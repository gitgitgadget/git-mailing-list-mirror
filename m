Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D92CC43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 12:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B94920716
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 12:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/J1JAgC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbgC3MNk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 08:13:40 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:33054 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729996AbgC3MNk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 08:13:40 -0400
Received: by mail-qv1-f67.google.com with SMTP id p19so8744090qve.0
        for <git@vger.kernel.org>; Mon, 30 Mar 2020 05:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wjGCip/hpGJBWTL3ukT8ZY41odfBMJ+rmQB6FupQolM=;
        b=X/J1JAgCPkmHKM8M2w03wtSqrgawKOtp3FaUK7KZXrdCT53Jai5wM7PmBgIRsf4q6w
         08pKIc46Km84tvoWoW4bpNFRCNSQMIGIZS4BJdwiBjxTNoyVxY/G8crWJ+PB+SfUiuUn
         uW09D4Qrt+V3/cq+A2QiLrOsMXSvR841TSxMODdyY4Ofm4rt9XQnoamfiZTaLefy3PNZ
         WWDVmWRBqeZZxqa2G0XlwbSt0RRF+fV0iPquMU8fsW5R8SU9tJh7EQM/fhCucZ3ecuXV
         bXyO+DHY8i1VkQVVwibBDb13wF9Yzfz0CxrIslyye9SFsCu7a1yqBEiQ/UUzqx2xgb6s
         aSzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wjGCip/hpGJBWTL3ukT8ZY41odfBMJ+rmQB6FupQolM=;
        b=Tn69001FUyPmnwPgjt5ZmufiimyE7PeliY3PVaZRoRSH7BhY2TZQBN3c5NzO+ECJ1k
         T9+qVnPg2lEFgC/NXBXITjiOvRxfQH7M8wuuE16s6wfhysQLanSTp7A0/PUkCNF+bBA3
         2n4Olg1+qfVrc2Pj7bL6bWn1KDXEju7jessPQNoS2a5hOWWJBntPd2ZIzzxM4lyZ3cKz
         rKEeDXSv9bdZnT/nASx+MPbS+IORrT4XMz+cAjEuPFfE+W7tOp/INTkf81MjltE5eOEc
         83KWQ0pZzk6J+z65eivt+mgQ2pjL1ANCzZIFsuPpYXlcWWZWCn9mrg1lIszv9IqisDt1
         jG3g==
X-Gm-Message-State: ANhLgQ3TISbKYaAOapK/gwfMx9rVF1C2/rTcUMoqofVRnQAz6v9J6SnE
        7cZSPk5jfSyc44hrG1K1qXI=
X-Google-Smtp-Source: ADFU+vuui5gjbW1BOiuInHHn9YznUj9/79aaWIvkYWDVrw+SBS5YpWB1xD+3vkg5DcSpRBZp86kZJg==
X-Received: by 2002:a05:6214:1863:: with SMTP id eh3mr11597951qvb.71.1585570415924;
        Mon, 30 Mar 2020 05:13:35 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id g187sm9904665qkf.115.2020.03.30.05.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2020 05:13:34 -0700 (PDT)
Subject: Re: [PATCH v3] rebase --merge: optionally skip upstreamed commits
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Cc:     congdanhqx@gmail.com, newren@gmail.com, gitster@pobox.com
References: <20200309205523.121319-1-jonathantanmy@google.com>
 <20200330040621.13701-1-jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e917f451-c00a-c819-7f78-888ba6e8f5ea@gmail.com>
Date:   Mon, 30 Mar 2020 08:13:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <20200330040621.13701-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/30/2020 12:06 AM, Jonathan Tan wrote:
> When rebasing against an upstream that has had many commits since the
> original branch was created:
> 
>  O -- O -- ... -- O -- O (upstream)
>   \
>    -- O (my-dev-branch)
> 
> it must read the contents of every novel upstream commit, in addition to
> the tip of the upstream and the merge base, because "git rebase"
> attempts to exclude commits that are duplicates of upstream ones. This
> can be a significant performance hit, especially in a partial clone,
> wherein a read of an object may end up being a fetch.
> 
> Add a flag to "git rebase" to allow suppression of this feature. This
> flag only works when using the "merge" backend.

So this is the behavior that already exists, and you are providing a way
to suppress it. However, you also change the default in this patch, which
may surprise users expecting this behavior to continue.

