Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2D5C433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 18:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243917AbiBWScM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 13:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243888AbiBWSbq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 13:31:46 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF4B4B430
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:18 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so2158350wmj.0
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BXrzedZOQdaUzkt+06k4i4zy10kAbzieYhw98+se9QY=;
        b=eEZDo6vEabEsKPHUlw7qiQQPsPRUFtSiUSJYRntbnGbpiFSjMC0bakh8GWwyEZCZVM
         zp6GyvYNT8ec6AtA5O4LDnXISefBPasPAGfHCUaMCfhd0WQ7ljT0F1NtzsDnZKC2bXsf
         x20zYWUUAKQKldkZoPSAXujvCMwVZlA39DoKtvB4WZfUGvefbWndzf3trHTTo8OlUgCb
         fftQ+Iq6BQsslOlO/KPZnpv8wWiSx8F9LsX4wAXUaID9GYRio9KY0U3ZWOGo6D5HZmoG
         RmPK2Lq9/U68k0msyNYqcEZ96e753yX7qjngtTHr3ql16emASRwwwh4ETfdQIg40u44U
         pBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BXrzedZOQdaUzkt+06k4i4zy10kAbzieYhw98+se9QY=;
        b=kcoz1lKKjLfxOPHUC3D6GZWBkAFtPGEV/46VATyRpnBv0eCLB01sRHc4CJGf2ITDAS
         QNpMoYl5+aL5EwEJv4tuPbifgizj5VKDsQP887d6m0Qr6EiJE7V2WDv2ptODcBuj73qG
         rj4IMtf9/5f7+aPLqO30nzteb4buO1JZtCh20MZOpg45Rg/SUJDkBfh1+1yTUN2xz7Rg
         mJ67YqnET3fGoVafkRGGOTgE0o+TNpS3CiHjhvkxOTm6GmQZMBzUddZybmkcihYT3hh5
         JHA8QpFKBcfQFLGkMaraASD6hpTVS9kNcqecrZMsfNhbW+KEdjwXwpgU5kBXhkkcE6N2
         tH/Q==
X-Gm-Message-State: AOAM531NmyKy7+EWqGJYl4muaCf/eZiCzUdvt2l/i7ftJnBWpiVcjWav
        y7Dfv29FOsMLMGyXhZF5d0qtoEpr9O0=
X-Google-Smtp-Source: ABdhPJyYZHsm/xekYdjqHGU3yk1HXJSeK9+JqiX7r+LKuWpB6mC7Kf0FGMb47XIdRFkk7wyke7IRyA==
X-Received: by 2002:a05:600c:1c0d:b0:37c:3016:1601 with SMTP id j13-20020a05600c1c0d00b0037c30161601mr811436wms.84.1645641077421;
        Wed, 23 Feb 2022 10:31:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a16sm290626wrt.37.2022.02.23.10.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 10:31:17 -0800 (PST)
Message-Id: <f170cb27ce70d142aef3884a8866b87d4822be5f.1645641063.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
References: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 18:30:50 +0000
Subject: [PATCH 12/25] bundle: make it easy to call 'git bundle fetch'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, aevar@gmail.com,
        newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Future changes will integrate 'git bundle fetch' into the 'git clone'
and 'git fetch' operations. Make it easy to fetch bundles via a helper
method.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle.c | 21 +++++++++++++++++++++
 bundle.h |  9 +++++++++
 2 files changed, 30 insertions(+)

diff --git a/bundle.c b/bundle.c
index 3d97de40ef0..9e1b5300366 100644
--- a/bundle.c
+++ b/bundle.c
@@ -649,3 +649,24 @@ int unbundle(struct repository *r, struct bundle_header *header,
 		return error(_("index-pack died"));
 	return 0;
 }
+
+int fetch_bundle_uri(const char *bundle_uri,
+		     const char *filter)
+{
+	int res = 0;
+	struct strvec args = STRVEC_INIT;
+
+	strvec_pushl(&args, "bundle", "fetch", NULL);
+
+	if (filter)
+		strvec_pushf(&args, "--filter=%s", filter);
+	strvec_push(&args, bundle_uri);
+
+	if (run_command_v_opt(args.v, RUN_GIT_CMD)) {
+		warning(_("failed to download bundle from uri '%s'"), bundle_uri);
+		res = 1;
+	}
+
+	strvec_clear(&args);
+	return res;
+}
diff --git a/bundle.h b/bundle.h
index eb026153d56..bf865b19687 100644
--- a/bundle.h
+++ b/bundle.h
@@ -45,4 +45,13 @@ int unbundle(struct repository *r, struct bundle_header *header,
 int list_bundle_refs(struct bundle_header *header,
 		int argc, const char **argv);
 
+struct list_objects_filter_options;
+/**
+ * Fetch bundles from the given URI with the given filter.
+ *
+ * Uses 'git bundle fetch' as a subprocess.
+ */
+int fetch_bundle_uri(const char *bundle_uri,
+		     const char *filter);
+
 #endif
-- 
gitgitgadget

