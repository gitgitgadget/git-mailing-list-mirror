Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971AEC43331
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 14:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69DF120789
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 14:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuAjzoZX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbgCYOgW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 10:36:22 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36780 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727593AbgCYOgW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 10:36:22 -0400
Received: by mail-pf1-f193.google.com with SMTP id i13so1130774pfe.3
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 07:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YDpMoAAF8jxVQVIRb8n3Cm6LNcFDvAtJrGuHV2tBSDA=;
        b=AuAjzoZXsio65IvCyQQCkWel4a0fS4+3y4l38CDbfYtKI9dWJGy4qUCJH7p7S3XFWa
         N978igmeQZ8xOSzAZ2E044ovW0xWm22IQryfN7k9BgUhc86rtS2kA2Upvqkb/6Hyjj+U
         LnM51UhZJJnl5KXIaOaD8PqKCfOP9wEdKLUPhwl6ilmJ753F++bmlAGdNWC18+ecfH5n
         rfwQYAyKmXGCo1yGvVCUK2T4LHog2GaQgTuohuX61VutGwKx0OSh2/XVZgLMeuMCJdqv
         JjG8JJH+ivizfkgoOE7XyOJPPFbpvp0h1+t4f0jSAWczsDstSjohBJ5J/Xet352QdQmi
         4NPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YDpMoAAF8jxVQVIRb8n3Cm6LNcFDvAtJrGuHV2tBSDA=;
        b=eKWrsDANH5OToKM7eSCMs+/lUg6sGQMwcGMC1cT7963IRiG+X7sZhh5W+RO08jOr0k
         ubeyP9opmWKlS83wtwbqs/JSVRpEkduHVjN+NoXWhAe1wI66h7pstDP2+vLkzH78D+AY
         E/UZreJZdnllJF0YCRLZZU5EChhlB9xFiw3/hcJX6ZA7qAUQyKXrZ6f9XjTGhNZrBJeH
         QZMRE+aqZu32ZIhobKGV7jlsPTkJOK/Bk9qadoOIxG0I6doC79haqKXwlLk1vlePk/AM
         z6g+hfO1aeWnUSq2KT5DA0dbwrLlbkOc+GuIywvWSd4s6wpqwgkTKZ1zNCv26+of9lmZ
         GQ2Q==
X-Gm-Message-State: ANhLgQ2/th3kFV0DFsztJmallvq2ZTq2XjEV0u+vOYEbB/63kXMOhpRL
        87JjGvmIWqtOtmOMJPqOGzo=
X-Google-Smtp-Source: ADFU+vv41q6SHPoHgpDCDP+vSOAVFAhAj4W/a0QWtNlmn84D3QjKuEqlIrjflKuVrjAgKtXT4TehJw==
X-Received: by 2002:a65:5846:: with SMTP id s6mr3405642pgr.179.1585146981224;
        Wed, 25 Mar 2020 07:36:21 -0700 (PDT)
Received: from localhost.localdomain ([47.89.83.3])
        by smtp.gmail.com with ESMTPSA id f127sm18180423pfa.112.2020.03.25.07.36.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 07:36:20 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
X-Google-Original-From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH 1/3] t5543: never report what we do not push
Date:   Wed, 25 Mar 2020 22:36:06 +0800
Message-Id: <20200325143608.45141-2-zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.26.0.3.ga7a9d752d4
In-Reply-To: <20200322131815.11872-3-worldhello.net@gmail.com>
References: <20200322131815.11872-3-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we push some references to the git server, we expect git to report
the status of the references we are pushing; no more, no less.  But when
pusing with atomic mode, if some references cannot be pushed, Git reports
the reject message on all references in the remote repository.

Add new test cases in t5543, and fix them in latter commit.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t5543-atomic-push.sh | 92 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/t/t5543-atomic-push.sh b/t/t5543-atomic-push.sh
index 7079bcf9a0..4b4c0a262b 100755
--- a/t/t5543-atomic-push.sh
+++ b/t/t5543-atomic-push.sh
@@ -27,6 +27,13 @@ test_refs () {
 	test_cmp expect actual
 }
 
+format_git_output () {
+	awk '/^(To| !) / {print}' | \
+	sed \
+		-e "s/  *\$//g" \
+		-e "s/'/\"/g"
+}
+
 test_expect_success 'atomic push works for a single branch' '
 	mk_repo_pair &&
 	(
@@ -191,4 +198,89 @@ test_expect_success 'atomic push is not advertised if configured' '
 	test_refs master HEAD@{1}
 '
 
+# References in upstream : master(1) one(1) foo(1)
+# References in workbench: master(2)        foo(1) two(2) bar(2)
+# Atomic push            : master(2)               two(2) bar(2)
+test_expect_failure 'atomic push reports (reject by update hook)' '
+	mk_repo_pair &&
+	(
+		cd workbench &&
+		# Keep constant output.
+		git config core.abbrev 7 &&
+		test_commit one &&
+		git branch foo &&
+		git push up master one foo &&
+		git tag -d one
+	) &&
+	(
+		mkdir -p upstream/.git/hooks &&
+		cat >upstream/.git/hooks/update <<-EOF &&
+		#!/bin/sh
+
+		if test "\$1" = "refs/heads/bar"
+		then
+			echo >2 "Pusing to branch bar is prohibited"
+			exit 1
+		fi
+		EOF
+		chmod a+x upstream/.git/hooks/update
+	) &&
+	(
+		cd workbench &&
+		test_commit two &&
+		git branch bar
+	) &&
+	test_must_fail git -C workbench \
+		push --atomic up master two bar >out 2>&1 &&
+	format_git_output <out >actual &&
+	cat >expect <<-EOF &&
+	To ../upstream
+	 ! [remote rejected] master -> master (atomic push failure)
+	 ! [remote rejected] two -> two (atomic push failure)
+	 ! [remote rejected] bar -> bar (hook declined)
+	EOF
+	test_cmp expect actual
+'
+
+# References in upstream : master(1) one(1) foo(1)
+# References in workbench: master(2)        foo(1) two(2) bar(2)
+test_expect_failure 'atomic push reports (mirror, but reject by update hook)' '
+	(
+		cd workbench &&
+		git remote remove up &&
+		git remote add up ../upstream
+	) &&
+	test_must_fail git -C workbench \
+		push --atomic --mirror up >out 2>&1 &&
+	format_git_output <out >actual &&
+	cat >expect <<-EOF &&
+	To ../upstream
+	 ! [remote rejected] master -> master (atomic push failure)
+	 ! [remote rejected] one (atomic push failure)
+	 ! [remote rejected] bar -> bar (hook declined)
+	 ! [remote rejected] two -> two (atomic push failure)
+	EOF
+	test_cmp expect actual
+'
+
+# References in upstream : master(2) one(1) foo(1)
+# References in workbench: master(1)        foo(1) two(2) bar(2)
+test_expect_failure 'atomic push reports (reject by non-ff)' '
+	rm upstream/.git/hooks/update &&
+	(
+		cd workbench &&
+		git push up master &&
+		git reset --hard HEAD^
+	) &&
+	test_must_fail git -C workbench \
+		push --atomic up master foo bar >out 2>&1 &&
+	format_git_output <out >actual &&
+	cat >expect <<-EOF &&
+	To ../upstream
+	 ! [rejected]        master -> master (non-fast-forward)
+	 ! [rejected]        bar -> bar (atomic push failed)
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.26.0.3.ga7a9d752d4

