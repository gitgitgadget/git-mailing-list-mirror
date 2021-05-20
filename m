Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7155C433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 16:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86A8161019
	for <git@archiver.kernel.org>; Thu, 20 May 2021 16:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbhETQgt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 12:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbhETQgs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 12:36:48 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB1EC061574
        for <git@vger.kernel.org>; Thu, 20 May 2021 09:35:25 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id t15so20153776edr.11
        for <git@vger.kernel.org>; Thu, 20 May 2021 09:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ukrsIDsUVGFswpgU2qnyIkIVG3EC3x/xBS+BirQlt8s=;
        b=kxB9tINPgXfZu8E0Y01lzFtvod92LBzdGDgOeZ3xqMEL5EnqfKjh612r3704V3PWPe
         PFi/h2vFOoJaLAciZqzoueZDQTvN3D+L6hbmTrGsyEXwLTS90Eke22cd0SPIbLr5mmC0
         XQ3OJoQzWxzFUIDDP8CuS88QjuF0JW+AgUByutgZn6RZiXJqFp4O5biRgpew8bW+tioU
         h6WofLPxAvfkSygEu9z729ywzASAMwEjiXzH+XOj0fxjavxOMiD0kmq9X04VMmvvx4ca
         V4f6DMzYVFe9hm4FOEkTY2vyU/xZwsEyt6YYJdxQmajQhlajRPRDqG0M1ibnxlfKXJzA
         3QFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ukrsIDsUVGFswpgU2qnyIkIVG3EC3x/xBS+BirQlt8s=;
        b=YYv669OUUWqAwwnZD0pukCqovv1IbvnH7mXi1UiTsZZExtekwbHiApS/BKw7W/ypr+
         ncYwBUgolqCLJoXj7sBNfVmJ3mcq2AjGJIH2JvyirAgqfekU0VggarARFTUbobCpCpjO
         +NCd+Agqwv+779FozhlmcPl3pNRojmn2b6FiQUDDHFJFFIDnX0ubanuaxT2eYQr12yDd
         8dcdfMHMtTWsSaLvg2TGy94SlvX8qn/U4Sq9TRiDYSi8Ot0HoF4L63D0DvcnmT8/ItZY
         VFX2YyN+LrlOz7CAyPHj+OvRJFLlrDvsbkLT8jpA9r/yWCoYWMwxHyP7e+vByflr+6t8
         y4JQ==
X-Gm-Message-State: AOAM530duRUhKG8K+3UF4LuS4q67waUYHFOn3V8CsdNIGhvYCSke1V9M
        bxH7PiaR0ll4qZAbiXzpfkq+OL2tRweuqA==
X-Google-Smtp-Source: ABdhPJy265uEmeHD0Li0Tw1ntiOWdWrS5M+E9WRA4O+kI0jo3hpFykMTlbJeXm5IxHtVE63d6If9mg==
X-Received: by 2002:aa7:c781:: with SMTP id n1mr5815165eds.108.1621528522970;
        Thu, 20 May 2021 09:35:22 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id p7sm1867292edw.43.2021.05.20.09.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 09:35:22 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 00/21] Prepare tests for reftable backend
