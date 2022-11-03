Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC6CC433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 17:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbiKCRHk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 13:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiKCRHM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 13:07:12 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324C51DF1E
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 10:06:27 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id d26so6979649eje.10
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 10:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dze9RkArWSeZHK025g/7+L4II7lxv+gd+rgr/XIQiss=;
        b=GohtKLdRqKsRAZFcjHmrtz+9Zs/bhIUKo70keVu/Pw/wkd2oPVG6lIHIMMpA3T54Qt
         +vgYkik1fSpq/LbFRMx/QguiSnf2WK0Te54cS6k5WRJTdsaCdNOyZGMNeM+2nE35SupK
         EC0UFRDsM6OdlP37Y9dXtj4H8tWxpeFQwt2FWep7hKJbHu4AIOjnM72/gjj/aVdpJPlG
         fOVbiDB5oDAFZPYKx7CHsiJAJaiLYiAcIM3Y0qdhRYyZaol/ci4QKI1pSW8QSKv6K1J7
         ZwRA4D+6pbdPjixEYt43OkEiflC8EhHVF2na9TyuUNnpGarN4QsbadgzIiNcmBeA35H4
         Mzeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dze9RkArWSeZHK025g/7+L4II7lxv+gd+rgr/XIQiss=;
        b=Ghg+I5drpzG4kYoJEgg8y2II5FLkPNCVcRBRXBJU0sJU475P8zmepuBHsB3FJFBsUy
         qILL72oucOlkoMsEFhx540XYqA1aJldc59X+cH5PRFh+9UtTQXDVkOj/aychVGAUJxvJ
         5oQq8Ajm9m+XpcKYt8vNQDAaafGc/0SVIxDpm8PzR9OZcyvsM7MF+OsScB18J7oLtooI
         /oUO6PcAjIRBxaim/Pbg3e07gyAsLkdRW+bdua9z0HL7mPnQ543vipTzEfMtxcmz9YQ5
         9zgbZPTj/RnlISDpo13o1EMmRONG0HJdhqe7O6lBZSWzzvPUocKZNO7pngBbpy91Miim
         pvdA==
X-Gm-Message-State: ACrzQf1/RY/MKaZ69A+4DsvH8Qks6YqFWHqos3/PBuGCdCw8LwPxZew4
        jbls7yoXxFGmg5CYm4nyMPoR6KUcmIgLKQ==
X-Google-Smtp-Source: AMsMyM6BZmp5pI3V27JAeiRU9HMzsB0MrDKhS/SH4FvFnPnzIv3D6tmOb/+xLVbIwSwBGBGIBkSuWA==
X-Received: by 2002:a17:906:7d8c:b0:7ae:159d:1146 with SMTP id v12-20020a1709067d8c00b007ae159d1146mr4853309ejo.528.1667495185116;
        Thu, 03 Nov 2022 10:06:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v4-20020aa7d644000000b0044e01e2533asm741882edr.43.2022.11.03.10.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:06:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/17] built-ins & libs & helpers: add/move destructors, fix leaks
Date:   Thu,  3 Nov 2022 18:06:05 +0100
Message-Id: <patch-06.17-009c41d2e91-20221103T164632Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1451.g86b35f4140a
In-Reply-To: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix various leaks in built-ins, libraries and a test helper here we
were missing a call to strbuf_release(), string_list_clear() etc, or
were calling them after a potential "return".

Comments on individual changes:

- builtin/checkout.c: Fix a memory leak that was introduced in [1]. A
  sibling leak introduced in [2] was recently fixed in [3]. As with [3]
  we should be using the wt_status_state_free_buffers() API introduced
  in [4].

- builtin/repack.c: Fix a leak that's been here since this use of
  "strbuf_release()" was added in a1bbc6c0176 (repack: rewrite the shell
  script in C, 2013-09-15). We don't use the variable for anything
  except this loop, so we can instead free it right afterwards.

- builtin/rev-parse: Fix a leak that's been here since this code was
  added in 21d47835386 (Add a parseopt mode to git-rev-parse to bring
  parse-options to shell scripts., 2007-11-04).

- builtin/stash.c: Fix a couple of leaks that have been here since
  this code was added in d4788af875c (stash: convert create to builtin,
  2019-02-25), we strbuf_release()'d only some of the "struct strbuf" we
  allocated earlier in the function, let's release all of them.

- ref-filter.c: Fix a leak in 482c1191869 (gpg-interface: improve
  interface for parsing tags, 2021-02-11), we don't use the "payload"
  variable that we ask parse_signature() to populate for us, so let's
  free it.

