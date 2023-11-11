Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A53714A98
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 13:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTLS5VbO"
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E983862
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 05:27:52 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32dff08bbdbso1900457f8f.2
        for <git@vger.kernel.org>; Sat, 11 Nov 2023 05:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699709270; x=1700314070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ussIO7SW2rXOEJj2vz0J8ZNu1DEOo77RvHIR09lkKM=;
        b=QTLS5VbOCDXNQBwEA97rJkQbtK6LONVPy+Kkd9JFL4jbxx/Pzam9uJaccY0EhvHOPM
         MwLIggN4KCwq1epiGKEmw7htnrxEIXHbzkT+Hn9Q3ogZzE3ErmZ30UBGsXGJL3mRry1G
         MfoBbJgojq/vokl838guZSZj5BqiMuP4BcgHiEjUJk7dy+oztIhEVO7SPJ4yXH2dC486
         SytgW+FQns3R7LO6jyNoBDJ+i2KFPXcxfTo5I56g+3N+DiGf7h3ArtTY08VLzjojalEW
         vImPoxeJbU0DLcCgzHQnMdS/dMeHz+Tj4ws0FfF+Y/o4JOqnD22V6WtiIWskVYDSvRiI
         TAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699709270; x=1700314070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ussIO7SW2rXOEJj2vz0J8ZNu1DEOo77RvHIR09lkKM=;
        b=oYfd7UAe2AmE7yHLJxqAlgUDjAPQYMEXNpqJghNPov6M5zOqMUAEvZvXPcUf7J18aR
         a2ULPOi23WHSdRJ5gylXjgSNXfhfxWU0l5n/nSZXM+JrEegSt8rgA3hXmRL24gqTVEi0
         sz8MyQU2sjr4rFsnNXeIvb4Ynr/q8yvAmuMH2PdzAmsrfVliwJVpGuJstmPAISNMblT7
         qQj/eovX+GthPpMPEocHWAtcipm6iiSL5JuVRoegcMCZrECo2u5jR/DM01RINWCWiJG1
         xH+rVzYyybRZzWf1Do+t22RMwKbmJrw9Faf0SsHRMQCXvNOXiTHRRzqZ8bSyTYI8LCGq
         af9A==
X-Gm-Message-State: AOJu0YzbFeu2l2rOivHKA+LXTG4aPB7YglOSWt7kiSrKd7Ljq1ZpIWRv
	3y+RYr81AilPw+AiN2VfhcQITdENEFrgbw==
X-Google-Smtp-Source: AGHT+IGaGNLeI7xxlcPyqQtmKxbl4BDqdVpZhYVmIoVsbClazTnLPAiuK4mJpYBEISSyC1R8RFPqyw==
X-Received: by 2002:a05:6000:18a2:b0:32f:86e7:9bf9 with SMTP id b2-20020a05600018a200b0032f86e79bf9mr1520295wri.5.1699709270466;
        Sat, 11 Nov 2023 05:27:50 -0800 (PST)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id h4-20020adff4c4000000b0031ad5fb5a0fsm1467102wrp.58.2023.11.11.05.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 05:27:50 -0800 (PST)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	newren@gmail.com,
	Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v4 1/4] rebase: fully ignore rebase.autoSquash without -i
Date: Sat, 11 Nov 2023 13:27:15 +0000
Message-ID: <20231111132720.78877-2-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.43.0-rc1
In-Reply-To: <20231111132720.78877-1-andy.koppe@gmail.com>
References: <20231105000808.10171-1-andy.koppe@gmail.com>
 <20231111132720.78877-1-andy.koppe@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Setting the rebase.autoSquash config variable to true implies a couple
of restrictions: it prevents preemptive fast-forwarding and it triggers
conflicts with amend backend options. However, it only actually results
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
2.43.0-rc1

