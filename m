Return-Path: <SRS0=rdad=ID=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61E5C43603
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 15:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E2F965017
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 15:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbhCEPVl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 10:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhCEPVh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 10:21:37 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B208C061574
        for <git@vger.kernel.org>; Fri,  5 Mar 2021 07:21:35 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id o1so1914017qta.13
        for <git@vger.kernel.org>; Fri, 05 Mar 2021 07:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ZRIdJxKiKMLY6gCpu+gLJi5ZXpeFVXFoAhzSU99ud60=;
        b=bbSbILAKhSzS5Bl8xFwqmP98a9VZmmoshzw65ocy1G/VXItcK7nX8MEAzLBfXppMlf
         uR/bL4oHCEpJ5v/SkgiW2SfvCz0a3ETWtvk8UMqCZIbBOoaILIffxgADHwGFYHtI0IPa
         q168594upgi1J8Lv19hji5X3A59RHKH77HInivSoyiDGg4dHyxFixXA3Ggl/5jtlKJ65
         tc7IozByUg3Neg8jp2R7JgI5bYhiW/ekK663DHtoVoQAxQ48VDCiLALCUARv5zRkP68l
         qMsWtLKVSVzQXuY4Bm/1eJ7ptBkAwfMxurIQfj/tGyLNWqwGVn51+BKMGLE/qkV/b2d9
         gbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ZRIdJxKiKMLY6gCpu+gLJi5ZXpeFVXFoAhzSU99ud60=;
        b=bBgV/qPVTydeYTOPfrxWDlTVKkEGl35iFF7WG26fz6/xluci0tIPyKx4pJTmrcD6XG
         5OWt+DEt1kP0b1u0TgtkCJSc8AYcdu+x0Mgp2ZDpoqlFpgvtsjLu7/N36Tm+RFYhq+GU
         8HBFUzh11qiPZRivsvHoQZUkZYyot04ZfHphzkF6FgF9uGKGWlUA3k3MLbZad5tWuwSA
         YhBMOEUUub0o7Y43bwjugbxxdwEZja5pZHYEn/Xie44XsxZQxUu2ClE9Jh23o6gR3Q1b
         RnNty6nkzfK7re2QMMPI/Nzol5ZcZaD+c82EyhBZaGJsphp4WbJk41t81Mdm40xZNnSF
         jFYw==
X-Gm-Message-State: AOAM532ehbNOMh/EU4hsSmO9XYqq9dpIQCuAvPwDBvq+mbnP0TfwPUNi
        vxk06SD/ufq83Y79aoxANVH73zERD2zlqlaO
X-Google-Smtp-Source: ABdhPJxzi3keasMnO609BjsAfCkDHWCSyd4aZS+53gVeyNao1jlaG3CXcmpotJ6aCpw20Qgue61OYw==
X-Received: by 2002:ac8:4644:: with SMTP id f4mr9587306qto.346.1614957694378;
        Fri, 05 Mar 2021 07:21:34 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:4ce8:219:f731:dbf5])
        by smtp.gmail.com with ESMTPSA id m5sm2097560qtu.45.2021.03.05.07.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 07:21:33 -0800 (PST)
Date:   Fri, 5 Mar 2021 10:21:31 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net
Subject: [PATCH 0/5] clean-ups to geometric repacking
Message-ID: <cover.1614957681.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was reading Junio's comments on my patch to implement a '--geometric' option
for 'git repack' here:

    https://lore.kernel.org/git/xmqqv9ahxddp.fsf@gitster.g/

and felt that all of the suggestions therein would make for good clean-up. Since
the original series is already on next, this follow-up series is sent separately
(and can be cleanly applied on top of tb/geometric-repack).

These are all fairly straightforward clean-ups, although I could do with or
without the fourth patch. It adds a lot of verbosity in exchanged for checking
unsigned overflows, but I'm not sure how likely it is that we'd run into it. So,
I would be fine if that patch were dropped.

I applied Junio's sign-off to the last patch, since it was written by him in
the above mail, and I merely added a patch message. I hope that that's OK; if it
isn't, please don't hesitate to drop it (or I can resend it with my authorship
and sign-off).

Junio C Hamano (1):
  builtin/repack.c: reword comment around pack-objects flags

Taylor Blau (4):
  builtin/repack.c: do not repack single packs with --geometric
  t7703: test --geometric repack with loose objects
  builtin/repack.c: assign pack split later
  builtin/repack.c: be more conservative with unsigned overflows

 builtin/repack.c            | 46 ++++++++++++++++++++++++++-----------
 t/t7703-repack-geometric.sh | 46 +++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 13 deletions(-)

-- 
2.30.0.667.g81c0cbc6fd
