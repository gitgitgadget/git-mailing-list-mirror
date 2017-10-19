Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8379202A2
	for <e@80x24.org>; Thu, 19 Oct 2017 19:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752737AbdJSTHV (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 15:07:21 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:47253 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751725AbdJSTHU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 15:07:20 -0400
Received: by mail-wr0-f194.google.com with SMTP id y39so9356462wrd.4
        for <git@vger.kernel.org>; Thu, 19 Oct 2017 12:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YcbhZ3KDPjQztC6saqB14Fqp+ZHxrF0tP+IjG2yOJtA=;
        b=ojYyVaUFmKpDyXo6xpMSS2vd9p2rs6UNw2WxtievByq+oQT8pGl/B/0yKxXiMxOF7G
         K5ZyglthT3kvuWxWXS0gtvkzNul21Rg0svmSAVL+9KWfj16PY1+NPytfr16hBh6x1Zly
         gQNz2nwJwBRUv7gkawjlVVcgByGbBTiAK49tqPMrQ6j4ePpzHo9wEUq1wCZXzdn/HgA6
         mh05S4jDzDKRmarOWRVh5RpL0U9YBSRTMkbKvaZ8nI7tDA2jUrgxtozZALXxATtFzWSg
         37A8XE/B7F8XgV4wa9PyiahtsSIxVkx2BANVtMkmrSbmyUtxumqFAqwo+jZbVnGvWgGD
         SlZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YcbhZ3KDPjQztC6saqB14Fqp+ZHxrF0tP+IjG2yOJtA=;
        b=EDn9o73+db+VqTJZ8c3vMVYWOMV1lRPDgJBJQjQfokFIQZkA+3bmM25w8brEYONxyk
         ZQ5je+9Bi1/e4KvsYzZTtC9IAnGLZlE/YSjTZNiYTCAveCA2gKW6n+Le0kj+2UGlzhpf
         jQarCxcuGbV1GOdhkyy06NQVdfyQarn9BFO120e2fTn8tBC/t0kFtkAS17cYs3wTF6wm
         b/uOnvv0bLq5Z8yRL/wCtmaH06fJHUx/O5fiHiXx7slCmRLCUUwqm/uKLM8+lwy1RJVX
         ZFleWX0W2z2vlQ63iIfiDN2YEU76YqSy17r7oKI3C41YtAmnudaYmC/Rasvw9yOYLT/5
         guRQ==
X-Gm-Message-State: AMCzsaWDq0+S5PlcX+eH4gytfJUGYxE37FK5uM+CUWphqNzxLmcVVSpV
        rwie353o6wYF38UYmcGZkWXgSRHa
X-Google-Smtp-Source: ABhQp+T0Urnif0An56SnNIbMi9wJ3yP5u42+wMcUIX5kFpUpDgC/Ujxvtc+NaThtWZwZ5D8A7UBZ3g==
X-Received: by 10.223.157.203 with SMTP id q11mr2652550wre.131.1508440038462;
        Thu, 19 Oct 2017 12:07:18 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id o24sm2416163wmi.39.2017.10.19.12.07.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Oct 2017 12:07:17 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH/RFC] grep: turn off threading when recursing submodules
Date:   Thu, 19 Oct 2017 21:07:03 +0200
Message-Id: <20171019190703.1534-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.15.0.rc1.71.g1477d2401
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With --recurse-submodules, we use the machinery for alternate object
databases and pretend that the repository is an alternate ODB. This has
some drawbacks since the list of alternates is global and will grow as
we proceed. Still, that's a problem with performance, not correctness.
The other immediately available option is to spawn an external process.
We actually used to do this until f9ee2fcdf (grep: recurse in-process
using 'struct repository', 2017-08-02).

So, as we encounter submodules during our recursing, we add them to the
list of ODBs. But with threading, our changes to the list are not
protected against races. Indeed, ThreadSanitizer reports a problem in
this area with t7814.

The race which ThreadSanitizer detects is that `grep_submodule()` calls
`add_to_alternates_memory()` around the same time that
`grep_source_load_oid()` ends up calling `prepare_packed_git()`. A
similar race might occur if two threads encounter a submodule each at
the same time and add them to the list of ODBs. This might end up losing
one of them and could give incorrect results.

Turn off threading when we're recursing submodules to avoid this race.
Long term, a better approach will be to address the existing NEEDSWORK
in builtin/grep.c to introduce per-repo object stores. Then we should be
able to revert this commit.

Alternatively, we could equip the list with a mutex (or maybe do some
lock-less cleverness), but it seems a bit sad considering it shouldn't
really be needed: the list of ODBs would normally be fully populated
before we start using it.

