Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532A9C433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 06:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C1F964DF2
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 06:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbhBWGkR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 01:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbhBWGj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 01:39:57 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50310C061786
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 22:39:17 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 75so11758683pgf.13
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 22:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=t/W/8w0LwLCPzZJ7aUtGLyOzEv36kB2MALwddxUQ90A=;
        b=QYLu2VRZW+Gg7ufxkAugrZ4CuA/v4bWjHsJVlMHBAxVU/gHIXBN6JAqZsHIOBahQZ8
         lKkDQeYF1l43lt9ZrWCpGFINHJMJs+cbtXi15hscf7G6rDjK926E/AbBQe8cQQFOX2qp
         8TeiroTk2ivSI7lqEFEx57ZV/aHC6tJ1X240/krE9FaxP+3TwJ1lhWbLJlYEYtNU5hSz
         3jSX2G9k8aAdsP2+CnM6GmaYxAX2ktjpLyUH18vJAakJzadKxKDPX80aKLdi+RGSR4mX
         mvSHIafBsSFtvIqOQBHhVVqSfMjIqFqXdDs9wCmzibifg6sIxp8zl3TOOhyrP6SuLhzZ
         0nXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t/W/8w0LwLCPzZJ7aUtGLyOzEv36kB2MALwddxUQ90A=;
        b=gGgaUlTtUUBK8Xn25LAnzattvH9wlJbhT9MzjZjfe9Dx0V0IWMdMfCqWqslqwa4fBw
         HwYudB9t9ZJiWkz32/FSaJoOSwG6xShlM8GzqzsXzFtKsHvLMYO/m6C/K8audXiqhTYJ
         KRoRlXachXqDcHQkKtQM6OqORZ+C8U9wvLFDZqyjQZly36VpB7iFGOk77+uwRBXDs5sz
         Tia9g8nlRwakh0Q7EdKyh8Q22ovPx3PC3yzk3UGlXG4EhB2odOS0wMQlZ0XhbHtfAjfg
         CWRLktu+kkeNw1SDXA6XRcW/gglkcauhemFelp326nF/X8244433LiM/cbMLmqB15b/r
         9NuQ==
X-Gm-Message-State: AOAM533oww2PLJSYpFNUl8FNztAl/vm8AnJPJX3xMiJW2vlNWxquOLVy
        75CjxfWMZ1LeURd1yVkXWCpj3DPCxPY=
X-Google-Smtp-Source: ABdhPJyKQ51x1aBodNYCbdnFBOil5uqgWlF4DM+MNTu86oYNpktv0mnfiDgL+iTjYC6kIfToemXq+g==
X-Received: by 2002:a63:1b48:: with SMTP id b8mr10086517pgm.334.1614062356600;
        Mon, 22 Feb 2021 22:39:16 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id j1sm21355055pfr.78.2021.02.22.22.39.15
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 22:39:16 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 2/3] git-cat-file.txt: monospace args and placeholders
Date:   Mon, 22 Feb 2021 22:39:07 -0800
Message-Id: <1ab7ca7fc0928b40c47b53d97695ae911ba93c39.1614062288.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01
In-Reply-To: <cover.1614062288.git.liu.denton@gmail.com>
References: <cover.1614062288.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In modern documentation, args and placeholders are monospaced. Format
all remaining args and placeholders as monospace.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-cat-file.txt | 42 +++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 8e192d87db..987d170506 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -35,42 +35,42 @@ OPTIONS
 
 -t::
 	Instead of the content, show the object type identified by
-	<object>.
+	`<object>`.
 
 -s::
 	Instead of the content, show the object size identified by
-	<object>.
+	`<object>`.
 
 -e::
-	Exit with zero status if <object> exists and is a valid
-	object. If <object> is of an invalid format exit with non-zero and
+	Exit with zero status if `<object>` exists and is a valid
+	object. If `<object>` is of an invalid format exit with non-zero and
 	emits an error on stderr.
 
 -p::
-	Pretty-print the contents of <object> based on its type.
+	Pretty-print the contents of `<object>` based on its type.
 
 <type>::
-	Typically this matches the real type of <object> but asking
+	Typically this matches the real type of `<object>` but asking
 	for a type that can trivially be dereferenced from the given
-	<object> is also permitted.  An example is to ask for a
-	"tree" with <object> being a commit object that contains it,
-	or to ask for a "blob" with <object> being a tag object that
+	`<object>` is also permitted.  An example is to ask for a
+	"tree" with `<object>` being a commit object that contains it,
+	or to ask for a "blob" with `<object>` being a tag object that
 	points at it.
 
 --textconv::
 	Show the content as transformed by a textconv filter. In this case,
-	<object> has to be of the form <tree-ish>:<path>, or :<path> in
+	`<object>` has to be of the form `<tree-ish>:<path>`, or `:<path>` in
 	order to apply the filter to the content recorded in the index at
-	<path>.
+	`<path>`.
 
 --filters::
 	Show the content as converted by the filters configured in
-	the current working tree for the given <path> (i.e. smudge filters,
-	end-of-line conversion, etc). In this case, <object> has to be of
-	the form <tree-ish>:<path>, or :<path>.
+	the current working tree for the given `<path>` (i.e. smudge filters,
+	end-of-line conversion, etc). In this case, `<object>` has to be of
+	the form `<tree-ish>:<path>`, or `:<path>`.
 
 --path=<path>::
-	For use with --textconv or --filters, to allow specifying an object
+	For use with `--textconv` or `--filters`, to allow specifying an object
 	name and a path separately, e.g. when it is difficult to figure out
 	the revision from which the blob came.
 
@@ -115,7 +115,7 @@ OPTIONS
 	repository.
 
 --allow-unknown-type::
-	Allow -s or -t to query broken/corrupt objects of unknown type.
+	Allow `-s` or `-t` to query broken/corrupt objects of unknown type.
 
 --follow-symlinks::
 	With --batch or --batch-check, follow symlinks inside the
@@ -175,15 +175,15 @@ respectively print:
 
 OUTPUT
 ------
-If `-t` is specified, one of the <type>.
+If `-t` is specified, one of the `<type>`.
 
-If `-s` is specified, the size of the <object> in bytes.
+If `-s` is specified, the size of the `<object>` in bytes.
 
-If `-e` is specified, no output, unless the <object> is malformed.
+If `-e` is specified, no output, unless the `<object>` is malformed.
 
-If `-p` is specified, the contents of <object> are pretty-printed.
+If `-p` is specified, the contents of `<object>` are pretty-printed.
 
-If <type> is specified, the raw (though uncompressed) contents of the <object>
+If `<type>` is specified, the raw (though uncompressed) contents of the `<object>`
 will be returned.
 
 BATCH OUTPUT
-- 
2.30.0.478.g8a0d178c01

