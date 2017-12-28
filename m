Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 427391F404
	for <e@80x24.org>; Thu, 28 Dec 2017 04:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753377AbdL1EPE (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 23:15:04 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:33867 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753284AbdL1EOW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 23:14:22 -0500
Received: by mail-io0-f194.google.com with SMTP id q188so12900897iod.1
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 20:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Djqyxf2A1aSJtzjibVwRt+TYs/xmmN3CUvh8RJq8HZQ=;
        b=vgy4BQD5YUzbb4GOU9lWk92S9VEMx6UjTxM56cPyv4QQJyU+fSX5Qp49/Sw0Jm71eN
         E5G6AHfH0bRyyotbx9iwl4ZGDXc3KfocNU0t4SaHeNfdet4QMvMosPgthBPaF8OoOk4d
         7OMCI/FBlbb7SvkuAfeZrERBNQUd829qVMDlGnLzH/0svZj+O9nA55zqvfDrrtBTNlE9
         /TCJTXHWpW7iIa3nFsdNmIVA2wS4LkgP1w9J+gwmBpu3i4Ikkrwudtd0NS+j+K+IM6uw
         swMLo2Z65+mQLY6a/ytwCImw2sXzLQmi3Nrgl29UGVGyZ0rEEQ/MbdLH7lmp1xRWHmg1
         36Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Djqyxf2A1aSJtzjibVwRt+TYs/xmmN3CUvh8RJq8HZQ=;
        b=KVcvqytJ4OB2fgixcj6RFNxmf+hBZgVWZKtUp7686w/CVLoqINH//5NoNTvaIIcYa3
         NwXufCRGkSiqw9dKD1FkPfRC2lUM8wLfl7DOqDf/IBsd3Zap5mQ6KVatu2iwaMIJU9HD
         vWSMtif1JOhJwPzolqCcM4cq/xv4WRBmSCnP/1CQw3kjhsxHlnftk/RJp4SH/KqjqXA2
         jVe/In8dhpUqpaOp4wAQuOnAn+67F3PJ6Rcpsnb00f4zXvyvfAAZi2bgFaAajevnhHDU
         +VGi0OsNnI2uWc4RgDcbjjf9aUFX7f9yYhY8MMqDSo7nw+sp4qhWM74aqRX7JcTW9sbs
         QDzA==
X-Gm-Message-State: AKGB3mKeEmjM9cskELx1M94EymMRMvkYtnlG/eZ7IRoR3ewHqSVp1VWO
        K4GmV9hqGc8DrnwcZpLDzWPduA==
X-Google-Smtp-Source: ACJfBouGPS6faharcU9juMqOxks4hxMZ40fHoIL0RcztDWnHdeHPhGcrwY71nfVBNgBeLoFrMXufmQ==
X-Received: by 10.107.18.147 with SMTP id 19mr38718988ios.197.1514434461920;
        Wed, 27 Dec 2017 20:14:21 -0800 (PST)
Received: from localhost.localdomain (170-72-6-219.ut.vivintwireless.net. [170.72.6.219])
        by smtp.gmail.com with ESMTPSA id f207sm11201841ita.26.2017.12.27.20.14.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 20:14:21 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 21/34] merge-recursive: make a helper function for cleanup for handle_renames
Date:   Wed, 27 Dec 2017 20:13:39 -0800
Message-Id: <20171228041352.27880-22-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.408.g8e199d483
In-Reply-To: <20171228041352.27880-1-newren@gmail.com>
References: <20171228041352.27880-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In anticipation of more involved cleanup to come, make a helper function
for doing the cleanup at the end of handle_renames.  Rename the already
existing cleanup_rename[s]() to final_cleanup_rename[s](), name the new
helper initial_cleanup_rename(), and leave the big comment in the code
about why we can't do all the cleanup at once.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 0cb27c66e..c5932d5c5 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1695,6 +1695,12 @@ struct rename_info {
 	struct string_list *merge_renames;
 };
 
+static void initial_cleanup_rename(struct diff_queue_struct *pairs)
+{
+	free(pairs->queue);
+	free(pairs);
+}
+
 static int handle_renames(struct merge_options *o,
 			  struct tree *common,
 			  struct tree *head,
@@ -1725,16 +1731,13 @@ static int handle_renames(struct merge_options *o,
 	 * data structures are still needed and referenced in
 	 * process_entry().  But there are a few things we can free now.
 	 */
-
-	free(head_pairs->queue);
-	free(head_pairs);
-	free(merge_pairs->queue);
-	free(merge_pairs);
+	initial_cleanup_rename(head_pairs);
+	initial_cleanup_rename(merge_pairs);
 
 	return clean;
 }
 
-static void cleanup_rename(struct string_list *rename)
+static void final_cleanup_rename(struct string_list *rename)
 {
 	const struct rename *re;
 	int i;
@@ -1750,10 +1753,10 @@ static void cleanup_rename(struct string_list *rename)
 	free(rename);
 }
 
-static void cleanup_renames(struct rename_info *re_info)
+static void final_cleanup_renames(struct rename_info *re_info)
 {
-	cleanup_rename(re_info->head_renames);
-	cleanup_rename(re_info->merge_renames);
+	final_cleanup_rename(re_info->head_renames);
+	final_cleanup_rename(re_info->merge_renames);
 }
 
 static struct object_id *stage_oid(const struct object_id *oid, unsigned mode)
@@ -2149,7 +2152,7 @@ int merge_trees(struct merge_options *o,
 		}
 
 cleanup:
-		cleanup_renames(&re_info);
+		final_cleanup_renames(&re_info);
 
 		string_list_clear(entries, 1);
 		free(entries);
-- 
2.15.0.408.g8e199d483

