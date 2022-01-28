Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FECC433EF
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 12:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348125AbiA1MC5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 07:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242911AbiA1MC4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 07:02:56 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D71FC061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 04:02:55 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id e8so10552665wrc.0
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 04:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DYuGb9rSkace8bGLkTMmHIMDj91JTpOlwsxg0hTlXNo=;
        b=I5RaRHCG1sPqTxdvcRk5TWrfj1tSColTgciQBSwM2OsNpDzrObkN0aQRFEZNp84A+6
         pZawY7j29tye0dUMPM9TNRGv5RMiHoCME98NL9UctthHCtHBYnrU8TMNOmO1LJs5s8I3
         Fg18tX5GinenLTsO/hST9BZmSSwAUBbI6GFCm9mYmyKjMyT6VMBUtmxD47wLmORV6W7k
         AzKNApi4Pu5iuiGS6+a16SbtysBIPwgQQYF7nUcghv6Ls3VUgS2/W1Z+Ba/NB44P2Cah
         9vgIXHzF2HYNXq8Z+S83TqXQUIZDdjcqeF1PKLDA5GB622pgFqbf/xcOn9nQQbpmoZot
         uXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DYuGb9rSkace8bGLkTMmHIMDj91JTpOlwsxg0hTlXNo=;
        b=BDAOcZr9lCFg3xQbmwDEZnq/hGtNehkK3YJu7lS6sRGmwYIFDmA1OtQ3X7Tk3CxPgX
         hZiy0JeUiXRV5jBu9C6NAS1mWwuBrgIT0H9ot74CeLRrt0eUkUvWot44FIcLXd6uAVQ4
         +oYM4QQtndlYSjKlNzJpMBDO+2Sgc68d6pRoolf12f5gzG/IF1/t/c4dEtlIhUCjoIha
         mCAgm5BU3BTopx9XYlueH78CAq7cp+GEh64eNIzO/5Fq63kc9KAtLG9IAnEYXsAHd+pV
         YvY4wBMNlOKqZIOCT2TWhltzhlDLW0wvbMSbEMrDRBY0tVMl2+k3fwjhUkypCJlfggi5
         X/AA==
X-Gm-Message-State: AOAM531Xtz6dLYiCQzGCK1JkwwxFvwsPj+LtnCdcVkjImfghO4i1yUdH
        Da8HACMIn7mt7CZ4aLDtDZlTG9YdtSw=
X-Google-Smtp-Source: ABdhPJz5vWSTcFxsDiRP72ttWpXVr6YKCfkxVBqnuqoof12KNm9VXnakOe5AdHE6q8FRU5USr2lwkw==
X-Received: by 2002:a05:6000:2ac:: with SMTP id l12mr7259259wry.371.1643371373966;
        Fri, 28 Jan 2022 04:02:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n14sm4747417wri.75.2022.01.28.04.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 04:02:53 -0800 (PST)
Message-Id: <19c7223e265962eac2f56d82d87c2fd069f04c6e.1643371370.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1127.v3.git.1643371370.gitgitgadget@gmail.com>
References: <pull.1127.v2.git.1643310510.gitgitgadget@gmail.com>
        <pull.1127.v3.git.1643371370.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 28 Jan 2022 12:02:49 +0000
Subject: [PATCH v3 2/3] diff.c: move the diff filter bits definitions up a bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This prepares for a more careful handling of the `--diff-filter`
options over the next few commits.

This commit is best viewed with `--color-moved`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff.c | 74 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/diff.c b/diff.c
index c862771a589..5081052c431 100644
--- a/diff.c
+++ b/diff.c
@@ -4570,6 +4570,43 @@ void repo_diff_setup(struct repository *r, struct diff_options *options)
 	prep_parse_options(options);
 }
 
+static const char diff_status_letters[] = {
+	DIFF_STATUS_ADDED,
+	DIFF_STATUS_COPIED,
+	DIFF_STATUS_DELETED,
+	DIFF_STATUS_MODIFIED,
+	DIFF_STATUS_RENAMED,
+	DIFF_STATUS_TYPE_CHANGED,
+	DIFF_STATUS_UNKNOWN,
+	DIFF_STATUS_UNMERGED,
+	DIFF_STATUS_FILTER_AON,
+	DIFF_STATUS_FILTER_BROKEN,
+	'\0',
+};
+
+static unsigned int filter_bit['Z' + 1];
+
+static void prepare_filter_bits(void)
+{
+	int i;
+
+	if (!filter_bit[DIFF_STATUS_ADDED]) {
+		for (i = 0; diff_status_letters[i]; i++)
+			filter_bit[(int) diff_status_letters[i]] = (1 << i);
+	}
+}
+
+static unsigned filter_bit_tst(char status, const struct diff_options *opt)
+{
+	return opt->filter & filter_bit[(int) status];
+}
+
+unsigned diff_filter_bit(char status)
+{
+	prepare_filter_bits();
+	return filter_bit[(int) status];
+}
+
 void diff_setup_done(struct diff_options *options)
 {
 	unsigned check_mask = DIFF_FORMAT_NAME |
@@ -4774,43 +4811,6 @@ static int parse_dirstat_opt(struct diff_options *options, const char *params)
 	return 1;
 }
 
-static const char diff_status_letters[] = {
-	DIFF_STATUS_ADDED,
-	DIFF_STATUS_COPIED,
-	DIFF_STATUS_DELETED,
-	DIFF_STATUS_MODIFIED,
-	DIFF_STATUS_RENAMED,
-	DIFF_STATUS_TYPE_CHANGED,
-	DIFF_STATUS_UNKNOWN,
-	DIFF_STATUS_UNMERGED,
-	DIFF_STATUS_FILTER_AON,
-	DIFF_STATUS_FILTER_BROKEN,
-	'\0',
-};
-
-static unsigned int filter_bit['Z' + 1];
-
-static void prepare_filter_bits(void)
-{
-	int i;
-
-	if (!filter_bit[DIFF_STATUS_ADDED]) {
-		for (i = 0; diff_status_letters[i]; i++)
-			filter_bit[(int) diff_status_letters[i]] = (1 << i);
-	}
-}
-
-static unsigned filter_bit_tst(char status, const struct diff_options *opt)
-{
-	return opt->filter & filter_bit[(int) status];
-}
-
-unsigned diff_filter_bit(char status)
-{
-	prepare_filter_bits();
-	return filter_bit[(int) status];
-}
-
 static int diff_opt_diff_filter(const struct option *option,
 				const char *optarg, int unset)
 {
-- 
gitgitgadget

