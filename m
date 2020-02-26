Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758A3C4BA24
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 19:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 423C3222C4
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 19:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Cfmaudxm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgBZTGs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 14:06:48 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64164 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgBZTGs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 14:06:48 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 76630B8849;
        Wed, 26 Feb 2020 14:06:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3bGZKjfu2csWdSAfoaVQR7zNPys=; b=Cfmaud
        xmHLF+2ogHMK45OtepejnJfrRtPJizFaHU10Ck5S6LEMtbQTxZA7Kig1pAg4RGDP
        3BATbf04pBQgvzlGPzJ965JIzkw2Xc6bYEYurukDSuIZMQ3S0plyplSKR1ZloQDs
        HnmdqLtOSBEIBCHOwLNeHTsvo/isTgSitdt3U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=k9j6+taSk3CsgaSiFWfRZumNQGXTxhaa
        kNESKL1pHx9oqGNUR5xnsmBKY684nl0rjA8lXRmgvcFaLS+QnqFXsehfmuQRN/iX
        JRCy3rhtAvHvK2YM5eVP5OT7AY1fo2o1N7wXKEOThXf8ieRJ5BSVDtqRnvPR7RAJ
        MxCQK5iuds8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6E53BB8848;
        Wed, 26 Feb 2020 14:06:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9B269B8844;
        Wed, 26 Feb 2020 14:06:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 01/10] bisect--helper: introduce new `write_in_file()` function
References: <20200226101429.81327-1-mirucam@gmail.com>
        <20200226101429.81327-2-mirucam@gmail.com>
Date:   Wed, 26 Feb 2020 11:06:39 -0800
In-Reply-To: <20200226101429.81327-2-mirucam@gmail.com> (Miriam Rubio's
        message of "Wed, 26 Feb 2020 11:14:20 +0100")
Message-ID: <xmqq4kvdjhhc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1F6447F2-58CB-11EA-AEEB-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miriam Rubio <mirucam@gmail.com> writes:

> Let's refactor code adding a new `write_in_file()` function
> that opens a file for writing a message and closes it.
>
> This removes some duplicated code and makes the code simpler,
> clearer and easier to understand.

I find it a bit too much self promotion ;-)  With what we see only in
this step, the code is not so much simpler nor easier to understand.
Perhaps when we see more callers in the remainder of the series, we
may start to appreciate it, but if that is the case, we should
clarify it here, e.g.

    This helper will be used in later steps and makes the code
    simpler, ...

> +static int write_in_file(const char *filepath, const char *content, int append)
> +{
> +	FILE *fp = NULL;
> +	const char *mode = append ? "a" : "w";
> +
> +	fp = fopen(filepath, mode);
> +	if (!fp)
> +		return error_errno(_("could not open the file '%s'"), filepath);
> +	if (!fprintf(fp, "%s\n", content))
> +		return error_errno(_("could not write in file '%s'"), filepath);

Use and non-use of definite article being inconstent between "open
the file X" vs "write in file X" bothers me as a reader here.

Wouldn't it be more common to say "write TO" here, not "write IN"?

> +	return fclose(fp);

We didn't use to say error_errno(_("could not close ...")) in the
original, so we stay silent and return an error (EOF, which is a
negative integer) from here.

> +}
> +
>  static int check_term_format(const char *term, const char *orig_term)
>  {
>  	int res;
> @@ -104,7 +117,7 @@ static int check_term_format(const char *term, const char *orig_term)
>  
>  static int write_terms(const char *bad, const char *good)
>  {
> -	FILE *fp = NULL;
> +	char *content = xstrfmt("%s\n%s", bad, good);
>  	int res;
>  
>  	if (!strcmp(bad, good))
> @@ -113,12 +126,9 @@ static int write_terms(const char *bad, const char *good)
>  	if (check_term_format(bad, "bad") || check_term_format(good, "good"))
>  		return -1;
>  
> -	fp = fopen(git_path_bisect_terms(), "w");
> -	if (!fp)
> -		return error_errno(_("could not open the file BISECT_TERMS"));
> +	res = write_in_file(git_path_bisect_terms(), content, 0);
> +	free(content);
>  
> -	res = fprintf(fp, "%s\n%s\n", bad, good);

With just this one callsite, I do not think it is a good idea to
lose the "write a formatted output without an extra allcoation" 
by introducing this wrapper.  The equation may become different if
we see more (a lot more) callsites that already have strings ready
to be written that can use this helper, though.

> -	res |= fclose(fp);
>  	return (res < 0) ? -1 : 0;

The return value is a bit strange here, but it is inherited from the
original, so I'll let it pass.

>  }
