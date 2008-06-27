From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: is rebase the same as merging every commit?
Date: Fri, 27 Jun 2008 09:34:15 +0200
Message-ID: <vpqd4m349hk.fsf@bauges.imag.fr>
References: <7vvdzvn0ql.fsf@gitster.siamese.dyndns.org>
	<willow-jeske-01l79c1jFEDjCWw6-01l7@0yvFEDjCjEl>
	<willow-jeske-01l7GhRWFEDjChtB>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "David Jeske" <jeske@willowmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 09:37:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KC8Vu-0002Mc-CW
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 09:36:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753876AbYF0Hfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 03:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753398AbYF0Hfl
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 03:35:41 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:44113 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752001AbYF0Hfl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 03:35:41 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m5R7YGdu005810;
	Fri, 27 Jun 2008 09:34:16 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KC8TI-0000A4-2U; Fri, 27 Jun 2008 09:34:16 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KC8TI-0004lN-03; Fri, 27 Jun 2008 09:34:16 +0200
In-Reply-To: <willow-jeske-01l7GhRWFEDjChtB> (David Jeske's message of "Fri\, 27 Jun 2008 06\:24\:23 -0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Fri, 27 Jun 2008 09:34:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86530>

"David Jeske" <jeske@willowmail.com> writes:

> However, when considering an SCM perspective, I don't understand why I have to
> make a tradeoff between personal reproducibility (which I get from the original
> changes), and upstream readability (which the community gets from my rebase).

Well, look at the [PATCH] messages on this list, and how they evolve.
Patch series give a clean way to go from a point to another. That's
what you want to see in upstream history.

Then, patch series usually get reviewed, and the patches themselves
are modified. There's a kind of meta-history: the changes you make to
your own changes.

Suppose I send a patch containing

+	int * x = malloc(sizeof(char));

and someone notices how wrong it is. I send another patch with

+	int * x = malloc(sizeof(int));

The first version was basicaly a mistake, and if it hasn't been
released, no one want to bother with it longer that the time to resend
the patch. No one want to be hit by the bug while using bisect later
on the upstream repository. And no one wants to see both patches when
reviewing or "git blame"-ing.

Things you rebase in Git are just like things for which you don't make
intermediate commits in SVN.

>>From all I've read about rebase, bisect, and the big tree management, it seems
> like the three steps are Reorder, combine, rebase.  (In a more complicated
> situation, i'd want to split a commit into pieces)
>
> (1'')
> 0' - feature A
> 1' - bugfix a
> 2' - bugfix a2
> (2'')
> 3' - feature b
> 4' - bugfix b
> (3'')
> 5' - feature c (split)
> (4'')
> 6' - feature d (split)
>
> Frankly, I'm super impressed, because I can imagine how I might do
> this in git.

git rebase -i will help you to do that painlessly.

> I want to mess around and try this stuff out, but I'm scared of doing bad
> things to the tree and them being unrecoverable

They won't. The reflog is still there. Try it, an cancel it if you
don't like.

The huge difference between the reflog and the history is that the
reflog is local, it's your own mess, other people won't get disturbed
by how messy it can be.

> (other than the fact that the current dag
> link propagation model would force others to get these changes if
> they remained connected together. Something easily remidied by out
> of band metadata, or different link types)

No. One fundamental principle of Git is that objects are immutable. If
your objects have a link, of whatever kind, then the same object moved
in another repository have the same link.

But what's wrong with the reflog?

-- 
Matthieu
