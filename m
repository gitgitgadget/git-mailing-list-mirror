Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C9AC43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 16:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D06E920776
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 16:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfRU3UN1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbgC3Q6F (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 12:58:05 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35842 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgC3Q6F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 12:58:05 -0400
Received: by mail-pf1-f193.google.com with SMTP id i13so8882614pfe.3
        for <git@vger.kernel.org>; Mon, 30 Mar 2020 09:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B9QSCEk7yE2zlJXYKaq2yfWDxnM5gWJbIfoxoVxCSEM=;
        b=OfRU3UN1dcQguhxtP3XcHx5kUWOyLEoONQK5UMY4keJgk90DiyFTugxG7WRe2HNIVN
         skoWxy61CHdUUhzy9Giv7iOox2rWW8Cs0b84j62+xloblyGdTleatkeE0Q1+gCuH/v7f
         3Id4sGULUj1Ri/tw34TPUqimbUKMsnHXb0FtVtIPvW0I1CIdzBjq7sy03ZvZjVVErW2X
         96zouSZUI1fujpTmj/KsMhRo8FJMdLIPJo6uXKN5bi3BI4A4+s3eajHyHLKvplMcSUT0
         W8xUECmqH2hrEEVsviRpIHYym/goHVMdSTWcGAwurFSZcKVjkg2yJ749Fx90SJQSRgFx
         UyEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B9QSCEk7yE2zlJXYKaq2yfWDxnM5gWJbIfoxoVxCSEM=;
        b=kyUpDHHq9ElCQFI563eqlJEeFNuOLcsCpL8KaumddMJrb7hD91sxig5bwkkZjdMwrx
         U6aPIJZK+7E/3eD1UFRRYzgr3Jfmq8g6ZPh0QgFC5kGcju5mekGumOD40/gdqEN36dWJ
         tZn4VUsMGPsnYNyT2DmbuTcRhEI+GL2BMhLIcK4Zdxsk6aIpGTkvzLMD1cTrXPKNAJ7e
         vgqwd9cMMDTSVBEUbg4guJySlIkqHBaAKmPQ1nd1ij+fWQ6MK2PjwLeXaIIlwkd74Jbo
         VUJFlCtYVxQHSOahBcRomEiyBud8nXophWberdaMiROn5AZgVKJ8xURJMfU0r/5dfg2e
         o9MA==
X-Gm-Message-State: AGi0PuaLnKodN0oqlrx5o6DSmk/rIYFXtgj9q6CmZUXIdEDLx5K1L21U
        PpDxqF5HAPf2hPZRJKZeNihDawZ8Ty0=
X-Google-Smtp-Source: APiQypLIdddlaOOS2QSTGhMkkK5aB1G8f3a7in/alsvs+CLCy3Qi4tfJI3iC6dPab2rOXo6Kd4PCJg==
X-Received: by 2002:aa7:9839:: with SMTP id q25mr213391pfl.2.1585587483712;
        Mon, 30 Mar 2020 09:58:03 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id a24sm10589604pfl.115.2020.03.30.09.58.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Mar 2020 09:58:03 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v5 1/6] transport: not report a non-head push as a branch
Date:   Mon, 30 Mar 2020 12:57:49 -0400
Message-Id: <20200330165754.19195-2-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200304113312.34229-1-zhiyou.jx@alibaba-inc.com>
References: <20200304113312.34229-1-zhiyou.jx@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

When pushing a new reference (not a head or tag), report it as a new
reference instead of a new branch.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t5411-proc-receive-hook.sh | 153 +++++++++++++++++++++++++++++++++++
 t/t5516-fetch-push.sh        |   2 +-
 transport.c                  |   9 ++-
 3 files changed, 160 insertions(+), 4 deletions(-)
 create mode 100755 t/t5411-proc-receive-hook.sh

