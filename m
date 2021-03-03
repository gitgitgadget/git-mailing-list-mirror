Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D6BC433E9
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACFE164EBA
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448819AbhCCGgL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 01:36:11 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60551 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352478AbhCCDuK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Mar 2021 22:50:10 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C8DDCB813C;
        Tue,  2 Mar 2021 22:44:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=rpHd5ZmDYhYNE193hjwI/R8pP+A=; b=yEhDWE2O5CNYKWyNgMHL
        Yeawuld8KBTQLVb7tK+DyQs4XfRh5+6Q3xhvcEHBn8n5aRodz5qc4MWUuStDkgdi
        mz7AwPMAIUZ2TWTu74zaef/Nci5Uq1pmcYsPAzHrWXJZaWEWpjuoSYIdDSbabqOB
        Ztiis2gfZpZ4+H5PtLNqPQg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=pfPEyEedZdXxHuy/GfgWb9/6AYyvcfyk2syI634GFHmm9h
        jSGw0zc6DO8+hfvNigzXo9AydUMnWFOmcJtp8o1l0HCXRM3PAlJQ79xioEgbXi+D
        TqH9A5q9vLSf0I96z/2YLEjpN951tHycCfOg/RjoCvcqRyFNodIsqo7AK9aEk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C0620B813B;
        Tue,  2 Mar 2021 22:44:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3F243B813A;
        Tue,  2 Mar 2021 22:44:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v2] format-patch: allow a non-integral version numbers
References: <pull.885.git.1614269753194.gitgitgadget@gmail.com>
        <pull.885.v2.git.1614588030233.gitgitgadget@gmail.com>
Date:   Tue, 02 Mar 2021 19:44:42 -0800
Message-ID: <xmqqzgzklx3p.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CA535CC2-7BD2-11EB-98AC-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/builtin/log.c b/builtin/log.c
> index f67b67d80ed1..95c95eab5393 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1662,13 +1662,15 @@ static void print_bases(struct base_tree_info *bases, FILE *file)
>  	oidclr(&bases->base_commit);
>  }
>  
> -static const char *diff_title(struct strbuf *sb, int reroll_count,
> -		       const char *generic, const char *rerolled)
> +static const char *diff_title(struct strbuf *sb, const char *reroll_count, int reroll_count_is_integer,
> +			const char*previous_count, const char *generic, const char *rerolled)

Avoid overly long lines here, but quite honestly, I find that this
interface is way too ugly to live.

Can we do all the computation around previous count in the caller,
so that this function only takes reroll_count and previous_count
that are both "const char *", and then the body will just be:

	if (!reroll_count)
		strbuf_addstr(sb, generic);
	else if (previous_count)
		strbuf_addf(sb, rerolled, previous_count);
	return sb->buf;

That way, the callers do not have to prepare two different rerolled
template and switch between them based on "is_integer".

In other words, they need to care "is_integer" already, so making
them responsible for preparing "previous_count" always usable by
this function would be a reasonable way to partition the tasks
between this callee and the caller.

That way, this function do not even need to know about "is_integer"
bit.

> +	if (previous_count && !reroll_count)
> +		usage(_("previous-count can only used when reroll-count is used"));
> +	if (reroll_count) {
>  		struct strbuf sprefix = STRBUF_INIT;
> -		strbuf_addf(&sprefix, "%s v%d",
> +		char ch;
> +		size_t i = 0 , reroll_count_len = strlen(reroll_count);
> +
> +		for (; i != reroll_count_len; i++) {
> +			ch = reroll_count[i];
> +			if(!isdigit(ch))
> +				break;
> +		}
> +		reroll_count_is_integer = i == reroll_count_len ? 1 : 0;

Do not reinvent integer parsing.  In our codebase, it is far more
common (and it is less error prone) to do something like this:

	char *endp;

	count = strtoul(reroll_count_string, &endp, 10);
	if (*endp) {
		/* followed by non-digit: not an integer */
		is_integer = 0;
	} else {
        	is_integer = 1;
                if (0 < count)
			previous_count_string = xstrfmt("%d", count - 1);
	}

And then, you can move the "if previous is there and count is not
specified" check after this block, to make sure that a non-integer
reroll count is always accompanied by a previous count, for example.

> +		strbuf_addf(&sprefix, "%s v%s",
>  			    rev.subject_prefix, reroll_count);
>  		rev.reroll_count = reroll_count;
>  		rev.subject_prefix = strbuf_detach(&sprefix, NULL);
> @@ -2079,8 +2095,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  		rev.idiff_oid1 = &idiff_prev.oid[idiff_prev.nr - 1];
>  		rev.idiff_oid2 = get_commit_tree_oid(list[0]);
>  		rev.idiff_title = diff_title(&idiff_title, reroll_count,
> -					     _("Interdiff:"),
> -					     _("Interdiff against v%d:"));
> +			reroll_count_is_integer, previous_count, _("Interdiff:"),
> +				reroll_count_is_integer ? _("Interdiff against v%d:") :
> +					_("Interdiff against v%s:"));

I've touched the calling convention into diff_title() function
earlier.

> @@ -2098,8 +2115,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  		rev.rdiff2 = rdiff2.buf;
>  		rev.creation_factor = creation_factor;
>  		rev.rdiff_title = diff_title(&rdiff_title, reroll_count,
> -					     _("Range-diff:"),
> -					     _("Range-diff against v%d:"));
> +			reroll_count_is_integer, previous_count, _("Range-diff:"),
> +				reroll_count_is_integer ? _("Range-diff against v%d:") :
> +					_("Range-diff against v%s:"));

Ditto.

