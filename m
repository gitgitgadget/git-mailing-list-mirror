Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41C8C55191
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 22:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6756720736
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 22:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UgEHsPX2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgDXWUg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 18:20:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65445 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgDXWUf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 18:20:35 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 550985770C;
        Fri, 24 Apr 2020 18:20:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SwQRSGxkk5+hxsYxzjUJeJrBAW0=; b=UgEHsP
        X2ag3VFKPJmzXcBUvq/1wsgK0vgrVn1KqnuSPn6l8CJOCJ9p1EhDntK81kOnrGmB
        8JnWVd46xvoaENV3PW43XMe2ymisJR92D1NTkP8HyBe9jwb6vBS6T6MN5Y8qNJo0
        reoV3bmi5x/MAAg/CzPDF1AZqxxLNfuAdTsgM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DOlxmtIshy74Pa0IVz9FLGghHKqFJalK
        5Wj5a/CwUhHv6KUYsLOFUGWT3CG/2PD+Gz39m/cgbEtuxR0jMq8EMkhB6uzv6lNA
        RfbCMFWx/rsf8whN/LoccUoy6lKmsuJaQX4jnqdavTo+hkcCSOgwD6a5KeN7ye7E
        o3O4btoKg3A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4CB675770B;
        Fri, 24 Apr 2020 18:20:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D01EE5770A;
        Fri, 24 Apr 2020 18:20:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ilya Tretyakov <it@it3xl.ru>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 3/3] credential: handle `credential.<partial-URL>.<key>` again
References: <pull.615.v2.git.1587685397.gitgitgadget@gmail.com>
        <pull.615.v3.git.1587728992.gitgitgadget@gmail.com>
        <0535908dd7ea4487b342c0f86182579279c57b34.1587728992.git.gitgitgadget@gmail.com>
Date:   Fri, 24 Apr 2020 15:20:32 -0700
In-Reply-To: <0535908dd7ea4487b342c0f86182579279c57b34.1587728992.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Fri, 24 Apr 2020
        11:49:52 +0000")
Message-ID: <xmqq4kt8bk5r.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D0195052-8679-11EA-902A-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> @@ -53,7 +57,13 @@ static int credential_config_callback(const char *var, const char *value,
>  		char *url = xmemdupz(key, dot - key);
>  		int matched;
>  
> -		credential_from_url(&want, url);
> +		if (credential_from_potentially_partial_url(&want, url) < 0) {
> +			warning(_("skipping credential lookup for key: %s"),
> +				var);
> +			credential_clear(&want);
> +			free(url);
> +			return 0;
> +		}
>  		matched = credential_match(&want, c);

Unfortunately, the whole section of this code that is being patched
here goes away with 46fd7b39 (credential: allow wildcard patterns
when matching config, 2020-02-20), that delegates large part of the
logic to urlmatch.

Dscho and Brian, how do we want to proceed?  As the conflicting
change has already been in 'next' for more than a month and a half,
we'd need this "partial URL" logic build to work well with it.

Thanks.
