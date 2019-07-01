Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 918B81F461
	for <e@80x24.org>; Mon,  1 Jul 2019 21:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfGAVbz (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 17:31:55 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52207 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfGAVbz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 17:31:55 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E16F76DBF6;
        Mon,  1 Jul 2019 17:31:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=xtYkh4aKcENz
        Jk/XTMqqQ3LrMKI=; b=bX5IDmvPPOtIEp/ONN1squfHin8DXGinPBwEmQaGGmpF
        8S0tnzCJSBD19X9Ha8vjgF5qDHtZO2ZegdIfGDZen1riCHsHeuLh56Jsv1MxWV6G
        z49t7kq4uWeqVOQBEbZaIughdm+M9jm/stfPAatghVuhsU/UVcwJu2A0vN6x9uM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=vl043V
        LAIIJQpdW56gS2/QiiGqczIKUKvO7yfxJB9fmNN4LM9nDfJh6jDnMmq+AIDX+PIx
        876tOPFIntNmkPtydkZPVuhr+DJSJwFspgScVm1ZNQ2SN02wiRX5FdkBQ0nsrfx1
        6uybXnOMLn4QTI2hiwG4RTbQYs5A+K1uqYUG4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D7A796DBF5;
        Mon,  1 Jul 2019 17:31:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0F6986DBF3;
        Mon,  1 Jul 2019 17:31:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, git-packagers@googlegroups.com,
        gitgitgadget@gmail.com, johannes.schindelin@gmx.de, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com
Subject: Re: [PATCH v3 00/10] grep: move from kwset to optional PCRE v2
References: <20190627233912.7117-1-avarab@gmail.com>
        <20190701212100.27850-1-avarab@gmail.com>
Date:   Mon, 01 Jul 2019 14:31:49 -0700
In-Reply-To: <20190701212100.27850-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 1 Jul 2019 23:20:50 +0200")
Message-ID: <xmqqef395tmi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A4129A12-9C47-11E9-8F4F-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This v3 has a new patch (3/10) that I believe fixes the regression on
> MinGW Johannes noted in
> https://public-inbox.org/git/nycvar.QRO.7.76.6.1907011515150.44@tvgsbej=
vaqbjf.bet/
>
> As noted in the updated commit message in 10/10 I believe just
> skipping this test & documenting this in a commit message is the least
> amount of suck for now. It's really an existing issue with us doing
> nothing sensible when the log/grep haystack encoding doesn't match the
> needle encoding supplied via the command line.

Is that quite the case?  If they do not match, not finding the match
is the right answer, because we are byte-for-byte matching/searching
IIUC.

> We swept that under the carpet with the kwset backend, but PCRE v2
> exposes it.

Is it exposing, or just showing the limitation of the rewritten
implementation where it cannot do byte-for-byte matching/searching
as we used to be able to?

Without having a way to know what encoding is used on the command
line, there is no sensible way to reencode them to match the
haystack encoding (even when it is known), so "you got to feed the
strings in the same encoding, as we are going to match/search
byte-for-byte" is the only sensible way to work, given the design
space, I would think.

Not that it is all that useful to be able to match/search
byte-for-byte, of course, so I am OK if we punt with these tests,
but I'd prefer to see us admit we are punting when we do ;-).




