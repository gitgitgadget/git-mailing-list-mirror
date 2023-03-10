Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA9DC64EC4
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 05:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjCJFAl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 00:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjCJFAi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 00:00:38 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9BBE4D87
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 21:00:37 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id 76so1603381iou.9
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 21:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678424436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HmzzaoNQ9gWZzjsXZvie8bjG61ujtuaMk5bBwH1g+Ps=;
        b=Cfj0xfI9QYSE/hFowbgEBUN8OJB6F6Ns7AcNQyCfwBkLx4qeZiXdTfEspFOGMPZ2TF
         MTvdVmwQorkqCBZFYDS9qHw+lJQobpMxy03AbABalSogHW4q4GmPNet9L8MceKXbiEBU
         CGuVsJB45QU6+K52Elk/fKJQuFKqHLaXqtxcthxDChE2tK4PDPbRZ0vEE2mSNetN5FlV
         p6Iq0OsLbhnPXqKq7kNSQ6q5aMqOfmDU3QLPjFTCT16UGy/rx45aWrvYnh57YmJEthBe
         xPrUV77Y8p+3lPdCWQU0rdpuy/XQU7GPafm4EqYR+1kioVcFFk14RhFkxTRoYVPQNxMF
         3Q/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678424436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HmzzaoNQ9gWZzjsXZvie8bjG61ujtuaMk5bBwH1g+Ps=;
        b=hzhHcSJlJg/htaaxgFoa2xA043FItn5tx4w08UrFzsW+7OV4uWCxSFzOkLkHxhzWz2
         NdMuFK/hiWJ02nvZTtfc2uUzG0l7m9qtxF0gK1Bd5DiGYS8sgfqdMbxTZN2xOKmUK3vR
         U66+FK3T3xdhj4RFXlcRyLq+f9SUOwtvcVOqE0bO1AkmIJWAbCVK7EoZcGMSemD07ohy
         FdmPFGLgj/Y+5G4CE3AwwuhXeGdYS/g6w18T/Bnhn6kUD7AlJDj7RsBreuHYLWb62rVb
         I37HjwTPxAOCXgsiSxlmDkMGnEZkFOS5e1hPrGOdfHzNFkdAiRl1phUAsBLobZYiZmm4
         uJKQ==
X-Gm-Message-State: AO0yUKUfVBPTKnfP0pSDJe/uHLLSJGRV1AruJHDB+XVWYKvQBIKW3Ysq
        k1ghHADcH3119WCOyY/ZeAzZIe6O9z4=
X-Google-Smtp-Source: AK7set8oBmoWB5bjlk+41+lcT+b/VPs6TxtSNZ+cHX9kPfEL+HpiqOdF/OakzWhUVlN+5yB1EJmmdg==
X-Received: by 2002:a6b:7a4b:0:b0:74c:c594:beaf with SMTP id k11-20020a6b7a4b000000b0074cc594beafmr4398720iop.18.1678424436280;
        Thu, 09 Mar 2023 21:00:36 -0800 (PST)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id c4-20020a6bfd04000000b00734ac8a5ef7sm323930ioi.25.2023.03.09.21.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 21:00:35 -0800 (PST)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, gitster@pobox.com,
        vdye@github.com, derrickstolee@github.com
Subject: [PATCH v5 0/2] diff-files: integrate with sparse index
Date:   Fri, 10 Mar 2023 00:00:19 -0500
Message-Id: <20230310050021.123769-1-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230309063952.42362-1-cheskaqiqi@gmail.com>
References: <20230309063952.42362-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v4:

1. In 'diff-files with pathspec inside sparse definition' '

Add some extra space to make test more readable.

2.In 'diff-files with pathspec outside sparse definition' '

(1)
Remove redundant tests since output from checkout and index 
are known to be identical. 

(2)
Add test to check 
sparse-checkout-err (sparse-index-err) is empty.

(3)
Add test to test the actual output for
'file present on-disk with modifications'.




Shuqi Liang (2):
  t1092: add tests for `git diff-files`
  diff-files: integrate with sparse index

 builtin/diff-files.c                     |  4 ++
 t/perf/p2000-sparse-operations.sh        |  2 +
 t/t1092-sparse-checkout-compatibility.sh | 61 ++++++++++++++++++++++++
 3 files changed, 67 insertions(+)


base-commit: a38d39a4c50d1275833aba54c4dbdfce9e2e9ca1
-- 
2.39.0

