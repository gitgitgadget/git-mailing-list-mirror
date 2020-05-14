Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4BDC433DF
	for <git@archiver.kernel.org>; Thu, 14 May 2020 22:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96BB720709
	for <git@archiver.kernel.org>; Thu, 14 May 2020 22:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=calebgray.com header.i=@calebgray.com header.b="WMIOgORH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgENWFA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 May 2020 18:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgENWE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 May 2020 18:04:59 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE412C061A0C
        for <git@vger.kernel.org>; Thu, 14 May 2020 15:04:58 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id b11so2933323vsa.13
        for <git@vger.kernel.org>; Thu, 14 May 2020 15:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=calebgray.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H7HY1xItxyNn97XWpXkg+RwltdtoElhyc8hYSSNAcnY=;
        b=WMIOgORHMLd2v0oNBnxf3GoCutqpmCZ2gQuDTNfLJd81VaJHKXKEPj5rAYvm03jc3s
         lC+ofWJ9U+plbNPW3cT/ucpp+EufuUwfeXEcFqFc4eDdsdfniszPrw6berGwvkY8dA6s
         lLtgpcOWgZsd+7sbwiTyY6lCYjiaIq3dpxbUXjbfzmdIT/cp0zbym5loXWJJtC9D6yqb
         +fUCFKB6uDMVxNTuPqzy1cG/vOAfwBa3RFFR930MNA2drabwtGfU5KkZHZ6L4j4tOQoW
         EQxnG9EaxmbbB3tMQmO2hJO+XINexl1rBgF8n/n6u3HNvYJ3yk25eJanqQKaYuJEp3Js
         duYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H7HY1xItxyNn97XWpXkg+RwltdtoElhyc8hYSSNAcnY=;
        b=fAq0kgo58PoGv/PbN8q0ijJh6JWCLQZmKhJMeTA2gYu7IZSIP4M+HTcLpk/BkIQApr
         Embdi2HG16Lnm6oDseA2wKRQBXceqMberdzUZ0qUOtQA/Kmpq5x47j1BmxsITE4zdct6
         8il6HZjO1i47PeUtxcpmS/oxTNeoSlaUc7oCDNqRyk3h8EfuNmkDghRoquHG5Jjd7Rv4
         L+B64ZidFZZl6wSHxD22AFMJB8mGxFaNSboAGgLv+SBXcJ2mgHM/Y7IEEyDuXEl6Z/4X
         17Izqv0+k1Xr2lG0QRBJ6dMLBMVDnJo3Uu+rH3juX8bFsZHsBDfPFj562uGWt5wMuTZX
         dH9Q==
X-Gm-Message-State: AOAM5303PX475NjZJ13WlVRmHwnBVQJbPhAa0fpQzwTdZHhVVQNhGvgl
        etNy1c2plsQceo2Et7BGyrg2/XSYK5mCC+wHhooDmTGA
X-Google-Smtp-Source: ABdhPJyKsoi2hHE+zJB8tkGcuzR2//8vIOBvWO+gpFQGGQWsOz8A5/hCFLMvbMYQfB5k5bq8fKw1tmWUr6PiEW/ckRg=
X-Received: by 2002:a05:6102:392:: with SMTP id m18mr481148vsq.38.1589493897209;
 Thu, 14 May 2020 15:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAGjfG9a-MSg7v6+wynR1gL0zoe+Kv8HZfR8oxe+a3r59cGhEeg@mail.gmail.com>
 <20200514203326.2aqxolq5u75jx64q@chatter.i7.local> <20200514210501.GY1596452@mit.edu>
 <CAGjfG9bsQh2C6WP242v4LoiaSdghZDPuqns0VO82Txe-V54_KA@mail.gmail.com> <xmqqmu6ap4dw.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqmu6ap4dw.fsf@gitster.c.googlers.com>
From:   Caleb Gray <hey@calebgray.com>
Date:   Thu, 14 May 2020 15:04:46 -0700
Message-ID: <CAGjfG9akT+KG-tttRWEX_ZqxrqPoY_4Ed7Pymt4DkV5Rgc1CEA@mail.gmail.com>
Subject: Re: Add a "Flattened Cache" to `git --clone`?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Actually those are the steps that I'm explicitly hoping can be
skipped, both on server and client, after the first successful clone
request transaction. The cache itself would be of the end resulting
`.git` directory (client side)... unless I have misconceptions about
the complexity of reproducing what ends up on the client side from the
server side... I figured the shared library probably offers endpoints
for the information I'd need to achieve that.


On Thu, May 14, 2020 at 2:56 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Caleb Gray <hey@calebgray.com> writes:
>
> > To Clarify: I'm talking about a server-side only cache which behaves
> > much like a `tar` file: it is a flat version of exactly(*) what ends
> > up on the client's storage. When a client runs `git --clone` and
> > there's a valid cache on the other end, that's all that gets streamed.
>
> So this is to save server processing time only.  It does not save
> bandwidth (the "cache" is bit-for-bit idential replay of the clone
> request it served earlier), and it does not save client processing
> cycles (as the receiving end must validate the whole packdata it
> received before it can even know what objects it received).
>
> OK.
>
>
>
>
