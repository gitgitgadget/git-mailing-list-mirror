Return-Path: <SRS0=b7P8=2X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AC1C3276E
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 22:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911DE20866
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 22:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="VGxdAICg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbgABWvt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:51:49 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:33687 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729074AbgABWvs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jan 2020 17:51:48 -0500
Received: by mail-io1-f65.google.com with SMTP id z8so39737058ioh.0
        for <git@vger.kernel.org>; Thu, 02 Jan 2020 14:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=xLH/2HBbe/htSjugU8h9IHoXrGTg3v+ZFLHACMigC1A=;
        b=VGxdAICgJlTD1dYiTJ4XsylkpNZGmM2g96wEC4Wzdb5QsZ5sBK3rImlokIFG9IPHGh
         08lwuujhFXFNUQMlwtfoVjmSXIcak1WPWqon8ya58UeUQckxtFnRdm0/rzWeg7q+iWja
         nkvG4SHIXaJjfT4pc3xP2W6vRlEC7OYc143UuvUtme1C3Muihcq2ce/HnGILtqW2KvoE
         +Wjnp2Z9/FcnkS67m41E5IWVAsSafbYqlipDe9WKuAFilDUp1z95mLhljYJUNaPsj5za
         W6h4u5j5Hz0xkRVF6Z7qkmUWWihvpfxXxDjtPFDO0YPLsaIN/ad7l6wA7Uwc1UQRvXvI
         g80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=xLH/2HBbe/htSjugU8h9IHoXrGTg3v+ZFLHACMigC1A=;
        b=DXC+9eC0WQ5O2U8DgYT/Eq+DHUYK1D66eHkmuysXKSfTnWYYmBDsytZ6dE1533vDoZ
         kL/0S1eZi685ec3NT58QkzvVniSEgFMIiXK1qdsc3iQ9ygALtOeGensUj82ejEMAzeH1
         NlU2od68VyRI+IaxOpoDXfui/z0LQQbxjInx9alvZS9cPmpnwfjbGUereoyu5Y4m8euD
         Zm+Q2OKemMI8HZIyp1meLLPIuHIGypXuNpYV9Vq2fM28/drHYrzE8wcRXPljp+qI1rPU
         J7e73q5CvPGEGZbNKm186084RYl3c3B8TuSOFsVB5NEKzx9Un8Vjqb/u0BfgaGRoHbqW
         mMpg==
X-Gm-Message-State: APjAAAUDoWh/FCDi8QBDdWWkyYTVrGdEjOUpxVbAdPRCmiafX4Xjquaw
        eZHjYwhBIg5wiFr0j8uRloaW/dWJ45w8Jg==
X-Google-Smtp-Source: APXvYqwlxZTMnjzY5RpXv3qbllBtAfRc+01lvSgwEJ57W8kUh/1eMIObHyyicFwn//A2qelKXJBd0A==
X-Received: by 2002:a05:6638:5b6:: with SMTP id b22mr68241195jar.6.1578005507464;
        Thu, 02 Jan 2020 14:51:47 -0800 (PST)
Received: from localhost ([75.166.236.123])
        by smtp.gmail.com with ESMTPSA id h6sm14465145iom.43.2020.01.02.14.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 14:51:46 -0800 (PST)
Date:   Thu, 2 Jan 2020 15:51:40 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com
Subject: [PATCH] Documentation/git-sparse-checkout.txt: fix a typo
Message-ID: <1acd9e81607cc3f430a52512d7ff3cb82ccb0cfb.1578005500.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This typo was introduced in 94c0956b60 (sparse-checkout: create builtin
with 'list' subcommand, 2019-11-21).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-sparse-checkout.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 9c3c66cc37..a3c920fa6c 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -5,7 +5,7 @@ NAME
 ----
 git-sparse-checkout - Initialize and modify the sparse-checkout
 configuration, which reduces the checkout to a set of paths
-given by a list of atterns.
+given by a list of patterns.
 
 
 SYNOPSIS
-- 
2.25.0.rc0.2.g1acd9e8160
