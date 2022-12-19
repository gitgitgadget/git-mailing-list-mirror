Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899FCC4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 23:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbiLSX66 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 18:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiLSX64 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 18:58:56 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C102705
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 15:58:55 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id 65so7397593pfx.9
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 15:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGZOt3a3h7AiGFy6dGdBj+SwXXqjLEPwMaHnr5LyXPs=;
        b=gYlWvEEnZ2bZt0hF5eE9kBhZIJqfxIwA541i7loaBr/OtUlVfDzFNci0TdctLKFrkF
         cIZpqPVvDouzA9q/ycM3e6NogL3MeDDMuwntlx4uHBzJPCEr8ZqZg+Q+MAvIR/XbP2eo
         AjLi1NgfXuNi8z68MvddVzVwqhSB/cTL1NEhavY4wq8SrvlVUIOpO6DIZyPwzly3/12J
         cItklhJOCMtkm9cXN31Vhe6OLzTHzc21dP8Kv2TwkDKmwoVcICTmjWGz50wG/kkpwz7D
         e6IgG753yyKF+gslYTClvArRKr/YD+5zlswhFlD8isgblgHPBZlO9DdsiMkIAZAmINkU
         MdHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BGZOt3a3h7AiGFy6dGdBj+SwXXqjLEPwMaHnr5LyXPs=;
        b=rhDfcA3p8I0vlvU4u6k6CMp7bbqAewpVKg7JTonDiwlnXAYhY1JzZ1mLq+yzrKmvKd
         MuRxM83BJFZNMKMTB5lAPbywW9Ofvf4ir2bBKfcMXrLyPVRbYP08R5VMtceob9wmEJfZ
         huC/JX5l0sqVklcRmbHdv1bA1cJrUaFW8C88t6TrfiQRmM17dMpflRgTef9ZLAvRoI6y
         kSOouJNoPvGmapH+Z+eDMWuTgeMFHLGDi76qa8DOyRDJZqnD6gvMi4s2a5Ss0oIJawuj
         OzRpIdUBoq6taV7ktMhT9XRIvS8D1zyE7Tlyd55qUPlMpA44NmhVrM5QR37nO/A16Zjz
         PwuQ==
X-Gm-Message-State: ANoB5pmnMIsPQsriMqmySs3MiDgdN/VvlbkKotJooI5QfB07wKpaPI3Z
        nB/9xZqmmMjWPVAOZd59D08=
X-Google-Smtp-Source: AA0mqf6qaa1qtPFqFJWG0vlJkb+IiGUMzkZbZeBgvWXqeA+0RAQreolm6n1OLmqm4GlpAo7PkqsKww==
X-Received: by 2002:a62:a113:0:b0:56e:a7a7:35a0 with SMTP id b19-20020a62a113000000b0056ea7a735a0mr38328439pff.25.1671494334673;
        Mon, 19 Dec 2022 15:58:54 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 74-20020a62194d000000b005771d583893sm7402037pfz.96.2022.12.19.15.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 15:58:54 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] tests: make 'test_oid' print trailing newline
References: <20221218162905.3508164-1-szeder.dev@gmail.com>
        <221219.864jtrz9yf.gmgdl@evledraar.gmail.com>
Date:   Tue, 20 Dec 2022 08:58:53 +0900
In-Reply-To: <221219.864jtrz9yf.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 19 Dec 2022 16:27:12 +0100")
Message-ID: <xmqqfsdb2beq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> @@ -826,7 +827,7 @@ test_expect_success 'test_oid can look up data for SHA-1' '
>>  	grep "^00*\$" actual &&
> ...
> I also vaguely recall (although probably nobody worries about such a
> platform anymore) that POSIX utilities left themselves room to not work
> on things that weren't \n-terminated.

[jc: totally irrelevant curiosity-hunt]

I think you have in mind the combination of these.

 * "3.195 Incomplete Line" defines an incomple line as "A sequence
   of one or more non-<newline> characters at the end of the file."

 * "3.403 Text File" defines a text file to be "A file that contains
   characters organized into zero or more lines. ... many utilities
   only produce predictable or meaningful output when operating on
   text files".

 * "INPUT FILES" section of "grep" for example says "The input files
   shall be text files".

It may look unclear if "an incomplete line" is supposed to be a
"line", and if it is not, then the output from "test_oid zero" we
are grepping in in the above snippet is not a "text file".

The "INPUT FILES" section of "sort" states something interesting.

    The input files shall be text files, except that the sort
    utility shall add a <newline> to the end of a file ending with
    an incomplete last line.

Why is this interesting?  Because it smells like it is clarifying
whether it makes file a text to end in an incomplete line, but it
does not do any such thing ;-)  You can read it in two ways:

 * You must feed text files to "sort", but if you did feed a file
   that ends with an incomplete line, the utility adds <newline> at
   the end, which makes it a text, so the inputs to the utilities
   all becomes "text".

   Under this reading, you can as an exception feed a non-text file
   to the utility, as long as its non-text-ness is limited to ending
   with an incomplete line.  So, a file that ends with an incomplete
   line is *not* text.

 * You must feed text files to "sort", and an text file that ends
   with an incomplete line gains terminating <newline> at the end of
   that last line, so a hit on that line will be shown, terminated
   with <newline>, just like a hit on any other line.

   Under this reading, a text file may or may not end with an
   incomplete line, so a file that ends with an incomplete line is
   text.

https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap03.html
https://pubs.opengroup.org/onlinepubs/9699919799/utilities/grep.html
https://pubs.opengroup.org/onlinepubs/9699919799/utilities/sort.html

So I dunno.

In any case, I think it is a good practice to avoid having to worry
about how the standard utilities would behave by making sure our
lines are complete.

