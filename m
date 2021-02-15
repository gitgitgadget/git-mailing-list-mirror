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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59C4C433E0
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 00:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E6C764E27
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 00:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhBOAyl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 19:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbhBOAyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 19:54:25 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EEAC061797
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 16:53:09 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id b3so7163202wrj.5
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 16:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sDQWtdsqgVP1xzGMMHIVLBQnHWWFVNNWVvtxfSvgY9I=;
        b=euY04mrbJncKl/qZs/phTOAycw3nkuXp4qqKTwrW1Wb4tEH7hbVJwJYw4a2+KGyahx
         kEeLJvLpADXcLeaRpyUHJTErgnfbd6/IDlNbXTVauZks1jy5Mm3r+FZGOql20tIgJlLw
         WMMnt3YGqcP0EgEYo5YSE82YqbFHtoGdYqIFl7PnBDDzutLW89Wjkq/d3tlZGk9sAo5p
         48cIZwpvS+UmwhdbNymYM4q0W15FBw3t7qmOv/2AIyaVIhEreqmlUveLI6wGrPO8NfdB
         5ZRY4nw2YlApJO45T0c+C/FJFCOI4M7FtBTfB8gFXmAqpHhcqYRbDPmAunlQIPwQkmj6
         e25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sDQWtdsqgVP1xzGMMHIVLBQnHWWFVNNWVvtxfSvgY9I=;
        b=JqFU79SO+RkPnEFV645H/X6AkO8KjymuwSskl5rxADu0Sz/MvgnINp+3+xc8gZCHeM
         g0l7N+vRyR2Am6jdV04lUQHWxG6wEGniV69IVRYhknbvQRTTvwQKMa7gZz32JhrrDeKL
         /Kl3kXQxqHss4fWno+OQOwMFzJSmjqs9ZpbTB2yM2UNk0DIBq2qeoNw5imPRW8wf/foI
         xGsH+tYwSj3rPnLEU4KCDnR3ly/THrhBWNgKbDkunANIGjtwYZyGvf+kIyU6RKNJNkwd
         qVIYi6MJx0oCWNHd2KAkqPmLyHwOq3XAZJGxL7SmQ6iFKKSIUegtWWqIKV+vD6JuPQsK
         Cbyw==
X-Gm-Message-State: AOAM5333yL1HY+bpH3nhEQ5iEjSgNK6mQN967Y4z0Pb7ETNagd5+ZumP
        ggOyUFd/qPOSzcftlAbdTw/YI3ilXqkIWQ==
X-Google-Smtp-Source: ABdhPJzH30SmzT7zAq+wD5mCJMwEiciDtCI8qiIQRWuQFo0mH4mxcFU20hFPctes1++xKXfbDl8qIA==
X-Received: by 2002:a5d:6d06:: with SMTP id e6mr16146104wrq.425.1613350385822;
        Sun, 14 Feb 2021 16:53:05 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 3sm5209832wmi.2.2021.02.14.16.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 16:53:05 -0800 (PST)
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
Subject: [PATCH 08/20] userdiff tests: rewrite hunk header test infrastructure
Date:   Mon, 15 Feb 2021 01:52:24 +0100
Message-Id: <20210215005236.11313-9-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <87tuqebj6m.fsf@evledraar.gmail.com>
References: <87tuqebj6m.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rewrite the hunk header test infrastructure introduced in
bfa7d01413 (t4018: an infrastructure to test hunk headers,
2014-03-21). See c228a5c077 (Merge branch 'js/userdiff-cc',
2014-03-31) for the whole series that commit was part of.

As noted in an earlier commit that change introduced the regression of
not testing for the full hunk line, but just whether "RIGHT" appeared
on it[1]. A preceding commit fixed that specific issue, but we were
still left with the inflexibility of the approach described in the
now-deleted t/t4018/README.

I.e. to add any sort of new tests that used the existing test data
we'd either need to add more files like the recently added (but now
deleted) *.ctx) files, using the filesystem as our test datastructure,
or introduce more parsing for the custom file format we were growing
here.

Let's instead just move this over to using a custom test
function. This makes it trivial to add new tests by adding new
optional parameters to the function. Let's still keep the relevant
files in the "t/t4018/" subdirectory instead of adding ~1.5k
lines (and growing) to "t/t4018-diff-funcname.sh"

If this diff is viewed with "--color-moved=plain" we can see that
there's no changes to the lines being moved into the new *.sh files,
i.e. all the deletions are moves. I'm just adding boilerplate around
those existing lines.

The one-off refactoring was performed by an ad-hoc shellscript [2].

