Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1555AC43334
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 23:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345743AbiFCX0W (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 19:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiFCX0V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 19:26:21 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAA61F620
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 16:26:18 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id c2so11998362edf.5
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 16:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=4VvF2MNNF/OTQmk/UNk9DyHx/21aptijv2di8I8viFU=;
        b=d8xG0hBoNbo0k8QDqFRbl1+1qjU8S88K+CAl/VWX4RaBGtknTBr2ABYH4/JRmTLM2n
         NFPGZ5RPwPwgIJJXjeagGCNt6Cjdg9KiS65CvtoXo8NPrwOqgQfIEsgmZa6sFPeiNHLg
         8GEWe9zzS35oT962hRr1j4Q+DBgKryeTD042cyafQzyM7e9gVgpsdCmCVVwVc6KzmRA6
         wyMjDD3FVic0BFYf9+3BDPlBLjU+3DD4dlBEzYaZ2g0RVEHMIDE+XgPwDowqz3j6S/BC
         BCoeWqZSwQJNm9reYhgP6rq4b4S5QewYFWPRKLfwlcEphvKGZ9aug1ux/iWPbTVAspup
         f4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=4VvF2MNNF/OTQmk/UNk9DyHx/21aptijv2di8I8viFU=;
        b=xPX2uO7qL0dWJPYTmP+ocjDLnCLCBDYy+We+EPjafrTNep3CTk9WfA0LnRiWpUIwHG
         WDw0qPlhGVlMaZIJD1OtHc4QCobZ6gXie3p5slY33i3nb0frAGOaYCfTShWjh8Jaikw9
         uv0N59bJyWjBJjimNxqIMPkAh6FoxWpI6zM6zIvDaS9Abeq2OXZgCQtxjHJ9jJF8Xf0q
         3JivFqqZQhcd1HCKZ+/eU/+bEknVJN6MI3M1yxRFE/XOu9ysfkF1gqmFVeblpNe+byEn
         L+n8E3dIP2LSsKN0zqh7BCr1hg61SODgsnju5FeCLiq9b6WunGTjQ3euZODssbQMxywn
         BxPA==
X-Gm-Message-State: AOAM531nirw/2W9TtNSbnc2Vcw3cpTSB29ix4PP89Ucv5qH9DDT0NQAp
        P3kAyoiqoAOA1zDezBVe26A=
X-Google-Smtp-Source: ABdhPJzyZozaMcZs3KNTFfeIn5vaCPu1v8bBYEelJre4juMUeQ2M9u1H1AxM/0au/0AK+QmnNH55Vg==
X-Received: by 2002:a05:6402:1449:b0:42d:d250:e504 with SMTP id d9-20020a056402144900b0042dd250e504mr13325214edx.213.1654298776570;
        Fri, 03 Jun 2022 16:26:16 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id g1-20020a170906348100b00702d8b37a03sm3410352ejb.17.2022.06.03.16.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 16:26:15 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nxGgI-001v0H-TR;
        Sat, 04 Jun 2022 01:26:14 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Josh Steadmon <steadmon@google.com>,
        congdanhqx@gmail.com, dyroneteng@gmail.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: Re: js/ci-github-workflow-markup output regression
Date:   Sat, 04 Jun 2022 01:13:08 +0200
References: <xmqqee28spni.fsf@gitster.g>
        <patch-1.1-0fdfec624eb-20220531T171908Z-avarab@gmail.com>
        <nycvar.QRO.7.76.6.2206021703110.349@tvgsbejvaqbjf.bet>
        <220603.86fskmxd43.gmgdl@evledraar.gmail.com>
        <xmqqpmjpeedq.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqpmjpeedq.fsf@gitster.g>
Message-ID: <220604.86y1ydwcq1.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 03 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> Further, since this failure is outside of any `test_expect_success` or
>>> `test_expect_failure`, the error message about this is not even included
>>> in the weblogs (but of course it is included in the full logs that are
>>> included in the build artifacts). For the record, here is the error
>>> message:
>>
>> ...this part of it though seems like a pretty bad regression in your
>> merged-to-next js/ci-github-workflow-markup topic, which just happens to
>> be unearthed by this CI failure.
>
> Indeed it makes it impossible to figure it out things like this
> case.  But ...
>
>> But this does look easy to "solve" with a quicker fix, just bringing
>> back the "ci/print-test-failures.sh" step so you can at least expand it,
>> and not have to go to the "summary" and download the *.zip of the log
>> itself. As that shows we still have the raw log there, it just didn't
>> make it to the new GitHub Markdown formatting mechanism.
>
> ... it seems a solution is possible?  Care to send in a patch (or
> perhaps Dscho already has a counter-proposal)?

The only thing I have at the moment is:

    1. git revert -m 1 bd37e9e41f5
    2. merge: https://lore.kernel.org/git/cover-v6-00.29-00000000000-202205=
25T094123Z-avarab@gmail.com/
    3. merge: https://lore.kernel.org/git/cover-v6-00.14-00000000000-202205=
25T100743Z-avarab@gmail.com/

I.e. to pick this in the sequence I'd proposed doing & have tested
thoroughly.

It also addresses other noted some other regressions in "next", but as
noted e.g. in [A] there's other issues in "next", e.g. that even the
"raw" trace logs are altered as a side-effect of running with
--github-workflow-markup, and of course the major UX slowdowns.

So I think the better way forward would be to do that & leave out [B],
i.e. make the new output format optional, and wait until outstanding
issues are fixed until we flip the default.

But do I have something that neatly fixes the issue(s) on top of "next"
without a revert & re-apply? No, sorry.

In case you want to go for that the resolution for [2] is [C], and a
"git rm ci/run-build-and-tests.sh ci/run-static-analysis.sh".

A. https://lore.kernel.org/git/patch-v6-13.14-fbe0d99c6b3-20220525T100743Z-=
avarab@gmail.com/
B. https://lore.kernel.org/git/patch-v6-14.14-0b02b186c87-20220525T100743Z-=
avarab@gmail.com/
C.=20
	diff --git a/Makefile b/Makefile
	index 19f3756f7eb..c2b0a728df5 100644
	--- a/Makefile
	+++ b/Makefile
	@@ -3618,3 +3618,4 @@ ci-static-analysis: ci-check-directional-formatting
	 ci-static-analysis: check-builtins
	 ci-static-analysis: check-coccicheck
	 ci-static-analysis: hdr-check
	+ci-static-analysis: check-pot
	diff --git a/ci/lib.sh b/ci/lib.sh
	index 80e89f89b7f..9c54c1330e6 100755
	--- a/ci/lib.sh
	+++ b/ci/lib.sh
	@@ -270,7 +270,7 @@ linux-TEST-vars)
	        setenv --test GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS 1
	        setenv --test GIT_TEST_MULTI_PACK_INDEX 1
	        setenv --test GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP 1
	-       setenv --test GIT_TEST_ADD_I_USE_BUILTIN 1
	+       setenv --test GIT_TEST_ADD_I_USE_BUILTIN 0
	        setenv --test GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME master
	        setenv --test GIT_TEST_WRITE_REV_INDEX 1
	        setenv --test GIT_TEST_CHECKOUT_WORKERS 2
=09
