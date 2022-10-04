Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A8CC433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 13:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbiJDNZL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 09:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbiJDNYY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 09:24:24 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86464DB67
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 06:24:15 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bq9so21318002wrb.4
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 06:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8Bu7r84EzE59hopkfLpjHA7BiJ5vGC0aro7TD2H9Jk=;
        b=nodnD21+E1guAVEHEh+lugvmnYc47IRU1zkwGheXdiwpvBOdrYfLy2lwTdqLo/f621
         57am7AIv8bKkiZCdrQ3bkuRuZnETtQ6EZcn4Tzoc66gxcR91sVmrM8hs1BwBP7j5kN6R
         kB5cgn/FvwpyKxtMs9FGl1K3jpjXhvKb6gnkRgTWXffrmsYtuDU2T3Kt/iZsFSSdhDY+
         cZfKUGECEXjSAGaOqYvMOB1N8xkpUtd4cAcAPA+8zrcS45fYgGlGzX8QQibSA7Tdy25G
         Tgk5iFKaIbeQdCijqeOgXaGW6X/0bvIecPjHruEYmMuXpdYo/XWrMtMUxOGjgWV5MME0
         HJUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O8Bu7r84EzE59hopkfLpjHA7BiJ5vGC0aro7TD2H9Jk=;
        b=32czOmWSIN2yCDv/yhUVu//0ffD13FjMZjvJjxX3Jq6UPOEINEFk+qqNXGwceKL1/6
         mLRV2nmxk5bupLqaiKE9wh+YCmRaw46ulNQhL/qPukyMFIhFQpybk1AAJyM2OoJ1sb1H
         uqLi8RyBLUpfYQkkFUR5ysNPRRIXA4E1FutOAydwenMxpLAa1yxPPr5X4HQV+Xr6Q/8j
         GpVbQcuKtV6z8UEgVMVtwr1RSXaayTRXUPQuzAk3ksN9M0oII6kiZb+pkuN/espBGRqZ
         bxPbnYO6W8jHp5/m2SjpfNAGr6nQd3rysz1MOw3UBp1jMuaHE/CZdqm5+Ij92ldNw5dx
         3dng==
X-Gm-Message-State: ACrzQf1aDMFCThGu7+6fZ1JlzIrekCLohEn+6IvFHY4+PCji4Q1MopzH
        3n39vIyUgtQF5mf3ERrZhugzRYeebA8WTw==
X-Google-Smtp-Source: AMsMyM5vSNI3KrEqIWgwwwmm3z1MD5SyZvEm2rTw8zYL7ntRNU6nP4lbZ3c5kxdyx6EJr7Oy5o1Xrg==
X-Received: by 2002:a05:6000:1a8d:b0:22a:44e9:831e with SMTP id f13-20020a0560001a8d00b0022a44e9831emr16786703wry.575.1664889853996;
        Tue, 04 Oct 2022 06:24:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t187-20020a1c46c4000000b003b4a699ce8esm19666022wma.6.2022.10.04.06.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 06:24:13 -0700 (PDT)
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
Subject: [PATCH v4 18/34] doc txt & -h consistency: make output order consistent
Date:   Tue,  4 Oct 2022 15:23:32 +0200
Message-Id: <patch-v4-18.34-766bafcde05-20221004T132211Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
References: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com> <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix cases where the SYNOPSIS and -h output was presented in a
different order.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index a11f8c6e4bb..6f3941f2a49 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -31,8 +31,8 @@ static int show_merge_base(struct commit **rev, int rev_nr, int show_all)
 static const char * const merge_base_usage[] = {
 	N_("git merge-base [-a | --all] <commit> <commit>..."),
 	N_("git merge-base [-a | --all] --octopus <commit>..."),
-	N_("git merge-base --independent <commit>..."),
 	N_("git merge-base --is-ancestor <commit> <commit>"),
+	N_("git merge-base --independent <commit>..."),
 	N_("git merge-base --fork-point <ref> [<commit>]"),
 	NULL
 };
-- 
2.38.0.rc2.935.g6b421ae1592

