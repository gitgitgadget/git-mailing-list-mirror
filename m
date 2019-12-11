Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F312AC2D0C4
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 04:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA79D20836
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 04:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuVqMwf4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfLKEQB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 23:16:01 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36583 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfLKEQA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 23:16:00 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so5474388wma.1
        for <git@vger.kernel.org>; Tue, 10 Dec 2019 20:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/MKyvc60IGGNeY4Wu0uWdfaHFI0eDeYRrIWniU3B6lI=;
        b=AuVqMwf4biRpnUI/SStNNQOQJZ7BZYph86XxDfTAF/OZA88qFO9IWWJXnVL4QpdRFm
         y8qkIN1PTVMN3WfAC1ORaDEmz1Oyp1HdGALIUW4SBRm7gmAjULUCvJIPOvj/rzhlh6Rh
         5mZd9IIeqwgwW4G59TcE0YFRzXxJjsvY8rBSfdLaBVsBhSfNmoWZYwMPrYJe4fvtJ8MC
         ORhQaYfbRHd+z8kAQrM9PuTO3+xxmSbEN/BNrcgP9tfF7ePHfOAsuGVrpOa5bzAsY+PD
         Paes86UKsLHNzA7iONxpU9K/IYhizNs+pqZe0Vx5DOVwblUW56hhuOEC3ruQWL8wQElv
         E9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/MKyvc60IGGNeY4Wu0uWdfaHFI0eDeYRrIWniU3B6lI=;
        b=uVq9nhRAIkvBJPmKA0omiB/jvWBmNUlqphzpXaJttbsN8/gLqy7F1wM5OU26pWMer2
         iyeilYuaLcTvUzT7z6BQmgJ32QRq+vjTaLzolBtTnAS9gSwKZ3DXZn6WplnBJtmb6LJN
         3/cs+F3tdpit89RpbvsgAyNq/Mmsno89r9jzGcYhmBxocVuLV4tIwVf+dokUuAaR4Zjk
         3yQaB2p/gHuuv3icD8i4Am/aYGXCq7DRk9F9jzmyo0uTA1iGLccQQliCTjntCfTW58gK
         +KxYsZIiwqpid5tIZp+QxrVdK1KzosYvpRFVShw4hvQbo2e13KWLXfUm831MmBPYiMj6
         saSw==
X-Gm-Message-State: APjAAAXRfYobtHEMELAXHyx4w1HMYoy5S2zUJSvbHO/t4AkhnHL+hfTS
        1amFnrZNLhpIyHee5gzwhGfkhBl0
X-Google-Smtp-Source: APXvYqyO3oSVgkMpb6JRM9aeOKCXLmuPXY/s8fRH31R4KmP2DQuM2smRjHbp/UlnLaHXMRBokl1QLQ==
X-Received: by 2002:a1c:4d03:: with SMTP id o3mr940761wmh.164.1576037758697;
        Tue, 10 Dec 2019 20:15:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g9sm746942wro.67.2019.12.10.20.15.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 20:15:58 -0800 (PST)
Message-Id: <b429f8ecb304ab8bd09d929c0b5686cc97a85df0.1576037756.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.489.git.1576037756.gitgitgadget@gmail.com>
References: <pull.489.git.1576037756.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Dec 2019 04:15:56 +0000
Subject: [PATCH 1/1] gitmodules: link to gitsubmodules guide
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Presently in the manpages git-submodule[1] links to gitsubmodules[7]
and gitmodules[5], gitsubmodules[7] links to git-submodule[1] and gitmodules[5],
but gitmodules[5] only link to git-submodule[1] (and git-config[1]).

Add a link to gitsubmodules[7] in gitmodules[5], so that a person
stumbling upon gitmodules[5] can quickly access gitsubmodules[7],
which has a more high-level overview of submodule usage.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/gitmodules.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index 953c3876f0..f139910db4 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -121,7 +121,7 @@ submodules a URL is specified which can be used for cloning the submodules.
 
 SEE ALSO
 --------
-linkgit:git-submodule[1] linkgit:git-config[1]
+linkgit:git-submodule[1], linkgit:gitsubmodules[7], linkgit:git-config[1]
 
 GIT
 ---
-- 
gitgitgadget
