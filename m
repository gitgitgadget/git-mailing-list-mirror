Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6897C5479D
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 12:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236884AbjAIMaA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 07:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236961AbjAIM33 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 07:29:29 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADC11AD8D
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 04:29:28 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id bk16so7966552wrb.11
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 04:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L9Na4Jt4kdYzYfOQUXmy6+8Z4RtoJsZSfSkO22cYnjc=;
        b=FcW1RktxvjvYeGatkv8Oh0fETawEqppel9dJUsDuBO9vxixDn7ielsd0pOJZR6M/C5
         E2asMR6MrDLypvz9XaT05niYNS5uEu/Z3CMD4y9Rhh4EAG4hy0uzEpT91MqakLGefvAK
         MTpdXYYBXbH7UlJrwFIvq7xt+0j6VQrRYGd6wlpUcQZkn4lJlkBhTw3EcX43ltvFgNCK
         hGzAA71GvgyZwI/cPfd1I54lX0Gwx9DNycd5aAkEIHCLeyqOqJUO0deA70zWw1CnkDor
         pgJm3B1V0m5IRqpQoOOjjWySi5aW5/ECaTRhx70j5VM/SPR6A13RVrhyWB//8s9f4xSU
         jHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9Na4Jt4kdYzYfOQUXmy6+8Z4RtoJsZSfSkO22cYnjc=;
        b=P1j+wSnqdRWAjc/rFVzZCt3Tw/f0aNRnW2v0/g/TJSKUM0LDEaSFEhvFEzZTXSR9gp
         4GAEeezvbtE24K9DAEGV7s/Vr1saXEqpjLJc7K3A90mrohY1CVd5WmeSlPXPIRNW6VMt
         pyyOXvdg5MxIN3ti8Pcz81iAkBCyVSaosFtDBws/qTZ5kSCWB5S2oDrIcANVl8x+vx6D
         pY4RPeuHoWGKMNp2Z2kP7zr0UA2fFYIOoLWOLedx/DCQLnUXHBNjKI7nN9kvEv/G1YKb
         aZwO/uNKyr2Sonq7wVBQWEfIynPJZNXktyllFp0lZ4gEG/97rDoYdnif7njbueV9OcSA
         8qhw==
X-Gm-Message-State: AFqh2kopVgZMMsHOnRw/4dMtDJzTIvcjtfHS0Bf16v/KDtf1M8/03Dpe
        2gQEARPehkpfL5IBKrLpjuk=
X-Google-Smtp-Source: AMrXdXuOaoKdJ0CbDlvuGzjUOqR2h56PMSWqyfDXD9myv3mn5yNeN+O43AbyeT1w4MnhCq8mH10lBA==
X-Received: by 2002:adf:fb05:0:b0:242:15d6:1a75 with SMTP id c5-20020adffb05000000b0024215d61a75mr35625644wrr.66.1673267367009;
        Mon, 09 Jan 2023 04:29:27 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id e10-20020adfe38a000000b002bc7fcf08ddsm1097439wrm.103.2023.01.09.04.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 04:29:26 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pErHJ-0003i6-2o;
        Mon, 09 Jan 2023 13:29:25 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v7 0/4] worktree: Support `--orphan` when creating new
 worktrees
Date:   Mon, 09 Jan 2023 13:26:05 +0100
References: <20221104010242.11555-1-jacobabel@nullpo.dev>
 <20221104213401.17393-1-jacobabel@nullpo.dev>
 <20221110233137.10414-1-jacobabel@nullpo.dev>
 <20221212014003.20290-1-jacobabel@nullpo.dev>
 <20221220023637.29042-1-jacobabel@nullpo.dev>
 <20221228061539.13740-1-jacobabel@nullpo.dev>
 <20230107045757.30037-1-jacobabel@nullpo.dev>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230107045757.30037-1-jacobabel@nullpo.dev>
Message-ID: <230109.86r0w328nu.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jan 07 2023, Jacob Abel wrote:

