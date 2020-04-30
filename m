Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A32C83000
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 14:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BA682072A
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 14:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kv91LdVG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgD3Ogv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbgD3Ogv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Apr 2020 10:36:51 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162BFC035494
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 07:36:51 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id n143so5883149qkn.8
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 07:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=CZ3bdvPzOZMcqczM14KCzUzTT79mSXNHllzzn6moW04=;
        b=kv91LdVGMTfZM/WAlMXEm66V6FNkB718KYWAUTY+faO5MQN5ciGlKrb4pseqMvGw5o
         MspLgZAkwxJrFxhV0J8/U5a3+yo68XyM2uHGjcPmrWzMiCfOHzifsZHPBkqNowZmKPba
         xyI3eycrCuC/IfY14ewOjP2lbM4umoskWJ7WiYSzWX/iMnNeQze68VeP0yedJpZ2bvI7
         R5VsliecT2DCfiG54G9QaR3x4qgNUBKZK1HZztUh9RXWBpDihxktXDivEJSVR46/dpuy
         ZntJ/JMuWaAjeOzmXlwmPDLcFuqgRcuxfkwmCg925EHzZ2ftAUuWmVgPWrONR0nibZxA
         LdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=CZ3bdvPzOZMcqczM14KCzUzTT79mSXNHllzzn6moW04=;
        b=IQPt6t+izi3lGrCfKS75MTkbTLiAf96/Mnfwr3/Dbj+s8ODYAvMqqRq28nNVsqxB17
         yraoCszZ18Hr217hZoXRMIJ2i8pkWUxZG5pLNCQok6yMqUD2wYA7+1iTVoIc8ywI0pda
         GI8J+zwaY7CPKSdRY+uI3Id7gsWcOMJnOShJys1E2JHkchHdcnowYe+cKhXyHsvEIkeu
         EdMtlb+SgC10itObifwfbRTwGIQMR7ch/1OpuoU5H9P137pM7cOYo5/7i5KxPGEmEJcO
         CNNYy7ap+zKvXlAv5F+PhgXVb6DZoOSP1heRt/zQydv1+WpiiWDrkASJIZhkzQJZJ/ar
         0zjw==
X-Gm-Message-State: AGi0Pube2blYaHPpUkpDl9Y0nUEAJsD+aBW/PF/1dmCwVuMRvJOJitcc
        9F//o05kSOzhrPkqvQOSVOog+FmMd+4=
X-Google-Smtp-Source: APiQypLI8SxpaUA4SMr5gP9POsuZdsujxdCXw8oZqi8T7za6N8gPrltW3tdkDRVF6oZZiDk/DESytg==
X-Received: by 2002:a37:6415:: with SMTP id y21mr3993434qkb.258.1588257409833;
        Thu, 30 Apr 2020 07:36:49 -0700 (PDT)
Received: from Douglass-MBP-2 (c-71-236-60-199.hsd1.tn.comcast.net. [71.236.60.199])
        by smtp.gmail.com with ESMTPSA id g12sm2209116qtu.69.2020.04.30.07.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 07:36:49 -0700 (PDT)
Message-ID: <63f35287c9ced4d674f938bedd439aefa6c46f41.camel@gmail.com>
Subject: [PATCH] doc: fix quoting bug in credential cache example
From:   douglas.fuller@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net
Date:   Thu, 30 Apr 2020 10:36:47 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1 (3.36.1-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unquoted semicolons are considered shell argument separators, quote
them so the example works correctly.

Signed-off-by: Douglas Fuller <douglas.fuller@gmail.com>
---
 Documentation/gitcredentials.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitcredentials.txt
b/Documentation/gitcredentials.txt
index 1814d2d23c..fb16c71cfe 100644
--- a/Documentation/gitcredentials.txt
+++ b/Documentation/gitcredentials.txt
@@ -229,7 +229,7 @@ foo --bar="whitespace arg"
 /path/to/my/helper --with-arguments
 
 # or you can specify your own shell snippet
-!f() { echo "password=`cat $HOME/.secret`"; }; f
+"!f() { echo password=`cat $HOME/.secret`; }; f"
 ----------------------------------------------------
 
 Generally speaking, rule (3) above is the simplest for users to
specify.
-- 
2.26.2


