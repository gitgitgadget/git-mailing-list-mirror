Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5302C20A40
	for <e@80x24.org>; Mon, 27 Nov 2017 04:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751180AbdK0Exh (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 23:53:37 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65064 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751126AbdK0Exg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 23:53:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F0767BC008;
        Sun, 26 Nov 2017 23:53:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EBL2b+1JIQ2KvqW5kzEujtUiwH8=; b=eF7qBk
        pBXUjwNYmGczNqsleMOmrVS3/Wx7Dq/OEqd/uTWKrz3SpNRL4bvEnVqHdBfvFR55
        qPyYDuXkTUcfS0OTzkZC3F3s3yLAHvjaHBGxMWX+NFYbcSqdRhIOds4fLAeqNV7S
        3lZxF+B7+db+sklEoffvGgheqL3l64giKouq4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ACkk6XAQTrhEZC7zxdPgLLeoBOKT6asY
        rzGLk3FNJzQXgiGXb9BgLmvCZNf406bvaOllnAFvfi/NZaspIS2x2CsgpEeSjGnQ
        PcxKlZBYiDbhR1Vua8x6SvgA37ft4/8mU3Ra/4vvZ3OR9bhW/w4amhZd/WEudWVi
        zit/+1SK6PM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E8281BC007;
        Sun, 26 Nov 2017 23:53:35 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 649D5BC006;
        Sun, 26 Nov 2017 23:53:35 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Takuto Ikuta <tikuta@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] Use OBJECT_INFO_QUICK to speedup git fetch-pack
References: <0102015ffbbb2905-570eadd1-6b5c-46af-a3a9-bddfbd01c242-000000@eu-west-1.amazonses.com>
        <xmqqo9noe3u0.fsf@gitster.mtv.corp.google.com>
        <20171127043740.GA5994@sigill>
Date:   Mon, 27 Nov 2017 13:53:34 +0900
In-Reply-To: <20171127043740.GA5994@sigill> (Jeff King's message of "Sun, 26
        Nov 2017 23:37:40 -0500")
Message-ID: <xmqqk1yce301.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ECE1E574-D32E-11E7-8CC2-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> cf. https://public-inbox.org/git/20171120202920.7ppcwmzkxifywtoj@sigill.intra.peff.net/
>
> It's funny that we'd get two patches so close together. AFAIK the
> slowness here has been with us for years, and I just happened to
> investigate it recently.
>
>> The 5-patch series that contains the same change as this one is
>> cooking and will hopefully be in the released version before the end
>> of the year.
>
> I'd be curious if the 5th patch there provides an additional speedup for
> Takuto's case.

Indeed, it is a very good point.

IIUC, the 5th one is about fetching tons of refs that you have never
seen, right?  If a repository that has trouble with everything-local
is suffering because it right now has 300k remote-tracking branches,
I'd imagine that these remote-tracking branches are being added at a
considerable rate, so I'd not be surprised if these "new" refs
benefits from that patch.  And it would be nice to know how much a
real life scenario actually does improve.

Thanks.
