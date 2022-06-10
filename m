Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968DEC43334
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 02:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243162AbiFJCBy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 22:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241068AbiFJCBt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 22:01:49 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF340CE5CE
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 19:01:45 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id e5so6388716wma.0
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 19:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rIyi/CsPXMJSMNpQVaWLi8npyVKSPXDDR33TupCK2UM=;
        b=PQUUDmFPsiTCkxx4cEzC9g/uK2m1bb6gkdbF4mUBI/y5xTlQOgR2Yfb/GCH1D12mOh
         atfZaGL4Q3+cp+rChGMcL9070gK/gUf7HVNiZT+j2r+u7NpPkEYnuSO9/yYmiUpz9r2X
         U4hKCbjZKWBxn5TW7BPud2i+dA2aqFRYDeaROoZGAChM5RI6Io6XleTfjybOkmMapjFo
         S5WyOAe3C7CMXv5xpsZd4fmxKVyoURKLHCnc09t36HeleFTtqjfrwU+8OyuGM82LjAo4
         lFL1JebTYt2fbudi8WyioG0ZpiDW9/StTWe9EkF0B/c2t/4JAmYTwj56MypUwvYTj9SE
         Tg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rIyi/CsPXMJSMNpQVaWLi8npyVKSPXDDR33TupCK2UM=;
        b=mIBscrfvrlOvBfuFfrMwdXIwy9zI+YviyBHnWGJ9QwheJ0cVNuEHsJvn+OxsvrDReN
         kuRNwCUqtc0I2Oj42MBVp3YyN8kxf72clG2uJ0I1l72iHZHXc5mfJriYUGcmhQirwBYm
         7HoGyWro/5Uz6sK4Aq4liFigyl+XndU87jin6S9TAQ3OnwqElnb5HtMFlEmO7DiZAVvi
         ckOqmvPiyvZ4r2/GD7BDj1IsNT1/kLlo2WhdZ2bM0fHYDsO7VKO4jYDj74RFWkWRg1Kf
         u5llnKJJVt6MskXywk5g+Q2v/imE7fi8vCd3Y0UJvWLVFLRlgY6WwzI63JYSJKGYhBq4
         a+aw==
X-Gm-Message-State: AOAM531+nC2XDVS3wRkyLsG3FwWcz7S6MMh8QHuW2Ct2Vc5ijM4i8PBc
        WBUelL+1gkC1pKLImMJUMOc1hnW9HZ4vpg==
X-Google-Smtp-Source: ABdhPJxe0JPlPlUM5Mp3ClTd8U0NIBMA4gROpJiyP5eR/+19uldj0hFAL50hbw8ZsdhFhxWVNTFSDg==
X-Received: by 2002:a05:600c:19c7:b0:39c:30b0:2b05 with SMTP id u7-20020a05600c19c700b0039c30b02b05mr6040374wmq.170.1654826503911;
        Thu, 09 Jun 2022 19:01:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m5-20020adffe45000000b00219e8d28fb1sm122547wrs.57.2022.06.09.19.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 19:01:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 00/20] submodule: remove git-submodule.sh, create bare builtin/submodule.c
Date:   Fri, 10 Jun 2022 04:01:12 +0200
Message-Id: <RFC-cover-00.20-00000000000-20220610T011725Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1178.gb5b1747c546
In-Reply-To: <pull.1275.git.git.1654820781.gitgitgadget@gmail.com>
References: <pull.1275.git.git.1654820781.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 10 2022, Glen Choo via GitGitGadget wrote:

> As a follow up to ar/submodule-update [1] and its successors
> gc/submodule-update-part* [2] [3], this series converts the last remaining
> piece of "git submodule update" into C, namely, the option parsing in
> git-submodule.sh.

Aside at the end at [2].

> As a result, git-submodule.sh::cmd_update() is now an (almost) one-liner:
>
> cmd_update() { git ${wt_prefix:+-C "$wt_prefix"} submodule--helper update
> ${wt_prefix:+--prefix "$wt_prefix"}
> "$@" }
>
> and best of all, "git submodule update" now shows a usage string for its own
> subcommand instead of a giant usage string for all of "git submodule" :)
>
> Given how many options "git submodule update" accepts, this series takes a
> gradual approach:
>
>  1. Create a variable opts, which holds the literal options we want to pass
>     to "git submodule--helper update". Then, for each option...
>  2. If "git submodule--helper update" already understands the string option,
>     append it to opts and remove any special handling (1-3/8).
>  3. Otherwise, if the option makes sense, teach "git submodule--helper
>     update" to understand the option. Goto 2. (4-5/8).
>  4. Otherwise, if the option makes no sense, drop it (6/8).
>  5. When we've processed all options, delete all the option parsing code
>     (7/8) and clean up (8/8).

