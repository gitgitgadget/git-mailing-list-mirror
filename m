Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D51C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F69161103
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346800AbhIGVMi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 17:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344715AbhIGVMi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 17:12:38 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7608CC061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 14:11:31 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id t190so251345qke.7
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 14:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+3tG3dUI1CT0OEtNA5RSxxUPpe+DxKHj7Bpu9395LeQ=;
        b=aV311n2WVZi/g3O6R5Xx3WWXLpyuiV9Jr6SktnDp2qKH8rDWU7k1b+8alTWf2V1a7X
         0aOVu3JbuEg0cWs3HcEiJOWNF4bNX5DNvJo5o8Tk5RZT/vBDh2Eqna2vQ9X8FEV9mjO2
         GP+wKuN5Yvck+szr25XyhUPcECLlj1yBW3Dwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+3tG3dUI1CT0OEtNA5RSxxUPpe+DxKHj7Bpu9395LeQ=;
        b=Hkyr6om0nZPTYMVjDz9s7o8WRanI2fltlEKd4pV+PGuCd4qislstPQQP7PMT8RcUsn
         132f3QhMprrczWM2U2LLX3u5ldwP3YzEV+xFNvyNz2URT4s3kSO4D7YuJihIOLrmVWIx
         X0cdNfd1r9lLOj57wBWRwWl655owWCCRZ/0eSiNaUwAmMdHDDtDXtQHLY+xyUl/usupF
         NfbTU2iH+b3oK1XxOBU4aJv2wBLH2dS1HMSrqFxgd2qD992GNspDEMTXzkJfwbU9Favh
         qhFd1OVcBksm3Xlseb+eKoDX2Ou/hmFTHzapTBTmEYpJeuvtZ16P/gF6MBSH4dHtP4xz
         Tlwg==
X-Gm-Message-State: AOAM530byIX3sPY/q9VTdwkmZvOgSskqjggTDp0DFYfjPMfvi5LoQU+N
        r7E9SXoOpM1AkGxzFA4nVb60Q86vZ+v+4A==
X-Google-Smtp-Source: ABdhPJyp2O/idCLx7Umkhy1F+ByvRllNLgHNpnRbMajh1OuWXI33PZ29Sqpzt01Ty/aTipCZTrQFcQ==
X-Received: by 2002:ae9:c119:: with SMTP id z25mr235038qki.201.1631049090556;
        Tue, 07 Sep 2021 14:11:30 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-181.dsl.bell.ca. [216.209.220.181])
        by smtp.gmail.com with ESMTPSA id g7sm172132qtj.28.2021.09.07.14.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 14:11:30 -0700 (PDT)
Date:   Tue, 7 Sep 2021 17:11:28 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] Docs: web server must setenv GIT_PROTOCOL for v2
Message-ID: <20210907211128.mauwgxupbredgx7w@meerkat.local>
References: <20210904151721.445117-1-konstantin@linuxfoundation.org>
 <YTOW352xtsbvJcKy@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YTOW352xtsbvJcKy@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 04, 2021 at 11:55:11AM -0400, Jeff King wrote:
> Unfortunately there isn't any nginx example config there at all yet. If
> you have kernel.org config you could share, that would be great. But
> even starting with just the "here's how you do v2" part would be
> welcome.

I'll see if I can come up with something to put into
Documentation/git-http-backend.txt, but I can't right away -- hopefully in
early October once a bunch of conferences are over.

Best regards,
-K
