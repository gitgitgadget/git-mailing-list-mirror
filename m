Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA51C433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 13:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A53D9613CE
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 13:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbhDTNBI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 09:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbhDTNBD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 09:01:03 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9212C06138C
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 06:00:31 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id y204so18712856wmg.2
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 06:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H/NOCWZ9ANOqetOH4jVrRGxry3qtZ/t+LF3sOilgpyc=;
        b=q7pxb2P8PPjKrNAi+TvKzXLQ6AWkOKjLjAqbpx7Gz8YgvnKdvVhJ8ml5rjaQleNRz5
         3MwxHNd58hnwtMWnVNTvSTL09SUAMhG1HmD8wx4eculuesfMAK9K7jED0c/yKV9GAxHj
         u9ZyFTjckAa8F5PPep0W+M44xa1D12acZ7d9pbfkMUP/aSFX8YgGM3aQ32Io3Wg4J0Lh
         8/KhjjsHwcGufp43KUTI6WeExttiKuEoKnfrQx6CfHR5zFBJyTgeHOwh0i+uUIWBaKTZ
         cp3ubDQr0lpXd+J8cvPOKQr/ssFHJOOgMrgAHnZkeURdj05ZvxGU7twn2Cm5bWqy6l5a
         Cibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H/NOCWZ9ANOqetOH4jVrRGxry3qtZ/t+LF3sOilgpyc=;
        b=hZqzoSjUNO8wjuqk2eQ3YMTFOHqtDbcN93pE+3FxKV5CGHihoCz6u6rrjFMVVGSApO
         ntXN5SeVuqneghUtxcOqjE6RkCzz+c6nNE3l4fneMZMazxHLOZ7JPVzfwavwo+euOM2f
         5OOZh8aW6wDFLnUHiMoIwqqEuPEepIKFpqWlWCl2tVzzRVhcHMnr+HWqg9akLM8Wo+jT
         ztfY7Q34ixvEGo9k9GSH1PfW3WIJgFICSGaiH2JeqkKZJUaW3FdPZAdQzWn1+jBhH/r8
         KQsddqWi28NkUUSY7Cl+B7CUhUNYJxGUnvCpBN8YNgkudiDCFpqHqb1wznCXGYJnT8Vd
         CTRg==
X-Gm-Message-State: AOAM533L3sIZx5C6E8B0TPtuSGRSKq4xYg9sVMQVUNNl9u/cB+/0CBjF
        ZFPwLIFYJGJf/r9PMJlwtwq9Pmmq/ropyw==
X-Google-Smtp-Source: ABdhPJwTVK+W0HnbOBooj19t4mtfZDUMdDe0irRW69ElgPuvG5W6GvaxectgV0ruUXhtmMJxPPPzlA==
X-Received: by 2002:a05:600c:3397:: with SMTP id o23mr4287781wmp.26.1618923630375;
        Tue, 20 Apr 2021 06:00:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w7sm24452523wrt.74.2021.04.20.06.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 06:00:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 03/10] object.c: make type_from_string() return "enum object_type"
Date:   Tue, 20 Apr 2021 15:00:09 +0200
Message-Id: <patch-03.10-f0ec7d1dbb-20210420T125416Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.ga5d7868e4a
In-Reply-To: <cover-00.10-0000000000-20210420T125415Z-avarab@gmail.com>
References: <cover-0.6-0000000000-20210409T082935Z-avarab@gmail.com> <cover-00.10-0000000000-20210420T125415Z-avarab@gmail.com>
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
index 7028243c9a..8f3ddfc8f4 100644
--- a/object.c
+++ b/object.c
@@ -35,9 +35,9 @@ const char *type_name(unsigned int type)
 	return object_type_strings[type];
 }
 
-int type_from_string_gently(const char *str, size_t len)
+enum object_type type_from_string_gently(const char *str, size_t len)
 {
-	int i;
+	enum object_type i;
 
 	if (len == ~(size_t)0)
 		BUG("type-from-string-gently no longer allows unspecified length");
@@ -49,10 +49,10 @@ int type_from_string_gently(const char *str, size_t len)
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
index 470b3c1b86..a4eca10d72 100644
--- a/object.h
+++ b/object.h
@@ -93,8 +93,8 @@ struct object {
 };
 
 const char *type_name(unsigned int type);
-int type_from_string_gently(const char *str, size_t len);
-int type_from_string(const char *str);
+enum object_type type_from_string_gently(const char *str, size_t len);
+enum object_type type_from_string(const char *str);
 
 /*
  * Return the current number of buckets in the object hashmap.
-- 
2.31.1.723.ga5d7868e4a

