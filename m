Return-Path: <SRS0=levB=AJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EC7C433DF
	for <git@archiver.kernel.org>; Sun, 28 Jun 2020 10:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C900120768
	for <git@archiver.kernel.org>; Sun, 28 Jun 2020 10:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VE5gNUN6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbgF1Kh6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Jun 2020 06:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgF1Kh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jun 2020 06:37:57 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFCFC061794
        for <git@vger.kernel.org>; Sun, 28 Jun 2020 03:37:57 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 207so6468586pfu.3
        for <git@vger.kernel.org>; Sun, 28 Jun 2020 03:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vdjb/UxaWWGuPFTKonxaiHT2Hl2eXWchoiXxeBY3ko8=;
        b=VE5gNUN65puDGopXc8KPZ5/3nqQpkcPgaj0jhC4SUCdw47w2b8vKmdcVj4ZL50/jpy
         sSboUOG/Wx+ehcop4MepoeeVyj+Jl+OObTsjgM8Necxr7NGuaGgQlkIa5RLtZiA4RwgR
         BUncXiucRykVfLiQU94sZk+MCPu1NT6NcIkF1Q2JIoH9NsdYskX9Bd29+91Bst8GQaOW
         +zavPEgpOUwzqMEBF/sQ7/XSlOSeSOzGv95/8/kKtLfG3p+DGsQi+f2wp5R2q9Y64xjo
         RVTIbp6SRHSmYKZPX69kwUkXvl/MGDNXwnwQ2lEN6BjvwSp5wsx3XQsCju+MrzUw3+UG
         sVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vdjb/UxaWWGuPFTKonxaiHT2Hl2eXWchoiXxeBY3ko8=;
        b=c8kflUPxA7HkkBRJFNdKgi2mcfhWOMaoNMeVbRxx/d1kqZtPQVW70fghOCD0vVspEw
         SsQYP3p9nv0LsCSVBIcamFr0a+CYQopZUsVdK2v9rBmEpSQOSEiVpWpbcv29xVvgemf/
         l9juuA7NobwUxWNhORDCgTt17pDj5O9AA6ZRrtIWGgaPiex7m7poaViiRONWlgP0m3ff
         yZVo4DX1PdMAtMvCdyuhFYEK6AhGZ4Cqxnh/vNPjKESuPpArvFKc3UfMW3D1g9kTZ168
         T0+eEpMGyxccZgv9PTB7ZMjJurbjA0mHOwYHIDYCb4D7m50NG7lLIE50v9tZkNqtVsm+
         mj0A==
X-Gm-Message-State: AOAM531PagLnLhAnHbIAUt8kJtx4jogt4vOSRj9X7ZTUg3wofsYmyZYu
        TbPVB8v9762KCPwnBonGzAA=
X-Google-Smtp-Source: ABdhPJxHag8Vmvgdq/C5NVLUpfifvGEtKrrdS3s+/9GmvRKwpBH4jxQT12fhhQuxVSpdbnO71/PK9A==
X-Received: by 2002:a65:410b:: with SMTP id w11mr3420841pgp.65.1593340677505;
        Sun, 28 Jun 2020 03:37:57 -0700 (PDT)
Received: from localhost ([2402:800:6375:9968:2644:616c:71ad:c7e6])
        by smtp.gmail.com with ESMTPSA id x2sm30668261pff.103.2020.06.28.03.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 03:37:56 -0700 (PDT)
Date:   Sun, 28 Jun 2020 17:37:55 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     lin.sun@zoom.us
Cc:     'Pratyush Yadav' <me@yadavpratyush.com>,
        'sunlin via GitGitGadget' <gitgitgadget@gmail.com>,
        git@vger.kernel.org, 'sunlin' <sunlin7@yahoo.com>,
        David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2] Enable auto-merge for meld to follow the vim-diff
 beharior
Message-ID: <20200628103755.GB26319@danh.dev>
References: <311401d63e0e$b1ffe490$15ffadb0$@zoom.us>
 <0c2401d64d14$aeafa680$0c0ef380$@zoom.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c2401d64d14$aeafa680$0c0ef380$@zoom.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-06-28 14:23:43+0800, lin.sun@zoom.us wrote:
> Hi Pratyush,
> 
> Could you help to review and merge this patch?
> Or do you know who can review and merge this patch please?

It seems like only David Aguilar (Cc-ed) works on that file.

Look into  b12d04503b (mergetools/meld: make usage of `--output`
configurable and more robust, 2014-10-15), it looks like we need to
check if --auto-merge option is available in meld.

Someone still live with the ancient tools ;).
meld has known --output for a long time but we still have a check for
it.

-- 
Danh