> This flag changes the behavior of sequencer_make_script(), called from
> do_interactive_rebase() <- run_rebase_interactive() <-
> run_specific_rebase() <- cmd_rebase(). With this flag, limit_list()
> (indirectly called from sequencer_make_script() through
> prepare_revision_walk()) will no longer call cherry_pick_list(), and
> thus PATCHSAME is no longer set. Refraining from setting PATCHSAME both
> means that the intermediate commits in upstream are no longer read (as
> shown by the test) and means that no PATCHSAME-caused skipping of
> commits is done by sequencer_make_script(), either directly or through
> make_script_with_merges().
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> This commit contains Junio's sign-off because I based it on
> jt/rebase-allow-duplicate.
> 
> This does not include the fix by Đoàn Trần Công Danh. If we want all
> commits to pass all tests (whether run by Busybox or not) it seems like
> we should squash that patch instead of having it as a separate commit.
> If we do squash, maybe include a "Helped-by" with Đoàn Trần Công Danh's
> name.
> 
> Junio wrote [1]:
> 
>> Sounds much better to me.  I do not mind --[no-]keep-cherry-pick,
>> either, by the way.  I know I raised the possibility of having to
>> make it non-bool later, but since then I haven't thought of a good
>> third option myself anyway, so...
> 
> In that case, I think it's better to stick to bool. This also means that
> the change from the version in jt/rebase-allow-duplicate is very small,
> hopefully aiding reviewers - mostly a replacement of
> --skip-cherry-pick-detection with --keep-cherry-pick (which mean the
> same thing).
> 
> [1] https://lore.kernel.org/git/xmqq4kuakjcn.fsf@gitster.c.googlers.com/
> ---
>  Documentation/git-rebase.txt | 21 +++++++++-
>  builtin/rebase.c             |  7 ++++
>  sequencer.c                  |  3 +-
>  sequencer.h                  |  2 +-
>  t/t3402-rebase-merge.sh      | 77 ++++++++++++++++++++++++++++++++++++
>  5 files changed, 107 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 0c4f038dd6..f4f8afeb9a 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -318,6 +318,21 @@ See also INCOMPATIBLE OPTIONS below.
>  +
>  See also INCOMPATIBLE OPTIONS below.
>  
> +--keep-cherry-pick::
> +--no-keep-cherry-pick::

I noticed that this _could_ have been simplified to

	--[no-]keep-cherry-pick::

but I also see several uses of either in our documentation. Do we
have a preference? By inspecting the lines before a "no-" string,
I see that some have these two lines, some use the [no-] pattern,
and others highlight the --no-<option> flag completely separately.

> +	Control rebase's behavior towards commits in the working
> +	branch that are already present upstream, i.e. cherry-picks.

I think the "already present upstream" is misleading. We don't rebase
things that are _reachable_ already, but this is probably better as

	Specify if rebase should include commits in the working branch
	that have diffs equivalent to other commits upstream. For example,
	a cherry-picked commit has an equivalent diff.

> ++
> +By default, these commits will be dropped. Because this necessitates
> +reading all upstream commits, this can be expensive in repos with a
> +large number of upstream commits that need to be read.

Now I'm confused. Are they dropped by default? Which option does what?
--keep-cherry-pick makes me think that cherry-picked commits will come
along for the rebase, so we will not check for them. But you have documented
that --no-keep-cherry-pick is the default.

(Also, I keep writing "--[no-]keep-cherry-picks" (plural) because that
seems more natural to me. Then I go back and fix it when I notice.)

> ++
> +If `--keep-cherry-pick is given`, all commits (including these) will be

Bad tick marks: "`--keep-cherry-pick` is given"

> +re-applied. This allows rebase to forgo reading all upstream commits,
> +potentially improving performance.

This reasoning is good. Could you also introduce a config option to make
--keep-cherry-pick the default? I would like to enable that option by
default in Scalar, but could also see partial clones wanting to enable that
by default, too.

> ++
> +See also INCOMPATIBLE OPTIONS below.
> +

Could we just say that his only applies with the --merge option? Why require
the jump to the end of the options section? (After writing this, I go look
at the rest of the doc file and see this is a common pattern.)

>  --rerere-autoupdate::
>  --no-rerere-autoupdate::
>  	Allow the rerere mechanism to update the index with the
> @@ -568,6 +583,9 @@ In addition, the following pairs of options are incompatible:
>   * --keep-base and --onto
>   * --keep-base and --root
>  
> +Also, the --keep-cherry-pick option requires the use of the merge backend
> +(e.g., through --merge).
> +

