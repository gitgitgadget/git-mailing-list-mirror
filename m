Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59134C433E1
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 04:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 056C82075F
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 04:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sHvvMO+r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgGME0c (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 00:26:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64774 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgGME0b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 00:26:31 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 81DB57E4F5;
        Mon, 13 Jul 2020 00:26:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pPWSvt6zI48hrptW586FgiDUB+E=; b=sHvvMO
        +rzvpf8Ict/Wa1EwDGhLquXm+ADM9dOOb7GU3irbFRcc4Zd+xSQ76FTDN78i+l3C
        +we5pBbyEAZb6603lLoaNDoIrzk4Wl1pHi4FesfTSv4kKC80bZCAzKkjjGkGGZM4
        Oy26Ys6dth5lrlIQDINHm29DWw1KQ4D/i/I0A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qdeWjdo/M7/woeq3sd4TUT65ks7a8LK1
        7rwe9WmXJCjZkIsAsdh+W8676RndzlXPc5F5Ocm4TDWP82t7Tc68yJyDT9bvrV31
        WztQBqUwqWalRJx0rBWV8/ANBFgbr/13AnIOknRf0krDrJXozQzdFWEyDaI1j/3B
        gq2y43CGgcg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 789177E4F4;
        Mon, 13 Jul 2020 00:26:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 04FE67E4F3;
        Mon, 13 Jul 2020 00:26:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Denton Liu <liu.denton@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 31/39] bundle: add new version for use with SHA-256
References: <20200713024909.3714837-1-sandals@crustytoothpaste.net>
        <20200713024909.3714837-32-sandals@crustytoothpaste.net>
Date:   Sun, 12 Jul 2020 21:26:24 -0700
In-Reply-To: <20200713024909.3714837-32-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 13 Jul 2020 02:49:01 +0000")
Message-ID: <xmqqeepgoxan.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 033E1D20-C4C1-11EA-A087-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Currently we detect the hash algorithm in use by the length of the
> object ID.  This is inelegant and prevents us from using a different
> hash algorithm that is also 256 bits in length.
>
> Since we cannot extend the v2 format in a backward-compatible way, let's
> add a v3 format, which is identical, except for the addition of
> capabilities, which are prefixed by an at sign.  We add "object-format"
> as the only capability and reject unknown capabilities, since we do not
> have a network connection and therefore cannot negotiate with the other
> side.
>
> For compatibility, default to the v2 format for SHA-1 and require v3
> for SHA-256.
>
> In t5510, always use format v3 so we can be sure we produce consistent
> results across hash algorithms.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---

Wow, that was quick ;-)

> +capability   = "@" key ["=" value] LF
> +key          = 1*(ALPHA / DIGIT / "-")
> +value        = *(%01-09 / %0b-FF)

OK.

