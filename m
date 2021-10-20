Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C890DC433F5
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 13:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B41066134F
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 13:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhJTN1D (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 09:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhJTN07 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 09:26:59 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02026C061753
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 06:24:44 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id b189-20020a1c1bc6000000b0030da052dd4fso10241327wmb.3
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 06:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FOrypeBWeRFbhhIaVzych6YWS0VZktygxcW2Snudt+c=;
        b=JU+dg2ikAqBAH+S0IrnY+wUIevL7MXFLf6b3wkfnO1IzUDVzfDgjqsy+3qJEsoPdGz
         Qjow+Suz+f4e92CTbfuPtFQJOURHHiqN0NaR/6cKtKvae2No1/OOjF4g3PzKus6FTqGG
         hLYXIeFwvDoQqI5i7zCI0U0kNut37ihjSYQZcYoomxx+YDpR7y+wiSdP7ObArrbiGe5b
         VS5eBj7lyJGFftpfGaz8hgbhQqbd3Uiu9Nd6gXgvQbMgsamR9fZNQq6810UQEHXcre4p
         k1ZhV8Sf0H3C2GkckE0lkGrrJztFNJ2X4qaf1AZT95jLKGwzRLzPeHvqBQBl/BbtxBj5
         yysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FOrypeBWeRFbhhIaVzych6YWS0VZktygxcW2Snudt+c=;
        b=kh52bQbS4NpMxGUWLDkbF2YHgur7yYYrleug/gzgeVwBaB9ODPUoJNZBtfRPu4wy5Q
         Vcp5PIO6R1Y5jrBXehhh0dgZdNy1cSBc52YgM+R3eqb9d2PPtWFzy6dHmu6GX4WQ/tA6
         /s4A2x7YVk/FIJ3OTsA7Yf2ILKhdE3EzCbFqNzgU39QmR5ZoOHnX8ad+DSfScX/IL5Rg
         ttLsxZIRvsh0cbws37LQrgEm0zAsfyxj6mDZG8gzg5cP3cu+K8JWYf0nEwrOTbGi0E3z
         aly7Q+tR1miamjzVTnaekf3j0721URDf4buETbkIiM8zITCrhcZ8ueYL+s41x4/eVp0Q
         bqUA==
X-Gm-Message-State: AOAM532GI+7V5t1FJSzBc85lZUagA0r58dCX8p9O5qxa+AEogx8aD1yC
        4CR4n8rp6Qul+6bjtTBlBaglxG0Fte7HTQ==
X-Google-Smtp-Source: ABdhPJxExCiR3DBDn22kPZX+rSGVCIwuWrMpB4UqF32L6WT4XXMlIbTqHnggRr24U5H4DGC5Oh327Q==
X-Received: by 2002:a05:600c:3b11:: with SMTP id m17mr14039755wms.157.1634736283286;
        Wed, 20 Oct 2021 06:24:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k17sm5933351wmj.0.2021.10.20.06.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 06:24:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v2 2/4] ref-filter API user: add and use a ref_sorting_release()
Date:   Wed, 20 Oct 2021 15:24:34 +0200
Message-Id: <RFC-patch-v2-2.4-0ae71c19ab7-20211020T131627Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <RFC-cover-v2-0.4-00000000000-20211020T131627Z-avarab@gmail.com>
References: <211020.864k9boo0f.gmgdl@evledraar.gmail.com> <RFC-cover-v2-0.4-00000000000-20211020T131627Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a ref_sorting_release() and use it for some of the current API
users, the ref_sorting_default() function and its siblings will do a
malloc() which wasn't being free'd previously.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/for-each-ref.c | 2 +-
 builtin/tag.c          | 1 +
 ref-filter.c           | 8 ++++++++
 ref-filter.h           | 2 ++
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 642b4b888fb..16a2c7d57ca 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -96,6 +96,6 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	ref_array_clear(&array);
 	free_commit_list(filter.with_commit);
 	free_commit_list(filter.no_commit);
-	UNLEAK(sorting);
+	ref_sorting_release(sorting);
 	return 0;
 }
diff --git a/builtin/tag.c b/builtin/tag.c
index ad6c9855914..6fe646710d6 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -630,6 +630,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		       find_unique_abbrev(&prev, DEFAULT_ABBREV));
 
 cleanup:
+	ref_sorting_release(sorting);
 	strbuf_release(&buf);
 	strbuf_release(&ref);
 	strbuf_release(&reflog_msg);
diff --git a/ref-filter.c b/ref-filter.c
index add429be797..bdf8b0725df 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2705,6 +2705,14 @@ int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+void ref_sorting_release(struct ref_sorting *sorting)
+{
+	struct ref_sorting *next = sorting->next;
+	if (next)
+	       ref_sorting_release(next);
+	free(sorting);
+}
+
 int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset)
 {
 	struct ref_filter *rf = opt->value;
diff --git a/ref-filter.h b/ref-filter.h
index b636f4389d0..6228458d306 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -127,6 +127,8 @@ void parse_ref_sorting(struct ref_sorting **sorting_tail, const char *atom);
 int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset);
 /*  Default sort option based on refname */
 struct ref_sorting *ref_default_sorting(void);
+/* Release a "struct ref_sorting" */
+void ref_sorting_release(struct ref_sorting *);
 /*  Function to parse --merged and --no-merged options */
 int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset);
 /*  Get the current HEAD's description */
-- 
2.33.1.1338.g20da966911a