> While working with the worktree based git workflow, I realised that setting
> up a new git repository required switching between the traditional and
> worktree based workflows. Searching online I found a SO answer [1] which
> seemed to support this and which indicated that adding support for this should
> not be technically difficult.
>
> This patchset has four parts:
>   * adding `-B` to the usage docs (noticed during dev and it seemed too small
>     to justify a separate submission)
>   * adding a helper fn to simplify testing for mutual exclusion of options
>     in `t/t2400-worktree-add.sh`
>   * adding orphan branch functionality (as is present in `git-switch`)
>     to `git-worktree-add`
>   * adding an advise for using --orphan when `git worktree add` fails due to
>     a bad ref.
>
> Changes from v6:
>   * Removed helper save_param_arr() introduced in v6 from t2400 (2/4) [2].
>   * Reverted changes introduced in v6 to test_wt_add_excl() from t2400 (2/4) [3].
>   * Changed test_wt_add_excl() to use `local opts="$*"` (2/4) [3].
>   * Added check to test_wt_add_excl() to better validate test results (2/4).
>   * Re-add &&-chains to test_wt_add_excl() (2/4) [4].
>   * Reverted changes introduced in v6 to test_wt_add_empty_repo_orphan_hint()
>     from t2400 (4/4) [3].
>   * Changed test_wt_add_empty_repo_orphan_hint() to use `local opts="$*"` (4/4) [3].
>   * Added check to test_wt_add_empty_repo_orphan_hint() to better validate test
>     results (4/4).
>   * Re-add &&-chains to test_wt_add_empty_repo_orphan_hint() (2/4) [4].

This round looks good to me, except for a small tiny (and new)
portability issue that needs fixing:

> Range-diff against v6:
> 1:  a9ef3eca7b = 1:  a9ef3eca7b worktree add: include -B in usage docs
> 2:  c03c112f79 ! 2:  d124cc481c worktree add: refactor opt exclusion tests
>     @@ t/t2400-worktree-add.sh: test_expect_success '"add" no auto-vivify with --detach
>      -test_expect_success '"add" -b/-B mutually exclusive' '
>      -	test_must_fail git worktree add -b poodle -B poodle bamboo main
>      -'
>     -+# Saves parameter sequence/array as a string so they can be safely stored in a
>     -+# variable and restored with `eval "set -- $arr"`. Sourced from
>     -+# https://stackoverflow.com/a/27503158/15064705
>     -+save_param_arr () {
>     -+	local i
>     -+	for i;
>     -+	do
>     -+		# For each argument:
>     -+		# 1. Append "\n" after each entry
>     -+		# 2. Convert "'" into "'\''"
>     -+		# 3. Prepend "'" before each entry
>     -+		# 4. Append " \" after each entry
>     -+		printf "%s\\n" "$i" | sed "
>     -+			s/'/'\\\\''/g
>     -+			1s/^/'/
>     -+			\$s/\$/' \\\\/
>     -+		"
>     -+	done
>     -+	echo " "
>     -+}
>     -
>     +-
>      -test_expect_success '"add" -b/--detach mutually exclusive' '
>      -	test_must_fail git worktree add -b poodle --detach bamboo main
>      -'

Good to get rid of this.

>      +# Helper function to test mutually exclusive options.
>     ++#
>     ++# Note: Quoted arguments containing spaces are not supported.
>      +test_wt_add_excl () {
>     -+	local arr=$(save_param_arr "$@")
>     -+	test_expect_success "'worktree add' with $* has mutually exclusive options" '
>     -+		eval "set -- $arr" &&
>     -+		test_must_fail git worktree add "$@"
>     ++	local opts="$*" &&
>     ++	test_expect_success "'worktree add' with '$opts' has mutually exclusive options" '
>     ++		test_must_fail git worktree add $opts 2>actual &&
>     ++		grep -P "fatal:( options)? .* cannot be used together" actual

This is the new unportable code, the "-P" option is specific to GNU
grep, and here you're relying on the "?" syntax along with other
ERE-like syntax.

It looks like the minimal fix here is to just change -P to -E, which we
can use, you're not using any PCRE-syntax, but just syntax that's part
of ERE.
