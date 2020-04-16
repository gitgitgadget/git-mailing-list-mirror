Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFADAC2BB55
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 17:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAAE1214D8
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 17:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GeXIhJbw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbgDPRtS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 13:49:18 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52886 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727977AbgDPRtS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Apr 2020 13:49:18 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B683DB34FE;
        Thu, 16 Apr 2020 13:49:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NGExLHLivQ9DAvwFJktMltxbUEU=; b=GeXIhJ
        bwf5Oas+1MvfTU2OpooxAsXmdnMux5gK+ThzbN2EzpIccLmDM17JoPdIcxBhsZ/2
        bgiD7OOI/I6KxA2o1nNgcCHJK8J4tzGnayb/EsHu1knwgMjGGVNGEIQi/82Mm1Bj
        rro1vQ2iSAT/S1ZNypSbhGNHUmNU5tIibmRhI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=niDatz/wyXNbNTPRPnjtIJWPlE4rtOdZ
        rZpE3gPa9+l6E/nuG6QJ4g+kVzPQZJwcJ9zFTgIkgu62UuD+TlgGUboijBALMIGD
        HA9uCAY+SA98cO9AXkNVXn7TExX2TKdfXsdB6+z8NIFp6e5X2C0BagZK8sV1SkJR
        7uVc8YgO4jw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AED00B34FD;
        Thu, 16 Apr 2020 13:49:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A84B4B34FB;
        Thu, 16 Apr 2020 13:49:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sluongng@gmail.com, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 2/2] log: add log.excludeDecoration config option
References: <pull.610.v2.git.1586965463222.gitgitgadget@gmail.com>
        <pull.610.v3.git.1587046549.gitgitgadget@gmail.com>
        <96c865e9214802021f8e991d2194b7aea6cd6bba.1587046549.git.gitgitgadget@gmail.com>
Date:   Thu, 16 Apr 2020 10:49:12 -0700
In-Reply-To: <96c865e9214802021f8e991d2194b7aea6cd6bba.1587046549.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 16 Apr 2020
        14:15:49 +0000")
Message-ID: <xmqqo8rrz5gn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 95A7E782-800A-11EA-BC04-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/log-tree.c b/log-tree.c
> index ab6d29a746b..fd3fd3316a1 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -103,6 +103,8 @@ static int ref_filter_match(const char *refname,
>  	struct string_list_item *item;
>  	const struct string_list *exclude_patterns = filter->exclude_ref_pattern;
>  	const struct string_list *include_patterns = filter->include_ref_pattern;
> +	const struct string_list *exclude_patterns_config =
> +				filter->exclude_ref_config_pattern;
>  
>  	if (exclude_patterns && exclude_patterns->nr) {
>  		for_each_string_list_item(item, exclude_patterns) {
> @@ -112,17 +114,21 @@ static int ref_filter_match(const char *refname,
>  	}
>  
>  	if (include_patterns && include_patterns->nr) {
> -		int found = 0;
>  		for_each_string_list_item(item, include_patterns) {
>  			if (match_ref_pattern(refname, item)) {
> -				found = 1;
> -				break;
> +				return 1;
>  			}

Micronit.  

Let's mimick the early return in the loop above (for command line
excludes) and below (for configured excludes), each of which is just
a single "return" statement in a block without {braces} around.

Other than that, looks nicely done.

The new tests are really appreciated, too.
