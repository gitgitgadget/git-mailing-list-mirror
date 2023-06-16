Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4203EB64D9
	for <git@archiver.kernel.org>; Fri, 16 Jun 2023 02:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240731AbjFPCWC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jun 2023 22:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjFPCWA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2023 22:22:00 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9BB1BD6
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 19:21:57 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-7622a74e1cfso19527185a.0
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 19:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686882117; x=1689474117;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mjmMwrjcamz3933FMfRHZwzKBFTwUQTen0E7jgYh4/g=;
        b=oAvfxc5jSj2vFdTjAAVjZk9B4GScI9YQqD3ZWLaTYOo7U17nEpmlusP1WUby/qNwkc
         5DJl97oax0ktrtEXnVXanTR2mLMGcDEdocMytInQ2pSwUREJ5WcES26acuyfNnmZ5+WV
         xl4mdo18R2JncmTBeCV9kKCLf4TiFwCo/nd16Gv8cpVdWAvXV/IDf95f8LvTlB8XjTP7
         AJHe7V+hCDpxDk4I6G8Xwy4l/niHIcftf2GuP02OaHLFCw+lZgMvbgdmAh/P3xjGgo8I
         XTKZQYzxXyKURjupVO2LqhXiBoDS1OGcIQYO44q7ZBcMfaYY3p/ZhTc/GlJ3QqrAd1ie
         eKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686882117; x=1689474117;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mjmMwrjcamz3933FMfRHZwzKBFTwUQTen0E7jgYh4/g=;
        b=aIrFI4pbChMZQvtefWeeq0xOeYuziwCwcZ+2NZMOIS7mJulnBA6K9BIAZJVrmL5vL8
         HK8zAjcVdgjKP4q9dUb1x8Hb/adhvKpLveyggjeGj1gX8Gl6CcoZVB6IUJLH0VsxBRie
         q/2tkpwRbVLGZQl30vE1TNqVerDzDXFnmGpPae9Sypc0U868ASUTzXJhxLwLbYlUQ/7F
         r9Vi7wD574+z77wuo4Ob8aWYlp9M69O0ywyA6kCbV6M24BAxPl7teqvRBFM0k3RbkN0O
         U7LucYdpsh7AGBhpI5V4YW63wpYFMzJj3MDSCwEYIUvZZnsp2lNxfPbzVM6meX3/m7py
         rkQQ==
X-Gm-Message-State: AC+VfDxlrP2YnDwWDDfyqpm8gg56WgGjtAZY2/K7q3mO1pMCaNdX+SI6
        GBkc65QvT9ydeiVR+i6f+mk=
X-Google-Smtp-Source: ACHHUZ4j9ZJdhglbUe1EdQA/MHJ33VWrAc/5VZBnP6Bt8GX6/t3JG6/+szCnxxjpGUAm9UlkLC0iig==
X-Received: by 2002:ac8:7dc6:0:b0:3f9:a852:3c27 with SMTP id c6-20020ac87dc6000000b003f9a8523c27mr1440785qte.4.1686882116770;
        Thu, 15 Jun 2023 19:21:56 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id u1-20020aa78481000000b0064fd8b3dd10sm12539229pfn.109.2023.06.15.19.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 19:21:56 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 8/9] repack: implement `--filter-to` for storing
 filtered out objects
References: <20230614192541.1599256-1-christian.couder@gmail.com>
        <20230614192541.1599256-9-christian.couder@gmail.com>
