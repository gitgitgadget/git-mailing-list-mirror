Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2FBC433B4
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 18:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CE77613C0
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 18:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240705AbhDFSsH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 14:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240547AbhDFSsE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 14:48:04 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EF5C06174A
        for <git@vger.kernel.org>; Tue,  6 Apr 2021 11:47:55 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id d191so7851897wmd.2
        for <git@vger.kernel.org>; Tue, 06 Apr 2021 11:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ieKN0ePML38Z+JEsF9arGpYtZ2tbULScvKE8Rh2Dso4=;
        b=e1T8TzHaZSS4DuJMbpP50gUWQ/NfEIeU0L92PsVkl+gF37sqxznexFnPrpTxE+rj0J
         UPofYcxaa86XOL55ZTGa8aAUvRVH2noO3yi7Q1qABSdXpzNFzY9aLb3DuNVwOQnoGRuh
         4U68LWLv0Jz3fnOGUP9874VLsIhpS38DpLRi5AC9vrS2p7DH2bdTwIip2WZtCGS+fidA
         n3JRipNIseL8bfv3qWOr6wczRQ/Bg2wrhl54jLr54jiKXVCiZPcUux+rmkuOzs5kWzNO
         6SOxDP55Kk6QIhw+dQKWRGslJDTF//h+1TvYxyM4N+D/Ef1M21vPHf48xypE8W/BIbnj
         B54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ieKN0ePML38Z+JEsF9arGpYtZ2tbULScvKE8Rh2Dso4=;
        b=t5XxmQrK+pbSqzMa8YKGeSNYL/nkEOrwQPKNRKB4wD/GSJLCYbQBfolzefdV2IhfrM
         A6pXGmagNC22A754bWGvI98CP8KnxWm34TEjv2kqF8fSdvsNAg56dsW/mG34nH7ObeS5
         ZoPB8YQrkbtwjJzrN+hsJ3XrFABS1E6RpGBqtZ7GsK5BcKTKi7DAbP7soG3W2BC81GyV
         +l+rEIMVypdMPMgxCRDJvDtYX1qXyd2n4yS82LZiLFrt0yH6ZQ0zH3+pcYXLt0vNht9v
         Zx12wALgW0AvH3J/KNzFZWSJbbIX3Rkk+PMjgtlDz+kKYbgr4PdF5v8VI6Ckfr/1UsPK
         rJ7w==
X-Gm-Message-State: AOAM533tMfjuFKbvpD3/pyldjVp9ZMIkmccjbWeWWmt4WBKnU3u1ASBr
        242o1zB2AbOiwzjNzG5rUBtNek88KgA=
X-Google-Smtp-Source: ABdhPJxsgim0ysaIm4+bB90ldGzN9VocwFWnS+rBvaJHOuxeECJCeOZ/7GJzcb1GNyXS+QVWK5DhAw==
X-Received: by 2002:a1c:e906:: with SMTP id q6mr5396362wmc.138.1617734873890;
        Tue, 06 Apr 2021 11:47:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r11sm18592964wrp.70.2021.04.06.11.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 11:47:53 -0700 (PDT)
Message-Id: <96388d949b98668d1f272090f7100da09a1c977d.1617734870.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.924.v2.git.1617734870.gitgitgadget@gmail.com>
References: <pull.924.git.1617627856.gitgitgadget@gmail.com>
        <pull.924.v2.git.1617734870.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Apr 2021 18:47:48 +0000
Subject: [PATCH v2 3/5] refspec: output a refspec item
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     tom.saeger@oracle.com, gitster@pobox.com, sunshine@sunshineco.com,
        Derrick Stolee <stolee@gmail.com>,
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
 refspec.c | 23 +++++++++++++++++++++++
 refspec.h |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/refspec.c b/refspec.c
index e3d852c0bfec..e79cde3c58be 100644
--- a/refspec.c
+++ b/refspec.c
@@ -180,6 +180,29 @@ void refspec_item_clear(struct refspec_item *item)
 	item->exact_sha1 = 0;
 }
 
+char *refspec_item_format(const struct refspec_item *rsi)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	if (rsi->matching)
+		return xstrdup(":");
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
+	return strbuf_detach(&buf, NULL);
+}
+
 void refspec_init(struct refspec *rs, int fetch)
 {
 	memset(rs, 0, sizeof(*rs));
diff --git a/refspec.h b/refspec.h
index 8b79891d3218..9f2ddc7949a1 100644
--- a/refspec.h
+++ b/refspec.h
@@ -56,6 +56,8 @@ int refspec_item_init(struct refspec_item *item, const char *refspec,
 void refspec_item_init_or_die(struct refspec_item *item, const char *refspec,
 			      int fetch);
 void refspec_item_clear(struct refspec_item *item);
+char *refspec_item_format(const struct refspec_item *rsi);
+
 void refspec_init(struct refspec *rs, int fetch);
 void refspec_append(struct refspec *rs, const char *refspec);
 __attribute__((format (printf,2,3)))
-- 
gitgitgadget

