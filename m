Return-Path: <SRS0=oqjl=22=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DD6C33C9B
	for <git@archiver.kernel.org>; Sun,  5 Jan 2020 13:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6490D20866
	for <git@archiver.kernel.org>; Sun,  5 Jan 2020 13:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dyntopia-com.20150623.gappssmtp.com header.i=@dyntopia-com.20150623.gappssmtp.com header.b="oxhMuuSA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgAEN4f (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Jan 2020 08:56:35 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36274 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgAEN4e (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Jan 2020 08:56:34 -0500
Received: by mail-pf1-f193.google.com with SMTP id x184so25713353pfb.3
        for <git@vger.kernel.org>; Sun, 05 Jan 2020 05:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dyntopia-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g5CPEi1473t6RTC0Gz3LGXkp2lQxK5muwgJxMQ0Ksbc=;
        b=oxhMuuSAVp7E2RosvVb8z86Vr7Hf8JcW4s6P17Ewz6sjwLwvygYqwnGzwzvSt8bvoz
         B+25+gGriVKrK0Zt+gV8u1xRSyzBy+ytC2SrhwpRwc0Ri+5OSJWuiV+6Fyoslsi9wrcz
         N+IQUmWrJ7vuk93xW3d1lfvhPLWMZIUDWPTeU8rcl+KSLNOPDJOm19B97iXRHcL2Vzro
         cqkBY+3c6/9dVXw0DdbXywsvcbKW4J1ZLmHZpASlBq7DgR8nG/rApBGQRU3429swYUWW
         j2YVm5tHEbuJsfRPKiWeZJLWB5tzChZPctKaBKdrTHZU2rHEME029Tn+4okIe3JWCOsU
         cA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g5CPEi1473t6RTC0Gz3LGXkp2lQxK5muwgJxMQ0Ksbc=;
        b=D75bsp/QDCvwSjM0+Nzt+wDXNEYpA8yTzrUbJ42KOna6NPFBbXnxsK7XR4LqPFy+Qh
         tpFcWCPdj3xNk0GdteypKZAIKMJ/N/xYIKh6evnmZx7MGvVcDI6AAluTL6FO7Cu0B7h9
         9uNQwcT1BcTjF4eDoOOLcUsjrfkMjUddKmvvWyhvXdFJCigv8H1oS/JUEQImLqFo1fr2
         vjzMNrUAqtTLeNvspyLrC1aHPhprVbunP+HfhzRDoY/G3u61yfhqGrxWQZ7ewynrcxJx
         wChSDM/j18OiPiFQZnub6fGg7TNLNboQ5hYp1oSHigBqcPfXBvFDTPZVXhkFoxUuGF5Y
         cGaQ==
X-Gm-Message-State: APjAAAWlT1isW/jYoXMz1tRDLORcloAeWo507wtC1Qbg3WHRdwNSkWWb
        2uS0h0kDVH90/hVCLHJ1C8921RfaYmc=
X-Google-Smtp-Source: APXvYqx9KbfLqd8vk5KJ1stk1+GrjEoJjMfWrcUdb6trsbfQTPdwG60F+NNgH8klgY6V+c0terbzRg==
X-Received: by 2002:a65:5786:: with SMTP id b6mr66443022pgr.316.1578232592273;
        Sun, 05 Jan 2020 05:56:32 -0800 (PST)
Received: from localhost ([202.62.47.81])
        by smtp.gmail.com with ESMTPSA id z130sm70233466pgz.6.2020.01.05.05.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 05:56:31 -0800 (PST)
From:   Hans Jerry Illikainen <hji@dyntopia.com>
To:     git@vger.kernel.org
Cc:     Hans Jerry Illikainen <hji@dyntopia.com>
Subject: [PATCH 4/5] merge: verify signatures if gpg.verifySignatures is true
Date:   Sun,  5 Jan 2020 13:56:15 +0000
Message-Id: <20200105135616.19102-5-hji@dyntopia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200105135616.19102-1-hji@dyntopia.com>
References: <20200105135616.19102-1-hji@dyntopia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Merge operations has had support for a merge.verifySignatures config
knob for quite some time.  However, there is no global option to enable
signature verification for all operations that support it.  This makes
sense because only merges (and, by extent, pulls) has support for
configurable signature verifications.

However, with the upcoming introduction of signature verification for
clones, it seems reasonable to have a global option that enables
verification for all operations that support it.  Otherwise, users would
have to track down and enable every *.verifySignatures knob.

This patch adds support for a global gpg.verifySignatures in
git_merge_config().  The global variant is overridden by both
merge.verifySignatures and the --(no-)verify-signatures command-line
parameter.

Signed-off-by: Hans Jerry Illikainen <hji@dyntopia.com>
---
 Documentation/config/gpg.txt       |  6 ++++++
 Documentation/config/merge.txt     |  4 +++-
 builtin/merge.c                    |  8 +++++---
 t/t7612-merge-verify-signatures.sh | 27 +++++++++++++++++++++++++++
 4 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/gpg.txt b/Documentation/config/gpg.txt
