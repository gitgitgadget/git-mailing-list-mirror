Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE0FECAAD1
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 00:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbiIAAaE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 20:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbiIAAaC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 20:30:02 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CF21EAF8
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 17:30:00 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id i188-20020a1c3bc5000000b003a7b6ae4eb2so443527wma.4
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 17:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc;
        bh=8jfbem/YRp5Tb34zZvNLgmlBybUAuPOQwvQSrYRQE/c=;
        b=EZm7G/YZXhSemDH6Z5gm/hglnqm+Qoa1yADNG76qgXYfnAsZ8iX2vAlWHMwYAhd10g
         LrIv5reu3FNaWFph+Y4kAlQrtUwCPLjuA+Xb8VLzOWioUAGXlcccIX8SwpEj9Cpg6jSb
         SdlfrB85uflb0/pc75Nsozy4kqBL8hgXEzmB87lb9kXZ08hTcW9Eqz0gBwjlsoxae7X4
         HU4PpMRo6lKlPQqyvSnHHQTdb+VzJWgpDdyrmDFVAn8YpJuxKuPwHhwpMyt3BpCGgVz+
         mAXLlNwmof9wzZO6C0jHA0LOJctP+kUkCVLkBD9f2vw7WB4PsOuBzhbEisCN/Julimvd
         v7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc;
        bh=8jfbem/YRp5Tb34zZvNLgmlBybUAuPOQwvQSrYRQE/c=;
        b=VsdC6uJCoBIyj87hlj/uyywPigraB+Uqqh1GuuarfBhVKJwEOfCrFwzgdja62ttH2M
         aW14YUEM2EqibderBnursnoIRieGpVQ2JCP7TftUMgops468liLJiOQt1ppxbxZmk+fJ
         MXynCsVgJi+xdL9vm6FsJCleZeWpkvCeObQWOIuXjamzsNKQCIOgzTYUmMWta9OKE47Y
         doPoupyd4u8KuVI9Og6V2aS2JgB/lqF3g1yA0indwrs3PXCIeuZ39O7Wz0gkXY64a1Yw
         UgdaZ2ghidYSA5HosXiCfFtw2Qpwg4FR3Y5bdNRDd8alSByCnEJSu1cswwuvz7nrqk9K
         iXJw==
X-Gm-Message-State: ACgBeo3kLxodz5O1o/bgBam/hCp7pOmVGKtQRnY26YjTEA/sKDxelWSh
        VA6mbXn/nhlXuMQYF0IGw+M6eCyPc+c=
X-Google-Smtp-Source: AA6agR53Ba8UmGJr9ZBKwtv3ZSp9JKg82hPOBRcbDBnF1NusGTBIH5QBgXfNfghSHNexk2v5ffSWqg==
X-Received: by 2002:a05:600c:3c8a:b0:3a6:7719:6118 with SMTP id bg10-20020a05600c3c8a00b003a677196118mr3461981wmb.199.1661992198732;
        Wed, 31 Aug 2022 17:29:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c378c00b003a5f4fccd4asm3369111wmr.35.2022.08.31.17.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 17:29:58 -0700 (PDT)
Message-Id: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Sep 2022 00:29:38 +0000
Subject: [PATCH 00/18] make test "linting" more comprehensive
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Fabian Stelzer <fs@gigacodes.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A while back, Peff successfully nerd-sniped[1] me into tackling a
long-brewing idea I had about (possibly) improving "chainlint" performance
by linting all tests in all scripts with a single command invocation instead
of running "sed" 26800+ times (once for each test). The new linter
introduced by this series can check all test definitions in the entire
project in a single invocation, and each test definition is checked only
once no matter how many times the test is actually run (unlike chainlint.sed
which will check a test repeatedly if, for instance, the test is run in a
loop). Moreover, all test definitions in the project are "linted" even if
some of those tests would not run on a particular platform or under a
certain configuration (unlike chainlint.sed which only lints tests which
actually run).

