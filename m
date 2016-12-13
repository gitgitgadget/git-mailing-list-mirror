Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F10A71FF40
	for <e@80x24.org>; Tue, 13 Dec 2016 06:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751974AbcLMGjj (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 01:39:39 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62325 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750929AbcLMGji (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 01:39:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 336F955E47;
        Tue, 13 Dec 2016 01:39:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=aZ8CvEIyFm88
        79XzM2SCMJ0IYhk=; b=NkbY6XjtEz3o6aVnkIL/2fQnIar9lmFiwQBD/ra5zMJ8
        zms/NAU1yYsuBagBW0c7AzohPJ1SUzDcSrPLN+C3OTvyt0Vl1iEpyJbWX1yu6swv
        GrcmxwS2DQLh6i57yVwQ+t1rmSQuTDgIWMuNJmRoKWpq5CG3LCPxGbRIn/mVG4o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Ce8Fyx
        lf9I9nb49/aTU9gNr/0zrWAw+kFwVj4iGkaRTSfKWu6vK2ZBWMKIr8uiOr0FzoKL
        PNI5Oy5kmcx8p0H6jR60G+bkphCbfq0TMZ+aY+QL/BAsSHGLN3AF0DDeQm4uEh4G
        BTc6bkkGRQsMOdDPyjmKU6PSl8yEO5EvtWTL0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2C88655E46;
        Tue, 13 Dec 2016 01:39:37 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A703F55E45;
        Tue, 13 Dec 2016 01:39:36 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Leho Kraav <leho@conversionready.com>, git@vger.kernel.org
Subject: Re: [PATCHv2 5/7] versioncmp: cope with common part overlapping with prerelease suffix
References: <20161005033353.Horde.33pf2naqnF4HgwPWSy9DaHV@webmail.informatik.kit.edu>
        <20161208142401.1329-1-szeder.dev@gmail.com>
        <20161208142401.1329-6-szeder.dev@gmail.com>
        <xmqqshps96ti.fsf@gitster.mtv.corp.google.com>
        <CAM0VKjnPdt3keodXRFNit9=WKeY330N4T2t_dJuArgch7L6BNg@mail.gmail.com>
Date:   Mon, 12 Dec 2016 22:39:35 -0800
In-Reply-To: <CAM0VKjnPdt3keodXRFNit9=WKeY330N4T2t_dJuArgch7L6BNg@mail.gmail.com>
        ("SZEDER =?utf-8?Q?G=C3=A1bor=22's?= message of "Tue, 13 Dec 2016 01:27:35
 +0100")
Message-ID: <xmqqbmwg72oo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EA54CC06-C0FE-11E6-86F8-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

>>> -             if (i1 =3D=3D -1 && starts_with(s1 + off, suffix))
>>> -                     i1 =3D i;
>>> -             if (i2 =3D=3D -1 && starts_with(s2 + off, suffix))
>>> -                     i2 =3D i;
>>> +             int j, start, suffix_len =3D strlen(suffix);
>>> +             if (suffix_len < off)
>>> +                     start =3D off - suffix_len + 1;
>>> +             else
>>> +                     start =3D 0;
>>
>> Now that this function has to rewind the beginning of the comparison
>> earlier than the given 'off', it makes me wonder if it still makes
>> sense for the caller to compute it in the first place.
>
> The caller has to compute it anyway, because it must deal with all the
> cases when the two compared tagnames are not reordered based on their
> (prerelease)suffix.

Sure.
