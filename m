Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D54C433E0
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 06:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA49A20771
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 06:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQPQELGI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgGGGFE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 02:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgGGGFE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 02:05:04 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E420C061755
        for <git@vger.kernel.org>; Mon,  6 Jul 2020 23:05:04 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id j80so37162557qke.0
        for <git@vger.kernel.org>; Mon, 06 Jul 2020 23:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YSA1UCPvxvt4cjGZAFnnmozrGNe4mrWjk38tmglrZHE=;
        b=lQPQELGI8iEPh/1NECQLTzT+1f4oBTXADuuYse56tYb21fpz+lOxzMcc7CiO+9tscI
         6LKo6iSrKJNBYikR0RiEXRbLoW7YyKUSGpJnABag/XJ2bQ5lcdXEsnwtl00EK1/5ugo+
         nIfvwpIOqrE+N1zSiSBIRBx4r9mAaSRkJeeNz9+RrSgZmvIUILLY9qP56PVKMSlzIx59
         NJKXrMS/EYANUqXiFOMwyAdyEAVxSAExUzr7TUbrbHsim+4x/wV1R7vqaq99urqbVU9J
         qcDd8QCBKojFV7JfMzbMX2CJjIp6bPsyt69qdz3iqUZ/MM2V6QplhL5u+rj38Tms5mGg
         KQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YSA1UCPvxvt4cjGZAFnnmozrGNe4mrWjk38tmglrZHE=;
        b=Z2Jp7MsHzX8Jd88PoDlUouXe72B81y2QXGMucKVRf87F1IzUht+vnDUiJsyZTM1Ol+
         fFgleNjGjg661zfYLMmo8Ub/JCg5s8q/DtCnLtsgtAw6Jh2KGNr3Acd82aYTCNtt3VWo
         XKKUhqTn7pDqXrns1dEFgC9xe5ICZlMzfjqqfQEU4fcy315KQ+vryG5R7m3ddnnbr5Qb
         bE4tWjhWqKx6ufJN192gS7h/bdk2kUKg4vNnYrLrtP9dAusJAJasCFyODKZcbr5vnRn7
         GuC3oNucjRNpMGhFO2b07g1ldBYNCq1i9mylOob7u+VSYb1IBg3uW5f6RzsOr52GxwlO
         1QBQ==
X-Gm-Message-State: AOAM532NylDMjUNuUJGVgbyLTGkR3xodHTGRiY16eXbRpJKWr5mXqKWN
        WYAMEk/LWXrd2ctFEh2WbPh2lux8fqo=
X-Google-Smtp-Source: ABdhPJyflH8YdW1LTDV6ztH63UbD45wyja+7bvbSGNId2mkzCf4tRTpYDnHH6xopXpITvlXX0yE08w==
X-Received: by 2002:a37:a785:: with SMTP id q127mr51289020qke.452.1594101903215;
        Mon, 06 Jul 2020 23:05:03 -0700 (PDT)
Received: from archbookpro.phub.net.cable.rogers.com (CPEc05627352ede-CM185933998587.cpe.net.cable.rogers.com. [174.112.146.193])
        by smtp.gmail.com with ESMTPSA id k197sm23446778qke.133.2020.07.06.23.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 23:05:02 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [RESEND PATCH v2 0/5] t: replace incorrect test_must_fail usage (part 6)
Date:   Tue,  7 Jul 2020 02:04:33 -0400
Message-Id: <cover.1594101831.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae
In-Reply-To: <cover.1593576601.git.liu.denton@gmail.com>
References: <cover.1593576601.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The overall scope of these patches is to replace inappropriate uses of
test_must_fail. IOW, we should only allow test_must_fail to run on `git`
and `test-tool`. Ultimately, we will conclude by making test_must_fail
error out on non-git commands. An advance view of the final series can
be found here[1].

This is the sixth and final(!) part. It cleans up instances of
`test_must_fail` that were introduced since the effort began. In
addition, it finally flips the switch and makes test_must_fail only
allow a whitelist of commands.

This series is based on the merge of 'master' and
'dl/test-must-fail-fixes-5'. In addition, this series was tested by
merging with 'seen~1' (to ignore the reftable failures) to ensure no
in-flight topics will require more changes.

The first part can be found here[2]. The second part can be found
here[3]. The third part can be found here[4]. The fourth part can be
found here[5]. The fifth part can be found here[6].

Changes since v1:

* Add a code comment to force_color()

* Do not allow nested env's in test_must_fail_acceptable()

* Clean up the env-processing case code

* Give an example on how to use `!`.

[1]: (may be rebased at any time) https://github.com/Denton-L/git/tree/ready/cleanup-test-must-fail2
[2]: https://lore.kernel.org/git/cover.1576583819.git.liu.denton@gmail.com/
[3]: https://lore.kernel.org/git/cover.1577454401.git.liu.denton@gmail.com/
[4]: https://lore.kernel.org/git/cover.1585209554.git.liu.denton@gmail.com/
[5]: https://lore.kernel.org/git/cover.1587372771.git.liu.denton@gmail.com/
[6]: https://lore.kernel.org/git/cover.1588162842.git.liu.denton@gmail.com/

