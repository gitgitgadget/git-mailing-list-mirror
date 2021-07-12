Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0771C11F66
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 16:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D77E6610FA
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 16:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbhGLRBh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 13:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbhGLRBg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 13:01:36 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AD0C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 09:58:47 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 7-20020a9d0d070000b0290439abcef697so19554902oti.2
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 09:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=fdxsEV/CMJNAg9jHoybb6UXQC7wXCqhXgdQVELEEbiw=;
        b=SXuevDPkfVI3DEmIsl5Hx9i/6z7VQoV54/CyFMvtENLwfhRTTw5Y5e7meDb49uGJMH
         F6Ux6ZIi1JhdTXQQAeXlzuNxYLMuWpUQLntDSwSmovp+udX2a6US14kLn8Kop18XkXHi
         4WGRQzrdPmbgm6d6zbZy4XSLAanfaf9Y0ReEQQfGiJ8poyapLhDD05jzoR0KQPRmj6kN
         YJ19+vcdVshdkH5anFsYJrY0kr9KedWN8i6Gk/7tCRgJW7K6iloyL6fJTYOvkBNlI6hH
         wJnHm9mQKhRtzQb3vX9aIx58aGH3PRo4PqnasJrVpleomd4J2t/7I/GhtDAOpDXqc3vc
         xhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=fdxsEV/CMJNAg9jHoybb6UXQC7wXCqhXgdQVELEEbiw=;
        b=NFAV7Yb0PrDW+FKpvjtqGw7aBtTGKpL984+LzLQkr1Wm+RurayePQM0C9+uTOrPOZr
         /Og2nWT5s0Y2/gGw5R4VKQwS7Z9shxn4M7AtZROuHLzxR/kAQWn2pbIy/O+/z4IqRtHG
         yIrWqWz5BwJsEdbBSqzQa9Pwa161EUjrH5TPZBZSqTeFySbQWfOf+34IQ1Qtq00v7rTN
         5zBTnb8m99NfrFnzxy9vAqZswtfkYhamM+cAxfDCzalq8THJJrg0DwLUXg6PQ7hGEI+n
         BEnougWYKw9XegGWO4zqMAutuymeK3/Caw1jYFmpKXBmYIj+g/e5adH74LFqmgIRd304
         OfFg==
X-Gm-Message-State: AOAM532Wyp4iYIBbNPapQXf8Sm5Zn5ha5lDxAh3N6u5VvvthHQ5+2BO+
        nFaFrXd3cf/9gwVGMrIn7TymQudKfeRxXQ==
X-Google-Smtp-Source: ABdhPJz6OmNjVZNRZxdyc03qLnwpOeAEKN3uGKCXXMLlLU6BCPnoCp09fxU+qmR5BMxCQjufilhalw==
X-Received: by 2002:a9d:2085:: with SMTP id x5mr2417618ota.287.1626109126616;
        Mon, 12 Jul 2021 09:58:46 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id x29sm2580591ooj.10.2021.07.12.09.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 09:58:46 -0700 (PDT)
Date:   Mon, 12 Jul 2021 11:58:45 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Martin <git@mfriebe.de>, git@vger.kernel.org
Message-ID: <60ec74c513b2b_a45252081b@natae.notmuch>
In-Reply-To: <54644739-2138-8086-1696-d3c52960216c@mfriebe.de>
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <877di13hhe.fsf@osv.gnss.ru>
 <c740a4f0-011f-762e-4f49-f85d1b3abc99@mfriebe.de>
 <60e67389a4adc_306ac1208fd@natae.notmuch>
 <4057b3ac-a77c-0d5f-d3f4-ad781754aae4@mfriebe.de>
 <60e736e72da68_30939020850@natae.notmuch>
 <155308af-42ad-b044-fb37-676251a9b7e1@mfriebe.de>
 <60e762243aab1_30a7b02089@natae.notmuch>
 <2b85a7eb-d0be-65e7-ecbb-1750abf53e53@mfriebe.de>
 <60e79c31aaa72_30b8a4208c1@natae.notmuch>
 <65362688-b65b-661c-20c1-94d7dc2118c7@mfriebe.de>
 <60e874e1c6845_215320861@natae.notmuch>
 <dbfa96f0-558e-ccaf-6e34-6d95c43848b5@mfriebe.de>
 <60e88a4b8592f_16bcb2082b@natae.notmuch>
 <ad58bd54-a9dd-59a9-4fce-f90be469cd60@mfriebe.de>
 <60e9f8d462bd9_7ef20898@natae.notmuch>
 <6f43b36b-abe1-41f2-6138-e820c974b1bd@mfriebe.de>
 <60ea07e3495e8_7ef2081d@natae.notmuch>
 <30e4c874-6b87-b03d-fa33-fde5b7e50b2a@mfriebe.de>
 <60ea2eb562f26_2a69208e8@natae.notmuch>
 <1e18c4ed-6975-5041-4b4f-75c4d3d21860@mfriebe.de>
 <60ec6d91deced_a452520825@natae.notmuch>
 <54644739-2138-8086-1696-d3c52960216c@mfriebe.de>
Subject: Re: PATCH: improve git switch documentation
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin wrote:
> On 12/07/2021 18:28, Felipe Contreras wrote:
> > Martin wrote:
> >> On 11/07/2021 01:35, Felipe Contreras wrote:
> > 
> >>> Do this:
> >>>
> >>>     -N <branch>::
> >>>       Create a new branch like '--new', but if it already exists reset it
> >>>       like '--reset'.
> > 
> >> Or even shorter
> >>         See the --new option.
> >>         Allows to re-use a branch-name and may drop commits
> >>         [resetting it].
> > 
> > Yes, it is shorter, but now it doesn't even say what it does.
> > 
> 
> Ok instead of " see the --new option"
> use "Same as the --new option, but allows...."

Yeah, that explains more, but what happend when you use a branch name
that already exists? Still not explained.

-- 
Felipe Contreras