Date:   Thu, 20 May 2021 18:28:47 +0200
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
Message-ID: <878s49pdmd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 27 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> Rewrites some tests to avoid direct filesystem access.
>
> Introduces the test prereq REFFILES to mark other tests that depend on
> specifics of the files ref backend.
>
> changes in v2 (relative to v1 from Apr 19)
>
>  * t9300: use ref-store test-helper to read toplevel tag.
>  * t1401: use $TAR for restoring.
>  * t1407: clarify what test is doing.
>  * t1417: "$TAR" rather than tar
>  * t1415: clarify test objective.
>  * t7003: formatting.
>  * README entry for REFFILES.
>
> cc: SZEDER G=C3=A1bor szeder.dev@gmail.com cc: =C3=86var Arnfj=C3=B6r=C3=
=B0 Bjarmason
> avarab@gmail.com cc: Han-Wen Nienhuys hanwen@google.com
>
> cc: Han-Wen Nienhuys hanwen@google.com
>
> Han-Wen Nienhuys (21):
>   t4202: split testcase for invalid HEAD symref and HEAD hash
>   t/helper/ref-store: initialize oid in resolve-ref
>   t9300: check ref existence using test-helper rather than a file system
>     check
>   t5601: read HEAD using rev-parse
>   t1401-symbolic-ref: avoid direct filesystem access
>   t1413: use tar to save and restore entire .git directory
>   t1301: fix typo in error message
>   t5000: reformat indentation to the latest fashion
>   t5000: inspect HEAD using git-rev-parse
>   t7003: use rev-parse rather than FS inspection
>   t5304: restyle: trim empty lines, drop ':' before >
>   t5304: use "reflog expire --all" to clear the reflog
>   test-lib: provide test prereq REFFILES
>   t1407: require REFFILES for for_each_reflog test
>   t1414: mark corruption test with REFFILES
>   t2017: mark --orphan/logAllRefUpdates=3Dfalse test as REFFILES
>   t1404: mark tests that muck with .git directly as REFFILES.
>   t7900: mark pack-refs tests as REFFILES
>   t7003: check reflog existence only for REFFILES
>   t4202: mark bogus head hash test with REFFILES
>   t1415: set REFFILES for test specific to storage format
>
>  t/README                      |   6 ++
>  t/helper/test-ref-store.c     |   2 +-
>  t/t1301-shared-repo.sh        |   2 +-
>  t/t1401-symbolic-ref.sh       |  34 +++++-----
>  t/t1404-update-ref-errors.sh  |  30 ++++-----
>  t/t1407-worktree-ref-store.sh |   9 ++-
>  t/t1413-reflog-detach.sh      |   5 +-
>  t/t1414-reflog-walk.sh        |   2 +-
>  t/t1415-worktree-refs.sh      |   5 +-
>  t/t2017-checkout-orphan.sh    |   2 +-
>  t/t4202-log.sh                |  10 ++-
>  t/t5000-tar-tree.sh           | 113 +++++++++++++++++-----------------
>  t/t5304-prune.sh              |  83 ++++++++-----------------
>  t/t5601-clone.sh              |   3 +-
>  t/t7003-filter-branch.sh      |   7 ++-
>  t/t7900-maintenance.sh        |   2 +-
>  t/t9300-fast-import.sh        |   2 +-
>  t/test-lib.sh                 |   2 +
>  18 files changed, 156 insertions(+), 163 deletions(-)
>
>
> base-commit: 311531c9de557d25ac087c1637818bd2aad6eb3a
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-100=
8%2Fhanwen%2Freffiles-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1008/h=
anwen/reffiles-v2
> Pull-Request: https://github.com/git/git/pull/1008
>
> Range-diff vs v1:
>
>   1:  91ef012cbcc9 !  1:  8ad4a35cda70 t4202: split testcase for invalid =
HEAD symref and HEAD hash
>      @@ t/t4202-log.sh: test_expect_success 'log --graph --no-walk is for=
bidden' '
>       +	test_i18ngrep broken stderr'
>       +
>       +test_expect_success 'log diagnoses bogus HEAD symref' '
>      ++	rm -rf empty &&
>       +	git init empty &&
>       +	git --git-dir empty/.git symbolic-ref HEAD refs/heads/invalid.loc=
k &&
>        	test_must_fail git -C empty log 2>stderr &&
>   -:  ------------ >  2:  e6222944a3eb t/helper/ref-store: initialize oid=
 in resolve-ref
>   2:  ccc26a8950be !  3:  c5855b0caa73 t9300: check ref existence using g=
it-rev-parse rather than FS check
>      @@ Metadata
>       Author: Han-Wen Nienhuys <hanwen@google.com>
>=20=20=20=20=20=20=20
>        ## Commit message ##
>      -    t9300: check ref existence using git-rev-parse rather than FS c=
heck
>      +    t9300: check ref existence using test-helper rather than a file=
 system check
