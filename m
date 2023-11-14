Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974B633077
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 21:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpYAKBq9"
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01664D2
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 13:44:29 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-32fdc5be26dso3779820f8f.2
        for <git@vger.kernel.org>; Tue, 14 Nov 2023 13:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699998267; x=1700603067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bi8B43KVOWSHH24dTUSErLWILUBZkOgPmGS+o/3WrBM=;
        b=hpYAKBq9OxGiHZUor+t0vbjrUgRDP4KicveeNDAMNaNhgqtxm+HqxTcws9sQTNsOOO
         ZDvGk7jxwyOdEzcZXhf7gB0cH/JDFyvvbow+HgbRz73CMqxOLPwHN8TIDfegHiQEuk50
         d2R9iVwQvAvLt5yBPSXPg7CWaud0Vew4xXxXakMCT/lnMudeR8HnXSLGBRfwRXwOWy5Q
         uIZdw3LFqXs8XWADUmjRDM9eCmb04be5CpOxqWAxbXCIXB/Ink73p/s05FZ9f2q4WycC
         f9u3K/MtCZMp3jnxoFgUctsUKHWqQLgUzsM8CE+IjsZ/h9yinTwkH+5rL1pwW7T8V9iE
         8soA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699998267; x=1700603067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bi8B43KVOWSHH24dTUSErLWILUBZkOgPmGS+o/3WrBM=;
        b=nYPA/LIfvLbOz7Bs/S72gmDeMbs/60uOpvsLxzd3W4qmF6A+7hA2D/xJ22kMsdUwLD
         sAAMvV465jtISloQiZd6grgdhy0cPMCJUc8dm+ZmC8dJv827q/UTGvobvJaWDdwSF9Cm
         Jy70DFdI2yYUuNp4g79JFnWkz8YuOH7yI/TcnITZ2qRvyYXdkfgTlvoquzw6JxhD72LR
         XQ0v1hbigiAVjvH5NxWzhV/fTLoDzdUGSBENSTMo5JwkXNI6eo9Dkn39tvupYbqaOJh1
         yNiia/2Q0Dg976lwLzkX8lrAxB6fTOxRi0fv650n88FUWc6foFuKpFWP0vq7wYq/+bUe
         IYhg==
X-Gm-Message-State: AOJu0Yx6ZH7u8BG+yvQ4KFy2vho2HKba3vD2tPRNlPvhGzOFfHZa0jaj
	rpK0Tuy86FqhwlfL6OxCS0C33sugsJNIuw==
X-Google-Smtp-Source: AGHT+IHAYiZ/9QYx2qEd7dJxJaml8/AZrjfmK6IWSGLrrXWZvVtuUPOfWbdSyXNKV3auTo+p+3g2EA==
X-Received: by 2002:adf:f58c:0:b0:329:6662:ac1d with SMTP id f12-20020adff58c000000b003296662ac1dmr8788450wro.24.1699998267066;
        Tue, 14 Nov 2023 13:44:27 -0800 (PST)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id u7-20020a05600c19c700b0040651505684sm12804379wmq.29.2023.11.14.13.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 13:44:26 -0800 (PST)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v5 1/3] rebase: fully ignore rebase.autoSquash without -i
Date: Tue, 14 Nov 2023 21:43:37 +0000
Message-ID: <20231114214339.10925-2-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.43.0-rc2
In-Reply-To: <20231114214339.10925-1-andy.koppe@gmail.com>
References: <20231111132720.78877-1-andy.koppe@gmail.com>
 <20231114214339.10925-1-andy.koppe@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Setting the rebase.autoSquash config variable to true implies a couple
of restrictions: it prevents preemptive fast-forwarding and it triggers
conflicts with apply backend options. However, it only actually results
in auto-squashing when combined with the --interactive (or -i) option,
due to code in run_specific_rebase() that disables auto-squashing unless
the REBASE_INTERACTIVE_EXPLICIT flag is set.

Doing autosquashing for rebase.autoSquash without --interactive would be
problematic in terms of backward compatibility, but conversely, there is
no need for the aforementioned restrictions without --interactive.

So drop the options.config_autosquash check from the conditions for
clearing allow_preemptive_ff, as the case where it is combined with
--interactive is already covered by the REBASE_INTERACTIVE_EXPLICIT
flag check above it.

Also drop the "apply options are incompatible with rebase.autoSquash"
error, because it is unreachable if it is restricted to --interactive,
as apply options already cause an error when used with --interactive.
Drop the tests for the error from t3422-rebase-incompatible-options.sh,
which has separate tests for the conflicts of --interactive with apply
options.

When neither --autosquash nor --no-autosquash are given, only set
options.autosquash to true if rebase.autosquash is combined with
--interactive.

