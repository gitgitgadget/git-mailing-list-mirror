Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDA6C433E6
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 15:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 404B064DE0
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 15:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbhBOPrk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 10:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbhBOPp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 10:45:29 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A2BC06178C
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:44:47 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id x4so9743495wmi.3
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qKuaakSsFcKWQtzJhNFpZA7jIbMBgSOyXYBdBS9EOdA=;
        b=eoTU/0Jn/l9usgC2zEadR4mk9AdNhbm4TkI90qhZdXqYXa7i9RdxRn16x0fFIjREey
         8N1/rPfSDVeEuH7aaJgKDPN0W3W2iHIB8JBGW4iV+N6WJG8L0+kz85sIFB96+ROQF61P
         6D3oF5bNPh2BfTjCniDd4q+vtfyoe5io+iSmpJLJU5Y66aBip1WOXXPrn6JLJvhvYEHq
         dsR76dofLSreFgJLpehr+QNVPs1VVB4JfYYa9ruYFZstJZOwPQ1T8ypjDg5GrO5p6Tk0
         igrvhKRBLE/q06oyP00LAlq3ya3TP1sPu4DCFpbdqxetRSrESbNZ2h88el+5SZz5VO/4
         VEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qKuaakSsFcKWQtzJhNFpZA7jIbMBgSOyXYBdBS9EOdA=;
        b=O8MHaJbATZMg7E89YX8m6KYOmDj/NkyPAph1UJ0WW+XvzFxj2Bp67SCgqdM8a5IDVu
         x7oma8EoKXJeYmNTDiq2b0vYCnu2yG/qEpuLbzxAQY9y+CZQuf0EP1Rftl1JJnkyJ1RH
         O0p/HjcyJDhYAZkJ2FJRBKC8YtNnS6qwuty33M99slBBHre4h/q+2Vr+yKY0rrh5iV4G
         K66CROYhpT5GJ0SjGsISytOdhMBjQaBy7njmqYMGfFgqt1w3Jjsv6KuAMU3JKfwE5KVU
         DpZqpRWbdJ2E7zSPA+ukL2gINunim1n8hesb0Ee4lXdofaQc+yPnezSaL26SM4tLDP/X
         cWRw==
X-Gm-Message-State: AOAM532mve67292cvljV03YQUC4iCnxO2AN3wK9iYaLlOnXB0Fl+zClC
        i+j7pjpSXCx+hBOt0mX7hdbA/oelOWoXHQ==
X-Google-Smtp-Source: ABdhPJxZM2oLEJWMXlJ82Byqs9Vak9TC+R/OdmbI8Ncu0BHyv7wTRD3k8zA13MnY6mAHzBCIcPgU/A==
X-Received: by 2002:a7b:cb4f:: with SMTP id v15mr14903117wmj.162.1613403885435;
        Mon, 15 Feb 2021 07:44:45 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f17sm23562757wrx.57.2021.02.15.07.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 07:44:44 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 00/27] userdiff: refactor + test + doc + misc improvements
Date:   Mon, 15 Feb 2021 16:44:00 +0100
Message-Id: <20210215154427.32693-1-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215005236.11313-1-avarab@gmail.com>
References: <20210215005236.11313-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Incorporates all the feedback on v2 and more, see the range-diff
below.

Ævar Arnfjörð Bjarmason (27):
  userdiff: refactor away the parse_bool() function
  userdiff style: re-order drivers in alphabetical order
  userdiff style: declare patterns with consistent style
  userdiff style: normalize pascal regex declaration
  userdiff: add and use for_each_userdiff_driver()
  userdiff tests: explicitly test "default" pattern
  userdiff tests: list builtin drivers via test-tool
  userdiff: remove support for "broken" tests
  userdiff tests: match full hunk headers
  blame tests: don't rely on t/t4018/ directory
  blame tests: simplify userdiff driver test
  userdiff tests: rewrite hunk header test infrastructure
  userdiff tests: do config teardown in test_diff_funcname()
  userdiff tests: move custom patterns into one test file
  userdiff tests: remove hack for "RIGHT" token
  userdiff tests: do not do compile tests on "custom" pattern
  userdiff tests + docs: document & test "diff.<driver>.x?funcname"
  gitattributes doc: reword discussion of built-in userdiff patterns
  gitattributes doc: document multi-line userdiff patterns
  userdiff tests: remove "funcname" from custom3 test
  userdiff tests: factor out test_diff_funcname() logic
  userdiff tests: test hunk headers on accumulated files
  userdiff tests: test hunk header selection with -U0
  userdiff tests: assert empty hunk header context on -U<large>
  userdiff: match "package" in diff=golang
  userdiff tests: add basic test for ada
  userdiff tests: add basic test for ruby

 Documentation/config/diff.txt              |  11 +
 Documentation/gitattributes.txt            |  41 +++-
 Makefile                                   |   1 +
 t/annotate-tests.sh                        |  34 +--
 t/helper/test-tool.c                       |   1 +
 t/helper/test-tool.h                       |   1 +
 t/helper/test-userdiff.c                   |  30 +++
 t/t4018-diff-funcname.sh                   | 163 ++++++++------
 t/t4018/README                             |  18 --
 t/t4018/ada.sh                             |  37 ++++
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
 t/t4018/custom.sh                          | 163 ++++++++++++++
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
 t/t4018/perl.sh                            |  94 ++++++++
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
 t/t4018/ruby.sh                            |  58 +++++
 t/t4018/rust-fn                            |   5 -
 t/t4018/rust-impl                          |   5 -
 t/t4018/rust-macro-rules                   |   6 -
 t/t4018/rust-struct                        |   5 -
 t/t4018/rust-trait                         |   5 -
 t/t4018/rust.sh                            |  60 ++++++
 userdiff.c                                 | 180 ++++++++++------
 userdiff.h                                 |  15 ++
 150 files changed, 2083 insertions(+), 928 deletions(-)
 create mode 100644 t/helper/test-userdiff.c
 delete mode 100644 t/t4018/README
 create mode 100755 t/t4018/ada.sh
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
 create mode 100755 t/t4018/ruby.sh
 delete mode 100644 t/t4018/rust-fn
 delete mode 100644 t/t4018/rust-impl
 delete mode 100644 t/t4018/rust-macro-rules
 delete mode 100644 t/t4018/rust-struct
 delete mode 100644 t/t4018/rust-trait
 create mode 100755 t/t4018/rust.sh

Range-diff:
 -:  ---------- >  1:  305fc646d0 userdiff: refactor away the parse_bool() function
 1:  7dbe7d638e !  2:  989438c46a userdiff: re-order builtin drivers in alphabetical order
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    userdiff: re-order builtin drivers in alphabetical order
    +    userdiff style: re-order drivers in alphabetical order
     
         Address some old code smell and move around the built-in userdiff
    -    definitions so they're both in alphabetical order, and now in the same
    +    drivers so they're both in alphabetical order, and now in the same
         order they appear in the gitattributes(5) documentation.
     
         The two started drifting in be58e70dba (diff: unify external diff and
 -:  ---------- >  3:  4c48e5532c userdiff style: declare patterns with consistent style
 -:  ---------- >  4:  f41fa5b316 userdiff style: normalize pascal regex declaration
 2:  69532bfb68 =  5:  0875d5205c userdiff: add and use for_each_userdiff_driver()
 3:  6ad7a5f608 =  6:  638247d04d userdiff tests: explicitly test "default" pattern
 4:  48b8c39380 !  7:  219043a488 userdiff tests: list builtin drivers via test-tool
    @@ t/helper/test-userdiff.c (new)
     +#include "cache.h"
     +#include "userdiff.h"
     +
    -+static int userdiff_list_builtin_drivers_cb(struct userdiff_driver *driver,
    -+					    enum userdiff_driver_type type,
    -+					    void *priv)
    ++static int driver_cb(struct userdiff_driver *driver,
    ++		     enum userdiff_driver_type type, void *priv)
     +{
     +	puts(driver->name);
     +	return 0;
    @@ t/helper/test-userdiff.c (new)
     +
     +static int list_what(enum userdiff_driver_type type)
     +{
    -+	return for_each_userdiff_driver(userdiff_list_builtin_drivers_cb, type,
    -+					NULL);
    ++	return for_each_userdiff_driver(driver_cb, type, NULL);
     +}
     +
     +int cmd__userdiff(int argc, const char **argv)
    @@ t/t4018-diff-funcname.sh: test_description='Test custom diff function name patte
      . ./test-lib.sh
      
      test_expect_success 'setup' '
    -+	test-tool userdiff list-builtin-drivers >builtin-drivers &&
    -+	test_file_not_empty builtin-drivers &&
    -+	builtin_drivers=$(cat builtin-drivers) &&
    ++	builtin_drivers=$(test-tool userdiff list-builtin-drivers) &&
    ++	test -n "$builtin_drivers" &&
     +
      	# a non-trivial custom pattern
      	git config diff.custom1.funcname "!static
 5:  3073d07409 =  8:  eb66160aac userdiff: remove support for "broken" tests
 6:  fd93d18351 !  9:  c6c54039e2 userdiff tests: match full hunk headers
    @@ Commit message
         towards even better test coverage. I'm structuring these tests in such
         a way as to benefit from the diff.colorMove detection.
     
    +    The "sed -n -e" here was originally a single 's/^.*@@\( \|$\)//p'
    +    pattern, but the '\( \|$\)' part had portability issues on OSX and
    +    AIX.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/t4018-diff-funcname.sh ##
    @@ t/t4018-diff-funcname.sh: test_expect_success 'setup hunk header tests' '
     -		git diff -U1 $i >actual &&
     -		grep '@@ .* @@.*RIGHT' actual
     +		git diff -U1 $i >diff &&
    -+		sed -n -e 's/^.*@@\( \|$\)//p' <diff >ctx &&
    ++		sed -n -e 's/^.*@@$//p' -e 's/^.*@@ //p' <diff >ctx &&
     +		test_cmp $i.ctx ctx
      	"
      done
    @@ t/t4018/README
     -of equal signs.
     +The text that must appear in the hunk header must contains the word
     +"RIGHT" by convention. The "LANG-whatever.ctx" file contains what we
    -+expect to appear in the hunk header. We munged the start of the line
    -+to "@@ [...] @@" for ease of not having to hardcode the line numbers
    -+and offsets.
    ++expect to appear in the hunk header. We munged away the starting "@@
    ++[...] @@" part of the line for ease of not having to hardcode the line
    ++numbers and offsets.
     
      ## t/t4018/README.ctx (new) ##
     @@
 8:  034ab9f85b ! 10:  1c6ddf96f6 blame tests: don't rely on t/t4018/ directory
    @@ Commit message
         with userdiff driver, 2020-11-01) so that the blame tests don't rely
         on stealing the contents of "t/t4018/fortran-external-function".
     
    -    I'm about to refactor that directory, just moving the relevant test
    -    file here inline is the easiest solution, and I think also the most
    -    readable.
    +    I'm about to refactor that directory to delete that file, just moving
    +    the relevant test file here inline is the easiest solution, and I
    +    think also the most readable.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
 -:  ---------- > 11:  8a883d8799 blame tests: simplify userdiff driver test
 7:  4f8df97207 ! 12:  e56a7a6b5f userdiff tests: rewrite hunk header test infrastructure
    @@ t/t4018-diff-funcname.sh: test_expect_success 'last regexp must not be negated'
     +
     +	test_expect_success "$desc" '
     +		git diff -U1 "$what" >diff &&
    -+		sed -n -e "s/^.*@@\( \|$\)//p" <diff >actual &&
    ++		sed -n -e "s/^.*@@$//p" -e "s/^.*@@ //p" <diff >actual &&
     +		test_cmp expected actual
     +	'
     +}
    @@ t/t4018-diff-funcname.sh: test_expect_success 'last regexp must not be negated'
      do
     -	test_expect_success "hunk header: $i" "
     -		git diff -U1 $i >diff &&
    --		sed -n -e 's/^.*@@\( \|$\)//p' <diff >ctx &&
    +-		sed -n -e 's/^.*@@$//p' -e 's/^.*@@ //p' <diff >ctx &&
     -		test_cmp $i.ctx ctx
     -	"
     +	test="$TEST_DIRECTORY/t4018/$what.sh"
    @@ t/t4018/README (deleted)
     -
     -The text that must appear in the hunk header must contains the word
     -"RIGHT" by convention. The "LANG-whatever.ctx" file contains what we
    --expect to appear in the hunk header. We munged the start of the line
    --to "@@ [...] @@" for ease of not having to hardcode the line numbers
    --and offsets.
    +-expect to appear in the hunk header. We munged away the starting "@@
    +-[...] @@" part of the line for ease of not having to hardcode the line
    +-numbers and offsets.
     
      ## t/t4018/README.ctx (deleted) ##
     @@
 -:  ---------- > 13:  84d20a7cd0 userdiff tests: do config teardown in test_diff_funcname()
 9:  e48ad2b57f ! 14:  70fc9fa565 userdiff tests: move custom patterns into one test file
    @@ Commit message
     
      ## t/t4018-diff-funcname.sh ##
     @@ t/t4018-diff-funcname.sh: test_expect_success 'setup' '
    - 	test_file_not_empty builtin-drivers &&
    - 	builtin_drivers=$(cat builtin-drivers) &&
    + 	builtin_drivers=$(test-tool userdiff list-builtin-drivers) &&
    + 	test -n "$builtin_drivers" &&
      
     -	# a non-trivial custom pattern
     -	git config diff.custom1.funcname "!static
    @@ t/t4018/custom.sh (new)
     +	}
     +}
     +EOF_TEST
    -+
    -+test_expect_success 'custom: teardown' '
    -+	test_unconfig diff.custom.funcname &&
    -+	test_unconfig diff.custom.xfuncname
    -+'
     
      ## t/t4018/custom1.sh (deleted) ##
     @@
10:  6a4224b512 = 15:  8539d6d464 userdiff tests: remove hack for "RIGHT" token
 -:  ---------- > 16:  121e5d6dfa userdiff tests: do not do compile tests on "custom" pattern
12:  9ce7de5698 ! 17:  451b7ae453 userdiff tests + docs: document & test "diff.<driver>.x?funcname"
    @@ Documentation/config/diff.txt: diff.<driver>.command::
      	See linkgit:gitattributes[5] for details.
     ++
     +When provided as `diff.<driver>.funcname` the regular expression is
    -+interpreted as a basic regular expression, with
    ++interpreted as a basic regular expression. With
     +`diff.<driver>.xfuncname` it's interpreted as an extended regular
     +expression.
     ++
    -+
     +The `*.funcname` and `*.xfuncname` variables behave as if though they
     +were one configuration variable for the purposes of what value
     +eventually gets used. Setting `*.funcname` will override an earlier
    @@ Documentation/config/diff.txt: diff.<driver>.command::
     
      ## t/t4018/custom.sh ##
     @@ t/t4018/custom.sh: public class Beer
    + 	}
      }
      EOF_TEST
    - 
    -+test_expect_success 'custom; setup config precedence' '
    ++
    ++test_expect_success 'custom: setup config precedence' '
     +	git config diff.custom.funcname "foo" &&
     +	git config diff.custom.xfuncname "bar"
     +'
    @@ t/t4018/custom.sh: public class Beer
     +baz
     +EOF_TEST
     +
    -+test_expect_success 'custom: teardown' '
    -+	test_unconfig diff.custom.funcname &&
    -+	test_unconfig diff.custom.xfuncname
    -+'
    -+
    -+test_expect_success 'custom; setup config precedence' '
    ++test_expect_success 'custom: setup config precedence' '
     +	git config diff.custom.xfuncname "bar" &&
     +	git config diff.custom.funcname "foo"
    -+
     +'
     +
     +test_diff_funcname 'custom: config precedence' \
    @@ t/t4018/custom.sh: public class Beer
     +
     +baz
     +EOF_TEST
    -+
    - test_expect_success 'custom: teardown' '
    - 	test_unconfig diff.custom.funcname &&
    - 	test_unconfig diff.custom.xfuncname
