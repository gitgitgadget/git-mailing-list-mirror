Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B00C433DB
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 00:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF20C64E11
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 00:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhA3ACR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 19:02:17 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54367 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbhA3ACQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 19:02:16 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E06519B03D;
        Fri, 29 Jan 2021 19:01:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hpnkv+WSkrCb91neZDDuU+pXC9M=; b=qbfXVx
        JOGb2330YU8YZEiVMjOszp9HN3sdOs6Hoy2dIW9goAE+ov+kSXn9E3JEZTD9DS2Q
        o++9SFNR+z5hBaFW6oDZ8Kq0Ja+sfkoKoBaUEW/dvztOW9rnJi8o2N8E2RbTo/2P
        8U3IbYueCvK7IwhL/AXsSYvzZ5YlbQoikGg+A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cuLtZxn0FQhwYqCvfD/ZD9y2XEM0fQYR
        HvcoDgsMReWfIaO8DSqfkuuyepuW4qAvIQpZDN/Ir7U7vYeUUsr6otyhyFar75LR
        GuI0QYFObbe8AY0j1buAZJz+j3JFjfOUKN9QQh26ZcqiKNZ+teQJAUppfuz1C14J
        yX4cWuElwPw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D85A49B03B;
        Fri, 29 Jan 2021 19:01:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5D8849B03A;
        Fri, 29 Jan 2021 19:01:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH v2 2/3] pretty.c: capture invalid trailer argument
References: <pull.726.git.1599335291.gitgitgadget@gmail.com>
        <pull.726.v2.git.1611954543.gitgitgadget@gmail.com>
        <245e48eb6835cae4e61f65af780b766d990d4b5f.1611954543.git.gitgitgadget@gmail.com>
Date:   Fri, 29 Jan 2021 16:01:31 -0800
In-Reply-To: <245e48eb6835cae4e61f65af780b766d990d4b5f.1611954543.git.gitgitgadget@gmail.com>
        (Hariom Verma via GitGitGadget's message of "Fri, 29 Jan 2021 21:09:02
        +0000")
Message-ID: <xmqqsg6jqomc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4F860BDC-628E-11EB-A291-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +			size_t invalid_arg_len = strcspn(*arg, ",)");
> +			*invalid_arg = xstrndup(*arg, invalid_arg_len);
> +			return 1;

How about doing this only when invalid_arg is not NULL, i.e.

	} else if (!match_placeholder_bool_arg(....) &&
		   ...
        	   !match_placeholder_bool_arg(....)) {
		if (invalid_arg) {
			size_t len = strcspn(*arg, ",)");
			*invalid_arg = xstrndup(*arg, len);
		}
		return -1;
	}

Note that I just used 'len'; when the scope of a variable is so
short, it is clear the length of what thing it refers to from the
context, and there is no point in using a variable name that long.

In any case, by doing so, the callers that are not interested in the
report can just pass NULL, which means ...

> @@ -1464,12 +1472,13 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
>  		struct strbuf sepbuf = STRBUF_INIT;
>  		struct strbuf kvsepbuf = STRBUF_INIT;
>  		size_t ret = 0;
> +		char *unused = NULL;

... this will become unneeded, and ...

>  		opts.no_divider = 1;
>  
>  		if (*arg == ':') {
>  			arg++;
> -			if (format_set_trailers_options(&opts, &filter_list, &sepbuf, &kvsepbuf, &arg))
> +			if (format_set_trailers_options(&opts, &filter_list, &sepbuf, &kvsepbuf, &arg, &unused))
>  				goto trailer_out;

... this will pass NULL, and ...

>  		}
>  		if (*arg == ')') {
> @@ -1479,6 +1488,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
>  	trailer_out:
>  		string_list_clear(&filter_list, 0);
>  		strbuf_release(&sepbuf);
> +		free((char *)unused);

... this will become unneeded.

>  		return ret;
>  	}
>  
> diff --git a/pretty.h b/pretty.h
> index 7369cf7e148..d902cdd70a9 100644
> --- a/pretty.h
> +++ b/pretty.h
> @@ -151,6 +151,7 @@ int format_set_trailers_options(struct process_trailer_options *opts,
>  			struct string_list *filter_list,
>  			struct strbuf *sepbuf,
>  			struct strbuf *kvsepbuf,
> -			const char **arg);
> +			const char **arg,
> +			char **invalid_arg);
>  
>  #endif /* PRETTY_H */
