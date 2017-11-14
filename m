Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 896BA201C8
	for <e@80x24.org>; Tue, 14 Nov 2017 06:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751734AbdKNGis (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 01:38:48 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57270 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751030AbdKNGiq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 01:38:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0F8FCAE7D1;
        Tue, 14 Nov 2017 01:38:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BMe+bnPWHsJg60Riwk47qDIOurI=; b=U60l+t
        GpF7UYoMP3mSZUo1eBsauqooNM3DIpV2IQhVk8DRYvbJhivJKKAFBfNcV7IqH7IR
        PD9hPG0CE0qHAOhMxMckZEIwIJ9UlGpC7suwQwKd7eFR2sSAdmhmod51YIUSeHU2
        8G2VtyYJbIH42Llocv1zhCUmd807KyvDtzXNI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XYlfFCca/mReTbwbrvUKIo/Lld28lYbn
        voFdorbKYUSpSGkkaH+RQs2aljXw8ABQcrfVOGQE88wr0//daJcE4SgbWGEtvu1C
        0NYfsZKCojwJ5AqhDqUdmkbqU9sNYc6nJbHfj/eCj0TLTKjSJwFlWLsuyZIyhe4Y
        8gh0Sx7cUDY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 05967AE7D0;
        Tue, 14 Nov 2017 01:38:46 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6FF29AE7CF;
        Tue, 14 Nov 2017 01:38:45 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     hsed@unimetic.com
Cc:     peff@peff.net, git@vger.kernel.org
Subject: Re: [PATCH V2] config: add --expiry-date
References: <20171112145535.gb4nafdhhdslknex@sigill.intra.peff.net>
        <1510625073-8842-1-git-send-email-hsed@unimetic.com>
Date:   Tue, 14 Nov 2017 15:38:44 +0900
In-Reply-To: <1510625073-8842-1-git-send-email-hsed@unimetic.com>
        (hsed@unimetic.com's message of "Tue, 14 Nov 2017 02:04:33 +0000")
Message-ID: <xmqqshdh2wln.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 769792A6-C906-11E7-9849-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hsed@unimetic.com writes:

> From: Haaris <hsed@unimetic.com>
>
> Description:
> This patch adds a new option to the config command.
>
> Uses flag --expiry-date as a data-type to covert date-strings to
> timestamps when reading from config files (GET).
> This flag is ignored on write (SET) because the date-string is stored in
> config without performing any normalization.
>
> Creates a few test cases and documentation since its a new feature.
>
> Motivation:
> A parse_expiry_date() function already existed for api calls,
> this patch simply allows the function to be used from the command line.
>
> Signed-off-by: Haaris <hsed@unimetic.com>
> ---

Please drop all these section headers; they are irritating.  Learn
from "git log --no-merges" how the log messages in this project is
written and imitate them.  Documentation/SubmittingPatches would be
helpful.

	Add --expiry-date as a new type 'git config --get' takes,
	similar to existing --int, --bool, etc. types, so that
	scripts can learn values of configuration variables like
	gc.reflogexpire (e.g. "2.weeks") in a more useful way
	(e.g. the timesamp as of two weeks ago, expressed in number
	of seconds since epoch).

	As a helper function necessary to do this already exists in
	the implementation of builtin/reflog.c, the implementation
	is just the matter of moving it to config.c and using it
	from bultin/config.c, but shuffle the order of the parameter
	so that the pointer to the output variable comes first.
	This is to match the convention used by git_config_pathname()
	and other helper functions.

or something like that?

> +		} else if (types == TYPE_EXPIRY_DATE) {
> +			timestamp_t t;
> +			if(git_config_expiry_date(&t, key_, value_) < 0)

Style.

	if (git_config_expiry_date(&t, key_, value_) < 0)

> +				return -1;
> +			strbuf_addf(buf, "%"PRItime, t);
> ...

Thanks.
