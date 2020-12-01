Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8F9C64E90
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 23:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E2DF22250
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 23:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbgLAXiT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 18:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgLAXiP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 18:38:15 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6124AC0613D4
        for <git@vger.kernel.org>; Tue,  1 Dec 2020 15:37:29 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id i10so1939703pfe.19
        for <git@vger.kernel.org>; Tue, 01 Dec 2020 15:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=8bF1pXZ4SQDEhmARkWEysVnUcUCb/jF4+MuQnMuAvOM=;
        b=IIrQ/aKxgrDuiDc/5QKx7IG87iezK4jCBMQyTWgMxsaf2EfKfpHvX4igb2YteaXAid
         vCys0VFnhVPAvQtK7pxkWSkIcbdt7SA21fKYK54FpIt5rONLk43vhJz6JaKVzrJAputQ
         q4a+yX4bI8pz7eutuuO/ROtb9dA+SY/PxXUYw0w0i+frM0Kycf4a6BCJU4v/PYZKPdHW
         gh2RSt7knjuIP7Cf5ivOJkUQlUdq4twog2LJ/uDPDrp29DMy6PokXL4C81TaDuczfB+1
         avrFh80hAHXUmSdOH3HbnghsUIwBvFm54/WdHzzxtjhZ2v7AFNLgCzvHEzeUJycjI2eb
         tqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8bF1pXZ4SQDEhmARkWEysVnUcUCb/jF4+MuQnMuAvOM=;
        b=fAtEPTw21HeqfJi47UP+iCSHHhsb8AcCaueLJHlN6V6ljRLaVApUvS2vwdhGFFYXvA
         Gq1vXm7+IZxopbWK3PjHhGCqVgd3bqvppNyYIZXW4Nu3EX5EVPoF8G0AgN9Vz5RfHuTV
         2UL4iUwQEByehjs8ILRhasaqMH+V8SveoH0r9Nu7LoRkCQOcb0uh/QeW/6a+o/Ijy2jc
         PTH1kByaLQUYncY/ovd675Z6a+L9wA1QEKa20T4V55rXSrrFgAnb1mIhyd28E/UDxk1a
         YiWp8DhmHh6AzqAMAuFPw/KKehCM9qrFa2Av/s0qPDMy3DpZ9IM8eGErawKrHyZjM9Kt
         dRkA==
X-Gm-Message-State: AOAM5337lGpzIueWD2VmnU+ws9NiPpM/GuqwLN/tXADy0m1soACajoko
        I1p2shl0R3SC13Z4zmNMsSY0o/AhNGz6TYHI4CuF
X-Google-Smtp-Source: ABdhPJxI97BltzJq9vte8fSrpyBV08QwLNqbgFujwcPYt3XGfGDTlY7l6ghFK1ovNS5F/ThK0OUAuu+5k0Yf3tN9XhLM
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:ab8a:b029:da:13c5:6ed4 with
 SMTP id f10-20020a170902ab8ab02900da13c56ed4mr5031797plr.56.1606865848644;
 Tue, 01 Dec 2020 15:37:28 -0800 (PST)
Date:   Tue,  1 Dec 2020 15:37:25 -0800
In-Reply-To: <X8bL7baFdXufk2jj@nand.local>
Message-Id: <20201201233725.3396453-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <X8bL7baFdXufk2jj@nand.local>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: Re: [PATCH v2 00/24] pack-bitmap: bitmap generation improvements
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     peff@peff.net, martin.agren@gmail.com, gitster@pobox.com,
        git@vger.kernel.org, dstolee@microsoft.com, szeder.dev@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I think I would like a little more clarification on the discussion in
> [1]. From my reading, Jonathan Tan wants comments about the algorithm in
> the code, but Stolee would rather rely on the commits, especially since
> the algorithm changes later on in the series relative to the patch that
> this is downthread from.
> 
> Once we can reach a good decision there, I'll send a v3 (which currently
> lives in my fork[2]).

I did, but Stolee has a point that the algorithm will change later on.
I'm OK with the parts I reviewed (patches 10 to 18).
