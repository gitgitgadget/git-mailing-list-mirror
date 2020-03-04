Return-Path: <SRS0=VPsx=4V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCA5C3F2CD
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 11:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF6220848
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 11:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioHTwuOE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387921AbgCDLeW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Mar 2020 06:34:22 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:40081 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387774AbgCDLeV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Mar 2020 06:34:21 -0500
Received: by mail-pj1-f65.google.com with SMTP id k36so817500pje.5
        for <git@vger.kernel.org>; Wed, 04 Mar 2020 03:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lM1ts5ETOcePpWiL4XDa+kz0IbYiuE07/kACZPWPmoM=;
        b=ioHTwuOEjyQQ4LAZdnQCQAZeHOSTHYcoxBynsjKi3dUjjSqrKrZkhF5O5KOJiKRw+U
         hdrgNHoyw45kmRmXKJzJxKalpjYdKCoy6r0Fbm5S/nu006ScPnfiNWvKE4iE2p5sJiJW
         SVjFYrwQSf3Wo+q96M1rz80HepfBQuwqX9+jGq2oQf20tBlLO9QLcDZywu2BIrKRdP4W
         gbOZjCEM3o1Pzu+02Qi9YGJG9LbXeCSYaXkxUd8UA7CxyouZ1ZWbb24uerZNaUt5Aku0
         tV59LHJf9Qc5wFBrEACMHN6cdItfo2mDwdgrE4fKX9QSXXGhP2R/m7/tRxfkTL8vcfTG
         +JmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lM1ts5ETOcePpWiL4XDa+kz0IbYiuE07/kACZPWPmoM=;
        b=Mjv64MEA8wZp9O9ykglxD5nB0zb3N1TCxw2o6g+tsZYJkq9aCoIRmyDLJskR3PXgSL
         9ZQSOlTxUAsHYsXqkL1p8KP4Reco30PyUkSD/OOoks7ioiWGn/sjCtiHmgn3qDWVQso5
         Jy8AhdBrMLdLJF2NqwG7rJnJvA1j6ylA75C6xFcvzWAoyAl9joXxKJ9fj/SfZjgqgGWF
         oF/rqURrACmrOT6XHbtHG+3KafzUO7Hp1e6iltu4GEUxfFraT9JbYlksxXsrcIhylNdS
         RDoknlNWn2Wwv24PpOP5byn9Du9PzuHeXeaYvMjSEeKarkmjNP0tV3uIeCBuMIQZ6KHN
         uI6g==
X-Gm-Message-State: ANhLgQ2re5Drv8ypipSwWbLhqWnZOZ3ccsC1NXngS4GpCgDa+GykiOr0
        Lkbwzmr/QtcBmc/sMgTS401ef8hJyma2eg==
X-Google-Smtp-Source: ADFU+vtdeOU9YPtCIPVIGNSXdTxffNngJwV4HuW57ovzv+3B19amUBwNFFqOWqvrPQBLBCiXZrCwVQ==
X-Received: by 2002:a17:902:76cc:: with SMTP id j12mr2773246plt.129.1583321659458;
        Wed, 04 Mar 2020 03:34:19 -0800 (PST)
Received: from localhost.localdomain ([47.89.83.4])
        by smtp.gmail.com with ESMTPSA id d77sm15350050pfd.109.2020.03.04.03.34.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Mar 2020 03:34:18 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
X-Google-Original-From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
To:     Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 7/7] hook: add document and example for "execute-commands" hook
Date:   Wed,  4 Mar 2020 19:33:12 +0800
Message-Id: <20200304113312.34229-8-zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.25.1.362.g51ebf55b93
In-Reply-To: <20200304113312.34229-1-zhiyou.jx@alibaba-inc.com>
References: <20200304113312.34229-1-zhiyou.jx@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 Documentation/githooks.txt               |  43 ++++++++
 t/t5411-execute-commands-hook.sh         |  98 +++++++++++++++++
 templates/hooks--execute-commands.sample | 131 +++++++++++++++++++++++
 3 files changed, 272 insertions(+)
 create mode 100755 templates/hooks--execute-commands.sample

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 3dccab5375..6c21ab6db2 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -58,6 +58,49 @@ the message file.
 The default 'applypatch-msg' hook, when enabled, runs the
 'commit-msg' hook, if the latter is enabled.
 
