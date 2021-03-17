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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34DBC43381
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A551E64F4F
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbhCQSVZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 14:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbhCQSVO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 14:21:14 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18D2C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:21:13 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v4so2823015wrp.13
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O+FIxwKwSqGjF8S+lR63tXVM+rkWT7p0qumHxdrPm/s=;
        b=BVF6ay2nAenhaG++CJ39QV161DYO0KKTiG4FqJl3icQfKj4o90Mf71CgguRTGP963M
         ztpUFkdE85OvxNJ4V8DiLa+f5jC++iEsJf9F+V/FhfeJDFjOSsGqfGPe+f3vlQSQ1U1m
         NaZOdj1zeesnGZ49Bkz4fcnUrcas7ZFSKn/q9g9wHYLN8WVMdpDLFpO6fmfK2KgZxUfj
         u0b2q4fd2bhJXXVFrYLsSeh3HQmP0B9Czo31ZPudFosR2JBtgTYcpq+sPakh6KaoKSqD
         OmfXw0nr7m9f+p5hHYLimpuhv0jo/X8YgWgh+sMB5BjvOy/6izRmPE1AjvgsxRkBxq/T
         /CCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O+FIxwKwSqGjF8S+lR63tXVM+rkWT7p0qumHxdrPm/s=;
        b=alnd/hSF6YuXsKzMSm9GkIOPqCbFa6GsUMgMAMfQIJnXvPwv0z0Um44Zy2GeMrdaL3
         vpq2u9Q/Xdh3Wq8VdxhZo2dQIDdPKMqbyUY4wCq/E/X4uaHLTuanBQ/3izBPh9Iry6g5
         PPHwQlHMGTSHkd2g0n7Xd7CIZzrOvNktQ4qyhEGQ0Y7X87CbtTscpl2IPSKtf0RsavQq
         zehDrQI1jCsMpb7S1LI4ULOEHd/EtA67UYEMOZNXS9UQcEGJHOjRe2LVZXzmBSodj+fL
         JwbF9pM/pieANNekGS8kp+HhekJRvffrZ01gmMK8/Yqqdm9vSltGbrsw+UYUty19m1ff
         0FQw==
X-Gm-Message-State: AOAM533MP+sO3VwYxMRF8NbHDQKYLuxeXireQ9m26H7qVLK9GgW8SVA9
        LFMjrIMDDqMDVH+gXQp50YmBBuO8FYVR2Q==
X-Google-Smtp-Source: ABdhPJyvWqsC/MJKLM7nfB8MebEsn68wUjNgi1n6vbBqmkOwvEtGQtPQK3B7mg7TZS8+kU84k6B4Tw==
X-Received: by 2002:adf:a2cf:: with SMTP id t15mr6000575wra.250.1616005272131;
        Wed, 17 Mar 2021 11:21:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x23sm3177205wmi.33.2021.03.17.11.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 11:21:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 02/19] fsck.h: use designed initializers for FSCK_OPTIONS_{DEFAULT,STRICT}
Date:   Wed, 17 Mar 2021 19:20:37 +0100
Message-Id: <20210317182054.5986-3-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.260.g719c683c1d
In-Reply-To: <20210316161738.30254-1-avarab@gmail.com>
References: <20210316161738.30254-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the definitions of FSCK_OPTIONS_{DEFAULT,STRICT} to use
designated initializers.

While I'm at it add the "object_names" member to the
initialization. This was omitted in 7b35efd734e (fsck_walk():
optionally name objects on the go, 2016-07-17) when the field was
added.

I'm using a new FSCK_OPTIONS_COMMON and FSCK_OPTIONS_COMMON_ERROR_FUNC
helper macros to define what FSCK_OPTIONS_{DEFAULT,STRICT} have in
common, and define the two in terms of those macro.

The FSCK_OPTIONS_COMMON macro will be used in a subsequent commit to
define other variants of common fsck initialization that wants to use
a custom error function, but share the rest of the defaults.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fsck.h b/fsck.h
index f70d11c559..15e12f292f 100644
--- a/fsck.h
+++ b/fsck.h
@@ -43,8 +43,17 @@ struct fsck_options {
 	kh_oid_map_t *object_names;
 };
 
-#define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL, OIDSET_INIT }
-#define FSCK_OPTIONS_STRICT { NULL, fsck_error_function, 1, NULL, OIDSET_INIT }
+#define FSCK_OPTIONS_COMMON \
+	.walk = NULL, \
+	.msg_type = NULL, \
+	.skiplist = OIDSET_INIT, \
+	.object_names = NULL,
+#define FSCK_OPTIONS_COMMON_ERROR_FUNC \
+	FSCK_OPTIONS_COMMON \
+	.error_func = fsck_error_function
+
+#define FSCK_OPTIONS_DEFAULT	{ .strict = 0, FSCK_OPTIONS_COMMON_ERROR_FUNC }
+#define FSCK_OPTIONS_STRICT	{ .strict = 1, FSCK_OPTIONS_COMMON_ERROR_FUNC }
 
 /* descend in all linked child objects
  * the return value is:
-- 
2.31.0.260.g719c683c1d

