Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B33C433F5
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 17:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346641AbiDRR2a (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347079AbiDRR1I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 13:27:08 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A382B34645
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:24 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id x3so9099900wmj.5
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gqszxvba+4iXVawIm26unVr7x4qH5k5M/y1S/pYzxWY=;
        b=KgQfCC5l5j8TGtOROsJg+uWr3jd+o/lW+KmA+5CZNDmfi4n2hVfCaprSN/8187rDKT
         5jpssakF4bBQHvzISy7f/REOUbA2CNk7lZIDmsNoP2dvAFdyYzm1KvGHhpKoehgwUk0c
         dH8F3yI3yiuftpc5gC/3gE0lVvdVxYLaJ0+i5V75eF+wz5UAuogetz42ItYSNhDZmMOm
         QktXGtTBQt3LBxrBevk8e+GFd/a8cDM0PINr+6aZTLwod4u80b3IJ7Sdb/pQLGsY4jZd
         V5p67A96EGvSX4v+V6qpfezFhmg8gAHeeB3/jpc0gL1L3OzgtbSHsIqJHnJ6PFNhZ11B
         1i7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gqszxvba+4iXVawIm26unVr7x4qH5k5M/y1S/pYzxWY=;
        b=kBPaQOEzYPDhGYdGy5QcRQMXxjuRRKQ0JMZRhrIOU903sZQM4ZMAkMAzjdtChqdkTj
         BDzD2p46X3xbb5qOMuSHV6FQGXMMyrDSGnVHtPMbKXwBFnJakDeWOscv2etvnQmNU7Ga
         h+mt/rPLaZfnfSwoXne8+6P4yay9RIfigOnnMq1bDjp9H+PE601eJfvH7tth3YGx7GwN
         1tnPljKmTG94gM0O6FRZLUp4oK8z4urWNkiqdRpOJK5cXLf7Rt6gizrTWPLDy5kACmjP
         CvKXNdtkRGceK6gHa3lyQ2ZkY6AJEfBNkdvn+hcMLCKT0LhZt3w80k9ylPKo5tn55YDh
         FEiA==
X-Gm-Message-State: AOAM533OLum9PCRdEpp/ySOGPNUrITHi6eWHpz2ttR29EFZ3EKRaTbPO
        nKnt5IahtkjWsBjKwVd5+JZGJFDBDQPTrw==
X-Google-Smtp-Source: ABdhPJxB+Ftx3CkMmDWitTq5hkZ8vt+ORO3SVvvrrSiIxVhYOVnBgVURBGYElSRPkoXd+Cx/EOhdpg==
X-Received: by 2002:a1c:f211:0:b0:381:6c60:742f with SMTP id s17-20020a1cf211000000b003816c60742fmr12634114wmc.130.1650302662970;
        Mon, 18 Apr 2022 10:24:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c3b1400b0038ebbbb2ad2sm16803066wms.44.2022.04.18.10.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:24:22 -0700 (PDT)
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
Subject: [RFC PATCH v2 22/36] bundle: make it easy to call 'git bundle fetch'
Date:   Mon, 18 Apr 2022 19:23:39 +0200
Message-Id: <RFC-patch-v2-22.36-1350c19c3a1-20220418T165545Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
References: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com> <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 5fa41a52f11..7e88f5bc942 100644
--- a/bundle.c
+++ b/bundle.c
@@ -639,3 +639,24 @@ int unbundle(struct repository *r, struct bundle_header *header,
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
index 0c052f54964..c647dec7c93 100644
--- a/bundle.h
+++ b/bundle.h
@@ -46,4 +46,13 @@ int unbundle(struct repository *r, struct bundle_header *header,
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
2.36.0.rc2.902.g60576bbc845

