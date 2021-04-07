Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FEFC433ED
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 22:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CE716115B
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 22:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhDGWFa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 18:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhDGWF3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 18:05:29 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63658C061760
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 15:05:18 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id r9so7621023ejj.3
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 15:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=5zRyeRrJ5W4+uFDpUbQVbbnmNELBDAfW4oPCHosxBXM=;
        b=iycAX/luoLggjtTkO+QtVI4j7x0q7KYTdhBrdhzTZEdnWc4XEs/tg94U7Sii1YubTr
         OEtYJ1hMQDy/WXobMiys1f687Wh0ARaglL1Ee/74z2uoHteQ/cUGok8tY5vblhgPjWjq
         /+ulm8e1ow1CrvoPY/YGLkGCXnXcPwYvFHj9AJyLwUN00m4udz84agZQqTq/AyzkMSiI
         5MiuAzuTuuxmkyKx/M2KKwzqzi8AoLzuBaDBtGbxTAfrJfiAYxSCv++wvIYT+OVoX7nN
         2b9wpCVlKTqW7PUhBVh76E2u7zbgcdotpil9EVfRPRGvWLiVte+l0ZYe6y/8sr3N9zhr
         ywvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=5zRyeRrJ5W4+uFDpUbQVbbnmNELBDAfW4oPCHosxBXM=;
        b=NzHjGcJGMk8GCWrLCsluPNm4SOMD8xBhREedbktWXHTX11fFo0Rr5tc+tjyLXWvm7Y
         6Si2R+wNCaIaF4dKoc3TcFVYcKEJd/ApZWU6JZgPKVG7NbXbg6G/42FWzuuhM8eF1sc5
         t9g6zhArdfbyX6aZKdK5C+CC+JOSp2syJ4NcI2I9CjXcwt5QTNC7h2QTyZcMzRWI3wAF
         r8LwVmDjUF6csw/ctY/44f9/w6/sSNGRAvThhixPM8RA1sH2oMmiNydeCFZZtCfY+kKb
         mUun/VVpmmt+VBApCAFIuADLbzpifJemPAMKZBE9moNkYKvJ2uW9G6ElTukoxoXzvC9p
         LrKw==
X-Gm-Message-State: AOAM5314fSZjKa9LyU1ofliCmWYkjeyoHesvCI3HgDjWyq61HHLyG0Gi
        ugnEis4Psw7FxDoznaKRKuM=
X-Google-Smtp-Source: ABdhPJyZsi/Jk9V8rGj5Cz+qCXJv9GMCnZ15kv3pWs8qNchJZOeG3G2f2RdbFT+80Wi6N2xy82MfeA==
X-Received: by 2002:a17:907:8315:: with SMTP id mq21mr6066304ejc.197.1617833117058;
        Wed, 07 Apr 2021 15:05:17 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id hz24sm8539683ejc.119.2021.04.07.15.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 15:05:16 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, tom.saeger@oracle.com, gitster@pobox.com,
        sunshine@sunshineco.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 3/5] refspec: output a refspec item
References: <pull.924.git.1617627856.gitgitgadget@gmail.com>
        <e10007e1cf8ff0005295f648b9489c11a9427122.1617627856.git.gitgitgadget@gmail.com>
        <87r1jmjxdg.fsf@evledraar.gmail.com>
        <b3e00d3e-c782-9f2a-14e0-f576e50a7e55@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <b3e00d3e-c782-9f2a-14e0-f576e50a7e55@gmail.com>
Date:   Thu, 08 Apr 2021 00:05:15 +0200
Message-ID: <87czv5kaxw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 07 2021, Derrick Stolee wrote:

> On 4/7/2021 4:46 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Mon, Apr 05 2021, Derrick Stolee via GitGitGadget wrote:
>>> +	return buf.buf;
>>=20
>> There's a downthread discussion about the strbuf usage here so that's
>> covered.
>
> And it's fixed in v2.
>
>> But I'm still confused about the need for this function and the
>> following two patches. If we apply this on top of your series:
>>=20=20=20=20=20
>>     diff --git a/t/helper/test-refspec.c b/t/helper/test-refspec.c
>>     index 08cf441a0a0..9e099e43ebf 100644
>>     --- a/t/helper/test-refspec.c
>>     +++ b/t/helper/test-refspec.c
>>     @@ -31,7 +31,7 @@ int cmd__refspec(int argc, const char **argv)
>>                             continue;
>>                     }
>>=20=20=20=20=20
>>     -               printf("%s\n", refspec_item_format(&rsi));
>>     +               puts(line.buf);
>>                     refspec_item_clear(&rsi);
>>             }
>>=20
>> The only failing test is:
>>=20=20=20=20=20
>>     + diff -u expect output
>>     --- expect      2021-04-07 08:12:05.577598038 +0000
>>     +++ output      2021-04-07 08:12:05.577598038 +0000
>>     @@ -11,5 +11,5 @@
>>      refs/heads*/for-linus:refs/remotes/mine/*
>>      2e36527f23b7f6ae15e6f21ac3b08bf3fed6ee48:refs/heads/fixed
>>      HEAD
>>     -HEAD
>>     +@
>>      :
>
> It should be obvious that taking refspecs as input, parsing them,
> then reformatting them for output should be almost equivalent to
> printing the input line.
>
> The point is to exercise the logic that actually formats the
> refspec for output. The test-tool clearly does this.
>
> The logic for converting a 'struct refspec_item' to a string is
> non-trivial and worth testing. I don't understand why you are
> concerned that the black-box of the test-tool could be done
> more easily to "trick" the test script.

Yes, but why do we need to convert it to a struct refspec_item in the
first place?

Maybe I'm just overly comfortable with string munging but I think the
smaller patch-on-top to use strbuf_splice() is simpler than adding a new
API just for this use-case.

But I'm still wondering if that @ v.s. HEAD case is something this
series actually needs in its end goal (but then has a missing test?), or
if it was just a "let's test the guts of the refspec.c while we're at
it".

>> So the purpose of this new API is that we don't want to make the
>> assumption that strrchr(buf, ':') is a safe way to find the delimiter in
>> the refspec, or is there some case where we grok "HEAD" but not "@"
>> that's buggy, but not tested for in this series?
>
> The purpose is to allow us to modify a 'struct refspec_item' andproduce a=
 refspec string instead of munging a refspec string
> directly.

But aren't we doing that all over the place, e.g. the grep results for
"refspec_appendf". Even for things purely constructed on the C API level
we pass a const char* now.

I'm not saying it wouldn't be nice to have the refspec.c API changed to
have a clear delimitation between its const char* handling, and C-level
uses which could construct and pass a "struct refspec_item" instead.

But is it *needed* here in a way that I've missed, or is this just a
partial testing/refactoring of that API while we're at it?

[Guessing ahead here because of our TZ difference]:

It seems to me that if this is such a partial refactoring it's a strange
way to go about it.

We're left with freeing/munging the "struct refspec" src/dst in-place
and re-constructing a string that has "+" etc., but we already had that
data in parse_refspec() just before we'd call
refspec_item_format(). That function could then just spew out a
pre-formatted string we'd squirreled away in "struct refspec_item".

If the lengthy paragraph you have at the end of 4/5 holds true, then
such an internal representation doesn't need to have the "refs/" prefix
stores as a const char* (in cases where it's not just "*" or whatever),
no?. We'd then be able to more easily init/copy/munge the refspec for
formatting.
