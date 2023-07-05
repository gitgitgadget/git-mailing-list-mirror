Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FE1EB64DA
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 16:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbjGEQQE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 12:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjGEQQD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 12:16:03 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7841730
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 09:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1688573757; x=1689178557; i=l.s.r@web.de;
 bh=VcGvlwNUKCVK86Z4gSSDXJvqdFtxg6adL772mCgKxE4=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=tvYc9YElfNW2spDLtmuge2y/ZuhnJ2mdHGEjwT4OV5oZhTi8jkevBSpSG2wGq9d6gm246c5
 ZKj3VNrKPfgevtnUVXYZydbUNqBHAclsnWvBtSRDcvHSBZbxOb1JoxoWfFlHlW6EO0aB059rc
 2ZoTdL5yx2E/yit+t/FJFAdnEUorLSP8GxlyfdMQ5ArEG8ia4w5qIG55RtW2tOxTXbi6a9jCn
 6vbrHXsGd7CDXLyLsEjtIxKQ2NjpbLyrhiaCw+opHLz0jfCQ6xqYplNS6nxhcerbMdgNXiM8X
 ZCJ1PzccWfOPBGefyzreha9yEO9XXK7ubbFCWvd+vFP1mdQptbjw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.159.50]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MEUWM-1qFSKN0LBy-00GUvX; Wed, 05
 Jul 2023 18:15:57 +0200
Message-ID: <32f41065-a78c-aa60-0d78-4dbfa8827b1a@web.de>
Date:   Wed, 5 Jul 2023 18:15:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] pkt-line: don't check string length in packet_length()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
References: <89d58db7-6a01-b3fa-54f0-19d5a3819eb3@web.de>
 <xmqqttui3nqn.fsf@gitster.g>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqttui3nqn.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fQ91RRuRbm8V0Fl/DCgId/nuY5cjCNe5mQB/snQbYubRgmodtnE
 2uHxEeWEYa7wHg7CWZYc0Du7hsJ65gp5UVvnbVJ/TudR4nx6zQYEdZVGO8ZdZyfqXUpqfT2
 R+krTtPrlKJtXSz0tdCwcjv7aU/GGDyD5+o9DmUzE5T3Ih79CkfGWbjsuVAXmB/JEiDfURp
 uZMCKJbNYYenI69UeIU0g==
UI-OutboundReport: notjunk:1;M01:P0:0sJD51Wayi0=;v99QcISDg5nj1zjAfXKMvHqDNF+
 kGabjjz31C/O+asessJyRXfpRG6DYxJhCg/GE83l9KzvFQBSjVUBzKRCDMx8r6DMvdfNUMe8+
 J8r9CPL98GSMVHBHOXvrlZ8+DWuhD5H7q9+hCe4MvM+KSqfAyXojcN2lL4pX5W1aoPyELqSgw
 gSX+wgEiHpMHRiupt6edLccup15S2M/L9F4HSFLmdt55DV2LSMeJswomV5cHW5tausTykVwca
 0EOWwsqnEdVEZ08HWqYyb4zTF/3nquE6HChlu8jrZaHuSbskTcjnEJfasQAOGKzbTYaoZbNco
 roOLCTMfDd+Tx6PMh0i7MgVKZu1vJkv1hUAWYBZsgB1jHNuf8gTIw0O1CbjJbEyT0iHKETyPw
 2aot7VeHQ4C4dEocajG0IHA8raDW6CQW863d3cyk9sFakRxdkiPpY++MCdVKeghuFZ1ZGhBvs
 OUdtBMOOEUpS2qNwQJLDjdHSHSadMU6dne4vSHzC5zQNfYKpWtDuF/zizcmRI+Uoq9rSpzfF5
 rTZW3AVm4yoEdrl6Rz3xuz9yEOKsWo4ukYS88PNrHOHFv55GzX1tko7wrK+13Kapq3FKqHMNq
 utAcfNQPQeFMBwgl+VgS5MY7/PSD7krJlP3WbSTzlJ6I7F29RtTGIS1Oy6qMLW/9wtM45JIo1
 dVJzhnYw1LK0tig1vHTsejzpk+5KbmZ3XJ+uaVgr0WP/UmE18f9ej9BEiNrzTTE0NZASIb1ZI
 E5B++26RJfR3SPmE4XbyK0ByEsQBFgeAJoe0v0A8rl3TmR1j/NJucjqxjRDfyZZ6T8iorGd+z
 cPyYYJwLl/Sf1WAp/TxxpjhSTth9hvilF+sLqJ5OMUdGUWRsiBboE5j93WfJsq6I36XdADrPl
 pXpKBLYv5O35hu0V3+GTGTlTvUjs4ZmEY26gn+FULY7KDuABvfVyQsHg3m1MRbM29+DNqP9HC
 8QAk0Q==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.07.23 um 07:56 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> hex2chr() takes care not to run over the end of a short string.
>> 101736a14c (pkt-line: extern packet_length(), 2020-05-19) turned the
>> input parameter of packet_length() from a string pointer into an array
>> of known length, making string length checks unnecessary.  Get rid of
>> them by using hexval() directly.
>
> I am puzzled about the part of the above description on "making
> string length checks unnecessary".  The two callers we currently
> have both do pass char[4], but the compiler would not stop us from
> passing a pointer to a memory region of an unknown size; if we
> butcher one of the current callers
>
> diff --git c/pkt-line.c w/pkt-line.c
> index 6e022029ca..e1c49baefd 100644
> --- c/pkt-line.c
> +++ w/pkt-line.c
> @@ -421,7 +421,7 @@ enum packet_read_status packet_read_with_status(int =
fd, char **src_buffer,
>  		return PACKET_READ_EOF;
>  	}
>
> -	len =3D packet_length(linelen);
> +	len =3D packet_length(buffer);
>
>  	if (len < 0) {
>  		if (options & PACKET_READ_GENTLE_ON_READ_ERROR)
>
> where "buffer" is just a random piece of memory passed to the caller
> and there is no such guarantee like "it at least is 4 bytes long",
> we would just slurp garbage and run past the end of the buffer.

Indeed, GCC warns if you give it a short array, but not if you pass a
pointer: https://godbolt.org/z/T3xfE5W9n.  Clang doesn't care at all.

So that was wishful thinking on my part.  Sorry.  :-/

>> The resulting branchless code is simpler and it becomes easier to see
>> that the function mirrors set_packet_header().
>
> I do like the resulting code, but I feel a bit uneasy to sell this
> change as "the code becomes more streamlined without losing safety".
> It looks more like "this change is safe for our two callers; those
> adding more callers in the future are better be very careful", no?

With no way to enforce passing an array of a certain size to a function
the only safe options I see are keeping the length check, using a macro
or inlining the calculation.  Hmm.

Ren=C3=A9
