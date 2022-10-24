Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E10C38A2D
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 10:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiJXK2F (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 06:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJXK2D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 06:28:03 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E080E2018A
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 03:28:01 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id x2so2159482edd.2
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 03:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xL5fWXNSgYWF9V/dsChwr3ZteLLiZGCy4lJZXIm1lXU=;
        b=pAi56r3d1SsQv2/43l1cq1R93CBof5//6GoWmJe1yXKyRqt4ailZYhIsXPqkFUgK2p
         K1/Ob/9HJSZB3YWz9yErqFRmdrCOmtsTWsMZR/sxUssGD1xRHr3b1/poUtvFqnFNUylo
         jaiFQVaV0SNBS+hTjOq7GOFnGp8IyiE65CebgNSEHhPotYCxT165MG86A9owBEJIvMrC
         Owkt7ubnCSwBizzQY5UQE4ekJ+TxN58UrxU5xK8fLd33QjJSVsSvkjhtaOrzdYH1F3NC
         MWKk3qunTfa/MXBxrUPuKMryhrOd2cCAiV6FTT+Ln76tC8G1pA/ZwapgbRS5xMu5BNyP
         zfAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xL5fWXNSgYWF9V/dsChwr3ZteLLiZGCy4lJZXIm1lXU=;
        b=EI8Wz1vHAMHs01D0+Ys+LUsHCSfVeNLEtUBZxr9wOWOUW2Ytk5tBnqx53IzSRb9FFa
         0BSk093lMPEdvVexmQ0AJvoEbwfAGKZ3c5v2/PTvLwajSWotGJk7tVx3ibkDAswbqE4y
         OlRq4Tp78mIa/kolaUHaBmaG+2/D/EP/l706t2Wfy/SWi65O7074YvtRtfvDE3sl22w0
         iNiSMG+xP1h6vw89GLlVR68Xd84cTraBQ5atC5mbVIZ1YDn12PKjNrfEN9nOokCBz7QG
         6zvI3V13+Tz6ProzbSXlS8OhP8ytHpdOwMl/R3kkiA1SbSfPNrfKdvC66j29A109TeVB
         dGvg==
X-Gm-Message-State: ACrzQf1lVI8soZ9TZm3ukMBvwkI+RyTo9CpUBwH1lwjapM3a6B55EfC7
        B8EH4gpFyb35M1deH2czoyA=
X-Google-Smtp-Source: AMsMyM4yL0NvHmYa+8Ba82ti2vnZo/OYmvKE3sYy+QRvorMx008UEufpQ0indsE9PoOOCXzMZb0alg==
X-Received: by 2002:a17:907:25c5:b0:782:978d:c3da with SMTP id ae5-20020a17090725c500b00782978dc3damr26674398ejc.623.1666607280313;
        Mon, 24 Oct 2022 03:28:00 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id u1-20020a1709061da100b0073bdf71995dsm15279603ejh.139.2022.10.24.03.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 03:27:59 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1omugY-007aYY-2r;
        Mon, 24 Oct 2022 12:27:58 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: chainlint.pl's new "deparse" output (was: [PATCH v2] [...])
Date:   Mon, 24 Oct 2022 11:57:36 +0200
References: <pull.1324.git.git.1663023888412.gitgitgadget@gmail.com>
 <pull.1324.v2.git.git.1663041707260.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <pull.1324.v2.git.git.1663041707260.gitgitgadget@gmail.com>
Message-ID: <221024.865yg9ecsx.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


[Please ignore the just-sent empty
https://lore.kernel.org/git/221024.86a65lee8i.gmgdl@evledraar.gmail.com/;
local PBCAK problem :)]

On Tue, Sep 13 2022, Eric Sunshine via GitGitGadget wrote:

> From: Eric Sunshine <sunshine@sunshineco.com>
>
> When `chainlint.pl` detects problems in a test definition, it emits the
> test definition with "?!FOO?!" annotations highlighting the problems it
> discovered. For instance, given this problematic test:
>
>     test_expect_success 'discombobulate frobnitz' '
>         git frob babble &&
>         (echo balderdash; echo gnabgib) >expect &&
>         for i in three two one
>         do
>             git nitfol $i
>         done >actual
>         test_cmp expect actual
>     '
>
> chainlint.pl will output:
>
>     # chainlint: t1234-confusing.sh
>     # chainlint: discombobulate frobnitz
>     git frob babble &&
>     (echo balderdash ; ?!AMP?! echo gnabgib) >expect &&
>     for i in three two one
>     do
>     git nitfol $i ?!LOOP?!
>     done >actual ?!AMP?!
>     test_cmp expect actual

I've noticed that chainlint.pl is better in some ways, but that the
"deparse" output tends to be quite jarring. but I can't find version of
it that emitted this "will output" here.

Before this patch, or fb41727b7ed (t: retire unused chainlint.sed,
2022-09-01) we'd emit this instead:
	
	git frob babble &&
	( echo balderdash ; ?!AMP?! echo gnabgib ) > expect &&
	for i in three two one
	do
	git nitfol $i ?!LOOP?!
	done > actual ?!AMP?!
	test_cmp expect actual

The difference is in whitespace, e.g. "( ", not "(", "> " not ">".  This
is just because it's emitting "raw" tokenizer tokens.

Was there maybe some local version where the whitespace munging you're
doing against $checked was different & this commit message was left
over?

Anyway, that sort of an aside, but I did go hunting for the version with slightly better whitespace output.

But to get to the actual point: I've found the new chainlint.pl output
harder to read sometimes, because it goes through this parse & deparse
state, so you're preserving "\n"''s.

Whereas the old "sed" output also sucked because we couldn't note where
the issue was, but we spewed out the test source verbatim.

But it seem to me that we could get much better output if the
ShellParser/Lexer etc. just kept enough state to emit "startcol",
"endcol" and "linenum" along with every token, or something like that
(you might want offsets from the beginning of the parsed source
instead).

Then when it has errors it could emit the actual source passed in, and
even do gcc/clang-style underlining.

I poked at getting that working for a few minutes, but quickly saw that
someone more familiar with the code could do it much quicker, so
consider the above a feature request :)

Another thing: When a test *ends* in a "&&" (common when you copy/paste
e.g. "test_cmp expect actual &&\n" from another test) it doesn't spot
it, but instead we get all the way to the eval/117, i.e. "broken
&&-chain or run-away HERE-DOC".

More feature requests (because for some reason you've got infinite time,
but I don't :): This software is really close to being able to also
change the tests on the fly. If you could define callbacks where you
could change subsets of the parse stream, say a single command like:

	grep some.*rx file

Tokenized as:

	["grep", "some.*rx" "file"]

If you could define an interface to have a callback function e.g. as:

	sub munge_line_tokens {
		my $t = shift;

                return unless $t->[0] eq "grep"; # no changes
                my @t = @$t;

                return [qw(if ! grep), @t[1..$#t],
                	qw(then cat), $t[-1], qw(&& false fi)];
	}

So we could rewrite that into:

        if ! grep some.*rx foo
	then
		cat foo &&
		false
	fi

And other interesting auto-fixups and borderline coccinelle
transformations, e.g. changing our various:

	test "$(git ...) = "" &&

Into:

	git ... >out &&
	test_must_be_empty out
