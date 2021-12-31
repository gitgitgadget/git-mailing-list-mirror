Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD71FC433EF
	for <git@archiver.kernel.org>; Fri, 31 Dec 2021 05:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhLaFE2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Dec 2021 00:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbhLaFEL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Dec 2021 00:04:11 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B17CC06173E
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 21:04:11 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id d198-20020a1c1dcf000000b0034569cdd2a2so14272519wmd.5
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 21:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Tzc+2c9N2IQg0gI3MvnS5R42x8QisN9cgLet1CbeQ/0=;
        b=INCXnZQTYOrExTI7VWAPYXi8HZyT5fmcPUMc4p8ZTgWeABrZsX3RZ7Bd/RMg4ZSgPh
         YTevmUv9/s4e1g+jNBKjLwiKCTEi21LLkdMNi49zTs1J4RyO9c+Y2RwSLUiiqfyn+zh8
         Q3+GatBAEANTmaAPZbmbm9QEzd3FAZQozgoTk7De/GWO3w5Qrfg+DWkLiWoUWCuudqsO
         7lFma5Tz1wpWRdVJ2gSSz9L2NhfHMeSieb/Q1qgSIOW0lHnGe7WZmcObhRjZK7uVBnb0
         S3QUK7VusAve4jKQZRXb3Fi8caug/ZwujbzUsENUtba4pRUwp781mOfSe+P+5SAKrFed
         hr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Tzc+2c9N2IQg0gI3MvnS5R42x8QisN9cgLet1CbeQ/0=;
        b=K5hOUhKqC8XBxroZfgSvnq2+vemuZ5vGZeJz+pM32hq5+3yM/WWRfLwMkWJOz+36sZ
         /L8TIxsYcYJhG+6g5CL61uYwEgWWKSlDwhi9LFn2I+ywQtX437qXwgKSXG3/Ix6JZXbR
         Ix+kBAp4tR0Kpc5w9iZIfj3HK8x3oyydHFHG5ESKUtIj2AVE0/umCwY2u8ylb4PS+yB6
         dTu2EGC3Y7mZHNkqg+UVx3KHgTJ/5hutYy3hQIwVW/m+Pe5cGOLqb6YLB3ntKS/+Ex/e
         kZFiRHE0uqx9NFvXVE1zpmBCyZ3hy0KfRoWCfY7mSE4PmfP4GMkfmEbtOUVPdKgL8KqG
         aF8Q==
X-Gm-Message-State: AOAM531c2T9NaRKir0BszqJTx/Zxmc2qJc245d5SuFQV36pLIPz3iJVl
        czFGekqLGdiGCmwaui3EeZ9eCrH+aK0=
X-Google-Smtp-Source: ABdhPJxQiwhgSsemO4tczrmfJOkTCwuyyk45oGX32Tu/RjWaXkLFrBYQzdZR3tiLI05mH7pUZPlCTQ==
X-Received: by 2002:a1c:9a8d:: with SMTP id c135mr28552738wme.66.1640927049843;
        Thu, 30 Dec 2021 21:04:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y3sm25535919wrq.12.2021.12.30.21.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 21:04:09 -0800 (PST)
Message-Id: <32ad5b5c10da7204dc4a2d3ca74f8d73745925a7.1640927044.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Dec 2021 05:04:02 +0000
Subject: [PATCH 6/8] merge-ort: allow update messages to be written to
 different file stream
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This modifies the new display_update_messages() function to allow
printing to somewhere other than stdout.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 7 +++++--
 merge-ort.h | 3 ++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 6237e2fb7fe..86eebf39166 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4198,7 +4198,8 @@ static int record_conflicted_index_entries(struct merge_options *opt)
 }
 
 void merge_display_update_messages(struct merge_options *opt,
-				   struct merge_result *result)
+				   struct merge_result *result,
+				   FILE *stream)
 {
 	struct merge_options_internal *opti = result->priv;
 	struct hashmap_iter iter;
@@ -4222,7 +4223,7 @@ void merge_display_update_messages(struct merge_options *opt,
 	for (i = 0; i < olist.nr; ++i) {
 		struct strbuf *sb = olist.items[i].util;
 
-		printf("%s", sb->buf);
+		fprintf(stream, "%s", sb->buf);
 	}
 	string_list_clear(&olist, 0);
 
@@ -4271,6 +4272,8 @@ void merge_switch_to_result(struct merge_options *opt,
 		trace2_region_leave("merge", "write_auto_merge", opt->repo);
 	}
 
+	if (display_update_msgs)
+		merge_display_update_messages(opt, result, stdout);
 
 	merge_finalize(opt, result);
 }
diff --git a/merge-ort.h b/merge-ort.h
index 1b93555a60b..55819a57da8 100644
--- a/merge-ort.h
+++ b/merge-ort.h
@@ -76,7 +76,8 @@ void merge_switch_to_result(struct merge_options *opt,
  * so only call this when bypassing merge_switch_to_result().
  */
 void merge_display_update_messages(struct merge_options *opt,
-				   struct merge_result *result);
+				   struct merge_result *result,
+				   FILE *stream);
 
 /* Do needed cleanup when not calling merge_switch_to_result() */
 void merge_finalize(struct merge_options *opt,
-- 
gitgitgadget

