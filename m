Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ABDA2047F
	for <e@80x24.org>; Mon, 18 Sep 2017 23:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750990AbdIRXwf (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 19:52:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58516 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750714AbdIRXwe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 19:52:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 61150A80B3;
        Mon, 18 Sep 2017 19:52:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4LCtY/bvoQTyglKlITciZp0Ukn4=; b=lD2KRz
        Z80iOc3hBI9Ha5vLsh8fjEkjg2muV2DRP2EY8b1K1+hutNxcDL/LfmHlfCz9V7c/
        BGF9LPp/KcSsgkKwbjuqZdCWiGMKwlpjGBneRrewm4f+IJ0wyLXpWOEHWIRYpk+m
        L9I1nNwrARr3VDdZ7TvnM+9HL1M4GcTVpYvRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tQjeNH15d4Lk0PpPgBPztJi9zxkSKNjj
        swC5qY5MIWOuYIqrvE5UdLCIIf/n6oixDsn1KKMdN1ZsiLUnUrbNInNDSpXibpJO
        kNXXv+piLKCIp6O/kpE1wF9/dG8NgEGaZHSaj3qSlBOMO30vnSfKwEmee7NH7oSO
        R33yp2nO5S8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 596F7A80B2;
        Mon, 18 Sep 2017 19:52:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BC1C3A80B1;
        Mon, 18 Sep 2017 19:52:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Max Kirillov <max@max630.net>
Cc:     Jacob Keller <jacob.keller@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] describe: teach --match to handle branches and remotes
References: <20170917142416.30685-1-max@max630.net>
Date:   Tue, 19 Sep 2017 08:52:24 +0900
In-Reply-To: <20170917142416.30685-1-max@max630.net> (Max Kirillov's message
        of "Sun, 17 Sep 2017 17:24:16 +0300")
Message-ID: <xmqqzi9rsgxz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6C085C64-9CCC-11E7-AE17-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Max Kirillov <max@max630.net> writes:

>  --match <pattern>::
>  	Only consider tags matching the given `glob(7)` pattern,
> -	excluding the "refs/tags/" prefix.  This can be used to avoid
> -	leaking private tags from the repository. If given multiple times, a
> -	list of patterns will be accumulated, and tags matching any of the
> -	patterns will be considered. Use `--no-match` to clear and reset the
> -	list of patterns.
> +	excluding the "refs/tags/" prefix. If used with `--all`, it also
> +	considers local branches and remote-tracking references matching the
> +	pattern, excluding respectively "refs/heads/" and "refs/remotes/"
> +	prefix; references of other types are never considered. If given
> +	multiple times, a list of patterns will be accumulated, and tags
> +	matching any of the patterns will be considered.  Use `--no-match` to
> +	clear and reset the list of patterns.
>  
>  --exclude <pattern>::
>  	Do not consider tags matching the given `glob(7)` pattern, excluding
> -	the "refs/tags/" prefix. This can be used to narrow the tag space and
> -	find only tags matching some meaningful criteria. If given multiple
> -	times, a list of patterns will be accumulated and tags matching any
> -	of the patterns will be excluded. When combined with --match a tag will
> -	be considered when it matches at least one --match pattern and does not
> +	the "refs/tags/" prefix. If used with `--all`, it also does not consider
> +	local branches and remote-tracking references matching the pattern,
> +	excluding respectively "refs/heads/" and "refs/remotes/" prefix;
> +	references of other types are never considered. If given multiple times,
> +	a list of patterns will be accumulated and tags matching any of the
> +	patterns will be excluded. When combined with --match a tag will be
> +	considered when it matches at least one --match pattern and does not
>  	match any of the --exclude patterns. Use `--no-exclude` to clear and
>  	reset the list of patterns.

OK, I find this written clearly enough.

> diff --git a/builtin/describe.c b/builtin/describe.c
> index 94ff2fba0b..2a2e998063 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -124,6 +124,22 @@ static void add_to_known_names(const char *path,
>  	}
>  }
>  
> +/* Drops prefix. Returns NULL if the path is not expected with current settings. */
> +static const char *get_path_to_match(int is_tag, int all, const char *path)
> +{
> +	if (is_tag)
> +		return path + 10;

This is a faithful conversion of the existing code that wants to
behave the same as original, but a bit more on this later.

> +	else if (all) {
> +		if (starts_with(path, "refs/heads/"))
> +			return path + 11; /* "refs/heads/..." */
> +		else if (starts_with(path, "refs/remotes/"))
> +			return path + 13; /* "refs/remotes/..." */
> +		else
> +			return 0;

I think you can use skip_prefix() to avoid counting the length of
the prefix yourself, i.e.

	else if all {
		const char *body;

                if (skip_prefix(path, "refs/heads/", &body))
			return body;
		else if (skip_prefix(path, "refs/remotes/", &body))
			...
	}

Whether you do the above or not, the last one that returns 0 should
return NULL (to the language it is the same thing, but to humans, we
write NULL when it is the null pointer, not the number 0).

> +	} else
> +		return NULL;
> +}

Perhaps the whole thing may want to be a bit more simplified, like:

        static const *skip_ref_prefix(const char *path, int all)
        {
                const char *prefix[] = {
                        "refs/tags/", "refs/heads/", "refs/remotes/"
                };
                const char *body;
                int cnt;
                int bound = all ? ARRAY_SIZE(prefix) : 1;

                for (cnt = 0; cnt < bound; cnt++)
                        if (skip_prefix(path, prefix[cnt], &body);
                                return body;
                return NULL;
        }

The hardcoded +10 for "is_tag" case assumes that anything other than
"refs/tags/something" would ever be used to call into this function
when is_tag is true, and that may well be true in the current code
and have been so ever since the original code was written, but it
still smells like an invitation for future bugs.

I dunno.

> +
>  static int get_name(const char *path, const struct object_id *oid, int flag, void *cb_data)
>  {
>  	int is_tag = starts_with(path, "refs/tags/");
> @@ -140,12 +156,13 @@ static int get_name(const char *path, const struct object_id *oid, int flag, voi
>  	 */
>  	if (exclude_patterns.nr) {
>  		struct string_list_item *item;
> +		const char *path_to_match = get_path_to_match(is_tag, all, path);

> +test_expect_success 'set-up branches' '
> +	git branch branch_A A &&
> +	git branch branch_c c &&

Was there a reason why A and c are in different cases?  Are we
worried about case insensitive filesystems or something?

> +	git update-ref refs/remotes/origin/remote_branch_A "A^{commit}" &&
> +	git update-ref refs/remotes/origin/remote_branch_c "c^{commit}" &&
> +	git update-ref refs/original/original_branch_A test-annotated~2
> +'

Thanks.
