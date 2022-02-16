Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC47C433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 00:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244917AbiBPABe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 19:01:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244948AbiBPAB1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 19:01:27 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04A9D2051
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 16:01:13 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id m126-20020a1ca384000000b0037bb8e379feso2554898wme.5
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 16:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mN9MgerNuW8nVymqvUE2ePUzgV3PRrOllu1PeM+FjFs=;
        b=G40UKQi5xTTq4CYTcNMgj/0Zh4fM2JjbVF/9S8TBbqgeBeEiVGIHZCfKaM9+dUUG5u
         9ZAbGnh0IvxperbxpSwAblSKFW6VgbG7h0byvVSDdQH3XFNaZ+mZKIXfy9EfWv8VGI/F
         X89s+OUwiwfcaZOwumOJilQ2waj60p5T7Z9wJ+Hl76gDXwmGMhFCj1kWXoKhK7vuSqJK
         +WfiZCRskC9qk3Crq7FA3y33M7Y2WM66bTU5ngtFyWs6xtsGTlQ4DVeUeZNdHrl3C2cm
         0UQR86UrP8fs/SNZuFDhQDHcDYl6AJVZ2uKqjvHdrR4rS0W68+DWe45dH2Pw2h+Yk7cU
         AKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mN9MgerNuW8nVymqvUE2ePUzgV3PRrOllu1PeM+FjFs=;
        b=jWHVE1M+IbCu5v7aMJBUEieNoB5fJGFJlY/PtCB9Pa7qFbvD7RnYTnYY2c4En1MvwH
         v0fn4q+xb+A80wig+AHfwENSDbsMQH3UFXQ862P12E/9bMqrq1/t57be3O1j/PdtanaG
         dP8ZoSkmDsOB/1wMzmIhQS/arDIJfa4JuY+O8txqjBmhgwVsHqDJ+pK/K66HgP493yHs
         +ZjG60LFhen3I7fLOlz+MzCUYIWw9DQLec5DulPcXdn9OGzx1pQfI+BgWordVregAifJ
         7qC5aJZQ7EruA+Kr7Bn/8wFh8v3glBcnOps2f1JJdxMPogmzX+WIxMDiyhPcAcYibT+l
         DcoQ==
X-Gm-Message-State: AOAM532UAM+vMJHnNISbAiuVEUBTpnnDiq/2SdtiPvYOHPQkk1cvXGm9
        LkLVPTNjNMDiuFC8ubgBJPqryr+5N3FlAw==
X-Google-Smtp-Source: ABdhPJwnLJ2zqTEP881oTu92+uPXV17sHMV2JJzfqDJElZbtSzO2ID9I3APYOLavDk7KXjTRirSsdw==
X-Received: by 2002:a7b:c3d3:0:b0:37b:ea2b:55a4 with SMTP id t19-20020a7bc3d3000000b0037bea2b55a4mr219445wmj.85.1644969672092;
        Tue, 15 Feb 2022 16:01:12 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a12sm17260542wru.99.2022.02.15.16.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 16:01:11 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v11 06/10] grep.c: don't pass along NULL callback value
Date:   Wed, 16 Feb 2022 01:00:35 +0100
Message-Id: <patch-v11-06.10-38bfa0ed5f9-20220216T000006Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1028.g9479bb34b83
In-Reply-To: <cover-v11-00.10-00000000000-20220216T000006Z-avarab@gmail.com>
References: <cover-v10-0.9-00000000000-20220204T211534Z-avarab@gmail.com> <cover-v11-00.10-00000000000-20220216T000006Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change grep_cmd_config() to stop passing around the always-NULL "cb"
value. When this code was added in 7e8f59d577e (grep: color patterns
in output, 2009-03-07) it was non-NULL, but when that changed in
15fabd1bbd4 (builtin/grep.c: make configuration callback more
reusable, 2012-10-09) this code was left behind.

In a subsequent change I'll start using the "cb" value, this will make
it clear which functions we call need it, and which don't.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/grep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index d85cbabea67..5ec4cecae45 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -285,8 +285,8 @@ static int wait_all(void)
 
 static int grep_cmd_config(const char *var, const char *value, void *cb)
 {
-	int st = grep_config(var, value, cb);
-	if (git_color_default_config(var, value, cb) < 0)
+	int st = grep_config(var, value, NULL);
+	if (git_color_default_config(var, value, NULL) < 0)
 		st = -1;
 
 	if (!strcmp(var, "grep.threads")) {
-- 
2.35.1.1028.g9479bb34b83

