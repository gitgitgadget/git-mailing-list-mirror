Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B125DC433F5
	for <git@archiver.kernel.org>; Tue, 31 May 2022 17:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346510AbiEaRWE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 May 2022 13:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346513AbiEaRWD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 May 2022 13:22:03 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA45366FAE
        for <git@vger.kernel.org>; Tue, 31 May 2022 10:22:00 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q21so8407006wra.2
        for <git@vger.kernel.org>; Tue, 31 May 2022 10:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uh3lO7OT5wPwvxXROkgzGB+QEyPqQV4uf6dpblBNZP8=;
        b=kZMFbpaUpWbPL+VISfP7avNgI2rOT+BnTg4Q1nhy0evYBDpest/2r5pBFVyBx2pGor
         VqYyEoP1qrnKO2wi0fI3xp28Kq8a+t4HuHEEXdI8jvBvTlNpnSnrcXxgGPLR8KnEJwPv
         QTwSrjdMreqV4ofX5dXvflU/C6vg21x91NYguJwt8zfK2pMZ+x9NaEupVwQ1x43FZn6V
         sfh1/Re5tiZis66MpAI+S1xvgv65SRxwKDskL8dGX3zMalcWXfyqO6E+4T3+DrThrpIP
         KrwgtEy2gSFpgPAUv146Rc8Lhf3/L2z+OvAf9w5gZfzEmwGQK4pSuoVSfSmz+vk4yZF5
         2oGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uh3lO7OT5wPwvxXROkgzGB+QEyPqQV4uf6dpblBNZP8=;
        b=e5dWXTliBPYYtUGuKJEg++727+U/I7+sbySGi7HaA8W71ftmmMVwZg90+cw3aFw/TF
         p/4Ba97+g72pmSY21iakXt8ZFsupA2vEsDAR6a0X3iOJK/ug+e8Ac5zqpsblOcNeLc9k
         qr+IWDC7wTY/WVvurFgnC68YYSBgK/xfXSiAhxfFkxkZbtzpZGL1KQAj0nfkiM8pfXui
         WeT5mAbSpCu5yiFc1f4zkvA8x7JQ5b87P+/N0MGeFN2TedyDDr6YUOd97NjAIq6Q4nty
         MiRsoPE7lcmK6KlX3pDQc1M/NKgc/07KBEbslyPFJd8+ULi0oZxfHixBWWSIDCYCPC+1
         Nqtw==
X-Gm-Message-State: AOAM530UIhH8DlT4LQsedaFuW6psy9gBqpw5gfWXu4qUQ31AoyetSORt
        q9m6mpzfgEhRKbrBOJjl+oQeZhDzp9xc9Q==
X-Google-Smtp-Source: ABdhPJx4GGXrGxtK7CaCGiW9VeuhvTTOU+8gj7JhVEZ0b4+UMgog+iKzcdxd3H4iKrN33IRla9mmUw==
X-Received: by 2002:a05:6000:717:b0:20e:6160:39dd with SMTP id bs23-20020a056000071700b0020e616039ddmr51252250wrb.331.1654017718640;
        Tue, 31 May 2022 10:21:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m8-20020a05600c4f4800b003942a244f51sm3350521wmq.42.2022.05.31.10.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 10:21:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Josh Steadmon <steadmon@google.com>,
        Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        dyroneteng@gmail.com, martin.agren@gmail.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com
Subject: [PATCH] ls-tree: test for the regression in 9c4d58ff2c3
Date:   Tue, 31 May 2022 19:21:54 +0200
Message-Id: <patch-1.1-0fdfec624eb-20220531T171908Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1100.g16130010d07
In-Reply-To: <xmqqee28spni.fsf@gitster.g>
References: <xmqqee28spni.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test for the regression introduced in my 9c4d58ff2c3 (ls-tree:
split up "fast path" callbacks, 2022-03-23) and fixed in
350296cc789 (ls-tree: `-l` should not imply recursive listing,
2022-04-04), and test for the test of ls-tree option/mode combinations
to make sure we don't have other blind spots.

The setup for these tests can be shared with those added in the
1041d58b4d9 (Merge branch 'tl/ls-tree-oid-only', 2022-04-04) topic, so
let's create a new t/lib-t3100.sh to help them share data.

The existing tests in "t3104-ls-tree-format.sh" didn't deal with a
submodule, which they'll now encounter with as the
setup_basic_ls_tree_data() sets one up.

This extensive testing should give us confidence that there were no
further regressions in this area. The lack of testing was noted back
in [1], but unfortunately we didn't cover that blind-spot before
9c4d58ff2c3.