13:  3a9f64b747 ! 18:  5a402bb9bf gitattributes doc: reword discussion of built-in userdiff patterns
    @@ Commit message
         "diff.tex.xfuncname" example which now immediately precedes it. This
         will make a follow-up commit smaller.
     
    +    Helped-by: Eric Sunshine <sunshine@sunshineco.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Documentation/gitattributes.txt ##
    @@ Documentation/gitattributes.txt: backslashes; the pattern above picks a line tha
     +There are built-in patterns shipped as part of git itself. A more
     +advanced version of the `tex` pattern discussed above is one of them.
     +
    -+For built-in patterns you do not need the "diff.tex.xfuncname"
    -+discussed above in your configuration file, but if present it'll
    -+override the built-in pattern.
    ++For built-in patterns, you do not need `diff.<lang>.xfuncname` in your
    ++configuration file as discussed above, but if present, it will
    ++override a built-in pattern.
     +
    -+You still need to enable built-in patterns with the the attribute
    -+mechanism, via `.gitattributes`).
    ++Nevertheless, you need to enable built-in patterns via .gitattributes`
    ++for the pattern to take effect.
     +
    -+The following built in patterns are available:
    ++The following built-in patterns are available:
      
      - `ada` suitable for source code in the Ada language.
      
14:  a3e8d0bfc1 ! 19:  a3badb1a3e gitattributes doc: document multi-line userdiff patterns
    @@ Documentation/gitattributes.txt: backslashes; the pattern above picks a line tha
      backslash, and zero or more occurrences of `sub` followed by
      `section` followed by open brace, to the end of line.
      
    -+Multiple patterns can be supplied by seperating them with
    -+newlines. They will be matched one at a time and are compiled as
    -+separate patterns, and thus the first capture in each such pattern is
    -+`$1`, see further discussion of captures below.
    +-There are built-in patterns shipped as part of git itself. A more
    +-advanced version of the `tex` pattern discussed above is one of them.
    ++Multiple patterns can be supplied by listing them one per line
    ++separated by `\n`. They will be matched one at a time from left to
    ++right. Do not supply a trailing "\n" for the last pattern. E.g.:
     +
    -+Patterns that begin with "!" are negated (to match a literal "!" at
    -+the start of a line use e.g. "[!]"). A matching negated pattern will
    -+cause the matching line to be skipped. Use it to blacklist otherwise
    -+matching non-negated patterns. The last pattern must not be negated,
    -+we'll error out if that's the case.
    ++------------------------
    ++[diff "perl"]
    ++	xfuncname = "!^=head\n^[^ ]+.*"
    ++------------------------
    ++
    ++Patterns in in a list of multiple that begin with "!" are negated. A
    ++matching negated pattern will cause the matched line to be
    ++skipped. Use it to skip a later pattern that would otherwise match. It
    ++is an error if one or more negated patterns aren't followed by a
    ++non-negated pattern.
    ++
    ++To match a literal "!" at the start of a line, use some other regex
    ++construct that will match a literal "!" without "!" being the first
    ++character on that line, such as "[!]".
     +
     +If the pattern contains a `$1` capture it will be used instead of the
     +entire matching line (`$0`) to display the hunk header. This can be
    @@ Documentation/gitattributes.txt: backslashes; the pattern above picks a line tha
     +only display the function name as part of a longer function
     +definition.
     +
    - There are built-in patterns shipped as part of git itself. A more
    - advanced version of the `tex` pattern discussed above is one of them.
    ++There are built-in patterns shipped as part of git itself, see the
    ++full listing below.
    + 
    + For built-in patterns, you do not need `diff.<lang>.xfuncname` in your
    +-configuration file as discussed above, but if present, it will
    +-override a built-in pattern.
    ++configuration file. If present, it will override a built-in pattern,
    ++as shown in the `diff.perl.xfuncname` example above.
      
    + Nevertheless, you need to enable built-in patterns via .gitattributes`
    + for the pattern to take effect.
     
      ## t/t4018/custom.sh ##
    -@@ t/t4018/custom.sh: test_expect_success 'custom: teardown' '
    - 	test_unconfig diff.custom.funcname &&
    - 	test_unconfig diff.custom.xfuncname
    - '
    +@@ t/t4018/custom.sh: ChangeMe
    + 
    + baz
    + EOF_TEST
     +
    -+test_expect_success 'custom: negation syntax, ! is magic' '
    ++test_expect_success 'custom: setup negation syntax, ! is magic' '
     +	git config diff.custom.xfuncname "!negation
     +line"
     +'
     +
    -+test_diff_funcname 'custom: config precedence' \
    ++test_diff_funcname 'custom: negation syntax, ! is magic' \
     +	8<<\EOF_HUNK 9<<\EOF_TEST
     +line
     +EOF_HUNK
    @@ t/t4018/custom.sh: test_expect_success 'custom: teardown' '
     +baz
     +EOF_TEST
     +
    -+test_expect_success 'custom: negation syntax, use [!] to override ! magic' '
    ++test_expect_success 'custom: setup negation syntax, use [!] to override ! magic' '
     +	git config diff.custom.xfuncname "[!]negation
     +line"
     +'
     +
    -+test_diff_funcname 'custom: config precedence' \
    ++test_diff_funcname 'custom: negation syntax, use [!] to override ! magic' \
     +	8<<\EOF_HUNK 9<<\EOF_TEST
     +!negation
     +EOF_HUNK
    @@ t/t4018/custom.sh: test_expect_success 'custom: teardown' '
     +baz
     +EOF_TEST
     +
    ++test_expect_success 'custom: setup captures in multiple patterns' '
    ++	git config diff.custom.xfuncname "!^=head
    ++^format ([^ ]+)
    ++^sub ([^;]+)"
    ++'
    ++
    ++test_diff_funcname 'custom: captures in multiple patterns' \
    ++	8<<\EOF_HUNK 9<<\EOF_TEST
    ++foo
    ++EOF_HUNK
    ++sub foo;
    ++=head1
    ++ChangeMe
    ++
    ++EOF_TEST
    +
    + ## t/t4018/perl.sh ##
    +@@ t/t4018/perl.sh: sub RIGHT
    + 	print "ChangeMe\n";
    + }
    + EOF_TEST
    ++
    ++
    ++test_expect_success 'custom: setup config overrides built-in patterns' '
    ++	git config diff.perl.xfuncname "!^=head
    ++^[^ ]+.*"
    ++'
    ++
    ++test_diff_funcname 'custom: config overrides built-in patterns' \
    ++	8<<\EOF_HUNK 9<<\EOF_TEST
    ++sub foo;
    ++EOF_HUNK
    ++sub foo;
    ++=head1
    ++ChangeMe
    ++
    ++EOF_TEST
