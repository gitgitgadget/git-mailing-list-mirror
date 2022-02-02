Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B09C433F5
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 07:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238315AbiBBHev (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 02:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238048AbiBBHeq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 02:34:46 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7179BC061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 23:34:46 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id u15so36601481wrt.3
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 23:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=s/FNUD3Nfv1aJ56di/sqnJE/jJBUPQEIKWoIKlAJYVg=;
        b=UXMWn4Wa3cHRYntS+MDukKQKR1YaCl21cesMTEuDJmrer/0bUX0cEDi+G9u6haqmIw
         4RyV9OvEzfkIZ8TZOQF7wlux0O4QANC/I73uiRQZW/MDPqSh3MucIwRWzAOJEYViRNqh
         QEWq+LjjNkeu2Tz+o0scyVX+S7JfRFFVEWtYVckAmkthTEQsbcGWYY9dWw/fAkoWyqXD
         XC5qvZvoDgy8wyH7q0Nfl5errROIQzVOz4rW5s+fdvwnJ3nNVnCEfkaRgJx9mLmJHexo
         bdBp3AkthFKxB6NEH+wJXIIE3XwV2GZja2bG4pWyy2qm5Pb6Yd+zg/TIPq28wGVbJcbl
         DZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=s/FNUD3Nfv1aJ56di/sqnJE/jJBUPQEIKWoIKlAJYVg=;
        b=4rC+xA7LrxlI5O/wbCOyditqiPf2hkjbKkG8ibSsla5ONr0R6G9I25Cq0r2rDgAqK6
         33yPxPDarkOFWeaHTnnshLi8Zz8pz7JAMB6CfHm7Fa39bWECMfMcs8m5nGX6FAi4yI0T
         DWK4yrT7FaAaXiViWOo1VSLb1KMa0YwQ0scNahYv5S7Y5n/Omqz3toIMYqhmbWe4nCiC
         6OSaQY7ksrZ85zUlNMa61b2DnLH5/sUUn836Az+tnWEQnLPRuhI0l54ErMw6vAmRZFX+
         j3AaJ80L2na6Lu5jeRHlD+yxMisKltWIJ2G/naQ9JJZNYH/ZI2xqPSKDbc5A75ICP1Dk
         IFAQ==
X-Gm-Message-State: AOAM5324czAfb/+8v1pW/si9XTXihWg8zRjFAT/cZv1kE0WGNSCmRa6D
        YLImaDj0qZkwxAWFMrGmNF7ZiDMJB7M=
X-Google-Smtp-Source: ABdhPJwO0qofRf3Ndxr4TfcLnatCDpRHCWk3Lh7/KPz+45IJUR/ZzsKi28OR84aXcr6N3oPDKww3kw==
X-Received: by 2002:a5d:524e:: with SMTP id k14mr23920339wrc.620.1643787284884;
        Tue, 01 Feb 2022 23:34:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c14sm18048078wri.56.2022.02.01.23.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 23:34:44 -0800 (PST)
Message-Id: <4780ff6784d426bf0a96859ef9bf9c14e87d5f50.1643787281.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
        <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Feb 2022 07:34:28 +0000
Subject: [PATCH v3 02/15] merge-tree: move logic for existing merge into new
 function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In preparation for adding a non-trivial merge capability to merge-tree,
move the existing merge logic for trivial merges into a new function.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge-tree.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 06f9eee9f78..914ec960b7e 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -366,15 +366,12 @@ static void *get_tree_descriptor(struct repository *r,
 	return buf;
 }
 
-int cmd_merge_tree(int argc, const char **argv, const char *prefix)
+static int trivial_merge(int argc, const char **argv)
 {
 	struct repository *r = the_repository;
 	struct tree_desc t[3];
 	void *buf1, *buf2, *buf3;
 
-	if (argc != 4)
-		usage(merge_tree_usage);
-
 	buf1 = get_tree_descriptor(r, t+0, argv[1]);
 	buf2 = get_tree_descriptor(r, t+1, argv[2]);
 	buf3 = get_tree_descriptor(r, t+2, argv[3]);
@@ -386,3 +383,10 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 	show_result();
 	return 0;
 }
+
+int cmd_merge_tree(int argc, const char **argv, const char *prefix)
+{
+	if (argc != 4)
+		usage(merge_tree_usage);
+	return trivial_merge(argc, argv);
+}
-- 
gitgitgadget

