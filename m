Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949C0C433E0
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 12:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C710206BE
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 12:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6ePuUKs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404702AbgFYMfq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 08:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404451AbgFYMfp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 08:35:45 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D928FC061573
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 05:35:43 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a6so5672047wrm.4
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 05:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/xT9qTV7Nm44U+4dYQ70oOWqKJ20J12c2PDPHcLGxfc=;
        b=G6ePuUKsKqseHOvgBJ+pN0JaQGTnk62+TOXZpjUfUqYTIc4Vqb1cf40p/nN8FKhGZJ
         gOJIG5DIgppJQd6MmoPLUJxxyFGLeuFDej5SDphAi3SJKnT420FWhw+G8J151f1ZMK7P
         ygLLv1VK4PykodXNgGwimUNz7lo3CFmehmqsdjU0bwYrcqXTAJqEYw8O7r3QsWdxLiIK
         OCWZ4IXN9QeKJaZjU9RYYqKcBTUjeBG/EcHUSO1Fp+wanTLsnly2k0Jk2Di9MtsoLDqZ
         O5VosH5y5jT/tAok82uqxZYZFcRYJsoVtSxJ7JoYsClftDnSGYpK3kE5SZQWY+HD0bDY
         GqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/xT9qTV7Nm44U+4dYQ70oOWqKJ20J12c2PDPHcLGxfc=;
        b=i14rKttYiX2beSo6ONYfsGz1qu7IpDzD8EZpkSVgIVnyVG6a3pvQUICTXYrWDD6Zt5
         fMionZ84EkGFatDQm+Pla5gSa3KxtFRrsRzQGNMHcLqEBv6mS2KZ/t6KOpJfbYVLoqGi
         1qqAfxc9pELQwDvrTJzIQdO6Q11YBVu+h3e73wrOR4Is2U7QOm0lFk9WWhUqK0yHqU/4
         TUHIQ2m1IRVPs6Uyia0TAkRb861ZkYei+2ASmLF+V49NEvqJATIGejwGD+6baN5ZypoZ
         LAWW+oVI63S8PWgBJkFcEZ5MWKWSvX3EElFqGAN0Z7RSPE9lLiIdB2UKGUudYwuNppKK
         3nug==
X-Gm-Message-State: AOAM532vW/s4m5q2p1DjwzJRNRkIpkLZ3oxhNXcInLd8hg1pAwiwZBYO
        U0aC1R5iEErA185zVsbI1bE=
X-Google-Smtp-Source: ABdhPJzdkf0T/xej5QaV2D/MrCvVC/9ZM0lzcaiVbcBYd7xhdzYluC/hjhZSrLO14uDclE+9xmkb/g==
X-Received: by 2002:a5d:5341:: with SMTP id t1mr38846508wrv.207.1593088542643;
        Thu, 25 Jun 2020 05:35:42 -0700 (PDT)
Received: from [192.168.0.104] (atoulouse-654-1-308-216.w86-199.abo.wanadoo.fr. [86.199.91.216])
        by smtp.gmail.com with ESMTPSA id f12sm18492228wrw.53.2020.06.25.05.35.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 05:35:42 -0700 (PDT)
