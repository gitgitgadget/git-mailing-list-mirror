Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E15C07E9B
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 09:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 590FC61279
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 09:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbhGKJz0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jul 2021 05:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhGKJzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jul 2021 05:55:25 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64122C0613DD
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 02:52:39 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id s18so17494750ljg.7
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 02:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+puKWUiP+iedB5qcmRO3ZKzhAuwNdbFsaGm512S9Vpc=;
        b=inGZ4BJbl5WdmiWO5sTZHJxEaPE7NCUYyPjMa4tHASAixIYITSH0s+j/8TrX82Dlcm
         hr7uVpCa9inbPHl1SbEy0eu9L4FMvErNwIkg1Z9+qJPtZE4XAqCk/XqhMbBTqFnLdOUN
         m+DO01DukQridhjv4f7DrSiw11fZLKxmomY99qnp7BDCNQLXvQP817lADAEmL0O72PjE
         WfCFABqDK8RIdySTfiufK6kWTkfLj9K7BO3ngbhUQ3BTRbuVoBMqtQL9pcr66Jz9n7MX
         ux5X1Ljy2PpyMzLSmrTp+BaXCmF4yqm5qZbvsYQFYYUgwuxyt83YCAoVQwliOZ039Hhh
         KQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=+puKWUiP+iedB5qcmRO3ZKzhAuwNdbFsaGm512S9Vpc=;
        b=UrA+hpkmJZikzYO5c4QGCA4w/kezdpFitkFKvchZJ8ZjUCxygkcd3jsmQTp7kyIJCu
         7P9L9v3bD6KRcPatVxrBx6pnpF68qotU/Xxmr7xUbRX6Yt37IVejpunK2moq5jqTHOMp
         zt83DOKaOa3HGxezzQ1tzjtauOL90djd85EPT2ImTA8yIcMotgFCoKZ1CmjlzvknxUJr
         x8gi4W+WRBVJ2WXbR3YUtjLn39HEPiI2MydQ1DFs6ARUb67rTdTwL+BUtZEILnBL0gV0
         hfpu7HJfDWBPG5fWpAw7Rzqxm4SczH5T5cticWYrXNVrFPhummgk5FnxwD6wPoUmtacY
         TpjQ==
X-Gm-Message-State: AOAM5335MiBQBaZy3aRpk+QUdjl6N9OfPeD7bkIg67xm0zi7CLiFQQEc
        uIuNgRRXFnZL4pGhlfHvR6VtEXOVd04=
X-Google-Smtp-Source: ABdhPJxPD6244v4+qzVlmHH8ZSDcgaEJUb7W62e7KOMBwj+c2avxMfZfYoeQc6e075j11AJMWk9hHA==
X-Received: by 2002:a2e:9b89:: with SMTP id z9mr2465424lji.76.1625997157610;
        Sun, 11 Jul 2021 02:52:37 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id m28sm200491lfp.222.2021.07.11.02.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 02:52:36 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Martin <git@mfriebe.de>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: PATCH: improve git switch documentation
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
        <xmqqy2arrmba.fsf@gitster.g>
        <b80bf908-0c31-2b3a-6d6c-1a3fba5b2334@mfriebe.de>
        <87wnqaclz8.fsf@osv.gnss.ru> <60e5f3981de5f_301437208bc@natae.notmuch>
        <87bl7d3l8r.fsf@osv.gnss.ru> <60e61bbd7a37d_3030aa2081a@natae.notmuch>
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
        <87im1ieaba.fsf@osv.gnss.ru> <60e9fa5132e14_7ef20849@natae.notmuch>
Date:   Sun, 11 Jul 2021 12:52:36 +0300
In-Reply-To: <60e9fa5132e14_7ef20849@natae.notmuch> (Felipe Contreras's
        message of "Sat, 10 Jul 2021 14:51:45 -0500")
Message-ID: <87im1hfa8r.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Sergey Organov wrote:

[...]

>> Creating (a branch) is fundamentally different operation than switching
>> to (a branch), and that's why the former doesn't fit into "git switch".
>
> Not in my mind. Instead of switching to an existing branch, I'm switching
> to a new branch, which is easily understood by
> `git switch --new branch`.

To me:

"create a new branch" is basic operation.

"switch to another branch" is basic operation.

"create a new branch and then switch to it" is compound operation.

The latter could be implemented as either new-then-switch or
switch-to-new indeed, but the "new" part is the first action to be made,
so

  git new branch <branch-name>

that switches to the <branch-name> by default still sounds more logical
to me than current:

  git switch -c <branch-name>

Thanks,
-- 
Sergey Organov
