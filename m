Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A869EC636D3
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 23:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjBHXOB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 18:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjBHXOA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 18:14:00 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F45E0
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 15:13:53 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id 74so272812ybl.12
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 15:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BDK14YV0O3vXxcqO8Z4y8SfvwBFFzymFQw1twNEqWkE=;
        b=Uirvu90/n2dEFbcqzZaMaNEBTZaQ+D9p/bbGIvnTzYFJCtyGukrWEICDd9ADzEfrcd
         I7bFSLFpCR4rMlHesf+y2pDbXILP0GsYu1GtKB2L8aMYL+IAmdppJGdPdb4vmaca97bH
         CfNUN9YRWMTZ+IjoL9H5cDX/939lJKLcTP4Ciwzw/KuxLnMDE/aH/nROHxc+FmjIjLSs
         KGxFUgGDjCyRhH1Fg9suTDzVKQxM7NR78F4WoydV4G2t+p5vY7JsNKtnwVc40eK1FDhI
         42qOroD8y09SJokNP/hxoOl5jy7wSPWYub37VbeRqPp0UTLDG12Ao5XRsw6B/HQeYg9/
         /dOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BDK14YV0O3vXxcqO8Z4y8SfvwBFFzymFQw1twNEqWkE=;
        b=uwJ+9ZKtjuZfY7Sxej0zMM3JApbmGuSJPBp3uxwBzawO/VUe92ArcYowPVnpINl37c
         8T51TnarqXYgkQi+wYoBaWv/9frP592UR37pF4R9CBDV8oazw8zNNkqt4h0xVuX4RXWV
         a4uUe57BcckxGljisHI9N5LFW5G2SypQmgVwh+bjdXVjUtkD5wPu+MFlPUVTa4TzPzaY
         Y9eKENT/1ygdEO5W8K6v1yaN9iDZDuY3e7zGCcO3NMU3Wz5ziWVL33JInHM2pjq/d5Hq
         caKPzk4l5QqMtOoDz9eE840hrmbq8SHnw/pi0jzGqtSwlKTI9T9SMr9cTBU/2fBlwdkn
         3S7A==
X-Gm-Message-State: AO0yUKUiNgp44v49ve69jNIWy/4snrdY02rc+vgUu3F9tKnESHnvrGe+
        fsHHmdIUMwvUpB14Yi7xopvdcpzOznFYJSV8RB627eopNhQk76YZ
X-Google-Smtp-Source: AK7set/oY1cPPPZIGaFNOBJzl047OCK18b/tFyz4y3T84d0y/CWIAX6aJBbiE8BAmxM3Xlg+VlprJshfKJa4c927K1o=
X-Received: by 2002:a05:6902:cd:b0:8ad:5708:1df3 with SMTP id
 i13-20020a05690200cd00b008ad57081df3mr959742ybs.510.1675898032653; Wed, 08
 Feb 2023 15:13:52 -0800 (PST)
MIME-Version: 1.0
References: <20230117193041.708692-1-calvinwan@google.com> <20230207181706.363453-7-calvinwan@google.com>
 <230208.861qn01s4g.gmgdl@evledraar.gmail.com> <66bf75bd-b14f-2658-5f6f-8a368c1d429b@dunelm.org.uk>
In-Reply-To: <66bf75bd-b14f-2658-5f6f-8a368c1d429b@dunelm.org.uk>
From:   Calvin Wan <calvinwan@google.com>
Date:   Wed, 8 Feb 2023 15:13:41 -0800
Message-ID: <CAFySSZC1N4Jq9-nSHnX+GqxxU190Eq=PDod1GdCFirEhvyhbVg@mail.gmail.com>
Subject: Re: [PATCH v7 6/7] diff-lib: refactor match_stat_with_submodule
To:     phillip.wood@dunelm.org.uk
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, chooglen@google.com, newren@gmail.com,
        jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I agree that this patch should be dropped. Thanks for catching this.
