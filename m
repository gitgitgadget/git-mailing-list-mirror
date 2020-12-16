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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B012C0018C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 06:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0392F23333
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 06:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgLPG4n (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 01:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgLPG4m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 01:56:42 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09602C0617A7
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 22:55:52 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id t37so16958439pga.7
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 22:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PUt2zJWhcxbfQ9qLlVBDQe5Smxhiw+Z2lMeppf+ju+Q=;
        b=J0qBeFwMB/U20w/ByFtH00aFB4SChqy3jeBnXjo9s7Ffwt6ZTGt2fhUmDIw87H6jaw
         WVBIeKU+3UIuTtRIwUrPh+c9o5hWmFJZOSqmobhArdmWnukU2pHPObu/mkBh4B0m8yde
         lS1FA/L2j/cSd/4zzhYd3c/Y1yMS87bvtcpIgnYlJmGL4SFhCTgLmQXJze9Xc3z9KtmV
         hAD8nK8NDPYc1aMevC0zyuxVKe6FqLf/Tbnz2VGiXYxoJqWrOPBF54hT7Bbpx/SsgFjY
         HqNaGM+oiX7Tqq0kwk2ivF0evilQdHRFpJtPtNAT8oYNUj22rPlJCOzv4BMKzjLYBDox
         QqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PUt2zJWhcxbfQ9qLlVBDQe5Smxhiw+Z2lMeppf+ju+Q=;
        b=E0X2s9unsXSfh7oQ8FCdXtPRX+IbZsmBQ1Mzf7mi943hR9g9vdr0guPXMWJi+AymW2
         Zowyr0BjBLJGiLqUne+Np3ateXGbZo5eItDlllsrxB4t+WISNCdUotZIcqEBnk7RS/8z
         jah/cAZCyzCjmLezm44+9QL4BQnOY27gCEGOt8sDOWdpRSK2YQRcu5a8V8cIlVO1MjKN
         qJr4ImAQAQlsbIYYcIXqgJFZaF3MnfJDmLoh/JARcepiJ+CHb1+EWFUWgFnLHLhLccCp
         YAFLsYwT1+k82xh3Y/GCEXg6S85YVgDRp/o5KKCSYJ4KTLDKncO2QemPdpcX+dmRY1kV
         W5Rg==
X-Gm-Message-State: AOAM531329yFledemmmCmwA+2HFs3zhenKNCI8D45LhjRz2kYh3S5M+u
        TvLmXOR/L+jOB0ZaV3L4eL8=
X-Google-Smtp-Source: ABdhPJzRjhZfefssopmRhJWTLDxJyXT6J98d5o/WynC0ArtuhrYupk07OfeloCVGuF9BRk6cALkDlA==
X-Received: by 2002:a63:e311:: with SMTP id f17mr5493618pgh.62.1608101751313;
        Tue, 15 Dec 2020 22:55:51 -0800 (PST)
Received: from xavier.hsd1.ut.comcast.net ([2601:681:5900:961c:3398:e348:1cc1:ced7])
        by smtp.gmail.com with ESMTPSA id u25sm1051457pfn.101.2020.12.15.22.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 22:55:50 -0800 (PST)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     paulus@ozlabs.org, git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] gitk: exclude common URL delimiters from linkification regex
Date:   Tue, 15 Dec 2020 23:55:23 -0700
Message-Id: <20201216065523.12698-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Angle brackets, square brackets, double quotes, and backticks are all
commonly used to delineate URLs in plain text (and should be escaped
when they are actually part of the URL).

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 gitk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitk b/gitk
index 23d9dd1..fcd6f61 100755
--- a/gitk
+++ b/gitk
@@ -7054,7 +7054,7 @@ proc appendwithlinks {text tags} {
         incr linknum
     }
     set wlinks [regexp -indices -all -inline -line \
-                    {https?://[^[:space:]]+} $text]
+                    {https?://[^[:space:]<>\[\]\"`]+} $text]
     foreach l $wlinks {
         set s2 [lindex $l 0]
         set e2 [lindex $l 1]
-- 
2.29.2

