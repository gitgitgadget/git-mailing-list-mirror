Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D34CC11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58DA3613FE
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbhGAOUF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 10:20:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64595 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbhGAOUE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 10:20:04 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 52E82D3042;
        Thu,  1 Jul 2021 10:17:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=v+ayxcDtsVvS
        aVyuc70jvW99nGE/dYz1bnz/vWk6jPk=; b=nZ2HYB0QBJ0cbfHz4QkM0rmtDt7x
        QfbPeHIk9uWzeaEXNwhSspF1L3244i4+wszyEuer23S7xSBFZvJylhS5NTm6bAIf
        B2VjTMg170RbpCO4L61Bgo8D6zQdbvuPRZC9R+Wk2eXB0I801fbxZrMyKATGGQEx
        4HXY9Sn4v/sUOpM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 49CCED3040;
        Thu,  1 Jul 2021 10:17:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C4606D303F;
        Thu,  1 Jul 2021 10:17:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v6 00/15] [GSOC][RFC] cat-file: reuse ref-filter logic
References: <pull.980.v5.git.1624636945.gitgitgadget@gmail.com>
        <pull.980.v6.git.1624797350.gitgitgadget@gmail.com>
        <xmqqbl7nt3fh.fsf@gitster.g>
        <CAOLTT8S=qeg8QBhMU0fCc600n-qzJBT9P9LvhSVZaXpvsr0__Q@mail.gmail.com>
Date:   Thu, 01 Jul 2021 07:17:30 -0700
In-Reply-To: <CAOLTT8S=qeg8QBhMU0fCc600n-qzJBT9P9LvhSVZaXpvsr0__Q@mail.gmail.com>
        (ZheNing Hu's message of "Thu, 1 Jul 2021 20:39:18 +0800")
Message-ID: <xmqqtulerudh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 12EA222E-DA77-11EB-BEE0-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=881=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=886:04=E5=86=99=E9=81=93=EF=BC=9A
>>
>> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>> > This patch series make cat-file reuse ref-filter logic.
>>
>> Unfortunately this seems to interact with your own
>> zh/cat-file-batch-fix rather badly.
>>
>
> Well, it's because I didn't base this patch on it.
> That should be easy to achieve.

It is preferrable for contributors try merging their individual
topics with the rest of 'seen' to see if there are potential
conflicts (either textual or semantic) before sending their topics
out.  Not all topics need to build on top of other topics (in fact,
the fewer inter-dependencies they have, the better), but in this
case, I think it makes sense to build one on top of the other.

