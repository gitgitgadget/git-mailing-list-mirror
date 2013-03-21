From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC] Add posibility to preload stat information.
Date: Thu, 21 Mar 2013 11:41:48 +0100
Message-ID: <87vc8lyqz7.fsf@pctrast.inf.ethz.ch>
References: <1363781732-11396-1-git-send-email-iveqy@iveqy.com>
	<20130320164806.GA10752@sigill.intra.peff.net>
	<7vhak6f0w4.fsf@alter.siamese.dyndns.org>
	<20130320174759.GA29349@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Fredrik Gustafsson <iveqy@iveqy.com>, <spearce@spearce.org>,
	<git@vger.kernel.org>, <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 21 11:42:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIcwt-000565-Ut
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 11:42:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753895Ab3CUKlx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 06:41:53 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:2681 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753358Ab3CUKlw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 06:41:52 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 21 Mar
 2013 11:41:47 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.153.233) by
 CAS12.d.ethz.ch (172.31.38.212) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Thu, 21 Mar 2013 11:41:49 +0100
In-Reply-To: <20130320174759.GA29349@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 20 Mar 2013 13:47:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218706>

Jeff King <peff@peff.net> writes:

> On Wed, Mar 20, 2013 at 10:15:39AM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > So maybe just run "git status >/dev/null"?
>> 
>> In the background?  How often would it run?  I do not think a single
>> lockfile solves anything.  It may prevent simultaneous runs of two
>> such "prime the well" processes, but the same user may be working in
>> two separate repositories.
>
> Yes, in the background (he invokes __git_recursive_stat already in the
> background). I'd think you would want to run it whenever you enter a
> repository.
>
>> I do not see anything that prevents it from running in the same
>> repository over and over again, either.  "prompt" is a bad place to
>> do this kind of thing.
>
> Yeah, I did not look closely at that. The commit message claims "When
> entering a git working dir", but the implementation runs it on each
> prompt invocation, which is awful. I think you'd want to check to use
> rev-parse to see if you have changed into a new git repo, and only run
> it once then.

I think it would actually be a somewhat interesting feature if it
interacted with GIT_PS1_SHOW*.  If you use these settings (I personally
use SHOWDIRTYSTATE but not SHOWUNTRACKEDFILES), the prompt hangs while
__git_ps1 runs git-status.  It should be possible to run a git-status
process in the background when entering a repository, and displaying
some marker ('??' maybe) in the prompt instead of the dirty-state info
until git-status has finished.  That way the user doesn't have his shell
blocked by cding to a big repo.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
