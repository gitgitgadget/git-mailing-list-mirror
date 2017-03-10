Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9875C1FBEC
	for <e@80x24.org>; Fri, 10 Mar 2017 16:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932818AbdCJQp2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 11:45:28 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60202 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932712AbdCJQp1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 11:45:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 512726653A;
        Fri, 10 Mar 2017 11:45:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=TuSNp+m4b+Qh
        tlDp4UY5Iu6m1uk=; b=mjPSDmVG8HnT3WG9AHZYGpsbvFlcyyQu/Hs7tAB5/YMD
        V6jgQpoG1W3YSaM1G8dcJca0fyZniBMgitYWETM6wcOfQjvq1xRQGXI+wf7VIRRk
        nRz83yG4iAKG0ekVAW6eSEaRFeoRR1Dvt2nCkj9Hw8dvbjhZYkrTt1MHTBJBTds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=QHzogD
        y4QO1aYLCBDGF0i9pOFwsSQro5KeANNqqHGimR35cKQklNY+8ALt4f3k2FdvLoW5
        rxx9S2Hr9M392OQ0zD48E0AelEu+HpYXu/bPU9yyM5wfOjGgoeIl1jm4Vute3IPi
        91natW3E1o0tZXssPIuoJ/5FE6zmknHx6c2lY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4988766539;
        Fri, 10 Mar 2017 11:45:25 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9D30A66538;
        Fri, 10 Mar 2017 11:45:24 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
        Guillaume Wenzek <guillaume.wenzek@gmail.com>
Subject: Re: [PATCH] branch: honor --abbrev/--no-abbrev in --list mode
References: <CAAvNd=ir1qNQVaKphdg51AfGnsNgTrfvW2L6cca3SHiZrWNgHA@mail.gmail.com>
        <xmqqlgsf39fg.fsf@gitster.mtv.corp.google.com>
        <xmqqzigv1lc3.fsf@gitster.mtv.corp.google.com>
        <xmqqvarj1kix.fsf_-_@gitster.mtv.corp.google.com>
        <4d09ad56-96ac-75d3-c9df-0c23b805b478@gmail.com>
Date:   Fri, 10 Mar 2017 08:45:23 -0800
In-Reply-To: <4d09ad56-96ac-75d3-c9df-0c23b805b478@gmail.com> ("Jakub
        =?utf-8?Q?Nar=C4=99bski=22's?= message of "Thu, 9 Mar 2017 14:25:08 +0100")
Message-ID: <xmqqinnhytb0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F556A362-05B0-11E7-BBCA-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> W dniu 08.03.2017 o 23:16, Junio C Hamano pisze:
> =20
>> diff --git a/builtin/branch.c b/builtin/branch.c
>> index cbaa6d03c0..537c47811a 100644
>> --- a/builtin/branch.c
>> +++ b/builtin/branch.c
>> @@ -335,9 +335,18 @@ static char *build_format(struct ref_filter *filt=
er, int maxwidth, const char *r
>>  		    branch_get_color(BRANCH_COLOR_CURRENT));
>> =20
>>  	if (filter->verbose) {
>> +		struct strbuf obname =3D STRBUF_INIT;
>> +
>> +		if (filter->abbrev < 0)
>> +			strbuf_addf(&obname, "%%(objectname:short)");
>> +		else if (!filter->abbrev)
>> +			strbuf_addf(&obname, "%%(objectname)");
>> +		else
>> +			strbuf_addf(&obname, " %%(objectname:short=3D%d) ", filter->abbrev=
);
>                                               ^                       ^
> I wonder why the last one has leading space --/ and trailing one -----/
> The rest (for default abbrev and for no abbrev do not).

Thanks for spotting; that's just an editor cruft that shouldn't have
been there.