Denton Liu (5):
  t3701: stop using `env` in force_color()
  t5324: reorder `run_with_limited_open_files test_might_fail`
  t7107: don't use test_must_fail()
  t9834: remove use of `test_might_fail p4`
  test-lib-functions: restrict test_must_fail usage

 t/t0000-basic.sh               | 18 +++++++++++++
 t/t3701-add-interactive.sh     | 13 ++++++++--
 t/t5324-split-commit-graph.sh  |  2 +-
 t/t7107-reset-pathspec-file.sh |  9 +++++--
 t/t9834-git-p4-file-dir-bug.sh |  2 +-
 t/test-lib-functions.sh        | 47 ++++++++++++++++++++++++++++++++++
 6 files changed, 85 insertions(+), 6 deletions(-)

Range-diff against v1:
1:  67d5b93fda ! 1:  654c864691 t3701: stop using `env` in force_color()
    @@ t/t3701-add-interactive.sh: diff_cmp () {
      
      force_color () {
     -	env GIT_PAGER_IN_USE=true TERM=vt100 "$@"
    ++	# The first element of $@ may be a shell function, as a result POSIX
    ++	# does not guarantee that "one-shot assignment" will not persist after
    ++	# the function call. Thus, we prevent these variables from escaping
    ++	# this function's context with this subshell.
     +	(
     +		GIT_PAGER_IN_USE=true &&
    -+		export GIT_PAGER_IN_USE &&
     +		TERM=vt100 &&
    -+		export TERM &&
    ++		export GIT_PAGER_IN_USE TERM &&
     +		"$@"
     +	)
      }
2:  aae48a89e5 = 2:  9ba997f7c1 t5324: reorder `run_with_limited_open_files test_might_fail`
3:  74bc29b18b = 3:  eb2052bf64 t7107: don't use test_must_fail()
4:  1287798e69 = 4:  92d3b38428 t9834: remove use of `test_might_fail p4`
5:  01e29450fe ! 5:  3ebbda6c57 test-lib-functions: restrict test_must_fail usage
    @@ Commit message
         We allow `__git*` as some completion functions return an error code that
         comes from a git invocation. It's good to avoid using test_must_fail
         unnecessarily but it wouldn't hurt to err on the side of caution when
    -    we're potentially wrapping a git command (like in these case).
    +    we're potentially wrapping a git command (like in these cases).
     
         We also allow `test-tool` and `test-svn-fe` because these are helper
         commands that are written by us and we want to catch their failure.
    @@ t/t0000-basic.sh: test_expect_success 'very long name in the index handled sanel
     +'
     +
     +test_expect_success 'test_must_fail on a failing git command with env' '
    -+	test_must_fail env var1=a var2=b env var3=c git notacommand
    ++	test_must_fail env var1=a var2=b git notacommand
     +'
     +
     +test_expect_success 'test_must_fail rejects a non-git command' '
    @@ t/t0000-basic.sh: test_expect_success 'very long name in the index handled sanel
     +'
     +
     +test_expect_success 'test_must_fail rejects a non-git command with env' '
    -+	! test_must_fail env var1=a var2=b env var3=c grep ^$ notafile 2>err &&
    ++	! test_must_fail env var1=a var2=b grep ^$ notafile 2>err &&
     +	grep -F "test_must_fail: only '"'"'git'"'"' is allowed" err
     +'
     +
    @@ t/test-lib-functions.sh: list_contains () {
     +# and its corresponding variable settings will be stripped before we
     +# test the command being run.
     +test_must_fail_acceptable () {
    -+	while test "$1" = "env"
    -+	do
    ++	if test "$1" = "env"
    ++	then
     +		shift
     +		while test $# -gt 0
     +		do
    -+			case "$1" in *?=*) ;; *) break ;; esac
    -+			shift
    ++			case "$1" in
    ++			*?=*)
    ++				shift
    ++				;;
    ++			*)
    ++				break
    ++				;;
    ++			esac
     +		done
    -+	done
    ++	fi
     +
     +	case "$1" in
     +	git|__git*|test-tool|test-svn-fe|test_terminal)
    @@ t/test-lib-functions.sh: list_contains () {
     +#
     +#    test_must_fail grep pattern output
     +#
    -+# Just use '!' instead.
    ++# Instead use '!':
    ++#
    ++#    ! grep pattern output
      
      test_must_fail () {
      	case "$1" in
    @@ t/test-lib-functions.sh: test_must_fail () {
      	esac
     +	if ! test_must_fail_acceptable "$@"
     +	then
    -+	    echo >&7 "test_must_fail: only 'git' is allowed: $*"
    -+	    return 1
    ++		echo >&7 "test_must_fail: only 'git' is allowed: $*"
    ++		return 1
     +	fi
      	"$@" 2>&7
      	exit_code=$?
-- 
2.27.0.383.g050319c2ae