Will the command _fail_ if someone says --keep-cherry-pick without the merge
backend, or just have no effect? Also, specify the option with ticks and

	`--[no-]keep-cherry-pick`

It seems that none of the options in this section are back-ticked, which I think
is a doc bug.

>  BEHAVIORAL DIFFERENCES
>  -----------------------
>  
> @@ -866,7 +884,8 @@ Only works if the changes (patch IDs based on the diff contents) on
>  'subsystem' did.
>  
>  In that case, the fix is easy because 'git rebase' knows to skip
> -changes that are already present in the new upstream.  So if you say
> +changes that are already present in the new upstream (unless
> +`--keep-cherry-pick` is given). So if you say
>  (assuming you're on 'topic')
>  ------------
>      $ git rebase subsystem
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 8081741f8a..626549b0b2 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -88,6 +88,7 @@ struct rebase_options {
>  	struct strbuf git_format_patch_opt;
>  	int reschedule_failed_exec;
>  	int use_legacy_rebase;
> +	int keep_cherry_pick;
>  };
>  
>  #define REBASE_OPTIONS_INIT {			  	\
> @@ -381,6 +382,7 @@ static int run_rebase_interactive(struct rebase_options *opts,
>  	flags |= opts->rebase_cousins > 0 ? TODO_LIST_REBASE_COUSINS : 0;
>  	flags |= opts->root_with_onto ? TODO_LIST_ROOT_WITH_ONTO : 0;
>  	flags |= command == ACTION_SHORTEN_OIDS ? TODO_LIST_SHORTEN_IDS : 0;
> +	flags |= opts->keep_cherry_pick ? TODO_LIST_KEEP_CHERRY_PICK : 0;

Since opts->keep_cherry_pick is initialized as zero, did you change the default
behavior? Do we not have a test that verifies this behavior when using the merge
backend an no "--keep-cherry-pick" option?

If you initialize it to -1, then you can tell if the --no-keep-cherry-pick option
is specified, which is relevant to my concern below.

>  
>  	switch (command) {
>  	case ACTION_NONE: {
> @@ -1515,6 +1517,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  		OPT_BOOL(0, "reschedule-failed-exec",
>  			 &reschedule_failed_exec,
>  			 N_("automatically re-schedule any `exec` that fails")),
> +		OPT_BOOL(0, "keep-cherry-pick", &options.keep_cherry_pick,
> +			 N_("apply all changes, even those already present upstream")),
>  		OPT_END(),
>  	};
>  	int i;
> @@ -1848,6 +1852,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  			      "interactive or merge options"));
>  	}
>  
> +	if (options.keep_cherry_pick && !is_interactive(&options))
> +		die(_("--keep-cherry-pick does not work with the 'apply' backend"));
> +

I see you are failing here. Is this the right decision?

The apply backend will "keep" cherry-picks because it will not look for them upstream.
If anything, shouldn't it be that "--no-keep-cherry-pick" is incompatible?

