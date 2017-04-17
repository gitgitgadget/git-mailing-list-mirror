Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90C8820D09
	for <e@80x24.org>; Mon, 17 Apr 2017 00:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757167AbdDQAvj (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 20:51:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62481 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757160AbdDQAvi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 20:51:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2CCA38AE77;
        Sun, 16 Apr 2017 20:51:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=cJ/VU7arw4mc
        9mL1kmPLpsndUfc=; b=QbpC3GvF9hidCybnVR2QJgasPf0D6ihL5eJzC8ubIC6m
        ZaryoCd22P6IpVyaJ69rwVjix8Q+3BlcJWjCfy3Alpkw+c6wjCAM5/9pd4ztftw4
        jsroZejSWljQjOwXCXCg76QI7LCsYnbYxkwFX8zevv7HGYe3gjcje4bf2yp4KwE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=b7a6Us
        yhVKeuW/T7dzm6sxsCmNiuPtTTBKNcRHJnsNeaEbAf6OUcVUEaB7TRPn1ujkuV/V
        coIO7OkcvafwHnS8TnuviystB8PJQkSiT13qfv3be3XTLN8SLskSkQ3gXE0EJAW3
        yFOQq95zg7H+w/8hlB3YGQUm0mAv7ReVcEDv0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 23B238AE76;
        Sun, 16 Apr 2017 20:51:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 90E688AE75;
        Sun, 16 Apr 2017 20:51:36 -0400 (EDT)
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
Date:   Sun, 16 Apr 2017 17:51:35 -0700
In-Reply-To: <CACBZZX5SooaEjLSy-dTRF-Aa2EnH8S2hS+w40mPTUOvonBNPDg@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 11 Apr
 2017 13:06:10
        +0200")
Message-ID: <xmqqefwrluug.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0275E282-2308-11E7-B02F-C260AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> That's fine by me. We may want to pick up the segfault one separately
>> (though I don't think it's security-interesting).
>
> Up to you, but in case it's less work for you & Junio I already have
> it in my branch of fallout from this series/discussion, so if it's
> easier for you/Junio I can submit it, and it would save my a tiny bit
> of work since I could just base on master instead of some other
> in-flight patch.

Sure, with existing backlog I probably won't get around to it before
you have a clean series anyway.  It may not be a bad idea to base
the patches on 'maint', though, if possible.

Thanks.
