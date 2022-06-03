Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01DDC43334
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 10:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243035AbiFCKUe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 06:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243774AbiFCKUS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 06:20:18 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCCE3B3C3
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 03:20:15 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 25so9272192edw.8
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 03:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=IezzVea0Bl5VlsJm+YhxcHeQ01cHcj8ywFVz1dTsUjU=;
        b=prym6bigyeGCK0D6/CK3k+5UF2mb36jINdLPC1/eqGuxUPPNRqUXjS2oLVUa6b7X+u
         L+DHw3uqod/e3Y+SHXLmBwpnuYcTQ0VouT7mouI2zbtkgboKxsI6/bdEyvd7z8Ht0srU
         Vp5d/oH14vpoaS40wwDO4JoTMHHRJMQPu+JVKvgzNMkNc9W4eixTeu/jFRBK+AtKn/CC
         eqjzhvhKWD//FkWgaKMIiWHkym47k82rNXA/XmrsWOh+ZQNHkJz/gN5cwA8a0MPs7jt5
         GMJ5W1tQjpad1YGuK3bRKHODUaSH1DL5Al4nxwbjee5WcdUPJOmNodsMGCg80Du1jWBZ
         tfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=IezzVea0Bl5VlsJm+YhxcHeQ01cHcj8ywFVz1dTsUjU=;
        b=6/ETo4ZbmpZ14gX0QdK597M6FTtdrnVqGkqISU3D5Odab7/kOw0RrJRkyESN5MOYtO
         uIXmp2CAKMEEGyFX+ZCbpk5cLhU2l9Piv9IXxjvh3pHT5uU+o3hAdL2TkQq14/KrpcJe
         f4LhPu9ZbYjkD/JpD+ncboVPEi921WR/yhIPqhcgAFBKyOErEnx52uWGU107AtT0XbG2
         1mXAXeNBQUm6t2gbEEA5xoTSDZgLO2INWGbKxlm03ZYkU2QCUq7ZmPrgPqpq2k2aOy+N
         Bo8mUEOxJ6VLEcC7OIWQ0hx/mqGOZbAYUq6xWshkP6d8r8WOt/fAo7dW6w5ntAEXBjME
         hfYw==
X-Gm-Message-State: AOAM533kssplKP2IoujGBVBWpxDK/smYIPrJ0hCHximTchlIVmPY0SWY
        LKCiB5aRcUZ/+eKTAyfb7lY=
X-Google-Smtp-Source: ABdhPJyCWy6WLRzLSdxyRnVZk8qdnnzSm++1dDZB+t/+cR3yZETAgJFsqpycXcLXpJqgP8MgmmByog==
X-Received: by 2002:a05:6402:f:b0:42e:561:a1c0 with SMTP id d15-20020a056402000f00b0042e0561a1c0mr9872515edu.309.1654251613946;
        Fri, 03 Jun 2022 03:20:13 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id c10-20020a170906154a00b006f3ef214de7sm2689258ejd.77.2022.06.03.03.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 03:20:13 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nx4Pc-001bo7-Ik;
        Fri, 03 Jun 2022 12:20:12 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Josh Steadmon <steadmon@google.com>, congdanhqx@gmail.com,
        dyroneteng@gmail.com, martin.agren@gmail.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com
Subject: js/ci-github-workflow-markup output regression (was: [PATCH]
 ls-tree: test for the regression in 9c4d58ff2c3)
Date:   Fri, 03 Jun 2022 11:54:31 +0200
References: <xmqqee28spni.fsf@gitster.g>
 <patch-1.1-0fdfec624eb-20220531T171908Z-avarab@gmail.com>
 <nycvar.QRO.7.76.6.2206021703110.349@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <nycvar.QRO.7.76.6.2206021703110.349@tvgsbejvaqbjf.bet>
Message-ID: <220603.86fskmxd43.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 02 2022, Johannes Schindelin wrote:

> On Tue, 31 May 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> [...]
>> +test_ls_tree_format_mode_output () {
>> +	local opts=3D$1 &&
>
> This line does not quote `$1`, but...

Well spotted, thanks, I don't know how I missed that, will fix it &
re-roll, but per changed $subject...

> [...]
> ... this line passes a first argument that contains spaces. Hence the
> tests fail in CI:
> https://github.com/git/git/runs/6703333447?check_suite_focus=3Dtrue
>
> Further, since this failure is outside of any `test_expect_success` or
> `test_expect_failure`, the error message about this is not even included
> in the weblogs (but of course it is included in the full logs that are
> included in the build artifacts). For the record, here is the error
> message:

...this part of it though seems like a pretty bad regression in your
merged-to-next js/ci-github-workflow-markup topic, which just happens to
be unearthed by this CI failure.

On top of master this patch will get this CI failure:
https://github.com/avar/git/runs/6675920732?check_suite_focus=3Dtrue#step:5=
:598;
Ending in ("[...]" edit is mine):
=09
	 ok 35 - 'ls-tree --object-only -r' output (via subdir)
	+ git rev-parse --short HEAD:.gitmodules
	[...]
	+ HEAD_short_dir_sub_file=3Da150abd
=09
	ok 36 - setup: HEAD_short_* variables
	t3105-ls-tree-output.sh: 20: local: --abbrev: bad variable name
	FATAL: Unexpected exit with code 2

So here we see that we got to test 36, and then got this error. All of
which is after the step we focused on to begin with would have shown:
=09
	 Test Summary Report
	-------------------
	t3105-ls-tree-output.sh                          (Wstat: 256 Tests: 36 Fai=
led: 0)
	  Non-zero exit status: 1
	  Parse errors: No plan found in TAP output

I.e. telling us we had a TAP parse error, so something like this was
going on.

But now we'll instead get ("=3D>" edit is mine, it didn't copy/paste):

	=3D> Run tests
	=3D=3D=3D Failed test: t3105-ls-tree-output =3D=3D=3D
	The full logs are in the artifacts attached to this run.
	Error: Process completed with exit code 1.

Where expanding the "=3D>" in "Run tests" will get us the "Test summary
report" from before, but now we have no "ci/print-test-failures.sh" step
to emit the output we got from the test, and we just get a cryptic error
about t3105 having failed *somewhere*.

As noted in the breadcrumb trail leading from "[2]" in [1] this is a
fundamental limitation of the approach you picked for
--github-workflow-markup. You're tasking the test-lib.sh to emit
well-formed output, but as shown here we can die prematurely on "eval"
failures.

But this does look easy to "solve" with a quicker fix, just bringing
back the "ci/print-test-failures.sh" step so you can at least expand it,
and not have to go to the "summary" and download the *.zip of the log
itself. As that shows we still have the raw log there, it just didn't
make it to the new GitHub Markdown formatting mechanism.

1. https://lore.kernel.org/git/220324.8635j7nyvw.gmgdl@evledraar.gmail.com/
