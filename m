Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98495C4743D
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 10:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E4A661246
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 10:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbhFHKvE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 06:51:04 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:37608 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbhFHKvA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 06:51:00 -0400
Received: by mail-wm1-f51.google.com with SMTP id f16-20020a05600c1550b02901b00c1be4abso1614918wmg.2
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 03:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2dNB4wLiPRKZFSb0fxX6LFLJBXB30M9kq8hIjDtiGjs=;
        b=ey4HiDvYXTJVPnwZpjvMyh4zB+T7nqu0H2tzW7OlVtOXklxKxqnOVgfbX6etMp4j+8
         Kp2OGTbeLW3V5QWEuJ0cV6N+offiK4eVxp8ERx8YwY+t4xkhBwudlqPzVl8Dvh8J/+zo
         NWwL6K2GT0X34W5LUBRiUXLwmvc6f/SYCt1UC03VKqe7LYdRyIlcg43uPHsaDXgxaWj9
         wiRRFy9H8JzELX+zQL8gSf5Wb3XYncy3Fu01Pv7cG6972ueb3k+hyr0UxZOb386LcSS5
         BgqqWaAc4CLSp4snqAwJ7+DIF+Vyeynx/t64DlJcSPQJudnLuNCfXD6PVhW28pnk3aFY
         0vQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2dNB4wLiPRKZFSb0fxX6LFLJBXB30M9kq8hIjDtiGjs=;
        b=kZY16FZhoRvV5dPUDdCczxFjLyzvqdv8EEbGQy7y4CY8NeIgZuKV00N3ahR7Pyjs53
         YdPV55bgzShygomYUoRiLHROm2cmKb/7hC4i6wMP0kjIqG9LY3dNAzLpACitcQH4z4fG
         wzImyf4vOWCD2JVqjdfl3qjgew/5lNH/3hl1ueHKSOKBqItNXpGfBsduqmRhTrJyHRt8
         KGNZastR0/Iod4jSYCSVJnO8CbHGkpBxWxlRWshwCTRpsEIc3YJwoKqlFIyIrsD4FveN
         X9dCpe2JCzraTYxUtevYnuECdhrd9IguVMUd06cS6mcQel6oDzBjPQlGOovPyacjfYsu
         3rNA==
X-Gm-Message-State: AOAM532dEv4CLoGlfjlHwEhg7oeo5htPsFEQL6+crwrlBxzQgQrKTefn
        Ueg98hYTvHuN/Ljt8cBkm3g9P1jcyY9ixw==
X-Google-Smtp-Source: ABdhPJxFRnxGfbLW88DYpyKlJXST+1ZOWmZGL2Aty8ghh2/h8956G0ipN3jyKO/0ULuVguhrG4kzoQ==
X-Received: by 2002:a05:600c:4e8e:: with SMTP id f14mr3466825wmq.172.1623149286787;
        Tue, 08 Jun 2021 03:48:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t4sm19765449wru.53.2021.06.08.03.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 03:48:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] builtins + test helpers: use return instead of exit() in cmd_*
