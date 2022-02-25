Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25405C433EF
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 19:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235368AbiBYTin (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 14:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235354AbiBYTim (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 14:38:42 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A65FFF9A
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 11:38:05 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id bm39so5438218qkb.0
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 11:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZrHGzSzq+y+yQBPby9SIc5wAGXuAJ3qClwvYhPprmZo=;
        b=Ox3l5XxS7jgUQKiEvEm+6G51hwA54Bu/PAOI2axHNT/NL3XPNBuPG0GrxgjRdiZ69K
         P6VLdcwkan6mIo/EJfclznGW0b3JcfSBwHJIz7dgERQmrmYQndRFCf/IFC7hlBTcRq35
         Ys10+gw1BzNOxpoaJ7D1pcW6M+d4gP55LfhHlKhn5J0J3TLPw2scN1cOM6nZ4WbzKCyg
         KH75vvSj3UEgdY1xOT4DufJ3SHajb6k2w0SjUL2QYlQaomSHLAO2J2gOAtWFx0AsrJn3
         03OLwBruakd9VrChJhSiIBbLC8tfR0bSL15a2v2/F0KegbeTai68CcZWzLhg+jf1AHgw
         eq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZrHGzSzq+y+yQBPby9SIc5wAGXuAJ3qClwvYhPprmZo=;
        b=nETGF4bHQ/6y/6wfzHG/y9owqECm3GQZvtjBZn5RNGrnePmqWBVRqJeQ0/4lftBPoJ
         saRodeGJFhxPJ24sJHD1MbUsTCOG1KD1G9HDKCumu0TmqmvCGf5fK1OZFHwZL4xqjIsK
         V4ioIDdLEJc3gMJ9KK1S3nm9aOy+aDTgLWBcb0Hva4tp8PKWcBIUydvpOqmqtOAXo0Ep
         tIlkMZ1nsv/YLHqkz8SxQkIJ40WeyVDua04BgmTaLZ5XZQHWZ6aU5saCrPAuBUEvaGMp
         3Uz4GqnE0P2v7CEAMQiGnAw3sZ9HKtJw/c8w5da9ZrO2DXucSqSclhAohaBPOyQz8Xl1
         ViqA==
X-Gm-Message-State: AOAM533CNlaarjOEFA5+XwN5nmFZH2JXtGPZoe2VOmb8TX1/4/VPF36a
        1VKUD3tc/fGrv7RfqKnZamXMEQ==
X-Google-Smtp-Source: ABdhPJyuiYqIQjUCx5+3zLq6jySiPsNIwTcs7//6SV4v400CdZXfUM8ZPc7GuJk1103y1xrECtD61A==
X-Received: by 2002:a05:620a:46:b0:60d:d4af:37cb with SMTP id t6-20020a05620a004600b0060dd4af37cbmr5851404qkt.658.1645817885007;
        Fri, 25 Feb 2022 11:38:05 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m2-20020ae9e002000000b0050819df7151sm1581012qkk.99.2022.02.25.11.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 11:38:04 -0800 (PST)
Date:   Fri, 25 Feb 2022 14:38:03 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v3 0/3] libify reflog
Message-ID: <YhkwG5JGNKB2yl3i@nand.local>
References: <pull.1218.v2.git.git.1645554651.gitgitgadget@gmail.com>
 <pull.1218.v3.git.git.1645817452.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pull.1218.v3.git.git.1645817452.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 25, 2022 at 07:30:49PM +0000, John Cai via GitGitGadget wrote:
> John Cai (3):
>   stash: add tests to ensure reflog --rewrite --updatref behavior
>   reflog: libify delete reflog function and helpers
>   stash: call reflog_delete() in reflog.c
>
>  Makefile         |   1 +
>  builtin/reflog.c | 455 +----------------------------------------------
>  builtin/stash.c  |  18 +-
>  object.h         |   2 +-
>  reflog.c         | 432 ++++++++++++++++++++++++++++++++++++++++++++
>  reflog.h         |  43 +++++
>  t/t3903-stash.sh |  65 +++++--
>  7 files changed, 539 insertions(+), 477 deletions(-)
>  create mode 100644 reflog.c
>  create mode 100644 reflog.h

Thanks; I glossed over the discussion about tests (since it looks like
you and Ævar already have a good handle on how things are going there).

The rest of this version of the series (which I looked at more closely)
looks good to me.

Thanks
Taylor
