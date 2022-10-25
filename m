Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E241CC04A95
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 10:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbiJYKVI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 06:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbiJYKUu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 06:20:50 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDB41162C1
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 03:17:31 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b12so35516118edd.6
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 03:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+Jf5osTvqsn4F/TOOKJ3MHbkMax/gjttHTdSZyZf3ck=;
        b=WcUjSh23+lBiu4BuctummsurdikCjetktuydyAXF/hbTE3piT3TEcFmEJ2OJHwmmpO
         o52sxzQSF2VYN+bmFYNTpbrXzCnSSjFzXH2fov46K+/R0WdxmxbMKegBt3TfoNN5EH5e
         QWu3qz3HXrgMS8k7tnYCs5Uf/AfyCKQbosLusVq19uRzr4vawkWSkZk6XpxPYzxVJdJ6
         mx4JEkPmELRQMrTNPCXwBQg9Nb86dEut0IDw3fp4BGdaRAyVXI/dpua5KiuH3ckanHdZ
         UN5mzn4rEmMJMWqnROLhjhj/RRa1/eJArUOtzQa11HWYKgpbMVPjhwIvy6ZRYxA65Qdm
         0uuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Jf5osTvqsn4F/TOOKJ3MHbkMax/gjttHTdSZyZf3ck=;
        b=a07q6Sja+odg0DQ+AUyk5ggkog9j0L1DtVFL+7MgtqbVBFUI5/uKHLRwa057ai5QRk
         NWl7rfc6ZMSy4kWhvf6+uafDjCUvKkawU+9U9ZNYt/AoaXN3F1EV+XMS9oO/ynwfxlhR
         VHv6ql7BeiSuuRuSybhSJyOPzPaj89p5hSSP7v8W3lZU1Tlp1UdgCe+q7egE4IklgVCl
         m7DJbHnULa0d1M9vl3Hfq4ittlUf6DEGbB3+plEwjeyqColnTc0ja/tYJkZH3lXL6Es3
         inLJsn+JEOuGhSyDSP8nxKkp8uwDx+Gi7qFf/iQWNVMSPa1WF5AAFmym9huBIxSy6L4I
         odjw==
X-Gm-Message-State: ACrzQf2H5a5cuS4rMDNBBwdoihTdOcHeEruQJxEbdkCQvMmAAhj1WsBW
        /isbHwmUehmeOhaLwtE2Pojfxt3QrCk=
X-Google-Smtp-Source: AMsMyM6cIQDgWfBtQhejTIUE34CKZ81UYQz1G/FOPkpx/h01XFwDaKqonAIM98N6D4ASxWJTSwL/IQ==
X-Received: by 2002:a05:6402:f2a:b0:461:eff7:bae8 with SMTP id i42-20020a0564020f2a00b00461eff7bae8mr5617217eda.322.1666693049787;
        Tue, 25 Oct 2022 03:17:29 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id ka3-20020a170907990300b0073cd7cc2c81sm1132433ejc.181.2022.10.25.03.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 03:17:29 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1onGzw-007v6J-1M;
        Tue, 25 Oct 2022 12:17:28 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: chainlint.pl's new "deparse" output (was: [PATCH v2] [...])
Date:   Tue, 25 Oct 2022 12:07:43 +0200
References: <pull.1324.git.git.1663023888412.gitgitgadget@gmail.com>
 <pull.1324.v2.git.git.1663041707260.gitgitgadget@gmail.com>
 <221024.865yg9ecsx.gmgdl@evledraar.gmail.com>
 <CAPig+cT=cWYT6kicNWT+6RxfiKKMyVz72H3_9kwkF-f4Vuoe1w@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <CAPig+cT=cWYT6kicNWT+6RxfiKKMyVz72H3_9kwkF-f4Vuoe1w@mail.gmail.com>
Message-ID: <221025.86o7u0cimf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 25 2022, Eric Sunshine wrote:

> On Mon, Oct 24, 2022 at 6:28 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> On Tue, Sep 13 2022, Eric Sunshine via GitGitGadget wrote:
>> > When `chainlint.pl` detects problems in a test definition, it emits the
>> > test definition with "?!FOO?!" annotations highlighting the problems it
>> > discovered. For instance, given this problematic test:
>> >
>> >     test_expect_success 'discombobulate frobnitz' '
>> >         (echo balderdash; echo gnabgib) >expect &&
>> >     '
>> >
>> > chainlint.pl will output:
>> >
>> >     # chainlint: t1234-confusing.sh
>> >     # chainlint: discombobulate frobnitz
>> >     (echo balderdash ; ?!AMP?! echo gnabgib) >expect &&
>>
>> I've noticed that chainlint.pl is better in some ways, but that the
>> "deparse" output tends to be quite jarring. but I can't find version of
>> it that emitted this "will output" here.
>
> There is no such version.
> [...]
> No, I botched the commit message. I typed the example test in by hand
> and then, also by hand, typed in the example output, forgetting to
> insert the spaces which you correctly noted are missing from the
> example output. I should have run the example test through
> chainlint.pl and copy/pasted its output into the commit message. (I
> did, in fact, run the sample test through chanlint.pl _after_
> hand-typing the example output, and compared them by eye but missed
> most of the whitespace differences.)
>
>> Anyway, that sort of an aside, but I did go hunting for the version with=
 slightly better whitespace output.
>
> Sorry, my fault for a faulty commit message.

No worries!

>> But to get to the actual point: I've found the new chainlint.pl output
>> harder to read sometimes, because it goes through this parse & deparse
>> state, so you're preserving "\n"''s.
>>
>> Whereas the old "sed" output also sucked because we couldn't note where
>> the issue was, but we spewed out the test source verbatim.
>
> Somewhat verbatim. chainlint.sed did swallow blank lines and comment
> lines, and it folded multi-line strings into one-line strings.

Yeah, it had a lot of edge cases, the new one's much better overall. I
just sometimes found it jarring to look at code that's not /quite/ my
version now, but anyway... :)

>> But it seem to me that we could get much better output if the
>> ShellParser/Lexer etc. just kept enough state to emit "startcol",
>> "endcol" and "linenum" along with every token, or something like that
>> (you might want offsets from the beginning of the parsed source
>> instead).
>>
>> Then when it has errors it could emit the actual source passed in, and
>> even do gcc/clang-style underlining.
>>
>> I poked at getting that working for a few minutes, but quickly saw that
>> someone more familiar with the code could do it much quicker, so
>> consider the above a feature request :)
>
> Yes, there should be better integration between the lexer and parser
> for emitting errors. Unfortunately, it didn't occur to me during
> implementation, and I only thought about it when Peff mentioned the
> difficult-to-read output in a different part of this discussion.
>
> An alternative, somewhat hacky approach, might be to simply retain
> whitespace as tokens in the token stream. That would require less
> retrofitting of the lexer, though perhaps more complexity/ugliness in
> the parser. It wouldn't give you gcc/clang-level underlining, etc.,
> but would more or less preserve whitespace in the test definition.
> Definitely not a proper solution, but perhaps "good enough".

Yeah, maybe.

>> Another thing: When a test *ends* in a "&&" (common when you copy/paste
>> e.g. "test_cmp expect actual &&\n" from another test) it doesn't spot
>> it, but instead we get all the way to the eval/117, i.e. "broken
>> &&-chain or run-away HERE-DOC".
>
> Yes, I recall considering that case and others, but decided that
> that's probably outside the scope of the linter. In particular, a
> trailing "&&" is a plain old syntax error, and the shell itself is
> perfectly capable of diagnosing that problem along with all other
> syntax errors, and you'll find out about syntax errors in your code
> when the shell tries running it. The linter, on the other hand, is
> meant to catch semantic problems (per the project's best-practices) in
> what is assumed to be syntactically valid shell code. I suppose the
> linter could be made to complain about this syntax error and others,
> but it seems unnecessary to bloat it by duplicating behavior already
> provided by the shell itself.

FWIW I thought it would be nice because it sometimes takes 10s or
whatever to get to the syntax error by running the test, but the linter
can find it right away.

> It is unfortunate, though, that the shell's "syntax error" output gets
> swallowed by the eval/117 checker in test-lib.sh and turned into a
> somewhat less useful message. I'm not quite sure how we can fix the
> eval/117 checker to not swallow genuine syntax errors like that,
> unless we perhaps specially recognize exit code 2 and, um, do