>=20=20=20=20=20=20=20
>           Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
>=20=20=20=20=20=20=20
>      @@ t/t9300-fast-import.sh: test_expect_success 'B: accept branch nam=
e "TEMP_TAG"' '
>        		git prune" &&
>        	git fast-import <input &&
>       -	test -f .git/TEMP_TAG &&
>      -+	git rev-parse TEMP_TAG &&
>      ++	test $(test-tool ref-store main resolve-ref TEMP_TAG 0 | cut -f1 =
-d " " ) !=3D "$ZERO_OID" &&
>        	test $(git rev-parse main) =3D $(git rev-parse TEMP_TAG^)
>        '
>=20=20=20=20=20=20=20=20
>   3:  47b5ec56a383 =3D  4:  369c968ab837 t5601: read HEAD using rev-parse
>   4:  53cf1069552b !  5:  248d9ffe7927 t1401-symbolic-ref: avoid direct f=
ilesystem access
>      @@ Commit message
>           Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
>=20=20=20=20=20=20=20
>        ## t/t1401-symbolic-ref.sh ##
>      -@@ t/t1401-symbolic-ref.sh: test_description=3D'basic symbolic-ref =
tests'
>      - # the git repo, meaning that further tests will operate on
>      - # the surrounding git repo instead of the trash directory.
>      - reset_to_sane() {
>      --	echo ref: refs/heads/foo >.git/HEAD
>      -+	git --git-dir .git symbolic-ref HEAD refs/heads/foo
>      - }
>      +@@
>      + test_description=3D'basic symbolic-ref tests'
>      + . ./test-lib.sh
>=20=20=20=20=20=20=20=20
>      +-# If the tests munging HEAD fail, they can break detection of
>      +-# the git repo, meaning that further tests will operate on
>      +-# the surrounding git repo instead of the trash directory.
>      +-reset_to_sane() {
>      +-	echo ref: refs/heads/foo >.git/HEAD
>      +-}
>      +-
>       -test_expect_success 'symbolic-ref writes HEAD' '
>      --	git symbolic-ref HEAD refs/heads/foo &&
>      ++test_expect_success 'setup' '
>      + 	git symbolic-ref HEAD refs/heads/foo &&
>       -	echo ref: refs/heads/foo >expect &&
>       -	test_cmp expect .git/HEAD
>      --'
>      --
>      ++	test_commit file &&
>      ++	"$TAR" cf .git.tar .git/
>      + '
>      +=20
>       -test_expect_success 'symbolic-ref reads HEAD' '
>       -	echo refs/heads/foo >expect &&
>      --	git symbolic-ref HEAD >actual &&
>      ++reset_to_sane() {
>      ++	rm -rf .git &&
>      ++	"$TAR" xf .git.tar
>      ++}
>      ++
>       +test_expect_success 'symbolic-ref read/write roundtrip' '
>       +	git symbolic-ref HEAD refs/heads/read-write-roundtrip &&
>      -+	echo refs/heads/read-write-roundtrip > expect &&
>      -+	git symbolic-ref HEAD > actual &&
>      ++	echo refs/heads/read-write-roundtrip >expect &&
>      + 	git symbolic-ref HEAD >actual &&
>        	test_cmp expect actual
>        '
>      +@@ t/t1401-symbolic-ref.sh: test_expect_success 'symbolic-ref reads=
 HEAD' '
>      + test_expect_success 'symbolic-ref refuses non-ref for HEAD' '
>      + 	test_must_fail git symbolic-ref HEAD foo
>      + '
>      ++
>      + reset_to_sane
>      +=20
>      + test_expect_success 'symbolic-ref refuses bare sha1' '
>      +-	echo content >file && git add file && git commit -m one &&
>      + 	test_must_fail git symbolic-ref HEAD $(git rev-parse HEAD)
>      + '
>      ++
>      + reset_to_sane
>=20=20=20=20=20=20=20=20
>      + test_expect_success 'HEAD cannot be removed' '
>       @@ t/t1401-symbolic-ref.sh: reset_to_sane
>        test_expect_success 'symbolic-ref can be deleted' '
>        	git symbolic-ref NOTHEAD refs/heads/foo &&
>      @@ t/t1401-symbolic-ref.sh: reset_to_sane
>       -	test_path_is_file .git/refs/heads/foo &&
>       -	test_path_is_missing .git/NOTHEAD
>       +	git rev-parse refs/heads/foo &&
>      -+	! git symbolic-ref NOTHEAD
>      ++	test_must_fail git symbolic-ref NOTHEAD
>        '
>        reset_to_sane
>=20=20=20=20=20=20=20=20
>      @@ t/t1401-symbolic-ref.sh: reset_to_sane
>        	git symbolic-ref -d NOTHEAD &&
>       -	test_path_is_missing .git/refs/heads/missing &&
>       -	test_path_is_missing .git/NOTHEAD
>      -+	! git rev-parse refs/heads/missing &&
>      -+	! git symbolic-ref NOTHEAD
>      ++	test_must_fail git rev-parse refs/heads/missing &&
>      ++	test_must_fail git symbolic-ref NOTHEAD
>        '
>        reset_to_sane
>=20=20=20=20=20=20=20=20
>   5:  223583594c00 !  6:  e4e8fc1d4b4f t1413: use tar to save and restore=
 entire .git directory
