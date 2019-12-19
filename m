Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C651C2D0C1
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 22:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC392465E
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 22:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKSewrJn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfLSW0L (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 17:26:11 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39308 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfLSW0K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 17:26:10 -0500
Received: by mail-pj1-f67.google.com with SMTP id t101so3194412pjb.4
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 14:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0osw5RRFjAWNFDk6A88+K/HkAwVBhEys7X3C8uonrIs=;
        b=SKSewrJny4gvuVeaHkyDuYGMUOJzQeFmf/7YHfg28pSairIzgpetyavpzr2hMwWAML
         MrPRToFp8cwfLrsT7UiwuTDNYpETCofbanDWCkTpvk+x5T6N9p+ruCZ1L1miyu2mBBbM
         pLCNR1gpoL6eaYNKaurQXr6ymTqRbrFvOgN6zAJLA7kXfbrYdQb9YgrzS+Zv5tRBeVhR
         /e83qeauCBbM4PtJaMfFx86CURQh0XD//kauTxegbgLSw4Rt07Q68X6mT5Syw575bfFv
         D/oHyWoN48H+urux2KHQYAJA6WI4nPme4RiqTdaxAnlo1YHOFO6Rdit3XqYQTjc9SrLp
         kdgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0osw5RRFjAWNFDk6A88+K/HkAwVBhEys7X3C8uonrIs=;
        b=EzcUMXmZJrSuyqVYG+QVv53YX/lW7xDBmqs/gN57GDuoRDvmi5JNOzLnLSjQJ3dzKu
         GzkqpX/iQNStzoCz7HRKfcuxvjnE3WeNvuliCEYh7YDDiiKi6kiMnlM44DmXTX7Fh1Tx
         GubWLnZh3sL4bl0DCCL9CyN9WrJQsS4wHArWUbmOPMp9dE+FrEi+UP82uYfXF5P3/XXh
         WwNk2Nl8SHXmBqSqPYsNfGlYJuFFOprfNN8+dsZRmspdXKv1KdOhm7lqfq7qxwuqShtR
         UdfXjOnq+TrllEAOpzd5UT9UKz26BnE/bE3JZxiMx7XkX4wEVcDgUKiCTROREaqpQP7F
         27vQ==
X-Gm-Message-State: APjAAAVprZmNkZv0PyJT2X4Abdop90B2WOO/7Ed8d4Wjkm6Bdx9Yhiv6
        SHE5x7NhwUcuvWceK0WJVRM=
X-Google-Smtp-Source: APXvYqzmi9VdVQDmBI02IG4cs/lAH3rVJdVayaNLHvNXDI1HlnLJ+KGs/F8i4GorQX1IRjbHuTmIuA==
X-Received: by 2002:a17:90a:62ca:: with SMTP id k10mr12230349pjs.59.1576794369847;
        Thu, 19 Dec 2019 14:26:09 -0800 (PST)
Received: from generichostname ([216.52.21.197])
        by smtp.gmail.com with ESMTPSA id y38sm8504363pgk.33.2019.12.19.14.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 14:26:09 -0800 (PST)
Date:   Thu, 19 Dec 2019 14:27:48 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Ed Maste <emaste@FreeBSD.org>
Cc:     git mailing list <git@vger.kernel.org>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>
Subject: Re: [PATCH v2] sparse-checkout: improve OS ls compatibility
Message-ID: <20191219222748.GA63814@generichostname>
References: <20191219015833.49314-1-emaste@FreeBSD.org>
 <20191219214516.69209-1-emaste@FreeBSD.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219214516.69209-1-emaste@FreeBSD.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ed,

On Thu, Dec 19, 2019 at 09:45:16PM +0000, Ed Maste wrote:
> On FreeBSD, when executed by root ls enables the '-A' option:
> 
>   -A  Include directory entries whose names begin with a dot (`.')
>       except for . and ...  Automatically set for the super-user unless
>       -I is specified.
> 
> As a result the .git directory appeared in the output when run as root.
> Simulate no-dotfile ls behaviour using a shell glob.
> 
> Signed-off-by: Ed Maste <emaste@FreeBSD.org>
> Helped-by: Eric Wong <e@80x24.org>
> Helped-by: Junio C Hamano <gitster@pobox.com>

Small nit: the Helped-by trailers should come before your sign-off.

Trailers should come in chronological order. Chronologically, they
helped you out with your patch and then, after that, you created your v2
based on their review and signed off on it.

Thanks,

Denton
