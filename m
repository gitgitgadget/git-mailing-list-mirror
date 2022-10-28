Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705A7FA3743
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 21:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiJ1Vyu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 17:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiJ1Vys (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 17:54:48 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FB912605
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 14:54:34 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id c24so5949098pls.9
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 14:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cyKnwpQIQg97QxqxAvKLgH1fiOUcYlTJWs6ULEDKhBE=;
        b=DP+JzNDoJyr0aC4VQ/H4rqgIoZMSRPkU3haPxDXOrqbYITy1gr5gy97FS7VOf7Trj7
         KMm/SBVflr+d4ScpNFj53MJ6pb1MHCxGhKfdHivh9ZVmDQMLpIVa9HUfar16Nd91mrwe
         6BSyykgBP1akdwCzfL1KMC1JvqsLXZXnolSeD7sbQ7FfluD1TXkFmdDz3S9opA/cZ8mB
         dVQBlF4Fh3Cg6k13hbhXTIhgsJP6b0UzpAuIwfWdlOV+KdHRlGxiOskiT+BcFi7fkUzo
         UniKpyQcRt9QFY1/2fUJqzpgcVcaY1ugTrfdY6CgCyK23ikr3csV+tAPjHy4JGU9Xl40
         YFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cyKnwpQIQg97QxqxAvKLgH1fiOUcYlTJWs6ULEDKhBE=;
        b=2y64tHA7ZqWjckVQo/IOVXRJLnDwHEnv7JIXe6H7Wrg0NqZ1ZwcfpCDRQRw31qFflH
         S5+7a1DwGTUSeCmmWNyoNcoBQeXstNFERWO5M21DWeoMAlJwKFatAsdPFted21MhMuh+
         H92h/oS8GVNmmIkFC/w5bNQaiQsHCbbj8DkwYpRRQtoke6mR+3BzE5EKAqZd5h7N2ewx
         Gjr7/OkHluRBOhCsrC6StLcCY+ZLeQJZeq0plFTyeWJuEfDPwT2wEOaGE5RQ5qC/qWCx
         nEyp+Q2FfUMEBfrRCAby+ya1PWBn6sV9gyYGx7c2h9tilFj8xpIQfs3vORSsGXYXH5eW
         V8dw==
X-Gm-Message-State: ACrzQf2GxZRXGb6AE5HFzHVanjyMLliuQvJNItgvRSF/VhX5nE3Xdx3F
        EhKWa46T0tj8nkSIzG8AKSA=
X-Google-Smtp-Source: AMsMyM6XZqQiQpmevjojYr4ypd6EGCXWwhE8bApR7dqFCL0KzATE1KqHScdHuHAY2Ea0WBXhUgdKmw==
X-Received: by 2002:a17:90a:428e:b0:205:d5fe:e0b3 with SMTP id p14-20020a17090a428e00b00205d5fee0b3mr1409930pjg.33.1666994074152;
        Fri, 28 Oct 2022 14:54:34 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id x7-20020aa79407000000b00561dcfa700asm3284284pfo.107.2022.10.28.14.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 14:54:33 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v3 1/8] clone: teach --detach option
References: <pull.1321.v2.git.git.1666297238.gitgitgadget@gmail.com>
        <pull.1321.v3.git.git.1666988096.gitgitgadget@gmail.com>
        <432bc7cb3a42cf39d0033701c2cc677c9109b3dd.1666988096.git.gitgitgadget@gmail.com>
        <xmqqmt9fhbjt.fsf@gitster.g>
Date:   Fri, 28 Oct 2022 14:54:33 -0700
In-Reply-To: <xmqqmt9fhbjt.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        28 Oct 2022 14:40:22 -0700")
Message-ID: <xmqq7d0jhaw6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Wouldn't it the same thing to do "git clone -n && git checkout
> --detach"?

Not exactly.  It still creates the initial branch and points HEAD at
it.  It is so close, which is a bit disappointing, though.
