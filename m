Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CA2C7EE22
	for <git@archiver.kernel.org>; Thu, 11 May 2023 22:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239431AbjEKWIH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 18:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239506AbjEKWHs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 18:07:48 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6D593D7
        for <git@vger.kernel.org>; Thu, 11 May 2023 15:07:34 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-541fb831026so3067027eaf.3
        for <git@vger.kernel.org>; Thu, 11 May 2023 15:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683842854; x=1686434854;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wacibTOk8jv0wWkxNwvv+EjAoOJFp0LnEBnB+QPqlzc=;
        b=pNTzfzhnfo5MTe0b8jfs5XmdRR/nmd/dfsP5tiOI1NJ41vJf3NB1rtYhtCeB0xYgph
         CTIXALCabOpdDeBmXmNg4Ho2RYdFDQYpKOg/qdexNoHZpJniH+qB6D4wp625F0A8wypN
         tioTGZlyvPrRRdctwAfGgQIklpAF4Zq+TepOq7yIT7Ea1uKKrW8l6bFdGXsexwe6WnwL
         OeFfNiwV2DcdYnb/wYu0PTvY/l4kVAXF6bq1tRG908jCZDGNuLI2o4xmWqesoC6/j6s8
         uFp6TLwkkr9i1Jv3FGas6hpih0gAGeC3bP5JzrGchriel9bQCs5vETcYFL60YbVG332+
         d0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683842854; x=1686434854;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wacibTOk8jv0wWkxNwvv+EjAoOJFp0LnEBnB+QPqlzc=;
        b=VbFahJBAUjiWjvHQGN/t+RDE6V/rG43Gly8ervpLcWtVBG7K1jyxP1yPccBV+krhSG
         tl0HyLT78xLOGRx7DjzNJg2EJ3CuvtkimjPO2/tVXHxHcusSSoT9L4ru8JcumKBiKSoc
         GQSkCn6wIqbGexo3PEpeAROel7Z3N3/Xhl9k4v2mbq2rd1xfti6Qg3ccfYJyRZt3ooJ9
         sFC2jqCrzh8wy4O0ruLovbzzadyPqlUzjPbkI7azjJQYBKj7fOmtAFx0HGDGj9OQDvGn
         Ewao41HOm6Ta24Nve2LPNdIYbla8QJcieIxSnZDAmGHeT7r56eD5uCy8PfeE2N2H7U6n
         wdcg==
X-Gm-Message-State: AC+VfDzhJsfoyU9Vq6kdnidyES+IVd+Ug3G3cEODqxK7UrfsWXQNm1Y+
        Q/rNQOWvPCxan6BIAZcgm/4=
X-Google-Smtp-Source: ACHHUZ5TlZTbzneGHlGFoT/CHq+fLqB32kndtOSKNsBMBnQ2WLqU4g5A6LIzohSWDqFlYiv/CmiqjQ==
X-Received: by 2002:a4a:271a:0:b0:54f:8540:d05a with SMTP id l26-20020a4a271a000000b0054f8540d05amr4660366oof.8.1683842853719;
        Thu, 11 May 2023 15:07:33 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:e8a3:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id w14-20020a4ac18e000000b00541854ce607sm7618360oop.28.2023.05.11.15.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 15:07:33 -0700 (PDT)
Date:   Thu, 11 May 2023 16:07:32 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, christian.couder@gmail.com
Message-ID: <645d672447ebb_13d3fe294f@chronos.notmuch>
In-Reply-To: <015dcb79-9630-e188-65cf-23b005184db1@github.com>
References: <pull.1530.git.1683745654800.gitgitgadget@gmail.com>
 <645bfed357efc_3819294e1@chronos.notmuch>
 <015dcb79-9630-e188-65cf-23b005184db1@github.com>
Subject: Re: [PATCH] merge-tree: load default git config
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee wrote:
> On 5/10/2023 4:30 PM, Felipe Contreras wrote:
> > Derrick Stolee via GitGitGadget wrote:
> >> From: Derrick Stolee <derrickstolee@github.com>
> >>
> >> The 'git merge-tree' command handles creating root trees for merges
> >> without using the worktree. This is a critical operation in many Git
> >> hosts, as they typically store bare repositories.
> >>
> >> This builtin does not load the default Git config, which can have
> >> several important ramifications.
> > 
> > For the record, I had already sent a better version of this patch almost 2
> > years ago [1], not just for `git merge-tree`, but other commands as well.
> > 
> > The obvious fix was completely ignored by the maintainer.
> > 
> > The reason why it should be git_xmerge_config and not git_default_config, is
> > that merge.conflictstyle would not be parsed if you call git_default_config.
> 
> As mentioned by Elijah in a different thread, the merge machinery loads
> the merge config as needed. I confirmed by creating this test, which I
> may submit as an independent patch:

I wrote my patches before Elijah wrote the real merge implementation, and in
his function he does `init_merge_options()`, which eventually calls
`git_config(git_xmerge_config, NULL)`.

But if `git_config()` is already called, you shouldn't need to add yet another
`git_config()` call.

The problem is that he added `init_merge_options()` *after* the
`get_merge_parent()` calls, that's why the configuration is ignored.

If we move `init_merge_options()` to the right place, the problem is fixed:

--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -424,6 +424,8 @@ static int real_merge(struct merge_tree_options *o,
 	struct merge_result result = { 0 };
 	int show_messages = o->show_messages;
 
+	init_merge_options(&opt, the_repository);
+
 	parent1 = get_merge_parent(branch1);
 	if (!parent1)
 		help_unknown_ref(branch1, "merge-tree",
@@ -434,8 +436,6 @@ static int real_merge(struct merge_tree_options *o,
 		help_unknown_ref(branch2, "merge-tree",
 				 _("not something we can merge"));
 
-	init_merge_options(&opt, the_repository);
-
 	opt.show_rename_progress = 0;
 
 	opt.branch1 = branch1;

I ran your test case, and it passes.

I sent a patch for that here:

https://lore.kernel.org/git/20230511215608.1297686-1-felipe.contreras@gmail.com/

This is a more proper fix because a) it doesn't add any new line of code, b) it
doesn't add a new include, and c) it doesn't call `git_config()` twice.

Cheers.

-- 
Felipe Contreras
