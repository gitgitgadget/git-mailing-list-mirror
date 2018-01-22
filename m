Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E28F1F404
	for <e@80x24.org>; Mon, 22 Jan 2018 22:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751077AbeAVWgG (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 17:36:06 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64501 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750996AbeAVWgF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 17:36:05 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 31E1FD7F28;
        Mon, 22 Jan 2018 17:36:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=sh4NQM2Bi/sK
        yJXaguraoAA4Fgk=; b=cK4/xF9S7+J0GKT38q6iU9mUhLZNsqz75q90i/+APlDn
        EWMbsCFUczdpeTJ++3Z0YIOIUjYDQEs1GZ4y6jPE0J0wLdQUjxWpLb0TLoZ5ugW+
        NCYtfvGFPugrf1BNzadcufDoSH5EU2hqX/S1CSW0bg8FeZawQyAHzPxNM3xEldo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ny/u51
        /ofYi5GhtRQmM23rwfGpcU2agJ3NhW1akw9jGccfiV2529JXWftyMNMFp9lWh8VK
        1JihjBlu4uKwX5oEcFtuOXzMoFxaU9Kez8U9zBNZ+85sTHJUWI4Bqp6BtRTUqiMC
        UmkGw0DLaPPE26UMKTwWxkT4WVUGq2tZntXGc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 28B8AD7F27;
        Mon, 22 Jan 2018 17:36:05 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 95EC6D7F26;
        Mon, 22 Jan 2018 17:36:04 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     randall.s.becker@rogers.com, git@vger.kernel.org,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v2 0/6] Force pipes to flush immediately on NonStop platform
References: <20180119173406.13324-1-randall.s.becker@rogers.com>
        <20180120111012.GA26459@tor.lan>
Date:   Mon, 22 Jan 2018 14:36:03 -0800
In-Reply-To: <20180120111012.GA26459@tor.lan> ("Torsten =?utf-8?Q?B=C3=B6g?=
 =?utf-8?Q?ershausen=22's?=
        message of "Sat, 20 Jan 2018 12:10:12 +0100")
Message-ID: <xmqqshaxjzcc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A18066E2-FFC4-11E7-93DB-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On Fri, Jan 19, 2018 at 12:33:59PM -0500, randall.s.becker@rogers.com w=
rote:
>> From: "Randall S. Becker" <rsbecker@nexbridge.com>
>>=20
>> * wrapper.c: called setbuf(stream,0) to force pipe flushes not enabled=
 by
>>   default on the NonStop platform.
>>=20
>> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
>> ---
>>  wrapper.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>=20
>> diff --git a/wrapper.c b/wrapper.c
>> index d20356a77..671cbb4b4 100644
>> --- a/wrapper.c
>> +++ b/wrapper.c
>> @@ -403,6 +403,9 @@ FILE *xfdopen(int fd, const char *mode)
>>  	FILE *stream =3D fdopen(fd, mode);
>>  	if (stream =3D=3D NULL)
>>  		die_errno("Out of memory? fdopen failed");
>> +#ifdef __TANDEM
>> +	setbuf(stream,0);
>> +#endif
>
> Reading the commit message, I would have expected someting similar to
>
> #ifdef FORCE_PIPE_FLUSHES
> 	setbuf(stream,0);
> #endif
>
> (Because other systems may need the tweak as well, some day)
> Of course you need to change that in the Makefile and config.mak.uname

I actually wouldn't have expected anything like that after reading
the commit message. =20

First I thought it was describing only what it does (i.e. "let's use
setbuf() to set the stream unbuffered on TANDEM"), which is a
useless description that only says what it does which we can read
from the diff, but "NonStop by default creates pipe that does not
flush" is a potentially useful information the log message adds.
But it is just "potentially"---we cannot read what exact problem the
change is trying to address.  Making a pipe totally unbuffered is a
heavy hammer that may not be an appropriate solution---it could be
that we are missing calls to fflush() where we need and have been
lucky because most of the systems we deal with do line-buffered by
default, or something silly/implausible like that, and if that is
the case, a more proper fix may be to add these missing fflush() to
right places.

IOW, I do not see it explained clearly why this change is needed on
any single platform---so "that issue may be shared by others, too"
is a bit premature thing for me to listen to and understand, as
"that issue" is quite unclear to me.
