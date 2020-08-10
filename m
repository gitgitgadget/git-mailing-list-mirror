Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E39C433E5
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 22:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAFE82073E
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 22:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XE6Zn8kU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgHJW3g (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 18:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbgHJW3c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 18:29:32 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEB8C061756
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 15:29:31 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id z18so9622760wrm.12
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 15:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CLLkOGBsioA4S1kw3+zkoNT7lH7FDdtowG131CyGeAY=;
        b=XE6Zn8kUnHIpUlCjOZymNrTBX3a34yc07wQGCzRx7p7ryR+9eJyzNoD8frrAZHYqOx
         aYSIejk6/AWeSH/XIPoGtNbXKQnmKuEQo7waEs7JBsw6A4aq2UUZzvi9T97BE3Vvyepl
         Bdg4b78fRgnIOivtU0Z3jzcGUdfJpUxhAuN/qZtCMHRGeijkXvjMU0NwbrNr1wpvq3C9
         +3dXkwdEOjHd1TUpTNg9H5mQgGGI6PitazdZEh7z1rdjmp0e8EEGsSZA3tAM429wzU8E
         nOevT6qdJa2Xddx3JemGuDUAxOn90jDSYChhYwn4CL6U4MxGZK4mApLbf+g45hcXnSIp
         1m5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CLLkOGBsioA4S1kw3+zkoNT7lH7FDdtowG131CyGeAY=;
        b=UVV3XRQBEZcaDjETJxNVe6dOez9w+4AqpjwYdqlPOtwtAyALi01ew0fAbQWuxhL5tt
         RMAdRxuRTdy0NJ4wH509IjMA9xQhel+O3y+JXW2PFqpHNDQQjp8OHNdcTkXNNYG7gb6U
         3LGGUCvqdz7Se4nAiCzUmqgEYrClwThIOzELIr+TRf7F1k2Uv1z0VXb5CRQblv8p+4ib
         8GdaUI1k++Lt4OFEwYE8EH0T1vgSv7hDjJ9evZxWIwA7o5/X09BzOLILW0zgzGzhO9Hs
         I4y1m7KRnLxmntn+esaLMwtbishsAPEGmIHyoPNHqeedXjFXLq5Y+ROKhMDOL5UbSeaN
         hk5w==
X-Gm-Message-State: AOAM531MekfwuekMqDSRhZbgOshX1faqZOVm4Bu7uw+G0ZFtPofNS/Ks
        B5XNBsZkg7wIVh8r5zna0PB+V7HY
X-Google-Smtp-Source: ABdhPJz0rcAJLFKONX41E8uv8RxgIV3Gp5I7XUF/jme6YJydBOrX4JFXr+IAI5ORmoCPZvj1JP4Z3g==
X-Received: by 2002:adf:a195:: with SMTP id u21mr28050092wru.296.1597098570207;
        Mon, 10 Aug 2020 15:29:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g25sm1503412wmh.35.2020.08.10.15.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 15:29:29 -0700 (PDT)
Message-Id: <0c8dcbf01cc7bb78f62291b645d56d344b24e5fd.1597098559.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.827.v3.git.git.1597098559.gitgitgadget@gmail.com>
References: <pull.827.v2.git.git.1596906081.gitgitgadget@gmail.com>
        <pull.827.v3.git.git.1597098559.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Aug 2020 22:29:19 +0000
Subject: [PATCH v3 11/11] t6425: be more flexible with rename/delete conflict
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
