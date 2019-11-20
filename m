Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4B1C432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 00:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851F82245B
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 00:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEqGo7K2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfKTAvJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 19:51:09 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38556 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfKTAvJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 19:51:09 -0500
Received: by mail-pl1-f195.google.com with SMTP id q18so9230931pls.5
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 16:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s6yIMb3y3tBujvAvtyNre5XgHYtGVViRTmPByOWX3KQ=;
        b=cEqGo7K2MWW/7Uk+UhMLOhU5vxHKv16qShtm9nl4JboTDnfd5+OJvbiTPNpeKgLu11
         NUaezwysgVVxm4YxEHCV6h1UtPYEB3MeyMxSbkSVkmpf5oXWPWLYfca4oCCRHfTyizb0
         f/zYtpYpeCend8U/5UYkxc0yI0qEnjYlx4TLtzRRCdeIxii4CZ/SmgDubR42cJUFCg4p
         a1WAcu5ibN1Z2C1AhCCaIzK3GKJLfmmGzC76rAo30DY/PHX/ijZfbDbO9TGTjFzrItbo
         xdP6pGNhtGHUUcJvaarlh6m53ReFwqySfZJpp5AZwzsY1NNNotwO390UFsZc+F9EoT6G
         Gm3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s6yIMb3y3tBujvAvtyNre5XgHYtGVViRTmPByOWX3KQ=;
        b=NEZrB7ZkADVYA/ZetpIeiPVSlZHWrdow+Ati7yZErMgVOBa5zyW+NisQeZkyihECbW
         Ahf8vJs8tLHDoJ0lweIuILq/3p5XoUMwOIwz14Wux/evTFCs6mBzamgfeCQ9zMrgf9bA
         pnm3OADR0fAW0SivzEQ3Br0QTmh9hrzp7qoVYS3mNptf8J4FsCNuUUlwGYB3lzsPe06R
         Hbm421b3ZZuWrbVfw1SrHnBkUZYC4p4eXXGYZx36gA/8XNciKK+OhT88rpEdI7tmF3uK
         JoMNku0ZSRCG1zGVPGuoC1ZJClRxhRywT5kW2qvRr0zbZg5JKZM3n3uQAQKWyJjHcNhs
         vQSg==
X-Gm-Message-State: APjAAAXIuoTv7AcDxL934O16tf42gvuy4SIYbsXsBkXHgSQbTziSSCxw
        huWU9DEs6WI7krbYs2REK6eAn/qI
X-Google-Smtp-Source: APXvYqwTgdMZ04pBYAzBk7n9yWueWcKLL5VTE/ThxGmDVUFH+Yp7PrVU2vo5sZe9w2SsUIqSKTSeHw==
X-Received: by 2002:a17:902:aa95:: with SMTP id d21mr124795plr.182.1574211068409;
        Tue, 19 Nov 2019 16:51:08 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id a25sm26403233pff.50.2019.11.19.16.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 16:51:07 -0800 (PST)
Date:   Tue, 19 Nov 2019 16:51:06 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Todd Zullinger <tmz@pobox.com>
Subject: [PATCH v5 02/11] pretty-formats.txt: use generic terms for hash
Message-ID: <badd3d4275b1a235c95f671ca3f46fd7bee6bfec.1574211027.git.liu.denton@gmail.com>
References: <cover.1574122784.git.liu.denton@gmail.com>
 <cover.1574211027.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574211027.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since Git is planning on upgrading from SHA-1 to be more hash-agnostic,
replace specific references to SHA-1 with more generic terminology.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/pretty-formats.txt | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 079598307a..fdccfe5b03 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -4,7 +4,7 @@ PRETTY FORMATS
 If the commit is a merge, and if the pretty-format
 is not 'oneline', 'email' or 'raw', an additional line is
 inserted before the 'Author:' line.  This line begins with
-"Merge: " and the sha1s of ancestral commits are printed,
+"Merge: " and the hashes of ancestral commits are printed,
 separated by spaces.  Note that the listed commits may not
 necessarily be the list of the *direct* parent commits if you
 have limited your view of history: for example, if you are
@@ -20,20 +20,20 @@ built-in formats:
 
 * 'oneline'
 
-	  <sha1> <title line>
+	  <hash> <title line>
 +
 This is designed to be as compact as possible.
 
 * 'short'
 
-	  commit <sha1>
+	  commit <hash>
 	  Author: <author>
 
 	      <title line>
 
 * 'medium'
 
-	  commit <sha1>
+	  commit <hash>
 	  Author: <author>
 	  Date:   <author date>
 
@@ -43,7 +43,7 @@ This is designed to be as compact as possible.
 
 * 'full'
 
-	  commit <sha1>
+	  commit <hash>
 	  Author: <author>
 	  Commit: <committer>
 
@@ -53,7 +53,7 @@ This is designed to be as compact as possible.
 
 * 'fuller'
 
-	  commit <sha1>
+	  commit <hash>
 	  Author:     <author>
 	  AuthorDate: <author date>
 	  Commit:     <committer>
@@ -65,7 +65,7 @@ This is designed to be as compact as possible.
 
 * 'email'
 
-	  From <sha1> <date>
+	  From <hash> <date>
 	  From: <author>
 	  Date: <author date>
 	  Subject: [PATCH] <title line>
@@ -75,7 +75,7 @@ This is designed to be as compact as possible.
 * 'raw'
 +
 The 'raw' format shows the entire commit exactly as
-stored in the commit object.  Notably, the SHA-1s are
+stored in the commit object.  Notably, the hashes are
 displayed in full, regardless of whether --abbrev or
 --no-abbrev are used, and 'parents' information show the
 true parent commits, without taking grafts or history
-- 
2.24.0.420.g9ac4901264

