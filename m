Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E93C433DF
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 08:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D546120EDD
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 08:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kibj7NQt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbgFRItY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 04:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbgFRItT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 04:49:19 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C331C06174E
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 01:49:19 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id z2so1748913qts.5
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 01:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/jWmUTzNumCt4LW6M3g8byeTeSuyDXUpc7eQENzSJYM=;
        b=kibj7NQt8CQCaSmYS5GhqLbhaRFgOtkSKV8eLAL+pCp0vaYBMF4Igq4FKEa0jSuwIK
         0oZbVvBP7yDnxlBpiqVmr7yZqoHFpve+t6GwQoVer+ELp2wjn/ZAYfcWDGmpRZVF+TCK
         CqwkTZw3T/O/LUkjC9kWcJ+pjr7Q38l8CiG/uk9Mmqsis/+jzDk1pK98iNS6SVChs8An
         lVFWaUJDALFlVlSW3LWiomlLihVdUB2U0BR8yQInq2KedH4jZvrvXEIOousgXewWcixZ
         knfYwMo29Zp15dC86BS+x1T9gWVbhsQjbeGFra5uzX6Mz/xas88iB6SiGd3eaYEvjZqd
         rwIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/jWmUTzNumCt4LW6M3g8byeTeSuyDXUpc7eQENzSJYM=;
        b=MwSos7tBUIzIwV8wevMI2YOhO/rStDDJw2fYlSHLtfnZIj4x38xmGGAkgNYXMHAMlc
         GhozkafkXZK3iJXR7E1t6bdW5jjKY5WXv6y7Ac/rEn6ThJELeui0I0hponv088r56UlA
         qgI3sV3UixJsd2DdGDZc/4Rv18UnZThk7bVHDLpmnpiT/fF7AYXac6rj5hSOYzuYAR6p
         eLc1oTx2BPOke7s9LtvriM4bWUxOGh3YnS0O1tqOwJ+SvM49XkXKbY2DFnDiMmSFtKl0
         cSPLZQuki1uAjRWNWPhau9/LSSKmX7amU8djKtYTAsUxEQn9lP1nbM7uEZjXRg/qXXtF
         8fhA==
X-Gm-Message-State: AOAM531BahDADzU1XBHudkAY1xDnSAbx1Fn1aIKNML6MAjNBgYT3eGyQ
        FOW2IVk4tkLqOfrDRO+SRlIZNEFVfKg=
X-Google-Smtp-Source: ABdhPJy/h5s+Hy4dPWBmwJ2L8FoXdqgOVKNzgwCM48xJt/W8gE41ryCzbafiKCEoecioLab5c4GUpw==
X-Received: by 2002:ac8:4790:: with SMTP id k16mr3356782qtq.362.1592470157862;
        Thu, 18 Jun 2020 01:49:17 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id p11sm2733082qtb.4.2020.06.18.01.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 01:49:17 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v4 0/4] t: replace incorrect test_must_fail usage (part 5)
Date:   Thu, 18 Jun 2020 04:49:10 -0400
Message-Id: <cover.1592470068.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.132.g321788e831
In-Reply-To: <cover.1591897173.git.liu.denton@gmail.com>
References: <cover.1591897173.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

This revision of the series just improves on some of the documentation
and add addresses one of Junio's comments. Aside from that, the code
remains the same.


The overall scope of these patches is to replace inappropriate uses of
test_must_fail. IOW, we should only allow test_must_fail to run on `git`
and `test-tool`. Ultimately, we will conclude by making test_must_fail
error out on non-git commands. An advance view of the final series can
be found here[1].

This is the fifth part. It focuses on lib-submodule-update.sh and tests
that make use of it.

The first part can be found here[2]. The second part can be found
here[3]. The third part can be found here[4]. The fourth part can be
found here[5].

Changes since v1.2:

* In "lib-submodule-update: pass OVERWRITING_FAIL", use if-then return
  to reduce the amount of code churn

Changes since v2:

* Replace the OVERWRITING_FAIL approach with callback functions as
  suggested by Peff[6]

Changes since v3:

* Simply handling of empty $before and $after

* Add more comments on the usage of the helper functions

[1]: (may be rebased at any time) https://github.com/Denton-L/git/tree/ready/cleanup-test-must-fail2
[2]: https://lore.kernel.org/git/cover.1576583819.git.liu.denton@gmail.com/
[3]: https://lore.kernel.org/git/cover.1577454401.git.liu.denton@gmail.com/
[4]: https://lore.kernel.org/git/cover.1585209554.git.liu.denton@gmail.com/
[5]: https://lore.kernel.org/git/cover.1587372771.git.liu.denton@gmail.com/
[6]: https://lore.kernel.org/git/20200521182928.GA1308647@coredump.intra.peff.net/

