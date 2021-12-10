Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD89BC433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 10:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240012AbhLJKLf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 05:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239987AbhLJKLe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 05:11:34 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14878C0617A2
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 02:08:00 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id i12so6388667wmq.4
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 02:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/IHdS19Kog1vLhXxRkIWwK3fSYFu0mMTeQLqHuJxdVg=;
        b=pfIN56RuBe7nhdSBmOIaZoWSK9gGok4nmtKkJx/0mA+vbzUKHrTLbULvrNwIRfA6iI
         oOSt575k91zScvIOorbJveIEB+Izm5nFa5+t/YYJfxutqd/G+/UgAMjsr9izaJ/KgyQS
         AoQTBt7mslmDRDCMypfTf3IiarGva7UCfvwBVRe4WMM1/ukRgPHW9JGmLzod/sRGZYr/
         h/qMp+nu72EFvG9/Mmhw6SngpNfsqQTrFFWRfkuITUFnWQQHG+DSvJdXb0cId9dQLv4I
         1EO5zOGWYn7Qcsro20FquAgH+UvkJUgCGyuxetgLP9Nk1ZlemQimH++u5/YxIfTRAXhL
         SUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/IHdS19Kog1vLhXxRkIWwK3fSYFu0mMTeQLqHuJxdVg=;
        b=PNCU1hhw1QljNgzjAJho3TbaWH4MzJwWlvkwqQ3TJ941lPiUlxWEucDz3laWDOGSP9
         Kv9P8OdhhcP1XgGGEc79WcZFWo+a7CQkI/bR6Vg8N6CBdvRa+IFoZYxwK6gU+5knBj1F
         ZH7FpoW3Gyp3IDBDggQN2wMayKYEvHfxYSNVwVYgDvDoQ5Yk4ejwwezPtyx8dq5HMf4n
         gDjrb8Ky1LCGjwzCZ8RZC5bv3tDtqv2eW5YgLjxHYtQS9b/FLBTwcrpOmnq3WBPKl505
         w4HuEAY7uo98udkE+4Z2jjovioP2P6AUAESR96Mz0KTACbcinCaUyR7/KLm6oUYkfcRB
         ddgw==
X-Gm-Message-State: AOAM530ErMJmWIHS6d/osVcpbZk35T5Z17YhqyiF/7nuNScOcQezxmSY
        pOgfDou/jXfdNdXFpGbq9+din+imnKQ8sA==
X-Google-Smtp-Source: ABdhPJyIe6PMam4D0XBqrBrcReyHHyVRsmdNEL4GRqb+m8RYBmxRvyOks1M/JW1vRys6qq5urX6IvA==
X-Received: by 2002:a7b:cf0f:: with SMTP id l15mr15308233wmg.92.1639130878187;
        Fri, 10 Dec 2021 02:07:58 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m3sm2055561wrv.95.2021.12.10.02.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 02:07:57 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/2] test-lib.sh: have all tests pass under "-x", remove BASH_XTRACEFD
Date:   Fri, 10 Dec 2021 11:07:53 +0100
Message-Id: <cover-v3-0.2-00000000000-20211210T100512Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.932.g36842105b61
In-Reply-To: <cover-v2-0.2-00000000000-20211201T200801Z-avarab@gmail.com>
References: <cover-v2-0.2-00000000000-20211201T200801Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This re-roll fixes a stupid mistake of mine pointed out by SZEDER[1]
(thanks!): I was redirecting to "stderr" across function calls, but
some of those changed directories. Now we'll pass around an absolute
path from the top-level function.

That bug hid an issue where we'd include the trace output in that
stderr log still due to an interpolation of $(pwd), we can just change
that to $PWD, which won't have that issue.

1. https://lore.kernel.org/git/20211202192802.GC1991@szeder.dev/

