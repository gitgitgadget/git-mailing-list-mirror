Return-Path: <SRS0=kUNO=A7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F6FC433E6
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 06:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0E3921775
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 06:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cda6KsKf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgGTGR4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jul 2020 02:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgGTGR4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jul 2020 02:17:56 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA70CC0619D2
        for <git@vger.kernel.org>; Sun, 19 Jul 2020 23:17:55 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id e22so11917648edq.8
        for <git@vger.kernel.org>; Sun, 19 Jul 2020 23:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nsMzNsehl+ZErKAdyNyn9ji0pjPMQiJUOUYvVR1YBAY=;
        b=cda6KsKftAm0uNwORAXvvuUOlwuwow7PMZl9sy8a0UgnUwasT4eFB7/EgEKucc7tmj
         6PqNXvH1ow/bD63vOwRMvwZS5ikW9CrjNywvMZgWTkSiPcT7m/FL73HPSGOeO7KQpndi
         cL+p1OB85CC6ewPAfDF7jjjuOHjuuRQBfFbehuK4hDieVgz5l42nSgODH4pX+BP6dL6I
         1YSi8e4b2hwsrOQkrt0gOyp+Y8tjvVVDcrCMB6MR4Cmpm3nI+3ZLT3/ovhJzjlRDNZ3c
         wM0G7yaSfxTwb58H000n6rD9YbxGtWLWgvRtTq2G1xdmryUngOTZEsgcpZ/sR8yVT04d
         /RAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nsMzNsehl+ZErKAdyNyn9ji0pjPMQiJUOUYvVR1YBAY=;
        b=PAqv7Bk5yRH5WgR5G64l7GrX6ehpUJTxxyOlvZCEmDYve23O9AIE/8T7nt5I2NzUdD
         OX08fYZjottxNtI7HQF6I2n7577jbCyB/k+m09o15INHntaMn1gyeYqBimNxvEo4Lgys
         5BFQ3QG06/ti24TjQqr6FXUTP2sj1p4NK/7v32EP+LvII6R57cWXpEwHCTCPB6U8FqRw
         T3rJF4T0rzTNxu2v0QgYTDVwJCyNzifxiOgsroLf1uQEa+fk6hE/Ds7rmHW/70DwnTsl
         F0toGqWGM9xFOBhFjfNQXInDhglabmImMRdlDXgz5MGqY+rTELaCp2Mv+ODl6MCJxLhc
         dBaw==
X-Gm-Message-State: AOAM531BMsVaU1DWr1k+ok+L63NbNO+pHctvPn6Wzxre/mn8yL+4pGnD
        CIyYjIiZINcgGlq/V5BG7E5Scw8y
X-Google-Smtp-Source: ABdhPJxSOMsmN49Ojx/sa4WlYuPf90v2D+mDTfQwqXYm2NYoTv6HYubTRmfsCMNv1PX0wFSo83EqZQ==
X-Received: by 2002:aa7:ccd5:: with SMTP id y21mr19549612edt.91.1595225874260;
        Sun, 19 Jul 2020 23:17:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x64sm15121011edc.95.2020.07.19.23.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 23:17:53 -0700 (PDT)
Message-Id: <pull.678.v2.git.1595225873014.gitgitgadget@gmail.com>
In-Reply-To: <pull.678.git.1595028293855.gitgitgadget@gmail.com>
References: <pull.678.git.1595028293855.gitgitgadget@gmail.com>
From:   "Chris Torek via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Jul 2020 06:17:52 +0000
Subject: [PATCH v2] git-mv: improve error message for conflicted file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Chris Torek <chris.torek@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Chris Torek <chris.torek@gmail.com>

'git mv' has always complained about renaming a conflicted
file, as it cannot handle multiple index entries for one file.
However, the error message it uses has been the same as the
one for an untracked file:

    fatal: not under version control, src=...

which is patently wrong.  Distinguish the two cases and
add a test to make sure we produce the correct message.

Signed-off-by: Chris Torek <chris.torek@gmail.com>
---
    git-mv: improve error message for conflicted file
    
    'git mv' has always complained about renaming a conflicted file, as it
    cannot handle multiple index entries for one file. However, the error
    message it uses has been the same as the one for an untracked file:
    
    fatal: not under version control, src=...
    
    which is patently wrong. Distinguish the two cases and add a test to
    make sure we produce the correct message.
    
    Signed-off-by: Chris Torek chris.torek@gmail.com [chris.torek@gmail.com]
    
    
    ------------------------------------------------------------------------
    
    Tests updated, and took Junio's suggestion to reduce the cache lookup to
    one call.
    
    I put in the shortened "conflicted" here but did not shorten the
    existing "not under version control" message (to minimize the visible
    and translations-required changes).
    
    I like the idea of renaming all stages and keeping them at their current
    stages, but that's too much for this patch.
    
    I'll be traveling next week and not sure if I will get to any followups
    for a while.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-678%2Fchris3torek%2Fgit-mv-message-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-678/chris3torek/git-mv-message-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/678

