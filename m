Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3216EC433FE
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 11:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241442AbiKRLSl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 06:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235237AbiKRLSi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 06:18:38 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9DE14016
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:18:35 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id vv4so2936214ejc.2
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5j0OtJ/pT2mCNtYINNUolxU5Rc0Pp5AWJsA1AwpOpPg=;
        b=KaMAFnodHaIoy0++hmVym87ltajhs2KcJstWckx2y3avFZGDJ6T70A31BnZjkE1KBo
         gZGHI4x/b5OHiHBB3gdz+o/3fz/XXfN9znXExWDsMMdD4brILwKbx17IkUVyOek/DWHa
         zY67zHbdqCYXZ65jTF/pScgEs7KiCuir1keRpiMBgq98ZkGrDXJ0M7bgWLwgKKKGKOfl
         jEbAgvlOVgVjQSstKZ8xh52rUOiu9bS+2aER84yGVjpuzw9oecVDQBl/X/UNO2EqCXvC
         VIiRM1zIPTbxC8d0CqwiiNIGzCFAuIjWt6BDblf2LZ9cvk4KCuvLqN+SbVjiNiXBWwEE
         CqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5j0OtJ/pT2mCNtYINNUolxU5Rc0Pp5AWJsA1AwpOpPg=;
        b=F9boe5+I/WPnhYuYyx4lD3iEnF3mEerRO0sue3H4D4nqkdHaY3+4yK3/hFDmMcKXe2
         WQAYhJnmYIcSmPBabVgDrn4R3yWq8f9/usg6fh5unT9BK1yTpcRIkKSLNlDyKrbshXCV
         X3EA8Yl7IXUzT0wgSKb9tE8jmEAiPXDp08I+CUbnp864IUA4VyZ3Ri9G2dPYro1o3fkf
         33VbXgIXDptAsEUKkeUalkLqbR3j3xLOjcmcuuJL+VYkx1cLZAqg9uoPU5AG3iETDImG
         yVuIhlFlHalqc+f5TwBZKfkf1QXTrIq0Jv91y57gPtmDlCKv1KMnJGcBSTiYqbnP38rV
         c31g==
X-Gm-Message-State: ANoB5pmHB+g7OX7qKlcQqCO0wCxtai4Lk6MV9bSdxwYIrbLThPWRnD2i
        spi0xLjg9/SmLzullb5975o87i/h0nM4mg==
X-Google-Smtp-Source: AA0mqf7Q/2T/U9VbiC4mKdRSZ4J6PNiifBO/JlfqsEZ0xkIPgWVHJp64bF58iR/d3yL6aTNQW52koA==
X-Received: by 2002:a17:906:2650:b0:7b2:c004:55fe with SMTP id i16-20020a170906265000b007b2c00455femr1298063ejc.742.1668770313666;
        Fri, 18 Nov 2022 03:18:33 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id fy20-20020a1709069f1400b00788c622fa2csm1558955ejc.135.2022.11.18.03.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 03:18:33 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v9 01/12] merge-index doc & -h: fix padding, labels and "()" use
Date:   Fri, 18 Nov 2022 12:18:18 +0100
Message-Id: <patch-v9-01.12-cafc7db374e-20221118T110058Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1511.gcdcff1f1dc2
In-Reply-To: <cover-v9-00.12-00000000000-20221118T110058Z-avarab@gmail.com>
References: <20220809185429.20098-1-alban.gruin@gmail.com> <cover-v9-00.12-00000000000-20221118T110058Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the "merge-index" doc SYNOPSIS and "-h" output consistent with
one another, and small issues with it:

- Whitespace padding, per e2f4e7e8c0f (doc txt & -h consistency:
  correct padding around "[]()", 2022-10-13).

- Use "<file>" consistently, rather than using "<filename>" in the
  "-h" output, and "<file>" in the SYNOPSIS.

- The "-h" version incorrectly claimed that the filename was optional,
  but it's not.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-merge-index.txt | 2 +-
 builtin/merge-index.c             | 2 +-
 t/t0450/txt-help-mismatches       | 1 -
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-merge-index.txt b/Documentation/git-merge-index.txt
index eea56b3154e..a297105d6d8 100644
--- a/Documentation/git-merge-index.txt
+++ b/Documentation/git-merge-index.txt
@@ -9,7 +9,7 @@ git-merge-index - Run a merge for files needing merging
 SYNOPSIS
 --------
 [verse]
-'git merge-index' [-o] [-q] <merge-program> (-a | ( [--] <file>...) )
+'git merge-index' [-o] [-q] <merge-program> (-a | ([--] <file>...))
 
 DESCRIPTION
 -----------
diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index 012f52bd007..1a5a64afd2a 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -80,7 +80,7 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 	signal(SIGCHLD, SIG_DFL);
 
 	if (argc < 3)
-		usage("git merge-index [-o] [-q] <merge-program> (-a | [--] [<filename>...])");
+		usage("git merge-index [-o] [-q] <merge-program> (-a | ([--] <file>...))");
 
 	read_cache();
 
diff --git a/t/t0450/txt-help-mismatches b/t/t0450/txt-help-mismatches
index a0777acd667..9e73c1892ae 100644
--- a/t/t0450/txt-help-mismatches
+++ b/t/t0450/txt-help-mismatches
@@ -34,7 +34,6 @@ mailsplit
 maintenance
 merge
 merge-file
-merge-index
 merge-one-file
 multi-pack-index
 name-rev
-- 
2.38.0.1511.gcdcff1f1dc2

