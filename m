Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82668C433F5
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 16:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350312AbiCKQ0H (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 11:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350286AbiCKQZs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 11:25:48 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4563A1111B3
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 08:24:43 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id p9so13672495wra.12
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 08:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zUn1DOy5hTmWrJr4clO+wC+LjiT/FpKMP8Ap2nd5Sr4=;
        b=W2WiINqxDELYfNvpWDGL5zVdfJJpKjfSI+alBr28r0TKdLFGQ/IgII6hI5TlKwA7gq
         DYQEDhzqVMTC8qo9K9z5nqArPaQXlV3hsWAfubF4a/+GurGOmFqZJzxF/1zcnU/qAw5m
         ZkwTi0pfkz52mRRXjd/JoodwsAcKdQum2z59eYGUjAxwyRhqbTg2UjMdHHumKoOtWseu
         ncQwpM2kEnarG0qBVvXlDTP7bBIogLimZ39LGjR4YEsURHcNZLuZi6MRG5cStHsnoW5U
         PGqZijYw9UrYOppcRwU1H/UlzPGoA4hOEBFMBO8V6NGQ9Z6FlQT+z0E5cXhromtkbOQm
         aySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zUn1DOy5hTmWrJr4clO+wC+LjiT/FpKMP8Ap2nd5Sr4=;
        b=WBLxSBV8NUhaYb2itSWRQ50AXyqF8Jr1klP08IHDdWYqlS3Tc0weHHG9+AnKouWJyl
         I7sXkgP9M901E6AUqeTSibMrzknUgojcHcWSOn0Wr70Fve6AuyYiok8NM6/2gsMZ2BU4
         WYPVleGzMFHqhpTZVPwb6rGcyARDUYLHMGGwNxApUTu0X2EUcDl80UC7+pvo8xLlzoIS
         7hkHN9EErR2VH6DINpIz4YPVWskmLa3ZqK4eiFM5boA7Egfah26Bhm0RAHfm41tQMB1F
         P8wWST6erZ+w3HPdNziSLdZuwh/NWoTjqSPwQHy0W1mhKwW5/ynCClaZgf5r1hFb5tcZ
         /LoQ==
X-Gm-Message-State: AOAM530T9UmiXNZ+XuQwTQK5c9AeZ29upzd+Eev7CtBsR4PRZ2/eSf1Z
        5i1AcIbDFJN0KJSj92wcFuyQDUaLPnqkdA==
X-Google-Smtp-Source: ABdhPJx36d4UskXzTf1iI8HJE/tSS4+UAKJPJrBXD/gzFs+7ahd3Nc3PracPaTWRPvm3A+ItdVVWCA==
X-Received: by 2002:a05:6000:1561:b0:203:7b90:1da0 with SMTP id 1-20020a056000156100b002037b901da0mr8107666wrz.629.1647015881558;
        Fri, 11 Mar 2022 08:24:41 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f22-20020a1cc916000000b00380d3e49e89sm7318667wmb.22.2022.03.11.08.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 08:24:41 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        "Robin H . Johnson" <robbat2@gentoo.org>,
        Teng Long <dyroneteng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v2 11/13] bundle.h: make "fd" version of read_bundle_header() public
Date:   Fri, 11 Mar 2022 17:24:23 +0100
Message-Id: <RFC-patch-v2-11.13-5ade9419454-20220311T155841Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1337.g7e32d794afe
In-Reply-To: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20211025T211159Z-avarab@gmail.com> <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com>
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
index a0bb687b0f4..bfe32f543a6 100644
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
index 06009fe6b1f..2893defbc33 100644
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
2.35.1.1337.g7e32d794afe

