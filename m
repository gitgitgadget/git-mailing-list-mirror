Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9126B1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 20:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732442AbeGLU2K (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 16:28:10 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:38042 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbeGLU2K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 16:28:10 -0400
Received: by mail-yw0-f195.google.com with SMTP id r3-v6so10931988ywc.5
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 13:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ySnNvNU7efWyz6i2brNB4Go0kW/09NTwcmbYubYPlc=;
        b=rB6jJaFnbrdYyf6oHda2Sg0viV8fb5qTWtAQ4iKdIU1neAIBUxGE2UPJBAsmC+7hqA
         uZwbuVSePuCltGS7FK+lU4LAtZFBZHml0aEDQ4phDziO9LO4QR6ND9V5gmq4YzOm2v9I
         tiJI0poDxfBfpycN5ALtT1wESwCZfa0uw7UKyzQO9i9mjOUM+uesgz4Yu7mmSkt2+ZUw
         zGvw8C7NH0RWtbGU6kmQTqA0Pl9jPBCalzi7tf2OFdPGwENqZQUbAzzqM/ZPfkqh1eRX
         +fPnrGt5XoinGX3mTU10hpiLKXhQ2cKe6MB8sKg2gPs9xy1qJC9o7Rnir+hpNNHemr/O
         Gs2g==
X-Gm-Message-State: AOUpUlG8CZQDJK+0KuZJgXkxwIIa+GWzOqPsMUjTnRTzHDbp0mhl1BNd
        B1HLdQb6WUJ/GAEdqeLGtkb+SYHIEb7TBL3108Bv/A==
X-Google-Smtp-Source: AAOMgpeQsJWZLkY4LOGRjms+b9fXPG8jnf09/WgVAjk86npxpULk/T3C0TGuUyGkzm2nATSzsccuvZ7TE/j2AJC4IGk=
X-Received: by 2002:a81:110e:: with SMTP id 14-v6mr1864637ywr.16.1531426621794;
 Thu, 12 Jul 2018 13:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <86a7qwpt9g.knu@iDaemons.org> <xmqqa7qww6uk.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqa7qww6uk.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 12 Jul 2018 16:16:50 -0400
Message-ID: <CAPig+cQWA+sE3iH89kQGWgS+0HQDK-V5++S0+F6_dpfOCfXxDg@mail.gmail.com>
Subject: Re: [PATCH] sequencer.c: terminate the last line of author-script properly
To:     Junio C Hamano <gitster@pobox.com>
Cc:     knu@idaemons.org, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 12, 2018 at 4:13 PM Junio C Hamano <gitster@pobox.com> wrote:
> I _think_ the right and safe way to fix taht is to do something like
> this:
>
>         test -f .git/rebase-merge/author-script &&
>         (
>                 safe_unset GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL ... &&

s/safe_unset/sane_unset/

>                 eval "$(cat .git/rebase-merge/author-script)" &&
>                 test ... &&
>                 test ... &&
>                 test ...
>         )