1. https://lore.kernel.org/git/87wnvbbf2y.fsf@evledraar.gmail.com/
2.
	#!/bin/sh
	set -ex

	git rm README*
	for t in $(git ls-files ':!*.ctx')
	do
		lang=$(echo $t | sed 's/-.*//')
		desc=$(echo $t | sed -E 's/^[^-]*-//' | tr - " ")

		if ! test -e $lang.sh
		then
			cat >$lang.sh <<-EOF
			#!/bin/sh
			#
			# See ../t4018-diff-funcname.sh's test_diff_funcname()
			#

			EOF
		else
			echo >>$lang.sh
	        fi

		(
	            printf "test_diff_funcname '%s: %s' \\" "$lang" "$desc"
	            echo
	            printf "\t8<<%sEOF_HUNK 9<<%sEOF_TEST\n" '\' '\'
	            cat $t.ctx
	            printf "EOF_HUNK\n"
	            cat $t
	            printf "EOF_TEST\n"
		) >>$lang.sh

		chmod +x $lang.sh
		git add $lang.sh
	        git rm $t $t.ctx
	done

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4018-diff-funcname.sh                      |  59 +++--
 t/t4018/README                                |  15 --
 t/t4018/README.ctx                            |   1 -
 t/t4018/bash-arithmetic-function              |   4 -
 t/t4018/bash-arithmetic-function.ctx          |   1 -
 t/t4018/bash-bashism-style-compact            |   6 -
 t/t4018/bash-bashism-style-compact.ctx        |   1 -
 t/t4018/bash-bashism-style-function           |   4 -
 t/t4018/bash-bashism-style-function.ctx       |   1 -
 t/t4018/bash-bashism-style-whitespace         |   4 -
 t/t4018/bash-bashism-style-whitespace.ctx     |   1 -
 t/t4018/bash-conditional-function             |   4 -
 t/t4018/bash-conditional-function.ctx         |   1 -
 t/t4018/bash-missing-parentheses              |   6 -
 t/t4018/bash-missing-parentheses.ctx          |   1 -
 t/t4018/bash-mixed-style-compact              |   4 -
 t/t4018/bash-mixed-style-compact.ctx          |   1 -
 t/t4018/bash-mixed-style-function             |   4 -
 t/t4018/bash-mixed-style-function.ctx         |   1 -
 t/t4018/bash-nested-functions                 |   6 -
 t/t4018/bash-nested-functions.ctx             |   1 -
 t/t4018/bash-other-characters                 |   4 -
 t/t4018/bash-other-characters.ctx             |   1 -
 t/t4018/bash-posix-style-compact              |   4 -
 t/t4018/bash-posix-style-compact.ctx          |   1 -
 t/t4018/bash-posix-style-function             |   4 -
 t/t4018/bash-posix-style-function.ctx         |   1 -
 t/t4018/bash-posix-style-whitespace           |   4 -
 t/t4018/bash-posix-style-whitespace.ctx       |   1 -
 t/t4018/bash-subshell-function                |   4 -
 t/t4018/bash-subshell-function.ctx            |   1 -
 t/t4018/bash-trailing-comment                 |   4 -
 t/t4018/bash-trailing-comment.ctx             |   1 -
 t/t4018/bash.sh                               | 160 ++++++++++++
 t/t4018/cpp-c++-function                      |   4 -
 t/t4018/cpp-c++-function.ctx                  |   1 -
 t/t4018/cpp-class-constructor                 |   4 -
 t/t4018/cpp-class-constructor-mem-init        |   5 -
 t/t4018/cpp-class-constructor-mem-init.ctx    |   1 -
 t/t4018/cpp-class-constructor.ctx             |   1 -
 t/t4018/cpp-class-definition                  |   4 -
 t/t4018/cpp-class-definition-derived          |   5 -
 t/t4018/cpp-class-definition-derived.ctx      |   1 -
 t/t4018/cpp-class-definition.ctx              |   1 -
 t/t4018/cpp-class-destructor                  |   4 -
 t/t4018/cpp-class-destructor.ctx              |   1 -
 t/t4018/cpp-function-returning-global-type    |   4 -
 .../cpp-function-returning-global-type.ctx    |   1 -
 t/t4018/cpp-function-returning-nested         |   5 -
 t/t4018/cpp-function-returning-nested.ctx     |   1 -
 t/t4018/cpp-function-returning-pointer        |   4 -
 t/t4018/cpp-function-returning-pointer.ctx    |   1 -
 t/t4018/cpp-function-returning-reference      |   4 -
 t/t4018/cpp-function-returning-reference.ctx  |   1 -
 t/t4018/cpp-gnu-style-function                |   5 -
 t/t4018/cpp-gnu-style-function.ctx            |   1 -
 t/t4018/cpp-namespace-definition              |   4 -
 t/t4018/cpp-namespace-definition.ctx          |   1 -
 t/t4018/cpp-operator-definition               |   4 -
 t/t4018/cpp-operator-definition.ctx           |   1 -
 t/t4018/cpp-skip-access-specifiers            |   8 -
 t/t4018/cpp-skip-access-specifiers.ctx        |   1 -
 t/t4018/cpp-skip-comment-block                |   9 -
 t/t4018/cpp-skip-comment-block.ctx            |   1 -
 t/t4018/cpp-skip-labels                       |   8 -
 t/t4018/cpp-skip-labels.ctx                   |   1 -
 t/t4018/cpp-struct-definition                 |   9 -
 t/t4018/cpp-struct-definition.ctx             |   1 -
 t/t4018/cpp-struct-single-line                |   7 -
 t/t4018/cpp-struct-single-line.ctx            |   1 -
 t/t4018/cpp-template-function-definition      |   4 -
 t/t4018/cpp-template-function-definition.ctx  |   1 -
 t/t4018/cpp-union-definition                  |   4 -
 t/t4018/cpp-union-definition.ctx              |   1 -
 t/t4018/cpp-void-c-function                   |   4 -
 t/t4018/cpp-void-c-function.ctx               |   1 -
 t/t4018/cpp.sh                                | 239 ++++++++++++++++++
 t/t4018/css-attribute-value-selector          |   4 -
 t/t4018/css-attribute-value-selector.ctx      |   1 -
 t/t4018/css-block-level-@-statements          |  10 -
 t/t4018/css-block-level-@-statements.ctx      |   1 -
 t/t4018/css-brace-in-col-1                    |   5 -
 t/t4018/css-brace-in-col-1.ctx                |   1 -
 t/t4018/css-class-selector                    |   4 -
 t/t4018/css-class-selector.ctx                |   1 -
 t/t4018/css-colon-eol                         |   4 -
 t/t4018/css-colon-eol.ctx                     |   1 -
 t/t4018/css-colon-selector                    |   5 -
 t/t4018/css-colon-selector.ctx                |   1 -
 t/t4018/css-common                            |   4 -
 t/t4018/css-common.ctx                        |   1 -
 t/t4018/css-id-selector                       |   4 -
 t/t4018/css-id-selector.ctx                   |   1 -
 t/t4018/css-long-selector-list                |   6 -
 t/t4018/css-long-selector-list.ctx            |   1 -
 t/t4018/css-prop-sans-indent                  |   5 -
 t/t4018/css-prop-sans-indent.ctx              |   1 -
 t/t4018/css-root-selector                     |   4 -
 t/t4018/css-root-selector.ctx                 |   1 -
 t/t4018/css-short-selector-list               |   4 -
 t/t4018/css-short-selector-list.ctx           |   1 -
 t/t4018/css-trailing-space                    |   5 -
 t/t4018/css-trailing-space.ctx                |   1 -
 t/t4018/css.sh                                | 146 +++++++++++
 t/t4018/custom1-pattern.ctx                   |   1 -
 t/t4018/{custom1-pattern => custom1.sh}       |  10 +
 t/t4018/custom2-match-to-end-of-line          |   8 -
 t/t4018/custom2-match-to-end-of-line.ctx      |   1 -
 t/t4018/custom2.sh                            |  18 ++
 t/t4018/custom3-alternation-in-pattern.ctx    |   1 -
 ...tom3-alternation-in-pattern => custom3.sh} |  10 +
 t/t4018/dts-labels                            |   9 -
 t/t4018/dts-labels.ctx                        |   1 -
 t/t4018/dts-node-unitless                     |   8 -
 t/t4018/dts-node-unitless.ctx                 |   1 -
 t/t4018/dts-nodes                             |   8 -
 t/t4018/dts-nodes-boolean-prop                |   9 -
 t/t4018/dts-nodes-boolean-prop.ctx            |   1 -
 t/t4018/dts-nodes-comment1                    |   8 -
 t/t4018/dts-nodes-comment1.ctx                |   1 -
 t/t4018/dts-nodes-comment2                    |   8 -
 t/t4018/dts-nodes-comment2.ctx                |   1 -
 t/t4018/dts-nodes-multiline-prop              |  13 -
 t/t4018/dts-nodes-multiline-prop.ctx          |   1 -
 t/t4018/dts-nodes.ctx                         |   1 -
 t/t4018/dts-reference                         |   9 -
 t/t4018/dts-reference.ctx                     |   1 -
 t/t4018/dts-root                              |   5 -
 t/t4018/dts-root-comment                      |   8 -
 t/t4018/dts-root-comment.ctx                  |   1 -
 t/t4018/dts-root.ctx                          |   1 -
 t/t4018/dts.sh                                | 149 +++++++++++
 t/t4018/elixir-do-not-pick-end                |   5 -
 t/t4018/elixir-do-not-pick-end.ctx            |   1 -
 t/t4018/elixir-ex-unit-test                   |   6 -
 t/t4018/elixir-ex-unit-test.ctx               |   1 -
 t/t4018/elixir-function                       |   5 -
 t/t4018/elixir-function.ctx                   |   1 -
 t/t4018/elixir-macro                          |   5 -
 t/t4018/elixir-macro.ctx                      |   1 -
 t/t4018/elixir-module                         |   9 -
 t/t4018/elixir-module-func                    |   8 -
 t/t4018/elixir-module-func.ctx                |   1 -
 t/t4018/elixir-module.ctx                     |   1 -
 t/t4018/elixir-nested-module                  |   9 -
 t/t4018/elixir-nested-module.ctx              |   1 -
 t/t4018/elixir-private-function               |   5 -
 t/t4018/elixir-private-function.ctx           |   1 -
 t/t4018/elixir-protocol                       |   6 -
 t/t4018/elixir-protocol-implementation        |   5 -
 t/t4018/elixir-protocol-implementation.ctx    |   1 -
 t/t4018/elixir-protocol.ctx                   |   1 -
 t/t4018/elixir.sh                             | 127 ++++++++++
 t/t4018/fortran-block-data                    |   5 -
 t/t4018/fortran-block-data.ctx                |   1 -
 t/t4018/fortran-comment                       |  13 -
 t/t4018/fortran-comment-keyword               |  14 -
 t/t4018/fortran-comment-keyword.ctx           |   1 -
 t/t4018/fortran-comment-legacy                |  13 -
 t/t4018/fortran-comment-legacy-star           |  13 -
 t/t4018/fortran-comment-legacy-star.ctx       |   1 -
 t/t4018/fortran-comment-legacy.ctx            |   1 -
 t/t4018/fortran-comment.ctx                   |   1 -
 t/t4018/fortran-external-function             |   9 -
 t/t4018/fortran-external-function.ctx         |   1 -
 t/t4018/fortran-external-subroutine           |   5 -
 t/t4018/fortran-external-subroutine.ctx       |   1 -
 t/t4018/fortran-module                        |   5 -
 t/t4018/fortran-module-procedure              |  13 -
 t/t4018/fortran-module-procedure.ctx          |   1 -
 t/t4018/fortran-module.ctx                    |   1 -
 t/t4018/fortran-program                       |   5 -
 t/t4018/fortran-program.ctx                   |   1 -
 t/t4018/fortran.sh                            | 159 ++++++++++++
 t/t4018/fountain-scene                        |   4 -
 t/t4018/fountain-scene.ctx                    |   1 -
 t/t4018/fountain.sh                           |  14 +
 t/t4018/golang-complex-function               |   8 -
 t/t4018/golang-complex-function.ctx           |   1 -
 t/t4018/golang-func                           |   4 -
 t/t4018/golang-func.ctx                       |   1 -
 t/t4018/golang-interface                      |   4 -
 t/t4018/golang-interface.ctx                  |   1 -
 t/t4018/golang-long-func                      |   5 -
 t/t4018/golang-long-func.ctx                  |   1 -
 t/t4018/golang-struct                         |   4 -
 t/t4018/golang-struct.ctx                     |   1 -
 t/t4018/golang.sh                             |  59 +++++
 t/t4018/java-class-member-function            |   8 -
 t/t4018/java-class-member-function.ctx        |   1 -
 t/t4018/java.sh                               |  18 ++
 t/t4018/markdown-heading-indented             |   6 -
 t/t4018/markdown-heading-indented.ctx         |   1 -
 t/t4018/markdown-heading-non-headings         |  17 --
 t/t4018/markdown-heading-non-headings.ctx     |   1 -
 t/t4018/markdown.sh                           |  39 +++
 t/t4018/matlab-class-definition               |   5 -
 t/t4018/matlab-class-definition.ctx           |   1 -
 t/t4018/matlab-function                       |   4 -
 t/t4018/matlab-function.ctx                   |   1 -
 t/t4018/matlab-octave-section-1               |   3 -
 t/t4018/matlab-octave-section-1.ctx           |   1 -
 t/t4018/matlab-octave-section-2               |   3 -
 t/t4018/matlab-octave-section-2.ctx           |   1 -
 t/t4018/matlab-section                        |   3 -
 t/t4018/matlab-section.ctx                    |   1 -
 t/t4018/matlab.sh                             |  52 ++++
 t/t4018/perl-skip-end-of-heredoc              |   8 -
 t/t4018/perl-skip-end-of-heredoc.ctx          |   1 -
 t/t4018/perl-skip-forward-decl                |  10 -
 t/t4018/perl-skip-forward-decl.ctx            |   1 -
 t/t4018/perl-skip-sub-in-pod                  |  18 --
 t/t4018/perl-skip-sub-in-pod.ctx              |   1 -
 t/t4018/perl-sub-definition                   |   4 -
 t/t4018/perl-sub-definition-kr-brace          |   4 -
 t/t4018/perl-sub-definition-kr-brace.ctx      |   1 -
 t/t4018/perl-sub-definition.ctx               |   1 -
 t/t4018/perl.sh                               |  78 ++++++
 t/t4018/php-abstract-class                    |   4 -
 t/t4018/php-abstract-class.ctx                |   1 -
 t/t4018/php-abstract-method                   |   7 -
 t/t4018/php-abstract-method.ctx               |   1 -
 t/t4018/php-class                             |   4 -
 t/t4018/php-class.ctx                         |   1 -
 t/t4018/php-final-class                       |   4 -
 t/t4018/php-final-class.ctx                   |   1 -
 t/t4018/php-final-method                      |   7 -
 t/t4018/php-final-method.ctx                  |   1 -
 t/t4018/php-function                          |   4 -
 t/t4018/php-function.ctx                      |   1 -
 t/t4018/php-interface                         |   4 -
 t/t4018/php-interface.ctx                     |   1 -
 t/t4018/php-method                            |   7 -
 t/t4018/php-method.ctx                        |   1 -
 t/t4018/php-trait                             |   7 -
 t/t4018/php-trait.ctx                         |   1 -
 t/t4018/php.sh                                | 106 ++++++++
 t/t4018/python-async-def                      |   4 -
 t/t4018/python-async-def.ctx                  |   1 -
 t/t4018/python-class                          |   4 -
 t/t4018/python-class.ctx                      |   1 -
 t/t4018/python-def                            |   4 -
 t/t4018/python-def.ctx                        |   1 -
 t/t4018/python-indented-async-def             |   7 -
 t/t4018/python-indented-async-def.ctx         |   1 -
 t/t4018/python-indented-class                 |   5 -
 t/t4018/python-indented-class.ctx             |   1 -
 t/t4018/python-indented-def                   |   7 -
 t/t4018/python-indented-def.ctx               |   1 -
 t/t4018/python.sh                             |  71 ++++++
 t/t4018/rust-fn                               |   5 -
 t/t4018/rust-fn.ctx                           |   1 -
 t/t4018/rust-impl                             |   5 -
 t/t4018/rust-impl.ctx                         |   1 -
 t/t4018/rust-macro-rules                      |   6 -
 t/t4018/rust-macro-rules.ctx                  |   1 -
 t/t4018/rust-struct                           |   5 -
 t/t4018/rust-struct.ctx                       |   1 -
 t/t4018/rust-trait                            |   5 -
 t/t4018/rust-trait.ctx                        |   1 -
 t/t4018/rust.sh                               |  60 +++++
 261 files changed, 1549 insertions(+), 879 deletions(-)
 delete mode 100644 t/t4018/README
 delete mode 100644 t/t4018/README.ctx
 delete mode 100644 t/t4018/bash-arithmetic-function
 delete mode 100644 t/t4018/bash-arithmetic-function.ctx
 delete mode 100644 t/t4018/bash-bashism-style-compact
 delete mode 100644 t/t4018/bash-bashism-style-compact.ctx
 delete mode 100644 t/t4018/bash-bashism-style-function
 delete mode 100644 t/t4018/bash-bashism-style-function.ctx
 delete mode 100644 t/t4018/bash-bashism-style-whitespace
 delete mode 100644 t/t4018/bash-bashism-style-whitespace.ctx
 delete mode 100644 t/t4018/bash-conditional-function
 delete mode 100644 t/t4018/bash-conditional-function.ctx
 delete mode 100644 t/t4018/bash-missing-parentheses
 delete mode 100644 t/t4018/bash-missing-parentheses.ctx
 delete mode 100644 t/t4018/bash-mixed-style-compact
 delete mode 100644 t/t4018/bash-mixed-style-compact.ctx
 delete mode 100644 t/t4018/bash-mixed-style-function
 delete mode 100644 t/t4018/bash-mixed-style-function.ctx
 delete mode 100644 t/t4018/bash-nested-functions
 delete mode 100644 t/t4018/bash-nested-functions.ctx
 delete mode 100644 t/t4018/bash-other-characters
 delete mode 100644 t/t4018/bash-other-characters.ctx
 delete mode 100644 t/t4018/bash-posix-style-compact
 delete mode 100644 t/t4018/bash-posix-style-compact.ctx
 delete mode 100644 t/t4018/bash-posix-style-function
 delete mode 100644 t/t4018/bash-posix-style-function.ctx
 delete mode 100644 t/t4018/bash-posix-style-whitespace
 delete mode 100644 t/t4018/bash-posix-style-whitespace.ctx
 delete mode 100644 t/t4018/bash-subshell-function
 delete mode 100644 t/t4018/bash-subshell-function.ctx
 delete mode 100644 t/t4018/bash-trailing-comment
 delete mode 100644 t/t4018/bash-trailing-comment.ctx
 create mode 100755 t/t4018/bash.sh
 delete mode 100644 t/t4018/cpp-c++-function
 delete mode 100644 t/t4018/cpp-c++-function.ctx
 delete mode 100644 t/t4018/cpp-class-constructor
 delete mode 100644 t/t4018/cpp-class-constructor-mem-init
 delete mode 100644 t/t4018/cpp-class-constructor-mem-init.ctx
 delete mode 100644 t/t4018/cpp-class-constructor.ctx
 delete mode 100644 t/t4018/cpp-class-definition
 delete mode 100644 t/t4018/cpp-class-definition-derived
 delete mode 100644 t/t4018/cpp-class-definition-derived.ctx
 delete mode 100644 t/t4018/cpp-class-definition.ctx
 delete mode 100644 t/t4018/cpp-class-destructor
 delete mode 100644 t/t4018/cpp-class-destructor.ctx
 delete mode 100644 t/t4018/cpp-function-returning-global-type
 delete mode 100644 t/t4018/cpp-function-returning-global-type.ctx
 delete mode 100644 t/t4018/cpp-function-returning-nested
 delete mode 100644 t/t4018/cpp-function-returning-nested.ctx
 delete mode 100644 t/t4018/cpp-function-returning-pointer
 delete mode 100644 t/t4018/cpp-function-returning-pointer.ctx
 delete mode 100644 t/t4018/cpp-function-returning-reference
 delete mode 100644 t/t4018/cpp-function-returning-reference.ctx
 delete mode 100644 t/t4018/cpp-gnu-style-function
 delete mode 100644 t/t4018/cpp-gnu-style-function.ctx
 delete mode 100644 t/t4018/cpp-namespace-definition
 delete mode 100644 t/t4018/cpp-namespace-definition.ctx
 delete mode 100644 t/t4018/cpp-operator-definition
 delete mode 100644 t/t4018/cpp-operator-definition.ctx
 delete mode 100644 t/t4018/cpp-skip-access-specifiers
 delete mode 100644 t/t4018/cpp-skip-access-specifiers.ctx
 delete mode 100644 t/t4018/cpp-skip-comment-block
 delete mode 100644 t/t4018/cpp-skip-comment-block.ctx
 delete mode 100644 t/t4018/cpp-skip-labels
 delete mode 100644 t/t4018/cpp-skip-labels.ctx
 delete mode 100644 t/t4018/cpp-struct-definition
 delete mode 100644 t/t4018/cpp-struct-definition.ctx
 delete mode 100644 t/t4018/cpp-struct-single-line
 delete mode 100644 t/t4018/cpp-struct-single-line.ctx
 delete mode 100644 t/t4018/cpp-template-function-definition
 delete mode 100644 t/t4018/cpp-template-function-definition.ctx
 delete mode 100644 t/t4018/cpp-union-definition
 delete mode 100644 t/t4018/cpp-union-definition.ctx
 delete mode 100644 t/t4018/cpp-void-c-function
 delete mode 100644 t/t4018/cpp-void-c-function.ctx
 create mode 100755 t/t4018/cpp.sh
 delete mode 100644 t/t4018/css-attribute-value-selector
 delete mode 100644 t/t4018/css-attribute-value-selector.ctx
 delete mode 100644 t/t4018/css-block-level-@-statements
 delete mode 100644 t/t4018/css-block-level-@-statements.ctx
 delete mode 100644 t/t4018/css-brace-in-col-1
 delete mode 100644 t/t4018/css-brace-in-col-1.ctx
 delete mode 100644 t/t4018/css-class-selector
 delete mode 100644 t/t4018/css-class-selector.ctx
 delete mode 100644 t/t4018/css-colon-eol
 delete mode 100644 t/t4018/css-colon-eol.ctx
 delete mode 100644 t/t4018/css-colon-selector
 delete mode 100644 t/t4018/css-colon-selector.ctx
 delete mode 100644 t/t4018/css-common
 delete mode 100644 t/t4018/css-common.ctx
 delete mode 100644 t/t4018/css-id-selector
 delete mode 100644 t/t4018/css-id-selector.ctx
 delete mode 100644 t/t4018/css-long-selector-list
 delete mode 100644 t/t4018/css-long-selector-list.ctx
 delete mode 100644 t/t4018/css-prop-sans-indent
 delete mode 100644 t/t4018/css-prop-sans-indent.ctx
 delete mode 100644 t/t4018/css-root-selector
 delete mode 100644 t/t4018/css-root-selector.ctx
 delete mode 100644 t/t4018/css-short-selector-list
 delete mode 100644 t/t4018/css-short-selector-list.ctx
 delete mode 100644 t/t4018/css-trailing-space
 delete mode 100644 t/t4018/css-trailing-space.ctx
 create mode 100755 t/t4018/css.sh
 delete mode 100644 t/t4018/custom1-pattern.ctx
 rename t/t4018/{custom1-pattern => custom1.sh} (71%)
 mode change 100644 => 100755
 delete mode 100644 t/t4018/custom2-match-to-end-of-line
 delete mode 100644 t/t4018/custom2-match-to-end-of-line.ctx
 create mode 100755 t/t4018/custom2.sh
 delete mode 100644 t/t4018/custom3-alternation-in-pattern.ctx
 rename t/t4018/{custom3-alternation-in-pattern => custom3.sh} (66%)
 mode change 100644 => 100755
 delete mode 100644 t/t4018/dts-labels
 delete mode 100644 t/t4018/dts-labels.ctx
 delete mode 100644 t/t4018/dts-node-unitless
 delete mode 100644 t/t4018/dts-node-unitless.ctx
 delete mode 100644 t/t4018/dts-nodes
 delete mode 100644 t/t4018/dts-nodes-boolean-prop
 delete mode 100644 t/t4018/dts-nodes-boolean-prop.ctx
 delete mode 100644 t/t4018/dts-nodes-comment1
 delete mode 100644 t/t4018/dts-nodes-comment1.ctx
 delete mode 100644 t/t4018/dts-nodes-comment2
 delete mode 100644 t/t4018/dts-nodes-comment2.ctx
 delete mode 100644 t/t4018/dts-nodes-multiline-prop
 delete mode 100644 t/t4018/dts-nodes-multiline-prop.ctx
 delete mode 100644 t/t4018/dts-nodes.ctx
 delete mode 100644 t/t4018/dts-reference
 delete mode 100644 t/t4018/dts-reference.ctx
 delete mode 100644 t/t4018/dts-root
 delete mode 100644 t/t4018/dts-root-comment
 delete mode 100644 t/t4018/dts-root-comment.ctx
 delete mode 100644 t/t4018/dts-root.ctx
 create mode 100755 t/t4018/dts.sh
 delete mode 100644 t/t4018/elixir-do-not-pick-end
 delete mode 100644 t/t4018/elixir-do-not-pick-end.ctx
 delete mode 100644 t/t4018/elixir-ex-unit-test
 delete mode 100644 t/t4018/elixir-ex-unit-test.ctx
 delete mode 100644 t/t4018/elixir-function
 delete mode 100644 t/t4018/elixir-function.ctx
 delete mode 100644 t/t4018/elixir-macro
 delete mode 100644 t/t4018/elixir-macro.ctx
 delete mode 100644 t/t4018/elixir-module
 delete mode 100644 t/t4018/elixir-module-func
 delete mode 100644 t/t4018/elixir-module-func.ctx
 delete mode 100644 t/t4018/elixir-module.ctx
 delete mode 100644 t/t4018/elixir-nested-module
 delete mode 100644 t/t4018/elixir-nested-module.ctx
 delete mode 100644 t/t4018/elixir-private-function
 delete mode 100644 t/t4018/elixir-private-function.ctx
 delete mode 100644 t/t4018/elixir-protocol
 delete mode 100644 t/t4018/elixir-protocol-implementation
 delete mode 100644 t/t4018/elixir-protocol-implementation.ctx
 delete mode 100644 t/t4018/elixir-protocol.ctx
 create mode 100755 t/t4018/elixir.sh
 delete mode 100644 t/t4018/fortran-block-data
 delete mode 100644 t/t4018/fortran-block-data.ctx
 delete mode 100644 t/t4018/fortran-comment
 delete mode 100644 t/t4018/fortran-comment-keyword
 delete mode 100644 t/t4018/fortran-comment-keyword.ctx
 delete mode 100644 t/t4018/fortran-comment-legacy
 delete mode 100644 t/t4018/fortran-comment-legacy-star
 delete mode 100644 t/t4018/fortran-comment-legacy-star.ctx
 delete mode 100644 t/t4018/fortran-comment-legacy.ctx
 delete mode 100644 t/t4018/fortran-comment.ctx
 delete mode 100644 t/t4018/fortran-external-function
 delete mode 100644 t/t4018/fortran-external-function.ctx
 delete mode 100644 t/t4018/fortran-external-subroutine
 delete mode 100644 t/t4018/fortran-external-subroutine.ctx
 delete mode 100644 t/t4018/fortran-module
 delete mode 100644 t/t4018/fortran-module-procedure
 delete mode 100644 t/t4018/fortran-module-procedure.ctx
 delete mode 100644 t/t4018/fortran-module.ctx
 delete mode 100644 t/t4018/fortran-program
 delete mode 100644 t/t4018/fortran-program.ctx
 create mode 100755 t/t4018/fortran.sh
 delete mode 100644 t/t4018/fountain-scene
 delete mode 100644 t/t4018/fountain-scene.ctx
 create mode 100755 t/t4018/fountain.sh
 delete mode 100644 t/t4018/golang-complex-function
 delete mode 100644 t/t4018/golang-complex-function.ctx
 delete mode 100644 t/t4018/golang-func
 delete mode 100644 t/t4018/golang-func.ctx
 delete mode 100644 t/t4018/golang-interface
 delete mode 100644 t/t4018/golang-interface.ctx
 delete mode 100644 t/t4018/golang-long-func
 delete mode 100644 t/t4018/golang-long-func.ctx
 delete mode 100644 t/t4018/golang-struct
 delete mode 100644 t/t4018/golang-struct.ctx
 create mode 100755 t/t4018/golang.sh
 delete mode 100644 t/t4018/java-class-member-function
 delete mode 100644 t/t4018/java-class-member-function.ctx
 create mode 100755 t/t4018/java.sh
 delete mode 100644 t/t4018/markdown-heading-indented
 delete mode 100644 t/t4018/markdown-heading-indented.ctx
 delete mode 100644 t/t4018/markdown-heading-non-headings
 delete mode 100644 t/t4018/markdown-heading-non-headings.ctx
 create mode 100755 t/t4018/markdown.sh
 delete mode 100644 t/t4018/matlab-class-definition
 delete mode 100644 t/t4018/matlab-class-definition.ctx
 delete mode 100644 t/t4018/matlab-function
 delete mode 100644 t/t4018/matlab-function.ctx
 delete mode 100644 t/t4018/matlab-octave-section-1
 delete mode 100644 t/t4018/matlab-octave-section-1.ctx
 delete mode 100644 t/t4018/matlab-octave-section-2
 delete mode 100644 t/t4018/matlab-octave-section-2.ctx
 delete mode 100644 t/t4018/matlab-section
 delete mode 100644 t/t4018/matlab-section.ctx
 create mode 100755 t/t4018/matlab.sh
 delete mode 100644 t/t4018/perl-skip-end-of-heredoc
 delete mode 100644 t/t4018/perl-skip-end-of-heredoc.ctx
 delete mode 100644 t/t4018/perl-skip-forward-decl
 delete mode 100644 t/t4018/perl-skip-forward-decl.ctx
 delete mode 100644 t/t4018/perl-skip-sub-in-pod
 delete mode 100644 t/t4018/perl-skip-sub-in-pod.ctx
 delete mode 100644 t/t4018/perl-sub-definition
 delete mode 100644 t/t4018/perl-sub-definition-kr-brace
 delete mode 100644 t/t4018/perl-sub-definition-kr-brace.ctx
 delete mode 100644 t/t4018/perl-sub-definition.ctx
 create mode 100755 t/t4018/perl.sh
 delete mode 100644 t/t4018/php-abstract-class
 delete mode 100644 t/t4018/php-abstract-class.ctx
 delete mode 100644 t/t4018/php-abstract-method
 delete mode 100644 t/t4018/php-abstract-method.ctx
 delete mode 100644 t/t4018/php-class
 delete mode 100644 t/t4018/php-class.ctx
 delete mode 100644 t/t4018/php-final-class
 delete mode 100644 t/t4018/php-final-class.ctx
 delete mode 100644 t/t4018/php-final-method
 delete mode 100644 t/t4018/php-final-method.ctx
 delete mode 100644 t/t4018/php-function
 delete mode 100644 t/t4018/php-function.ctx
 delete mode 100644 t/t4018/php-interface
 delete mode 100644 t/t4018/php-interface.ctx
 delete mode 100644 t/t4018/php-method
 delete mode 100644 t/t4018/php-method.ctx
 delete mode 100644 t/t4018/php-trait
 delete mode 100644 t/t4018/php-trait.ctx
 create mode 100755 t/t4018/php.sh
 delete mode 100644 t/t4018/python-async-def
 delete mode 100644 t/t4018/python-async-def.ctx
 delete mode 100644 t/t4018/python-class
 delete mode 100644 t/t4018/python-class.ctx
 delete mode 100644 t/t4018/python-def
 delete mode 100644 t/t4018/python-def.ctx
 delete mode 100644 t/t4018/python-indented-async-def
 delete mode 100644 t/t4018/python-indented-async-def.ctx
 delete mode 100644 t/t4018/python-indented-class
 delete mode 100644 t/t4018/python-indented-class.ctx
 delete mode 100644 t/t4018/python-indented-def
 delete mode 100644 t/t4018/python-indented-def.ctx
 create mode 100755 t/t4018/python.sh
 delete mode 100644 t/t4018/rust-fn
 delete mode 100644 t/t4018/rust-fn.ctx
 delete mode 100644 t/t4018/rust-impl
 delete mode 100644 t/t4018/rust-impl.ctx
 delete mode 100644 t/t4018/rust-macro-rules
 delete mode 100644 t/t4018/rust-macro-rules.ctx
 delete mode 100644 t/t4018/rust-struct
 delete mode 100644 t/t4018/rust-struct.ctx
 delete mode 100644 t/t4018/rust-trait
 delete mode 100644 t/t4018/rust-trait.ctx
 create mode 100755 t/t4018/rust.sh

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index d32c38ad1a..3ff34c13d7 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -61,33 +61,42 @@ test_expect_success 'last regexp must not be negated' '
 	test_i18ngrep ": Last expression must not be negated:" msg
 '
 
-test_expect_success 'setup hunk header tests' '
-	for i in $diffpatterns
-	do
-		echo "$i-* diff=$i"
-	done > .gitattributes &&
-
-	# add all test files to the index
-	(
-		cd "$TEST_DIRECTORY"/t4018 &&
-		git --git-dir="$TRASH_DIRECTORY/.git" add .
-	) &&
-
-	# place modified files in the worktree
-	for i in $(git ls-files)
-	do
-		sed -e "s/ChangeMe/IWasChanged/" <"$TEST_DIRECTORY/t4018/$i" >"$i" || return 1
-	done
-'
+test_diff_funcname () {
+	desc=$1
+	cat <&8 >arg.header &&
+	cat <&9 >arg.test &&
+	what=$(cat arg.what) &&
+
+	test_expect_success "setup: $desc" '
+		cp arg.test "$what" &&
+		cp arg.header expected &&
+		git add "$what" &&
+		sed -e "s/ChangeMe/IWasChanged/" <"$what" >tmp &&
+		mv tmp "$what"
+	' &&
+
+	test_expect_success "$desc" '
+		git diff -U1 "$what" >diff &&
+		sed -n -e "s/^.*@@\( \|$\)//p" <diff >actual &&
+		test_cmp expected actual
+	'
+}
 
-# check each individual file
-for i in $(git ls-files -- ':!*.ctx')
+for what in $diffpatterns
 do
-	test_expect_success "hunk header: $i" "
-		git diff -U1 $i >diff &&
-		sed -n -e 's/^.*@@\( \|$\)//p' <diff >ctx &&
-		test_cmp $i.ctx ctx
-	"
+	test="$TEST_DIRECTORY/t4018/$what.sh"
+	if ! test -e "$test"
+	then
+		test_expect_failure "$what: no tests" 'false'
+		continue
+	fi &&
+
+	test_expect_success "setup: hunk header for $what" '
+		echo "$what diff=$what" >.gitattributes &&
+		echo "$what" >arg.what
+	' &&
+
+	. "$test"
 done
 
 test_done
