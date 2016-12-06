Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BBAC1FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 20:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753296AbcLFUW3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 15:22:29 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51901 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753207AbcLFUW2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 15:22:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 20F975598F;
        Tue,  6 Dec 2016 15:22:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WM2o+qNurD7Xi1ezOSM4IW/CmLc=; b=ZAAhN+
        4kpCb49ZZIUXI4RpuJbWVACUjN7ehkCj8JDlUSF4cZfp1ZSZ6XVVwmaUieu4nVoh
        yPtqm/cz1S+kT+TkmNVNYe+Cmg5CraBsjlt3rZRn1R9GZceIQpiYygBRfx+gW8TY
        yIHaaJ639tSiN49Wkk00G6qMAYlMcuJ9Oq8Fo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Xibc+1WRlXu2kmkS4cwmxkJgdVXKbXJV
        hvjkBOePC52Zu7BK6zlf9n8gSfBx28NJ1gWVLKpVNRHJFHEez3+w8LmHQcdocfxc
        kASy57BNxSG/RLjIpe8YHJy3WBfdaf2Vc0jj8/3WwdvWNzBZHLToR+MT+oLfhfKp
        Sa1Uhph6IQs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1905F5598E;
        Tue,  6 Dec 2016 15:22:27 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8ED105598D;
        Tue,  6 Dec 2016 15:22:26 -0500 (EST)
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
        <xmqqd1h425vv.fsf@gitster.mtv.corp.google.com>
        <20161206201130.azfmqvtk3iettlx7@sigill.intra.peff.net>
Date:   Tue, 06 Dec 2016 12:22:25 -0800
In-Reply-To: <20161206201130.azfmqvtk3iettlx7@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 6 Dec 2016 15:11:30 -0500")
Message-ID: <xmqq37i024fy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B431269A-BBF1-11E6-AC31-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think you are right that diff-index could work, though. I always
> forget that without "--cached", diff-index looks at the working tree
> files.

I'll reword the log message while queuing.  It was super surprising
to me to hear that there was something "git diff" did that three
"git diff-*" plumbing brothers couldn't do at the basic "what to
compare with what" level, as I wrote all four ;-)
