From: Junio C Hamano <junkio@cox.net>
Subject: Re: Handling merge conflicts a bit more gracefully..
Date: Wed, 08 Jun 2005 17:11:21 -0700
Message-ID: <7voeag1j9y.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0506081336080.2286@ppc970.osdl.org>
	<7vis0o30sc.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506081629370.2286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 02:27:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgAtl-0002Ef-AR
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 02:27:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262197AbVFIAaW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 20:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbVFIA1v
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 20:27:51 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:31889 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S262247AbVFIAL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2005 20:11:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050609001120.OGMD20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 8 Jun 2005 20:11:20 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506081629370.2286@ppc970.osdl.org> (Linus
 Torvalds's message of "Wed, 8 Jun 2005 16:35:48 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

While I have your attention, I have been thinking about a
problem at lower level than what is being discussed.

Consider the following two command sequences:

     (1) git-read-tree -m $H $M	&& git-write-tree

     (2) I=`git-write-tree` &&
         git-read-tree -m $H $I $M &&
         git-merge-cache -o git-merge-one-file-script -a &&
         git-write-tree

I think they should be equivalent in that:

   - when (1) refuses to run, (2) should either cause
     git-read-tree to refuse, or at least should result in an
     unmerged cache and git-write-tree phase should fail;

   - when (1) succeeds, (2) should also succeed, and the
     resulting tree from both should be the same.


