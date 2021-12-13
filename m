Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE52C433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 16:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240506AbhLMQRP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 11:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234044AbhLMQRP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 11:17:15 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DD6C061574
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 08:17:14 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id o20so54258189eds.10
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 08:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=1BdW7I+qxvETiUp0lne/9H/jggQsIMfDS+0WnT1KRQc=;
        b=Pz/bXumh7oNTBoYF/J6tCHZffmnTScDAz2iIgyFywx/7v8b0+ZKWAQPhOXLlO7MXvn
         3OWVMyJDG/9MQeHq3aI7X46bAA58cJBnjxnzcZPhrnaJwAhryHpzWYQ+zT4Vp4LEp/mv
         oAknk5zL07kqyTflInAMZocopwoSorZ1PlKcQSwT7kC/wWF0x3sbFj1cLpDlMTHdfkGi
         +ETIvDAw7wkFFfzmCJpLRfkIfcT8I2TrkqNqeg6wiBpV7dZ/3oxUDc9+QkNOqzqcws5Y
         tLt74fuy252i4zf572vmUVVYicI5rnvF4RT7gUi3xkpjKApQyurVDa0zHKD8AxjRMeNH
         C5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=1BdW7I+qxvETiUp0lne/9H/jggQsIMfDS+0WnT1KRQc=;
        b=4UWXEdtdqLjQWVF8nn5UehQ7ziEHYiLGFRZVfWo1VeR//1yzKgHqwbb0VnszZMU4Qa
         bhi3dqb7yE4TuuSoBxiPF4mCzoxh33dqcCU+GGYHj49je00+eYe5yfwtCtnPMJWYigIz
         lwhuiNVBGWufq3IMzWVYTH3GMKs8eTVDyB8NAARYdYbTaN+0Y/L1V3TFQBFYTpubdLao
         Q+3M24rMTfBWRHYbMAa2nUwjCzRGATjcYhXRly/2OeSo54YDcI8WGkhm5IS6f3OTQ/bP
         NyAKHVGR8gfnZWev1d/TE0aN05Lx6qMeijGmWoiGy239RM1x58YF4g2mhzwtokoK7msQ
         FXSw==
X-Gm-Message-State: AOAM531grhs7JKBiCmqZcwTyM98/2+vK2gefhMZghaSF3z5Poui4psly
        Gjxq+lBrWC6iilzJ0wnBmle2D+XzF42dFg==
X-Google-Smtp-Source: ABdhPJwCrfSLn9Xtq4d/i3A/NiAbM3WMPuozJbj1tca7fWEyWXkgs7HyGoDTie70bgOKUjkuoH+5Tg==
X-Received: by 2002:a50:fc10:: with SMTP id i16mr65051114edr.84.1639412232728;
        Mon, 13 Dec 2021 08:17:12 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id du16sm305215ejc.183.2021.12.13.08.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 08:17:12 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mwo0k-000twl-MA;
        Mon, 13 Dec 2021 17:17:10 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Fabian Stelzer <fs@gigacodes.de>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 05/15] t/Makefile: optimize chainlint self-test
Date:   Mon, 13 Dec 2021 17:11:18 +0100
References: <20211213063059.19424-1-sunshine@sunshineco.com>
 <20211213063059.19424-6-sunshine@sunshineco.com>
 <20211213102224.y5psbojmivlxe5px@fs>
 <CAPig+cSKn6wdPKc=b8Xjqy5D=bVdu6FQtYKJuwN2VoV7pEEgHw@mail.gmail.com>
 <20211213154327.pmhopjbdlkz7dgjh@fs>
 <CAPig+cSXHBMgOUycL0cXuVCb_PJ2=x2w4wUkc7eQQueyk=0Uzw@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CAPig+cSXHBMgOUycL0cXuVCb_PJ2=x2w4wUkc7eQQueyk=0Uzw@mail.gmail.com>
Message-ID: <211213.86tufc8oop.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 13 2021, Eric Sunshine wrote:

> On Mon, Dec 13, 2021 at 10:43 AM Fabian Stelzer <fs@gigacodes.de> wrote:
>> Personally i find the initial for loop variant to be the most readable.
>> =C3=86vars makefile targets could be very nice too, but especially:
>>
>> +$(BUILT_CHAINLINTTESTS): | .build/chainlint
>> +$(BUILT_CHAINLINTTESTS): .build/%.actual: %
>> +       $(CHAINLINT) <$< | \
>> +        sed -e '/^# LINT: /d' >$@ && \
>> +       diff -u $(basename $<).expect $@
>>
>> i find very hard to grasp :/
>> I have no idea what is going on here: `<$< |` ?
>
> Ya, that line-noise is an unfortunate combination of shell and
> Makefile gobbledygook. The `$<` is effectively the source file (the
> file being passed into chainlint.sed), and the rest of it is just
> normal shell. `<` is redirection (using the source file `$<` as
> stdin), and `|` is the pipe operator (sending the output of
> chainlint.sed to another `sed`), and capturing it all via shell `>`
> redirection in `$@` which is the Makefile variable for the target
> file.

To add to that;
https://www.gnu.org/software/make/manual/html_node/Rules.html#Rules and
other relevant parts of the GNU make manual are very helpful here.

> Anyhow, although the commit message tries to sell this change as some
> sort of optimization, it's really in preparation for the new chainlint
> which wants to check all tests in all files with a single invocation
> rather than being invoked over and over and over. The self-test files
> also require more preprocessing to work with the new chainlint, so the
> implementation of `check-chainlint` gets rather more complex once the
> end state is reached. I'll think about it a bit, but at the moment,
> I'm still leaning toward this intermediate step as being beneficial to
> reaching the end state. However, my opinion could change since the way
> this is done here was probably influenced by an earlier iteration of
> the new chainlint, but now that the implementation of the new
> chainlint is concrete, it may not be especially important to do it
> this way.

I don't really care about the details of whether it's invoked once or N
times, although I think the N times with proper dependencies tends to
give you better error messages, but maybe you'll be changing it
significantly enough that the current map between chainlint files and
approximately what sort of thing they check won't be there anymore.

In any case, I'd think that a rule that used $< now (i.e. 1=3D1 file->out
prereq) would be better for the current state, and could just be changed
to use one of $^ or $+ later.

I.e. you can declare a "check.done" that depends on {1..10}.todo, and
get a list of all of those {1..10}.todo files if one changes, or just
the ones whose mtime is newer than a "check.done".

The reason I looked at this to begin with is that it takes it ~100-150ms
to run now, which adds up if you're e.g. using "make test T=3D<glob>" in
"git rebase -i --exec".
