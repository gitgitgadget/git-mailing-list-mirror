Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A023D1FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 21:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754167AbcH2VNV (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 17:13:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51058 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751223AbcH2VNU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 17:13:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 79AA13A12E;
        Mon, 29 Aug 2016 17:13:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=PLLhqcPlUkAt
        FQGJOYQtCybvF1M=; b=Fpp9XS3QbcHjeA+ojjvTh90e3WrZRK4XYIZnqla12hFj
        42SuzWGleg+hFdoIVF9NDB0NF9NztS6uuE0pfYFLz19prsCi1F5cZqutr5wNJG7S
        s8LvDodgW9LPuM1tjih3fBYQBd1fzcKkZeRqMp65nuPaIjdn5EvONHL5WQMZ6JU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=c2ibQB
        tqirO/rt68vNjlJAWhQ3K0NgkK8OVMc1o80Qs6dWkrbt+ZvFDoL2boXadnQQXDGQ
        4MxbshRbgDIMPDBsla99Nuvu61MTqOdxE1fXPXFTINBZ2LBUmiTSGdfSu6Rz/OqN
        kIo3/RMa5tsey8kcnNLgh3IVZGm5W0UlIfG/s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 70E223A12D;
        Mon, 29 Aug 2016 17:13:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EFEA93A12A;
        Mon, 29 Aug 2016 17:13:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 20/22] sequencer: remember do_recursive_merge()'s return value
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
        <1f79d41e3417a0b1f0cffccc40e97f1a2c5ef987.1472457609.git.johannes.schindelin@gmx.de>
        <99fd1126-53d1-36e4-facd-7e18ba06e3c0@gmail.com>
Date:   Mon, 29 Aug 2016 14:13:16 -0700
In-Reply-To: <99fd1126-53d1-36e4-facd-7e18ba06e3c0@gmail.com> ("Jakub
        =?utf-8?Q?Nar=C4=99bski=22's?= message of "Mon, 29 Aug 2016 22:32:40
 +0200")
Message-ID: <xmqqlgzf8ej7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 68AA2440-6E2D-11E6-ACB1-F7BB12518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> W dniu 29.08.2016 o 10:06, Johannes Schindelin pisze:
>
>> diff --git a/sequencer.c b/sequencer.c
>> index 5ec956f..0614b90 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -623,7 +623,7 @@ static int do_pick_commit(enum todo_command comman=
d, struct commit *commit,
>>  	const char *base_label, *next_label;
>>  	struct commit_message msg =3D { NULL, NULL, NULL, NULL };
>>  	struct strbuf msgbuf =3D STRBUF_INIT;
>> -	int res, unborn =3D 0, allow;
>> +	int res =3D 0, unborn =3D 0, allow;
>
> Not that I am against this part of change, making initialization
> explicit, but why we are initializing automatic variables with 0,
> which would be the default value anyway?

Because an on-stack "auto" begins its life with an undefined value,
unlike a file-scope static (and global variables) that can be in BSS
segment.

> I thought our coding
> guidelines discourage initializing with 0 or NULL...

You are confused between the two, I am afraid.

