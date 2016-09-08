Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D13120705
	for <e@80x24.org>; Thu,  8 Sep 2016 18:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757452AbcIHSUS (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 14:20:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64285 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754888AbcIHSUR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 14:20:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 84E4D3D1D2;
        Thu,  8 Sep 2016 14:20:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=18gKxgjH4tNBQ0ZOz32bfQUMO3Q=; b=Etps7k
        mE7PIXXBVUxxw60iLwtmulR/I1dLeJhk8MczBiMuW/d4em3sQF50KoLsJH45tMlL
        /JABLtNlkoE5XARXjY5kp40OPu+oDZOiAMD2bfEu8ZyE20O1xV3x+Lnl0hKwz9TQ
        F18jxk0q32e8k7vnUpFlvjuJqREbN/7yOBi5M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IczHqGJfuLxV6aZum+G+Nen4S24lgM/T
        AOtvosn2oyrfe6SXEyfA652xjPm6I0tf1HjBA1kKaqaMAbHYVRGJKv4wNu8LVdo3
        O30qrFv0WdXWeA36+YWayRqQDeW05my3428GcUKhHXoz4ZJwI3QiATOUiiCYWZj4
        0zBjZOw3gC0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D46D3D1D1;
        Thu,  8 Sep 2016 14:20:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 076833D1D0;
        Thu,  8 Sep 2016 14:20:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Michael J Gruber <git@drmicha.warpmail.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] gpg-interface: reflect stderr to stderr
References: <ced7502d-0095-bd90-19e3-c14d0e4d4f07@drmicha.warpmail.net>
        <18a7e2984121d988137c135ec560fee56506981b.1473167263.git.git@drmicha.warpmail.net>
        <alpine.DEB.2.20.1609061827290.129229@virtualbox>
        <alpine.DEB.2.20.1609061839370.129229@virtualbox>
        <alpine.DEB.2.20.1609061843120.129229@virtualbox>
        <655b42d8-baa9-e649-2b3c-5b7bfc914bc5@drmicha.warpmail.net>
        <20160907083947.b7q7ebe62xsr6447@sigill.intra.peff.net>
Date:   Thu, 08 Sep 2016 11:20:09 -0700
In-Reply-To: <20160907083947.b7q7ebe62xsr6447@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 7 Sep 2016 04:39:47 -0400")
Message-ID: <xmqqwpimgso6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E37A75A6-75F0-11E6-9101-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Sep 07, 2016 at 10:27:34AM +0200, Michael J Gruber wrote:
>
>> Now, I can't reproduce C on Linux[*], so there is more involved. It
>> could be that my patch just exposes a problem in our start_command()
>> etc.: run-command.c contains a lot of ifdefing, so possibly quite
>> different code is run on different platforms.
>
> Maybe, though my blind guess is that it is simply that on Linux we can
> open /dev/tty directly, and console-IO on Windows is a bit more
> complicated.

True.

Even though this patch is fixing only one of the two issues, I am
tempted to say that we should queue it for now, as it does so
without breaking a bigger gain made by the original, i.e. we learn
the status of verification in a way the authors of GPG wants us to,
while somebody figuires out what the best way is to show the prompt
to the console on Windows.