15:  b83cf4da91 ! 20:  1b46726e85 userdiff tests: remove "funcname" from custom3 test
    @@ t/t4018/custom.sh: public class Beer
      	git config diff.custom.xfuncname "^[ 	]*((public|static).*)$"
      '
      
    -@@ t/t4018/custom.sh: test_diff_funcname 'custom: config precedence' \
    - line
    - EOF_HUNK
    - line
    -+
    - !negation
    - 
    - ChangeMe
16:  f286e42540 ! 21:  9a18506aff userdiff tests: factor out test_diff_funcname() logic
    @@ t/t4018-diff-funcname.sh: test_expect_success 'last regexp must not be negated'
     +
     +last_diff_context_line () {
     +	file=$1
    -+	sed -n -e "s/^.*@@\( \|$\)//p" <$file
    ++	sed -n -e "s/^.*@@$//p" -e "s/^.*@@ //p" <$file
     +}
     +
      test_diff_funcname () {
    @@ t/t4018-diff-funcname.sh: test_diff_funcname () {
      
      	test_expect_success "$desc" '
      		git diff -U1 "$what" >diff &&
    --		sed -n -e "s/^.*@@\( \|$\)//p" <diff >actual &&
    +-		sed -n -e "s/^.*@@$//p" -e "s/^.*@@ //p" <diff >actual &&
     +		last_diff_context_line diff >actual &&
      		test_cmp expected actual
    - 	'
    - }
    + 	' &&
    + 
17:  12635fefd6 ! 22:  24548fb680 userdiff tests: test hunk headers on accumulated files
    @@ t/t4018-diff-funcname.sh: test_diff_funcname () {
      		git diff -U1 "$what" >diff &&
      		last_diff_context_line diff >actual &&
      		test_cmp expected actual
    -+	' &&
    -+
    + 	' &&
    + 
     +	test_expect_success "$desc (accumulated)" '
     +		git diff -U1 "$what".acc >diff &&
     +		last_diff_context_line diff >actual.lines &&
     +		tail -n 1 actual.lines >actual &&
     +		test_cmp expected actual
    - 	'
    - }
    - 
    ++	' &&
    ++
    + 	test_expect_success "teardown: $desc" '
    + 		# In case any custom config was set immediately before
    + 		# the test itself in the test file
     @@ t/t4018-diff-funcname.sh: do
      		echo "$what" >arg.what
      	' &&
18:  3eef2896ea = 23:  48f00a59d5 userdiff tests: test hunk header selection with -U0
19:  3061fac48c ! 24:  05a01990c9 userdiff tests: assert empty hunk header context on -U<large>
    @@ Commit message
     
      ## t/t4018-diff-funcname.sh ##
     @@ t/t4018-diff-funcname.sh: test_diff_funcname () {
    - 		tail -n 1 actual.lines >actual &&
      		test_cmp expected actual
    - 	'
    -+
    + 	' &&
    + 
     +	test_expect_success "$desc -U9001 (accumulated)" '
     +		git diff -U9001 "$what".acc >diff &&
     +		last_diff_context_line diff >actual.lines &&
     +		tail -n 1 actual.lines >actual &&
     +		echo >blank &&
     +		test_cmp blank actual
    -+	'
    - }
    - 
    - for what in $diffpatterns
    ++	' &&
    ++
    + 	test_expect_success "teardown: $desc" '
    + 		# In case any custom config was set immediately before
    + 		# the test itself in the test file
11:  0901623546 ! 25:  3d2f42d704 userdiff: match "package" in diff=golang
    @@ t/t4018/golang.sh
      func (t *Test) RIGHT(a Type) (Type, error) {
     
      ## userdiff.c ##
    -@@ userdiff.c: IPATTERN("fortran",
    - IPATTERN("fountain", "^((\\.[^.]|(int|ext|est|int\\.?/ext|i/e)[. ]).*)$",
    +@@ userdiff.c: IPATTERN("fountain",
    + 	 /* -- */
      	 "[^ \t-]+"),
      PATTERNS("golang",
     +	 /* Packages */
 -:  ---------- > 26:  b2e16ade06 userdiff tests: add basic test for ada
 -:  ---------- > 27:  826b6f4d6a userdiff tests: add basic test for ruby
-- 
2.30.0.284.gd98b1dd5eaa7