index d94025cb36..7bf64cff24 100644
--- a/Documentation/config/gpg.txt
+++ b/Documentation/config/gpg.txt
@@ -33,3 +33,9 @@ gpg.minTrustLevel::
 * `marginal`
 * `fully`
 * `ultimate`
+
+gpg.verifySignatures::
+	Verify that commits are signed with a valid key for operations
+	that support signature verification.  This option act as a
+	global default and can be overridden in sections specific to
+	individual operations.
diff --git a/Documentation/config/merge.txt b/Documentation/config/merge.txt
index 6a313937f8..7ff72fafc2 100644
--- a/Documentation/config/merge.txt
+++ b/Documentation/config/merge.txt
@@ -28,7 +28,9 @@ merge.ff::
 
 merge.verifySignatures::
 	If true, this is equivalent to the --verify-signatures command
-	line option. See linkgit:git-merge[1] for details.
+	line option. See linkgit:git-merge[1] for details.  Also see
+	`gpg.verifySignatures` for a global option to enable signature
+	verification.
 
 include::fmt-merge-msg.txt[]
 
diff --git a/builtin/merge.c b/builtin/merge.c
index e472f17738..539dd1dbfc 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -61,7 +61,7 @@ static const char * const builtin_merge_usage[] = {
 static int show_diffstat = 1, shortlog_len = -1, squash;
 static int option_commit = -1;
 static int option_edit = -1;
-static int allow_trivial = 1, have_message, verify_signatures;
+static int allow_trivial = 1, have_message, verify_signatures = -1;
 static int overwrite_ignore = 1;
 static unsigned gpg_flags = GPG_VERIFY_SHORT | GPG_VERIFY_COMPAT;
 static struct strbuf merge_msg = STRBUF_INIT;
@@ -610,6 +610,8 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 		show_diffstat = git_config_bool(k, v);
 	else if (!strcmp(k, "merge.verifysignatures"))
 		verify_signatures = git_config_bool(k, v);
+	else if (!strcmp(k, "gpg.verifysignatures") && verify_signatures < 0)
+		verify_signatures = git_config_bool(k, v);
 	else if (!strcmp(k, "pull.twohead"))
 		return git_config_string(&pull_twohead, k, v);
 	else if (!strcmp(k, "pull.octopus"))
@@ -1399,7 +1401,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		if (remoteheads->next)
 			die(_("Can merge only exactly one commit into empty head"));
 
-		if (verify_signatures &&
+		if (verify_signatures == 1 &&
 		    gpg_verify_commit(&remoteheads->item->object.oid, NULL,
 				      NULL, gpg_flags))
 			die(_("Signature verification failed"));
@@ -1423,7 +1425,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_merge_usage,
 			builtin_merge_options);
 
-	if (verify_signatures) {
+	if (verify_signatures == 1) {
 		for (p = remoteheads; p; p = p->next) {
 			if (gpg_verify_commit(&p->item->object.oid, NULL, NULL,
 					      gpg_flags))
diff --git a/t/t7612-merge-verify-signatures.sh b/t/t7612-merge-verify-signatures.sh
index a426f3a89a..10ab2fa119 100755
--- a/t/t7612-merge-verify-signatures.sh
+++ b/t/t7612-merge-verify-signatures.sh
@@ -125,6 +125,33 @@ test_expect_success GPG 'merge commit with bad signature with merge.verifySignat
 	git merge --no-verify-signatures $(cat forged.commit)
 '
 
+test_expect_success GPG 'merge commit with bad signature with gpg.verifySignatures=true and --no-verify-signatures' '
+	test_when_finished "git reset --hard && git checkout initial" &&
+	test_config gpg.verifySignatures true &&
+	git merge --no-verify-signatures $(cat forged.commit)
+'
+
+test_expect_success GPG 'merge commit with bad signature with gpg.verifySignatures=true and merge.verifySignatures=false' '
+	test_when_finished "git reset --hard && git checkout initial" &&
+	test_config gpg.verifySignatures true &&
+	test_config merge.verifySignatures false &&
+	git merge $(cat forged.commit)
+'
+
+test_expect_success GPG 'merge commit with bad signature with clone.verifySignatures=false and gpg.verifySignatures=true' '
+	test_when_finished "git reset --hard && git checkout initial" &&
+	test_config merge.verifySignatures false &&
+	test_config gpg.verifySignatures true &&
+	git merge $(cat forged.commit)
+'
+
+test_expect_success GPG 'merge commit with bad signature with gpg.verifySignatures=true' '
+	test_when_finished "git reset --hard && git checkout initial" &&
+	test_config gpg.verifySignatures true &&
+	test_must_fail git merge $(cat forged.commit) 2>mergeerror &&
+	test_i18ngrep "has a bad GPG signature allegedly by" mergeerror
+'
+
 test_expect_success GPG 'merge unsigned commit into unborn branch' '
 	test_when_finished "git checkout initial" &&
 	git checkout --orphan unborn &&
-- 
2.25.0.rc1.302.gc71d20beed

