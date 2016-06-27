Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83FE12018B
	for <e@80x24.org>; Mon, 27 Jun 2016 15:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751852AbcF0PAT (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 11:00:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62143 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751844AbcF0PAS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 11:00:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B84D827918;
	Mon, 27 Jun 2016 11:00:11 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XFf74VncDublMcTlOIt8rIDFfjA=; b=FOkkTC
	RJ7E6u1htKJGkGC/Ye7bVTWNhK2Qmth+UhRPRpWV7NK04kc4IU9a/jm+Z95XFB43
	1xY/gZYwhb5RuwvaX4WTiuVSH0YPsTlklHUB2O80EMAzgohhN8llTSF0IxnvhSBf
	dhpgoLh3slKo7RK47LJY8+kIrNscUCZvCHChs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=glIoPHb6KgR2/V7vWtoQsT0MVCjM6ryX
	CI34OrJ9p3i+QMM8FJV4a455UDbzePtiYDbahQVEwAx4RROSl90/MW1oPAYAlhPe
	S8wrDLUA/18egCcwq8+FTKNwb7W/u7HzvRwZYEYxsHzmwuTL1FimFWdNSi++2iFc
	B+/MsckQJAY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AF25027917;
	Mon, 27 Jun 2016 11:00:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C5BFC2790B;
	Mon, 27 Jun 2016 11:00:10 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:	git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 00/12] nd/icase updates
References: <20160623162907.23295-1-pclouds@gmail.com>
	<20160625052238.13615-1-pclouds@gmail.com>
	<xmqqeg7id6ns.fsf@gitster.mtv.corp.google.com>
Date:	Mon, 27 Jun 2016 08:00:06 -0700
In-Reply-To: <xmqqeg7id6ns.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 27 Jun 2016 07:53:59 -0700")
Message-ID: <xmqqa8i6d6dl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D83FA5E2-3C77-11E6-92E7-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>  	if (p->fixed) {
>  		p->kws = kwsalloc(icase ? tolower_trans_tbl : NULL);
>  		kwsincr(p->kws, p->pattern, p->patternlen);
>  		kwsprep(p->kws);
>  		return;
>  	} else if (opt->fixed) {
> +		/*
> +		 * We only come here when the pattern has the regexp
> +		 * special characters in it, which need to be matched
> +		 * literally, while ignoring case.
> +		 */

This comment is wrong.

		/*
		 * We come here only when the pattern has non-ascii
		 * characters we cannot case-fold, and we were asked
		 * to ignore-case.
		 */

>  		compile_fixed_regexp(p, opt);
>  		return;
>  	}
