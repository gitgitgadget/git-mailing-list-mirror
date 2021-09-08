Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C1EC433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 10:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60F5F61163
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 10:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243868AbhIHKsZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 06:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbhIHKsU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 06:48:20 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98CEC061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 03:47:09 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id s25so2324861edw.0
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 03:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Xx8f0nB+m+CB6J8t9VC+KEYIz29eyWmlYC5Z44o5p0c=;
        b=qEiJlv7qFNBJUTAYRKgkh/gjQS26brScFNTzTaf+e6oFRQ3vHKma39Li7gODmAiqQH
         8clOzPnTorHA0FGY0f8bxhefPdSJ9nPXOF/cV8iHJjoTxChUNi7wJ0k/K7tf4TvN/efo
         8UhxLX85mRPPgVr4jyhARX9arWzIPoWaV/nIZj5jutgQGuZX5ph8T2sw+9Qw+EMMBfot
         pCxZkNFPQeMWeN0jUzNMWgn8QUmyBgjG+S3FSPtt1FgMZHg49Q84/jZLEPiGTzD3sJQx
         c+1ydkutKuw4pOKYCcxOK9dceboIP1Xm5TGNUiZfPfd/R+iLIGOJnBVtTODDj6pjW7Br
         nwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Xx8f0nB+m+CB6J8t9VC+KEYIz29eyWmlYC5Z44o5p0c=;
        b=l8qULDQpO7ePD+uC6P1JaJQITLs7GnJoR+etLMPWA3osOxYuosWpGGmpDzJ05/8mCF
         Uh/zk6/EW+3uVyRQmgoRDnt9Ds0wMsWYNxCUiAfZBL/idgDijEJFe+bXzYEH38bJsnL8
         94XQd79mdX0bfleDHCYBwrI7/dypmdtZDTjmoHgDp/ZTmH2u4AMI/cDbh7wsShdN3AFk
         TPFu9kOIuouEdSkknV1C4tIrPGHF0xNEoh1Y3MrI8+4I9rf0iJT5Mmar2pLuok+zgig1
         V/NY6UUAMvpAuk9pfjVguJDttBtXVYjrfeMCy8NYxgwU3VKd574POlaBSMsV1TJyz3c8
         9vnA==
X-Gm-Message-State: AOAM532gdIooQNKPcWIGy/Pb6plTHaQhtHfa0vFDrWk4osL360/ytJw2
        QUdxf3RcaqzQkepAKRkA0cgmziQpC+Fdxg==
X-Google-Smtp-Source: ABdhPJwfq/L5j3NmGIjZguxN/p74yjjWkdqtVGF4312wmS2fFk1gK5BEXel0cWV8pirB7GuSLKEzUg==
X-Received: by 2002:a05:6402:b47:: with SMTP id bx7mr3228620edb.319.1631098028273;
        Wed, 08 Sep 2021 03:47:08 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id mb14sm816198ejb.81.2021.09.08.03.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 03:47:07 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 11/11] rebase: dereference tags
Date:   Wed, 08 Sep 2021 12:45:20 +0200
References: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
 <e87ce4fe2537fa5ab6cedec43dd8ffb241bfe5ce.1631094563.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <e87ce4fe2537fa5ab6cedec43dd8ffb241bfe5ce.1631094563.git.gitgitgadget@gmail.com>
