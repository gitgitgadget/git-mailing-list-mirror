Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898F9C433E0
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 04:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 597BA206CB
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 04:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KF/1FBK3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgGAE1a (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 00:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgGAE11 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 00:27:27 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A36C061755
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 21:27:27 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id e3so4090196qvo.10
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 21:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YSA1UCPvxvt4cjGZAFnnmozrGNe4mrWjk38tmglrZHE=;
        b=KF/1FBK38qEBMHvgQFYaxCYha9uvdu/pbGOnJbFY8e/h7QchIFjWYA/4OHvzAFM/r2
         renLvwSSw3U242rmkVPGOgGbqKLw54tV/CA1mS5LSNe9Ihg95NGWz8u//59KjNplIYcL
         8FvXNfVSv6tHuIGEJJ0NjhPbr3LCbjc4V3bVXb1HZmZFfkZNggl1BfC1IS/Kq7egwYXH
         CReI6pfn/+dcaqKmUm9URTCgrTalcetlC3064x5j7mszVSzh8yd497rKBICm2raB/CGm
         MbgUc0prgP/Dh67knBrXw3zYw9rgGanFen7CBRlAdtCvYHpRxk5/g9xhFbF22+XOy0z/
         A2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YSA1UCPvxvt4cjGZAFnnmozrGNe4mrWjk38tmglrZHE=;
        b=gox7Z2kZ0kZ3/IYzSYNk0jws9bMrAUuIgH52bLu6ELAwGBmauvAOWxrTBBhu1wq+Ph
         vxixJ1Cpey4O8Q727QQ67gkgPUpl3151431VNZIvi2XVX2uVWLNq/uq6CGKVU+phfCqb
         eh8hvGKNnld6IZ/pMizirtbQZPZti+l8FunnI4qEYtU1y1B4ZJF16ry1urGf/tNX6rY8
         XuC7TzGMPr6iREqaVBqkfpdHMXqXzI/o52IWgfNqlEDMDfHPU5/GMDmIJxXxMpI0FS4n
         unVjujWoJVRPt3MHN+/I0KcVQei7ILcFqFFz9DeFFOjuNAbgBZkawG0M5YQiM7tf3RXJ
         edNQ==
X-Gm-Message-State: AOAM532jscZa1bo/uNuluEl10SJWKQCuDVm74jU48+H9ralTgPYIq+e4
        U6oVozDrV3M+Is0UhZ9hNRgqKU5xUtE=
X-Google-Smtp-Source: ABdhPJx8xH3Z/Pv+/ytdyCyU2aPAK8P1Cw2Hb7ZB9ipKMhmz9YL22ni3XiO4cSNzoq5n2uUOZuDtuw==
X-Received: by 2002:ad4:57c3:: with SMTP id y3mr6145693qvx.38.1593577646175;
        Tue, 30 Jun 2020 21:27:26 -0700 (PDT)
Received: from archbookpro.phub.net.cable.rogers.com (CPEc05627352ede-CM185933998587.cpe.net.cable.rogers.com. [174.112.146.193])
        by smtp.gmail.com with ESMTPSA id x13sm4418813qts.57.2020.06.30.21.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 21:27:25 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/5] t: replace incorrect test_must_fail usage (part 6)
Date:   Wed,  1 Jul 2020 00:27:08 -0400
Message-Id: <cover.1593576601.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae
In-Reply-To: <cover.1593529394.git.liu.denton@gmail.com>
References: <cover.1593529394.git.liu.denton@gmail.com>
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

