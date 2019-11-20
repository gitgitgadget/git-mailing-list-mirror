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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89985C432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 00:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 600A12245B
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 00:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdWEo0z+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfKTAvM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 19:51:12 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34431 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfKTAvM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 19:51:12 -0500
Received: by mail-pg1-f195.google.com with SMTP id z188so12451431pgb.1
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 16:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Xz3HKaR/mABlrGSH91pOYq/CcZA6SZvhLGmRiGFNP20=;
        b=WdWEo0z+BNzDYSP+oSKBT3WTFJDFWwnjGJdY70t2oiReJosXT/pJhCXIwA8mybrIwZ
         Fbxue5+l4xfgCRK9lPcDptZSgpibVXyrXxruIQzwkMI7QI9eXfy828yBxEyeOftS5czT
         6rrzl5To1j2v+ubWiz/bkPXVyt1i2EjL0YNSA/RRFkJ+Tbg/MSjoLGDWM+dFFbQR3s17
         4QI7aMRcSm5SnwZ9PsurCnZAbH0mhji7cGrWah9xYWfWwOj1NxH/6WFppQmJa/LTshYU
         D+6Njwir8ZQReylcOVh8HTrVjeQFu1/5fLZjwHQNmfuO9/AnbS2DZOKTC57AnAvoWT6g
         aCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Xz3HKaR/mABlrGSH91pOYq/CcZA6SZvhLGmRiGFNP20=;
        b=bhqjCyFmooLihlAsON3UFOsQcqBuQN6ABoAhiUSTvHGtHzd4lXPHgQl9z8abWstb7X
         0o9neVj5b52HAyJF5Bssk2Iumxhpy6l19gtJzQ5aYFSNK5ZdQIZvpVOl1UYAcSkUVrOf
         /gxpTnrRmS1oV6B7nN4o+yFJoyByX2oR361qp5iuV/5Ommbn8J50Y4mPGVv2FJk6hA/q
         qix4Vam37ma1u7cjFvkIAxJreEKjtqTnYHM9rxNJD5LCE0EG6fYL5w9EIYe2bLu9fzw/
         Dr5sdfjsljBKCGblyzuH8J9ZCHDvs5vMT4UsfcwdZY5GRP5WKwBxsEKwr76xD0WII3EJ
         0NYA==
X-Gm-Message-State: APjAAAUc/gtSJlcG6DTUmKig/4J+y9Nvudm37d/ztR7eOks94gSFs6dw
        kJr1Uqb//8Tw+oF9RQhEKJ5QoM4n
X-Google-Smtp-Source: APXvYqzr5BA+1etK+E0ZoD0cm0tP3eMwgfPq8ucjam6e7Q5UFIAPGXuPExe33EkPgJY8qh5FwUN+fg==
X-Received: by 2002:aa7:824d:: with SMTP id e13mr579671pfn.35.1574211070999;
        Tue, 19 Nov 2019 16:51:10 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id m13sm25857955pga.70.2019.11.19.16.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 16:51:10 -0800 (PST)
Date:   Tue, 19 Nov 2019 16:51:08 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Todd Zullinger <tmz@pobox.com>
Subject: [PATCH v5 03/11] SubmittingPatches: remove dq from commit reference
Message-ID: <ff818446add361304fcd7a70eed300c407a408b3.1574211027.git.liu.denton@gmail.com>
References: <cover.1574122784.git.liu.denton@gmail.com>
 <cover.1574211027.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1574211027.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Quoting SZEDER Gábor[1],

	SubmittingPatches is simply wrong: our de-facto standard format for
	referencing other commits does not enclose the subject in a pair of
	double-quotes:

	  $ git log v2.24.0 |grep -E '[0-9a-f]{7} \("' |wc -l
	  785
	  $ git log v2.24.0 |grep -E '[0-9a-f]{7} \([^"]' |wc -l
	  2276

	Those double-quotes don't add any value to the references, but they
	result in weird looking references for 1083 of our commits whose
	subject lines happen to end with double-quotes, e.g.:

	  f23a465132 ("hashmap_get{,_from_hash} return "struct hashmap_entry *"", 2019-10-06)

	and without those unnecessary pair of double-quotes we would have
	~3000 more commits whose summary would fit on a single line.

Remove references to the enclosing double-quotes from SubmittingPatches
since our de-facto standard for referencing commits does not actually
use them.

[1]: cf. <20191114011048.GS4348@szeder.dev>

Signed-off-by: Denton Liu <liu.denton@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/SubmittingPatches | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 5a00329d5a..a1aad13384 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -142,19 +142,19 @@ archive, summarize the relevant points of the discussion.
 
 [[commit-reference]]
 If you want to reference a previous commit in the history of a stable
-branch, use the format "abbreviated hash (subject, date)",
-with the subject enclosed in a pair of double-quotes, like this:
+branch, use the format "abbreviated hash (subject, date)", like this:
 
 ....
-	Commit f86a374 ("pack-bitmap.c: fix a memleak", 2015-03-30)
+	Commit f86a374 (pack-bitmap.c: fix a memleak, 2015-03-30)
 	noticed that ...
 ....
 
 The "Copy commit summary" command of gitk can be used to obtain this
-format, or this invocation of `git show`:
+format (with the subject enclosed in a pair of double-quotes), or this
+invocation of `git show`:
 
 ....
-	git show -s --date=short --pretty='format:%h ("%s", %ad)' <commit>
+	git show -s --date=short --pretty='format:%h (%s, %ad)' <commit>
 ....
 
 [[git-tools]]
-- 
2.24.0.420.g9ac4901264