+execute-commands--pre-receive
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+This hook is invoked by linkgit:git-receive-pack[1] when it reacts to
+special `git push` command.  Just before starting to execute the
+external 'execute-commands' hook to make changes to the repository,
+the 'execute-commands--pre-receive' hook is invoked.  This hook has
+the same functionality as 'pre-receive' hook, while it only acts on
+special commands which 'git-push' sends to 'git-receive-pack'.
+The refnames of these spacial commands have special prefix (such as
+"refs/for/") which matches what the `receive.executeCommandsHookRefs`
+configuration variable defines.
+
+If this hook does not exist, will try to find the 'execute-commands'
+hook, and run `execute-command --pre-receive` command to do some
+checks.  Its exit status determines the success or failure of the
+update.  If the hook exits with non-zero status, won't execute any of
+the commands, no metter calling the internal `execute_commands`
+function or calling the external "execute-commands" hook.
+
+This hook executes once for the receive operation, and gets the
+information from its standard input.
+See <<pre-receive,'pre-receive'>> for details.
+
+execute-commands
+~~~~~~~~~~~~~~~~
+This hook is invoked by linkgit:git-receive-pack[1] when it reacts to
+special `git push` command.  According to refnames of the commands which
+`git push` sends to 'git-receive-pack', the commands will be devided
+into two groups by matching what the `receive.executeCommandsHookRefs`
+configuration variable defines.  One group of the commands will execute
+the internal `execute_commands` function to update the corresponding
+refnames, and the other group of commands which have matching refnames
+will execute this external 'execute-commands' hook to create pull
+requests, etc.
+
+Its exit status only determines the success or failure of the group of
+commands with special refnames, unless atomic push is in use.
+
+This hook executes once if there are any special commands with special
+refnames.  There is no argument taken by this hook, and the push options
+(if any) and command(s) will be fed to this book by its standard input.
+See the <<pre-receive,'pre-receive'>> hook for the format of the input.
+
 pre-applypatch
 ~~~~~~~~~~~~~~
 
diff --git a/t/t5411-execute-commands-hook.sh b/t/t5411-execute-commands-hook.sh
index c8ee699773..6dd1560f9d 100755
--- a/t/t5411-execute-commands-hook.sh
+++ b/t/t5411-execute-commands-hook.sh
@@ -597,4 +597,102 @@ test_expect_success "push and show environments" '
 	test_cmp expect actual
 '
 
