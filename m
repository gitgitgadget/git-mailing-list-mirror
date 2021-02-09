Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1725C433E9
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 21:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 789C164EE5
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 21:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbhBIVmo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 16:42:44 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57863 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbhBIUzB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 15:55:01 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 44EA910C50A;
        Tue,  9 Feb 2021 15:54:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BPFfqARZqunlvkWwZn4MR1pTWGY=; b=iPqbIX
        fbKhaSB0swjpAkXEaPZ5Fv2Ia2bxC8xpwkplVtgSvV1rU3ZmIrHiCM76KgHOqV/T
        ZEQJ587YFzsjcOActOip0Rq9xidDRKBZXuVoOz6XXjFJaeQZ3jQz8x5B+kMv6RSm
        hj3k1mhid4JM/2jeY3bkSVgzV71gcvwWYmPyI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nJ9MgmvNzy8xPyx/oqabE5WiaJIP3QRI
        FA7cyNK3R5d3toGnaW3olpheqAgzXQ39uXxBk3xjSshAjZoAX2oWPg5bJRKTgJal
        WQYNSfempc6SdTtvnKRdFsfLZQK3VPWV9wX/1dEzwu0iNSTobUeY3JAnSJ5x1IO0
        rxqKFJP/iXs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3EAE110C509;
        Tue,  9 Feb 2021 15:54:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7F5EB10C508;
        Tue,  9 Feb 2021 15:54:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Hariom verma <hariom18599@gmail.com>,
        Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 3/3] ref-filter: use pretty.c logic for trailers
References: <pull.726.v3.git.1612602945.gitgitgadget@gmail.com>
        <47d89f872314cad6dc6010ff3c8ade43a70bc540.1612602945.git.gitgitgadget@gmail.com>
        <xmqqpn1c8m7u.fsf@gitster.c.googlers.com>
        <CA+CkUQ9-OCiEkMDRTpyF3rp-g1mSSzn4s9MgqJZ2BJY=XJCoEw@mail.gmail.com>
        <xmqqh7mn91w2.fsf@gitster.c.googlers.com>
        <CA+CkUQ9kHhbDVMru=pRO90o+k7cc_ykxN9JRFGMvoG3hkeGJpA@mail.gmail.com>
        <xmqqlfbz7i7i.fsf@gitster.c.googlers.com>
        <CA+CkUQ_cdUmuP+_yUeCytn=6cc8SjMBE1aTLzWJL-U_V01uzog@mail.gmail.com>
        <xmqqv9b25s7f.fsf@gitster.c.googlers.com>
        <xmqqlfby5o9h.fsf@gitster.c.googlers.com>
        <YCH71+ck1Wmk1Css@camp.crustytoothpaste.net>
Date:   Tue, 09 Feb 2021 12:54:14 -0800
In-Reply-To: <YCH71+ck1Wmk1Css@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Tue, 9 Feb 2021 03:04:55 +0000")
Message-ID: <xmqqh7ml0xop.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F8F86006-6B18-11EB-9182-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I'll send out a fixed patch tomorrow, but for the moment, here's the
> gist of the change if you want to an immediate fix to squash in:
>
> ------- %< ---------
> diff --git a/ref-filter.c b/ref-filter.c
> index e6c8106377..5f8a443be5 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1344,8 +1344,8 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
>  		} else if (atom->u.contents.option == C_BARE)
>  			v->s = xstrdup(subpos);
>  
> -		free((void *)sigpos);
>  	}
> +	free((void *)sigpos);
>  }

Ah, I see.  find_subpos() will only called once to find the subject
and signature in the loop, and the finding will have to live even
the current iteration of the loop is done, only to be released after
everything is done.

Makes sense.
