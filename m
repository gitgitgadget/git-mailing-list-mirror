Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32321C43381
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0600564E59
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238564AbhCDAWs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1843055AbhCCKY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 05:24:59 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C71EC0698DB
        for <git@vger.kernel.org>; Wed,  3 Mar 2021 01:22:11 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id e9so3963661pjj.0
        for <git@vger.kernel.org>; Wed, 03 Mar 2021 01:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HfpAL1/8NNR81JAF5gtWY9dktgJMgCLxLCtemiMSSk8=;
        b=hvyQHR25WAF+fRRFCqr45vATfAJ9GiLWHtAmPWstRnL2pZdReC1MdEi9ZSHuWFMg8h
         dd37lABGnxBH6zCkIhH07rXZySdAKDfLqLJw3BO/Yz38PcipLxsNXCKZDkPyEnl9SoFU
         HuglzpLBtdS3QKfWjJWthlZ1vBM/i47v3yGdi/LkSGOgUycNqaw+2TCWcxXfUwqTAfkd
         eC96uJAB5D67+d/XArjsjQVsm0mMIyjHHwJV+IFtZ2qCez8caJ7BxI8aT139a6sNl33E
         1+H6vUl7a9KS4g232BuqCajMm2EntaygHbDfOjrdBShF/cOA2kdsCvcNnn94K42XNu/U
         Pp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HfpAL1/8NNR81JAF5gtWY9dktgJMgCLxLCtemiMSSk8=;
        b=czCwNy5226xoI0CN6Biw0iXoPunbsgeYhhd7GbMpg1Wc6qv0VuU2rtnzyXmx+ChUb9
         fUBHlzcsKdPkU7KKaXKL+6z4kkt6knqI+82su2xgsysaE2/mKJaThK2PZ9KLD0exj47S
         XC67BWv45DlJz4chMaAlKt5HnqWbPKFBjEUozu7uXzzBy7gnteVg1FdMBIg1mElb8Bue
         fUiazM/ucJxjSMAEFinWBnZ4oEH0XJv61ffOgBX04yRq2rv6zKAnqXoPKH5nnlCDP1De
         p5NHfRKRyDu0XjY9rBL0kpBkJT2tLQo5SdbqryU9jbs8S3sNP/a0OF8ieoDK8ann6Fd5
         eAYQ==
X-Gm-Message-State: AOAM531lvQBnEILj/UWkRHoqSLxvAUsirYDhVxgcsx5EUUamRXeMbdjm
        wD5t5T8pn4znimbBD7/bvZPatIoY1+o=
X-Google-Smtp-Source: ABdhPJy+RiOmN0761Vmn4bfmztd9PsIRA86fGFxFffhzIgXybppj7HtcywRr5PsSRmNBnGyK9rtahw==
X-Received: by 2002:a17:90a:d90a:: with SMTP id c10mr5870191pjv.13.1614763330079;
        Wed, 03 Mar 2021 01:22:10 -0800 (PST)
Received: from archbookpro.localdomain ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id a11sm13986861pfk.109.2021.03.03.01.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 01:22:09 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/2] git-cat-file.txt: monospace args, placeholders and filenames
Date:   Wed,  3 Mar 2021 01:21:55 -0800
Message-Id: <6d044cf540e81ff5218e730172ab5044f7b3a139.1614763281.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.30.1.823.g0a3b79fd18
In-Reply-To: <cover.1614763281.git.liu.denton@gmail.com>
References: <cover.1614062288.git.liu.denton@gmail.com> <cover.1614763281.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In modern documentation, args, placeholders and filenames are
monospaced. Apply monospace formatting to these objects.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
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

