Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFC9C433EF
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 17:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347035AbiDRR1I (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347022AbiDRR0s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 13:26:48 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A02633E19
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:09 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id ay11-20020a05600c1e0b00b0038eb92fa965so12153539wmb.4
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MceH0svTfa+WJb5sDCSSWwOmOgEqDKKceHfAiUySqGk=;
        b=Oz8m1i9HfxPSj/L57PBaAI65Et6WltFntTbe2EH2zJ4ZyqTedIjiGpZGI9XeI2U0GT
         uJnR5GSGLAbaICVS1TyP/PDZ5RP87lbjWcGuOWvpB3kUPVq0hj7z5m0x+w6Rkml0Q5TN
         JiLFEZqC25cDi7guNxQVhs9nxU+HqlCoEN6RsTlSY9L1qk3EkY6+AczoWu95UDGeNr8y
         XxotvQ0Wx84NWHYwgTxzbK9cRpam3Af1H9i7JSvV+YY66ORNFfZfxwlasJV3xZVNdZZp
         VbKmgMVVErfkgmzOMdcrli7IQ4koOX0JuiRVwz2FNAIJjljOnUwJnF4ekjXlT0wI6T61
         TW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MceH0svTfa+WJb5sDCSSWwOmOgEqDKKceHfAiUySqGk=;
        b=4fnBmA0+eg9ZCBPTht/BnehSRuoHAUvIZVHym+l0CEAAr/GyI/UjlC+Ios9w0lc+gj
         wCzefUpOwS0HHuEXsISKAFqOrOBM3vyAzHdGsL7cVnlqQBWt4qgRBZzOlU8sXL1zyXKI
         X0fx2KnKIMjbT1dhvE3cNGCwCFPG/2/Lz+I5bAiRM21gzXkzB3WB7+RSDiZ4CE/nv6qD
         AvJOEfxMHEiUJ15R1/RbT6zebCf8bshCKO2hA+iX0qZhJ6VJdzEEH6CWcBAFxBQDDfJg
         iwdU5qGIQHglUuNUbQoqtrCEyorlfJm/JgvLCwt/HViBAC4SvvOXimck6fh4on/mXIC/
         lf+Q==
X-Gm-Message-State: AOAM530FSzk7imn5QCaqq6poRhb3hyNob3IUR5Wovy2Dj/41nrU/4mPu
        NvTI9XZOxuLAlimUcpCSLYoUshg2j4yoRw==
X-Google-Smtp-Source: ABdhPJyDC9Jw5we9OwEi6Bd19vREUg9cbhhItYYdgRtEMkXZxE9Bf1Pl78hisRBj2+vnmkD9n91BRA==
X-Received: by 2002:a1c:f211:0:b0:381:6c60:742f with SMTP id s17-20020a1cf211000000b003816c60742fmr12633121wmc.130.1650302647602;
        Mon, 18 Apr 2022 10:24:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c3b1400b0038ebbbb2ad2sm16803066wms.44.2022.04.18.10.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:24:07 -0700 (PDT)
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
Subject: [RFC PATCH v2 07/36] remote: allow relative_url() to return an absolute url
Date:   Mon, 18 Apr 2022 19:23:24 +0200
Message-Id: <RFC-patch-v2-07.36-2917cdd8277-20220418T165545Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
References: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com> <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

When the 'url' parameter was absolute, the previous implementation would
concatenate 'remote_url' with 'url'. Instead, we want to return 'url' in
this case.

The documentation now discusses what happens when supplying two
absolute URLs.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 remote.c | 12 ++++++++++--
 remote.h |  1 +
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index 87656138645..7576f673fcd 100644
--- a/remote.c
+++ b/remote.c
@@ -2761,10 +2761,18 @@ char *relative_url(const char *remote_url, const char *url,
 	int is_relative = 0;
 	int colonsep = 0;
 	char *out;
-	char *remoteurl = xstrdup(remote_url);
+	char *remoteurl;
 	struct strbuf sb = STRBUF_INIT;
-	size_t len = strlen(remoteurl);
+	size_t len;
+
+	if (!url_is_local_not_ssh(url) || is_absolute_path(url))
+		return xstrdup(url);
+
+	len = strlen(remote_url);
+	if (!len)
+		BUG("invalid empty remote_url");
 
+	remoteurl = xstrdup(remote_url);
 	if (is_dir_sep(remoteurl[len-1]))
 		remoteurl[len-1] = '\0';
 
diff --git a/remote.h b/remote.h
index f18fd27e530..dd4402436f1 100644
--- a/remote.h
+++ b/remote.h
@@ -434,6 +434,7 @@ void apply_push_cas(struct push_cas_option *, struct remote *, struct ref *);
  * http://a.com/b  ../../../c       http:/c          error out
  * http://a.com/b  ../../../../c    http:c           error out
  * http://a.com/b  ../../../../../c    .:c           error out
+ * http://a.com/b  http://d.org/e   http://d.org/e   as is
  * NEEDSWORK: Given how chop_last_dir() works, this function is broken
  * when a local part has a colon in its path component, too.
  */
-- 
2.36.0.rc2.902.g60576bbc845

