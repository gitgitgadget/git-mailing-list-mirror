Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335DEC433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 21:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08E0C22CAE
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 21:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="v2kG+v0x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgHEVaz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 17:30:55 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50011 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgHEVay (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 17:30:54 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A2F70E68AB;
        Wed,  5 Aug 2020 17:30:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=22rkaiLcfFNGN07cSkmO4wjmbWU=; b=v2kG+v
        0xuYYFUhZRUI0kApMHP0VgocEtkgdtpw5jiiaBKy5U3Vkj5mRSm+GXqyinYDB4oQ
        8gkISeq21lbwAVpzfhUxkBaX+VXz01nkPA3eL1elgXA016T6Juxky8FK51RcWfe1
        03NuJAvgeakvQ2rA6O83rDpqPax7bcReIHuVg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZAiPdt1Db1d9xdzQCwMmQXrq/enD6MBM
        my7SfG9AfjlnljHlUkNaSRTrvWeSpdPV83YyiFZI2Y4NE+OmDM7sNIrWYbrVXiOn
        WJFDNXkWiP0PLRDgDFiUWDOcCEwzigMB0CyUk216qGquI5Vv4KojsjDuItqZ6cug
        uaGpG808Vzk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9B162E68AA;
        Wed,  5 Aug 2020 17:30:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 201FBE68A6;
        Wed,  5 Aug 2020 17:30:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, johannes.schindelin@gmx.de,
        liu.denton@gmail.com, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/4] t7401: ensure uniformity in the '--for-status' test
References: <20200805174921.16000-1-shouryashukla.oo@gmail.com>
        <20200805174921.16000-4-shouryashukla.oo@gmail.com>
Date:   Wed, 05 Aug 2020 14:30:48 -0700
In-Reply-To: <20200805174921.16000-4-shouryashukla.oo@gmail.com> (Shourya
        Shukla's message of "Wed, 5 Aug 2020 23:19:20 +0530")
Message-ID: <xmqq3650ok53.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EECE490A-D762-11EA-BA68-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> The '--for-status' test got its expected output from stdin. This is
> inconsistent with the other tests in the test script which get their
> expected output from a file named 'expected'.
>
> So, change the syntax of the '--for-status' test for uniformity.

There are a handful examples in t5401 and another one in t3700 that
give the "golden master" from the standard input.  When the expected
output is used only once, I do not think it is particularlly bad to
have it this way.  So,... meh?

Unless there is a compelling reason to insist both are files
(that may make it easier to enhance test_cmp in a certain way
you plan to, for example), that is.

> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> ---
>  t/t7401-submodule-summary.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
> index 18fefdb0ba..145914cd5a 100755
> --- a/t/t7401-submodule-summary.sh
> +++ b/t/t7401-submodule-summary.sh
> @@ -285,13 +285,14 @@ EOF
>  
>  test_expect_success '--for-status' "
>  	git submodule summary --for-status HEAD^ >actual &&
> -	test_i18ncmp actual - <<EOF
> +	cat >expected <<-EOF &&
>  * sm1 $head6...0000000:
>  
>  * sm2 0000000...$head7 (2):
>    > Add foo9
>  
>  EOF
> +	test_i18ncmp expected actual
>  "
>  
>  test_expect_success 'fail when using --files together with --cached' "
