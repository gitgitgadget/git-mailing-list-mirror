Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87F54207BD
	for <e@80x24.org>; Thu, 27 Apr 2017 00:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033219AbdD0AIn (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 20:08:43 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35938 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033215AbdD0AIl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 20:08:41 -0400
Received: by mail-pf0-f196.google.com with SMTP id v14so3830665pfd.3
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 17:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=Ai1GZRK8FqHHHQ2lVf14yvDlJT626Y/34m5my2bKP3c=;
        b=Mgv3DKcNMn4XjzNZ645zMKTL+nCmtq5F1qxPhGGg6TtHc/zTz8mSLAhIsy/+QGBtOj
         LyvIyaidq6r79JW3J0isQFYhyP0wI0EAHiXlMtEaYxP3Wxu3loulc12kQdyKvgey2bdu
         1me+n1CG7/guVCF0FMwTDHtvIrBg7OaSe+AQ9cnFKHATUoHozsnWvcPT7Xzs4W/IdK2i
         hptytgNapiJCvwdw8/FN+UZ8JWTpFXQDbk9BsgUlc/bIQEgfP5QWcRmMIaEhlBNb2CtX
         ezRIZOin4PAubUe2nPnyPVtPpZtlywEYeluBYE0tEfMrB4jC4bnG7G5UdwY7IWChNtEC
         LREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=Ai1GZRK8FqHHHQ2lVf14yvDlJT626Y/34m5my2bKP3c=;
        b=GFLNawDTYFOGTKmgnw5wkav5u7mPK/aARjbmJWX4wR//G/+iOrYXEQMG/OxhTytYf7
         gsb/kyMMUGi6UBIQOg8hPBNA79cIfJmvrnUKxxPZzoOquO0nuQ7UP5QK28qGw4WiiBGS
         VISI61vUgai9l3onW7IFxSeSno28E3aT/en6NChEwNGXMZhlvdBCp/G/HHN5CR2iDLxT
         14mrIuDeJpPptwyi5r2CtKiW8vdh6rrWU30ISCBmTWA0wQngaYE9/fqSJp4NBDrpimeU
         eJLk1voxCoBlo7CkxxMtJSYOY2gMMOBQjJks00KwKmD+XBWA4COJ6CqqJUbruKzWIaL6
         cruQ==
X-Gm-Message-State: AN3rC/7+Keqza7OJv/aLnYg5/LQaSxVBlxrR/Nm4OJn8NzTyvY8ahOOA
        wxZer/8GndyB0ics7JQJCA==
X-Received: by 10.84.210.10 with SMTP id z10mr3218086plh.173.1493251720496;
        Wed, 26 Apr 2017 17:08:40 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d550:ca2:cfe6:6d97])
        by smtp.gmail.com with ESMTPSA id r1sm702949pfg.12.2017.04.26.17.08.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 26 Apr 2017 17:08:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] repack: accept --threads=<n> and pass it down to pack-objects
Date:   Wed, 26 Apr 2017 17:08:39 -0700
Message-ID: <xmqqr30er9tk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We already do so for --window=<n> and --depth=<n>; this will help
when the user wants to force --threads=1 for reproducible testing
without getting affected by racing multiple threads.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-repack.txt | 5 ++++-
 builtin/repack.c             | 5 +++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 26afe6ed54..ae750e9e11 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -9,7 +9,7 @@ git-repack - Pack unpacked objects in a repository
 SYNOPSIS
 --------
 [verse]
-'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [--window=<n>] [--depth=<n>]
+'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [--window=<n>] [--depth=<n>] [--threads=<n>]
 
 DESCRIPTION
 -----------
@@ -92,6 +92,9 @@ other objects in that pack they already have locally.
 	to be applied that many times to get to the necessary object.
 	The default value for --window is 10 and --depth is 50.
 
+--threads=<n>::
+	This option is passed through to `git pack-objects`.
+
 --window-memory=<n>::
 	This option provides an additional limit on top of `--window`;
 	the window size will dynamically scale down so as to not take
diff --git a/builtin/repack.c b/builtin/repack.c
index 677bc7c81a..38ba4ef825 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -155,6 +155,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	int keep_unreachable = 0;
 	const char *window = NULL, *window_memory = NULL;
 	const char *depth = NULL;
+	const char *threads = NULL;
 	const char *max_pack_size = NULL;
 	int no_reuse_delta = 0, no_reuse_object = 0;
 	int no_update_server_info = 0;
@@ -190,6 +191,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				N_("same as the above, but limit memory size instead of entries count")),
 		OPT_STRING(0, "depth", &depth, N_("n"),
 				N_("limits the maximum delta depth")),
+		OPT_STRING(0, "threads", &threads, N_("n"),
+				N_("limits the maximum number of threads")),
 		OPT_STRING(0, "max-pack-size", &max_pack_size, N_("bytes"),
 				N_("maximum size of each packfile")),
 		OPT_BOOL(0, "pack-kept-objects", &pack_kept_objects,
@@ -234,6 +237,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		argv_array_pushf(&cmd.args, "--window-memory=%s", window_memory);
 	if (depth)
 		argv_array_pushf(&cmd.args, "--depth=%s", depth);
+	if (threads)
+		argv_array_pushf(&cmd.args, "--threads=%s", threads);
 	if (max_pack_size)
 		argv_array_pushf(&cmd.args, "--max-pack-size=%s", max_pack_size);
 	if (no_reuse_delta)
-- 
2.13.0-rc1-202-gb5c0e471fc

