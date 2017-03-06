Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2395920133
	for <e@80x24.org>; Mon,  6 Mar 2017 22:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932438AbdCFWWN (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 17:22:13 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64891 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754233AbdCFWVf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 17:21:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0C3AD70E9A;
        Mon,  6 Mar 2017 17:21:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8kwXQXCzOsnNmBMhRWmGvYAxJ/I=; b=ETMTNX
        7WVZHOpCJ3vSZeOi5z+21/+X1oTQCfRWj1WMBdiqUbrmRYWfsD6kLn8VhV3GFcvx
        P1C8GJxYsksUO+Q1b/CqJKbG5/gdxfjILqkK+Zm4rKdOKdeNNmqsWLG2ZbXcFMDi
        mR7fjJSb7owyjFzVaAfn7+hR9SfTvXARc/KLc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DSylaMgtCs5tbhP3po1C93kFFsm3raHX
        eVWsQ/FZg2xayL7n9qlEMJed71SY59U39a4nKGVOm350bsVaxRU9pXpgGWAo9LNi
        oshso2O/5vnxZbEXELvi49Gjr5lFqohZBunIKJ7dj5Er2EInsrFMJMHfmXCPkmH4
        fRoxfo0pMIA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EB01F70E99;
        Mon,  6 Mar 2017 17:21:32 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.84])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 47E3570E98;
        Mon,  6 Mar 2017 17:21:32 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: Re: [PATCH 03/18] lib-submodule-update: teach test_submodule_content the -C <dir> flag
References: <20170302004759.27852-1-sbeller@google.com>
        <20170306205919.9713-1-sbeller@google.com>
        <20170306205919.9713-4-sbeller@google.com>
Date:   Mon, 06 Mar 2017 14:21:31 -0800
In-Reply-To: <20170306205919.9713-4-sbeller@google.com> (Stefan Beller's
        message of "Mon, 6 Mar 2017 12:59:04 -0800")
Message-ID: <xmqqo9xem4gk.fsf@junio-linux.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4095061E-02BB-11E7-B7AC-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  t/lib-submodule-update.sh | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
> index c0d6325133..00128f28b5 100755
> --- a/t/lib-submodule-update.sh
> +++ b/t/lib-submodule-update.sh
> @@ -193,6 +193,11 @@ test_superproject_content () {
>  # Test that the given submodule at path "$1" contains the content according
>  # to the submodule commit recorded in the superproject's commit "$2"
>  test_submodule_content () {
> +	if test x"$1" = "x-C"
> +	then
> +		cd "$2"
> +		shift; shift;

That's old fashoned like me ;-)  

It seems "shift [<n>]" is already used elsewhere in our test scripts
without getting complaints.

'git-difftool-helper.sh' is the only one that uses number above 1 in
the scripted Porcelains, so it is possible that an esoteric platform
without a shell that understands it may be built and used _without_
passing our test suite, so I'd be wary of using it in the scripted
Porcelains, but this is part of the test suite, so I would think it
is OK.

> +	fi
>  	if test $# != 2
>  	then
>  		echo "test_submodule_content needs two arguments"
