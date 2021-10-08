Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472BAC433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 04:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21A9860FE8
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 04:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhJHEf4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 00:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhJHEfx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 00:35:53 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D998EC061570
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 21:33:58 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id qe4-20020a17090b4f8400b0019f663cfcd1so8551388pjb.1
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 21:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bvvqHjr1wnifEIbWSWxB1Y+hVY30eZCIDzqqw6u3iPI=;
        b=aspsn6bf4Sos7vbm/JmfGzYqqHHQtzrLdrWM4rzYuzd+xwcmkXZdZA8SENZTxAT1+D
         o1QKZkbuP7k4RcdT3Vq0Rzn3sId1cCAYPgUFKWnWe3HoxMjhBr4rUqKLKlIehHpaaAmg
         ukZjEEA9oDG3vHNB+DeNy/Jm2Qc/E/AHukw4hpotWNbUxFCNxDznVfg6aYOVNKOf7Sp7
         qY4WjoUN5NHPfOc9ShYHYSK9jXvq3sQFPCMf+wzyN6PeK0u6BOozNQCgFi5mk5DfZTbL
         1+jh5S30HApNdFRj+aL7gfBPSLhbTCXJ6CkcBAXMPW1YsXbn9WNi7vzEb2ShweDKbKLU
         zhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bvvqHjr1wnifEIbWSWxB1Y+hVY30eZCIDzqqw6u3iPI=;
        b=KsuWuKrmznSSV/+dn3sMbmkmEa8rwD+ZauG5VOkBOj/OY54/RgKgI5DM/kiXfEUeSO
         /hlPfdHcWZh4bbQ1bQ+EP8zIla2CUqT3ADIGq2tFjxo8M5JeFVK0nAGO+RVIiU3COH1X
         FVG9hHKgUKhy8mMT9wqaaKQDVsr4jWvrSqDxK5R++zk0/StiprI+Fo9C8zDR+nw3AyL6
         NXVrgvFPjkfryRpkCSauX0apcco/OUDxUVN4S3AJUyRvHf5l9Hcw1Arcwdw0ZWM8bPgD
         DKZ6ZefGSaO4B8DKQDHnwdESNv3xyyKWMohWr2AZMDK0quvC5/r+8tSb7lg3Lim31afF
         73GQ==
X-Gm-Message-State: AOAM533+A1885+yTJDbCpStjZyJXht4YyRkKQ8lI1WE3sqkovANEmGTd
        bBjMCsYR/v/jokdhThAFD0cDJQvsotXijaak
X-Google-Smtp-Source: ABdhPJzLV84vbObb3sbkYNryop4On1cGeYLFYkAqHu0iEmJSMpmEhu/D4BP/CafJQANwTu2ZQKuRlw==
X-Received: by 2002:a17:90a:c082:: with SMTP id o2mr5629125pjs.31.1633667638324;
        Thu, 07 Oct 2021 21:33:58 -0700 (PDT)
Received: from ubuntu.mate (subs03-180-214-233-82.three.co.id. [180.214.233.82])
        by smtp.gmail.com with ESMTPSA id k14sm870845pga.65.2021.10.07.21.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 21:33:58 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        "Dr . Matthias St . Pierre" <m.st.pierre@ncp-e.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 1/2] blame: describe default output format
Date:   Fri,  8 Oct 2021 11:33:42 +0700
Message-Id: <20211008043343.189651-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211008043343.189651-1-bagasdotme@gmail.com>
References: <20211008043343.189651-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While there is descriptions for porcelain and incremental output
formats, the default format isn't described. Describe that format for
the sake of completeness.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/git-blame.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index 3bf5d5d8b4..08008f4a60 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -93,6 +93,19 @@ include::blame-options.txt[]
 	is used for a caret to mark the boundary commit.
 
 
+THE DEFAULT FORMAT
+------------------
+
+When neither `--porcelain` nor `--incremental` option is specified,
+`git blame` will output annotation for each line with:
+
+- abbreviated object name for the commit the line came from;
+- author ident (by default author name and date, unless `-s` or `-e` is
+specified); and
+- line number
+
+before the line contents.
+
 THE PORCELAIN FORMAT
 --------------------
 
-- 
An old man doll... just what I always wanted! - Clara

