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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5B2C11F67
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 00:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DB966136D
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 00:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237180AbhGNASo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 20:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237153AbhGNASn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 20:18:43 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE904C0613EF
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 17:15:52 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t5so858549wrw.12
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 17:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rpuU+hkjgrosuGrPdHtiXP1P3pJ99yiJMY5kQ9aVvUs=;
        b=pqFE9gCYElv4/68hGYFd51GaYe5Aj+JOmAD2r/0CKGkYo6HYsxRalm2sL3DLO5+tGc
         shK5Kv41dkfvQHoOnlOjs196SnayCSgCAeWgZD0fngdT7CPJ5WjpH93wGmmrhRBNIA6P
         elgbCsnn1g0ORFh5j4V5liJ0oxv8RPaKFsTHAQHeSVpDEhXUoruKRaHBHqguFNHPtGg8
         UHg+cS8zE2mP8+VuOeeC2eT/uBTelxOYYIKIA1E6w3/euKo1Cz4t4wX78EXSfbd4uYOG
         7S9sC9/oLEyIgwDqMFWQhW0v5Fck8NrNQyPwoMD7zW4KS4ouCqHp5+u0qU6ihpwGX978
         d6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rpuU+hkjgrosuGrPdHtiXP1P3pJ99yiJMY5kQ9aVvUs=;
        b=d7T76Fhk9+9krXJ5mAu8St69ONfBRNyfScrUCzjvdN+9L7kvN8ABOdu/b3oUeCaixu
         IGVSPOee+nxctgu6icaBbDk5gyVohaXIsvXpb30qnug5FbAxNRdNawuyvwZnotFttVzZ
         gq9ONjK0D9XY3pLT8nItxgjtBXWpf5vu2Me4/0e6mn7gErrR5ayxwH1oebjPLiqciaWz
         mdF3rY0sQtryVKiXbc+0QuPNv5L14kdKAlGKyNZIasjZ7HaIBZLk1ZBVCgE67vpYRSbO
         VGd1tgtNchkMk9FjEVA2uy8d0D+KA1H3d76zglG4vgnPUrNQM1HkXK1oTjaZ2RmC1m3W
         6b5Q==
X-Gm-Message-State: AOAM533h/ttGXR7wqUAWdsxlMdiKDFkcs+BIt+Dltaj25nWKZIftAmKk
        /PWkdT2+8ErhGUBWuqOfsTIz1QDKlmNkRt1W
X-Google-Smtp-Source: ABdhPJzABsaNx9BNObaAhWkrEZgSIrExd1D9abkgBhCX+TzStpn8JlKNi+96KZY8aK+Xz1h24sBwZw==
X-Received: by 2002:a05:6000:1048:: with SMTP id c8mr8836721wrx.202.1626221751142;
        Tue, 13 Jul 2021 17:15:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y197sm2876518wmc.7.2021.07.13.17.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 17:15:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 5/5] advice.h: add missing __attribute__((format)) & fix usage
Date:   Wed, 14 Jul 2021 02:15:44 +0200
Message-Id: <patch-5.5-a001e851d2-20210714T001433Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0-dev
In-Reply-To: <cover-0.5-0000000000-20210714T001433Z-avarab@gmail.com>
References: <cover-0.6-0000000000-20210713T080411Z-avarab@gmail.com> <cover-0.5-0000000000-20210714T001433Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the missing __attribute__((format)) checking to
advise_if_enabled(). This revealed a trivial issue introduced in
b3b18d16213 (advice: revamp advise API, 2020-03-02). We treated the
argv[1] as a format string, but did not intend to do so. Let's use
"%s" and pass argv[1] as an argument instead.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 advice.h               | 1 +
 t/helper/test-advise.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/advice.h b/advice.h
index bd26c385d0..9f8ffc7354 100644
--- a/advice.h
+++ b/advice.h
@@ -90,6 +90,7 @@ int advice_enabled(enum advice_type type);
 /**
  * Checks the visibility of the advice before printing.
  */
+__attribute__((format (printf, 2, 3)))
 void advise_if_enabled(enum advice_type type, const char *advice, ...);
 
 int error_resolve_conflict(const char *me);
diff --git a/t/helper/test-advise.c b/t/helper/test-advise.c
index a7043df1d3..cb881139f7 100644
--- a/t/helper/test-advise.c
+++ b/t/helper/test-advise.c
@@ -16,7 +16,7 @@ int cmd__advise_if_enabled(int argc, const char **argv)
 	 * selected here and in t0018 where this command is being
 	 * executed.
 	 */
-	advise_if_enabled(ADVICE_NESTED_TAG, argv[1]);
+	advise_if_enabled(ADVICE_NESTED_TAG, "%s", argv[1]);
 
 	return 0;
 }
-- 
2.32.0-dev

