Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A90F21FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 19:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753882AbcLFT4t (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 14:56:49 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51833 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752590AbcLFT4t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 14:56:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0ACEE55409;
        Tue,  6 Dec 2016 14:51:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Pp5K3VK948ZMj+xvvNRT2QrZ5pk=; b=ZWl9rD
        HnNKCS8E5KFb1yUSelbdn+H2EiIWsoSDy8yVGnIZVP8pyLfQ7C8ItBEK09+PGoOQ
        DP4W+F8wiYyGu03KhDXgTULQsdtaEYHnaIKDyNGlRhfMAj2GRy+jynIltFrl9Kmu
        pGlWQg20ddOlLO7zXIGRdGdWp0xQy/vUQLMZM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=k/xKPJ6cEyYCGEdUPluQd18Jrw6T+9ja
        fjD5XfH998w5sp+ICiNNBjXq+2U9p+qin37ghcPAJXN9/fdKyRqwBy5m2vUTaVqL
        5FlKWpSDJC1UBlwFzQ69fsFSOnbNLsoCc+jphbmvOuOZu+Cr8H/pJ+rFVFoMAILE
        XvdqKYx39Ss=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0112D55408;
        Tue,  6 Dec 2016 14:51:18 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6D8B855407;
        Tue,  6 Dec 2016 14:51:17 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Matthew Patey <matthew.patey2167@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] stash: disable renames when calling git-diff
References: <CAFQpxxKbn4vBMzVcLZgBVvuL2fsOGNMHR1WC+aTOG_RAWkZ_Gg@mail.gmail.com>
        <20161206142446.5ba3wc625p5o6nct@sigill.intra.peff.net>
        <CAFQpxx+PJ3FSoH9DFWyEw+ZLagji9Qou+aY9EB8A+=t+QX0o2A@mail.gmail.com>
        <20161206152530.snccf7buiosst3e4@sigill.intra.peff.net>
        <20161206154120.yyuca35ugyuifpq6@sigill.intra.peff.net>
        <xmqqh96g27bh.fsf@gitster.mtv.corp.google.com>
        <20161206193154.vf7cd7lk5gyxrra5@sigill.intra.peff.net>
Date:   Tue, 06 Dec 2016 11:51:16 -0800
In-Reply-To: <20161206193154.vf7cd7lk5gyxrra5@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 6 Dec 2016 14:31:54 -0500")
Message-ID: <xmqqd1h425vv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5A1979FE-BBED-11E6-A9A6-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Dec 06, 2016 at 11:20:18AM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> >> If you run:
>> >> 
>> >>   git -c diff.renames=false stash
>> >> 
>> >> then it works.
>> >
>> > And here's a patch to fix it.
>> 
>> Yuck.  This obviously has easier to bite more people since we
>> enabled the renames by default.  Thanks for a quick fix.
>> 
>> I wonder why we are using "git diff" here, not the plumbing,
>> though.
>
> I don't think there's a plumbing command which works for diffing the
> working tree directly to a git tree. In the long run, it might be a good
> idea to remedy that.

I do not think that one is doing anything different from "git
diff-index --name-only -z HEAD".

> Though I'm not sure that "git add -u" would not accomplish the same
> thing as these several commands.

Yeah, it looks like "add -u" to me, too.  Perhaps the script was old
enough that it didn't exist back then?  I dunno.

