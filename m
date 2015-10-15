From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Falis on commit --amend when already pushed
Date: Thu, 15 Oct 2015 08:44:36 +0200
Message-ID: <vpqr3kw636z.fsf@grenoble-inp.fr>
References: <CACbztPOSZBaqLLUERS_yfvAEPmxS2PZs0fYTy7E_9HfLi9UGmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Tomohiro Koana <kntmhr.1221@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 15 08:44:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmcHP-0005UF-GH
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 08:44:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753613AbbJOGon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 02:44:43 -0400
Received: from mx2.imag.fr ([129.88.30.17]:43261 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753384AbbJOGom (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 02:44:42 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t9F6iaGT013222
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 15 Oct 2015 08:44:36 +0200
Received: from anie (ensi-vpn-233.imag.fr [129.88.57.233])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t9F6iavb008031;
	Thu, 15 Oct 2015 08:44:36 +0200
In-Reply-To: <CACbztPOSZBaqLLUERS_yfvAEPmxS2PZs0fYTy7E_9HfLi9UGmA@mail.gmail.com>
	(Tomohiro Koana's message of "Thu, 15 Oct 2015 13:09:15 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 15 Oct 2015 08:44:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t9F6iaGT013222
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1445496279.71563@cEe8DIIZAhxIW4kOMyPpQg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279645>

Tomohiro Koana <kntmhr.1221@gmail.com> writes:

> Hello all,
>
> I'm a third year student at the University of Tokyo and, in our
> "Diving into open-source software" class, my friends and I decided to
> work with git. Our final, hopefully, is contributing to git.

Welcome on board :-). I give the same class to my students (in Ensimag,
Grenoble, France). You can have a look at
https://git.wiki.kernel.org/index.php/SmallProjectsIdeas for a list of
ideas of things you can do.

The first contact with an open-source community is usually hard (the
quality expectation is much higher that your usual lab works), but you
are going to learn a lot!

> One improvement that we thought of was not letting users to amend
> commit when the commit is already pushed to the remote server.

This is a good introduction, but not a good commit message. The commit
message is not about what you "thought", but about what the commit is
doing, and more importantly _why_ it is doing that and doing it this
way. See it as an argument like "You should accept this patch
because ...." (even if you won't actually write it like this). Read some
existing messages ("git log --no-merges") to see what I mean.

Please, read Documentation/SubmittingPatches and
Documentation/CodingGuidelines in Git's source tree.

> --- a/builtin/commit.c
>
> +++ b/builtin/commit.c
>
> @@ -32,6 +32,7 @@
>
>  #include "sequencer.h"
>
>  #include "notes-utils.h"
>
>  #include "mailmap.h"
>
> +#include "remote.h"

The patch is whitespace-damaged (there are extra blank lines). Use
either "git send-email" or http://submitgit.herokuapp.com/ to submit
your patches.

> + stat_tracking_info(branch, &ours, &theirs, &full_base);
>
> + if (amend && ours == 0) {
>
> + die(_("This commit is already pushed to the remote -- cannot amend."));
>
> + }

I don't know the API well enough so I can't say whether this correctly
detects already pushed branch, but this looks suspiciously simple. Are
you not just detecting the presence of a remote-tracking branch? What
you should do is to detect whether the remote-tracking branch contains
the current commit.

Also, this is clearly not acceptable in its current form: there are many
valid use-cases to amend an already-pushed commit, so you can't break
the flow of people using this. It must 1) be configurable, and 2) unless
you have a really good reason, backward-compatible by default.

Also, it lacks tests.

Actually, the idea you have is far, far more difficult than what you
probably thought.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
