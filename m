From: David Kastrup <dak@gnu.org>
Subject: Re: git gc --aggressive led to about 40 times slower "git log --raw"
Date: Wed, 19 Feb 2014 10:01:08 +0100
Message-ID: <87bny3qxwr.fsf@fencepost.gnu.org>
References: <CAEjYwfU==yYtQBDzZzEPdvbqz1N=gZtbMr5ccRaC_U7NfViQLA@mail.gmail.com>
	<87r470ssuc.fsf@fencepost.gnu.org>
	<CACsJy8D9tws_gu6yWVdz3t+Vfg5-9iorptn4BLnTL3b+YWcHzQ@mail.gmail.com>
	<87ioscsoow.fsf@fencepost.gnu.org> <20140218155842.GA7855@google.com>
	<xmqqzjlocf28.fsf@gitster.dls.corp.google.com>
	<CACsJy8AEXP45K+r3gGVTWbn4uuPLeHOkf-an20rj77QSfG1-ew@mail.gmail.com>
	<xmqq4n3warni.fsf@gitster.dls.corp.google.com>
	<CACsJy8C+wGd9WxnsML6-_G_S5GtN2pCPf09kcFtBVu-SDfP8YA@mail.gmail.com>
	<CAGK7Mr4wpwUK6UF6vTmgszX4sajPDvQazY2QagFfH9BEJx_9Ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Jaeger <chrjae@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Philippe Vaucher <philippe.vaucher@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 19 10:01:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WG31r-0001OE-0c
	for gcvg-git-2@plane.gmane.org; Wed, 19 Feb 2014 10:01:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752122AbaBSJBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Feb 2014 04:01:11 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:35559 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375AbaBSJBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Feb 2014 04:01:09 -0500
Received: from localhost ([127.0.0.1]:34600 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WG31g-0002WJ-Hh; Wed, 19 Feb 2014 04:01:08 -0500
Received: by lola (Postfix, from userid 1000)
	id 08141E0683; Wed, 19 Feb 2014 10:01:08 +0100 (CET)
In-Reply-To: <CAGK7Mr4wpwUK6UF6vTmgszX4sajPDvQazY2QagFfH9BEJx_9Ow@mail.gmail.com>
	(Philippe Vaucher's message of "Wed, 19 Feb 2014 09:38:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242384>

Philippe Vaucher <philippe.vaucher@gmail.com> writes:

>> fwiw this is the thread that added --depth=250
>>
>> http://thread.gmane.org/gmane.comp.gcc.devel/94565/focus=94626
>
> This post is quite interesting:
> http://article.gmane.org/gmane.comp.gcc.devel/94637

Yes.  Of course I am prejudiced because I volunteered fixing git-blame
on the Emacs developer list in order to make it more feasible to
transfer the Emacs repository to Git.

Calling git blame via C-x v g is a rather important part of the
workflow, and it's currently intolerable to work with on a number of
files.

While I'm fixing the basic shortcomings in builtin/blame.c itself, the
operation "fetch the objects" is necessary for all objects at least
once.  It's conceivable that some nice caching strategy would help with
avoiding the repeated traversal of long delta chain tails.  That could
also help defusing the operation of basic stuff like git-log.

But the short and long end of it is that there are valid operations
accessing a large amount of past history, and one point of having a
distributed version control system with non-shallow repository by
default is to have history and ways of working with it at one's hand.

And git's default modus of operation is _not_ to store things like
copies and moves and renames in commits, but deduce them from looking at
the stored data.  So making looking at stored data including old data
expensive means that Git does not work well in the way it is designed to
operate.

-- 
David Kastrup
