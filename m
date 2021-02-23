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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59769C433E0
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 07:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDC0F64E32
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 07:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhBWG77 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 01:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhBWG76 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 01:59:58 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A215C06174A
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 22:59:18 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id g20so9274598plo.2
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 22:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U8JuGl9NwFRlpE/1KpcUFlfBWGwGGyw6x/9dGJSoiHM=;
        b=Z5l7fbQjcexfAxvjBZKvN+db9E2ldbCW46DsEwQIMDNkNYadqjPWgTJkzN9HdlFv/B
         Xg0crqVl13g8IUJVD4Dji4H8i+hQCkY6K0NDlkdKsG60sr4MVr6lTGo+zlw6ePxlMzia
         cBD1LJrmwsPqwz7Rn3GLxXsF5SFbT6poizFHq+wn1t1uvjBwgcKf5yKjufgK51rnolhJ
         OgxA9pTh9R1xjFYo19mBiUROyR5tzlGXEXzrzXf8f5JzjvO1/xaQHYHAEBr2bW85GEGY
         wZZyGjfR/F4C/QaiRKUmK0yDMd92c7mxpx2z5fa4j+ylzikp/TioxVPynxJj/hj/3ikX
         MSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U8JuGl9NwFRlpE/1KpcUFlfBWGwGGyw6x/9dGJSoiHM=;
        b=t7/nOj2o6H3TEQ3Bl0UtldRTMRM1dMala9suXTDyvhmDB8MdsKa2p9GMf9sz4Vx/KD
         gsFnLRKdOjNHNQryEb1Onc/48DvwPtNShLh9GkdDXkKyWT6DxnuLz7UL6CznlgonwVig
         sfl1l4Ux1ehptY8KHaDXJSGwp/ZCueXuk5Ss7z28+OzlvCg8ZaPVs9KTa8/qF3pxy/Mv
         cxMm5ru8L8Gai9HZfjNIobhtDGBBsjSBvWbWfC+PrWUQdl1/63lPtYCmslC4OYib1fwk
         H3LAYtYj1YKK3+5uikRExqH8nrM75JbCWxNFlXWNpwWqn9wW6LPgNx0HmBIdLXSNdhXv
         gsvQ==
X-Gm-Message-State: AOAM531LSAjeF04NRi71C5vMM+D+Woiekt5Z/e+eR8S/Uy7p7L9omGTm
        DDudgtRuLHcPHiyI3fb6/RHie9cwcQo=
X-Google-Smtp-Source: ABdhPJxRjnM0vXFIY6LUvzcgw2ai13VFDxcpzbBGMu2cuVvLDsLbnawPmHVOoltl8w2MZ6fLhh4fag==
X-Received: by 2002:a17:90b:e12:: with SMTP id ge18mr6521503pjb.30.1614063557494;
        Mon, 22 Feb 2021 22:59:17 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id ml17sm2106847pjb.18.2021.02.22.22.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 22:59:17 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v1.1 2/3] git-cat-file.txt: monospace args, placeholders and filenames
Date:   Mon, 22 Feb 2021 22:59:08 -0800
Message-Id: <7dab69ce23b984266ac388ca62e5a37842499797.1614063441.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.30.1.823.g0a3b79fd18
In-Reply-To: <1ab7ca7fc0928b40c47b53d97695ae911ba93c39.1614062288.git.liu.denton@gmail.com>
References: <1ab7ca7fc0928b40c47b53d97695ae911ba93c39.1614062288.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In modern documentation, args, placeholders and filenames are
monospaced. Apply monospace formatting to these objects.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
Thanks for catching the omission, Eric. I've gone through the
documentation with a fine-tooth comb and caught many more missing
instances.

 Documentation/git-cat-file.txt | 56 +++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 8e192d87db..a1c37a9e81 100644
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
 
@@ -115,15 +115,15 @@ OPTIONS
 	repository.
 
 --allow-unknown-type::
-	Allow -s or -t to query broken/corrupt objects of unknown type.
+	Allow `-s` or `-t` to query broken/corrupt objects of unknown type.
 
 --follow-symlinks::
-	With --batch or --batch-check, follow symlinks inside the
+	With `--batch` or `--batch-check`, follow symlinks inside the
 	repository when requesting objects with extended SHA-1
 	expressions of the form tree-ish:path-in-tree.  Instead of
 	providing output about the link itself, provide output about
 	the linked-to object.  If a symlink points outside the
-	tree-ish (e.g. a link to /foo or a root-level link to ../foo),
+	tree-ish (e.g. a link to `/foo` or a root-level link to `../foo`),
 	the portion of the link which is outside the tree will be
 	printed.
 +
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
@@ -258,7 +258,7 @@ If a name is specified that might refer to more than one object (an ambiguous sh
 <object> SP ambiguous LF
 ------------
 
-If --follow-symlinks is used, and a symlink in the repository points
+If `--follow-symlinks` is used, and a symlink in the repository points
 outside the repository, then `cat-file` will ignore any custom format
 and print:
 
@@ -267,11 +267,11 @@ symlink SP <size> LF
 <symlink> LF
 ------------
 
-The symlink will either be absolute (beginning with a /), or relative
-to the tree root.  For instance, if dir/link points to ../../foo, then
-<symlink> will be ../foo.  <size> is the size of the symlink in bytes.
+The symlink will either be absolute (beginning with a `/`), or relative
+to the tree root.  For instance, if dir/link points to `../../foo`, then
+`<symlink>` will be `../foo`.  `<size>` is the size of the symlink in bytes.
 
-If --follow-symlinks is used, the following error messages will be
+If `--follow-symlinks` is used, the following error messages will be
 displayed:
 
 ------------
-- 
2.30.1.823.g0a3b79fd18

