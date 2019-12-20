Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476ABC43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 19:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E172064B
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 19:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfLTTdS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 14:33:18 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42227 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfLTTdR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 14:33:17 -0500
Received: by mail-wr1-f66.google.com with SMTP id q6so10460883wro.9
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 11:33:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t6rBhc0VYTiw0e+26DxWGl/15ghIwEprAsHXh+j/59A=;
        b=euSjdUVCqizB2V9qUcreC5tIwDqg5II/2puRGu6jccXk71awdLkh+6EjdQwMFZA+Nh
         7C6f11iy0a5JerJVUBnrDmVpqL4meinv7FV8H4QPm5Vxn+vozPv7pgoTGLFTzi0aI9NA
         jhakhhDUbu1s/FXAUT1Fspzm5YxRlevHJDFIp6NCW1QDsF90ND7Su3QerOnZ9KzQl2rI
         74C3+pbCjoEkWR35//jwvBJAEs0lllGaNa+HAcJY12tyPlJhqdgFBD07zTPxNGIozTw0
         LRHnHzw2rR2wTDO9fkKdbUK8xyip4YJXP1IFkbSUhm5OY4QjvNFkW/1WRrdCZioZeDH2
         VwKg==
X-Gm-Message-State: APjAAAXN72i8UcptYrluCMMLk4KND3cDCLWE1vyfADjSj2YoXNxQoVI4
        iAbOkynCWjTKGfDBcwiTf8aY9uS9x/kM+3pXbA8pV66N
X-Google-Smtp-Source: APXvYqymztiMJ26Eyfn/JLGYrnno9cIVo8jqoKvtSSV+8esIv7GNDAnk8SXHs/eN7E/1Bhlt7qqftRiUgUoPUZ0ow8c=
X-Received: by 2002:adf:f382:: with SMTP id m2mr16864598wro.163.1576870395467;
 Fri, 20 Dec 2019 11:33:15 -0800 (PST)
MIME-Version: 1.0
References: <20191219015833.49314-1-emaste@FreeBSD.org> <20191220153814.54899-1-emaste@FreeBSD.org>
 <CAPig+cS6XPc9KZo3ytEHLFjMxEFqCk5OJMUjZyFBP0cA95u9Lw@mail.gmail.com>
 <xmqqftheamea.fsf@gitster-ct.c.googlers.com> <CAPyFy2AF+zcriUfZnpbXy+9r7hRpNBUe0agMuan-cE1ryqTipw@mail.gmail.com>
 <xmqq7e2qajix.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq7e2qajix.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 20 Dec 2019 14:33:04 -0500
Message-ID: <CAPig+cR64QkBJ8ybMkMiX2CvrgajcGMyG41SMt4mA-VzHyae=A@mail.gmail.com>
Subject: Re: [PATCH v3] sparse-checkout: improve OS ls compatibility
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ed Maste <emaste@freebsd.org>,
        git mailing list <git@vger.kernel.org>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Eric Wong <e@80x24.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 20, 2019 at 2:23 PM Junio C Hamano <gitster@pobox.com> wrote:
> Ed Maste <emaste@freebsd.org> writes:
> > Ok, I'm also happy if it goes in with no comment; the reason I added
> > it is I could foresee someone coming along in a few years, thinking
> > this is just a strange local implementation of ls, and changing it.
> > But, perhaps we can assume that any such person would check the
> > history before doing so and the comment is not needed.

The in-code comment has sufficient value that I'd like to see it
remain since your concern about someone coming along and wanting to
replace the function with "ls" is a genuine one, and because it saves
people the trouble of having to dig through history in the first
place. And, by "people", I mean that it may save reviewers too since
patch submitters don't always dig through history or don't always
explain _why_ a change is a good idea or valid, which places the
burden on reviewers instead.

> > Indeed, that is more direct, although it's not just FreeBSD ls; this
> > came from 4.2BSD and is probably common to most/all non-GNU ls
> > implementations. In particular, macOS behaves the same way. (Also, the
> > replacement would be even simpler, just "ls $1".)
>
> Good piece of info to include.  Final try for the day from me:
>
>     # Do not replace this with 'ls "$1"', as "ls" with BSD-lineage
>     # enables "-A" by default for root and ends up ...

This looks good to me.
