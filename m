Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9432C4332B
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 13:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724F5206C3
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 13:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pkBaA9gL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgCVNS2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 09:18:28 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:54560 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgCVNS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 09:18:28 -0400
Received: by mail-pj1-f66.google.com with SMTP id np9so4807675pjb.4
        for <git@vger.kernel.org>; Sun, 22 Mar 2020 06:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DMrYhzVG6GMpmze6k7qz6cpaMgWCkFRuRT2dFP9SExU=;
        b=pkBaA9gL7fdYD0XEuXdH8ZQd8H6LjXWRYN6VN7UnwwgGzeCx39P22rzpiK3va/yGZw
         uMN5taAIJV2Pk4Smkek4ph2ADA15SUUD9GLwxRZPNdrOlVma26N4DOI87KmzoaMnjOoC
         uK5B2zeO8dTfw9TVHG4ZQPtuIrKkbsg/qHlSFiJ+7vaqwRRgdVEzUiiSX25KyXDfy/L0
         iFwiX4E3jQq5+8TPqT1QKZ4wN9p7Q7Lc3d4l2dG8sX+zHoIEeLOFdtfa6+7S9DQ/Uv3u
         i0UeXmIfcajA4LV6OEH9bf3eZdb4+IBIm7YOvqjFRaL9BAPBbrd0uakUcSfoMutKN3SK
         gNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DMrYhzVG6GMpmze6k7qz6cpaMgWCkFRuRT2dFP9SExU=;
        b=m5gFkIxDWqwcE5QhtQIK3+5KnAHC9/4Fe/z0N+sMZyjUqJW9lpz+d76sW9oC7ThQWN
         cWGgrwcrRtzakXBdIZb9fJpili4TMfzHgsjhGLlvD49WA4eiWlwEjKBJsKF9+nm3jwtj
         9FJONNXV+Usl/Le8Quy2HphRKl/Se9jB7LzzL67nVC5YYWMgVxcwfnj9bj2A8oOcHgM2
         aSPXrXlLZA8CaGTu4Jp3Mi4XHRfMMgBrelp+LefGunx806MzzXjGF738lIjgcDDjZDXE
         TS6vxr1ri7PWUvuFGlaGc/XgiIcicwk9rGOl39KIltYXwhuK3gL2h/R503g94JwaOIeH
         EwuQ==
X-Gm-Message-State: ANhLgQ2AbLOGzT1fHRl1OnjrB+AAREi5Nh/PcaAGj4n+NnZCYxvMRfZs
        ieMdZpmnOBIYl0QdBZfv7/U=
X-Google-Smtp-Source: ADFU+vvbNztPguZxXhrz6yTQa4xgy9vX5EvpY/OjFVWunU5mE08HR82MJr47kRbRAOwaK1VzhWtdIw==
X-Received: by 2002:a17:90b:282:: with SMTP id az2mr20345121pjb.13.1584883106471;
        Sun, 22 Mar 2020 06:18:26 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id nh4sm9456432pjb.39.2020.03.22.06.18.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Mar 2020 06:18:26 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v4 1/5] transport: not report a non-head push as a branch
Date:   Sun, 22 Mar 2020 09:18:11 -0400
Message-Id: <20200322131815.11872-2-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200313122318.78000-1-zhiyou.jx@alibaba-inc.com>
References: <20200313122318.78000-1-zhiyou.jx@alibaba-inc.com>
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
 t/t5411-proc-receive-hook.sh | 144 +++++++++++++++++++++++++++++++++++
 transport.c                  |   3 +-
 2 files changed, 146 insertions(+), 1 deletion(-)
 create mode 100755 t/t5411-proc-receive-hook.sh

