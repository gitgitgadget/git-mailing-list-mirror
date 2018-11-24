Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47BB81F97E
	for <e@80x24.org>; Sat, 24 Nov 2018 04:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731261AbeKXPEv (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Nov 2018 10:04:51 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62795 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731111AbeKXPEv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Nov 2018 10:04:51 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A5065126F61;
        Fri, 23 Nov 2018 23:17:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=KZa9KBBogAen
        IGg8reSCYsHTX+o=; b=pQzWIza/hRT6QBMTAG6u0te5S3RfeJLgHqKgkwWeKyqw
        BaRIZRMvoiaIQxcCpHqbO9je4hpv+/aR++lWFwLnbjPKqnDVwhvvc4L88zEsdfdG
        7fqHIYAbsDlz/uk23ymGAOifTkyp4QJxNS958w9MoZ/fjk+STgauwebFW97tYpc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Bub5o/
        5EC4MF9YIUg35gE0O96c5fThtLqJFgGqi5bh7KERFg8IKafkYaY1blZkFhabxSI2
        Z3IZWCZ532LVmQzlnphTpmFoTZlLm4wjAmK28ebjM7Na13fUU2hWD5RRqqIyJjRd
        EPSDgmQH5vL2y82M4gQMusWtqvq57GjDh/4cE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9D780126F60;
        Fri, 23 Nov 2018 23:17:54 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D0B6A126F5F;
        Fri, 23 Nov 2018 23:17:53 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] format-patch: don't include --stat with --range-diff output
References: <CAPig+cSzyT5N5=YeX+VgRq1t0VbWqXLHSB=g=V=O-nLdCWrE9g@mail.gmail.com>
        <20181122211248.24546-3-avarab@gmail.com>
        <xmqqa7lz43d8.fsf@gitster-ct.c.googlers.com>
Date:   Sat, 24 Nov 2018 13:17:49 +0900
In-Reply-To: <xmqqa7lz43d8.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Sat, 24 Nov 2018 11:26:59 +0900")
Message-ID: <xmqqk1l32jo2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E9F39FD6-EF9F-11E8-9DB4-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>>  	if (rev->rdiff1) {
>> +		struct diff_options opts;
>> +		memcpy(&opts, &rev->diffopt, sizeof(opts));
>> +		opts.output_format &=3D ~(DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_SUMMAR=
Y);
>> +
>>  		fprintf_ln(rev->diffopt.file, "%s", rev->rdiff_title);
>>  		show_range_diff(rev->rdiff1, rev->rdiff2,
>> -				rev->creation_factor, 1, &rev->diffopt);
>> +				rev->creation_factor, 1, &opts);
>
> I am not quite convinced if this shallow copy is a safe thing to do.
> Quite honestly at this late in the release cycle, as a band-aid, I'd
> rather see a simpler revert than a change like this that we have to
> worry about what happens if/when show_range_diff() _thinks_ it is
> done with the opts and ends up discarding resources (e.g. "FILE *")
> that are shared with rev->diffopt that would still have to be used
> later.

Well, let's take it anyway as-is, at least for today, as I notice
show_range_diff() itself does another shallow copy, so we are not
making anything dramatically worse.

Thanks.
