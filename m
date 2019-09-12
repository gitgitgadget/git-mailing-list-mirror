Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 050211F463
	for <e@80x24.org>; Thu, 12 Sep 2019 20:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfILURJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 16:17:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57203 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfILURI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 16:17:08 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 82617273DE;
        Thu, 12 Sep 2019 16:17:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pJkwfiwPUIoSxdU3hTmbLsmVXms=; b=XKwHVd
        DW9qB1mYmLAjZ1oJ3x9INJTIxzrzfG49S+RG1tENo3wUs6+1SH3bqhyFlc7dLKr5
        TQQ+yPhNlhIzqrqrcJCpZ442MZ4QhHbZX35gVr/cDSfNnTsV0uQ+0bmbysYHAbvV
        6i1R6d3n7k8f63gU0rwZiOIkI7qKYgD0OnZJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=apWe1lGJZRX+qCo3AtU9n+E/DwThVS+o
        autu2d0V0WAZgmWWoj1/t2VNDSk2ifUX9WPVgV3gSlGETiJm/qvmi5SrtdkXgAGG
        v3kVgOfbQd/xTP45+cpYnsVux+c4/KBYTrLzepf3s4dbcGKVVlv0lTCYvkx1ZXcb
        7rcC1AipiOU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 72F99273DD;
        Thu, 12 Sep 2019 16:17:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A6F6D273DC;
        Thu, 12 Sep 2019 16:17:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "William Baker via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, williamtbakeremail@gmail.com,
        stolee@gmail.com, jeffhost@microsoft.com,
        William Baker <William.Baker@microsoft.com>
Subject: Re: [PATCH 1/1] multi-pack-index: add --no-progress Add --no-progress option to git multi-pack-index. The progress feature was added in 144d703 ("multi-pack-index: report progress during 'verify'", 2018-09-13) but the ability to opt-out was overlooked.
References: <pull.337.git.gitgitgadget@gmail.com>
        <0821a8073a48067ecd9ce08226656fa04d803f6b.1568216234.git.gitgitgadget@gmail.com>
Date:   Thu, 12 Sep 2019 13:17:04 -0700
In-Reply-To: <0821a8073a48067ecd9ce08226656fa04d803f6b.1568216234.git.gitgitgadget@gmail.com>
        (William Baker via GitGitGadget's message of "Wed, 11 Sep 2019
        08:37:15 -0700 (PDT)")
Message-ID: <xmqqlfutfewv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4A2416E8-D59A-11E9-AB5D-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"William Baker via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  [verse]
> -'git multi-pack-index' [--object-dir=<dir>] <subcommand>
> +'git multi-pack-index' [--object-dir=<dir>] <subcommand> [--[no-]progress]

I am wondering what the reasoning behind having this new one *after*
the subcommand while the existing one *before* is.  Isn't the
--[no-]progress option supported by all subcommands of the
multi-pack-index command, just like the --object-dir=<dir> option
is?

If there is no reason that explains why one must come before and the
other must come after the subcommand, we are then adding another
thing the end-users or scriptors need to memorize, which is not
ideal.

> +--[no-]progress::
> +	Turn progress on/off explicitly. If neither is specified, progress is 
> +	shown if standard error is connected to a terminal.

Sounds sensible.

> diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
> index b1ea1a6aa1..f8b2a74179 100644
> --- a/builtin/multi-pack-index.c
> +++ b/builtin/multi-pack-index.c
> @@ -6,34 +6,41 @@
>  #include "trace2.h"
>  
>  static char const * const builtin_multi_pack_index_usage[] = {
> -	N_("git multi-pack-index [--object-dir=<dir>] (write|verify|expire|repack --batch-size=<size>)"),
> +	N_("git multi-pack-index [--object-dir=<dir>] (write|verify|expire|repack --batch-size=<size>) [--[no-]progress]"),
>  	NULL
>  };

The same comment as the SYNOPSIS part.

>  static struct opts_multi_pack_index {
>  	const char *object_dir;
>  	unsigned long batch_size;
> +	int progress;
>  } opts;
>  
>  int cmd_multi_pack_index(int argc, const char **argv,
>  			 const char *prefix)
>  {
> +	unsigned flags = 0;
> +
>  	static struct option builtin_multi_pack_index_options[] = {
>  		OPT_FILENAME(0, "object-dir", &opts.object_dir,
>  		  N_("object directory containing set of packfile and pack-index pairs")),
>  		OPT_MAGNITUDE(0, "batch-size", &opts.batch_size,
>  		  N_("during repack, collect pack-files of smaller size into a batch that is larger than this size")),
> +		OPT_BOOL(0, "progress", &opts.progress, N_("force progress reporting")),
>  		OPT_END(),
>  	};

Seeing that all the options that made me curious (see above) are
defined here for all subcommands, I suspect that "technically",
all options must come before the <subcommand> (side note: I know
parse-options may reorder commands after options, but in the
documentation and usage, we strongly discourage users from relying
on the reordering and always show "global --options, subcommand, and
then subcommand --options" order).  I also see in the code that
handles opts.batch_size that there is a workaround for this inverted
code structure to make sure subcommands other than repack does not
allow --batch-size option specified.

Unless and until we get rid of the "git multi-pack-index" as a
separate command (side note: when it happens, we;'d call the
underlying midx API functions directly from appropriate places in
the codepaths like "gc"), we probably would want to correct the use
of parse_options() API in the implementation of this command before
adding any new option or subcommand.

> @@ -47,14 +54,15 @@ int cmd_multi_pack_index(int argc, const char **argv,
>  	trace2_cmd_mode(argv[0]);
>  
>  	if (!strcmp(argv[0], "repack"))
> -		return midx_repack(the_repository, opts.object_dir, (size_t)opts.batch_size);
> +		return midx_repack(the_repository, opts.object_dir, 
> +			(size_t)opts.batch_size, flags);
>  	if (opts.batch_size)
>  		die(_("--batch-size option is only for 'repack' subcommand"));
>  
>  	if (!strcmp(argv[0], "write"))
>  		return write_midx_file(opts.object_dir);
>  	if (!strcmp(argv[0], "verify"))
> -		return verify_midx_file(the_repository, opts.object_dir);
> +		return verify_midx_file(the_repository, opts.object_dir, flags);
>  	if (!strcmp(argv[0], "expire"))
>  		return expire_midx_packs(the_repository, opts.object_dir);

We can see that the new option only affects "verify", even though
the SYNOPSIS and usage text pretends that everybody understands and
reacts to it.  Shouldn't it be documented just like how --batch-size
is documented that it is understood only by "repack"?

If the mid-term aspiration of this patch is to later enhance other
subcommands to also understand the progress output or verbosity
option (and if the excuse given as a response to the above analysis
is "this is just a first step, more will come later"), the instead
of adding a "unsigned flag" local variable to the function, it would
probably make much more sense to

 (1) make struct opts_multi_pack_index as a part of the public API
     between cmd_multi_pack_index() and midx.c and document it in
     midx.h;

 (2) instead of passing opts.object_dir to existing command
     implementations, pass &opts, the pointer to the whole
     structure;

 (3) add a new field "unsigned progress" to the structure, and teach
     the command line parser to flip it upon seeing "--[no-]progress".
