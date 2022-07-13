Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2D4C43334
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 11:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235740AbiGMLeV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 07:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235603AbiGMLeT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 07:34:19 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D72F599F6
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 04:34:18 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id e15so13712592edj.2
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 04:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=IUSk7BTxkY9O7nWmOViaoo4LEyHVjYgLsluAMtRYjMM=;
        b=LlfSWvJiEBV11RvY6FgDbJaJGJ8V8QfIKKqp2UhxPL5duATN5WESwcN8Y1q3lz0Mth
         qJwy5PPPnctEAMVw7tzeNte6bL7cqEJXShKJZ/M1PdnzyZPuyA7mJfQgRxa1gkuIw53F
         wz4DOi+ruuu/do4eIo7q22sOK3jAKxcBQSNvD9z5WZOo4JYUkJnmfHbUJy/I64/DbDHi
         Ii+zfUIOBB2Gze282V3bkgQc2FxPJvsKiOkZ7HRNazGkELLo0z8nfwndDArbclSscTXo
         ScMpGTdEsuefRZn0AbwESGRSf3EQfPbJPSUN+UAzp98xcL//vKNU7lgxm13UQKsLZw5T
         et4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=IUSk7BTxkY9O7nWmOViaoo4LEyHVjYgLsluAMtRYjMM=;
        b=I5tUF/M1tCWo0lqq1Qb/V8P7R4nLAlMpeZGNkvTpMUGdyfykfGfuqdii3L7bo+X9D9
         GKE37r+0Q2dnRfe9qt8l4NhKl6BQQ0lR+X8qWcWbeY0tdKBqjk8gTRYa/php5/FpOn/J
         c6r05voLJC3GVryexAeBh0GIGGfY9gRqPYi2iZFcy94fhVvCf9kX7xNQ3BhnUkNxE7p4
         eODw9HtP/PyqtikguhbnaJEV8AwaJ1B9v0Z4GoO5FKvhcw7tr+3cUrg3H5B2Vs/VI4t0
         E2cPchHJ2exgjW3y9D7KxYvnJX2G5oOvWZbIMcdLdSSooAJ91oVDteh+LO1ui+a4+6rJ
         h10g==
X-Gm-Message-State: AJIora+a2PdNFHNshV6pk1SRscyv9hoWjB7xtXxbUXQn3QMpve74bmLn
        BPJKFwgNHolrDipR91lAhZPfF8KXFNcE6w==
X-Google-Smtp-Source: AGRyM1s0whb4/HLdBK1ppES0I6yqJ3/HzxysA39dzk7ZsYDYIi/noZeCKVjdaOVQthEMd5yn7PC2QA==
X-Received: by 2002:a05:6402:4252:b0:43a:9232:dafc with SMTP id g18-20020a056402425200b0043a9232dafcmr4174068edb.243.1657712056759;
        Wed, 13 Jul 2022 04:34:16 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id 26-20020a170906311a00b0070e238ff66fsm4843694ejx.96.2022.07.13.04.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 04:34:13 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oBadA-001hvZ-Ob;
        Wed, 13 Jul 2022 13:34:12 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: js/bisect-in-c, was Re: What's cooking in git.git (Jul 2022,
 #03; Mon, 11)
Date:   Wed, 13 Jul 2022 13:18:39 +0200
References: <xmqqo7xufee7.fsf@gitster.g>
 <s3726r9p-r96o-7793-0qrq-o54rs4npr972@tzk.qr>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <s3726r9p-r96o-7793-0qrq-o54rs4npr972@tzk.qr>
Message-ID: <220713.865yk1456z.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 13 2022, Johannes Schindelin wrote:

> Hi Junio,
>
> On Tue, 12 Jul 2022, Junio C Hamano wrote:
>
>> * js/bisect-in-c (2022-06-27) 16 commits
>>  - bisect: no longer try to clean up left-over `.git/head-name` files
>>  - bisect: remove Cogito-related code
>>  - Turn `git bisect` into a full built-in
>>  - bisect: move even the command-line parsing to `bisect--helper`
>>  - bisect: teach the `bisect--helper` command to show the correct usage strings
>>  - bisect--helper: return only correct exit codes in `cmd_*()`
>>  - bisect--helper: move the `BISECT_STATE` case to the end
>>  - bisect--helper: make `--bisect-state` optional
>>  - bisect--helper: align the sub-command order with git-bisect.sh
>>  - bisect--helper: using `--bisect-state` without an argument is a bug
>>  - bisect--helper: really retire `--bisect-autostart`
>>  - bisect--helper: really retire --bisect-next-check
>>  - bisect--helper: retire the --no-log option
>>  - bisect: avoid double-quoting when printing the failed command
>>  - bisect run: fix the error message
>>  - bisect: verify that a bogus option won't try to start a bisection
>>
>>  Final bits of "git bisect.sh" have been rewritten in C.
>>
>>  Expecting a (hopefully final) reroll.
>>  cf. <20627.86ilolhnnn.gmgdl@evledraar.gmail.com>
>
> I did not find that one, but I found
> https://lore.kernel.org/git/220627.86ilolhnnn.gmgdl@evledraar.gmail.com/
>
> And that claims that Git has a convention to universally exit with code
> 129 when options are passed with incorrect values.
>
> That claim does not survive even minimal contact with Git's source
> code, though.

I'm not claiming that we always use 129 when we're fed bad options etc.,
but rather that that's what parse_options() does, so at this point most
commands do that consistently.
	
	./git --blah >/dev/null 2>&1; echo $?
	129
	./git status --blah >/dev/null 2>&1; echo $?
	129

But yes, you can find exceptions still, e.g. try that with "git log" and
it'll return 128.

Your series migrates the bisect--helper.c away from parse_options() in a
a way that I don't think is necessary, but leaving that aside mimicking
the exit codes we'd get from parse_options() for those cases you're
handling in your custom parsing seems like a good thing.

> If I find some time, I will respond to that mail, but a reroll is actually
> unnecessary.

There's some more in [1], but there's at least one outstanding bug in
this series, i.e. that you're moving away from parse_options(), but
forgot to change the corresponding flag in git.c for the
built-in. That's then used by the completion mechanism.

But as noted in [2] and more recently in [1] I'm most concerned about us
having outstanding bugs due to past iterations of this having played
whack-a-mole in fixing specific edge cases I found, but not gone back
and added missing test coverage for the series beforehand.

Which, I'm not saying should hold this series up, but just that having
reviewed it for a few iterations I'm not comfortable saying we haven't
missed something else, and given the nature of the past whack-a-mole
fixes it looks like you haven't really looked it either.

I'm referring to e.g. the thread ending at [3], where I pointed out that
"git <subcommand> -h" was broken, you apparently tested one of the
subcommands and concluded it wasn't broken, but clearly not all of them.

Which, I'd be less concerned about if as pointed out in [1] we don't
have entirte bisect sub-commands that don't have any test coverage at
all, so whatever coverage we have probably has major gaps.

1. https://lore.kernel.org/git/220627.86mtdxhnwk.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/220523.865ylwzgji.gmgdl@evledraar.gmail.com/
3. https://lore.kernel.org/git/220225.86ilt27uln.gmgdl@evledraar.gmail.com/
