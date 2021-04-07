Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C84C433ED
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 23:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0699610FA
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 23:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbhDGXBV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 19:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhDGXBU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 19:01:20 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF908C061760
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 16:01:09 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id n2so24090609ejy.7
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 16:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=pwWL70zKYK5/5NuHWCJy6iTPiAVD0ROmHlDr+VQo2+M=;
        b=DVatLfCeYnYT4WZjyFMurbvM66Fh+6dMtsE9qGUZiuomcZ9JWDkLuLHeFuOzbrdxZb
         dK+kUdRFYcqCMhrwzbNmib0RJCvDIemp2YR81u9Giyjcml6QNmWlL7l91X3fOuSRAyNl
         FF5E4ChBXCNFSMtoQElUXHwhGht0DLs+WrMNjQ98qL1H1sD40ZXwDWWzRwVAVzX3hhSh
         HUAFJ7gGomaD/l7a7ynWi610edt6t8PjvjHiLcsEpkWWYKGaVbFw8FEYpoyzH9toHqvv
         HyHQJ5qvP6WHGVWUXGJg0FsBsNBZYxF6dSe6ev1udFAmX//AvMo8Ku7XBtfaranNB/0h
         Sm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=pwWL70zKYK5/5NuHWCJy6iTPiAVD0ROmHlDr+VQo2+M=;
        b=q15lVai1XtNdn/Ql9bjnOug0NsEm0cNjaU5sN1HYb2LEAp0uQ0L9rGXmeqXzBg932e
         xUmNnIjIxZMnbemxUyw6OaqqzjtQVPg81cjf2LO25Sx4BiZ2lVo4mmG/6ekQWVOO8ufo
         0eqxFANh93hDz9SjndGr47vFwWBiQORwChl0moxAB2jz8pzOvFuFLdEXVr0mXlVE/Ig0
         hI8rne0bapvxXVFwd+XT3VkA1iyOHQp7MVUcKxbIYCELgblp9KHSYz90nMrRrJR4jNlw
         AdwZzK0y4v8400hixam7ulfGUkY93A9m938BRtpASugGkiTWIus/rfsKLc8o0rFe3xiN
         Udzg==
X-Gm-Message-State: AOAM530YdRzrEISBJcwD6J1pVWcqDudkkM3RgnrIMRYZ38wiD2oETsH0
        k5a7msnKyFoGYL6D6pPJ/KCwRHaT0adCQg==
X-Google-Smtp-Source: ABdhPJxfd3pQqHAI3fONNNJEspY3zWT494iXY+URDk7Fl/HK1zu5CPCpLXv1zgYUT4mSCuv7ZT3I8Q==
X-Received: by 2002:a17:906:cd0e:: with SMTP id oz14mr6730415ejb.60.1617836468575;
        Wed, 07 Apr 2021 16:01:08 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id eo22sm13394850ejc.0.2021.04.07.16.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 16:01:08 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, tom.saeger@oracle.com,
        sunshine@sunshineco.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 3/5] refspec: output a refspec item
References: <pull.924.git.1617627856.gitgitgadget@gmail.com>
 <e10007e1cf8ff0005295f648b9489c11a9427122.1617627856.git.gitgitgadget@gmail.com>
 <87r1jmjxdg.fsf@evledraar.gmail.com>
 <b3e00d3e-c782-9f2a-14e0-f576e50a7e55@gmail.com>
 <87czv5kaxw.fsf@evledraar.gmail.com> <xmqqy2dtww0h.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqy2dtww0h.fsf@gitster.g>
Date:   Thu, 08 Apr 2021 01:01:06 +0200
Message-ID: <871rblk8ct.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 08 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Wed, Apr 07 2021, Derrick Stolee wrote:
>>
>>> The purpose is to allow us to modify a 'struct refspec_item'
>>> andproduce a refspec string instead of munging a refspec string
>>> directly.
>
> Ouch.  I thought the goal was to take
>
>     [remote "origin"]
> 	fetch =3D $src:$dst
>
> let the code that is used in the actual fetching to parse it into
> the in-core "refspec_item", and then transform the refspec_item by
>
>  - discarding it if the item does not result in storing in the real
>    fetch
>
>  - tweaking $dst side so that it won't touch anywhere outside
>    refs/prefetch/ to avoid disturbing end-user's notion of what the
>    latest state of the remote ref is.
>
> so that the "parsed" refspec_item is passed to the fetch machinery
> without ever having to be converted back to textual form.
>
> Why do we even need to "andproduce a refspec string"?

We're shelling out to "git fetch", but we first munge the refspec on in
"git gc".

But yes, it seems even more straightforward to do away with passing the
refspec at all to "git fetch", and instead pass some (maybe internal
only, and documented as such) "--refspec-dst-prefix=3Drefs/prefetch/"
option to "git fetch".

I.e. get_ref_map() over there is already doing a version of this loop
over "remote->fetch.nr".

So instead of "git gc" doing the loop, then passing all the refspecs on
the command-line, it could tell "git fetch" to do the same munging when
it does the same iteration.

Doing the munging in builtin/gc.c's fetch_remote() just seems like a
relic from when we didn't care what decision builtin/fetch.c made about
refspecs, we always wanted our custom one.