Another approach would be to first recurse the submodules and collect
the ODBs, then recurse again to do the actual grepping. That would be a
more involved change. Or, we could revert f9ee2fcdf. That would hurt
those who do not use threading.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
This is a simple, stupid solution. I'm posting this in patch-form so
that I can do one better than just mailing about the race and waving my
hands. Maybe threading is common enough that reverting could be a better
approach. Or implementing some (optional) locking...

Output from ThreadSanitizer below the patch.

 builtin/grep.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/builtin/grep.c b/builtin/grep.c
index 2d65f27d0..29f79104d 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1023,6 +1023,15 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		die(_("invalid number of threads specified (%d)"), num_threads);
 	if (num_threads == 1)
 		num_threads = 0;
+	/*
+	 * NEEDSWORK: When we recurse through submodules we misuse the
+	 * alt-odb-mechanism (alternate object databases). Doing so may hit
+	 * data-races if we are threading. This can be removed once the object
+	 * store is no longer global and instead is a member of the repository
+	 * object.
+	 */
+	if (recurse_submodules)
+		num_threads = 0;
 #else
 	if (num_threads)
 		warning(_("no threads support, ignoring --threads"));
-- 
WARNING: ThreadSanitizer: data race (pid=27207)
  Write of size 8 at 0x7d4c0000de40 by main thread:
    #0 link_alt_odb_entry sha1_file.c:361
    #1 link_alt_odb_entries.lto_priv.1377 sha1_file.c:422
    #2 add_to_alternates_memory sha1_file.c:510
    #3 grep_submodule builtin/grep.c:434
    #4 grep_cache builtin/grep.c:508
    #5 grep_submodule builtin/grep.c:462
    #6 grep_cache builtin/grep.c:508
    #7 cmd_grep builtin/grep.c:1092
    #8 run_builtin git.c:346
    #9 handle_builtin.lto_priv.1929 git.c:554
    #10 run_argv git.c:606
    #11 cmd_main git.c:683
    #12 main common-main.c:43

  Previous read of size 8 at 0x7d4c0000de40 by thread T4 (mutexes: write
M6):
    #0 prepare_packed_git.part.9.lto_priv.953 packfile.c:883
    #1 prepare_packed_git packfile.c:289
    #2 find_pack_entry packfile.c:1836
    #3 sha1_object_info_extended sha1_file.c:1179
    #4 read_object.lto_priv.900 packfile.c:1453
    #5 read_sha1_file_extended.constprop.779 sha1_file.c:1279
    #6 read_sha1_file cache.h:1162
    #7 grep_source_load_oid grep.c:1966
    #8 grep_source_load grep.c:2019
    #9 grep_source_is_binary grep.c:2045
    #10 grep_source_1 grep.c:1689
    #11 grep_source grep.c:1897
    #12 run builtin/grep.c:183
    #13 <null> <null>

  Location is heap block of size 408 at 0x7d4c0000de40 allocated by main
thread:
    #0 calloc <null>
    #1 xcalloc.constprop.820 wrapper.c:160
    #2 alloc_alt_odb sha1_file.c:449
    #3 link_alt_odb_entry sha1_file.c:358
    #4 link_alt_odb_entries.lto_priv.1377 sha1_file.c:422
    #5 add_to_alternates_memory sha1_file.c:510
    #6 grep_submodule builtin/grep.c:434
    #7 grep_cache builtin/grep.c:508
    #8 cmd_grep builtin/grep.c:1092
    #9 run_builtin git.c:346
    #10 handle_builtin.lto_priv.1929 git.c:554
    #11 run_argv git.c:606
    #12 cmd_main git.c:683
    #13 main common-main.c:43

  Mutex M6 (0x000000959340) created at:
    #0 pthread_mutex_init <null>
    #1 start_threads builtin/grep.c:204
    #2 cmd_grep builtin/grep.c:1047
    #3 run_builtin git.c:346
    #4 handle_builtin.lto_priv.1929 git.c:554
    #5 run_argv git.c:606
    #6 cmd_main git.c:683
    #7 main common-main.c:43

  Thread T4 (tid=27212, running) created by main thread at:
    #0 pthread_create <null>
    #1 start_threads builtin/grep.c:223
    #2 cmd_grep builtin/grep.c:1047
    #3 run_builtin git.c:346
    #4 handle_builtin.lto_priv.1929 git.c:554
    #5 run_argv git.c:606
    #6 cmd_main git.c:683
    #7 main common-main.c:43

SUMMARY: ThreadSanitizer: data race sha1_file.c:361 link_alt_odb_entry

-- 
2.15.0.rc1.71.g1477d2401

