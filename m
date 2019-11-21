Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F511C432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 00:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC1EA20855
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 00:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Th1V8gB5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfKUApu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 19:45:50 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33046 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfKUApt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 19:45:49 -0500
Received: by mail-pl1-f194.google.com with SMTP id ay6so698833plb.0
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 16:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ANbX9Ui97uBwY5Dl9zCzQjxUnkFCPTlXzalKJKiASqY=;
        b=Th1V8gB5Nre41PHqwYcg+RWyxX5+GM9spYBq9shU+SSANigqorsQ8QGAnvA8VLg40d
         INFJwka6JpYj4W8ks8xm7UYV/o7USYOvpDbuMBuJ3wNfVg/UdCXqw6jfuszSJsH8l8S4
         De1UPqxhUb6fnMyxG4t35tEFYS2dXBfF1NEsPPFtwI+JfmasVQ6mPre1XSw1A2GK02dv
         0mXS1ToCCyi6mBo7EgYJ3rHACn9fB0aHeKTL9nzYRIdA+eF5tMAEBy4JCyyyccR8/rsR
         e/mdPGnCfsrGVZqVnJx6wf6Ks/S/nFVGhCss4a7OUjjukE0E3hNE+j4RTSsNijMwJqPn
         gWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ANbX9Ui97uBwY5Dl9zCzQjxUnkFCPTlXzalKJKiASqY=;
        b=ehDt89Ll+duu+2izLpVKaCeGNhKR1jMcCGF7LuhYz8XLOpt/1v+OT5ad6dR8/NFlj6
         geJR2YxgJfupN2L5LOmOd8ag+cWjdurBf22lDXpRdc/prV6f2wjOeNnCjjqXZ2wJo7nE
         nlwIOrOslGLWA8jO/wA38QoAxRnngUI2pi+FysfI8kuAp5noVsNIT2EeIwgClNKuJl4Q
         J1BzNloyF3ZDc6yEJvBJ8MH6ue83Huh7OKH6j0bViEucpALFu3CCJDuossYhiOJEe6Bh
         +fRY3RSmSnIolLuJaih+Xv/pKrSA9TT1oMwa6ydSSweO+lyd/BcLCJYEqkUWtz2EpbnP
         knRA==
X-Gm-Message-State: APjAAAXXFQrB1WjwDSF2JZQ7sFGfHzpOvieMnzuSY5QzMG6m9hKvqhs5
        e+Pp3hNOMk3fiFCpMyZSDC1yhq7i
X-Google-Smtp-Source: APXvYqzkA/tUh4ab2sIz0ecFSzdUX4iJd7RuqX99A+ur95AQV91+iYab/GDuz3/YCVeL7Mr3P4Cdkg==
X-Received: by 2002:a17:90b:300c:: with SMTP id hg12mr7724713pjb.75.1574297148232;
        Wed, 20 Nov 2019 16:45:48 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id v189sm592229pfv.133.2019.11.20.16.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 16:45:47 -0800 (PST)
Date:   Wed, 20 Nov 2019 16:45:45 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 00/21] t: test cleanup stemming from experimentally
 enabling pipefail
Message-ID: <cover.1574296987.git.liu.denton@gmail.com>
References: <cover.1573779465.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573779465.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches perform some general test cleanup to modernise the style.
They should be relatively uncontroversial. The reason these tests were
identified for cleanup was because they failed under `set -o pipefail`.

I've gotten rid of the RFC part that actually enables `set -o pipefail`
on supported platforms. As Peff pointed out, there are a lot of
opportunities for racy SIGPIPE failures so that part still needs a lot
of work to be ironed out.

Those changes shouldn't hold back the first part of the series, however.
Let's try to get this test cleanup merged in sooner than later so that
any new test cases done by copy-paste will have their changes
represented.

Changes since v1:

* Removed the `set -o pipefail` changes

* Addressed Junio and Eric's comments on the first part of the series

Denton Liu (21):
  lib-bash.sh: move `then` onto its own line
  t0014: remove git command upstream of pipe
  t0090: stop losing return codes of git commands
  t3301: stop losing return codes of git commands
  t3600: use test_line_count() where possible
  t3600: stop losing return codes of git commands
  t3600: comment on inducing SIGPIPE in `git rm`
  t4015: stop losing return codes of git commands
  t4015: use test_write_lines()
  t4138: stop losing return codes of git commands
  t5317: stop losing return codes of git commands
  t5317: use ! grep to check for no matching lines
  t5703: simplify one-time-sed generation logic
  t5703: stop losing return codes of git commands
  t7501: remove spaces after redirect operators
  t7501: stop losing return codes of git commands
  t7700: drop redirections to /dev/null
  t7700: remove spaces after redirect operators
  t7700: move keywords onto their own line
  t7700: s/test -f/test_path_is_file/
  t7700: stop losing return codes of git commands

 t/lib-bash.sh                          |   6 +-
 t/t0014-alias.sh                       |   4 +-
 t/t0090-cache-tree.sh                  |   5 +-
 t/t3301-notes.sh                       | 230 ++++++++++++++++++-------
 t/t3600-rm.sh                          |  14 +-
 t/t4015-diff-whitespace.sh             | 123 +++++++------
 t/t4138-apply-ws-expansion.sh          |  16 +-
 t/t5317-pack-objects-filter-objects.sh |  34 ++--
 t/t5703-upload-pack-ref-in-want.sh     |  53 +++---
 t/t7501-commit-basic-functionality.sh  |  83 +++++----
 t/t7700-repack.sh                      | 125 ++++++++------
 11 files changed, 428 insertions(+), 265 deletions(-)

