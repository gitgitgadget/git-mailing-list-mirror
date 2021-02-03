Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36D3C433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C767A64F50
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbhBCDbT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 22:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbhBCDaU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 22:30:20 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37415C0612F2
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 19:28:40 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id q7so22549305wre.13
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 19:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KYXXVyw5H3JyNbDugs3LzYrAKPVskYuIXY3VLwb52r0=;
        b=uKzgOKV4KSS98oXucpvHvzzvD6rA+CzmVSVHZ2GDrYRarYWaMKKJMxIls01SfQb3Sg
         W3NpxkqEHFJFA3Obukk1Jpn5chexbef2Sv10kG+nFZmMrLk8iXLGHfdrhhW0hJDuW/pi
         r/CagkUV2p0rzZO+qzpD1AP3pXlcnMMlodVEiaFkmL5b+i8m4sBf7ZrllhUcNiIDM2tY
         rPhyVfZvZWsHACsG5Y1kddHJ0b+kd4/yhxYdWtgB9b7JoADJ1kA/hnWKMwZ4NDYio91z
         CbVlJ86qY3lFEGlkNCiHqyHyGhKlTy/FdhJj2sL2WCfjlND7iTeTY039vTQia3Nxqhp4
         5F5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KYXXVyw5H3JyNbDugs3LzYrAKPVskYuIXY3VLwb52r0=;
        b=PXLDRLi2sALTrPW+nDh5yI+pNIcqC/cip8MGOSmB5Nv8yK5cj70fELQslC/+8iENvG
         dC44/tHCY5aFKwiO3/tIcZI2dLjFgLnKHTc/OufKea6cMed05KCEk5ePe8D0PSUniqBt
         0VRVvKP9ESGqSw6gpxQ02UOZUtbw0+Qx4UeyvzckwNxv/3I9v0X7C/YPoMOTxGzMmIwj
         d7uchOomy8Ajs5OvyfK9lzW+1++qeT0jWVXRK43TUpEslX2t0CfTPVTatvTlio4Hsbdc
         UhYHCXtPuMhRXGpEmEtwVk7WJmiaj8prdjYxK1ck4tAB3cqSL9O6Arm9BeEn98h+/mtn
         n70w==
X-Gm-Message-State: AOAM532Z/uTh/ZF94dxyG+NhNQi4kGbtKK91L5fv5p3hESd4gY6/sj3e
        xckU2cIPOjM6J49AzIHK9HlnuxZPnM7ZrA==
X-Google-Smtp-Source: ABdhPJzgSQk3qOus64eq+GElZy6udZ2SpDKOl/RAJPfM/hGw31Hoa75mTkoI5T7iupjnqDJo/B+IDw==
X-Received: by 2002:adf:f508:: with SMTP id q8mr1043705wro.291.1612322918548;
        Tue, 02 Feb 2021 19:28:38 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c5sm971089wrn.77.2021.02.02.19.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 19:28:37 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 21/25] pickaxe: use PCREv2 for -G and -S
Date:   Wed,  3 Feb 2021 04:28:07 +0100
Message-Id: <20210203032811.14979-22-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210203032811.14979-1-avarab@gmail.com>
References: <20210203032811.14979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Follow-up b65abcafc7a (grep: use PCRE v2 for optimized fixed-string
search, 2019-07-01) and remove the use of kwset in the pickaxe code
for fixed-string search, in favor of optimistically using PCRE v2.

This does mean that the semantics of the -G option subtly change,
before it's an ERE, whereas now it'll be a PCRE if we're compiled with
PCRE. Since PCRE is almost entirely a strict superset of ERE syntax I
think this is OK.

Now when running the newly added t/perf/p4209-pickaxe.sh[1] and the
latest PCRE v2 we'll get the following performance improvements (well,
mostly improvements):

    Test                                                                           origin/next       HEAD
    -----------------------------------------------------------------------------------------------------------------------
    4209.1: git log --pickaxe-regex -S'[þæö]' <limit-rev>..                        0.41(0.37+0.03)   0.42(0.37+0.05) +2.4%
    4209.2: git log -G'a' <limit-rev>..                                            0.61(0.52+0.08)   0.50(0.45+0.05) -18.0%
    4209.3: git log --pickaxe-regex -S'a' <limit-rev>..                            0.73(0.66+0.07)   0.42(0.37+0.05) -42.5%
    4209.4: git log --text -G'a' <limit-rev>..                                     0.61(0.54+0.06)   0.50(0.44+0.05) -18.0%
    4209.5: git log --text --pickaxe-all -G'a' <limit-rev>..                       0.44(0.37+0.06)   0.46(0.36+0.06) +4.5%
    4209.6: git log --pickaxe-all -G'a' <limit-rev>..                              0.46(0.39+0.07)   0.38(0.33+0.05) -17.4%
    4209.7: git log --pickaxe-all --pickaxe-regex -S'a' <limit-rev>..              0.55(0.48+0.06)   0.35(0.30+0.04) -36.4%
    4209.8: git log -G'uncommon' <limit-rev>..                                     0.68(0.60+0.07)   0.59(0.53+0.05) -13.2%
    4209.9: git log --pickaxe-regex -S'uncommon' <limit-rev>..                     0.48(0.45+0.03)   0.36(0.31+0.05) -25.0%
    4209.10: git log --text -G'uncommon' <limit-rev>..                             0.66(0.58+0.07)   0.58(0.52+0.04) -12.1%
    4209.11: git log --text --pickaxe-all -G'uncommon' <limit-rev>..               0.67(0.61+0.05)   0.57(0.52+0.05) -14.9%
    4209.12: git log --pickaxe-all -G'uncommon' <limit-rev>..                      0.62(0.55+0.06)   0.52(0.46+0.06) -16.1%
    4209.13: git log --pickaxe-all --pickaxe-regex -S'uncommon' <limit-rev>..      0.49(0.43+0.06)   0.31(0.26+0.04) -36.7%
    4209.14: git log -G'[þæö]' <limit-rev>..                                       0.71(0.64+0.07)   0.51(0.47+0.04) -28.2%
    4209.15: git log --pickaxe-regex -S'[þæö]' <limit-rev>..                       0.45(0.40+0.05)   0.42(0.37+0.04) -6.7%
    4209.16: git log --text -G'[þæö]' <limit-rev>..                                0.64(0.56+0.07)   0.50(0.44+0.06) -21.9%
    4209.17: git log --text --pickaxe-all -G'[þæö]' <limit-rev>..                  0.64(0.54+0.09)   0.50(0.47+0.03) -21.9%
    4209.18: git log --pickaxe-all -G'[þæö]' <limit-rev>..                         0.66(0.59+0.07)   0.50(0.45+0.05) -24.2%
    4209.19: git log --pickaxe-all --pickaxe-regex -S'[þæö]' <limit-rev>..         0.42(0.38+0.04)   0.41(0.37+0.04) -2.4%
    4209.20: git log -i --pickaxe-regex -S'[þæö]' <limit-rev>..                    0.41(0.38+0.03)   0.49(0.43+0.05) +19.5%
    4209.21: git log -i -G'a' <limit-rev>..                                        0.63(0.61+0.02)   0.50(0.45+0.05) -20.6%
    4209.22: git log -i --pickaxe-regex -S'a' <limit-rev>..                        0.81(0.75+0.06)   0.60(0.58+0.02) -25.9%
    4209.23: git log -i --text -G'a' <limit-rev>..                                 0.64(0.54+0.10)   0.49(0.44+0.05) -23.4%
    4209.24: git log -i --text --pickaxe-all -G'a' <limit-rev>..                   0.47(0.43+0.04)   0.37(0.31+0.06) -21.3%
    4209.25: git log -i --pickaxe-all -G'a' <limit-rev>..                          0.51(0.43+0.08)   0.37(0.31+0.06) -27.5%
    4209.26: git log -i --pickaxe-all --pickaxe-regex -S'a' <limit-rev>..          0.62(0.55+0.05)   0.46(0.41+0.04) -25.8%
    4209.27: git log -i -G'uncommon' <limit-rev>..                                 0.64(0.58+0.05)   0.51(0.48+0.03) -20.3%
    4209.28: git log -i --pickaxe-regex -S'uncommon' <limit-rev>..                 0.48(0.44+0.04)   0.47(0.42+0.05) -2.1%
    4209.29: git log -i --text -G'uncommon' <limit-rev>..                          0.62(0.53+0.08)   0.51(0.44+0.07) -17.7%
    4209.30: git log -i --text --pickaxe-all -G'uncommon' <limit-rev>..            0.61(0.53+0.08)   0.51(0.45+0.06) -16.4%
    4209.31: git log -i --pickaxe-all -G'uncommon' <limit-rev>..                   0.63(0.57+0.05)   0.51(0.47+0.04) -19.0%
    4209.32: git log -i --pickaxe-all --pickaxe-regex -S'uncommon' <limit-rev>..   0.47(0.42+0.04)   0.47(0.45+0.01) +0.0%
    4209.33: git log -i -G'[þæö]' <limit-rev>..                                    0.60(0.54+0.05)   0.51(0.47+0.04) -15.0%
    4209.34: git log -i --pickaxe-regex -S'[þæö]' <limit-rev>..                    0.39(0.33+0.05)   0.49(0.45+0.03) +25.6%
    4209.35: git log -i --text -G'[þæö]' <limit-rev>..                             0.59(0.53+0.06)   0.51(0.47+0.02) -13.6%
    4209.36: git log -i --text --pickaxe-all -G'[þæö]' <limit-rev>..               0.62(0.56+0.05)   0.51(0.45+0.04) -17.7%
    4209.37: git log -i --pickaxe-all -G'[þæö]' <limit-rev>..                      0.61(0.55+0.06)   0.51(0.47+0.04) -16.4%
    4209.38: git log -i --pickaxe-all --pickaxe-regex -S'[þæö]' <limit-rev>..      0.42(0.39+0.02)   0.49(0.46+0.03) +16.7%

