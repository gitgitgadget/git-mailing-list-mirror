Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5197FC433EF
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 18:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244514AbiA2SHW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Jan 2022 13:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352996AbiA2SHS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jan 2022 13:07:18 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4C9C061741
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 10:07:18 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id s18so17133637wrv.7
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 10:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=s/FNUD3Nfv1aJ56di/sqnJE/jJBUPQEIKWoIKlAJYVg=;
        b=fqdWb86ba550I1HmmkCbs2tsxtkgABQEuT4GF+PFn+cpJN/cqxZTsRykBI5up48yfk
         ZPz+0YWAN3xWyvtQ1Pkx1djYydFEmO6ZIqxl1tSJPQW5RXXzfHgHZ3VWlpQOMTSMHomz
         pIKL+0PUAawVAT/g1AvYQsIx74rj6gBV+rv8C6wc1cgB9U+y7jF379VDkyhxU/1D0xSn
         COYnwr6tqw+esksfO9jb0YlPB5J8AJmpy7Zk2wUkOhM4IMyxlbQgXJI3f3Ege6UIxekI
         GSaRfNW0qRdpa6JyZDRWMuY4zD9eBz37e+RIRbM/xk1U0zbLp5gV/NHhL6iS3BOQ9onF
         cwpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=s/FNUD3Nfv1aJ56di/sqnJE/jJBUPQEIKWoIKlAJYVg=;
        b=J6uMZ7ufeW44/CCHkvL04roe1YF/2tWj6B7lEQDUUZJYs7GvxkuwWGMIAZsf3g5Vv+
         TmHvPZBNXaSCfZC2BZELXDrrXDmLGUnDY3V/iTL2Rt+1b1yh42westdKO80bMRJ12ASA
         Yi4K9HupmF71+vBp3wS+tmsxYmVDFZHveoYImVwkWMoue3Dl8dZbDjXD+ntLqx/SRGE0
         jLGhPLmRb/4GqlN/y3iVIVsk2ofNF2sFhR9/MMELVU/w+R7UdRJNSp3diJIevtkBr0wT
         8MS30FLdJ6z1Qp3wnlKyJfnOr+EAbLeNjnARlZ6ADV0mckpmyIJ1ptm21brBY9yedN9q
         fm0g==
X-Gm-Message-State: AOAM530oHB2FIyWmINbWfhFoRKh2PwUZKAtYpGcXKoqOmFTAwtSAXjnJ
        cSuvQlG6KwR8wO9FdKphYT0s35V8imI=
X-Google-Smtp-Source: ABdhPJyFuOAeElBvhX+MgXwyUheNzoNfsSzWpsY4CTfavjAXr8WiRFaCjPXf3xXWJkRA96/mXgR5Vw==
X-Received: by 2002:a5d:6486:: with SMTP id o6mr11154608wri.636.1643479636717;
        Sat, 29 Jan 2022 10:07:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t16sm7371269wrx.79.2022.01.29.10.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 10:07:16 -0800 (PST)
Message-Id: <4780ff6784d426bf0a96859ef9bf9c14e87d5f50.1643479633.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
        <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 29 Jan 2022 18:07:02 +0000
Subject: [PATCH v2 02/13] merge-tree: move logic for existing merge into new
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