That's quite the timing coincidence. I hacked this up yesterday,
thinking that the submodule topic had been too quiet for a while, and
wondering how hard it was to convert the rest of git-submodule.sh.

It's more than 2x the length of yours, but gets to the point where we
can "git rm git-submodule.sh".

Some brief comparison/commentary:

> Glen Choo (8):
>   submodule update: remove intermediate parsing
>   submodule update: pass options containing "[no-]"
>   submodule update: pass options with stuck forms

Yeah, this is the alternate approach I considered and ended up
discarding. I.e. to make forward progress with migrating things away
from the cmd_*() functions you either have to prepare things in
advance and then sweep the rug from under them in one go.

Or, as you're doing here teaching them about the options they're
not-really-parsing anymore, but must know about because they're in a
loop that ends with a "if unknown option, usage".

>   submodule update: pass --require-init and --init

Almost the same as my 12/20.

>   submodule--helper update: use one param per type

Same as my 13/20, but I ended up doing it in a more narrow/smaller
way. I tried your way and ran into some bug, then figured I'd do it
more narrowly instead of debugging it.

>   submodule update: remove -v, pass --quiet

Hrm, so we don't need it at all then. Well, that's a bit simpler than
my 1[45]/20 and 17/20 :)

So yeah, definitely RFC-quality, but I ran into that one test that
used -v, and then saw the missing docs etc. But no cheating, so I've
left it in :)

I do wonder if we should leave it in anyway, we never documented -v,
but we *did* understand it, and if you look at:

    git log -p -Gsay -- git-submodule.sh

We used to have a lot more code impacted by it, but looking at this
again now it would have only been for users of command-lines like:

    git submodule --quiet update -v [...]

I.e. where we already set the flag to the non-default quiet, and then
used -v to flip it.

I think at this point I've talked myself into "let's just remove it",
but maybe...

>   submodule update: stop parsing options in .sh

Same effect as my 16/20, but it's the last one I converted, the
cmd_update() case being the trickiest.

>   submodule update: remove never-used expansion

Same as my 02/20, but as seen there I think you missed several
"prefix" non-uses.

Brief commentary on my patches, details in commit messages:

Ævar Arnfjörð Bjarmason (20):
  git-submodule.sh: remove unused sanitize_submodule_env()
  git-submodule.sh: remove unused $prefix variable
  git-submodule.sh: remove unused --super-prefix logic

I removed a bit more dead code here than yours.

  git-submodule.sh: normalize parsing of "--branch"
  git-submodule.sh: normalize parsing of --cached

This & various other prep commits (hereafter "easy prep") make
subsequent one-time conversions of whole cmd_*() easier.

  submodule--helper: rename "absorb-git-dirs" to "absorbgitdirs"
  git-submodule.sh: create a "case" dispatch statement

easy prep

  submodule--helper: pretend to be "git submodule" in "-h" output

easy prep & bug fix for existing (on master) output bugs.

  git-submodule.sh: dispatch "sync" to helper
  git-submodule.sh: dispatch directly to helper
  git-submodule.sh: dispatch "foreach" to helper

These are easy conversions as the options 1=1 map after the above
prep.

  submodule--helper: have --require-init imply --init
  submodule--helper: understand --checkout, --merge and --rebase
    synonyms
  git-submodule doc: document the -v" option to "update"
  submodule--helper: understand -v option for "update"

not-so-easy prep for "cmd_update()"

  git-submodule.sh: dispatch "update" to helper

Full cmd_update() migration in one go.

  git-submodule.sh: use "$quiet", not "$GIT_QUIET"

"easy prep", but this one is less overall churn if done at the end,
but as noted above could/should maybe be dropped entirely.

  git-submodule.sh: simplify parsing loop

Not really needed, but I wanted to get the code as close to minimal
for the next step, to eyeball the resulting sh v.s. C version.

  submodule: make it a built-in, remove git-submodule.sh

We now have a builtin/submodule.c *and* the current
builtin/submodule--helper.c, and we even dispatch to "git
submodule--helper" via run_command()!

The idea is to be as close as possible to a bug-for-bug implementation
of the shellscript, and that reviewers should be confident in being
able to trace what commands we invoked before/after, we're invoking
the same "git submodule--helper" commands.