1. With these options:

    GIT_PERF_EXTRA=1 GIT_PERF_REPEAT_COUNT=10 GIT_PERF_MAKE_OPTS='-j8 USE_LIBPCRE=Y CFLAGS=-O3 LIBPCREDIR=/home/avar/g/pcre2/inst' ./run origin/next HEAD -- p4209-pickaxe.sh

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 diff.h             |   4 ++
 diffcore-pickaxe.c | 143 ++++++++++++++++++---------------------------
 2 files changed, 61 insertions(+), 86 deletions(-)

diff --git a/diff.h b/diff.h
index 2ff2b1c7f2..2f369c162b 100644
--- a/diff.h
+++ b/diff.h
@@ -365,6 +365,8 @@ struct diff_options {
 
 	struct repository *repo;
 	struct option *parseopts;
+
+	struct grep_opt *grep_filter;
 };
 
 unsigned diff_filter_bit(char status);
@@ -520,6 +522,8 @@ int git_config_rename(const char *var, const char *value);
 #define DIFF_PICKAXE_KIND_G	8 /* grep in the patch */
 #define DIFF_PICKAXE_KIND_OBJFIND	16 /* specific object IDs */
 
+#define DIFF_PICKAXE_KIND_GS_MASK (DIFF_PICKAXE_KIND_S | \
+				   DIFF_PICKAXE_KIND_G)
 #define DIFF_PICKAXE_KINDS_MASK (DIFF_PICKAXE_KIND_S | \
 				 DIFF_PICKAXE_KIND_G | \
 				 DIFF_PICKAXE_KIND_OBJFIND)
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 5161c81057..25ab1b2427 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -6,16 +6,16 @@
 #include "diff.h"
 #include "diffcore.h"
 #include "xdiff-interface.h"
-#include "kwset.h"
+#include "grep.h"
 #include "commit.h"
 #include "quote.h"
 
 typedef int (*pickaxe_fn)(mmfile_t *one, mmfile_t *two,
 			  struct diff_options *o,
-			  regex_t *regexp, kwset_t kws);
+			  struct grep_opt *grep_filter);
 
 struct diffgrep_cb {
-	regex_t *regexp;
+	struct grep_opt	*grep_filter;
 	int hit;
 };
 
