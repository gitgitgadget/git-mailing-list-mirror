Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B2371F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 22:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730623AbfHOWDL (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 18:03:11 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36009 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729387AbfHOWDL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 18:03:11 -0400
Received: by mail-pl1-f194.google.com with SMTP id g4so1587245plo.3
        for <git@vger.kernel.org>; Thu, 15 Aug 2019 15:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PxKiE6GQwmEpr7LWQNKCFXdEasxBvV5Wo+Gh6+zYZBc=;
        b=gtV2otqd7wb6an+4RG7X39/IxXOCT+jo4HFThwnuHBWi0f+2CbEgIL0j+CpcYvuLMp
         IAe1wd10WvUDibA3lzSbxpyVMDQe5XbY7YAmAYBc5zaBzvhlDB7kzZRhj1dYgMwo7jbn
         B4xjxDnLmLB9+C3GeSYHReE7kB6Q8jmJQg2okP6FF4Hjtcb4c+R48t6nVvf8QPq3DogP
         qYgcWen4VbXLsYkmC/ZoFdbIKZ04RpFK8lOw0IELGwgVNXGrC/CEN7JmdROO7Hknnc7t
         uomuU0+mrHhCXMj+80tUu/pkBKfeWKTo8+vY9kJAPydt4DXCDXhLSWzQlzmPPgHEsths
         3YYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PxKiE6GQwmEpr7LWQNKCFXdEasxBvV5Wo+Gh6+zYZBc=;
        b=X/9Sz8Y31T6KOa+5iapPMfI3J4Y3LbKAJmL45kwhqy8BMsxvaV0fWppbS4K9Liw4d2
         YCes1Qf8mGDYlcMq7VKHxC1ItALwfgImp72TQz04q9PqotvbLlj6ql9iYpdmFe1sCMG3
         6v2fzbVXvqaYL/P+LmlK2zLizPpThIpM80rEjToc+1fCbXP8hrUWUUAWvZYfnm/s6i3s
         nmk+KJPZWg7AkCbStd1Po9uKg09kg7dnwsvcBnwouX/VxJOgtX0NSzjw1D7zm/dDEH66
         CLYbxX+wrLvDn+Mp39Xgstpy4k8FwL2Iyfm4yL4wLxFJFhAxLm5p7Ma3yDBz7jrmMdBM
         IG8Q==
X-Gm-Message-State: APjAAAWyaPLFDhVSAwCWtAHusZqaU2smNmKW/uupYPiGf4fTfoMmL255
        HZBR1FoH59ES7DdhS8QRO7LYI8BJ
X-Google-Smtp-Source: APXvYqzargo8IW9DRmWPjIS2SDP4U8xBfvAwUXRNRhbdNWajjbweRHbuIiUJJqwTmMFqeytnyqfr2Q==
X-Received: by 2002:a17:902:1024:: with SMTP id b33mr6306396pla.325.1565906590188;
        Thu, 15 Aug 2019 15:03:10 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id t7sm1935477pjq.15.2019.08.15.15.03.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Aug 2019 15:03:08 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: BUG?: xdl_merge surprisingly does not recognize content conflict
Date:   Thu, 15 Aug 2019 15:03:03 -0700
Message-Id: <20190815220303.17209-1-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.32.g2123e9e4e4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It appears git.git had a case of a patch being resubmitted and both the
original (nd/checkout-m-doc-update) and new (nd/checkout-m) versions
getting applied, with the merge picking to include both versions of some
of the text rather than just one of the two.  I have a patch below to
delete the duplicate hunk, but more surprising to me was the fact that
re-running the merge in question did not show any conflicts despite the
two patches adding different text in the same location.

The "duplicate" commits:
  * commit a7256debd4b6 ("checkout.txt: note about losing staged changes
    with --merge", 2019-03-19), from nd/checkout-m-doc-update
  * commit 6eff409e8a76 ("checkout: prevent losing staged changes with
    --merge", 2019-03-22), from nd/checkout-m
(From reading the mailing list, the former was v1 and the latter was
meant as v2, but the latter was not marked as v2 and apparently both
were picked up.)

The problematic merge was commit 4a3ed2bec603 ("Merge branch
'nd/checkout-m'", 2019-04-25), but redoing that merge produces no merge
conflicts.  This can be seen at the individual file level with the
following:

  $ git show 4a3ed2bec603^1:builtin/checkout.c >ours
  $ git show 4a3ed2bec603^2:builtin/checkout.c >theirs
  $ git show $(git merge-base 4a3ed2bec603^1 4a3ed2bec603^2):builtin/checkout.c >base

At this point, we can note that ours and theirs both added similar code
at the same place; looking at ours:

  $ git diff --no-index base ours | grep -B 4 -A 7 repo_index_has_changes
  @@ -736,6 +738,13 @@ static int merge_working_tree(const struct checkout_opts *opts,
   			if (!old_branch_info->commit)
   				return 1;

  +			if (repo_index_has_changes(the_repository,
  +						   get_commit_tree(old_branch_info->commit),
  +						   &sb))
  +				warning(_("staged changes in the following files may be lost: %s"),
  +					sb.buf);
  +			strbuf_release(&sb);
  +
   			/* Do more real merge */

Looking at theirs:

  $ git diff --no-index base theirs | grep -B 4 -A 7 repo_index_has_changes
   			if (!old_branch_info->commit)
   				return 1;
  +			old_tree = get_commit_tree(old_branch_info->commit);
  +
  +			if (repo_index_has_changes(the_repository, old_tree, &sb))
  +				die(_("cannot continue with staged changes in "
  +				      "the following files:\n%s"), sb.buf);
  +			strbuf_release(&sb);

   			/* Do more real merge */

  @@ -772,7 +781,7 @@ static int merge_working_tree(const struct checkout_opts *opts,

Now, a manual merge of these files gives no conflicts, which surprises me:

  $ git merge-file ours base theirs; echo $?
  0

and this merge includes BOTH additions:

  $ git diff --no-index base ours | grep -B 4 -A 7 repo_index_has_changes
   			if (!old_branch_info->commit)
   				return 1;
  +			old_tree = get_commit_tree(old_branch_info->commit);
  +
  +			if (repo_index_has_changes(the_repository, old_tree, &sb))
  +				die(_("cannot continue with staged changes in "
  +				      "the following files:\n%s"), sb.buf);
  +			strbuf_release(&sb);
  +
  +			if (repo_index_has_changes(the_repository,
  +						   get_commit_tree(old_branch_info->commit),
  +						   &sb))
  +				warning(_("staged changes in the following files may be lost: %s"),
  +					sb.buf);
  +			strbuf_release(&sb);

   			/* Do more real merge */

I'm not that familiar with the xdl_merge stuff, but this seemed buggy
to me.  Or is there something about the content merge that I'm just not
understanding and this merge is actually correct?

Elijah

-- 8< --
Subject: checkout: remove duplicate code

Both commit a7256debd4b6 ("checkout.txt: note about losing staged
changes with --merge", 2019-03-19) from nd/checkout-m-doc-update and
commit 6eff409e8a76 ("checkout: prevent losing staged changes with
--merge", 2019-03-22) from nd/checkout-m were included in git.git
despite the fact that the latter was meant to be v2 of the former.
The merge of these two topics resulted in a redundant chunk of code;
remove it.

Signed-off-by: Elijah Newren <newren@gmail.com>


---
 builtin/checkout.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 6123f732a2..dc61afa066 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -730,13 +730,6 @@ static int merge_working_tree(const struct checkout_opts *opts,
 				      "the following files:\n%s"), sb.buf);
 			strbuf_release(&sb);
 
-			if (repo_index_has_changes(the_repository,
-						   get_commit_tree(old_branch_info->commit),
-						   &sb))
-				warning(_("staged changes in the following files may be lost: %s"),
-					sb.buf);
-			strbuf_release(&sb);
-
 			/* Do more real merge */
 
 			/*
-- 
2.23.0.rc2.32.g2123e9e4e4

