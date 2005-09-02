From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PROBLEM] Checkout from cloned repository does not work
Date: Fri, 02 Sep 2005 11:13:36 -0700
Message-ID: <7vpsrrgwxb.fsf@assigned-by-dhcp.cox.net>
References: <84144f0205090204201f74e425@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 02 20:15:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EBG2n-0007RT-2U
	for gcvg-git@gmane.org; Fri, 02 Sep 2005 20:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbVIBSNi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Sep 2005 14:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbVIBSNi
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Sep 2005 14:13:38 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:21718 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750772AbVIBSNi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Sep 2005 14:13:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050902181337.VZSJ3588.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 2 Sep 2005 14:13:37 -0400
To: Pekka Enberg <penberg@cs.helsinki.fi>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8026>

Pekka Enberg <penberg@cs.helsinki.fi> writes:

> I cannot checkout from a cloned git repository I have created. I am
> using git 0.99.5 from Gentoo portage.

> Following the tutorial, I create new git repository:
>...
> Now on the server, I create a repository:
>
>   $ mkdir git-test.git
>   GIT_DIR=git-test.git/ git-init-db

You would need 'chmod +x git-test.git/hooks/post-update' here if
you are allowing people to pull over http from this repository.

I just realized that where this was documented was quite obscure
in the tutorial.  I'll update it with the appended patch.

> After which I clone the newly created repository like this:
>
>   $ git clone http://www.remote.server/~penberg/git-test.git cloned
>   defaulting to local storage area
>   Somebody should define smarter http server protocol
>
> Now, the problem is that checkout does not work:

The problem is that 'git clone' does not support cloning over
http from servers that are not properly prepared.  This 'git
clone' exited with non-zero status with an error message, didn't
it?

-->8-- -->8-- -->8--
Mention post-update when we first talk about publishing a repository.

There is more detailed instruction for `project lead` later in
the tutorial to talk about the same, but at this point in the
flow of tutorial, the first time reader has no way of knowing it.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -1103,6 +1103,12 @@ your login shell is `bash`, only `.bashr
 `.bash_profile`. As a workaround, make sure `.bashrc` sets up
 `$PATH` so that you can run `git-receive-pack` program.
 
+[NOTE]
+If you plan to publish this repository to be accessed over http,
+you should do `chmod +x my-git.git/hooks/post-update` at this
+point.  This makes sure that every time you push into this
+repository, `git-update-server-info` is run.
+
 Your "public repository" is now ready to accept your changes.
 Come back to the machine you have your private repository. From
 there, run this command:
