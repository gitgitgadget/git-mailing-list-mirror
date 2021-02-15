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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B19C433DB
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 00:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B7F564DBA
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 00:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhBOAy1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 19:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbhBOAyY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 19:54:24 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBE7C06178C
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 16:53:07 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id v14so7147792wro.7
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 16:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TuY9Bm806qnPHztDetPrG5cyVmwvwW01t6LP8F/X2FU=;
        b=rvCkM5B8VRDDzCb8pHT7EnVcJJySXfw9dM50BlMLQeFfLFkN9LrF/WJhPlvD3iIxWf
         6qPRACslb3Gw+lFMlRbBLK3zdWHWD9qFSQ1lp9H05PrUPv50ihYQv+H1KbSikWK6Q/rC
         xTvY3VM0HrITDKI0h05f9Roz+i6nr/7PhQ7FkVGzHaMvORWWTdtV+QNb1g6C9EpghPg0
         ROuhvAiG0cMN3PcrfPgoNliXCe9CgkGcOGzG244TGi9uuUbpXGb37KUDbmpLleNeOS42
         P36t1TDhNKVVpfHbyKGkJY4PiFfG2qRWuKKOtiYjAff5xM9sWpjdwP7Bu0/bpLLS01Gb
         1VAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TuY9Bm806qnPHztDetPrG5cyVmwvwW01t6LP8F/X2FU=;
        b=SR6xImLmBpGjHQHdH4DJt7BmnMRJaDZr04TzsDdErci3ZNV+i7YcXezg3iB7zt9OjB
         YPjEfD7sgMSJ6p9fKZPXHQVTtVWey+GCLOZ5PkwV5W0RoC/I1KWlhv3rXPUrRJbFDgWm
         PbAaD76q7Ow5BIYqBlllMBJguMRyBLDk4jQhYLgwL8YUuzVXHvIqkd5Oge8i4tHwTKHS
         QtjLnoHi0ooipij3maVlMbB8VCHpBkxabkVjGddg+CIuA+XeoX0Zim8BJ0X/sE4NvZAB
         STj6ftPSgHE+3kYNFukPAJoeL7rXMC2cYHFfB+5NTE4EAKFUceXpVggoW9LT/iPEFw/W
         GjwA==
X-Gm-Message-State: AOAM530ygWuWp2iTpjvrv3bqyJqEWLyeyKy0XmreLy3Rm1sJneyyKEgV
        jfN04ZQfPI49C+jRxsDssoO8Ft0+Ng5Z9Q==
X-Google-Smtp-Source: ABdhPJzm2B7NE7FO3csY4AV0XtOq0x9gWtnEdkpZqwpyDvyZIQGZr3oJjpNFf9Dg2iTzdDLrnmYqLw==
X-Received: by 2002:adf:efc9:: with SMTP id i9mr15597015wrp.177.1613350384811;
        Sun, 14 Feb 2021 16:53:04 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 3sm5209832wmi.2.2021.02.14.16.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 16:53:04 -0800 (PST)
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
Subject: [PATCH 07/20] userdiff tests: match full hunk headers
Date:   Mon, 15 Feb 2021 01:52:23 +0100
Message-Id: <20210215005236.11313-8-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <87tuqebj6m.fsf@evledraar.gmail.com>
References: <87tuqebj6m.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a regression in the test framework for userdiff added in
bfa7d01413 (t4018: an infrastructure to test hunk headers,
2014-03-21).

The testing infrastructure added in that change went overboard with
simplifying the tests, to the point where we lost test coverage.

Before that we'd been able to test the full context line, or ever
since the feature was originally added in f258475a6e (Per-path
attribute based hunk header selection., 2007-07-06).

After bfa7d01413 all we cared about was whether "RIGHT" appeared on
the line. We thus lost the information about whether or not "RIGHT"
was extracted from the line for the hunk header, or the line appeared
in full (or other subset of the line).

Let's bring back coverage for that by adding corresponding *.ctx
files, this has the added advantage that we're doing a "test_cmp", so
when we have failures it's just a non-zero exit code from "grep",
we'll actually have something meaningful in the "-v" output.

