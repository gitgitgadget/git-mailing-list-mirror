Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B48E1F404
	for <e@80x24.org>; Fri, 26 Jan 2018 22:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752004AbeAZWSy (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 17:18:54 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54697 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751615AbeAZWSy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 17:18:54 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 21CC0CFA77;
        Fri, 26 Jan 2018 17:18:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NHv8FkuHmPa4CBfU1r+kWpQ0iJM=; b=gJY2qr
        pnCVkJgXKFZhoN8t0pxS3p9KrH0pKoGMK89h6D0Y4T+l6sNVTGfK97054dSzr6LM
        rR5Xxo1Gyswzrp6dRCWLNT95OCPGXg/mX0MVdMs0DgX8+lbOd1v9cP0LfOOp4W0L
        4oC39kDE/+7vLZuFiwrsphBjNEZJGjknS3fDY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jpV4YmD6vFPESGWrl9N4qyY1Lz2b9v1i
        inHrOxXr8cxOLyM0lyDFV7uMxZWIqhYsxky0QoGUSv0pLenm4Ulf/OWdWA/o4mgV
        2tcd+zQkItQx9Q4BwPFnC6vbnjkslX9F+RJJYzStOB8SbAwQ2kTm55seoqZQRBYb
        5t9sMeXrQic=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 19F1CCFA76;
        Fri, 26 Jan 2018 17:18:53 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 79CE7CFA75;
        Fri, 26 Jan 2018 17:18:52 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH RFC 04/24] cat-file: reuse struct ref_format
References: <0102016133ff3a86-44d354ec-13c6-4c38-bc75-1ba4422db5a7-000000@eu-west-1.amazonses.com>
        <0102016133ff3af0-0ebed14d-deb5-4744-9267-4c5b0c6a30c8-000000@eu-west-1.amazonses.com>
Date:   Fri, 26 Jan 2018 14:18:51 -0800
In-Reply-To: <0102016133ff3af0-0ebed14d-deb5-4744-9267-4c5b0c6a30c8-000000@eu-west-1.amazonses.com>
        (Olga Telezhnaya's message of "Fri, 26 Jan 2018 19:43:40 +0000")
Message-ID: <xmqq4ln8qn5g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E3F734C2-02E6-11E8-A280-D3940C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Olga Telezhnaya <olyatelezhnaya@gmail.com> writes:

> Start using ref_format struct instead of simple char*.
> Need that for further reusing of formatting logic from ref-filter.
>
> Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored by: Jeff King <peff@peff.net>
> ---
>  builtin/cat-file.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)

OK, so at this stage we only use its .format field (which happens to
be the same simple "char *"), but we can later extend the functions
on the callchain this thing is passed through.

Makes sense.

Thanks.


>
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index f783b39b9bd5c..65c300184cab8 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -13,15 +13,16 @@
>  #include "tree-walk.h"
>  #include "sha1-array.h"
>  #include "packfile.h"
> +#include "ref-filter.h"
>  
>  struct batch_options {
> +	struct ref_format format;
>  	int enabled;
>  	int follow_symlinks;
>  	int print_contents;
>  	int buffer_output;
>  	int all_objects;
>  	int cmdmode; /* may be 'w' or 'c' for --filters or --textconv */
> -	const char *format;
>  };
>  
>  static const char *force_path;
> @@ -353,7 +354,7 @@ static void batch_object_write(const char *obj_name, struct batch_options *opt,
>  		return;
>  	}
>  
> -	strbuf_expand(&buf, opt->format, expand_format, data);
> +	strbuf_expand(&buf, opt->format.format, expand_format, data);
>  	strbuf_addch(&buf, '\n');
>  	batch_write(opt, buf.buf, buf.len);
>  	strbuf_release(&buf);
> @@ -446,8 +447,8 @@ static int batch_objects(struct batch_options *opt)
>  	int save_warning;
>  	int retval = 0;
>  
> -	if (!opt->format)
> -		opt->format = "%(objectname) %(objecttype) %(objectsize)";
> +	if (!opt->format.format)
> +		opt->format.format = "%(objectname) %(objecttype) %(objectsize)";
>  
>  	/*
>  	 * Expand once with our special mark_query flag, which will prime the
> @@ -456,7 +457,7 @@ static int batch_objects(struct batch_options *opt)
>  	 */
>  	memset(&data, 0, sizeof(data));
>  	data.mark_query = 1;
> -	strbuf_expand(&buf, opt->format, expand_format, &data);
> +	strbuf_expand(&buf, opt->format.format, expand_format, &data);
>  	data.mark_query = 0;
>  	if (opt->cmdmode)
>  		data.split_on_whitespace = 1;
> @@ -548,7 +549,7 @@ static int batch_option_callback(const struct option *opt,
>  
>  	bo->enabled = 1;
>  	bo->print_contents = !strcmp(opt->long_name, "batch");
> -	bo->format = arg;
> +	bo->format.format = arg;
>  
>  	return 0;
>  }
> @@ -557,7 +558,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>  {
>  	int opt = 0;
>  	const char *exp_type = NULL, *obj_name = NULL;
> -	struct batch_options batch = {0};
> +	struct batch_options batch = { REF_FORMAT_INIT };
>  	int unknown_type = 0;
>  
>  	const struct option options[] = {
>
> --
> https://github.com/git/git/pull/452
