From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 1/3] cherry-pick: add support to copy notes
Date: Tue, 28 May 2013 20:01:11 +0200
Message-ID: <87mwrfx9ug.fsf@linux-k42r.v.cablecom.net>
References: <1369745947-19416-1-git-send-email-felipe.contreras@gmail.com>
	<1369745947-19416-2-git-send-email-felipe.contreras@gmail.com>
	<7vobbv119k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Christian Couder" <chriscool@tuxfamily.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 28 20:01:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhOD1-0001wS-KP
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 20:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759214Ab3E1SBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 14:01:15 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:23234 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759193Ab3E1SBO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 14:01:14 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 28 May
 2013 20:01:08 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 cas10.d.ethz.ch (172.31.38.210) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 28 May 2013 20:01:11 +0200
In-Reply-To: <7vobbv119k.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 28 May 2013 10:07:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225676>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast Cc'ed as he has been the primary force behind this line
> of "notes" usability.

Thanks for pointing this out to me.

> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>  builtin/revert.c  |   2 +
>>  sequencer.c       | 136 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
>>  sequencer.h       |   2 +
>>  t/t3500-cherry.sh |  32 +++++++++++++
>>  4 files changed, 169 insertions(+), 3 deletions(-)
>
> "git cherry-pick" should help maintaining notes just like amend and
> rebase, but how should this interact with notes.rewrite.<command>,
> where the command is capable of doing this without an explicit
> option once you tell which notes need to be maintained?

Since we already have the notes.rewrite.<command> convention, it would
seem the obvious choice to line it up with the others.  The main
bikeshedding opportunity is whether this should be an exception and
default to false (all other commands default it to true).

Also: how does this interact with notes.rewriteRef and the corresponding
env vars?  Why?

How does it interact with 'cherry-pick -n' if this is done in sequence,
effectively squashing several commits (this use-case is actually
suggested by the manpage), if multiple source commits had notes?  Should
it respect notes.rewriteMode (and by default concatenate)?  (I don't
know if the sequencer state is expressive enough already to carry this
in a meaningful way across cherry-pick commands.)

A commit message and some docs would be a nice idea, too.

> diff --git a/t/t3500-cherry.sh b/t/t3500-cherry.sh
> index f038f34..79c1219 100755
> --- a/t/t3500-cherry.sh
> +++ b/t/t3500-cherry.sh

This file starts out with

  test_description='git cherry should detect patches integrated upstream

  This test cherry-picks one local change of two into master branch, and
  checks that git cherry only returns the second patch in the local branch
  '

So either your tests should go to a different file or the description
becomes stale and needs to be updated.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
