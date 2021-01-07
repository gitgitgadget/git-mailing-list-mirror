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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C08C433E9
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 09:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF5B0217A0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 09:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbhAGJxe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 04:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbhAGJxd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 04:53:33 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D2DC0612FA
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 01:52:19 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id q75so4984868wme.2
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 01:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4o2/u2lXkOH0h/RF/TJKUIGB3WnODBhX0AArxrztVbQ=;
        b=aF62soTqaP4vgqkZmml8+5r5ydvVpek3+kp9Yci0ZPQbSuz9B4zSaE4OFJYkDeSIL2
         sTIeNa2c5ffeFloHB3mp8Pq7R7sAqxjC0d00rLEAJaG5QI3tPyJMG7V4aTAJzj6yXOp2
         QngZDY8dojL+uk4ocSf3ESCHWqceHrfH6S/ngW7dHxYlM6HjEsmkGMcjbjDioEsF0kSJ
         J+m+NBSkFdhXd9WuMaapG5CO9iTaT2phNJ3n5zewzd3j9LdMLxLg1V36Vrs3ZhRcJouD
         M8KVZ6tOKiI98IL9iGasm6bbxcsMjiK6PneEwYeaDZyNynnoVOmnMp/iawdk2vWK7TC9
         mGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4o2/u2lXkOH0h/RF/TJKUIGB3WnODBhX0AArxrztVbQ=;
        b=tiLxp8kfkHqvLVQPzovh6W89QAmWdwPbRfFrunpcWiEcqeE6hWqI83Lc+Har+gX0lh
         GD3lM8EtBn7WUsVCXDua0R27QfATOnYA2EyjP9zcJBIO/7kz21Ne8i3eNjt1t3wtth16
         u8FJKmN+vvfPn2f4elpYYTkW54x/PmgKc7MworQcXgaEPo8eWaJzOEAl4cFBiwMdGLzl
         jwg+imenJN9p72uyK866dikBiQBj3WC202AZnFyVOicDZ6MAQcr71YP8Qe9VMqzuOGjQ
         R4IHwTT2if7jwjPnyP1/L21V8Tu7JW7emDXTLvNjLc4R9WvVI8vz92/kQfxEjJUEzJsO
         /vlA==
X-Gm-Message-State: AOAM533tBMArR3X1cE4IX7uvWlABRUfZKtsdLnbpufl7SqMmSGbpZUWL
        sC1T8Df4BNvasJ4mnnwIspOJYWGsxOqJiw==
X-Google-Smtp-Source: ABdhPJxmEHigWPlIJ1qoZPI0PAmDm91Wi4zbM/Gu+LkzLFpiccMUbwHw033BgRweEXJ1CNF9YapY7A==
X-Received: by 2002:a7b:c385:: with SMTP id s5mr7208464wmj.170.1610013137431;
        Thu, 07 Jan 2021 01:52:17 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k10sm6806535wrq.38.2021.01.07.01.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 01:52:16 -0800 (PST)
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
Subject: [PATCH v2 5/7] ref-filter: move ref_sorting flags to a bitfield
Date:   Thu,  7 Jan 2021 10:51:51 +0100
Message-Id: <20210107095153.4753-6-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210106100139.14651-1-avarab@gmail.com>
References: <20210106100139.14651-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the reverse/ignore_case/version sort flags in the ref_sorting
struct into a bitfield. Having three of them was already a bit
unwieldy, but it would be even more so if another flag needed a
function like ref_sorting_icase_all() introduced in
76f9e569adb (ref-filter: apply --ignore-case to all sorting keys,
2020-05-03).

A follow-up change will introduce such a flag, so let's move this over
to a bitfield. Instead of using the usual '#define' pattern I'm using
the "enum" pattern from builtin/rebase.c's b4c8eb024af (builtin
rebase: support --quiet, 2018-09-04).

Perhaps there's a more idiomatic way of doing the "for each in list
amend mask" pattern than this "mask/on" variable combo. This function
doesn't allow us to e.g. do any arbitrary changes to the bitfield for
multiple flags, but I think in this case that's fine. The common case
is that we're calling this with a list of one.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/branch.c       |  2 +-
 builtin/for-each-ref.c |  2 +-
 builtin/tag.c          |  2 +-
 ref-filter.c           | 24 +++++++++++++++---------
 ref-filter.h           | 12 +++++++-----
 5 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 045866a51ae..2dd51a8653b 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -739,7 +739,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		 */
 		if (!sorting)
 			sorting = ref_default_sorting();
-		ref_sorting_icase_all(sorting, icase);
+		ref_sorting_set_sort_flags_all(sorting, REF_SORTING_ICASE, icase);
 		print_ref_list(&filter, sorting, &format);
 		print_columns(&output, colopts, NULL);
 		string_list_clear(&output, 0);
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 9d1ecda2b8f..cb9c81a0460 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -70,7 +70,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 
 	if (!sorting)
 		sorting = ref_default_sorting();
