Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF4FC4167B
	for <git@archiver.kernel.org>; Fri, 16 Dec 2022 18:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbiLPSjz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Dec 2022 13:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbiLPSjb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2022 13:39:31 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE37B537E0
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 10:39:05 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id w15so3355364wrl.9
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 10:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vUT/nyGHnrDzP7SxiBBjH+ItT4JLbMwcHQUTyhguanI=;
        b=jY7fqVehvYIe1yjgrniRMLLwMlAbReo6ZJLX9o5hXCKwj52s9ASS6tCeoM6CGiIqvV
         AsOjQxPpmuPx+t/yesvOerjBwexQDtReR33r6XJblsJHMfvMfaBF17pMrDVx8d/VXv8Z
         sTr77lFXIBBgF4gidMj57SNRiVA9HvLAlKj+Nt2LLE83yeENvfHigXa7SLXJpguDT6mU
         zgKvbGbWtXf4x4P4jlkx5MsXrBD15YxvfhF7xWFzdrdDpENxvWNFXKgiuGV2Qrr65gbY
         5SSrmpWl/bq1cR4IoDNgaI0rPvOPSuhW7bwCHeTA7D8+zbfwFma1CYzNslU9I08aJDzD
         GGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vUT/nyGHnrDzP7SxiBBjH+ItT4JLbMwcHQUTyhguanI=;
        b=0aa5tg9CFv18WXubDJ8snJc6SbIH5bPFEy5AivshJEteaa1875DxT2Dm9reWcuDiZs
         UuRUoSpBm7lBdGY8DE3hDgVrc1vqu8cYOXt4BnEpzafEOyJRPSD8h0SQZ81lhcqcNsfK
         EMVEwt0i3cOuogGfpXXGsCu38uHcQDk0Yf1czR66U2BF+aXwTyUnFvZA5lMfJbwqBa7u
         Cc7+vkXadtyrfNGtujJD3IDGT/hbr+mSEIPNWXFHm4WkNUJ33/3nhgWIhqMyzIz7PmMH
         TxzqR3N3rkqmlGTgu//xX2kEon9Y5rEg7At2baPhiyD5edW0xma43s8deVdd50FyU/+O
         8bOA==
X-Gm-Message-State: ANoB5pnpkPBU1zN5FBp4Ad+CFdg/Sn1xNOPZjMff2NDK3O7KIqqVoQeN
        /REhNqoF35KaMVKFjqgQ8fCoyNptGT3cGQmZ7jB3p7S4DAqw1A==
X-Google-Smtp-Source: AA0mqf6Y6YRevwVn4hlCZBpW40AdEq4faophWFCJT+sR2FXqmlwA6XEQX14u7HQjyZEXgp7+qZbhEk8tjELIaWNHvpo=
X-Received: by 2002:adf:f082:0:b0:24f:a9bf:964c with SMTP id
 n2-20020adff082000000b0024fa9bf964cmr866648wro.106.1671215944298; Fri, 16 Dec
 2022 10:39:04 -0800 (PST)
MIME-Version: 1.0
References: <20221216033638.2582956-1-phil.hord@gmail.com> <xmqq359gnfhe.fsf@gitster.g>
In-Reply-To: <xmqq359gnfhe.fsf@gitster.g>
From:   Phil Hord <phil.hord@gmail.com>
Date:   Fri, 16 Dec 2022 10:38:53 -0800
Message-ID: <CABURp0pWwfWO3msZ4U=_i3zkEDOq6+CUVT9Tb7KCjeBRK34Miw@mail.gmail.com>
Subject: Re: [PATCH] date.c: allow ISO 8601 reduced precision times
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, congdanhqx@gmail.com, plavarre@purestorage.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 15, 2022 at 8:23 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Phil Hord <phil.hord@gmail.com> writes:
>
> > From: Phil Hord <phil.hord@gmail.com>
> >
> > ISO 8601 permits "reduced precision" time representations to omit the
> > seconds value or both the minutes and the seconds values.  The
> > abbreviate times could look like 17:45 or 1745 to omit the seconds,
> > or simply as 17 to omit both the minutes and the seconds.
> >
> > parse_date_basic accepts the 17:45 format but it rejects the other two.
> > Fix it to accept 4-digit and 2-digit time values when they follow a
> > recognized date but no time has yet been parsed.
>
> I worry a bit that this may conflict with other approxidate
> heuristics.

I share your concern. I tried to make the ISO matching code very
specific to the case where we have already matched a date, we have not
yet matched a time value, and we see a lone 2-digit or 4-digit number
show up.

> > $ test-tool date approxidate 2022-12-13T23:00 2022-12-13T2300 2022-12-13T23
> > 2022-12-13T23:00 -> 2022-12-14 07:00:00 +0000
> > 2022-12-13T2300 -> 2022-12-14 07:00:00 +0000
> > 2022-12-13T23 -> 2022-12-14 07:00:00 +0000
>
> All of these may be obvious improvements, but the thing is that
> there is nothing in the approxidate parsing code that insists on the
> presence of "T" to loosen the rule only for ISO-8601 case.

I considered making the T an explicit marker, but it didn't seem
necessary here. But the looseness of approxidate with regard to spaces
is worrisome. That's why I added the date/no-time constraints.

> For example, with only 6 digits, do we still recognise our internal
> timestamp format (i.e. seconds since epoch) without the
> disambiguating '@' prefix?

I don't grok your example.  This change should not affect the
interpretation of any 6-digit number.

Oh, do you mean if there was _no_ delimiter before the time field?
Like 2022-12-132300?  My change will not recognize this format, and I
believe it was explicitly rejected by ISO-8601-1:2019.

approxidate seems not to recognize fewer than 9 digits as an epoch
number, even with the @ prefix.  But this is not because of my change.

test-tool date approxidate 123456789 12345678
123456789 -> 1973-11-29 21:33:09 +0000
12345678 -> 2022-12-16 18:34:02 +0000

test-tool date approxidate @123456789 @12345678
@123456789 -> 1973-11-29 21:33:09 +0000
@12345678 -> 2022-12-16 18:36:35 +0000

test-tool date parse 123456789 12345678
123456789 -> 1973-11-29 13:33:09 -0800
12345678 -> bad

test-tool date parse @123456789 @12345678
@123456789 -> 1973-11-29 13:33:09 -0800
@12345678 -> bad
