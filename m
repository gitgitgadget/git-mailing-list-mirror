Return-Path: <SRS0=OIeF=BS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7347DC433DF
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 09:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D01620855
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 09:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmpmoOBQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgHHJLS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Aug 2020 05:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgHHJLR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Aug 2020 05:11:17 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024AFC061756
        for <git@vger.kernel.org>; Sat,  8 Aug 2020 02:11:16 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r2so3717609wrs.8
        for <git@vger.kernel.org>; Sat, 08 Aug 2020 02:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=TTAzfsJQiVUJTw8cAKaN4Dn4PSJQ6AVPytpq3uhzCpE=;
        b=RmpmoOBQzKAj2sleRckcj4WuXmfeczHv3QfpoNnyhnI3zSLxL6PMqiSs1Eo6W0zizO
         aSheuCTXd7hc0CqnlYlhzToFLgmiOhOQX88HbMKT/p26SxTvDHNs7pQEz9Tbogdgv2jR
         481Fvje84pMIxDRqR2UFWJqMt3QrrvokVctidsrPDy8v24xrFNTgbt9e9b8Sg6v4NbJP
         k5VBPj5ViHD5v2pF2p2lnMyt5x2tVpxP/Y9GT0wRbT3xp7rSYGb/gOWOtvQzKoG5htn1
         9SQilS5KgLuc4w83mebIqN9CQCrQbng6c6sABdDVlVwAm4DmIvOCP7wQJd9Fah/lfVAC
         ZU5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=TTAzfsJQiVUJTw8cAKaN4Dn4PSJQ6AVPytpq3uhzCpE=;
        b=poSpkkqOdctI6QHRrKYQ0a9NqiwMfOI/opTKSu3HL50QnqKbHrSDGBT4gDVtRpmygZ
         4C8HKkK8b1cRh3wBpg/PgXM9iYG3fzaUZUU5vjisQHsaEdjnKk4MzsP9Bcnu1LvEUKGC
         er5p1d8NcTic38cUYrnn+WIVJnh+xp5zPHQ4tzAI8Ix9AIVN7S/+yn7WRaOezpRba7WM
         l5GAPHbivdHTrfbIBSZsHXwM3i51yNA3KdqInoiujVLVBTM24+wMUCAHAMiGh7qXTeh+
         ecauVZ1JDCC9cBdkp+u0IUbp7dF5Z1xqBM2+rJZuDpkbF2ayWHpl41PKZ4IGiB8qWa83
         S6fQ==
X-Gm-Message-State: AOAM533YMwv+zDzLsDIIlmwYKQSJLY2DkbHAPtA3bHc5z1aaIq0y23nB
        Ryf8r5EKd6+WItHA5aTfbpU=
X-Google-Smtp-Source: ABdhPJyY7pNSmX69LDnUAxE5ScyrEef/Qcjv6hWEvuUw1TLv8KIFduTnCGeNBP3KGqw5s9QegJTohA==
X-Received: by 2002:adf:eecb:: with SMTP id a11mr16035926wrp.339.1596877874093;
        Sat, 08 Aug 2020 02:11:14 -0700 (PDT)
Received: from doriath (eth-east-parth2-46-193-68-89.wb.wifirst.net. [46.193.68.89])
        by smtp.gmail.com with ESMTPSA id g14sm13124211wmk.37.2020.08.08.02.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 02:11:13 -0700 (PDT)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
Date:   Sat, 8 Aug 2020 11:11:03 +0200
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Andreas Schwab <schwab@linux-m68k.org>,
        Andreas Schwab <schwab@suse.de>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Birger Skogeng Pedersen <birgersp@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Ed Maste <emaste@freebsd.org>, Fangyi Zhou <me@fangyi.io>,
        Fangyi Zhou <fangyi.zhou@yuriko.moe>,
        Jiang Xin <worldhello.net@gmail.com>,
        Jiang Xin <xin.jiang@huawei.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Kevin Willford <Kevin.Willford@microsoft.com>,
        Kevin Willford <kewillf@microsoft.com>,
        Peter Kaestle <peter@piie.net>,
        Peter Kaestle <peter.kaestle@nokia.com>,
        Sun Chao <sunchao9@huawei.com>, Sun Chao <16657101987@163.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH RESEND] Update .mailmap
Message-ID: <20200808091103.rh5iur5sopgnlfcw@doriath>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Sat, 08 Aug 2020 11:07:50 +0200
References: <xmqqy2muqddg.fsf@gitster.c.googlers.com>
 <20200805065408.1242617-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200805065408.1242617-1-martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From Martin Ågren, Wed 05 Aug 2020 at 08:54:08 (+0200) :
> Use the one from their "Signed-off-by":
>  * Damien Robert
> +Damien Robert <damien.olivier.robert+git@gmail.com> <damien.olivier.robert@gmail.com>

Ack.

Thanks!
