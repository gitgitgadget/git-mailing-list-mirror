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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547B9C433E6
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 10:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 172FD2310B
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 10:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbhAFKDS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 05:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbhAFKDR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 05:03:17 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8FDC06135A
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 02:02:08 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id q18so1896269wrn.1
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 02:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ise7IwhiQmdjtggtvUjYapk4t3iV1wfOXWWgoQ8mDc0=;
        b=EbOAK5hOGHnOJ63gLBWyQ+746DLrJqfmSR848PBonyvgny64+VZ2IVfa/M7VXh+C0G
         tFPh3nwCMysYXOjEY9BHkjn0JdonYLoS+XrcrHM810H7ewZZZSjYJ79hDmQ08PVMAPU2
         FITKi+6Nmj58Qh4WlhjREV2sjTV8jC1Z9tFwt0WtRSGzkXJ0ed+cfD2+JMTQ1uY5fK+9
         4RCWKv1CfRsAV43pVwfbTufF56qz40hTUBe4wITz/oiWQ0jyajeQMZQA/DGBBALuE9aE
         EGR2jw2kISKFObEN8VAUrXWDY4GkY6Y+d7thVia9OoX1razqU+tnr4JntEyprSr48TWf
         YjPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ise7IwhiQmdjtggtvUjYapk4t3iV1wfOXWWgoQ8mDc0=;
        b=cWgheDeTgBMtckQzP8qi7LoKLQAPtf4FyqjLuzzjhaSnfWbuFX8R1l5gOdNf1LYXlO
         vlpKjKp4TosEHn8v+2PEmH+xY8Q317TecPbDUmbSy8jae2j6RtCdO1/lGAAZHU32Kbgb
         QVGS9lTAH/ddjqR7llnjq944aDvkjSzl1D0U+FOSaqVr1fi1nRiJzfRgC64PByeG8kV4
         YDkcbBMWP4XsWby5c7YcFisXb5UHNkUhcSXR9STNIdbgvhgE/e9/ZbXbz+BB11Lyg3CT
         3ScupwRtPnAa9BCL2885oDHSayTiVykevlNjsW0w4tUMe84990QkBlZHrxn3qa45+HkB
         PK6A==
X-Gm-Message-State: AOAM5320A9KY8HgU5nwxtqogd/IglehnQWzOz3hb4fOJtbyHE2SS3ynb
        ciuoxM/f2bp+SpdcWocjEcIpEhZKUW8JgQ==
X-Google-Smtp-Source: ABdhPJyqKhWjr5oZk3vMGGzbXKmRESRUvqaRP5FdBfN9MRYLB6TOOQEgxvLtaepvF18aY9j3iODIXw==
X-Received: by 2002:adf:c6c4:: with SMTP id c4mr3598207wrh.348.1609927327331;
        Wed, 06 Jan 2021 02:02:07 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r13sm2538637wrs.6.2021.01.06.02.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 02:02:06 -0800 (PST)
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
Subject: [PATCH 5/5] branch: show "HEAD detached" first under reverse sort
Date:   Wed,  6 Jan 2021 11:01:39 +0100
Message-Id: <20210106100139.14651-6-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <9bd85516f91c3e2fdefdafd51df71f75603e51f6.1560895672.git.matvore@google.com>
References: <9bd85516f91c3e2fdefdafd51df71f75603e51f6.1560895672.git.matvore@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the output of the likes of "git branch -l --sort=-objectsize"
to show the "(HEAD detached at <hash>)" message at the start of the
output. Before the compare_detached_head() function added in a
preceding commit we'd emit this output as an emergent effect.

It doesn't make any sense to consider the objectsize, type or other
non-attribute of the "(HEAD detached at <hash>)" message for the
purposes of sorting. Let's always emit it at the top instead. The only
reason it was sorted in the first place is because we're injecting it
into the ref-filter machinery so builtin/branch.c doesn't need to do
its own "am I detached?" detection.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ref-filter.c             | 4 +++-
 t/t3203-branch-output.sh | 6 +++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 7e0289cb659..5bbdc46c1f9 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2355,6 +2355,7 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
 {
 	struct atom_value *va, *vb;
 	int cmp;
+	int cmp_detached_head = 0;
 	cmp_type cmp_type = used_atom[s->atom].type;
 	int (*cmp_fn)(const char *, const char *);
 	struct strbuf err = STRBUF_INIT;
@@ -2370,6 +2371,7 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
 	     ^
 	     (b->kind & FILTER_REFS_DETACHED_HEAD))) {
 		cmp = compare_detached_head(a, b);
+		cmp_detached_head = 1;
 	} else if (s->version)
 		cmp = versioncmp(va->s, vb->s);
 	else if (cmp_type == FIELD_STR)
@@ -2383,7 +2385,7 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
 			cmp = 1;
 	}
 
-	return (s->reverse) ? -cmp : cmp;
+	return (s->reverse && !cmp_detached_head) ? -cmp : cmp;
 }
 
 static int compare_refs(const void *a_, const void *b_, void *ref_sorting)
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 8f53b081365..5e0577d5c7f 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -221,10 +221,10 @@ test_expect_success 'git branch `--sort=[-]objectsize` option' '
 	test_i18ncmp expect actual &&
 
 	cat >expect <<-\EOF &&
+	* (HEAD detached from fromtag)
 	  branch-one
 	  main
 	  branch-two
-	* (HEAD detached from fromtag)
 	EOF
 	git branch --sort=-objectsize >actual &&
 	test_i18ncmp expect actual
@@ -241,10 +241,10 @@ test_expect_success 'git branch `--sort=[-]type` option' '
 	test_i18ncmp expect actual &&
 
 	cat >expect <<-\EOF &&
+	* (HEAD detached from fromtag)
 	  branch-one
 	  branch-two
 	  main
-	* (HEAD detached from fromtag)
 	EOF
 	git branch --sort=-type >actual &&
 	test_i18ncmp expect actual
@@ -261,10 +261,10 @@ test_expect_success 'git branch `--sort=[-]version:refname` option' '
 	test_i18ncmp expect actual &&
 
 	cat >expect <<-\EOF &&
+	* (HEAD detached from fromtag)
 	  main
 	  branch-two
 	  branch-one
-	* (HEAD detached from fromtag)
 	EOF
 	git branch --sort=-version:refname >actual &&
 	test_i18ncmp expect actual
-- 
2.29.2.222.g5d2a92d10f8

