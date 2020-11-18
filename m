Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB656C2D0E4
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 02:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74D862100A
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 02:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmV9j290"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgKRCkc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 21:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgKRCkc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 21:40:32 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD526C0613D4
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 18:40:31 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id y22so185007plr.6
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 18:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2s6sPiu4gunCbKD7mQ/+VTLn6kS0kXl8q6qI59/MCVM=;
        b=dmV9j290uMVx6urzkyphj+klwk31qFdd94OdEbhglNCOrNzBmWJV2HtZGxQNUukKcv
         PQzPBL0pp1N9STaS9bzMmuy1CZB+2oBLrK5PRhdxXI3tK6cpDnlt2Oe5T7LbtUuuxS7k
         +I6ld/RsDHbYsxTbV/YoKhxht2NQYjlZIAn1fjo5HdxE3+eaRwHFjSFOHM8zxai6myzT
         tF/drh0uBu9paNBxz44bjCz5mUOG+xhcH8WxBvgFT6O/xBTilpZmE9pQ7InfVOSNEDkb
         05L21Y4/Z1jRCzi3NKgI+o1hQOeTRmVMnkrpAsB3M4Hc4IRpgjuudyaJwUoJON4XrFUJ
         tDmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2s6sPiu4gunCbKD7mQ/+VTLn6kS0kXl8q6qI59/MCVM=;
        b=KuBwVmTT9ztUMzvoNeKE4JF/ZMOV9CzdzfKPlNb1ePpkMpS85JUv/pRngi4qIQyKSd
         mG0tDYrGP/dQzydZFmbNuCl9YlL4S9HIC+bCfNSvQAe4fn2fAPsd6gwo3Ht3axsje4qt
         nLB16GhEbDGiC+u4vM8N8nn679g3RgV5HKMTXCGBukm3C9S8lGapfChc0OUaHBSJECSU
         na+6QFHD91eTHS0LCs5YSJBd76sL8zkAl00GvTQQ4WYgHUM0TbU/2ZxymDr3Srki1EOu
         //61wM6Zwg22e/r8f6u370Wl6oy/eaHVArre1Q9WN2FGYmxKRL7zv2mdXd4oIFq0exPq
         HBJg==
X-Gm-Message-State: AOAM533oZ40cYDTwLzTKNDpmrmZRq7X9TmW3556l7O9R0B4rhS4t6Qyl
        7zDiBApVTUCB0/+Wv+dHOPTCWc/AzrY=
X-Google-Smtp-Source: ABdhPJyUm78/IDE8KzogjUtiGIVyw87MmvYWdUo6zNdE6p9ZhmQr710bYidiqw/Yvqfm1FfIyuuDTw==
X-Received: by 2002:a17:90a:ea04:: with SMTP id w4mr1920921pjy.43.1605667231472;
        Tue, 17 Nov 2020 18:40:31 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id x18sm22089079pfi.206.2020.11.17.18.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 18:40:30 -0800 (PST)
Date:   Tue, 17 Nov 2020 18:40:28 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 00/28] Use main as default branch name
Message-ID: <20201118024028.GE360414@google.com>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
 <87r1oraewl.fsf@x220.int.ebiederm.org>
 <CAMP44s2VJOd3N2zaj8YPv0iLOqTF7vWyZ=zPd9vd0+qO1DbEVA@mail.gmail.com>
 <20201117233313.GB642410@coredump.intra.peff.net>
 <xmqqr1or4jen.fsf@gitster.c.googlers.com>
 <20201118012544.GC650959@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118012544.GC650959@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> IMHO, though, all of this is orthogonal to question of what the default
> is. Unless we are thinking the basename thing would work as a default,
> but I don't think that resolves any of the backwards-compatibility
> concerns.

If we think it would make sense as the *eventual* default, we could use

	[init]
		defaultBranchName =

(i.e., an empty string) to request it early.