+test_expect_success "execute-commands.sample: new execute-commands hook from templates/execute-commands.sample" '
+	mv $bare/hooks/pre-receive $bare/hooks/pre-receive.fail &&
+	mv $bare/hooks/pre-receive.ok $bare/hooks/pre-receive &&
+	mv $bare/hooks/post-receive $bare/hooks/post-receive.env &&
+	mv $bare/hooks/post-receive.ok $bare/hooks/post-receive &&
+	mv $bare/hooks/execute-commands $bare/hooks/execute-commands.env &&
+	cp ../../templates/hooks--execute-commands.sample $bare/hooks/execute-commands &&
+	chmod a+x $bare/hooks/execute-commands
+'
+
+test_expect_success "execute-commands.sample: show push result" '
+	(
+		cd work &&
+		git push origin \
+			HEAD:refs/for/a/b/c/my/topic
+	) >out 2>&1 &&
+	grep "^remote:" out | sed -e "s/  *\$//g" >actual &&
+	cat >expect <<-EOF &&
+	remote: 102939797ab91a4f201d131418d2c9d919dcdd2c
+	remote: [execute-commands] *******************************************************
+	remote: [execute-commands] * Pull request #12345678901 created/updated           *
+	remote: [execute-commands] * URL: https://... ...                                *
+	remote: [execute-commands] *******************************************************
+	remote: execute: post-receive hook
+	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/for/a/b/c/my/topic.
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "execute-commands.sample: show debug info" '
+	(
+		cd work &&
+		git push -o debug=1 -o reviewers=user1,user2 \
+			origin \
+			HEAD:refs/for/a/b/c/my/topic
+	) >out 2>&1 &&
+	grep "^remote:" out | sed -e "s/  *\$//g" >actual &&
+	cat >expect <<-EOF &&
+	remote: [DEBUG] [execute-commands] push-option: AGIT_DEBUG=1
+	remote: [DEBUG] [execute-commands] push-option: AGIT_REVIEWERS=user1,user2
+	remote: [DEBUG] [execute-commands] command from stdin: 0000000000000000000000000000000000000000 ce858e653cdbf70f9955a39d73a44219e4b92e9e refs/for/a/b/c/my/topic
+	remote: 102939797ab91a4f201d131418d2c9d919dcdd2c
+	remote: [DEBUG] [execute-commands: pre-receive] check permissions...
+	remote: [DEBUG] [execute-commands] push-option: AGIT_DEBUG=1
+	remote: [DEBUG] [execute-commands] push-option: AGIT_REVIEWERS=user1,user2
+	remote: [DEBUG] [execute-commands] command from stdin: 0000000000000000000000000000000000000000 ce858e653cdbf70f9955a39d73a44219e4b92e9e refs/for/a/b/c/my/topic
+	remote: [DEBUG] [execute-commands] call API (AGIT_PR_TARGET=a/b/c, AGIT_PR_TOPIC=)...
+	remote: [DEBUG] [execute-commands] parse API result, and get AGIT_PR_ID, etc.
+	remote: [execute-commands] *******************************************************
+	remote: [execute-commands] * Pull request #12345678901 created/updated           *
+	remote: [execute-commands] * URL: https://... ...                                *
+	remote: [execute-commands] *******************************************************
+	remote: [DEBUG] [execute-commands] output kv pairs to stdout for git to parse.
+	remote: execute: post-receive hook
+	remote: >> old: 0000000000000000000000000000000000000000, new: ce858e653cdbf70f9955a39d73a44219e4b92e9e, ref: refs/for/a/b/c/my/topic.
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "execute-commands.sample: fail to push refs/for/maint" '
+	(
+		cd work &&
+		test_must_fail git push -o reviewers=user1,user2 \
+			origin \
+			HEAD:refs/for/maint/my/topic
+	) >out 2>&1 &&
+	grep "^remote:" out | sed -e "s/  *\$//g" >actual &&
+	cat >expect <<-EOF &&
+	remote: 102939797ab91a4f201d131418d2c9d919dcdd2c
+	remote: [execute-commands: pre-receive] send pull request to maint branch is not allowed
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "execute-commands.sample: fail to push non-exist branch" '
+	(
+		cd work &&
+		test_must_fail git push -o reviewers=user1,user2 \
+			origin \
+			HEAD:refs/for/a/b/x/my/topic
+	) >out 2>&1 &&
+	grep "^remote:" out | sed -e "s/  *\$//g" >actual &&
+	cat >expect <<-EOF &&
+	remote: [execute-commands] cannot find target branch from ref: refs/for/a/b/x/my/topic
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "show refs of the repository using git-show-ref" '
+	git -C $bare show-ref >actual &&
+	cat >expect <<-EOF &&
+	102939797ab91a4f201d131418d2c9d919dcdd2c refs/heads/a/b/c
+	102939797ab91a4f201d131418d2c9d919dcdd2c refs/heads/maint
+	102939797ab91a4f201d131418d2c9d919dcdd2c refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
 test_done
