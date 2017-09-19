Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF5C220281
	for <e@80x24.org>; Tue, 19 Sep 2017 03:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751300AbdISDBY (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 23:01:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62318 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751074AbdISDBX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 23:01:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3465BAA53D;
        Mon, 18 Sep 2017 23:01:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IYq9gUAsVy/dKBQKKTgwoBXhl64=; b=XHloaz
        AtmmKPd4fkz0bG9/dGZ8vUIsm8ObhgkqqtzZDZHugtqVL95tw7LWg6p4z7vpzsHH
        VVF9Sy2BHLApUvtTngu4QgX/NGFYfAIuHHNmaIh4bXvol5Jd2JeWnxz5Z6Cn2eW4
        FibODhHf8r5NlLDQesozxzmFhZb2LNeioXd0A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RPvHODPq95GcMbwCH5F0FyWdHpmI3I22
        OjqnB9RrszkCdDIZ7agV1Pg4RvOTkO+iGUDRTC4guqU2f1vdoBP6gYtQorDDQxwn
        TgbaKbTsxm5MuYbZIXCa5Tp/EuTPOGHGptvn3blFlOGvvxKPPs4XiF6XZ4QOAcl9
        5k34QUUiOeo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A5DFAA53B;
        Mon, 18 Sep 2017 23:01:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 765F1AA53A;
        Mon, 18 Sep 2017 23:01:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ian Campbell <ijc@hellion.org.uk>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/4] mktag: add option which allows the tagger field to be omitted
References: <1505633797.22447.4.camel@hellion.org.uk>
        <20170917073657.31193-1-ijc@hellion.org.uk>
Date:   Tue, 19 Sep 2017 12:01:20 +0900
In-Reply-To: <20170917073657.31193-1-ijc@hellion.org.uk> (Ian Campbell's
        message of "Sun, 17 Sep 2017 08:36:54 +0100")
Message-ID: <xmqqzi9rqtmn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D0A57084-9CE6-11E7-AE01-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ian Campbell <ijc@hellion.org.uk> writes:

> This can be useful e.g. in `filter-branch` when rewritting tags produced by
> older versions of Git, such as v2.6.12-rc2..v2.6.13-rc3 in the Linux kernel
> source tree:
>
>         $ git cat-file tag v2.6.12-rc2
>         object 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2
>         type commit
>         tag v2.6.12-rc2
>
>         Linux v2.6.12-rc2 release
>         -----BEGIN PGP SIGNATURE-----
>         Version: GnuPG v1.2.4 (GNU/Linux)
>
>         iD8DBQBCbW8ZF3YsRnbiHLsRAgFRAKCq/TkuDaEombFABkPqYgGCgWN2lQCcC0qc
>         wznDbFU45A54dZC8RZ5JxyE=
>         =ESRP
>         -----END PGP SIGNATURE-----
>
>         $ git cat-file tag v2.6.12-rc2 | git mktag
>         error: char76: could not find "tagger "
>         fatal: invalid tag signature file
>         $ git cat-file tag v2.6.12-rc2 | git mktag --allow-missing-tagger
>         9e734775f7c22d2f89943ad6c745571f1930105f
>
> To that end, pass the new option to `mktag` in `filter-branch`.

Hmph.  I cannot shake this nagging feeling that this is probably a
solution that is overly narrow to a single problem that won't scale
into the future.

As there is no guarantee that "missing-tagger" will stay to be the
only kind of broken tag objects we'd produce in one version, later
we notice our mistake and then forbid in another version, with the
approach to add '--allow-missing-tagger' optoin would imply that
we'd end up adding more and more such options, and filter-branch
will need to use all these '--allow-this-breakage' options we would
ever add.  Even though I fully agree with the problem you are trying
to solve (i.e. we want to be able to replay an old history without
our tool rejecting the data we have), it was my first reaction when
I read this patch.  IOW, my first reaction was "perhaps a single
option '--allow-broken' to cover the currently known and any future
shape of malformat over tag data is more appropriate".

But then, if we look at the body of cmd_mktag(), it looks like this:

	int cmd_mktag(...)
	{
		read input into strbuf buf;
		call verify_tag on buf to sanity check;
		call write_sha1_file() the contents of buf as a tag;
		report the object name;
	}

If we drop the "verification" step from the above, that essentially
becomes an equivaent to "hash-object -t tag -w --stdin".

So I now have to wonder if it may be sufficient to use "hash-object"
in filter-branch, without doing this "allow malformed data that we
would not permit if the tag were being created today, only to help
replaying an old, already broken data" change to "git mktag".

Is there something that makes "hash-object" insufficient (like it
still does some extra checks we would want to disable and cannot
work as a replacement for your "--allow-missing-tagger")?

Thanks.