@@ -23,6 +23,8 @@ static void diffgrep_consume(void *priv, char *line, unsigned long len)
 {
 	struct diffgrep_cb *data = priv;
 	regmatch_t regmatch;
+	struct grep_opt *grep_filter = data->grep_filter;
+	struct grep_pat *grep_pat = grep_filter->pattern_list;
 
 	if (line[0] != '+' && line[0] != '-')
 		return;
@@ -32,25 +34,25 @@ static void diffgrep_consume(void *priv, char *line, unsigned long len)
 		 * caller early.
 		 */
 		return;
-	data->hit = !regexec_buf(data->regexp, line + 1, len - 1, 1,
-				 &regmatch, 0);
+	data->hit = patmatch(grep_pat, line + 1, line + len + 1, &regmatch, 0);
 }
 
 static int diff_grep(mmfile_t *one, mmfile_t *two,
 		     struct diff_options *o,
-		     regex_t *regexp, kwset_t kws)
+		     struct grep_opt *grep_filter)
 {
-	regmatch_t regmatch;
 	struct diffgrep_cb ecbdata;
 	xpparam_t xpp;
 	xdemitconf_t xecfg;
+	regmatch_t regmatch;
+	struct grep_pat *grep_pat = grep_filter->pattern_list;
 
 	if (!one)
-		return !regexec_buf(regexp, two->ptr, two->size,
-				    1, &regmatch, 0);
+		return patmatch(grep_pat, two->ptr, two->ptr + two->size,
+				&regmatch, 0);
 	if (!two)
-		return !regexec_buf(regexp, one->ptr, one->size,
-				    1, &regmatch, 0);
+		return patmatch(grep_pat, one->ptr, one->ptr + one->size,
+				&regmatch, 0);
 
 	/*
 	 * We have both sides; need to run textual diff and see if
@@ -58,7 +60,7 @@ static int diff_grep(mmfile_t *one, mmfile_t *two,
 	 */
 	memset(&xpp, 0, sizeof(xpp));
 	memset(&xecfg, 0, sizeof(xecfg));
-	ecbdata.regexp = regexp;
+	ecbdata.grep_filter = grep_filter;
 	ecbdata.hit = 0;
 	xecfg.ctxlen = 0;
 	xecfg.interhunkctxlen = o->interhunkcontext;
@@ -68,52 +70,40 @@ static int diff_grep(mmfile_t *one, mmfile_t *two,
 	return ecbdata.hit;
 }
 
-static unsigned int contains(mmfile_t *mf, regex_t *regexp, kwset_t kws)
+static unsigned int contains(mmfile_t *mf, struct grep_opt *grep_filter)
 {
+
 	unsigned int cnt = 0;
 	unsigned long sz = mf->size;
-	const char *data = mf->ptr;
-
-	if (regexp) {
-		regmatch_t regmatch;
-		int flags = 0;
-
-		while (!regexec_buf(regexp, data, sz, 1, &regmatch, flags)) {
-			flags |= REG_NOTBOL;
-			data += regmatch.rm_eo;
-			sz -= regmatch.rm_eo;
-			if (regmatch.rm_so == regmatch.rm_eo) {
-				data++;
-				sz--;
-			}
-			cnt++;
-		}
-
-	} else { /* Classic exact string match */
-		while (sz) {
-			struct kwsmatch kwsm;
-			size_t offset = kwsexec(kws, data, sz, &kwsm);
-			if (offset == -1)
-				break;
-			sz -= offset + kwsm.size[0];
-			data += offset + kwsm.size[0];
-			cnt++;
+	char *data = mf->ptr;
+	regmatch_t regmatch;
+	int flags = 0;
+	struct grep_pat *grep_pat = grep_filter->pattern_list;
+
+	while (patmatch(grep_pat, data, data + sz, &regmatch, flags)) {
+		flags |= REG_NOTBOL;
+		data += regmatch.rm_eo;
+		sz -= regmatch.rm_eo;
+		if (regmatch.rm_so == regmatch.rm_eo) {
+			data++;
+			sz--;
 		}
+		cnt++;
 	}
 	return cnt;
 }
 
 static int has_changes(mmfile_t *one, mmfile_t *two,
 		       struct diff_options *o,
-		       regex_t *regexp, kwset_t kws)
+		       struct grep_opt *grep_filter)
 {
-	unsigned int one_contains = one ? contains(one, regexp, kws) : 0;
-	unsigned int two_contains = two ? contains(two, regexp, kws) : 0;
+	unsigned int one_contains = one ? contains(one, grep_filter) : 0;
+	unsigned int two_contains = two ? contains(two, grep_filter) : 0;
 	return one_contains != two_contains;
 }
 
 static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
-			 regex_t *regexp, kwset_t kws, pickaxe_fn fn)
+			 struct grep_opt *grep_filter, pickaxe_fn fn)
 {
 	struct userdiff_driver *textconv_one = NULL;
 	struct userdiff_driver *textconv_two = NULL;
@@ -160,7 +150,7 @@ static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
 
 	ret = fn(DIFF_FILE_VALID(p->one) ? &mf1 : NULL,
 		 DIFF_FILE_VALID(p->two) ? &mf2 : NULL,
-		 o, regexp, kws);
+		 o, grep_filter);
 
 	if (textconv_one)
 		free(mf1.ptr);