diff --git a/templates/hooks--execute-commands.sample b/templates/hooks--execute-commands.sample
new file mode 100755
index 0000000000..d061984bca
--- /dev/null
+++ b/templates/hooks--execute-commands.sample
@@ -0,0 +1,131 @@
+#!/bin/sh
+#
+# This is an  example hook script, DO NOT use it on production service.
+
+debug() {
+	case "$AGIT_DEBUG" in
+	"yes" | "true" | "1")
+		;;
+	*)
+		return
+	esac
+
+	echo >&2 "[DEBUG] $@"
+}
+
+# Parse push options
+if test -n "$GIT_PUSH_OPTION_COUNT"
+then
+	i=0
+	while test "$i" -lt "$GIT_PUSH_OPTION_COUNT"
+	do
+		eval "value=\$GIT_PUSH_OPTION_$i"
+		i=$((i + 1))
+
+		k=$(echo ${value%=*} | tr [a-z] [A-Z])
+		v=${value#*=}
+		if test -n "$v" && test -n "$k"
+		then
+			k="AGIT_$k"
+		else
+			continue
+		fi
+		eval "$k=$v"
+		debug "[execute-commands] push-option: $k=$v"
+	done
+fi
+
+# Read push commands.
+count=0
+while read old new refname
+do
+	debug "[execute-commands] command from stdin: $old $new $refname"
+	count=$(( count + 1 ))
+	# Only one special refname is allowed for each push
+	if test $count -gt 1
+	then
+		echo >&2 "[execute-commands]: cannot handle more than one push commands"
+		exit 1
+	fi
+
+	# Parse refname, and set envrionment
+	remains=
+	if test "${refname#refs/for/}" != "$refname"
+	then
+		AGIT_PR_IS_DRAFT=false
+		remains=${refname#refs/for/}
+	elif test "${refname#refs/drafts/}" != "$refname"
+	then
+		AGIT_PR_IS_DRAFT=true
+		remains=${refname#refs/drafts/}
+	else
+		echo >&2 "[execute-commands] unknown refname: $refname"
+		exit 1
+	fi
+
+	ref=
+	found_ref=
+	for i in $(echo $remains | tr "/" "\n")
+	do
+		if test -z "$ref"
+		then
+			ref=$i
+		else
+			ref=$ref/$i
+		fi
+		if git rev-parse --verify $ref -- 2>/dev/null
+		then
+			found_ref=yes
+			break
+		fi
+	done
+	if test -z "$found_ref"
+	then
+		echo >&2 "[execute-commands] cannot find target branch from ref: $refname"
+		exit 1
+	fi
+	AGIT_PR_TARGET=$ref
+	AGIT_PR_SOURCE=${remains#$ref/}
+done
+
+if test -z "$AGIT_PR_TARGET"
+then
+	echo >&2 "[execute-commands] fail to parse refname, no target found"
+	exit 1
+fi
+
+# pre-receive mode, used to check permissions.
+if test "$1" = "--pre-receive"
+then
+	debug "[execute-commands: pre-receive] check permissions..."
+	if test "$AGIT_PR_TARGET" = "maint"
+	then
+		echo >&2 "[execute-commands: pre-receive] send pull request to maint branch is not allowed"
+		exit 1
+	fi
+	exit 0
+fi
+
+# Call API to generate code review.
+debug "[execute-commands] call API (AGIT_PR_TARGET=$AGIT_PR_TARGET, AGIT_PR_TOPIC=$AGIT_PR_TOPIC)..."
+
+# Parse result of API.
+debug "[execute-commands] parse API result, and get AGIT_PR_ID, etc."
+AGIT_PR_ID="12345678901"
+AGIT_PR_LOCAL_ID="23"
+
+# Show message.
+if test -n "$AGIT_PR_ID"
+then
+	echo >&2 "[execute-commands] *******************************************************"
+	echo >&2 "[execute-commands] * Pull request #$AGIT_PR_ID created/updated           *"
+	echo >&2 "[execute-commands] * URL: https://... ...                                *"
+	echo >&2 "[execute-commands] *******************************************************"
+fi
+
+# Show envs to stdout, and will be exported as envs for "post-receive" hook.
+debug "[execute-commands] output kv pairs to stdout for git to parse."
+echo "AGIT_PR_ID=$AGIT_PR_ID"
+echo "AGIT_PR_LOCAL_ID=$AGIT_PR_LOCAL_ID"
+
+exit 0
-- 
2.25.1.362.g51ebf55b93

