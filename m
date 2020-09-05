Return-Path: <SRS0=od8b=CO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E74C433E2
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 19:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9AA22074B
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 19:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMU5Fjp8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgIETIr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Sep 2020 15:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728449AbgIETIj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Sep 2020 15:08:39 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F342C061244
        for <git@vger.kernel.org>; Sat,  5 Sep 2020 12:08:37 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b124so6413916pfg.13
        for <git@vger.kernel.org>; Sat, 05 Sep 2020 12:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4AVt485aTuo7yvtGO3YBhuaEV0nIIPDV4HX+ZW+Zhak=;
        b=eMU5Fjp8FqNu3xPQ5JkG8MUxQS4jW80XinlZGleO6gN5kOhD/0i/qNJPbAt4WC9TdS
         a97B3LZYrkLvCampHLDwyc7VKYs0W7Z5JyjeUfClaSM5Wn7+2/qqOXVdNuGxooBZx9yU
         XMDuhgYoyhQoElip7oBHkDf5nWEbq8VTostxICUHdLikxd70VS45Sa1H2MjdZ81IouOU
         woRYT00dTdsXyMeAZjBXZ6TPzz2iwK8LKdvvl9ANbq/rpxLKccLFvsg9ZUo5I2JQObrh
         Ziqw6GUkktupoCHF8En2fyYUxDBQ4n0nuN/3JrXrYi0TqIn26468mbDVo+y9R9z9uiAP
         Mlnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4AVt485aTuo7yvtGO3YBhuaEV0nIIPDV4HX+ZW+Zhak=;
        b=JIvf+40qsXQNlR8dT00W2i2BCEDui7Yd49VufxanTiFW9MryW/X+8mGaiZskoQx37p
         q/KV7rmCg+6YaCiQPDIkJ7we6wNgp7tKWgmxUvZAy0dCc+oKO3D35lYBw0K9s58+8g/l
         KpXhBs+yCh4QKN0Ht66sydyV5m94WxPlwueNeqUrJNdbHyXgsjSow0UCmEhDPCeZ3vTo
         d2aM9W7D8v9cqcUP0d8bM7Zqn8QdliweGH+IlyFqUE9U6oHoAlodY/ZCK1PtCgP0jve0
         AvF1R+7+6pxvjudKLtznB03wVKURgei2JvBqZ8Qr0NrYvYPlgDSMYueINTIvwQqqjF6U
         /nMQ==
X-Gm-Message-State: AOAM531QzZm5+VoegikdRhCVJxea3JlxSJOTwW+6zR49b6sS2TN/rZ1F
        L3JE3+8O16x+q6KWSNttkpkHeK1IcRQ=
X-Google-Smtp-Source: ABdhPJwfHixVUve4iLLVuVSlMq2aTUFpYpnq9tW7npGKnqAEX0zKyPqMwVGX2pVk33UBkCvDMedLfg==
X-Received: by 2002:a62:1b56:: with SMTP id b83mr12005281pfb.15.1599332916668;
        Sat, 05 Sep 2020 12:08:36 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:5900:d670::1ab5])
        by smtp.gmail.com with ESMTPSA id u5sm3045459pfh.215.2020.09.05.12.08.35
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 12:08:36 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 2/4] git-diff.txt: backtick quote command text
Date:   Sat,  5 Sep 2020 12:08:19 -0700
Message-Id: <8e72bd8fea276d40729705eb8dcc63bcc9faef2c.1599332861.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.rc0.135.gc7877b767d
In-Reply-To: <cover.1599332861.git.liu.denton@gmail.com>
References: <cover.1599332861.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The modern way to quote commands in the documentation is to use
backticks instead of double-quotes as this renders the text with the
code style. Convert double-quoted command text to backtick-quoted
commands. While we're at it, quote one instance of `^@`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-diff.txt | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 727f24d16e..8f7b4ed3ca 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -68,13 +68,13 @@ files on disk.
 	This form is to view the results of a merge commit.  The first
 	listed <commit> must be the merge itself; the remaining two or
 	more commits should be its parents.  A convenient way to produce
-	the desired set of revisions is to use the {caret}@ suffix.
+	the desired set of revisions is to use the `^@` suffix.
 	For instance, if `master` names a merge commit, `git diff master
 	master^@` gives the same combined diff as `git show master`.
 
 'git diff' [<options>] <commit>..<commit> [--] [<path>...]::
 
-	This is synonymous to the earlier form (without the "..") for
+	This is synonymous to the earlier form (without the `..`) for
 	viewing the changes between two arbitrary <commit>.  If <commit> on
 	one side is omitted, it will have the same effect as
 	using HEAD instead.
@@ -83,20 +83,20 @@ files on disk.
 
 	This form is to view the changes on the branch containing
 	and up to the second <commit>, starting at a common ancestor
-	of both <commit>.  "git diff A\...B" is equivalent to
-	"git diff $(git merge-base A B) B".  You can omit any one
+	of both <commit>.  `git diff A...B` is equivalent to
+	`git diff $(git merge-base A B) B`.  You can omit any one
 	of <commit>, which has the same effect as using HEAD instead.
 
 Just in case you are doing something exotic, it should be
 noted that all of the <commit> in the above description, except
-in the last two forms that use ".." notations, can be any
+in the last two forms that use `..` notations, can be any
 <tree>.
 
 For a more complete list of ways to spell <commit>, see
 "SPECIFYING REVISIONS" section in linkgit:gitrevisions[7].
 However, "diff" is about comparing two _endpoints_, not ranges,
-and the range notations ("<commit>..<commit>" and
-"<commit>\...<commit>") do not mean a range as defined in the
+and the range notations (`<commit>..<commit>` and
+`<commit>...<commit>`) do not mean a range as defined in the
 "SPECIFYING RANGES" section in linkgit:gitrevisions[7].
 
 'git diff' [<options>] <blob> <blob>::
@@ -144,9 +144,9 @@ $ git diff HEAD       <3>
 +
 <1> Changes in the working tree not yet staged for the next commit.
 <2> Changes between the index and your last commit; what you
-    would be committing if you run "git commit" without "-a" option.
+    would be committing if you run `git commit` without `-a` option.
 <3> Changes in the working tree since your last commit; what you
-    would be committing if you run "git commit -a"
+    would be committing if you run `git commit -a`
 
 Comparing with arbitrary commits::
 +
-- 
2.28.0.rc0.135.gc7877b767d

