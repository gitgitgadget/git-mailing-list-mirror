Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EC4C433E0
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 05:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 259B064F55
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 05:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhBDFvK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 00:51:10 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60732 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhBDFvJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 00:51:09 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E0909AF7F9;
        Thu,  4 Feb 2021 00:50:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zFJ8IzKSb5kAVYW04YvkAeGBct0=; b=MItKIt
        kw+lOVtM5D8AO7C8XZrjf8iOTNSFaOjtu6Zk8CjMBAIi4BcWH+2nGCiZS2G/s3fw
        v+bhdHIz8GRBRBFm6lEGTDj3DY1SJVgDshbKGAKmSVvMxwqPi9NoCTJBHBPLvKnk
        DAIzHslJkXKp+hNMTCxPG5qG6KhIwF9Ma4ozw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cPUMqFkiw9nVutwh1F1bVXpUypdNiL5D
        oB6uAKnM67UJqoMHyU72m9vaduAsM89iYgkYCcF+fnFRUc6AeIWYdG6kRtlUGV+C
        VSfn0ni5MlKyiGIM7VPiCiq/n0DRnHNs0LFQIFV9ceplYcmQmeu7ELDO/GLhZD62
        mgP8qIwFxUU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D80A4AF7F8;
        Thu,  4 Feb 2021 00:50:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6009CAF7F7;
        Thu,  4 Feb 2021 00:50:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        dscho <johannes.schindelin@gmx.de>,
        Li Linchao <lilinchao@oschina.cn>
Subject: Re: [PATCH] builtin/clone.c: add --no-shallow option
References: <pull.865.git.1612409491842.gitgitgadget@gmail.com>
Date:   Wed, 03 Feb 2021 21:50:24 -0800
In-Reply-To: <pull.865.git.1612409491842.gitgitgadget@gmail.com> (Li Linchao
        via GitGitGadget's message of "Thu, 04 Feb 2021 03:31:31 +0000")
Message-ID: <xmqq35yc9yan.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E0A26A62-66AC-11EB-B2DD-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Li Linchao via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: lilinchao <lilinchao@oschina.cn>
>
> This patch add a new option that reject to clone a shallow repository.

A canonical form of our log message starts by explaining the need,
and then presents the solution at the end.

> Clients don't know it's a shallow repository until they download it
> locally, in some scenariors, clients just don't want to clone this kind

"scenarios".  "in some scenarios" would have to be clarified a bit
more to justify why it is a good idea to have such a feature.

> of repository, and want to exit the process immediately without creating
> any unnecessary files.

"clients don't know it's a shallow repository until they download"
leading to "so let's reject immediately upon finding out that they
are shallow" does make sense as a flow of thought, though.

> +--no-shallow::
> +	Don't clone a shallow source repository. In some scenariors, clients

"scenarios" (no 'r').

> diff --git a/builtin/clone.c b/builtin/clone.c
> old mode 100644
> new mode 100755

Unwarranted "chmod +x"; accidents do happen, but please be careful
before making what you did public ;-)