@@ -173,7 +163,7 @@ static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
 }
 
 static void pickaxe(struct diff_queue_struct *q, struct diff_options *o,
-		    regex_t *regexp, kwset_t kws, pickaxe_fn fn)
+		    struct grep_opt *grep_filter, pickaxe_fn fn)
 {
 	int i;
 	struct diff_queue_struct outq;
@@ -184,7 +174,7 @@ static void pickaxe(struct diff_queue_struct *q, struct diff_options *o,
 		/* Showing the whole changeset if needle exists */
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
-			if (pickaxe_match(p, o, regexp, kws, fn))
+			if (pickaxe_match(p, o, grep_filter, fn))
 				return; /* do not munge the queue */
 		}
 
@@ -199,7 +189,7 @@ static void pickaxe(struct diff_queue_struct *q, struct diff_options *o,
 		/* Showing only the filepairs that has the needle */
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
-			if (pickaxe_match(p, o, regexp, kws, fn))
+			if (pickaxe_match(p, o, grep_filter, fn))
 				diff_q(&outq, p);
 			else
 				diff_free_filepair(p);
@@ -210,54 +200,35 @@ static void pickaxe(struct diff_queue_struct *q, struct diff_options *o,
 	*q = outq;
 }
 
-static void regcomp_or_die(regex_t *regex, const char *needle, int cflags)
-{
-	int err = regcomp(regex, needle, cflags);
-	if (err) {
-		/* The POSIX.2 people are surely sick */
-		char errbuf[1024];
-		regerror(err, regex, errbuf, 1024);
-		die("invalid regex: %s", errbuf);
-	}
-}
-
 void diffcore_pickaxe(struct diff_options *o)
 {
 	const char *needle = o->pickaxe;
 	int opts = o->pickaxe_opts;
-	regex_t regex, *regexp = NULL;
-	kwset_t kws = NULL;
+	struct grep_opt opt;
+
+	if (opts & (DIFF_PICKAXE_REGEX | DIFF_PICKAXE_KIND_GS_MASK)) {
+		grep_init(&opt, the_repository, NULL);
+#ifdef USE_LIBPCRE2
+		grep_commit_pattern_type(GREP_PATTERN_TYPE_PCRE, &opt);
+#else
+		grep_commit_pattern_type(GREP_PATTERN_TYPE_ERE, &opt);
+#endif
 
-	if (opts & (DIFF_PICKAXE_REGEX | DIFF_PICKAXE_KIND_G)) {
-		int cflags = REG_EXTENDED | REG_NEWLINE;
 		if (o->pickaxe_opts & DIFF_PICKAXE_IGNORE_CASE)
-			cflags |= REG_ICASE;
-		regcomp_or_die(&regex, needle, cflags);
-		regexp = &regex;
-	} else if (opts & DIFF_PICKAXE_KIND_S) {
-		if (o->pickaxe_opts & DIFF_PICKAXE_IGNORE_CASE &&
-		    has_non_ascii(needle)) {
-			struct strbuf sb = STRBUF_INIT;
-			int cflags = REG_NEWLINE | REG_ICASE;
-
-			basic_regex_quote_buf(&sb, needle);
-			regcomp_or_die(&regex, sb.buf, cflags);
-			strbuf_release(&sb);
-			regexp = &regex;
-		} else {
-			kws = kwsalloc(o->pickaxe_opts & DIFF_PICKAXE_IGNORE_CASE
-				       ? tolower_trans_tbl : NULL);
-			kwsincr(kws, needle, strlen(needle));
-			kwsprep(kws);
-		}
+			opt.ignore_case = 1;
+		if (opts & DIFF_PICKAXE_KIND_S &&
+		    !(opts & DIFF_PICKAXE_REGEX))
+			opt.fixed = 1;
+
+		append_grep_pattern(&opt, needle, "diffcore-pickaxe", 0, GREP_PATTERN);
+		compile_grep_patterns(&opt);
 	}
 
-	pickaxe(&diff_queued_diff, o, regexp, kws,
+	pickaxe(&diff_queued_diff, o, &opt,
 		(opts & DIFF_PICKAXE_KIND_G) ? diff_grep : has_changes);
 
-	if (regexp)
-		regfree(regexp);
-	if (kws)
-		kwsfree(kws);
+	if (opts & ~DIFF_PICKAXE_KIND_OBJFIND)
+		free_grep_patterns(&opt);
+
 	return;
 }
-- 
2.30.0.284.gd98b1dd5eaa7

