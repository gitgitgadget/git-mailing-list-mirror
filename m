Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBBDC433DF
	for <git@archiver.kernel.org>; Mon, 25 May 2020 21:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF6AF206C3
	for <git@archiver.kernel.org>; Mon, 25 May 2020 21:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tAJ5WgPb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbgEYVDB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 17:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbgEYVDB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 May 2020 17:03:01 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F16BC061A0E
        for <git@vger.kernel.org>; Mon, 25 May 2020 14:03:01 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id n18so9215647pfa.2
        for <git@vger.kernel.org>; Mon, 25 May 2020 14:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UIHpXssmDVVcM/484RjL9Q6WVV8+3i+X8fkwAu8UC9w=;
        b=tAJ5WgPbLEv1evrmvF560ZGHv4rZvy8YwXCKcxmm/wCm3MLmZ5xlbM1iYAJKktp3dF
         bsexlweC6eWdbJ+yNOEOYcGWFcarHuKQZ/u4JRNj5YDOO8oDiVaUhiwEpH/MRRsVBKDI
         FuCo5aWfXDOtPvpHEzbWBFbm9Ucvzj393jY8yiybkgH+JMmCexCpHRF1IBk2OjeJDve+
         quBPncsNEobyMaWrGY0oAr3ZxlEBE37sRvsKUmgyNQ8jBe2YrIiqJAfufLz3/s7Gw/+m
         pFgfzP70xTG9rFu+e8x0Oy40WFSLlIdHrwP22G3OuloGXKQFrPHW377zsWY/SDwZa5hK
         jmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UIHpXssmDVVcM/484RjL9Q6WVV8+3i+X8fkwAu8UC9w=;
        b=mcLSit8zW0o/zggQ/pgXKh77FwBYuQFHTeVOR1eVqVM/KLrfW+anZ92AGYT/vSW8NR
         OoiymMI1m9r52zF8ZrBaByZwHIbfHfIjSMAe7vCjJqQwWsWJ0lBpe81dtYfn/0n4jb4F
         aefxyEPeDQNrsAz9Nmbr4qHu4YkGEkhYTAb7bQTJP2VwYurUG31MDvgb1rHh2th4QwFJ
         S9zIZ2oZIyz9ki4/szd3QrwUOm4a8ydHY6q4hCmf3nWJsYpdOoeTBUHkNameF1XccgVb
         z5ocQSMexmsDh4x7qzcqhYzg9mJXr84cJcBLfxrgnAjZDpp3gdroRnhSAG336NQlw1A9
         /+kA==
X-Gm-Message-State: AOAM531cMgAqUIwPP+5ZiBUX+j5PHiWa4OTsg4SgaXATZtLy25wWShpc
        JfRmDldKhRcuwPUJaLf1ckkqemxb
X-Google-Smtp-Source: ABdhPJw+xCH26N0MC9iuYpT+UDpyEvsWuKSRJRvXtffkciWOxi6TT042TAygeoZUpTptvYi0EXrUWg==
X-Received: by 2002:aa7:973b:: with SMTP id k27mr18165113pfg.219.1590440580464;
        Mon, 25 May 2020 14:03:00 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id b5sm13146758pju.50.2020.05.25.14.02.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 May 2020 14:02:59 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     hanwen@google.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] reftable: technical documentation link fixes
Date:   Mon, 25 May 2020 14:02:32 -0700
Message-Id: <20200525210232.87550-1-carenas@gmail.com>
X-Mailer: git-send-email 2.27.0.rc1.264.g59ed0186f2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Showing as broken links in the html version (when using asciidoc 8.6.10)
because some of the characters in the url need encoding.

Change them to use a explicit "link" and URL encode the problematic
charecters (ex: +, =, @).  While at it, change the base URL to use
lore.kernel.org as has been suggested since 56e6c16394 (Merge branch
'dl/lore-is-the-archive', 2019-12-06)

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 Documentation/technical/reftable.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/reftable.txt b/Documentation/technical/reftable.txt
index 6eae449685..2951840e9c 100644
--- a/Documentation/technical/reftable.txt
+++ b/Documentation/technical/reftable.txt
@@ -1028,7 +1028,7 @@ Michael Haggerty's alternate format
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 Michael Haggerty proposed
-https://public-inbox.org/git/CAMy9T_HCnyc1g8XWOOWhe7nN0aEFyyBskV2aOMb_fe+wGvEJ7A@mail.gmail.com/[an
+link:https://lore.kernel.org/git/CAMy9T_HCnyc1g8XWOOWhe7nN0aEFyyBskV2aOMb_fe%2BwGvEJ7A%40mail.gmail.com/[an
 alternate] format to reftable on the Git mailing list. This format uses
 smaller chunks, without the restart table, and avoids block alignment
 with padding. Reflog entries immediately follow each ref, and are thus
@@ -1050,7 +1050,7 @@ JGit Ketch RefTree
 
 https://dev.eclipse.org/mhonarc/lists/jgit-dev/msg03073.html[JGit Ketch]
 proposed
-https://public-inbox.org/git/CAJo=hJvnAPNAdDcAAwAvU9C4RVeQdoS3Ev9WTguHx4fD0V_nOg@mail.gmail.com/[RefTree],
+link:https://lore.kernel.org/git/CAJo%3DhJvnAPNAdDcAAwAvU9C4RVeQdoS3Ev9WTguHx4fD0V_nOg%40mail.gmail.com/[RefTree],
 an encoding of references inside Git tree objects stored as part of the
 repository's object database.
 
@@ -1070,7 +1070,7 @@ LMDB
 ^^^^
 
 David Turner proposed
-https://public-inbox.org/git/1455772670-21142-26-git-send-email-dturner@twopensource.com/[using
+https://lore.kernel.org/git/1455772670-21142-26-git-send-email-dturner@twopensource.com/[using
 LMDB], as LMDB is lightweight (64k of runtime code) and GPL-compatible
 license.
 
-- 
2.27.0.rc1.264.g59ed0186f2