Of course we eventually want to get to some full union of
builtin/submodule{,--helper}.c, but that can wait.

  submodule: add a subprocess-less submodule.useBuiltin setting

Wait, a useBuiltin setting to switch between two built-ins? Yeah,
maybe it makes little sense, but here we get rid of the run_command()
overhead, and could generally use the built-in to experiment with
deeper integration between the two.

Performance is around ~2x faster with the "real" built-in than the
run_command() version, whic hin turn is more than 6x as fast on basic
overhead than the shellscript version, to the extent that anyone cares
about "git submodule" overhead. See [1] at the end for a benchmark.

That last change adds a CI target for
GIT_TEST_SUBMODULE_USE_BUILTIN=true, full CI run here:
https://github.com/avar/git/actions/runs/2472131257

 Documentation/config/submodule.txt |   4 +
 Documentation/git-submodule.txt    |   8 +-
 Makefile                           |   2 +-
 builtin.h                          |   1 +
 builtin/submodule--helper.c        | 118 +++---
 builtin/submodule.c                | 169 ++++++++
 ci/run-build-and-tests.sh          |   1 +
 git-sh-setup.sh                    |   7 -
 git-submodule.sh                   | 637 -----------------------------
 git.c                              |   1 +
 submodule.c                        |   2 +-
 t/README                           |   4 +
 12 files changed, 255 insertions(+), 699 deletions(-)
 create mode 100644 builtin/submodule.c
 delete mode 100755 git-submodule.sh

1. GIT_TEST_SUBMODULE_USE_BUILTIN=true git hyperfine -L rev origin/master,HEAD~0 -L v false,true -s 'make CFLAGS=-O3' 'GIT_TEST_SUBMODULE_USE_BUILTIN={v} ./git --exec-path=$PWD submodule status' -r 20
Benchmark 1: GIT_TEST_SUBMODULE_USE_BUILTIN=false ./git --exec-path=$PWD submodule status' in 'origin/master
  Time (mean ± σ):      40.9 ms ±   0.3 ms    [User: 33.3 ms, System: 9.7 ms]
  Range (min … max):    40.2 ms …  41.5 ms    20 runs

Benchmark 2: GIT_TEST_SUBMODULE_USE_BUILTIN=false ./git --exec-path=$PWD submodule status' in 'HEAD~0
  Time (mean ± σ):      12.4 ms ±   0.1 ms    [User: 9.9 ms, System: 2.5 ms]
  Range (min … max):    12.2 ms …  12.7 ms    20 runs

Benchmark 3: GIT_TEST_SUBMODULE_USE_BUILTIN=true ./git --exec-path=$PWD submodule status' in 'origin/master
  Time (mean ± σ):      40.9 ms ±   0.5 ms    [User: 35.6 ms, System: 7.2 ms]
  Range (min … max):    40.1 ms …  41.8 ms    20 runs

Benchmark 4: GIT_TEST_SUBMODULE_USE_BUILTIN=true ./git --exec-path=$PWD submodule status' in 'HEAD~0
  Time (mean ± σ):       6.4 ms ±   0.1 ms    [User: 3.9 ms, System: 2.5 ms]
  Range (min … max):     6.3 ms …   6.6 ms    20 runs

Summary
  'GIT_TEST_SUBMODULE_USE_BUILTIN=true ./git --exec-path=$PWD submodule status' in 'HEAD~0' ran
    1.94 ± 0.03 times faster than 'GIT_TEST_SUBMODULE_USE_BUILTIN=false ./git --exec-path=$PWD submodule status' in 'HEAD~0'
    6.40 ± 0.11 times faster than 'GIT_TEST_SUBMODULE_USE_BUILTIN=true ./git --exec-path=$PWD submodule status' in 'origin/master'
    6.40 ± 0.10 times faster than 'GIT_TEST_SUBMODULE_USE_BUILTIN=false ./git --exec-path=$PWD submodule status' in 'origin/master'

2. Aside: I don't think these ever made it on-list but Atharva's
   version of what we're trying to do here is at:
   https://github.com/tfidfwastaken/git/tree/submodule-make-builtin-2

   I'd looked those over at some distant point in the past, and
   skimmed them again yesterday, but thought they were too much
   all-at-once to be confident in testing it myself, hence coming up
   with this alternate & smaller approach.

-- 
2.36.1.1178.gb5b1747c546

