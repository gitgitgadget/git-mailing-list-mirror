Return-Path: <SRS0=OIeF=BS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92C7C433E0
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 17:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9945D206CD
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 17:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpoZn0+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgHHRBs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Aug 2020 13:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgHHRBf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Aug 2020 13:01:35 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DA8C061A2D
        for <git@vger.kernel.org>; Sat,  8 Aug 2020 10:01:34 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id a15so4406086wrh.10
        for <git@vger.kernel.org>; Sat, 08 Aug 2020 10:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CLLkOGBsioA4S1kw3+zkoNT7lH7FDdtowG131CyGeAY=;
        b=UpoZn0+1vWVIWYx/sX5V3Xcf+F/8kXBt0OC3GESvh/DmE608varirczroDyuBBDyPW
         vXL9j5cIvkjY3NTbqwUGU1CHYvgQtEjjf+JgCjZWZVGI2EW+3L7n/so8nEn8/G2dywsR
         aSLpIo16kqwFOynBVMSsDFY5Hr7A2MrZK2FMNi6vT2S/1qphkQVYo7i6Ih7izx6Ab2fj
         I+o/sRiUzCwNjxB/rpIm9KttSy+zLHIzcmarPbTXl+yDAHSxktVmcBAE9KuGHiRnivu0
         N3e8fVFv1tBJDm4Uk9FhEAfkwoItZz1kA12R0MXXb5nzugB+tCx0mIg1t4+L0C9bg3FK
         WjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CLLkOGBsioA4S1kw3+zkoNT7lH7FDdtowG131CyGeAY=;
        b=n9tAu602sciwu5mQdUVXyHq7MolKQ7Wnzvx3MzF/nTY3NGj0m0NdThmSmA4OsFS5oU
         sW6koL8VqbNmPZpxU5Po4QWqMsMY7hz2w1xHAIER5LhqKkG/4VQnfMkLYFabJEiaI8gf
         UUJQ3MQchO50taG6iZUt7cUYB8RBXUOqRmsG/hdRL2OxiyyKSmJudE/ghLI124I8mggW
         cYHoQlHCnCzJmMvx/17yJMzedXbW/HTwF1U9Cmo6Q7//UEnsPDjUQ8imt+/4gp7aYA3Q
         66/LqE7CMuNxdSbg79l0hRcJWfX4LR6i2LUXnJoz/+wYjab9rnU6CWIR9eiNE3cpBxWF
         Dldw==
X-Gm-Message-State: AOAM5314IZVzIyv2py0tad4Izsfbo08JfUocLniveWjUZac7kouxYorT
        LaQRr30wTsbieIIahYlUUSxfJ/Dc
X-Google-Smtp-Source: ABdhPJzH6tyEPBRRcSXpyBTuUSYRbuAH6xAQ9TUq2vzl/t++Na4Q/NJ3efjVS29187Id8WyVSEsI+A==
X-Received: by 2002:adf:aad8:: with SMTP id i24mr16904858wrc.336.1596906092021;
        Sat, 08 Aug 2020 10:01:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j2sm15554477wrp.46.2020.08.08.10.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 10:01:31 -0700 (PDT)
Message-Id: <38f65735118955e56af2a7b0a786e167b5f7263d.1596906081.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.827.v2.git.git.1596906081.gitgitgadget@gmail.com>
References: <pull.827.git.git.1596644952296.gitgitgadget@gmail.com>
        <pull.827.v2.git.git.1596906081.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 08 Aug 2020 17:01:20 +0000
Subject: [PATCH v2 11/11] t6425: be more flexible with rename/delete conflict
 messages
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

t6425 was very picky about the exact output message produced by a
rename/delete conflict, in a way that just scratches the surface of the
mess that was built into merge-recursive.  The idea was that it would
try to find the possible combinations of different conflict types, and
when more than one was present for one path, it would try to provide a
combined message that covered all the cases.

There's a lot to unravel here...

First, there's a basic conflict type known as modify/delete, which is a
content conflict.  It occurs when one side deletes a file, but the other
modifies it.

There is also a path conflict known as a rename/delete.  This occurs
when one side deletes a path, and the other renames it.  This is not a
content conflict, it is a path conflict.  It will often occur in
combination with a content conflict, though, namely a modify/delete.  As
such, these two were often combined.

Another type of conflict that can exist is a directory/file conflict.
For example, one side adds a new file at some path, and the other side
of history adds a directory at the same path.  The path that was "added"
could have been put there by a rename, though.  Thus, we have the
possibility of a single path being affected by a modify/delete, a
rename/delete, and a directory/file conflict.

In part, this was a natural by-product of merge-recursive's design.
Since it was doing a four way merge with the contents of the working
tree being the fourth factor it had to consider, it had working tree
handling spread all over the code.  It also had directory/file conflict
handling spread everywhere through all the other types of conflicts.
And our testsuite has a huge number of directory/file conflict tests
because trying to get them right required modifying so many different
codepaths.  A natural outgrowth of this kind of structure is conflict
messages that combine all the different types that the current codepath
is considering.

However, if we want to make the different conflict types orthogonal and
avoid repeating ourselves and getting very brittle code, then we need to
split the messages from these different conflict types apart.  Besides,
trying to determine all possible permutations is a _royal_ mess.  The
code to handle the rename/delete/directory/file conflict output is
already somewhat hard to parse, and is somewhat brittle.  But if we
really wanted to go that route, then we'd have to have special handling
for the following types of combinations:
  * rename/add/delete:
      on side of history that didn't rename the given file, remove the file
      instead and place an unrelated file in the way of the rename
  * rename/rename(2to1)/mode conflict/delete/delete:
      two different files, one executable and the other not, are renamed
      to the same location, each side deletes the source file that the
      other side renames
  * rename/rename(1to2)/add/add:
      file renamed differently on each side of history, with each side
      placing an unrelated file in the way of the other
  * rename/rename(1to2)/content conflict/file location/(D/F)/(D/F)/:
      both sides modify a file in conflicting way, both rename that file
      but to different paths, one side renames the directory which the
      other side had renamed that file into causing it to possibly need a
      transitive rename, and each side puts a directory in the way of the
      other's path.

Let's back away from this path of insanity, and allow the different
types of conflicts to be handled by separate pieces of non-repeated code
by allowing the conflict messages to be split into their separate types.
(If multiple conflict types affect a single path, the conflict messages
can be printed sequentially.)  Start this path with a simple change:
modify this test to be more flexible and accept the output either merge
backend (recursive or the new ort) will produce.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6425-merge-rename-delete.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t6425-merge-rename-delete.sh b/t/t6425-merge-rename-delete.sh
index 5d33577d2f..f79d021590 100755
--- a/t/t6425-merge-rename-delete.sh
+++ b/t/t6425-merge-rename-delete.sh
@@ -17,7 +17,8 @@ test_expect_success 'rename/delete' '
 	git commit -m "delete" &&
 
 	test_must_fail git merge --strategy=recursive rename >output &&
-	test_i18ngrep "CONFLICT (rename/delete): A deleted in HEAD and renamed to B in rename. Version rename of B left in tree." output
+	test_i18ngrep "CONFLICT (rename/delete): A.* renamed .*to B.* in rename" output &&
+	test_i18ngrep "CONFLICT (rename/delete): A.*deleted in HEAD." output
 '
 
 test_done
-- 
gitgitgadget
