Return-Path: <SRS0=wu5b=B6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC51C433E1
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 18:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4C18208E4
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 18:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=elementl-com.20150623.gappssmtp.com header.i=@elementl-com.20150623.gappssmtp.com header.b="s3Z34/dW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgHTS1v (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Aug 2020 14:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbgHTS1s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Aug 2020 14:27:48 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA48BC061385
        for <git@vger.kernel.org>; Thu, 20 Aug 2020 11:27:47 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id h16so2241619oti.7
        for <git@vger.kernel.org>; Thu, 20 Aug 2020 11:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=elementl-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=2iNmiCWdu9JnCVOAVO+89bQoENGLhHiBi1Ruew3y+JE=;
        b=s3Z34/dW7fjiknodQckwO4RITSHXSpGWYTJRN6dc9NnnoactSgqXOQ3n9DKC4Rk1Ci
         VqjIbmEW4ABtdUicrNNUAwaRBynwZxXQztSgogkOMP/U63a9p3hkYF7RVtfV8Bf/m/yN
         g3TxNhj4tEaW1LkqQCrfy+2posk9drTz+zkyEU33PlNXbT3EOcN1LwbQH19N44w+akhr
         1/5tQonjFjm6Tm2mVWJhHfZnY59LP/yrZ9viG1XzAgfPApkOMamGyq+PNRxds3Ppuiye
         ApsZml8PZOAQ9Euqyor5fiSPm29UNCOFyf+iDyWhj3F+Ws3hF+anlO0L6h6Ei/bfjhWN
         ntrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2iNmiCWdu9JnCVOAVO+89bQoENGLhHiBi1Ruew3y+JE=;
        b=ZMM/axYqCCUqDwQR/LSUlyeKJDxvX23GfDx5eEsUdNlOGK4uI96l8mRh5Ern70N3Wg
         bQnNuDceXd2cy45OfhmgYrxtste30G2yTWrPsTPmDcQomYM1ytYhBDVsk8gSINXfr5zH
         /1gLTZFqIb1QNpxWb82qt9E09BxU9Hzlh+yknp9TdYRblYIePQHe+4RfBN/O8iDzR86Y
         a7Ehpt8KMMy3cHtxyyO6t+oAWrg2Oj6vRMQHN9+YEAmbze6viuggyRPLs5HSga5AYQZO
         D7CDIi2uB/pUv+iLrmcAu7+MYrT6skohYnPOBABdye4B4JPuFyv7pRnL8GA95GOw4aYc
         nmLg==
X-Gm-Message-State: AOAM531ISBym3rpw50WyAVuNM4q7AjU55qjRgpnz9L4OY65aCKWgaLjN
        UkNCLcCuR18JmhEgFnVuxKFTPpPzZv4pGeKTREcH2gszjsESfg==
X-Google-Smtp-Source: ABdhPJyBBwTnU36X+O5YgSvmRhfmENDIs1rIpT2zewVH21jc5M5fArjp5XL2aKCHRMR2E5cNv6JwDFrVG3LyCWj3g9g=
X-Received: by 2002:a05:6830:786:: with SMTP id w6mr3205864ots.232.1597948064567;
 Thu, 20 Aug 2020 11:27:44 -0700 (PDT)
MIME-Version: 1.0
From:   Chris DeCarolis <chris@elementl.com>
Date:   Thu, 20 Aug 2020 14:27:34 -0400
Message-ID: <CAMs-bDiFmD3=rWVc33oD-rUYWfawAjeqtbgsfoYzq9cav9UCsQ@mail.gmail.com>
Subject: Inconsistent error message with git checkout
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I hope all is well. I wanted to send this email to report a possible
inconsistency with the error message displayed by git checkout under
certain conditions.

When I try to switch branches using git checkout, and switching is
disallowed due to uncommitted changes, the error message will tell me
the absolute path of the files causing the issue rather than the
relative path. This seems to be a bit inconsistent, as calling git
status, for example, will display relative paths. Since this only
occurs when barred from actually switching branches, it seems
displaying the relative path would be a better option here.

I'd love to know your thoughts as to whether changing this behavior is
worthwhile or not.

Best,
Chris
