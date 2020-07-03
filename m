Return-Path: <SRS0=CKFy=AO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB94C433E1
	for <git@archiver.kernel.org>; Fri,  3 Jul 2020 03:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BF5620B1F
	for <git@archiver.kernel.org>; Fri,  3 Jul 2020 03:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Foh9hAKt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgGCDig (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jul 2020 23:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgGCDid (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jul 2020 23:38:33 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF0FC08C5DD
        for <git@vger.kernel.org>; Thu,  2 Jul 2020 20:38:33 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id s10so30948930wrw.12
        for <git@vger.kernel.org>; Thu, 02 Jul 2020 20:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TKSgVEhpetKaGG40J72/nMhRAAlk00EhYwCqPLl45/s=;
        b=Foh9hAKtZgXXBiuT4suoXGXd+0CU2YqQL1OHlxN9+soAs7gIedJKNGKGxcy3mj/k/4
         GyX/34WMbd5DJu7E3J7qX7suXNSkfnL3xB5At1wjztaw0I5okUIsYc8gZQQAC7zfMRWv
         6Zgoj+Hw8DeKQ0lUPngzEez7gnrmy4O6b3CS09F7CDz1GUcRvQGJq/7Ss7jAyFogli0w
         nDRphOcl5ii7PoIbCWW4vuGSX18VhHUhcbTPIrQ4Lpfd70oZo8t5IzBUwJJj0cs7VyY8
         mjKa4InOl8YqZiCrIp1Jd035Jf+ON4MKPFYkkawFKbim06q+5WL2wa4DQAuu3D2cyu4B
         S95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TKSgVEhpetKaGG40J72/nMhRAAlk00EhYwCqPLl45/s=;
        b=AgkKf4EZN5sHZqlLYHvs/iMPMN9UVDyLe3ICMVDQRxIAcd2+r+1JQM4eakwQLeVTMC
         NIBakZKrXYLjrZohsgK7AsmFP2+KPi0KZNR4tKWL8OQdy+af2ZBRmgZswz+c8SH/dyeT
         ZnQn/8h65DvymJs4scLCxRBaR2hqSVcie7LBoN6ShQ+UvdA+vPsLez+vl7YUmpaZY3A8
         jiozsKXdtX3R7u1OyewCWTMgLovGfNaMFRmNuyuhA0P49xUKhg1q1Ln/ORvpQDKemcav
         wwcKePvfpoMPB+rBCEGKMz1mkCAGd8FAgCLIg05bPmGhI5KtjMK57o0Vm9LxCFy/WJ5b
         Lt0A==
X-Gm-Message-State: AOAM530QOlq571IDJwBIkjJgQ0xp8/QBQ4DUYKXE8pP3LlNB3Jy/VgKZ
        grAPE58pYMUkC+m19iU9JbBET5hX
X-Google-Smtp-Source: ABdhPJzeIxESWHNY04ffG0WOzIM5V3Um2k1FLGzw8boN2bwttSILAawUyDPH9291LsVvJulY8iqoYA==
X-Received: by 2002:a5d:4202:: with SMTP id n2mr33562615wrq.171.1593747511751;
        Thu, 02 Jul 2020 20:38:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v6sm191330wrr.85.2020.07.02.20.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 20:38:31 -0700 (PDT)
Message-Id: <daf00d9398f0bc094272f5b97aa1220fd573db9a.1593747509.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.590.v2.git.1593747509.gitgitgadget@gmail.com>
References: <pull.590.git.1585429894378.gitgitgadget@gmail.com>
        <pull.590.v2.git.1593747509.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Jul 2020 03:38:27 +0000
Subject: [PATCH v2 2/4] git-rev-list.txt: move description to separate file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Lawrence Siebert <lawrencesiebert@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

A following commit will reuse the description of the `git rev-list`
command in the `git log` manpage.

Move this description to a separate file.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/git-rev-list.txt         | 39 +-------------------------
 Documentation/rev-list-description.txt | 38 +++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/rev-list-description.txt

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 025c911436..b06e11ae56 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -14,44 +14,7 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-List commits that are reachable by following the `parent` links from the
-given commit(s), but exclude commits that are reachable from the one(s)
-given with a '{caret}' in front of them.  The output is given in reverse
-chronological order by default.
-
-You can think of this as a set operation.  Commits given on the command
-line form a set of commits that are reachable from any of them, and then
-commits reachable from any of the ones given with '{caret}' in front are
-subtracted from that set.  The remaining commits are what comes out in the
-command's output.  Various other options and paths parameters can be used
-to further limit the result.
-
-Thus, the following command:
-
------------------------------------------------------------------------
-	$ git rev-list foo bar ^baz
------------------------------------------------------------------------
-
-means "list all the commits which are reachable from 'foo' or 'bar', but
-not from 'baz'".
-
-A special notation "'<commit1>'..'<commit2>'" can be used as a
-short-hand for "{caret}'<commit1>' '<commit2>'". For example, either of
-the following may be used interchangeably:
-
------------------------------------------------------------------------
-	$ git rev-list origin..HEAD
-	$ git rev-list HEAD ^origin
------------------------------------------------------------------------
-
-Another special notation is "'<commit1>'...'<commit2>'" which is useful
-for merges.  The resulting set of commits is the symmetric difference
-between the two operands.  The following two commands are equivalent:
-
------------------------------------------------------------------------
-	$ git rev-list A B --not $(git merge-base --all A B)
-	$ git rev-list A...B
------------------------------------------------------------------------
+include::rev-list-description.txt[]
 
 'rev-list' is a very essential Git command, since it
 provides the ability to build and traverse commit ancestry graphs. For
diff --git a/Documentation/rev-list-description.txt b/Documentation/rev-list-description.txt
new file mode 100644
index 0000000000..aa6bbd8cec
--- /dev/null
+++ b/Documentation/rev-list-description.txt
@@ -0,0 +1,38 @@
+List commits that are reachable by following the `parent` links from the
+given commit(s), but exclude commits that are reachable from the one(s)
+given with a '{caret}' in front of them.  The output is given in reverse
+chronological order by default.
+
+You can think of this as a set operation.  Commits given on the command
+line form a set of commits that are reachable from any of them, and then
+commits reachable from any of the ones given with '{caret}' in front are
+subtracted from that set.  The remaining commits are what comes out in the
+command's output.  Various other options and paths parameters can be used
+to further limit the result.
+
+Thus, the following command:
+
+-----------------------------------------------------------------------
+	$ git rev-list foo bar ^baz
+-----------------------------------------------------------------------
+
+means "list all the commits which are reachable from 'foo' or 'bar', but
+not from 'baz'".
+
+A special notation "'<commit1>'..'<commit2>'" can be used as a
+short-hand for "{caret}'<commit1>' '<commit2>'". For example, either of
+the following may be used interchangeably:
+
+-----------------------------------------------------------------------
+	$ git rev-list origin..HEAD
+	$ git rev-list HEAD ^origin
+-----------------------------------------------------------------------
+
+Another special notation is "'<commit1>'...'<commit2>'" which is useful
+for merges.  The resulting set of commits is the symmetric difference
+between the two operands.  The following two commands are equivalent:
+
+-----------------------------------------------------------------------
+	$ git rev-list A B --not $(git merge-base --all A B)
+	$ git rev-list A...B
+-----------------------------------------------------------------------
-- 
gitgitgadget