diff --git a/t/t4018/README b/t/t4018/README
deleted file mode 100644
index 2cccf8c950..0000000000
--- a/t/t4018/README
+++ /dev/null
@@ -1,15 +0,0 @@
-How to write test cases
-=======================
-
-Create test cases called "LANG-whatever" in this directory, where
-"LANG" is e.g. the userdiff driver name, where "whatever" is a brief
-description of the test.
-
-Insert the word "ChangeMe" (exactly this form) at a distance of
-at least two lines from the line that must appear in the hunk header.
-
-The text that must appear in the hunk header must contains the word
-"RIGHT" by convention. The "LANG-whatever.ctx" file contains what we
-expect to appear in the hunk header. We munged the start of the line
-to "@@ [...] @@" for ease of not having to hardcode the line numbers
-and offsets.
diff --git a/t/t4018/README.ctx b/t/t4018/README.ctx
deleted file mode 100644
index cd79384b04..0000000000
--- a/t/t4018/README.ctx
+++ /dev/null
@@ -1 +0,0 @@
-description of the test.
diff --git a/t/t4018/bash-arithmetic-function b/t/t4018/bash-arithmetic-function
deleted file mode 100644
index c0b276cb50..0000000000
--- a/t/t4018/bash-arithmetic-function
+++ /dev/null
@@ -1,4 +0,0 @@
-RIGHT() ((
-
-    ChangeMe = "$x" + "$y"
-))
diff --git a/t/t4018/bash-arithmetic-function.ctx b/t/t4018/bash-arithmetic-function.ctx
deleted file mode 100644
index 811eac7d2f..0000000000
--- a/t/t4018/bash-arithmetic-function.ctx
+++ /dev/null
@@ -1 +0,0 @@
-RIGHT()
diff --git a/t/t4018/bash-bashism-style-compact b/t/t4018/bash-bashism-style-compact
deleted file mode 100644
index 1ca3126f61..0000000000
--- a/t/t4018/bash-bashism-style-compact
+++ /dev/null
@@ -1,6 +0,0 @@
-function RIGHT {
-    function InvalidSyntax{
-        :
-        echo 'ChangeMe'
-    }
-}
diff --git a/t/t4018/bash-bashism-style-compact.ctx b/t/t4018/bash-bashism-style-compact.ctx
deleted file mode 100644
index 4f8eac48c6..0000000000
--- a/t/t4018/bash-bashism-style-compact.ctx
+++ /dev/null
@@ -1 +0,0 @@
-function RIGHT {
diff --git a/t/t4018/bash-bashism-style-function b/t/t4018/bash-bashism-style-function
deleted file mode 100644
index f1de4fa831..0000000000
--- a/t/t4018/bash-bashism-style-function
+++ /dev/null
@@ -1,4 +0,0 @@
-function RIGHT {
-    :
-    echo 'ChangeMe'
-}
diff --git a/t/t4018/bash-bashism-style-function.ctx b/t/t4018/bash-bashism-style-function.ctx
deleted file mode 100644
index 4f8eac48c6..0000000000
--- a/t/t4018/bash-bashism-style-function.ctx
+++ /dev/null
@@ -1 +0,0 @@
-function RIGHT {
diff --git a/t/t4018/bash-bashism-style-whitespace b/t/t4018/bash-bashism-style-whitespace
deleted file mode 100644
index ade85dd3a5..0000000000
--- a/t/t4018/bash-bashism-style-whitespace
+++ /dev/null
@@ -1,4 +0,0 @@
-	 function 	RIGHT 	( 	) 	{
-
-	    ChangeMe
-	 }
diff --git a/t/t4018/bash-bashism-style-whitespace.ctx b/t/t4018/bash-bashism-style-whitespace.ctx
deleted file mode 100644
index 35dbd0220e..0000000000
--- a/t/t4018/bash-bashism-style-whitespace.ctx
+++ /dev/null
@@ -1 +0,0 @@
-function 	RIGHT 	( 	) 	{
diff --git a/t/t4018/bash-conditional-function b/t/t4018/bash-conditional-function
deleted file mode 100644
index c5949e829b..0000000000
--- a/t/t4018/bash-conditional-function
+++ /dev/null
@@ -1,4 +0,0 @@
-RIGHT() [[ \
-
-    "$a" > "$ChangeMe"
-]]
diff --git a/t/t4018/bash-conditional-function.ctx b/t/t4018/bash-conditional-function.ctx
deleted file mode 100644
index 811eac7d2f..0000000000
--- a/t/t4018/bash-conditional-function.ctx
+++ /dev/null
@@ -1 +0,0 @@
-RIGHT()
diff --git a/t/t4018/bash-missing-parentheses b/t/t4018/bash-missing-parentheses
deleted file mode 100644
index 8c8a05dd7a..0000000000
--- a/t/t4018/bash-missing-parentheses
+++ /dev/null
@@ -1,6 +0,0 @@
-function RIGHT {
-    functionInvalidSyntax {
-        :
-        echo 'ChangeMe'
-    }
-}
diff --git a/t/t4018/bash-missing-parentheses.ctx b/t/t4018/bash-missing-parentheses.ctx
deleted file mode 100644
index 4f8eac48c6..0000000000
--- a/t/t4018/bash-missing-parentheses.ctx
+++ /dev/null
@@ -1 +0,0 @@
-function RIGHT {
diff --git a/t/t4018/bash-mixed-style-compact b/t/t4018/bash-mixed-style-compact
deleted file mode 100644
index d9364cba67..0000000000
--- a/t/t4018/bash-mixed-style-compact
+++ /dev/null
@@ -1,4 +0,0 @@
-function RIGHT(){
-    :
-    echo 'ChangeMe'
-}
diff --git a/t/t4018/bash-mixed-style-compact.ctx b/t/t4018/bash-mixed-style-compact.ctx
deleted file mode 100644
index bba11074eb..0000000000
--- a/t/t4018/bash-mixed-style-compact.ctx
+++ /dev/null
@@ -1 +0,0 @@
-function RIGHT(){
diff --git a/t/t4018/bash-mixed-style-function b/t/t4018/bash-mixed-style-function
deleted file mode 100644
index 555f9b2466..0000000000
--- a/t/t4018/bash-mixed-style-function
+++ /dev/null
@@ -1,4 +0,0 @@
-function RIGHT() {
-
-    ChangeMe
-}
diff --git a/t/t4018/bash-mixed-style-function.ctx b/t/t4018/bash-mixed-style-function.ctx
deleted file mode 100644
index 922b87a4aa..0000000000
--- a/t/t4018/bash-mixed-style-function.ctx
+++ /dev/null
@@ -1 +0,0 @@
-function RIGHT() {
diff --git a/t/t4018/bash-nested-functions b/t/t4018/bash-nested-functions
deleted file mode 100644
index 2c9237ead4..0000000000
--- a/t/t4018/bash-nested-functions
+++ /dev/null
@@ -1,6 +0,0 @@
-outer() {
-    RIGHT() {
-        :
-        echo 'ChangeMe'
-    }
-}
diff --git a/t/t4018/bash-nested-functions.ctx b/t/t4018/bash-nested-functions.ctx
deleted file mode 100644
index 811eac7d2f..0000000000
--- a/t/t4018/bash-nested-functions.ctx
+++ /dev/null
@@ -1 +0,0 @@
-RIGHT()
diff --git a/t/t4018/bash-other-characters b/t/t4018/bash-other-characters
deleted file mode 100644
index a3f390d525..0000000000
--- a/t/t4018/bash-other-characters
+++ /dev/null
@@ -1,4 +0,0 @@
-_RIGHT_0n() {
-
-    ChangeMe
-}
diff --git a/t/t4018/bash-other-characters.ctx b/t/t4018/bash-other-characters.ctx
deleted file mode 100644
index 6a55317fdf..0000000000
--- a/t/t4018/bash-other-characters.ctx
+++ /dev/null
@@ -1 +0,0 @@
-_RIGHT_0n()
diff --git a/t/t4018/bash-posix-style-compact b/t/t4018/bash-posix-style-compact
deleted file mode 100644
index 045bd2029b..0000000000
--- a/t/t4018/bash-posix-style-compact
+++ /dev/null
@@ -1,4 +0,0 @@
-RIGHT(){
-
-    ChangeMe
-}
diff --git a/t/t4018/bash-posix-style-compact.ctx b/t/t4018/bash-posix-style-compact.ctx
deleted file mode 100644
index 811eac7d2f..0000000000
--- a/t/t4018/bash-posix-style-compact.ctx
+++ /dev/null
@@ -1 +0,0 @@
-RIGHT()
diff --git a/t/t4018/bash-posix-style-function b/t/t4018/bash-posix-style-function
deleted file mode 100644
index a4d144856e..0000000000
--- a/t/t4018/bash-posix-style-function
+++ /dev/null
@@ -1,4 +0,0 @@
-RIGHT() {
-
-    ChangeMe
-}
diff --git a/t/t4018/bash-posix-style-function.ctx b/t/t4018/bash-posix-style-function.ctx
deleted file mode 100644
index 811eac7d2f..0000000000
--- a/t/t4018/bash-posix-style-function.ctx
+++ /dev/null
@@ -1 +0,0 @@
-RIGHT()
diff --git a/t/t4018/bash-posix-style-whitespace b/t/t4018/bash-posix-style-whitespace
deleted file mode 100644
index 4d984f0aa4..0000000000
--- a/t/t4018/bash-posix-style-whitespace
+++ /dev/null
@@ -1,4 +0,0 @@
-	 RIGHT 	( 	) 	{
-
-	    ChangeMe
-	 }
diff --git a/t/t4018/bash-posix-style-whitespace.ctx b/t/t4018/bash-posix-style-whitespace.ctx
deleted file mode 100644
index 28f8698e14..0000000000
--- a/t/t4018/bash-posix-style-whitespace.ctx
+++ /dev/null
@@ -1 +0,0 @@
-RIGHT 	( 	)
diff --git a/t/t4018/bash-subshell-function b/t/t4018/bash-subshell-function
deleted file mode 100644
index 80baa09484..0000000000
--- a/t/t4018/bash-subshell-function
+++ /dev/null
@@ -1,4 +0,0 @@
-RIGHT() (
-
-    ChangeMe=2
-)
diff --git a/t/t4018/bash-subshell-function.ctx b/t/t4018/bash-subshell-function.ctx
deleted file mode 100644
index 811eac7d2f..0000000000
--- a/t/t4018/bash-subshell-function.ctx
+++ /dev/null
@@ -1 +0,0 @@
-RIGHT()
diff --git a/t/t4018/bash-trailing-comment b/t/t4018/bash-trailing-comment
deleted file mode 100644
index f1edbeda31..0000000000
--- a/t/t4018/bash-trailing-comment
+++ /dev/null
@@ -1,4 +0,0 @@
-RIGHT() { # Comment
-
-    ChangeMe
-}
diff --git a/t/t4018/bash-trailing-comment.ctx b/t/t4018/bash-trailing-comment.ctx
deleted file mode 100644
index 811eac7d2f..0000000000
--- a/t/t4018/bash-trailing-comment.ctx
+++ /dev/null
@@ -1 +0,0 @@
-RIGHT()
diff --git a/t/t4018/bash.sh b/t/t4018/bash.sh
new file mode 100755
index 0000000000..69144d9144
--- /dev/null
+++ b/t/t4018/bash.sh
@@ -0,0 +1,160 @@
+#!/bin/sh
+#
+# See ../t4018-diff-funcname.sh's test_diff_funcname()
+#
+
+test_diff_funcname 'bash: arithmetic function' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+RIGHT()
+EOF_HUNK
+RIGHT() ((
+
+    ChangeMe = "$x" + "$y"
+))
+EOF_TEST
+
+test_diff_funcname 'bash: bashism style compact' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+function RIGHT {
+EOF_HUNK
+function RIGHT {
+    function InvalidSyntax{
+        :
+        echo 'ChangeMe'
+    }
+}
+EOF_TEST
+
+test_diff_funcname 'bash: bashism style function' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+function RIGHT {
+EOF_HUNK
+function RIGHT {
+    :
+    echo 'ChangeMe'
+}
+EOF_TEST
+
+test_diff_funcname 'bash: bashism style whitespace' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+function 	RIGHT 	( 	) 	{
+EOF_HUNK
+	 function 	RIGHT 	( 	) 	{
+
+	    ChangeMe
+	 }
+EOF_TEST
+
+test_diff_funcname 'bash: conditional function' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+RIGHT()
+EOF_HUNK
+RIGHT() [[ \
+
+    "$a" > "$ChangeMe"
+]]
+EOF_TEST
+
+test_diff_funcname 'bash: missing parentheses' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+function RIGHT {
+EOF_HUNK
+function RIGHT {
+    functionInvalidSyntax {
+        :
+        echo 'ChangeMe'
+    }
+}
+EOF_TEST
+
+test_diff_funcname 'bash: mixed style compact' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+function RIGHT(){
+EOF_HUNK
+function RIGHT(){
+    :
+    echo 'ChangeMe'
+}
+EOF_TEST
+
+test_diff_funcname 'bash: mixed style function' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+function RIGHT() {
+EOF_HUNK
+function RIGHT() {
+
+    ChangeMe
+}
+EOF_TEST
+
+test_diff_funcname 'bash: nested functions' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+RIGHT()
+EOF_HUNK
+outer() {
+    RIGHT() {
+        :
+        echo 'ChangeMe'
+    }
+}
+EOF_TEST
+
+test_diff_funcname 'bash: other characters' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+_RIGHT_0n()
+EOF_HUNK
+_RIGHT_0n() {
+
+    ChangeMe
+}
+EOF_TEST
+
+test_diff_funcname 'bash: posix style compact' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+RIGHT()
+EOF_HUNK
+RIGHT(){
+
+    ChangeMe
+}
+EOF_TEST
+
+test_diff_funcname 'bash: posix style function' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+RIGHT()
+EOF_HUNK
+RIGHT() {
+
+    ChangeMe
+}
+EOF_TEST
+
+test_diff_funcname 'bash: posix style whitespace' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+RIGHT 	( 	)
+EOF_HUNK
+	 RIGHT 	( 	) 	{
+
+	    ChangeMe
+	 }
+EOF_TEST
+
+test_diff_funcname 'bash: subshell function' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+RIGHT()
+EOF_HUNK
+RIGHT() (
+
+    ChangeMe=2
+)
+EOF_TEST
+
+test_diff_funcname 'bash: trailing comment' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+RIGHT()
+EOF_HUNK
+RIGHT() { # Comment
+
+    ChangeMe
+}
+EOF_TEST
diff --git a/t/t4018/cpp-c++-function b/t/t4018/cpp-c++-function
deleted file mode 100644
index 9ee6bbef55..0000000000
--- a/t/t4018/cpp-c++-function
+++ /dev/null
@@ -1,4 +0,0 @@
-Item RIGHT::DoSomething( Args with_spaces )
-{
-	ChangeMe;
-}
diff --git a/t/t4018/cpp-c++-function.ctx b/t/t4018/cpp-c++-function.ctx
deleted file mode 100644
index 337b49dbb3..0000000000
--- a/t/t4018/cpp-c++-function.ctx
+++ /dev/null
@@ -1 +0,0 @@
-Item RIGHT::DoSomething( Args with_spaces )
diff --git a/t/t4018/cpp-class-constructor b/t/t4018/cpp-class-constructor
deleted file mode 100644
index ec4f115c25..0000000000
--- a/t/t4018/cpp-class-constructor
+++ /dev/null
@@ -1,4 +0,0 @@
-Item::Item(int RIGHT)
-{
-	ChangeMe;
-}
diff --git a/t/t4018/cpp-class-constructor-mem-init b/t/t4018/cpp-class-constructor-mem-init
deleted file mode 100644
index 49a69f37e1..0000000000
--- a/t/t4018/cpp-class-constructor-mem-init
+++ /dev/null
@@ -1,5 +0,0 @@
-Item::Item(int RIGHT) :
-	member(0)
-{
-	ChangeMe;
-}
diff --git a/t/t4018/cpp-class-constructor-mem-init.ctx b/t/t4018/cpp-class-constructor-mem-init.ctx
deleted file mode 100644
index 6664b8b3d8..0000000000
--- a/t/t4018/cpp-class-constructor-mem-init.ctx
+++ /dev/null
@@ -1 +0,0 @@
-Item::Item(int RIGHT) :
diff --git a/t/t4018/cpp-class-constructor.ctx b/t/t4018/cpp-class-constructor.ctx
deleted file mode 100644
index 2dcadfc0ba..0000000000
--- a/t/t4018/cpp-class-constructor.ctx
+++ /dev/null
@@ -1 +0,0 @@
-Item::Item(int RIGHT)
diff --git a/t/t4018/cpp-class-definition b/t/t4018/cpp-class-definition
deleted file mode 100644
index 11b61da3b7..0000000000
--- a/t/t4018/cpp-class-definition
+++ /dev/null
@@ -1,4 +0,0 @@
-class RIGHT
-{
-	int ChangeMe;
-};
diff --git a/t/t4018/cpp-class-definition-derived b/t/t4018/cpp-class-definition-derived
deleted file mode 100644
index 3b98cd09ab..0000000000
--- a/t/t4018/cpp-class-definition-derived
+++ /dev/null
@@ -1,5 +0,0 @@
-class RIGHT :
-	public Baseclass
-{
-	int ChangeMe;
-};
diff --git a/t/t4018/cpp-class-definition-derived.ctx b/t/t4018/cpp-class-definition-derived.ctx
deleted file mode 100644
index 146f0a7b7c..0000000000
--- a/t/t4018/cpp-class-definition-derived.ctx
+++ /dev/null
@@ -1 +0,0 @@
-class RIGHT :
diff --git a/t/t4018/cpp-class-definition.ctx b/t/t4018/cpp-class-definition.ctx
deleted file mode 100644
index 54bff816d6..0000000000
--- a/t/t4018/cpp-class-definition.ctx
+++ /dev/null
@@ -1 +0,0 @@
-class RIGHT
diff --git a/t/t4018/cpp-class-destructor b/t/t4018/cpp-class-destructor
deleted file mode 100644
index 5487665096..0000000000
--- a/t/t4018/cpp-class-destructor
+++ /dev/null
@@ -1,4 +0,0 @@
-RIGHT::~RIGHT()
-{
-	ChangeMe;
-}
diff --git a/t/t4018/cpp-class-destructor.ctx b/t/t4018/cpp-class-destructor.ctx
deleted file mode 100644
index 5390c17cf6..0000000000
--- a/t/t4018/cpp-class-destructor.ctx
+++ /dev/null
@@ -1 +0,0 @@
-RIGHT::~RIGHT()
diff --git a/t/t4018/cpp-function-returning-global-type b/t/t4018/cpp-function-returning-global-type
deleted file mode 100644
index 1084d5990e..0000000000
--- a/t/t4018/cpp-function-returning-global-type
+++ /dev/null
@@ -1,4 +0,0 @@
-::Item get::it::RIGHT()
-{
-	ChangeMe;
-}
diff --git a/t/t4018/cpp-function-returning-global-type.ctx b/t/t4018/cpp-function-returning-global-type.ctx
deleted file mode 100644
index 4dcdde25f4..0000000000
--- a/t/t4018/cpp-function-returning-global-type.ctx
+++ /dev/null
@@ -1 +0,0 @@
-::Item get::it::RIGHT()
diff --git a/t/t4018/cpp-function-returning-nested b/t/t4018/cpp-function-returning-nested
deleted file mode 100644
index d9750aa61a..0000000000
--- a/t/t4018/cpp-function-returning-nested
+++ /dev/null
@@ -1,5 +0,0 @@
-get::Item get::it::RIGHT()
-{
-	ChangeMe;
-}
-
diff --git a/t/t4018/cpp-function-returning-nested.ctx b/t/t4018/cpp-function-returning-nested.ctx
deleted file mode 100644
index 6ef73c8368..0000000000
--- a/t/t4018/cpp-function-returning-nested.ctx
+++ /dev/null
@@ -1 +0,0 @@
-get::Item get::it::RIGHT()
diff --git a/t/t4018/cpp-function-returning-pointer b/t/t4018/cpp-function-returning-pointer
deleted file mode 100644
index ef15657ea8..0000000000
--- a/t/t4018/cpp-function-returning-pointer
+++ /dev/null
@@ -1,4 +0,0 @@
-const char *get_it_RIGHT(char *ptr)
-{
-	ChangeMe;
-}
diff --git a/t/t4018/cpp-function-returning-pointer.ctx b/t/t4018/cpp-function-returning-pointer.ctx
deleted file mode 100644
index bb0acce5c7..0000000000
--- a/t/t4018/cpp-function-returning-pointer.ctx
+++ /dev/null
@@ -1 +0,0 @@
-const char *get_it_RIGHT(char *ptr)
diff --git a/t/t4018/cpp-function-returning-reference b/t/t4018/cpp-function-returning-reference
deleted file mode 100644
index 01b051df70..0000000000
--- a/t/t4018/cpp-function-returning-reference
+++ /dev/null
@@ -1,4 +0,0 @@
-string& get::it::RIGHT(char *ptr)
-{
-	ChangeMe;
-}
diff --git a/t/t4018/cpp-function-returning-reference.ctx b/t/t4018/cpp-function-returning-reference.ctx
deleted file mode 100644
index 76afe381fd..0000000000
--- a/t/t4018/cpp-function-returning-reference.ctx
+++ /dev/null
@@ -1 +0,0 @@
-string& get::it::RIGHT(char *ptr)
diff --git a/t/t4018/cpp-gnu-style-function b/t/t4018/cpp-gnu-style-function
deleted file mode 100644
index 08c7c7565a..0000000000
--- a/t/t4018/cpp-gnu-style-function
+++ /dev/null
@@ -1,5 +0,0 @@
-const char *
-RIGHT(int arg)
-{
-	ChangeMe;
-}
diff --git a/t/t4018/cpp-gnu-style-function.ctx b/t/t4018/cpp-gnu-style-function.ctx
deleted file mode 100644
index 1858287812..0000000000
--- a/t/t4018/cpp-gnu-style-function.ctx
+++ /dev/null
@@ -1 +0,0 @@
-RIGHT(int arg)
diff --git a/t/t4018/cpp-namespace-definition b/t/t4018/cpp-namespace-definition
deleted file mode 100644
index 6749980241..0000000000
--- a/t/t4018/cpp-namespace-definition
+++ /dev/null
@@ -1,4 +0,0 @@
-namespace RIGHT
-{
-	ChangeMe;
-}
diff --git a/t/t4018/cpp-namespace-definition.ctx b/t/t4018/cpp-namespace-definition.ctx
deleted file mode 100644
index 14c29c4638..0000000000
--- a/t/t4018/cpp-namespace-definition.ctx
+++ /dev/null
@@ -1 +0,0 @@
-namespace RIGHT
diff --git a/t/t4018/cpp-operator-definition b/t/t4018/cpp-operator-definition
deleted file mode 100644
index 1acd827159..0000000000
--- a/t/t4018/cpp-operator-definition
+++ /dev/null
@@ -1,4 +0,0 @@
-Value operator+(Value LEFT, Value RIGHT)
-{
-	ChangeMe;
-}
diff --git a/t/t4018/cpp-operator-definition.ctx b/t/t4018/cpp-operator-definition.ctx
deleted file mode 100644
index 5b56778961..0000000000
--- a/t/t4018/cpp-operator-definition.ctx
+++ /dev/null
@@ -1 +0,0 @@
-Value operator+(Value LEFT, Value RIGHT)
diff --git a/t/t4018/cpp-skip-access-specifiers b/t/t4018/cpp-skip-access-specifiers
deleted file mode 100644
index 4d4a9dbb9d..0000000000
--- a/t/t4018/cpp-skip-access-specifiers
+++ /dev/null
@@ -1,8 +0,0 @@
-class RIGHT : public Baseclass
-{
-public:
-protected:
-private:
-	void DoSomething();
-	int ChangeMe;
-};
diff --git a/t/t4018/cpp-skip-access-specifiers.ctx b/t/t4018/cpp-skip-access-specifiers.ctx
deleted file mode 100644
index 075bcd883b..0000000000
--- a/t/t4018/cpp-skip-access-specifiers.ctx
+++ /dev/null
@@ -1 +0,0 @@
-class RIGHT : public Baseclass
diff --git a/t/t4018/cpp-skip-comment-block b/t/t4018/cpp-skip-comment-block
deleted file mode 100644
index 3800b9967a..0000000000
--- a/t/t4018/cpp-skip-comment-block
+++ /dev/null
@@ -1,9 +0,0 @@
-struct item RIGHT(int i)
-// Do not
-// pick up
-/* these
-** comments.
-*/
-{
-	ChangeMe;
-}
diff --git a/t/t4018/cpp-skip-comment-block.ctx b/t/t4018/cpp-skip-comment-block.ctx
deleted file mode 100644
index 656c59893d..0000000000
--- a/t/t4018/cpp-skip-comment-block.ctx
+++ /dev/null
@@ -1 +0,0 @@
-struct item RIGHT(int i)
diff --git a/t/t4018/cpp-skip-labels b/t/t4018/cpp-skip-labels
deleted file mode 100644
index b9c10aba22..0000000000
--- a/t/t4018/cpp-skip-labels
+++ /dev/null
@@ -1,8 +0,0 @@
-void RIGHT (void)
-{
-repeat:		// C++ comment
-next:		/* C comment */
-	do_something();
-
-	ChangeMe;
-}
diff --git a/t/t4018/cpp-skip-labels.ctx b/t/t4018/cpp-skip-labels.ctx
deleted file mode 100644
index 6b0635f7f7..0000000000
--- a/t/t4018/cpp-skip-labels.ctx
+++ /dev/null
@@ -1 +0,0 @@
-void RIGHT (void)
diff --git a/t/t4018/cpp-struct-definition b/t/t4018/cpp-struct-definition
deleted file mode 100644
index 521c59fd15..0000000000
--- a/t/t4018/cpp-struct-definition
+++ /dev/null
@@ -1,9 +0,0 @@
-struct RIGHT {
-	unsigned
-	/* this bit field looks like a label and should not be picked up */
-		decoy_bitfield: 2,
-		more : 1;
-	int filler;
-
-	int ChangeMe;
-};
diff --git a/t/t4018/cpp-struct-definition.ctx b/t/t4018/cpp-struct-definition.ctx
deleted file mode 100644
index 48ed893279..0000000000
--- a/t/t4018/cpp-struct-definition.ctx
+++ /dev/null
@@ -1 +0,0 @@
-struct RIGHT {
diff --git a/t/t4018/cpp-struct-single-line b/t/t4018/cpp-struct-single-line
deleted file mode 100644
index a0de5fb800..0000000000
--- a/t/t4018/cpp-struct-single-line
+++ /dev/null
@@ -1,7 +0,0 @@
-void wrong()
-{
-}
-
-struct RIGHT_iterator_tag {};
-
-int ChangeMe;
diff --git a/t/t4018/cpp-struct-single-line.ctx b/t/t4018/cpp-struct-single-line.ctx
deleted file mode 100644
index e3bc9d5017..0000000000
--- a/t/t4018/cpp-struct-single-line.ctx
+++ /dev/null
@@ -1 +0,0 @@
-struct RIGHT_iterator_tag {};
diff --git a/t/t4018/cpp-template-function-definition b/t/t4018/cpp-template-function-definition
deleted file mode 100644
index 0cdf5ba5bd..0000000000
--- a/t/t4018/cpp-template-function-definition
+++ /dev/null
@@ -1,4 +0,0 @@
-template<class T> int RIGHT(T arg)
-{
-	ChangeMe;
-}
diff --git a/t/t4018/cpp-template-function-definition.ctx b/t/t4018/cpp-template-function-definition.ctx
deleted file mode 100644
index c9da39cf65..0000000000
--- a/t/t4018/cpp-template-function-definition.ctx
+++ /dev/null
@@ -1 +0,0 @@
-template<class T> int RIGHT(T arg)
diff --git a/t/t4018/cpp-union-definition b/t/t4018/cpp-union-definition
deleted file mode 100644
index 7ec94df697..0000000000
--- a/t/t4018/cpp-union-definition
+++ /dev/null
@@ -1,4 +0,0 @@
-union RIGHT {
-	double v;
-	int ChangeMe;
-};
diff --git a/t/t4018/cpp-union-definition.ctx b/t/t4018/cpp-union-definition.ctx
deleted file mode 100644
index 2fc7b54fb8..0000000000
--- a/t/t4018/cpp-union-definition.ctx
+++ /dev/null
@@ -1 +0,0 @@
-union RIGHT {
diff --git a/t/t4018/cpp-void-c-function b/t/t4018/cpp-void-c-function
deleted file mode 100644
index 153081e872..0000000000
--- a/t/t4018/cpp-void-c-function
+++ /dev/null
@@ -1,4 +0,0 @@
-void RIGHT (void)
-{
-	ChangeMe;
-}
diff --git a/t/t4018/cpp-void-c-function.ctx b/t/t4018/cpp-void-c-function.ctx
deleted file mode 100644
index 6b0635f7f7..0000000000
--- a/t/t4018/cpp-void-c-function.ctx
+++ /dev/null
@@ -1 +0,0 @@
-void RIGHT (void)
diff --git a/t/t4018/cpp.sh b/t/t4018/cpp.sh
new file mode 100755
index 0000000000..185d40d5ef
--- /dev/null
+++ b/t/t4018/cpp.sh
@@ -0,0 +1,239 @@
+#!/bin/sh
+#
+# See ../t4018-diff-funcname.sh's test_diff_funcname()
+#
+
+test_diff_funcname 'cpp: c++ function' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+Item RIGHT::DoSomething( Args with_spaces )
+EOF_HUNK
+Item RIGHT::DoSomething( Args with_spaces )
+{
+	ChangeMe;
+}
+EOF_TEST
+
+test_diff_funcname 'cpp: class constructor' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+Item::Item(int RIGHT)
+EOF_HUNK
+Item::Item(int RIGHT)
+{
+	ChangeMe;
+}
+EOF_TEST
+
+test_diff_funcname 'cpp: class constructor mem init' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+Item::Item(int RIGHT) :
+EOF_HUNK
+Item::Item(int RIGHT) :
+	member(0)
+{
+	ChangeMe;
+}
+EOF_TEST
+
+test_diff_funcname 'cpp: class definition' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+class RIGHT
+EOF_HUNK
+class RIGHT
+{
+	int ChangeMe;
+};
+EOF_TEST
+
+test_diff_funcname 'cpp: class definition derived' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+class RIGHT :
+EOF_HUNK
+class RIGHT :
+	public Baseclass
+{
+	int ChangeMe;
+};
+EOF_TEST
+
+test_diff_funcname 'cpp: class destructor' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+RIGHT::~RIGHT()
+EOF_HUNK
+RIGHT::~RIGHT()
+{
+	ChangeMe;
+}
+EOF_TEST
+
+test_diff_funcname 'cpp: function returning global type' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+::Item get::it::RIGHT()
+EOF_HUNK
+::Item get::it::RIGHT()
+{
+	ChangeMe;
+}
+EOF_TEST
+
+test_diff_funcname 'cpp: function returning nested' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+get::Item get::it::RIGHT()
+EOF_HUNK
+get::Item get::it::RIGHT()
+{
+	ChangeMe;
+}
+
+EOF_TEST
+
+test_diff_funcname 'cpp: function returning pointer' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+const char *get_it_RIGHT(char *ptr)
+EOF_HUNK
+const char *get_it_RIGHT(char *ptr)
+{
+	ChangeMe;
+}
+EOF_TEST
+
+test_diff_funcname 'cpp: function returning reference' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+string& get::it::RIGHT(char *ptr)
+EOF_HUNK
+string& get::it::RIGHT(char *ptr)
+{
+	ChangeMe;
+}
+EOF_TEST
+
+test_diff_funcname 'cpp: gnu style function' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+RIGHT(int arg)
+EOF_HUNK
+const char *
+RIGHT(int arg)
+{
+	ChangeMe;
+}
+EOF_TEST
+
+test_diff_funcname 'cpp: namespace definition' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+namespace RIGHT
+EOF_HUNK
+namespace RIGHT
+{
+	ChangeMe;
+}
+EOF_TEST
+
+test_diff_funcname 'cpp: operator definition' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+Value operator+(Value LEFT, Value RIGHT)
+EOF_HUNK
+Value operator+(Value LEFT, Value RIGHT)
+{
+	ChangeMe;
+}
+EOF_TEST
+
+test_diff_funcname 'cpp: skip access specifiers' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+class RIGHT : public Baseclass
+EOF_HUNK
+class RIGHT : public Baseclass
+{
+public:
+protected:
+private:
+	void DoSomething();
+	int ChangeMe;
+};
+EOF_TEST
+
+test_diff_funcname 'cpp: skip comment block' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+struct item RIGHT(int i)
+EOF_HUNK
+struct item RIGHT(int i)
+// Do not
+// pick up
+/* these
+** comments.
+*/
+{
+	ChangeMe;
+}
+EOF_TEST
+
+test_diff_funcname 'cpp: skip labels' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+void RIGHT (void)
+EOF_HUNK
+void RIGHT (void)
+{
+repeat:		// C++ comment
+next:		/* C comment */
+	do_something();
+
+	ChangeMe;
+}
+EOF_TEST
+
+test_diff_funcname 'cpp: struct definition' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+struct RIGHT {
+EOF_HUNK
+struct RIGHT {
+	unsigned
+	/* this bit field looks like a label and should not be picked up */
+		decoy_bitfield: 2,
+		more : 1;
+	int filler;
+
+	int ChangeMe;
+};
+EOF_TEST
+
+test_diff_funcname 'cpp: struct single line' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+struct RIGHT_iterator_tag {};
+EOF_HUNK
+void wrong()
+{
+}
+
+struct RIGHT_iterator_tag {};
+
+int ChangeMe;
+EOF_TEST
+
+test_diff_funcname 'cpp: template function definition' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+template<class T> int RIGHT(T arg)
+EOF_HUNK
+template<class T> int RIGHT(T arg)
+{
+	ChangeMe;
+}
+EOF_TEST
+
+test_diff_funcname 'cpp: union definition' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+union RIGHT {
+EOF_HUNK
+union RIGHT {
+	double v;
+	int ChangeMe;
+};
+EOF_TEST
+
+test_diff_funcname 'cpp: void c function' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+void RIGHT (void)
+EOF_HUNK
+void RIGHT (void)
+{
+	ChangeMe;
+}
+EOF_TEST
diff --git a/t/t4018/css-attribute-value-selector b/t/t4018/css-attribute-value-selector
deleted file mode 100644
index 918256b20c..0000000000
--- a/t/t4018/css-attribute-value-selector
+++ /dev/null
@@ -1,4 +0,0 @@
-[class*="RIGHT"] {
-    background : #000;
-    border : 10px ChangeMe #C6C6C6;
-}
diff --git a/t/t4018/css-attribute-value-selector.ctx b/t/t4018/css-attribute-value-selector.ctx
deleted file mode 100644
index 7f8956251c..0000000000
--- a/t/t4018/css-attribute-value-selector.ctx
+++ /dev/null
@@ -1 +0,0 @@
-[class*="RIGHT"] {
diff --git a/t/t4018/css-block-level-@-statements b/t/t4018/css-block-level-@-statements
deleted file mode 100644
index d6755f2f3d..0000000000
--- a/t/t4018/css-block-level-@-statements
+++ /dev/null
@@ -1,10 +0,0 @@
-@keyframes RIGHT {
-    from {
-        background : #000;
-        border : 10px ChangeMe #C6C6C6;
-    }
-    to {
-        background : #fff;
-        border : 10px solid #C6C6C6;
-    }
-}
diff --git a/t/t4018/css-block-level-@-statements.ctx b/t/t4018/css-block-level-@-statements.ctx
deleted file mode 100644
index 7f5e90468c..0000000000
--- a/t/t4018/css-block-level-@-statements.ctx
+++ /dev/null
@@ -1 +0,0 @@
-@keyframes RIGHT {
diff --git a/t/t4018/css-brace-in-col-1 b/t/t4018/css-brace-in-col-1
deleted file mode 100644
index 7831577506..0000000000
--- a/t/t4018/css-brace-in-col-1
+++ /dev/null
@@ -1,5 +0,0 @@
-RIGHT label.control-label
-{
-    margin-top: 10px!important;
-    border : 10px ChangeMe #C6C6C6;
-}
diff --git a/t/t4018/css-brace-in-col-1.ctx b/t/t4018/css-brace-in-col-1.ctx
deleted file mode 100644
index 91a9105c6a..0000000000
--- a/t/t4018/css-brace-in-col-1.ctx
+++ /dev/null
@@ -1 +0,0 @@
-RIGHT label.control-label
diff --git a/t/t4018/css-class-selector b/t/t4018/css-class-selector
deleted file mode 100644
index f790a0062f..0000000000
--- a/t/t4018/css-class-selector
+++ /dev/null
@@ -1,4 +0,0 @@
-.RIGHT {
-    background : #000;
-    border : 10px ChangeMe #C6C6C6;
-}
diff --git a/t/t4018/css-class-selector.ctx b/t/t4018/css-class-selector.ctx
deleted file mode 100644
index ac7367d7f4..0000000000
--- a/t/t4018/css-class-selector.ctx
+++ /dev/null
@@ -1 +0,0 @@
-.RIGHT {
diff --git a/t/t4018/css-colon-eol b/t/t4018/css-colon-eol
deleted file mode 100644
index 5a30553d29..0000000000
--- a/t/t4018/css-colon-eol
+++ /dev/null
@@ -1,4 +0,0 @@
-RIGHT h1 {
-color:
-ChangeMe;
-}
diff --git a/t/t4018/css-colon-eol.ctx b/t/t4018/css-colon-eol.ctx
deleted file mode 100644
index b68493b9b0..0000000000
--- a/t/t4018/css-colon-eol.ctx
+++ /dev/null
@@ -1 +0,0 @@
-RIGHT h1 {
diff --git a/t/t4018/css-colon-selector b/t/t4018/css-colon-selector
deleted file mode 100644
index c6d71fb42d..0000000000
--- a/t/t4018/css-colon-selector
+++ /dev/null
@@ -1,5 +0,0 @@
-RIGHT a:hover {
-    margin-top:
-    10px!important;
-    border : 10px ChangeMe #C6C6C6;
-}
diff --git a/t/t4018/css-colon-selector.ctx b/t/t4018/css-colon-selector.ctx
deleted file mode 100644
index 00b1a5aefe..0000000000
--- a/t/t4018/css-colon-selector.ctx
+++ /dev/null
@@ -1 +0,0 @@
-RIGHT a:hover {
diff --git a/t/t4018/css-common b/t/t4018/css-common
deleted file mode 100644
index 84ed754b33..0000000000
--- a/t/t4018/css-common
+++ /dev/null
@@ -1,4 +0,0 @@
-RIGHT label.control-label {
-    margin-top: 10px!important;
-    border : 10px ChangeMe #C6C6C6;
-}
diff --git a/t/t4018/css-common.ctx b/t/t4018/css-common.ctx
deleted file mode 100644
index 43686b4081..0000000000
--- a/t/t4018/css-common.ctx
+++ /dev/null
@@ -1 +0,0 @@
-RIGHT label.control-label {
diff --git a/t/t4018/css-id-selector b/t/t4018/css-id-selector
deleted file mode 100644
index 17c5111052..0000000000
--- a/t/t4018/css-id-selector
+++ /dev/null
@@ -1,4 +0,0 @@
-#RIGHT {
-    background : #000;
-    border : 10px ChangeMe #C6C6C6;
-}
diff --git a/t/t4018/css-id-selector.ctx b/t/t4018/css-id-selector.ctx
deleted file mode 100644
index ce19f6d8dc..0000000000
--- a/t/t4018/css-id-selector.ctx
+++ /dev/null
@@ -1 +0,0 @@
-#RIGHT {
diff --git a/t/t4018/css-long-selector-list b/t/t4018/css-long-selector-list
deleted file mode 100644
index 7ccd25d9ed..0000000000
--- a/t/t4018/css-long-selector-list
+++ /dev/null
@@ -1,6 +0,0 @@
-p.header,
-label.control-label,
-div ul#RIGHT {
-    margin-top: 10px!important;
-    border : 10px ChangeMe #C6C6C6;
-}
diff --git a/t/t4018/css-long-selector-list.ctx b/t/t4018/css-long-selector-list.ctx
deleted file mode 100644
index bc8d0fb62c..0000000000
--- a/t/t4018/css-long-selector-list.ctx
+++ /dev/null
@@ -1 +0,0 @@
-div ul#RIGHT {
diff --git a/t/t4018/css-prop-sans-indent b/t/t4018/css-prop-sans-indent
deleted file mode 100644
index a9e3c86b3c..0000000000
--- a/t/t4018/css-prop-sans-indent
+++ /dev/null
@@ -1,5 +0,0 @@
-RIGHT, label.control-label {
-margin-top: 10px!important;
-padding: 0;
-border : 10px ChangeMe #C6C6C6;
-}
diff --git a/t/t4018/css-prop-sans-indent.ctx b/t/t4018/css-prop-sans-indent.ctx
deleted file mode 100644
index cc880b2f44..0000000000
--- a/t/t4018/css-prop-sans-indent.ctx
+++ /dev/null
@@ -1 +0,0 @@
-RIGHT, label.control-label {
diff --git a/t/t4018/css-root-selector b/t/t4018/css-root-selector
deleted file mode 100644
index 22b958e369..0000000000
--- a/t/t4018/css-root-selector
+++ /dev/null
@@ -1,4 +0,0 @@
-:RIGHT {
-    background : #000;
-    border : 10px ChangeMe #C6C6C6;
-}
diff --git a/t/t4018/css-root-selector.ctx b/t/t4018/css-root-selector.ctx
deleted file mode 100644
index 3010cded2a..0000000000
--- a/t/t4018/css-root-selector.ctx
+++ /dev/null
@@ -1 +0,0 @@
-:RIGHT {
diff --git a/t/t4018/css-short-selector-list b/t/t4018/css-short-selector-list
deleted file mode 100644
index 6a0bdee336..0000000000
--- a/t/t4018/css-short-selector-list
+++ /dev/null
@@ -1,4 +0,0 @@
-label.control, div ul#RIGHT {
-    margin-top: 10px!important;
-    border : 10px ChangeMe #C6C6C6;
-}
diff --git a/t/t4018/css-short-selector-list.ctx b/t/t4018/css-short-selector-list.ctx
deleted file mode 100644
index 9e5d87d126..0000000000
--- a/t/t4018/css-short-selector-list.ctx
+++ /dev/null
@@ -1 +0,0 @@
-label.control, div ul#RIGHT {
diff --git a/t/t4018/css-trailing-space b/t/t4018/css-trailing-space
deleted file mode 100644
index 32b5606c70..0000000000
--- a/t/t4018/css-trailing-space
+++ /dev/null
@@ -1,5 +0,0 @@
-RIGHT label.control-label {
-    margin:10px;   
-    padding:10px;
-    border : 10px ChangeMe #C6C6C6;
-}
diff --git a/t/t4018/css-trailing-space.ctx b/t/t4018/css-trailing-space.ctx
deleted file mode 100644
index 43686b4081..0000000000
--- a/t/t4018/css-trailing-space.ctx
+++ /dev/null
@@ -1 +0,0 @@
-RIGHT label.control-label {
diff --git a/t/t4018/css.sh b/t/t4018/css.sh
new file mode 100755
index 0000000000..106a3de242
--- /dev/null
+++ b/t/t4018/css.sh
@@ -0,0 +1,146 @@
+#!/bin/sh
+#
+# See ../t4018-diff-funcname.sh's test_diff_funcname()
+#
+
+test_diff_funcname 'css: attribute value selector' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+[class*="RIGHT"] {
+EOF_HUNK
+[class*="RIGHT"] {
+    background : #000;
+    border : 10px ChangeMe #C6C6C6;
+}
+EOF_TEST
+
+test_diff_funcname 'css: block level @ statements' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+@keyframes RIGHT {
+EOF_HUNK
+@keyframes RIGHT {
+    from {
+        background : #000;
+        border : 10px ChangeMe #C6C6C6;
+    }
+    to {
+        background : #fff;
+        border : 10px solid #C6C6C6;
+    }
+}
+EOF_TEST
+
+test_diff_funcname 'css: brace in col 1' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+RIGHT label.control-label
+EOF_HUNK
+RIGHT label.control-label
+{
+    margin-top: 10px!important;
+    border : 10px ChangeMe #C6C6C6;
+}
+EOF_TEST
+
+test_diff_funcname 'css: class selector' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+.RIGHT {
+EOF_HUNK
+.RIGHT {
+    background : #000;
+    border : 10px ChangeMe #C6C6C6;
+}
+EOF_TEST
+
+test_diff_funcname 'css: colon eol' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+RIGHT h1 {
+EOF_HUNK
+RIGHT h1 {
+color:
+ChangeMe;
+}
+EOF_TEST
+
+test_diff_funcname 'css: colon selector' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+RIGHT a:hover {
+EOF_HUNK
+RIGHT a:hover {
+    margin-top:
+    10px!important;
+    border : 10px ChangeMe #C6C6C6;
+}
+EOF_TEST
+
+test_diff_funcname 'css: common' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+RIGHT label.control-label {
+EOF_HUNK
+RIGHT label.control-label {
+    margin-top: 10px!important;
+    border : 10px ChangeMe #C6C6C6;
+}
+EOF_TEST
+
+test_diff_funcname 'css: id selector' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+#RIGHT {
+EOF_HUNK
+#RIGHT {
+    background : #000;
+    border : 10px ChangeMe #C6C6C6;
+}
+EOF_TEST
+
+test_diff_funcname 'css: long selector list' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+div ul#RIGHT {
+EOF_HUNK
+p.header,
+label.control-label,
+div ul#RIGHT {
+    margin-top: 10px!important;
+    border : 10px ChangeMe #C6C6C6;
+}
+EOF_TEST
+
+test_diff_funcname 'css: prop sans indent' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+RIGHT, label.control-label {
+EOF_HUNK
+RIGHT, label.control-label {
+margin-top: 10px!important;
+padding: 0;
+border : 10px ChangeMe #C6C6C6;
+}
+EOF_TEST
+
+test_diff_funcname 'css: root selector' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+:RIGHT {
+EOF_HUNK
+:RIGHT {
+    background : #000;
+    border : 10px ChangeMe #C6C6C6;
+}
+EOF_TEST
+
+test_diff_funcname 'css: short selector list' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+label.control, div ul#RIGHT {
+EOF_HUNK
+label.control, div ul#RIGHT {
+    margin-top: 10px!important;
+    border : 10px ChangeMe #C6C6C6;
+}
+EOF_TEST
+
+test_diff_funcname 'css: trailing space' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+RIGHT label.control-label {
+EOF_HUNK
+RIGHT label.control-label {
+    margin:10px;   
+    padding:10px;
+    border : 10px ChangeMe #C6C6C6;
+}
+EOF_TEST
diff --git a/t/t4018/custom1-pattern.ctx b/t/t4018/custom1-pattern.ctx
deleted file mode 100644
index d1609cc9a6..0000000000
--- a/t/t4018/custom1-pattern.ctx
+++ /dev/null
@@ -1 +0,0 @@
-int special, RIGHT;
diff --git a/t/t4018/custom1-pattern b/t/t4018/custom1.sh
old mode 100644
new mode 100755
similarity index 71%
rename from t/t4018/custom1-pattern
rename to t/t4018/custom1.sh
index e8fd59f884..f8bbccadb4
--- a/t/t4018/custom1-pattern
+++ b/t/t4018/custom1.sh
@@ -1,3 +1,12 @@
+#!/bin/sh
+#
+# See ../t4018-diff-funcname.sh's test_diff_funcname()
+#
+
+test_diff_funcname 'custom1: pattern' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+int special, RIGHT;
+EOF_HUNK
 public class Beer
 {
 	int special, RIGHT;
@@ -15,3 +24,4 @@ public class Beer
 			+ "99 bottles of beer on the wall.\n");
 	}
 }
+EOF_TEST
diff --git a/t/t4018/custom2-match-to-end-of-line b/t/t4018/custom2-match-to-end-of-line
deleted file mode 100644
index f88ac318b7..0000000000
--- a/t/t4018/custom2-match-to-end-of-line
+++ /dev/null
@@ -1,8 +0,0 @@
-public class RIGHT_Beer
-{
-	int special;
-	public static void main(String args[])
-	{
-		System.out.print("ChangeMe");
-	}
-}
diff --git a/t/t4018/custom2-match-to-end-of-line.ctx b/t/t4018/custom2-match-to-end-of-line.ctx
deleted file mode 100644
index 8294c6e49b..0000000000
--- a/t/t4018/custom2-match-to-end-of-line.ctx
+++ /dev/null
@@ -1 +0,0 @@
-RIGHT_Beer
diff --git a/t/t4018/custom2.sh b/t/t4018/custom2.sh
new file mode 100755
index 0000000000..c68421f788
--- /dev/null
+++ b/t/t4018/custom2.sh
@@ -0,0 +1,18 @@
+#!/bin/sh
+#
+# See ../t4018-diff-funcname.sh's test_diff_funcname()
+#
+
+test_diff_funcname 'custom2: match to end of line' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+RIGHT_Beer
+EOF_HUNK
+public class RIGHT_Beer
+{
+	int special;
+	public static void main(String args[])
+	{
+		System.out.print("ChangeMe");
+	}
+}
+EOF_TEST
diff --git a/t/t4018/custom3-alternation-in-pattern.ctx b/t/t4018/custom3-alternation-in-pattern.ctx
deleted file mode 100644
index 2125474b68..0000000000
--- a/t/t4018/custom3-alternation-in-pattern.ctx
+++ /dev/null
@@ -1 +0,0 @@
-public static void main(String RIGHT[])
diff --git a/t/t4018/custom3-alternation-in-pattern b/t/t4018/custom3.sh
old mode 100644
new mode 100755
similarity index 66%
rename from t/t4018/custom3-alternation-in-pattern
rename to t/t4018/custom3.sh
index 5f3769c64f..07c5c134ff
--- a/t/t4018/custom3-alternation-in-pattern
+++ b/t/t4018/custom3.sh
@@ -1,3 +1,12 @@
+#!/bin/sh
+#
+# See ../t4018-diff-funcname.sh's test_diff_funcname()
+#
+
+test_diff_funcname 'custom3: alternation in pattern' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+public static void main(String RIGHT[])
+EOF_HUNK
 public class Beer
 {
 	int special;
@@ -15,3 +24,4 @@ public class Beer
 			+ "99 bottles of beer on the wall.\n");
 	}
 }
+EOF_TEST
diff --git a/t/t4018/dts-labels b/t/t4018/dts-labels
deleted file mode 100644
index b21ef8737b..0000000000
--- a/t/t4018/dts-labels
+++ /dev/null
@@ -1,9 +0,0 @@
-/ {
-	label_1: node1@ff00 {
-		label2: RIGHT {
-			vendor,some-property;
-
-			ChangeMe = <0x45-30>;
-		};
-	};
-};
diff --git a/t/t4018/dts-labels.ctx b/t/t4018/dts-labels.ctx
deleted file mode 100644
index 48d9373cab..0000000000
--- a/t/t4018/dts-labels.ctx
+++ /dev/null
@@ -1 +0,0 @@
-label2: RIGHT {
diff --git a/t/t4018/dts-node-unitless b/t/t4018/dts-node-unitless
deleted file mode 100644
index c5287d9141..0000000000
--- a/t/t4018/dts-node-unitless
+++ /dev/null
@@ -1,8 +0,0 @@
-/ {
-	label_1: node1 {
-		RIGHT {
-			prop-array = <1>, <4>;
-			ChangeMe = <0xffeedd00>;
-		};
-	};
-};
diff --git a/t/t4018/dts-node-unitless.ctx b/t/t4018/dts-node-unitless.ctx
deleted file mode 100644
index 82c8683fa1..0000000000
--- a/t/t4018/dts-node-unitless.ctx
+++ /dev/null
@@ -1 +0,0 @@
-RIGHT {
diff --git a/t/t4018/dts-nodes b/t/t4018/dts-nodes
deleted file mode 100644
index 5a4334bb16..0000000000
--- a/t/t4018/dts-nodes
+++ /dev/null
@@ -1,8 +0,0 @@
-/ {
-	label_1: node1@ff00 {
-		RIGHT@deadf00,4000 {
-			#size-cells = <1>;
-			ChangeMe = <0xffeedd00>;
-		};
-	};
-};
diff --git a/t/t4018/dts-nodes-boolean-prop b/t/t4018/dts-nodes-boolean-prop
deleted file mode 100644
index afc6b5b404..0000000000
--- a/t/t4018/dts-nodes-boolean-prop
+++ /dev/null
@@ -1,9 +0,0 @@
-/ {
-	label_1: node1@ff00 {
-		RIGHT@deadf00,4000 {
-			boolean-prop1;
-
-			ChangeMe;
-		};
-	};
-};
diff --git a/t/t4018/dts-nodes-boolean-prop.ctx b/t/t4018/dts-nodes-boolean-prop.ctx
deleted file mode 100644
index 3a0232d55d..0000000000
--- a/t/t4018/dts-nodes-boolean-prop.ctx
+++ /dev/null
@@ -1 +0,0 @@
-RIGHT@deadf00,4000 {
diff --git a/t/t4018/dts-nodes-comment1 b/t/t4018/dts-nodes-comment1
deleted file mode 100644
index 559dfce9b3..0000000000
--- a/t/t4018/dts-nodes-comment1
+++ /dev/null
@@ -1,8 +0,0 @@
-/ {
-	label_1: node1@ff00 {
-		RIGHT@deadf00,4000 /* &a comment */ {
-			#size-cells = <1>;
-			ChangeMe = <0xffeedd00>;
-		};
-	};
-};
diff --git a/t/t4018/dts-nodes-comment1.ctx b/t/t4018/dts-nodes-comment1.ctx
deleted file mode 100644
index ec364600b1..0000000000
--- a/t/t4018/dts-nodes-comment1.ctx
+++ /dev/null
@@ -1 +0,0 @@
-RIGHT@deadf00,4000 /* &a comment */ {
diff --git a/t/t4018/dts-nodes-comment2 b/t/t4018/dts-nodes-comment2
deleted file mode 100644
index 27e9718b31..0000000000
--- a/t/t4018/dts-nodes-comment2
+++ /dev/null
@@ -1,8 +0,0 @@
-/ {
-	label_1: node1@ff00 {
-		RIGHT@deadf00,4000 { /* a trailing comment */ 
-			#size-cells = <1>;
-			ChangeMe = <0xffeedd00>;
-		};
-	};
-};
diff --git a/t/t4018/dts-nodes-comment2.ctx b/t/t4018/dts-nodes-comment2.ctx
deleted file mode 100644
index 75f0d75258..0000000000
--- a/t/t4018/dts-nodes-comment2.ctx
+++ /dev/null
@@ -1 +0,0 @@
-RIGHT@deadf00,4000 { /* a trailing comment */
diff --git a/t/t4018/dts-nodes-multiline-prop b/t/t4018/dts-nodes-multiline-prop
deleted file mode 100644
index 072d58b69d..0000000000
--- a/t/t4018/dts-nodes-multiline-prop
+++ /dev/null
@@ -1,13 +0,0 @@
-/ {
-	label_1: node1@ff00 {
-		RIGHT@deadf00,4000 {
-			multilineprop = <3>,
-					<4>,
-					<5>,
-					<6>,
-					<7>;
-
-			ChangeMe = <0xffeedd00>;
-		};
-	};
-};
diff --git a/t/t4018/dts-nodes-multiline-prop.ctx b/t/t4018/dts-nodes-multiline-prop.ctx
deleted file mode 100644
index 3a0232d55d..0000000000
--- a/t/t4018/dts-nodes-multiline-prop.ctx
+++ /dev/null
@@ -1 +0,0 @@
-RIGHT@deadf00,4000 {
diff --git a/t/t4018/dts-nodes.ctx b/t/t4018/dts-nodes.ctx
deleted file mode 100644
index 3a0232d55d..0000000000
--- a/t/t4018/dts-nodes.ctx
+++ /dev/null
@@ -1 +0,0 @@
-RIGHT@deadf00,4000 {
diff --git a/t/t4018/dts-reference b/t/t4018/dts-reference
deleted file mode 100644
index 8f0c87d863..0000000000
--- a/t/t4018/dts-reference
+++ /dev/null
@@ -1,9 +0,0 @@
-&label_1 {
-	TEST = <455>;
-};
-
-&RIGHT {
-	vendor,some-property;
-
-	ChangeMe = <0x45-30>;
-};
diff --git a/t/t4018/dts-reference.ctx b/t/t4018/dts-reference.ctx
deleted file mode 100644
index c1e13409ee..0000000000
--- a/t/t4018/dts-reference.ctx
+++ /dev/null
@@ -1 +0,0 @@
-&RIGHT {
diff --git a/t/t4018/dts-root b/t/t4018/dts-root
deleted file mode 100644
index 4353b8220c..0000000000
--- a/t/t4018/dts-root
+++ /dev/null
@@ -1,5 +0,0 @@
-/ { RIGHT /* Technically just supposed to be a slash and brace */
-	#size-cells = <1>;
-
-	ChangeMe = <0xffeedd00>;
-};
diff --git a/t/t4018/dts-root-comment b/t/t4018/dts-root-comment
deleted file mode 100644
index 333a625c70..0000000000
--- a/t/t4018/dts-root-comment
+++ /dev/null
@@ -1,8 +0,0 @@
-/ { RIGHT /* Technically just supposed to be a slash and brace */
-	#size-cells = <1>;
-
-	/* This comment should be ignored */
-
-	some-property = <40+2>;
-	ChangeMe = <0xffeedd00>;
-};
diff --git a/t/t4018/dts-root-comment.ctx b/t/t4018/dts-root-comment.ctx
deleted file mode 100644
index 656053dd42..0000000000
--- a/t/t4018/dts-root-comment.ctx
+++ /dev/null
@@ -1 +0,0 @@
-/ { RIGHT /* Technically just supposed to be a slash and brace */
diff --git a/t/t4018/dts-root.ctx b/t/t4018/dts-root.ctx
deleted file mode 100644
index 656053dd42..0000000000
--- a/t/t4018/dts-root.ctx
+++ /dev/null
@@ -1 +0,0 @@
-/ { RIGHT /* Technically just supposed to be a slash and brace */
diff --git a/t/t4018/dts.sh b/t/t4018/dts.sh
new file mode 100755
index 0000000000..304c131d86
--- /dev/null
+++ b/t/t4018/dts.sh
@@ -0,0 +1,149 @@
+#!/bin/sh
+#
+# See ../t4018-diff-funcname.sh's test_diff_funcname()
+#
+
+test_diff_funcname 'dts: labels' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+label2: RIGHT {
+EOF_HUNK
+/ {
+	label_1: node1@ff00 {
+		label2: RIGHT {
+			vendor,some-property;
+
+			ChangeMe = <0x45-30>;
+		};
+	};
+};
+EOF_TEST
+
+test_diff_funcname 'dts: node unitless' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+RIGHT {
+EOF_HUNK
+/ {
+	label_1: node1 {
+		RIGHT {
+			prop-array = <1>, <4>;
+			ChangeMe = <0xffeedd00>;
+		};
+	};
+};
+EOF_TEST
+
+test_diff_funcname 'dts: nodes' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+RIGHT@deadf00,4000 {
+EOF_HUNK
+/ {
+	label_1: node1@ff00 {
+		RIGHT@deadf00,4000 {
+			#size-cells = <1>;
+			ChangeMe = <0xffeedd00>;
+		};
+	};
+};
+EOF_TEST
+
+test_diff_funcname 'dts: nodes boolean prop' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+RIGHT@deadf00,4000 {
+EOF_HUNK
+/ {
+	label_1: node1@ff00 {
+		RIGHT@deadf00,4000 {
+			boolean-prop1;
+
+			ChangeMe;
+		};
+	};
+};
+EOF_TEST
+
+test_diff_funcname 'dts: nodes comment1' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+RIGHT@deadf00,4000 /* &a comment */ {
+EOF_HUNK
+/ {
+	label_1: node1@ff00 {
+		RIGHT@deadf00,4000 /* &a comment */ {
+			#size-cells = <1>;
+			ChangeMe = <0xffeedd00>;
+		};
+	};
+};
+EOF_TEST
+
+test_diff_funcname 'dts: nodes comment2' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+RIGHT@deadf00,4000 { /* a trailing comment */
+EOF_HUNK
+/ {
+	label_1: node1@ff00 {
+		RIGHT@deadf00,4000 { /* a trailing comment */ 
+			#size-cells = <1>;
+			ChangeMe = <0xffeedd00>;
+		};
+	};
+};
+EOF_TEST
+
+test_diff_funcname 'dts: nodes multiline prop' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+RIGHT@deadf00,4000 {
+EOF_HUNK
+/ {
+	label_1: node1@ff00 {
+		RIGHT@deadf00,4000 {
+			multilineprop = <3>,
+					<4>,
+					<5>,
+					<6>,
+					<7>;
+
+			ChangeMe = <0xffeedd00>;
+		};
+	};
+};
+EOF_TEST
+
+test_diff_funcname 'dts: reference' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+&RIGHT {
+EOF_HUNK
+&label_1 {
+	TEST = <455>;
+};
+
+&RIGHT {
+	vendor,some-property;
+
+	ChangeMe = <0x45-30>;
+};
+EOF_TEST
+
+test_diff_funcname 'dts: root' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+/ { RIGHT /* Technically just supposed to be a slash and brace */
+EOF_HUNK
+/ { RIGHT /* Technically just supposed to be a slash and brace */
+	#size-cells = <1>;
+
+	ChangeMe = <0xffeedd00>;
+};
+EOF_TEST
+
+test_diff_funcname 'dts: root comment' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+/ { RIGHT /* Technically just supposed to be a slash and brace */
+EOF_HUNK
+/ { RIGHT /* Technically just supposed to be a slash and brace */
+	#size-cells = <1>;
+
+	/* This comment should be ignored */
+
+	some-property = <40+2>;
+	ChangeMe = <0xffeedd00>;
+};
+EOF_TEST
diff --git a/t/t4018/elixir-do-not-pick-end b/t/t4018/elixir-do-not-pick-end
deleted file mode 100644
index fae08ba7e8..0000000000
--- a/t/t4018/elixir-do-not-pick-end
+++ /dev/null
@@ -1,5 +0,0 @@
-defmodule RIGHT do
-end
-#
-#
-# ChangeMe; do not pick up 'end' line
diff --git a/t/t4018/elixir-do-not-pick-end.ctx b/t/t4018/elixir-do-not-pick-end.ctx
deleted file mode 100644
index 8f28a7a689..0000000000
--- a/t/t4018/elixir-do-not-pick-end.ctx
+++ /dev/null
@@ -1 +0,0 @@
-defmodule RIGHT do
diff --git a/t/t4018/elixir-ex-unit-test b/t/t4018/elixir-ex-unit-test
deleted file mode 100644
index 0560a2b697..0000000000
--- a/t/t4018/elixir-ex-unit-test
+++ /dev/null
@@ -1,6 +0,0 @@
-defmodule Test do
-  test "RIGHT" do
-    assert true == true
-    assert ChangeMe
-  end
-end
diff --git a/t/t4018/elixir-ex-unit-test.ctx b/t/t4018/elixir-ex-unit-test.ctx
deleted file mode 100644
index a55e3de2cc..0000000000
--- a/t/t4018/elixir-ex-unit-test.ctx
+++ /dev/null
@@ -1 +0,0 @@
-test "RIGHT" do
diff --git a/t/t4018/elixir-function b/t/t4018/elixir-function
deleted file mode 100644
index d452f495a7..0000000000
--- a/t/t4018/elixir-function
+++ /dev/null
@@ -1,5 +0,0 @@
-def function(RIGHT, arg) do
-  # comment
-  # comment
-  ChangeMe
-end
diff --git a/t/t4018/elixir-function.ctx b/t/t4018/elixir-function.ctx
deleted file mode 100644
index 62aee9c8b1..0000000000
--- a/t/t4018/elixir-function.ctx
+++ /dev/null
@@ -1 +0,0 @@
-def function(RIGHT, arg) do
diff --git a/t/t4018/elixir-macro b/t/t4018/elixir-macro
deleted file mode 100644
index 4f925e9ad4..0000000000
--- a/t/t4018/elixir-macro
+++ /dev/null
@@ -1,5 +0,0 @@
-defmacro foo(RIGHT) do
-  # Code
-  # Code
-  ChangeMe
-end
diff --git a/t/t4018/elixir-macro.ctx b/t/t4018/elixir-macro.ctx
deleted file mode 100644
index fc1d3b85e8..0000000000
--- a/t/t4018/elixir-macro.ctx
+++ /dev/null
@@ -1 +0,0 @@
-defmacro foo(RIGHT) do
diff --git a/t/t4018/elixir-module b/t/t4018/elixir-module
deleted file mode 100644
index 91a4e7aa20..0000000000
--- a/t/t4018/elixir-module
+++ /dev/null
@@ -1,9 +0,0 @@
-defmodule RIGHT do
-  @moduledoc """
-  Foo bar
-  """
-
-  def ChangeMe(a) where is_map(a) do
-    a
-  end
-end
diff --git a/t/t4018/elixir-module-func b/t/t4018/elixir-module-func
deleted file mode 100644
index c9910d0675..0000000000
--- a/t/t4018/elixir-module-func
+++ /dev/null
@@ -1,8 +0,0 @@
-defmodule Foo do
-  def fun(RIGHT) do
-     # Code
-     # Code
-     # Code
-     ChangeMe
-  end
-end
diff --git a/t/t4018/elixir-module-func.ctx b/t/t4018/elixir-module-func.ctx
deleted file mode 100644
index 8239214386..0000000000
--- a/t/t4018/elixir-module-func.ctx
+++ /dev/null
@@ -1 +0,0 @@
-def fun(RIGHT) do
diff --git a/t/t4018/elixir-module.ctx b/t/t4018/elixir-module.ctx
deleted file mode 100644
index 8f28a7a689..0000000000
--- a/t/t4018/elixir-module.ctx
+++ /dev/null
@@ -1 +0,0 @@
-defmodule RIGHT do
diff --git a/t/t4018/elixir-nested-module b/t/t4018/elixir-nested-module
deleted file mode 100644
index 771ebc5c42..0000000000
--- a/t/t4018/elixir-nested-module
+++ /dev/null
@@ -1,9 +0,0 @@
-defmodule MyApp.RIGHT do
-  @moduledoc """
-  Foo bar
-  """
-
-  def ChangeMe(a) where is_map(a) do
-    a
-  end
-end
diff --git a/t/t4018/elixir-nested-module.ctx b/t/t4018/elixir-nested-module.ctx
deleted file mode 100644
index 3ffbdd18b1..0000000000
--- a/t/t4018/elixir-nested-module.ctx
+++ /dev/null
@@ -1 +0,0 @@
-defmodule MyApp.RIGHT do
diff --git a/t/t4018/elixir-private-function b/t/t4018/elixir-private-function
deleted file mode 100644
index 1aabe33b7a..0000000000
--- a/t/t4018/elixir-private-function
+++ /dev/null
@@ -1,5 +0,0 @@
-defp function(RIGHT, arg) do
-  # comment
-  # comment
-  ChangeMe
-end
diff --git a/t/t4018/elixir-private-function.ctx b/t/t4018/elixir-private-function.ctx
deleted file mode 100644
index 1c4eba44f7..0000000000
--- a/t/t4018/elixir-private-function.ctx
+++ /dev/null
@@ -1 +0,0 @@
-defp function(RIGHT, arg) do
diff --git a/t/t4018/elixir-protocol b/t/t4018/elixir-protocol
deleted file mode 100644
index 7d9173691e..0000000000
--- a/t/t4018/elixir-protocol
+++ /dev/null
@@ -1,6 +0,0 @@
-defprotocol RIGHT do
-  @doc """
-  Calculates the size (and not the length!) of a data structure
-  """
-  def size(data, ChangeMe)
-end
diff --git a/t/t4018/elixir-protocol-implementation b/t/t4018/elixir-protocol-implementation
deleted file mode 100644
index f9234bbfc4..0000000000
--- a/t/t4018/elixir-protocol-implementation
+++ /dev/null
@@ -1,5 +0,0 @@
-defimpl RIGHT do
-  # Docs
-  # Docs
-  def foo(ChangeMe), do: :ok
-end
diff --git a/t/t4018/elixir-protocol-implementation.ctx b/t/t4018/elixir-protocol-implementation.ctx
deleted file mode 100644
index efb758aea6..0000000000
--- a/t/t4018/elixir-protocol-implementation.ctx
+++ /dev/null
@@ -1 +0,0 @@
-defimpl RIGHT do
diff --git a/t/t4018/elixir-protocol.ctx b/t/t4018/elixir-protocol.ctx
deleted file mode 100644
index d0204e9f14..0000000000
--- a/t/t4018/elixir-protocol.ctx
+++ /dev/null
@@ -1 +0,0 @@
-defprotocol RIGHT do
diff --git a/t/t4018/elixir.sh b/t/t4018/elixir.sh
new file mode 100755
index 0000000000..6b09df9520
--- /dev/null
+++ b/t/t4018/elixir.sh
@@ -0,0 +1,127 @@
+#!/bin/sh
+#
+# See ../t4018-diff-funcname.sh's test_diff_funcname()
+#
+
+test_diff_funcname 'elixir: do not pick end' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+defmodule RIGHT do
+EOF_HUNK
+defmodule RIGHT do
+end
+#
+#
+# ChangeMe; do not pick up 'end' line
+EOF_TEST
+
+test_diff_funcname 'elixir: ex unit test' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+test "RIGHT" do
+EOF_HUNK
+defmodule Test do
+  test "RIGHT" do
+    assert true == true
+    assert ChangeMe
+  end
+end
+EOF_TEST
+
+test_diff_funcname 'elixir: function' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+def function(RIGHT, arg) do
+EOF_HUNK
+def function(RIGHT, arg) do
+  # comment
+  # comment
+  ChangeMe
+end
+EOF_TEST
+
+test_diff_funcname 'elixir: macro' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+defmacro foo(RIGHT) do
+EOF_HUNK
+defmacro foo(RIGHT) do
+  # Code
+  # Code
+  ChangeMe
+end
+EOF_TEST
+
+test_diff_funcname 'elixir: module' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+defmodule RIGHT do
+EOF_HUNK
+defmodule RIGHT do
+  @moduledoc """
+  Foo bar
+  """
+
+  def ChangeMe(a) where is_map(a) do
+    a
+  end
+end
+EOF_TEST
+
+test_diff_funcname 'elixir: module func' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+def fun(RIGHT) do
+EOF_HUNK
+defmodule Foo do
+  def fun(RIGHT) do
+     # Code
+     # Code
+     # Code
+     ChangeMe
+  end
+end
+EOF_TEST
+
+test_diff_funcname 'elixir: nested module' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+defmodule MyApp.RIGHT do
+EOF_HUNK
+defmodule MyApp.RIGHT do
+  @moduledoc """
+  Foo bar
+  """
+
+  def ChangeMe(a) where is_map(a) do
+    a
+  end
+end
+EOF_TEST
+
+test_diff_funcname 'elixir: private function' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+defp function(RIGHT, arg) do
+EOF_HUNK
+defp function(RIGHT, arg) do
+  # comment
+  # comment
+  ChangeMe
+end
+EOF_TEST
+
+test_diff_funcname 'elixir: protocol' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+defprotocol RIGHT do
+EOF_HUNK
+defprotocol RIGHT do
+  @doc """
+  Calculates the size (and not the length!) of a data structure
+  """
+  def size(data, ChangeMe)
+end
+EOF_TEST
+
+test_diff_funcname 'elixir: protocol implementation' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+defimpl RIGHT do
+EOF_HUNK
+defimpl RIGHT do
+  # Docs
+  # Docs
+  def foo(ChangeMe), do: :ok
+end
+EOF_TEST
diff --git a/t/t4018/fortran-block-data b/t/t4018/fortran-block-data
deleted file mode 100644
index 63d4e21d0a..0000000000
--- a/t/t4018/fortran-block-data
+++ /dev/null
@@ -1,5 +0,0 @@
-       BLOCK DATA RIGHT
-       
-       COMMON /B/ C, ChangeMe
-       DATA C, ChangeMe  / 2.0, 6.0 / 
-       END 
diff --git a/t/t4018/fortran-block-data.ctx b/t/t4018/fortran-block-data.ctx
deleted file mode 100644
index c3db084ccc..0000000000
--- a/t/t4018/fortran-block-data.ctx
+++ /dev/null
@@ -1 +0,0 @@
-BLOCK DATA RIGHT
diff --git a/t/t4018/fortran-comment b/t/t4018/fortran-comment
deleted file mode 100644
index 7b10d17658..0000000000
--- a/t/t4018/fortran-comment
+++ /dev/null
@@ -1,13 +0,0 @@
-      module a
-
-      contains
-
-      ! subroutine wrong
-      subroutine RIGHT
-      ! subroutine wrong
-
-      real ChangeMe
-
-      end subroutine RIGHT
-
-      end module a
diff --git a/t/t4018/fortran-comment-keyword b/t/t4018/fortran-comment-keyword
deleted file mode 100644
index e9206a5379..0000000000
--- a/t/t4018/fortran-comment-keyword
+++ /dev/null
@@ -1,14 +0,0 @@
-      module a
-
-      contains
-
-      subroutine RIGHT (funcA, funcB)
-
-      real funcA  ! grid function a
-      real funcB  ! grid function b
-
-      real ChangeMe
-
-      end subroutine RIGHT
-
-      end module a
diff --git a/t/t4018/fortran-comment-keyword.ctx b/t/t4018/fortran-comment-keyword.ctx
deleted file mode 100644
index 0b9220b355..0000000000
--- a/t/t4018/fortran-comment-keyword.ctx
+++ /dev/null
@@ -1 +0,0 @@
-subroutine RIGHT (funcA, funcB)
diff --git a/t/t4018/fortran-comment-legacy b/t/t4018/fortran-comment-legacy
deleted file mode 100644
index 53cd062c1e..0000000000
--- a/t/t4018/fortran-comment-legacy
+++ /dev/null
@@ -1,13 +0,0 @@
-      module a
-
-      contains
-
-C subroutine wrong
-      subroutine RIGHT
-C subroutine wrong
-
-      real ChangeMe
-
-      end subroutine RIGHT
-
-      end module a
diff --git a/t/t4018/fortran-comment-legacy-star b/t/t4018/fortran-comment-legacy-star
deleted file mode 100644
index 2cbcdc3d8a..0000000000
--- a/t/t4018/fortran-comment-legacy-star
+++ /dev/null
@@ -1,13 +0,0 @@
-      module a
-
-      contains
-
-* subroutine wrong
-      subroutine RIGHT
-* subroutine wrong
-
-      real ChangeMe
-
-      end subroutine RIGHT
-
-      end module a
diff --git a/t/t4018/fortran-comment-legacy-star.ctx b/t/t4018/fortran-comment-legacy-star.ctx
deleted file mode 100644
index 6a34203f80..0000000000
--- a/t/t4018/fortran-comment-legacy-star.ctx
+++ /dev/null
@@ -1 +0,0 @@
-subroutine RIGHT
diff --git a/t/t4018/fortran-comment-legacy.ctx b/t/t4018/fortran-comment-legacy.ctx
deleted file mode 100644
index 6a34203f80..0000000000
--- a/t/t4018/fortran-comment-legacy.ctx
+++ /dev/null
@@ -1 +0,0 @@
-subroutine RIGHT
diff --git a/t/t4018/fortran-comment.ctx b/t/t4018/fortran-comment.ctx
deleted file mode 100644
index 6a34203f80..0000000000
--- a/t/t4018/fortran-comment.ctx
+++ /dev/null
@@ -1 +0,0 @@
-subroutine RIGHT
diff --git a/t/t4018/fortran-external-function b/t/t4018/fortran-external-function
deleted file mode 100644
index 5a2d85d3aa..0000000000
--- a/t/t4018/fortran-external-function
+++ /dev/null
@@ -1,9 +0,0 @@
-function RIGHT(a, b) result(c)
-
-integer, intent(in) :: ChangeMe
-integer, intent(in) :: b
-integer, intent(out) :: c
-
-c = a+b
-
-end function RIGHT
diff --git a/t/t4018/fortran-external-function.ctx b/t/t4018/fortran-external-function.ctx
deleted file mode 100644
index 56ec4d8eca..0000000000
--- a/t/t4018/fortran-external-function.ctx
+++ /dev/null
@@ -1 +0,0 @@
-function RIGHT(a, b) result(c)
diff --git a/t/t4018/fortran-external-subroutine b/t/t4018/fortran-external-subroutine
deleted file mode 100644
index 4ce85fea13..0000000000
--- a/t/t4018/fortran-external-subroutine
+++ /dev/null
@@ -1,5 +0,0 @@
-subroutine RIGHT
-
-real ChangeMe
-
-end subroutine RIGHT
diff --git a/t/t4018/fortran-external-subroutine.ctx b/t/t4018/fortran-external-subroutine.ctx
deleted file mode 100644
index 6a34203f80..0000000000
--- a/t/t4018/fortran-external-subroutine.ctx
+++ /dev/null
@@ -1 +0,0 @@
-subroutine RIGHT
diff --git a/t/t4018/fortran-module b/t/t4018/fortran-module
deleted file mode 100644
index c4b737dac3..0000000000
--- a/t/t4018/fortran-module
+++ /dev/null
@@ -1,5 +0,0 @@
-module RIGHT
-
-use ChangeMe
-
-end module RIGHT
diff --git a/t/t4018/fortran-module-procedure b/t/t4018/fortran-module-procedure
deleted file mode 100644
index 1ce6d854c2..0000000000
--- a/t/t4018/fortran-module-procedure
+++ /dev/null
@@ -1,13 +0,0 @@
- module RIGHT
-
-   implicit none
-   private
-
-   interface letters  ! generic interface
-      module procedure aaaa, &
-                       bbbb, &
-                       ChangeMe, &
-                       dddd
-   end interface
-   
-end module RIGHT
diff --git a/t/t4018/fortran-module-procedure.ctx b/t/t4018/fortran-module-procedure.ctx
deleted file mode 100644
index 4f5ff2e4b8..0000000000
--- a/t/t4018/fortran-module-procedure.ctx
+++ /dev/null
@@ -1 +0,0 @@
-module RIGHT
diff --git a/t/t4018/fortran-module.ctx b/t/t4018/fortran-module.ctx
deleted file mode 100644
index 4f5ff2e4b8..0000000000
--- a/t/t4018/fortran-module.ctx
+++ /dev/null
@@ -1 +0,0 @@
-module RIGHT
diff --git a/t/t4018/fortran-program b/t/t4018/fortran-program
deleted file mode 100644
index 4616895e4b..0000000000
--- a/t/t4018/fortran-program
+++ /dev/null
@@ -1,5 +0,0 @@
-program RIGHT
-
-call ChangeMe
-
-end program RIGHT
diff --git a/t/t4018/fortran-program.ctx b/t/t4018/fortran-program.ctx
deleted file mode 100644
index c4e844df30..0000000000
--- a/t/t4018/fortran-program.ctx
+++ /dev/null
@@ -1 +0,0 @@
-program RIGHT
diff --git a/t/t4018/fortran.sh b/t/t4018/fortran.sh
new file mode 100755
index 0000000000..7b0c6789d3
--- /dev/null
+++ b/t/t4018/fortran.sh
@@ -0,0 +1,159 @@
+#!/bin/sh
+#
+# See ../t4018-diff-funcname.sh's test_diff_funcname()
+#
+
+test_diff_funcname 'fortran: block data' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+BLOCK DATA RIGHT
+EOF_HUNK
+       BLOCK DATA RIGHT
+       
+       COMMON /B/ C, ChangeMe
+       DATA C, ChangeMe  / 2.0, 6.0 / 
+       END 
+EOF_TEST
+
+test_diff_funcname 'fortran: comment' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+subroutine RIGHT
+EOF_HUNK
+      module a
+
+      contains
+
+      ! subroutine wrong
+      subroutine RIGHT
+      ! subroutine wrong
+
+      real ChangeMe
+
+      end subroutine RIGHT
+
+      end module a
+EOF_TEST
+
+test_diff_funcname 'fortran: comment keyword' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+subroutine RIGHT (funcA, funcB)
+EOF_HUNK
+      module a
+
+      contains
+
+      subroutine RIGHT (funcA, funcB)
+
+      real funcA  ! grid function a
+      real funcB  ! grid function b
+
+      real ChangeMe
+
+      end subroutine RIGHT
+
+      end module a
+EOF_TEST
+
+test_diff_funcname 'fortran: comment legacy' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+subroutine RIGHT
+EOF_HUNK
+      module a
+
+      contains
+
+C subroutine wrong
+      subroutine RIGHT
+C subroutine wrong
+
+      real ChangeMe
+
+      end subroutine RIGHT
+
+      end module a
+EOF_TEST
+
+test_diff_funcname 'fortran: comment legacy star' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+subroutine RIGHT
+EOF_HUNK
+      module a
+
+      contains
+
+* subroutine wrong
+      subroutine RIGHT
+* subroutine wrong
+
+      real ChangeMe
+
+      end subroutine RIGHT
+
+      end module a
+EOF_TEST
+
+test_diff_funcname 'fortran: external function' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+function RIGHT(a, b) result(c)
+EOF_HUNK
+function RIGHT(a, b) result(c)
+
+integer, intent(in) :: ChangeMe
+integer, intent(in) :: b
+integer, intent(out) :: c
+
+c = a+b
+
+end function RIGHT
+EOF_TEST
+
+test_diff_funcname 'fortran: external subroutine' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+subroutine RIGHT
+EOF_HUNK
+subroutine RIGHT
+
+real ChangeMe
+
+end subroutine RIGHT
+EOF_TEST
+
+test_diff_funcname 'fortran: module' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+module RIGHT
+EOF_HUNK
+module RIGHT
+
+use ChangeMe
+
+end module RIGHT
+EOF_TEST
+
+test_diff_funcname 'fortran: module procedure' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+module RIGHT
+EOF_HUNK
+ module RIGHT
+
+   implicit none
+   private
+
+   interface letters  ! generic interface
+      module procedure aaaa, &
+                       bbbb, &
+                       ChangeMe, &
+                       dddd
+   end interface
+   
+end module RIGHT
+EOF_TEST
+
+test_diff_funcname 'fortran: program' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+program RIGHT
+EOF_HUNK
+program RIGHT
+
+call ChangeMe
+
+end program RIGHT
+EOF_TEST
diff --git a/t/t4018/fountain-scene b/t/t4018/fountain-scene
deleted file mode 100644
index 6b3257d680..0000000000
--- a/t/t4018/fountain-scene
+++ /dev/null
@@ -1,4 +0,0 @@
-EXT. STREET RIGHT OUTSIDE - DAY
-
-CHARACTER
-You didn't say the magic phrase, "ChangeMe".
diff --git a/t/t4018/fountain-scene.ctx b/t/t4018/fountain-scene.ctx
deleted file mode 100644
index bf10171418..0000000000
--- a/t/t4018/fountain-scene.ctx
+++ /dev/null
@@ -1 +0,0 @@
-EXT. STREET RIGHT OUTSIDE - DAY
diff --git a/t/t4018/fountain.sh b/t/t4018/fountain.sh
new file mode 100755
index 0000000000..02b44d6a3f
--- /dev/null
+++ b/t/t4018/fountain.sh
@@ -0,0 +1,14 @@
+#!/bin/sh
+#
+# See ../t4018-diff-funcname.sh's test_diff_funcname()
+#
+
+test_diff_funcname 'fountain: scene' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+EXT. STREET RIGHT OUTSIDE - DAY
+EOF_HUNK
+EXT. STREET RIGHT OUTSIDE - DAY
+
+CHARACTER
+You didn't say the magic phrase, "ChangeMe".
+EOF_TEST
diff --git a/t/t4018/golang-complex-function b/t/t4018/golang-complex-function
deleted file mode 100644
index e057dcefed..0000000000
--- a/t/t4018/golang-complex-function
+++ /dev/null
@@ -1,8 +0,0 @@
-type Test struct {
-	a Type
-}
-
-func (t *Test) RIGHT(a Type) (Type, error) {
-	t.a = a
-	return ChangeMe, nil
-}
diff --git a/t/t4018/golang-complex-function.ctx b/t/t4018/golang-complex-function.ctx
deleted file mode 100644
index 8e8d5582ff..0000000000
--- a/t/t4018/golang-complex-function.ctx
+++ /dev/null
@@ -1 +0,0 @@
-func (t *Test) RIGHT(a Type) (Type, error) {
diff --git a/t/t4018/golang-func b/t/t4018/golang-func
deleted file mode 100644
index 8e9c9ac7c3..0000000000
--- a/t/t4018/golang-func
+++ /dev/null
@@ -1,4 +0,0 @@
-func RIGHT() {
-	a := 5
-	b := ChangeMe
-}
diff --git a/t/t4018/golang-func.ctx b/t/t4018/golang-func.ctx
deleted file mode 100644
index 88bc823813..0000000000
--- a/t/t4018/golang-func.ctx
+++ /dev/null
@@ -1 +0,0 @@
-func RIGHT() {
diff --git a/t/t4018/golang-interface b/t/t4018/golang-interface
deleted file mode 100644
index 553bedec96..0000000000
--- a/t/t4018/golang-interface
+++ /dev/null
@@ -1,4 +0,0 @@
-type RIGHT interface {
-	a() Type
-	b() ChangeMe
-}
diff --git a/t/t4018/golang-interface.ctx b/t/t4018/golang-interface.ctx
deleted file mode 100644
index 2d07f5a383..0000000000
--- a/t/t4018/golang-interface.ctx
+++ /dev/null
@@ -1 +0,0 @@
-type RIGHT interface {
diff --git a/t/t4018/golang-long-func b/t/t4018/golang-long-func
deleted file mode 100644
index ac3a77b5c4..0000000000
--- a/t/t4018/golang-long-func
+++ /dev/null
@@ -1,5 +0,0 @@
-func RIGHT(aVeryVeryVeryLongVariableName AVeryVeryVeryLongType,
-	anotherLongVariableName AnotherLongType) {
-	a := 5
-	b := ChangeMe
-}
diff --git a/t/t4018/golang-long-func.ctx b/t/t4018/golang-long-func.ctx
deleted file mode 100644
index 25635e712e..0000000000
--- a/t/t4018/golang-long-func.ctx
+++ /dev/null
@@ -1 +0,0 @@
-func RIGHT(aVeryVeryVeryLongVariableName AVeryVeryVeryLongType,
diff --git a/t/t4018/golang-struct b/t/t4018/golang-struct
deleted file mode 100644
index 5deda77fee..0000000000
--- a/t/t4018/golang-struct
+++ /dev/null
@@ -1,4 +0,0 @@
-type RIGHT struct {
-	a Type
-	b ChangeMe
-}
diff --git a/t/t4018/golang-struct.ctx b/t/t4018/golang-struct.ctx
deleted file mode 100644
index 8a1240699d..0000000000
--- a/t/t4018/golang-struct.ctx
+++ /dev/null
@@ -1 +0,0 @@
-type RIGHT struct {
diff --git a/t/t4018/golang.sh b/t/t4018/golang.sh
new file mode 100755
index 0000000000..bf22f58c12
--- /dev/null
+++ b/t/t4018/golang.sh
@@ -0,0 +1,59 @@
+#!/bin/sh
+#
+# See ../t4018-diff-funcname.sh's test_diff_funcname()
+#
+
+test_diff_funcname 'golang: complex function' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+func (t *Test) RIGHT(a Type) (Type, error) {
+EOF_HUNK
+type Test struct {
+	a Type
+}
+
+func (t *Test) RIGHT(a Type) (Type, error) {
+	t.a = a
+	return ChangeMe, nil
+}
+EOF_TEST
+
+test_diff_funcname 'golang: func' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+func RIGHT() {
+EOF_HUNK
+func RIGHT() {
+	a := 5
+	b := ChangeMe
+}
+EOF_TEST
+
+test_diff_funcname 'golang: interface' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+type RIGHT interface {
+EOF_HUNK
+type RIGHT interface {
+	a() Type
+	b() ChangeMe
+}
+EOF_TEST
+
+test_diff_funcname 'golang: long func' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+func RIGHT(aVeryVeryVeryLongVariableName AVeryVeryVeryLongType,
+EOF_HUNK
+func RIGHT(aVeryVeryVeryLongVariableName AVeryVeryVeryLongType,
+	anotherLongVariableName AnotherLongType) {
+	a := 5
+	b := ChangeMe
+}
+EOF_TEST
+
+test_diff_funcname 'golang: struct' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+type RIGHT struct {
+EOF_HUNK
+type RIGHT struct {
+	a Type
+	b ChangeMe
+}
+EOF_TEST
diff --git a/t/t4018/java-class-member-function b/t/t4018/java-class-member-function
deleted file mode 100644
index 298bc7a71b..0000000000
--- a/t/t4018/java-class-member-function
+++ /dev/null
@@ -1,8 +0,0 @@
-public class Beer
-{
-	int special;
-	public static void main(String RIGHT[])
-	{
-		System.out.print("ChangeMe");
-	}
-}
diff --git a/t/t4018/java-class-member-function.ctx b/t/t4018/java-class-member-function.ctx
deleted file mode 100644
index 2125474b68..0000000000
--- a/t/t4018/java-class-member-function.ctx
+++ /dev/null
@@ -1 +0,0 @@
-public static void main(String RIGHT[])
diff --git a/t/t4018/java.sh b/t/t4018/java.sh
new file mode 100755
index 0000000000..c89cf2f9d8
--- /dev/null
+++ b/t/t4018/java.sh
@@ -0,0 +1,18 @@
+#!/bin/sh
+#
+# See ../t4018-diff-funcname.sh's test_diff_funcname()
+#
+
+test_diff_funcname 'java: class member function' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+public static void main(String RIGHT[])
+EOF_HUNK
+public class Beer
+{
+	int special;
+	public static void main(String RIGHT[])
+	{
+		System.out.print("ChangeMe");
+	}
+}
+EOF_TEST
diff --git a/t/t4018/markdown-heading-indented b/t/t4018/markdown-heading-indented
deleted file mode 100644
index 1991c2bd45..0000000000
--- a/t/t4018/markdown-heading-indented
+++ /dev/null
@@ -1,6 +0,0 @@
-Indented headings are allowed, as long as the indent is no more than 3 spaces.
-
-   ### RIGHT
-
-- something
-- ChangeMe
diff --git a/t/t4018/markdown-heading-indented.ctx b/t/t4018/markdown-heading-indented.ctx
deleted file mode 100644
index 5938336743..0000000000
--- a/t/t4018/markdown-heading-indented.ctx
+++ /dev/null
@@ -1 +0,0 @@
-   ### RIGHT
diff --git a/t/t4018/markdown-heading-non-headings b/t/t4018/markdown-heading-non-headings
deleted file mode 100644
index c479c1a3f1..0000000000
--- a/t/t4018/markdown-heading-non-headings
+++ /dev/null
@@ -1,17 +0,0 @@
-Headings can be right next to other lines of the file:
-# RIGHT
-Indents of four or more spaces make a code block:
-
-    # code comment, not heading
-
-If there's no space after the final hash, it's not a heading:
-
-#hashtag
-
-Sequences of more than 6 hashes don't make a heading:
-
-####### over-enthusiastic heading
-
-So the detected heading should be right up at the start of this file.
-
-ChangeMe
diff --git a/t/t4018/markdown-heading-non-headings.ctx b/t/t4018/markdown-heading-non-headings.ctx
deleted file mode 100644
index 7e2165be6e..0000000000
--- a/t/t4018/markdown-heading-non-headings.ctx
+++ /dev/null
@@ -1 +0,0 @@
-# RIGHT
diff --git a/t/t4018/markdown.sh b/t/t4018/markdown.sh
new file mode 100755
index 0000000000..3e1c79b139
--- /dev/null
+++ b/t/t4018/markdown.sh
@@ -0,0 +1,39 @@
+#!/bin/sh
+#
+# See ../t4018-diff-funcname.sh's test_diff_funcname()
+#
+
+test_diff_funcname 'markdown: heading indented' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+   ### RIGHT
+EOF_HUNK
+Indented headings are allowed, as long as the indent is no more than 3 spaces.
+
+   ### RIGHT
+
+- something
+- ChangeMe
+EOF_TEST
+
+test_diff_funcname 'markdown: heading non headings' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+# RIGHT
+EOF_HUNK
+Headings can be right next to other lines of the file:
+# RIGHT
+Indents of four or more spaces make a code block:
+
+    # code comment, not heading
+
+If there's no space after the final hash, it's not a heading:
+
+#hashtag
+
+Sequences of more than 6 hashes don't make a heading:
+
+####### over-enthusiastic heading
+
+So the detected heading should be right up at the start of this file.
+
+ChangeMe
+EOF_TEST
diff --git a/t/t4018/matlab-class-definition b/t/t4018/matlab-class-definition
deleted file mode 100644
index 84daedfb4e..0000000000
--- a/t/t4018/matlab-class-definition
+++ /dev/null
@@ -1,5 +0,0 @@
-classdef RIGHT
-    properties
-        ChangeMe
-    end
-end
diff --git a/t/t4018/matlab-class-definition.ctx b/t/t4018/matlab-class-definition.ctx
deleted file mode 100644
index 5dd5b45628..0000000000
--- a/t/t4018/matlab-class-definition.ctx
+++ /dev/null
@@ -1 +0,0 @@
-classdef RIGHT
diff --git a/t/t4018/matlab-function b/t/t4018/matlab-function
deleted file mode 100644
index 897a9b13ff..0000000000
--- a/t/t4018/matlab-function
+++ /dev/null
@@ -1,4 +0,0 @@
-function y = RIGHT()
-x = 5;
-y = ChangeMe + x;
-end
diff --git a/t/t4018/matlab-function.ctx b/t/t4018/matlab-function.ctx
deleted file mode 100644
index 72d2350b13..0000000000
--- a/t/t4018/matlab-function.ctx
+++ /dev/null
@@ -1 +0,0 @@
-function y = RIGHT()
diff --git a/t/t4018/matlab-octave-section-1 b/t/t4018/matlab-octave-section-1
deleted file mode 100644
index 3bb6c4670e..0000000000
--- a/t/t4018/matlab-octave-section-1
+++ /dev/null
@@ -1,3 +0,0 @@
-%%% RIGHT section
-# this is octave script
-ChangeMe = 1;
diff --git a/t/t4018/matlab-octave-section-1.ctx b/t/t4018/matlab-octave-section-1.ctx
deleted file mode 100644
index ca9b349f94..0000000000
--- a/t/t4018/matlab-octave-section-1.ctx
+++ /dev/null
@@ -1 +0,0 @@
-%%% RIGHT section
diff --git a/t/t4018/matlab-octave-section-2 b/t/t4018/matlab-octave-section-2
deleted file mode 100644
index ab2980f7f2..0000000000
--- a/t/t4018/matlab-octave-section-2
+++ /dev/null
@@ -1,3 +0,0 @@
-## RIGHT section
-# this is octave script
-ChangeMe = 1;
diff --git a/t/t4018/matlab-octave-section-2.ctx b/t/t4018/matlab-octave-section-2.ctx
deleted file mode 100644
index 5cbb77faf5..0000000000
--- a/t/t4018/matlab-octave-section-2.ctx
+++ /dev/null
@@ -1 +0,0 @@
-## RIGHT section
diff --git a/t/t4018/matlab-section b/t/t4018/matlab-section
deleted file mode 100644
index 5ea59a5de0..0000000000
--- a/t/t4018/matlab-section
+++ /dev/null
@@ -1,3 +0,0 @@
-%% RIGHT section
-% this is understood by both matlab and octave
-ChangeMe = 1;
diff --git a/t/t4018/matlab-section.ctx b/t/t4018/matlab-section.ctx
deleted file mode 100644
index e83fee6f4d..0000000000
--- a/t/t4018/matlab-section.ctx
+++ /dev/null
@@ -1 +0,0 @@
-%% RIGHT section
diff --git a/t/t4018/matlab.sh b/t/t4018/matlab.sh
new file mode 100755
index 0000000000..f62289148e
--- /dev/null
+++ b/t/t4018/matlab.sh
@@ -0,0 +1,52 @@
+#!/bin/sh
+#
+# See ../t4018-diff-funcname.sh's test_diff_funcname()
+#
+
+test_diff_funcname 'matlab: class definition' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+classdef RIGHT
+EOF_HUNK
+classdef RIGHT
+    properties
+        ChangeMe
+    end
+end
+EOF_TEST
+
+test_diff_funcname 'matlab: function' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+function y = RIGHT()
+EOF_HUNK
+function y = RIGHT()
+x = 5;
+y = ChangeMe + x;
+end
+EOF_TEST
+
+test_diff_funcname 'matlab: octave section 1' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+%%% RIGHT section
+EOF_HUNK
+%%% RIGHT section
+# this is octave script
+ChangeMe = 1;
+EOF_TEST
+
+test_diff_funcname 'matlab: octave section 2' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+## RIGHT section
+EOF_HUNK
+## RIGHT section
+# this is octave script
+ChangeMe = 1;
+EOF_TEST
+
+test_diff_funcname 'matlab: section' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+%% RIGHT section
+EOF_HUNK
+%% RIGHT section
+% this is understood by both matlab and octave
+ChangeMe = 1;
+EOF_TEST
diff --git a/t/t4018/perl-skip-end-of-heredoc b/t/t4018/perl-skip-end-of-heredoc
deleted file mode 100644
index c22d39b256..0000000000
--- a/t/t4018/perl-skip-end-of-heredoc
+++ /dev/null
@@ -1,8 +0,0 @@
-sub RIGHTwithheredocument {
-	print <<"EOF"
-decoy here-doc
-EOF
-	# some lines of context
-	# to pad it out
-	print "ChangeMe\n";
-}
diff --git a/t/t4018/perl-skip-end-of-heredoc.ctx b/t/t4018/perl-skip-end-of-heredoc.ctx
deleted file mode 100644
index c15f4b78bd..0000000000
--- a/t/t4018/perl-skip-end-of-heredoc.ctx
+++ /dev/null
@@ -1 +0,0 @@
-sub RIGHTwithheredocument {
diff --git a/t/t4018/perl-skip-forward-decl b/t/t4018/perl-skip-forward-decl
deleted file mode 100644
index a98cb8bdad..0000000000
--- a/t/t4018/perl-skip-forward-decl
+++ /dev/null
@@ -1,10 +0,0 @@
-package RIGHT;
-
-use strict;
-use warnings;
-use parent qw(Exporter);
-our @EXPORT_OK = qw(round finalround);
-
-sub other; # forward declaration
-
-# ChangeMe
diff --git a/t/t4018/perl-skip-forward-decl.ctx b/t/t4018/perl-skip-forward-decl.ctx
deleted file mode 100644
index e0c51599ad..0000000000
--- a/t/t4018/perl-skip-forward-decl.ctx
+++ /dev/null
@@ -1 +0,0 @@
-package RIGHT;
diff --git a/t/t4018/perl-skip-sub-in-pod b/t/t4018/perl-skip-sub-in-pod
deleted file mode 100644
index e39f02462e..0000000000
--- a/t/t4018/perl-skip-sub-in-pod
+++ /dev/null
@@ -1,18 +0,0 @@
-=head1 NAME
-
-Beer - subroutine to output fragment of a drinking song
-
-=head1 SYNOPSIS_RIGHT
-
-	use Beer qw(round finalround);
-
-	sub song {
-		for (my $i = 99; $i > 0; $i--) {
-			round $i;
-		}
-		finalround;
-	}
-
-	ChangeMe;
-
-=cut
diff --git a/t/t4018/perl-skip-sub-in-pod.ctx b/t/t4018/perl-skip-sub-in-pod.ctx
deleted file mode 100644
index abddd76655..0000000000
--- a/t/t4018/perl-skip-sub-in-pod.ctx
+++ /dev/null
@@ -1 +0,0 @@
-=head1 SYNOPSIS_RIGHT
diff --git a/t/t4018/perl-sub-definition b/t/t4018/perl-sub-definition
deleted file mode 100644
index a507d1f645..0000000000
--- a/t/t4018/perl-sub-definition
+++ /dev/null
@@ -1,4 +0,0 @@
-sub RIGHT {
-	my ($n) = @_;
-	print "ChangeMe";
-}
diff --git a/t/t4018/perl-sub-definition-kr-brace b/t/t4018/perl-sub-definition-kr-brace
deleted file mode 100644
index 330b3df114..0000000000
--- a/t/t4018/perl-sub-definition-kr-brace
+++ /dev/null
@@ -1,4 +0,0 @@
-sub RIGHT
-{
-	print "ChangeMe\n";
-}
diff --git a/t/t4018/perl-sub-definition-kr-brace.ctx b/t/t4018/perl-sub-definition-kr-brace.ctx
deleted file mode 100644
index 7e5aee5cde..0000000000
--- a/t/t4018/perl-sub-definition-kr-brace.ctx
+++ /dev/null
@@ -1 +0,0 @@
-sub RIGHT
diff --git a/t/t4018/perl-sub-definition.ctx b/t/t4018/perl-sub-definition.ctx
deleted file mode 100644
index d49a63598e..0000000000
--- a/t/t4018/perl-sub-definition.ctx
+++ /dev/null
@@ -1 +0,0 @@
-sub RIGHT {
diff --git a/t/t4018/perl.sh b/t/t4018/perl.sh
new file mode 100755
index 0000000000..ac8fff7417
--- /dev/null
+++ b/t/t4018/perl.sh
@@ -0,0 +1,78 @@
+#!/bin/sh
+#
+# See ../t4018-diff-funcname.sh's test_diff_funcname()
+#
+
+test_diff_funcname 'perl: skip end of heredoc' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+sub RIGHTwithheredocument {
+EOF_HUNK
+sub RIGHTwithheredocument {
+	print <<"EOF"
+decoy here-doc
+EOF
+	# some lines of context
+	# to pad it out
+	print "ChangeMe\n";
+}
+EOF_TEST
+
+test_diff_funcname 'perl: skip forward decl' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+package RIGHT;
+EOF_HUNK
+package RIGHT;
+
+use strict;
+use warnings;
+use parent qw(Exporter);
+our @EXPORT_OK = qw(round finalround);
+
+sub other; # forward declaration
+
+# ChangeMe
+EOF_TEST
+
+test_diff_funcname 'perl: skip sub in pod' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+=head1 SYNOPSIS_RIGHT
+EOF_HUNK
+=head1 NAME
+
+Beer - subroutine to output fragment of a drinking song
+
+=head1 SYNOPSIS_RIGHT
+
+	use Beer qw(round finalround);
+
+	sub song {
+		for (my $i = 99; $i > 0; $i--) {
+			round $i;
+		}
+		finalround;
+	}
+
+	ChangeMe;
+
+=cut
+EOF_TEST
+
+test_diff_funcname 'perl: sub definition' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+sub RIGHT {
+EOF_HUNK
+sub RIGHT {
+	my ($n) = @_;
+	print "ChangeMe";
+}
+EOF_TEST
+
+test_diff_funcname 'perl: sub definition kr brace' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+sub RIGHT
+EOF_HUNK
+sub RIGHT
+{
+	print "ChangeMe\n";
+}
+EOF_TEST
diff --git a/t/t4018/php-abstract-class b/t/t4018/php-abstract-class
deleted file mode 100644
index 5213e12494..0000000000
--- a/t/t4018/php-abstract-class
+++ /dev/null
@@ -1,4 +0,0 @@
-abstract class RIGHT
-{
-    const FOO = 'ChangeMe';
-}
diff --git a/t/t4018/php-abstract-class.ctx b/t/t4018/php-abstract-class.ctx
deleted file mode 100644
index f572d2129b..0000000000
--- a/t/t4018/php-abstract-class.ctx
+++ /dev/null
@@ -1 +0,0 @@
-abstract class RIGHT
diff --git a/t/t4018/php-abstract-method b/t/t4018/php-abstract-method
deleted file mode 100644
index ce215df75a..0000000000
--- a/t/t4018/php-abstract-method
+++ /dev/null
@@ -1,7 +0,0 @@
-abstract class Klass
-{
-    abstract public function RIGHT(): ?string
-    {
-        return 'ChangeMe';
-    }
-}
diff --git a/t/t4018/php-abstract-method.ctx b/t/t4018/php-abstract-method.ctx
deleted file mode 100644
index 14cb6df42e..0000000000
--- a/t/t4018/php-abstract-method.ctx
+++ /dev/null
@@ -1 +0,0 @@
-abstract public function RIGHT(): ?string
diff --git a/t/t4018/php-class b/t/t4018/php-class
deleted file mode 100644
index 7785b6303c..0000000000
--- a/t/t4018/php-class
+++ /dev/null
@@ -1,4 +0,0 @@
-class RIGHT
-{
-    const FOO = 'ChangeMe';
-}
diff --git a/t/t4018/php-class.ctx b/t/t4018/php-class.ctx
deleted file mode 100644
index 54bff816d6..0000000000
--- a/t/t4018/php-class.ctx
+++ /dev/null
@@ -1 +0,0 @@
-class RIGHT
diff --git a/t/t4018/php-final-class b/t/t4018/php-final-class
deleted file mode 100644
index 69f5710552..0000000000
--- a/t/t4018/php-final-class
+++ /dev/null
@@ -1,4 +0,0 @@
-final class RIGHT
-{
-    const FOO = 'ChangeMe';
-}
diff --git a/t/t4018/php-final-class.ctx b/t/t4018/php-final-class.ctx
deleted file mode 100644
index 4d59fb749b..0000000000
--- a/t/t4018/php-final-class.ctx
+++ /dev/null
@@ -1 +0,0 @@
-final class RIGHT
diff --git a/t/t4018/php-final-method b/t/t4018/php-final-method
deleted file mode 100644
index 537fb8ad9a..0000000000
--- a/t/t4018/php-final-method
+++ /dev/null
@@ -1,7 +0,0 @@
-class Klass
-{
-    final public function RIGHT(): string
-    {
-        return 'ChangeMe';
-    }
-}
diff --git a/t/t4018/php-final-method.ctx b/t/t4018/php-final-method.ctx
deleted file mode 100644
index b7da8f8082..0000000000
--- a/t/t4018/php-final-method.ctx
+++ /dev/null
@@ -1 +0,0 @@
-final public function RIGHT(): string
diff --git a/t/t4018/php-function b/t/t4018/php-function
deleted file mode 100644
index 35717c51c3..0000000000
--- a/t/t4018/php-function
+++ /dev/null
@@ -1,4 +0,0 @@
-function RIGHT()
-{
-    return 'ChangeMe';
-}
diff --git a/t/t4018/php-function.ctx b/t/t4018/php-function.ctx
deleted file mode 100644
index c5f3e55302..0000000000
--- a/t/t4018/php-function.ctx
+++ /dev/null
@@ -1 +0,0 @@
-function RIGHT()
diff --git a/t/t4018/php-interface b/t/t4018/php-interface
deleted file mode 100644
index 86b49ad5d9..0000000000
--- a/t/t4018/php-interface
+++ /dev/null
@@ -1,4 +0,0 @@
-interface RIGHT
-{
-    public function foo($ChangeMe);
-}
diff --git a/t/t4018/php-interface.ctx b/t/t4018/php-interface.ctx
deleted file mode 100644
index a45fa0532a..0000000000
--- a/t/t4018/php-interface.ctx
+++ /dev/null
@@ -1 +0,0 @@
-interface RIGHT
diff --git a/t/t4018/php-method b/t/t4018/php-method
deleted file mode 100644
index 03af1a6d9d..0000000000
--- a/t/t4018/php-method
+++ /dev/null
@@ -1,7 +0,0 @@
-class Klass
-{
-    public static function RIGHT()
-    {
-        return 'ChangeMe';
-    }
-}
diff --git a/t/t4018/php-method.ctx b/t/t4018/php-method.ctx
deleted file mode 100644
index eb1659ff9f..0000000000
--- a/t/t4018/php-method.ctx
+++ /dev/null
@@ -1 +0,0 @@
-public static function RIGHT()
diff --git a/t/t4018/php-trait b/t/t4018/php-trait
deleted file mode 100644
index 65b8c82a61..0000000000
--- a/t/t4018/php-trait
+++ /dev/null
@@ -1,7 +0,0 @@
-trait RIGHT
-{
-    public function foo($ChangeMe)
-    {
-        return 'foo';
-    }
-}
diff --git a/t/t4018/php-trait.ctx b/t/t4018/php-trait.ctx
deleted file mode 100644
index 57aa4c6267..0000000000
--- a/t/t4018/php-trait.ctx
+++ /dev/null
@@ -1 +0,0 @@
-trait RIGHT
diff --git a/t/t4018/php.sh b/t/t4018/php.sh
new file mode 100755
index 0000000000..e0ccb2277b
--- /dev/null
+++ b/t/t4018/php.sh
@@ -0,0 +1,106 @@
+#!/bin/sh
+#
+# See ../t4018-diff-funcname.sh's test_diff_funcname()
+#
+
+test_diff_funcname 'php: abstract class' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+abstract class RIGHT
+EOF_HUNK
+abstract class RIGHT
+{
+    const FOO = 'ChangeMe';
+}
+EOF_TEST
+
+test_diff_funcname 'php: abstract method' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+abstract public function RIGHT(): ?string
+EOF_HUNK
+abstract class Klass
+{
+    abstract public function RIGHT(): ?string
+    {
+        return 'ChangeMe';
+    }
+}
+EOF_TEST
+
+test_diff_funcname 'php: class' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+class RIGHT
+EOF_HUNK
+class RIGHT
+{
+    const FOO = 'ChangeMe';
+}
+EOF_TEST
+
+test_diff_funcname 'php: final class' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+final class RIGHT
+EOF_HUNK
+final class RIGHT
+{
+    const FOO = 'ChangeMe';
+}
+EOF_TEST
+
+test_diff_funcname 'php: final method' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+final public function RIGHT(): string
+EOF_HUNK
+class Klass
+{
+    final public function RIGHT(): string
+    {
+        return 'ChangeMe';
+    }
+}
+EOF_TEST
+
+test_diff_funcname 'php: function' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+function RIGHT()
+EOF_HUNK
+function RIGHT()
+{
+    return 'ChangeMe';
+}
+EOF_TEST
+
+test_diff_funcname 'php: interface' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+interface RIGHT
+EOF_HUNK
+interface RIGHT
+{
+    public function foo($ChangeMe);
+}
+EOF_TEST
+
+test_diff_funcname 'php: method' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+public static function RIGHT()
+EOF_HUNK
+class Klass
+{
+    public static function RIGHT()
+    {
+        return 'ChangeMe';
+    }
+}
+EOF_TEST
+
+test_diff_funcname 'php: trait' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+trait RIGHT
+EOF_HUNK
+trait RIGHT
+{
+    public function foo($ChangeMe)
+    {
+        return 'foo';
+    }
+}
+EOF_TEST
diff --git a/t/t4018/python-async-def b/t/t4018/python-async-def
deleted file mode 100644
index 87640e03d2..0000000000
--- a/t/t4018/python-async-def
+++ /dev/null
@@ -1,4 +0,0 @@
-async def RIGHT(pi: int = 3.14):
-    while True:
-        break
-    return ChangeMe()
diff --git a/t/t4018/python-async-def.ctx b/t/t4018/python-async-def.ctx
deleted file mode 100644
index 468c548bbe..0000000000
--- a/t/t4018/python-async-def.ctx
+++ /dev/null
@@ -1 +0,0 @@
-async def RIGHT(pi: int = 3.14):
diff --git a/t/t4018/python-class b/t/t4018/python-class
deleted file mode 100644
index ba9e741430..0000000000
--- a/t/t4018/python-class
+++ /dev/null
@@ -1,4 +0,0 @@
-class RIGHT(int, str):
-    # comment
-    # another comment
-    # ChangeMe
diff --git a/t/t4018/python-class.ctx b/t/t4018/python-class.ctx
deleted file mode 100644
index a40b755e29..0000000000
--- a/t/t4018/python-class.ctx
+++ /dev/null
@@ -1 +0,0 @@
-class RIGHT(int, str):
diff --git a/t/t4018/python-def b/t/t4018/python-def
deleted file mode 100644
index e50b31b0ad..0000000000
--- a/t/t4018/python-def
+++ /dev/null
@@ -1,4 +0,0 @@
-def RIGHT(pi: int = 3.14):
-    while True:
-        break
-    return ChangeMe()
diff --git a/t/t4018/python-def.ctx b/t/t4018/python-def.ctx
deleted file mode 100644
index a1a9cbad63..0000000000
--- a/t/t4018/python-def.ctx
+++ /dev/null
@@ -1 +0,0 @@
-def RIGHT(pi: int = 3.14):
diff --git a/t/t4018/python-indented-async-def b/t/t4018/python-indented-async-def
deleted file mode 100644
index f5d03258af..0000000000
--- a/t/t4018/python-indented-async-def
+++ /dev/null
@@ -1,7 +0,0 @@
-class Foo:
-    async def RIGHT(self, x: int):
-        return [
-            1,
-            2,
-            ChangeMe,
-        ]
diff --git a/t/t4018/python-indented-async-def.ctx b/t/t4018/python-indented-async-def.ctx
deleted file mode 100644
index d393620a1e..0000000000
--- a/t/t4018/python-indented-async-def.ctx
+++ /dev/null
@@ -1 +0,0 @@
-async def RIGHT(self, x: int):
diff --git a/t/t4018/python-indented-class b/t/t4018/python-indented-class
deleted file mode 100644
index 19b4f35c4c..0000000000
--- a/t/t4018/python-indented-class
+++ /dev/null
@@ -1,5 +0,0 @@
-if TYPE_CHECKING:
-    class RIGHT:
-        # comment
-        # another comment
-        # ChangeMe
diff --git a/t/t4018/python-indented-class.ctx b/t/t4018/python-indented-class.ctx
deleted file mode 100644
index 0881c84dba..0000000000
--- a/t/t4018/python-indented-class.ctx
+++ /dev/null
@@ -1 +0,0 @@
-class RIGHT:
diff --git a/t/t4018/python-indented-def b/t/t4018/python-indented-def
deleted file mode 100644
index 208fbadd2b..0000000000
--- a/t/t4018/python-indented-def
+++ /dev/null
@@ -1,7 +0,0 @@
-class Foo:
-    def RIGHT(self, x: int):
-        return [
-            1,
-            2,
-            ChangeMe,
-        ]
diff --git a/t/t4018/python-indented-def.ctx b/t/t4018/python-indented-def.ctx
deleted file mode 100644
index 6e5a44b391..0000000000
--- a/t/t4018/python-indented-def.ctx
+++ /dev/null
@@ -1 +0,0 @@
-def RIGHT(self, x: int):
diff --git a/t/t4018/python.sh b/t/t4018/python.sh
new file mode 100755
index 0000000000..ecb5736d57
--- /dev/null
+++ b/t/t4018/python.sh
@@ -0,0 +1,71 @@
+#!/bin/sh
+#
+# See ../t4018-diff-funcname.sh's test_diff_funcname()
+#
+
+test_diff_funcname 'python: async def' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+async def RIGHT(pi: int = 3.14):
+EOF_HUNK
+async def RIGHT(pi: int = 3.14):
+    while True:
+        break
+    return ChangeMe()
+EOF_TEST
+
+test_diff_funcname 'python: class' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+class RIGHT(int, str):
+EOF_HUNK
+class RIGHT(int, str):
+    # comment
+    # another comment
+    # ChangeMe
+EOF_TEST
+
+test_diff_funcname 'python: def' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+def RIGHT(pi: int = 3.14):
+EOF_HUNK
+def RIGHT(pi: int = 3.14):
+    while True:
+        break
+    return ChangeMe()
+EOF_TEST
+
+test_diff_funcname 'python: indented async def' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+async def RIGHT(self, x: int):
+EOF_HUNK
+class Foo:
+    async def RIGHT(self, x: int):
+        return [
+            1,
+            2,
+            ChangeMe,
+        ]
+EOF_TEST
+
+test_diff_funcname 'python: indented class' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+class RIGHT:
+EOF_HUNK
+if TYPE_CHECKING:
+    class RIGHT:
+        # comment
+        # another comment
+        # ChangeMe
+EOF_TEST
+
+test_diff_funcname 'python: indented def' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+def RIGHT(self, x: int):
+EOF_HUNK
+class Foo:
+    def RIGHT(self, x: int):
+        return [
+            1,
+            2,
+            ChangeMe,
+        ]
+EOF_TEST
diff --git a/t/t4018/rust-fn b/t/t4018/rust-fn
deleted file mode 100644
index cbe02155f1..0000000000
--- a/t/t4018/rust-fn
+++ /dev/null
@@ -1,5 +0,0 @@
-pub(self) fn RIGHT<T>(x: &[T]) where T: Debug {
-    let _ = x;
-    // a comment
-    let a = ChangeMe;
-}
diff --git a/t/t4018/rust-fn.ctx b/t/t4018/rust-fn.ctx
deleted file mode 100644
index baa37cf253..0000000000
--- a/t/t4018/rust-fn.ctx
+++ /dev/null
@@ -1 +0,0 @@
-pub(self) fn RIGHT<T>(x: &[T]) where T: Debug {
diff --git a/t/t4018/rust-impl b/t/t4018/rust-impl
deleted file mode 100644
index 09df3cd93b..0000000000
--- a/t/t4018/rust-impl
+++ /dev/null
@@ -1,5 +0,0 @@
-impl<'a, T: AsRef<[u8]>>  std::RIGHT for Git<'a> {
-
-    pub fn ChangeMe(&self) -> () {
-    }
-}
diff --git a/t/t4018/rust-impl.ctx b/t/t4018/rust-impl.ctx
deleted file mode 100644
index 5344c35f3f..0000000000
--- a/t/t4018/rust-impl.ctx
+++ /dev/null
@@ -1 +0,0 @@
-impl<'a, T: AsRef<[u8]>>  std::RIGHT for Git<'a> {
diff --git a/t/t4018/rust-macro-rules b/t/t4018/rust-macro-rules
deleted file mode 100644
index ec610c5b62..0000000000
--- a/t/t4018/rust-macro-rules
+++ /dev/null
@@ -1,6 +0,0 @@
-macro_rules! RIGHT {
-    () => {
-        // a comment
-        let x = ChangeMe;
-    };
-}
diff --git a/t/t4018/rust-macro-rules.ctx b/t/t4018/rust-macro-rules.ctx
deleted file mode 100644
index 7520463aa0..0000000000
--- a/t/t4018/rust-macro-rules.ctx
+++ /dev/null
@@ -1 +0,0 @@
-macro_rules! RIGHT {
diff --git a/t/t4018/rust-struct b/t/t4018/rust-struct
deleted file mode 100644
index 76aff1c0d8..0000000000
--- a/t/t4018/rust-struct
+++ /dev/null
@@ -1,5 +0,0 @@
-#[derive(Debug)]
-pub(super) struct RIGHT<'a> {
-    name: &'a str,
-    age: ChangeMe,
-}
diff --git a/t/t4018/rust-struct.ctx b/t/t4018/rust-struct.ctx
deleted file mode 100644
index c1e09dc808..0000000000
--- a/t/t4018/rust-struct.ctx
+++ /dev/null
@@ -1 +0,0 @@
-pub(super) struct RIGHT<'a> {
diff --git a/t/t4018/rust-trait b/t/t4018/rust-trait
deleted file mode 100644
index ea397f09ed..0000000000
--- a/t/t4018/rust-trait
+++ /dev/null
@@ -1,5 +0,0 @@
-unsafe trait RIGHT<T> {
-    fn len(&self) -> u32;
-    fn ChangeMe(&self, n: u32) -> T;
-    fn iter<F>(&self, f: F) where F: Fn(T);
-}
diff --git a/t/t4018/rust-trait.ctx b/t/t4018/rust-trait.ctx
deleted file mode 100644
index 6af803db29..0000000000
--- a/t/t4018/rust-trait.ctx
+++ /dev/null
@@ -1 +0,0 @@
-unsafe trait RIGHT<T> {
diff --git a/t/t4018/rust.sh b/t/t4018/rust.sh
new file mode 100755
index 0000000000..ba018c6b95
--- /dev/null
+++ b/t/t4018/rust.sh
@@ -0,0 +1,60 @@
+#!/bin/sh
+#
+# See ../t4018-diff-funcname.sh's test_diff_funcname()
+#
+
+test_diff_funcname 'rust: fn' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+pub(self) fn RIGHT<T>(x: &[T]) where T: Debug {
+EOF_HUNK
+pub(self) fn RIGHT<T>(x: &[T]) where T: Debug {
+    let _ = x;
+    // a comment
+    let a = ChangeMe;
+}
+EOF_TEST
+
+test_diff_funcname 'rust: impl' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+impl<'a, T: AsRef<[u8]>>  std::RIGHT for Git<'a> {
+EOF_HUNK
+impl<'a, T: AsRef<[u8]>>  std::RIGHT for Git<'a> {
+
+    pub fn ChangeMe(&self) -> () {
+    }
+}
+EOF_TEST
+
+test_diff_funcname 'rust: macro rules' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+macro_rules! RIGHT {
+EOF_HUNK
+macro_rules! RIGHT {
+    () => {
+        // a comment
+        let x = ChangeMe;
+    };
+}
+EOF_TEST
+
+test_diff_funcname 'rust: struct' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+pub(super) struct RIGHT<'a> {
+EOF_HUNK
+#[derive(Debug)]
+pub(super) struct RIGHT<'a> {
+    name: &'a str,
+    age: ChangeMe,
+}
+EOF_TEST
+
+test_diff_funcname 'rust: trait' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+unsafe trait RIGHT<T> {
+EOF_HUNK
+unsafe trait RIGHT<T> {
+    fn len(&self) -> u32;
+    fn ChangeMe(&self, n: u32) -> T;
+    fn iter<F>(&self, f: F) where F: Fn(T);
+}
+EOF_TEST
-- 
2.30.0.284.gd98b1dd5eaa7

