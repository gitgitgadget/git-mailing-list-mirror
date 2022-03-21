Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4594C433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 23:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbiCUXH2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbiCUXHS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 19:07:18 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010F02980F
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:41 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id o7-20020a05600c4fc700b0038c87edc21eso687221wmq.0
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=syJWHGONhgbM/mz6hF20nLA370dSxhysyv3V9DRQUVQ=;
        b=mj+muPUtmz40g1CCdng5g29P0gaJmRo0we2dlHgGUsNHnBurGPoTl6qyX+zRqrUIaK
         MdvFKChLWmQhxoCb558aa75ar0xPk+5yehJPXdmWMG9XMYkq4wRMwxs630HYDZqbc2+d
         1JaJDGw5eNbCdCB7XgoNFVdHkbIIuZjGXfmr8yQvGhmd6qd9bhGWQrzOlMJWp6p0FaGM
         YUwDyzoloTFIR7sZPKQG5s1HbnLC6o8sYmElcb9KmoyGVRuSjMI/dC5JbGRDXkKcaTFT
         LI9ugjnYa0nw6u0yG64wo3bY/84/QpM2A5ENCHvECOsrtoHlOZiN8TGwVnidspTWHLEb
         6LIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=syJWHGONhgbM/mz6hF20nLA370dSxhysyv3V9DRQUVQ=;
        b=u3kp7iWKmro3mQSjF44alPKlAeBe96gJNMg8Y7UEUdhH06FIo2htcwUcSnIOu5J8at
         3n49tlTvLZBHS6lCoIKev+hCvGvjSYes34o5FqXHx/AEuXlWwrLqHSTTuoDpOpJLrWb+
         ANl5CBz+FVj01RGYcgZgtqq+smkMEqwvZfjwjQU6W/hF4XdMceDWIgEi9pD1QDXHwfFj
         MxWbYT9bQMEDMZiYrznx1Yv3yGc5HZHrCTYzqxD1bNPwFm1OCjYBGcQ738QFdaKbATqj
         zxtlg9CcR6lmUFNrXV6r/dp1zgNixGkjPACvA2xrN+qlFcanyz+9nUdK6P6DuuqC3MXw
         t4Zw==
X-Gm-Message-State: AOAM531kwRc4gEFzSzd+JSHpnbSCDCQvbikAw5gXQgJ/8qKhDzPFl8cS
        QvXBxcLQL1/LpBSecq3YXhxuyg4M/6c=
X-Google-Smtp-Source: ABdhPJxAyaYj1HpSWaTte7pWV/aCFFT1LTtKeddQC8Fd1dlhWGpeKF9kgRPR82R83jXmYEfH+BlI8Q==
X-Received: by 2002:a7b:ce83:0:b0:37b:f1f1:3a0c with SMTP id q3-20020a7bce83000000b0037bf1f13a0cmr1132132wmj.10.1647903352660;
        Mon, 21 Mar 2022 15:55:52 -0700 (PDT)
Received: from fedora35.example.com ([151.24.239.1])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d440d000000b00203f2b010b1sm10022910wrq.44.2022.03.21.15.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:55:52 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 13/41] rebase.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
Date:   Mon, 21 Mar 2022 22:54:55 +0000
Message-Id: <20220321225523.724509-14-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220321225523.724509-1-gitter.spiros@gmail.com>
References: <20220321225523.724509-1-gitter.spiros@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The C standard specifies two constants, EXIT_SUCCESS and  EXIT_FAILURE, that may
be  passed  to exit() to indicate successful or unsuccessful termination,
respectively. The value of status in exit(status) may be EXIT_SUCCESS,
EXIT_FAILURE, or any other value, though only the least significant 8 bits (that
is, status & 0377) shall be available to a waiting parent proces. So exit(-1)
return 255.

Use the C standard EXIT_SUCCESS and EXIT_FAILURE to indicate the program exit
status instead of "0" or "1", respectively. In <stdlib.h> EXIT_FAILURE has the
value "1": use EXIT_FAILURE even if the program uses exit(-1), ie 255, for
consistency.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 builtin/rebase.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index b29ad2b65e..cafacc87f8 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -988,7 +988,7 @@ static void NORETURN error_on_missing_default_upstream(void)
 			 "\n"),
 		       remote, current_branch->name);
 	}
-	exit(1);
+	exit(EXIT_FAILURE);
 }
 
 static void set_reflog_action(struct rebase_options *options)
@@ -1266,10 +1266,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		if (has_unstaged_changes(the_repository, 1)) {
 			puts(_("You must edit all merge conflicts and then\n"
 			       "mark them as resolved using git add"));
-			exit(1);
+			exit(EXIT_FAILURE);
 		}
 		if (read_basic_state(&options))
-			exit(1);
+			exit(EXIT_FAILURE);
 		goto run_rebase;
 	}
 	case ACTION_SKIP: {
@@ -1285,7 +1285,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			die(_("could not discard worktree changes"));
 		remove_branch_state(the_repository, 0);
 		if (read_basic_state(&options))
-			exit(1);
+			exit(EXIT_FAILURE);
 		goto run_rebase;
 	}
 	case ACTION_ABORT: {
@@ -1297,7 +1297,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		string_list_clear(&merge_rr, 1);
 
 		if (read_basic_state(&options))
-			exit(1);
+			exit(EXIT_FAILURE);
 		ropts.oid = &options.orig_head;
 		ropts.branch = options.head_name;
 		ropts.flags = RESET_HEAD_HARD;
@@ -1388,7 +1388,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	for (i = 0; i < exec.nr; i++)
 		if (check_exec_cmd(exec.items[i].string))
-			exit(1);
+			exit(EXIT_FAILURE);
 
 	if (!(options.flags & REBASE_NO_QUIET))
 		strvec_push(&options.git_am_opts, "-q");
-- 
2.35.1

