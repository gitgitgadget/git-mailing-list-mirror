Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A978EC433F5
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 17:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347043AbiDRR1G (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347019AbiDRR0q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 13:26:46 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A95633E00
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:07 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id n40-20020a05600c3ba800b0038ff1939b16so7952758wms.2
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CbCTSET7bx5hOpynvWnICsRCtHOpq/L52G49Kn/3bp4=;
        b=INNqXyg5XPCD4N3g18ll2q3S3cZvMpDzwzN7CeGSMvDp2DtBM05IksU5beC1QXlkBy
         WkPhXxh97FUd8JiSFpsXLTrj5TlG57zpvhcwjSL7kw2fwxA82R8/K39/Fk+hHPsWaINV
         If9pnuoHAd9rm+xp0H8fteEyRyvikFkuNfvdb/qS/1lFrftb7mwPZ/R9bLQP6hIjnFjU
         ljnULS3MpKwIGhTfHMefyjfDIzwChrubSoVcbrFNHoUMhtOdCovsDdkFM1ztK4JBfcA0
         LxmnrHX5jXLj9VAj5QaJztoGl50X//PYA5wAUByGvCwd9nXSnik2N8eC9u7A/3jmp1Be
         WCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CbCTSET7bx5hOpynvWnICsRCtHOpq/L52G49Kn/3bp4=;
        b=mPkUq5uGps0z6OOW4TMAYENv0idN5NqVA+LomuDPrGeEj5EzTjtLC27WF193PMLwMx
         6gpTVqYnC7KibZAlXJWRYt4Dxdho7qIn1gM/gdEtdjw6RsBCiUDmSZbdExQ/mtQX/u8v
         uP1sDXervUylitzecY6PR0gxRs7hejXUWOrPQ3kvpIBu33Ak287Z1eA1Fn+4F0RBFoHX
         CkHax2mYZ07KtMAKFlRcx8ol/buu63Ah3I7KAy/8hCj6VRx3NXUMVsF/9KUxER7hdb+j
         nvoH2xN/9+VSNpCowOEpAyvkG6IKXUktxhVWnnKRoXD4VLRAT/Nr/qmsSPx6bnE/R58B
         6GEw==
X-Gm-Message-State: AOAM5333odNwq2HasoWD+Nb19b7/oyFsH/rdLb6Zfl0eZ8RavyN8kefp
        jc+TBBE1jGypnPlA0JoODWnnaR+bkk7Zng==
X-Google-Smtp-Source: ABdhPJzez2l2JjrKGoRi0mSiu8SWEN3WNPjQRsJPpuIE8kqDFg/++zfyHlKLE+x2t5K24/fChygIUA==
X-Received: by 2002:a1c:a181:0:b0:392:8f7e:d2f8 with SMTP id k123-20020a1ca181000000b003928f7ed2f8mr9473553wme.30.1650302645699;
        Mon, 18 Apr 2022 10:24:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c3b1400b0038ebbbb2ad2sm16803066wms.44.2022.04.18.10.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:24:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        "Robin H . Johnson" <robbat2@gentoo.org>,
        Teng Long <dyroneteng@gmail.com>
Subject: [RFC PATCH v2 05/36] http: make http_get_file() external
Date:   Mon, 18 Apr 2022 19:23:22 +0200
Message-Id: <RFC-patch-v2-05.36-6e1f4296896-20220418T165545Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
References: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com> <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

This method will be used in an upcoming extension of git-remote-curl to
download a single file over HTTP(S) by request.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 http.c | 4 ++--
 http.h | 9 +++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/http.c b/http.c
index 229da4d1488..04e73149357 100644
--- a/http.c
+++ b/http.c
@@ -1945,8 +1945,8 @@ int http_get_strbuf(const char *url,
  * If a previous interrupted download is detected (i.e. a previous temporary
  * file is still around) the download is resumed.
  */
-static int http_get_file(const char *url, const char *filename,
-			 struct http_get_options *options)
+int http_get_file(const char *url, const char *filename,
+		  struct http_get_options *options)
 {
 	int ret;
 	struct strbuf tmpfile = STRBUF_INIT;
diff --git a/http.h b/http.h
index df1590e53a4..ba303cfb372 100644
--- a/http.h
+++ b/http.h
@@ -163,6 +163,15 @@ struct http_get_options {
  */
 int http_get_strbuf(const char *url, struct strbuf *result, struct http_get_options *options);
 
+/*
+ * Downloads a URL and stores the result in the given file.
+ *
+ * If a previous interrupted download is detected (i.e. a previous temporary
+ * file is still around) the download is resumed.
+ */
+int http_get_file(const char *url, const char *filename,
+		  struct http_get_options *options);
+
 int http_fetch_ref(const char *base, struct ref *ref);
 
 /* Helpers for fetching packs */
-- 
2.36.0.rc2.902.g60576bbc845

