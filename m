Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106DEEB64DD
	for <git@archiver.kernel.org>; Tue, 25 Jul 2023 23:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjGYXEa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 19:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjGYXE3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 19:04:29 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2802A2
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 16:04:27 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-583f036d50bso35576567b3.3
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 16:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1690326267; x=1690931067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gpG1erFEdYN3YO6PGmbGmoUvKumUXWvsdloKB/gtrxc=;
        b=iJK3kGQM46l4oOOtgJ9RgmBkgo2XLDOtH0Y+I4+ZqqPS4opbQ0o8SusVyyTaVqxiHp
         THM8UajX+0862Yy2sbl6h7eY2llBR3qYNu6SiFfvuY8D+1kD5oYGoSJ6ZgGwCgo/g99f
         rRZJdVRkKMze+VlBcfZhzvZ7K4BnNe2cjFeSOR7FRhiZ2M6pALyYk7KEGG9HzS8IynR/
         EfXGcK5N0Do+zykZrjCVu20EA0/oOFq2KzAG5M+0efArnj8nrKu2JGQyHJVyz43yy761
         ifMCfe2jckb53VqldrIlvXEH2gF3lVyJbFGTqXvUtRjGjqbyNejdOi6BKAKFAUIRuwzq
         41YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690326267; x=1690931067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpG1erFEdYN3YO6PGmbGmoUvKumUXWvsdloKB/gtrxc=;
        b=Sv9os2AGcAQVghzrB94ePOerEGPRUZeeM0xKzn9MOFCap+eooHkGQEIOUC40BdNgSi
         unFSoklWnIF6+M5QjmNFtxzjOyJd7jMXwZYIaEmGtsUDRyOGwrydoPlG3IiqRbfRI54K
         EuThX+Ecw6zunVVBuxrHJDsMo7zGi1jGdmpecG/JZ1dYbeZB6oqAohsbqh8/91ulWQcl
         Zj2A0SC7wrLaVtqCbHYr4Gkwx6jkiPAVIPvX7wKkWI1B9p89PZQdWhlVwV7/6oqVLE1H
         IQYmqEuaiKqkRm/6j3Q8TYPA4PGxJgR0976znxToPL2z5ob0DAQHCsu+VQ4lL1rwzw2N
         8KLQ==
X-Gm-Message-State: ABy/qLah/Q8VTYy7xEyzO35SGibtPCd1aNRKpaJw93RKDOV3f60NUVGV
        tcQXCXIHOmbJH2zJ+9WMOvkdXg==
X-Google-Smtp-Source: APBJJlGLLroohtx5PfV45HzdYGa2jo4QRsOepc2AnKIWm9A2TBP5v5OJ6IqWqg/u69aI5nw+eND/mA==
X-Received: by 2002:a0d:f881:0:b0:56c:fafe:908b with SMTP id i123-20020a0df881000000b0056cfafe908bmr555556ywf.38.1690326266756;
        Tue, 25 Jul 2023 16:04:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m64-20020a0de343000000b005773e0ee56bsm3849153ywe.77.2023.07.25.16.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 16:04:26 -0700 (PDT)
Date:   Tue, 25 Jul 2023 19:04:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 5/8] repack: add `--filter=<filter-spec>` option
Message-ID: <ZMBU+SALVQthOgC7@nand.local>
References: <20230705060812.2865188-1-christian.couder@gmail.com>
 <20230724085909.3831831-1-christian.couder@gmail.com>
 <20230724085909.3831831-6-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230724085909.3831831-6-christian.couder@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 24, 2023 at 10:59:06AM +0200, Christian Couder wrote:
> This feature is implemented by running `git pack-objects` twice in a
> row. The first command is run with `--filter=<filter-spec>`, using the
> specified filter. It packs objects while omitting the objects specified
> by the filter. Then another `git pack-objects` command is launched using
> `--stdin-packs`. We pass it all the previously existing packs into its
> stdin, so that it will pack all the objects in the previously existing
> packs. But we also pass into its stdin, the pack created by the previous
> `git pack-objects --filter=<filter-spec>` command as well as the kept
> packs, all prefixed with '^', so that the objects in these packs will be
> omitted from the resulting pack. The result is that only the objects
> filtered out by the first `git pack-objects` command are in the pack
> resulting from the second `git pack-objects` command.

Very nice. I appreciate you taking my suggestion here; I'm hopeful that
it simplified things and resulted in fewer new lines of code.