Denton Liu (4):
  lib-submodule-update: add space after function name
  lib-submodule-update: consolidate --recurse-submodules
  lib-submodule-update: prepend "git" to $command
  lib-submodule-update: use callbacks in test_submodule_switch_common()

 t/lib-submodule-update.sh        | 135 +++++++++++++++++++++++--------
 t/t1013-read-tree-submodule.sh   |   4 +-
 t/t2013-checkout-submodule.sh    |   4 +-
 t/t3426-rebase-submodule.sh      |  10 +--
 t/t3512-cherry-pick-submodule.sh |   2 +-
 t/t3513-revert-submodule.sh      |  10 ++-
 t/t3906-stash-submodule.sh       |  10 ++-
 t/t4137-apply-submodule.sh       |  12 +--
 t/t4255-am-submodule.sh          |  12 +--
 t/t5572-pull-submodule.sh        |  28 +------
 t/t6041-bisect-submodule.sh      |  10 ++-
 t/t7112-reset-submodule.sh       |   6 +-
 t/t7613-merge-submodule.sh       |   8 +-
 13 files changed, 148 insertions(+), 103 deletions(-)

Range-diff against v3:
1:  ba2f642e0f = 1:  ba2f642e0f lib-submodule-update: add space after function name
2:  16d0a3eb9a = 2:  16d0a3eb9a lib-submodule-update: consolidate --recurse-submodules
3:  09446be5b9 = 3:  09446be5b9 lib-submodule-update: prepend "git" to $command
4:  74e6086da4 ! 4:  35d07117e6 lib-submodule-update: use callbacks in test_submodule_switch_common()
    @@ Commit message
         If the command requires a filename argument, specify it as `\$arg` since
         that variable will be set and the whole $command string will be eval'd.
         Unfortunately, there is no way to get rid of the eval as some of the
    -    commands are passed (such as the `git pull` tests) require that no
    +    commands that are passed (such as the `git pull` tests) require that no
         additional arguments are passed so we must have some mechanism for the
         caller to specify whether or not it wants the filename argument.
     
    @@ Commit message
         Finally, as an added bonus, `test_must_fail` will only run on $command
         which is guaranteed to be a git command.
     
    -    An alternate design was considered where the $OVERWRITING_FAIL is set
    -    from the test_submodule_switch_common() function and passed to the
    -    helper function. This approach was considered too difficult to
    -    understand due to the fact that using a signalling magic environment
    -    variable might be too indirect.
    +    An alternate design was considered where $OVERWRITING_FAIL is set from
    +    test_submodule_switch_common() and exposed to the helper function. This
    +    approach was considered too difficult to understand due to the fact that
    +    using a signalling magic environment variable might be too indirect.
     
      ## t/lib-submodule-update.sh ##
     @@ t/lib-submodule-update.sh: test_submodule_content () {
    + # Removing a submodule containing a .git directory must fail even when forced
    + # to protect the history!
    + #
    ++# $1: The git command to be eval'd and tested. The submodule being operated on
    ++# will be available as $arg.
    ++#
    ++# $2: The function that will run before the git command. It will be passed the
    ++# submodule being operated on as the only argument. This argument is optional.
    ++#
    ++# $3: The function that will run after $1. It will be passed the submodule
    ++# being operated on as the only argument. This argument is optional. It will
    ++# not be run when testing a case where the git command is expected to fail.
    + 
      # Internal function; use test_submodule_switch_func(), test_submodule_switch(),
      # or test_submodule_forced_switch() instead.
      test_submodule_switch_common () {
     -	command="$1"
    -+	command="$1" # should be a git command
    -+	before="$2"
    -+	after="$3"
    -+
    -+	if test -z "$before"
    -+	then
    -+		before=true
    -+	fi
    -+
    -+	if test -z "$after"
    -+	then
    -+		after=true
    -+	fi
    ++	command="$1" before="${2:-true}" after="${3:-true}"
     +
      	######################### Appearing submodule #########################
      	# Switching to a commit letting a submodule appear creates empty dir ...
    @@ t/lib-submodule-update.sh: test_submodule_switch_common () {
      			test_dir_is_empty sub1 &&
      			git submodule update --init --recursive &&
     @@ t/lib-submodule-update.sh: test_submodule_switch_common () {
    + # conditions, set the appropriate KNOWN_FAILURE_* variable used in the tests
    + # below to 1.
    + #
    +-# Use as follows:
    ++# $1: The git command to be eval'd and tested. The submodule being operated on
    ++# will be available as $arg. Do not include the leading "git".
    + #
    +-# my_func () {
    ++# $2: The function that will run before the git command. It will be passed the
    ++# submodule being operated on as the only argument. This argument is optional.
    ++#
    ++# $3: The function that will run after $1. It will be passed the submodule
    ++# being operated on as the only argument. This argument is optional. It will
    ++# not be run when testing a case where the git command is expected to fail.
    ++#
    ++# The following example uses `git some-command` as an example command to be
    ++# tested. It updates the worktree and index to match a target, but not any
    ++# submodule directories.
    ++#
    ++# my_func_before () {
    + #   target=$1
    +-#   # Do something here that updates the worktree and index to match target,
    +-#   # but not any submodule directories.
    ++#   # Prepare for git some-command to be run
      # }
    - # test_submodule_switch_func "my_func"
    +-# test_submodule_switch_func "my_func"
    ++# my_func_after () {
    ++#   target=$1
    ++#   # Check the state after git some-command is run
    ++# }
    ++# test_submodule_switch_func "some-command \$arg" "my_func_before" "my_func_after"
      test_submodule_switch_func () {
     -	command="$1"
     -	test_submodule_switch_common "$command"
-- 
2.27.0.132.g321788e831