Range-diff against v1:
 1:  a1a1199254 !  1:  da6ff63918 lib-bash.sh: move `then` onto its own line
    @@ t/lib-bash.sh
     +then
      	# we are in full-on bash mode
      	true
    - elif type bash >/dev/null 2>&1; then
    +-elif type bash >/dev/null 2>&1; then
    ++elif type bash >/dev/null 2>&1
    ++then
    + 	# execute in full-on bash mode
    + 	unset POSIXLY_CORRECT
    + 	exec bash "$0" "$@"
 2:  735d3fce93 =  2:  c0a513145d t0014: remove git command upstream of pipe
 3:  c29a54880a =  3:  52d8933ac9 t0090: stop losing return codes of git commands
 4:  5d634f8e5d =  4:  e8eafa1551 t3301: stop losing return codes of git commands
 5:  49069d12c0 =  5:  97ad3604dd t3600: use test_line_count() where possible
 6:  e4c43b686a =  6:  e0152ff3c1 t3600: stop losing return codes of git commands
 7:  91001a5be3 =  7:  54e9e78e03 t3600: comment on inducing SIGPIPE in `git rm`
 8:  738e0f1c27 =  8:  7c9e9a4b81 t4015: stop losing return codes of git commands
 9:  63b0028057 =  9:  9fb33ea04e t4015: use test_write_lines()
10:  8f9945bb16 ! 10:  6c91594492 t4138: stop losing return codes of git commands
    @@ t/t4138-apply-ws-expansion.sh: test_expect_success setup '
      	printf "\t%s\n" 4 5 6 >>after &&
     -	git diff --no-index before after |
     -		sed -e "s/before/test-1/" -e "s/after/test-1/" >patch1.patch &&
    -+	test_must_fail git diff --no-index before after >patch1.patch.raw &&
    ++	test_expect_code 1 git diff --no-index before after >patch1.patch.raw &&
     +	sed -e "s/before/test-1/" -e "s/after/test-1/" patch1.patch.raw >patch1.patch &&
      	printf "%64s\n" 1 2 3 4 5 6 >test-1 &&
      	printf "%64s\n" 1 2 3 a b c 4 5 6 >expect-1 &&
    @@ t/t4138-apply-ws-expansion.sh: test_expect_success setup '
      	printf "\t%s\n" d e f >>after &&
     -	git diff --no-index before after |
     -		sed -e "s/before/test-2/" -e "s/after/test-2/" >patch2.patch &&
    -+	test_must_fail git diff --no-index before after >patch2.patch.raw &&
    ++	test_expect_code 1 git diff --no-index before after >patch2.patch.raw &&
     +	sed -e "s/before/test-2/" -e "s/after/test-2/" patch2.patch.raw >patch2.patch &&
      	printf "%64s\n" a b c d e f >test-2 &&
      	printf "%64s\n" a b c >expect-2 &&
    @@ t/t4138-apply-ws-expansion.sh: test_expect_success setup '
      	printf "\t%s\n" d e f >>after &&
     -	git diff --no-index before after |
     -	sed -e "s/before/test-3/" -e "s/after/test-3/" >patch3.patch &&
    -+	test_must_fail git diff --no-index before after >patch3.patch.raw &&
    ++	test_expect_code 1 git diff --no-index before after >patch3.patch.raw &&
     +	sed -e "s/before/test-3/" -e "s/after/test-3/" patch3.patch.raw >patch3.patch &&
      	printf "%64s\n" a b c d e f >test-3 &&
      	printf "%64s\n" a b c >expect-3 &&
    @@ t/t4138-apply-ws-expansion.sh: test_expect_success setup '
      	done &&
     -	git diff --no-index before after |
     -	sed -e "s/before/test-4/" -e "s/after/test-4/" >patch4.patch &&
    -+	test_must_fail git diff --no-index before after >patch4.patch.raw &&
    ++	test_expect_code 1 git diff --no-index before after >patch4.patch.raw &&
     +	sed -e "s/before/test-4/" -e "s/after/test-4/" patch4.patch.raw >patch4.patch &&
      	>test-4 &&
      	x=0 &&
