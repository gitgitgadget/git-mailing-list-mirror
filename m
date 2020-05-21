Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB60C433E0
	for <git@archiver.kernel.org>; Thu, 21 May 2020 16:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8735A2083E
	for <git@archiver.kernel.org>; Thu, 21 May 2020 16:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fyqwo2kn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbgEUQfD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 12:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgEUQfD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 12:35:03 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F93EC061A0E
        for <git@vger.kernel.org>; Thu, 21 May 2020 09:35:03 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d3so3049743pln.1
        for <git@vger.kernel.org>; Thu, 21 May 2020 09:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ifxvNzW9/AYFJNH+4+Kf5Pxab4EIWk3gM3bk4/ie0Vs=;
        b=Fyqwo2knf6QUxsrvOXQSPprmGbiqmOD/hsZwcdnlySmV5rt5M3FmZSW7m8gLfPbUpI
         1Xy/O1+MKmsqIyHi16Ucg/yIdqL7E9mkhXo6jfkObaNz/7wzNgr4ObqQxwar8e9v86pV
         2AIoX8f8x7izaLwH3/Mpm53aEnsXoW4w/EsfWZC68hRrWHXqa5D7yPih9if6OFDX2POB
         MdlulBqTfB208Qq0jWfPNzcy1NpR5v6hKETVZn1DOmJY4GS3GRlYNni5SOQQc5THa8iO
         S0BdKpzgOQ0mi3gPOrdnf22lrK7Z9v1xsoP5+dYDpgMjXu94+7fEC+320EFa8LWXGKhF
         M1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ifxvNzW9/AYFJNH+4+Kf5Pxab4EIWk3gM3bk4/ie0Vs=;
        b=QlLi8CX0PUgLflay31fCX5rzCWkDZDGj2HwzbJB/Sum3jkYCubZB9KuPH9J2NpNOle
         A8ii4sVDFqp2N6lnHfug5VxCKNsqQyftviXC+IQdhSAAbJl14pqwGtDoFNgMzClAGHMu
         L11cCa4GkMhGBNKS2Yrih4J9N18AQ5LeSqrkDTxG/HEua7Mhkqcii0k/7HJjzm9VArXf
         dzGvfYs0GhkXLqXVAsGUSb3od7nUZ2r9MgeHLU3oUlAw+f3SL67lOSFY4neXVbQmUL9r
         RSSpv6DmGaKkDCa3ZEv5GdU9QU7vKrCAwrNVxCTJelSZIASqw5iTlsuDHV2RN3PTGHX2
         UCIg==
X-Gm-Message-State: AOAM5316xPEYcfBIdNOO2A0H8igBK0s2eW8C8Nn+FCzfuKdfUkNYV9Zd
        1+kg03vfkzBf68Dby/FxJw03Sxoa
X-Google-Smtp-Source: ABdhPJxKuI452RnffWb8ywJ26uZKZa6vocZsy3gH3J0eJJ7DPVuROVUfSYY+rm5nIaf6iAJUlorj2A==
X-Received: by 2002:a17:902:9049:: with SMTP id w9mr10642088plz.27.1590078902241;
        Thu, 21 May 2020 09:35:02 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id m5sm4605591pjn.56.2020.05.21.09.35.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2020 09:35:01 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     mirucam@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] git-bisect: remove no longer needed variables
Date:   Thu, 21 May 2020 09:34:49 -0700
Message-Id: <20200521163449.36108-1-carenas@gmail.com>
X-Mailer: git-send-email 2.27.0.rc1.181.g8d5cacc8d1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With the original functionality moved to bisect--helper there is no need
for them in git-bisect.sh anymore.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 git-bisect.sh | 34 ----------------------------------
 1 file changed, 34 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 2da0810b1a..d6debcbb87 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -1,41 +1,7 @@
 #!/bin/sh
 
-USAGE='[help|start|bad|good|new|old|terms|skip|next|reset|visualize|view|replay|log|run]'
-LONG_USAGE='git bisect help
-	print this long help message.
-git bisect start [--term-{old,good}=<term> --term-{new,bad}=<term>]
-		 [--no-checkout] [<bad> [<good>...]] [--] [<pathspec>...]
-	reset bisect state and start bisection.
-git bisect (bad|new) [<rev>]
-	mark <rev> a known-bad revision/
-		a revision after change in a given property.
-git bisect (good|old) [<rev>...]
-	mark <rev>... known-good revisions/
-		revisions before change in a given property.
-git bisect terms [--term-good | --term-bad]
-	show the terms used for old and new commits (default: bad, good)
-git bisect skip [(<rev>|<range>)...]
-	mark <rev>... untestable revisions.
-git bisect next
-	find next bisection to test and check it out.
-git bisect reset [<commit>]
-	finish bisection search and go back to commit.
-git bisect (visualize|view)
-	show bisect status in gitk.
-git bisect replay <logfile>
-	replay bisection log.
-git bisect log
-	show bisect log.
-git bisect run <cmd>...
-	use <cmd>... to automatically bisect.
-
-Please use "git help bisect" to get the full man page.'
-
-OPTIONS_SPEC=
 . git-sh-setup
 
-_x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
-_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 TERM_BAD=bad
 TERM_GOOD=good
 

base-commit: 011eca7cfdb7f13ee285c00dfe9ea576ec1166a7
-- 
2.27.0.rc1.181.g8d5cacc8d1