Message-ID: <875yvbibtg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 08 2021, Phillip Wood via GitGitGadget wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Aborting a rebase stated with 'git rebase <upstream> <tag-object>'
> should checkout the commit pointed to by <tag-object>. Instead it gives
>
>     error: update_ref failed for ref 'HEAD': cannot update ref 'HEAD':
>     trying to write non-commit object
>     710d743b2b9892457fdcc3970f397e6ec07447e0 to branch 'HEAD'
>
> This is because when we parse the command line arguments although we
> check that the tag points to a commit we remember the oid of the tag
> and try and checkout that object rather than the commit it points
> to. Fix this by using lookup_commit_reference_by_name() when parsing
> the command line.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
> ---
>  builtin/rebase.c        | 18 +++++++++++-------
>  t/t3407-rebase-abort.sh | 18 ++++++++++++++----
>  2 files changed, 25 insertions(+), 11 deletions(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 93fcc0df2ad..8bf7660a24b 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1903,13 +1903,17 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  			die_if_checked_out(buf.buf, 1);
>  			options.head_name = xstrdup(buf.buf);
>  		/* If not is it a valid ref (branch or commit)? */
> -		} else if (!get_oid(branch_name, &options.orig_head) &&
> -			   lookup_commit_reference(the_repository,
> -						   &options.orig_head))
> -			options.head_name = NULL;
> -		else
> -			die(_("fatal: no such branch/commit '%s'"),
> -			    branch_name);
> +		} else {
> +			struct commit *commit =
> +				lookup_commit_reference_by_name(branch_name);
> +			if (commit) {
> +				oidcpy(&options.orig_head, &commit->object.oid);
> +				options.head_name = NULL;
> +			} else {
> +				die(_("fatal: no such branch/commit '%s'"),
> +				    branch_name);
> +			}
> +		}

Suggested style nit:

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 8bf7660a24b..c751ef866fd 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1906,13 +1906,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		} else {
 			struct commit *commit =
 				lookup_commit_reference_by_name(branch_name);
-			if (commit) {
-				oidcpy(&options.orig_head, &commit->object.oid);
-				options.head_name = NULL;
-			} else {
+			if (!commit)
 				die(_("fatal: no such branch/commit '%s'"),
 				    branch_name);
-			}
+
+			oidcpy(&options.orig_head, &commit->object.oid);
+			options.head_name = NULL;
 		}
 	} else if (argc == 0) {
 		/* Do not need to switch branches, we are already on it. */

I.e. handle the "die" case right away & skip the indenting of the
non-assert code.

(Also grepping around we could really use a fatal non-gentle version of
lookup_commit_reference_by_name(), but that's another more general
cleanup...)

>  	} else if (argc == 0) {
>  		/* Do not need to switch branches, we are already on it. */
>  		options.head_name =
> diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
> index 2f41b06e028..310cd0c736c 100755
> --- a/t/t3407-rebase-abort.sh
> +++ b/t/t3407-rebase-abort.sh
> @@ -11,18 +11,18 @@ test_expect_success setup '
>  	test_commit a a a &&
>  	git branch to-rebase &&
>  
> -	test_commit b a b &&
> -	test_commit c a c &&
> +	test_commit --annotate b a b &&
> +	test_commit --annotate c a c &&
>  
>  	git checkout to-rebase &&
>  	test_commit "merge should fail on this" a d d &&
> -	test_commit "merge should fail on this, too" a e pre-rebase
> +	test_commit --annotate "merge should fail on this, too" a e pre-rebase
>  '
>  
>  # Check that HEAD is equal to "pre-rebase" and the current branch is
>  # "to-rebase"
>  check_head() {
> -	test_cmp_rev HEAD pre-rebase &&
> +	test_cmp_rev HEAD pre-rebase^{commit} &&
>  	test "$(git symbolic-ref HEAD)" = refs/heads/to-rebase
>  }
>  
> @@ -67,6 +67,16 @@ testrebase() {
>  		test_path_is_missing "$state_dir"
>  	'
>  
> +	test_expect_success "rebase$type --abort when checking out a tag" '
> +		test_when_finished "git symbolic-ref HEAD refs/heads/to-rebase" &&
> +		git reset --hard a -- &&
> +		test_must_fail git rebase$type --onto b c pre-rebase &&
> +		test_cmp_rev HEAD b^{commit} &&
> +		git rebase --abort &&
> +		test_cmp_rev HEAD pre-rebase^{commit} &&
> +		! git symbolic-ref HEAD
> +	'
> +
>  	test_expect_success "rebase$type --abort does not update reflog" '
>  		# Clean up the state from the previous one
>  		git reset --hard pre-rebase &&

This whole series looks good to me, left some comments on other
patches. Consider the above suggested squash highly optional :)
