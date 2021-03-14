Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3DFC433E0
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 13:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC5DD64EC4
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 13:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbhCNNqr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Mar 2021 09:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhCNNqO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Mar 2021 09:46:14 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C21C061574
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 06:46:13 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id mj10so61880014ejb.5
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 06:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:date:message-id
         :in-reply-to:mime-version;
        bh=SCOOv5yqydYtx2qH7AnwGu5mxDTUHb88NMUnsdYDW0I=;
        b=AI0Bw4lW9V/zaV6Ntj6y4AwLp4TlX3wtbrMlyIAdkA0xubbJsQtRILGqh1QYQPkOry
         wk8t26qMasbZVg7ckqljGDuwe0xWDMuPuJMHgVkQKP0zzBaiWfLbGvw36MROfiLfG2jS
         tUwe+WzX6snC1q/HGnBDsQv06otO2RYvq/cddxz+EVxXbmqGZQe++Uhu/fkbtzRqhQsc
         4TLeWvMf6jHCPnOKSIUpIBEXMCnwwBmSqRq7Aml2a3OUzvZNEb+yASTrbeYmJdK8nCRu
         j7AfeOf3jzU4gaevbKu3r08TV7JCTl4DoGUjisC3W6ovOO7x7iBSZ2vY6Jk4meFBJQ6k
         bRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :message-id:in-reply-to:mime-version;
        bh=SCOOv5yqydYtx2qH7AnwGu5mxDTUHb88NMUnsdYDW0I=;
        b=Ho32FXD1Xenm6dGG+WbpSowsM8VPbEE/xwM3f8tut3XWQIDn96VZ0hZ42Eq/SFKQle
         fnH40darO/qIaWJKNhI6ML6JNUTvb3k3DCbHtJr7AsTTEaUe3RkYmzLhTRD874z0vf+1
         X9jEM2yL5lG/h9M70nSpumAJAUxSlHzdb7gEzazDIXtbCznPod/KZ2R+0L4UhnKhCjyj
         E2HCAHqgIj+f00kArDu3DKIs5qz/KnneEljfpCcMjK8qXNZSwIjFRtlKk97ZLDI6Wq5I
         pHO4FUFqPQPJ3y7SRAEpkYqeW6I3qLWLrZrEg4U1q7+85EA/Rq1WNfL+3Ld9oxGemNNN
         7vXA==
X-Gm-Message-State: AOAM532spslW3zr301CPB2RomuwN+1ycQw01BwCeBhWp6+MUvHUhPpXH
        2UrKRrD/gThBxQOjfUTL9Tg=
X-Google-Smtp-Source: ABdhPJxE8JVolE2tZHilMv5Xxjh2C33ocoSCBbE+nHtRONuMYCw38NULAuFSmXgVVZCpVMQ6YOu+cA==
X-Received: by 2002:a17:906:f1d6:: with SMTP id gx22mr18823523ejb.59.1615729571842;
        Sun, 14 Mar 2021 06:46:11 -0700 (PDT)
Received: from archlinux ([79.140.115.129])
        by smtp.gmail.com with ESMTPSA id e8sm6419780edq.77.2021.03.14.06.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 06:46:11 -0700 (PDT)
References: <pull.901.v2.git.1615564478029.gitgitgadget@gmail.com>
 <pull.901.v3.git.1615726978059.gitgitgadget@gmail.com>
