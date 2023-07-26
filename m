Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8C1C001DE
	for <git@archiver.kernel.org>; Wed, 26 Jul 2023 23:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjGZX0x (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jul 2023 19:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjGZX0w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2023 19:26:52 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7793D1BD6
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 16:26:51 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-c11e2b31b95so292731276.3
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 16:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1690414010; x=1691018810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=50kg+940a74lvh0tpUW52moSqhhgqVxBvidP7fo5MGc=;
        b=SVxN68lEo+317TjYtreJhYL3rIpQh5/81ZTklZuMk5dfi09Yv/SPdz+dfiBC9+WGJ4
         V27yYX06fpRubORsSvbs2687tir3c+Ca1LzVDs5clLiSw2QlaJ38aoFYKnQSZKhnbOMP
         5j4KbgCXIolc/79h4kHTVnoV/K7EvMVNdpsVBzAd7VklhC8ziEG692xr4H/FBVvXTcMj
         tHtQviFeBO87q0BRXI/xNZBr2p5jLLT4uRoOdRfJY/7SzPii1+CIiYNcLOPSz4V1bs05
         yK4mxKfuB22hcx86XEul12BWKCntj/U0Wg0Pc/V2omu2M4c8CAMUdSvmuOxvzo5xzxyc
         B/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690414010; x=1691018810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50kg+940a74lvh0tpUW52moSqhhgqVxBvidP7fo5MGc=;
        b=BwxpYJ70LdvFr5xsA2ahJ8Qy2JyEAct0UqQpTNxrELPjRmq4oWp3202OBjOxPmU/w4
         qks9NZemW6czR4ArjgyVFD+YMdCBg7FTdD2TTpVy/MY85lbj2ySBr/l1rP1AG4MVecVS
         tbwQmB++KOBgLkeSsQTsjtW8PaCvm1hwUQFm3mdPBaKgIiumyAHd03Rx4CwE/2Q87JFy
         L+adRqlEAWM5gAC5PB4Xw3WA6jhrY+b2ZHtRexbXGDeloZHOcDkPpCAOnw7pr/L6GIIV
         qRRBTRCc3ueoy8FEReRFFayRMpaUsnxt6Le3vBBE4oNSPD1z2AR4NqEXFSbapWXbsw5h
         hs9Q==
X-Gm-Message-State: ABy/qLZmM0LPJyEWnX55cumvQeUEIZzMbjtlq5rhAE9/HYakYQdJnk31
        2up4fIa77CGWu693ZacgV3QOww==
X-Google-Smtp-Source: APBJJlGs/3aApNtrFbdc+NHcq4aHll8+QLZjtWojj7fdGHuzXM6ogcSCmVJ7LkO2jX38wuDr28KTzA==
X-Received: by 2002:a81:8941:0:b0:56d:3b91:7e78 with SMTP id z62-20020a818941000000b0056d3b917e78mr3614800ywf.20.1690414010583;
        Wed, 26 Jul 2023 16:26:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w5-20020a818605000000b005773430a57csm92754ywf.78.2023.07.26.16.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 16:26:50 -0700 (PDT)
Date:   Wed, 26 Jul 2023 19:26:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 2/7] t/helper/test-read-graph.c: extract
 `dump_graph_info()`
Message-ID: <ZMGruenDbAo22aWV@nand.local>
References: <cover.1684790529.git.jonathantanmy@google.com>
 <cover.1689889382.git.jonathantanmy@google.com>
 <1955734d1f7385ccc1bd3bb189b72e36d8a9b6ec.1689889382.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1955734d1f7385ccc1bd3bb189b72e36d8a9b6ec.1689889382.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 20, 2023 at 02:46:35PM -0700, Jonathan Tan wrote:
> From: Taylor Blau <me@ttaylorr.com>
>
> Prepare for the 'read-graph' test helper to perform other tasks besides
> dumping high-level information about the commit-graph by extracting its
> main routine into a separate function.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>

Missing sign-off from Jonathan?

Thanks,
Taylor
