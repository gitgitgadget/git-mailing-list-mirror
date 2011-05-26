From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] plug a DIR buffer leak in rerere.c
Date: Thu, 26 May 2011 15:55:50 +0200
Message-ID: <8762ox7ehl.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 15:56:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPb2h-0008Iu-3r
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 15:56:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757806Ab1EZNz6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 09:55:58 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:48412 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757774Ab1EZNz6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 09:55:58 -0400
Received: from mx.meyering.net (unknown [82.230.74.64])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 42C4F9400F3
	for <git@vger.kernel.org>; Thu, 26 May 2011 15:55:52 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 1C7E4601E2; Thu, 26 May 2011 15:55:51 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174509>


* rerere.c (rerere_gc): Don't leak a DIR buffer.
---
Spotted by coverity, and since I was already looking at this
particular file...
Like the preceding patch, this is relative to "next".

 rerere.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/rerere.c b/rerere.c
index cb8e5ba..dcb525a 100644
--- a/rerere.c
+++ b/rerere.c
@@ -745,6 +745,7 @@ void rerere_gc(struct string_list *rr)
 		if (then < now - cutoff * 86400)
 			string_list_append(&to_remove, e->d_name);
 	}
+	closedir(dir);
 	for (i = 0; i < to_remove.nr; i++)
 		unlink_rr_item(to_remove.items[i].string);
 	string_list_clear(&to_remove, 0);
--
1.7.5.2.660.g9f46c
