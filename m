Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520FFC2D0CF
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 12:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21EF720706
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 12:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYngZOdT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfLXMiA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Dec 2019 07:38:00 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38092 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfLXMiA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Dec 2019 07:38:00 -0500
Received: by mail-qk1-f194.google.com with SMTP id k6so15943791qki.5
        for <git@vger.kernel.org>; Tue, 24 Dec 2019 04:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tkfuH/NktMWynwk5bkgWg7t7rq3ugORXMRZB9kOXnNc=;
        b=CYngZOdTWXbJCHQ6Q/o+Bh4mPtUvrhcmEu0n91cVa8ZayA6/OI0a9LDIknKYq9vqu2
         phC4tcEcgcQkRx8FU90dLsVS8Nbfl2QORW3G70ItLMqd3c1TcOEeEtotUmK1BoUwdV56
         yiXB9QdWqb/MF/b+3J6nAnIk9NFoVkwrWc1oxNBVudCS/mokW01twPj6oRXhM+/BdIyL
         YeLqd/UAaJALw+XqsLV0nlVkWfO/6ouYJDj8fAbqK5SroNsSk/xPT1yTnotAPv7cvk/I
         03qXPKCoWvByA5CBYAyeOuungeFkmsSscs+mRkltlCRxzLWI5QuhbP5PfsdY6/eTaen1
         FRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tkfuH/NktMWynwk5bkgWg7t7rq3ugORXMRZB9kOXnNc=;
        b=WFmH0VchWNl64kwmOWsFOfli0oGqJHhvheG/O6jI0QhRZAvyt2I29AlZB5lOJPtakK
         n1Y1myVZM6hXSHxq4B9SBn6cMxQmGyhWMnie7xrVtpbDfetLcT4C+9rLVaXZYUCKzgJn
         HILYS3DptuCWoKSj1pJUQUtlPsL5WhPZ6xnoXHVGMNsI3Lf73tqLmiVXWUdb5D+E/eX4
         Whr2/ngXcarK3hyoPaW7JiaQ+kpKQ4ZS9uEkbmhp+x2KB3Cnc1QoWy4vlPZHrvDnZquV
         67kBrumi7S++YzWZP3UxozJTxnbDFDdUD4CmkMDOQIyAdFsCRKIXFG2xNEgmbAUlhXoS
         S2SQ==
X-Gm-Message-State: APjAAAUWMNIOOy8rgcwOgeM+dk7MwWbGTO23Rf2K4kfkANH4sNmtN0z2
        //0+VYOHomn4RDvWkOQ8NhvUMZdc
X-Google-Smtp-Source: APXvYqwtoI6Jh/QxpXi4crNAHrhiXWXbUlhONy9cp91ekPAHCBg9OAnZS45bek/qLP53trQOxHb1fw==
X-Received: by 2002:a05:620a:84a:: with SMTP id u10mr30102202qku.182.1577191078537;
        Tue, 24 Dec 2019 04:37:58 -0800 (PST)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id x11sm6787842qkf.50.2019.12.24.04.37.57
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 04:37:57 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH] format-patch: make format.outputDirectory relative to worktree
Date:   Tue, 24 Dec 2019 07:37:50 -0500
Message-Id: <9422e4225143b2b908bd1fed9a510b9333bf34a2.1577191015.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.810.g65a2f617f4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, when format-patch outputs patches to the path specified by
the `format.outputDirectory` configuration variable, it is relative to
the current working directory. However, it would make more sense for the
path to be relative to the worktree if it exists so that patches will be
placed in one location even if a user were to change directories.

Rewrite the output directory logic for format-patch so that it will be
relative to the worktree of the directory. An escape hatch is provided
for if the previous behaviour is desired by prepending "./" to the
variable.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/config/format.txt |  3 +++
 builtin/log.c                   | 20 ++++++++++++-----
 t/t4014-format-patch.sh         | 39 +++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/format.txt b/Documentation/config/format.txt
index 513fcd88d5..fc9d110d88 100644
--- a/Documentation/config/format.txt
+++ b/Documentation/config/format.txt
@@ -88,6 +88,9 @@ format.coverLetter::
 format.outputDirectory::
 	Set a custom directory to store the resulting files instead of the
 	current working directory. All directory components will be created.
+	The path specified will be relative to the worktree of the repository
+	unless the path begins with "./" or there is no worktree in which case
+	the path will be relative to current working directory.
 
 format.useAutoBase::
 	A boolean value which lets you enable the `--base=auto` option of
diff --git a/builtin/log.c b/builtin/log.c
index 8c664067ca..fe072c7309 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -885,7 +885,7 @@ static int git_format_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 	if (!strcmp(var, "format.outputdirectory"))
-		return git_config_string(&config_output_directory, var, value);
+		return git_config_pathname(&config_output_directory, var, value);
 	if (!strcmp(var, "format.useautobase")) {
 		base_auto = git_config_bool(var, value);
 		return 0;
@@ -1841,13 +1841,21 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (rev.show_notes)
 		init_display_notes(&rev.notes_opt);
 
-	if (!output_directory && !use_stdout)
-		output_directory = config_output_directory;
+	if (!use_stdout) {
+		const char *outdir_prefix = NULL;
+		const char *outdir = config_output_directory;
 
-	if (!use_stdout)
-		output_directory = set_outdir(prefix, output_directory);
-	else
+		if (output_directory)
+			outdir = output_directory;
+
+		if (output_directory ||
+		    (config_output_directory && starts_with(config_output_directory, "./")))
+			outdir_prefix = prefix;
+
+		output_directory = set_outdir(outdir_prefix, outdir);
+	} else {
 		setup_pager();
+	}
 
 	if (output_directory) {
 		int saved;
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index a5b6302a1c..cc13cc4699 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1813,6 +1813,45 @@ test_expect_success 'format-patch format.outputDirectory option' '
 	test_line_count = $count list
 '
 
+test_expect_success 'format-patch format.outputDirectory option relative to git dir' '
+	test_config format.outputDirectory patches &&
+	rm -fr patches &&
+	mkdir -p sub &&
+	(
+		cd sub &&
+		git format-patch master..side
+	) &&
+	count=$(git rev-list --count master..side) &&
+	ls patches >list &&
+	test_line_count = $count list
+'
+
+test_expect_success 'format-patch format.outputDirectory option with relative path' '
+	test_config format.outputDirectory ./patches &&
+	mkdir -p sub &&
+	(
+		cd sub &&
+		rm -fr patches &&
+		git format-patch master..side &&
+		count=$(git rev-list --count master..side) &&
+		ls patches >list &&
+		test_line_count = $count list
+	)
+'
+
+test_expect_success 'format-patch format.outputDirectory option absolute path' '
+	test_config format.outputDirectory "$PWD/patches" &&
+	rm -fr patches &&
+	mkdir -p sub &&
+	(
+		cd sub &&
+		git format-patch master..side
+	) &&
+	count=$(git rev-list --count master..side) &&
+	ls patches >list &&
+	test_line_count = $count list
+'
+
 test_expect_success 'format-patch -o overrides format.outputDirectory' '
 	test_config format.outputDirectory patches &&
 	rm -fr patches patchset &&
-- 
2.24.1.810.g65a2f617f4

