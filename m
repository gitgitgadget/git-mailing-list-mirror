Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D836BC433DF
	for <git@archiver.kernel.org>; Fri, 15 May 2020 17:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A31D820727
	for <git@archiver.kernel.org>; Fri, 15 May 2020 17:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGNbqxeJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgEORWK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 13:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726170AbgEORWK (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 15 May 2020 13:22:10 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E61C061A0C
        for <git@vger.kernel.org>; Fri, 15 May 2020 10:22:10 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id q16so1158283plr.2
        for <git@vger.kernel.org>; Fri, 15 May 2020 10:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IVn68xO1FLhNfysyaNGRSMd0ctEwEza4s3J+PnWK8yw=;
        b=bGNbqxeJxqWow1pVD5qo5DhTZPmpEy3T5erKCM5tXNOwVjXN3oMeoYhCJVsc/AunPU
         xL740vQaNf2O65tMhzFjezDFn92YDPDTw2/YH4ORueQJZDDyC73V9r6GIncpLn+Bme/d
         xezlcWD4yx4Oueef3w7LkJOdU739p/Cr7bShAcBRBT6n9QDLlh3FdrdvPbM3gxS72vrZ
         JolaqqR+U1nznRhJuxRLDhR2ds/WIRiQh4OvqieIfc0cKMvhzLgYIBIlymaSPhacgCi2
         ZD8ex9Ahk7+aC0CMvNESjscPc4Gn+6CaMBbmsVwcZpkSEgFG2qhP+7WmPqcyRoMulxF3
         qJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IVn68xO1FLhNfysyaNGRSMd0ctEwEza4s3J+PnWK8yw=;
        b=kWhv8xeH2ZqgSCuZBcWCBsmspoLp6NV/f/X5TnKND4IZoejWkK1J0HzcFCGq1VlKB0
         GAz5xcn/nYuEpqdC/kZu01JLK+9fFOeyNQfiurpIAJrqGWdn7KP0VKGRvxYLRe8UHmob
         0DDGBWQJToj6AN0JezDUakfw/fk0DdW2MhuVMa0bWYe3dz5x5QUhPmSEc7xL9sAw1YI4
         OjbeFAiIzFigcCA3F/rKs+dFXjcdoo51+9EJEWA0cj8dw48FBvUGh4Hr0n8eK6Lj0QHa
         oZ0jVVBwhmVJ06FQ06XNdXjQSbUGq3/k7vn4OfwSa9zisW2hjY2mViUoRzFBqLQX79Da
         8pfA==
X-Gm-Message-State: AOAM533gFZHUlRL1oGcCt7SDwVnCgzdu5DNrMu3ksOBAH66uTfYQFF2W
        jp4K/6W1trxHKdBjkzO4mNI=
X-Google-Smtp-Source: ABdhPJx4qOJYdxetE6QRvAxJMRoW7DALMQGgcs/QOVz/8DXZ4eW2RKv9cmVgBY/Rz1wRwfOUalBbEg==
X-Received: by 2002:a17:90a:fc8c:: with SMTP id ci12mr4707141pjb.104.1589563329946;
        Fri, 15 May 2020 10:22:09 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id d13sm2173965pga.64.2020.05.15.10.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 10:22:09 -0700 (PDT)
Date:   Fri, 15 May 2020 10:22:07 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, alban.gruin@gmail.com, congdanhqx@gmail.com,
        johannes.schindelin@gmx.de
Subject: Re: [RFC PATCH] t: move metadata into TAP test description
Message-ID: <20200515172207.GD61200@Carlos-MBP>
References: <5b373748-d986-1aec-670f-7ac1502e7052@gmail.com>
 <20200515150041.22873-1-carenas@gmail.com>
 <xmqqpnb5m9w1.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpnb5m9w1.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 15, 2020 at 09:38:06AM -0700, Junio C Hamano wrote:
> 
> Do we ever run our tests in ci environments with a shell other than
> bash?

the alpine test uses busybox, and the cirrus-ci job uses FreeBSD's sh
but most of the other tests (including all windows jobs) use bash and
therefore can benefit from this as shown by :

  https://github.com/carenas/git/commit/5517179c37904e9b8ac6408fa22643759e91538d#annotation_205089161

Carlo
