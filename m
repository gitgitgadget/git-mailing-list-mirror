From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: WANTED: patch splitting tool - waypoints
Date: Sun, 02 May 2010 17:17:33 +0200
Message-ID: <vpqwrvmuycy.fsf@bauges.imag.fr>
References: <20100502115842.GA11607@brong.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bron Gondwana <brong@brong.net>
X-From: git-owner@vger.kernel.org Sun May 02 17:17:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8avW-0006Vu-MA
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 17:17:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757098Ab0EBPRp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 11:17:45 -0400
Received: from mx2.imag.fr ([129.88.30.17]:58475 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755777Ab0EBPRo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 11:17:44 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o42FBjKI027190
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 2 May 2010 17:11:45 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1O8avG-0005R3-55; Sun, 02 May 2010 17:17:34 +0200
In-Reply-To: <20100502115842.GA11607@brong.net> (Bron Gondwana's message of "Sun\, 2 May 2010 21\:58\:42 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 02 May 2010 17:11:45 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o42FBjKI027190
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1273417906.26772@RpLVz+OS/qYNJfJ8vLRYmA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146182>

Bron Gondwana <brong@brong.net> writes:

> Hi,
>
> My toolkit is missing a tool.  I've never seen it
> or anything like it, but I can describe it - and
> hopefully someone else knows if it exists.
>
> It's basically a combination of git rebase -i and
> git add -p.

I guess you named it: git add -p.

> So the journey A => B becomes the journey A => W => B.

Just checkout B, then

git reset HEAD^

This will reset your _index_ to the state of A (which happens to be
HEAD^, the ancestor of HEAD). Now, you can

while !happy; do
    git add -p   # select patch hunks
    git commit   # Create an intermediate commit
done
git commit -a    # Re-create commit B

> The tool allows you to quickly choose which hunks to
> add to patch(A=>W) and which to add to patch(W=>B),
> but also lets you make edits to the intermediate state
> easily so that W will compile even if some bits of the
> patch were intermingled.

Then, "git stash --keep-index" between "git add -p" and "git commit",
and "git stash pop" afterwards.

> And a graphical/
> ncurses interface

then, replace "git add -p; git commit" with "git gui", which will let
you select hunks and commit from a GUI.


Note that "rebase -i" is not strictly needed here, but you can apply
the above flow within a "edit" command of "rebase -i", so it's a nice
complement.

--
Matthieu Moy
http://www-verimag.imag.fr/~moy/
