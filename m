Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0A9EB64DD
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 19:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbjGETuO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 15:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbjGETuK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 15:50:10 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AE01730
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 12:50:09 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b70404a5a0so3617131fa.2
        for <git@vger.kernel.org>; Wed, 05 Jul 2023 12:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688586607; x=1691178607;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xyZb0C9xsOze/kPweG6JBte8PhjiNbbjV6r/bHkkyW0=;
        b=bCmKg6RAX4XT4IGb7Q5gyB72tc08+BC3FA/4rkyb2uwRf2jGa+PIi+jil44d/3wTTc
         dTqT61Cj+jtb0SPk1EYThs063IXHO+PGF57C4wUFrgAcSenyDUsiSVI2CkjazeHAFd8o
         mB19OTQb6Uz/0YztRxg1YDg2cqvVrCNZ1w4PR6ivFp7PzkpSxrKpguuC/zogz4RMGUdd
         Zk8DjvORHCgpb+BMrcM7OarDp3iJNr3mKpERp1Id/V0EN0ZTl7orS7bffhqj/iaeBNGa
         RdpnMrf5MWp8DwO9dqk01YnRR8KWsFHDLeVaR0XmoZtrcsG+sps3eAC+zy+dErVsuGTe
         Bxmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688586607; x=1691178607;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xyZb0C9xsOze/kPweG6JBte8PhjiNbbjV6r/bHkkyW0=;
        b=jJIEt6m8LALCJucr8uli3Fuyjym1W9wHLZB626fj2iLxucd5W4VpqPvF8sGmUtnWd5
         qNd3aIg8rwB8lEbDc6gXQ56IJC0lmmXtNrAG4LZyZXP5rtZOtVH7Uc7o/GmCw+YG0vZb
         7Soi+gftFPAevVWxO67L7gNClpGuhsTxzHxAnrwQToM2bcprcFYQaZ4oMVea08rpMAwq
         osT2NtdHFiJzP3n6wAerIH4ufw+sES2+DBVDJ0pNtq1bmhpv/W+EYqi8hY8xtE59RB/G
         JHIJSBA+g7yJHQuKv4PVgtUDI2T48vk6vHHmBvqsAIOyFhZlUjhCLyeiPAng/iZBtD3p
         OySA==
X-Gm-Message-State: ABy/qLbAG0iF4wcz6lr8qdeJxLbQF1nBjEqU/bKW7rELqbZ6m6hZ5gMW
        UMfXIniZW0y1+Qo07sv2DjOZREI80Js=
X-Google-Smtp-Source: APBJJlHm+qFUEG+gknW328xI2Z+Emy8afIhkJjzXfkbMviF4NyCeFSWUKnMhYiP0Y97Ubj3I3D8V4g==
X-Received: by 2002:a2e:b0d6:0:b0:2b6:fc88:3ee7 with SMTP id g22-20020a2eb0d6000000b002b6fc883ee7mr3537883ljl.13.1688586607136;
        Wed, 05 Jul 2023 12:50:07 -0700 (PDT)
Received: from localhost.localdomain ([90.242.235.211])
        by smtp.gmail.com with ESMTPSA id bx1-20020a170906a1c100b00992665694f7sm10078341ejb.107.2023.07.05.12.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 12:50:06 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Thomas Guyot-Sionnest <tguyot@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 1/4] diff --no-index: refuse to compare stdin to a directory
Date:   Wed,  5 Jul 2023 20:49:27 +0100
Message-ID: <5e65a15223bc42293516308eb31ade5395609c55.1688586536.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.40.1.852.g0a1e0755a6
In-Reply-To: <cover.1688586536.git.phillip.wood@dunelm.org.uk>
References: <cover.1687874975.git.phillip.wood@dunelm.org.uk> <cover.1688586536.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When the user runs

    git diff --no-index file directory

we follow the behavior of POSIX diff and rewrite the arguments as

    git diff --no-index file directory/file

Doing that when "file" is "-" (which means "read from stdin") does not
make sense so we should error out if the user asks us to compare "-" to
a directory. This matches the behavior of GNU diff and diff on *BSD.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff-no-index.c          | 12 +++++++-----
 t/t4053-diff-no-index.sh |  5 +++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 4296940f90..77462ac2a9 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -218,11 +218,13 @@ static void fixup_paths(const char **path, struct strbuf *replacement)
 {
 	unsigned int isdir0, isdir1;
 
-	if (path[0] == file_from_standard_input ||
-	    path[1] == file_from_standard_input)
-		return;
-	isdir0 = is_directory(path[0]);
-	isdir1 = is_directory(path[1]);
+	isdir0 = path[0] != file_from_standard_input && is_directory(path[0]);
+	isdir1 = path[1] != file_from_standard_input && is_directory(path[1]);
+
+	if ((path[0] == file_from_standard_input && isdir1) ||
+	    (isdir0 && path[1] == file_from_standard_input))
+		die(_("cannot compare stdin to a directory"));
+
 	if (isdir0 == isdir1)
 		return;
 	if (isdir0) {
diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
index 4e9fa0403d..5bfb282e98 100755
--- a/t/t4053-diff-no-index.sh
+++ b/t/t4053-diff-no-index.sh
@@ -205,4 +205,9 @@ test_expect_success POSIXPERM,SYMLINKS 'diff --no-index normalizes: mode not lik
 	test_cmp expected actual
 '
 
+test_expect_success 'diff --no-index refuses to diff stdin and a directory' '
+	test_must_fail git diff --no-index -- - a </dev/null 2>err &&
+	grep "fatal: cannot compare stdin to a directory" err
+'
+
 test_done
-- 
2.40.1.852.g0a1e0755a6

