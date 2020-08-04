Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C28C433E3
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 00:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37AC6206DA
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 00:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXQp0GvO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgHDA4d (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 20:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728662AbgHDA4c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 20:56:32 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2648FC06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 17:56:32 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id j8so28149131ioe.9
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 17:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZrC8wLBIFYwitVitQ/ZS+YEFjZy+3oYRMK+2UsGUmoA=;
        b=LXQp0GvOo/LgFIjVqmJUhSKE8FEnWaiZRYwKDe+c21LorepuBZpfUHgy0a4/vVIF/h
         UQfATAt5OohYaBGvCp7nnspfE+2RchMj/SQJF1LgFT66ZXV8lz5mLML8GCJ+bTLvOzIr
         dJw5SUmHLQ28/tyIeV66dfmVAGqXcNR8z6TpDsQ4B7C0yV3wgTaa8dMybCDgZlSq5dik
         HqdsUUPmVQXdkP1aREik6XqD9Tfhz/vDq8UyEtdT5Iz5T10ujbKq9n6gBy9hJPwBpA+N
         MsiWEE6ypZ7m+rXNEz4rMc+zkiphxJGHCfe5JCSK13CdLb1mNHFaduhWtNsga1cdSW6/
         uqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ZrC8wLBIFYwitVitQ/ZS+YEFjZy+3oYRMK+2UsGUmoA=;
        b=F3GEgev8SyhSxGkgJR07lOOqx4VDpcnAP8cuZ7/CCKSxEqnoZZ1/2a6Ognwu7ZbJiF
         5k384VdbMfqrdOnQUG1+0i7P3uZd1k50rqPbHhwdU3HOGmRRkakiBj1mHclaMO8VjYXF
         d1ldiS+W/sRWCchD1Ol+8wPKe89TmqJRCUyEcYpvrQzljhgdd8zP5aJ1SLUYiT9aiC3h
         RJWnaqS1xE+e0HvQdQCq4d8hc9qZqOZ1j0R/GUe+dQEDyxepApApDqpKNPeUOS2jisKh
         dCd4Z8PIB+/BIU7G5RJmzDnOpXxrd08qAbfzMhFi61FFAgXYM81u0RLhQZs4ibb1H3y7
         UyFg==
X-Gm-Message-State: AOAM533i65+74eugRP6PnZXahaN3RAOcf24OukmxHu5RFf/wO1aHqeo9
        geUbCZb/hfryWoqkhtHmXs95fNuGr/I=
X-Google-Smtp-Source: ABdhPJx6bO/7K9KX80jRKp09qHmZw3+Wg0gBOSaEyx3wxU7RGomt46OAQeznR67Q9V54xZDCsYaOPg==
X-Received: by 2002:a6b:c504:: with SMTP id v4mr2680560iof.20.1596502591206;
        Mon, 03 Aug 2020 17:56:31 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id e84sm11878453ill.60.2020.08.03.17.56.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Aug 2020 17:56:30 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 5/5] git-wortkree.txt: link to man pages when citing other Git commands
Date:   Mon,  3 Aug 2020 20:55:35 -0400
Message-Id: <20200804005535.5126-6-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966
In-Reply-To: <20200804005535.5126-1-sunshine@sunshineco.com>
References: <20200803053612.50095-1-sunshine@sunshineco.com>
 <20200804005535.5126-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When citing other Git commands, rather than merely formatting them with
a fixed-width typeface, improve the reader experience by linking to them
directly via `linkgit:`.

Suggested-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-worktree.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 544464f949..6ee6ec7982 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -25,8 +25,9 @@ Manage multiple working trees attached to the same repository.
 A git repository can support multiple working trees, allowing you to check
 out more than one branch at a time.  With `git worktree add` a new working
 tree is associated with the repository.  This new working tree is called a
-"linked working tree" as opposed to the "main working tree" prepared by `git
-init` or `git clone`.  A repository has one main working tree (if it's not a
+"linked working tree" as opposed to the "main working tree" prepared by
+linkgit:git-init[1] or linkgit:git-clone[1].
+A repository has one main working tree (if it's not a
 bare repository) and zero or more linked working trees. When you are done
 with a linked working tree, remove it with `git worktree remove`.
 
-- 
2.28.0.236.gb10cc79966

