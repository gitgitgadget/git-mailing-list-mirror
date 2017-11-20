Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A26120954
	for <e@80x24.org>; Mon, 20 Nov 2017 04:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750969AbdKTE7h (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 23:59:37 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55995 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750764AbdKTE7g (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 23:59:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9BD1AAA61E;
        Sun, 19 Nov 2017 23:59:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fYYa5NkC+4HHQa607GofjZLKGcI=; b=YFsCFo
        sAiImT/geP/Uv7B1vqpLEZz18+eMyJevCN1PMhHi8T5xi9/B9hsT7dbsHZ6J1bWZ
        kTLR4IP9cTtToNe7ffOtP3PNLagYulxLoj9CMwayCSEmSCY+2dLdrpzIzG3/zMxU
        Sbg270LYUruBwkzlCOGoOLg+4XmxDApPkEUvo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xNLi0NzktQnwcpEd5Ns2yY96cm4tK+7Z
        4bQ7nojoJzEh0cDzF8C8SDpRZP0+DixjV41Te/tIXnJcMYr0vHoHZtwwc7cKtjeF
        nh69Y8Zx/HkVbCh5n/d3A9nqqng4XnuNJBuy5T5ygA8lOczHMUgsGgpSjMwYpmni
        2cLSQKnflFw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 93EF0AA61D;
        Sun, 19 Nov 2017 23:59:35 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0E6D7AA61C;
        Sun, 19 Nov 2017 23:59:34 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Gennady Kupava <gennady.kupava@gmail.com>
Cc:     git <git@vger.kernel.org>, Gennady Kupava <gkupava@bloomberg.net>
Subject: Re: [PATCH 1/2] Simplify tracing code by removing trace key normalization concept
References: <20171117221631.x2xqeeqmf5xob3yv@sigill.intra.peff.net>
        <20171119004247.22792-1-gennady.kupava@gmail.com>
        <xmqqzi7jnh6a.fsf@gitster.mtv.corp.google.com>
        <CAPu-DQoapb=cgxYEOEVcpZ4nQeh+FuOE6VF=m3NaqRcr2p8Nrg@mail.gmail.com>
        <xmqqr2stokzd.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 20 Nov 2017 13:59:33 +0900
In-Reply-To: <xmqqr2stokzd.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 20 Nov 2017 09:24:38 +0900")
Message-ID: <xmqqvai5lf4a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A5BA314-CDAF-11E7-9810-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> The thought behind the change flows much better in the above
> explanation than your four-bullet list (which a reader would often
> assume are parallel and orthogonal).  "Remove this, because it is
> not used" is the primary thing for this step, and the fact that the

Make that "because it is not strictly necessary", as that seems to
be much closer to what is going on, and I agree that it is a good
change to remove such "convenience for callers" feature from
codepaths that could be performance critical.  The callers can pass
the "&default" thing themselves just as easily as they pass NULL
and have the library code to do the defaulting, and that will remove
the need to incur extra cost for a subroutine call.
