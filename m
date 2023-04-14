Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2565FC77B70
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 08:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjDNIOB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 04:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjDNIN7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 04:13:59 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF192737
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 01:13:58 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id q26so10205840lfe.9
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 01:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681460036; x=1684052036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQ2f1AWk+4CN2U6V0JpRtn8n1GLBHLAtzAX7Y2gASAY=;
        b=PYAT+lAjbBJhM24yMsV51jlDe4GfgtC6Wl1uP2NqO1v3QbgIeEAaMm1R8rCj5WXLW1
         /wEqY/4uRsQxwP+YyPtY0M1oGw0m00Fz6CWUBsO1srNNOpO426lx/NYdZwo9EEWdk3AD
         SFS7X4Y6tYAvg6SGQGLIiAc65v1V0I7j7w1f+q3PvU+0LI+dsnm6su7HGGOU+XuzLa1z
         bUWR9Vm+qS59IFYg5GyeBz5jK37NHV+N0Okb67bl0KeIj6c6BSMRa2l4PLs8au+jcxnv
         yqQTXxC0aWBE1seTfp+KnSiJSlAkEHnHQZnerli+wCHbRoUnsot1iLVNIS10Cx1Zt70z
         nx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681460036; x=1684052036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WQ2f1AWk+4CN2U6V0JpRtn8n1GLBHLAtzAX7Y2gASAY=;
        b=OcJPNih/oUrSG7fejM5EqQbHsB+V8bYNoS534RBHfRNDunPuTOF6tdJ+0bYdYYNNmv
         a/CZRMB9tZ3Q9BeFr1vzSoDk/9264eay+awf/NUy7uK/P94lVMItJiYOgfHGOu5R06MA
         bxiSl7n2fwAHSBdAvXBFRW9UIla5V4e/cip2b3Mk4ariJsXmIl10a24AYxlHdKT0AyVI
         QmvOdEQrUH7hDcMFJAEnpOhT3ED1cvWKypFC/p7Sd2Aq4mpd5FNEK3NYGaZrGqXsbgyA
         KMmE6DcfnI/hmWmHwLQripUTWivm9dvAOLWOOpc0cNIqbYYrWY/H6iLb1fVxnRq4/0rT
         IjiA==
X-Gm-Message-State: AAQBX9ce1xtNoEAm/gTOIENeyXGevA9F0UH3OMMI4KXMoyMUmMdfNQ4Z
        Jp2SHV5qU8j599kbLnsEzrBVR3/jEN2VX2tcQfw=
X-Google-Smtp-Source: AKy350aae9TOtvlPZMtgDhltcFjK6AIK5c4sk5Vb5tn5rsQXVrBiFABTi1jv15ZizhkA5Zkw2Hei/A==
X-Received: by 2002:a05:6512:4012:b0:4eb:2b62:134f with SMTP id br18-20020a056512401200b004eb2b62134fmr2541175lfb.16.1681460035815;
        Fri, 14 Apr 2023 01:13:55 -0700 (PDT)
Received: from titov.fritz.box ([195.246.120.47])
        by smtp.gmail.com with ESMTPSA id d9-20020a2e3309000000b002a76f63a657sm657506ljc.105.2023.04.14.01.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 01:13:55 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v1 0/2] git config tests for "'git config ignores pairs ..."
Date:   Fri, 14 Apr 2023 10:13:50 +0200
Message-Id: <20230414081352.810296-1-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <7a5de047-3535-3b87-f023-43c400d57131@gmail.com>
References: <7a5de047-3535-3b87-f023-43c400d57131@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-04-06T23:35, Andrei Rybak wrote:
> There are some tests in t/t1300-config.sh that do check that standard
> output
> or standard error is empty.  And I think I stumbled some other broken
> tests,
> while checking those.
>
> Test 'git config ignores pairs without count' checks that standard error
> (2>error) is empty.  Just below it, there seems to be a copy-paste error:
> there are two tests titled 'git config ignores pairs with zero count'.
> First one doesn't check any output, but the second checks standard output,
> while calling the file "error" (>error). Test 'git config ignores pairs
> with empty count' checks >error as well.
>
> They were all introduced in d8d77153ea (config: allow specifying config
> entries
> via envvar pairs, 2021-01-12) by Patrick Steinhardt.  Patrick, what do
> you think?

Here are patches to fix these.

Andrei Rybak (2):
  t1300: drop duplicate test
  t1300: check stderr for "ignores pairs" tests

 t/t1300-config.sh | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

-- 
2.40.0

