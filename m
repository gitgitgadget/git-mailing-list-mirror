Return-Path: <SRS0=oqjl=22=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F795C33C8C
	for <git@archiver.kernel.org>; Sun,  5 Jan 2020 17:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E45620848
	for <git@archiver.kernel.org>; Sun,  5 Jan 2020 17:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dyntopia-com.20150623.gappssmtp.com header.i=@dyntopia-com.20150623.gappssmtp.com header.b="B1CIHv7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgAERlj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Jan 2020 12:41:39 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33798 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgAERli (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Jan 2020 12:41:38 -0500
Received: by mail-pf1-f195.google.com with SMTP id i6so19023396pfc.1
        for <git@vger.kernel.org>; Sun, 05 Jan 2020 09:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dyntopia-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M94F0b2eBv5xQZsYYAtQ3Ah1vFw7Dc9ty70GCJqGIcY=;
        b=B1CIHv7zpye2uwwHtJVZxnnjEKGJ+WFMhXO1IbsZzn5H7wlqI7NtUPjtVw5VoKZBJg
         hCNYeqNKY8qby35263Xzh6mdp7jpsS2Se9X9vLEg05QeQC6dEVPcknnm9VbseY43zwT1
         eVbSx5onflwsjnnkLjyVEA3ljNkPd3YhwXa/AkdLxnSN/w96hwaQuRTg/6eibFvtcgup
         ID3lVYf81T05CI+A/13syDiiRzKJplE1AMFmAJ+yRkYroVqVc7r+5QyzDmdyv1WqUv7x
         XqShFTLm6oKlN9XYbOVv+W8Nfmp/WkReR6zpVNlvAMSCtK2j+Rcs60ElMrRjlrovmQh/
         kUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M94F0b2eBv5xQZsYYAtQ3Ah1vFw7Dc9ty70GCJqGIcY=;
        b=lw43zv+u2WJ8qo/I5Wnd6GR5PIpck2Jx/elIi8pd+z01LpATTprYpnhBItQckcvR+/
         UC2xAG0GNGR1iaK6w4/htgYDlseW3Df8JhK5dWdAmecGk9OZcR1yDwk2abyrtyDcI/Sy
         r4BDAhJ9hWTraVK+/EPHzoeMCSLaavGxPxP4GX9vwDeegxmAE20mZDXjqotrSK/RgTmA
         Fi922wuxDkmsQ6RIT9fcIYKkvKAwtzlR+ttaK53n4HlRAcXpkyP2wYk5+ZLQVUD1TdU7
         hjmXywJOJG1yoS1aYmICOa8e/bXRsgwCHF1KIHo45kKySSqZlZDXAMEw/ELPCji1Egw+
         nIkQ==
X-Gm-Message-State: APjAAAWkTCtsGsp7eF3G9fqs/3wJ08pNSUVFTn9oU2eP0TrYAUzKtUBG
        g6BG2SLs0T9tRhCeSx8D95B4dSt+J88=
X-Google-Smtp-Source: APXvYqycskU/bDFnq4c0kj9/WrGG4SZ97viwMzSpg/yF1owGMl3GcuaRCTcnU4cGBf4qqAaJSZ96Fw==
X-Received: by 2002:a63:6787:: with SMTP id b129mr106959500pgc.103.1578246097488;
        Sun, 05 Jan 2020 09:41:37 -0800 (PST)
Received: from localhost ([202.62.47.81])
        by smtp.gmail.com with ESMTPSA id a1sm61082475pfo.68.2020.01.05.09.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 09:41:37 -0800 (PST)
From:   Hans Jerry Illikainen <hji@dyntopia.com>
To:     git@vger.kernel.org
Cc:     Hans Jerry Illikainen <hji@dyntopia.com>
Subject: [PATCH 1/1] commit: make the sign-off trailer configurable
Date:   Sun,  5 Jan 2020 17:41:27 +0000
Message-Id: <20200105174127.9278-2-hji@dyntopia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200105174127.9278-1-hji@dyntopia.com>
References: <20200105174127.9278-1-hji@dyntopia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit builtin did not previously have a configuration option to
enable the 'Signed-off-by' trailer by default.

For some use-cases (namely, when the user doesn't always have the right
to contribute patches to a project) it makes sense to make it a
conscientious decision to add the signoff trailer.  However, others'
might always have the right to ship patches -- in which case it makes
sense to have an option to add the trailer by default for projects that
require it.

