Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 007011F428
	for <e@80x24.org>; Fri,  5 Jan 2018 20:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752800AbeAEU2u (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:28:50 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:43329 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752787AbeAEU2o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:28:44 -0500
Received: by mail-it0-f65.google.com with SMTP id u62so2885009ita.2
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 12:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B3g+g64TqSsh4IhW2tdX9SGe0QENaqwdloNhgovP0eY=;
        b=pVsTxHfhC0j2j/Aq7FDe/ejgvq9qRvFmZygoqeQ17HxSYilQ5sH013C5siVWFpYVCG
         sRha7jkRpUTuWxIDefN1xNITiQEINxfcW9aSc0voOXoVFo4IGfquJ1m+KSL1ofwbQVlv
         5jQo1NOM6ZQslW9Ss6IHoGDMX1iuqtsnIbmiF1WMcpCmB02DgQBgpV6UzQu1+R7wfpns
         cIoMoABesEqpPmcd12AqoHx5rONepna5B189342X/xm0y97D0isM9rwk1YMVg4Rz74Mv
         JzvALPW5nvfhKll0Pe9/4364Ow9pqRvKtPr/LyhktQ28kQgseiMqBIOFy49rW5hsyVq9
         91oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B3g+g64TqSsh4IhW2tdX9SGe0QENaqwdloNhgovP0eY=;
        b=IS9QOdIF1vFezlo14lk8ZnMtj7ZYcT7/lSmP6HFVXgSkn9J6oS0Jfh7wimWhgRkY+r
         vLf7DOt/aEzujjkBp4xeZ1B8UH3hhtavf6hj1p9NKlLihw+sPVKTrmoOWxpuwyV5XxgA
         grN1cjEILHPQvpMqyBqkO9H9nSR38libL4/p/UaDwi++cGxOBrJ0fLkkKLOX1d2W48Dn
         svn1Md0V3ymt47Z7BjAQ78wC7VFGPMpM6b7h6aRfqYPvxgx8yrJ+J2bDo3H1SxtjLF7h
         IhIszHVFDEKD0TKSkWCP8b9q2V2yYMexpquBqWzyvn2jJPsa4b3NZlYdn8XTXjtWPTCR
         L0Jg==
X-Gm-Message-State: AKGB3mIOPAK29jm6dRRnSJMwPCZ7W6KWQMeNw7+aX6aa+ofk8tsDNk3o
        QhxGXUVSW+ZbfauDcpugXYqHCd/9
X-Google-Smtp-Source: ACJfBoujcBjwafAFyfZqSD0YrUYy5qYHtNL7adROPHjyAe2GzQdRJnH4DmvpBJvTDBIIn1RPlAOhvg==
X-Received: by 10.36.78.140 with SMTP id r134mr4021597ita.27.1515184123078;
        Fri, 05 Jan 2018 12:28:43 -0800 (PST)
Received: from localhost.localdomain (c-73-20-122-173.hsd1.ut.comcast.net. [73.20.122.173])
        by smtp.gmail.com with ESMTPSA id 6sm3739659iow.55.2018.01.05.12.28.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jan 2018 12:28:42 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, szeder.dev@gmail.com, j6t@kdbg.org,
        jrnieder@gmail.com, peff@peff.net, git@matthieu-moy.fr,
        Elijah Newren <newren@gmail.com>
Subject: [PATCHv6 18/31] merge-recursive: make a helper function for cleanup for handle_renames
Date:   Fri,  5 Jan 2018 12:26:58 -0800
Message-Id: <20180105202711.24311-19-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.409.g72e1e5805
In-Reply-To: <20180105202711.24311-1-newren@gmail.com>
References: <20180105202711.24311-1-newren@gmail.com>
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
2.14.2

