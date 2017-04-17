Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F0E920D09
	for <e@80x24.org>; Mon, 17 Apr 2017 00:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757095AbdDQAyG (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 20:54:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64678 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757051AbdDQAyF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 20:54:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8FE768ABDB;
        Sun, 16 Apr 2017 20:54:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=kL1S8bHi2KDS
        dMRifQbGyLkPOhc=; b=RlK63ebD3SS9k/ngoDZeMhR2q0m92d4CnUEKlB2eXHP1
        K6RFXCsaHie8uYZ/XOctDWLjHFmqA5qrGqgQY7kOVYoEXLeJj9PTos4/AugxsyHy
        MDx6sQxb09wzesj0LXfWvRoE4g1gA0LvwuuM3P/G7Upxw0eIFsh4vesHrUEAf90=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=G/WmTS
        O48yVxIsj9VUBLkXiHz1q7gIsxT/Q4yKuvhYIuRI1yBCatVkEdAMg55SqpynWPNC
        ahRIzynrUhSs68AiHKP4HR28IB4o5IdRooMufO6W+RchHlUdFkbi9e5vh7kwZrEv
        1r6GoiGiVu+w4WGwUPO6FC6BxgJuqIbKtaQqg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 88DB88ABDA;
        Sun, 16 Apr 2017 20:54:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E4F4D8ABD7;
        Sun, 16 Apr 2017 20:54:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Joachim Durchholz <jo@durchholz.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] connect.c: handle errors from split_cmdline
References: <20170409191117.25175-1-avarab@gmail.com>
        <20170409191117.25175-3-avarab@gmail.com>
        <CACBZZX7OfM-zivJAQMXdNarHDjAhzQhqGNZNs2QqDUyOo3AA0g@mail.gmail.com>
        <20170411003023.ynzc76yzdmomxthp@sigill.intra.peff.net>
        <20170411003554.2tjnn65vfco376kj@sigill.intra.peff.net>
        <CACBZZX4LxL_ZBnFwkwXSMfBPGcKvOtHe3LeMtG9n2xRqWVZBkA@mail.gmail.com>
        <20170411105408.332krulfrbqqi42k@sigill.intra.peff.net>
        <CACBZZX5SooaEjLSy-dTRF-Aa2EnH8S2hS+w40mPTUOvonBNPDg@mail.gmail.com>
Date:   Sun, 16 Apr 2017 17:54:02 -0700
In-Reply-To: <CACBZZX5SooaEjLSy-dTRF-Aa2EnH8S2hS+w40mPTUOvonBNPDg@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 11 Apr
 2017 13:06:10
        +0200")
Message-ID: <xmqqa87fluqd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5A5250D0-2308-11E7-913D-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, Apr 11, 2017 at 12:54 PM, Jeff King <peff@peff.net> wrote:
>> On Tue, Apr 11, 2017 at 11:27:57AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>>
>>> Junio: If you're not in some rush to pick this up I'll take this, fix
>>> up a bunch of other bugs & tests failures on odd --root directories
>>> and submit this and Jeff's \r patch (after adding tests etc) along
>>> with it.
>>
>> That's fine by me. We may want to pick up the segfault one separately
>> (though I don't think it's security-interesting).

This one cleanly applied on top of sf/putty-w-args, so I'll queue it
there without introducing a new "jk/fix-something" topic.  That way,
even when sf/putty-w-args were to be merged to older maintenance
track, this fix will also be there as well.

Thanks.
