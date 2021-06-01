Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1741DC4708F
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 13:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2778610C9
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 13:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbhFANP4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 09:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbhFANPz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 09:15:55 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEAFC061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 06:14:14 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id x41-20020a05683040a9b02903b37841177eso4570898ott.9
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 06:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=ldEiEVe92OSwB5+2p45J4QZxUFrgZOvClPnb38uSduQ=;
        b=Y3LzKxYhV0wjZTNzniWa4XGqLsYaz2OAZyDY0OTJxhv854RkFaS0dAJHjhh6nTF4mC
         mdA02ZwosseaqHLAW5sr4Xcpzcwij5VbLbWjPLbhi+tSZlAFCSYmL13JqmdfPYxmCvmq
         C5fPGiL4hknVeO5JpwI8f7smiu1GmzTeqy0J5Z34wQSmDVS1Bi1aNvSKaU5NQtqf4nAE
         IbQgmMeplXWFDqhC/rQ1biwlFSuTOFqu7oVAepdC68VDAp5t1L6JbzvBdp58KYWqexvI
         Zqzrzoxvd/zP9lqNKNuvvOx/95U62IPWUoVwYUIbHU99ZxEwqg7o1+n3QsOITJzstIgn
         ToLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=ldEiEVe92OSwB5+2p45J4QZxUFrgZOvClPnb38uSduQ=;
        b=pWazYoVorvwRwm9H6i5OMeSB1Z78XR1X6mlRnojqsZgy0V0bnOgEPrY0qcptT5jqGQ
         tcjrfe2PujVpA2auC/phVqG9LGj0WtSHsMxg6EjA0QhDjZoBL+EUds5tKNA+lrE6cKFG
         NFYPUWUhvAdkjPC0+L9xMRf1/Sq7t6f5TJfpZjMEx8XIHc8dHxwz1JqJ+v5YTVhI2DPr
         kTzCCyHIc54KUsXAH2fjaisGKMWRkJamAo73lgSNGFjYzykC5e0exmr7r27wLcUjfZKw
         TfJndZtLuVlpwcf57QSoT8N7Cy5SuBPmDMf4fjaV+jhcQq9rRtmOim91y/WwAvXN9Y8d
         JEUg==
X-Gm-Message-State: AOAM5334Jn/MvXOqIZVcB3g8pGToIBstHmbIy9K2H5ozA8h6SMsmvYdv
        gKMxHatbSGlBPgwoQ0tNg+sYcqumR6jaBw==
X-Google-Smtp-Source: ABdhPJxV7k7fGCWpklunG2whprED/XT+HcyKYKTbxLAuqXgR1AJsA08BJM0JdaM8TQKTsTrBFDNwjA==
X-Received: by 2002:a05:6830:210a:: with SMTP id i10mr22468241otc.286.1622553253738;
        Tue, 01 Jun 2021 06:14:13 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id c32sm3616537otu.13.2021.06.01.06.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 06:14:13 -0700 (PDT)
Date:   Tue, 01 Jun 2021 08:14:11 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Message-ID: <60b632a3d5a2c_e5b8b20876@natae.notmuch>
In-Reply-To: <YLYn7iMA+Ne8nbJk@danh.dev>
References: <60b5d281552d6_e359f20828@natae.notmuch>
 <YLXl5+ronWhcGh13@danh.dev>
 <60b61089ba63d_e40ca20894@natae.notmuch>
 <YLYcnwZQAEoSQKsG@danh.dev>
 <60b62665df1de_e40952080@natae.notmuch>
 <YLYn7iMA+Ne8nbJk@danh.dev>
Subject: Re: The git spring cleanup challenge
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:
> On 2021-06-01 07:21:57-0500, Felipe Contreras <felipe.contreras@gmail.c=
om> wrote:
> > Yes, I know, but I am talking about you personally. Where do you
> > absolutely need --rerere?
> =

> I need rerere in both of merge, rebase, cherry-pick, revert, switch, am=

> Don't ask me why, I use all of them in a daily basis. And rerere saves
> me a lot of trouble.

Fair enough. If you need it you need it.

But probably many users would benefit from rerere too, and they don't
even realize it exists.

BTW. I've done integrations too, and I understand perfectly why you need
it.

Cheers.

https://github.com/felipec/git-reintegrate

-- =

Felipe Contreras=
