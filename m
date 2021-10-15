Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BA1C433EF
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 16:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30BB161181
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 16:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241292AbhJOQ2a (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 12:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241266AbhJOQ23 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 12:28:29 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63380C061570
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 09:26:22 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id q19so8799775pfl.4
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 09:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tCg6c8HCUYUoInQEB/3cPd1S5z9Xa+aDCCJV9wCNHsY=;
        b=DsdxB+nuDVpF3fVVkLj83hmDsbdPiqq5vRIZYAM1EjjBV5FAsNZMFpSm8KfGdNTKww
         VScysDJlgt8FZdDg9jEpzLbufRqmG7SDSq/pEWPmTunfki+S2zj0QGKraGM9mkxh6KyO
         GGQ+0M2uHHlyee+vtdjV0StWEBtro7o8d8V8fpMpsFyarvvphW27vDPTX8ejrbiOoyCm
         3TKDv4frK3l78h5eZVe/vKJGOSLlUxMQ4Y65ZXB73V3MtI3XqEQgD/CDBH8WjxvUY+AW
         Sg7mdj0mlWgX6HYNir0MThNb9ZWTx36WA+WQAhSP+AUSJu7EdH3WM/UMY3TpNHY9FIS8
         sn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tCg6c8HCUYUoInQEB/3cPd1S5z9Xa+aDCCJV9wCNHsY=;
        b=5VFbo60IyPORaczA7w073TJ3hN6cn2S/JYvxItOMwNroCWcXu0WIz+29/PRJjfJVSU
         Cn/S0qFeO411liqLj6VJ2JBe6BGJ20UufSn9yEw1gICnaQQYyDcs9z1DVIryA5AMHWa/
         MtC7EO05mavLDHEZyFG0MTpQpEclt1RnO7yR8fBlc0InvcyPWr2tXEx+3luUNu3bzpf6
         W/Hiu3F4j8AR/sW28+iSSzwM5Rpnm2h6WnTiJ2uVi2FfJoo+iL/Ri9LZpcb+lI0jKG5M
         KHZj+xByeUzSVL5rv+fwx++zDCkmWlnGcp8iGmcvk8eO4JDc26Bw4Hj5hl51yzAzDt8L
         YSqw==
X-Gm-Message-State: AOAM5308hrAg8xgBRSBB9sk1cIeNsJQGHA+05a8dxR0Hm3P03qGqQ3Rz
        qprT2D5aLc/IF0B9Y+iR3iYC4A==
X-Google-Smtp-Source: ABdhPJw3ngOF+mwSI28hlHh8O/GS2D9BLryLMNuyG328qbyGKSY6e9CNuA1Nqja9RYensgP/FJzu1g==
X-Received: by 2002:a62:5f03:0:b0:445:38d5:98bd with SMTP id t3-20020a625f03000000b0044538d598bdmr12752638pfb.81.1634315181610;
        Fri, 15 Oct 2021 09:26:21 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cc2f:afb0:ab09:f218])
        by smtp.gmail.com with ESMTPSA id kb15sm5848798pjb.43.2021.10.15.09.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 09:26:21 -0700 (PDT)
Date:   Fri, 15 Oct 2021 09:26:16 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 06/13] merge: convert post-merge to use hook.h
Message-ID: <YWmrqJetzyi2MbfI@google.com>
References: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
 <patch-v2-06.13-327f916f8c3-20211015T093918Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-06.13-327f916f8c3-20211015T093918Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 12, 2021 at 03:30:31PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> Teach post-merge to use the hook.h library instead of the
> run-command.h library to run hooks.
> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Reviewed-by: Emily Shaffer <emilyshaffer@google.com>
