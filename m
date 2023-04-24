Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3D8C77B73
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 13:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbjDXNnn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 09:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbjDXNni (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 09:43:38 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB50974F
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 06:43:12 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-187af4a5453so1519458fac.1
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 06:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682343790; x=1684935790;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFu1FdTAyXGnsGTjGEJXev0CbkAO1It/7/9omxu2dgw=;
        b=diZS0/GM5pm1fz/q/GVeL5IJ7YjprGiy75wzQAlHLZZo+MOB+95HQwOCkZAnyCa8w0
         ufZf9W6XMgeD7KRhzTUHhb2O7IzFcb0d+j2B0axcPDaePiO+E7vHoVg0ly+FiNhKWVXW
         P/0r1OIikko2ijGa32oORonNdB6M/D+Egq5dsfupxIrf+PR6mqDM3YUFuKAIRawb/YGT
         ERXi/CRQtTA9C1RhDSyvocVc9QlGffNAzCt48mGBbYXbDVgvrVYFGjkVr8kKhdmtj/te
         IwFhAv+JIAYR/0s3l/HjvQGn6HqMdI6Sg5Ldbh5Vh+yZdthas/Re/T7OJXvSmp9MO5ak
         wjMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682343790; x=1684935790;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HFu1FdTAyXGnsGTjGEJXev0CbkAO1It/7/9omxu2dgw=;
        b=SgdX2wXXFPaWW73CveKvzaT2xn6cGFh+mbeyH34cPXjQQx1T3tNqhRwjq+Vpd9LgAw
         3d8jTQ3dj1LV1LGk0Mszdah2FcCPzS/to+gFBCAjCqm/kkyAG2Da+9YB1MWSAQQnA0E3
         RvUDuGWhT3LXLx2CFTQY4EzeUFk3nRitRl+KatB8BXOreUWj0zbT673shC94Cn1mQ6w4
         Svlq/vb/gWh6+8zevsVVaRzXQW9F2f3c+oWTZr/julwM2fT7MNwvrvmttbbi71/PA1Or
         n3wOIThmpSMiVYTmjFVaCc4VaQmE5nQz7eqJZtQDwPxmTCU7KUIHG/hDH2ZXM1N7PhIw
         3hnA==
X-Gm-Message-State: AAQBX9dAOmY/+yHEnXmGJhcrwXHfFKq5Gmtm96ERduajIjgvkxH2lDrL
        JKCX54qZ+g+toWlEQp2Iyy8=
X-Google-Smtp-Source: AKy350buN3pVFh7Sg9d1EDVgTxZ2vsneroJqjsIpkJ7ZMwKSdaLhfBt8FTAYcaE7CNEuvfaZoF4yug==
X-Received: by 2002:a05:6870:610d:b0:187:8260:2f8 with SMTP id s13-20020a056870610d00b00187826002f8mr10679351oae.6.1682343790386;
        Mon, 24 Apr 2023 06:43:10 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id k3-20020a4ab083000000b0053479edbc17sm4792034oon.33.2023.04.24.06.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 06:43:09 -0700 (PDT)
Date:   Mon, 24 Apr 2023 07:43:09 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Koichi Murase <myoga.murase@gmail.com>
Cc:     git@vger.kernel.org, Justin Donnelly <justinrdonnelly@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder.dev@gmail.com>,
        Edwin Kofler <edwin@kofler.dev>
Message-ID: <6446876d2e22b_aba294a5@chronos.notmuch>
In-Reply-To: <xmqqh6ta3485.fsf@gitster.g>
References: <20230420074616.1642742-1-myoga.murase@gmail.com>
 <xmqqh6ta3485.fsf@gitster.g>
Subject: Re: [PATCH 1/2] completion: quote arguments of test and [
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Koichi Murase <myoga.murase@gmail.com> writes:
> 
> > The raw command substitutions $v in the arguments of the test command
> > and the [ command are subject to word splitting and pathname
> > expansions. Even when it is ensured that the variable is not empty and
> > does not contain whitespaces and glob characters, it can fail when IFS
> > is set to non-trivial values containing letters and digits.
> 
> The above sounded good before I looked at the patch, and it still is
> good in theory, but it start to look mostly academic especially with
> enclosing $# inside a pair of double-quotes, and the variable would
> have only digits.  The same for $i and $j that appear in the loop
> control "for ((i=0, j=0; ...)); do".  The story is pretty much the
> same for local variables we set outselves to signal our findings,
> like $pcmode that is only set to either 'yes' or 'no'.

I do have the same opinion.

Although the result seems more proper, I fail to see the actual value of doing
all these changes everywhere.

On the other hand I do see the very real harm that they would break the
git-completion branch everywhere. Rebasing those 50-so patches would not be
very pleasant.

> In other words, this patch looks way too noisy to be reviewed to
> discover its real worth.

Agreed.

-- 
Felipe Contreras