1. https://lore.kernel.org/git/211115.86o86lqe3c.gmgdl@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Thu, Apr 07 2022, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>>>>> Let's not go too cute like this.  This forces the caller to remember
>>>>> which among 6, 7, and 8 corresponds to which option.  It is too ugly
>>>>> to live.
>>>>
>>>> I think it's rather elegant actually, but to be fair it would, per:
>>>>
>>>>    git grep '<&[1-9]| [1-9]<<-'
>>>>
>>>> Be the user with the most FD's using this sort of pattern.
>>>
>>> Please give a clear explanation why "-d" has to be 6, "-r" 7 and
>>> "-t" 8, that can be used by developers as a memory aid to help them
>>> write new tests using the helper.
>>
>> It's documented when test-lib.sh does the redirection, since Fabian
>> Stelzer's a6714088e0c (test-lib: make BAIL_OUT() work in tests and
>> prereq, 2021-12-01).
>
> Sorry, but that is not what I asked.  I know what we use lower file
> descriptors for, and I didn't ask why we start from 6 (as opposed to
> 3).
>
> The updated helper forces our developers to know that the expected
> result for "-d" has to go to #6 (not #7 or #8), and "-r" to #7 (not
> #6 or #8), etc., in order to write new tests using it, and in order
> to spot a mistake while reviewing such new tests.
>
> It is an invitation to unmaintainable mess.  Don't encourage it.

I came up with this at the time, but didn't submit it since we were in
the rc period.

But since we're past that I think it makes sense to have a test for
the regression we fixed, the below is a lot less magical, but larger
by line count. I think this alternate test implementation should
address the concerns you had.

