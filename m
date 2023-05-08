Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF50EC7EE25
	for <git@archiver.kernel.org>; Mon,  8 May 2023 22:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbjEHV77 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 17:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234386AbjEHV7v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 17:59:51 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4174EFC
        for <git@vger.kernel.org>; Mon,  8 May 2023 14:59:48 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-559e317eef1so75350947b3.0
        for <git@vger.kernel.org>; Mon, 08 May 2023 14:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683583187; x=1686175187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vdKIcqYBgzsFlc3rxsHPqqlUt5NsrdUU8Q1NvrDtse0=;
        b=IRMH5LvRrPaTrjNDbQ3IgArpKtJASdkvZvbiFMvMGuMSsE6h5aq9B7ZY7T9ftGQ4Tm
         4jc6NcgsKUDH1XRffpXmpf1gn9gT2a8kijBt0A7PtQQP8XEdjHYzCim4QsnrxoGemMyn
         kkMnYvqi+M+8gCOoAdvzCaewMtaReRIsYaA4dGQfSIA3rdzFLoX8/YFxp51JDAUX9+Pr
         DNwRrchJPcxZodjB8R9xMBmwKZtKNfpPXMgxexT7YkcRqor2fqlweT4+f5wTl+43uHS3
         f/8xZfzpOKSXZyTbUR6BGipbNTEY6dnrQBv/4ix3KG3gcKbDgF24W7XPNAsjKSv9tlzp
         A0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683583187; x=1686175187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdKIcqYBgzsFlc3rxsHPqqlUt5NsrdUU8Q1NvrDtse0=;
        b=OBdNBruWLU7skitDaad8CqKbuoRdi7Ri2iwyqhhLv+XoHX1oM2FVfLdH5X8pi0VHnl
         AJTPBA9epbc7TbtOyWebZ9C1XuuA23cVmamkxX1cvtAhXMr132iYT9X4YdBvLighrjh8
         k0kbV6JtBxMB2Gu2cVAgKZrNscaenBvIwUDFdZZxBjwycmtlWk5T+8V60CZwSv3stV+D
         j9hcM1Y5ZO20wx5GnvZz0yzmssGNQQrZOD0nxY2vMOHL4rvwFODghBjwgLKCgQDeQKdp
         3wRq/+1sT1sMJIs3aj/a96ORwSOhtrCaHV+0r8a8zwWCRV/+IQ2io8nhAH4nvySUUs+Q
         aPzQ==
X-Gm-Message-State: AC+VfDzAT762pSJAu6m8BZ2bCDwfm8tg+jf2WizH5JzLx/KvKDmseD71
        29/jCQ52xiljMB37EiwmL8fF2t1pUGYaVpI/EN/8dg==
X-Google-Smtp-Source: ACHHUZ5+ynZDlkQeCId48RgpcNlpKe75pJ7dBgv5rlDQ07pEBZ3yaOSdulQ3bkk7wumMe7cPDHJnZQ==
X-Received: by 2002:a0d:f1c3:0:b0:55d:aff9:fbbb with SMTP id a186-20020a0df1c3000000b0055daff9fbbbmr14133605ywf.28.1683583187222;
        Mon, 08 May 2023 14:59:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u124-20020a816082000000b0055a1c6d1249sm2791667ywb.72.2023.05.08.14.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 14:59:46 -0700 (PDT)
Date:   Mon, 8 May 2023 17:59:45 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 02/15] ref-filter.h: provide `REF_FILTER_INIT`
Message-ID: <ea1c7834db8c62d04344e824eb0848bad35afd1b.1683581621.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1683581621.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Provide a sane initialization value for `struct ref_filter`, which in a
subsequent patch will be used to initialize a new field.

In the meantime, fix a case in test-reach.c where its `ref_filter` is
not even zero-initialized.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/branch.c       | 3 +--
 builtin/for-each-ref.c | 3 +--
 builtin/tag.c          | 3 +--
 ref-filter.h           | 3 +++
 t/helper/test-reach.c  | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 501c47657c..03bb8e414c 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -662,7 +662,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	int reflog = 0, quiet = 0, icase = 0, force = 0,
 	    recurse_submodules_explicit = 0;
 	enum branch_track track;
-	struct ref_filter filter;
+	struct ref_filter filter = REF_FILTER_INIT;
 	static struct ref_sorting *sorting;
 	struct string_list sorting_options = STRING_LIST_INIT_DUP;
 	struct ref_format format = REF_FORMAT_INIT;
@@ -720,7 +720,6 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 	setup_ref_filter_porcelain_msg();
 
-	memset(&filter, 0, sizeof(filter));
 	filter.kind = FILTER_REFS_BRANCHES;
 	filter.abbrev = -1;
 
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 695fc8f4a5..99ccb73518 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -24,7 +24,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	struct string_list sorting_options = STRING_LIST_INIT_DUP;
 	int maxcount = 0, icase = 0, omit_empty = 0;
 	struct ref_array array;
-	struct ref_filter filter;
+	struct ref_filter filter = REF_FILTER_INIT;
 	struct ref_format format = REF_FORMAT_INIT;
 	struct strbuf output = STRBUF_INIT;
 	struct strbuf err = STRBUF_INIT;
@@ -61,7 +61,6 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	};
 
 	memset(&array, 0, sizeof(array));
-	memset(&filter, 0, sizeof(filter));
 
 	format.format = "%(objectname) %(objecttype)\t%(refname)";
 
diff --git a/builtin/tag.c b/builtin/tag.c
index 1850a6a6fd..6b41bb7374 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -443,7 +443,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	struct msg_arg msg = { .buf = STRBUF_INIT };
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
-	struct ref_filter filter;
+	struct ref_filter filter = REF_FILTER_INIT;
 	struct ref_sorting *sorting;
 	struct string_list sorting_options = STRING_LIST_INIT_DUP;
 	struct ref_format format = REF_FORMAT_INIT;
@@ -501,7 +501,6 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	git_config(git_tag_config, &sorting_options);
 
 	memset(&opt, 0, sizeof(opt));
-	memset(&filter, 0, sizeof(filter));
 	filter.lines = -1;
 	opt.sign = -1;
 
diff --git a/ref-filter.h b/ref-filter.h
index 430701cfb7..a920f73b29 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -92,6 +92,9 @@ struct ref_format {
 	struct string_list bases;
 };
 
+#define REF_FILTER_INIT { \
+	.points_at = OID_ARRAY_INIT, \
+}
 #define REF_FORMAT_INIT {             \
 	.use_color = -1,              \
 	.bases = STRING_LIST_INIT_DUP, \
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index 5b6f217441..ef58f10c2d 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -139,7 +139,7 @@ int cmd__reach(int ac, const char **av)
 
 		printf("%s(X,_,_,0,0):%d\n", av[1], can_all_from_reach_with_flag(&X_obj, 2, 4, 0, 0));
 	} else if (!strcmp(av[1], "commit_contains")) {
-		struct ref_filter filter;
+		struct ref_filter filter = REF_FILTER_INIT;
 		struct contains_cache cache;
 		init_contains_cache(&cache);
 
-- 
2.40.1.477.g956c797dfc