diff --git a/t/t5411-proc-receive-hook.sh b/t/t5411-proc-receive-hook.sh
new file mode 100755
index 0000000000..1784bcb584
--- /dev/null
+++ b/t/t5411-proc-receive-hook.sh
@@ -0,0 +1,153 @@
+#!/bin/sh
+#
+# Copyright (c) 2020 Jiang Xin
+#
+
+test_description='Test proc-receive hook'
+
+. ./test-lib.sh
+
+# Create commits in <repo> and assign each commit's oid to shell variables
+# given in the arguments (A, B, and C). E.g.:
+#
+#     create_commits_in <repo> A B C
+#
+# NOTE: Never calling this function from a subshell since variable
+# assignments will disappear when subshell exits.
+create_commits_in () {
+	repo="$1" &&
+	if ! parent=$(git -C "$repo" rev-parse HEAD^{})
+	then
+		parent=
+	fi &&
+	T=$(git -C "$repo" write-tree) &&
+	shift &&
+	while test $# -gt 0
+	do
+		name=$1 &&
+		test_tick &&
+		if test -z "$parent"
+		then
+			oid=$(echo $name | git -C "$repo" commit-tree $T)
+		else
+			oid=$(echo $name | git -C "$repo" commit-tree -p $parent $T)
+		fi &&
+		eval $name=$oid &&
+		parent=$oid &&
+		shift ||
+		return 1
+	done &&
+	git -C "$repo" update-ref refs/heads/master $oid
+}
+
+# Format the output of git-push, git-show-ref and other commands to make a
+# user-friendly and stable text.  We can easily prepare the expect text
+# without having to worry about future changes of the commit ID and spaces
+# of the output.  We also replce single quotes with double quotes, because
+# it is boring to prepare unquoted single quotes in expect txt.
+make_user_friendly_and_stable_output () {
+	sed \
+		-e "s/  *\$//" \
+		-e "s/   */ /g" \
+		-e "s/'/\"/g" \
+		-e "s/$A/<COMMIT-A>/g" \
+		-e "s/$B/<COMMIT-B>/g" \
+		-e "s/$TAG/<TAG-v123>/g" \
+		-e "s/$ZERO_OID/<ZERO-OID>/g" \
+		-e "s/[0-9a-f]\{7,\}/<OID>/g"
+}
+
+# Refs of upstream : master(B)  next(A)
+# Refs of workbench: master(A)           tags/v123
+test_expect_success "setup" '
+	git init --bare upstream &&
+	git init workbench &&
+	create_commits_in workbench A B &&
+	(
+		cd workbench &&
+		# Try to make a stable fixed width for abbreviated commit ID,
+		# this fixed-width oid will be replaced with "<OID>".
+		git config core.abbrev 7 &&
+		git remote add origin ../upstream &&
+		git update-ref refs/heads/master $A &&
+		git tag -m "v123" v123 $A &&
+		git push origin \
+			$B:refs/heads/master \
+			$A:refs/heads/next
+	) &&
+	TAG=$(git -C workbench rev-parse v123) &&
+
+	# setup pre-receive hook
+	cat >upstream/hooks/pre-receive <<-\EOF &&
+	#!/bin/sh
+
+	echo >&2 "# pre-receive hook"
+
+	while read old new ref
+	do
+		echo >&2 "pre-receive< $old $new $ref"
+	done
+	EOF
+
+	# setup post-receive hook
+	cat >upstream/hooks/post-receive <<-\EOF &&
+	#!/bin/sh
+
+	echo >&2 "# post-receive hook"
+
+	while read old new ref
+	do
+		echo >&2 "post-receive< $old $new $ref"
+	done
+	EOF
+
+	chmod a+x \
+		upstream/hooks/pre-receive \
+		upstream/hooks/post-receive
+'
+
+# Refs of upstream : master(B)  next(A)
+# Refs of workbench: master(A)           tags/v123
+# git-push -f      : master(A)  NULL     tags/v123  refs/review/master/topic(A)  a/b/c(A)
+test_expect_success "normal git-push command" '
+	git -C workbench push -f origin \
+		refs/tags/v123 \
+		:refs/heads/next \
+		HEAD:refs/heads/master \
+		HEAD:refs/review/master/topic \
+		HEAD:refs/heads/a/b/c \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <COMMIT-B> <COMMIT-A> refs/heads/master
+	remote: pre-receive< <COMMIT-A> <ZERO-OID> refs/heads/next
+	remote: pre-receive< <ZERO-OID> <TAG-v123> refs/tags/v123
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/review/master/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/a/b/c
+	remote: # post-receive hook
+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/heads/master
+	remote: post-receive< <COMMIT-A> <ZERO-OID> refs/heads/next
+	remote: post-receive< <ZERO-OID> <TAG-v123> refs/tags/v123
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/review/master/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/a/b/c
+	To ../upstream
+	 + <OID>...<OID> HEAD -> master (forced update)
+	 - [deleted] next
+	 * [new tag] v123 -> v123
+	 * [new reference] HEAD -> refs/review/master/topic
+	 * [new branch] HEAD -> a/b/c
+	EOF
+	test_cmp expect actual &&
+	git -C upstream show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/a/b/c
+	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/review/master/topic
+	<TAG-v123> refs/tags/v123
+	EOF
+	test_cmp expect actual
+'
+
+test_done
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 9ff041a093..9e4b9313b5 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1039,7 +1039,7 @@ test_force_fetch_tag "annotated tag" "-f -a -m'tag message'"
 test_expect_success 'push --porcelain' '
 	mk_empty testrepo &&
 	echo >.git/foo  "To testrepo" &&
-	echo >>.git/foo "*	refs/heads/master:refs/remotes/origin/master	[new branch]"  &&
+	echo >>.git/foo "*	refs/heads/master:refs/remotes/origin/master	[new reference]"  &&
 	echo >>.git/foo "Done" &&
 	git push >.git/bar --porcelain  testrepo refs/heads/master:refs/remotes/origin/master &&
 	(
diff --git a/transport.c b/transport.c
index 1fdc7dac1a..272c0f4046 100644
--- a/transport.c
+++ b/transport.c
@@ -500,9 +500,12 @@ static void print_ok_ref_status(struct ref *ref, int porcelain, int summary_widt
 				 porcelain, summary_width);
 	else if (is_null_oid(&ref->old_oid))
 		print_ref_status('*',
-			(starts_with(ref->name, "refs/tags/") ? "[new tag]" :
-			"[new branch]"),
-			ref, ref->peer_ref, NULL, porcelain, summary_width);
+				 (starts_with(ref->name, "refs/tags/")
+				  ? "[new tag]"
+				  : (starts_with(ref->name, "refs/heads/")
+				     ? "[new branch]"
+				     : "[new reference]")),
+				 ref, ref->peer_ref, NULL, porcelain, summary_width);
 	else {
 		struct strbuf quickref = STRBUF_INIT;
 		char type;
-- 
2.26.0.4.g39bcdcb101.dirty

