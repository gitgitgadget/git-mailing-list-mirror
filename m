Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84339C47082
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 01:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B8EB60FDA
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 01:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhFDBNd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 21:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbhFDBNd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 21:13:33 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D935FC06174A
        for <git@vger.kernel.org>; Thu,  3 Jun 2021 18:11:47 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id q9-20020a9d66490000b02903c741e5b703so6482593otm.0
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 18:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=TDBPPS12ILDBazV7OlNFRj3y7knNIpp0NN5YL1a315k=;
        b=E5LIieAD6gv3oFAZmnRJtL7pXheWSPAPJOqabCvPNoL3q6GMSqkH9eSpEJCzJO4HtA
         iRtskRoY8cNACyCTE6yNy5I7YGSZRmpKxRt9pcq50g7uhirs6CF5p+xZtPEhRRq3nOTw
         0MhqemuPKxH81+5j4RUQKrGbDy6IwTLFwyS1CjiGiFCwVZWqU/H18dvftpSMR1U0TlIb
         xKXTxM4BDMA+Fwx9IbgueQw3i8NagvYDRs6t3M/8gCmDeFJmxBV76MUhyliH18GN/Qcn
         e83Xar2/Ksd8sm+9GMi7BlRUG3PqNrTjsxa2trD+nMQCrZfjm2krNxe4YIgd0sdXVfVu
         YY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=TDBPPS12ILDBazV7OlNFRj3y7knNIpp0NN5YL1a315k=;
        b=CAjRU/1ctmmUYLJF5Uv4/caq77SJdCMppVD7a7LzeHZrfxkflPfXwHrzpygk5kv07/
         +Zrj4WovA00cxQOzaxKX2aELmMBG16JeNsO1wj318w+8UrpwCiPb9X5PYFsKZVLEKC71
         rJx8fL1AbCpKersEcK5DU2cEFjvf6Z3X4X+BZgKSJtCV/EFHqfjSUigT7D8SAXWXFla6
         YGLgDiaU1KSTTnHZPzvw2cBsPuDjuIQ+OoJgjrl02JXiTOPCO67+PX2tLo/XlzcS5W3U
         bFgPbls47WISGn8Ds9Q0ScuTunl886GGeS9WNOeBLepi9bcWcuH9N4j4QyGx1sbH2DZy
         3ckw==
X-Gm-Message-State: AOAM532hMRQ5iEfmFmCFjEQF3MWJlrU/j5jU2ptQudhgtJUjJHgNcVLJ
        t8EF0AW8vptufNxDkOm9Fi9aWRdDJj7f9Q==
X-Google-Smtp-Source: ABdhPJzTgYPkAS6G7dc8KZ4q8hZV/fgVihFpXduwKrwn2SEjxdS21k7X6rDtxskvd0v4TNi5DIlKWw==
X-Received: by 2002:a9d:4507:: with SMTP id w7mr1668190ote.230.1622769107276;
        Thu, 03 Jun 2021 18:11:47 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id t26sm148211oth.14.2021.06.03.18.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 18:11:46 -0700 (PDT)
Date:   Thu, 03 Jun 2021 20:11:45 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Message-ID: <60b97dd1acd9d_3a18272087b@natae.notmuch>
In-Reply-To: <CAPig+cS74Ah3OyJPNQhvkdV6f7mkFgFQjHgfrrAE1gZsvN38RA@mail.gmail.com>
References: <d93a3024-ba8d-3469-2dba-2e0032334232@gmail.com>
 <20210603180851.5tbnuvfb6auxrhvm@nitro.local>
 <CAPig+cT2fJqsptU0YpNQ=nhvU2Tu19zdHXxCin8fUkSkd97m4A@mail.gmail.com>
 <60b928374d90e_39cbe920835@natae.notmuch>
 <CAPig+cS74Ah3OyJPNQhvkdV6f7mkFgFQjHgfrrAE1gZsvN38RA@mail.gmail.com>
Subject: Re: Gmail OAuth2 in git send-email
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine wrote:
> Google requires 2fa to be enabled in order to create app passwords,

That doesn't make sense.

It's like complaining that you need to lose a limb in order to use
prostetics...

App passwords are a suboptimal solution in case you cannot use 2fa for a
certain application.

If you cannot use 2fa for any application, then don't enable 2fa, and
then you don't need an app password. Just use your regular password.

> > And of course you don't need them for the second step authentication
> > either, you can use any OTP client:
> >
> >   https://github.com/paolostivanin/OTPClient
> 
> Thanks, that's an interesting bit of information, though if a person
> can't enable 2fa in the first place, then... (intentionally left
> blank)

All you need to enable 2fa is demonstrate that you can *use* 2fa... So
you need an OTP client.

Cheers.

-- 
Felipe Contreras
