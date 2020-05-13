Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B562C433DF
	for <git@archiver.kernel.org>; Wed, 13 May 2020 19:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A3D3206A5
	for <git@archiver.kernel.org>; Wed, 13 May 2020 19:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuWPY8PT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390515AbgEMT27 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 15:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390291AbgEMT27 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 15:28:59 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A84C061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 12:28:58 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id z1so485765vsn.11
        for <git@vger.kernel.org>; Wed, 13 May 2020 12:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hf1WDvIlOCOs/ejogB4ybeDiuTN1Kld0KHjpjSKI7CA=;
        b=OuWPY8PT6j//PonG3WOBy4mRKvZDuo5fMRyUudCcIRiJlq5punOfuwPgtMXAr6caBZ
         FY7s2fBypqMvpRIz540QrXJue0WmEhyjN1NjDfc3VaumCU+qEsW2HGkqwjATqTnysgS0
         U9cUqvrmK+5UhJqaM0bt7lRpHJ9qahS50tn6qg+HN7ybJhHjy26l+7C9Fs2hHnjHWMDP
         lGUmCkISr03WoWYEe0x/Gi0uoUHEu/a0JgrUdhVWms3a7QpV8qJKtxKW6OWqZDWNeQUX
         qGbg+KlsSizJiOPQ9UeKpluLEKsMOg4DgMSVeO7uLUNeSBb6/UZt/+4UuWdlkJKit15+
         eGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hf1WDvIlOCOs/ejogB4ybeDiuTN1Kld0KHjpjSKI7CA=;
        b=SEPWXM6t2cE4EiG5vLRxYcNzH50+BYqz3ofM5jWsCFNP7mS+HtRxfpRMlyws3htAnQ
         zITYA68c96m/dzDfZ9R0867zkKSjHZzKW/TqWTVLaBT+P154JqPB0XWG6mjQJRJ1EPef
         enJj22aUIvrOIE1tteYnQJ7mZvwVq2rTGk+6bLc94YoDwXcTZac6ZduGMOl+n6bsBV+f
         CMj6OUYQHUi7HkMdq3bQBvkiFm5b9mFD14m8EymmDcxlndXVRCsRQOgDIgYFu7lCIRjh
         R8xHw2rSajmaj9lECwkFXMUb6+5Q+cGRJDf5Ai2/nG/3vWLNG3libzf1dSWVOnUZlK3J
         IVWA==
X-Gm-Message-State: AOAM530FAveMBq6S6SPHyZaA6syXX3wYQuQgYLzFWqfz/x6g/qgvrsE2
        yuyJThO10fT2NvZ2IOvYvEBK3QiAdI8OZrKCQJc=
X-Google-Smtp-Source: ABdhPJzthIIuO7XXYZ+QrWhduYtwt1yoKP137CZ0SBW9vjARbt5fesCCufB9pnSYPRL2KDUrOO0+LGSex2VjhVYTY/4=
X-Received: by 2002:a67:b91a:: with SMTP id q26mr653961vsn.118.1589398137384;
 Wed, 13 May 2020 12:28:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200513005424.81369-1-sandals@crustytoothpaste.net> <20200513005424.81369-3-sandals@crustytoothpaste.net>
In-Reply-To: <20200513005424.81369-3-sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 13 May 2020 21:28:46 +0200
Message-ID: <CAN0heSqYsTZDnTG+roZ9pydUcEXJBayWXnijOcAZqb3-Rqegjg@mail.gmail.com>
Subject: Re: [PATCH 02/44] Documentation: document v1 protocol object-format capability
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 13 May 2020 at 02:56, brian m. carlson
<sandals@crustytoothpaste.net> wrote:

> @@ -189,7 +204,6 @@ refs being sent.
>
>  Clients MAY use the parameters from this capability to select the proper initial
>  branch when cloning a repository.
> -
>  shallow
>  -------

Looks like a spurious line deletion snuck in.


Martin
