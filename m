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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29BCC3F2D1
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 02:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D8620842
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 02:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tCavJpnf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387510AbgCDCbm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 21:31:42 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:33607 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387432AbgCDCbl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 21:31:41 -0500
Received: by mail-io1-f67.google.com with SMTP id r15so721017iog.0
        for <git@vger.kernel.org>; Tue, 03 Mar 2020 18:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bk35kswXL0S0kqyUnu2oS3HrfL+suIiOItzQP6rDuIk=;
        b=tCavJpnfFn5dGv+rfczQmX4CISQWM6CpIVhfaCPJ4ld/rj4K5JKDQxiBkSaC+V/Uvy
         6btHLHiprgWY4G7mNt3wykxcQu+kpeqfGHtP0EdebZIo+81bZxl6mBDtBLn+2vKM4Hto
         L0vZ/k+cjkqStFASshYhNr0YB/9aLVoO8lv3YRPeHN9IfR/UESe9P+Vv+GoBmqe/SB1v
         bmgKmWejjR8SWyxtgBxU3pLIuhpSkq2OnGm6L3Rn3GCxGr659a3kyVCkn92HPtFUpu1P
         7HC1Xm/TOsOSq5fWOin5laFbqrVv64FeSHgw9C235tByCbyfLK31q5RpkO6SQLVY08Yw
         46HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bk35kswXL0S0kqyUnu2oS3HrfL+suIiOItzQP6rDuIk=;
        b=aavBcWzC/Xh6+MkiewTmcxByhOsyFmcav2YPSiP5CSAGc0Dkc+n2rDgaS4oWJmioOD
         M1YRegtjTf1sVFlbd/EZyxQ4PkCDdWmZcM5gtrqsHUL1a11djD3ro/PL8VJV63eGcAHt
         twmS9iAbErXvCr/eBraLtFFaZTVZGRXCodesqzlLOIplqdE4C0ymTkJT+PgVhoJHLuv/
         ZTxNxfkftLpFnMGDwCoAAgqMKEA2hItM0AarYKIFWj/jCLSz07PzFFcAPVVb8TnTutAa
         vdpYo8Oh6iSYkQfb4b0TE5p+W4ebqCL0aHJNXTMoCz/DOKE44QyY5nxjQyWdq5fgb2DG
         Wz8w==
X-Gm-Message-State: ANhLgQ2E9TNxiv+/ZR/QYXzr5V1ALdOZeOV5DWikmBq0aMinjle1nWVP
        hYqkw1b58V5u9xHGbzIfcKTqBm5Z
X-Google-Smtp-Source: ADFU+vu5IPhqcYCftoR7rOMoMVNhFdNo7vW2yTn/gV7N4MCnX+ADjUG+teQgSjcDTOJwfBOONx3jfw==
X-Received: by 2002:a6b:6d13:: with SMTP id a19mr425239iod.117.1583289100718;
        Tue, 03 Mar 2020 18:31:40 -0800 (PST)
Received: from viper.801labs.org ([63.228.208.98])
        by smtp.gmail.com with ESMTPSA id p18sm976812ilp.27.2020.03.03.18.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 18:31:39 -0800 (PST)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, rcdailey.lists@gmail.com, newren@gmail.com,
        rsbecker@nexbridge.com, gitster@pobox.com, annulen@yandex.ru,
        tytso@mit.edu
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v4] pull: warn if the user didn't say whether to rebase or to merge
Date:   Tue,  3 Mar 2020 19:29:31 -0700
Message-Id: <20200304022931.2469455-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Often novice Git users forget to say "pull --rebase" and end up with an
unnecessary merge from upstream. What they usually want is either "pull
--rebase" in the simpler cases, or "pull --ff-only" to update the copy
of main integration branches, and rebase their work separately. The
pull.rebase configuration variable exists to help them in the simpler
cases, but there is no mechanism to make these users aware of it.

Issue a warning message when no --[no-]rebase option from the command
line and no pull.rebase configuration variable is given. This will
inconvenience those who never want to "pull --rebase", who haven't had
to do anything special, but the cost of the inconvenience is paid only
once per user, which should be a reasonable cost to help a number of new
users.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
v4:
- Revise warning message based on Junio's feedback
- Consistently wrap warning lines to 75 characters for easy viewing in
PO files
- Fix test failures
---
 builtin/pull.c          | 15 +++++++++++++++
 t/t5521-pull-options.sh |  3 ++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 3e624d1e00..351b933c4d 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -327,6 +327,21 @@ static enum rebase_type config_get_rebase(void)
 	if (!git_config_get_value("pull.rebase", &value))
 		return parse_config_rebase("pull.rebase", value, 1);
 
+	if (!opt_ff || strcmp(opt_ff, "--ff-only")) {
+		warning(_("Pulling without specifying how to reconcile divergent branches is\n"
+			"discouraged. You can squelch this message by running one of the following\n"
+			"commands sometime before your next pull:\n"
+			"\n"
+			"  git config pull.rebase false  # merge (the default strategy)\n"
+			"  git config pull.rebase true   # rebase\n"
+			"  git config pull.ff only       # fast-forward only\n"
+			"\n"
+			"You can replace \"git config\" with \"git config --global\" to set a default\n"
+			"preference for all repositories. You can also pass --rebase, --no-rebase,\n"
+			"or --ff-only on the command line to override the configured default per\n"
+			"invocation.\n"));
+	}
+
 	return REBASE_FALSE;
 }
 
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index ccde8ba491..6e890ec936 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -8,7 +8,8 @@ test_expect_success 'setup' '
 	mkdir parent &&
 	(cd parent && git init &&
 	 echo one >file && git add file &&
-	 git commit -m one)
+	 git commit -m one) &&
+	git config pull.rebase false
 '
 
 test_expect_success 'git pull -q' '
-- 
2.25.1

