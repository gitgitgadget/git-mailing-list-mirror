Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDF442055E
	for <e@80x24.org>; Sat, 28 Oct 2017 12:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751295AbdJ1ME6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 08:04:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47090 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751029AbdJ1ME5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Oct 2017 08:04:57 -0400
Received: from mail-pf0-f197.google.com ([209.85.192.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <anthony.wong@canonical.com>)
        id 1e8PrE-0001QP-Cc
        for git@vger.kernel.org; Sat, 28 Oct 2017 12:04:56 +0000
Received: by mail-pf0-f197.google.com with SMTP id p2so6936433pfk.13
        for <git@vger.kernel.org>; Sat, 28 Oct 2017 05:04:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=vgRXrX2ply9htBUdt+P2l80fFBmMpXhBoSPYAYsBvR4=;
        b=i5PEJBLcW3vJPR/LSvGHcfMftDXgsTgm56yHvYJun+SbaTiadnP9A1821zrQpHRFdW
         Fygmrca/rw7iXEgYcA7A0BbzTWXeiJk2+E5W3DyroMoQvNH7ihqephDOC5g5shgUp5iA
         hopGNam6ay4U/K/5/mAcABRjRsQkw1F9HOfpjElzHaZTNeu0eKd/+jVG5Z+b7Db11iMX
         5JAyVzECJG3Re9JBNybGLnqSBg/2Vdo9iqdM4Zi/dB8hUxi+o1P3lGSudbwJ+q1mEkXe
         wK/zAr0FsMik4Pf9PhBTmmlPEhpSy5ZCyMivYfhlUcpLJIpndKnz6xOoQe54F23mji9z
         rC6Q==
X-Gm-Message-State: AMCzsaWB8D7G6Ac1iy9hgZzBPlb6bC8+ib/DHiuRwh0A1i5+Ic4afYT4
        f2rTxcjd7ypXvKJWkCoZ19on15tV3EEwhYLKGFNMI6PUbQE791pcOogA6anD7SVgkeNlDhHPblw
        fnZfo4wg7r+W8Q1qE6Bnhzwu5btta3g==
X-Received: by 10.99.121.201 with SMTP id u192mr2826384pgc.69.1509192294691;
        Sat, 28 Oct 2017 05:04:54 -0700 (PDT)
X-Google-Smtp-Source: ABhQp+QwKrZYklpQs4CbJHo+3MblCdcs6QCyFEOdG+rQoSQvxCCEJUf0QzhjNrFGLYnke+OEd8Z64w==
X-Received: by 10.99.121.201 with SMTP id u192mr2826373pgc.69.1509192294465;
        Sat, 28 Oct 2017 05:04:54 -0700 (PDT)
Received: from localhost.localdomain ([46.101.149.102])
        by smtp.gmail.com with ESMTPSA id q13sm11751064pgt.73.2017.10.28.05.04.50
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Oct 2017 05:04:53 -0700 (PDT)
From:   Anthony Wong <anthony.wong@canonical.com>
X-Google-Original-From: Anthony Wong <yp@anthonywong.net>
To:     git@vger.kernel.org
Subject: [PATCH] cherry-pick: add --keep-existing-origin option
Date:   Sat, 28 Oct 2017 20:04:40 +0800
Message-Id: <20171028120440.2022-1-yp@anthonywong.net>
X-Mailer: git-send-email 2.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When cherry-picking from a commit whose commit message already
contains the "(cherry picked from commit ...)" line, this option will
not add another one. This is useful when you are cherry-picking from a
bunch of commits, some are cherry-picks and already contains the
upstream hash but some do not. Use with -x.

Signed-off-by: Anthony Wong <yp@anthonywong.net>
---
 Documentation/git-cherry-pick.txt |  8 ++++++++
 builtin/revert.c                  |  2 ++
 sequencer.c                       | 14 ++++++++------
 sequencer.h                       |  1 +
 4 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index d35d771fc..7a074511f 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -71,6 +71,14 @@ OPTIONS
 	development branch), adding this information can be
 	useful.
 
+--keep-existing-origin::
+	This option has to be used with -x to take effect. When
+	cherry-picking from a commit whose commit message already
+	contains the "(cherry picked from commit ...)" line, this
+	option will not add another one. This is useful when you are
+	cherry-picking from a bunch of commits, some are cherry-picks
+	and already contains the upstream hash but some do not.
+
 -r::
 	It used to be that the command defaulted to do `-x`
 	described above, and `-r` was to disable it.  Now the
diff --git a/builtin/revert.c b/builtin/revert.c
index b9d927eb0..a1900cc1d 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -122,6 +122,7 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 			OPT_BOOL(0, "allow-empty", &opts->allow_empty, N_("preserve initially empty commits")),
 			OPT_BOOL(0, "allow-empty-message", &opts->allow_empty_message, N_("allow commits with empty messages")),
 			OPT_BOOL(0, "keep-redundant-commits", &opts->keep_redundant_commits, N_("keep redundant, empty commits")),
+			OPT_BOOL(0, "keep-existing-origin", &opts->keep_existing_origin, N_("do not add another hash if one already exists, use with -x")),
 			OPT_END(),
 		};
 		options = parse_options_concat(options, cp_extra);
@@ -157,6 +158,7 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 				"--ff", opts->allow_ff,
 				"--rerere-autoupdate", opts->allow_rerere_auto == RERERE_AUTOUPDATE,
 				"--no-rerere-autoupdate", opts->allow_rerere_auto == RERERE_NOAUTOUPDATE,
+				"--keep-existing-origin", opts->keep_existing_origin,
 				NULL);
 	}
 
diff --git a/sequencer.c b/sequencer.c
index f2a10cc4f..c96add16e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1050,12 +1050,14 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 			strbuf_addstr(&msgbuf, p);
 
 		if (opts->record_origin) {
-			strbuf_complete_line(&msgbuf);
-			if (!has_conforming_footer(&msgbuf, NULL, 0))
-				strbuf_addch(&msgbuf, '\n');
-			strbuf_addstr(&msgbuf, cherry_picked_prefix);
-			strbuf_addstr(&msgbuf, oid_to_hex(&commit->object.oid));
-			strbuf_addstr(&msgbuf, ")\n");
+			if (!opts->keep_existing_origin || strstr(msgbuf.buf, cherry_picked_prefix) == NULL) {
+				strbuf_complete_line(&msgbuf);
+				if (!has_conforming_footer(&msgbuf, NULL, 0))
+					strbuf_addch(&msgbuf, '\n');
+				strbuf_addstr(&msgbuf, cherry_picked_prefix);
+				strbuf_addstr(&msgbuf, oid_to_hex(&commit->object.oid));
+				strbuf_addstr(&msgbuf, ")\n");
+			}
 		}
 	}
 
diff --git a/sequencer.h b/sequencer.h
index 6f3d3df82..a907c0947 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -24,6 +24,7 @@ struct replay_opts {
 	int allow_empty;
 	int allow_empty_message;
 	int keep_redundant_commits;
+	int keep_existing_origin;
 	int verbose;
 
 	int mainline;
-- 
2.14.1

