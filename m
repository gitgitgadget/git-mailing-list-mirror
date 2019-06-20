Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C45C1F461
	for <e@80x24.org>; Thu, 20 Jun 2019 19:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfFTTzF (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 15:55:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63347 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfFTTzE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 15:55:04 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8BAA6167892;
        Thu, 20 Jun 2019 15:55:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=l4FsNvAdZaX/
        6AZAX2cyM7gg8p8=; b=d3h39gyMj4Mj9EmM4cjr+vG1JsMUt8KAPBNTy9LQNf7n
        s82Ynbr/xcIW3EuynjWYXN0CfGEXIJlHqTK7whjbf9htRLPXK/gHZj4zSChhgEPv
        zCDcE6r26/V2WPc4a/WPZK+G/dS8YYsFY27Gk4H/JT+dxYg+B3dfXsv7WYpFbPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=WuFVnO
        dyWj29ZRHrDMcjuqdlEQKVEUADvm0p7fftO2qQbz360RcMYBP7ys5pxfQGWklnHk
        Z8ONgoyIohSHzfceXeMZ3CwrVg7OtQVZPNB48nQpSsg2TW+pPVp48HV5S8ic7KzE
        dBEVpSqc1Ae4s6Xhv6irvb5sKsHh4iJ9OXFho=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5F7D3167890;
        Thu, 20 Jun 2019 15:55:00 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A4B4416788F;
        Thu, 20 Jun 2019 15:54:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/6] t6040 test: stop using global "script" variable
References: <87imt18a2r.fsf@evledraar.gmail.com>
        <20190619233046.27503-3-avarab@gmail.com>
Date:   Thu, 20 Jun 2019 12:54:58 -0700
In-Reply-To: <20190619233046.27503-3-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 20 Jun 2019 01:30:42 +0200")
Message-ID: <xmqqy31wm3ql.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 49131FDE-9395-11E9-9825-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change test code added in c0234b2ef6 ("stat_tracking_info(): clear
> object flags used during counting", 2008-07-03) to stop using the
> "script" variable also used for lazy prerequisites in
> test-lib-functions.sh.
>
> Since this test uses test_i18ncmp and expects to use its own "script"
> variable twice it implicitly depends on the C_LOCALE_OUTPUT
> prerequisite not being a lazy prerequisite. A follow-up change will
> make it a lazy prerequisite, so we must remove this landmine before
> inadvertently stepping on it as we make that change.

Well spotted (eh, I suspect that you didn't until you actually stomped
on the landmine and saw it trigger, and then pretending to have had
the perfect foresight in this series, which is perfectly fine ;-),
and nicely done.

>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  t/t6040-tracking-info.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
> index 716283b274..970b25a289 100755
> --- a/t/t6040-tracking-info.sh
> +++ b/t/t6040-tracking-info.sh
> @@ -38,7 +38,7 @@ test_expect_success setup '
>  	advance h
>  '
> =20
> -script=3D's/^..\(b.\) *[0-9a-f]* \(.*\)$/\1 \2/p'
> +t6040_script=3D's/^..\(b.\) *[0-9a-f]* \(.*\)$/\1 \2/p'
>  cat >expect <<\EOF
>  b1 [ahead 1, behind 1] d
>  b2 [ahead 1, behind 1] d
> @@ -53,7 +53,7 @@ test_expect_success 'branch -v' '
>  		cd test &&
>  		git branch -v
>  	) |
> -	sed -n -e "$script" >actual &&
> +	sed -n -e "$t6040_script" >actual &&
>  	test_i18ncmp expect actual
>  '
> =20
> @@ -71,7 +71,7 @@ test_expect_success 'branch -vv' '
>  		cd test &&
>  		git branch -vv
>  	) |
> -	sed -n -e "$script" >actual &&
> +	sed -n -e "$t6040_script" >actual &&
>  	test_i18ncmp expect actual
>  '
