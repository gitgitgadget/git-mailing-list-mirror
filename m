Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62768C4332D
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 20:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F9FB2072C
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 20:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OrhK0HJ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgCTU0t (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 16:26:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55721 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbgCTU0s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 16:26:48 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 242235C174;
        Fri, 20 Mar 2020 16:26:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sqnKSRQMn+XsnA8sZh6sWY1nQXg=; b=OrhK0H
        J1ra0GOxyffktHrVbfjLKwOhbJe1FVSkZL3lULjQO7xYUKplThSE1KRljPH6CXW3
        wmtjdwWwK6Q6BEsBpUEIBOkom41yN9dCZ9fAHvNgEv6tDOe0wCZP+iF9wPxkqaXl
        kUCZM4rrgy3YlxH68eTkJbnyVETxMqCHs5m1s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=F5WnISI3NBQCGUPRJ2uwN1n5F+i0wil/
        iqUcJkQa0AoU11MVtNUhl5vvPog+25HXUCBKUnV7ywmQqDokPt4z+7nYuFWTmIqg
        JU0U8NNxx2RXIolLcsvsTZaDlnRqRrC1lpZFE9R3zTKwWr2rBEGs8Wdp4qhvhEzw
        aiRjlsWAZmo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1B5FB5C173;
        Fri, 20 Mar 2020 16:26:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 880D55C170;
        Fri, 20 Mar 2020 16:26:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, jonathantanmy@google.com,
        christian.couder@gmail.com, git@jeffhostetler.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/2] partial-clone: set default filter with --partial
References: <pull.586.git.1584638887.gitgitgadget@gmail.com>
        <6f340d9aadf71d394ad320ad162f1d140b632f2c.1584638887.git.gitgitgadget@gmail.com>
Date:   Fri, 20 Mar 2020 13:26:42 -0700
In-Reply-To: <6f340d9aadf71d394ad320ad162f1d140b632f2c.1584638887.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 19 Mar 2020
        17:28:06 +0000")
Message-ID: <xmqqr1xmbwn1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1D106910-6AE9-11EA-9C60-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
> index 256bcfbdfe6..a71716ef75e 100644
> --- a/list-objects-filter-options.c
> +++ b/list-objects-filter-options.c
> @@ -270,6 +270,24 @@ int opt_parse_list_objects_filter(const struct option *opt,
>  	return 0;
>  }
>  
> +int opt_set_blob_none_filter(const struct option *opt,
> +			     const char *arg, int unset)

Isn't the convention to use "opt_parse_" for canned parse-options
callbacks?

> +{
> +	struct strbuf filter_arg = STRBUF_INIT;
> +	struct list_objects_filter_options *filter_options = opt->value;
> +	
> +	if (unset || !arg || !strcmp(arg, "0")) {
> +		parse_list_objects_filter(filter_options, "blob:none");
> +		return 0;

If "--no-partial" were allowed, it should be usable to countermand
"--partial" earlier on the command line or perhaps configured
default.  But the above (especially the "unset ||" part) makes
"--no-partial" a synonym to "--filter=blob:none", no?

> +	}
> +	
> +	strbuf_addf(&filter_arg, "blob:limit=%s", arg);
> +	parse_list_objects_filter(filter_options, filter_arg.buf);
> +	strbuf_release(&filter_arg);

I would have expected the body of the function to read more like
this:

	if (unset) {
        	... clear filter_options stored in opt->value ...
	} else {
		struct strbuf filter_arg = STRBUF_INIT;
		if (!arg)
			strbuf_addstr(&filter_arg, "blob:none");
		else
			strbuf_addf(&filter_arg, "blob:limit=%s", arg);
		parse_list_objects_filter(filter_options, filter_arg.buf);
		strbuf_release(&filter_arg);
	}

Specifically, I find it unsatisifying to see the "0" optimization at
this level.  Shouldn't it be done in parse_list_objects_filter() to
parse "blob:limit=<num>" and after realizing <num> is zero, pretend
as if it got "blob:none" to optimize?  That way, people can even say
"--partial=0k" and get it interpreted as "--filter=blob:none", right?

>  #define OPT_PARSE_LIST_OBJECTS_FILTER(fo) \
>  	{ OPTION_CALLBACK, 0, CL_ARG__FILTER, fo, N_("args"), \
>  	  N_("object filtering"), 0, \
> -	  opt_parse_list_objects_filter }
> +	  opt_parse_list_objects_filter }, \
> +	{ OPTION_CALLBACK, 0, CL_ARG__PARTIAL, fo, N_("size"), \
> +	  N_("partial clone with blob filter"), \
> +	  PARSE_OPT_OPTARG | PARSE_OPT_NONEG , opt_set_blob_none_filter }

PARSE_OPT_NONEG means "--no-partial" is forbidden and the callback
won't see unset==1 at all, right?

Thanks.
