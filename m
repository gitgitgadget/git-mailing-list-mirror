Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D32C6FD1C
	for <git@archiver.kernel.org>; Sun, 26 Mar 2023 03:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjCZDJz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Mar 2023 23:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjCZDJu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2023 23:09:50 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64AAA241
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 20:09:46 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso5459235pjb.3
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 20:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679800186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mG0Eh42iXR92/z6npu4aNTODQkar2R2pkU5LgoUXoUQ=;
        b=NWyYxC0QhlcAnHL98CC2VsHb301kVpd2lXvJmX4hhe1Mg1gIXQj+9dvApF2djAE88J
         NNA1MKtCnQ5Dk44SSTGLmJW1NJCBD2z1QCmzs/YMd7r/eyu/EFcAaJ49W2faipyPs1QT
         5wT0DWu85krBhxXlJ6JO1FUSup9xilQMWC+0UtVwSktQmI3naAHlp01O+17ml4IfPwNv
         AZQgEUfgH7AdnTUaaO9kSak2ccJBmFBLpbh6vPnKomWNuNyag8D6EJY+MEj+9SkhIQDt
         rEtcwzHolGj8KsSxL6f7jmGTsLXZZQTJk5v/e7fVC8YTgrGSNaK2ir9Psx9GaIoj55OF
         Mapw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679800186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mG0Eh42iXR92/z6npu4aNTODQkar2R2pkU5LgoUXoUQ=;
        b=iaPYJKef23YtXJM/OpYp4OPg6z6PbaVdf8Aio4JRw6yOPC/cVLBb/TUOo+CCC2u992
         +hKEYyoe7k1jpWAYsM9g9tGOhxN2wVm67ZlpS4yUy2DaChlA12J5qKUAUl8UQ7XBIOpE
         UjSoLf+1fkJKkeDSTAKn9mzNFDvhs0nkwiwDlb3U1NA12pJJCsDB9b+vDkjL8ksZpJMl
         MgWiwDaUW3pl3a1ODkXTEBq/SB4kORuCW0gHvWZ6mdia6gR3OcLyvSr7jm3KGhiV2Dk6
         KkE709JM/+o1UfLdvdV7sfsHsgWXn5uiWrKUmOzMsXgF2iIlfQSzTXVecFKfJt3cCWd7
         aeNg==
X-Gm-Message-State: AAQBX9fh55Rdy6AJbaYU8HwaBf3oJBRMNP9toqGJK4/XzclJ8mxwkL3p
        Ft1A75WZ9ooX9tJDBUDOy6LUXZOkXCjtMg==
X-Google-Smtp-Source: AKy350Y7iKfEVQiPjb9V0sTuTZ/5E9ncYPmj75Y/AVtbThKPKMClRC0Di6cTPR72D2O4o4h2gY7TJQ==
X-Received: by 2002:a17:902:e801:b0:1a0:53b8:907f with SMTP id u1-20020a170902e80100b001a053b8907fmr9234707plg.17.1679800186116;
        Sat, 25 Mar 2023 20:09:46 -0700 (PDT)
Received: from xavier.hsd1.ut.comcast.net ([2601:681:897e:74d0::de86])
        by smtp.gmail.com with ESMTPSA id x17-20020a170902ea9100b001a1c00317b0sm13587929plb.273.2023.03.25.20.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 20:09:45 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, sorganov@gmail.com,
        chooglen@google.com, calvinwan@google.com,
        jonathantanmy@google.com, felipe.contreras@gmail.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v9 1/3] rebase: add documentation and test for --no-rebase-merges
Date:   Sat, 25 Mar 2023 21:06:34 -0600
Message-Id: <20230326030636.2635642-2-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230326030636.2635642-1-alexhenrie24@gmail.com>
References: <20230320055955.461138-1-alexhenrie24@gmail.com>
 <20230326030636.2635642-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As far as I can tell, --no-rebase-merges has always worked, but has
never been documented. It is especially important to document it before
a rebase.rebaseMerges option is introduced so that users know how to
override the config option on the command line. It's also important to
clarify that --rebase-merges without an argument is not the same as
--no-rebase-merges and not passing --rebase-merges is not the same as
passing --rebase-merges=no-rebase-cousins.

A test case is necessary to make sure that --no-rebase-merges keeps
working after its code is refactored in the following patches of this
series. The test case is a little contrived: It's unlikely that a user
would type both --rebase-merges and --no-rebase-merges at the same time.
However, if an alias is defined which includes --rebase-merges, the user
might decide to add --no-rebase-merges to countermand that part of the
alias but leave alone other flags set by the alias.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 Documentation/git-rebase.txt | 18 +++++++++++-------
 t/t3430-rebase-merges.sh     | 10 ++++++++++
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 9a295bcee4..4e57a87624 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -529,20 +529,24 @@ See also INCOMPATIBLE OPTIONS below.
 
 -r::
 --rebase-merges[=(rebase-cousins|no-rebase-cousins)]::
+--no-rebase-merges::
 	By default, a rebase will simply drop merge commits from the todo
 	list, and put the rebased commits into a single, linear branch.
 	With `--rebase-merges`, the rebase will instead try to preserve
 	the branching structure within the commits that are to be rebased,
 	by recreating the merge commits. Any resolved merge conflicts or
 	manual amendments in these merge commits will have to be
-	resolved/re-applied manually.
+	resolved/re-applied manually. `--no-rebase-merges` can be used to
+	countermand a previous `--rebase-merges`.
 +
-By default, or when `no-rebase-cousins` was specified, commits which do not
-have `<upstream>` as direct ancestor will keep their original branch point,
-i.e. commits that would be excluded by linkgit:git-log[1]'s
-`--ancestry-path` option will keep their original ancestry by default. If
-the `rebase-cousins` mode is turned on, such commits are instead rebased
-onto `<upstream>` (or `<onto>`, if specified).
+When rebasing merges, there are two modes: `rebase-cousins` and
+`no-rebase-cousins`. If the mode is not specified, it defaults to
+`no-rebase-cousins`. In `no-rebase-cousins` mode, commits which do not have
+`<upstream>` as direct ancestor will keep their original branch point, i.e.
+commits that would be excluded by linkgit:git-log[1]'s `--ancestry-path`
+option will keep their original ancestry by default. In `rebase-cousins` mode,
+such commits are instead rebased onto `<upstream>` (or `<onto>`, if
+specified).
 +
 It is currently only possible to recreate the merge commits using the
 `ort` merge strategy; different merge strategies can be used only via
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index fa2a06c19f..d46d9545f2 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -250,6 +250,16 @@ test_expect_success 'with a branch tip that was cherry-picked already' '
 	EOF
 '
 
+test_expect_success '--no-rebase-merges countermands --rebase-merges' '
+	git checkout -b no-rebase-merges E &&
+	git rebase --rebase-merges --no-rebase-merges C &&
+	test_cmp_graph C.. <<-\EOF
+	* B
+	* D
+	o C
+	EOF
+'
+
 test_expect_success 'do not rebase cousins unless asked for' '
 	git checkout -b cousins main &&
 	before="$(git rev-parse --verify HEAD)" &&
-- 
2.40.0

