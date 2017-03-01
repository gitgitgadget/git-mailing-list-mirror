Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F4C12023D
	for <e@80x24.org>; Wed,  1 Mar 2017 20:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751450AbdCAUKs (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 15:10:48 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56996 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750815AbdCAUKp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 15:10:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9681975464;
        Wed,  1 Mar 2017 14:53:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gEfnHXABMyffH6PilxaVYmXBVyY=; b=FRAjbn
        Q45KZHibhNUYpl07OCno7f+ixEzNwThw3WMUWD2HP8vz4GL4T0Egs8k+I+lslso3
        3nAb4ss8s0gdTc8GnjkQeZQll95r9FWFKIgESMiq9xgrj1nf8u3hTV/mUw564mZy
        8iw11XTuWIleoH8OG1VGUjomAXvDs4wFcd+PQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=c6fBMDCn9oHC9ArVQ0ZNb5EzPenk7Uor
        nLvL6uYzwsPGezJyAG5h2nczWTRAcSsewIn5VryMq97h7VC4xz3ejbTsTGLL3kYD
        NC24VORnWhMJinJ++moANTpucxdzCcmunKOZVdLz0BNtzzytlbutsxQOqQ+wxBlE
        bQi0zaV/FJE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8F70875463;
        Wed,  1 Mar 2017 14:53:45 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 06BD875461;
        Wed,  1 Mar 2017 14:53:44 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/6] Introduce a new "printf format" for timestamps
References: <cover.1488231002.git.johannes.schindelin@gmx.de>
        <f4ff525dda1964dd0e7cef1d0507e1f2403469e1.1488231002.git.johannes.schindelin@gmx.de>
        <xmqqbmtkhna9.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 01 Mar 2017 11:53:43 -0800
In-Reply-To: <xmqqbmtkhna9.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 01 Mar 2017 10:20:14 -0800")
Message-ID: <xmqqy3wog4e0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C72C710A-FEB8-11E6-9CA8-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>
>> So let's introduce the pseudo format "PRItime" (currently simply being
>> "lu") so that it is easy later on to change the data type to time_t.
>
> The problem being solved is a good thing to solve, and 
>
>> -	printf("author-time %lu\n", ci.author_time);
>> +	printf("author-time %"PRItime"\n", ci.author_time);
> ...
> It would be better to introduce the timestamp_t we discussed earlier
> before (or at) this step, and typedef it to ulong first, and then in
> this step, change the above to
>
> 	printf("author-time %"PRItime"\n", (timestamp_t)ci.author_time);
>
> to keep them in sync.

Nah, ignore me.  This was just me being silly.

I was somehow expecting (incorrecty) that we would pick one single
PRItime for everybody and end up doing an equivalent of

	printf("%llu", (unsigned long long)(something_that_is_time_t))

But as long as the plan is to configure PRItime for the platform's
time_t (or whatever the final type for timestamp_t is), we do not
have to have any extra cast here.  The endgame will use the type
that is consistent with %PRItime for variables and structure fields,
and we do not want an extra cast.
