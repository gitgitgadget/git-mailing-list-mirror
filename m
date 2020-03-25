Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28438C2D0E7
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 21:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F17412082D
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 21:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vFV2CHt1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbgCYVK1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 17:10:27 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:51194 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbgCYVK1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 17:10:27 -0400
Received: by mail-wm1-f46.google.com with SMTP id d198so4299814wmd.0
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 14:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u36TQ1tAtEldtlicTEXvHc9djav+tZSEG+930TO7JwU=;
        b=vFV2CHt1g0uX+chomJPBA5gUFb4xGrWs5wVtp1GdTekT9Hddph9Sp9Y7GIixWMwI+M
         EP4o6lSA4Gevm6lzfIaUTGYOVKnBTudm98XFs0to79n6HRwpheiB5KI+LkJnQdat8m64
         7moRDn56/iKHyGV4jlZFB0pLoVoXWYQiCRkUVEPBKp3aPtl0RFdaY7YmZR9pkRJzq3Ro
         7OpNa0BbHh6ZrhUfVKAAj9XloFWeMcOjgLITccI7CKzohpg6tn+LcrCUSxlCupaJ8+8e
         UH64rKfI8vDtj3Q/tzsaJI5jpnvQ1AJAwA+QVdkAKqOPUa6bA1L/e76kv/wynJ8cWuix
         IBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u36TQ1tAtEldtlicTEXvHc9djav+tZSEG+930TO7JwU=;
        b=TY4RniwvFLSm36czODm1ncO5X5vPdZQyDu0IYO7gWs/gGTeAuKwruo89rxQeYLwGMt
         JEi3qCR6lCU5oQBTxKIJkjFLYErgU5WtADh8EH6kvbX/QMqJRe3rZzPPoJPZbdODplAC
         FCI3wzcDXF58+LfKRA3OL/rFNw3xnJdbdF6je9Uyq04f+/wpH7e9+w39onflZFOuHP71
         OiRjREm00euqcNcfjGTfpuSU8hFTfHz1KyaD5MoDhw0/IlkWUBXPlZM7p2Bszu/or730
         tFeStqost4B6m2sxgZXabXP3r/nt5fz/qNKgjm8qY6/k0tsbuTXopaKUXGckzqiBbmAw
         sUFQ==
X-Gm-Message-State: ANhLgQ0p/bAA2YYMRNMd9/7EOijsB5HUHJdMXQyUAwuNsYR0zQqj5sA7
        MHiNqSvnAdm0xcq5TAdUJmK7bdVpIes=
X-Google-Smtp-Source: ADFU+vsceMgGj5G7/RKaDVIz8nq4B3FdZYyzoVYjL+YCPh9vvPCeSj0H7PGwQHZjtmfXJKco0TQzjg==
X-Received: by 2002:a1c:9904:: with SMTP id b4mr5369832wme.34.1585170625084;
        Wed, 25 Mar 2020 14:10:25 -0700 (PDT)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id u16sm352760wro.23.2020.03.25.14.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 14:10:24 -0700 (PDT)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH v4 1/5] doc: list all commands affected by submodule.recurse
Date:   Wed, 25 Mar 2020 22:09:39 +0100
Message-Id: <20200325210943.339240-2-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200325210943.339240-1-damien.olivier.robert+git@gmail.com>
References: <20200325210943.339240-1-damien.olivier.robert+git@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Note that `ls-files` is not affected, even though it has a
`--recurse-submodules` option, so list it as an exception too.

Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>
---
 Documentation/config/submodule.txt | 5 +++--
 Documentation/gitsubmodules.txt    | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/submodule.txt b/Documentation/config/submodule.txt
index b33177151c..5962f41ead 100644
--- a/Documentation/config/submodule.txt
+++ b/Documentation/config/submodule.txt
@@ -59,8 +59,9 @@ submodule.active::
 
 submodule.recurse::
 	Specifies if commands recurse into submodules by default. This
-	applies to all commands that have a `--recurse-submodules` option,
-	except `clone`.
+	applies to all commands that have a `--recurse-submodules` option
+	(`checkout`, `fetch`, `grep`, `pull`, `push`, `read-tree`, `reset`,
+	`restore` and `switch`) except `clone` and `ls-files`.
 	Defaults to false.
 
 submodule.fetchJobs::
diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodules.txt
index c476f891b5..f9f4e65c9e 100644
--- a/Documentation/gitsubmodules.txt
+++ b/Documentation/gitsubmodules.txt
@@ -271,7 +271,8 @@ will not be checked out by default; You can instruct 'clone' to recurse
 into submodules. The 'init' and 'update' subcommands of 'git submodule'
 will maintain submodules checked out and at an appropriate revision in
 your working tree. Alternatively you can set 'submodule.recurse' to have
-'checkout' recursing into submodules.
+'checkout' recursing into submodules (note that 'submodule.recurse' also
+affects other git commands, see linkgit:git-config[1] for a complete list).
 
 
 SEE ALSO
-- 
Patched on top of v2.26.0 (git version 2.25.2)