> --- a/builtin/bundle.c
> +++ b/builtin/bundle.c
> @@ -60,6 +60,7 @@ static int cmd_bundle_create(int argc, const char **argv, const char *prefix) {
>  	int all_progress_implied = 0;
>  	int progress = isatty(STDERR_FILENO);
>  	struct argv_array pack_opts;
> +	int version = -1;
>  
>  	struct option options[] = {
>  		OPT_SET_INT('q', "quiet", &progress,
> @@ -71,6 +72,8 @@ static int cmd_bundle_create(int argc, const char **argv, const char *prefix) {
>  		OPT_BOOL(0, "all-progress-implied",
>  			 &all_progress_implied,
>  			 N_("similar to --all-progress when progress meter is shown")),
> +		OPT_INTEGER(0, "version", &version,
> +			    N_("specify bundle format version")),
>  		OPT_END()
>  	};
>  	const char* bundle_file;
> @@ -91,7 +94,7 @@ static int cmd_bundle_create(int argc, const char **argv, const char *prefix) {
>  
>  	if (!startup_info->have_repository)
>  		die(_("Need a repository to create a bundle."));
> -	return !!create_bundle(the_repository, bundle_file, argc, argv, &pack_opts);
> +	return !!create_bundle(the_repository, bundle_file, argc, argv, &pack_opts, version);

OK, so the builtin command itself does not know how the default
version is picked; it is left to the code in bundle.c which is at a
lower layer.  Makes sense.

> diff --git a/bundle.c b/bundle.c
> index 2a0d744d3f..5636ea5f7c 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -12,7 +12,8 @@
>  #include "refs.h"
>  #include "argv-array.h"
>  
> -static const char bundle_signature[] = "# v2 git bundle\n";
> +static const char v2_bundle_signature[] = "# v2 git bundle\n";
> +static const char v3_bundle_signature[] = "# v3 git bundle\n";
>  
>  static void add_to_ref_list(const struct object_id *oid, const char *name,
>  		struct ref_list *list)
> @@ -23,17 +24,20 @@ static void add_to_ref_list(const struct object_id *oid, const char *name,
>  	list->nr++;
>  }
>  
> -static const struct git_hash_algo *detect_hash_algo(struct strbuf *buf)
> +static int parse_capability(struct bundle_header *header, const char *capability)
>  {
> +	const char *arg;
> +	if (skip_prefix(capability, "object-format=", &arg)) {
> +		int algo = hash_algo_by_name(arg);
> +		if (algo == GIT_HASH_UNKNOWN)
> +			return error(_("unable to detect hash algorithm"));
> +		header->hash_algo = &hash_algos[algo];
> +		return 0;
> +	}
> +	return error(_("unknown capability '%s'"), capability);

This certainly enforces the earlier EBNF we saw on the value side by
the caller stopping at the first LF and feeding the bytes before it
to the function, but there is no sanity checking for the key part.

In a sense, there is no need to. As we always reject what is unknown
to us, the only thing we need is to ensure that skip_prefix() we use
here are the syntactically correct key followed by '='.

>  }
>  
> +
>  static int parse_bundle_header(int fd, struct bundle_header *header,
>  			       const char *report_path)
>  {

I do not particularly mind two blank lines between functions but
let's be consistent, and this patch is not the place to make that
change.

> @@ -42,14 +46,18 @@ static int parse_bundle_header(int fd, struct bundle_header *header,
>  
>  	/* The bundle header begins with the signature */
>  	if (strbuf_getwholeline_fd(&buf, fd, '\n') ||
> -	    strcmp(buf.buf, bundle_signature)) {
> +	    (strcmp(buf.buf, v2_bundle_signature) &&
> +	     strcmp(buf.buf, v3_bundle_signature))) {
>  		if (report_path)
> -			error(_("'%s' does not look like a v2 bundle file"),
> +			error(_("'%s' does not look like a v2 or v3 bundle file"),
>  			      report_path);
>  		status = -1;
>  		goto abort;
>  	}

OK.

> +	header->version = buf.buf[3] - '0';

Hmmmmm.  So in addition to the vN_bundle_signature[], the code also
knows where the '2' and '3' are?  It may be overkill to have a
helper function just for this but

	if (strbuf_getwholeline_fd(&buf, fd, '\n') ||
	    parse_bundle_signature(buf.buf, header)) {
		... does not look like a supported bundle file ...
	}

with

	static struct {
		int version;
	        const char *signature;
	} bundle_sigs[] = {
		{ 2, "# v2 git bundle\n" },
		{ 3, "# v3 git bundle\n" },
	};

	static int parse_bundle_signature(const char *s, struct bundle_header *h)
	{
		int i;

                for (i = 0; i < ARRAY_SIZE(bundle_sigs); i++) {
			if (!strcmp(s, bundle_sigs[i].signature) {
				h->version = bundle_sigs[i].version;
				return 0;
			}
		}
		return -1;
	}

or something like that?

> +	header->hash_algo = the_hash_algo;
> +
>  	/* The bundle header ends with an empty line */
>  	while (!strbuf_getwholeline_fd(&buf, fd, '\n') &&
>  	       buf.len && buf.buf[0] != '\n') {
> @@ -57,21 +65,21 @@ static int parse_bundle_header(int fd, struct bundle_header *header,
>  		int is_prereq = 0;
>  		const char *p;
>  
> +		if (header->version == 3 && *buf.buf == '@') {
> +			buf.buf[buf.len - 1] = '\0';

This is chomping the final LF.  I know the current code does not
care, but after this, buf.len is inconsistent with buf.buf in that
the NUL we placed here is not part of the payload on the line.
Doing strbuf_rtrim(&buf) is certainly too much (it also drops
trailing whitespaces), but it somewhat feels disturbing.  It might
be sufficient to say

			buf.buf[--buf.len] = '\0';

to make it palatable.  I dunno.

> +			if (parse_capability(header, buf.buf + 1)) {
> +				status = -1;
> +				break;
> +			}
> +			continue;
> +		}
> +
>  		if (*buf.buf == '-') {
>  			is_prereq = 1;
>  			strbuf_remove(&buf, 0, 1);
>  		}
>  		strbuf_rtrim(&buf);
>  
> -		if (!header->hash_algo) {
> -			header->hash_algo = detect_hash_algo(&buf);
> -			if (!header->hash_algo) {
> -				error(_("unknown hash algorithm length"));
> -				status = -1;
> -				break;
> -			}
> -		}
> -
>  		/*
>  		 * Tip lines have object name, SP, and refname.
>  		 * Prerequisites have object name that is optionally
> @@ -449,13 +457,14 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
>  }
>  
>  int create_bundle(struct repository *r, const char *path,
> -		  int argc, const char **argv, struct argv_array *pack_options)
> +		  int argc, const char **argv, struct argv_array *pack_options, int version)
>  {
>  	struct lock_file lock = LOCK_INIT;
>  	int bundle_fd = -1;
>  	int bundle_to_stdout;
>  	int ref_count = 0;
>  	struct rev_info revs;
> +	int default_version = the_hash_algo == &hash_algos[GIT_HASH_SHA1] ? 2 : 3;
>  
>  	bundle_to_stdout = !strcmp(path, "-");
>  	if (bundle_to_stdout)
> @@ -464,8 +473,22 @@ int create_bundle(struct repository *r, const char *path,
>  		bundle_fd = hold_lock_file_for_update(&lock, path,
>  						      LOCK_DIE_ON_ERROR);
>  
> -	/* write signature */
> -	write_or_die(bundle_fd, bundle_signature, strlen(bundle_signature));
> +	if (version == -1)
> +		version = default_version;
> +
> +	if (version < 2 || version > 3) {
> +		die(_("unsupported bundle version %d"), version);
> +	} else if (version < default_version) {
> +		die(_("cannot write bundle version %d with algorithm %s"), version, the_hash_algo->name);
> +	} else if (version == 2) {
> +		write_or_die(bundle_fd, v2_bundle_signature, strlen(v2_bundle_signature));
> +	} else {
> +		const char *capability = "@object-format=";
> +		write_or_die(bundle_fd, v3_bundle_signature, strlen(v3_bundle_signature));
> +		write_or_die(bundle_fd, capability, strlen(capability));
> +		write_or_die(bundle_fd, the_hash_algo->name, strlen(the_hash_algo->name));
> +		write_or_die(bundle_fd, "\n", 1);
> +	}

Quite straight-forward.

> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index a66dbe0bde..9284b64e7e 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -281,15 +281,16 @@ test_expect_success 'create bundle 1' '
>  	cd "$D" &&
>  	echo >file updated again by origin &&
>  	git commit -a -m "tip" &&
> -	git bundle create bundle1 master^..master
> +	git bundle create --version=3 bundle1 master^..master
>  '
>  
>  test_expect_success 'header of bundle looks right' '
>  	head -n 4 "$D"/bundle1 &&
>  	head -n 1 "$D"/bundle1 | grep "^#" &&
> -	head -n 2 "$D"/bundle1 | grep "^-$OID_REGEX " &&
> -	head -n 3 "$D"/bundle1 | grep "^$OID_REGEX " &&
> -	head -n 4 "$D"/bundle1 | grep "^$"
> +	head -n 2 "$D"/bundle1 | grep "^@object-format=" &&
> +	head -n 3 "$D"/bundle1 | grep "^-$OID_REGEX " &&
> +	head -n 4 "$D"/bundle1 | grep "^$OID_REGEX " &&
> +	head -n 5 "$D"/bundle1 | grep "^$"
>  '

This is not new, but because "head -n $n" is not "look at the $n-th
line", but "look at the first $n lines", the construct look somewhat
bogus.  Wouldn't we want something more like

	sed -n -e 1p "$D/bundle1" | grep "^#" &&
	sed -n -e 2p "$D/bundle1" | grep "^@object-format=" &&
	...

I wonder.

> +test_expect_success 'git bundle uses expected default format' '
> +	git bundle create bundle HEAD^.. &&
> +	head -n1 bundle | grep "^# v$(test_oid version) git bundle$"
> +'

Nice.

> +test_expect_success 'git bundle v3 has expected contents' '
> +	git branch side HEAD &&
> +	git bundle create --version=3 bundle HEAD^..side &&
> +	head -n2 bundle >actual &&
> +	echo "# v3 git bundle" >expected &&
> +	echo "@object-format=$(test_oid algo)" >>expected &&

Rather than two separate echo,

	cat >expect <<-EOF &&
	# v3 git bundle
	@object-format=$(test_oid algo)
	EOF

might be more direct and easier to see what is expected.

> +	test_cmp actual expected &&
> +	git bundle verify bundle
> +'
> +
> +test_expect_success 'git bundle v3 rejects unknown extensions' '
> +	head -n2 bundle >new &&
> +	echo "@unknown=silly" >>new &&
> +	sed "1,2d" >>new &&

What are we feeding this sed?  You meant to feed 'bundle'?

> +	test_must_fail git bundle verify new 2>output &&
> +	grep "unknown capability .unknown=silly." output
> +'
> +
>  test_done
