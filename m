Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E524C2D0A3
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0632B2071A
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0QQbyA2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbgKBUoO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 15:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbgKBUoN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 15:44:13 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC801C0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 12:44:11 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id w145so10383710oie.9
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 12:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/91y2IShTUxlFRJSwGZM1L55xZd3TS9RORFe+3DBDT0=;
        b=b0QQbyA2zJxFjY/TH5rwh6wMzOQZ6/qlwvSrogWAw01vogrIY7jNp8PZ4BuswtQWLG
         TWtK1b71gDuv6kdmnPx7PtiNxqj1cLTeFEsF8OIxEeGltHD/lYmxaAzHl3Z73n7XO3xY
         rJ2fHN7Ly4hviuuOfYUTpY0YMsFGE0sdn+oGSfOFGLVJdypCbPhENnoz3VUnapB0sWd7
         FUCQFxUkS7KFZjuCtX219AgZsil8MS+g8LyY3AlpEzTG9okzh9ZK+XrsPY5dSxS78LJy
         qwsTbeBVB5DO4WbIhpGQwy02WBdpizC+EGB3z3LxpG9UD5JIFYkc+zNLvBkw92BlQEjd
         wf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/91y2IShTUxlFRJSwGZM1L55xZd3TS9RORFe+3DBDT0=;
        b=i2vZNMUaKuO3y9nescHFUo+Kgpj4zL55PgzYYMenxKhLD7W898KVWOpgTLG0gGyn11
         Cad/3/HFbynE8bJXNg2UcmrkJqm9P5RX++2x+TbcKBj1K2k13pvUtn7b55Y9bEjPIZ+P
         zrzU6Xx0cxXPuGLrAXxXsogYJRpt6RFMGiXa5Hv3vA49+5Odp/khPQL5kqR+eokMHACm
         qqRaUAD3idHnJLwsmwf0zUKVYh1CIgmdJ8UdpyGCNXx3W2BZyabtkrlndFbd23ZLtqWh
         49A0nOTF98uGTTx0EezBv2W7lH8SDkqEoIH0V1SwBS9WE55jlJkBZSXWHT9n0CL5CWHp
         /4fg==
X-Gm-Message-State: AOAM533Gqu+oCxteDYlRdgu+POCiafNiCs0aRqzs8LEbzWMJeIQw5Ega
        oxyC6ycSog2WcB8R5tPqQZ2PBzlI1p6M/g==
X-Google-Smtp-Source: ABdhPJxSj51rA2hHhSSnVu+uCQlnEz9++Tchtxgq0slpe3mXbIk72LjrvXyRxP7v7RmR+7MsTx5aag==
X-Received: by 2002:aca:ddc2:: with SMTP id u185mr11574795oig.81.1604349850964;
        Mon, 02 Nov 2020 12:44:10 -0800 (PST)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id t27sm3848512otc.14.2020.11.02.12.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 12:44:10 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 16/20] merge-ort: basic outline for merge_switch_to_result()
Date:   Mon,  2 Nov 2020 12:43:40 -0800
Message-Id: <20201102204344.342633-17-newren@gmail.com>
X-Mailer: git-send-email 2.29.0.471.ga4f56089c0
In-Reply-To: <20201102204344.342633-1-newren@gmail.com>
References: <20201102204344.342633-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds a basic implementation for merge_switch_to_result(), though
just in terms of a few new empty functions that will be defined in
subsequent commits.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 20b7c0d8b0..2a60d84f1d 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -658,13 +658,53 @@ static void process_entries(struct merge_options *opt,
 	string_list_clear(&dir_metadata.offsets, 0);
 }
 
+static int checkout(struct merge_options *opt,
+		    struct tree *prev,
+		    struct tree *next)
+{
+	die("Not yet implemented.");
+}
+
+static int record_unmerged_index_entries(struct merge_options *opt,
+					 struct index_state *index,
+					 struct strmap *paths,
+					 struct strmap *unmerged)
+{
+	if (strmap_empty(unmerged))
+		return 0;
+
+	die("Not yet implemented.");
+}
+
 void merge_switch_to_result(struct merge_options *opt,
 			    struct tree *head,
 			    struct merge_result *result,
 			    int update_worktree_and_index,
 			    int display_update_msgs)
 {
-	die("Not yet implemented");
+	assert(opt->priv == NULL);
+	if (result->clean >= 0 && update_worktree_and_index) {
+		struct merge_options_internal *opti = result->priv;
+
+		if (checkout(opt, head, result->tree)) {
+			/* failure to function */
+			result->clean = -1;
+			return;
+		}
+
+		if (record_unmerged_index_entries(opt, opt->repo->index,
+						  &opti->paths,
+						  &opti->unmerged)) {
+			/* failure to function */
+			result->clean = -1;
+			return;
+		}
+	}
+
+	if (display_update_msgs) {
+		/* TODO: print out CONFLICT and other informational messages. */
+	}
+
 	merge_finalize(opt, result);
 }
 
-- 
2.29.0.471.ga4f56089c0