Date:   Thu, 15 Jun 2023 19:21:56 -0700
In-Reply-To: <20230614192541.1599256-9-christian.couder@gmail.com> (Christian
        Couder's message of "Wed, 14 Jun 2023 21:25:40 +0200")
Message-ID: <xmqqfs6srvsr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> A previous commit has implemented `git repack --filter=<filter-spec>` to
> allow users to filter out some objects from the main pack and move them
> into a new different pack.
>
> It would be nice if this new different pack could be created in a
> different directory than the regular pack. This would make it possible
> to move large blobs into a pack on a different kind of storage, for
> example cheaper storage. Even in a different directory this pack can be
> accessible if, for example, the Git alternates mechanism is used to
> point to it.

Makes sense, I guess, for "in other usecases" scenario.  I am not
sure how this would be useful for the originally stated goal of
unbloating a bloated repository with promisor remote(s), though. 

> If users want to remove a pack that contains filtered out objects after
> checking that they are all already on a promisor remote, creating the
> pack in a different directory makes it easier to do so.

Care to elaborate?  I do not see how a separate directory would make
it easier.  After separating the potential cruft into a packfile,
you'd walk its .idx and see if there are any objects that are not
available (yet) at the promisor remotes to check if it is safe to
remove.  That can be done regardless of the location of the packfile
that is suspected to be now removable.

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/git-repack.txt |  6 ++++++
>  builtin/repack.c             | 17 ++++++++++++-----
>  t/t7700-repack.sh            | 27 +++++++++++++++++++++++++++
>  3 files changed, 45 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
> index aa29c7e648..070dd22610 100644
> --- a/Documentation/git-repack.txt
> +++ b/Documentation/git-repack.txt
> @@ -148,6 +148,12 @@ depth is 4095.
>  	resulting packfile and put them into a separate packfile. See
>  	linkgit:git-rev-list[1] for valid `<filter-spec>` forms.
>  
> +--filter-to=<dir>::
> +	Write the pack containing filtered out objects to the
> +	directory `<dir>`. This can be used for putting the pack on a
> +	separate object directory that is accessed through the Git
> +	alternates mechanism. Only useful with `--filter`.
> +
>  -b::
>  --write-bitmap-index::
>  	Write a reachability bitmap index as part of the repack. This
> diff --git a/builtin/repack.c b/builtin/repack.c
> index b13d7196de..8c71e8fd51 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -838,7 +838,8 @@ static void prepare_pack_filtered_cmd(struct child_process *cmd,
>  }
>  
>  static void finish_pack_filtered_cmd(struct child_process *cmd,
> -				     struct string_list *names)
> +				     struct string_list *names,
> +				     const char *destination)
>  {
>  	if (cmd->in == -1) {
>  		/* No packed objects; cmd was never started */
> @@ -848,7 +849,7 @@ static void finish_pack_filtered_cmd(struct child_process *cmd,
>  
>  	close(cmd->in);
>  
> -	if (finish_pack_objects_cmd(cmd, names, NULL, NULL))
> +	if (finish_pack_objects_cmd(cmd, names, destination, NULL))
>  		die(_("could not finish pack-objects to pack filtered objects"));
>  }
>  
> @@ -877,6 +878,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  	const char *cruft_expiration = NULL;
>  	const char *expire_to = NULL;
>  	struct child_process pack_filtered_cmd = CHILD_PROCESS_INIT;
> +	const char *filter_to = NULL;
>  
>  	struct option builtin_repack_options[] = {
>  		OPT_BIT('a', NULL, &pack_everything,
> @@ -930,6 +932,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  			   N_("write a multi-pack index of the resulting packs")),
>  		OPT_STRING(0, "expire-to", &expire_to, N_("dir"),
>  			   N_("pack prefix to store a pack containing pruned objects")),
> +		OPT_STRING(0, "filter-to", &filter_to, N_("dir"),
> +			   N_("pack prefix to store a pack containing filtered out objects")),
>  		OPT_END()
>  	};
>  
> @@ -1073,8 +1077,11 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  		strvec_push(&cmd.args, "--incremental");
>  	}
>  
> -	if (po_args.filter)
> -		prepare_pack_filtered_cmd(&pack_filtered_cmd, &po_args, packtmp);
> +	if (po_args.filter) {
> +		if (!filter_to)
> +			filter_to = packtmp;
> +		prepare_pack_filtered_cmd(&pack_filtered_cmd, &po_args, filter_to);
> +	}
>  
>  	if (geometry)
>  		cmd.in = -1;
> @@ -1169,7 +1176,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  	}
>  
>  	if (po_args.filter)
> -		finish_pack_filtered_cmd(&pack_filtered_cmd, &names);
> +		finish_pack_filtered_cmd(&pack_filtered_cmd, &names, filter_to);
>  
>  	string_list_sort(&names);
>  
> diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
> index 9e7654090f..898f8a01b4 100755
> --- a/t/t7700-repack.sh
> +++ b/t/t7700-repack.sh
> @@ -286,6 +286,33 @@ test_expect_success 'repacking with a filter works' '
>  	test "$blob_pack2" = "$blob_pack"
>  '
>  
> +test_expect_success '--filter-to stores filtered out objects' '
> +	git -C bare.git repack -a -d &&
> +	test_stdout_line_count = 1 ls bare.git/objects/pack/*.pack &&
> +
> +	git init --bare filtered.git &&
> +	git -C bare.git -c repack.writebitmaps=false repack -a -d \
> +		--filter=blob:none \
> +		--filter-to=../filtered.git/objects/pack/pack &&
> +	test_stdout_line_count = 1 ls bare.git/objects/pack/pack-*.pack &&
> +	test_stdout_line_count = 1 ls filtered.git/objects/pack/pack-*.pack &&
> +
> +	commit_pack=$(test-tool -C bare.git find-pack HEAD) &&
> +	test -n "$commit_pack" &&
> +	blob_pack=$(test-tool -C bare.git find-pack HEAD:file1) &&
> +	test -z "$blob_pack" &&
> +	blob_hash=$(git -C bare.git rev-parse HEAD:file1) &&
> +	test -n "$blob_hash" &&
> +	blob_pack=$(test-tool -C filtered.git find-pack $blob_hash) &&
> +	test -n "$blob_pack" &&
> +
> +	echo $(pwd)/filtered.git/objects >bare.git/objects/info/alternates &&
> +	blob_pack=$(test-tool -C bare.git find-pack HEAD:file1) &&
> +	test -n "$blob_pack" &&
> +	blob_content=$(git -C bare.git show $blob_hash) &&
> +	test "$blob_content" = "content1"
> +'
> +
>  objdir=.git/objects
>  midx=$objdir/pack/multi-pack-index
