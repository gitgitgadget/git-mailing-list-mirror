Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D188E1F85B
	for <e@80x24.org>; Wed, 11 Jul 2018 06:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbeGKGur (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 02:50:47 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:32949 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbeGKGur (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 02:50:47 -0400
Received: by mail-io0-f193.google.com with SMTP id z20-v6so22639170iol.0
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 23:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qWtuQPNu3uJYpgIZkcbEyOZpMhtK4Sxa5UazzbRvD9c=;
        b=O7w97I52BA9C60dmEq7MVUSCCQcWAUOIzBX3P87zAX66KFA4mnBxVdcm0Q2pGdihQ6
         ID+hM+CaIsE8Uh5hoB34oqFGUS37iQOIbU9OqbSaA3nHALt6H4My3FKsdcIY/2B6ku88
         tZvOyAiRTezXBH4QOAau8h0Rz167QniqEMbeRFkK1vqnQJ0RxDeS0uC1wx3KN+DP3lw/
         20179gyiBAyRKE/U9ILb2SsmFpu1oimCD1kWl3SRorY98OYCsD0Quy+5a3ByVdIXFR9y
         cP3Be+11sKob+g7hCCsATuCFNSzUJTOtejTqGD7SvYoUc/gfdx9egYixS/1P2gMCOPeB
         6onA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=qWtuQPNu3uJYpgIZkcbEyOZpMhtK4Sxa5UazzbRvD9c=;
        b=luWUkGxkz9gk16xV52zIVK32iShwpOH+dkbJuhCzXxzqIL7P57UERvcxJjVAlG58gM
         oiBH/jZfJr2V9qelOkgpEaW4p2XlxldbkRmJ/lV10GosAz6fqJ8w+7WF5U6bOWhTQDko
         9ZJ6bxgqCzkGjUzBuKwJy6Y7hl6VV/YUSvWPPBZFUtxykvM8xwXWqGqfvoii3XBSkoSx
         petwVkPqyXMxDlOwCdIYcm/eavM8xF86NSO6nRC2Q/z8+FfjrMkcbYxBwZQGbDrdbs6/
         dT2tcimL9Kf3/Febyoj5kDvq8ZuahASe5oeDdvwdnOtKfcaXNyK5GOJJlmSPVHZSzmR5
         dtrg==
X-Gm-Message-State: AOUpUlHm6vArTtOPi1lLtn97xiCXXqK2w9cVcWD84AW0zIeU7ZA03eKY
        miE6TKn8FU9Q+nyxBAkM4z9Pkw==
X-Google-Smtp-Source: AAOMgpfCnfho50ba2QFfXEZS84D9j890UlwrafPJBlBA+DgtPiz83FS8jUBrfdLuBtcjTdKvEuDmSw==
X-Received: by 2002:a6b:9fcb:: with SMTP id i194-v6mr23265664ioe.286.1531291681347;
        Tue, 10 Jul 2018 23:48:01 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id b143-v6sm11308298ioe.66.2018.07.10.23.48.00
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 10 Jul 2018 23:48:00 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 00/10] detect broken &&-chains in subshells
Date:   Wed, 11 Jul 2018 02:46:32 -0400
Message-Id: <20180711064642.6933-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9
In-Reply-To: <20180626073001.6555-1-sunshine@sunshineco.com>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a re-roll of [1] which teaches --chain-lint to detect broken
&&-chains in subshells since the existing implementation[2] detects
breakage only at the top-level. It is built atop 'es/test-fixes', which
was split off of [1] and submitted separately[3], and which fixes many
broken &&-chains.

The major difference since v1 is that broken &&-chains in subshells are
now detected by pure textual inspection rather than by merging subshell
commands into the top-level &&-chain. Thus, v2 entirely sidesteps the
primary objection[4] raised during v1 review of possible unintended
side-effects of test code executing outside of the intended directory.
The pure textual detection implemented by v2 can have no such
side-effects.

A second important difference since v1 is that the "linter" itself, a
complex 'sed' script, now has its own tests to ensure correct behavior.
Not only do the tests protect against regressions, but they help to
document (for humans) expected behavior, which is important since 'sed'
scripts can seem rather inscrutable due to looking like line-noise and
due to the 'sed' "language" being stack-oriented (albeit with a very
tiny stack) which, like other stack-oriented languages (Forth,
Postscript, etc.) can be difficult to reason about.

Although the 'sed' script in v1 was already well-commented, the comments
have been improved in v2. More importantly, a high-level overview of the
script's operation has been added at the top of the file to aid
comprehension.

Thanks to Elijah, Hannes, Jonathan Nieder, Jonathan Tan, Junio, Luke,
Peff, and Stefan for comments on v1.

[1]: https://public-inbox.org/git/20180626073001.6555-1-sunshine@sunshineco.com/
[2]: https://public-inbox.org/git/20150320100429.GA17354@peff.net/
[3]: https://public-inbox.org/git/20180702002405.3042-1-sunshine@sunshineco.com/
[4]: https://public-inbox.org/git/xmqqwouljr5e.fsf@gitster-ct.c.googlers.com/

Eric Sunshine (10):
  t/test-lib: teach --chain-lint to detect broken &&-chains in subshells
  t/Makefile: add machinery to check correctness of chainlint.sed
  t/chainlint: add chainlint "basic" test cases
  t/chainlint: add chainlint "whitespace" test cases
  t/chainlint: add chainlint "one-liner" test cases
  t/chainlint: add chainlint "nested subshell" test cases
  t/chainlint: add chainlint "loop" and "conditional" test cases
  t/chainlint: add chainlint "cuddled" test cases
  t/chainlint: add chainlint "complex" test cases
  t/chainlint: add chainlint "specialized" test cases

 t/.gitignore                                  |   1 +
 t/Makefile                                    |  25 +-
 t/chainlint.sed                               | 346 ++++++++++++++++++
 t/chainlint/arithmetic-expansion.expect       |   9 +
 t/chainlint/arithmetic-expansion.test         |  11 +
 t/chainlint/bash-array.expect                 |  10 +
 t/chainlint/bash-array.test                   |  12 +
 t/chainlint/blank-line.expect                 |   4 +
 t/chainlint/blank-line.test                   |  10 +
 t/chainlint/block.expect                      |  12 +
 t/chainlint/block.test                        |  15 +
 t/chainlint/broken-chain.expect               |   6 +
 t/chainlint/broken-chain.test                 |   8 +
 t/chainlint/case.expect                       |  19 +
 t/chainlint/case.test                         |  23 ++
 .../close-nested-and-parent-together.expect   |   4 +
 .../close-nested-and-parent-together.test     |   3 +
 t/chainlint/close-subshell.expect             |  25 ++
 t/chainlint/close-subshell.test               |  27 ++
 t/chainlint/command-substitution.expect       |   9 +
 t/chainlint/command-substitution.test         |  11 +
 t/chainlint/comment.expect                    |   4 +
 t/chainlint/comment.test                      |  11 +
 t/chainlint/complex-if-in-cuddled-loop.expect |  10 +
 t/chainlint/complex-if-in-cuddled-loop.test   |  11 +
 t/chainlint/cuddled-if-then-else.expect       |   7 +
 t/chainlint/cuddled-if-then-else.test         |   7 +
 t/chainlint/cuddled-loop.expect               |   5 +
 t/chainlint/cuddled-loop.test                 |   7 +
 t/chainlint/cuddled.expect                    |  21 ++
 t/chainlint/cuddled.test                      |  23 ++
 t/chainlint/exit-loop.expect                  |  24 ++
 t/chainlint/exit-loop.test                    |  27 ++
 t/chainlint/exit-subshell.expect              |   5 +
 t/chainlint/exit-subshell.test                |   6 +
 t/chainlint/for-loop.expect                   |  11 +
 t/chainlint/for-loop.test                     |  19 +
 t/chainlint/here-doc.expect                   |   3 +
 t/chainlint/here-doc.test                     |  16 +
 t/chainlint/if-in-loop.expect                 |  12 +
 t/chainlint/if-in-loop.test                   |  15 +
 t/chainlint/if-then-else.expect               |  19 +
 t/chainlint/if-then-else.test                 |  28 ++
 t/chainlint/incomplete-line.expect            |   4 +
 t/chainlint/incomplete-line.test              |  12 +
 t/chainlint/inline-comment.expect             |   9 +
 t/chainlint/inline-comment.test               |  12 +
 t/chainlint/loop-in-if.expect                 |  12 +
 t/chainlint/loop-in-if.test                   |  15 +
 ...ti-line-nested-command-substitution.expect |   9 +
 ...ulti-line-nested-command-substitution.test |   9 +
 t/chainlint/multi-line-string.expect          |   9 +
 t/chainlint/multi-line-string.test            |  15 +
 t/chainlint/negated-one-liner.expect          |   5 +
 t/chainlint/negated-one-liner.test            |   7 +
 t/chainlint/nested-cuddled-subshell.expect    |  19 +
 t/chainlint/nested-cuddled-subshell.test      |  31 ++
 t/chainlint/nested-here-doc.expect            |   5 +
 t/chainlint/nested-here-doc.test              |  23 ++
 t/chainlint/nested-subshell-comment.expect    |  11 +
 t/chainlint/nested-subshell-comment.test      |  13 +
 t/chainlint/nested-subshell.expect            |  12 +
 t/chainlint/nested-subshell.test              |  14 +
 t/chainlint/one-liner.expect                  |   9 +
 t/chainlint/one-liner.test                    |  12 +
 t/chainlint/p4-filespec.expect                |   4 +
 t/chainlint/p4-filespec.test                  |   5 +
 t/chainlint/pipe.expect                       |   8 +
 t/chainlint/pipe.test                         |  12 +
 t/chainlint/semicolon.expect                  |  20 +
 t/chainlint/semicolon.test                    |  25 ++
 t/chainlint/subshell-here-doc.expect          |   5 +
 t/chainlint/subshell-here-doc.test            |  23 ++
 t/chainlint/subshell-one-liner.expect         |  14 +
 t/chainlint/subshell-one-liner.test           |  24 ++
 t/chainlint/while-loop.expect                 |  11 +
 t/chainlint/while-loop.test                   |  19 +
 t/test-lib.sh                                 |   3 +-
 78 files changed, 1316 insertions(+), 5 deletions(-)
 create mode 100644 t/chainlint.sed
 create mode 100644 t/chainlint/arithmetic-expansion.expect
 create mode 100644 t/chainlint/arithmetic-expansion.test
 create mode 100644 t/chainlint/bash-array.expect
 create mode 100644 t/chainlint/bash-array.test
 create mode 100644 t/chainlint/blank-line.expect
 create mode 100644 t/chainlint/blank-line.test
 create mode 100644 t/chainlint/block.expect
 create mode 100644 t/chainlint/block.test
 create mode 100644 t/chainlint/broken-chain.expect
 create mode 100644 t/chainlint/broken-chain.test
 create mode 100644 t/chainlint/case.expect
 create mode 100644 t/chainlint/case.test
 create mode 100644 t/chainlint/close-nested-and-parent-together.expect
 create mode 100644 t/chainlint/close-nested-and-parent-together.test
 create mode 100644 t/chainlint/close-subshell.expect
 create mode 100644 t/chainlint/close-subshell.test
 create mode 100644 t/chainlint/command-substitution.expect
 create mode 100644 t/chainlint/command-substitution.test
 create mode 100644 t/chainlint/comment.expect
 create mode 100644 t/chainlint/comment.test
 create mode 100644 t/chainlint/complex-if-in-cuddled-loop.expect
 create mode 100644 t/chainlint/complex-if-in-cuddled-loop.test
 create mode 100644 t/chainlint/cuddled-if-then-else.expect
 create mode 100644 t/chainlint/cuddled-if-then-else.test
 create mode 100644 t/chainlint/cuddled-loop.expect
 create mode 100644 t/chainlint/cuddled-loop.test
 create mode 100644 t/chainlint/cuddled.expect
 create mode 100644 t/chainlint/cuddled.test
 create mode 100644 t/chainlint/exit-loop.expect
 create mode 100644 t/chainlint/exit-loop.test
 create mode 100644 t/chainlint/exit-subshell.expect
 create mode 100644 t/chainlint/exit-subshell.test
 create mode 100644 t/chainlint/for-loop.expect
 create mode 100644 t/chainlint/for-loop.test
 create mode 100644 t/chainlint/here-doc.expect
 create mode 100644 t/chainlint/here-doc.test
 create mode 100644 t/chainlint/if-in-loop.expect
 create mode 100644 t/chainlint/if-in-loop.test
 create mode 100644 t/chainlint/if-then-else.expect
 create mode 100644 t/chainlint/if-then-else.test
 create mode 100644 t/chainlint/incomplete-line.expect
 create mode 100644 t/chainlint/incomplete-line.test
 create mode 100644 t/chainlint/inline-comment.expect
 create mode 100644 t/chainlint/inline-comment.test
 create mode 100644 t/chainlint/loop-in-if.expect
 create mode 100644 t/chainlint/loop-in-if.test
 create mode 100644 t/chainlint/multi-line-nested-command-substitution.expect
 create mode 100644 t/chainlint/multi-line-nested-command-substitution.test
 create mode 100644 t/chainlint/multi-line-string.expect
 create mode 100644 t/chainlint/multi-line-string.test
 create mode 100644 t/chainlint/negated-one-liner.expect
 create mode 100644 t/chainlint/negated-one-liner.test
 create mode 100644 t/chainlint/nested-cuddled-subshell.expect
 create mode 100644 t/chainlint/nested-cuddled-subshell.test
 create mode 100644 t/chainlint/nested-here-doc.expect
 create mode 100644 t/chainlint/nested-here-doc.test
 create mode 100644 t/chainlint/nested-subshell-comment.expect
 create mode 100644 t/chainlint/nested-subshell-comment.test
 create mode 100644 t/chainlint/nested-subshell.expect
 create mode 100644 t/chainlint/nested-subshell.test
 create mode 100644 t/chainlint/one-liner.expect
 create mode 100644 t/chainlint/one-liner.test
 create mode 100644 t/chainlint/p4-filespec.expect
 create mode 100644 t/chainlint/p4-filespec.test
 create mode 100644 t/chainlint/pipe.expect
 create mode 100644 t/chainlint/pipe.test
 create mode 100644 t/chainlint/semicolon.expect
 create mode 100644 t/chainlint/semicolon.test
 create mode 100644 t/chainlint/subshell-here-doc.expect
 create mode 100644 t/chainlint/subshell-here-doc.test
 create mode 100644 t/chainlint/subshell-one-liner.expect
 create mode 100644 t/chainlint/subshell-one-liner.test
 create mode 100644 t/chainlint/while-loop.expect
 create mode 100644 t/chainlint/while-loop.test

-- 
2.18.0.203.gfac676dfb9