>  	if (options.signoff) {
>  		if (options.type == REBASE_PRESERVE_MERGES)
>  			die("cannot combine '--signoff' with "
> diff --git a/sequencer.c b/sequencer.c
> index b9dbf1adb0..7bbb63f444 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4800,12 +4800,13 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
>  	int keep_empty = flags & TODO_LIST_KEEP_EMPTY;
>  	const char *insn = flags & TODO_LIST_ABBREVIATE_CMDS ? "p" : "pick";
>  	int rebase_merges = flags & TODO_LIST_REBASE_MERGES;
> +	int keep_cherry_pick = flags & TODO_LIST_KEEP_CHERRY_PICK;
>  
>  	repo_init_revisions(r, &revs, NULL);
>  	revs.verbose_header = 1;
>  	if (!rebase_merges)
>  		revs.max_parents = 1;
> -	revs.cherry_mark = 1;
> +	revs.cherry_mark = !keep_cherry_pick;
>  	revs.limited = 1;
>  	revs.reverse = 1;
>  	revs.right_only = 1;
> diff --git a/sequencer.h b/sequencer.h
> index 9f9ae291e3..298b7de1c8 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -148,7 +148,7 @@ int sequencer_remove_state(struct replay_opts *opts);
>   * `--onto`, we do not want to re-generate the root commits.
>   */
>  #define TODO_LIST_ROOT_WITH_ONTO (1U << 6)
> -
> +#define TODO_LIST_KEEP_CHERRY_PICK (1U << 7)
>  
>  int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
>  			  const char **argv, unsigned flags);
> diff --git a/t/t3402-rebase-merge.sh b/t/t3402-rebase-merge.sh
> index a1ec501a87..64200c5f20 100755
> --- a/t/t3402-rebase-merge.sh
> +++ b/t/t3402-rebase-merge.sh
> @@ -162,4 +162,81 @@ test_expect_success 'rebase --skip works with two conflicts in a row' '
>  	git rebase --skip
>  '
>  
> +test_expect_success '--keep-cherry-pick' '
> +	git init repo &&
> +
> +	# O(1-10) -- O(1-11) -- O(0-10) master
> +	#        \
> +	#         -- O(1-11) -- O(1-12) otherbranch
> +
> +	printf "Line %d\n" $(test_seq 1 10) >repo/file.txt &&
> +	git -C repo add file.txt &&
> +	git -C repo commit -m "base commit" &&
> +
> +	printf "Line %d\n" $(test_seq 1 11) >repo/file.txt &&
> +	git -C repo commit -a -m "add 11" &&
> +
> +	printf "Line %d\n" $(test_seq 0 10) >repo/file.txt &&
> +	git -C repo commit -a -m "add 0 delete 11" &&
> +
> +	git -C repo checkout -b otherbranch HEAD^^ &&
> +	printf "Line %d\n" $(test_seq 1 11) >repo/file.txt &&
> +	git -C repo commit -a -m "add 11 in another branch" &&
> +
> +	printf "Line %d\n" $(test_seq 1 12) >repo/file.txt &&
> +	git -C repo commit -a -m "add 12 in another branch" &&
> +
> +	# Regular rebase fails, because the 1-11 commit is deduplicated
> +	test_must_fail git -C repo rebase --merge master 2> err &&
> +	test_i18ngrep "error: could not apply.*add 12 in another branch" err &&
> +	git -C repo rebase --abort &&

OK. So here you are demonstrating that the --no-keep-cherry-pick is the
new default. Just trying to be sure that this was intended.

> +
> +	# With --keep-cherry-pick, it works
> +	git -C repo rebase --merge --keep-cherry-pick master
> +'
> +
> +test_expect_success '--keep-cherry-pick refrains from reading unneeded blobs' '
> +	git init server &&
> +
> +	# O(1-10) -- O(1-11) -- O(1-12) master
> +	#        \
> +	#         -- O(0-10) otherbranch
> +
> +	printf "Line %d\n" $(test_seq 1 10) >server/file.txt &&
> +	git -C server add file.txt &&
> +	git -C server commit -m "merge base" &&
> +
> +	printf "Line %d\n" $(test_seq 1 11) >server/file.txt &&
> +	git -C server commit -a -m "add 11" &&
> +
> +	printf "Line %d\n" $(test_seq 1 12) >server/file.txt &&
> +	git -C server commit -a -m "add 12" &&
> +
> +	git -C server checkout -b otherbranch HEAD^^ &&
> +	printf "Line %d\n" $(test_seq 0 10) >server/file.txt &&
> +	git -C server commit -a -m "add 0" &&
> +
> +	test_config -C server uploadpack.allowfilter 1 &&
> +	test_config -C server uploadpack.allowanysha1inwant 1 &&
> +
> +	git clone --filter=blob:none "file://$(pwd)/server" client &&
> +	git -C client checkout origin/master &&
> +	git -C client checkout origin/otherbranch &&
> +
> +	# Sanity check to ensure that the blobs from the merge base and "add
> +	# 11" are missing
> +	git -C client rev-list --objects --all --missing=print >missing_list &&
> +	MERGE_BASE_BLOB=$(git -C server rev-parse master^^:file.txt) &&
> +	ADD_11_BLOB=$(git -C server rev-parse master^:file.txt) &&
> +	grep "\\?$MERGE_BASE_BLOB" missing_list &&
> +	grep "\\?$ADD_11_BLOB" missing_list &&
> +
> +	git -C client rebase --merge --keep-cherry-pick origin/master &&
> +
> +	# The blob from the merge base had to be fetched, but not "add 11"
> +	git -C client rev-list --objects --all --missing=print >missing_list &&
> +	! grep "\\?$MERGE_BASE_BLOB" missing_list &&
> +	grep "\\?$ADD_11_BLOB" missing_list
> +'

I appreciate this test showing that this is accomplishing the goal in
a partial clone. 

Thanks,
-Stolee


