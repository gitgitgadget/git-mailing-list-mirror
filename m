Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBCEC43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 10:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B1C920757
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 10:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVVAxYbs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgDCK4o (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 06:56:44 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39370 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbgDCK4o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 06:56:44 -0400
Received: by mail-qt1-f195.google.com with SMTP id f20so6023112qtq.6
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 03:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P7tPfNvNamse5uORaaE+UWvPE5N6kPw+sJu1/ndUtIM=;
        b=WVVAxYbsVjgilcmjRWCc/MTOoIr0fZO3nOCZiPv3oYkfbK3NCMYjbrJXjYfZowb/DX
         t/xezcO8zI7WHPS3CN/TpM+Ipo5bsvF/c774wef4DfsvEyTkdG3o8QfyXkbKq05MPGUn
         PB7bnPJ6FbN/rqaW0pWFG9qH5/v9gEyoBI8APOzsLDBsnX/L9K0WOyvJ7yGxTy3HycT4
         EEDF4rZBBqyH+hdpRWfrqfuOxw4XlwDQCscTvv6aB1Guv8MSSGeSEg326Z3eu1PYTdFp
         fCq10yUXKQ4yJpmjIgST12A4g7D1R1RxVn70fvpw2PZoGab33JXujsiVjzJjkCqFSNfQ
         9Z5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P7tPfNvNamse5uORaaE+UWvPE5N6kPw+sJu1/ndUtIM=;
        b=oSznVoAabYg1YGulQAZ6C+PFX4JhYiY7gj/DunRlrKGANeQKy1Eh+40RkNw+0Vwe5M
         b2sYvBhfK7pFwBkXwjE9TNtUozH0sSdM+uB/oZVvTXYYEqf/iP7mqmEcUIiPT1+WRbfT
         08cte9N+9fxBzsZoBufkHiv4Kl0ymjgQvxtpurmiRkYRsFgcNDqywkcFDdi0LWZN3IQP
         P15SCGFZQJcNoRY6TqZmwQ6zj0+N4kDFM1xfZgCALq5576KDpfujRL6e0ryWkVGvXUB+
         /7m0eAfW1lnqMAh6Fz6cjBryxY5LA0Qlc1ANZGcmS5L4zEFjM8RpwzaR2hOTuehC2Itz
         9VxA==
X-Gm-Message-State: AGi0PubWq57p7DH6+DT3X9FvsxszhY4pDGwKs+hS3jyRtkpPO/wQHG3f
        FUpwUsMPUk6rnDV+/Lp030Y=
X-Google-Smtp-Source: APiQypJPktUnC+xxzOYSAA1OhRAo5ZAljUS0R+tywDY8AQ9zo2o+i4d+bq05hjGjaoYJHGNnRaTB/g==
X-Received: by 2002:ac8:6edc:: with SMTP id f28mr7519767qtv.271.1585911402305;
        Fri, 03 Apr 2020 03:56:42 -0700 (PDT)
Received: from generichostname ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id q5sm5983746qkq.17.2020.04.03.03.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 03:56:41 -0700 (PDT)
Date:   Fri, 3 Apr 2020 06:56:39 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Git Mailing List <git@vger.kernel.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 17/19] merge: teach --autostash option
Message-ID: <20200403105639.GA3193506@generichostname>
References: <cover.1577185374.git.liu.denton@gmail.com>
 <cover.1584782450.git.liu.denton@gmail.com>
 <9e3d4393cae8813cc4718c6ffcc28231b1344fbe.1584782450.git.liu.denton@gmail.com>
 <cd7cb5aa-0a08-29dc-e1cc-f65a4010622f@gmail.com>
 <20200403103126.GA3163329@generichostname>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403103126.GA3163329@generichostname>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 03, 2020 at 06:31:26AM -0400, Denton Liu wrote:
> > > diff --git a/builtin/reset.c b/builtin/reset.c
> > > index 18228c312e..038c8532eb 100644
> > > --- a/builtin/reset.c
> > > +++ b/builtin/reset.c
> > > @@ -25,6 +25,7 @@
> > >   #include "cache-tree.h"
> > >   #include "submodule.h"
> > >   #include "submodule-config.h"
> > > +#include "sequencer.h"
> > >   #define REFRESH_INDEX_DELAY_WARNING_IN_MS (2 * 1000)
> > > @@ -437,8 +438,12 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
> > >   		if (reset_type == HARD && !update_ref_status && !quiet)
> > >   			print_new_head_line(lookup_commit_reference(the_repository, &oid));
> > >   	}
> > > -	if (!pathspec.nr)
> > > +	if (!pathspec.nr) {
> > > +		if (reset_type == HARD)
> > > +			save_autostash(git_path_merge_autostash(the_repository));
> > > +
> > >   		remove_branch_state(the_repository, 0);
> > 
> > This removes the autostash file for all reset types but we only keep the
> > stash in the case of 'reset --hard' which is confusing.
> 
> I was worried that this change would be controversial... The rationale
> behind this change was that with `reset --hard`, we want to leave a
> clean working tree behind so we save it into the stash reflog. In all
> other cases, remove_branch_state() will apply the saved stash entry
> which should be fine since users don't expect a clean worktree with the
> other reset types.
> 
> I considered saving the autostash in all cases of reset but
> `git merge --abort` invokes `git reset --merge` behind the scenes so
> we'd have to consider that. Perhaps we can make all resets save the
> stash entry and, in the case of `merge --abort`, we can add some extra
> logic to subvert this so that the stash entry is applied?

Perhaps something like this?

-- >8 --
commit 14d0b569cb7675f00d32d3d7fad7564fcaeca458
Author: Denton Liu <liu.denton@gmail.com>
Date:   Fri Apr 3 06:50:34 2020 -0400

    squash! merge: teach --autostash option
    
    Stash is saved when any reset is run, when git merge --abort is run,
    stash is applied.

diff --git a/builtin/merge.c b/builtin/merge.c
index 9573d77096..31b82d614c 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1242,6 +1242,8 @@ static int merging_a_throwaway_tag(struct commit *commit)
 	return is_throwaway_tag;
 }
 
+static GIT_PATH_FUNC(git_path_merge_autostash_saved, "MERGE_AUTOSTASH_SAVED")
+
 int cmd_merge(int argc, const char **argv, const char *prefix)
 {
 	struct object_id result_tree, stash, head_oid;
@@ -1295,9 +1297,16 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		if (!file_exists(git_path_merge_head(the_repository)))
 			die(_("There is no merge to abort (MERGE_HEAD missing)."));
 
+		if (file_exists(git_path_merge_autostash(the_repository))) {
+			if (rename(git_path_merge_autostash(the_repository),
+						git_path_merge_autostash_saved()))
+				die_errno(_("failed to rename autostash"));
+		}
+
 		/* Invoke 'git reset --merge' */
 		ret = cmd_reset(nargc, nargv, prefix);
-		apply_autostash(git_path_merge_autostash(the_repository));
+
+		apply_autostash(git_path_merge_autostash_saved());
 		goto done;
 	}
 
diff --git a/builtin/reset.c b/builtin/reset.c
index 038c8532eb..060470c455 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -439,9 +439,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 			print_new_head_line(lookup_commit_reference(the_repository, &oid));
 	}
 	if (!pathspec.nr) {
-		if (reset_type == HARD)
-			save_autostash(git_path_merge_autostash(the_repository));
-
+		save_autostash(git_path_merge_autostash(the_repository));
 		remove_branch_state(the_repository, 0);
 	}
 
> 
> I'm not sure about what the most intuitive behaviour is. I thought that
> this implementation would be the best but I'm not entirely sure. I'd
> appreciate some more discussion on this.
> 
> Thanks,
> 
> Denton
> 
> > Best Wishes
> > 
> > Phillip
> > 
> > > +	}
> > >   	return update_ref_status;
> > >   }