Range-diff:
1:  ed83b3b74ab ! 1:  0fdfec624eb ls-tree: fix --long implying -r regression in 9c4d58ff2c3
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    ls-tree: fix --long implying -r regression in 9c4d58ff2c3
    +    ls-tree: test for the regression in 9c4d58ff2c3
     
    -    Fix a regression introduced in 9c4d58ff2c3 (ls-tree: split up "fast
    -    path" callbacks, 2022-03-23), and improve the tests added in the
    -    1041d58b4d9 (Merge branch 'tl/ls-tree-oid-only', 2022-04-04) topic it
    -    was merged as part of to test the full expected output of various
    -    "ls-tree" options with and without -r.
    +    Add a test for the regression introduced in my 9c4d58ff2c3 (ls-tree:
    +    split up "fast path" callbacks, 2022-03-23) and fixed in
    +    350296cc789 (ls-tree: `-l` should not imply recursive listing,
    +    2022-04-04), and test for the test of ls-tree option/mode combinations
    +    to make sure we don't have other blind spots.
     
    -    Let's fix it, and also add tests not only for that blindspot, but also
    -    any other potential blindspots. To that end test the "modes" of -d, -r
    -    and -t (as well as "no mode") against all of the format options.
    +    The setup for these tests can be shared with those added in the
    +    1041d58b4d9 (Merge branch 'tl/ls-tree-oid-only', 2022-04-04) topic, so
    +    let's create a new t/lib-t3100.sh to help them share data.
     
    -    These tests all pass with that topic reverted (except those that would
    -    fail because they're testing the new --object-only feature introduced
    -    in that topic), which should give us confidence that there were no
    -    further regressions in this area.
    +    The existing tests in "t3104-ls-tree-format.sh" didn't deal with a
    +    submodule, which they'll now encounter with as the
    +    setup_basic_ls_tree_data() sets one up.
    +
    +    This extensive testing should give us confidence that there were no
    +    further regressions in this area. The lack of testing was noted back
    +    in [1], but unfortunately we didn't cover that blind-spot before
    +    9c4d58ff2c3.
    +
    +    1. https://lore.kernel.org/git/211115.86o86lqe3c.gmgdl@evledraar.gmail.com/
     
    -    Reported-By: Josh Steadmon <steadmon@google.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## builtin/ls-tree.c ##
    -@@ builtin/ls-tree.c: static int show_tree_long(const struct object_id *oid, struct strbuf *base,
    - 	printf("%06o %s %s %7s\t", data.mode, type_name(data.type),
    - 	       find_unique_abbrev(data.oid, abbrev), size_text);
    - 	show_tree_common_default_long(base, pathname, data.base->len);
    --	return 1;
    -+	return recurse;
    - }
    - 
    - static int show_tree_name_only(const struct object_id *oid, struct strbuf *base,
    + ## t/lib-t3100.sh (new) ##
    +@@
    ++#!/bin/sh
    ++
    ++setup_basic_ls_tree_data () {
    ++	mkdir dir &&
    ++	test_commit dir/sub-file &&
    ++	test_commit top-file &&
    ++	git clone . submodule &&
    ++	git submodule add ./submodule &&
    ++	git commit -m"add submodule"
    ++}
     
      ## t/t3104-ls-tree-format.sh ##
    -@@ t/t3104-ls-tree-format.sh: test_ls_tree_format () {
    - 	fmtopts=$3 &&
    - 	shift 2 &&
    +@@ t/t3104-ls-tree-format.sh: test_description='ls-tree --format'
    + 
    + TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    ++. "$TEST_DIRECTORY"/lib-t3100.sh
    + 
    + test_expect_success 'ls-tree --format usage' '
    + 	test_expect_code 129 git ls-tree --format=fmt -l HEAD &&
    +@@ t/t3104-ls-tree-format.sh: test_expect_success 'ls-tree --format usage' '
    + '
    + 
    + test_expect_success 'setup' '
    +-	mkdir dir &&
    +-	test_commit dir/sub-file &&
    +-	test_commit top-file
    ++	setup_basic_ls_tree_data
    + '
      
    + test_ls_tree_format () {
    +
    + ## t/t3105-ls-tree-output.sh (new) ##
    +@@
    ++#!/bin/sh
    ++
    ++test_description='ls-tree output'
    ++
    ++TEST_PASSES_SANITIZE_LEAK=true
    ++. ./test-lib.sh
    ++. "$TEST_DIRECTORY"/lib-t3100.sh
    ++
    ++test_expect_success 'ls-tree --format usage' '
    ++	test_expect_code 129 git ls-tree --format=fmt -l HEAD &&
    ++	test_expect_code 129 git ls-tree --format=fmt --name-only HEAD &&
    ++	test_expect_code 129 git ls-tree --format=fmt --name-status HEAD
    ++'
    ++
    ++test_expect_success 'setup' '
    ++	setup_basic_ls_tree_data
    ++'
    ++
    ++test_ls_tree_format_mode_output () {
    ++	local opts=$1 &&
    ++	shift &&
     +	cat >expect &&
    -+	cat <&6 >expect.-d &&
    -+	cat <&7 >expect.-r &&
    -+	cat <&8 >expect.-t &&
     +
    -+	for opt in '' '-d' '-r' '-t'
    ++	while test $# -gt 0
     +	do
    -+		test_expect_success "'ls-tree $opts${opt:+ $opt}' output" '
    -+			git ls-tree ${opt:+$opt }$opts $opt HEAD >actual &&
    -+			test_cmp expect${opt:+.$opt} actual
    ++		local mode="$1" &&
    ++		shift &&
    ++
    ++		test_expect_success "'ls-tree $opts${mode:+ $mode}' output" '
    ++			git ls-tree ${mode:+$mode }$opts HEAD >actual &&
    ++			test_cmp expect actual
     +		'
    ++
    ++		case "$opts" in
    ++		--full-tree)
    ++			test_expect_success "'ls-tree $opts${mode:+ $mode}' output (via subdir, fails)" '
    ++				test_must_fail git -C dir ls-tree --full-name ${mode:+$mode }$opts HEAD -- ../
    ++			'
    ++			;;
    ++		*)
    ++			test_expect_success "'ls-tree $opts${mode:+ $mode}' output (via subdir)" '
    ++				git -C dir ls-tree --full-name ${mode:+$mode }$opts HEAD -- ../ >actual &&
    ++				test_cmp expect actual
    ++			'
    ++			;;
    ++		esac
     +	done
    ++}
     +
    - 	test_expect_success "ls-tree '--format=<$format>' is like options '$opts $fmtopts'" '
    - 		git ls-tree $opts -r HEAD >expect &&
    - 		git ls-tree --format="$format" -r $fmtopts HEAD >actual &&
    -@@ t/t3104-ls-tree-format.sh: test_ls_tree_format () {
    - 
    - test_ls_tree_format \
    - 	"%(objectmode) %(objecttype) %(objectname)%x09%(path)" \
    --	""
    -+	"" \
    -+	<<-OUT 6<<-OUT_D 7<<-OUT_R 8<<-OUT_T
    -+	040000 tree $(git rev-parse HEAD:dir)	dir
    -+	100644 blob $(git rev-parse HEAD:top-file.t)	top-file.t
    -+	OUT
    -+	040000 tree $(git rev-parse HEAD:dir)	dir
    -+	OUT_D
    -+	100644 blob $(git rev-parse HEAD:dir/sub-file.t)	dir/sub-file.t
    -+	100644 blob $(git rev-parse HEAD:top-file.t)	top-file.t
    -+	OUT_R
    -+	040000 tree $(git rev-parse HEAD:dir)	dir
    -+	100644 blob $(git rev-parse HEAD:top-file.t)	top-file.t
    -+	OUT_T
    - 
    - test_ls_tree_format \
    - 	"%(objectmode) %(objecttype) %(objectname) %(objectsize:padded)%x09%(path)" \
    --	"--long"
    -+	"--long" \
    -+	<<-OUT 6<<-OUT_D 7<<-OUT_R 8<<-OUT_T
    -+	040000 tree $(git rev-parse HEAD:dir)       -	dir
    -+	100644 blob $(git rev-parse HEAD:top-file.t)       9	top-file.t
    -+	OUT
    -+	040000 tree $(git rev-parse HEAD:dir)       -	dir
    -+	OUT_D
    -+	100644 blob $(git rev-parse HEAD:dir/sub-file.t)      13	dir/sub-file.t
    -+	100644 blob $(git rev-parse HEAD:top-file.t)       9	top-file.t
    -+	OUT_R
    -+	040000 tree $(git rev-parse HEAD:dir)       -	dir
    -+	100644 blob $(git rev-parse HEAD:top-file.t)       9	top-file.t
    -+	OUT_T
    - 
    - test_ls_tree_format \
    - 	"%(path)" \
    --	"--name-only"
    -+	"--name-only" \
    -+	<<-OUT 6<<-OUT_D 7<<-OUT_R 8<<-OUT_T
    ++# test exact output of option (none, --long, ...) and mode (none and
    ++# -d, -r -t) and combinations
    ++test_expect_success 'setup: HEAD_* variables' '
    ++	HEAD_gitmodules=$(git rev-parse HEAD:.gitmodules) &&
    ++	HEAD_dir=$(git rev-parse HEAD:dir) &&
    ++	HEAD_top_file=$(git rev-parse HEAD:top-file.t) &&
    ++	HEAD_submodule=$(git rev-parse HEAD:submodule) &&
    ++	HEAD_dir_sub_file=$(git rev-parse HEAD:dir/sub-file.t)
    ++'
    ++## opt =
    ++test_ls_tree_format_mode_output "" "" "-t" <<-EOF
    ++	100644 blob $HEAD_gitmodules	.gitmodules
    ++	040000 tree $HEAD_dir	dir
    ++	160000 commit $HEAD_submodule	submodule
    ++	100644 blob $HEAD_top_file	top-file.t
    ++	EOF
    ++test_ls_tree_format_mode_output "" "-d" <<-EOF
    ++	040000 tree $HEAD_dir	dir
    ++	160000 commit $HEAD_submodule	submodule
    ++	EOF
    ++test_ls_tree_format_mode_output "" "-r" <<-EOF
    ++	100644 blob $HEAD_gitmodules	.gitmodules
    ++	100644 blob $HEAD_dir_sub_file	dir/sub-file.t
    ++	160000 commit $HEAD_submodule	submodule
    ++	100644 blob $HEAD_top_file	top-file.t
    ++	EOF
    ++## opt = --long
    ++test_ls_tree_format_mode_output "--long" "" "-t" <<-EOF
    ++	100644 blob $HEAD_gitmodules      61	.gitmodules
    ++	040000 tree $HEAD_dir       -	dir
    ++	160000 commit $HEAD_submodule       -	submodule
    ++	100644 blob $HEAD_top_file       9	top-file.t
    ++	EOF
    ++test_ls_tree_format_mode_output "--long" "-d" <<-EOF
    ++	040000 tree $HEAD_dir       -	dir
    ++	160000 commit $HEAD_submodule       -	submodule
    ++	EOF
    ++test_ls_tree_format_mode_output "--long" "-r" <<-EOF
    ++	100644 blob $HEAD_gitmodules      61	.gitmodules
    ++	100644 blob $HEAD_dir_sub_file      13	dir/sub-file.t
    ++	160000 commit $HEAD_submodule       -	submodule
    ++	100644 blob $HEAD_top_file       9	top-file.t
    ++	EOF
    ++## opt = --name-only
    ++test_ls_tree_format_mode_output "--name-only" "" "-t" <<-EOF
    ++	.gitmodules
     +	dir
    ++	submodule
     +	top-file.t
    -+	OUT
    ++	EOF
    ++test_ls_tree_format_mode_output "--name-only" "-d" <<-EOF
     +	dir
    -+	OUT_D
    ++	submodule
    ++	EOF
    ++test_ls_tree_format_mode_output "--name-only" "-r" <<-EOF
    ++	.gitmodules
     +	dir/sub-file.t
    ++	submodule
     +	top-file.t
    -+	OUT_R
    -+	dir
    -+	top-file.t
    -+	OUT_T
    - 
    - test_ls_tree_format \
    - 	"%(objectname)" \
    --	"--object-only"
    -+	"--object-only" \
    -+	<<-OUT 6<<-OUT_D 7<<-OUT_R 8<<-OUT_T
    -+	$(git rev-parse HEAD:dir)
    -+	$(git rev-parse HEAD:top-file.t)
    -+	OUT
    -+	$(git rev-parse HEAD:dir)
    -+	OUT_D
    -+	$(git rev-parse HEAD:dir/sub-file.t)
    -+	$(git rev-parse HEAD:top-file.t)
    -+	OUT_R
    -+	$(git rev-parse HEAD:dir)
    -+	$(git rev-parse HEAD:top-file.t)
    -+	OUT_T
    - 
    - test_ls_tree_format \
    - 	"%(objectname)" \
    - 	"--object-only --abbrev" \
    --	"--abbrev"
    -+	"--abbrev" \
    -+	<<-OUT 6<<-OUT_D 7<<-OUT_R 8<<-OUT_T
    -+	$(git rev-parse HEAD:dir | test_copy_bytes 7)
    -+	$(git rev-parse HEAD:top-file.t| test_copy_bytes 7)
    -+	OUT
    -+	$(git rev-parse HEAD:dir | test_copy_bytes 7)
    -+	OUT_D
    -+	$(git rev-parse HEAD:dir/sub-file.t | test_copy_bytes 7)
    -+	$(git rev-parse HEAD:top-file.t | test_copy_bytes 7)
    -+	OUT_R
    -+	$(git rev-parse HEAD:dir | test_copy_bytes 7)
    -+	$(git rev-parse HEAD:top-file.t | test_copy_bytes 7)
    -+	OUT_T
    - 
    - test_ls_tree_format \
    - 	"%(objectmode) %(objecttype) %(objectname)%x09%(path)" \
    - 	"-t" \
    --	"-t"
    -+	"-t" \
    -+	<<-OUT 6<<-OUT_D 7<<-OUT_R 8<<-OUT_T
    -+	040000 tree $(git rev-parse HEAD:dir)	dir
    -+	100644 blob $(git rev-parse HEAD:top-file.t)	top-file.t
    -+	OUT
    -+	040000 tree $(git rev-parse HEAD:dir)	dir
    -+	OUT_D
    -+	040000 tree $(git rev-parse HEAD:dir)	dir
    -+	100644 blob $(git rev-parse HEAD:dir/sub-file.t)	dir/sub-file.t
    -+	100644 blob $(git rev-parse HEAD:top-file.t)	top-file.t
    -+	OUT_R
    -+	040000 tree $(git rev-parse HEAD:dir)	dir
    -+	100644 blob $(git rev-parse HEAD:top-file.t)	top-file.t
    -+	OUT_T
    - 
    - test_ls_tree_format \
    - 	"%(objectmode) %(objecttype) %(objectname)%x09%(path)" \
    - 	"--full-name" \
    --	"--full-name"
    -+	"--full-name" \
    -+	<<-OUT 6<<-OUT_D 7<<-OUT_R 8<<-OUT_T
    -+	040000 tree $(git rev-parse HEAD:dir)	dir
    -+	100644 blob $(git rev-parse HEAD:top-file.t)	top-file.t
    -+	OUT
    -+	040000 tree $(git rev-parse HEAD:dir)	dir
    -+	OUT_D
    -+	100644 blob $(git rev-parse HEAD:dir/sub-file.t)	dir/sub-file.t
    -+	100644 blob $(git rev-parse HEAD:top-file.t)	top-file.t
    -+	OUT_R
    -+	040000 tree $(git rev-parse HEAD:dir)	dir
    -+	100644 blob $(git rev-parse HEAD:top-file.t)	top-file.t
    -+	OUT_T
    - 
    - test_ls_tree_format \
    - 	"%(objectmode) %(objecttype) %(objectname)%x09%(path)" \
    - 	"--full-tree" \
    --	"--full-tree"
    -+	"--full-tree" \
    -+	<<-OUT 6<<-OUT_D 7<<-OUT_R 8<<-OUT_T
    -+	040000 tree $(git rev-parse HEAD:dir)	dir
    -+	100644 blob $(git rev-parse HEAD:top-file.t)	top-file.t
    -+	OUT
    -+	040000 tree $(git rev-parse HEAD:dir)	dir
    -+	OUT_D
    -+	100644 blob $(git rev-parse HEAD:dir/sub-file.t)	dir/sub-file.t
    -+	100644 blob $(git rev-parse HEAD:top-file.t)	top-file.t
    -+	OUT_R
    -+	040000 tree $(git rev-parse HEAD:dir)	dir
    -+	100644 blob $(git rev-parse HEAD:top-file.t)	top-file.t
    -+	OUT_T
    - 
    - test_done
    ++	EOF
    ++## opt = --object-only
    ++test_ls_tree_format_mode_output "--object-only" "" "-t" <<-EOF
    ++	$HEAD_gitmodules
    ++	$HEAD_dir
    ++	$HEAD_submodule
    ++	$HEAD_top_file
    ++	EOF
    ++test_ls_tree_format_mode_output "--object-only" "-d" <<-EOF
    ++	$HEAD_dir
    ++	$HEAD_submodule
    ++	EOF
    ++test_ls_tree_format_mode_output "--object-only" "-r" <<-EOF
    ++	$HEAD_gitmodules
    ++	$HEAD_dir_sub_file
    ++	$HEAD_submodule
    ++	$HEAD_top_file
    ++	EOF
    ++## opt = --object-only --abbrev
    ++test_expect_success 'setup: HEAD_short_* variables' '
    ++	HEAD_short_gitmodules=$(git rev-parse --short HEAD:.gitmodules) &&
    ++	HEAD_short_dir=$(git rev-parse --short HEAD:dir) &&
    ++	HEAD_short_top_file=$(git rev-parse --short HEAD:top-file.t) &&
    ++	HEAD_short_submodule=$(git rev-parse --short HEAD:submodule) &&
    ++	HEAD_short_dir_sub_file=$(git rev-parse --short HEAD:dir/sub-file.t)
    ++'
    ++test_ls_tree_format_mode_output "--object-only --abbrev" "" "-t" <<-EOF
    ++	$HEAD_short_gitmodules
    ++	$HEAD_short_dir
    ++	$HEAD_short_submodule
    ++	$HEAD_short_top_file
    ++	EOF
    ++test_ls_tree_format_mode_output "--object-only --abbrev" "-d" <<-EOF
    ++	$HEAD_short_dir
    ++	$HEAD_short_submodule
    ++	EOF
    ++test_ls_tree_format_mode_output "--object-only --abbrev" "-r" <<-EOF
    ++	$HEAD_short_gitmodules
    ++	$HEAD_short_dir_sub_file
    ++	$HEAD_short_submodule
    ++	$HEAD_short_top_file
    ++	EOF
    ++## opt = --full-name
    ++test_ls_tree_format_mode_output "--full-name" "" <<-EOF
    ++	100644 blob $HEAD_gitmodules	.gitmodules
    ++	040000 tree $HEAD_dir	dir
    ++	160000 commit $HEAD_submodule	submodule
    ++	100644 blob $HEAD_top_file	top-file.t
    ++	EOF
    ++test_ls_tree_format_mode_output "--full-name" "-d" <<-EOF
    ++	040000 tree $HEAD_dir	dir
    ++	160000 commit $HEAD_submodule	submodule
    ++	EOF
    ++test_ls_tree_format_mode_output "--full-name" "-r" <<-EOF
    ++	100644 blob $HEAD_gitmodules	.gitmodules
    ++	100644 blob $HEAD_dir_sub_file	dir/sub-file.t
    ++	160000 commit $HEAD_submodule	submodule
    ++	100644 blob $HEAD_top_file	top-file.t
    ++	EOF
    ++test_ls_tree_format_mode_output "--full-name" "-t" <<-EOF
    ++	100644 blob $HEAD_gitmodules	.gitmodules
    ++	040000 tree $HEAD_dir	dir
    ++	160000 commit $HEAD_submodule	submodule
    ++	100644 blob $HEAD_top_file	top-file.t
    ++	EOF
    ++## opt = --full-tree
    ++test_ls_tree_format_mode_output "--full-tree" "" "-t" <<-EOF
    ++	100644 blob $HEAD_gitmodules	.gitmodules
    ++	040000 tree $HEAD_dir	dir
    ++	160000 commit $HEAD_submodule	submodule
    ++	100644 blob $HEAD_top_file	top-file.t
    ++	EOF
    ++test_ls_tree_format_mode_output "--full-tree" "-d" <<-EOF
    ++	040000 tree $HEAD_dir	dir
    ++	160000 commit $HEAD_submodule	submodule
    ++	EOF
    ++test_ls_tree_format_mode_output "--full-tree" "-r" <<-EOF
    ++	100644 blob $HEAD_gitmodules	.gitmodules
    ++	100644 blob $HEAD_dir_sub_file	dir/sub-file.t
    ++	160000 commit $HEAD_submodule	submodule
    ++	100644 blob $HEAD_top_file	top-file.t
    ++	EOF
    ++
    ++test_done

 t/lib-t3100.sh            |  10 ++
 t/t3104-ls-tree-format.sh |   5 +-
 t/t3105-ls-tree-output.sh | 192 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 204 insertions(+), 3 deletions(-)
 create mode 100644 t/lib-t3100.sh
 create mode 100755 t/t3105-ls-tree-output.sh

diff --git a/t/lib-t3100.sh b/t/lib-t3100.sh
new file mode 100644
index 00000000000..eabb5fd8034
--- /dev/null
+++ b/t/lib-t3100.sh
@@ -0,0 +1,10 @@
+#!/bin/sh
+
+setup_basic_ls_tree_data () {
+	mkdir dir &&
+	test_commit dir/sub-file &&
+	test_commit top-file &&
+	git clone . submodule &&
+	git submodule add ./submodule &&
+	git commit -m"add submodule"
+}
diff --git a/t/t3104-ls-tree-format.sh b/t/t3104-ls-tree-format.sh
index 0769a933d69..383896667b6 100755
--- a/t/t3104-ls-tree-format.sh
+++ b/t/t3104-ls-tree-format.sh
@@ -4,6 +4,7 @@ test_description='ls-tree --format'
 
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-t3100.sh
 
 test_expect_success 'ls-tree --format usage' '
 	test_expect_code 129 git ls-tree --format=fmt -l HEAD &&
@@ -12,9 +13,7 @@ test_expect_success 'ls-tree --format usage' '
 '
 
 test_expect_success 'setup' '
-	mkdir dir &&
-	test_commit dir/sub-file &&
-	test_commit top-file
+	setup_basic_ls_tree_data
 '
 
 test_ls_tree_format () {
diff --git a/t/t3105-ls-tree-output.sh b/t/t3105-ls-tree-output.sh
new file mode 100755
index 00000000000..29511d9331b
--- /dev/null
+++ b/t/t3105-ls-tree-output.sh
@@ -0,0 +1,192 @@
+#!/bin/sh
+
+test_description='ls-tree output'
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-t3100.sh
+
+test_expect_success 'ls-tree --format usage' '
+	test_expect_code 129 git ls-tree --format=fmt -l HEAD &&
+	test_expect_code 129 git ls-tree --format=fmt --name-only HEAD &&
+	test_expect_code 129 git ls-tree --format=fmt --name-status HEAD
+'
+
+test_expect_success 'setup' '
+	setup_basic_ls_tree_data
+'
+
+test_ls_tree_format_mode_output () {
+	local opts=$1 &&
+	shift &&
+	cat >expect &&
+
+	while test $# -gt 0
+	do
+		local mode="$1" &&
+		shift &&
+
+		test_expect_success "'ls-tree $opts${mode:+ $mode}' output" '
+			git ls-tree ${mode:+$mode }$opts HEAD >actual &&
+			test_cmp expect actual
+		'
+
+		case "$opts" in
+		--full-tree)
+			test_expect_success "'ls-tree $opts${mode:+ $mode}' output (via subdir, fails)" '
+				test_must_fail git -C dir ls-tree --full-name ${mode:+$mode }$opts HEAD -- ../
+			'
+			;;
+		*)
+			test_expect_success "'ls-tree $opts${mode:+ $mode}' output (via subdir)" '
+				git -C dir ls-tree --full-name ${mode:+$mode }$opts HEAD -- ../ >actual &&
+				test_cmp expect actual
+			'
+			;;
+		esac
+	done
+}
+
+# test exact output of option (none, --long, ...) and mode (none and
+# -d, -r -t) and combinations
+test_expect_success 'setup: HEAD_* variables' '
+	HEAD_gitmodules=$(git rev-parse HEAD:.gitmodules) &&
+	HEAD_dir=$(git rev-parse HEAD:dir) &&
+	HEAD_top_file=$(git rev-parse HEAD:top-file.t) &&
+	HEAD_submodule=$(git rev-parse HEAD:submodule) &&
+	HEAD_dir_sub_file=$(git rev-parse HEAD:dir/sub-file.t)
+'
+## opt =
+test_ls_tree_format_mode_output "" "" "-t" <<-EOF
+	100644 blob $HEAD_gitmodules	.gitmodules
+	040000 tree $HEAD_dir	dir
+	160000 commit $HEAD_submodule	submodule
+	100644 blob $HEAD_top_file	top-file.t
+	EOF
+test_ls_tree_format_mode_output "" "-d" <<-EOF
+	040000 tree $HEAD_dir	dir
+	160000 commit $HEAD_submodule	submodule
+	EOF
+test_ls_tree_format_mode_output "" "-r" <<-EOF
+	100644 blob $HEAD_gitmodules	.gitmodules
+	100644 blob $HEAD_dir_sub_file	dir/sub-file.t
+	160000 commit $HEAD_submodule	submodule
+	100644 blob $HEAD_top_file	top-file.t
+	EOF
+## opt = --long
+test_ls_tree_format_mode_output "--long" "" "-t" <<-EOF
+	100644 blob $HEAD_gitmodules      61	.gitmodules
+	040000 tree $HEAD_dir       -	dir
+	160000 commit $HEAD_submodule       -	submodule
+	100644 blob $HEAD_top_file       9	top-file.t
+	EOF
+test_ls_tree_format_mode_output "--long" "-d" <<-EOF
+	040000 tree $HEAD_dir       -	dir
+	160000 commit $HEAD_submodule       -	submodule
+	EOF
+test_ls_tree_format_mode_output "--long" "-r" <<-EOF
+	100644 blob $HEAD_gitmodules      61	.gitmodules
+	100644 blob $HEAD_dir_sub_file      13	dir/sub-file.t
+	160000 commit $HEAD_submodule       -	submodule
+	100644 blob $HEAD_top_file       9	top-file.t
+	EOF
+## opt = --name-only
+test_ls_tree_format_mode_output "--name-only" "" "-t" <<-EOF
+	.gitmodules
+	dir
+	submodule
+	top-file.t
+	EOF
+test_ls_tree_format_mode_output "--name-only" "-d" <<-EOF
+	dir
+	submodule
+	EOF
+test_ls_tree_format_mode_output "--name-only" "-r" <<-EOF
+	.gitmodules
+	dir/sub-file.t
+	submodule
+	top-file.t
+	EOF
+## opt = --object-only
+test_ls_tree_format_mode_output "--object-only" "" "-t" <<-EOF
+	$HEAD_gitmodules
+	$HEAD_dir
+	$HEAD_submodule
+	$HEAD_top_file
+	EOF
+test_ls_tree_format_mode_output "--object-only" "-d" <<-EOF
+	$HEAD_dir
+	$HEAD_submodule
+	EOF
+test_ls_tree_format_mode_output "--object-only" "-r" <<-EOF
+	$HEAD_gitmodules
+	$HEAD_dir_sub_file
+	$HEAD_submodule
+	$HEAD_top_file
+	EOF
+## opt = --object-only --abbrev
+test_expect_success 'setup: HEAD_short_* variables' '
+	HEAD_short_gitmodules=$(git rev-parse --short HEAD:.gitmodules) &&
+	HEAD_short_dir=$(git rev-parse --short HEAD:dir) &&
+	HEAD_short_top_file=$(git rev-parse --short HEAD:top-file.t) &&
+	HEAD_short_submodule=$(git rev-parse --short HEAD:submodule) &&
+	HEAD_short_dir_sub_file=$(git rev-parse --short HEAD:dir/sub-file.t)
+'
+test_ls_tree_format_mode_output "--object-only --abbrev" "" "-t" <<-EOF
+	$HEAD_short_gitmodules
+	$HEAD_short_dir
+	$HEAD_short_submodule
+	$HEAD_short_top_file
+	EOF
+test_ls_tree_format_mode_output "--object-only --abbrev" "-d" <<-EOF
+	$HEAD_short_dir
+	$HEAD_short_submodule
+	EOF
+test_ls_tree_format_mode_output "--object-only --abbrev" "-r" <<-EOF
+	$HEAD_short_gitmodules
+	$HEAD_short_dir_sub_file
+	$HEAD_short_submodule
+	$HEAD_short_top_file
+	EOF
+## opt = --full-name
+test_ls_tree_format_mode_output "--full-name" "" <<-EOF
+	100644 blob $HEAD_gitmodules	.gitmodules
+	040000 tree $HEAD_dir	dir
+	160000 commit $HEAD_submodule	submodule
+	100644 blob $HEAD_top_file	top-file.t
+	EOF
+test_ls_tree_format_mode_output "--full-name" "-d" <<-EOF
+	040000 tree $HEAD_dir	dir
+	160000 commit $HEAD_submodule	submodule
+	EOF
+test_ls_tree_format_mode_output "--full-name" "-r" <<-EOF
+	100644 blob $HEAD_gitmodules	.gitmodules
+	100644 blob $HEAD_dir_sub_file	dir/sub-file.t
+	160000 commit $HEAD_submodule	submodule
+	100644 blob $HEAD_top_file	top-file.t
+	EOF
+test_ls_tree_format_mode_output "--full-name" "-t" <<-EOF
+	100644 blob $HEAD_gitmodules	.gitmodules
+	040000 tree $HEAD_dir	dir
+	160000 commit $HEAD_submodule	submodule
+	100644 blob $HEAD_top_file	top-file.t
+	EOF
+## opt = --full-tree
+test_ls_tree_format_mode_output "--full-tree" "" "-t" <<-EOF
+	100644 blob $HEAD_gitmodules	.gitmodules
+	040000 tree $HEAD_dir	dir
+	160000 commit $HEAD_submodule	submodule
+	100644 blob $HEAD_top_file	top-file.t
+	EOF
+test_ls_tree_format_mode_output "--full-tree" "-d" <<-EOF
+	040000 tree $HEAD_dir	dir
+	160000 commit $HEAD_submodule	submodule
+	EOF
+test_ls_tree_format_mode_output "--full-tree" "-r" <<-EOF
+	100644 blob $HEAD_gitmodules	.gitmodules
+	100644 blob $HEAD_dir_sub_file	dir/sub-file.t
+	160000 commit $HEAD_submodule	submodule
+	100644 blob $HEAD_top_file	top-file.t
+	EOF
+
+test_done
-- 
2.36.1.1100.g16130010d07

