Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D200A207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 19:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757023AbcILTVl (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 15:21:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59364 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756703AbcILTVi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 15:21:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C587F3C22F;
        Mon, 12 Sep 2016 15:21:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ykkFYS7qG8RgSseflqe1PKBc2DE=; b=cIvPz2
        N5as8ZRlHO33B/t/ngke5Cw5v/eMsQ9rJz772rGYmED8X6K675sqGhcXwqbXsKUQ
        5Jb8qP2q3/Fr2E/UmpUO9Lvjvzu6/giVthG+dceJXheMDDDSGpIISBeVTMzflLs7
        Mo9lcCU6LAmOrD9zdR3lXgB13NFZZCLLl6xqI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XsPeN7SrwXuQrB2FKs0Gw4S+IEt0YPui
        xJ312YgKdAKqPxmMroEJELC233tQFJ+vypG7F21FCXtOW+ymt8xBY4hzyURyYP2V
        HlRq4VbvxmjDKZiEiX8f3aKEWrYf5p8vy1aI5s0DPIVVaopSbpB3cwuwyK8t0OGb
        IZBvZV4+y3s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BC8243C22E;
        Mon, 12 Sep 2016 15:21:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3FEA93C22D;
        Mon, 12 Sep 2016 15:21:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kirill Smelkov <kirr@nexedi.com>
Cc:     Jeff King <peff@peff.net>, Vicent Marti <tanoku@gmail.com>,
        =?utf-8?Q?J=C3=A9rome?= Perrin <jerome@nexedi.com>,
        Isabelle Vallet <isabelle.vallet@nexedi.com>,
        Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
        Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2 v7] pack-objects: use reachability bitmap index when generating non-stdout pack
References: <20160809192858.GA25822@teco.navytux.spb.ru>
        <20160809193217.32389-1-kirr@nexedi.com>
        <20160818180615.q25p57v35m2xxtww@sigill.intra.peff.net>
        <20160910145925.xbbus7eck5ineika@teco.navytux.spb.ru>
Date:   Mon, 12 Sep 2016 12:21:35 -0700
In-Reply-To: <20160910145925.xbbus7eck5ineika@teco.navytux.spb.ru> (Kirill
        Smelkov's message of "Sat, 10 Sep 2016 17:59:25 +0300")
Message-ID: <xmqq8tuw3ow0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1FF2C774-791E-11E6-B0A2-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kirill Smelkov <kirr@nexedi.com> writes:

>> This is v7, but as I understand your numbering, it goes with v5 of patch
>> 1/2 that I just reviewed (usually we just increment the version number
>> on the whole series and treat it as a unit, even if some patches didn't
>> change from version to version).
>
> The reason those patches are having their own numbers is that they are
> orthogonal to each other and can be applied / rejected independently.

In such a case, we wouldn't label them 1/2 and 2/2, which tells the
readers that these are two pieces that are to be applied together to
form a single unit of change.  That was what these numbered patches
with different version numbers confusing.

> But ok, since now we have them considered both together, their next
> versions posted will be uniform v8.

OK.  Thanks for clarifying.
