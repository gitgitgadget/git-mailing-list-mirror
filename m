Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93720207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 21:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934184AbcI2VT7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 17:19:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53160 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933484AbcI2VT5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 17:19:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B1EDE42C30;
        Thu, 29 Sep 2016 17:19:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ffqfFAl59qNDrLIJ5n3JHIrrXJU=; b=GomAW3
        azJRAPbHcsvFIikWOP0SeLfTNtkkZqh0nSTYETm2e241rDeVG8zrBFilGyuDxXKZ
        AqhhvjQsMoB0ZWi+5Bn+w/zf/7AABKjj+uIECgjqWqiZN6QEGp3o3M2fBCeKIn5Y
        W7RwRc+pKEUItIB9YJ2/mHBhr0S7NwD/RDwhg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JlDb4cmWh7yTZstEHdsvZGprymW0Pm1l
        zehaVWlVrwnjlUkySDlYJteAuGMyrVMgkUcq/2L8tBy4lfe08R8m0Q5+eS5irpMJ
        JD70AGTeOeNY9H7qutBf6saVwPfvnp1TEwOBd/FATSLD93p30osuEoFSf3203xm2
        Tgszjj6iAII=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A8E4F42C2F;
        Thu, 29 Sep 2016 17:19:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0E89142C2E;
        Thu, 29 Sep 2016 17:19:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        ramsay@ramsayjones.plus.com
Subject: Re: [PATCH v8 00/11] Git filter protocol
References: <20160920190247.82189-1-larsxschneider@gmail.com>
        <xmqq8tubitjs.fsf@gitster.mtv.corp.google.com>
        <C2C9761E-986F-473D-BFB7-CBEF900D9FA3@gmail.com>
        <f7a4f828-bb1d-0ffa-e369-3b4fa476d9e5@web.de>
        <xmqqk2duhcdm.fsf@gitster.mtv.corp.google.com>
        <20160929180247.d4owhzwyawtanw3r@sigill.intra.peff.net>
Date:   Thu, 29 Sep 2016 14:19:53 -0700
In-Reply-To: <20160929180247.d4owhzwyawtanw3r@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 29 Sep 2016 14:02:48 -0400")
Message-ID: <xmqqa8eqe746.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 78308E66-868A-11E6-A9D1-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I don't necessarily agree, though, that the timing of filter-process
> cleanup needs to be part of the public interface. So in your list:
>
>>     3) Git waits until the filter process finishes.
>
> That seems simple and elegant, but I can think of reasons we might not
> want to wait (e.g., if the filter has to do some maintenance task and
> does not the user to have to wait).
>
> OTOH, we already face this in git, and we solve it by explicitly
> backgrounding the maintenance task (i.e., auto-gc). So one could argue
> that it is the responsibility of the filter process to manage its own
> processes. It certainly makes the interaction with git simpler.

Yup, that summarizes my thinking a lot better than I managed to do
in the previous message.