> @@ -90,6 +91,7 @@ static struct option builtin_clone_options[] = {
>  	OPT__VERBOSITY(&option_verbosity),
>  	OPT_BOOL(0, "progress", &option_progress,
>  		 N_("force progress reporting")),
> +	OPT_BOOL(0, "no-shallow", &option_no_shallow, N_("don't clone shallow repository")),
>  	OPT_BOOL('n', "no-checkout", &option_no_checkout,
>  		 N_("don't create a checkout")),
>  	OPT_BOOL(0, "bare", &option_bare, N_("create a bare repository")),

It is a bad idea to give a name that begins with "no-" to an option
whose default can be tweaked by a configuration variable [*].  If
the configuration is named "rejectshallow", perhaps it is better to
call it "--reject-shallow" instead.

This is because configured default must be overridable from the
command line.  I.e. even if you have in your ~/.gitconfig this:

    [clone]
        rejectshallow = true

you should be able to say "allow it only this time", with

    $ git clone --no-reject-shallow http://github.com/git/git/ git

and you do not want to have to say "--no-no-shallow", which sounds
just silly.

	Side note. it is a bad idea in general, even if the option
	does not have corresponding configuration variable.  The
	existing "no-checkout" is a historical accident that
	happened long time ago and cannot be removed due to
	compatibility.  Let's not introduce a new option that
	follows such a bad pattern.

> @@ -963,6 +968,7 @@ static int path_exists(const char *path)
>  int cmd_clone(int argc, const char **argv, const char *prefix)
>  {
>  	int is_bundle = 0, is_local;
> +	int is_shallow = 0;
>  	const char *repo_name, *repo, *work_tree, *git_dir;
>  	char *path, *dir, *display_repo = NULL;
>  	int dest_exists, real_dest_exists = 0;
> @@ -1215,6 +1221,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  		if (filter_options.choice)
>  			warning(_("--filter is ignored in local clones; use file:// instead."));
>  		if (!access(mkpath("%s/shallow", path), F_OK)) {
> +			is_shallow = 1;
>  			if (option_local > 0)
>  				warning(_("source repository is shallow, ignoring --local"));
>  			is_local = 0;

This change is to the local clone codepath.  Cloning over the wire
would not go through this part.  And throughout the patch, this is
the only place that sets is_shallow to 1.

Also let's note that this is after we called parse_options(), so the
value of option_no_shallow is known at this point.

So, this patch does not even *need* to introduce a new "is_shallow"
variable at all.  It only needs to add

                        if (option_no_shallow)
                                die(...);

instead of adding "is_shallow = 1" to the above hunk.

I somehow think that this is only half a feature---wouldn't it be
more useful if we also rejected a non-local clone from a shallow
repository?

And for that ...


> diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
> index 7f082fb23b6a..9d310dbb158a 100755
> --- a/t/t5606-clone-options.sh
> +++ b/t/t5606-clone-options.sh
> @@ -42,6 +42,13 @@ test_expect_success 'disallows --bare with --separate-git-dir' '
>  
>  '
>  
> +test_expect_success 'reject clone shallow repository' '
> +	git clone --depth=1 --no-local parent shallow-repo &&
> +	test_must_fail git clone --no-shallow shallow-repo out 2>err &&
> +	test_i18ngrep -e "source repository is shallow, reject to clone." err
> +
> +'
> +

... in addition to the test for a local clone above, you'd also want
to test a non-local clone, perhaps like so:

test_expect_success 'reject clone shallow repository' '
	rm -fr shallow-repo &&
	git clone --depth=1 --no-local parent shallow-repo &&
	test_must_fail git clone --no-shallow --no-local shallow-repo out 2>err &&
	test_i18ngrep -e "source repository is shallow, reject to clone." err

'

Ditto for the other test script.

Also, you would want to make sure that the command line overrides
the configured default.  I.e.

	git -c clone.rejectshallow=false clone --reject-shallow

should refuse to clone from a shallow one, while there should be a
way to countermand a configured "I always refuse to clone from a
shallow repository" with "but let's allow it only this time", i.e.

	git -c clone.rejectshallow=true clone --no-reject-shallow

or something along the line.


> diff --git a/t/t5611-clone-config.sh b/t/t5611-clone-config.sh
> index 8e0fd398236b..3aab86ad4def 100755
> --- a/t/t5611-clone-config.sh
> +++ b/t/t5611-clone-config.sh
> @@ -92,6 +92,13 @@ test_expect_success 'clone -c remote.<remote>.fetch=<refspec> --origin=<name>' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'clone -c clone.rejectshallow' '
> +	rm -rf child &&
> +	git clone --depth=1 --no-local . child &&
> +	test_must_fail git clone -c clone.rejectshallow child out 2>err &&

This is not quite right, even though it may happen to work.  The
"clone.rejectshallow" variable is a configuration about what should
happen when creating a new repository by cloning, so letting "git
clone -c var[=val]" to set the variable _in_ the resulting repository
would not make much sense.  Even if the clone succeeded, nobody would
look at that particular configuration variable that is set in the
resulting repository.

I think it would communicate to the readers better what we are
trying to do, if we write

	test_must_fail git -c clone.rejectshallow=true clone child out

instead.

Thanks.
