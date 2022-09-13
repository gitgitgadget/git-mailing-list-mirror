Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2228BC6FA82
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 08:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbiIMI4p (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Sep 2022 04:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbiIMI4m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2022 04:56:42 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FF23C8DC
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 01:56:38 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id z25so19002063lfr.2
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 01:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=o/nHhhtQxt7OocErsnhVxfdKFsHRlxh+mq/mCGgSWn8=;
        b=gwvUnp5WtBDXQIoeNCeeZ6tOYssGxI2Qo5Uy2Sn9c2HXm4VQoBGr3i7tcuRiyz21Li
         vUrCcIEGvrPfxAIoR0dxnPdX9+XKKUR6dm1mSUihUz42gi5s65TWLJkwfgnHeqhF8Pbs
         j4FHou8FR81bhup7s59PdPNlsKq566PSZoYR26lpCV4ZRwsfd6hWAmlynHJD90HlZ3xi
         tZSeoSmdyWVmYxPcd0U1m/qg253jCXtr0k6EXLn7Jj+XMTvxwWO3fLDYHGyW/zj2ARIF
         YcunXb9Ag6a0pler/5PuCbwoBtzdiMQjH8/Vg8ztJF0OoQjmE6QhSZlcxRpVoswFUrMO
         1ByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=o/nHhhtQxt7OocErsnhVxfdKFsHRlxh+mq/mCGgSWn8=;
        b=a14itJIEACOKzx//E35GjhJ5fDcMkMG4ysEeblN04N61ccX2F54pzGtFbTNmPmBk9j
         +lcwyx15GiCDtcmrGVNL9HLSso9OD430aFN7CcJ1vW3NIHK56hVwRhGly6zcbgcOtN6q
         Q+nBje+mZAtvf7LGXPuB7i9exIaWb1YMy9Wmg8JNrGBq4S2H9ThsEqEL/QjJc1FRhfhl
         Qd4G3OG95chdC9MMFbBKV8isS0Ont7tjn6tEbUpopzlZnJ2rMsC6UMR3RrhLdGsDvGWj
         z8GOD4mS1ZGTwy12kbZN4SwIHlEpSEYFq2+DTJcghAjBXPtzvvwxVvlbH98yYFGF5mbm
         taLA==
X-Gm-Message-State: ACgBeo0KAr9RGbg6FRbHtwPakLfAeB6YW6BDf5htFg8eKLsIplhZIiBi
        aXBLx1iJRZTJlWrLuSpGmTI=
X-Google-Smtp-Source: AA6agR5Qvr8JvnTXkEg4dAbZM5HjKuqzq3NsdpQBt3K942ekUTTSztNZcPy1059+aWvRPxxckQRKcw==
X-Received: by 2002:a05:6512:1686:b0:491:3199:d407 with SMTP id bu6-20020a056512168600b004913199d407mr10218936lfb.476.1663059396373;
        Tue, 13 Sep 2022 01:56:36 -0700 (PDT)
Received: from fryseskap.osl.infront.as ([195.204.99.197])
        by smtp.gmail.com with ESMTPSA id c17-20020a056512075100b004946e72711bsm1572721lfs.76.2022.09.13.01.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 01:56:36 -0700 (PDT)
From:   "=?UTF-8?q?=C3=98ystein=20Walle?=" <oystwa@gmail.com>
X-Google-Original-From: =?UTF-8?q?=C3=98ystein=20Walle?= <walle@fryseskap.localdomain>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, mail@rkta.de, oystwa@gmail.com
Subject: Re: [PATCH 1/2] blame: Make --show-name negatable
Date:   Tue, 13 Sep 2022 10:56:31 +0200
Message-Id: <20220913085631.4031-1-walle@fryseskap.localdomain>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <xmqqsfkwftd0.fsf@gitster.g>
References: <xmqqsfkwftd0.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Junio

> Not clear to this bystander what exactly is going on.  Is the patch
> Rene relayed is your rough attempt that was incomplete?

Correct! I am the nice IRC that was mentioned in the cover letter. My
improved patch is the one in the e-mail you responded to, apart from
GMail's text wrapping that was unaware of until now.

> Thanks.  Let's see if we can have an cleaned-up version with tests,
> then.

I can send a corrected (and correctly formatted patch) for review,
optionally with the docs squashed in with Rene's permission. Maybe Rene
would like to take a stab at writing tests? I am in the process of
moving house and my usual workstation is not exactly online, so it'll be
a while.

Øsse