The new linter is a good deal smarter than chainlint.sed and understands not
just shell syntax but also some semantics of test construction, unlike
chainlint.sed which is merely heuristics-based. For instance, the new linter
recognizes cases when a broken &&-chain is legitimate, such as when "$?" is
handled explicitly or when a failure is signaled directly with "false", in
which case the &&-chain leading up to the "false" is immaterial, as well as
other cases. Unlike chainlint.sed, it recognizes that a semicolon after the
last command in a compound statement is harmless, thus won't interpret the
semicolon as breaking the &&-chain.

The new linter also provides considerably better coverage for broken
&&-chains. The "magic exit code 117" &&-chain checker built into test-lib.sh
only works for top-level command invocations; it doesn't work within "{...}"
groups, "(...)" subshells, "$(...)" substitutions, or within bodies of
compound statements, such as "if", "for", "while", "case", etc.
chainlint.sed partly fills the gap by catching broken &&-chains in "(...)"
subshells one level deep, but bugs can still lurk behind broken &&-chains in
the other cases. The new linter catches broken &&-chains within all those
constructs to any depth.

Another important improvement is that the new linter understands that shell
loops do not terminate automatically when a command in the loop body fails,
and that the condition needs to be handled explicitly by the test author by
using "|| return 1" (or "|| exit 1" in a subshell) to signal failure.
Consequently, the new linter will complain when a loop is lacking "|| return
1" (or "|| exit 1").

Finally, unlike chainlint.sed which (not surprisingly) is implemented in
"sed", the new linter is written in Perl, thus should be more accessible to
a wider audience, and is structured as a traditional top-down parser which
makes it much easier to reason about.

The new linter could eventually subsume other linting tasks such as
check-nonportable-shell.pl (which itself takes a couple seconds to run on my
machine), though it probably should be renamed to something other than
"chainlint" since it is no longer targeted only at spotting &&-chain breaks,
but that can wait for another day.

Ævar offered some sensible comments[2,3] about optimizing the Makefile rules
related to chainlint, but those optimizations are not tackled here for a few
reasons: (1) this series is already quite long, (2) I'd like to keep the
series focused on its primary goal of installing a new and improved linter,
(3) these patches do not make the Makefile situation any worse[4], and (4)
those optimizations can easily be done atop this series[5].

Junio: This series is nominally atop es/t4301-sed-portability-fix which is
in "next", and es/fix-chained-tests, es/test-chain-lint, and es/chainlint,
all of which are already in "master".

Dscho: This series conflicts with some patches carried only by the Git for
Windows project; the resolutions are obvious and simple. The new linter also
identifies some problems in tests carried only by the Git for Windows
project.

[1] https://lore.kernel.org/git/YJzGcZpZ+E9R0gYd@coredump.intra.peff.net/
[2]
https://lore.kernel.org/git/RFC-patch-1.1-bb3f1577829-20211213T095456Z-avarab@gmail.com/
[3] https://lore.kernel.org/git/211213.86tufc8oop.gmgdl@evledraar.gmail.com/
[4]
https://lore.kernel.org/git/CAPig+cSFtpt6ExbVDbcx3tZodrKFuM-r2GMW4TQ2tJmLvHBFtQ@mail.gmail.com/
[5] https://lore.kernel.org/git/211214.86tufbbbu3.gmgdl@evledraar.gmail.com/

