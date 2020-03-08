Return-Path: <SRS0=m/qT=4Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCECEC10F27
	for <git@archiver.kernel.org>; Sun,  8 Mar 2020 15:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE862084E
	for <git@archiver.kernel.org>; Sun,  8 Mar 2020 15:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhNHsA5q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgCHPiX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Mar 2020 11:38:23 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:40650 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgCHPiW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Mar 2020 11:38:22 -0400
Received: by mail-pj1-f65.google.com with SMTP id gv19so3301646pjb.5
        for <git@vger.kernel.org>; Sun, 08 Mar 2020 08:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QCRoykGyqvBYbGdGdBEY+MSzZ9WPPSm9L8vfS0EeIzg=;
        b=YhNHsA5qZM8cGHaU8o97Aqb/BdCiMCVnR0QKnHCIftQFI9Ynb9mvgzHU1YJYrG75km
         vt5rEse0cgYOg8TVCmuCuH+0387bzwK9RVuKiLu63AP3eWsApudrZQHM+qD7hPc97lw0
         enH+uw71I3XfGZbZ89Fi+1cPcPuqlKwPO+ugppBPbwY53Jrg6EbWAi24Gm9col9hwQNs
         O/v1O65mT22A0S4ji/63DADCRRDpIFPjmZIe9fqqzbfB7WRSw96dH3b1onlJ7y2Ph/yy
         UhRvWaz8W8+0hb4soFcnzgzfY35T6ApDeDvhTuZfgpYD1YssZo6/hdxBPhUHgQAXo7M9
         ynfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QCRoykGyqvBYbGdGdBEY+MSzZ9WPPSm9L8vfS0EeIzg=;
        b=H3XIfbr/DgBpJ34zPy8fMbEM1l0NAKYUEsL4x3zR7nTkH3FIFD9xiWAmqqNT2kzFIT
         DyilMFXTJGFKQ9UXpVZCNmyi/Vln9cx21lY9SNHF2LLi3AOA6gByzolF7ntLymGYvNy8
         BPsoS3BNKnadFFDed5PEuE0dvDF/7JJo9nHR85HwMSael1I9SctFFUdXC3vIhkrEQUqB
         DWP5CvA9V+2uA45BPG5WfaStP3Dwo+1KFZZrgHfAuqeMCsDgRCSj75CcgFAVKPHa6e6A
         hy6WaAKdqqZaI5sNHCTV1CaPy473OQu8MB4SePtYs2FODGG1XSiuIYKwLFm++5THnLl8
         jBfA==
X-Gm-Message-State: ANhLgQ3+vxYXoK0kEbbxSQzma7gdFIZBZPYi3xfDLHvLVao1ZWY/jbjk
        QBKsanZaPVoc4uEjUkTqO3w=
X-Google-Smtp-Source: ADFU+vs+Nfi/FMrEeN/D3YzN9KZkiy+pWF3eWT76NzCyjB/GS9dK2LCXyMhlPtgqYc7qhV78k6QJLg==
X-Received: by 2002:a17:90a:ab0a:: with SMTP id m10mr889552pjq.105.1583681901665;
        Sun, 08 Mar 2020 08:38:21 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id a143sm18141508pfd.108.2020.03.08.08.38.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Mar 2020 08:38:21 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v2 5/5] hook: add document and example for "proc-receive" hook
Date:   Sun,  8 Mar 2020 11:38:16 -0400
Message-Id: <20200308153816.4690-3-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <CANYiYbE2V3bLfEgH-aRDv4Y5V+_BTZn-oUN7fOVpARm+_14BdQ@mail.gmail.com>
References: <CANYiYbE2V3bLfEgH-aRDv4Y5V+_BTZn-oUN7fOVpARm+_14BdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 Documentation/githooks.txt           |  22 +++++
 t/t5411-proc-receive-hook.sh         |  71 ++++++++++++++++
 templates/hooks--proc-receive.sample | 119 +++++++++++++++++++++++++++
 3 files changed, 212 insertions(+)
 create mode 100755 templates/hooks--proc-receive.sample

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 3dccab5375..1af213bad8 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -333,6 +333,28 @@ The default 'update' hook, when enabled--and with
 `hooks.allowunannotated` config option unset or set to false--prevents
 unannotated tags to be pushed.
 
+[[proc-receive]]
+proc-receive
+~~~~~~~~~~~~
+This hook is invoked by linkgit:git-receive-pack[1] when it reacts to
+special `git push` command.  According to refnames of the commands which
+`git push` sends to 'git-receive-pack', the commands will be devided
+into two groups by matching what the `receive.procReceiveRefs`
+configuration variable defines.  One group of the commands will execute
+the internal `execute_commands` function to update the corresponding
+refnames, and the other group of commands which have matching refnames
+will execute this 'proc-receive' hook to create pull requests, etc.
+If there is no `receive.procReceiveRefs` settings, this hook won't
+execute at all, and all commands are sent to the internal
+`execute_commands` function.
+
+Its exit status only determines the success or failure of the group of
+commands with special refnames, unless atomic push is in use.
+
+This hook executes once for the receive operation.  It takes no
+arguments, but gets the same information as the
+<<pre-receive,'pre-receive'>> hook does on its standard input.
+
 [[post-receive]]
 post-receive
 ~~~~~~~~~~~~
diff --git a/t/t5411-proc-receive-hook.sh b/t/t5411-proc-receive-hook.sh
index 6f35867e85..caedd49f2e 100755
--- a/t/t5411-proc-receive-hook.sh
+++ b/t/t5411-proc-receive-hook.sh
@@ -757,4 +757,75 @@ test_expect_success "(7) push one special ref (show environments)" '
 	test_cmp expect actual
 '
 
