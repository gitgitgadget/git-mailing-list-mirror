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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC60C4320E
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 15:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6B9C60EE5
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 15:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241872AbhHEPIJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 11:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241795AbhHEPH7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 11:07:59 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74698C0617A2
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 08:07:44 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d8so7011191wrm.4
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 08:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Aybp8La8P+K9uxY6PEDr5NxTP9FXf57JA1TNG5/mSjI=;
        b=o/4z2/kLl8nf6oV6xQT7GL1XKZIgn/VjlDCynf1TzyjsYMiEcQsMQ0cqGeg4vdzmLO
         xmNfBii6FOSRuuN4kI27blGmPhe6mc1wU3EGKNixAXbGRRPOaDBUbT39V8aLDdlGuDde
         1iAWSsMuYK+BmLSQJ5h7A/I4NkfrQh/gid5aleq5A3d0yrJLFkIWQHG2DXThLQ2QY8/B
         BDF7qTQrC31/CpnauJMObP5LEsrxmnVpvGT0BkWYvsSnCxKASAittQBZyTxS2yi6KL/a
         EFxjTST9wD+GlS3F3mufjSaVdtwHTPurfslNctJHAnNIiaL/wPA/xK2J0/u+2VCn2Wgs
         9Npw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Aybp8La8P+K9uxY6PEDr5NxTP9FXf57JA1TNG5/mSjI=;
        b=n3n110j9gn0903NWaeTxjRw1rprN+WnNCTIjsmIBqlha56CTWxMZ3twCkwsbB+h4xh
         7hCeyv1DxAJI630e7Rs+dJ3/X/B8VG//eUPkKq8spBj50rNJwf4y8TUlnx7WH73Orzxb
         vHr1r+Q/L3NdDnnPcjYagHq4BN4y9aFbwhRoRnjrpCNYDUIyHDujwNjmdCQy0qGzlOpV
         ZJZCUpUXf9GPZLPfhicPUou/IrZJfEbp/n1plL56WQLFM9su78HbYrjvsp8JZsi8kgc8
         n6chC/fEWajuyuDlX71c53ZdBwQKNGxguCcM0I//yX0qkQu4hxshDsLQje4sEFbf+I5t
         Qc0w==
X-Gm-Message-State: AOAM530MMtJRfZPPJVCt24D8cPd6qEj9GqFr9QJUGl07Mm6mW2HzubUU
        mqGXkUpggUuWyro6cX7G06AbSTfum2uBMA==
X-Google-Smtp-Source: ABdhPJyzpvjzlyMgbDXiOY0wSS0kz0ISKuVruf4OvuZbC6yv5VKqUlpxohzkNymqtWw/83SzlpVihg==
X-Received: by 2002:adf:fe89:: with SMTP id l9mr6010423wrr.396.1628176062824;
        Thu, 05 Aug 2021 08:07:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w4sm6856340wrm.24.2021.08.05.08.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 08:07:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 08/13] bundle.h: make "fd" version of read_bundle_header() public
Date:   Thu,  5 Aug 2021 17:07:24 +0200
Message-Id: <RFC-patch-08.13-c9700e66d9-20210805T150534Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.646.g585563e77f
In-Reply-To: <RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com>
References: <RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the parse_bundle_header() function to be non-static, and rename
it to parse_bundle_header_fd(). The parse_bundle_header() function is
already public, and it's a thin wrapper around this function. This
will be used by code that wants to pass a fd to the bundle API.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 bundle.c | 8 ++++----
 bundle.h | 2 ++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/bundle.c b/bundle.c
index ab63f40226..f3a87308cf 100644
--- a/bundle.c
+++ b/bundle.c
@@ -61,8 +61,8 @@ static int parse_bundle_signature(struct bundle_header *header, const char *line
 	return -1;
 }
 
-static int parse_bundle_header(int fd, struct bundle_header *header,
-			       const char *report_path)
+int read_bundle_header_fd(int fd, struct bundle_header *header,
+			  const char *report_path)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int status = 0;
@@ -138,7 +138,7 @@ int read_bundle_header(const char *path, struct bundle_header *header)
 
 	if (fd < 0)
 		return error(_("could not open '%s'"), path);
-	return parse_bundle_header(fd, header, path);
+	return read_bundle_header_fd(fd, header, path);
 }
 
 int is_bundle(const char *path, int quiet)
@@ -148,7 +148,7 @@ int is_bundle(const char *path, int quiet)
 
 	if (fd < 0)
 		return 0;
-	fd = parse_bundle_header(fd, &header, quiet ? NULL : path);
+	fd = read_bundle_header_fd(fd, &header, quiet ? NULL : path);
 	if (fd >= 0)
 		close(fd);
 	bundle_header_release(&header);
diff --git a/bundle.h b/bundle.h
index 1927d8cd6a..8adf0e7393 100644
--- a/bundle.h
+++ b/bundle.h
@@ -22,6 +22,8 @@ void bundle_header_release(struct bundle_header *header);
 
 int is_bundle(const char *path, int quiet);
 int read_bundle_header(const char *path, struct bundle_header *header);
+int read_bundle_header_fd(int fd, struct bundle_header *header,
+			  const char *report_path);
 int create_bundle(struct repository *r, const char *path,
 		  int argc, const char **argv, struct strvec *pack_options,
 		  int version);
-- 
2.33.0.rc0.646.g585563e77f

