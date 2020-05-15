Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C8FC433DF
	for <git@archiver.kernel.org>; Fri, 15 May 2020 18:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A9C72076A
	for <git@archiver.kernel.org>; Fri, 15 May 2020 18:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AO1V896o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgEOSTJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 14:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbgEOSTJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 14:19:09 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDD2C061A0C
        for <git@vger.kernel.org>; Fri, 15 May 2020 11:19:09 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id f23so1367257pgj.4
        for <git@vger.kernel.org>; Fri, 15 May 2020 11:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8jM62k9PRfNAo5NcDVzuDO/4Yp87VnK2v/mNgso3fFU=;
        b=AO1V896o8hPSqeNTWsuokXf5/JQ/utgz+OvsTGCZ/Tfsjh00JasCHm1Yl/uYZhfiQP
         rndwsx7z2U51lfE3ezS374Q3X2cCZNSPRLAZhMVo+QqEdVqLp3/CCJ0784WsgEjhMeeS
         YAEgYEmKFnibD0addFYSwDzZbLv1aSZSpsBSN2yz79HmJQyq4rmo8aIHGpsIZexLEmvl
         X84GHOnIffWQFi/rYRrtFJ4wFdVsoklmcbsZu0SKjap4DMSjRhY4WxgxGVTc3I9VBUdp
         B/AJigOjVekVTRZZxNx2ePNQ82P7foTSQ2t88zKEFvt0QW6H3VpweWR9j6WAhK3uSWPm
         CALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8jM62k9PRfNAo5NcDVzuDO/4Yp87VnK2v/mNgso3fFU=;
        b=DiS9t6o0cy1gkqu97ZXz+AH68oP1nKNLDyhScrm8uxIbgo6/zBFRwmsMzteQozLZzT
         tP+xALYJIxzV5oz2K+PWfG6PAx5+7AFI9bXn9g81TW8hf13l9SftMb1wNMf5zWwj7W35
         xuDYQqCWUUO9wNKUOtBqE9d33wwgkCVmt2ZN7Ybp/zP80Qs9IRbz1HNBVT6CJiZPLKSx
         HJNVho8sj+7UmAWdRnySme5UoxzRd9i6s+QfShl6aPG0O9rzcZxyTDjABm9Lww+LFLwk
         QXkjGCE/WNwO8tjYaZJrRgBXRBSgJmig3HYUaWsm73Vp7nwkkViTQu4AzPHmp9nozu36
         95dQ==
X-Gm-Message-State: AOAM531Yc2YX98JZLc3ZOUbt+RNb9dCkrB5e+laE66vkLLmQIQU/7u1g
        /tDyQJuGkejuPbbRkdeYIns=
X-Google-Smtp-Source: ABdhPJz/g3EN4N5jZj/wWvVfd23EgVq6L4jqSQDDo8KR3I6CsYtLpMzt+3lQ2F4K9p504xgU6cQp8g==
X-Received: by 2002:a63:a84d:: with SMTP id i13mr4047023pgp.342.1589566748601;
        Fri, 15 May 2020 11:19:08 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id b1sm2476970pfi.140.2020.05.15.11.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 11:19:08 -0700 (PDT)
Date:   Fri, 15 May 2020 11:18:12 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, emaste@freebsd.org, sunshine@sunshineco.com
Subject: Re: [RFC PATCH v2] t4210: detect REG_ILLSEQ dynamically
Message-ID: <20200515181812.GE61200@Carlos-MBP>
References: <20200513111636.30818-1-carenas@gmail.com>
 <20200513180213.45866-1-carenas@gmail.com>
 <xmqqy2ptkrhp.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy2ptkrhp.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 15, 2020 at 11:00:50AM -0700, Junio C Hamano wrote:
> Is https://github.com/git/git/runs/678964255 related to this change?

yes; when built without PCRE then fixed can also trigger REG_SIGILL

Carlo
