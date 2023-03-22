Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE7DC6FD1F
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 17:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjCVRNT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 13:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjCVRNS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 13:13:18 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7911E2A9
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 10:13:17 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id p13-20020a17090a284d00b0023d2e945aebso1715300pjf.0
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 10:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679505196;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PuCODOjT1u2dwNCZQxAwGEHkfKEjN0+eYt2F2ilmW1E=;
        b=nkV1JFz9gVyFt5LlIZ/p/kmwuxDgAtXuoayhThIHCOfvCDqaRsiqQ2ahYh2/Gm0M6b
         QNcbWMaxMyKNmwGKqD4sMVIz1LkKwkfPHFnBpvfFTSX7pPmkgomtr8E0zAEtxzPL8J+A
         TwJACJVNn8uQdsjlKS4HP2CnkwZC5x8E5eHBJ2KwRQDH6Si7FZH9ATXEtxTmuDvxTNZf
         ITK+VvYqvx4WUsErL6Iei0ZVVxyFDCTLs96cr31FOzEW2yC5S6Y4oKGphurGk7grTMid
         DkwzI70BUoPd7VGMtFJF5ftYdMhffLZKXUjLwWYA5Yxk3+/Luex/MdYEy9teqVGQDDzN
         0tOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679505196;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PuCODOjT1u2dwNCZQxAwGEHkfKEjN0+eYt2F2ilmW1E=;
        b=mmkTy1vEuM8lTreLpi3jbmwrNDZfzKdx1eJ1O8akphPy7OtVZYISyv6tVXZaNl0TGT
         Q243v3bS/0O0dxlsnJFxjQkSawFh3yGABNPtQe1iHSsR7c96V0Tt8ym9A9Ej0M93kXZQ
         7U7xaORto9hrt1mgJYLh7hEeZSwP9hWicRE6s56aJ/ZDTq+0VCNOz9eTRxBEbvlA3da/
         fT3q9DGHnGtOI4uffrkxc0gfEjDtpMNrFMgBiM3gVEM85CUcFFI+8FGQc11Mf0bfQ5Ut
         kwDQuh5Y+1w2xGksI+dlJvGzq4/YoHm6XbmGZy7Vcpkvf/X5YcJulbVq169tHcKU8pt8
         7e4Q==
X-Gm-Message-State: AAQBX9c+zPPmFEXQ64VW8QCkVR3Ar3Dvm468HGlj1eFFGwt2cc7y6PLo
        WimdhacaJq92qQTkANb7wd8=
X-Google-Smtp-Source: AKy350a0ed+iYoCm8r00MlKWKPVdF7qW9eMnzYjhRmyYhTqyEa2z1x+NliF7awTIc0psI44zBNggVQ==
X-Received: by 2002:a17:902:d492:b0:1a0:57df:861c with SMTP id c18-20020a170902d49200b001a057df861cmr2984985plg.1.1679505196413;
        Wed, 22 Mar 2023 10:13:16 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id 17-20020a170902ee5100b0019339f3368asm10878747plo.3.2023.03.22.10.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 10:13:16 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Sean Allred via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Sean Allred <code@seanallred.com>,
        Sean Allred <allred.sean@gmail.com>
Subject: Re* [PATCH v2 2/2] Document the output format of ls-remote
References: <pull.1471.git.git.1679153586903.gitgitgadget@gmail.com>
        <pull.1471.v2.git.git.1679478573.gitgitgadget@gmail.com>
        <44e79f0d69c86e3cf4363aaa10acda91bfa3e9ee.1679478573.git.gitgitgadget@gmail.com>
        <xmqqy1noenq3.fsf@gitster.g>
Date:   Wed, 22 Mar 2023 10:13:15 -0700
In-Reply-To: <xmqqy1noenq3.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        22 Mar 2023 09:48:36 -0700")
Message-ID: <xmqqedpgeml0.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> The documentation for "show-branch" uses many <reference>s in the
> description, which should be updated to match what its SYNOPSIS
> section uses, which is <ref>.

I forgot to list this in the list of actionable items at the end of
my review message I am responding to, so here is a patch to help us
not forget about it ;-).

----- >8 -----
Subject: show-branch doc: say <ref>, not <reference>

The glossary defines 'ref' as the official name of the thing,
and the output from "git grep -e '<ref' Documentation/" shows
that most everybody uses <ref>, not <reference>.  In addition,
the page already says <ref> in its SYNOPSIS section for the
command when it is used in the mode to follow the reflogs.

Strictly speaking, many references of these should be updated to
<commit> after adding an explanation on how these <commit>s are
discovered (i.e. we take <rev>, <glob>, or <ref> and starting from
these commits, follow their ancestry or reflog entries to list
commits), but that would be a lot bigger change I would rather not
to do in this patch, whose primary purpose is to make the existing
documentation more consistent.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-show-branch.txt | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git c/Documentation/git-show-branch.txt w/Documentation/git-show-branch.txt
index 71f608b1ff..0874c01e37 100644
--- c/Documentation/git-show-branch.txt
+++ w/Documentation/git-show-branch.txt
@@ -74,8 +74,7 @@ OPTIONS
 	that is the common ancestor of all the branches.  This
 	flag tells the command to go <n> more common commits
 	beyond that.  When <n> is negative, display only the
-	<reference>s given, without showing the commit ancestry
-	tree.
+	<ref>s given, without showing the commit ancestry tree.
 
 --list::
 	Synonym to `--more=-1`
@@ -88,8 +87,8 @@ OPTIONS
 	the case of three or more commits.
 
 --independent::
-	Among the <reference>s given, display only the ones that
-	cannot be reached from any other <reference>.
+	Among the <ref>s given, display only the ones that
+	cannot be reached from any other <ref>.
 
 --no-name::
 	Do not show naming strings for each commit.
@@ -132,7 +131,7 @@ are mutually exclusive.
 
 OUTPUT
 ------
-Given N <references>, the first N lines are the one-line
+Given N <ref>s, the first N lines are the one-line
 description from their commit message.  The branch head that is
 pointed at by $GIT_DIR/HEAD is prefixed with an asterisk `*`
 character while other heads are prefixed with a `!` character.
