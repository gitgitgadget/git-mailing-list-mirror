From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] branch.autosetupmerge: allow boolean values, or "all"
Date: Sun, 08 Jul 2007 11:41:42 -0700
Message-ID: <7vzm2620wp.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707062252390.4093@racer.site>
	<7vhcof2rur.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707081336020.4248@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Paolo Bonzini <bonzini@gnu.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 08 20:41:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7bhc-0001Gs-OQ
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 20:41:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757883AbXGHSlq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 14:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757862AbXGHSlp
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 14:41:45 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:46316 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757280AbXGHSlo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 14:41:44 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070708184144.BUWE3098.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sun, 8 Jul 2007 14:41:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id M6hi1X00A1kojtg0000000; Sun, 08 Jul 2007 14:41:43 -0400
In-Reply-To: <Pine.LNX.4.64.0707081336020.4248@racer.site> (Johannes
	Schindelin's message of "Sun, 8 Jul 2007 13:41:21 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51904>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> 	> Eh?  I did not want this to get applied for my local branches.
>
> 	That is certainly unexpected and unwelcomed.  Alas, I think it is 
> 	one of the consequences of rarely executed (and thus, tested) 
> 	code.
> ...
> +test_expect_success 'autosetupmerge = all' '
> +	git config branch.autosetupmerge true &&
> +	git branch all1 master &&
> +	test -z "$(git config branch.all1.merge)" &&
> +	git config branch.autosetupmerge all &&
> +	git branch all2 master &&
> +	test $(git config branch.all2.merge) = refs/heads/master
> +'

Thanks.

Having prepared the patch below, I do not think if the original
patch even wanted to have 'all' semantics.  The surrounding text
only talks about "off a remote branch" and I strongly suspect
that nobody wanted to do this for a local branch case at all.



diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4b67f0a..aeece84 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -309,7 +309,10 @@ branch.autosetupmerge::
 	so that gitlink:git-pull[1] will appropriately merge from that
 	remote branch.  Note that even if this option is not set,
 	this behavior can be chosen per-branch using the `--track`
-	and `--no-track` options.  This option defaults to false.
+	and `--no-track` options.  This option can have values
+	'false' (never touch the configuration), 'all' (do this
+	for all branches), or 'true' (do this only when
+	branching from a remote tracking branch), and defaults to 'true'.
 
 branch.<name>.remote::
 	When in branch <name>, it tells `git fetch` which remote to fetch.
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 818b720..8292952 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -52,8 +52,9 @@ OPTIONS
 	set up configuration so that git-pull will automatically
 	retrieve data from the remote branch.  Set the
 	branch.autosetupmerge configuration variable to true if you
-	want git-checkout and git-branch to always behave as if
-	'--track' were given.
+	want git-checkout and git-branch to behave as if
+	'--track' were given when you branch from a remote
+	tracking branch.
 
 --no-track::
 	When -b is given and a branch is created off a remote branch,
