Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1380C4332B
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AEE46146D
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381470AbhCDAW1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:22:27 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:33011 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357187AbhCCIUM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 03:20:12 -0500
Received: by mail-wr1-f41.google.com with SMTP id 7so22654689wrz.0
        for <git@vger.kernel.org>; Wed, 03 Mar 2021 00:19:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ua1JRSyjsphEwYR7n69MI7SrbBmia4TKXY/VkXpVr3k=;
        b=XfSugt32By2PN6EjZzEb6Eb9i8vBnVyrsxlg+uY/MnUUkQ/0tcDj4HCDZAdYkOp7K0
         fdmGa3Jzs5r7LnNF8n118/L3BVnvPLG6sRkcFLN1hGZKjAInQZAf8z7xmqeIeqwJyyP0
         sj6/oqkEdHfFiuYreIdPkMEtM2PdlpRWWtll3RCrvttaz89WGl/1pjUCyO6D6kV5nCm8
         e5ySwf47HZds8Lf1AJXMxE9X8qOWh0Ag5GDFy3EBvedGaYlSIYD5lBHI6M9k7eSnZyKi
         yDu2AuJbAtYtx7FmHBGfSHUDex+aT0XsZNsllEBH6gpE6Iea3xYn3tNHB514fS25rky4
         rXDQ==
X-Gm-Message-State: AOAM5327GszKO0r8sHbq1scpi70WEtdi4tb4lcjNSb9w8yLZL++A522E
        csb08Bb3PREjGOw1+QKn6vqeA9VherJ7BhIcOHvcLT/u
X-Google-Smtp-Source: ABdhPJzEmnHSeYjqwkLmoMudqSp0dICNTEYi5F+cjwhR09tfwW9261Ys63YrOq4AH0CKEKfZQ/M4l8QLxoRjDYTP2TQ=
X-Received: by 2002:a17:906:68c5:: with SMTP id y5mr8535883ejr.371.1614757588604;
 Tue, 02 Mar 2021 23:46:28 -0800 (PST)
MIME-Version: 1.0
References: <20210301084512.27170-1-charvi077@gmail.com> <20210301084512.27170-3-charvi077@gmail.com>
 <CAPig+cQAG3p6rhGHzBNGPUxMXQbbLZgiw-uUpizNiEWY9wm-3A@mail.gmail.com> <CAPSFM5dm7vD8pszCG+JKNb7Hu6Zp48wKXaj9ayxe6yaf6swePA@mail.gmail.com>
In-Reply-To: <CAPSFM5dm7vD8pszCG+JKNb7Hu6Zp48wKXaj9ayxe6yaf6swePA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 3 Mar 2021 02:46:17 -0500
Message-ID: <CAPig+cSJCSLBDumaXvnkdSBTATs62h9EfgtgJu0O7R_PJEumCg@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] commit: add amend suboption to --fixup to create
 amend! commit
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     20210217072904.16257-1-charvi077@gmail.com,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 3, 2021 at 2:37 AM Charvi Mendiratta <charvi077@gmail.com> wrote:
> On Tue, 2 Mar 2021 at 03:45, Eric Sunshine <sunshine@sunshineco.com> wrote:
> > > +       if (starts_with(sb->buf, "amend! amend!"))
> >
> > Is the content of the incoming strbuf created mechanically so that we
> > know that there will only ever be one space between the two "amend!"
> > literals? If not, then this starts_with() check feels fragile.
>
> Yes, so for preparing each "amend!" commit we add prefix "amend! '' to
> the subject of the specific commit. And further if we amend the
> "amend!" commit then this above code is checked before creating a
> "amend! amend!" commit for the user. So I think maybe we don't need to
> check for multiple spaces ?

Okay, if this is guaranteed to be created mechanically, then what you
have should work, though it may be a good idea to add an in-code
comment stating the reason it is okay to expect just the single space.

The alternative would be to avoid having "amend! amend!" in the first
place. I didn't trace through the code carefully so I don't know if it
is possible, but would it make sense for the caller(s) to check before
adding a second "amend!", thus eliminating the need to do so here?
(Perhaps I'm misunderstanding, but the above code almost feels like a
case of "whoops, we did something undesirable, so let's undo it.".)
