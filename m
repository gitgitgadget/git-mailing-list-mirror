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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986ECC48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 16:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80EDB6162F
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 16:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhFOQVP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 12:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbhFOQVO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 12:21:14 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F30C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 09:19:09 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v9so2700394wrx.6
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 09:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AL8pZf3EzXl2cmYcCpzgbNDDcn3eIrO+d5VjL5wVxSo=;
        b=dehqETJQtH6gwzzJyP/pxm0UUkZDSvZMWMDojSOZwAWZdRrxUQ/aalUpNA8WmYaN9N
         iE8MaL4NdJ4qslhzB6AKEo6eqk+d+3uSyhAhf7G27nOwqDZWej+M20k6aIssgofWhZQv
         O5kum7Mc3OQ/6bQy0bLrMAHAnNtfN2gI2WUF8yYep/SNAICwkYn9ogR8KdoBnSdGDta1
         HcS4YG8TdKjTWgOZNzkFEAT4yvzgniGSoEYf4dXZWN6iaTaW+4lgfSg2x4sKqeUl0qS/
         Br5xBfrEfqjd0bfXMcnTruV98HiwceisFRddsp7IPDN6M0N++JF+JFr+fy11XJErBwIc
         lCWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AL8pZf3EzXl2cmYcCpzgbNDDcn3eIrO+d5VjL5wVxSo=;
        b=DuCI+FDYmnC0MZy2DpowaTCkUT+Ska87KIMQqclZ2DE3CNdjy2UY5MwnNDs9SAoL7+
         c4VYNR0vo0aBJSZ7+Q8AGWxIWcZroLfftLN82P7jkKJUCPccfRaoftx/JqQxCkSnQK2i
         OHIlieq3GsHJvQN5Tlpv/XYWT5296IMdl0Eo2at6z0W7ehh20Sngrp7/K/z4lzPSrRzG
         se4Vfe5M2yidwp7rC5GPgGn31JZ+7OVSjvHNMEpRs93vZ0HHnW/TNL3t8/DCuyxRO8P3
         626m6J+nCpBZ2IJqV9zj30/RKytoSXmHu//AjOluBsw4ulc0Ue35VFOs5CHMuElOsMsq
         TBcQ==
X-Gm-Message-State: AOAM533TrPmmTy3SX8GJCI+MZAGkXD2lAghbMSCjjlislOAabRjuwluQ
        ySnq0Z2YyjrMIoZlbE413qUd2+pxxUjiMg==
X-Google-Smtp-Source: ABdhPJwm49/E6EbM5IZ99gtEVD/TzQ5yl9tcxo4226O6u7YgUhDyVajkR3oXJJu4AWTDPPiLhF4UpA==
X-Received: by 2002:adf:d20a:: with SMTP id j10mr4677585wrh.157.1623773947629;
        Tue, 15 Jun 2021 09:19:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b8sm2671901wmd.35.2021.06.15.09.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 09:19:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/6] fast-import doc: change "bob" in an example to "file.txt"
Date:   Tue, 15 Jun 2021 18:18:01 +0200
Message-Id: <patch-4.6-0b464dc51d8-20210615T161330Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.555.g0268d380f7b
In-Reply-To: <cover-0.6-00000000000-20210615T161330Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210615T161330Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The example added in e7e5170f804 (Update fast-import documentation to
discuss crash reports, 2008-02-14) is a bit confusing in that we're
referring to a "bob" when we really just need a placeholder name for a
file that has bad mode bits, let's use "file.txt" instead.

Let's also use "<<-" in the here-doc so this'll work if the reader
copies this from e.g. a tab-indented manual page, none of the content
needs leading whitespace, so that won't break anything if the content
isn't indented.

The fast-import error message and other output has also changed
slightly since 2008, let's update the relevant parts of it, while
retaining the original PID, time etc. of the 2007-era example.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-fast-import.txt | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 39cfa05b28b..ddaa8e5d755 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -1277,7 +1277,7 @@ must be applied manually if the update is needed.
 An example crash:
 
 ====
-	$ cat >in <<END_OF_INPUT
+	$ cat >in <<-END_OF_INPUT
 	# my very first test commit
 	commit refs/heads/master
 	committer Shawn O. Pearce <spearce> 19283 -0400
@@ -1289,12 +1289,13 @@ An example crash:
 	data <<EOF
 	.gitignore
 	EOF
-	M 777 inline bob
+	M 777 inline file.txt
 	END_OF_INPUT
 
 	$ git fast-import <in
-	fatal: Corrupt mode: M 777 inline bob
+	fatal: Corrupt mode: M 777 inline file.txt
 	fast-import: dumping crash report to .git/fast_import_crash_8434
+	Unpacking objects: 100% (1/1), 32 bytes | 32.00 KiB/s, done.
 
 	$ cat .git/fast_import_crash_8434
 	fast-import crash report:
@@ -1302,7 +1303,7 @@ An example crash:
 	    parent process     : 1391
 	    at Sat Sep 1 00:58:12 2007
 
-	fatal: Corrupt mode: M 777 inline bob
+	fatal: Corrupt mode: M 777 inline file.txt
 
 	Most Recent Commands Before Crash
 	---------------------------------
@@ -1313,7 +1314,7 @@ An example crash:
 	  data <<EOF
 	  M 644 inline .gitignore
 	  data <<EOF
-	* M 777 inline bob
+	* M 777 inline file.txt
 
 	Active Branch LRU
 	-----------------
@@ -1334,6 +1335,9 @@ An example crash:
 	  last pack   :
 
 
+	Marks
+	-----
+
 	-------------------
 	END OF CRASH REPORT
 ====
-- 
2.32.0.555.g0268d380f7b

