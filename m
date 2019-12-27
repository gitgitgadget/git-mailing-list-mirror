Return-Path: <SRS0=DNff=2R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0C8C2D0CE
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 13:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C768D20882
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 13:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENhz6GR7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfL0Nr5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 08:47:57 -0500
Received: from mail-qk1-f181.google.com ([209.85.222.181]:40295 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfL0Nry (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 08:47:54 -0500
Received: by mail-qk1-f181.google.com with SMTP id c17so21534565qkg.7
        for <git@vger.kernel.org>; Fri, 27 Dec 2019 05:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+FDqB+Bs8aMrZrdg71JpMtq5tQJuDAeH091ij9TslJE=;
        b=ENhz6GR7HDnzA7lhhcPA9uMLCl324oyav0rs7jfpX1jzGm4iuvEhSqhmwUEwTQqubb
         STs7dUrtV4s1saaDFJPt+L5WYSbuv5RndswkaOt4bc27SWXYD+gJxa9tobGtqhsYbHu0
         H4HDdADYFiJO94VAEocsxzZsgRAuWofbZsGGCiP3nJHDdrP4obte+aHSllpzV+cggvDo
         VTWO5CJ8h9ugGSTVQXI9D47sVmJUzKp+ZiNbkuYuxAsGkEodG0XrCaFCiD0I27JNTxa2
         Y6BKRUfyHTsiO8s4EvnK62SEfCvibEOxzIwvnjk3elKnE3v1p/BVNUBgGNqFc8XHiGrf
         IKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+FDqB+Bs8aMrZrdg71JpMtq5tQJuDAeH091ij9TslJE=;
        b=gUJ3fTymDX+Rq6jtY2rMYsHCC//67O9Ini16uabZVlMHTw02inetkpea1KuCd3ORwE
         X/B5yJ64HKpQA+x1al7U6xOVolAARmPKHPgm9CgGyfyAe3B4WvsFi3v0BkuMnTR/zeag
         Zcv3+7FbCMm2f6MR3Q7D/sefLhvKzvI+ZBJ+pA5n5aiLmSvfb4TzWOIH7WVjiOsF6KPE
         K2RCnRtlgjcMGIHruf1i7sFEeUZAcGVR/3W120UVV1uRc7y5NBuTSNUlIvXUsDwkxG3u
         yzs7yZfgKSE/T57kW7sl8ZR0LSMfSMrKHzfWjXf4N6T3dqjvjQMTMdiVBajALIyJ6s6V
         l8yQ==
X-Gm-Message-State: APjAAAWMBXmfDNuWSIfnVqrmYFYRZMYdMfE48M5gxU/2/YLCWtQtZ/Rb
        wgoXJTL25FEdSYkiSA9BGjv9TAW7
X-Google-Smtp-Source: APXvYqyTl0TWHz4IyHcyCJcp4A1x5Cv53YqQNDhDEu57i2Ik5rq2d50vRCpathEitFIbcMi5Syjkdw==
X-Received: by 2002:a37:6287:: with SMTP id w129mr42839369qkb.381.1577454472920;
        Fri, 27 Dec 2019 05:47:52 -0800 (PST)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id d9sm10510184qth.34.2019.12.27.05.47.49
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 05:47:52 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 16/16] t4124: let sed open its own files
Date:   Fri, 27 Dec 2019 08:47:25 -0500
Message-Id: <54315fecfe373d8020f2172b9b43e02c0dae137d.1577454401.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.810.g65a2f617f4
In-Reply-To: <cover.1577454401.git.liu.denton@gmail.com>
References: <cover.1577454401.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In one case, we were using a redirection operator to feed input into
sed. However, since sed is capable of opening its own files, make sed
open its own files instead of redirecting input into it.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4124-apply-ws-rule.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index 21a4adc73a..2b19ef9811 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -42,7 +42,7 @@ apply_patch () {
 		shift
 	fi &&
 	>target &&
-	sed -e "s|\([ab]\)/file|\1/target|" <patch |
+	sed -e "s|\([ab]\)/file|\1/target|" patch |
 	$should_fail git apply "$@"
 }
 
-- 
2.24.1.810.g65a2f617f4

