Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4754C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 05:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0B9320757
	for <git@archiver.kernel.org>; Mon,  4 May 2020 05:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pHPsjr7P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgEDFmg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 01:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgEDFmg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 01:42:36 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2DFC061A0E
        for <git@vger.kernel.org>; Sun,  3 May 2020 22:42:36 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id w3so6362970plz.5
        for <git@vger.kernel.org>; Sun, 03 May 2020 22:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HL2n4lZj2wcpnouSt9BP2Xi3Qb9iXbCROFPe7Fg3N50=;
        b=pHPsjr7PaJt4noy9RhqzX2J0YSmsqQRXCPjJUyvkDHoYzv6VtkaX1k2xA37JObB7sH
         30AX0V8rHgG5IPi8nC30tdCvs/nvC5IEmKPxSSYUlOBz9BZYKnV/65dElvjuyTxoaS9w
         td8oy7CiiUsGpMuHrRydK5gjWzXVs0uH3T2pvITRoWnRTGG+r19mp37NU+1lkjAFXb56
         sX3yZo8YMdPIpbP2wX319WAGmKltmkAKVUXelQjHiXX0Mr8XsO4r7389TnjLqfN3dOW4
         cBrlh9UTKJhwNhpRFrAZ8V+Bjgt/+6+yHDGp+RFtdDStxPK1KwgEknqH/89VrSq7rnti
         FRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HL2n4lZj2wcpnouSt9BP2Xi3Qb9iXbCROFPe7Fg3N50=;
        b=tjWmReUdIbpl5Tm2ldlD5JepxBZ4EnT0ZSPoFoDqcRUz5LeGy0kz2VjD6bnMvijABO
         9Qj+r2HlD6/2fU+zub+C5xYT7bLsyBHxVhrn9III5Orm1Z0UA/CL6toZ1BddcShSayiB
         0z7yeVpM3h4KzbFbajKKvuNceowrwAQ6Tz/V192TQgXZFNiR6YkgIgbB2cMQA37NZsvL
         CfiOG9DLxDkXFTTKNm/Ex2iiPY4CKYHdg3H2J10MQt0vFCFbN9Wa7Pj8pcftS08QzETS
         ClDHh1zmulH5Tz3YJqo1YV5WoLj8c9LBzKC8iaZvBJ8x9DtnF28jElpIL3nmEsqBYKw9
         KZPg==
X-Gm-Message-State: AGi0PuYD0C32p/NJUOzUnwZ90deKSGzem5yc3uL7FbPNqIOWGq6yh7JO
        3C52PQ0KpmT0oNvJhPVlR/tAbzo5h00=
X-Google-Smtp-Source: APiQypKSQM17KbZFbxGxIJp7VOWQ0TcDuEkbJxkZdozzls2BPztG+lbsYwghlYE4ICgPcxKYs+9f2w==
X-Received: by 2002:a17:90a:37c4:: with SMTP id v62mr14588855pjb.177.1588570955237;
        Sun, 03 May 2020 22:42:35 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.176])
        by smtp.gmail.com with ESMTPSA id 189sm7850785pfd.55.2020.05.03.22.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 22:42:34 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, newren@gmail.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH v5 2/4] gitfaq: changing the remote of a repository
Date:   Mon,  4 May 2020 11:12:21 +0530
Message-Id: <20200504054223.11125-2-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504054223.11125-1-shouryashukla.oo@gmail.com>
References: <20200504054223.11125-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add issue in 'Common Issues' section which addresses the problem of
changing the remote of a repository, covering various cases in which
one might want to change the remote and the ways to do the same.

Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 Documentation/gitfaq.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
index 11d9bac859..875cfa0acd 100644
--- a/Documentation/gitfaq.txt
+++ b/Documentation/gitfaq.txt
@@ -233,6 +233,17 @@ I asked Git to ignore various files, yet they are still tracked::
 	and add a pattern to `.gitignore` that matches the <file>.
 	See linkgit:gitignore[5] for details.
 
+[[changing-remote-of-the-repository]]
+I want to change the remote of my repository. How do I do that?::
+	A remote is an identifier for a location to which Git pushes your
+	changes as well as fetches any new changes from (if any).  There
+	might be different circumstances in which one might need to change
+	the remote URL (see linkgit:git-remote[1]).  To change the remote URL
+	one may use: git remote set-url <name> <newurl>
++
+One can list the remotes of a repository using `git remote -v` command.
+The default name of a remote is 'origin'.
+
 Hooks
 -----
 
-- 
2.26.2