diff --git a/t/t5411-proc-receive-hook.sh b/t/t5411-proc-receive-hook.sh
new file mode 100755
index 0000000000..fe2861f2e6
--- /dev/null
+++ b/t/t5411-proc-receive-hook.sh
@@ -0,0 +1,144 @@
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
+# NOTE: Avoid calling this function from a subshell since variable
+# assignments will disappear when subshell exits.
+create_commits_in () {
+	repo="$1" &&
+	if ! parent=$(git -C "$repo" rev-parse HEAD^{} 2>/dev/null)
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
+format_git_output () {
+	sed \
+		-e "s/  *\$//g" \
+		-e "s/$A/<COMMIT-A>/g" \
+		-e "s/$B/<COMMIT-B>/g" \
+		-e "s/$TAG/<COMMIT-T>/g" \
+		-e "s/$ZERO_OID/<ZERO-OID>/g" \
+		-e "s/'/\"/g"
+}
+
+test_expect_success "setup" '
+	git init --bare upstream &&
+	git init workbench &&
+	create_commits_in workbench A B &&
+	(
+		cd workbench &&
+		git remote add origin ../upstream &&
+		git config core.abbrev 7 &&
+		git update-ref refs/heads/master $A &&
+		git tag -m "v1.0.0" v1.0.0 $A &&
+		git push origin \
+			$B:refs/heads/master \
+			$A:refs/heads/next
+	) &&
+	TAG=$(cd workbench; git rev-parse v1.0.0) &&
+
+	# setup pre-receive hook
+	cat >upstream/hooks/pre-receive <<-EOF &&
+	#!/bin/sh
+
+	printf >&2 "# pre-receive hook\n"
+
+	while read old new ref
+	do
+		printf >&2 "pre-receive< \$old \$new \$ref\n"
+	done
+	EOF
+
+	# setup post-receive hook
+	cat >upstream/hooks/post-receive <<-EOF &&
+	#!/bin/sh
+
+	printf >&2 "# post-receive hook\n"
+
+	while read old new ref
+	do
+		printf >&2 "post-receive< \$old \$new \$ref\n"
+	done
+	EOF
+
+	chmod a+x \
+		upstream/hooks/pre-receive \
+		upstream/hooks/post-receive
+'
+
+test_expect_success "normal git-push command" '
+	(
+		cd workbench &&
+		git push -f origin \
+			refs/tags/v1.0.0 \
+			:refs/heads/next \
+			HEAD:refs/heads/master \
+			HEAD:refs/review/master/topic \
+			HEAD:refs/heads/a/b/c
+	) >out 2>&1 &&
+	format_git_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <COMMIT-B> <COMMIT-A> refs/heads/master
+	remote: pre-receive< <COMMIT-A> <ZERO-OID> refs/heads/next
+	remote: pre-receive< <ZERO-OID> <COMMIT-T> refs/tags/v1.0.0
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/review/master/topic
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/a/b/c
+	remote: # post-receive hook
+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/heads/master
+	remote: post-receive< <COMMIT-A> <ZERO-OID> refs/heads/next
+	remote: post-receive< <ZERO-OID> <COMMIT-T> refs/tags/v1.0.0
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/review/master/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/a/b/c
+	To ../upstream
+	 + ce858e6...1029397 HEAD -> master (forced update)
+	 - [deleted]         next
+	 * [new tag]         v1.0.0 -> v1.0.0
+	 * [new reference]   HEAD -> refs/review/master/topic
+	 * [new branch]      HEAD -> a/b/c
+	EOF
+	test_cmp expect actual &&
+	(
+		cd upstream &&
+		git show-ref
+	) >out &&
+	format_git_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/a/b/c
+	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/review/master/topic
+	<COMMIT-T> refs/tags/v1.0.0
+	EOF
+	test_cmp expect actual
+'
+
+test_done
diff --git a/transport.c b/transport.c
index 1fdc7dac1a..b5b7bb841e 100644
--- a/transport.c
+++ b/transport.c
@@ -501,7 +501,8 @@ static void print_ok_ref_status(struct ref *ref, int porcelain, int summary_widt
 	else if (is_null_oid(&ref->old_oid))
 		print_ref_status('*',
 			(starts_with(ref->name, "refs/tags/") ? "[new tag]" :
-			"[new branch]"),
+			(starts_with(ref->name, "refs/heads/") ? "[new branch]" :
+			"[new reference]")),
 			ref, ref->peer_ref, NULL, porcelain, summary_width);
 	else {
 		struct strbuf quickref = STRBUF_INIT;
-- 
2.26.0.rc1.33.g4914ba4bcf

