From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 25/37] merge-recursive: Update merge_content() call signature
Date: Mon, 20 Sep 2010 02:28:58 -0600
Message-ID: <1284971350-30590-26-git-send-email-newren@gmail.com>
References: <1284971350-30590-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 10:30:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxblJ-0006R4-2N
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 10:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755908Ab0ITI2Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 04:28:25 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:37157 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755897Ab0ITI2W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 04:28:22 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so1071833pvg.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 01:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=0Nyu6XfK24vjA83aZeSJAaM4Ai9Sn/PIZndKcbRW7bw=;
        b=LAGJUUVk5/V3IW1kkqtpONNr4sqljzEOFAD67mETk3PaRAPWCHQyFQhLOyat5pwQ/p
         QhX6QVTNxVQfp/meaZYD1m/CmUc19y26h15Dpg17I9hUa1CiiQQ2Y1yDEhJwWFrjuHBa
         CBrhKiFDa5g7gn6yG/CsWulcDhdyooxa9HhqA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AfIgAo9a1rxkxh4VvyovBWTfVlFhK4aeS6PJh19TRsoiO1mPR/7L/WJpK864dKXJAD
         ZE6Uh5xcgZ96Rw5NKYzpIKxTlmCj9Dyu41zFyaGmwhGOyo+xA5UMH+MbdfnZ4Nkg0gnP
         cMMMoM/wGiIySqkruSoDe4GQdDbP/8uxhtPFM=
Received: by 10.142.49.15 with SMTP id w15mr7361025wfw.220.1284971302653;
        Mon, 20 Sep 2010 01:28:22 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 9sm9288954wfd.0.2010.09.20.01.28.20
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 01:28:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.271.g16009
In-Reply-To: <1284971350-30590-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156573>

Enable calling merge_content() and providing more information about renames
and D/F conflicts (which we will want to do from process_df_entry()).

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 237d1ac..5f528c1 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1214,7 +1214,8 @@ static int merge_content(struct merge_options *o,
 			 const char *path,
 			 unsigned char *o_sha, int o_mode,
 			 unsigned char *a_sha, int a_mode,
-			 unsigned char *b_sha, int b_mode)
+			 unsigned char *b_sha, int b_mode,
+			 const char *df_rename_conflict_branch)
 {
 	const char *reason = "content";
 	struct merge_file_info mfi;
@@ -1322,7 +1323,8 @@ static int process_entry(struct merge_options *o,
 		/* Case C: Added in both (check for same permissions) and */
 		/* case D: Modified in both, but differently. */
 		clean_merge = merge_content(o, path,
-					    o_sha, o_mode, a_sha, a_mode, b_sha, b_mode);
+					    o_sha, o_mode, a_sha, a_mode, b_sha, b_mode,
+					    NULL);
 	} else if (!o_sha && !a_sha && !b_sha) {
 		/*
 		 * this entry was deleted altogether. a_mode == 0 means
-- 
1.7.3.271.g16009
