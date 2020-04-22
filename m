Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47410C54FCB
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 22:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E784E20776
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 22:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Cty2ZS0y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgDVW3M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 18:29:12 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58712 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgDVW3L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 18:29:11 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BCCFFC4FD5;
        Wed, 22 Apr 2020 18:29:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mC3D2WXQqxnabF4No7WBVfHURlU=; b=Cty2ZS
        0ycT6L+xb3J4OS50vHybsf6Dg27j2Et9G/6AXNCpwsUWcN/5m2l3Oc1jJZq4TDis
        eFLktcXAypQe8KfTyudInVg+1e29FAJcbVSjdTa+aYL4n75knoCb9/GMTvtAE/Qj
        TiYHFHpVtAn62O9EKyqtYr69JsUADoG7F4wv0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LzoMWvX1TAKwvid2X3Pkx9h0PDqzv3Eo
        ym6m+Ccl/d0canvAXN3Bob31cqK+Mjm0PLZgyBjYFTttVFB55Xjfi8gxWFWgBWY1
        bKYzdf0wLE+dOAw+rOfEoAI0rYJ085hoPZBgCsqohI0MRhvPVtSgotAstCL9YMAA
        7zc/IE6W5pg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AF7AFC4FD4;
        Wed, 22 Apr 2020 18:29:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 92B9EC4FD0;
        Wed, 22 Apr 2020 18:29:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ilya Tretyakov <it@it3xl.ru>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/3] credential: teach `credential_from_url()` a non-strict mode
References: <pull.615.git.1587588665.gitgitgadget@gmail.com>
        <1081841b16de31693473e72ff817bed5f0064dda.1587588665.git.gitgitgadget@gmail.com>
Date:   Wed, 22 Apr 2020 15:29:04 -0700
In-Reply-To: <1081841b16de31693473e72ff817bed5f0064dda.1587588665.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 22 Apr 2020
        20:51:04 +0000")
Message-ID: <xmqqh7xbi28f.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AD7D24A2-84E8-11EA-A35C-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> -	if (!proto_end || proto_end == url) {
> +	if (strict && (!proto_end || proto_end == url)) {
>  		if (!quiet)
>  			warning(_("url has no scheme: %s"), url);
>  		return -1;
>  	}
> -	cp = proto_end + 3;
> +	cp = proto_end ? proto_end + 3 : url;
>  	at = strchr(cp, '@');
>  	colon = strchr(cp, ':');
>  	slash = strchrnul(cp, '/');
> @@ -382,8 +382,10 @@ int credential_from_url_gently(struct credential *c, const char *url,
>  		host = at + 1;
>  	}
>  
> -	c->protocol = xmemdupz(url, proto_end - url);
> -	c->host = url_decode_mem(host, slash - host);
> +	if (proto_end && proto_end - url > 0)
> +		c->protocol = xmemdupz(url, proto_end - url);

Missing "proto://" under non-strict mode would leave c->protocol
NULL (not "") here, as described in [0/3].

Here, slash would be pointing at one of "/?#" at the end of the host
and url would be pointing at...?  E.g. for "http:///path", URL
points at 'h' at the beginning, proto_end points at ':', cp points
at the last '/' before "path" and slash is the same as cp.  host
points at cp as there is no '@' at sign.

> +	if (slash - url > 0)
> +		c->host = url_decode_mem(host, slash - host);

This wants to make c->host NULL when host is missing, as described
in [0/3].

Shouldn't the condition based on "slash - host", though?

Other than that, it looks sensible.
