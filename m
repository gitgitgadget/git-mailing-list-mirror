Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892E2C2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 20:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE5B215A4
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 20:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ie3iaVnT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgAaUtm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 15:49:42 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57276 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgAaUtm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 15:49:42 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A2AC73C74E;
        Fri, 31 Jan 2020 15:49:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=aFOnMuvRBzqP
        BRs0wx9yfiJccFc=; b=Ie3iaVnT7SIByk06yRysUXF5JKZHx3cN3XeMstCcnnTJ
        btY9i7xBz9nkU9rBjukcHQXu+0FyLjcvU07tHDPFWbzx9/QjAVP2Uz/Qe5Ycc2ml
        EEmu2/xNhJhlCqnv9f5Ozi9dW7r4/DOleHzasWEkOXv8F2TrbBnd5uJHhBXoajM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=DILELy
        G948QrkiBfvK6LBuncpxRMdnjTi3f2fD1CEQSBqeCbLJ+1k7o0dblyxQbaSqESze
        a9YiVed4dPErIhhI9fCvZXl302qwWbLr/HI2EatrzNpr3yuhlKvrFNnkeX2zlqli
        kVl+PpHfH4NW2Gir8EKOpA8CUXsvRthfdz4CM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 970613C74D;
        Fri, 31 Jan 2020 15:49:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 079D23C74B;
        Fri, 31 Jan 2020 15:49:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 2/6] commit-graph.h: store object directory in 'struct commit_graph'
References: <cover.1580424766.git.me@ttaylorr.com>
        <890e0e7136204f5ca47f0703f32b4adb99ad8d7e.1580424766.git.me@ttaylorr.com>
        <CAN0heSrrrWjBKnzjMfzEkTMVTge2AfVdwsp6D5Mx==5S8-ZLJQ@mail.gmail.com>
Date:   Fri, 31 Jan 2020 12:49:37 -0800
In-Reply-To: <CAN0heSrrrWjBKnzjMfzEkTMVTge2AfVdwsp6D5Mx==5S8-ZLJQ@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Fri, 31 Jan 2020 07:52:02
 +0100")
Message-ID: <xmqqftfv9wri.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 32AAB1DA-446B-11EA-9CD5-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

>> +               struct object_directory *odb;
>> +               if ((odb =3D find_odb(the_repository, opts.obj_dir)))
>> +                       graph =3D read_commit_graph_one(the_repository=
, odb);
>> +       }
>
> I'm a tiny bit allergic to this assignment-within-if. It's wrapped by
> another pair of parentheses, which both compilers and humans know to
> interpret as "trust me, this is not a mistake", but I still find this
> easier to read:
>
>   odb =3D find_odb(...);
>   if (odb)
>           ....

Yup.
