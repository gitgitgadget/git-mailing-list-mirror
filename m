Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CC1C47254
	for <git@archiver.kernel.org>; Tue,  5 May 2020 10:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D61F4206B9
	for <git@archiver.kernel.org>; Tue,  5 May 2020 10:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etIgZwl+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbgEEKMH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 06:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725766AbgEEKMF (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 May 2020 06:12:05 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DADC061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 03:12:04 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s8so885319pgq.1
        for <git@vger.kernel.org>; Tue, 05 May 2020 03:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TDAmIsAuiW6NLWLQ37MkhwCbp7rml7pjZ8+5CMqvsTw=;
        b=etIgZwl+FEORc7ZPgnUhLM/GEhoB02cBr4YXYWUJKrOr/lXWVhe1y+iFREcNLkxH9V
         BEpLyiCzBtGvL0teWTan6om73n9U4HIM21si0uwbCuzrlaWIjidbyKL/6q04qBrftwm0
         VQFfuMrUHRMHZa0z1n3qcLFdXGWh1J45j5syEI9dQ8Us90USDRCWoBJB7vD03+UjhEVK
         hHWcF9yTizlJxL8PHRHtBLl5Z1dXD5n/rcDPGVoBM9L/Y18ms+G55srk+QvZcVtg4dIC
         IAOwh7svTKvdknpCy2A4htFgIA2+dE6j39Jzn40AOMD4+1jIQC6s1bZf71JpjaRPTRRh
         UqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TDAmIsAuiW6NLWLQ37MkhwCbp7rml7pjZ8+5CMqvsTw=;
        b=i35G52mAEWf4yHsrynE/8hfWgjBZ2tRt77JJtVJFvVgeLNQgD6cAPiGXn5QmjBCdAE
         jEkJA7V3/SXpqO0s/0mTezxyWwYRFyZ3gA20vpZXoziA6mKZHm4mHtTev1J56qDOskEU
         nE1gLhFNB+zpqeXOJ5fRldlnJLARzXmmbC7CBka7GN3WEO7iILcKfhhyPJzzvRxoAviE
         hm25jzS82phuwe0eXxus9a7klx82g5CiwLrJwrgc61uJtoBZjZryQc2YS7wYLjXm/Dpw
         wRrKOGEDHf4PpOD5frHVldsRcNjJQXtflJajixle5OSjqlhpCvBaEk3Gf8SuLjSU2F6+
         MwXA==
X-Gm-Message-State: AGi0PuZSyFgkVEyHSK2DuHlIsyx9GBQq05f9XhJe0FYKujDB2pOG+PNb
        /AVd8bwm393DN4Dnhr/t6M0=
X-Google-Smtp-Source: APiQypIyZTg/Mymvrab3qHshQqwa3otWxQOKMcR/AO8+8lwj8juLbQM8BPyP+/w77svRCGX3UEfvfw==
X-Received: by 2002:a63:314b:: with SMTP id x72mr2356851pgx.362.1588673522169;
        Tue, 05 May 2020 03:12:02 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id cm14sm1575878pjb.31.2020.05.05.03.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 03:12:01 -0700 (PDT)
Date:   Tue, 5 May 2020 03:12:00 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH] builtin/receive-pack: avoid generic function name hmac
Message-ID: <20200505101200.GC1218@Carlos-MBP>
References: <20200505054630.5821-1-carenas@gmail.com>
 <20200505092421.GF6530@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505092421.GF6530@camp.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 05, 2020 at 09:24:21AM +0000, brian m. carlson wrote:
> I appreciate you pointing this out, since it was a surprise to me that
> this would be in stdlib.h without further guards, although perhaps it
> does have guards and we coax NetBSD to provide more than standard
> functionality (as we do with glibc).

we define NETBSD_SOURCE since 9a695fbf38 (NetBSD compilation fix, 2009-04-26)

Carlo