Eric Sunshine (18):
  t: add skeleton chainlint.pl
  chainlint.pl: add POSIX shell lexical analyzer
  chainlint.pl: add POSIX shell parser
  chainlint.pl: add parser to validate tests
  chainlint.pl: add parser to identify test definitions
  chainlint.pl: validate test scripts in parallel
  chainlint.pl: don't require `return|exit|continue` to end with `&&`
  t/Makefile: apply chainlint.pl to existing self-tests
  chainlint.pl: don't require `&` background command to end with `&&`
  chainlint.pl: don't flag broken &&-chain if `$?` handled explicitly
  chainlint.pl: don't flag broken &&-chain if failure indicated
    explicitly
  chainlint.pl: complain about loops lacking explicit failure handling
  chainlint.pl: allow `|| echo` to signal failure upstream of a pipe
  t/chainlint: add more chainlint.pl self-tests
  test-lib: retire "lint harder" optimization hack
  test-lib: replace chainlint.sed with chainlint.pl
  t/Makefile: teach `make test` and `make prove` to run chainlint.pl
  t: retire unused chainlint.sed

 contrib/buildsystems/CMakeLists.txt           |   2 +-
 t/Makefile                                    |  49 +-
 t/README                                      |   5 -
 t/chainlint.pl                                | 730 ++++++++++++++++++
 t/chainlint.sed                               | 399 ----------
 t/chainlint/blank-line-before-esac.expect     |  18 +
 t/chainlint/blank-line-before-esac.test       |  19 +
 t/chainlint/block.expect                      |  15 +-
 t/chainlint/block.test                        |  15 +-
 t/chainlint/chain-break-background.expect     |   9 +
 t/chainlint/chain-break-background.test       |  10 +
 t/chainlint/chain-break-continue.expect       |  12 +
 t/chainlint/chain-break-continue.test         |  13 +
 t/chainlint/chain-break-false.expect          |   9 +
 t/chainlint/chain-break-false.test            |  10 +
 t/chainlint/chain-break-return-exit.expect    |  19 +
 t/chainlint/chain-break-return-exit.test      |  23 +
 t/chainlint/chain-break-status.expect         |   9 +
 t/chainlint/chain-break-status.test           |  11 +
 t/chainlint/chained-block.expect              |   9 +
 t/chainlint/chained-block.test                |  11 +
 t/chainlint/chained-subshell.expect           |  10 +
 t/chainlint/chained-subshell.test             |  13 +
 .../command-substitution-subsubshell.expect   |   2 +
 .../command-substitution-subsubshell.test     |   3 +
 t/chainlint/complex-if-in-cuddled-loop.expect |   2 +-
 t/chainlint/double-here-doc.expect            |   2 +
 t/chainlint/double-here-doc.test              |  12 +
 t/chainlint/dqstring-line-splice.expect       |   3 +
 t/chainlint/dqstring-line-splice.test         |   7 +
 t/chainlint/dqstring-no-interpolate.expect    |  11 +
 t/chainlint/dqstring-no-interpolate.test      |  15 +
 t/chainlint/empty-here-doc.expect             |   3 +
 t/chainlint/empty-here-doc.test               |   5 +
 t/chainlint/exclamation.expect                |   4 +
 t/chainlint/exclamation.test                  |   8 +
 t/chainlint/for-loop-abbreviated.expect       |   5 +
 t/chainlint/for-loop-abbreviated.test         |   6 +
 t/chainlint/for-loop.expect                   |   4 +-
 t/chainlint/function.expect                   |  11 +
 t/chainlint/function.test                     |  13 +
 t/chainlint/here-doc-indent-operator.expect   |   5 +
 t/chainlint/here-doc-indent-operator.test     |  13 +
 t/chainlint/here-doc-multi-line-string.expect |   3 +-
 t/chainlint/if-condition-split.expect         |   7 +
 t/chainlint/if-condition-split.test           |   8 +
 t/chainlint/if-in-loop.expect                 |   2 +-
 t/chainlint/if-in-loop.test                   |   2 +-
 t/chainlint/loop-detect-failure.expect        |  15 +
 t/chainlint/loop-detect-failure.test          |  17 +
 t/chainlint/loop-detect-status.expect         |  18 +
 t/chainlint/loop-detect-status.test           |  19 +
 t/chainlint/loop-in-if.expect                 |   2 +-
 t/chainlint/loop-upstream-pipe.expect         |  10 +
 t/chainlint/loop-upstream-pipe.test           |  11 +
 t/chainlint/multi-line-string.expect          |  11 +-
 t/chainlint/nested-loop-detect-failure.expect |  31 +
 t/chainlint/nested-loop-detect-failure.test   |  35 +
 t/chainlint/nested-subshell.expect            |   2 +-
 t/chainlint/one-liner-for-loop.expect         |   9 +
 t/chainlint/one-liner-for-loop.test           |  10 +
 t/chainlint/return-loop.expect                |   5 +
 t/chainlint/return-loop.test                  |   6 +
 t/chainlint/semicolon.expect                  |   2 +-
 t/chainlint/sqstring-in-sqstring.expect       |   4 +
 t/chainlint/sqstring-in-sqstring.test         |   5 +
 t/chainlint/t7900-subtree.expect              |  13 +-
 t/chainlint/token-pasting.expect              |  27 +
 t/chainlint/token-pasting.test                |  32 +
 t/chainlint/while-loop.expect                 |   4 +-
 t/t0027-auto-crlf.sh                          |   7 +-
 t/t3070-wildmatch.sh                          |   5 -
 t/test-lib.sh                                 |  12 +-
 73 files changed, 1439 insertions(+), 449 deletions(-)
 create mode 100755 t/chainlint.pl
 delete mode 100644 t/chainlint.sed
 create mode 100644 t/chainlint/blank-line-before-esac.expect
 create mode 100644 t/chainlint/blank-line-before-esac.test
 create mode 100644 t/chainlint/chain-break-background.expect
 create mode 100644 t/chainlint/chain-break-background.test
 create mode 100644 t/chainlint/chain-break-continue.expect
 create mode 100644 t/chainlint/chain-break-continue.test
 create mode 100644 t/chainlint/chain-break-false.expect
 create mode 100644 t/chainlint/chain-break-false.test
 create mode 100644 t/chainlint/chain-break-return-exit.expect
 create mode 100644 t/chainlint/chain-break-return-exit.test
 create mode 100644 t/chainlint/chain-break-status.expect
 create mode 100644 t/chainlint/chain-break-status.test
 create mode 100644 t/chainlint/chained-block.expect
 create mode 100644 t/chainlint/chained-block.test
 create mode 100644 t/chainlint/chained-subshell.expect
 create mode 100644 t/chainlint/chained-subshell.test
 create mode 100644 t/chainlint/command-substitution-subsubshell.expect
 create mode 100644 t/chainlint/command-substitution-subsubshell.test
 create mode 100644 t/chainlint/double-here-doc.expect
 create mode 100644 t/chainlint/double-here-doc.test
 create mode 100644 t/chainlint/dqstring-line-splice.expect
 create mode 100644 t/chainlint/dqstring-line-splice.test
 create mode 100644 t/chainlint/dqstring-no-interpolate.expect
 create mode 100644 t/chainlint/dqstring-no-interpolate.test
 create mode 100644 t/chainlint/empty-here-doc.expect
 create mode 100644 t/chainlint/empty-here-doc.test
 create mode 100644 t/chainlint/exclamation.expect
 create mode 100644 t/chainlint/exclamation.test
 create mode 100644 t/chainlint/for-loop-abbreviated.expect
 create mode 100644 t/chainlint/for-loop-abbreviated.test
 create mode 100644 t/chainlint/function.expect
 create mode 100644 t/chainlint/function.test
 create mode 100644 t/chainlint/here-doc-indent-operator.expect
 create mode 100644 t/chainlint/here-doc-indent-operator.test
 create mode 100644 t/chainlint/if-condition-split.expect
 create mode 100644 t/chainlint/if-condition-split.test
 create mode 100644 t/chainlint/loop-detect-failure.expect
 create mode 100644 t/chainlint/loop-detect-failure.test
 create mode 100644 t/chainlint/loop-detect-status.expect
 create mode 100644 t/chainlint/loop-detect-status.test
 create mode 100644 t/chainlint/loop-upstream-pipe.expect
 create mode 100644 t/chainlint/loop-upstream-pipe.test
 create mode 100644 t/chainlint/nested-loop-detect-failure.expect
 create mode 100644 t/chainlint/nested-loop-detect-failure.test
 create mode 100644 t/chainlint/one-liner-for-loop.expect
 create mode 100644 t/chainlint/one-liner-for-loop.test
 create mode 100644 t/chainlint/return-loop.expect
 create mode 100644 t/chainlint/return-loop.test
 create mode 100644 t/chainlint/sqstring-in-sqstring.expect
 create mode 100644 t/chainlint/sqstring-in-sqstring.test
 create mode 100644 t/chainlint/token-pasting.expect
 create mode 100644 t/chainlint/token-pasting.test


base-commit: d42b38dfb5edf1a7fddd9542d722f91038407819
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1322%2Fsunshineco%2Fchainlintperl-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1322/sunshineco/chainlintperl-v1
Pull-Request: https://github.com/git/git/pull/1322
-- 
gitgitgadget
