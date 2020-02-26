Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9E4C4BA24
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 20:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF04520714
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 20:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KZRamrNn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgBZU0N (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 15:26:13 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64304 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbgBZU0M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 15:26:12 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 908A13AA85;
        Wed, 26 Feb 2020 15:26:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pIDD9Si7aHEqliZEcM3h2u8T9oA=; b=KZRamr
        NnZlubfyqfgHhcOyDLyNY1sGX/XrDKhEm7pXWohGhgrTouCLiu9fdujsGqXGq45I
        X1KNaKlEH2PkqJmjAmAtcWJDLl7Emgi3vn7nfsb+nFHh4EQUeHzhUgFs3A9+OR3a
        NCMSUiygw2X9To0aFfLWhS5onLkRw/Bi1CLoo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HheKGtCJomEBjF69HAympY/PTBtTh+dh
        ifoxiry783+dxpsnUIut7PQGEsu9gVo6AVSOvJB6lTItU9f7KdzjGOPY+yMg91Kk
        OYFfJaLViV+S4wrruXCsxIu/cdJyDdPhaJYTQayQyzYKX5aa1kjEYEv84ZojJQvb
        5NRxOSp2bys=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 888683AA84;
        Wed, 26 Feb 2020 15:26:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E91E03AA83;
        Wed, 26 Feb 2020 15:26:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/3] t/lib-httpd: avoid using BSD's sed
References: <pull.714.git.git.1582747775.gitgitgadget@gmail.com>
        <9900cacbfefb46610114702e6d48d8020f3f2866.1582747775.git.gitgitgadget@gmail.com>
Date:   Wed, 26 Feb 2020 12:26:09 -0800
In-Reply-To: <9900cacbfefb46610114702e6d48d8020f3f2866.1582747775.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 26 Feb 2020
        20:09:33 +0000")
Message-ID: <xmqqimjthz8e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A21A624-58D6-11EA-8C21-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
> index 9e16512fe31..4f10057e9f1 100755
> --- a/t/t5537-fetch-shallow.sh
> +++ b/t/t5537-fetch-shallow.sh
> @@ -237,7 +237,7 @@ test_expect_success 'shallow fetches check connectivity before writing shallow f
>  	git -C "$REPO" config protocol.version 2 &&
>  	git -C client config protocol.version 2 &&
>  
> -	git -C client fetch --depth=2 "$HTTPD_URL/one_time_sed/repo" master:a_branch &&
> +	git -C client fetch --depth=2 "$HTTPD_URL/one_time_perl/repo" master:a_branch &&
>  
>  	# Craft a situation in which the server sends back an unshallow request
>  	# with an empty packfile. This is done by refetching with a shorter
> @@ -246,13 +246,13 @@ test_expect_success 'shallow fetches check connectivity before writing shallow f
>  	printf "$(test_oid sed)" \

Hmm, shouldn't the test-oid token "sed" whose value is set up in the
setup section of this test script also be renamed to "perl"?  Or, if
we are actively taking advantage of the fact that the syntax of the
replacement operator is the same between the languages, perhaps "sed"
is better renamed to something more language agnostic and reflects
the purpose/reason why we extend the packet header by two bytes with
the one-time munging process?

>  	       "$(git -C "$REPO" rev-parse HEAD)" \
>  	       "$(git -C "$REPO" rev-parse HEAD^)" \
> -	       >"$HTTPD_ROOT_PATH/one-time-sed" &&
> +	       >"$HTTPD_ROOT_PATH/one-time-perl" &&

Other than that, this step looked quite sensible.  Thanks.
