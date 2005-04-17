From: Brad Roberts <braddr@puremagic.com>
Subject: [patch] fix for memory leak in write-tree.c
Date: Sun, 17 Apr 2005 04:21:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.44.0504170418390.2625-100000@bellevue.puremagic.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Apr 17 13:18:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DN7nF-0002ue-4c
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 13:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVDQLWC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 07:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVDQLWC
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 07:22:02 -0400
Received: from bellevue.puremagic.com ([209.189.198.108]:11498 "EHLO
	bellevue.puremagic.com") by vger.kernel.org with ESMTP
	id S261300AbVDQLV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 07:21:59 -0400
Received: from bellevue.puremagic.com (localhost [127.0.0.1])
	by bellevue.puremagic.com (8.13.3/8.13.3/Debian-6) with ESMTP id j3HBLu04002398
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Sun, 17 Apr 2005 04:21:57 -0700
Received: from localhost (braddr@localhost)
	by bellevue.puremagic.com (8.13.3/8.13.3/Submit) with ESMTP id j3HBLuRe002394
	for <git@vger.kernel.org>; Sun, 17 Apr 2005 04:21:56 -0700
X-Authentication-Warning: bellevue.puremagic.com: braddr owned process doing -bs
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I've made my tree rsync'able:

rsync://gameboy2.puremagic.com/git


commit 1cdbc0a19b8d9b68f1f42735e2f14f1289823a63
tree 0e060fed0642337e675368913ec8d4f910a9f019
parent 11ed64c1b141c9ba397a1ca76aef2cd250976007
author Brad Roberts,,, <braddr@gameboy2> 1113736632 -0700
committer Brad Roberts,,, <braddr@gameboy2> 1113736632 -0700

Fix a memory leak in write-tree.c, not freeing the directory buffer.

Index: write-tree.c
===================================================================
--- 51b1bddbbc05e50d5bbf1f9662e503c2e85d5e96/write-tree.c  (mode:100644 sha1:34a351b20fb38ea588f34bd9634f101b9dc533cb)
+++ 0e060fed0642337e675368913ec8d4f910a9f019/write-tree.c  (mode:100644 sha1:fb046aa6ce6b9fce6a523a1e36ff43adab9bdd93)
@@ -93,10 +93,8 @@
        i -= 5;
        memcpy(buffer+i, "tree ", 5);

-       buffer += i;
-       offset -= i;
-
-       write_sha1_file(buffer, offset, returnsha1);
+       write_sha1_file(buffer + i, offset - i, returnsha1);
+       free(buffer);
        return nr;
 }