Date:   Tue,  8 Jun 2021 12:48:03 +0200
Message-Id: <patch-1.1-f225b78e01-20210608T104454Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
In-Reply-To: <patch-1.1-61d7e6e079-20210607T111008Z-avarab@gmail.com>
References: <patch-1.1-61d7e6e079-20210607T111008Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change various cmd_* functions that claim no return an "int" to use
"return" instead of exit() to indicate an exit code. These were not
marked with NORETURN, and by directly exit()-ing we'll skip the
cleanup git.c would otherwise do (e.g. closing fd's, erroring if we
can't). See run_builtin() in git.c.

In the case of shell.c and sh-i18n--envsubst.c this was the result of
an incomplete migration to using a cmd_main() in 3f2e2297b9 (add an
extra level of indirection to main(), 2016-07-01).

This was spotted by SunCC 12.5 on Solaris 10 (gcc210 on the gccfarm).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

Clarified the commit message, and made the same s/exit/return/g change
in shell.c and sh-i18n--envsubst.c. I also missed an "exit(2)" in a
brach in builtin/merge-ours.c.

Range-diff against v1:
1:  61d7e6e079 ! 1:  f225b78e01 builtins + test helpers: use return instead of exit() in cmd_*
    @@ Metadata
      ## Commit message ##
         builtins + test helpers: use return instead of exit() in cmd_*
     
    -    Change various cmd_* functions to use "return" instead of exit() to
    -    indicate an exit code. On Solaris with SunCC the compiler legitimately
    -    complains about these, since we'll e.g. skip the cleanup (e.g. closing
    -    fd's, erroring if we can't) in git.c's run_builtin() when we exit()
    -    directly like this.
    +    Change various cmd_* functions that claim no return an "int" to use
    +    "return" instead of exit() to indicate an exit code. These were not
    +    marked with NORETURN, and by directly exit()-ing we'll skip the
    +    cleanup git.c would otherwise do (e.g. closing fd's, erroring if we
    +    can't). See run_builtin() in git.c.
    +
    +    In the case of shell.c and sh-i18n--envsubst.c this was the result of
    +    an incomplete migration to using a cmd_main() in 3f2e2297b9 (add an
    +    extra level of indirection to main(), 2016-07-01).
    +
    +    This was spotted by SunCC 12.5 on Solaris 10 (gcc210 on the gccfarm).
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ builtin/difftool.c: static int run_file_diff(int prompt, const char *prefix,
     
      ## builtin/merge-ours.c ##
     @@ builtin/merge-ours.c: int cmd_merge_ours(int argc, const char **argv, const char *prefix)
    + 	if (read_cache() < 0)
      		die_errno("read_cache failed");
      	if (index_differs_from(the_repository, "HEAD", NULL, 0))
    - 		exit(2);
    +-		exit(2);
     -	exit(0);
    ++		return 2;
     +	return 0;
      }
     
    @@ builtin/mktree.c: int cmd_mktree(int ac, const char **av, const char *prefix)
     +	return 0;
      }
     
    + ## sh-i18n--envsubst.c ##
    +@@ sh-i18n--envsubst.c: cmd_main (int argc, const char *argv[])
    +   if (ferror (stderr) || fflush (stderr))
    +     {
    +       fclose (stderr);
    +-      exit (EXIT_FAILURE);
    ++      return (EXIT_FAILURE);
    +     }
    +   if (fclose (stderr) && errno != EBADF)
    +-    exit (EXIT_FAILURE);
    ++    return (EXIT_FAILURE);
    + 
    +-  exit (EXIT_SUCCESS);
    ++  return (EXIT_SUCCESS);
    + }
    + 
    + /* Parse the string and invoke the callback each time a $VARIABLE or
    +
    + ## shell.c ##
    +@@ shell.c: int cmd_main(int argc, const char **argv)
    + 		default:
    + 			continue;
    + 		}
    +-		exit(cmd->exec(cmd->name, arg));
    ++		return cmd->exec(cmd->name, arg);
    + 	}
    + 
    + 	cd_to_homedir();
    +
      ## t/helper/test-hash-speed.c ##
     @@ t/helper/test-hash-speed.c: int cmd__hash_speed(int ac, const char **av)
      		free(p);

 builtin/difftool.c          | 5 ++---
 builtin/merge-ours.c        | 4 ++--
 builtin/mktree.c            | 2 +-
 sh-i18n--envsubst.c         | 6 +++---
 shell.c                     | 2 +-
 t/helper/test-hash-speed.c  | 2 +-
 t/helper/test-hash.c        | 2 +-
 t/helper/test-match-trees.c | 2 +-
 t/helper/test-reach.c       | 2 +-
 9 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index 89334b77fb..6a9242a803 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -675,7 +675,7 @@ static int run_file_diff(int prompt, const char *prefix,
 		"GIT_PAGER=", "GIT_EXTERNAL_DIFF=git-difftool--helper", NULL,
 		NULL
 	};
-	int ret = 0, i;
+	int i;
 
 	if (prompt > 0)
 		env[2] = "GIT_DIFFTOOL_PROMPT=true";
@@ -686,8 +686,7 @@ static int run_file_diff(int prompt, const char *prefix,
 	strvec_push(&args, "diff");
 	for (i = 0; i < argc; i++)
 		strvec_push(&args, argv[i]);
-	ret = run_command_v_opt_cd_env(args.v, RUN_GIT_CMD, prefix, env);
-	exit(ret);
+	return run_command_v_opt_cd_env(args.v, RUN_GIT_CMD, prefix, env);
 }
 
 int cmd_difftool(int argc, const char **argv, const char *prefix)
diff --git a/builtin/merge-ours.c b/builtin/merge-ours.c
index 4594507420..3583cff71c 100644
--- a/builtin/merge-ours.c
+++ b/builtin/merge-ours.c
@@ -28,6 +28,6 @@ int cmd_merge_ours(int argc, const char **argv, const char *prefix)
 	if (read_cache() < 0)
 		die_errno("read_cache failed");
 	if (index_differs_from(the_repository, "HEAD", NULL, 0))
-		exit(2);
-	exit(0);
+		return 2;
+	return 0;
 }
diff --git a/builtin/mktree.c b/builtin/mktree.c
index 891991b00d..ae78ca1c02 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -189,5 +189,5 @@ int cmd_mktree(int ac, const char **av, const char *prefix)
 		used=0; /* reset tree entry buffer for re-use in batch mode */
 	}
 	strbuf_release(&sb);