As we'll see in a follow-up commit this is an intermediate step
towards even better test coverage. I'm structuring these tests in such
a way as to benefit from the diff.colorMove detection.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4018-diff-funcname.sh                      |  7 +++---
 t/t4018/README                                | 22 +++++++++----------
 t/t4018/README.ctx                            |  1 +
 t/t4018/bash-arithmetic-function.ctx          |  1 +
 t/t4018/bash-bashism-style-compact.ctx        |  1 +
 t/t4018/bash-bashism-style-function.ctx       |  1 +
 t/t4018/bash-bashism-style-whitespace.ctx     |  1 +
 t/t4018/bash-conditional-function.ctx         |  1 +
 t/t4018/bash-missing-parentheses.ctx          |  1 +
 t/t4018/bash-mixed-style-compact.ctx          |  1 +
 t/t4018/bash-mixed-style-function.ctx         |  1 +
 t/t4018/bash-nested-functions.ctx             |  1 +
 t/t4018/bash-other-characters.ctx             |  1 +
 t/t4018/bash-posix-style-compact.ctx          |  1 +
 t/t4018/bash-posix-style-function.ctx         |  1 +
 t/t4018/bash-posix-style-whitespace.ctx       |  1 +
 t/t4018/bash-subshell-function.ctx            |  1 +
 t/t4018/bash-trailing-comment.ctx             |  1 +
 t/t4018/cpp-c++-function.ctx                  |  1 +
 t/t4018/cpp-class-constructor-mem-init.ctx    |  1 +
 t/t4018/cpp-class-constructor.ctx             |  1 +
 t/t4018/cpp-class-definition-derived.ctx      |  1 +
 t/t4018/cpp-class-definition.ctx              |  1 +
 t/t4018/cpp-class-destructor.ctx              |  1 +
 .../cpp-function-returning-global-type.ctx    |  1 +
 t/t4018/cpp-function-returning-nested.ctx     |  1 +
 t/t4018/cpp-function-returning-pointer.ctx    |  1 +
 t/t4018/cpp-function-returning-reference.ctx  |  1 +
 t/t4018/cpp-gnu-style-function.ctx            |  1 +
 t/t4018/cpp-namespace-definition.ctx          |  1 +
 t/t4018/cpp-operator-definition.ctx           |  1 +
 t/t4018/cpp-skip-access-specifiers.ctx        |  1 +
 t/t4018/cpp-skip-comment-block.ctx            |  1 +
 t/t4018/cpp-skip-labels.ctx                   |  1 +
 t/t4018/cpp-struct-definition.ctx             |  1 +
 t/t4018/cpp-struct-single-line.ctx            |  1 +
 t/t4018/cpp-template-function-definition.ctx  |  1 +
 t/t4018/cpp-union-definition.ctx              |  1 +
 t/t4018/cpp-void-c-function.ctx               |  1 +
 t/t4018/css-attribute-value-selector.ctx      |  1 +
 t/t4018/css-block-level-@-statements.ctx      |  1 +
 t/t4018/css-brace-in-col-1.ctx                |  1 +
 t/t4018/css-class-selector.ctx                |  1 +
 t/t4018/css-colon-eol.ctx                     |  1 +
 t/t4018/css-colon-selector.ctx                |  1 +
 t/t4018/css-common.ctx                        |  1 +
 t/t4018/css-id-selector.ctx                   |  1 +
 t/t4018/css-long-selector-list.ctx            |  1 +
 t/t4018/css-prop-sans-indent.ctx              |  1 +
 t/t4018/css-root-selector.ctx                 |  1 +
 t/t4018/css-short-selector-list.ctx           |  1 +
 t/t4018/css-trailing-space.ctx                |  1 +
 t/t4018/custom1-pattern.ctx                   |  1 +
 t/t4018/custom2-match-to-end-of-line.ctx      |  1 +
 t/t4018/custom3-alternation-in-pattern.ctx    |  1 +
 t/t4018/dts-labels.ctx                        |  1 +
 t/t4018/dts-node-unitless.ctx                 |  1 +
 t/t4018/dts-nodes-boolean-prop.ctx            |  1 +
 t/t4018/dts-nodes-comment1.ctx                |  1 +
 t/t4018/dts-nodes-comment2.ctx                |  1 +
 t/t4018/dts-nodes-multiline-prop.ctx          |  1 +
 t/t4018/dts-nodes.ctx                         |  1 +
 t/t4018/dts-reference.ctx                     |  1 +
 t/t4018/dts-root-comment.ctx                  |  1 +
 t/t4018/dts-root.ctx                          |  1 +
 t/t4018/elixir-do-not-pick-end.ctx            |  1 +
 t/t4018/elixir-ex-unit-test.ctx               |  1 +
 t/t4018/elixir-function.ctx                   |  1 +
 t/t4018/elixir-macro.ctx                      |  1 +
 t/t4018/elixir-module-func.ctx                |  1 +
 t/t4018/elixir-module.ctx                     |  1 +
 t/t4018/elixir-nested-module.ctx              |  1 +
 t/t4018/elixir-private-function.ctx           |  1 +
 t/t4018/elixir-protocol-implementation.ctx    |  1 +
 t/t4018/elixir-protocol.ctx                   |  1 +
 t/t4018/fortran-block-data.ctx                |  1 +
 t/t4018/fortran-comment-keyword.ctx           |  1 +
 t/t4018/fortran-comment-legacy-star.ctx       |  1 +
 t/t4018/fortran-comment-legacy.ctx            |  1 +
 t/t4018/fortran-comment.ctx                   |  1 +
 t/t4018/fortran-external-function.ctx         |  1 +
 t/t4018/fortran-external-subroutine.ctx       |  1 +
 t/t4018/fortran-module-procedure.ctx          |  1 +
 t/t4018/fortran-module.ctx                    |  1 +
 t/t4018/fortran-program.ctx                   |  1 +
 t/t4018/fountain-scene.ctx                    |  1 +
 t/t4018/golang-complex-function.ctx           |  1 +
 t/t4018/golang-func.ctx                       |  1 +
 t/t4018/golang-interface.ctx                  |  1 +
 t/t4018/golang-long-func.ctx                  |  1 +
 t/t4018/golang-struct.ctx                     |  1 +
 t/t4018/java-class-member-function.ctx        |  1 +
 t/t4018/markdown-heading-indented.ctx         |  1 +
 t/t4018/markdown-heading-non-headings.ctx     |  1 +
 t/t4018/matlab-class-definition.ctx           |  1 +
 t/t4018/matlab-function.ctx                   |  1 +
 t/t4018/matlab-octave-section-1.ctx           |  1 +
 t/t4018/matlab-octave-section-2.ctx           |  1 +
 t/t4018/matlab-section.ctx                    |  1 +
 t/t4018/perl-skip-end-of-heredoc.ctx          |  1 +
 t/t4018/perl-skip-forward-decl.ctx            |  1 +
 t/t4018/perl-skip-sub-in-pod.ctx              |  1 +
 t/t4018/perl-sub-definition-kr-brace.ctx      |  1 +
 t/t4018/perl-sub-definition.ctx               |  1 +
 t/t4018/php-abstract-class.ctx                |  1 +
 t/t4018/php-abstract-method.ctx               |  1 +
 t/t4018/php-class.ctx                         |  1 +
 t/t4018/php-final-class.ctx                   |  1 +
 t/t4018/php-final-method.ctx                  |  1 +
 t/t4018/php-function.ctx                      |  1 +
 t/t4018/php-interface.ctx                     |  1 +
 t/t4018/php-method.ctx                        |  1 +
 t/t4018/php-trait.ctx                         |  1 +
 t/t4018/python-async-def.ctx                  |  1 +
 t/t4018/python-class.ctx                      |  1 +
 t/t4018/python-def.ctx                        |  1 +
 t/t4018/python-indented-async-def.ctx         |  1 +
 t/t4018/python-indented-class.ctx             |  1 +
 t/t4018/python-indented-def.ctx               |  1 +
 t/t4018/rust-fn.ctx                           |  1 +
 t/t4018/rust-impl.ctx                         |  1 +
 t/t4018/rust-macro-rules.ctx                  |  1 +
 t/t4018/rust-struct.ctx                       |  1 +
 t/t4018/rust-trait.ctx                        |  1 +
 124 files changed, 137 insertions(+), 14 deletions(-)
 create mode 100644 t/t4018/README.ctx
 create mode 100644 t/t4018/bash-arithmetic-function.ctx
 create mode 100644 t/t4018/bash-bashism-style-compact.ctx
 create mode 100644 t/t4018/bash-bashism-style-function.ctx
 create mode 100644 t/t4018/bash-bashism-style-whitespace.ctx
 create mode 100644 t/t4018/bash-conditional-function.ctx
 create mode 100644 t/t4018/bash-missing-parentheses.ctx
 create mode 100644 t/t4018/bash-mixed-style-compact.ctx
 create mode 100644 t/t4018/bash-mixed-style-function.ctx
 create mode 100644 t/t4018/bash-nested-functions.ctx
 create mode 100644 t/t4018/bash-other-characters.ctx
 create mode 100644 t/t4018/bash-posix-style-compact.ctx
 create mode 100644 t/t4018/bash-posix-style-function.ctx
 create mode 100644 t/t4018/bash-posix-style-whitespace.ctx
 create mode 100644 t/t4018/bash-subshell-function.ctx
 create mode 100644 t/t4018/bash-trailing-comment.ctx
 create mode 100644 t/t4018/cpp-c++-function.ctx
 create mode 100644 t/t4018/cpp-class-constructor-mem-init.ctx
 create mode 100644 t/t4018/cpp-class-constructor.ctx
 create mode 100644 t/t4018/cpp-class-definition-derived.ctx
 create mode 100644 t/t4018/cpp-class-definition.ctx
 create mode 100644 t/t4018/cpp-class-destructor.ctx
 create mode 100644 t/t4018/cpp-function-returning-global-type.ctx
 create mode 100644 t/t4018/cpp-function-returning-nested.ctx
 create mode 100644 t/t4018/cpp-function-returning-pointer.ctx
 create mode 100644 t/t4018/cpp-function-returning-reference.ctx
 create mode 100644 t/t4018/cpp-gnu-style-function.ctx
 create mode 100644 t/t4018/cpp-namespace-definition.ctx
 create mode 100644 t/t4018/cpp-operator-definition.ctx
 create mode 100644 t/t4018/cpp-skip-access-specifiers.ctx
 create mode 100644 t/t4018/cpp-skip-comment-block.ctx
 create mode 100644 t/t4018/cpp-skip-labels.ctx
 create mode 100644 t/t4018/cpp-struct-definition.ctx
 create mode 100644 t/t4018/cpp-struct-single-line.ctx
 create mode 100644 t/t4018/cpp-template-function-definition.ctx
 create mode 100644 t/t4018/cpp-union-definition.ctx
 create mode 100644 t/t4018/cpp-void-c-function.ctx
 create mode 100644 t/t4018/css-attribute-value-selector.ctx
 create mode 100644 t/t4018/css-block-level-@-statements.ctx
 create mode 100644 t/t4018/css-brace-in-col-1.ctx
 create mode 100644 t/t4018/css-class-selector.ctx
 create mode 100644 t/t4018/css-colon-eol.ctx
 create mode 100644 t/t4018/css-colon-selector.ctx
 create mode 100644 t/t4018/css-common.ctx
 create mode 100644 t/t4018/css-id-selector.ctx
 create mode 100644 t/t4018/css-long-selector-list.ctx
 create mode 100644 t/t4018/css-prop-sans-indent.ctx
 create mode 100644 t/t4018/css-root-selector.ctx
 create mode 100644 t/t4018/css-short-selector-list.ctx
 create mode 100644 t/t4018/css-trailing-space.ctx
 create mode 100644 t/t4018/custom1-pattern.ctx
 create mode 100644 t/t4018/custom2-match-to-end-of-line.ctx
 create mode 100644 t/t4018/custom3-alternation-in-pattern.ctx
 create mode 100644 t/t4018/dts-labels.ctx
 create mode 100644 t/t4018/dts-node-unitless.ctx
 create mode 100644 t/t4018/dts-nodes-boolean-prop.ctx
 create mode 100644 t/t4018/dts-nodes-comment1.ctx
 create mode 100644 t/t4018/dts-nodes-comment2.ctx
 create mode 100644 t/t4018/dts-nodes-multiline-prop.ctx
 create mode 100644 t/t4018/dts-nodes.ctx
 create mode 100644 t/t4018/dts-reference.ctx
 create mode 100644 t/t4018/dts-root-comment.ctx
 create mode 100644 t/t4018/dts-root.ctx
 create mode 100644 t/t4018/elixir-do-not-pick-end.ctx
 create mode 100644 t/t4018/elixir-ex-unit-test.ctx
 create mode 100644 t/t4018/elixir-function.ctx
 create mode 100644 t/t4018/elixir-macro.ctx
 create mode 100644 t/t4018/elixir-module-func.ctx
 create mode 100644 t/t4018/elixir-module.ctx
 create mode 100644 t/t4018/elixir-nested-module.ctx
 create mode 100644 t/t4018/elixir-private-function.ctx
 create mode 100644 t/t4018/elixir-protocol-implementation.ctx
 create mode 100644 t/t4018/elixir-protocol.ctx
 create mode 100644 t/t4018/fortran-block-data.ctx
 create mode 100644 t/t4018/fortran-comment-keyword.ctx
 create mode 100644 t/t4018/fortran-comment-legacy-star.ctx
 create mode 100644 t/t4018/fortran-comment-legacy.ctx
 create mode 100644 t/t4018/fortran-comment.ctx
 create mode 100644 t/t4018/fortran-external-function.ctx
 create mode 100644 t/t4018/fortran-external-subroutine.ctx
 create mode 100644 t/t4018/fortran-module-procedure.ctx
 create mode 100644 t/t4018/fortran-module.ctx
 create mode 100644 t/t4018/fortran-program.ctx
 create mode 100644 t/t4018/fountain-scene.ctx
 create mode 100644 t/t4018/golang-complex-function.ctx
 create mode 100644 t/t4018/golang-func.ctx
 create mode 100644 t/t4018/golang-interface.ctx
 create mode 100644 t/t4018/golang-long-func.ctx
 create mode 100644 t/t4018/golang-struct.ctx
 create mode 100644 t/t4018/java-class-member-function.ctx
 create mode 100644 t/t4018/markdown-heading-indented.ctx
 create mode 100644 t/t4018/markdown-heading-non-headings.ctx
 create mode 100644 t/t4018/matlab-class-definition.ctx
 create mode 100644 t/t4018/matlab-function.ctx
 create mode 100644 t/t4018/matlab-octave-section-1.ctx
 create mode 100644 t/t4018/matlab-octave-section-2.ctx
 create mode 100644 t/t4018/matlab-section.ctx
 create mode 100644 t/t4018/perl-skip-end-of-heredoc.ctx
 create mode 100644 t/t4018/perl-skip-forward-decl.ctx
 create mode 100644 t/t4018/perl-skip-sub-in-pod.ctx
 create mode 100644 t/t4018/perl-sub-definition-kr-brace.ctx
 create mode 100644 t/t4018/perl-sub-definition.ctx
 create mode 100644 t/t4018/php-abstract-class.ctx
 create mode 100644 t/t4018/php-abstract-method.ctx
 create mode 100644 t/t4018/php-class.ctx
 create mode 100644 t/t4018/php-final-class.ctx
 create mode 100644 t/t4018/php-final-method.ctx
 create mode 100644 t/t4018/php-function.ctx
 create mode 100644 t/t4018/php-interface.ctx
 create mode 100644 t/t4018/php-method.ctx
 create mode 100644 t/t4018/php-trait.ctx
 create mode 100644 t/t4018/python-async-def.ctx
 create mode 100644 t/t4018/python-class.ctx
 create mode 100644 t/t4018/python-def.ctx
 create mode 100644 t/t4018/python-indented-async-def.ctx
 create mode 100644 t/t4018/python-indented-class.ctx
 create mode 100644 t/t4018/python-indented-def.ctx
 create mode 100644 t/t4018/rust-fn.ctx
 create mode 100644 t/t4018/rust-impl.ctx
 create mode 100644 t/t4018/rust-macro-rules.ctx
 create mode 100644 t/t4018/rust-struct.ctx
 create mode 100644 t/t4018/rust-trait.ctx

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 5fb5b0a651..d32c38ad1a 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -81,11 +81,12 @@ test_expect_success 'setup hunk header tests' '
 '
 
 # check each individual file
