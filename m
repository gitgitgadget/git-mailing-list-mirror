Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15B8220323
	for <e@80x24.org>; Wed, 22 Mar 2017 19:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759666AbdCVToT (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 15:44:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60894 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1759122AbdCVToC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 15:44:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8CB187B514;
        Wed, 22 Mar 2017 15:44:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VKaBlzzMqkyrFM818wUdukStnr4=; b=GB7eP8
        mHJwuZWGKCC1PTDlFxAPmkQtetxz0PG2sSm8YpowY5Yr/DSnXtBuHl8Q7uwQlVK1
        9qhnzBSL950D1XD3C0z8ZMo4+xb/JCAcmx8pRf+xFKjT6k4MZCKYRaopw4IhOJPa
        +R/ngj5RHsTQuYxqCECHOZFECk64nzVJughuM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UTAr5/XY0oiWnQlhhHL7f36REKzCWCtp
        qEdF1FeTYvZ35Gr1+B96p5bZ3Wb3FgstHrsL3VPbWcIuHSfDmj2QYPNb8dQosa6H
        lVethMOqAh0TiaEGyosEO52F9QGk3EeZmPKR4AQUkKUbmcEVu7MhAabMOuHtNGAZ
        Ze++JkOI6Sw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 621C97B513;
        Wed, 22 Mar 2017 15:44:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A7AB57B510;
        Wed, 22 Mar 2017 15:43:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jan Palus <jan.palus@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: EOF test fixes (t5615/t7004)
References: <20170322173528.ho43ulndlozq35tu@kalarepa>
Date:   Wed, 22 Mar 2017 12:43:58 -0700
In-Reply-To: <20170322173528.ho43ulndlozq35tu@kalarepa> (Jan Palus's message
        of "Wed, 22 Mar 2017 18:35:28 +0100")
Message-ID: <xmqqo9wtjdvl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E4F52530-0F37-11E7-B2C0-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jan Palus <jan.palus@gmail.com> writes:

> diff -ur git-2.12.0.orig/t/t7004-tag.sh git-2.12.0/t/t7004-tag.sh
> --- git-2.12.0.orig/t/t7004-tag.sh	2017-02-25 14:10:53.059367179 +0100
> +++ git-2.12.0/t/t7004-tag.sh	2017-02-25 14:11:45.105827700 +0100
> @@ -880,17 +880,17 @@
>  '
>  
>  test_expect_success 'verifying a proper tag with --format pass and format accordingly' '
> -	cat >expect <<-\EOF
> +	cat >expect <<-\EOF &&
>  	tagname : signed-tag
> -	EOF &&
> +	EOF
>  	git tag -v --format="tagname : %(tag)" "signed-tag" >actual &&
>  	test_cmp expect actual
>  '
>  
>  test_expect_success 'verifying a forged tag with --format fail and format accordingly' '
> -	cat >expect <<-\EOF
> +	cat >expect <<-\EOF &&
>  	tagname : forged-tag
> -	EOF &&
> +	EOF
>  	test_must_fail git tag -v --format="tagname : %(tag)" "forged-tag" >actual &&
>  	test_cmp expect actual
>  '

Ouch.  These shouldn't even have passed our review.

Thanks for spotting.