-	ref_sorting_icase_all(sorting, icase);
+	ref_sorting_set_sort_flags_all(sorting, REF_SORTING_ICASE, icase);
 	filter.ignore_case = icase;
 
 	filter.name_patterns = argv;
diff --git a/builtin/tag.c b/builtin/tag.c
index ecf011776dc..24d35b746d1 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -485,7 +485,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	}
 	if (!sorting)
 		sorting = ref_default_sorting();
-	ref_sorting_icase_all(sorting, icase);
+	ref_sorting_set_sort_flags_all(sorting, REF_SORTING_ICASE, icase);
 	filter.ignore_case = icase;
 	if (cmdmode == 'l') {
 		int ret;
diff --git a/ref-filter.c b/ref-filter.c
index 8882128cd3e..fe587afb80b 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2362,11 +2362,12 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
 	if (get_ref_atom_value(b, s->atom, &vb, &err))
 		die("%s", err.buf);
 	strbuf_release(&err);
-	if (s->version) {
+	if (s->sort_flags & REF_SORTING_VERSION) {
 		cmp = versioncmp(va->s, vb->s);
 	} else if (cmp_type == FIELD_STR) {
 		int (*cmp_fn)(const char *, const char *);
-		cmp_fn = s->ignore_case ? strcasecmp : strcmp;
+		cmp_fn = s->sort_flags & REF_SORTING_ICASE
+			? strcasecmp : strcmp;
 		cmp = cmp_fn(va->s, vb->s);
 	} else {
 		if (va->value < vb->value)
@@ -2377,7 +2378,7 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
 			cmp = 1;
 	}
 
-	return (s->reverse) ? -cmp : cmp;
+	return (s->sort_flags & REF_SORTING_REVERSE) ? -cmp : cmp;
 }
 
 static int compare_refs(const void *a_, const void *b_, void *ref_sorting)
@@ -2392,15 +2393,20 @@ static int compare_refs(const void *a_, const void *b_, void *ref_sorting)
 			return cmp;
 	}
 	s = ref_sorting;
-	return s && s->ignore_case ?
+	return s && s->sort_flags & REF_SORTING_ICASE ?
 		strcasecmp(a->refname, b->refname) :
 		strcmp(a->refname, b->refname);
 }
 
-void ref_sorting_icase_all(struct ref_sorting *sorting, int flag)
+void ref_sorting_set_sort_flags_all(struct ref_sorting *sorting,
+				    unsigned int mask, int on)
 {
-	for (; sorting; sorting = sorting->next)
-		sorting->ignore_case = !!flag;
+	for (; sorting; sorting = sorting->next) {
+		if (on)
+			sorting->sort_flags |= mask;
+		else
+			sorting->sort_flags &= ~mask;
+	}
 }
 
 void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
@@ -2537,12 +2543,12 @@ void parse_ref_sorting(struct ref_sorting **sorting_tail, const char *arg)
 	*sorting_tail = s;
 
 	if (*arg == '-') {
-		s->reverse = 1;
+		s->sort_flags |= REF_SORTING_REVERSE;
 		arg++;
 	}
 	if (skip_prefix(arg, "version:", &arg) ||
 	    skip_prefix(arg, "v:", &arg))
-		s->version = 1;
+		s->sort_flags |= REF_SORTING_VERSION;
 	s->atom = parse_sorting_atom(arg);
 }
 
diff --git a/ref-filter.h b/ref-filter.h
index feaef4a8fde..6296ae8bb27 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -28,9 +28,11 @@ struct atom_value;
 struct ref_sorting {
 	struct ref_sorting *next;
 	int atom; /* index into used_atom array (internal) */
-	unsigned reverse : 1,
-		ignore_case : 1,
-		version : 1;
+	enum {
+		REF_SORTING_REVERSE = 1<<0,
+		REF_SORTING_ICASE = 1<<1,
+		REF_SORTING_VERSION = 1<<2,
+	} sort_flags;
 };
 
 struct ref_array_item {
@@ -109,8 +111,8 @@ void ref_array_clear(struct ref_array *array);
 int verify_ref_format(struct ref_format *format);
 /*  Sort the given ref_array as per the ref_sorting provided */
 void ref_array_sort(struct ref_sorting *sort, struct ref_array *array);
-/*  Set the ignore_case flag for all elements of a sorting list */
-void ref_sorting_icase_all(struct ref_sorting *sorting, int flag);
+/*  Set REF_SORTING_* sort_flags for all elements of a sorting list */
+void ref_sorting_set_sort_flags_all(struct ref_sorting *sorting, unsigned int mask, int on);
 /*  Based on the given format and quote_style, fill the strbuf */
 int format_ref_array_item(struct ref_array_item *info,
 			  const struct ref_format *format,
-- 
2.29.2.222.g5d2a92d10f8

