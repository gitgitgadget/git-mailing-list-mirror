Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 009F91F461
	for <e@80x24.org>; Fri, 28 Jun 2019 16:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfF1QFi (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 12:05:38 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57613 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbfF1QFi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 12:05:38 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 46C0A7087D;
        Fri, 28 Jun 2019 12:05:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yXgy5GTe0VEF02VDVUjL0AHI9lU=; b=G1M7Ip
        9yA2H5w4Uphf3QgkJZhEwJNtHZEB+8fTb10Z9cHBLtwltDiz1+4S31c6oc7KrywD
        6vd/in5rtUrmjRfFniQOEFQSYJnUeV2GEi4ttyUSlTOJKMfBJJujymcN0Cu87V+9
        Yf9zy5+CPseawuTyFNtYE+KD7SHOtRvEOOeaY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=arCeTSCKO27S7lT1wLy8mjzu06bB9rNY
        ju/wovK2iXgmP0REkBeWMrgkLFCI+4gi7IUogfoynrfkpaCE6ZMiYG/s7DihtWmn
        x+o7t9AZ8i3ow8MPJbkWXK+vgLG4jdImO5yNvGH52dTyp/q+yOkT11MnLVxtQ1c1
        +kgkyWFQpHo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3E7FD7087C;
        Fri, 28 Jun 2019 12:05:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6065770879;
        Fri, 28 Jun 2019 12:05:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, jrn@google.com,
        dstolee@microsoft.com, jeffhost@microsoft.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, emilyshaffer@google.com,
        matvore@comcast.net, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v5 00/10] Filter combination
References: <20190601003603.90794-1-matvore@google.com>
        <cover.1561675151.git.matvore@google.com>
Date:   Fri, 28 Jun 2019 09:05:31 -0700
In-Reply-To: <cover.1561675151.git.matvore@google.com> (Matthew DeVore's
        message of "Thu, 27 Jun 2019 15:54:04 -0700")
Message-ID: <xmqq36jtae5w.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8F0A0636-99BE-11E9-94B6-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@google.com> writes:

> This applies suggestions made by Jonathan Tan, as well as fixes a
> Coccinelle-breaking error in strbuf usage, and makes an additional string
> localizable.

OK, so the convention is that errbuf has already translated string,
so the call to die() made in a fairly high point in the callchain do
not use _().  I looked at the new _() in deeper level of the
callchain this round adds relative to the previous one, and they all
looked sensible.

The helper function should_delegate is now gone---it had only one
callsite in the previous round, so I suspect the resulting code
would be the same either way with moderately decent compilers.

Will queue; thanks.