Subject: Re: [RFC PATCH v1 0/6] stash: drop usage of a second index
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Son Luong Ngoc <sluongng@gmail.com>
References: <20200505104849.13602-1-alban.gruin@gmail.com>
 <CAP8UFD0bfTEDQaA0rQEBW76niF0T7f_4HS_N1tkRPh-0ZW7-Gw@mail.gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Autocrypt: addr=alban.gruin@gmail.com; prefer-encrypt=mutual; keydata=
 mQINBFcsWp4BEAC6dalBNr/CZCvvfeARylnjAaZCxMPwUHXAyf4xotA59sNcyVmaFQ6KxQEs
 R20CSJhO6HqCh4bR9/994vdc4cGuNaWf82eYRYzqCzwFWvFJHj83QgDR2cjtz4frKpj3jSFJ
 No3KBlMmpU8yvSnYaCxjqHxBB+fZwkmmONj/57KdFRU83DvDllQdAxXfxEavL3qUKjVbld29
 o82M2xsN8ZN5KTw7rAMHcigYVnlrgP50euxz3WvfrV+Mky2W7q7m5rTK7eXqOKhewsKcxo0I
 AP+H0Nt91YTmMIAX2Ba25IfHI99kUCLpbHX9xdvj5UH1SZsG84APahdI3CXYibfYIS+qssoo
 72qj7eBIoCFbVS4Q5AINxojio32orGBDE8CaCy3EzTF+vwJ+h4uUKrTX4wyUMy8nXS0UxZqD
 aQsS7Di6LdAHu+4uf064mXdgjehJ2uHAydFnCThMoxckRoSZ70iCPwgconhNrnuTmunJ43BF
 YjAurjg8y3WrMPJuJaI42q0sYbAX21XeayyMI8dzoNwyG6s+v0Udb/uxdYnHhsGx1oXjYCeR
 nyBdVwdMLWFP4XmJH7JueGUZ37TLh719ME6HYRpfM3sh915ywPxKxQYmGC9iXRThXdGK7ipq
 hJM5RtMq4QPGg+/ShgTZaDdFuMnG8Zrq6W+O29h9NB5rQ/UvBwARAQABtCNBbGJhbiBHcnVp
 biA8YWxiYW4uZ3J1aW5AZ21haWwuY29tPokCcAQTAQIAWgIbAwIeAQIXgAULBwgJCgQVCAkK
 BRYAAQIDHxhoa3A6Ly9wb29sLnNrcy1rZXlzZXJ2ZXJzLm5ldC8CGQEWIQS1T1bLFrFdtpxn
 TIMOC58lWpNWKgUCWRSuYAAKCRAOC58lWpNWKoCfEACHmff95NF5OrBKN+GPYo3TOojjgjio
 CREt9BNIU1ltbks33N/84QF1ifjFF5xjK1XpNhZdk2Nxk+Uf3ByAS24i0b7/BM58RX3sJMHd
 mklCbqBGLBTS+bO/3nc+1snb7FPmjoi3IXznQ25ZXiV/9MUABUBZi7odwNhxeI3Hd2PaX/x5
 ZM0BApqhmBrueUd0JKqY7f/7a+0rTJ8fIHV9ml3cVWf72t2BVnxJMeNLSAIT1FaL8Okp8ViO
 t7RfjF0JZsYZouhCcw2fx7U0VxXGu6bONdVGxu07I7G3+vjhd2C/ld0dgRRjx8viA5HecUSf
 bwbviEXlc44TVo8D6tkrKOezctqNTLII498C7gIQZjc+6HmIIQrOzzLX/C27JQbXch+6KtHO
 ThYGzmD0d7EttTRtXnFJFTMbQMMFnc2X+Rh1ubvfp4Zp2U3a7Nh1//4+ikqIAPV8poJcEdQ0
 A6CaGD8pTCMdExDovizfJRU0ZN3AU9UgFsZWkMK7MFyJneRObUf26oXCQH8zVuJEJHrEsYPk
 VHdV1G86d++CdipKqe9iDNBGNa/5Q9IvYEKK6vj4wLS5ZaOwLGfApbsOcDJvFA1ll/KeHvzx
 Ig9dhUnNCtYXKJ1npChigwRbAiAADoTFI2rI69g6ZTTzBd0+9GM4z6RcOJvtGLnViO4tOCmy
 sbwbxA==
Message-ID: <4b73490a-c2b9-8ed7-8d58-998ac071292c@gmail.com>
Date:   Thu, 25 Jun 2020 14:35:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD0bfTEDQaA0rQEBW76niF0T7f_4HS_N1tkRPh-0ZW7-Gw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

Le 13/06/2020 à 09:52, Christian Couder a écrit :
> Hi,
> 
> On Tue, May 5, 2020 at 12:56 PM Alban Gruin <alban.gruin@gmail.com> wrote:
>>
>> The old scripted `git stash' used to create a second index to save
>> modified and untracked files, and restore untracked files, without
>> affecting the main index.  This behaviour was carried on when it was
>> rewritten in C, and here, most operations performed on the second index
>> are done by forked commands (ie. `read-tree' instead of reset_tree(),
>> etc.).  This works most of the time, except in some edge case with the
>> split-index when the split file has expired and is deleted by a forked
>> command: the main index may still contain a reference to the now-deleted
>> file, and subsequent operations on the index will fail [0].
> 
> Thanks for working on this! I agree that it would be nice to fix split
> index issues as it could help for sure with huge repositories. Sorry
> also that this patch series fell through the cracks.
> 
> I am adding Son Luong Ngoc in Cc as he reported the issue that this
> series fixes.
> 
>> The goal of this series is to modernise (a bit) builtin/stash.c, and to
>> fix the aforementionned edge case.
>>
>> I have to admit that I don't really know how to test this.
>> GIT_TEST_SPLIT_INDEX failed on me (gdb showed me that it does not enable
>> the split-index at all, at least in `git stash' and its forks),
> 
> It should have worked when it was introduced, though maybe not for `git stash`.
> 
>> and I'm
>> reluctant to add explicits tests on `git stash' about the split-index,
>> when nothing in its code explicitly does unusual things with the index
>> once this series is applied.  If anyone wants to share opinions about
>> this, I would be happy to read them.
> 
> I understand. I think the good way forward would be to fix
> GIT_TEST_SPLIT_INDEX and find a way to ensure that it keeps working in
> the future.
> 
> Thanks,
> Christian.
> 

Thank you for your feedback.

I'll resend this series with the changes you and Son suggested, but I
think I'm going to remove references to bugs in the commit messages, to
turn it into another cleanup series.  For the index, I will to try to
implement Gábor's suggestions in another series.

Thanks,
Alban

