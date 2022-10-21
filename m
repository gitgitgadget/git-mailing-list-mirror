Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2F7C433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 03:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJUDP6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 23:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiJUDPy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 23:15:54 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F481382C8
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 20:15:35 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id p16so1274460iod.6
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 20:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eamp3O1e7leJjRskoKZkbVh52ljXEQ3jeKl0kUiou8A=;
        b=EFg4fos4u2lQDMAvpt/tqLNF3iu2iYihdewNan5It9GQrT79tygUWtCMwSs30BoCfx
         0wG+yuTAcVEy80dZGNJt7OpOzMp/TQYVcCLcnspFeQP4gbMpTUK+Zjegpu9wIsmBubPY
         /gMjal491uRvWjlj5Ru9D5YaRrMK/BwVYoEWw5JWZkbAyz5Qmp/1bqXaFHRYtufQ6ebw
         PwQGHbsLYk51uyxdGm+LxHLGq8pIyfD6/y/5UmNPPWMssNvP/MUyNu9KwKAI+c/xAu59
         WBvzWUIZ+EfIVvqPdmjEE6frOfJfUSu2c/ryq1a4ktyjeukyTASSCNp4TrislRwMxyST
         qCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eamp3O1e7leJjRskoKZkbVh52ljXEQ3jeKl0kUiou8A=;
        b=JHjhe5JTPuCSbhXroPNOyCMuBh1y8/u55e8f+w1zDR0qB7fhyHSF6v2FtP1zZdv/un
         faLkl3j3D7DESP+6iERA2S3JzNE0G6cuj2ZgBpytjBtWVfBhrnFcaxj8znOGljbNUzoo
         pB/W+/1mPAjBuIDycAtmwIfQ6PqOhH7tS0UDTyEQM09/tqbt1bNSulIzHFvn4c6Y+vaA
         bTrzzYLwhDst2Uv5LPbL/XmN09WA5MGg27giBTYQqS8A6sL130zCXfkI0eoLoHwzw3HQ
         LKP5sSPjyGpJl35fFV/WJb/b9WZQFrHoRK5LXVwHSLCyQ1yd9+y7x3Hb7qnmw4VdRizU
         QnAg==
X-Gm-Message-State: ACrzQf34jRYMRk23rEq457tL4zKVRfmy5e0xLD60HcNVfMMNyrdg1Jfo
        QDMGVdhJvwxtEhfpjrnHPtnOeg==
X-Google-Smtp-Source: AMsMyM4oYQbqW4T7x+pO9sCC2OBd4ZQAceiwuWdg/POcGxfgq+s/1FDiV+RtmdPLWUhdzAUBptV50g==
X-Received: by 2002:a05:6638:3285:b0:356:4df5:5d10 with SMTP id f5-20020a056638328500b003564df55d10mr13815973jav.19.1666322134953;
        Thu, 20 Oct 2022 20:15:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f10-20020a056602088a00b006bb7764890dsm4106432ioz.45.2022.10.20.20.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 20:15:34 -0700 (PDT)
Date:   Thu, 20 Oct 2022 23:15:33 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: tb/remove-unused-pack-bitmap
Message-ID: <Y1IO1egsi9vZPiUo@nand.local>
References: <xmqqa65rnuvv.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa65rnuvv.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 19, 2022 at 06:31:16PM -0700, Junio C Hamano wrote:
> * tb/remove-unused-pack-bitmap (2022-10-17) 1 commit
>  - builtin/repack.c: remove redundant pack-based bitmaps
>
>  When creating a multi-pack bitmap, remove per-pack bitmap files
>  unconditionally as they will never be consulted.
>
>  Will merge to 'next'?
>  source: <1e0ef7ee7ff5feb323c77e594cd65433fb1d99f7.1666061096.git.me@ttaylorr.com>

Yeah, this one is ready to go, per Peff's review:

  https://lore.kernel.org/git/Y05HrVT9HxxDiXc2@coredump.intra.peff.net/

Thanks,
Taylor