Ævar Arnfjörð Bjarmason (2):
  t1510: remove need for "test_untraceable", retain coverage
  test-lib.sh: remove the now-unused "test_untraceable" facility

 t/README              |  3 --
 t/t1510-repo-setup.sh | 85 +++++++++++++++++++++----------------------
 t/test-lib.sh         | 66 ++++-----------------------------
 3 files changed, 49 insertions(+), 105 deletions(-)

Range-diff against v2:
1:  91402624777 ! 1:  7876202c5b0 t1510: remove need for "test_untraceable", retain coverage
    @@ Commit message
         use of "test_when_finished"), but the pattern enforces better test
         hygiene.
     
    +    The functions it calls might change directories, so we pass an
    +    absolute "$stderr_log_path" around. We also need to change a "$(pwd)"
    +    to "$PWD" in test_repo(), on e.g. "dash" that interpolation will be
    +    traced and part of the "2>>" redirection.
    +
    +    1. https://lore.kernel.org/git/YbMiK1wHzBfYvK2a@coredump.intra.peff.net/
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/t1510-repo-setup.sh ##
    @@ t/t1510-repo-setup.sh: test_repo () {
      		fi &&
      		rm -f trace &&
     -		GIT_TRACE_SETUP="$(pwd)/trace" git symbolic-ref HEAD >/dev/null &&
    -+		GIT_TRACE_SETUP="$(pwd)/trace" git symbolic-ref HEAD >/dev/null 2>>stderr &&
    ++		GIT_TRACE_SETUP="$PWD/trace" git symbolic-ref HEAD >/dev/null 2>>"$stderr_log_path" &&
      		grep '^setup: ' trace >result &&
      		test_cmp expected result
      	)
    @@ t/t1510-repo-setup.sh: maybe_config () {
      	if test "$value" != unset
      	then
     -		git config --file="$file" "$var" "$value"
    -+		git config --file="$file" "$var" "$value" 2>>stderr
    ++		git config --file="$file" "$var" "$value" 2>>"$stderr_log_path"
      	fi
      }
      
    @@ t/t1510-repo-setup.sh: setup_repo () {
      	sane_unset GIT_DIR GIT_WORK_TREE &&
      
     -	git -c init.defaultBranch=initial init "$name" &&
    -+	git -c init.defaultBranch=initial init "$name" 2>>stderr &&
    ++	git -c init.defaultBranch=initial init "$name" 2>>"$stderr_log_path" &&
      	maybe_config "$name/.git/config" core.worktree "$worktreecfg" &&
      	maybe_config "$name/.git/config" core.bare "$barecfg" &&
      	mkdir -p "$name/sub/sub" &&
    @@ t/t1510-repo-setup.sh: run_wt_tests () {
      #	(git dir) (work tree) (cwd) (prefix)	<-- from subdir
      try_repo () {
      	name=$1 worktreeenv=$2 gitdirenv=$3 &&
    -+	test_when_finished "rm stderr" &&
    ++	stderr_log_path="$PWD/stderr" &&
    ++
    ++	test_when_finished "rm \"$stderr_log_path\"" &&
      	setup_repo "$name" "$4" "$5" "$6" &&
      	shift 6 &&
      	try_case "$name" "$worktreeenv" "$gitdirenv" \
      		"$1" "$2" "$3" "$4" &&
    -+	test_must_be_empty stderr &&
    ++	test_must_be_empty "$stderr_log_path" &&
      	shift 4 &&
      	case "$gitdirenv" in
      	/* | ?:/* | unset) ;;
    @@ t/t1510-repo-setup.sh: try_repo () {
      	try_case "$name/sub" "$worktreeenv" "$gitdirenv" \
     -		"$1" "$2" "$3" "$4"
     +		"$1" "$2" "$3" "$4" &&
    -+	test_must_be_empty stderr
    ++	test_must_be_empty "$stderr_log_path"
      }
      
      # Bit 0 = GIT_WORK_TREE
2:  867d18d14bd = 2:  a7fc794e20d test-lib.sh: remove the now-unused "test_untraceable" facility
-- 
2.34.1.932.g36842105b61

