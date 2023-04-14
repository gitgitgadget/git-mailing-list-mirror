Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6898C77B6E
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 13:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjDNNlg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 09:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDNNle (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 09:41:34 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522CB7D90
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 06:41:33 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54fe82d8bf5so30999867b3.3
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 06:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681479692; x=1684071692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D8ShCCqmiGnargr2RnVxTiDCtIaVqrNcRB1KUouv960=;
        b=JrorRs6m6t7bQEVznt7EE+QB8k7zt8uZRniEPyLyF8VNkUP4GPqlj1IgFilF8dxH4P
         CAkxSOQ6xtEToHT7tTNh5XuWMMuiE3iuocjZdNYg4wjkfii0Mips4nx1LqA0d14bmfp4
         9SqKOZcKpQUp1VVOS6l0ND+cb2xhzSm0/hXQyIJ8fKUygLxmJKpi1wctuDV/AepxH9IU
         k5YiYrQhTZ5gnN7TfiqJ5TJfq2yKtjAzkdrt23+4gdssyT3xlwcUCgNdKp9mTfIURmy9
         pdxofn/ACgh0zKcpkDhiRDHVZEchfh832bFeH2NixAIeRBSWcRNk1NqLIvPGdAArEhpY
         UogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681479692; x=1684071692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8ShCCqmiGnargr2RnVxTiDCtIaVqrNcRB1KUouv960=;
        b=GYZspXvp95Nu4ilPmu9HnKvkejQKC0ndwP3vYohyek+Ol+qwvP9UxO8/gnR3nzl60f
         Nk2isqL/JJXh7Rd5BHQoXGg4dH3nvuXCx4v6dTP9HabTfwc2rDaxPoF2UQmdwQiwi3D9
         QUQWe2t0s1YP3tUKGecMapiRQddspPG2rQyZ4XCLdu4IpYh1/okbe/RJx1b5ucLSB84i
         DlR42cVS96unyBg7VckAjLT+0Gcse4bmkdiGHyaUcdZU0lg5pTzxasxFTf8etvskqxa8
         mvCEehwSdf4gCV4udw0pmJ83JUc+067I+9qVXokKUe+0FlVuyDuWqWADXkygqk+kdLk9
         bC7w==
X-Gm-Message-State: AAQBX9fS4Yz+2pAxcu/x0U73J6/GSoYfnvqdBrUNJonoGhJG0yt1RqQd
        SD0NJniPnj0JZdfgU1n+2gnoAVUkMt5Ic40TWUvSTQ==
X-Google-Smtp-Source: AKy350aCtUZZfh2t96cy/CtyjKgscfJPN/Yj9BHTL1lu+3csGKoqXmeV9UtzkFWF1Vquyf49jiBP7w==
X-Received: by 2002:a81:8985:0:b0:552:96d2:c6a with SMTP id z127-20020a818985000000b0055296d20c6amr732101ywf.6.1681479692309;
        Fri, 14 Apr 2023 06:41:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v132-20020a81488a000000b0054fa99bed5asm1166360ywa.129.2023.04.14.06.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 06:41:31 -0700 (PDT)
Date:   Fri, 14 Apr 2023 09:41:30 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/5] banned.h: mark `strtok()`, `strtok_r()` as banned
Message-ID: <ZDlYCgrPNG+htzJ3@nand.local>
References: <cover.1681428696.git.me@ttaylorr.com>
 <1d955f8bc6d2797def516897d019a186e461b648.1681428696.git.me@ttaylorr.com>
 <xmqq8revw8c9.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8revw8c9.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 13, 2023 at 06:39:18PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> >   - `strtok_r()` forces the caller to maintain an extra string pointer
> >     to pass as its `saveptr` value
> >
> >   - `strtok_r()` also requires that its `saveptr` value be unmodified
> >     between calls.
> >
> >   - `strtok()` (and by extension, `strtok_r()`) is confusing when used
> >     across multiple functions, since the caller is supposed to pass NULL
> >     as its first argument after the first call. This makes it difficult
> >     to determine what string is actually being tokenized without clear
> >     dataflow.
>
> It seems that the only existing users of strtok() are all in
> t/helper/ directory, so I personally do not think it is a huge loss
> if these two are forbidden.  While I do not see why we should use
> strtok(), none of the above sound like sensible reasons to ban
> strtok_r().  At best, they may point out awkwardness of the function
> to make you try finding an alternative that is easier-to-use before
> choosing strtok_r() for your application on a case-by-case basis.

For what it's worth, I could certainly live if we accomplished getting
strtok(2) on the banned list, but left strtok_r(2) un-banned.

TBH, I think that leaving the reenterant version of a banned function as
un-banned is a little awkward, I don't mind it if you don't feel like
the above are sufficient reasons to ban it.

> If your application wants to chomp a string into tokens from left to
> right, inspecting the resulting token one-by-one as it goes until it
> hits a token that satisfies some condition and then terminate
> without wasting cycles on the rest, string_list_split_in_place() is
> a poor choice.  In such a use case, you do not know upfront where in
> the string the sought-after token would be, so you have to split the
> string in full without taking an early exit via maxsplit.  Also, you
> are restricted to a single byte value for the delimiter, and unlike
> strtok[_r](), string_list_split_in_place() does not squash a run of
> delimiter bytes into one inter-token delimiter.

I don't quite agree with this. In practice, you could repeatedly call
`string_list_split_in_place()` with maxsplit of "1", using the tail of
the string list you're splitting into as the string to split. That would
allow you to split tokens one at a time into the string list without
having to split the whole line up front.

That all said, I don't think that we have such a use case in the tree,
at least from my searching for strtok() and
string_list_split_in_place().

It may be that using strtok_r() for such a thing would be less awkward:
not having tried both (and having no examples to reference) I honestly
do not know for certain.

> One gripe I have against use of strtok() is actually not with
> threading but because people often misuse it when strcspn() is what
> they want (i.e. measure the length of the "first token", so that
> they can then xmemdupz() a copy out), forgetting that strtok[_r]()
> is destructive.

Heh, I'm happy to add that to this, if you want ;-).

Thanks,
Taylor
