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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080BFC433E0
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 02:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D17E86197C
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 02:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhC1COy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 22:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbhC1COI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 22:14:08 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E458C0613B1
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 19:14:08 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v11so9309973wro.7
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 19:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x2ipjEA60vlY4TAYm9lQWpBDdki0CDB5fN/M/xgGqGI=;
        b=HaIjAN5OueUDR4eqf2kN1ue6YYqIoM6UTYgBtVNoOCaGXi690OrBCVge4encVD9Xv1
         PDzhIB/i6AOHcSyPLpBNDb1ZF2c5xec+NQU8OysdUCwA2cJLZ+lSpg4givX/IdK23d1d
         oS4DWdsQFsKGyPwx0+rMHdB68tlP7D3aoEKXk531MdHda7+KhHUJ+q/o1W0xRNeKRfy1
         bxQbZrpBjMiQWKNFKz1X4c7oVzXAlocNSdTGq/iNGKYXDg5aJhL7H7J2BkZUCSWNa2RV
         w+Wl1Qs26K90be8wlIHlYy5KsYPbZahqpb+yuNMjB2nBeP3azWSfRQY4ZP0WJBIMOqbs
         i06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x2ipjEA60vlY4TAYm9lQWpBDdki0CDB5fN/M/xgGqGI=;
        b=dX8klIviOzbRAfxwFdU6RJtDqhawLXN7zoSrY1RvvyuS+xg54SaeJmQQi858k4BcM7
         xCjn6JUS1xwDQVcavpHF5/RgBKC3o6XDN+92egGNRDt5zOzRdkaECRi1+TsGI2XMy0wm
         //4/4koxVpqGbTdt7+YcKNgDH0GhBfk2SFR5bPY+qY5E/9EsdQdgzJZAfoFr75FJNhEc
         2cv4oe/J0fYoHJuembPKtMgQy0vA9DlBqKw2EutWxU1NMTjPHlp/AzhLEs4jM+0QeCIU
         K2uDEJqR1FuLyR5IcN6ULjamSK8d/0aT3HOvXlxzW/Un7M6ZPDgKeG04uZiQcsQRpTSf
         O6kw==
X-Gm-Message-State: AOAM533sGYU2afBvEnMKBtXfUMvCYHmmFJTJt9UvnpRMYMPoiQh9GwTv
        oQXqxtQDtDLVNDMMMoKCDYhoVvnlWMS6BA==
X-Google-Smtp-Source: ABdhPJwLYnDCl4TIXgWwVjHevwClWCszMJeTtGvEPYLnb+addqfqqnZmBE5zfTbyWDwHZWwSq2Uvow==
X-Received: by 2002:a5d:47c4:: with SMTP id o4mr21461421wrc.138.1616897646825;
        Sat, 27 Mar 2021 19:14:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c2sm11291524wrt.47.2021.03.27.19.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 19:14:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 03/10] object.c: make type_from_string() return "enum object_type"
Date:   Sun, 28 Mar 2021 04:13:33 +0200
Message-Id: <patch-03.11-5615730f023-20210328T021238Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.442.g6c06c9fe35c
In-Reply-To: <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com>
References: <20210308200426.21824-1-avarab@gmail.com> <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the type_from_string*() functions to return an "enum
object_type", but don't refactor their callers to check for "==
OBJ_BAD" instead of "< 0".

Refactoring the check of the return value to check == OBJ_BAD would
now be equivalent to "ret < 0", but the consensus on an earlier
version of this patch was to not do that, and to instead use -1
consistently as a return value. It just so happens that OBJ_BAD == -1,
but let's not put a hard reliance on that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object.c | 8 ++++----
 object.h | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/object.c b/object.c
index 1c36ea606f2..c0e68d4bbf6 100644
--- a/object.c
+++ b/object.c
@@ -35,9 +35,9 @@ const char *type_name(unsigned int type)
 	return object_type_strings[type];
 }
 
-int type_from_string_gently(const char *str, ssize_t len)
+enum object_type type_from_string_gently(const char *str, ssize_t len)
 {
-	int i;
+	enum object_type i;
 
 	for (i = 1; i < ARRAY_SIZE(object_type_strings); i++)
 		if (!strncmp(str, object_type_strings[i], len) &&
@@ -46,10 +46,10 @@ int type_from_string_gently(const char *str, ssize_t len)
 	return -1;
 }
 
-int type_from_string(const char *str)
+enum object_type type_from_string(const char *str)
 {
 	size_t len = strlen(str);
-	int ret = type_from_string_gently(str, len);
+	enum object_type ret = type_from_string_gently(str, len);
 	if (ret < 0)
 		die(_("invalid object type \"%s\""), str);
 	return ret;
diff --git a/object.h b/object.h
index ffdc1298300..5e7a523e858 100644
--- a/object.h
+++ b/object.h
@@ -93,8 +93,8 @@ struct object {
 };
 
 const char *type_name(unsigned int type);
-int type_from_string_gently(const char *str, ssize_t len);
-int type_from_string(const char *str);
+enum object_type type_from_string_gently(const char *str, ssize_t len);
+enum object_type type_from_string(const char *str);
 
 /*
  * Return the current number of buckets in the object hashmap.
-- 
2.31.1.442.g6c06c9fe35c

