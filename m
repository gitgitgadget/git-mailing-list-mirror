From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] show changed tree objects with recursive git-diff-tree
Date: Fri, 20 May 2005 19:11:24 -0700
Message-ID: <7vsm0hpbub.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.62.0505202131520.4397@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 04:11:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZJRc-000886-Pd
	for gcvg-git@gmane.org; Sat, 21 May 2005 04:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVEUCL2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 22:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbVEUCL2
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 22:11:28 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:40127 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261186AbVEUCL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2005 22:11:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050521021125.YOOT12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 20 May 2005 22:11:25 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.62.0505202131520.4397@localhost.localdomain> (Nicolas
 Pitre's message of "Fri, 20 May 2005 21:40:41 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Although I do not have immediate objections to what it tries to
do, I have to think about the intent of the patch and its
ramifications.

However, I think the patch operates at the wrong level if you
are basing on the tip of Linus tree.  With the new diff core,
you do not filter like this:

-		char *newbase = malloc_base(base, path1, pathlen1);
+		char *newbase;
+		if (!silent && !generate_patch)
+			diff_change(mode1, mode2, sha1, sha2, base, path1);
+		newbase = malloc_base(base, path1, pathlen1);

I'd just say "if (!silent)" there.  The updated diff_change
_should_ do the right thing regardless of generate_patch value
you have there, because it is already told about it with
diff_setup(), and it knows not to say silly things when we are
generating patch.


