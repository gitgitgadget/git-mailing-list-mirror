Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A71F120958
	for <e@80x24.org>; Thu, 23 Mar 2017 19:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752086AbdCWTkj (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 15:40:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60113 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751349AbdCWTki (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 15:40:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C2D7659C9;
        Thu, 23 Mar 2017 15:40:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ShgyXVuunU7U
        QU1GyTTsSpQA3L8=; b=ebnEIbZFpi3l31PdYSMkHmp6w4vGy47B0fhjXrAnIywT
        uz0dwskd3/BxqGPESNOBsZ9Coybsys5XvAVlor9oc5fcOcUsBjEYT+K2VvQnCnID
        TMPRar5LAe5Axf/av+GOIK0bjComgTL6OBPedJ0JUvIhRqC+anwcv5PL9wjCAfc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=k1JYWw
        fItanwsPHyUlmM53PpNOwUVBAGr7kiDRJPGwgFbganLB1hVtSzMrkh0C/mu0oQiT
        PkkDfn2+tYbLSY+9aMV+Xcg1WAf6NSfwkuwN73mg6ujErzwpf79blI2DGmSMNGly
        NRR9XPm5EArjdQR7SuXFHbZm2qXNrcKpPlzgo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 960AE659C7;
        Thu, 23 Mar 2017 15:40:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1244C659C6;
        Thu, 23 Mar 2017 15:40:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] refs.c: use skip_prefix() in prettify_refname()
References: <20170323155012.6148-1-szeder.dev@gmail.com>
        <4382e211-63f6-811f-6f33-1cf5d2c087a8@web.de>
        <20170323192313.ytr56pjpnillnh63@sigill.intra.peff.net>
        <xmqqvaqzbxfx.fsf@gitster.mtv.corp.google.com>
        <4424eeeb-7eea-ed41-c031-ba7915cb93ab@web.de>
Date:   Thu, 23 Mar 2017 12:40:34 -0700
In-Reply-To: <4424eeeb-7eea-ed41-c031-ba7915cb93ab@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 23 Mar 2017 20:36:29 +0100")
Message-ID: <xmqqr31nbx3h.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 96022D82-1000-11E7-843B-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>> I think Ren=C3=A9 meant this:
>>
>>      /* just for side effects */
>>      skip_prefix(name, "refs/heads/", &name) ||
>>      skip_prefix(name, "refs/tags/", &name) ||
>>      skip_prefix(name, "refs/remotes/", &name);
>>
>>      return name;
>>
>> which still short-sircuits, even though I do think it looks
>> strange; "correct but strange".
>
> Yes.  At least to me it looks less strange than the same lines wrapped
> in "if ... /* nothing */".

Yup, after looking at it again, it does not look so "strange" to me.
I probably should have said "unusual but correct", not "correct but
strange".
