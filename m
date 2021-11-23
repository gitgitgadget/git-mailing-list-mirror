Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57083C433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 13:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbhKWNUr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 08:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbhKWNUq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 08:20:46 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BDCC061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 05:17:38 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id w1so92119684edc.6
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 05:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=DVuBqzzmdVvL9+emk6ts+/6l/T4ehIexmqDntGaQd5Q=;
        b=gth5+4WwFYXmyYQPRkidFXfFcd2YhF65B5QiO1BUV0l6geavRPemuAGFLXzqX182jP
         AqWAyphQ1mlT4ImwmjVrLvRsQhhIfjiwhe24nkxAnlEElQBy7zx06KxJ4ThuDBWCX36/
         FhqJUKiVD3g+opdsFYlEVUkOOBbpQ73RQVJsKCTLpn/MGNE3Bi4lAlhkYqza9pkjWBjb
         qdtbZbbgwdxZ+Y8khrEHB9Hh0XAPN+Xzued/9VB13L8G/HsETGO38Ojx/JMaFaEakXMY
         qW6D1bramW7H1xNswC2dSbTOH6hnIPIhn3BIn7+brWS2RlbkyNpO2c6jMOdmNqfX5nxU
         M9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=DVuBqzzmdVvL9+emk6ts+/6l/T4ehIexmqDntGaQd5Q=;
        b=5SL83JwsIoIbnU4RDI6wpTiUULruZcZvLOcr9YxHwqUVCvw3UQcIGkUVq9v1PDgWHf
         hJYi9BFVVXKQFAFIN2k/JnfT8cUX6b7PWhklmYllFwup2eHhtGLm9Nv267JbSkhRirIk
         GY/+QVas90H3lbJUpI9H+SI80na7myQVZ2eQB44N1H3pknaEOLsm122WApUYBESPnQkE
         XrIg5ZzZQa/IBp2Kj9LyzFfdf2WJZsCjuxVcbQN3gnyu3/u6vgMZ7+/APJMKpTJ3ZGbJ
         tJh/Uk1bMz3QcfsImVZowSg9aXGsKwBe8bmtDaJKm1AlW/eirb9f+OmKorYLAatcqPwP
         UXIA==
X-Gm-Message-State: AOAM530j1bjdKZ74m6gSMXaSdSOa2hcFzoJ5cHSKtYX4eu5NgRYJtVS9
        py2GVUvatVLPoAsVDyB/LV4=
X-Google-Smtp-Source: ABdhPJzeyOppITdaloA+PgWcWuru7cV2OuFJiDyopV7zwCWVHDHu9UM7mTR33ZdXkLjuzA1ACbk5xQ==
X-Received: by 2002:a17:906:81cb:: with SMTP id e11mr7470211ejx.186.1637673457083;
        Tue, 23 Nov 2021 05:17:37 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ar4sm5161167ejc.52.2021.11.23.05.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 05:17:36 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mpVfz-001NRT-Qj;
        Tue, 23 Nov 2021 14:17:35 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     William Sprent via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, William Sprent <williams@unity3d.com>
Subject: Re: [PATCH] fast-export: fix surprising behavior with --first-parent
Date:   Tue, 23 Nov 2021 14:07:26 +0100
References: <pull.1084.git.1637666927224.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <pull.1084.git.1637666927224.gitgitgadget@gmail.com>
Message-ID: <211123.865ysjui34.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 23 2021, William Sprent via GitGitGadget wrote:

> From: William Sprent <williams@unity3d.com>
>
> When invoking git-fast-export with the --first-parent flag on a branch
> with merges, fast-export would early-out on processing the first merge
> on the branch. If combined with --reverse, fast-export would instead
> output all single parent commits on the branch.
>
> This commit makes fast-export output the same commits as rev-list
> --first-parent, and makes --reverse not have an effect on which commits
> are output.
>
> The fix involves removing logic within fast-export which was responsible
> for ensuring that parents are processed before their children, which was
> what was exiting early due to missing second parents. This is replaced
> by setting 'reverse = 1' before revision walking, which, in conjuction
> with topo_order, allows for delegating the ordering of commits to
> revision.c. The reverse flag is set after parsing rev-list arguments to
> avoid having it disabled.
>
> Signed-off-by: William Sprent <williams@unity3d.com>
> ---
>     fast-export: fix surprising behavior with --first-parent
>     
>     Hi,
>     
>     This is my first time patching git, so I probably need some guidance on
>     my approach. :)

Hi, thanks for your first contribution to git. This is a rather shallow
review, a deeper one is much deserved.

I notice that you're removing code in builtin/fast-export.c, presumably
we have code in revision.c that does the same thing. It would really
help a reviewer for you to dig a bit into the relevant commit history
and note it in the commit message.

I.e. could revision.c always do this, and this was always needless
duplication, or at time X it was needed, but as of Y revision.c learned
to do this, and callers A, B and C were adjusted, but just not this
missed call D? etc.

