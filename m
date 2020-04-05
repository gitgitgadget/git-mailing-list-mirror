Return-Path: <SRS0=BqTQ=5V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48032C2BA15
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 15:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED93720672
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 15:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oe/tBHmI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgDEPOo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Apr 2020 11:14:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45555 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgDEPOo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Apr 2020 11:14:44 -0400
Received: by mail-wr1-f68.google.com with SMTP id v5so3377223wrp.12
        for <git@vger.kernel.org>; Sun, 05 Apr 2020 08:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=stRGHYq2Gxkuv/Wn0Mfm1Kq1Pf2YRCYNYThi+xrVWMY=;
        b=oe/tBHmINRpjJogIfZBBjZedzPZ1sIgIHFWeBZ6/CrXUj05SpD+pPeo1Y3qMoTu17A
         93F8U6/CvOKTjuuOqYGDxZJQuz9N6fds4B/TpANRpvko27MQ+2fOFVA5KlJqsXcRzBoE
         ANQ5JrdTOvOOD4qhafA4ZfE4H5KT5FBXDThV89+b6rjGX1Dwof6BlT5oX4uRjrz7WfBf
         NxN3eKZFCUuhEyNpdDNOdAASliwCfCG3okGq3Wnf6lyBmcZqsDg5tIN/6gt40F2opWSZ
         LUT/mnYW8ygrk630Rd5Lu0ZLwWCxnGB5mpdKW6/jPi63GpKzubPs+NF8HXQ6zVC/dEJW
         ZPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=stRGHYq2Gxkuv/Wn0Mfm1Kq1Pf2YRCYNYThi+xrVWMY=;
        b=RWWW/gRl+dx6pCcTnhmMv5UcY9/0w40HM+ILM5l3Ilyy+3lI6M3n4s6BQrcO57U4TZ
         1obJiyrTKdTbm0IeSpPlK4ojSVRdGCd+Zv1fSa1HTjWli0rv1IGIz9c5pueI9blrql0H
         QGHdRNZqg2g54w9+CwYAovMJjZjebDmL43pQRtqxaZ8KzeWg2+eCsv/8pz0t/RSb7tmz
         W2vWxukCC1e4RjtPfTMD179DGF84Fo+D/JXdA8ZEvIFlBpYz44SeBoWD58JF9MaX0Sou
         dieVZKSWpzegj/Bv8brCzhZQhtyL18A5ffmgFrJTBTRnA1piqC+Xq4Y0BXeiXahI3cDj
         ZWLA==
X-Gm-Message-State: AGi0Pua9h6RSdSBsbmxl9fVPPmupQNMUew0E4poDF3u6KopYjnvNz2ma
        1WmIHZz90cUn5N7794UoG/ykSR+Z
X-Google-Smtp-Source: APiQypK8qSuIhvtUAZv3/tghMSdBLoPrvSLDTRiVMsQVSgOKZWk1LWkjCVpPRSztq6/S5HdOIs1Ppw==
X-Received: by 2002:adf:eccd:: with SMTP id s13mr1412226wro.105.1586099680838;
        Sun, 05 Apr 2020 08:14:40 -0700 (PDT)
Received: from [192.168.1.240] (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.gmail.com with ESMTPSA id f62sm20219394wmf.44.2020.04.05.08.14.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2020 08:14:40 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 03/15] run-job: implement fetch job
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@google.com, stolee@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.597.git.1585946894.gitgitgadget@gmail.com>
 <77b1da5d3063a2404cd750adfe3bb8be9b6c497d.1585946894.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <0e924507-e77e-bff9-196a-e73f296a99d9@gmail.com>
Date:   Sun, 5 Apr 2020 16:14:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <77b1da5d3063a2404cd750adfe3bb8be9b6c497d.1585946894.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee

On 03/04/2020 21:48, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> When working with very large repositories, an incremental 'git fetch'
> command can download a large amount of data. If there are many other
> users pushing to a common repo, then this data can rival the initial
> pack-file size of a 'git clone' of a medium-size repo.
> 
> Users may want to keep the data on their local repos as close as
> possible to the data on the remote repos by fetching periodically in
> the background. This can break up a large daily fetch into several
> smaller hourly fetches.
> 
> However, if we simply ran 'git fetch <remote>' in the background,
> then the user running a foregroudn 'git fetch <remote>' would lose
> some important feedback when a new branch appears or an existing
> branch updates. This is especially true if a remote branch is
> force-updated and this isn't noticed by the user because it occurred
> in the background. Further, the functionality of 'git push
> --force-with-lease' becomes suspect.
> 
> When running 'git fetch <remote> <options>' in the background, use
> the following options for careful updating:
> 
> 1. --no-tags prevents getting a new tag when a user wants to see
>     the new tags appear in their foreground fetches.
> 
> 2. --refmap= removes the configured refspec which usually updates
>     refs/remotes/<remote>/* with the refs advertised by the remote.
> 
> 3. By adding a new refspec "+refs/heads/*:refs/hidden/<remote>/*"
>     we can ensure that we actually load the new values somewhere in
>     our refspace while not updating refs/heads or refs/remotes. By
>     storing these refs here, the commit-graph job will update the
>     commit-graph with the commits from these hidden refs.
> 
> 4. --prune will delete the refs/hidden/<remote> refs that no
>     longer appear on the remote.
> 
> We've been using this step as a critical background job in Scalar
> [1] (and VFS for Git). This solved a pain point that was showing up
> in user reports: fetching was a pain! Users do not like waiting to
> download the data that was created while they were away from their
> machines. After implementing background fetch, the foreground fetch
> commands sped up significantly because they mostly just update refs
> and download a small amount of new data. The effect is especially
> dramatic when paried with --no-show-forced-udpates (through
> fetch.showForcedUpdates=false).
> 
> [1] https://github.com/microsoft/scalar/blob/master/Scalar.Common/Maintenance/FetchStep.cs
> 
> RFC QUESTIONS:
> 
> 1. One downside of the refs/hidden pattern is that 'git log' will
>     decorate commits with twice as many refs if they appear at a
>     remote ref (<remote>/<ref> _and_ refs/hidden/<remote>/<ref>). Is
>     there an easy way to exclude a refspace from decorations? Should
>     we make refs/hidden/* a "special" refspace that is excluded from
>     decorations?

Having some way to specify which refs outside of 
refs/{heads,remote,tags}/ to show or exclude from decorations would be 
useful I think. Fetching to a hidden ref is a good idea (as are the 
other steps you outline above) but as you say we don't want it to show 
up in the output of 'git log' etc.

> 2. This feature is designed for a desktop machine or equivalent
>     that has a permanent wired network connection, and the machine
>     stays on while the user is not present. For things like laptops
>     with inconsistent WiFi connections (that may be metered) the
>     feature can use the less stable connection more than the user
>     wants. Of course, this feature is opt-in for Git, but in Scalar
>     we have a "scalar pause" command [2] that pauses all maintenance
>     for some amount of time. We should consider a similar mechanism
>     for Git, but for the point of this series the user needs to set
>     up the "background" part of these jobs manually.
> 
> [2] https://github.com/microsoft/scalar/blob/master/Scalar/CommandLine/PauseVerb.cs
> [3] https://github.com/microsoft/scalar/blob/master/docs/advanced.md#controlling-background-maintenance
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>   Documentation/git-run-job.txt | 13 ++++-
>   builtin/run-job.c             | 89 ++++++++++++++++++++++++++++++++++-
>   t/t7900-run-job.sh            | 22 +++++++++
>   3 files changed, 122 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-run-job.txt b/Documentation/git-run-job.txt
> index 8bf2762d650..eb92e891915 100644
> --- a/Documentation/git-run-job.txt
> +++ b/Documentation/git-run-job.txt
> @@ -9,7 +9,7 @@ git-run-job - Run a maintenance job. Intended for background operation.
>   SYNOPSIS
>   --------
>   [verse]
> -'git run-job commit-graph'
> +'git run-job (commit-graph|fetch)'
>   
>   
>   DESCRIPTION
> @@ -47,6 +47,17 @@ since it will not expire `.graph` files that were in the previous
>   `commit-graph-chain` file. They will be deleted by a later run based on
>   the expiration delay.
>   
> +'fetch'::
> +
> +The `fetch` job updates the object directory with the latest objects
> +from all registered remotes. For each remote, a `git fetch` command is
> +run. The refmap is custom to avoid updating local or remote branches
> +(those in `refs/heads` or `refs/remotes`). Instead, the remote refs are
> +stored in `refs/hidden/<remote>/`. Also, no tags are updated.
> ++
> +This means that foreground fetches are still required to update the
> +remote refs, but the users is notified when the branches and tags are
> +updated on the remote.
>   
>   GIT
>   ---
> diff --git a/builtin/run-job.c b/builtin/run-job.c
> index dd7709952d3..e59056b2918 100644
> --- a/builtin/run-job.c
> +++ b/builtin/run-job.c
> @@ -7,7 +7,7 @@
>   #include "run-command.h"
>   
>   static char const * const builtin_run_job_usage[] = {
> -	N_("git run-job commit-graph"),
> +	N_("git run-job (commit-graph|fetch)"),
>   	NULL
>   };
>   
> @@ -60,6 +60,91 @@ static int run_commit_graph_job(void)
>   	return 1;
>   }
>   
> +static int fetch_remote(const char *remote)
> +{
> +	int result;
> +	struct argv_array cmd = ARGV_ARRAY_INIT;
> +	struct strbuf refmap = STRBUF_INIT;
> +
> +	argv_array_pushl(&cmd, "fetch", remote, "--quiet", "--prune",
> +			 "--no-tags", "--refmap=", NULL);
> +
> +	strbuf_addf(&refmap, "+refs/heads/*:refs/hidden/%s/*", remote);
> +	argv_array_push(&cmd, refmap.buf);
> +
> +	result = run_command_v_opt(cmd.argv, RUN_GIT_CMD);
> +
> +	strbuf_release(&refmap);
> +	return result;
> +}
> +
> +static int fill_remotes(struct string_list *remotes)

Isn't there a easy way to get this using the config api rather than 
forking 'git remote'?

Best Wishes

Phillip

> +{
> +	int result = 0;
> +	FILE *proc_out;
> +	struct strbuf line = STRBUF_INIT;
> +	struct child_process *remote_proc = xmalloc(sizeof(*remote_proc));
> +
> +	child_process_init(remote_proc);
> +
> +	argv_array_pushl(&remote_proc->args, "git", "remote", NULL);
> +
> +	remote_proc->out = -1;
> +
> +	if (start_command(remote_proc)) {
> +		error(_("failed to start 'git remote' process"));
> +		result = 1;
> +		goto cleanup;
> +	}
> +
> +	proc_out = xfdopen(remote_proc->out, "r");
> +
> +	/* if there is no line, leave the value as given */
> +	while (!strbuf_getline(&line, proc_out))
> +		string_list_append(remotes, line.buf);
> +
> +	strbuf_release(&line);
> +
> +	fclose(proc_out);
> +
> +	if (finish_command(remote_proc)) {
> +		error(_("failed to finish 'git remote' process"));
> +		result = 1;
> +	}
> +
> +cleanup:
> +	free(remote_proc);
> +	return result;
> +}
> +
> +static int run_fetch_job(void)
> +{
> +	int result = 0;
> +	struct string_list_item *item;
> +	struct string_list remotes = STRING_LIST_INIT_DUP;
> +
> +	if (fill_remotes(&remotes)) {
> +		error(_("failed to fill remotes"));
> +		result = 1;
> +		goto cleanup;
> +	}
> +
> +	/*
> +	 * Do not modify the result based on the success of the 'fetch'
> +	 * operation, as a loss of network could cause 'fetch' to fail
> +	 * quickly. We do not want that to stop the rest of our
> +	 * background operations.
> +	 */
> +	for (item = remotes.items;
> +	     item && item < remotes.items + remotes.nr;
> +	     item++)
> +		fetch_remote(item->string);
> +
> +cleanup:
> +	string_list_clear(&remotes, 0);
> +	return result;
> +}
> +
>   int cmd_run_job(int argc, const char **argv, const char *prefix)
>   {
>   	static struct option builtin_run_job_options[] = {
> @@ -79,6 +164,8 @@ int cmd_run_job(int argc, const char **argv, const char *prefix)
>   	if (argc > 0) {
>   		if (!strcmp(argv[0], "commit-graph"))
>   			return run_commit_graph_job();
> +		if (!strcmp(argv[0], "fetch"))
> +			return run_fetch_job();
>   	}
>   
>   	usage_with_options(builtin_run_job_usage,
> diff --git a/t/t7900-run-job.sh b/t/t7900-run-job.sh
> index 18b9bd26b3a..d3faeba135b 100755
> --- a/t/t7900-run-job.sh
> +++ b/t/t7900-run-job.sh
> @@ -44,4 +44,26 @@ test_expect_success 'commit-graph job' '
>   	)
>   '
>   
> +test_expect_success 'fetch job' '
> +	git clone "file://$(pwd)/server" client &&
> +
> +	# Before fetching, build a client commit-graph
> +	git -C client run-job commit-graph &&
> +	chain=client/.git/objects/info/commit-graphs/commit-graph-chain &&
> +	test_line_count = 1 $chain &&
> +
> +	git -C client branch -v --remotes >before-refs &&
> +	test_commit -C server 24 &&
> +
> +	git -C client run-job fetch &&
> +	git -C client branch -v --remotes >after-refs &&
> +	test_cmp before-refs after-refs &&
> +	test_cmp server/.git/refs/heads/master \
> +		 client/.git/refs/hidden/origin/master &&
> +
> +	# the hidden ref should trigger a new layer in the commit-graph
> +	git -C client run-job commit-graph &&
> +	test_line_count = 2 $chain
> +'
> +
>   test_done
> 