> Signed-off-by: John Cai <johncai86@gmail.com>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/git-repack.txt | 12 +++++++
>  builtin/repack.c             | 67 ++++++++++++++++++++++++++++++++++++
>  t/t7700-repack.sh            | 24 +++++++++++++
>  3 files changed, 103 insertions(+)
>
> diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
> index 4017157949..6d5bec7716 100644
> --- a/Documentation/git-repack.txt
> +++ b/Documentation/git-repack.txt
> @@ -143,6 +143,18 @@ depth is 4095.
>  	a larger and slower repository; see the discussion in
>  	`pack.packSizeLimit`.
>
> +--filter=<filter-spec>::
> +	Remove objects matching the filter specification from the
> +	resulting packfile and put them into a separate packfile. Note
> +	that objects used in the working directory are not filtered
> +	out. So for the split to fully work, it's best to perform it
> +	in a bare repo and to use the `-a` and `-d` options along with
> +	this option.  Also `--no-write-bitmap-index` (or the
> +	`repack.writebitmaps` config option set to `false`) should be
> +	used otherwise writing bitmap index will fail, as it supposes
> +	a single packfile containing all the objects. See
> +	linkgit:git-rev-list[1] for valid `<filter-spec>` forms.
> +
>  -b::
>  --write-bitmap-index::
>  	Write a reachability bitmap index as part of the repack. This
> diff --git a/builtin/repack.c b/builtin/repack.c
> index 21e3b89f27..2c81b7738e 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -53,6 +53,7 @@ struct pack_objects_args {
>  	const char *depth;
>  	const char *threads;
>  	const char *max_pack_size;
> +	const char *filter;
>  	int no_reuse_delta;
>  	int no_reuse_object;
>  	int quiet;
> @@ -166,6 +167,8 @@ static void prepare_pack_objects(struct child_process *cmd,
>  		strvec_pushf(&cmd->args, "--threads=%s", args->threads);
>  	if (args->max_pack_size)
>  		strvec_pushf(&cmd->args, "--max-pack-size=%s", args->max_pack_size);
> +	if (args->filter)
> +		strvec_pushf(&cmd->args, "--filter=%s", args->filter);
>  	if (args->no_reuse_delta)
>  		strvec_pushf(&cmd->args, "--no-reuse-delta");
>  	if (args->no_reuse_object)
> @@ -726,6 +729,57 @@ static int finish_pack_objects_cmd(struct child_process *cmd,
>  	return finish_command(cmd);
>  }
>
> +static int write_filtered_pack(const struct pack_objects_args *args,
> +			       const char *destination,
> +			       const char *pack_prefix,
> +			       struct string_list *names,
> +			       struct string_list *existing_packs,
> +			       struct string_list *existing_kept_packs)
> +{
> +	struct child_process cmd = CHILD_PROCESS_INIT;
> +	struct string_list_item *item;
> +	FILE *in;
> +	int ret;
> +	const char *scratch;
> +	int local = skip_prefix(destination, packdir, &scratch);
> +
> +	/* We need to copy 'args' to modify it */
> +	struct pack_objects_args new_args = *args;
> +
> +	/* No need to filter again */
> +	new_args.filter = NULL;
> +
> +	prepare_pack_objects(&cmd, &new_args, destination);
> +
> +	strvec_push(&cmd.args, "--stdin-packs");
> +
> +	cmd.in = -1;
> +
> +	ret = start_command(&cmd);
> +	if (ret)
> +		return ret;


> +	/*
> +	 * names has a confusing double use: it both provides the list
> +	 * of just-written new packs, and accepts the name of the
> +	 * filtered pack we are writing.
> +	 *
> +	 * By the time it is read here, it contains only the pack(s)
> +	 * that were just written, which is exactly the set of packs we
> +	 * want to consider kept.
> +	 */

I think that this comment partially comes from the cruft pack code,
where we use the `names` string list both to reference existing packs at
the start of the repack, and to keep track of the pack we just wrote (to
exclude its contents from the cruft pack).

But I think we only write into "names" via finish_pack_objects_cmd() to
record the name of the pack we just wrote containing objects which
didn't meet the filter's conditions.

So I think that leaving this comment in is OK, but TBH I was on the
fence when I wrote that back in f9825d1cf75 (builtin/repack.c: support
generating a cruft pack, 2022-05-20), so I would just as soon drop it.

> +	in = xfdopen(cmd.in, "w");
> +	for_each_string_list_item(item, names)
> +		fprintf(in, "^%s-%s.pack\n", pack_prefix, item->string);
> +	for_each_string_list_item(item, existing_packs)
> +		fprintf(in, "%s.pack\n", item->string);

> +	for_each_string_list_item(item, existing_kept_packs)
> +		fprintf(in, "^%s.pack\n", item->string);

I think we may only want to do this if `honor_pack_keep` is zero.
Otherwise we'd avoid packing objects that appear in kept packs, even if
the caller told us to include objects found in kept packs.

> +	fclose(in);
> +
> +	return finish_pack_objects_cmd(&cmd, names, local);
> +}
> +
>  static int write_cruft_pack(const struct pack_objects_args *args,
>  			    const char *destination,
>  			    const char *pack_prefix,
> @@ -858,6 +912,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  				N_("limits the maximum number of threads")),
>  		OPT_STRING(0, "max-pack-size", &po_args.max_pack_size, N_("bytes"),
>  				N_("maximum size of each packfile")),
> +		OPT_STRING(0, "filter", &po_args.filter, N_("args"),
> +				N_("object filtering")),

I suppose we're storing the filter as a string here because we're just
going to pass it down to pack-objects directly. That part makes sense,
but I think we are producing subtly inconsistent behavior when
specifying multiple --filter options.

IIRC, passing --filter more than once down to pack-objects produces a
filter whose objects match all of the individually specified
sub-filters. But IIUC, using OPT_STRING here means that later
`--filter`'s override earlier ones.

So I think at minimum we'd want to store the filter arguments in a
strvec. But I would probably just as soon parse them into a bona-fide
list_objects_filter_options struct, and then reconstruct the arguments
to pack-objects based on that.

> diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
> index 27b66807cd..0a2c73bca7 100755
> --- a/t/t7700-repack.sh
> +++ b/t/t7700-repack.sh
> @@ -327,6 +327,30 @@ test_expect_success 'auto-bitmaps do not complain if unavailable' '
>  	test_must_be_empty actual
>  '
>
> +test_expect_success 'repacking with a filter works' '
> +	git -C bare.git repack -a -d &&
> +	test_stdout_line_count = 1 ls bare.git/objects/pack/*.pack &&

Huh! I never knew about the test_stdout_line_count function, I thought
that we always just had test_line_count. Neat!

> +	git -C bare.git -c repack.writebitmaps=false repack -a -d --filter=blob:none &&
> +	test_stdout_line_count = 2 ls bare.git/objects/pack/*.pack &&
> +	commit_pack=$(test-tool -C bare.git find-pack HEAD) &&
> +	test -n "$commit_pack" &&

I wonder if the test-tool itself should exit with a non-zero code if it
can't find the given object in any pack. It would at least allow us to
drop the "test -n $foo" after every invocation of the test-helper in
this test.

Arguably callers may want to ensure that an object doesn't exist in any
pack, and this would be inconvenient for them, since they'd have to
write something like:

    test_must_fail test-tool find-pack $obj

but I think a more direct test like

    test_must_fail git cat-file -t $obj

would do just as well.

> +	blob_pack=$(test-tool -C bare.git find-pack HEAD:file1) &&
> +	test -n "$blob_pack" &&
> +	test "$commit_pack" != "$blob_pack" &&
> +	tree_pack=$(test-tool -C bare.git find-pack HEAD^{tree}) &&
> +	test "$tree_pack" = "$commit_pack" &&
> +	blob_pack2=$(test-tool -C bare.git find-pack HEAD:file2) &&
> +	test "$blob_pack2" = "$blob_pack"
> +'

This all looks good, but I think there are a couple of more things that
we'd want to test for here:

  - That the list of all objects appears the same before and after all
    of the repacking. I think that this is tested implicitly already in
    your test, but having it written down explicitly would harden this
    against regressions that cause us to inadvertently delete an object
    we shouldn't have.

    (FWIW, I think this would be limited to running something like "git
    cat-file --batch-check='%(objectname)' --batch-all-objects" before
    and after all of the repacking, and ensuring that the two test_cmp
    without failure).

  - Another thing that I don't think we're testing here is that objects
    that *don't* match the filter don't appear in one of the filtered
    packs. I think we'd probably want to assert on the exact contents of
    the pack by dumping the list of objects into a file like "expect",
    and then dumping the actual set of objects with "git show-index
    <$idx | cut -d' ' -f2" or something.

Another thought from the OPT_STRING business above is that we probably
want to test this with non-trivial filter arguments. There are probably
a handful of interesting cases here, like passing `--no-filter`, passing
`--filter` multiple times, passing invalid values for `--filter`, etc.

> +test_expect_success '--filter fails with --write-bitmap-index' '
> +	test_must_fail git -C bare.git repack -a -d --write-bitmap-index \
> +		--filter=blob:none &&

Do we want to ensure that we get the exit code corresponding with
showing the usage text? I could go either way, but I do think that we
should grep through the output on stderr to ensure that we get the
appropriate error message.

> +	git -C bare.git repack -a -d --no-write-bitmap-index \
> +		--filter=blob:none

I don't think that this test is adding anything that the above
"repacking with a filter works" test isn't covering already.

Thanks,
Taylor
