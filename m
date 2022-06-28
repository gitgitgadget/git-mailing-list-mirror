Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AF5CCA47B
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 02:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235318AbiF1CDf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 22:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243239AbiF1CDM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 22:03:12 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D4A5FF7
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 19:03:10 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id g20-20020a17090a579400b001ed52939d72so5720470pji.4
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 19:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z0BW2gmM1Z0ODlky5cedvC+Z6uHdPKeUVJ9wDal81mc=;
        b=P2ow4V3xVBYjMQViIq2RnRI4tgrfzytoVVNaTl5QiXbfPU7omPXHhlRz5lfeogc8Mh
         kZOzpBVc510p92SjbWAroQ5H5Wk0sysOwo9VVv6XhwvViXkgGC9iH8RpPuhPGNN4TgFf
         UTsC/djcp3xqB4tbfaxHDfrjAELat0k3ptcXs1qUVrRzod4C10e/9SzmoXnacPaBWEtM
         vVxk2+Y9Kh+90NAVf80sDEgGXaRcigs4JBkTZoN69KMUgFNU6oEs9eUp4fkzhxHj9VML
         C0Wrez+hQDVhp6JZVLScbeinEsYCtQlIcLU6r9gHZ+qLYexUa/Ik7GU7YqE7nk5XPYm7
         7ZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z0BW2gmM1Z0ODlky5cedvC+Z6uHdPKeUVJ9wDal81mc=;
        b=UeOJiwQ9wcJGuL+zL6mRryuB5iSTyOh++zJq1TX6rWohizqO82mMDJia17OPDJO4Eb
         f7FiWUcoEkyyqeiVtrX9b776jo7iAjZhZDR16jUHcy4BD4amTATIgiFbkzKkw1shESRc
         qi0/9s3rzAStQgJXYU2NCpNmufjIKk7g+gpPtxzb7sjg4SR0dtsW6JV/nwlWX8xaIgF7
         5uOBC2keauaPYplf+TI2qaeXn43vGU8RGZ21Y0MIKMYMkHE5eqYz+DIOVVsYCIERiLzN
         Pue+ZUMubwi2D0Pu36Al1skXgEhYlm2A6zcUamP9OQtENZWfe7wRWCUdw7HZYmEzlSBK
         viAA==
X-Gm-Message-State: AJIora9BgwH9qul/Ou4nZes0bFyIUxK8Rzyb/POJ7DiKzNwgj4TVtzkS
        Pa0/RLu/cs9b8d4Zv5+NmxbuHg==
X-Google-Smtp-Source: AGRyM1tPIQ/56QWSIjgXiLeMEpoP6xuhcbLpJlT/RgdSn3KlwyoQ21fKBJGdWIT0S0bwC2E3f15jKQ==
X-Received: by 2002:a17:903:2612:b0:16a:30f:321f with SMTP id jd18-20020a170903261200b0016a030f321fmr2384512plb.69.1656381788995;
        Mon, 27 Jun 2022 19:03:08 -0700 (PDT)
Received: from JMHNXMC7VH.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id n18-20020a63f812000000b0040c33cb0ccasm7823744pgh.42.2022.06.27.19.03.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Jun 2022 19:03:08 -0700 (PDT)
From:   Han Xin <hanxin.hx@bytedance.com>
To:     hanxin.hx@bytedance.com
Cc:     chiyutianyi@gmail.com, derrickstolee@github.com,
        git@vger.kernel.org, haiyangtand@gmail.com,
        jonathantanmy@google.com, me@ttaylorr.com,
        Junio C Hamano <gitster@pobox.com>, ps@pks.im
Subject: [PATCH v3 1/2] test-lib.sh: add limited processes to test-lib
Date:   Tue, 28 Jun 2022 10:02:51 +0800
Message-Id: <ad0a539759ab79adb7a5b4c87f1a1548012ffbbe.1656381667.git.hanxin.hx@bytedance.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656381667.git.hanxin.hx@bytedance.com>
References: <cover.1656044659.git.hanxin.hx@bytedance.com> <cover.1656381667.git.hanxin.hx@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We will use the lazy prerequisite ULIMIT_PROCESSES in a follow-up
commit.

With run_with_limited_processses() we can limit forking subprocesses and
fail reliably in some test cases.

Signed-off-by: Han Xin <hanxin.hx@bytedance.com>
---
 t/test-lib.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 8ba5ca1534..655d6d543f 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1816,6 +1816,22 @@ test_lazy_prereq ULIMIT_FILE_DESCRIPTORS '
 	run_with_limited_open_files true
 '
 
+run_with_limited_processses () {
+	# bash and ksh use "ulimit -u", dash uses "ulimit -p"
+	if test -n "$BASH_VERSION"
+	then
+		ulimit_max_process="-u"
+	elif test -n "$KSH_VERSION"
+	then
+		ulimit_max_process="-u"
+	fi
+	(ulimit ${ulimit_max_process-"-p"} 512 && "$@")
+}
+
+test_lazy_prereq ULIMIT_PROCESSES '
+	run_with_limited_processses true
+'
+
 build_option () {
 	git version --build-options |
 	sed -ne "s/^$1: //p"
-- 
2.36.1

