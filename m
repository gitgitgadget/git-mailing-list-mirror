Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50D1C433EF
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 21:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242424AbiBDVVM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 16:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241753AbiBDVVD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 16:21:03 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2A5C06173D
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 13:21:02 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id bg21-20020a05600c3c9500b0035283e7a012so4538267wmb.0
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 13:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9SyXSMkK5Z5s8yiRlt74UeTgloodTUcm3Bm0YblH99U=;
        b=pv6zsJLqZV4ADSuAgjvcORM3IdYz8SsFMSYsVsdXYcObC237ZjGstJOO6lTYYXJ0J4
         9i7ZZ2zFo0BHWguCzcGlQhklrbA67bqBadPWHGrM3mkhoNb80n2tthjPK3aHcSxez31v
         9z+xouxf4wzMRtSissdFXa3IOk0SKVOWQiT9cpgB4Shyl87jIulL8eAtmbQegjt+w/Re
         qOEyeaTSdpEjQ8jdNg26cx+cya4T2dfocUTy1bV/Q4YiCtVnUxdFUmsL4MjsJpTh+xKO
         Labpw3kJvFROo9lRFKoWSNHT/Ahrqc8LR1T+rXfn4mfvqQoAzKYuZRtX2uYD48y43EMn
         Y7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9SyXSMkK5Z5s8yiRlt74UeTgloodTUcm3Bm0YblH99U=;
        b=0dN/Nmk+2by8qrqDdsTkmN7KCGWq5iJA5pQDe8gynYmMMQiVzUx+2g2DP/n3d0UC1j
         s3rR5yhd13M10iSlul0hTvID/8adcjGQQB6bfmdnOxv7Cz4o015CA1uf/rJK2F+IJGv6
         7Q2VKiQ3T+M7dNGInRaUW3DKLxN2fIsKHbajPjSBEIo+1NCfYN9Shs7xAvcqLGSCFSgz
         s7uITk4dgzPiZD47bCq9hQakC/qtJi5cb4dGqGRphQ0v/OhJH88Wm1ix+am5fScCmllX
         xGJmc3Qrwqw2dz/hEXBVL6ZNcVUrRlUUv5Sq3AzUvhBij84rZ5BWixbZIQb5Kl+uv4kN
         QgFw==
X-Gm-Message-State: AOAM533uMV4P5zJii8kVc8PJy/0jOvlg0I3DDRW1ElIkfQ5EmJ2JoTKb
        2lnVaLKxVu/utZwO6KhvhUuO5Pa1GcUPuw==
X-Google-Smtp-Source: ABdhPJyxRAsw3sO2oRQATp7WPyqcvbiaw5fi/ZmoISRPSr+bCQ/KnXdzRWiwdY4jghU3czQx85WdwA==
X-Received: by 2002:a05:600c:4f84:: with SMTP id n4mr524916wmq.106.1644009661181;
        Fri, 04 Feb 2022 13:21:01 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o21sm2321598wmh.36.2022.02.04.13.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 13:21:00 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v10 7/9] grep.h: make "grep_opt.pattern_type_option" use its enum
Date:   Fri,  4 Feb 2022 22:20:49 +0100
Message-Id: <patch-v10-7.9-6446b4f0f33-20220204T211534Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.940.ge7a5b4b05f2
In-Reply-To: <cover-v10-0.9-00000000000-20220204T211534Z-avarab@gmail.com>
References: <cover-v9-0.9-00000000000-20220127T115058Z-avarab@gmail.com> <cover-v10-0.9-00000000000-20220204T211534Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "pattern_type_option" member of "struct grep_opt" to use
the enum type we use for it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/grep.h b/grep.h
index 3112d1c2a38..89a2ce51130 100644
--- a/grep.h
+++ b/grep.h
@@ -164,7 +164,7 @@ struct grep_opt {
 	int funcname;
 	int funcbody;
 	int extended_regexp_option;
-	int pattern_type_option;
+	enum grep_pattern_type pattern_type_option;
 	int ignore_locale;
 	char colors[NR_GREP_COLORS][COLOR_MAXLEN];
 	unsigned pre_context;
-- 
2.35.1.940.ge7a5b4b05f2

