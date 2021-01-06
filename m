Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B80C433DB
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 10:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A04E2310E
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 10:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbhAFKCr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 05:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbhAFKCq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 05:02:46 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681EDC061358
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 02:02:06 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 3so2099361wmg.4
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 02:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hGmN/EzxG9m+CuQaV6gA8RjLoDPHyMsVKmg5+yWbpvI=;
        b=f0uXxGLwiWcy1YbrQghIZGjrSo54QqgHdpe81lGvWV4TCjTEOdtZJfGObLW2ZIdlAM
         0B6U1dAh32dn0bhCWX+dShKm6gRk0zSch62u+vYaY/cZdGvKuOhX+2CtuCURgf0rUrMz
         JAGQQuxi7mgfJ6dCzlDxuNs5enZO8PqFYXIey7I1I3K+YgNQYZs0IH+Q8fdSDgna18ha
         IfD6FbbBYBjbFY0XycXqGFKDrL5oEKmoioabUpnBOWqjwHxz4znlx30xMo4CgnEFQ/MH
         YrG+zBST8ImajVw0WM4NFRKrbl9WqCPPXFEV6zXwugZ2SVzRLF6XQU0ERWbgyTqZ4F35
         WHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hGmN/EzxG9m+CuQaV6gA8RjLoDPHyMsVKmg5+yWbpvI=;
        b=hB0jIzxavFgG/RTAPnbXTitckNDW513GNpALVAJZIlwjm4eezn5mY3mBpwcSKQzmTM
         xI+Q+lPBDl79btQyuNdyBghHhLgMjobaQwwo68BwfJx243HcPuLK/dc464iBjyAC1zm7
         xqnXEGk38Gn5FX+SwXZ6xsz7u9+5oQ0/vnGPoRiJyc/mdFN+aeGW78UAVm+M6W9dcV/q
         v4c+jx3kOjWpH2xF+z4Y9lYYaa+pXvmWDIYmlOLQnhcYqvXx9fkIZQPmhb8gNjxsQ8kL
         DmZ8+yfs+WT1UUvaTzj06nTZa2ID2yYGK+f3myQf9EStRWdLoI/e7sic4sWCY79R/Xxo
         Uegw==
X-Gm-Message-State: AOAM533heOkSi57drUh/a3Hqum93CVD5Zq8g8GsmRuLp11T53PM4vuni
        iopwp1FdjzVw+uRZLRWUB4x5GROhBE1ZSg==
X-Google-Smtp-Source: ABdhPJxTKpBAjtH6DM6YOYVHTTJMBq7sAygNOOGjpibYYoXopCKLzy7MSk81Na9nOsHkIzBLEP+rVQ==
X-Received: by 2002:a05:600c:2057:: with SMTP id p23mr2923862wmg.109.1609927324843;
        Wed, 06 Jan 2021 02:02:04 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r13sm2538637wrs.6.2021.01.06.02.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 02:02:03 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthew DeVore <matvore@google.com>, git@matthieu-moy.fr,
        olyatelezhnaya@gmail.com, samuel.maftoul@gmail.com,
        Johannes.Schindelin@gmx.de, karthik.188@gmail.com,
        pclouds@gmail.com, sunshine@sunshineco.com,
        emilyshaffer@google.com, jrnieder@gmail.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/5] ref-filter: add a "detached_head_first" sorting option
Date:   Wed,  6 Jan 2021 11:01:37 +0100
Message-Id: <20210106100139.14651-4-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <9bd85516f91c3e2fdefdafd51df71f75603e51f6.1560895672.git.matvore@google.com>
References: <9bd85516f91c3e2fdefdafd51df71f75603e51f6.1560895672.git.matvore@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a "detached_head_first" sorting option for eventual use by the
"git branch" command. When listing branches we want to list the
detached HEAD "ref" at the start of the list. As shown in
28438e84e04 (ref-filter: sort detached HEAD lines firstly, 2019-06-18)
this currently relies on "(" sorting before any other refname by
strcmp().

This boxes translators into using ASCII parentheses, a subsequent
commit will amend get_head_description() to get rid of this
limitation.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ref-filter.c | 23 ++++++++++++++++++++++-
 ref-filter.h |  3 +++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index aa260bfd099..94ab3f86a53 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2350,6 +2350,16 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 	return ret;
 }
 
+static int compare_detached_head(struct ref_array_item *a, struct ref_array_item *b)
+{
+	if (a->kind & FILTER_REFS_DETACHED_HEAD)
+		return -1;
+	else if (b->kind & FILTER_REFS_DETACHED_HEAD)
+		return 1;
+	BUG("compare_detached_head() is guarded by an xor on [ab]->kind & FILTER_REFS_DETACHED_HEAD");
+	return 0;
+}
+
 static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, struct ref_array_item *b)
 {
 	struct atom_value *va, *vb;
@@ -2364,7 +2374,12 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
 		die("%s", err.buf);
 	strbuf_release(&err);
 	cmp_fn = s->ignore_case ? strcasecmp : strcmp;
-	if (s->version)
+	if (s->detached_head_first &&
+	    ((a->kind & FILTER_REFS_DETACHED_HEAD)
+	     ^
+	     (b->kind & FILTER_REFS_DETACHED_HEAD))) {
+		cmp = compare_detached_head(a, b);
+	} else if (s->version)
 		cmp = versioncmp(va->s, vb->s);
 	else if (cmp_type == FIELD_STR)
 		cmp = cmp_fn(va->s, vb->s);
@@ -2403,6 +2418,12 @@ void ref_sorting_icase_all(struct ref_sorting *sorting, int flag)
 		sorting->ignore_case = !!flag;
 }
 
+void ref_sorting_detached_head_first_all(struct ref_sorting *sorting, int flag)
+{
+	for (; sorting; sorting = sorting->next)
+		sorting->detached_head_first = !!flag;
+}
+
 void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
 {
 	QSORT_S(array->items, array->nr, compare_refs, sorting);
diff --git a/ref-filter.h b/ref-filter.h
index feaef4a8fde..3b92e0f2696 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -30,6 +30,7 @@ struct ref_sorting {
 	int atom; /* index into used_atom array (internal) */
 	unsigned reverse : 1,
 		ignore_case : 1,
+		detached_head_first : 1,
 		version : 1;
 };
 
@@ -111,6 +112,8 @@ int verify_ref_format(struct ref_format *format);
 void ref_array_sort(struct ref_sorting *sort, struct ref_array *array);
 /*  Set the ignore_case flag for all elements of a sorting list */
 void ref_sorting_icase_all(struct ref_sorting *sorting, int flag);
+/*  Set the detached_head_first flag for all elements of a sorting list */
+void ref_sorting_detached_head_first_all(struct ref_sorting *sorting, int flag);
 /*  Based on the given format and quote_style, fill the strbuf */
 int format_ref_array_item(struct ref_array_item *info,
 			  const struct ref_format *format,
-- 
2.29.2.222.g5d2a92d10f8

