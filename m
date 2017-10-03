Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 367E52036B
	for <e@80x24.org>; Tue,  3 Oct 2017 19:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751241AbdJCT4i (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 15:56:38 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38675 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751208AbdJCT4g (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 15:56:36 -0400
Received: by mail-wr0-f196.google.com with SMTP id f12so749065wra.5
        for <git@vger.kernel.org>; Tue, 03 Oct 2017 12:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tebkDSFHk8vgJSeKwO7YPMVai0mc8kp6EJQtIuCJIoA=;
        b=dRg/7bzCFGWpYM5uEl0xYdugEyCwFKd3+tNyoyTYC6463VBDCWfrj4Djw5IT2GvHwB
         AI59/gdWfFI/xM0Oh7MJn8dF6+/yRxt4pOXDXxUL4hHjNh+c42mySNjvzs3wAkSBWcf0
         8G7i+66OsXmO8L284E34Cp7AEF9dVVLE2iQIzDK8VCIkanc1UxexLBzeY5zy9oTS1nK0
         nqjqUj/X/i3jwAubONi2tVIAsod2+jKXjj81RK38DwT5cS1da1gWBwAuJ0PR1AZ2aHZx
         gfItL8opBvjYfZ9IuWr3woq/M/EQUCnfukPwpT7b+/6ilfe/t6LH5pT7IDEnGpIQCx/m
         Bwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tebkDSFHk8vgJSeKwO7YPMVai0mc8kp6EJQtIuCJIoA=;
        b=UdPudckG4HRaXAzgu5Fi+CORSX1+8uig+TmbjE0IArf2i25sEdR9Iy+tbntKq4YRnw
         p1gHv+7b/lIeBLamq4MF1CVdcXhYfE9XTzSQ3gAlaJtlWOhAhbwrpb/So+h6OEKAm1Yg
         rXtawkjH4tYuUbmzcx92v+2X4MiEPk2Es9LuTNicyXa4zDQDxYDNuuy3Xj7pIeRN3AQE
         Vno1cnQEixUlzcso6M0nyDJKppzTtsmUk20TVq+jhiYcUQwxuAfA42hkHROpGzDrMMFg
         JL5+g6SNXYfpRPkCc47b9EVtaS3AZ/0a7hxJwTcXE63IK5lArD0/z7LHrAUfUk4ZZYQT
         PZZw==
X-Gm-Message-State: AMCzsaVQqaW0HTqY6rAOs/a3vsLL9I7s4lFG9mdTlYoKmq/lhCbOwVuI
        FXvNxBfn1+YVA1reE6Gxa1FDaR+k65w=
X-Google-Smtp-Source: AOwi7QBUN9mUk2o5TZ6I3w7J0LWDdIq6xgxMvTDhd+aayvQCaNHBi1u2GbP3QkdlCmcrbmcsk1Zvpw==
X-Received: by 10.223.167.10 with SMTP id c10mr11913311wrd.232.1507060594196;
        Tue, 03 Oct 2017 12:56:34 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id 69sm18156672wmp.11.2017.10.03.12.56.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Oct 2017 12:56:33 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Ben Peart <peartben@gmail.com>,
        Ben Peart <benpeart@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH 3/3] sub-process: allocate argv on the heap
Date:   Tue,  3 Oct 2017 20:57:13 +0100
Message-Id: <20171003195713.13395-4-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89
In-Reply-To: <20171003195713.13395-1-t.gummerer@gmail.com>
References: <20171003195713.13395-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently the argv is only allocated on the stack, and then assigned to
process->argv.  When the start_subprocess function goes out of scope,
the local argv variable is eliminated from the stack, but the pointer is
still kept around in process->argv.

Much later when we try to access the same process->argv in
finish_command, this leads us to access a memory location that no longer
contains what we want.  As argv0 is only used for printing errors, this
is not easily noticed in normal git operations.  However when running
t0021-conversion.sh through valgrind, valgrind rightfully complains:

==21024== Invalid read of size 8
==21024==    at 0x2ACF64: finish_command (run-command.c:869)
==21024==    by 0x2D6B18: subprocess_exit_handler (sub-process.c:72)
==21024==    by 0x2AB41E: cleanup_children (run-command.c:45)
==21024==    by 0x2AB526: cleanup_children_on_exit (run-command.c:81)
==21024==    by 0x54AD487: __run_exit_handlers (in /usr/lib/libc-2.26.so)
==21024==    by 0x54AD4D9: exit (in /usr/lib/libc-2.26.so)
==21024==    by 0x11A9EF: handle_builtin (git.c:550)
==21024==    by 0x11ABCC: run_argv (git.c:602)
==21024==    by 0x11AD8E: cmd_main (git.c:679)
==21024==    by 0x1BF125: main (common-main.c:43)
==21024==  Address 0x1ffeffec00 is on thread 1's stack
==21024==  1504 bytes below stack pointer
==21024==

Fix this by allocating the memory on properly on the heap.  This memory
is allocated on the heap, and never free'd.  However the same seems to be
true for struct child_process, so it should be fine to just let the
memory be free'd when the process terminates.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 sub-process.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sub-process.c b/sub-process.c
index 6dde5062be..4680af8193 100644
--- a/sub-process.c
+++ b/sub-process.c
@@ -77,7 +77,9 @@ int subprocess_start(struct hashmap *hashmap, struct subprocess_entry *entry, co
 {
 	int err;
 	struct child_process *process;
-	const char *argv[] = { cmd, NULL };
+	const char **argv = xmalloc(2 * sizeof(char *));
+	argv[0] = cmd;
+	argv[1] = NULL;
 
 	entry->cmd = cmd;
 	process = &entry->process;
-- 
2.14.1.480.gb18f417b89