>      @@ t/t1413-reflog-detach.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_=
NAME
>        reset_state () {
>       -	git checkout main &&
>       -	cp saved_reflog .git/logs/HEAD
>      -+	rm -rf .git && tar -xf .git-saved.tar
>      ++	rm -rf .git && "$TAR" xf .git-saved.tar
>        }
>=20=20=20=20=20=20=20=20
>        test_expect_success setup '
>      @@ t/t1413-reflog-detach.sh: test_expect_success setup '
>        	test_tick &&
>        	git commit --allow-empty -m second &&
>       -	cat .git/logs/HEAD >saved_reflog
>      -+	tar -cf .git-saved.tar .git
>      ++	"$TAR" cf .git-saved.tar .git
>        '
>=20=20=20=20=20=20=20=20
>        test_expect_success baseline '
>   6:  70da8f5631d0 =3D  7:  89cc215c6014 t1301: fix typo in error message
>   -:  ------------ >  8:  e67b90847c4e t5000: reformat indentation to the=
 latest fashion
>   7:  79843c0d5727 !  9:  d6072a70ae7d t5000: inspect HEAD using git-rev-=
parse
>      @@ Commit message
>           Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
>=20=20=20=20=20=20=20
>        ## t/t5000-tar-tree.sh ##
>      -@@ t/t5000-tar-tree.sh: test_expect_success \
>      -      test_cmp expected.mtime b.mtime'
>      +@@ t/t5000-tar-tree.sh: test_expect_success 'validate file modifica=
tion time' '
>      + 	test_cmp expected.mtime b.mtime
>      + '
>=20=20=20=20=20=20=20=20
>      - test_expect_success \
>      +-test_expect_success \
>       -    'git get-tar-commit-id' \
>       -    'git get-tar-commit-id <b.tar >b.commitid &&
>       -     test_cmp .git/$(git symbolic-ref HEAD) b.commitid'
>      -+	'git get-tar-commit-id' \
>      -+	'git get-tar-commit-id <b.tar >actual &&
>      -+	git rev-parse HEAD > expect &&
>      -+	test_cmp expect actual'
>      ++test_expect_success 'git get-tar-commit-id' '
>      ++	git get-tar-commit-id <b.tar >actual &&
>      ++	git rev-parse HEAD >expect &&
>      ++	test_cmp expect actual
>      ++'
>=20=20=20=20=20=20=20=20
>        test_expect_success 'git archive with --output, override inferred =
format' '
>        	git archive --format=3Dtar --output=3Dd4.zip HEAD &&
>   8:  dbb81b5b89d8 =3D 10:  4bf1bf16bca3 t7003: use rev-parse rather than=
 FS inspection