+test_expect_success "(8) install proc-receive from proc-receive.sample" '
+	mv $bare/hooks/pre-receive $bare/hooks/pre-receive.ok &&
+	mv $bare/hooks/post-receive $bare/hooks/post-receive.env &&
+	mv $bare/hooks/proc-receive $bare/hooks/proc-receive.env &&
+	cp ../../templates/hooks--proc-receive.sample $bare/hooks/proc-receive &&
+	chmod a+x $bare/hooks/proc-receive
+'
+
+test_expect_success "(8) proc-receive.sample: show push result" '
+	(
+		cd work &&
+		git push origin \
+			HEAD:refs/for/a/b/c/my/topic
+	) >out 2>&1 &&
+	grep "^remote:" out | sed -e "s/  *\$//g" >actual &&
+	cat >expect <<-EOF &&
+	remote: [proc-receive] *******************************************************
+	remote: [proc-receive] * Pull request #12345678901 created/updated           *
+	remote: [proc-receive] * URL: https://... ...                                *
+	remote: [proc-receive] *******************************************************
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "(8) proc-receive.sample: show debug info" '
+	(
+		cd work &&
+		git push -o debug=1 -o reviewers=user1,user2 \
+			origin \
+			HEAD:refs/for/a/b/c/my/topic
+	) >out 2>&1 &&
+	grep "^remote:" out | sed -e "s/  *\$//g" >actual &&
+	cat >expect <<-EOF &&
+	remote: [DEBUG] [proc-receive] push-option: AGIT_DEBUG=1
+	remote: [DEBUG] [proc-receive] push-option: AGIT_REVIEWERS=user1,user2
+	remote: [DEBUG] [proc-receive] command from stdin: $ZERO_OID $B refs/for/a/b/c/my/topic
+	remote: [DEBUG] [proc-receive] call API (AGIT_PR_TARGET=a/b/c, AGIT_PR_TOPIC=)...
+	remote: [DEBUG] [proc-receive] parse API result, and get AGIT_PR_ID, etc.
+	remote: [proc-receive] *******************************************************
+	remote: [proc-receive] * Pull request #12345678901 created/updated           *
+	remote: [proc-receive] * URL: https://... ...                                *
+	remote: [proc-receive] *******************************************************
+	remote: [DEBUG] [proc-receive] output kv pairs to stdout for git to parse.
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "(8) proc-receive.sample: fail to push non-exist branch" '
+	(
+		cd work &&
+		test_must_fail git push -o reviewers=user1,user2 \
+			origin \
+			HEAD:refs/for/a/b/x/my/topic
+	) >out 2>&1 &&
+	grep "^remote:" out | sed -e "s/  *\$//g" >actual &&
+	cat >expect <<-EOF &&
+	remote: [proc-receive] cannot find target branch from ref: refs/for/a/b/x/my/topic
+	EOF
+	test_cmp expect actual &&
+	(
+		cd $bare &&
+		git show-ref
+	) >actual &&
+	cat >expect <<-EOF &&
+	$A refs/heads/a/b/c
+	$A refs/heads/maint
+	$A refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
 test_done
diff --git a/templates/hooks--proc-receive.sample b/templates/hooks--proc-receive.sample
new file mode 100755
index 0000000000..31fa85ffe1
--- /dev/null
+++ b/templates/hooks--proc-receive.sample
@@ -0,0 +1,119 @@
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
+		debug "[proc-receive] push-option: $k=$v"
+	done
+fi
+
+# Read push commands.
+count=0
+while read old new refname
+do
+	debug "[proc-receive] command from stdin: $old $new $refname"
+	count=$(( count + 1 ))
+	# Only one special refname is allowed for each push
+	if test $count -gt 1
+	then
+		echo >&2 "[proc-receive]: cannot handle more than one push commands"
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
+		echo >&2 "[proc-receive] unknown refname: $refname"
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
+		echo >&2 "[proc-receive] cannot find target branch from ref: $refname"
+		exit 1
+	fi
+	AGIT_PR_TARGET=$ref
+	AGIT_PR_SOURCE=${remains#$ref/}
+done
+
+if test -z "$AGIT_PR_TARGET"
+then
+	echo >&2 "[proc-receive] fail to parse refname, no target found"
+	exit 1
+fi
+
+# Call API to generate code review.
+debug "[proc-receive] call API (AGIT_PR_TARGET=$AGIT_PR_TARGET, AGIT_PR_TOPIC=$AGIT_PR_TOPIC)..."
+
+# Parse result of API.
+debug "[proc-receive] parse API result, and get AGIT_PR_ID, etc."
+AGIT_PR_ID="12345678901"
+AGIT_PR_LOCAL_ID="23"
+
+# Show message.
+if test -n "$AGIT_PR_ID"
+then
+	echo >&2 "[proc-receive] *******************************************************"
+	echo >&2 "[proc-receive] * Pull request #$AGIT_PR_ID created/updated           *"
+	echo >&2 "[proc-receive] * URL: https://... ...                                *"
+	echo >&2 "[proc-receive] *******************************************************"
+fi
+
+# Show envs to stdout, and will be exported as envs for "post-receive" hook.
+debug "[proc-receive] output kv pairs to stdout for git to parse."
+echo "AGIT_PR_ID=$AGIT_PR_ID"
+echo "AGIT_PR_LOCAL_ID=$AGIT_PR_LOCAL_ID"
+
+exit 0
-- 
2.26.0.rc0.5.gb02b988a14.dirty

