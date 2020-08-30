Return-Path: <SRS0=qAd/=CI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AE3C433E6
	for <git@archiver.kernel.org>; Sun, 30 Aug 2020 22:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BECF2098B
	for <git@archiver.kernel.org>; Sun, 30 Aug 2020 22:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKC1tUY4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgH3WBf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Aug 2020 18:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbgH3WB1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Aug 2020 18:01:27 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B1EC061575
        for <git@vger.kernel.org>; Sun, 30 Aug 2020 15:01:26 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id o21so3654264wmc.0
        for <git@vger.kernel.org>; Sun, 30 Aug 2020 15:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xB8JMQT9aJ467pUeoZlsE+oUMNqDYZqauwecT1xy7pM=;
        b=SKC1tUY4QqO6fBOja9389O/EECFqQsj7ejk0jKwdBOZoBvw2m1P7N9Img/1SuPWwlb
         IngNezahO8Cf0Q8pRZNDbtb1Ay0+gPAkxkyn7iMgWjv6i+mQC7bs/siG+Z7k5WM1fHoE
         EWfaM14E7dc12ohFPQ6zjGgGC1DMmGuc+wZqyLZRT8Besnxp2UkHEfc5r1zfH7hrwLth
         p0MQvl3TD+V02K79xgDIN5EsKnp4mp2SeC0FN12n1urGqOzy6UpIJIPZcy8YmT5CNWVw
         CXnGIfnslRII7otAHQCcbknw11yfSSYJ4v5hpPH66nNJts15dtLpZ3WP9oA0raaCGGUp
         qc+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xB8JMQT9aJ467pUeoZlsE+oUMNqDYZqauwecT1xy7pM=;
        b=nM4YmqfMq9FMRLQalX+lyX2QcH6Fls1i0u1QKtaF8/ZtpeIvfWj9DBhJdKpz3v4yq2
         EyuJ4XHIxbKS5LTJwXpo7kTirOy3JEKmYB2x8nzoRwnW0D1R+B9owWNQTxcKec6Oox8o
         jH/1cLhJeTtGAe4KCClOemU2Vl4jn2Yy082mxVmUrvQMbSeVVcovJ8F8taqfvJSsOXe4
         XNP38WB0FfFb0qlQF4WjSAzVMfCftZ+xxtxBA0aO0zsr96j4ZvSNu30M/7AeP8GGsAod
         ucBEeYcaRm4ZoynjWvWmPyyVrEvU4/MXWaCmx910fzrt8VtG2cnqJsHbjU2et4pK1vzD
         dODA==
X-Gm-Message-State: AOAM530crrByCDCWCD7V5s8zPrlfWhrykhqZyIu3K0/uOskTX/P0KFuS
        xfyC4MX6ydGRdmP8vhnpO0OATq3wqlk=
X-Google-Smtp-Source: ABdhPJwwn+nu5db4Ilg/+nUQWrvzjbqZ6ZNoZS01UDzYs6GB/B14nLdjGA/7uXPngQOa8LcyV1aoiw==
X-Received: by 2002:a1c:4b12:: with SMTP id y18mr8299776wma.0.1598824883761;
        Sun, 30 Aug 2020 15:01:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k8sm9124773wrl.42.2020.08.30.15.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 15:01:23 -0700 (PDT)
Message-Id: <a4bea1c2dc79ef1947af812a3096ddacb0ef9d4e.1598824880.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.715.git.1598824880.gitgitgadget@gmail.com>
References: <pull.715.git.1598824880.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 30 Aug 2020 22:01:19 +0000
Subject: [PATCH 2/3] git-imap-send.txt: do verify SSL certificate for
 gmail.com
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

As a public service, it is unlikely that the Gmail server is configured
to throw a certificate that does not verify at the user.

Remove the `sslVerify=false` config from the Gmail example.

Also, comment it in the `example.com` example, and add a note to the
user explaining that they might want to uncomment it if they are having
trouble connecting. While at it, use an Asciidoc 'Note' section in the
Gmail example also.

Based-on-patch-by: Barbu Paul - Gheorghe <barbu.paul.gheorghe@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/git-imap-send.txt | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index 0a00a1236b..5e4d4d43b9 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -85,10 +85,17 @@ Using direct mode with SSL:
     user = bob
     pass = p4ssw0rd
     port = 123
-    sslverify = false
+    ; sslVerify = false
 .........................
 
 
+[NOTE]
+You may want to use `sslVerify=false`
+while troubleshooting, if you suspect that the reason you are
+having trouble connecting is because the certificate you use at
+the private server `example.com` you are trying to set up (or
+have set up) may not be verified correctly.
+
 Using Gmail's IMAP interface:
 
 ---------
@@ -97,9 +104,9 @@ Using Gmail's IMAP interface:
 	host = imaps://imap.gmail.com
 	user = user@gmail.com
 	port = 993
-	sslverify = false
 ---------
 
+[NOTE]
 You might need to instead use: `folder = "[Google Mail]/Drafts"` if you get an error
 that the "Folder doesn't exist".
 
-- 
gitgitgadget

