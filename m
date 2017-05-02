Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AADFD207E4
	for <e@80x24.org>; Tue,  2 May 2017 22:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751597AbdEBWYY (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 18:24:24 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35992 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751677AbdEBWX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 18:23:58 -0400
Received: by mail-pf0-f181.google.com with SMTP id q66so3483676pfi.3
        for <git@vger.kernel.org>; Tue, 02 May 2017 15:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/IpJfDrZv2cVVYTLQpYWBR9WxCFyBfbClQ9XD42rPks=;
        b=HGfGq0sfUC8IfVIWuldkrNwvcISJ1JTQRdYTFDr2YA8xOU//bo8VWMrxUn0W9aVeUJ
         oGlI7cB5Mi76RBlF9NDFjzzn+VUXCzCfQ9QcJyrAnJozNz0ZGCMZAXYLcdFKj0KsZGA/
         kjhd9olEMOQvtQjgoUObsrVomJAytq+orI4jSCs2zd7iTzPR9ikkzCB0bzlI1I100oFN
         xJ3Ru2mj0ewkUjvHtu2LHw7Tx4Cz9EFrUqB15uDMQkgka2yta19kzJfYQQmKDOCEZCZr
         oSsLGvJT3kaBFxhf2ittTGOVXaPqKOv3cIH/xmAPsliSStQ5BtUO7/gJht3Kr8LMkF5a
         M20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/IpJfDrZv2cVVYTLQpYWBR9WxCFyBfbClQ9XD42rPks=;
        b=gAOjip0Vskdz5I3EZrYroNPDVN1wlb3xqkyEdwWx7hCUdNJNktlgQ22Hdaovv32jci
         dmYLG24h3+Ni5EMKShddh0k9q15bxOQCo3UF5L5A5/1/zqr47e4wRckq0AWwONf1jaIZ
         oRZbJywaIGVkqRsTpT+OVPinL/hnoFZDbzdowhUJ2PdM7MTadlTOp5p6tqlmtbfIEwAZ
         HkqK+y4EjO0LTPMIT0cGM5ShHTITuErqQS598OE4WKh8fpTKhurxKi+VFRzlr7yjLVGN
         AdV9NzeI3ub1m4ibH8MgwZ1w878/BaOu/Pe/q4ROmiR4NbUVoaJkfy0q4DhxjhHOQAlC
         V1Dw==
X-Gm-Message-State: AN3rC/7VA+XXW0CzSQW1T2391AYP90T2/L7kKafAxcIht4a13gKZcHtQ
        5Ez7desPY3J6juc/
X-Received: by 10.84.254.4 with SMTP id b4mr44715598plm.64.1493763837903;
        Tue, 02 May 2017 15:23:57 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c805:cf1:74c5:2e74])
        by smtp.gmail.com with ESMTPSA id e131sm708556pfg.10.2017.05.02.15.23.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 May 2017 15:23:57 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, git@jeffhostetler.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 24/24] cache.h: retire NO_THE_INDEX_COMPATIBILITY_MACROS
Date:   Tue,  2 May 2017 15:23:22 -0700
Message-Id: <20170502222322.21055-25-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.rc1.39.ga6db8bfa24
In-Reply-To: <20170502222322.21055-1-sbeller@google.com>
References: <20170502222322.21055-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The NO_THE_INDEX_COMPATIBILITY_MACROS pre processor setting was introduced
in 4aab5b46f4 (Make read-cache.c "the_index" free., 2007-04-01), stating:

    This makes all low-level functions defined in read-cache.c to
    take an explicit index_state structure as their first parameter,
    to specify which index to work on.

The reasoning is very vague, maybe indicating that having the index
specified to work on is easier to for the new reader to understand what
is going on.

All preceding patches worked on retiring functions that do not take an
explicit index as to where to perform its work. Spelling out the reasons
why we want to specify the index at each call:

1)  Ease of understanding:
   The recent patches dropped a lot of macros that may confuse new people
   diving into the code base.
2a) Spelling out global state explicitly:
   Anything you do in submodule land today needs to spawn new processes in
   the submodule. This is cumbersome and not performant. So we may want to
   have an abstraction of a repo, i.e. all repository state in one struct.
   That way we can open a submodule in-process and perform the required
   actions without spawning a process. The road to this future is a long
   road, and we have to start somewhere. Exposing the global state seems
   like a good starter point.
2b) Spelling out global state explicitly (II): (Jeff Hostetler wrote)
   In addition to (eventually) allowing multiple repos be open at the same
   time for submodules, it would also help with various multi-threading
   efforts.  For example, we have loops that do a
   "for (k = 0, k < active_nr; k++) {...}"  There is no visual clue in that
   code that it references "the_index" and therefore should be subject to
   the same locking.  Granted, this is a trivial example, but goes to the
   argument that the code has lots of subtle global variables and macros
   that make it difficult to reason about the code.

   This step would help un-hide this.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 attr.c         | 1 -
 cache.h        | 4 ----
 name-hash.c    | 1 -
 read-cache.c   | 1 -
 unpack-trees.c | 1 -
 5 files changed, 8 deletions(-)

diff --git a/attr.c b/attr.c
index 7e2134471c..3decf432b8 100644
--- a/attr.c
+++ b/attr.c
@@ -7,7 +7,6 @@
  * an insanely large number of attributes.
  */
 
-#define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "exec_cmd.h"
 #include "attr.h"
diff --git a/cache.h b/cache.h
index f2a45eda9a..f4b7b8621c 100644
--- a/cache.h
+++ b/cache.h
@@ -352,10 +352,6 @@ extern void add_name_hash(struct index_state *istate, struct cache_entry *ce);
 extern void remove_name_hash(struct index_state *istate, struct cache_entry *ce);
 extern void free_name_hash(struct index_state *istate);
 
-
-#ifndef NO_THE_INDEX_COMPATIBILITY_MACROS
-#endif
-
 enum object_type {
 	OBJ_BAD = -1,
 	OBJ_NONE = 0,
diff --git a/name-hash.c b/name-hash.c
index 39309efb7f..02870c1d19 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -5,7 +5,6 @@
  *
  * Copyright (C) 2008 Linus Torvalds
  */
-#define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 
 struct dir_entry {
diff --git a/read-cache.c b/read-cache.c
index 6681376f5b..e0c6f3ca11 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3,7 +3,6 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-#define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "tempfile.h"
 #include "lockfile.h"
diff --git a/unpack-trees.c b/unpack-trees.c
index 3dd8f60fc1..41956c4b37 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1,4 +1,3 @@
-#define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "dir.h"
 #include "tree.h"
-- 
2.13.0.rc1.39.ga6db8bfa24