Range-diff vs v1:

 1:  0b617e74f7 ! 1:  f2e251a7ea git-mv: improve error message for conflicted file
     @@ Commit message
          Signed-off-by: Chris Torek <chris.torek@gmail.com>
      
       ## builtin/mv.c ##
     +@@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
     + 	struct stat st;
     + 	struct string_list src_for_dst = STRING_LIST_INIT_NODUP;
     + 	struct lock_file lock_file = LOCK_INIT;
     ++	struct cache_entry *ce;
     + 
     + 	git_config(git_default_config, NULL);
     + 
      @@ builtin/mv.c: int cmd_mv(int argc, const char **argv, const char *prefix)
       				}
       				argc += last - first;
       			}
      -		} else if (cache_name_pos(src, length) < 0)
     --			bad = _("not under version control");
     ++		} else if (!(ce = cache_file_exists(src, length, ignore_case))) {
     + 			bad = _("not under version control");
      -		else if (lstat(dst, &st) == 0 &&
     -+		} else if (cache_name_pos(src, length) < 0) {
     -+			/*
     -+			 * This occurs for both untracked files *and*
     -+			 * files that are in merge-conflict state, so
     -+			 * let's distinguish between those two.
     -+			 */
     -+			struct cache_entry *ce = cache_file_exists(src, length, ignore_case);
     -+			if (ce == NULL)
     -+				bad = _("not under version control");
     -+			else
     -+				bad = _("must resolve merge conflict first");
     ++		} else if (ce_stage(ce)) {
     ++			bad = _("conflicted");
      +		} else if (lstat(dst, &st) == 0 &&
       			 (!ignore_case || strcasecmp(src, dst))) {
       			bad = _("destination exists");
     @@ t/t7001-mv.sh: test_expect_success 'git mv should not change sha1 of moved cache
      +test_expect_success 'git mv error on conflicted file' '
      +	rm -fr .git &&
      +	git init &&
     -+	touch conflicted &&
     -+	cfhash=$(git hash-object -w conflicted) &&
     -+	git update-index --index-info <<-EOF &&
     -+	$(printf "0 $cfhash 0\tconflicted\n")
     -+	$(printf "100644 $cfhash 1\tconflicted\n")
     ++	>conflict &&
     ++	test_when_finished "rm -f conflict" &&
     ++	cfhash=$(git hash-object -w conflict) &&
     ++	q_to_tab <<-EOF | git update-index --index-info &&
     ++	0 $cfhash 0Qconflict
     ++	100644 $cfhash 1Qconflict
      +	EOF
      +
     -+	test_must_fail git mv conflicted newname 2>actual &&
     -+	test_i18ngrep "merge.conflict" actual
     ++	test_must_fail git mv conflict newname 2>actual &&
     ++	test_i18ngrep "conflicted" actual
      +'
     -+
     -+rm -f conflicted
      +
       test_expect_success 'git mv should overwrite symlink to a file' '
       


 builtin/mv.c  |  7 +++++--
 t/t7001-mv.sh | 17 +++++++++++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index be15ba7044..7dac714af9 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -132,6 +132,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	struct stat st;
 	struct string_list src_for_dst = STRING_LIST_INIT_NODUP;
 	struct lock_file lock_file = LOCK_INIT;
+	struct cache_entry *ce;
 
 	git_config(git_default_config, NULL);
 
@@ -220,9 +221,11 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				}
 				argc += last - first;
 			}
-		} else if (cache_name_pos(src, length) < 0)
+		} else if (!(ce = cache_file_exists(src, length, ignore_case))) {
 			bad = _("not under version control");
-		else if (lstat(dst, &st) == 0 &&
+		} else if (ce_stage(ce)) {
+			bad = _("conflicted");
+		} else if (lstat(dst, &st) == 0 &&
 			 (!ignore_case || strcasecmp(src, dst))) {
 			bad = _("destination exists");
 			if (force) {
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 36b50d0b4c..c978b6dee4 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -248,6 +248,23 @@ test_expect_success 'git mv should not change sha1 of moved cache entry' '
 
 rm -f dirty dirty2
 
+# NB: This test is about the error message
+# as well as the failure.
+test_expect_success 'git mv error on conflicted file' '
+	rm -fr .git &&
+	git init &&
+	>conflict &&
+	test_when_finished "rm -f conflict" &&
+	cfhash=$(git hash-object -w conflict) &&
+	q_to_tab <<-EOF | git update-index --index-info &&
+	0 $cfhash 0Qconflict
+	100644 $cfhash 1Qconflict
+	EOF
+
+	test_must_fail git mv conflict newname 2>actual &&
+	test_i18ngrep "conflicted" actual
+'
+
 test_expect_success 'git mv should overwrite symlink to a file' '
 
 	rm -fr .git &&

base-commit: ae46588be0cd730430dded4491246dfb4eac5557
-- 
gitgitgadget
