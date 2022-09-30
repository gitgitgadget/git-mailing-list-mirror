Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7931AC433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 18:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbiI3SI0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 14:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbiI3SIR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 14:08:17 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1BD1E2FEB
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:08:13 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id b7so380971wrq.9
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=KNsiYuRQSP+tfKsK0fGGzhUJVjHNLbZA9YRouJmlX0c=;
        b=JTNC3EbjbdnMfFzD69HlUuJcKph5i8RUVhr9DeG5DlQSfH6uZBO7BlKnhS+1pCWmeC
         YOgb+dldBb9d099iFYSo72sultn1vvnLWFmvpJZMfpwJBKa0YVwTRtKHm2hz9nu62lAv
         1PpKL2lH8jlsob/Waf3RRY84ZmqODkEx/B4r1w3dAnLfaWTJdGqlRROoOPXwg2OBLW3e
         Sy9odDnzf0fD9avlsxeXMepUyRMGBp+C8cw6nOOWsxNfK1VhAHOR14UAaqTvqA/VCoEj
         K6UPKgMVPtA+cLYtc3X0J0/A9SPsQWbKLQRCtRXYDVkc1LukfM6NPG1iSUz5GcOObmsp
         c+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=KNsiYuRQSP+tfKsK0fGGzhUJVjHNLbZA9YRouJmlX0c=;
        b=HP8yMUO1JrYgtocqe1Y32/RkzRda58RhLp3tBFGNOmVD+wr7beAH3qCPM2TwLRdisb
         ykrY1yMUKSKls2WbRUrJTAPBlLL6SehFHPBW7+ftUagFFbGUeSBAe0q7vnbtMlSM7zDV
         /rRwykGPuCvRB63XXqaApWMxKjZchUkj3HcvqIWMfQHWKNvKbTcSo7YWy5fh9KkrQTQ4
         +i85PDeYl2+/k4GE+iguh4sm0L9h1UJzlDJ97wCiO+cpRP/sBNcKQTg3U7rw7W44oNyJ
         dy0B20i8v/s95+ZK5ZOaXAi+DIPjoKedhnLwJAKrRe3KUz+6Yhz2VFyrTXDUvPrdtTz0
         /izg==
X-Gm-Message-State: ACrzQf3/FA8+Y1pevXwRPG4O+q0BODhm8lQrK6tNYlhBAhFeOpx+KzSj
        NPG956lpl2rOQ2+THOoByOvO4L3ALiWp+A==
X-Google-Smtp-Source: AMsMyM5kwfFtITeIAxlcV132sTgcFc8CrkZ+fULPC7c34nTvDN0gMFP2LTJ9EReKq5MOtFwrmd5Maw==
X-Received: by 2002:a05:6000:1d83:b0:22c:aa0a:12 with SMTP id bk3-20020a0560001d8300b0022caa0a0012mr6512726wrb.471.1664561291966;
        Fri, 30 Sep 2022 11:08:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h9-20020a1c2109000000b003b4fac020c8sm7102703wmh.16.2022.09.30.11.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 11:08:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 02/36] builtin/bundle.c: indent with tabs
Date:   Fri, 30 Sep 2022 20:07:25 +0200
Message-Id: <patch-v3-02.36-b2d76494a34-20220930T180415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com> <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix indentation issues introduced with 73c3253d75e (bundle: framework
for options before bundle file, 2019-11-10), and carried forward in
some subsequent commits.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bundle.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index e80efce3a42..5c78894afd5 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -12,31 +12,31 @@
  */
 
 static const char * const builtin_bundle_usage[] = {
-  N_("git bundle create [<options>] <file> <git-rev-list args>"),
-  N_("git bundle verify [<options>] <file>"),
-  N_("git bundle list-heads <file> [<refname>...]"),
-  N_("git bundle unbundle <file> [<refname>...]"),
-  NULL
+	N_("git bundle create [<options>] <file> <git-rev-list args>"),
+	N_("git bundle verify [<options>] <file>"),
+	N_("git bundle list-heads <file> [<refname>...]"),
+	N_("git bundle unbundle <file> [<refname>...]"),
+	NULL
 };
 
 static const char * const builtin_bundle_create_usage[] = {
-  N_("git bundle create [<options>] <file> <git-rev-list args>"),
-  NULL
+	N_("git bundle create [<options>] <file> <git-rev-list args>"),
+	NULL
 };
 
 static const char * const builtin_bundle_verify_usage[] = {
-  N_("git bundle verify [<options>] <file>"),
-  NULL
+	N_("git bundle verify [<options>] <file>"),
+	NULL
 };
 
 static const char * const builtin_bundle_list_heads_usage[] = {
-  N_("git bundle list-heads <file> [<refname>...]"),
-  NULL
+	N_("git bundle list-heads <file> [<refname>...]"),
+	NULL
 };
 
 static const char * const builtin_bundle_unbundle_usage[] = {
-  N_("git bundle unbundle <file> [<refname>...]"),
-  NULL
+	N_("git bundle unbundle <file> [<refname>...]"),
+	NULL
 };
 
 static int parse_options_cmd_bundle(int argc,
-- 
2.38.0.rc2.935.g6b421ae1592

