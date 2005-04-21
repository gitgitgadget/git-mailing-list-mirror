From: Junio C Hamano <junkio@cox.net>
Subject: Re: (rework) [PATCH 3/4] Accept commit in some places when tree is
 needed.
Date: Wed, 20 Apr 2005 19:32:59 -0700
Message-ID: <7v7jiwhnac.fsf@assigned-by-dhcp.cox.net>
References: <7vvf6hgeqj.fsf@assigned-by-dhcp.cox.net>
	<7vk6mxgds8.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504201807320.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 04:30:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DORRR-00072V-Gx
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 04:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVDUCd1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 22:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbVDUCd1
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 22:33:27 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:18824 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261192AbVDUCdE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 22:33:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050421023258.JGL2123.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 20 Apr 2005 22:32:58 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504201807320.2344@ppc970.osdl.org> (Linus
 Torvalds's message of "Wed, 20 Apr 2005 18:09:05 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> On Wed, 20 Apr 2005, Junio C Hamano wrote:
>> 
>> Sorry, but the numbering is wrong this should have been [4/5]
>> not [3/4].  The contents should be fine, though.

LT> Applied and pushed out.

Thanks.  I have alreay a bugfix and a half X-<.

----------------------------------------------------------------
[PATCH] Fix read-tree-with-tree-or-commit-sha1 function.

Instead of NULL to signal an error, it was returning a garbage.
Also the compiler complains about a type mismatch between signed
and unsigned character array.  Both are my bad.  Sorry.

Signed-off-by: Junio C Hamano <junkio@cox.net> 
---

--- l/sha1_file.c	2005-04-20 19:00:38.000000000 -0700
+++ k/sha1_file.c	2005-04-20 18:14:34.000000000 -0700
@@ -174,7 +174,7 @@
 	void *buffer;
 	unsigned long isize;
 	int was_commit = 0;
-	char tree_sha1[20];
+	unsigned char tree_sha1[20];
 
 	buffer = read_sha1_file(sha1, type, &isize);
 
@@ -197,7 +197,7 @@
 	 */
 	if (!buffer || strcmp(type, "tree")) {
 		free(buffer);
-		return;
+		return NULL;
 	}
 
 	*size = isize;


