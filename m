Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243E0C47082
	for <git@archiver.kernel.org>; Wed, 26 May 2021 23:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0676D613CA
	for <git@archiver.kernel.org>; Wed, 26 May 2021 23:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbhEZXyV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 19:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbhEZXyT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 19:54:19 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E25C061574
        for <git@vger.kernel.org>; Wed, 26 May 2021 16:52:46 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id t10-20020a05683022eab0290304ed8bc759so2697374otc.12
        for <git@vger.kernel.org>; Wed, 26 May 2021 16:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tRQwYVvC8gCg5Ch8qqrZsOwANLY2pKqE1ZnIQ5AfMjY=;
        b=J0wHvNBs2JOSNtB1vAhSkg0qOhLBOnSrZ1ezXSCNqrNCaXI5ELSALEiq0hBd1HGjvq
         mhKV5zoK46diJZdKJGirXatA1SsYb2DOjWgXp9UCwVEMwiTBneYbh92nZI4wAW4AfWur
         zFq++rO75umiUQ1BMcoxhnQFKZsWSOCTLEUlywcSuNfiooePyeEagwTYu08tj5lVN+Ld
         1GCnz7sneSyias7aEvquwNPJZT87su9LoEWZQGrX9Sez9E3fNi40VfnIU7rolqcHBYwA
         +lNrcMPGY1JiyEWmL0Rc8XJiAxnMU0EgkKfpEfD3SDopydKXuXB483NeVAu3jcoR5J52
         +HXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tRQwYVvC8gCg5Ch8qqrZsOwANLY2pKqE1ZnIQ5AfMjY=;
        b=rGdrJeed/u8neJmdnYXAJT+8rwAHEQZh3zSgh3BwEXpCntjggFLUx0h8k5/4WQAYFz
         9wmF7MVMe2hpkI1LPvQGyK7JG7gmW5XeLmcHGM60RQihsv2eiUDOvqRNJfTrMEmpWHpA
         OC5kBRDw2alOS8J3ZFzrfpsuhHAD0BjWKWE5NQxJsn3mqyfbqJEUEAGtC89gWqhrtT5F
         +50zuJZiEZyGkBLFMrYtCEdAJY8UIfpscPezjVG5Rq6Eif4CmLYmKUW3RRKpGRl1sjcG
         /LuSrSdX5xsQPNlMoag/iqkZFWpNG0HEo8uM8R0qvm7n/Vxbn6CQZ2zLHyk3/xd+Rk+A
         iskg==
X-Gm-Message-State: AOAM530gyxS05YdCzGLlWkxNsd+uxLYcPvJSODXJGrVVuzsc9L6YSHlU
        Yjc/CdCyiwjlDNGVpF5RoVTv8TwvOkEHXsMWC3U=
X-Google-Smtp-Source: ABdhPJyA9uXp7wLW0GtvMrkXCFmmHDHLF0X8lPgpmuSgD62F3DRPvDxbn/UxoP1J6gO4sHki2vKkV3XLlvUIDS3+k/w=
X-Received: by 2002:a9d:1d45:: with SMTP id m63mr588489otm.302.1622073166108;
 Wed, 26 May 2021 16:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAD2i4DBj6fNvq=Lc3KiXJj5uBpteyKfEKp7ATOWrTE36KUeRww@mail.gmail.com>
 <63dca3b2-1858-6708-5fb7-5a072b7b62f3@iee.email>
In-Reply-To: <63dca3b2-1858-6708-5fb7-5a072b7b62f3@iee.email>
From:   Varun Varada <varuncvarada@gmail.com>
Date:   Wed, 26 May 2021 18:52:34 -0500
Message-ID: <CAD2i4DAbBiVRo2Zk_cSYbgXGmm0SMUJZxSqYWhQr3tjwHxCYHQ@mail.gmail.com>
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
To:     Philip Oakley <philipoakley@iee.email>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 13 May 2021 at 05:40, Philip Oakley <philipoakley@iee.email> wrote:
>
> Hi Varun,
>
>
> I've seen the rather extended discussion about word choice. However Can
> I suggest an alternative split of the patch?
>
> If the patch is split between:
> 1. Test shells
> 2. Code comments
> 3. Manual pages
> 4. Guides and How to's.
>   then it should be possible to focus on the precision aspects first,
> and only later get into the imprecision of modern colloquial English.
> For the manual page changes, having a direct link to a test shell or
> code comment change would provide important support to the clarification
> of any precision aspects of the changes.

I'd be happy to split it, but I'm not sure I follow what you mean by
"precision aspects".