- t/helper/test-fake-ssh.c: Fix a leak that's been here since this
  code was added in 3064d5a38c7 (mingw: fix t5601-clone.sh,
  2016-01-27). Let's free the "struct strbuf" as soon as we don't need
  it anymore.

1. c45f0f525de (switch: reject if some operation is in progress,
   2019-03-29)
2. 2708ce62d21 (branch: sort detached HEAD based on a flag,
   2021-01-07)
3. abcac2e19fa (ref-filter.c: fix a leak in get_head_description,
   2022-09-25)
4. 962dd7ebc3e (wt-status: introduce wt_status_state_free_buffers(),
   2020-09-27).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/checkout.c        | 2 ++
 builtin/rebase.c          | 3 +++
 builtin/repack.c          | 2 +-
 builtin/rev-parse.c       | 1 +
 builtin/stash.c           | 2 ++
 ref-filter.c              | 1 +
 t/helper/test-fake-ssh.c  | 1 +
 t/t3428-rebase-signoff.sh | 1 +
 8 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2a132392fbe..659dd5c4309 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1470,6 +1470,8 @@ static void die_if_some_operation_in_progress(void)
 		      "or \"git worktree add\"."));
 	if (state.bisect_in_progress)
 		warning(_("you are switching branch while bisecting"));
+
+	wt_status_state_free_buffers(&state);
 }
 
 static int checkout_branch(struct checkout_opts *opts,
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 5d855fd8f51..64aed11c85d 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1825,10 +1825,13 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	strbuf_release(&buf);
 	strbuf_release(&revisions);
 	free(options.head_name);
+	strvec_clear(&options.git_am_opts);
 	free(options.gpg_sign_opt);
 	free(options.cmd);
 	free(options.strategy);
 	strbuf_release(&options.git_format_patch_opt);
 	free(squash_onto_name);
+	string_list_clear(&exec, 0);
+	string_list_clear(&strategy_options, 0);
 	return !!ret;
 }
diff --git a/builtin/repack.c b/builtin/repack.c
index 10e23f9ee1f..fb3ac197426 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -956,6 +956,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		item = string_list_append(&names, line.buf);
 		item->util = populate_pack_exts(item->string);
 	}
+	strbuf_release(&line);
 	fclose(out);
 	ret = finish_command(&cmd);
 	if (ret)
@@ -1124,7 +1125,6 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	string_list_clear(&existing_nonkept_packs, 0);
 	string_list_clear(&existing_kept_packs, 0);
 	clear_pack_geometry(geometry);
-	strbuf_release(&line);
 
 	return 0;
 }
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 8f61050bde8..e0244d63de6 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -530,6 +530,7 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 	strbuf_addstr(&parsed, " --");
 	sq_quote_argv(&parsed, argv);
 	puts(parsed.buf);
+	strbuf_release(&parsed);
 	return 0;
 }
 
diff --git a/builtin/stash.c b/builtin/stash.c
index bb5485b4095..8a64d564a19 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1686,8 +1686,10 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 	}
 
 done:
+	strbuf_release(&patch);
 	free_stash_info(&info);
 	strbuf_release(&stash_msg_buf);
+	strbuf_release(&untracked_files);
 	return ret;
 }
 
diff --git a/ref-filter.c b/ref-filter.c
index 914908fac52..b40b76c3806 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1358,6 +1358,7 @@ static void find_subpos(const char *buf,
 
 	/* parse signature first; we might not even have a subject line */
 	parse_signature(buf, end - buf, &payload, &signature);
+	strbuf_release(&payload);
 
 	/* skip past header until we hit empty line */
 	while (*buf && *buf != '\n') {
diff --git a/t/helper/test-fake-ssh.c b/t/helper/test-fake-ssh.c
index 12beee99ad2..d5e511633ab 100644
--- a/t/helper/test-fake-ssh.c
+++ b/t/helper/test-fake-ssh.c
@@ -17,6 +17,7 @@ int cmd_main(int argc, const char **argv)
 	f = fopen(buf.buf, "w");
 	if (!f)
 		die("Could not write to %s", buf.buf);
+	strbuf_release(&buf);
 	for (i = 0; i < argc; i++)
 		fprintf(f, "%s%s", i > 0 ? " " : "", i > 0 ? argv[i] : "ssh:");
 	fprintf(f, "\n");
diff --git a/t/t3428-rebase-signoff.sh b/t/t3428-rebase-signoff.sh
index f6993b7e14d..e1b1e947647 100755
--- a/t/t3428-rebase-signoff.sh
+++ b/t/t3428-rebase-signoff.sh
@@ -5,6 +5,7 @@ test_description='git rebase --signoff
 This test runs git rebase --signoff and make sure that it works.
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # A simple file to commit
-- 
2.38.0.1451.g86b35f4140a