Don't initialize options.config_autosquash to -1, as there is no need to
distinguish between rebase.autoSquash being unset or explicitly set to
false.

Finally, amend the rebase.autoSquash documentation to say it only
affects interactive mode.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 Documentation/config/rebase.txt        |  4 +++-
 builtin/rebase.c                       | 13 ++++++-------
 t/t3422-rebase-incompatible-options.sh | 12 ------------
 3 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/Documentation/config/rebase.txt b/Documentation/config/rebase.txt
index 9c248accec..d59576dbb2 100644
--- a/Documentation/config/rebase.txt
+++ b/Documentation/config/rebase.txt
@@ -9,7 +9,9 @@ rebase.stat::
 	rebase. False by default.
 
 rebase.autoSquash::
-	If set to true enable `--autosquash` option by default.
+	If set to true, enable the `--autosquash` option of
+	linkgit:git-rebase[1] by default for interactive mode.
+	This can be overridden with the `--no-autosquash` option.
 
 rebase.autoStash::
 	When set to true, automatically create a temporary stash entry
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 043c65dccd..a73de7892b 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -149,7 +149,6 @@ struct rebase_options {
 		.reapply_cherry_picks = -1,             \
 		.allow_empty_message = 1,               \
 		.autosquash = -1,                       \
-		.config_autosquash = -1,                \
 		.rebase_merges = -1,                    \
 		.config_rebase_merges = -1,             \
 		.update_refs = -1,                      \
@@ -1405,7 +1404,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if ((options.flags & REBASE_INTERACTIVE_EXPLICIT) ||
 	    (options.action != ACTION_NONE) ||
 	    (options.exec.nr > 0) ||
-	    (options.autosquash == -1 && options.config_autosquash == 1) ||
 	    options.autosquash == 1) {
 		allow_preemptive_ff = 0;
 	}
@@ -1508,8 +1506,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			if (is_merge(&options))
 				die(_("apply options and merge options "
 					  "cannot be used together"));
-			else if (options.autosquash == -1 && options.config_autosquash == 1)
-				die(_("apply options are incompatible with rebase.autoSquash.  Consider adding --no-autosquash"));
 			else if (options.rebase_merges == -1 && options.config_rebase_merges == 1)
 				die(_("apply options are incompatible with rebase.rebaseMerges.  Consider adding --no-rebase-merges"));
 			else if (options.update_refs == -1 && options.config_update_refs == 1)
@@ -1529,10 +1525,13 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	options.rebase_merges = (options.rebase_merges >= 0) ? options.rebase_merges :
 				((options.config_rebase_merges >= 0) ? options.config_rebase_merges : 0);
 
-	if (options.autosquash == 1)
+	if (options.autosquash == 1) {
 		imply_merge(&options, "--autosquash");
-	options.autosquash = (options.autosquash >= 0) ? options.autosquash :
-			     ((options.config_autosquash >= 0) ? options.config_autosquash : 0);
+	} else if (options.autosquash == -1) {
+		options.autosquash =
+			options.config_autosquash &&
+			(options.flags & REBASE_INTERACTIVE_EXPLICIT);
+	}
 
 	if (options.type == REBASE_UNSPECIFIED) {
 		if (!strcmp(options.default_backend, "merge"))
diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
index 2eba00bdf5..b40f26250b 100755
--- a/t/t3422-rebase-incompatible-options.sh
+++ b/t/t3422-rebase-incompatible-options.sh
@@ -100,12 +100,6 @@ test_rebase_am_only () {
 		test_must_fail git rebase $opt --root A
 	"
 
-	test_expect_success "$opt incompatible with rebase.autosquash" "
-		git checkout B^0 &&
-		test_must_fail git -c rebase.autosquash=true rebase $opt A 2>err &&
-		grep -e --no-autosquash err
-	"
-
 	test_expect_success "$opt incompatible with rebase.rebaseMerges" "
 		git checkout B^0 &&
 		test_must_fail git -c rebase.rebaseMerges=true rebase $opt A 2>err &&
@@ -118,12 +112,6 @@ test_rebase_am_only () {
 		grep -e --no-update-refs err
 	"
 
-	test_expect_success "$opt okay with overridden rebase.autosquash" "
-		test_when_finished \"git reset --hard B^0\" &&
-		git checkout B^0 &&
-		git -c rebase.autosquash=true rebase --no-autosquash $opt A
-	"
-
 	test_expect_success "$opt okay with overridden rebase.rebaseMerges" "
 		test_when_finished \"git reset --hard B^0\" &&
 		git checkout B^0 &&
-- 
2.43.0-rc2