-for i in $(git ls-files)
+for i in $(git ls-files -- ':!*.ctx')
 do
 	test_expect_success "hunk header: $i" "
-		git diff -U1 $i >actual &&
-		grep '@@ .* @@.*RIGHT' actual
+		git diff -U1 $i >diff &&
+		sed -n -e 's/^.*@@\( \|$\)//p' <diff >ctx &&
+		test_cmp $i.ctx ctx
 	"
 done
 
diff --git a/t/t4018/README b/t/t4018/README
index 2d25b2b4fc..2cccf8c950 100644
--- a/t/t4018/README
+++ b/t/t4018/README
@@ -1,15 +1,15 @@
-How to write RIGHT test cases
-=============================
+How to write test cases
+=======================
+
+Create test cases called "LANG-whatever" in this directory, where
+"LANG" is e.g. the userdiff driver name, where "whatever" is a brief
+description of the test.
 
 Insert the word "ChangeMe" (exactly this form) at a distance of
 at least two lines from the line that must appear in the hunk header.
 
-The text that must appear in the hunk header must contain the word
-"right", but in all upper-case, like in the title above.
-
-This text is a bit twisted and out of order, but it is itself a
-test case for the default hunk header pattern. Know what you are doing
-if you change it.
-
-BTW, this tests that the head line goes to the hunk header, not the line
-of equal signs.
+The text that must appear in the hunk header must contains the word
+"RIGHT" by convention. The "LANG-whatever.ctx" file contains what we
+expect to appear in the hunk header. We munged the start of the line
+to "@@ [...] @@" for ease of not having to hardcode the line numbers
+and offsets.
diff --git a/t/t4018/README.ctx b/t/t4018/README.ctx
new file mode 100644
index 0000000000..cd79384b04
--- /dev/null
+++ b/t/t4018/README.ctx
@@ -0,0 +1 @@
+description of the test.
diff --git a/t/t4018/bash-arithmetic-function.ctx b/t/t4018/bash-arithmetic-function.ctx
new file mode 100644
index 0000000000..811eac7d2f
--- /dev/null
+++ b/t/t4018/bash-arithmetic-function.ctx
@@ -0,0 +1 @@
+RIGHT()
diff --git a/t/t4018/bash-bashism-style-compact.ctx b/t/t4018/bash-bashism-style-compact.ctx
new file mode 100644
index 0000000000..4f8eac48c6
--- /dev/null
+++ b/t/t4018/bash-bashism-style-compact.ctx
@@ -0,0 +1 @@
+function RIGHT {
diff --git a/t/t4018/bash-bashism-style-function.ctx b/t/t4018/bash-bashism-style-function.ctx
new file mode 100644
index 0000000000..4f8eac48c6
--- /dev/null
+++ b/t/t4018/bash-bashism-style-function.ctx
@@ -0,0 +1 @@
+function RIGHT {
diff --git a/t/t4018/bash-bashism-style-whitespace.ctx b/t/t4018/bash-bashism-style-whitespace.ctx
new file mode 100644
index 0000000000..35dbd0220e
--- /dev/null
+++ b/t/t4018/bash-bashism-style-whitespace.ctx
@@ -0,0 +1 @@
+function 	RIGHT 	( 	) 	{
diff --git a/t/t4018/bash-conditional-function.ctx b/t/t4018/bash-conditional-function.ctx
new file mode 100644
index 0000000000..811eac7d2f
--- /dev/null
+++ b/t/t4018/bash-conditional-function.ctx
@@ -0,0 +1 @@
+RIGHT()
diff --git a/t/t4018/bash-missing-parentheses.ctx b/t/t4018/bash-missing-parentheses.ctx
new file mode 100644
index 0000000000..4f8eac48c6
--- /dev/null
+++ b/t/t4018/bash-missing-parentheses.ctx
@@ -0,0 +1 @@
+function RIGHT {
diff --git a/t/t4018/bash-mixed-style-compact.ctx b/t/t4018/bash-mixed-style-compact.ctx
new file mode 100644
index 0000000000..bba11074eb
--- /dev/null
+++ b/t/t4018/bash-mixed-style-compact.ctx
@@ -0,0 +1 @@
+function RIGHT(){
diff --git a/t/t4018/bash-mixed-style-function.ctx b/t/t4018/bash-mixed-style-function.ctx
new file mode 100644
index 0000000000..922b87a4aa
--- /dev/null
+++ b/t/t4018/bash-mixed-style-function.ctx
@@ -0,0 +1 @@
+function RIGHT() {
diff --git a/t/t4018/bash-nested-functions.ctx b/t/t4018/bash-nested-functions.ctx
new file mode 100644
index 0000000000..811eac7d2f
--- /dev/null
+++ b/t/t4018/bash-nested-functions.ctx
@@ -0,0 +1 @@
+RIGHT()
diff --git a/t/t4018/bash-other-characters.ctx b/t/t4018/bash-other-characters.ctx
new file mode 100644
index 0000000000..6a55317fdf
--- /dev/null
+++ b/t/t4018/bash-other-characters.ctx
@@ -0,0 +1 @@
+_RIGHT_0n()
diff --git a/t/t4018/bash-posix-style-compact.ctx b/t/t4018/bash-posix-style-compact.ctx
new file mode 100644
index 0000000000..811eac7d2f
--- /dev/null
+++ b/t/t4018/bash-posix-style-compact.ctx
@@ -0,0 +1 @@
+RIGHT()
diff --git a/t/t4018/bash-posix-style-function.ctx b/t/t4018/bash-posix-style-function.ctx
new file mode 100644
index 0000000000..811eac7d2f
--- /dev/null
+++ b/t/t4018/bash-posix-style-function.ctx
@@ -0,0 +1 @@
+RIGHT()
diff --git a/t/t4018/bash-posix-style-whitespace.ctx b/t/t4018/bash-posix-style-whitespace.ctx
new file mode 100644
index 0000000000..28f8698e14
--- /dev/null
+++ b/t/t4018/bash-posix-style-whitespace.ctx
@@ -0,0 +1 @@
+RIGHT 	( 	)
diff --git a/t/t4018/bash-subshell-function.ctx b/t/t4018/bash-subshell-function.ctx
new file mode 100644
index 0000000000..811eac7d2f
--- /dev/null
+++ b/t/t4018/bash-subshell-function.ctx
@@ -0,0 +1 @@
+RIGHT()
diff --git a/t/t4018/bash-trailing-comment.ctx b/t/t4018/bash-trailing-comment.ctx
new file mode 100644
index 0000000000..811eac7d2f
--- /dev/null
+++ b/t/t4018/bash-trailing-comment.ctx
@@ -0,0 +1 @@
+RIGHT()
diff --git a/t/t4018/cpp-c++-function.ctx b/t/t4018/cpp-c++-function.ctx
new file mode 100644
index 0000000000..337b49dbb3
--- /dev/null
+++ b/t/t4018/cpp-c++-function.ctx
@@ -0,0 +1 @@
+Item RIGHT::DoSomething( Args with_spaces )
diff --git a/t/t4018/cpp-class-constructor-mem-init.ctx b/t/t4018/cpp-class-constructor-mem-init.ctx
new file mode 100644
index 0000000000..6664b8b3d8
--- /dev/null
+++ b/t/t4018/cpp-class-constructor-mem-init.ctx
@@ -0,0 +1 @@
+Item::Item(int RIGHT) :
diff --git a/t/t4018/cpp-class-constructor.ctx b/t/t4018/cpp-class-constructor.ctx
new file mode 100644
index 0000000000..2dcadfc0ba
--- /dev/null
+++ b/t/t4018/cpp-class-constructor.ctx
@@ -0,0 +1 @@
+Item::Item(int RIGHT)
diff --git a/t/t4018/cpp-class-definition-derived.ctx b/t/t4018/cpp-class-definition-derived.ctx
new file mode 100644
index 0000000000..146f0a7b7c
--- /dev/null
+++ b/t/t4018/cpp-class-definition-derived.ctx
@@ -0,0 +1 @@
+class RIGHT :
diff --git a/t/t4018/cpp-class-definition.ctx b/t/t4018/cpp-class-definition.ctx
new file mode 100644
index 0000000000..54bff816d6
--- /dev/null
+++ b/t/t4018/cpp-class-definition.ctx
@@ -0,0 +1 @@
+class RIGHT
diff --git a/t/t4018/cpp-class-destructor.ctx b/t/t4018/cpp-class-destructor.ctx
new file mode 100644
index 0000000000..5390c17cf6
--- /dev/null
+++ b/t/t4018/cpp-class-destructor.ctx
@@ -0,0 +1 @@
+RIGHT::~RIGHT()
diff --git a/t/t4018/cpp-function-returning-global-type.ctx b/t/t4018/cpp-function-returning-global-type.ctx
new file mode 100644
index 0000000000..4dcdde25f4
--- /dev/null
+++ b/t/t4018/cpp-function-returning-global-type.ctx
@@ -0,0 +1 @@
+::Item get::it::RIGHT()
diff --git a/t/t4018/cpp-function-returning-nested.ctx b/t/t4018/cpp-function-returning-nested.ctx
new file mode 100644
index 0000000000..6ef73c8368
--- /dev/null
+++ b/t/t4018/cpp-function-returning-nested.ctx
@@ -0,0 +1 @@
+get::Item get::it::RIGHT()
diff --git a/t/t4018/cpp-function-returning-pointer.ctx b/t/t4018/cpp-function-returning-pointer.ctx
new file mode 100644
index 0000000000..bb0acce5c7
--- /dev/null
+++ b/t/t4018/cpp-function-returning-pointer.ctx
@@ -0,0 +1 @@
+const char *get_it_RIGHT(char *ptr)
diff --git a/t/t4018/cpp-function-returning-reference.ctx b/t/t4018/cpp-function-returning-reference.ctx
new file mode 100644
index 0000000000..76afe381fd
--- /dev/null
+++ b/t/t4018/cpp-function-returning-reference.ctx
@@ -0,0 +1 @@
+string& get::it::RIGHT(char *ptr)
diff --git a/t/t4018/cpp-gnu-style-function.ctx b/t/t4018/cpp-gnu-style-function.ctx
new file mode 100644
index 0000000000..1858287812
--- /dev/null
+++ b/t/t4018/cpp-gnu-style-function.ctx
@@ -0,0 +1 @@
+RIGHT(int arg)
diff --git a/t/t4018/cpp-namespace-definition.ctx b/t/t4018/cpp-namespace-definition.ctx
new file mode 100644
index 0000000000..14c29c4638
--- /dev/null
+++ b/t/t4018/cpp-namespace-definition.ctx
@@ -0,0 +1 @@
+namespace RIGHT
diff --git a/t/t4018/cpp-operator-definition.ctx b/t/t4018/cpp-operator-definition.ctx
new file mode 100644
index 0000000000..5b56778961
--- /dev/null
+++ b/t/t4018/cpp-operator-definition.ctx
@@ -0,0 +1 @@
+Value operator+(Value LEFT, Value RIGHT)
diff --git a/t/t4018/cpp-skip-access-specifiers.ctx b/t/t4018/cpp-skip-access-specifiers.ctx
new file mode 100644
index 0000000000..075bcd883b
--- /dev/null
+++ b/t/t4018/cpp-skip-access-specifiers.ctx
@@ -0,0 +1 @@
+class RIGHT : public Baseclass
diff --git a/t/t4018/cpp-skip-comment-block.ctx b/t/t4018/cpp-skip-comment-block.ctx
new file mode 100644
index 0000000000..656c59893d
--- /dev/null
+++ b/t/t4018/cpp-skip-comment-block.ctx
@@ -0,0 +1 @@
+struct item RIGHT(int i)
diff --git a/t/t4018/cpp-skip-labels.ctx b/t/t4018/cpp-skip-labels.ctx
new file mode 100644
index 0000000000..6b0635f7f7
--- /dev/null
+++ b/t/t4018/cpp-skip-labels.ctx
@@ -0,0 +1 @@
+void RIGHT (void)
diff --git a/t/t4018/cpp-struct-definition.ctx b/t/t4018/cpp-struct-definition.ctx
new file mode 100644
index 0000000000..48ed893279
--- /dev/null
+++ b/t/t4018/cpp-struct-definition.ctx
@@ -0,0 +1 @@
+struct RIGHT {
diff --git a/t/t4018/cpp-struct-single-line.ctx b/t/t4018/cpp-struct-single-line.ctx
new file mode 100644
index 0000000000..e3bc9d5017
--- /dev/null
+++ b/t/t4018/cpp-struct-single-line.ctx
@@ -0,0 +1 @@
+struct RIGHT_iterator_tag {};
diff --git a/t/t4018/cpp-template-function-definition.ctx b/t/t4018/cpp-template-function-definition.ctx
new file mode 100644
index 0000000000..c9da39cf65
--- /dev/null
+++ b/t/t4018/cpp-template-function-definition.ctx
@@ -0,0 +1 @@
+template<class T> int RIGHT(T arg)
diff --git a/t/t4018/cpp-union-definition.ctx b/t/t4018/cpp-union-definition.ctx
new file mode 100644
index 0000000000..2fc7b54fb8
--- /dev/null
+++ b/t/t4018/cpp-union-definition.ctx
@@ -0,0 +1 @@
+union RIGHT {
diff --git a/t/t4018/cpp-void-c-function.ctx b/t/t4018/cpp-void-c-function.ctx
new file mode 100644
index 0000000000..6b0635f7f7
--- /dev/null
+++ b/t/t4018/cpp-void-c-function.ctx
@@ -0,0 +1 @@
+void RIGHT (void)
diff --git a/t/t4018/css-attribute-value-selector.ctx b/t/t4018/css-attribute-value-selector.ctx
new file mode 100644
index 0000000000..7f8956251c
--- /dev/null
+++ b/t/t4018/css-attribute-value-selector.ctx
@@ -0,0 +1 @@
+[class*="RIGHT"] {
diff --git a/t/t4018/css-block-level-@-statements.ctx b/t/t4018/css-block-level-@-statements.ctx
new file mode 100644
index 0000000000..7f5e90468c
--- /dev/null
+++ b/t/t4018/css-block-level-@-statements.ctx
@@ -0,0 +1 @@
+@keyframes RIGHT {
diff --git a/t/t4018/css-brace-in-col-1.ctx b/t/t4018/css-brace-in-col-1.ctx
new file mode 100644
index 0000000000..91a9105c6a
--- /dev/null
+++ b/t/t4018/css-brace-in-col-1.ctx
@@ -0,0 +1 @@
+RIGHT label.control-label
diff --git a/t/t4018/css-class-selector.ctx b/t/t4018/css-class-selector.ctx
new file mode 100644
index 0000000000..ac7367d7f4
--- /dev/null
+++ b/t/t4018/css-class-selector.ctx
@@ -0,0 +1 @@
+.RIGHT {
diff --git a/t/t4018/css-colon-eol.ctx b/t/t4018/css-colon-eol.ctx
new file mode 100644
index 0000000000..b68493b9b0
--- /dev/null
+++ b/t/t4018/css-colon-eol.ctx
@@ -0,0 +1 @@
+RIGHT h1 {
diff --git a/t/t4018/css-colon-selector.ctx b/t/t4018/css-colon-selector.ctx
new file mode 100644
index 0000000000..00b1a5aefe
--- /dev/null
+++ b/t/t4018/css-colon-selector.ctx
@@ -0,0 +1 @@
+RIGHT a:hover {
diff --git a/t/t4018/css-common.ctx b/t/t4018/css-common.ctx
new file mode 100644
index 0000000000..43686b4081
--- /dev/null
+++ b/t/t4018/css-common.ctx
@@ -0,0 +1 @@
+RIGHT label.control-label {
diff --git a/t/t4018/css-id-selector.ctx b/t/t4018/css-id-selector.ctx
new file mode 100644
index 0000000000..ce19f6d8dc
--- /dev/null
+++ b/t/t4018/css-id-selector.ctx
@@ -0,0 +1 @@
+#RIGHT {
diff --git a/t/t4018/css-long-selector-list.ctx b/t/t4018/css-long-selector-list.ctx
new file mode 100644
index 0000000000..bc8d0fb62c
--- /dev/null
+++ b/t/t4018/css-long-selector-list.ctx
@@ -0,0 +1 @@
+div ul#RIGHT {
diff --git a/t/t4018/css-prop-sans-indent.ctx b/t/t4018/css-prop-sans-indent.ctx
new file mode 100644
index 0000000000..cc880b2f44
--- /dev/null
+++ b/t/t4018/css-prop-sans-indent.ctx
@@ -0,0 +1 @@
+RIGHT, label.control-label {
diff --git a/t/t4018/css-root-selector.ctx b/t/t4018/css-root-selector.ctx
new file mode 100644
index 0000000000..3010cded2a
--- /dev/null
+++ b/t/t4018/css-root-selector.ctx
@@ -0,0 +1 @@
+:RIGHT {
diff --git a/t/t4018/css-short-selector-list.ctx b/t/t4018/css-short-selector-list.ctx
new file mode 100644
index 0000000000..9e5d87d126
--- /dev/null
+++ b/t/t4018/css-short-selector-list.ctx
@@ -0,0 +1 @@
+label.control, div ul#RIGHT {
diff --git a/t/t4018/css-trailing-space.ctx b/t/t4018/css-trailing-space.ctx
new file mode 100644
index 0000000000..43686b4081
--- /dev/null
+++ b/t/t4018/css-trailing-space.ctx
@@ -0,0 +1 @@
+RIGHT label.control-label {
diff --git a/t/t4018/custom1-pattern.ctx b/t/t4018/custom1-pattern.ctx
new file mode 100644
index 0000000000..d1609cc9a6
--- /dev/null
+++ b/t/t4018/custom1-pattern.ctx
@@ -0,0 +1 @@
+int special, RIGHT;
diff --git a/t/t4018/custom2-match-to-end-of-line.ctx b/t/t4018/custom2-match-to-end-of-line.ctx
new file mode 100644
index 0000000000..8294c6e49b
--- /dev/null
+++ b/t/t4018/custom2-match-to-end-of-line.ctx
@@ -0,0 +1 @@
+RIGHT_Beer
diff --git a/t/t4018/custom3-alternation-in-pattern.ctx b/t/t4018/custom3-alternation-in-pattern.ctx
new file mode 100644
index 0000000000..2125474b68
--- /dev/null
+++ b/t/t4018/custom3-alternation-in-pattern.ctx
@@ -0,0 +1 @@
+public static void main(String RIGHT[])
diff --git a/t/t4018/dts-labels.ctx b/t/t4018/dts-labels.ctx
new file mode 100644
index 0000000000..48d9373cab
--- /dev/null
+++ b/t/t4018/dts-labels.ctx
@@ -0,0 +1 @@
+label2: RIGHT {
diff --git a/t/t4018/dts-node-unitless.ctx b/t/t4018/dts-node-unitless.ctx
new file mode 100644
index 0000000000..82c8683fa1
--- /dev/null
+++ b/t/t4018/dts-node-unitless.ctx
@@ -0,0 +1 @@
+RIGHT {
diff --git a/t/t4018/dts-nodes-boolean-prop.ctx b/t/t4018/dts-nodes-boolean-prop.ctx
new file mode 100644
index 0000000000..3a0232d55d
--- /dev/null
+++ b/t/t4018/dts-nodes-boolean-prop.ctx
@@ -0,0 +1 @@
+RIGHT@deadf00,4000 {
diff --git a/t/t4018/dts-nodes-comment1.ctx b/t/t4018/dts-nodes-comment1.ctx
new file mode 100644
index 0000000000..ec364600b1
--- /dev/null
+++ b/t/t4018/dts-nodes-comment1.ctx
@@ -0,0 +1 @@
+RIGHT@deadf00,4000 /* &a comment */ {
diff --git a/t/t4018/dts-nodes-comment2.ctx b/t/t4018/dts-nodes-comment2.ctx
new file mode 100644
index 0000000000..75f0d75258
--- /dev/null
+++ b/t/t4018/dts-nodes-comment2.ctx
@@ -0,0 +1 @@
+RIGHT@deadf00,4000 { /* a trailing comment */
diff --git a/t/t4018/dts-nodes-multiline-prop.ctx b/t/t4018/dts-nodes-multiline-prop.ctx
new file mode 100644
index 0000000000..3a0232d55d
--- /dev/null
+++ b/t/t4018/dts-nodes-multiline-prop.ctx
@@ -0,0 +1 @@
+RIGHT@deadf00,4000 {
diff --git a/t/t4018/dts-nodes.ctx b/t/t4018/dts-nodes.ctx
new file mode 100644
index 0000000000..3a0232d55d
--- /dev/null
+++ b/t/t4018/dts-nodes.ctx
@@ -0,0 +1 @@
+RIGHT@deadf00,4000 {
diff --git a/t/t4018/dts-reference.ctx b/t/t4018/dts-reference.ctx
new file mode 100644
index 0000000000..c1e13409ee
--- /dev/null
+++ b/t/t4018/dts-reference.ctx
@@ -0,0 +1 @@
+&RIGHT {
diff --git a/t/t4018/dts-root-comment.ctx b/t/t4018/dts-root-comment.ctx
new file mode 100644
index 0000000000..656053dd42
--- /dev/null
+++ b/t/t4018/dts-root-comment.ctx
@@ -0,0 +1 @@
+/ { RIGHT /* Technically just supposed to be a slash and brace */
diff --git a/t/t4018/dts-root.ctx b/t/t4018/dts-root.ctx
new file mode 100644
index 0000000000..656053dd42
--- /dev/null
+++ b/t/t4018/dts-root.ctx
@@ -0,0 +1 @@
+/ { RIGHT /* Technically just supposed to be a slash and brace */
diff --git a/t/t4018/elixir-do-not-pick-end.ctx b/t/t4018/elixir-do-not-pick-end.ctx
new file mode 100644
index 0000000000..8f28a7a689
--- /dev/null
+++ b/t/t4018/elixir-do-not-pick-end.ctx
@@ -0,0 +1 @@
+defmodule RIGHT do
diff --git a/t/t4018/elixir-ex-unit-test.ctx b/t/t4018/elixir-ex-unit-test.ctx
new file mode 100644
index 0000000000..a55e3de2cc
--- /dev/null
+++ b/t/t4018/elixir-ex-unit-test.ctx
@@ -0,0 +1 @@
+test "RIGHT" do
diff --git a/t/t4018/elixir-function.ctx b/t/t4018/elixir-function.ctx
new file mode 100644
index 0000000000..62aee9c8b1
--- /dev/null
+++ b/t/t4018/elixir-function.ctx
@@ -0,0 +1 @@
+def function(RIGHT, arg) do
diff --git a/t/t4018/elixir-macro.ctx b/t/t4018/elixir-macro.ctx
new file mode 100644
index 0000000000..fc1d3b85e8
--- /dev/null
+++ b/t/t4018/elixir-macro.ctx
@@ -0,0 +1 @@
+defmacro foo(RIGHT) do
diff --git a/t/t4018/elixir-module-func.ctx b/t/t4018/elixir-module-func.ctx
new file mode 100644
index 0000000000..8239214386
--- /dev/null
+++ b/t/t4018/elixir-module-func.ctx
@@ -0,0 +1 @@
+def fun(RIGHT) do
diff --git a/t/t4018/elixir-module.ctx b/t/t4018/elixir-module.ctx
new file mode 100644
index 0000000000..8f28a7a689
--- /dev/null
+++ b/t/t4018/elixir-module.ctx
@@ -0,0 +1 @@
+defmodule RIGHT do
diff --git a/t/t4018/elixir-nested-module.ctx b/t/t4018/elixir-nested-module.ctx
new file mode 100644
index 0000000000..3ffbdd18b1
--- /dev/null
+++ b/t/t4018/elixir-nested-module.ctx
@@ -0,0 +1 @@
+defmodule MyApp.RIGHT do
diff --git a/t/t4018/elixir-private-function.ctx b/t/t4018/elixir-private-function.ctx
new file mode 100644
index 0000000000..1c4eba44f7
--- /dev/null
+++ b/t/t4018/elixir-private-function.ctx
@@ -0,0 +1 @@
+defp function(RIGHT, arg) do
diff --git a/t/t4018/elixir-protocol-implementation.ctx b/t/t4018/elixir-protocol-implementation.ctx
new file mode 100644
index 0000000000..efb758aea6
--- /dev/null
+++ b/t/t4018/elixir-protocol-implementation.ctx
@@ -0,0 +1 @@
+defimpl RIGHT do
diff --git a/t/t4018/elixir-protocol.ctx b/t/t4018/elixir-protocol.ctx
new file mode 100644
index 0000000000..d0204e9f14
--- /dev/null
+++ b/t/t4018/elixir-protocol.ctx
@@ -0,0 +1 @@
+defprotocol RIGHT do
diff --git a/t/t4018/fortran-block-data.ctx b/t/t4018/fortran-block-data.ctx
new file mode 100644
index 0000000000..c3db084ccc
--- /dev/null
+++ b/t/t4018/fortran-block-data.ctx
@@ -0,0 +1 @@
+BLOCK DATA RIGHT
diff --git a/t/t4018/fortran-comment-keyword.ctx b/t/t4018/fortran-comment-keyword.ctx
new file mode 100644
index 0000000000..0b9220b355
--- /dev/null
+++ b/t/t4018/fortran-comment-keyword.ctx
@@ -0,0 +1 @@
+subroutine RIGHT (funcA, funcB)
diff --git a/t/t4018/fortran-comment-legacy-star.ctx b/t/t4018/fortran-comment-legacy-star.ctx
new file mode 100644
index 0000000000..6a34203f80
--- /dev/null
+++ b/t/t4018/fortran-comment-legacy-star.ctx
@@ -0,0 +1 @@
+subroutine RIGHT
diff --git a/t/t4018/fortran-comment-legacy.ctx b/t/t4018/fortran-comment-legacy.ctx
new file mode 100644
index 0000000000..6a34203f80
--- /dev/null
+++ b/t/t4018/fortran-comment-legacy.ctx
@@ -0,0 +1 @@
+subroutine RIGHT
diff --git a/t/t4018/fortran-comment.ctx b/t/t4018/fortran-comment.ctx
new file mode 100644
index 0000000000..6a34203f80
--- /dev/null
+++ b/t/t4018/fortran-comment.ctx
@@ -0,0 +1 @@
+subroutine RIGHT
diff --git a/t/t4018/fortran-external-function.ctx b/t/t4018/fortran-external-function.ctx
new file mode 100644
index 0000000000..56ec4d8eca
--- /dev/null
+++ b/t/t4018/fortran-external-function.ctx
@@ -0,0 +1 @@
+function RIGHT(a, b) result(c)
diff --git a/t/t4018/fortran-external-subroutine.ctx b/t/t4018/fortran-external-subroutine.ctx
new file mode 100644
index 0000000000..6a34203f80
--- /dev/null
+++ b/t/t4018/fortran-external-subroutine.ctx
@@ -0,0 +1 @@
+subroutine RIGHT
diff --git a/t/t4018/fortran-module-procedure.ctx b/t/t4018/fortran-module-procedure.ctx
new file mode 100644
index 0000000000..4f5ff2e4b8
--- /dev/null
+++ b/t/t4018/fortran-module-procedure.ctx
@@ -0,0 +1 @@
+module RIGHT
diff --git a/t/t4018/fortran-module.ctx b/t/t4018/fortran-module.ctx
new file mode 100644
index 0000000000..4f5ff2e4b8
--- /dev/null
+++ b/t/t4018/fortran-module.ctx
@@ -0,0 +1 @@
+module RIGHT
diff --git a/t/t4018/fortran-program.ctx b/t/t4018/fortran-program.ctx
new file mode 100644
index 0000000000..c4e844df30
--- /dev/null
+++ b/t/t4018/fortran-program.ctx
@@ -0,0 +1 @@
+program RIGHT
diff --git a/t/t4018/fountain-scene.ctx b/t/t4018/fountain-scene.ctx
new file mode 100644
index 0000000000..bf10171418
--- /dev/null
+++ b/t/t4018/fountain-scene.ctx
@@ -0,0 +1 @@
+EXT. STREET RIGHT OUTSIDE - DAY
diff --git a/t/t4018/golang-complex-function.ctx b/t/t4018/golang-complex-function.ctx
new file mode 100644
index 0000000000..8e8d5582ff
--- /dev/null
+++ b/t/t4018/golang-complex-function.ctx
@@ -0,0 +1 @@
+func (t *Test) RIGHT(a Type) (Type, error) {
diff --git a/t/t4018/golang-func.ctx b/t/t4018/golang-func.ctx
new file mode 100644
index 0000000000..88bc823813
--- /dev/null
+++ b/t/t4018/golang-func.ctx
@@ -0,0 +1 @@
+func RIGHT() {
diff --git a/t/t4018/golang-interface.ctx b/t/t4018/golang-interface.ctx
new file mode 100644
index 0000000000..2d07f5a383
--- /dev/null
+++ b/t/t4018/golang-interface.ctx
@@ -0,0 +1 @@
+type RIGHT interface {
diff --git a/t/t4018/golang-long-func.ctx b/t/t4018/golang-long-func.ctx
new file mode 100644
index 0000000000..25635e712e
--- /dev/null
+++ b/t/t4018/golang-long-func.ctx
@@ -0,0 +1 @@
+func RIGHT(aVeryVeryVeryLongVariableName AVeryVeryVeryLongType,
diff --git a/t/t4018/golang-struct.ctx b/t/t4018/golang-struct.ctx
new file mode 100644
index 0000000000..8a1240699d
--- /dev/null
+++ b/t/t4018/golang-struct.ctx
@@ -0,0 +1 @@
+type RIGHT struct {
diff --git a/t/t4018/java-class-member-function.ctx b/t/t4018/java-class-member-function.ctx
new file mode 100644
index 0000000000..2125474b68
--- /dev/null
+++ b/t/t4018/java-class-member-function.ctx
@@ -0,0 +1 @@
+public static void main(String RIGHT[])
diff --git a/t/t4018/markdown-heading-indented.ctx b/t/t4018/markdown-heading-indented.ctx
new file mode 100644
index 0000000000..5938336743
--- /dev/null
+++ b/t/t4018/markdown-heading-indented.ctx
@@ -0,0 +1 @@
+   ### RIGHT
diff --git a/t/t4018/markdown-heading-non-headings.ctx b/t/t4018/markdown-heading-non-headings.ctx
new file mode 100644
index 0000000000..7e2165be6e
--- /dev/null
+++ b/t/t4018/markdown-heading-non-headings.ctx
@@ -0,0 +1 @@
+# RIGHT
diff --git a/t/t4018/matlab-class-definition.ctx b/t/t4018/matlab-class-definition.ctx
new file mode 100644
index 0000000000..5dd5b45628
--- /dev/null
+++ b/t/t4018/matlab-class-definition.ctx
@@ -0,0 +1 @@
+classdef RIGHT
diff --git a/t/t4018/matlab-function.ctx b/t/t4018/matlab-function.ctx
new file mode 100644
index 0000000000..72d2350b13
--- /dev/null
+++ b/t/t4018/matlab-function.ctx
@@ -0,0 +1 @@
+function y = RIGHT()
diff --git a/t/t4018/matlab-octave-section-1.ctx b/t/t4018/matlab-octave-section-1.ctx
new file mode 100644
index 0000000000..ca9b349f94
--- /dev/null
+++ b/t/t4018/matlab-octave-section-1.ctx
@@ -0,0 +1 @@
+%%% RIGHT section
diff --git a/t/t4018/matlab-octave-section-2.ctx b/t/t4018/matlab-octave-section-2.ctx
new file mode 100644
index 0000000000..5cbb77faf5
--- /dev/null
+++ b/t/t4018/matlab-octave-section-2.ctx
@@ -0,0 +1 @@
+## RIGHT section
diff --git a/t/t4018/matlab-section.ctx b/t/t4018/matlab-section.ctx
new file mode 100644
index 0000000000..e83fee6f4d
--- /dev/null
+++ b/t/t4018/matlab-section.ctx
@@ -0,0 +1 @@
+%% RIGHT section
diff --git a/t/t4018/perl-skip-end-of-heredoc.ctx b/t/t4018/perl-skip-end-of-heredoc.ctx
new file mode 100644
index 0000000000..c15f4b78bd
--- /dev/null
+++ b/t/t4018/perl-skip-end-of-heredoc.ctx
@@ -0,0 +1 @@
+sub RIGHTwithheredocument {
diff --git a/t/t4018/perl-skip-forward-decl.ctx b/t/t4018/perl-skip-forward-decl.ctx
new file mode 100644
index 0000000000..e0c51599ad
--- /dev/null
+++ b/t/t4018/perl-skip-forward-decl.ctx
@@ -0,0 +1 @@
+package RIGHT;
diff --git a/t/t4018/perl-skip-sub-in-pod.ctx b/t/t4018/perl-skip-sub-in-pod.ctx
new file mode 100644
index 0000000000..abddd76655
--- /dev/null
+++ b/t/t4018/perl-skip-sub-in-pod.ctx
@@ -0,0 +1 @@
+=head1 SYNOPSIS_RIGHT
diff --git a/t/t4018/perl-sub-definition-kr-brace.ctx b/t/t4018/perl-sub-definition-kr-brace.ctx
new file mode 100644
index 0000000000..7e5aee5cde
--- /dev/null
+++ b/t/t4018/perl-sub-definition-kr-brace.ctx
@@ -0,0 +1 @@
+sub RIGHT
diff --git a/t/t4018/perl-sub-definition.ctx b/t/t4018/perl-sub-definition.ctx
new file mode 100644
index 0000000000..d49a63598e
--- /dev/null
+++ b/t/t4018/perl-sub-definition.ctx
@@ -0,0 +1 @@
+sub RIGHT {
diff --git a/t/t4018/php-abstract-class.ctx b/t/t4018/php-abstract-class.ctx
new file mode 100644
index 0000000000..f572d2129b
--- /dev/null
+++ b/t/t4018/php-abstract-class.ctx
@@ -0,0 +1 @@
+abstract class RIGHT
diff --git a/t/t4018/php-abstract-method.ctx b/t/t4018/php-abstract-method.ctx
new file mode 100644
index 0000000000..14cb6df42e
--- /dev/null
+++ b/t/t4018/php-abstract-method.ctx
@@ -0,0 +1 @@
+abstract public function RIGHT(): ?string
diff --git a/t/t4018/php-class.ctx b/t/t4018/php-class.ctx
new file mode 100644
index 0000000000..54bff816d6
--- /dev/null
+++ b/t/t4018/php-class.ctx
@@ -0,0 +1 @@
+class RIGHT
diff --git a/t/t4018/php-final-class.ctx b/t/t4018/php-final-class.ctx
new file mode 100644
index 0000000000..4d59fb749b
--- /dev/null
+++ b/t/t4018/php-final-class.ctx
@@ -0,0 +1 @@
+final class RIGHT
diff --git a/t/t4018/php-final-method.ctx b/t/t4018/php-final-method.ctx
new file mode 100644
index 0000000000..b7da8f8082
--- /dev/null
+++ b/t/t4018/php-final-method.ctx
@@ -0,0 +1 @@
+final public function RIGHT(): string
diff --git a/t/t4018/php-function.ctx b/t/t4018/php-function.ctx
new file mode 100644
index 0000000000..c5f3e55302
--- /dev/null
+++ b/t/t4018/php-function.ctx
@@ -0,0 +1 @@
+function RIGHT()
diff --git a/t/t4018/php-interface.ctx b/t/t4018/php-interface.ctx
new file mode 100644
index 0000000000..a45fa0532a
--- /dev/null
+++ b/t/t4018/php-interface.ctx
@@ -0,0 +1 @@
+interface RIGHT
diff --git a/t/t4018/php-method.ctx b/t/t4018/php-method.ctx
new file mode 100644
index 0000000000..eb1659ff9f
--- /dev/null
+++ b/t/t4018/php-method.ctx
@@ -0,0 +1 @@
+public static function RIGHT()
diff --git a/t/t4018/php-trait.ctx b/t/t4018/php-trait.ctx
new file mode 100644
index 0000000000..57aa4c6267
--- /dev/null
+++ b/t/t4018/php-trait.ctx
@@ -0,0 +1 @@
+trait RIGHT
diff --git a/t/t4018/python-async-def.ctx b/t/t4018/python-async-def.ctx
new file mode 100644
index 0000000000..468c548bbe
--- /dev/null
+++ b/t/t4018/python-async-def.ctx
@@ -0,0 +1 @@
+async def RIGHT(pi: int = 3.14):
diff --git a/t/t4018/python-class.ctx b/t/t4018/python-class.ctx
new file mode 100644
index 0000000000..a40b755e29
--- /dev/null
+++ b/t/t4018/python-class.ctx
@@ -0,0 +1 @@
+class RIGHT(int, str):
diff --git a/t/t4018/python-def.ctx b/t/t4018/python-def.ctx
new file mode 100644
index 0000000000..a1a9cbad63
--- /dev/null
+++ b/t/t4018/python-def.ctx
@@ -0,0 +1 @@
+def RIGHT(pi: int = 3.14):
diff --git a/t/t4018/python-indented-async-def.ctx b/t/t4018/python-indented-async-def.ctx
new file mode 100644
index 0000000000..d393620a1e
--- /dev/null
+++ b/t/t4018/python-indented-async-def.ctx
@@ -0,0 +1 @@
+async def RIGHT(self, x: int):
diff --git a/t/t4018/python-indented-class.ctx b/t/t4018/python-indented-class.ctx
new file mode 100644
index 0000000000..0881c84dba
--- /dev/null
+++ b/t/t4018/python-indented-class.ctx
@@ -0,0 +1 @@
+class RIGHT:
diff --git a/t/t4018/python-indented-def.ctx b/t/t4018/python-indented-def.ctx
new file mode 100644
index 0000000000..6e5a44b391
--- /dev/null
+++ b/t/t4018/python-indented-def.ctx
@@ -0,0 +1 @@
+def RIGHT(self, x: int):
diff --git a/t/t4018/rust-fn.ctx b/t/t4018/rust-fn.ctx
new file mode 100644
index 0000000000..baa37cf253
--- /dev/null
+++ b/t/t4018/rust-fn.ctx
@@ -0,0 +1 @@
+pub(self) fn RIGHT<T>(x: &[T]) where T: Debug {
diff --git a/t/t4018/rust-impl.ctx b/t/t4018/rust-impl.ctx
new file mode 100644
index 0000000000..5344c35f3f
--- /dev/null
+++ b/t/t4018/rust-impl.ctx
@@ -0,0 +1 @@
+impl<'a, T: AsRef<[u8]>>  std::RIGHT for Git<'a> {
diff --git a/t/t4018/rust-macro-rules.ctx b/t/t4018/rust-macro-rules.ctx
new file mode 100644
index 0000000000..7520463aa0
--- /dev/null
+++ b/t/t4018/rust-macro-rules.ctx
@@ -0,0 +1 @@
+macro_rules! RIGHT {
diff --git a/t/t4018/rust-struct.ctx b/t/t4018/rust-struct.ctx
new file mode 100644
index 0000000000..c1e09dc808
--- /dev/null
+++ b/t/t4018/rust-struct.ctx
@@ -0,0 +1 @@
+pub(super) struct RIGHT<'a> {
diff --git a/t/t4018/rust-trait.ctx b/t/t4018/rust-trait.ctx
new file mode 100644
index 0000000000..6af803db29
--- /dev/null
+++ b/t/t4018/rust-trait.ctx
@@ -0,0 +1 @@
+unsafe trait RIGHT<T> {
-- 
2.30.0.284.gd98b1dd5eaa7