> Signed-off-by: Ian Campbell <ijc@hellion.org.uk>
> ---
>  Documentation/git-mktag.txt |   9 +++-
>  builtin/mktag.c             | 100 +++++++++++++++++++++++++-------------------
>  git-filter-branch.sh        |   2 +-
>  t/t3800-mktag.sh            |  33 ++++++++++++++-
>  4 files changed, 98 insertions(+), 46 deletions(-)
>
> diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.txt
> index fa6a75612..c720c7419 100644
> --- a/Documentation/git-mktag.txt
> +++ b/Documentation/git-mktag.txt
> @@ -9,7 +9,7 @@ git-mktag - Creates a tag object
>  SYNOPSIS
>  --------
>  [verse]
> -'git mktag'
> +'git mktag' [--allow-missing-tagger]
>  
>  DESCRIPTION
>  -----------
> @@ -34,6 +34,13 @@ exists, is separated by a blank line from the header.  The
>  message part may contain a signature that Git itself doesn't
>  care about, but that can be verified with gpg.
>  
> +OPTIONS
> +-------
> +--allow-missing-tagger::
> +	Allow the `tagger` line in the header to be omitted. This is
> +	rarely desirable but may be useful in recreating tags created
> +	by older Git.
> +
>  GIT
>  ---
>  Part of the linkgit:git[1] suite
> diff --git a/builtin/mktag.c b/builtin/mktag.c
> index 031b750f0..0f5dae8d5 100644
> --- a/builtin/mktag.c
> +++ b/builtin/mktag.c
> @@ -1,4 +1,5 @@
>  #include "builtin.h"
> +#include "parse-options.h"
>  #include "tag.h"
>  
>  /*
> @@ -15,6 +16,8 @@
>   * the shortest possible tagger-line.
>   */
>  
> +static int allow_missing_tagger;
> +
>  /*
>   * We refuse to tag something we can't verify. Just because.
>   */
> @@ -41,8 +44,9 @@ static int verify_tag(char *buffer, unsigned long size)
>  	unsigned char sha1[20];
>  	const char *object, *type_line, *tag_line, *tagger_line, *lb, *rb;
>  	size_t len;
> +	const unsigned long min_size = allow_missing_tagger ? 71 : 84;
>  
> -	if (size < 84)
> +	if (size < min_size)
>  		return error("wanna fool me ? you obviously got the size wrong !");
>  
>  	buffer[size] = 0;
> @@ -98,46 +102,46 @@ static int verify_tag(char *buffer, unsigned long size)
>  	/* Verify the tagger line */
>  	tagger_line = tag_line;
>  
> -	if (memcmp(tagger_line, "tagger ", 7))
> +	if (!memcmp(tagger_line, "tagger ", 7)) {
> +		/*
> +		 * Check for correct form for name and email
> +		 * i.e. " <" followed by "> " on _this_ line
> +		 * No angle brackets within the name or email address fields.
> +		 * No spaces within the email address field.
> +		 */
> +		tagger_line += 7;
> +		if (!(lb = strstr(tagger_line, " <")) || !(rb = strstr(lb+2, "> ")) ||
> +			strpbrk(tagger_line, "<>\n") != lb+1 ||
> +			strpbrk(lb+2, "><\n ") != rb)
> +			return error("char%"PRIuMAX": malformed tagger field",
> +				(uintmax_t) (tagger_line - buffer));
> +
> +		/* Check for author name, at least one character, space is acceptable */
> +		if (lb == tagger_line)
> +			return error("char%"PRIuMAX": missing tagger name",
> +				(uintmax_t) (tagger_line - buffer));
> +
> +		/* timestamp, 1 or more digits followed by space */
> +		tagger_line = rb + 2;
> +		if (!(len = strspn(tagger_line, "0123456789")))
> +			return error("char%"PRIuMAX": missing tag timestamp",
> +				(uintmax_t) (tagger_line - buffer));
> +		tagger_line += len;
> +		if (*tagger_line != ' ')
> +			return error("char%"PRIuMAX": malformed tag timestamp",
> +				(uintmax_t) (tagger_line - buffer));
> +		tagger_line++;
> +
> +		/* timezone, 5 digits [+-]hhmm, max. 1400 */
> +		if (!((tagger_line[0] == '+' || tagger_line[0] == '-') &&
> +		      strspn(tagger_line+1, "0123456789") == 4 &&
> +		      tagger_line[5] == '\n' && atoi(tagger_line+1) <= 1400))
> +			return error("char%"PRIuMAX": malformed tag timezone",
> +				(uintmax_t) (tagger_line - buffer));
> +		tagger_line += 6;
> +	} else if (!allow_missing_tagger)
>  		return error("char%"PRIuMAX": could not find \"tagger \"",
> -			(uintmax_t) (tagger_line - buffer));
> -
> -	/*
> -	 * Check for correct form for name and email
> -	 * i.e. " <" followed by "> " on _this_ line
> -	 * No angle brackets within the name or email address fields.
> -	 * No spaces within the email address field.
> -	 */
> -	tagger_line += 7;
> -	if (!(lb = strstr(tagger_line, " <")) || !(rb = strstr(lb+2, "> ")) ||
> -		strpbrk(tagger_line, "<>\n") != lb+1 ||
> -		strpbrk(lb+2, "><\n ") != rb)
> -		return error("char%"PRIuMAX": malformed tagger field",
> -			(uintmax_t) (tagger_line - buffer));
> -
> -	/* Check for author name, at least one character, space is acceptable */
> -	if (lb == tagger_line)
> -		return error("char%"PRIuMAX": missing tagger name",
> -			(uintmax_t) (tagger_line - buffer));
> -
> -	/* timestamp, 1 or more digits followed by space */
> -	tagger_line = rb + 2;
> -	if (!(len = strspn(tagger_line, "0123456789")))
> -		return error("char%"PRIuMAX": missing tag timestamp",
> -			(uintmax_t) (tagger_line - buffer));
> -	tagger_line += len;
> -	if (*tagger_line != ' ')
> -		return error("char%"PRIuMAX": malformed tag timestamp",
> -			(uintmax_t) (tagger_line - buffer));
> -	tagger_line++;
> -
> -	/* timezone, 5 digits [+-]hhmm, max. 1400 */
> -	if (!((tagger_line[0] == '+' || tagger_line[0] == '-') &&
> -	      strspn(tagger_line+1, "0123456789") == 4 &&
> -	      tagger_line[5] == '\n' && atoi(tagger_line+1) <= 1400))
> -		return error("char%"PRIuMAX": malformed tag timezone",
> -			(uintmax_t) (tagger_line - buffer));
> -	tagger_line += 6;
> +			     (uintmax_t) (tagger_line - buffer));
>  
>  	/* Verify the blank line separating the header from the body */
>  	if (*tagger_line != '\n')
> @@ -148,13 +152,25 @@ static int verify_tag(char *buffer, unsigned long size)
>  	return 0;
>  }
>  
> +static char const * const mktag_usage[] = {
> +	N_("git mktag [<options>]"),
> +	NULL
> +};
> +
> +static struct option mktag_opts[] = {
> +	OPT_BOOL(0, "allow-missing-tagger", &allow_missing_tagger, N_("allow the tagger field to be omitted")),
> +	OPT_END(),
> +};
> +
>  int cmd_mktag(int argc, const char **argv, const char *prefix)
>  {
>  	struct strbuf buf = STRBUF_INIT;
>  	unsigned char result_sha1[20];
>  
> -	if (argc != 1)
> -		usage("git mktag");
> +	argc = parse_options(argc, argv, prefix, mktag_opts, mktag_usage, 0);
> +
> +	if (argc != 0)
> +		usage_with_options(mktag_usage, mktag_opts);
>  
>  	if (strbuf_read(&buf, 0, 4096) < 0) {
>  		die_errno("could not read from stdin");
> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index 3a74602ef..05645064a 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -530,7 +530,7 @@ if [ "$filter_tag_name" ]; then
>  					}' \
>  				    -e '/^-----BEGIN PGP SIGNATURE-----/q' \
>  				    -e 'p' ) |
> -				git mktag) ||
> +				git mktag --allow-missing-tagger) ||
>  				die "Could not create new tag object for $ref"
>  			if git cat-file tag "$ref" | \
>  			   sane_grep '^-----BEGIN PGP SIGNATURE-----' >/dev/null 2>&1
> diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
> index 8eb47942e..3a77a26c8 100755
> --- a/t/t3800-mktag.sh
> +++ b/t/t3800-mktag.sh
> @@ -340,7 +340,36 @@ check_verify_failure 'detect invalid header entry' \
>  	'^error: char124: trailing garbage in tag header$'
>  
>  ############################################################
> -# 24. create valid tag
> +# 24. missing tagger ok with --allow-missing-tagger
> +
> +cat >tag.sig <<EOF
> +object $head
> +type commit
> +tag mytag
> +
> +EOF
> +
> +test_expect_success \
> +    'missing tagger with --allow-missing-tagger' \
> +    'git mktag --allow-missing-tagger <tag.sig >.git/refs/tags/mytag 2>message'
> +
> +############################################################
> +# 25. detect invalid header entry with --allow-missing-tagger
> +
> +cat >tag.sig <<EOF
> +object $head
> +type commit
> +tag mytag
> +this line should not be here
> +EOF
> +
> +test_expect_success \
> +    'detect invalid header entry with --allow-missing-tagger' \
> +    '( test_must_fail git mktag --allow-missing-tagger <tag.sig 2>message ) &&
> +       grep "^error: char70: trailing garbage in tag header$" message'
> +
> +############################################################
> +# 26. create valid tag
>  
>  cat >tag.sig <<EOF
>  object $head
> @@ -355,7 +384,7 @@ test_expect_success \
>      'git mktag <tag.sig >.git/refs/tags/mytag 2>message'
>  
>  ############################################################
> -# 25. check mytag
> +# 27. check mytag
>  
>  test_expect_success \
>      'check mytag' \
