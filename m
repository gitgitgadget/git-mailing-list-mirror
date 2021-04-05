Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA834C43461
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 13:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8985B613AD
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 13:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240923AbhDENEd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 09:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235731AbhDENE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 09:04:28 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07010C061793
        for <git@vger.kernel.org>; Mon,  5 Apr 2021 06:04:21 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id a12so1092155wrq.13
        for <git@vger.kernel.org>; Mon, 05 Apr 2021 06:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=P0CSrGG0xl0UZrDRJ2dSC6xgIbyMmNQRJEdbeKxUd2w=;
        b=eCpwGhxYRWuIhx7A2B+7uD7mIsIETD41zMxklbrVAbKh3Q+lK0j2kClOng74tmjZpr
         d21Fh51boX10pnzER/rvb6OJvVBC1whVAsQ2viMGMSNv9f530bYLGA11zfHbsjyclZOx
         LKO8aSBgHKf0ibrVYMl8kkeN6evb3Iv07M3aHdWQ4p4aodYNCy9xt5bFuYu+Ez2e193u
         wIe3Oka8sktClO9SD9cG/O3cXYKGbqJCIHmJBddG5RI/twKaIRw6w2XXk35XnCBDeGYb
         KNwJf31Nh76kf8gIBUgii5qrsX2168fncJ4Z3GU2o7mv7+X9Z+iegCmW+JKxA+WYClN3
         /Waw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=P0CSrGG0xl0UZrDRJ2dSC6xgIbyMmNQRJEdbeKxUd2w=;
        b=TV0ghSgjrmvgQk7PrSo/f1rM/PIKMNAXaV/1Me0g+9Lri3ixXX6+1LABGDyQEmzerP
         JbLjUlNVP7TcA2WuoKZd8L/ubOH8k+vl3lbAutS2py/HwXLpx3irN6xyJhkyZ60i944J
         US7qGVwO8+8248y/No+PNA2Y89Kq8YCZLBuA0lYIQJv595/TK0vQGLjXDcRHSBNQ3qvT
         d2K8+I1ZttYwQsepo4tCpa+ks/XpdIqTkU0pAgf5yY1eEydXIyGxxjH3mbsJmmZrqCko
         dkin9Nhi5wCSqqHDG5GWlbChIgYes8hVQTg5wgDkNDNtQARm8RLnfURjnzTGLtTSjfdS
         4U7w==
X-Gm-Message-State: AOAM531ZR98awFbPUeSvVrs24JUnp598j0OMaA9GDyLjNvkEwHI0jop8
        /+fBTb18+YOSAR1enprFMFYZeT3Qo6Q=
X-Google-Smtp-Source: ABdhPJys0Ny0jnAVLtqCHtQrJAvLm24vpxfTizmke5BooxLWhUj7yZMnpo/94PXIFnYku/RRYaIjcw==
X-Received: by 2002:a5d:6a92:: with SMTP id s18mr9905813wru.200.1617627859864;
        Mon, 05 Apr 2021 06:04:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u19sm11082665wml.28.2021.04.05.06.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 06:04:19 -0700 (PDT)
Message-Id: <e10007e1cf8ff0005295f648b9489c11a9427122.1617627856.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.924.git.1617627856.gitgitgadget@gmail.com>
References: <pull.924.git.1617627856.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 05 Apr 2021 13:04:13 +0000
Subject: [PATCH 3/5] refspec: output a refspec item
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     tom.saeger@oracle.com, gitster@pobox.com, sunshine@sunshineco.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Add a new method, refspec_item_format(), that takes a 'struct
refspec_item' pointer as input and returns a string for how that refspec
item should be written to Git's config or a subcommand, such as 'git
fetch'.

There are several subtleties regarding special-case refspecs that can
occur and are represented in t5511-refspec.sh. These cases will be
explored in new tests in the following change. It requires adding a new
test helper in order to test this format directly, so that is saved for
a separate change to keep this one focused on the logic of the format
method.

A future change will consume this method when translating refspecs in
the 'prefetch' task of the 'git maintenance' builtin.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 refspec.c | 25 +++++++++++++++++++++++++
 refspec.h |  5 +++++
 2 files changed, 30 insertions(+)

diff --git a/refspec.c b/refspec.c
index e3d852c0bfec..ca65ba01bfe6 100644
--- a/refspec.c
+++ b/refspec.c
@@ -180,6 +180,31 @@ void refspec_item_clear(struct refspec_item *item)
 	item->exact_sha1 = 0;
 }
 
+const char *refspec_item_format(const struct refspec_item *rsi)
+{
+	static struct strbuf buf = STRBUF_INIT;
+
+	strbuf_reset(&buf);
+
+	if (rsi->matching)
+		return ":";
+
+	if (rsi->negative)
+		strbuf_addch(&buf, '^');
+	else if (rsi->force)
+		strbuf_addch(&buf, '+');
+
+	if (rsi->src)
+		strbuf_addstr(&buf, rsi->src);
+
+	if (rsi->dst) {
+		strbuf_addch(&buf, ':');
+		strbuf_addstr(&buf, rsi->dst);
+	}
+
+	return buf.buf;
+}
+
 void refspec_init(struct refspec *rs, int fetch)
 {
 	memset(rs, 0, sizeof(*rs));
diff --git a/refspec.h b/refspec.h
index 8b79891d3218..92a312f5b4e6 100644
--- a/refspec.h
+++ b/refspec.h
@@ -56,6 +56,11 @@ int refspec_item_init(struct refspec_item *item, const char *refspec,
 void refspec_item_init_or_die(struct refspec_item *item, const char *refspec,
 			      int fetch);
 void refspec_item_clear(struct refspec_item *item);
+/*
+ * Output a given refspec item to a string.
+ */
+const char *refspec_item_format(const struct refspec_item *rsi);
+
 void refspec_init(struct refspec *rs, int fetch);
 void refspec_append(struct refspec *rs, const char *refspec);
 __attribute__((format (printf,2,3)))
-- 
gitgitgadget

