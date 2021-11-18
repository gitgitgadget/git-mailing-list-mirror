Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E18C433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 23:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D6D961A8A
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 23:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbhKRXpV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 18:45:21 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58229 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhKRXpV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 18:45:21 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 521EF168ADC;
        Thu, 18 Nov 2021 18:42:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=w6QRTBcXdzxIz9MmrSBmdVbAhYt/R0433eYN1O
        v4TZ4=; b=aQj0OLk+x2jynC3PU/bUMqmTR8nVaPUjLYBW3fmLst4/DV/a/W/Cgw
        Mi8tuhOsVc4XEGrTn1e0X/UbryBRJY0KLZecZIYOaUimEQ9IlTyVter5+nnMr68E
        iUxkZK3J7R9+ONX84yN2VCdS2DFE+npPYQ36umOWA2BUDrEBm6n8g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4B534168ADB;
        Thu, 18 Nov 2021 18:42:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A498C168ADA;
        Thu, 18 Nov 2021 18:42:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Adam Dinwoodie <adam@dinwoodie.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] test-lib: introduce required prereq for test runs
References: <20211117090410.8013-1-fs@gigacodes.de>
        <20211117090410.8013-3-fs@gigacodes.de>
Date:   Thu, 18 Nov 2021 15:42:16 -0800
In-Reply-To: <20211117090410.8013-3-fs@gigacodes.de> (Fabian Stelzer's message
        of "Wed, 17 Nov 2021 10:04:10 +0100")
Message-ID: <xmqqpmqxuj3b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2A4C69AC-48C9-11EC-BAC7-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

> +			# Abort if this prereq was marked as required
> +			if test -n $GIT_TEST_REQUIRE_PREREQ

If GIT_TEST_REQUIRE_PREREQ is an empty string, this will ask

	test -n

and "test" will say "yes" (because "-n" is not an empty string).

Let's surround it with a pair of double-quotes.

> +			then
> +				case ",$GIT_TEST_REQUIRE_PREREQ," in
> +				*,$prerequisite,*)
> +					error "required prereq $prerequisite failed"
> +					;;
> +				esac
> +			fi
> +
>  			if test -z "$missing_prereq"
>  			then
>  				missing_prereq=$prerequisite
