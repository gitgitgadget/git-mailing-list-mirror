Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215E5C433E2
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 08:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD325619AD
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 08:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbhC2INH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 04:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbhC2IM0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 04:12:26 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17081C061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 01:12:26 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id a22-20020a17090aa516b02900c1215e9b33so7320110pjq.5
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 01:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Obi2TvoauuYnWSsuTTcLm7TRu9IDry/zdeDFpI6F7Ak=;
        b=AKz8I/CUem34hTQUxTa3mZjALLakHtgEE8zVd1lLKgMLokrXpexyg/txMz/lSKAmxk
         wmG2KyMZ3sUVjx6I5eNOLiTH/XbJuEnL8U1Ym74A9kNdCpBNp85kjRK58ysp8NW58X9E
         y26ip39T6QvhNZw7oHbj/MnmD2TG1aO/TeBHAQg/Jjea/CsaTrNFnuCM9o8TlyotEzrY
         BHV9qsTy50Lx6jHjfX8WdjdxaPcu7JfV7jttkB6bymH0QAKqOK+7xflq7c9Fh1M5CcUS
         +op6kUTCuZ24m51u+ihqFj+i4SFV8rcb9EaJLFXJiE0cRUw8ff1oEqHIlqh2SRzRT6sB
         QpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Obi2TvoauuYnWSsuTTcLm7TRu9IDry/zdeDFpI6F7Ak=;
        b=Eesav4D64HR9ggL4chbsziXaj7R05BNxhG/L5k13KWsMRTRjOyMjeli4Wz5B9LYTr2
         vd1z9rnp5aPvGAHOpUPLPkh1fUFM3LCrW4hPRmwpv7KVT7cakDPVAQSC0FB1I9HI1f6w
         NdFOw3L1MJ39xZKPQo5h7E+U/XFqNltbby2LB0sR/MaaRQyCbGeF93i+usTktmiXMdSM
         niArjlZF18/y/WwGavFNTFQZeMb9NKO17gfJmqRBv2M54bX6o1cDQCICqlpr0J9aYzFJ
         v/XBmNXD03pWOecsGjDNBywO+edHtUH9XaA3cVfut5n3RaHy6pbf4GGZSrcxBWI8Gk+1
         f9kg==
X-Gm-Message-State: AOAM530zyjn7GoV2bifivVbBBHT2iCajn9p1XsNxf+WOxYftSsSu62FG
        dqZAUcXhoO11emWRFOaGdNc=
X-Google-Smtp-Source: ABdhPJy0agMWZN9+Wxn3VJlGXgjUs+gI8tkofymDSOXBjFQgIHS8ARSJUINZnNDWzlBU9APKk2auQQ==
X-Received: by 2002:a17:902:ff01:b029:e7:147f:193 with SMTP id f1-20020a170902ff01b02900e7147f0193mr21976562plj.82.1617005545583;
        Mon, 29 Mar 2021 01:12:25 -0700 (PDT)
Received: from atharva-on-air.dlink ([119.82.121.20])
        by smtp.gmail.com with ESMTPSA id d20sm9107097pfn.166.2021.03.29.01.12.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Mar 2021 01:12:25 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [GSOC][PATCH] userdiff: add support for Scheme
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <xmqqft0fm9uu.fsf@gitster.g>
Date:   Mon, 29 Mar 2021 13:42:22 +0530
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <562DCDA0-EAE6-408F-97D7-127689DE5559@gmail.com>
References: <20210327173938.59391-1-raykar.ath@gmail.com>
 <xmqq5z1cqki7.fsf@gitster.g> <EBC020E6-BE8B-4332-8225-A988CB7CFA69@gmail.com>
 <xmqqft0fm9uu.fsf@gitster.g>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28-Mar-2021, at 23:36, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Atharva Raykar <raykar.ath@gmail.com> writes:
>=20
>>>> +         "(\\.|[^][)(\\}\\{ ])+"),
>>>=20
>>> One or more "dot or anything other than SP or parentheses"?  But
>>> a dot "." is neither a space or any {bra-ce} letter, so would the
>>> above be equivalent to
>>>=20
>>> 	"[^][()\\{\\} \t]+"
>>>=20
>>> I wonder...
>>=20
>> A backslash is allowed in scheme identifiers, and I erroneously =
thought that
>> the first part handles the case for identifiers such as =
`component\new` or=20
>> `\"id-with-quotes\"`. (I tested it with a regex engine that behaves =
differently
>> than the one git is using, my bad.)
>=20
> Ah, perhaps you didn't have enough backslashes.  A half of the
> doubled one before the dot is eaten by the C compiler, so the regexp
> engine is seeing only a single backslash before the dot, which means
> "literally a single dot".  If you meant "literally a single
> backslash, followed by any single char", you probably would write 4
> backslashes and a dot---half of the backslashes would be eaten by
> the compiler, so you'd be passing two backslashes and a dot, which
> is probably what you meant.
>=20
> Having said that, two further points.
>=20
> - the "anything but whitespaces and various forms of parentheses"
>   set would include backslash, so 'component\new' would be taken as
>   a single word with "[^][()\\{\\} \t]+", wouldn't it?
>=20
> - how common is the use of backslashes in identifiers?  I am trying
>   to see if the additional complexity needed to support them is
>   worth the benefit.

I have refined the regex, and now it is much simpler and does all of =
what
I want it to:

	"([^][)(}{[:space:]])+"

I did not have to escape the various parentheses, so I avoided the need =
to
handle backslashes separately. The "\\t" was causing problems as well =
because
it took it as a '\' followed by a 't' (Thanks to j416 on #git-devel for
helping me out on this).

>> Yes, this is exactly what I was trying to express. All words should =
be
>> delimited by either whitespace or a parenthesis, and all other =
special
>> characters should be accepted as part of the word.
>=20
> That sentence after "All words should be..." would be a good comment
> to replace what you wrote in the original, then ;-).

Yes, that should make it a lot more clear.

