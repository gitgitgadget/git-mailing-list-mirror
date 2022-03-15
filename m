Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A754FC433F5
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 21:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351862AbiCOVK4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 17:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351860AbiCOVKy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 17:10:54 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8DF5676D
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 14:09:41 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id q9-20020a17090a7a8900b001bf0a7d9dfdso332351pjf.4
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 14:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=YB/jejylpLRrFQcFwlwyRYDOXZWMA4zVmB898bjUBdY=;
        b=J0aCjSOT3soEi+PuMrHYP8LsOnnOsFBNcFWlc6f2oM5Md7d6WymCpm5YgAaA90r5zn
         HJXVsva6qTNdUb/xdZd2fgoX2dUYlrJ70cB1MmREKL3x4mi32A0udcKEIDqC+ZnFeZN4
         Poml8VWbzO0UphYp6QndqDt4p4FldFJDQuTWD77nBjzEqr2xElsvswR9MoTiWX9elvwZ
         XE1HRwg3Z6/OBZfnPlB/c54xz0HVGx7N33m4ReXRdOLCOpLYKhp5gnlso4Bo23LDbYei
         4Ql6dWLu87cWTJDQUp6rmWOY9KBIwDNL3uHSm1ZLraZ0WeaHRgG2pYuHHNN4yJ0oGW53
         aTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=YB/jejylpLRrFQcFwlwyRYDOXZWMA4zVmB898bjUBdY=;
        b=Opibfmsiyrp+lp0a9I14sHr3WQh2UZ+dF5tgc58pd+NaKbTjH2ELij59oS3jYxC0J9
         7cCKRYWeXX3BFKqNqSYuG2k7yXeBE7S9qQzVKaXmKAmdXNq8HadeEkJha63ckeWh/ZAy
         rarkw1HBb8rL1mYfdETGLjIqHOY0gkDmqbZo20gpkEmbKQj0XuwI8vr52v5OE+HWosxP
         SKADspdp9SZ6drhZpZ4YLjA5Pbnabi+FlhyvI1JXGNjKjlHnetEVV6YdkxMK9qlXWoeA
         yUInguU8Pi7PwfkHPmqOIqINu0m22PEVgJccejjag3uwNIcVh7RbQE8s89+H5oX4l5un
         EQ0A==
X-Gm-Message-State: AOAM533gPSub574WL22/jlVmg41w+X2UuyAsGW5uDjWNj0VKSyNaxtOi
        v6x4Y7r3l4fpZJpdF04yF1dYa9srLkgmHaEj/wzBlda33itW2Z6opXxRoFrk/kG373vSMl86nlR
        EGZzdtWZtoJ95j1K7QpEdUcxP8yr/2oZJb769veJmcqlRp/8jvG4ih/epZ5Q6yZ0=
X-Google-Smtp-Source: ABdhPJxGnt9yzSB53q9wFxaDT0gzfJVV9cvcXTEbeElhcSXgNaH77/Y/NArQqxXDPA6NflgU6C72uI25nltUqg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:1943:b0:4cb:79c9:fa48 with SMTP
 id s3-20020a056a00194300b004cb79c9fa48mr30652372pfk.47.1647378580977; Tue, 15
 Mar 2022 14:09:40 -0700 (PDT)
Date:   Tue, 15 Mar 2022 14:09:20 -0700
In-Reply-To: <20220315210925.79289-1-chooglen@google.com>
Message-Id: <20220315210925.79289-3-chooglen@google.com>
Mime-Version: 1.0
References: <20220315210925.79289-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [PATCH 2/7] submodule update: use die_message()
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use die_message() to print the "fatal: " prefix instead of doing it in
git-submodule.sh and remove a now-unnecessary exit code from "git
submodule--helper run-update-procedure".

Also, since die_message() adds the newline for us, replace an invocation
of die_with_status() with printf + exit invocations that do not add a
newline, but are otherwise identical to die_with_status().

Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Glen Choo <chooglen@google.com>
---
This was spun out of
https://lore.kernel.org/git/patch-v5-9.9-e8e57606ee9-20220128T125206Z-avara=
b@gmail.com

 builtin/submodule--helper.c | 33 ++++++++++++++-------------------
 git-submodule.sh            |  9 +++++----
 2 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 95ef113d16..af1d90af7c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2366,40 +2366,35 @@ static int run_update_command(struct update_data *u=
d, int subforce)
 	if (run_command(&cp)) {
 		switch (ud->update_strategy.type) {
 		case SM_UPDATE_CHECKOUT:
-			printf(_("Unable to checkout '%s' in submodule path '%s'"),
-			       oid, ud->displaypath);
+			die_message(_("Unable to checkout '%s' in submodule path '%s'"),
+				    oid, ud->displaypath);
 			break;
 		case SM_UPDATE_REBASE:
-			printf(_("Unable to rebase '%s' in submodule path '%s'"),
-			       oid, ud->displaypath);
+			die_message(_("Unable to rebase '%s' in submodule path '%s'"),
+			    oid, ud->displaypath);
 			break;
 		case SM_UPDATE_MERGE:
-			printf(_("Unable to merge '%s' in submodule path '%s'"),
-			       oid, ud->displaypath);
+			die_message(_("Unable to merge '%s' in submodule path '%s'"),
+			    oid, ud->displaypath);
 			break;
 		case SM_UPDATE_COMMAND:
-			printf(_("Execution of '%s %s' failed in submodule path '%s'"),
-			       ud->update_strategy.command, oid, ud->displaypath);
+			die_message(_("Execution of '%s %s' failed in submodule path '%s'"),
+			    ud->update_strategy.command, oid, ud->displaypath);
 			break;
 		default:
 			BUG("unexpected update strategy type: %s",
 			    submodule_strategy_to_string(&ud->update_strategy));
 		}
-		/*
-		 * NEEDSWORK: We are currently printing to stdout with error
-		 * return so that the shell caller handles the error output
-		 * properly. Once we start handling the error messages within
-		 * C, we should use die() instead.
-		 */
 		if (must_die_on_failure)
-			return 2;
-		/*
-		 * This signifies to the caller in shell that the command
-		 * failed without dying
-		 */
+			exit(128);
+
+		/* the command failed, but update must continue */
 		return 1;
 	}
=20
+	if (ud->quiet)
+		return 0;
+
 	switch (ud->update_strategy.type) {
 	case SM_UPDATE_CHECKOUT:
 		printf(_("Submodule path '%s': checked out '%s'\n"),
diff --git a/git-submodule.sh b/git-submodule.sh
index aa8bdfca9d..a84143daab 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -404,7 +404,7 @@ cmd_update()
 		# exit codes for run-update-procedure:
 		# 0: update was successful, say command output
 		# 1: update procedure failed, but should not die
-		# 2 or 128: subcommand died during execution
+		# 128: subcommand died during execution
 		# 3: no update procedure was run
 		res=3D"$?"
 		case $res in
@@ -412,11 +412,12 @@ cmd_update()
 			say "$out"
 			;;
 		1)
-			err=3D"${err};fatal: $out"
+			err=3D"${err};$out"
 			continue
 			;;
-		2|128)
-			die_with_status $res "fatal: $out"
+		128)
+			printf >&2 "$out"
+			exit $res
 			;;
 		esac
=20
--=20
2.33.GIT

