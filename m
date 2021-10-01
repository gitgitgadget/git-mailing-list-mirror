Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD996C433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 14:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4B6E6135E
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 14:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354550AbhJAObT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 10:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354532AbhJAObP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 10:31:15 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870F7C06177D
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 07:29:30 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id t16-20020a1c7710000000b003049690d882so11377455wmi.5
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 07:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eFSKEVD7wYb1UB0DMzAbk7s/DwGgVN0ahxtmkJFSLvE=;
        b=WF/69iwTNVPfjzvYT10HzKbtrIojnuHYXWozsD+0eMRD6UEj3yPjjpeohVpwvYCXUU
         pJkdiXow6FlGYTkqi3M5Rd7ED1yQ/fKWmIs3rIPQJdJJcOnsXm06t/3HkmpLgUVWkVXy
         oMH0sc7/SO2Mbm2Ojy6GGPoQu0wmQqRTL+RvRQx6kVRL47BnzE+WUqMOazyKDW1zHpuA
         mP3YVK1rNdo1DUzsZbkhW8iOPqAezvg0pfO8A0utaLMLUUCTkfaKWY7MKIglFBSfAxol
         SURGwfvmRWyqNjFUVMy3vn1Q65OQ3mnHS6hWjq37TrOOSnMvIP0rW7Iy5Q+WALG3k/8g
         mv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eFSKEVD7wYb1UB0DMzAbk7s/DwGgVN0ahxtmkJFSLvE=;
        b=FYuGpeWBOrc41/wn14xwc+TjoCYlmhX+ouMW+HZoIys+JIrVU6sdtKEwGclRGy1a2J
         pgTsDAhoJ+nNjam6h52wrXYpd/V8DO6XCxuesC6HWOqNmk6tsa5jpRX5P9bEIC2o4JS9
         YPGprPdXXdq4am2Re6deAVd6uXHM3WUd1LI6EKSUuEprRADa/leZv8Adj8cAibQ/ky4B
         iecLCyEDQAcv15noDrThyvOsLcrllEp0eH1iNgbNOWo1iD3vCBMdW3+fIXsjIpxX0Wk4
         jUxQIfCH8VVhUH9InI/yCnSvfcdy34VI7caUKgBF/PIIhoQPSsViYWjL6JpyAO3sgLmi
         hoJw==
X-Gm-Message-State: AOAM5316ST51z1VbhA0tQTFxkryJk8AdYPy6QUzIMLNeKmKb02W4MpoT
        vKgzJl56fPUuFEAZH9X4MyfIS7qoNZXBrg==
X-Google-Smtp-Source: ABdhPJySpxbGlG8vbbtT0in42aUzysdVy32HeA/X+lzITyU1mDCipZ1V/mBk0NJ8MDSBqxTWNNQvxA==
X-Received: by 2002:a05:600c:2c50:: with SMTP id r16mr4860896wmg.105.1633098568841;
        Fri, 01 Oct 2021 07:29:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 189sm9042069wmz.27.2021.10.01.07.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 07:29:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 09/11] parse-options.[ch]: make opt{bug,name}() "static"
Date:   Fri,  1 Oct 2021 16:29:15 +0200
Message-Id: <patch-v2-09.11-8cbee660174-20211001T142631Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1374.gc8f4fa74caf
In-Reply-To: <cover-v2-00.11-00000000000-20211001T142631Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com> <cover-v2-00.11-00000000000-20211001T142631Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change these two functions to "static", the last user of "optname()"
outside of parse-options.c itself went away in the preceding commit,
for the reasons noted in 9440b831ad5 (parse-options: replace
opterror() with optname(), 2018-11-10) we shouldn't be adding any more
users of it.

The "optbug()" function was never used outside of parse-options.c, but
was made non-static in 1f275b7c4ca (parse-options: export opterr,
optbug, 2011-08-11). I think the only external user of optname() was
the commit-graph.c caller added in 09e0327f57 (builtin/commit-graph.c:
introduce '--max-new-filters=<n>', 2020-09-18).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 parse-options.c | 4 ++--
 parse-options.h | 3 ---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 2cf6f4d01c1..0239c6bd418 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -11,7 +11,7 @@ static int disallow_abbreviated_options;
 #define OPT_SHORT 1
 #define OPT_UNSET 2
 
-int optbug(const struct option *opt, const char *reason)
+static int optbug(const struct option *opt, const char *reason)
 {
 	if (opt->long_name) {
 		if (opt->short_name)
@@ -22,7 +22,7 @@ int optbug(const struct option *opt, const char *reason)
 	return error("BUG: switch '%c' %s", opt->short_name, reason);
 }
 
-const char *optname(const struct option *opt, int flags)
+static const char *optname(const struct option *opt, int flags)
 {
 	static struct strbuf sb = STRBUF_INIT;
 
diff --git a/parse-options.h b/parse-options.h
index 74b66ba6e93..dd79c9c566f 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -224,9 +224,6 @@ NORETURN void usage_msg_opt(const char *msg,
 			    const char * const *usagestr,
 			    const struct option *options);
 
-int optbug(const struct option *opt, const char *reason);
-const char *optname(const struct option *opt, int flags);
-
 /*
  * Use these assertions for callbacks that expect to be called with NONEG and
  * NOARG respectively, and do not otherwise handle the "unset" and "arg"
-- 
2.33.0.1374.gc8f4fa74caf