11:  823ed38115 = 11:  04beafae8e t5317: stop losing return codes of git commands
12:  6342f480d5 ! 12:  b24745bd60 t5317: use ! grep to check for no matching lines
    @@ Commit message
     
         Several times in t5317, we would use `wc -l` to ensure that a grep
         result is empty. However, grep already has a way to do that... Its
    -    return code! Use ! grep in the cases where we are ensuring that there
    +    return code! Use `! grep` in the cases where we are ensuring that there
         are no matching lines.
     
    +    It turns out that these tests were simply born this way[1], doing all
    +    this unnecessary work for no reason, probably due to copy/paste
    +    programming, and it seems no reviewer caught it. Likewise, the
    +    unnecessary work wasn't noticed even when the code was later touched
    +    for various cleanups[2,3].
    +
    +    [1]: 9535ce7337 (pack-objects: add list-objects filtering, 2017-11-21)
    +    [2]: bdbc17e86a (tests: standardize pipe placement, 2018-10-05)
    +    [3]: 61de0ff695 (tests: don't swallow Git errors upstream of pipes, 2018-10-05)
    +
    +    Helped-by: Eric Sunshine <sunshine@sunshineco.com>
         Signed-off-by: Denton Liu <liu.denton@gmail.com>
     
    +
    + ## Notes ##
    +    Thanks for your help, Eric. I shamelessly stole your message text for
    +    the commit message.
    +
      ## t/t5317-pack-objects-filter-objects.sh ##
     @@ t/t5317-pack-objects-filter-objects.sh: test_expect_success 'verify blob:none packfile has no blobs' '
      	git -C r1 index-pack ../filter.pack &&
 -:  ---------- > 13:  d5fb60be6b t5703: simplify one-time-sed generation logic
13:  89b68fc876 ! 14:  4071168d8b t5703: stop losing return codes of git commands
    @@ t/t5703-upload-pack-ref-in-want.sh: test_expect_success 'fetching ref and exact
      	grep "want-ref refs/heads/master" log
      '
      
    -@@ t/t5703-upload-pack-ref-in-want.sh: inconsistency () {
    - 	# repository appears to change during negotiation, for example, when
    - 	# different servers in a load-balancing arrangement serve (stateless)
    - 	# RPCs during a single negotiation.
    -+	oid1=$(git -C "$REPO" rev-parse $1) &&
    -+	oid2=$(git -C "$REPO" rev-parse $2) &&
    - 	printf "s/%s/%s/" \
    --	       $(git -C "$REPO" rev-parse $1 | tr -d "\n") \
    --	       $(git -C "$REPO" rev-parse $2 | tr -d "\n") \
    -+	       $(echo "$oid1" | tr -d "\n") \
    -+	       $(echo "$oid2" | tr -d "\n") \
    - 	       >"$HTTPD_ROOT_PATH/one-time-sed"
    - }
    - 
14:  6ab0dafb54 = 15:  63eebe1df6 t7501: remove spaces after redirect operators
15:  952d3fdfe4 ! 16:  4675d3dbc4 t7501: stop losing return codes of git commands
    @@ Commit message
         that there are no git commands upstream so that we will know if a
         command fails.
     
    +    In the 'interactive add' test case, we prepend a `test_must_fail` to
    +    `git commit --interactive`. When there are no changes to commit,
    +    `git commit` will exit with status code 1. Following along with the rest
    +    of the file, we use `test_must_fail` to test for this case.
    +
         Signed-off-by: Denton Liu <liu.denton@gmail.com>
     
      ## t/t7501-commit-basic-functionality.sh ##
16:  e30db4d20e = 17:  3cc6e4455c t7700: drop redirections to /dev/null
17:  664145360d = 18:  43f184dbd5 t7700: remove spaces after redirect operators
18:  6a63a98b1c = 19:  9389a74fe0 t7700: move keywords onto their own line
19:  4749dbcb88 = 20:  079a42c45b t7700: s/test -f/test_path_is_file/
20:  6821af454c = 21:  a455fbb625 t7700: stop losing return codes of git commands
21:  6d0243d9bc <  -:  ---------- t: define test_grep_return_success()
22:  d56a851930 <  -:  ---------- t0090: mask failing grep status
23:  df8fab5f1c <  -:  ---------- t3600: mark git command as failing
24:  ca29fdaddd <  -:  ---------- t5004: ignore SIGPIPE in zipinfo
25:  4d3c28d90e <  -:  ---------- t5703: mask failing grep status
26:  d89c2c24ae <  -:  ---------- t9902: disable pipefail
27:  7036c96fc7 <  -:  ---------- t: run tests with `set -o pipefail` on Bash
-- 
2.24.0.450.g7a9a4598a9

