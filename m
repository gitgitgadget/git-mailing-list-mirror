Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47BAA2018B
	for <e@80x24.org>; Mon,  1 Aug 2016 21:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752398AbcHAVzS (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 17:55:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63014 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751467AbcHAVzR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 17:55:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A215A320B6;
	Mon,  1 Aug 2016 17:18:49 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uNikERynh9xvNPkBQV0Tgy0cEso=; b=j2MkDK
	OfFg/nxxyX8Ofy1WrxGLqC4GYvdsSpQfTN7uDztuyswdWOKgy3/lmhrGNvr7yCUr
	ebF0omgAcCWGKGafRX/H2wyFTSQkawlbCS0hkUQNp3IKZrpQ3ezIjVHjFyn0Lr6e
	6W8qhA6HchhD8vnilXe/PYC1tYla8Xzb9qxEw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=brXLFmh9bJ7LxdEQzpWlzNGkmkYmQ9kN
	4MfZsKSlLkYfQdsdDkMBah+qFKKj2POTT38NWBiIigFTUPVdMd01AtLZ+9vdIfQA
	Q+tcN8bXGEKD6lA9de25Stx7hrU5kTknsKfhSmwGupdKHLI7wcksFnRxPwp4Xbpq
	yb1i2AL3oWY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B600320B5;
	Mon,  1 Aug 2016 17:18:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 246E5320B4;
	Mon,  1 Aug 2016 17:18:49 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Josh Triplett <josh@joshtriplett.org>
Cc:	Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] format-patch: Add a config option format.from to set the default for --from
References: <cover.4d006cadf197f80d899ad7d7d56d8ba41f574adf.1469905775.git-series.josh@joshtriplett.org>
	<20160730191111.cd6ay3l4hweyjf7f@x>
Date:	Mon, 01 Aug 2016 14:18:47 -0700
In-Reply-To: <20160730191111.cd6ay3l4hweyjf7f@x> (Josh Triplett's message of
	"Sat, 30 Jul 2016 12:11:11 -0700")
Message-ID: <xmqqziowgpc8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 89E4DA26-582D-11E6-90AB-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Josh Triplett <josh@joshtriplett.org> writes:

> Subject: Re: [PATCH v2 1/2] format-patch: Add a config option format.from ...

At least s/Add/add/; but I would prefer an even shorter

	format-patch: format.from gives the default for --from

> +static char *from;

The same "this does not quite help the transition" comment applies
to this one.

> +enum from {
> +	FROM_AUTHOR,
> +	FROM_USER,
> +	FROM_VALUE,

Drop trailing comma after the last enum definition (trailing comma
after the last element in an array is OK, though).

> +static void set_from(enum from type, const char *value)
> +{
> +	free(from);
> +	switch (type) {
> +	case FROM_AUTHOR:
> +		from = NULL;
> +		break;
> +	case FROM_USER:
> +		from = xstrdup(git_committer_info(IDENT_NO_DATE));
> +		break;
> +	case FROM_VALUE:
> +		from = xstrdup(value);
> +		break;
> +	}
> +}

I tend to agree with what Jeff said; I'd queue 1/2 from the original
round for now.

Thanks.
