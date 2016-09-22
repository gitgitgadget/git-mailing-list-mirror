Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F1681F4F8
	for <e@80x24.org>; Thu, 22 Sep 2016 20:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965407AbcIVUvX (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 16:51:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58313 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933263AbcIVUu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 16:50:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 345CF3F40E;
        Thu, 22 Sep 2016 16:50:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cUU0Vvi85tYlI7f39UjkSeSqut4=; b=Oztiiw
        SfCSbmsQBeQhA/Mv/jvuQuRBsYLwn6t1uB3OGcdvmGmYv2EI6YzxlZRk3DQ0F8LO
        t1wQCtaewPJR79XvxT96ljbLjTz7DpHPBsJe/nKk/ZIA+V+JjNLuKfcg8hH+JsiX
        9G+oGcFVKsfydg1I4F+fl7lDgo2mxvs6dcEcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=npauhPnb2jaQBKvMU9pknnEdnvbJ5CWD
        Fv0CpzWjom0C6ICzquaqbtjl5u7Oi5SYq/I+Qn/CaPpkbd7/EGuhn+EE0iTDUT4F
        jBCx/CKyAAWF8BiSaVdiW7RVtMvrXcwlejthqh6uMFgRUYoIMuBDUvrDIKzYrTOd
        mxb7w8vCzi4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C63D3F40D;
        Thu, 22 Sep 2016 16:50:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AB6073F40B;
        Thu, 22 Sep 2016 16:50:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     santiago@nyu.edu
Cc:     git@vger.kernel.org, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Lukas P <luk.puehringer@gmail.com>,
        Lukas Puehringer <lukas.puehringer@nyu.edu>
Subject: Re: [PATCH 3/6] ref-filter: Expose wrappers for ref_item functions
References: <20160922185317.349-1-santiago@nyu.edu>
        <20160922185317.349-4-santiago@nyu.edu>
Date:   Thu, 22 Sep 2016 13:50:54 -0700
In-Reply-To: <20160922185317.349-4-santiago@nyu.edu> (santiago@nyu.edu's
        message of "Thu, 22 Sep 2016 14:53:14 -0400")
Message-ID: <xmqqvaxn3bgx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 428E1136-8106-11E6-A8FC-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

santiago@nyu.edu writes:

> From: Lukas P <luk.puehringer@gmail.com>
>
> Ref-filter functions are useful for printing git object information
> without a format specifier. However, some functions may not want to use
> a complete ref-array, and just a single item instead. Expose
> create/show/free functions for ref_array_items through wrappers around
> the original functions.
>
> Signed-off-by: Lukas Puehringer <lukas.puehringer@nyu.edu>
> ---
>  ref-filter.c | 20 ++++++++++++++++++++
>  ref-filter.h | 10 ++++++++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 9adbb8a..b013799 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1329,6 +1329,14 @@ static struct ref_array_item *new_ref_array_item(const char *refname,
>  	return ref;
>  }
>  
> +/* Wrapper: Create ref_array_item w/o referencing container in function name */
> +struct ref_array_item *new_ref_item(const char *refname,
> +						 const unsigned char *objectname,
> +						 int flag)
> +{
> +	return new_ref_array_item(refname, objectname, flag);
> +}

Why?  As a public function name, new_ref_item() is a horrible one,
as there are other structures about "ref" elsewhere in the system.
If a new caller needs to be able to get a new ref_array_item, you
are better off just exposing it, not an ill-named wrapper.

>  static int filter_ref_kind(struct ref_filter *filter, const char *refname)
>  {
>  	unsigned int i;
> @@ -1426,6 +1434,12 @@ static void free_array_item(struct ref_array_item *item)
>  	free(item);
>  }
>  
> +/* Wrapper: Free ref_array_item w/o referencing container in function name */
> +void free_ref_item(struct ref_array_item *ref_item)
> +{
> +	free_array_item(ref_item);
> +}

Again, why?  free_array_item() is a horrible name for a public
function, and it is OK to rename it to free_ref_array_item() while
giving external callers an access to it, so that their names are
descriptive enough to convey that they are about ref_array_item
structure used in ref-filter API while at the same time making it
clear to readers that the two functions with related names are
indeed related.

> @@ -1637,6 +1651,12 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
>  	putchar('\n');
>  }
>  
> +/* Wrapper: Show ref_array_item w/o referencing container in function name */
> +void show_ref_item(struct ref_array_item *ref_item, const char *format, int quote_style)
> +{
> +	show_ref_array_item(ref_item, format, quote_style);
> +}

Ditto.
