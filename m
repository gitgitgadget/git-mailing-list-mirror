Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D1AC433EF
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A56EA611EE
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbhKFVNo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 17:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbhKFVNn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 17:13:43 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF9EC061714
        for <git@vger.kernel.org>; Sat,  6 Nov 2021 14:11:01 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id u1so19514070wru.13
        for <git@vger.kernel.org>; Sat, 06 Nov 2021 14:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hAtfKNdCTtF2HY5pW9XfukK+7SN8KwhlYcfVTdzPkQ0=;
        b=XJDHFmgappvD/3ZxQYtOAPHtGRkm9hoqlJ49PFEBjlr2nRa/ElH7U5vfkD5wTsA2WB
         ySLSrItu+d654+OuUpD9VBaDqKjHyM6CUAqbidgvYYRTdQw6f1Hb9Zdr9Sr9tTApMqm+
         BbF1kWZh/xxQ5KXpfA17xVLZhT8gMLz81Vu1NH0+EmH46EV5ozNTYOUKqHemd0SKQVyb
         CuCIvDUQGCmpTj+yA9j9xt+8OTrocZjMsra6DjuY12TVEQoB445p9d3Llz6DFIUBZpME
         dmtutv8CMFt1WJPmh3IFU4dE1MN6T5yPhObR8YITZKkHk9V5I5JEgxdz0mmnCLe0q5bw
         pgww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hAtfKNdCTtF2HY5pW9XfukK+7SN8KwhlYcfVTdzPkQ0=;
        b=jW+IZjn29d8jGPsKRl8SuWuAI2WEQdPjT2APUbxxRCuKJCjTnLySXgwTavS0aZdgI2
         2rt4gh4SqhFk7vlPNWbUz3UWSwDYq+4JkEWhy+DJoVbNRPO0wEUJjXPU9FpzdI4O1Gn8
         CVkJfodq/wccFCSp8VvYslJTy1jdouDlg/YgckWcWABc8gORZ7HnrjhJo6F9FdRa5eV1
         FeSVTfjLmS2DohlUV4NCAA9TIM/AW5yVscrbHk5q3usGDfoXtG43ZrEbSMqJ5xpR6Tpx
         8I69PwdrEQsso0dgpbmOP88aLKIFhbrAz2rpXBLfdJDgDAYMk1g4xG9E7+eEmNSjo9Pu
         CA7Q==
X-Gm-Message-State: AOAM533LtRDV+OrcvHg9k/no55q+KhHaPSGQYOOaM+bCSnokEOEc/AV1
        v4tsFzXoUamjssFBRxRgEaz7YnAyszw2CA==
X-Google-Smtp-Source: ABdhPJzBn0bQH3nSEvStwNIPJYqenD4GoasoQAnAxGVBPKzEz4dHMK3oPazhmALi0KHoPvvxuxdrtA==
X-Received: by 2002:a05:6000:154b:: with SMTP id 11mr30653092wry.394.1636233060025;
        Sat, 06 Nov 2021 14:11:00 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4sm9123051wmq.31.2021.11.06.14.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 14:10:59 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/8] grep.h: remove unused "regex_t regexp" from grep_opt
Date:   Sat,  6 Nov 2021 22:10:47 +0100
Message-Id: <patch-1.8-412b8b65266-20211106T210711Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc1.741.gab7bfd97031
In-Reply-To: <cover-0.8-00000000000-20211106T210711Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20211106T210711Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This "regex_t" in grep_opt has not been used since
f9b9faf6f8a (builtin-grep: allow more than one patterns., 2006-05-02),
we still use a "regex_t" for compiling regexes, but that's in the
"grep_pat" struct".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/grep.h b/grep.h
index 3e8815c347b..95cccb670f9 100644
--- a/grep.h
+++ b/grep.h
@@ -136,7 +136,6 @@ struct grep_opt {
 
 	const char *prefix;
 	int prefix_length;
-	regex_t regexp;
 	int linenum;
 	int columnnum;
 	int invert;
-- 
2.34.0.rc1.741.gab7bfd97031

