Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BFA920135
	for <e@80x24.org>; Wed,  8 Mar 2017 23:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752874AbdCHXwa (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 18:52:30 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61896 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750869AbdCHXw3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 18:52:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 16AA371277;
        Wed,  8 Mar 2017 18:51:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nPHldb9X3xrgbec/5MkIseiVQms=; b=KZcH+/
        f3/+rRFBtwEaGR/cDNuXWqD9qqoxkc+evJWSmA6s8otWQYSE/JGqlTiXfS8O0qWu
        oBP8L0aitOc6xBH4TiFD80zKlmB0OIIEWrqwGinPSGH/mKgjfUWSV9eb+KOMpheI
        X+OwxzAWZGbw29lxVDXF9qhX0W54CauGOXFms=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oQk2xVvldIrZl73Gidpvj2zbnOw09QXd
        yBHFpyeB5VPX/eGoc8RKmrwjSps8DkD9PCimx3+CGEiW3K96CT4WCMkLfLizyCnj
        zdRih+F4Q1q+HXvWBFkNyuVzuzw3tadgy9lr7UadT4YegX6NF3GB1MukW7GziPif
        GpINZiwGw3Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D54D71276;
        Wed,  8 Mar 2017 18:51:42 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 618B871274;
        Wed,  8 Mar 2017 18:51:41 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     szeder.dev@gmail.com, email@benjaminfuchs.de, git@vger.kernel.org,
        sandals@crustytoothpaste.net, ville.skytta@iki.fi
Subject: Re: [PATCHv4] rev-parse: add --show-superproject-working-tree
References: <xmqqmvcv1jz9.fsf@gitster.mtv.corp.google.com>
        <20170308230742.5185-1-sbeller@google.com>
Date:   Wed, 08 Mar 2017 15:51:40 -0800
In-Reply-To: <20170308230742.5185-1-sbeller@google.com> (Stefan Beller's
        message of "Wed, 8 Mar 2017 15:07:42 -0800")
Message-ID: <xmqqr327z5rn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2D7BEE08-045A-11E7-900F-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>  *this patch*
>  
> * Documentation shamelessly stolen from Junio.

You stole it, and then ...

> +test_expect_success 'showing the superproject correctly' '
> +	git rev-parse --show-superproject-working-tree >out &&
> +	test_must_be_empty out &&

... made sure that the newly documented behaviour is tested as a
feature.  Good.

> +	test_create_repo super &&
> +	test_commit -C super test_commit &&
> +	test_create_repo sub &&
> +	test_commit -C sub test_commit &&
> +	git -C super submodule add ../sub dir/sub &&
> +	echo $(pwd)/super >expect  &&
> +	git -C super/dir/sub rev-parse --show-superproject-working-tree >out &&
> +	test_cmp expect out
> +'
> +