>   -:  ------------ > 11:  6f15c15573af t5304: restyle: trim empty lines, =
drop ':' before >
>   9:  ba575839e422 ! 12:  d8e80d83b6f8 t5304: use "reflog expire --all" t=
o clear the reflog
>      @@ Commit message
>=20=20=20=20=20=20=20
>        ## t/t5304-prune.sh ##
>       @@ t/t5304-prune.sh: test_expect_success 'prune: prune nonsense par=
ameters' '
>      - '
>=20=20=20=20=20=20=20=20
>        test_expect_success 'prune: prune unreachable heads' '
>      --
>        	git config core.logAllRefUpdates false &&
>       -	mv .git/logs .git/logs.old &&
>      - 	: > file2 &&
>      +-	: > file2 &&
>      ++	>file2 &&
>        	git add file2 &&
>        	git commit -m temporary &&
>        	tmp_head=3D$(git rev-list -1 HEAD) &&
>      @@ t/t5304-prune.sh: test_expect_success 'prune: prune nonsense para=
meters' '
>       +	git reflog expire --all &&
>        	git prune &&
>        	test_must_fail git reset $tmp_head --
>      --
>        '
>      -=20
>      +@@ t/t5304-prune.sh: test_expect_success 'prune: prune unreachable =
heads' '
>        test_expect_success 'prune: do not prune detached HEAD with no ref=
log' '
>      -=20
>        	git checkout --detach --quiet &&
>        	git commit --allow-empty -m "detached commit" &&
>       -	# verify that there is no reflogs
>      @@ t/t5304-prune.sh: test_expect_success 'prune: prune nonsense para=
meters' '
>       +	git reflog expire --all &&
>        	git prune -n >prune_actual &&
>        	test_must_be_empty prune_actual
>      -=20
>      -@@ t/t5304-prune.sh: test_expect_success 'prune: prune former HEAD =
after checking out branch' '
>      -=20
>      + '
>      +@@ t/t5304-prune.sh: test_expect_success 'prune: do not prune detac=
hed HEAD with no reflog' '
>      + test_expect_success 'prune: prune former HEAD after checking out b=
ranch' '
>        	head_oid=3D$(git rev-parse HEAD) &&
>        	git checkout --quiet main &&
>       +	git reflog expire --all &&
>        	git prune -v >prune_actual &&
>        	grep "$head_oid" prune_actual
>      -=20
>      + '
>  10:  3d3b733c3127 ! 13:  180847f4db14 test-lib: provide test prereq REFF=
ILES
>      @@ Commit message
>=20=20=20=20=20=20=20
>           Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
>=20=20=20=20=20=20=20
>      + ## t/README ##
>      +@@ t/README: use these, and "test_set_prereq" for how to define you=
r own.
>      +=20
>      +    Git wasn't compiled with NO_PTHREADS=3DYesPlease.
>      +=20
>      ++ - REFFILES
>      ++
>      ++   Test is specific to packed/loose ref storage, and should be
>      ++   disabled for other ref storage backends
>      ++
>      ++
>      + Tips for Writing Tests
>      + ----------------------
>      +=20
>      +
>        ## t/test-lib.sh ##
>       @@ t/test-lib.sh: parisc* | hppa*)
>        	;;
>  11:  dd1f6969c28d ! 14:  f3307b62bfd7 t1407: require REFFILES for for_ea=
ch_reflog test
>      @@ Metadata
>        ## Commit message ##
>           t1407: require REFFILES for for_each_reflog test
>=20=20=20=20=20=20=20
>      -    It tries to setup a reflog by catting to .git/logs/
>      +    Add extensive comment why this test needs a REFFILES annotation.
>      +
>      +    I tried forcing universal reflog creation with core.logAllRefUp=
dates=3Dtrue, but
>      +    that apparently also doesn't cause reflogs to be created for ps=
eudorefs
>=20=20=20=20=20=20=20
>           Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
>=20=20=20=20=20=20=20
>      @@ t/t1407-worktree-ref-store.sh: test_expect_success 'create_symref=
(FOO, refs/head
>        '
>=20=20=20=20=20=20=20=20
>       -test_expect_success 'for_each_reflog()' '
>      ++# Some refs (refs/bisect/*, pseudorefs) are kept per worktree, so =
they should
>      ++# only appear in the for-each-reflog output if it is called from t=
he correct
>      ++# worktree, which is exercised in this test. This test is poorly w=
ritten (and
>      ++# therefore marked REFFILES) for mulitple reasons: 1) it creates i=
nvalidly
>      ++# formatted log entres. 2) it uses direct FS access for creating t=
he reflogs. 3)
>      ++# PSEUDO-WT and refs/bisect/random do not create reflogs by defaul=
t, so it is
>      ++# not testing a realistic scenario.
>       +test_expect_success REFFILES 'for_each_reflog()' '
>        	echo $ZERO_OID > .git/logs/PSEUDO-MAIN &&
>        	mkdir -p     .git/logs/refs/bisect &&
>  12:  86951eb39cb6 =3D 15:  0d3b18cd3542 t1414: mark corruption test with=
 REFFILES
>  13:  1ce545043846 =3D 16:  b64e3e7ade15 t2017: mark --orphan/logAllRefUp=
dates=3Dfalse test as REFFILES
>  14:  a3abc4f70e7d ! 17:  fcc2b714dd50 t1404: mark tests that muck with .=
git directly as REFFILES.
>      @@ Metadata
>        ## Commit message ##
>           t1404: mark tests that muck with .git directly as REFFILES.
>=20=20=20=20=20=20=20
>      +    The packed/loose ref storage is an overlay combination of packe=
d-refs (refs and
>      +    tags in a single file) and one-file-per-ref. This creates all k=
inds of edge
>      +    cases related to directory/file conflicts, (non-)empty director=
ies, and the
>      +    locking scheme, none of which applies to reftable.
>      +
>           Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
>=20=20=20=20=20=20=20
>        ## t/t1404-update-ref-errors.sh ##
>  15:  2b3021c4ba62 ! 18:  ff3b67c84c41 t7900: mark pack-refs tests as REF=
FILES
>      @@ Metadata
>        ## Commit message ##
>           t7900: mark pack-refs tests as REFFILES
>=20=20=20=20=20=20=20
>      +    Reftable automatically compacts tables on writes. The functiona=
lity of
>      +    incremental compaction is unittested in reftable/stack_test.c
>      +    (test_reftable_stack_auto_compaction)
>      +
>      +    In addition, pack-refs triggers a full compaction of the entire=
 stack. This is
>      +    exercised in t0031-reftable.sh.
>      +
>      +    Given that git-maintenance simply calls out git-pack-refs, it s=
eems superfluous
>      +    to test this further for reftable.
>      +
>           Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
>=20=20=20=20=20=20=20
>        ## t/t7900-maintenance.sh ##
>  16:  a5b9439192db ! 19:  24dcf05d8fa6 t7003: check reflog existence only=
 for REFFILES
>      @@ t/t7003-filter-branch.sh: test_expect_success '--prune-empty is a=
ble to prune en
>        	git filter-branch -f --prune-empty --index-filter "git update-ind=
ex --remove A.t B.t" prune-entire &&
>        	test_must_fail git rev-parse refs/heads/prune-entire &&
>       -	test_must_fail git reflog exists refs/heads/prune-entire
>      -+	if test_have_prereq REFFILES ; then
>      ++	if test_have_prereq REFFILES
>      ++	then
>       +		test_must_fail git reflog exists refs/heads/prune-entire
>       +	fi
>        '
>  17:  a2cce772d44f =3D 20:  a33cdfda74ff t4202: mark bogus head hash test=
 with REFFILES
>  18:  0665edb1308b ! 21:  d7e5de8dba46 t1415: set REFFILES for test speci=
fic to storage format
>      @@ Metadata
>        ## Commit message ##
>           t1415: set REFFILES for test specific to storage format
>=20=20=20=20=20=20=20
>      +    Packing refs (and therefore checking that certain refs are not =
packed) is a
>      +    property of the packed/loose ref storage. Add a comment to expl=
ain what the test
>      +    checks.
>      +
>           Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
>=20=20=20=20=20=20=20
>        ## t/t1415-worktree-refs.sh ##
>      @@ t/t1415-worktree-refs.sh: test_expect_success 'setup' '
>        '
>=20=20=20=20=20=20=20=20
>       -test_expect_success 'refs/worktree must not be packed' '
>      ++# The 'packed-refs' files is stored directly in .git/. This means =
it is global
>      ++# to the repository, and can only contain refs that are shared acr=
oss all
>      ++# worktrees.
>       +test_expect_success REFFILES 'refs/worktree must not be packed' '
>        	git pack-refs --all &&
>        	test_path_is_missing .git/refs/tags/wt1 &&

I looked this all over and left some nits, suspect/probably/definite bug
comments on specific patches, the ones with no comments from me LGTM.

I intentionally didn't review my own earlier feedback on v1 to look at
this with fresh eyes, I'd forgetten what points I raised, aside from the
general "let's not skip tests but test the new behavior" mantra I think
I either mentioned there or in related discussions.