This patch introduces a commit.signOff configuration option that
determine whether the trailer should be added for commits.  It can be
overridden with the --(no-)signoff command-line option.

Signed-off-by: Hans Jerry Illikainen <hji@dyntopia.com>
---
 Documentation/config/commit.txt |  8 ++++++++
 Documentation/git-commit.txt    |  4 ++++
 builtin/commit.c                |  4 ++++
 t/t7502-commit-porcelain.sh     | 36 +++++++++++++++++++++++++++++++++
 4 files changed, 52 insertions(+)

diff --git a/Documentation/config/commit.txt b/Documentation/config/commit.txt
index 2c95573930..6ebfe384ac 100644
--- a/Documentation/config/commit.txt
+++ b/Documentation/config/commit.txt
@@ -15,6 +15,14 @@ commit.gpgSign::
 	convenient to use an agent to avoid typing your GPG passphrase
 	several times.
 
+commit.signOff::
+	A boolean to specify whether commits should enable the
+	`-s/--signoff` option by default.  *Note:* Adding the
+	Signed-off-by: line to a commit message should be a conscious
+	act and means that you certify you have the rights to submit the
+	work under the same open source license.  Please see the
+	'SubmittingPatches' document for further discussion.
+
 commit.status::
 	A boolean to enable/disable inclusion of status information in the
 	commit message template when using an editor to prepare the commit
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index ced5a9beab..61a362770d 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -165,12 +165,16 @@ The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
 
 -s::
 --signoff::
+--no-signoff::
 	Add Signed-off-by line by the committer at the end of the commit
 	log message.  The meaning of a signoff depends on the project,
 	but it typically certifies that committer has
 	the rights to submit this work under the same license and
 	agrees to a Developer Certificate of Origin
 	(see http://developercertificate.org/ for more information).
+	This option can be enabled by default with the `commit.signOff`
+	configuration option, in which case it can be disabled
+	temporarily with `--no-signoff`.
 
 -n::
 --no-verify::
diff --git a/builtin/commit.c b/builtin/commit.c
index c70ad01cc9..497e29c58c 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1474,6 +1474,10 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 		sign_commit = git_config_bool(k, v) ? "" : NULL;
 		return 0;
 	}
+	if (!strcmp(k, "commit.signoff")) {
+		signoff = git_config_bool(k, v);
+		return 0;
+	}
 	if (!strcmp(k, "commit.verbose")) {
 		int is_bool;
 		config_commit_verbose = git_config_bool_or_int(k, v, &is_bool);
diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
index 14c92e4c25..7510325698 100755
--- a/t/t7502-commit-porcelain.sh
+++ b/t/t7502-commit-porcelain.sh
@@ -151,6 +151,42 @@ test_expect_success 'sign off' '
 
 '
 
+test_expect_success 'commit.signOff=true' '
+	test_config commit.signOff true &&
+	echo 1 >>positive &&
+	git add positive &&
+	git commit -m "thank you" &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -ne "s/Signed-off-by: //p" commit.msg >actual &&
+	git var GIT_COMMITTER_IDENT >ident &&
+	sed -e "s/>.*/>/" ident >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'commit.signOff=true and --no-signoff' '
+	test_config commit.signOff true &&
+	echo 2 >>positive &&
+	git add positive &&
+	git commit --no-signoff -m "thank you" &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -ne "s/Signed-off-by: //p" commit.msg >actual &&
+	git var GIT_COMMITTER_IDENT >ident &&
+	sed -e "s/>.*/>/" ident >expected &&
+	! test_cmp expected actual
+'
+
+test_expect_success 'commit.signOff=false and --signoff' '
+	test_config commit.signOff false &&
+	echo 1 >>positive &&
+	git add positive &&
+	git commit --signoff -m "thank you" &&
+	git cat-file commit HEAD >commit.msg &&
+	sed -ne "s/Signed-off-by: //p" commit.msg >actual &&
+	git var GIT_COMMITTER_IDENT >ident &&
+	sed -e "s/>.*/>/" ident >expected &&
+	test_cmp expected actual
+'
+
 test_expect_success 'multiple -m' '
 
 	>negative &&
-- 
2.25.0.rc1.298.g45d5f025e1