User-agent: mu4e 1.5.10; emacs 27.1
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v3] [GSOC] commit: add --trailer option
Date:   Sun, 14 Mar 2021 13:10:33 +0000
Message-ID: <87czw1yj6q.fsf@gmail.com>
In-reply-to: <pull.901.v3.git.1615726978059.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/builtin/commit.c b/builtin/commit.c
> index 739110c5a7f6..abbd136b27f0 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -113,6 +113,8 @@ static int config_commit_verbose = -1; /* unspecified */
>  static int no_post_rewrite, allow_empty_message, pathspec_file_nul;
>  static char *untracked_files_arg, *force_date, *ignore_submodule_arg, *ignored_arg;
>  static char *sign_commit, *pathspec_from_file;
> +struct child_process run_trailer = CHILD_PROCESS_INIT;
> +static const char *trailer;
>  
>  /*
>   * The default commit message cleanup mode will remove the lines
> @@ -131,6 +133,17 @@ static struct strbuf message = STRBUF_INIT;
>  
>  static enum wt_status_format status_format = STATUS_FORMAT_UNSPECIFIED;
>  
> +static int opt_pass_trailer(const struct option *opt, const char *arg, int unset)
> +{
> +	if (unset) {
> +		strvec_clear(&run_trailer.args);
> +		return -1;
> +	}
> +	run_trailer.git_cmd = 1;
> +	strvec_pushl(&run_trailer.args, "--trailer", arg, NULL);
> +	return 0;
> +}
> +
>  static int opt_parse_porcelain(const struct option *opt, const char *arg, int unset)
>  {
>  	enum wt_status_format *value = (enum wt_status_format *)opt->value;
> @@ -958,6 +971,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  
>  	fclose(s->fp);
>  
> +	run_command(&run_trailer);
> +

There is slight problem with running the command unconditionally.
If no --trailer is passed, then the opt_pass_trailer() backend
is never called, which consequently will not set the trailer
command ".git_cmd" option to 1.

This will lead the run_command() API to not interpret the command as git
internal, and attempt to launch as an usual command "interpret-trailers"
that will likely not exist or launch an unwanted command that is not
part of the GIT suite.

This can be seen by running `git commit` without any options:

     $ ./bin-wrappers/git -C /tmp/test commit
     error: cannot run interpret-trailers: No such file or directory
     ...

The `.git_cmd` should be set to true before running the command.

(the above output is from a built version with v2.31.0-rc2 + this patch
 for confirmation).


Furthermore, in my opinion, we shouldn't even bother to run the command
if no --trailer is passed, otherwise, we always be paying the cost of
launching an OS process regardless if the user doesn't want to add
trailers in theirs projects.

With that said and based on this current implementation, maybe an
improved version will look like:

        if (run_trailer.args.nr) {
                run_trailer.git_cmd = 1;
                run_command(&run_trailer);
        }

Naturally the `git_cmd = 1` will be removed from opt_pass_trailer()
function as it won't be necessary. As minor bonus, we don't end up
setting the value for every new --trailer :).

>  	/*
>  	 * Reject an attempt to record a non-merge empty commit without
>  	 * explicit --allow-empty. In the cherry-pick case, it may be
> @@ -1507,6 +1522,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  		OPT_STRING(0, "fixup", &fixup_message, N_("commit"), N_("use autosquash formatted message to fixup specified commit")),
>  		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autosquash formatted message to squash specified commit")),
>  		OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit is authored by me now (used with -C/-c/--amend)")),
> +		OPT_CALLBACK(0, "trailer", &trailer, N_("trailer"), N_("trailer(s) to add"), opt_pass_trailer),
>  		OPT_BOOL('s', "signoff", &signoff, N_("add a Signed-off-by trailer")),
>  		OPT_FILENAME('t', "template", &template_file, N_("use specified template file")),
>  		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
> @@ -1577,6 +1593,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  			die(_("could not parse HEAD commit"));
>  	}
>  	verbose = -1; /* unspecified */
> +	strvec_pushl(&run_trailer.args, "interpret-trailers",
> +		"--in-place", "--where=end", git_path_commit_editmsg(), NULL);

Style: The "--in-place" part should be aligned with the parentheses
much the like the following line with the "argc = parse_and_validate_options....".

For example:

	strvec_pushl(&run_trailer.args, "interpret-trailers",
		     "--in-place", "--where=end", .....

>  	argc = parse_and_validate_options(argc, argv, builtin_commit_options,
>  					  builtin_commit_usage,
>  					  prefix, current_head, &s);
> diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
> index 6396897cc818..4b9ac4587d17 100755
> --- a/t/t7502-commit-porcelain.sh
> +++ b/t/t7502-commit-porcelain.sh
> @@ -154,6 +154,26 @@ test_expect_success 'sign off' '
>  
>  '
>  
> +test_expect_success 'trailer' '
> +	>file1 &&
> +	git add file1 &&
> +	git commit -s --trailer "Signed-off-by:C O Mitter1 <committer1@example.com>" \
> +	--trailer "Helped-by:C O Mitter2 <committer2@example.com>"  \
> +	--trailer "Reported-by:C O Mitter3 <committer3@example.com>" \
> +	--trailer "Mentored-by:C O Mitter4 <committer4@example.com>" \
> +	-m "hello" &&

Perhaps here, the --trailer lines and "-m hello" option should be
indent in order to make it clear that these option are part of the
"git commit" from the above line, something like this:

	git commit -s --trailer "Signed-off-by:C O Mitter1 <committer1@example.com>" \
	        --trailer "Helped-by:C O Mitter2 <committer2@example.com>"  \
	        --trailer "Reported-by:C O Mitter3 <committer3@example.com>" \
	        --trailer "Mentored-by:C O Mitter4 <committer4@example.com>" \
	        -m "hello" &&

> +	git cat-file commit HEAD >commit.msg &&
> +	sed -e "1,7d" commit.msg >actual &&
> +	cat >expected <<-\EOF &&
> +	Signed-off-by: C O Mitter <committer@example.com>
> +	Signed-off-by: C O Mitter1 <committer1@example.com>
> +	Helped-by: C O Mitter2 <committer2@example.com>
> +	Reported-by: C O Mitter3 <committer3@example.com>
> +	Mentored-by: C O Mitter4 <committer4@example.com>
> +	EOF
> +	test_cmp expected actual
> +'
> +
>  test_expect_success 'multiple -m' '


Hope these comments are useful.
-- 
Thanks
Rafael
