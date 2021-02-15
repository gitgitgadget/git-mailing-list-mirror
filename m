Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80488C433E6
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 00:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 431BA64DBA
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 00:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhBOAxp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 19:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhBOAxm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 19:53:42 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B86BC061574
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 16:53:01 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id r5so1468186wmp.1
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 16:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TQNwikR1hxfuH/N3xjr4YFKkUbR2eYDaVJL8aEpoffc=;
        b=c6AuULxhO3Zhc8fr5rzJyLgStl6zu+DE37hlEpkh2GvF6qoR+22lbBgxnUP+5R5yF/
         zqxVex29F5mlDP/Hhenolm/XsNil7FqHF8eehavASQ+bhN9RIvmd9ubat+movbhjZuCk
         n9Lk3LazK210cWfexMj8KFMEWgCXuFgZMURLrp6feUGAQ9bDSxJPzoEJ4bDr4vPYOeb+
         fdk3b4axEtw4j8YvWhDNDjjunA0wIZnbpdx1Kg1UNzE+s64HfFXaJ3Jaq+9MkwDYMqeS
         LbByRE8X1LBaqg/xosDYp2F1/cMT4+QwU/aHfYy+55zAFmXEL4jrJGWlUAysuWPjbIe+
         +KZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TQNwikR1hxfuH/N3xjr4YFKkUbR2eYDaVJL8aEpoffc=;
        b=AU1o/MeDeCIeTby3YgjDk/2hfL3wjYiNdcdzYo2NGk8+jq4nKKP0gD6KwACg/+SBDK
         sFiETNkMZiFPnJaWlE1EJ0vUBOoehe3kyxw3Vi1G+fRn+Zr6/XgvAwl53cqzLp9FpRSZ
         OSUDvlKD/72E1G3C51H8tlY/DB5Lc7nFXCjbT3n/CGcQ1W91V+POPFw8epUvkGjfk+Om
         CQPK07nO/pPvW49aPuAqLeftpoYnRUrWV95U1zN0T/Zg7BnIU0Vezbddy9VQHHGb51JC
         rKrssfs7ZG0v3GIHYlfszf+LYqCZLFxd8ZkSSFdB41EynaZPIKwVGc8IO481D1vJ2ABt
         iqwQ==
X-Gm-Message-State: AOAM533A703dhjfXG9gfj+YPh+ENUl8f4qvEu9TOIAjb4zzkAEj6EYJi
        Z7P/XzrpRfg089gGYg1vj6vD6vf4Lnx9aw==
X-Google-Smtp-Source: ABdhPJwoSsmBy4KF6uaffnplfy9lsnoIWgxS3un9X+oPwLbuGuZeLaUkX6Pk7x0lWkkekkWPb5u2Cw==
X-Received: by 2002:a1c:4c01:: with SMTP id z1mr12398106wmf.159.1613350379428;
        Sun, 14 Feb 2021 16:52:59 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 3sm5209832wmi.2.2021.02.14.16.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 16:52:58 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/20] userdiff: refactor + test + doc + misc improvements
Date:   Mon, 15 Feb 2021 01:52:16 +0100
Message-Id: <20210215005236.11313-1-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <87tuqebj6m.fsf@evledraar.gmail.com>
References: <87tuqebj6m.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This started out as a version of 07/20 since I noticed that we could
easily break userdiff patterns in subtle ways and and not notice,
since nothing tested the full @@ line (just whether we had a "RIGHT"
token).

But it grew into fixing warts in the code, tests docs, and I even
managed to improve the golang userdiff driver while I was at it.

Hopefully this isn't too hard to review, the diffstat is scary, but
it's mostly moving things around. I went out of my way to make 08/20
as easy as possible to review with the color-move detection.

