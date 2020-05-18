Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B4AC433DF
	for <git@archiver.kernel.org>; Mon, 18 May 2020 16:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16EF020657
	for <git@archiver.kernel.org>; Mon, 18 May 2020 16:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tnCt5K3Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgERQU2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 12:20:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64530 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgERQU2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 12:20:28 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BCBA861FD9;
        Mon, 18 May 2020 12:20:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+dsfzNUTV18hvkLCIyRrOkaz9UA=; b=tnCt5K
        3QDgiA0z9b7FyH7LY6XSwhtXalmQUw5Jyy47zZ774c7ZO6SUUOnWFnRyeB3E7xBn
        Sr00pZydVCkvKp/WQe/uFDj+4VR63OfXxmeGiZPj0brsjmWaypRE6KrBC9GOSBfU
        kEhb9tbG6imOtQzz35m3nqAtPS7ztnRqHzTp0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VPGfZsnIv1Goy/X8t+eIDaevZBqbilib
        1wznZGEc/fOAeckCcCZFPXmbSdkmmEep70Cuxov3GaLO1zfp6HXzXLC7Wi4ppGp3
        js3FoO5iDAELufDBKBKh5kaS9o9S7QuLtbCvy1Pz5n8FpPyvJpw1dDQPDHp4BPzt
        TSDn0DuPHC8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B3FC461FD8;
        Mon, 18 May 2020 12:20:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 37AAD61FD7;
        Mon, 18 May 2020 12:20:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 27/44] builtin/show-index: provide options to determine hash algo
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
        <20200513005424.81369-28-sandals@crustytoothpaste.net>
Date:   Mon, 18 May 2020 09:20:22 -0700
In-Reply-To: <20200513005424.81369-28-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Wed, 13 May 2020 00:54:07 +0000")
Message-ID: <xmqqimgt5i61.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 79ABF7B2-9923-11EA-B0EA-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> It's possible to use a variety of index formats with show-index, and we
> need a way to indicate the hash algorithm which is in use for a
> particular index we'd like to show.  Default to using the value for the
> repository we're in by calling setup_git_directory_gently, and allow
> overriding it by using a --hash argument.

I think you meant to say that "show-index" does not autodetect what
hash algorithm is used from its input, and the new argument is a way
for the user to help the command when the hash algorithm is
different from what is used in the current repository?

I ask because I found that your version can be read to say that
"show-index" can show the contents of a given pack index using any
hash algorithm we support, and the user can specify --hash=SHA-256
when running the command on a pack .idx that uses SHA-1 object names
to auto-convert it, and readers wouldn't be able to guess which was
meant with only the above five lines.

> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  builtin/show-index.c | 29 ++++++++++++++++++++++++-----
>  git.c                |  2 +-
>  2 files changed, 25 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/show-index.c b/builtin/show-index.c
> index 0826f6a5a2..ebfa2e9abd 100644
> --- a/builtin/show-index.c
> +++ b/builtin/show-index.c
> @@ -1,9 +1,12 @@
>  #include "builtin.h"
>  #include "cache.h"
>  #include "pack.h"
> +#include "parse-options.h"
>  
> -static const char show_index_usage[] =
> -"git show-index";
> +static const char *const show_index_usage[] = {
> +	"git show-index [--hash=HASH]",
> +	NULL
> +};

Do we say --hash=SHA-1 etc. or --hash-algo=SHA-256 in other places?
Would the word "hash" alone clear enough that it does not refer to
a specific "hash" value but the name of an algorithm?

The generating side seems to use "index-pack --object-format=<algo>"
and the transport seems to use a capability "object-format=<algo>",
neither of which is directly visible to the end users, but I think
they follow "git init --object-format=<algo>", so we are consistent
there.

Perhaps we should follow suit here, too?

>  int cmd_show_index(int argc, const char **argv, const char *prefix)
>  {
> @@ -11,10 +14,26 @@ int cmd_show_index(int argc, const char **argv, const char *prefix)
>  	unsigned nr;
>  	unsigned int version;
>  	static unsigned int top_index[256];
> -	const unsigned hashsz = the_hash_algo->rawsz;
> +	unsigned hashsz;
> +	const char *hash_name = NULL;
> +	int hash_algo;
> +	const struct option show_index_options[] = {
> +		OPT_STRING(0, "hash", &hash_name, N_("hash"),
> +			   N_("specify the hash algorithm to use")),

init-db has an entry identical to this except for the second token
given to the macro is "object-format" instead of "hash".  Both may
want to change what's inside N_() to "hash algorithm".

> +		OPT_END()
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, show_index_options, show_index_usage, 0);
> +
> +	if (hash_name) {
> +		hash_algo = hash_algo_by_name(hash_name);
> +		if (hash_algo == GIT_HASH_UNKNOWN)
> +			die(_("Unknown hash algorithm"));
> +		repo_set_hash_algo(the_repository, hash_algo);
> +	}
> +
> +	hashsz = the_hash_algo->rawsz;
>  
> -	if (argc != 1)
> -		usage(show_index_usage);
>  	if (fread(top_index, 2 * 4, 1, stdin) != 1)
>  		die("unable to read header");
>  	if (top_index[0] == htonl(PACK_IDX_SIGNATURE)) {
> diff --git a/git.c b/git.c
> index 2e4efb4ff0..e53e8159a2 100644
> --- a/git.c
> +++ b/git.c
> @@ -573,7 +573,7 @@ static struct cmd_struct commands[] = {
>  	{ "shortlog", cmd_shortlog, RUN_SETUP_GENTLY | USE_PAGER },
>  	{ "show", cmd_show, RUN_SETUP },
>  	{ "show-branch", cmd_show_branch, RUN_SETUP },
> -	{ "show-index", cmd_show_index },
> +	{ "show-index", cmd_show_index, RUN_SETUP_GENTLY },

Hmph, this is not necessary to support peeking an .idx file in
another repository that uses a different hash algorithm than ours
(we do need the --hash=<algo> override to tell that the algo is
different from what we read from our repository settings).  Is this
absolutely necessary?

Ah, I am misreading the patch.  We didn't even do setup but we now
optionally do, in order to see if we are in a repository and what
object format it uses to give the default value to --hash=<algo>
when the argument is not given.  The need for RUN_SETUP_GENTLY
is understandable.

As we do not take any path argument on the command line, the other
side effect of setup_git_directory() that takes us up to the top
level of the working tree does not hurt us, either, so this is a
good change, I think.

Thanks.



>  	{ "show-ref", cmd_show_ref, RUN_SETUP },
>  	{ "sparse-checkout", cmd_sparse_checkout, RUN_SETUP | NEED_WORK_TREE },
>  	{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
