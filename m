Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E67C433F5
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 17:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E668261057
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 17:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349916AbhICRul (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 13:50:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54876 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349713AbhICRuk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Sep 2021 13:50:40 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E059AE8B4D;
        Fri,  3 Sep 2021 13:49:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=OVW0tB7w3E4e
        9rpy7L+CA1wgX9WSGOVu0uEtcVf0E8U=; b=X0PDCEy0TQ6zMap0PHrF4obR41gw
        lTXAuRwEyYDFN0Ub0CPFERyu7U7YKD68V4q+ka/pyuEO+7yRJwyZ0auraOfIYzDu
        CWQFur8h8a+HxNgWwwaYaSdAEmhpQsItxG8FC+lh1WALAT7B5hE+Oxbf0nNPdrZC
        FL4hJbiwYoH6lRM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D88C2E8B4C;
        Fri,  3 Sep 2021 13:49:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 58289E8B4B;
        Fri,  3 Sep 2021 13:49:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 10/15] scalar: implement the `run` command
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
        <c3f16bccd023601bb1d041c36cf5f49011abcb76.1630359290.git.gitgitgadget@gmail.com>
        <877dg2xbjp.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2109031747290.55@tvgsbejvaqbjf.bet>
Date:   Fri, 03 Sep 2021 10:49:38 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2109031747290.55@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 3 Sep 2021 17:50:16 +0200 (CEST)")
Message-ID: <xmqqk0jxft1p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4F912390-0CDF-11EC-BCDF-ECFD1DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi =C3=86var,
>
> On Tue, 31 Aug 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> On Mon, Aug 30 2021, Derrick Stolee via GitGitGadget wrote:
>>
>> > +	const char *usagestr[] =3D { NULL, NULL };
>>
>> Missing usage strings?
>
> This command will show a generated usage, i.e. a non-static string. It
> therefore cannot be specified here already. See the `strbuf_*()` calls
> populating `buf` and the `usagestr[0] =3D buf.buf;` assignment.
>
>> > +	if (argc =3D=3D 0)
>>
>> Style nit (per style guide): s/argc =3D=3D 0/!argc/g.
>
> It is true that we often do this, but in this instance it would be
> misleading: `argc` is a counter, not a Boolean.

That argument could be a plausible excuse to deviate from the style
if it were

	if (argc =3D=3D 0)
		do no args case;
	else if (argc =3D=3D 1)
		do one arg case;
	else if (argc =3D=3D 2)
		do two args case;
	...

Replacing the first one with "if (!argc)" may make it less readable.

But I do not think the reasoning applies here

	if (argc =3D=3D 0)
		do a thing that applies only to no args case;

without "else".  This is talking about "do we have any argument? Yes
or no?" Boolean here.

>> > +	if (!strcmp("all", argv[0]))
>> > +		i =3D -1;
>>
>> Style nit (per style guide): missing braces here.
>
> The style guide specifically allows my preference to leave single-line
> blocks without curlies.

Actually, the exception goes the other way, no?

We generally want to avoid such an unnecessary braces around a
single statement block.  But when we have an else clause that has a
block with multiple statements (hence braces are required), as an
exception, the guide asks you to write braces around the body of the
if side for consistency.

When you only have just a couple of lines on the "else {}" side, I
do not think it matters too much either way for readability, though.
I cannot see the "else" side in the above clause, but IIRC it wasn't
just a few lines, was it?

Thanks.
