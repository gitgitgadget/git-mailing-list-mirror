Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82BEE1F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 18:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751520AbdAYSQo (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 13:16:44 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51975 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751444AbdAYSQn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 13:16:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7BF00614DE;
        Wed, 25 Jan 2017 13:16:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vAsDe8sU3fwbsPj/4h+od+TywYc=; b=kt0wdE
        OEzfqrC9S+ntVdnKiMmZuHsBjnpTQ0ZmT1Ia3LpIr2BWBY7U98jUmBymaNTUPo3V
        +ja/URK3W9iGhEM7gogO93dg+r7S/FwFoJnsBfCFLJM7YvVOqmTBLBOZzyYz6H+n
        +F4Fdf/FNP/ib8iL6kn3oCsFd6DCuY7vxCeBk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xFE+5G37miz3LRDX/G+8pc+vpyvXZYom
        pEGzh/wYMpJbvun7gfeyuU7IWvLPb/nNE19WjpQcpVPtQCWaoGJ2UkEbM1yE0Dyo
        mWjNkGgZ1F+kIeuUqWjgUsaornlwgsfQRZfe++3e/d+VmK7ie88mJyKN42XvW8F0
        jMOzscVnz/8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 635D0614D9;
        Wed, 25 Jan 2017 13:16:42 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B87C7614CB;
        Wed, 25 Jan 2017 13:16:41 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jan 2017, #04; Mon, 23)
References: <xmqqo9yxpaxk.fsf@gitster.mtv.corp.google.com>
        <0D956B23-E655-4C28-A205-14CCC0A7DEA2@gmail.com>
        <20170124132749.l3ezupyitvxe4t2l@sigill.intra.peff.net>
        <alpine.DEB.2.20.1701251800120.3469@virtualbox>
        <20170125173958.pg546a6w33dirp5k@sigill.intra.peff.net>
Date:   Wed, 25 Jan 2017 10:16:40 -0800
In-Reply-To: <20170125173958.pg546a6w33dirp5k@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 25 Jan 2017 12:39:58 -0500")
Message-ID: <xmqq4m0nc8dz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6BC6F19A-E32A-11E6-9055-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Jan 25, 2017 at 06:01:11PM +0100, Johannes Schindelin wrote:
>
>> > Looks like "mv" prompts and then fails to move the file (so we get the
>> > dangling blob for the source blob, and fsck doesn't report failure
>> > because we didn't actually corrupt the destination blob).
>> 
>> IIRC I had similar problems years ago, on a machine where the
>> administrator defined mandatory aliases, including mv="mv -i".
>
> Yeah, that was my first thought, too. But this should be a
> non-interactive shell, which would generally avoid loading rc files. I
> think there are some exceptions, though (e.g., setting ENV or BASH_ENV).
> Loading aliases like "mv -i" for non-interactive shells seems somewhat
> insane to me. 

It does to me, too.

> But whatever the cause, I think the workaround I posted is
> easy enough to do.

Or spelling it explicitly as "/bin/mv" (forgetting systems that does
not have it in /bin but as /usr/bin/mv) would also defeat alias if
that were the cause.

One downside of working it around like your patch does, or spelling
it out as "/bin/mv", is that we'd need to worry about all the uses
of "mv" in our scripts.  If this were _only_ happening in the Travis
environment, I'd prefer to see why it happens only there and fix that
instead.

