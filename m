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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAF9C433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 248D422CF6
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbgLDUs6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 15:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbgLDUs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 15:48:58 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9A9C061A53
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 12:48:17 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id x6so2636459wro.11
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 12:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Hc3mWT9aEJqqlzm5KsR2jjqFQ0+PmgVyER5CrCXRFso=;
        b=myceDPXNSP3md5j6CNLcKUntR+8HuvC7y40VlwZSG/rKoZckq4KvtKmzkOaZV/BVnX
         ZpjTDhh3HL2SxvHA2YJ1T+E+GIrOVZGzkJvCqHwAyZfYntk2Xw7Cw66ZGahT8I4HR/Mf
         7GomcoVMZljonoke/glJR+KyfmAfnK7wC+X8xWaLC4gWvYKNWjcWxbmzTC8jcKEPYEut
         QTab0xFjziDXkrar5C9UzJ53jIxO5SvHL30+CS+Bz2Oh3f65TAhp7GUkqqJyfZgvUPsU
         hz9ZI4eE4wPcruKeUhHcFShPwaQ3QgL+a7ekXDCb947CSBuw6VxR+TkDoO940zZ6Oiyg
         5aoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Hc3mWT9aEJqqlzm5KsR2jjqFQ0+PmgVyER5CrCXRFso=;
        b=bUd25Pi5NFWaraz7d+DGi4vsAkhfdGITTZ0i4blvE+cd1CY9kJIiyXfzBsSZEaiBtl
         PwLBf8OU4rVKUVxz33RhXaxsog+V5TT0uLXCCZ7TQyHLYlpxvz5FN2Rm8sv71/liaA1L
         Wjg4ZZgs4QV1B6H+TI2nCzkbDY6qqp0bsqAw2M+/BIUeTyZsPh874i9qOx3BfbNP8hFM
         k1prziO5vPxUZ7sV95SEhZn/mTNjEaF2ZlH9iBcmXhjFhVicrXjfSn7cRykiJy8F2at/
         41OpaQey25WNbBWWrPw7xNUT3NGewzhBcRpu/l42NheStgwnmRamMXD0w0kQJ5KoLWUJ
         iimA==
X-Gm-Message-State: AOAM530t4tBsaoQYoCD4FdNZOh6FtI3bUwOQmWbfn4+O01N1teJr+3Qf
        PCtEJn3e6mwK80npnl6kFwqiALjugaY=
X-Google-Smtp-Source: ABdhPJyWyPqZWB8UMZK1hz98v/XzvvJWmabjRpVenIzUzH1UGztvl4nxwXpApVZI3JHtswPLe1HX2A==
X-Received: by 2002:adf:f94b:: with SMTP id q11mr7061607wrr.351.1607114896075;
        Fri, 04 Dec 2020 12:48:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 189sm4707254wma.22.2020.12.04.12.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 12:48:15 -0800 (PST)
Message-Id: <acb40f5c165fa6dd2fe54caee3bcb4f2b24507e3.1607114890.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
References: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
        <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Dec 2020 20:47:53 +0000
Subject: [PATCH v2 03/20] merge-ort: port merge_start() from merge-recursive
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, dstolee@microsoft.com,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

merge_start() basically does a bunch of sanity checks, then allocates
and initializes opt->priv -- a struct merge_options_internal.

Most of the sanity checks are usable as-is.  The
allocation/intialization is a bit different since merge-ort has a very
different merge_options_internal than merge-recursive, but the idea is
the same.

The weirdest part here is that merge-ort and merge-recursive use the
same struct merge_options, even though merge_options has a number of
fields that are oddly specific to merge-recursive's internal
implementation and don't even make sense with merge-ort's high-level
design (e.g. buffer_output, which merge-ort has to always do).  I reused
the same data structure because:
  * most the fields made sense to both merge algorithms
  * making a new struct would have required making new enums or somehow
    externalizing them, and that was getting messy.
  * it simplifies converting the existing callers by not having to
    have different code paths for merge_options setup.

I also marked detect_renames as ignored.  We can revisit that later, but
in short: merge-recursive allowed turning off rename detection because
it was sometimes glacially slow.  When you speed something up by a few
orders of magnitude, it's worth revisiting whether that justification is
still relevant.  Besides, if folks find it's still too slow, perhaps
they have a better scaling case than I could find and maybe it turns up
some more optimizations we can add.  If it still is needed as an option,
it is easy to add later.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 8c9fea1a5a..f8ac721aa3 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -17,6 +17,8 @@
 #include "cache.h"
 #include "merge-ort.h"
 
+#include "diff.h"
+#include "diffcore.h"
 #include "strmap.h"
 #include "tree.h"
 
@@ -205,7 +207,48 @@ void merge_finalize(struct merge_options *opt,
 
 static void merge_start(struct merge_options *opt, struct merge_result *result)
 {
-	die("Not yet implemented.");
+	/* Sanity checks on opt */
+	assert(opt->repo);
+
+	assert(opt->branch1 && opt->branch2);
+
+	assert(opt->detect_directory_renames >= MERGE_DIRECTORY_RENAMES_NONE &&
+	       opt->detect_directory_renames <= MERGE_DIRECTORY_RENAMES_TRUE);
+	assert(opt->rename_limit >= -1);
+	assert(opt->rename_score >= 0 && opt->rename_score <= MAX_SCORE);
+	assert(opt->show_rename_progress >= 0 && opt->show_rename_progress <= 1);
+
+	assert(opt->xdl_opts >= 0);
+	assert(opt->recursive_variant >= MERGE_VARIANT_NORMAL &&
+	       opt->recursive_variant <= MERGE_VARIANT_THEIRS);
+
+	/*
+	 * detect_renames, verbosity, buffer_output, and obuf are ignored
+	 * fields that were used by "recursive" rather than "ort" -- but
+	 * sanity check them anyway.
+	 */
+	assert(opt->detect_renames >= -1 &&
+	       opt->detect_renames <= DIFF_DETECT_COPY);
+	assert(opt->verbosity >= 0 && opt->verbosity <= 5);
+	assert(opt->buffer_output <= 2);
+	assert(opt->obuf.len == 0);
+
+	assert(opt->priv == NULL);
+
+	/* Initialization of opt->priv, our internal merge data */
+	opt->priv = xcalloc(1, sizeof(*opt->priv));
+
+	/*
+	 * Although we initialize opt->priv->paths with strdup_strings=0,
+	 * that's just to avoid making yet another copy of an allocated
+	 * string.  Putting the entry into paths means we are taking
+	 * ownership, so we will later free it.
+	 *
+	 * In contrast, conflicted just has a subset of keys from paths, so
+	 * we don't want to free those (it'd be a duplicate free).
+	 */
+	strmap_init_with_options(&opt->priv->paths, NULL, 0);
+	strmap_init_with_options(&opt->priv->conflicted, NULL, 0);
 }
 
 /*
-- 
gitgitgadget

