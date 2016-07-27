Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA32D1F621
	for <e@80x24.org>; Wed, 27 Jul 2016 20:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757334AbcG0UAK (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 16:00:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53366 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754303AbcG0UAI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 16:00:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D67D3303E5;
	Wed, 27 Jul 2016 16:00:06 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=prI+b/T1ybaeu5GC2c9t3dE/H2s=; b=W7tYOE
	oHTMw8dMhC2LSCN2Vgxo6tddtm42x/KNb48MyxD9Yup8h0agSDE1bNW123OiyXxI
	BsbMRgSou1v4dy7uSo/9zm9Q+Hy0kSNmrt0CGSCrlVPlBUNVnYlWdSv62WYAT2mb
	hsTwa2d6WtdvPXExZopeFoiAsrbuD+9JU2pBs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=maJPuURiDG9WTMF1vy+TXP0/j2AUImaU
	jeEAjhZfd6lLqNHawvSBfwcLINv+WC4S2xg/rhMxCC47zcD8J7+MRfV/Hgmoy0W0
	if3hDM/SuQHIcTyQrqwkEt+Uxn/yfpuaRsiQwaCqCfWMjr2PhhiK0RRb2Vs9vpNC
	/kKZKfnIUkQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CF64B303E4;
	Wed, 27 Jul 2016 16:00:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B0CBB303DF;
	Wed, 27 Jul 2016 16:00:05 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Vasco Almeida <vascomalmeida@sapo.pt>
Cc:	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] i18n: config: unfold error messages marked for translation
References: <1469642375-27305-1-git-send-email-vascomalmeida@sapo.pt>
Date:	Wed, 27 Jul 2016 13:00:02 -0700
In-Reply-To: <1469642375-27305-1-git-send-email-vascomalmeida@sapo.pt> (Vasco
	Almeida's message of "Wed, 27 Jul 2016 17:59:35 +0000")
Message-ID: <xmqqy44mvol9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B67C084A-5434-11E6-8897-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> +
> +	switch (cf->origin_type) {
> +	case CONFIG_ORIGIN_BLOB:
> +		error_msg = xstrfmt(_("bad config line %d in blob %s"),
> +				      cf->linenr, cf->name);
> +		break;
> +	case CONFIG_ORIGIN_FILE:
> +		error_msg = xstrfmt(_("bad config line %d in file %s"),
> +				      cf->linenr, cf->name);
> +		break;

Hmm, if we were to switch the message based on the origin type, then
things like this:

> +	case CONFIG_ORIGIN_STDIN:
> +		error_msg = xstrfmt(_("bad config line %d in standard input %s"),
> +				      cf->linenr, cf->name);
> +		break;

and this:

> +	case CONFIG_ORIGIN_STDIN:
> +		die(errno == ERANGE
> +		    ? _("bad numeric config value '%s' for '%s' in standard input %s: out of range")
> +		    : _("bad numeric config value '%s' for '%s' in standard input %s: invalid unit"),
> +		    value, name, cf->name);

that does not have any useful cf->name can be improved even more, no?

The only reason why we pass an empty string here:

>  static int git_config_from_stdin(config_fn_t fn, void *data)
>  {
> -	return do_config_from_file(fn, "standard input", "", NULL, stdin, data);
> +	return do_config_from_file(fn, CONFIG_ORIGIN_STDIN, "", NULL, stdin, data);
>  }

is because do_config_from_file() function whose primary purpose is
to read from file was reused, the interface to that function
requires the filename there for reporting, and we do not have
anything useful when reading from the standard input.
