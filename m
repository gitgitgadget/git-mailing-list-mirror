Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A017C6379F
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 22:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07AFE2224D
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 22:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NzusK3cY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgKSWpP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 17:45:15 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55618 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbgKSWpP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 17:45:15 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3FD5B99C8E;
        Thu, 19 Nov 2020 17:45:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xp57n2ZzLwSlb52LNeIdbWCSUp0=; b=NzusK3
        cYucOswD3Z0oe6GTH80LnaUxmky4/jTIOUZKcF09VU1bLqdMvebsD/wBq4Sfhkle
        M8/udpHg6Hoj9AKOqKdUAN56ib7Gd6YxAoEqqsRk2geqq7+crBP/9XDnDnlROgPC
        DVcIDG/lSMzLxU1z1LUtVPDkqsA9XZ/ojHkjM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FkpgwMdoai461vS3TGpxuug+1RIwyqEK
        XUsDXi7hu6OJA+89v4gXda5TW0GEVwBH6zdY6o14gN0uhKnGsc9y1/00CqW/nZP3
        hj6dJS4TrpXO+jP3uMdW03Q7R6IsJ1r7OzbxVPkVM+x9FU++W23NdSCifdrz10fh
        grZAFdT89V4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3709599C8D;
        Thu, 19 Nov 2020 17:45:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B1A8A99C89;
        Thu, 19 Nov 2020 17:45:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 5/7] config: plumb --literal-value into config API
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
        <5881b2d987e3e8575d054a64fe21fbe7e7967aba.1605801143.git.gitgitgadget@gmail.com>
Date:   Thu, 19 Nov 2020 14:45:11 -0800
In-Reply-To: <5881b2d987e3e8575d054a64fe21fbe7e7967aba.1605801143.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 19 Nov 2020
        15:52:21 +0000")
Message-ID: <xmqqblftvudk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E28269C0-2AB8-11EB-AA99-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/config.c b/config.c
> index 4841c68a91..5028c1e736 100644
> --- a/config.c
> +++ b/config.c
> @@ -2402,6 +2402,7 @@ struct config_store_data {
>  	size_t baselen;
>  	char *key;
>  	int do_not_match;
> +	const char *literal_value;
>  	regex_t *value_regex;
>  	int multi_replace;
>  	struct {
> @@ -2431,6 +2432,8 @@ static int matches(const char *key, const char *value,
>  {
>  	if (strcmp(key, store->key))
>  		return 0; /* not ours */
> +	if (store->literal_value)
> +		return !strcmp(store->literal_value, value);
>  	if (!store->value_regex)
>  		return 1; /* always matches */
>  	if (store->value_regex == CONFIG_REGEX_NONE)
> @@ -2803,6 +2806,8 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
>  			store.value_regex = NULL;
>  		else if (value_regex == CONFIG_REGEX_NONE)
>  			store.value_regex = CONFIG_REGEX_NONE;
> +		else if (flags & CONFIG_FLAGS_LITERAL_VALUE)
> +			store.literal_value = value_regex;
>  		else {
>  			if (value_regex[0] == '!') {
>  				store.do_not_match = 1;

This is nice.  It is a surprisingly small change.

Thanks.
