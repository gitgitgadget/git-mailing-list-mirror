Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 361471F461
	for <e@80x24.org>; Tue,  2 Jul 2019 19:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfGBTaR (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 15:30:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63356 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfGBTaR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 15:30:17 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E58C714B08A;
        Tue,  2 Jul 2019 15:30:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jKTc98rCRqPejl+2gZvdE/ocHP8=; b=XhYwnh
        RNid/whvF3JX44m3sCFd6f3kxuhiYs/ZNmtikCy3hMC6LhUbqb9VbnPBelYCupw6
        b/RPAAmHbWmh1HET1n4pxcEGl9uaOs8UgrsMsgoFgJuT/jgxkOaG/7Wbq7Tovszp
        bBTiCm5HpfRNjKl6tmrYwtDnKz/ABesdaYARI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZB6T9mzD5ub+VyuNZGPpvUn+uAbOfEJi
        TP3JRYYahs58Y05GedLmw513WSTPVApPpW/jQckaiJuDf01DqKcLQqRY/voiDvv5
        r25e8wIcfvKJtRveGKrfQcGNqRdLhxazo6FWygu7NetzWrnDx9TZ6mp43uZItEDd
        +2Q62835vEw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DDF8F14B088;
        Tue,  2 Jul 2019 15:30:14 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 57EFC14B087;
        Tue,  2 Jul 2019 15:30:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v6] l10n: localizable upload progress messages
References: <20190702182248.5322-2-dimitriy.ryazantcev@gmail.com>
Date:   Tue, 02 Jul 2019 12:30:13 -0700
In-Reply-To: <20190702182248.5322-2-dimitriy.ryazantcev@gmail.com> (Dimitriy
        Ryazantcev's message of "Tue, 2 Jul 2019 21:22:48 +0300")
Message-ID: <xmqqsgro2q0q.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D0B6D2F0-9CFF-11E9-ADFD-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com> writes:

> -void strbuf_humanise_bytes(struct strbuf *buf, off_t bytes)
> +static void strbuf_humanise(struct strbuf *buf, off_t bytes,
> +				 int humanise_rate)
>  {
>  	if (bytes > 1 << 30) {
> -		strbuf_addf(buf, "%u.%2.2u GiB",
> +		strbuf_addf(buf,
> +				humanise_rate == 0 ?
> +					/* TRANSLATORS: IEC 80000-13:2008 gibibyte */
> +					_("%u.%2.2u GiB") :
> +					/* TRANSLATORS: IEC 80000-13:2008 gibibyte/second */
> +					_("%u.%2.2u GiB/s"),
>  			    (unsigned)(bytes >> 30),
>  			    (unsigned)(bytes & ((1 << 30) - 1)) / 10737419);

Thanks.  I guess that the previous attempt to make it more table
driven was probably a bit overkill, and because it did not quite
work well for Q_(), this would probably be the "good enough, let's
move on" optimal solution ;-)

Will queue.
