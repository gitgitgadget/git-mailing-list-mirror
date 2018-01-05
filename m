Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25E2E1F428
	for <e@80x24.org>; Fri,  5 Jan 2018 23:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752928AbeAEXXA (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 18:23:00 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56682 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752612AbeAEXW7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 18:22:59 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E4B6CC063;
        Fri,  5 Jan 2018 18:22:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=udqfJpWXmOKWN0NV6mbZvBCjq
        0Q=; b=FCE9P5zl1zWTFJ1GHmuZ4XNx9YifQiU0+32TcDkOXbkgOcZmZC8DNM9Rk
        XjufsEE2F4HBAKFdM4dcAxfdBsAAPhRo6j05/rW/zbZPbpW42n9VYhPRVaNz+shz
        /n24vCMkg4aMuA5GzNTVd748rlf+U39rAMzRCPNdhdSQ00ksEs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=Mrzm2/pBguLeKg1HhCT
        24vNzkZYwW+DRCg5WDS+s/hjW4s6YZ2DvB+orAiyjNtR8hOhxVl66nzKJwDlU0Zc
        T9CWBCAhyf8DTBMEgzRKpQFyKH9C8xtVAPVU8L6VP8zL0C11Uwigd2qpRDOgGkme
        pY4OVJPKhS2sNnIbSPnR8tfQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 94BADCC062;
        Fri,  5 Jan 2018 18:22:58 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DC251CC061;
        Fri,  5 Jan 2018 18:22:57 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     tboegi@web.de, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>, lars.schneider@autodesk.com,
        git@vger.kernel.org, patrick@luehne.de
Subject: Re: [PATCH 1/5] convert_to_git(): checksafe becomes an integer
References: <20171229152222.39680-1-lars.schneider@autodesk.com>
        <20171231080552.22258-1-tboegi@web.de>
        <96B6CD4C-0A0C-47F5-922D-B8BAFB832FD1@gmail.com>
Date:   Fri, 05 Jan 2018 15:22:56 -0800
Message-ID: <xmqqincfao1b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5D5F4B02-F26F-11E7-9044-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> On 31 Dec 2017, at 09:05, tboegi@web.de wrote:
>>=20
>> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>>=20
>> When calling convert_to_git(), the checksafe parameter has been used t=
o
>> check if commit would give a non-roundtrip conversion of EOL.
>>=20
>> When checksafe was introduced, 3 values had been in use:
>> SAFE_CRLF_FALSE: no warning
>> SAFE_CRLF_FAIL:  reject the commit if EOL do not roundtrip
>> SAFE_CRLF_WARN:  warn the user if EOL do not roundtrip
>
> In general, I really like the direction as this simplifies
> my patch later on in 5/5. However, I see a few problems:
> ...

Yes, this looks like a sensible way to go.  I saw Torsten's v3 for
1/5 but will end up queuing v2b, as I suspect 5/5 would need to be
adjusted for the change between the two versions.

Thanks.
