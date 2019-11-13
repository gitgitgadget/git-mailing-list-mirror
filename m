Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C1651F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 01:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbfKMB5l (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 20:57:41 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64284 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729847AbfKMB5k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 20:57:40 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CC1EB98A8B;
        Tue, 12 Nov 2019 20:57:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Zx45izvbrvWyUg1KQ8g9V0M0mJw=; b=CdB85p
        BBDHSa1jp/ZC1//Tchv7g3yA1Hz3QHva1GOIKHNat7UP60WAGqgZpoiGFcmG6OBL
        jgLmv5uXsQ5SqzTPUT5W0+OmuWCFvotdIaKi9UfiUPmFZeUQx3BQZlRo99Zw+RDk
        vLHmIQozVsGw7y3IqxCF9IWO0w0evxtGi7BAw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=t2ZSM2RUOGu1l9H1zChiZg2MPpdfsGhs
        3JcXFUIihDoNI91PIrONW0iD5N2lGWcW6chahfhBzJkZXs9Zyf3BuNEwisqb3Gv/
        QyxpVXVBIw5a3B+GPuWtYYnR2/kPUYoqpnVI+ep/kRFxQ9+CfxOS4xyJt4GCwWta
        qje3wsAxYGY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B11C998A8A;
        Tue, 12 Nov 2019 20:57:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DD8C198A89;
        Tue, 12 Nov 2019 20:57:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v6 01/14] t: teach test_cmp_rev to accept ! for not-equals
References: <cover.1573517561.git.liu.denton@gmail.com>
        <cover.1573595985.git.liu.denton@gmail.com>
        <0532847787dfd48fbe4b41a4a7d2783748f3bd7f.1573595985.git.liu.denton@gmail.com>
Date:   Wed, 13 Nov 2019 10:57:34 +0900
In-Reply-To: <0532847787dfd48fbe4b41a4a7d2783748f3bd7f.1573595985.git.liu.denton@gmail.com>
        (Denton Liu's message of "Tue, 12 Nov 2019 15:07:45 -0800")
Message-ID: <xmqqmud0czch.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F74AE844-05B8-11EA-9224-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> +# Tests that its two parameters refer to the same revision, or if '!' is
> +# provided first, that its other two parameters refer to different
> +# revisions.
>  test_cmp_rev () {
> +	local op wrong_result
> +	op='='
> +	wrong_result='different'
> +	if test $# -ge 1 && test "x$1" = 'x!'
> +	then
> +	    op='!='
> +	    wrong_result='the same'
> +	    shift
> +	fi

I'd prefer

	local op wrong_result

	if test $# -ge 1 && test "x$1" = 'x!'
	then
	    op='!='
	    wrong_result='the same'
	    shift
	else
	    op='='
	    wrong_result='different'
	fi

that clarifies that the variants with and without '!' are equals, as
opposed to the form with '!' is an afterthought exception.

On the other hand, if we want to insist that the form without '!' is
the norm, then

	local op='=' wrong_result='different'

	if test $# -ge 1 && test "x$1" = 'x!'
	then
	    op='!='
	    wrong_result='the same'
	    shift
	fi

would be shorter (yes, I made sure we already use assignment to a
variable on the same line where it is declared "local"; we used to
avoid "local" that is outside POSIX so I want to make sure our use
is safe).

I'll queue the patches as-is, but if enough people agree with me (on
either variants), I'd locally amend to make it so (i.e. no need to
resend only for this change).

Thanks.