Ævar Arnfjörð Bjarmason (20):
  userdiff: refactor away the parse_bool() function
  userdiff: re-order builtin drivers in alphabetical order
  userdiff: add and use for_each_userdiff_driver()
  userdiff tests: explicitly test "default" pattern
  userdiff tests: list builtin drivers via test-tool
  userdiff: remove support for "broken" tests
  userdiff tests: match full hunk headers
  userdiff tests: rewrite hunk header test infrastructure
  blame tests: don't rely on t/t4018/ directory
  userdiff tests: move custom patterns into one test file
  userdiff tests: remove hack for "RIGHT" token
  userdiff: match "package" in diff=golang
  userdiff tests + docs: document & test "diff.<driver>.x?funcname"
  gitattributes doc: reword discussion of built-in userdiff patterns
  gitattributes doc: document multi-line userdiff patterns
  userdiff tests: remove "funcname" from custom3 test
  userdiff tests: factor out test_diff_funcname() logic
  userdiff tests: test hunk headers on accumulated files
  userdiff tests: test hunk header selection with -U0
  userdiff tests: assert empty hunk header context on -U<large>

 Documentation/config/diff.txt              |  12 ++
 Documentation/gitattributes.txt            |  33 ++-
 Makefile                                   |   1 +
 t/annotate-tests.sh                        |  16 +-
 t/helper/test-tool.c                       |   1 +
 t/helper/test-tool.h                       |   1 +
 t/helper/test-userdiff.c                   |  32 +++
 t/t4018-diff-funcname.sh                   | 154 +++++++------
 t/t4018/README                             |  18 --
 t/t4018/bash-arithmetic-function           |   4 -
 t/t4018/bash-bashism-style-compact         |   6 -
 t/t4018/bash-bashism-style-function        |   4 -
 t/t4018/bash-bashism-style-whitespace      |   4 -
 t/t4018/bash-conditional-function          |   4 -
 t/t4018/bash-missing-parentheses           |   6 -
 t/t4018/bash-mixed-style-compact           |   4 -
 t/t4018/bash-mixed-style-function          |   4 -
 t/t4018/bash-nested-functions              |   6 -
 t/t4018/bash-other-characters              |   4 -
 t/t4018/bash-posix-style-compact           |   4 -
 t/t4018/bash-posix-style-function          |   4 -
 t/t4018/bash-posix-style-whitespace        |   4 -
 t/t4018/bash-subshell-function             |   4 -
 t/t4018/bash-trailing-comment              |   4 -
 t/t4018/bash.sh                            | 160 ++++++++++++++
 t/t4018/cpp-c++-function                   |   4 -
 t/t4018/cpp-class-constructor              |   4 -
 t/t4018/cpp-class-constructor-mem-init     |   5 -
 t/t4018/cpp-class-definition               |   4 -
 t/t4018/cpp-class-definition-derived       |   5 -
 t/t4018/cpp-class-destructor               |   4 -
 t/t4018/cpp-function-returning-global-type |   4 -
 t/t4018/cpp-function-returning-nested      |   5 -
 t/t4018/cpp-function-returning-pointer     |   4 -
 t/t4018/cpp-function-returning-reference   |   4 -
 t/t4018/cpp-gnu-style-function             |   5 -
 t/t4018/cpp-namespace-definition           |   4 -
 t/t4018/cpp-operator-definition            |   4 -
 t/t4018/cpp-skip-access-specifiers         |   8 -
 t/t4018/cpp-skip-comment-block             |   9 -
 t/t4018/cpp-skip-labels                    |   8 -
 t/t4018/cpp-struct-definition              |   9 -
 t/t4018/cpp-struct-single-line             |   7 -
 t/t4018/cpp-template-function-definition   |   4 -
 t/t4018/cpp-union-definition               |   4 -
 t/t4018/cpp-void-c-function                |   4 -
 t/t4018/cpp.sh                             | 240 +++++++++++++++++++++
 t/t4018/css-attribute-value-selector       |   4 -
 t/t4018/css-block-level-@-statements       |  10 -
 t/t4018/css-brace-in-col-1                 |   5 -
 t/t4018/css-class-selector                 |   4 -
 t/t4018/css-colon-eol                      |   4 -
 t/t4018/css-colon-selector                 |   5 -
 t/t4018/css-common                         |   4 -
 t/t4018/css-id-selector                    |   4 -
 t/t4018/css-long-selector-list             |   6 -
 t/t4018/css-prop-sans-indent               |   5 -
 t/t4018/css-root-selector                  |   4 -
 t/t4018/css-short-selector-list            |   4 -
 t/t4018/css-trailing-space                 |   5 -
 t/t4018/css.sh                             | 146 +++++++++++++
 t/t4018/custom.sh                          | 160 ++++++++++++++
 t/t4018/custom1-pattern                    |  17 --
 t/t4018/custom2-match-to-end-of-line       |   8 -
 t/t4018/custom3-alternation-in-pattern     |  17 --
 t/t4018/dts-labels                         |   9 -
 t/t4018/dts-node-unitless                  |   8 -
 t/t4018/dts-nodes                          |   8 -
 t/t4018/dts-nodes-boolean-prop             |   9 -
 t/t4018/dts-nodes-comment1                 |   8 -
 t/t4018/dts-nodes-comment2                 |   8 -
 t/t4018/dts-nodes-multiline-prop           |  13 --
 t/t4018/dts-reference                      |   9 -
 t/t4018/dts-root                           |   5 -
 t/t4018/dts-root-comment                   |   8 -
 t/t4018/dts.sh                             | 149 +++++++++++++
 t/t4018/elixir-do-not-pick-end             |   5 -
 t/t4018/elixir-ex-unit-test                |   6 -
 t/t4018/elixir-function                    |   5 -
 t/t4018/elixir-macro                       |   5 -
 t/t4018/elixir-module                      |   9 -
 t/t4018/elixir-module-func                 |   8 -
 t/t4018/elixir-nested-module               |   9 -
 t/t4018/elixir-private-function            |   5 -
 t/t4018/elixir-protocol                    |   6 -
 t/t4018/elixir-protocol-implementation     |   5 -
 t/t4018/elixir.sh                          | 127 +++++++++++
 t/t4018/fortran-block-data                 |   5 -
 t/t4018/fortran-comment                    |  13 --
 t/t4018/fortran-comment-keyword            |  14 --
 t/t4018/fortran-comment-legacy             |  13 --
 t/t4018/fortran-comment-legacy-star        |  13 --
 t/t4018/fortran-external-function          |   9 -
 t/t4018/fortran-external-subroutine        |   5 -
 t/t4018/fortran-module                     |   5 -
 t/t4018/fortran-module-procedure           |  13 --
 t/t4018/fortran-program                    |   5 -
 t/t4018/fortran.sh                         | 159 ++++++++++++++
 t/t4018/fountain-scene                     |   4 -
 t/t4018/fountain.sh                        |  14 ++
 t/t4018/golang-complex-function            |   8 -
 t/t4018/golang-func                        |   4 -
 t/t4018/golang-interface                   |   4 -
 t/t4018/golang-long-func                   |   5 -
 t/t4018/golang-struct                      |   4 -
 t/t4018/golang.sh                          |  69 ++++++
 t/t4018/java-class-member-function         |   8 -
 t/t4018/java.sh                            |  18 ++
 t/t4018/markdown-heading-indented          |   6 -
 t/t4018/markdown-heading-non-headings      |  17 --
 t/t4018/markdown.sh                        |  39 ++++
 t/t4018/matlab-class-definition            |   5 -
 t/t4018/matlab-function                    |   4 -
 t/t4018/matlab-octave-section-1            |   3 -
 t/t4018/matlab-octave-section-2            |   3 -
 t/t4018/matlab-section                     |   3 -
 t/t4018/matlab.sh                          |  55 +++++
 t/t4018/perl-skip-end-of-heredoc           |   8 -
 t/t4018/perl-skip-forward-decl             |  10 -
 t/t4018/perl-skip-sub-in-pod               |  18 --
 t/t4018/perl-sub-definition                |   4 -
 t/t4018/perl-sub-definition-kr-brace       |   4 -
 t/t4018/perl.sh                            |  78 +++++++
 t/t4018/php-abstract-class                 |   4 -
 t/t4018/php-abstract-method                |   7 -
 t/t4018/php-class                          |   4 -
 t/t4018/php-final-class                    |   4 -
 t/t4018/php-final-method                   |   7 -
 t/t4018/php-function                       |   4 -
 t/t4018/php-interface                      |   4 -
 t/t4018/php-method                         |   7 -
 t/t4018/php-trait                          |   7 -
 t/t4018/php.sh                             | 106 +++++++++
 t/t4018/python-async-def                   |   4 -
 t/t4018/python-class                       |   4 -
 t/t4018/python-def                         |   4 -
 t/t4018/python-indented-async-def          |   7 -
 t/t4018/python-indented-class              |   5 -
 t/t4018/python-indented-def                |   7 -
 t/t4018/python.sh                          |  71 ++++++
 t/t4018/rust-fn                            |   5 -
 t/t4018/rust-impl                          |   5 -
 t/t4018/rust-macro-rules                   |   6 -
 t/t4018/rust-struct                        |   5 -
 t/t4018/rust-trait                         |   5 -
 t/t4018/rust.sh                            |  60 ++++++
 userdiff.c                                 | 157 ++++++++------
 userdiff.h                                 |  15 ++
 148 files changed, 1937 insertions(+), 905 deletions(-)
 create mode 100644 t/helper/test-userdiff.c
 delete mode 100644 t/t4018/README
 delete mode 100644 t/t4018/bash-arithmetic-function
 delete mode 100644 t/t4018/bash-bashism-style-compact
 delete mode 100644 t/t4018/bash-bashism-style-function
 delete mode 100644 t/t4018/bash-bashism-style-whitespace
 delete mode 100644 t/t4018/bash-conditional-function
 delete mode 100644 t/t4018/bash-missing-parentheses
 delete mode 100644 t/t4018/bash-mixed-style-compact
 delete mode 100644 t/t4018/bash-mixed-style-function
 delete mode 100644 t/t4018/bash-nested-functions
 delete mode 100644 t/t4018/bash-other-characters
 delete mode 100644 t/t4018/bash-posix-style-compact
 delete mode 100644 t/t4018/bash-posix-style-function
 delete mode 100644 t/t4018/bash-posix-style-whitespace
 delete mode 100644 t/t4018/bash-subshell-function
 delete mode 100644 t/t4018/bash-trailing-comment
 create mode 100755 t/t4018/bash.sh
 delete mode 100644 t/t4018/cpp-c++-function
 delete mode 100644 t/t4018/cpp-class-constructor
 delete mode 100644 t/t4018/cpp-class-constructor-mem-init
 delete mode 100644 t/t4018/cpp-class-definition
 delete mode 100644 t/t4018/cpp-class-definition-derived
 delete mode 100644 t/t4018/cpp-class-destructor
 delete mode 100644 t/t4018/cpp-function-returning-global-type
 delete mode 100644 t/t4018/cpp-function-returning-nested
 delete mode 100644 t/t4018/cpp-function-returning-pointer
 delete mode 100644 t/t4018/cpp-function-returning-reference
 delete mode 100644 t/t4018/cpp-gnu-style-function
 delete mode 100644 t/t4018/cpp-namespace-definition
 delete mode 100644 t/t4018/cpp-operator-definition
 delete mode 100644 t/t4018/cpp-skip-access-specifiers
 delete mode 100644 t/t4018/cpp-skip-comment-block
 delete mode 100644 t/t4018/cpp-skip-labels
 delete mode 100644 t/t4018/cpp-struct-definition
 delete mode 100644 t/t4018/cpp-struct-single-line
 delete mode 100644 t/t4018/cpp-template-function-definition
 delete mode 100644 t/t4018/cpp-union-definition
 delete mode 100644 t/t4018/cpp-void-c-function
 create mode 100755 t/t4018/cpp.sh
 delete mode 100644 t/t4018/css-attribute-value-selector
 delete mode 100644 t/t4018/css-block-level-@-statements
 delete mode 100644 t/t4018/css-brace-in-col-1
 delete mode 100644 t/t4018/css-class-selector
 delete mode 100644 t/t4018/css-colon-eol
 delete mode 100644 t/t4018/css-colon-selector
 delete mode 100644 t/t4018/css-common
 delete mode 100644 t/t4018/css-id-selector
 delete mode 100644 t/t4018/css-long-selector-list
 delete mode 100644 t/t4018/css-prop-sans-indent
 delete mode 100644 t/t4018/css-root-selector
 delete mode 100644 t/t4018/css-short-selector-list
 delete mode 100644 t/t4018/css-trailing-space
 create mode 100755 t/t4018/css.sh
 create mode 100755 t/t4018/custom.sh
 delete mode 100644 t/t4018/custom1-pattern
 delete mode 100644 t/t4018/custom2-match-to-end-of-line
 delete mode 100644 t/t4018/custom3-alternation-in-pattern
 delete mode 100644 t/t4018/dts-labels
 delete mode 100644 t/t4018/dts-node-unitless
 delete mode 100644 t/t4018/dts-nodes
 delete mode 100644 t/t4018/dts-nodes-boolean-prop
 delete mode 100644 t/t4018/dts-nodes-comment1
 delete mode 100644 t/t4018/dts-nodes-comment2
 delete mode 100644 t/t4018/dts-nodes-multiline-prop
 delete mode 100644 t/t4018/dts-reference
 delete mode 100644 t/t4018/dts-root
 delete mode 100644 t/t4018/dts-root-comment
 create mode 100755 t/t4018/dts.sh
 delete mode 100644 t/t4018/elixir-do-not-pick-end
 delete mode 100644 t/t4018/elixir-ex-unit-test
 delete mode 100644 t/t4018/elixir-function
 delete mode 100644 t/t4018/elixir-macro
 delete mode 100644 t/t4018/elixir-module
 delete mode 100644 t/t4018/elixir-module-func
 delete mode 100644 t/t4018/elixir-nested-module
 delete mode 100644 t/t4018/elixir-private-function
 delete mode 100644 t/t4018/elixir-protocol
 delete mode 100644 t/t4018/elixir-protocol-implementation
 create mode 100755 t/t4018/elixir.sh
 delete mode 100644 t/t4018/fortran-block-data
 delete mode 100644 t/t4018/fortran-comment
 delete mode 100644 t/t4018/fortran-comment-keyword
 delete mode 100644 t/t4018/fortran-comment-legacy
 delete mode 100644 t/t4018/fortran-comment-legacy-star
 delete mode 100644 t/t4018/fortran-external-function
 delete mode 100644 t/t4018/fortran-external-subroutine
 delete mode 100644 t/t4018/fortran-module
 delete mode 100644 t/t4018/fortran-module-procedure
 delete mode 100644 t/t4018/fortran-program
 create mode 100755 t/t4018/fortran.sh
 delete mode 100644 t/t4018/fountain-scene
 create mode 100755 t/t4018/fountain.sh
 delete mode 100644 t/t4018/golang-complex-function
 delete mode 100644 t/t4018/golang-func
 delete mode 100644 t/t4018/golang-interface
 delete mode 100644 t/t4018/golang-long-func
 delete mode 100644 t/t4018/golang-struct
 create mode 100755 t/t4018/golang.sh
 delete mode 100644 t/t4018/java-class-member-function
 create mode 100755 t/t4018/java.sh
 delete mode 100644 t/t4018/markdown-heading-indented
 delete mode 100644 t/t4018/markdown-heading-non-headings
 create mode 100755 t/t4018/markdown.sh
 delete mode 100644 t/t4018/matlab-class-definition
 delete mode 100644 t/t4018/matlab-function
 delete mode 100644 t/t4018/matlab-octave-section-1
 delete mode 100644 t/t4018/matlab-octave-section-2
 delete mode 100644 t/t4018/matlab-section
 create mode 100755 t/t4018/matlab.sh
 delete mode 100644 t/t4018/perl-skip-end-of-heredoc
 delete mode 100644 t/t4018/perl-skip-forward-decl
 delete mode 100644 t/t4018/perl-skip-sub-in-pod
 delete mode 100644 t/t4018/perl-sub-definition
 delete mode 100644 t/t4018/perl-sub-definition-kr-brace
 create mode 100755 t/t4018/perl.sh
 delete mode 100644 t/t4018/php-abstract-class
 delete mode 100644 t/t4018/php-abstract-method
 delete mode 100644 t/t4018/php-class
 delete mode 100644 t/t4018/php-final-class
 delete mode 100644 t/t4018/php-final-method
 delete mode 100644 t/t4018/php-function
 delete mode 100644 t/t4018/php-interface
 delete mode 100644 t/t4018/php-method
 delete mode 100644 t/t4018/php-trait
 create mode 100755 t/t4018/php.sh
 delete mode 100644 t/t4018/python-async-def
 delete mode 100644 t/t4018/python-class
 delete mode 100644 t/t4018/python-def
 delete mode 100644 t/t4018/python-indented-async-def
 delete mode 100644 t/t4018/python-indented-class
 delete mode 100644 t/t4018/python-indented-def
 create mode 100755 t/t4018/python.sh
 delete mode 100644 t/t4018/rust-fn
 delete mode 100644 t/t4018/rust-impl
 delete mode 100644 t/t4018/rust-macro-rules
 delete mode 100644 t/t4018/rust-struct
 delete mode 100644 t/t4018/rust-trait
 create mode 100755 t/t4018/rust.sh

-- 
2.30.0.284.gd98b1dd5eaa7