> -static int has_unshown_parent(struct commit *commit)
> -{
> -	struct commit_list *parent;
> -
> -	for (parent = commit->parents; parent; parent = parent->next)
> -		if (!(parent->item->object.flags & SHOWN) &&
> -		    !(parent->item->object.flags & UNINTERESTING))
> -			return 1;
> -	return 0;
> -}
> -
>  struct anonymized_entry {
>  	struct hashmap_entry hash;
>  	const char *anon;
> @@ -752,20 +740,6 @@ static char *anonymize_tag(void *data)
>  	return strbuf_detach(&out, NULL);
>  }
>  
> -static void handle_tail(struct object_array *commits, struct rev_info *revs,
> -			struct string_list *paths_of_changed_objects)
> -{
> -	struct commit *commit;
> -	while (commits->nr) {
> -		commit = (struct commit *)object_array_pop(commits);
> -		if (has_unshown_parent(commit)) {
> -			/* Queue again, to be handled later */
> -			add_object_array(&commit->object, NULL, commits);
> -			return;
> -		}
> -		handle_commit(commit, revs, paths_of_changed_objects);
> -	}
> -}

...

>  static void handle_tag(const char *name, struct tag *tag)
>  {
> @@ -1185,7 +1159,6 @@ static int parse_opt_anonymize_map(const struct option *opt,
>  int cmd_fast_export(int argc, const char **argv, const char *prefix)
>  {
>  	struct rev_info revs;
> -	struct object_array commits = OBJECT_ARRAY_INIT;
>  	struct commit *commit;
>  	char *export_filename = NULL,
>  	     *import_filename = NULL,
> @@ -1281,19 +1254,14 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
>  
>  	get_tags_and_duplicates(&revs.cmdline);
>  
> +	revs.reverse = 1;

Is the placement of revs.reverse = 1 here important, or could it go
earlier after init_revision_sources() when we assign some other values
ir revs?

>  	if (prepare_revision_walk(&revs))
>  		die("revision walk setup failed");

A light reading of prepare_revision_walk() suggests it could come after,
but maybe I'm entirely wrong.

>  	revs.diffopt.format_callback = show_filemodify;
>  	revs.diffopt.format_callback_data = &paths_of_changed_objects;
>  	revs.diffopt.flags.recursive = 1;
>  	while ((commit = get_revision(&revs))) {
> -		if (has_unshown_parent(commit)) {
> -			add_object_array(&commit->object, NULL, &commits);
> -		}
> -		else {
> -			handle_commit(commit, &revs, &paths_of_changed_objects);
> -			handle_tail(&commits, &revs, &paths_of_changed_objects);
> -		}
> +		handle_commit(commit, &revs, &paths_of_changed_objects);
>  	}
>  

Yay code deletion, good if it works (I didn't check).

Since this is just a one-statement while-loop we can also remove its
braces now.

> +test_expect_success 'fast-export --first-parent outputs all revisions output by revision walk' '
> +	git init first-parent &&
> +	cd first-parent &&

Do any such "cd" in a sub-shell:

	git init x &&
	(
    		cd x &&
                ...
	)
Otherwise the next test after you is going to run in anotherdirectory.

> +	test_commit init &&
> +	git checkout -b topic1 &&
> +	test_commit file2 file2.txt &&
> +	git checkout main &&
> +	git merge topic1 --no-ff &&
> +
> +	git checkout -b topic2 &&
> +	test_commit file3 file3.txt &&
> +	git checkout main &&
> +	git merge topic2 --no-ff &&

Just a nit. I'd use "test_commit A", "test_commit B" etc. when the
filenames etc. aren't important. There's no subsequent reference here,
so I assume they're not.

> +	test_commit branch-head &&
> +
> +	git rev-list --format="%ad%B" --first-parent --topo-order --no-commit-header main > expected &&

nit; >expected, not > expected is the usual style.
> +
> +	git fast-export main -- --first-parent > first-parent-export &&
> +	git fast-export main -- --first-parent --reverse > first-parent-reverse-export &&

ditto:

> +	git init import && cd import &&

ditto earlier "cd" comment.

> +	cat ../first-parent-export | git fast-import &&

Instead of "cat x | prog" do "prog <x".

> +	git rev-list --format="%ad%B" --topo-order --all --no-commit-header > actual &&

> +	test $(git rev-list --all | wc -l) -eq 4 &&

Instead:

    git rev-list --all >tmp &&
    test_line_count = 4 tmp

(for some value of tmp)

> +	test_cmp ../expected actual &&
> +	test_cmp ../first-parent-export ../first-parent-reverse-export
> +'

Maybe some of the CD-ing around here wouldu be easier by not doing that
and instead running e.g.:

    git -C subdir fast-export >file-not-in-subdir &&
    ...
