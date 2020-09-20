Return-Path: <SRS0=oWbz=C5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59A0C43466
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 11:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F6D7216C4
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 11:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZihDyNd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgITLWr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Sep 2020 07:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgITLWk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Sep 2020 07:22:40 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49A6C0613CE
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 04:22:39 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b124so6515164pfg.13
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 04:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BBM6Z4UFUqbzxzSnSnByRwvr2Y6v7sMzlGe/goEffBw=;
        b=JZihDyNdKA3iWZu3gGX9wOERV45ZUZiGvyNkLxwqM9V5LeoEEpgJCAITiSuorNCsUn
         yQJoy3Dulxfjtv3GWZHv+V9SQ9Me2gjM8bqYKEkg8VqdzeQVyu4cfVV8bA7EjkgSGuCr
         ZaXF82FOgshholxI/RR/BTA1G/OSL9cPW0fWvNtXiCoEQ4CgHSbmVjB6q0A97TJRhaCk
         LdUiTsVU5jczph60zeFdVY5gYp/s721CZPgPL0dbhPc2z7O62YhVKI6W1yYaFjqa3co8
         tZQ3xlP+LcVKTGUVQtmIw6xB75VkGWK3vrAKuWl7d57ocxCYWpgi0JVWKguoCtEHZjmP
         6cew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BBM6Z4UFUqbzxzSnSnByRwvr2Y6v7sMzlGe/goEffBw=;
        b=aDT2cVVEvvyfVRNL/dFxilRUF65cr3I87bnep6xEcRoIARYm1NveYXlZwfKb4PzejW
         qnPjXJRBOoYeqh7d+j2/Qe6LAZoZVanyWmmH0D3UFxXUTEzyLbnJT6p/1ySey+OxH0VH
         T96n+czJ+/ABcwy+w4Qrz+6AG7rLIdnucNJ4eDFVtaYoWdZLUNTRooMAtsjFbED83ew+
         Q1C8t0+qqF8jSn5ekg7u2UvyiI/I8+gPuy0JhTyalKSDvMTDovhp3Vzi3vf57AVb9ilg
         KH5NPWVp0VxLu/LfmVktizkLka8SD0RonokduIpReae9V6gqBhQ3dFc16WgFPLqQKpfJ
         LvVA==
X-Gm-Message-State: AOAM533mrd6reGhlMuW2Ai+VM7iFOdCnJ5lBErSy+8+f2N/7z5sH3vH8
        lUWXvhvYPAORqctSCuYF80K4blZrBK4=
X-Google-Smtp-Source: ABdhPJwT5F4+249tFYgGIODZwGTZbcjPZbR23+r4vmiDYl1Z31ndBJ+gB6e+GclNw687VTh83M9CWg==
X-Received: by 2002:aa7:8ec7:0:b029:13e:d13d:a080 with SMTP id b7-20020aa78ec70000b029013ed13da080mr38329133pfr.23.1600600959018;
        Sun, 20 Sep 2020 04:22:39 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id y79sm9550737pfb.45.2020.09.20.04.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 04:22:38 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4 03/10] git-diff.txt: backtick quote command text
Date:   Sun, 20 Sep 2020 04:22:20 -0700
Message-Id: <ca9568c2ea7d28605633576609de53a2d79df22e.1600600823.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.760.g8d73e04208
In-Reply-To: <cover.1600600823.git.liu.denton@gmail.com>
References: <cover.1600328335.git.liu.denton@gmail.com> <cover.1600600823.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.28.0.760.g8d73e04208