-	exit(0);
+	return 0;
 }
diff --git a/sh-i18n--envsubst.c b/sh-i18n--envsubst.c
index e7430b9aa8..6cd307ac2c 100644
--- a/sh-i18n--envsubst.c
+++ b/sh-i18n--envsubst.c
@@ -104,12 +104,12 @@ cmd_main (int argc, const char *argv[])
   if (ferror (stderr) || fflush (stderr))
     {
       fclose (stderr);
-      exit (EXIT_FAILURE);
+      return (EXIT_FAILURE);
     }
   if (fclose (stderr) && errno != EBADF)
-    exit (EXIT_FAILURE);
+    return (EXIT_FAILURE);
 
-  exit (EXIT_SUCCESS);
+  return (EXIT_SUCCESS);
 }
 
 /* Parse the string and invoke the callback each time a $VARIABLE or
diff --git a/shell.c b/shell.c
index cef7ffdc9e..811e13b9c9 100644
--- a/shell.c
+++ b/shell.c
@@ -177,7 +177,7 @@ int cmd_main(int argc, const char **argv)
 		default:
 			continue;
 		}
-		exit(cmd->exec(cmd->name, arg));
+		return cmd->exec(cmd->name, arg);
 	}
 
 	cd_to_homedir();
diff --git a/t/helper/test-hash-speed.c b/t/helper/test-hash-speed.c
index 432233c7f0..f40d9ad0c2 100644
--- a/t/helper/test-hash-speed.c
+++ b/t/helper/test-hash-speed.c
@@ -57,5 +57,5 @@ int cmd__hash_speed(int ac, const char **av)
 		free(p);
 	}
 
-	exit(0);
+	return 0;
 }
diff --git a/t/helper/test-hash.c b/t/helper/test-hash.c
index 0a31de66f3..261c545b9d 100644
--- a/t/helper/test-hash.c
+++ b/t/helper/test-hash.c
@@ -54,5 +54,5 @@ int cmd_hash_impl(int ac, const char **av, int algo)
 		fwrite(hash, 1, algop->rawsz, stdout);
 	else
 		puts(hash_to_hex_algop(hash, algop));
-	exit(0);
+	return 0;
 }
diff --git a/t/helper/test-match-trees.c b/t/helper/test-match-trees.c
index b9fd427571..4079fdee06 100644
--- a/t/helper/test-match-trees.c
+++ b/t/helper/test-match-trees.c
@@ -23,5 +23,5 @@ int cmd__match_trees(int ac, const char **av)
 	shift_tree(the_repository, &one->object.oid, &two->object.oid, &shifted, -1);
 	printf("shifted: %s\n", oid_to_hex(&shifted));
 
-	exit(0);
+	return 0;
 }
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index cda804ed79..2f65c7f6a5 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -166,5 +166,5 @@ int cmd__reach(int ac, const char **av)
 		print_sorted_commit_ids(list);
 	}
 
-	exit(0);
+	return 0;
 }
-- 
2.32.0.rc3.434.gd8aed1f08a7

