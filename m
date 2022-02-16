Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C19FC433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 00:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244945AbiBPAB0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 19:01:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiBPABX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 19:01:23 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9898ECA70F
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 16:01:09 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id q7so609624wrc.13
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 16:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xjw5DGTNE6zD4CUxBYlVvhQIwkd1n0bV7XdtgWI49S0=;
        b=ObxxF75nKbytIlolALWdZjbLj66O7Ufu4oxerkQVtRvpe4eGuXYS3IABWRDGgFNweA
         sn/b+JYcXHBDymS48BZQyKqgFy1BaNMvIZb3k+moNv2gih5voeJWyB0zylsIZWtuMfm2
         Ijdoz6dPCprR1IZj+dRHGyjG1TzGJGJrumphAOcg/nXle7AGNgtmKAF2H/R0AwPxyQW0
         +aR8dt7wcpxsYT6aI0w9v5K5rosnpmg7LvuXqkD8Up7Mpv0cjzWR1UnX78fx9s8o4Upn
         liCI2bDSTawc3kDo1MyE92P3Lk1E0Tr7kq5IPPvGpG77ncpupN2Uq9k5eeYKWlmes5Tt
         ZrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xjw5DGTNE6zD4CUxBYlVvhQIwkd1n0bV7XdtgWI49S0=;
        b=VYz6RW6BbQfZl0or8ZMj2+uhRSNFSYZkklZ0VVrXIOLlXf+x8wkQQt8SIc+QtSW+1z
         N+lIHw1BPBG84qK6Yrks5fPvSaao/opQ5ry0Ucaha/D7fkF1IQZFlM2gEQ72/l62dq33
         dDwsJknR1uzVxFsvzPJRsF/whUD1tsldanw920dJE3Hesei2yt4DiPi6R0lwMa1MMzg5
         lS1cf7MUVGQtIaHUqkI4kvrC7SxO2y7QHthaPtmMVpWyv1bloFRu86P3ye0FsE2U+Vqk
         hk9jGAvQIaHjKywj15WKLj3SIbwCBaHL7StbJn2pIngnjJiNLMx8JgsWUzSOfY+glpyi
         qIYw==
X-Gm-Message-State: AOAM532tJMDjJiA793VlnM4w9gB1guLC8Q3rgLVkonkTxELwRiEPNfrr
        vzIM+rQjzrXpQi6KIA48DWuhQVf1IVkZHQ==
X-Google-Smtp-Source: ABdhPJwHA204/er284SxZjA9+Oej3sflZ4AZgIiDsgVwm2qojbpGCJStxb/y7ZXrqB5oxWo5YF3qQg==
X-Received: by 2002:adf:910f:0:b0:1e4:bc1b:4bbe with SMTP id j15-20020adf910f000000b001e4bc1b4bbemr249821wrj.9.1644969667960;
        Tue, 15 Feb 2022 16:01:07 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a12sm17260542wru.99.2022.02.15.16.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 16:01:07 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v11 01/10] grep.h: remove unused "regex_t regexp" from grep_opt
Date:   Wed, 16 Feb 2022 01:00:30 +0100
Message-Id: <patch-v11-01.10-67af9123727-20220216T000006Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1028.g9479bb34b83
In-Reply-To: <cover-v11-00.10-00000000000-20220216T000006Z-avarab@gmail.com>
References: <cover-v10-0.9-00000000000-20220204T211534Z-avarab@gmail.com> <cover-v11-00.10-00000000000-20220216T000006Z-avarab@gmail.com>
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
index 6a1f0ab0172..400172676a1 100644
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
2.35.1.1028.g9479bb34b83

