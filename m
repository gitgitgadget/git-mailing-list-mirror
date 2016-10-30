Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 564B42021E
	for <e@80x24.org>; Sun, 30 Oct 2016 07:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751652AbcJ3Hx5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Oct 2016 03:53:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51352 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750804AbcJ3Hx4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2016 03:53:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B07B440968;
        Sun, 30 Oct 2016 03:53:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hJ+1ZTvScg27gsuYuKdnXDK76XQ=; b=qXFUQY
        C1PjM+Vd1FcqMUwMQxesSSD8K2d8cWTAFjpme4/P2uPNT3df+j3jt6xSD+PmORVq
        nK8JoC4Wg5xQikEAN7kUJC/+pwmLaoyq95xpL0+1VVgprcjyKEssQnNPxGDXJLMe
        CvYGrLvSwkJf7FuMmNKi8miunCSo3rgp8z2t4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bnlQ7A+PpV1edMNo8yN+DoAE/hPzQPjs
        xlQtIHic0DsaYAyr4KvBLH5pny+P0C6VFxF+MlUyRybLXMZjvH1XjYzNa5h716Cy
        9nyRyqrST9L1/qMQImpoAXh0FdQ4mca5jXTbFyrx4sZjVjkAnxYfyJifwWkqXEKh
        idR5+t/j38w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A7BB940967;
        Sun, 30 Oct 2016 03:53:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2CA9140966;
        Sun, 30 Oct 2016 03:53:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Matt McCutchen <matt@mattmccutchen.net>, git@vger.kernel.org
Subject: Re: Fetch/push lets a malicious server steal the targets of "have" lines
References: <1477690790.2904.22.camel@mattmccutchen.net>
        <xmqqmvhoxhfp.fsf@gitster.mtv.corp.google.com>
        <1477692961.2904.36.camel@mattmccutchen.net>
        <xmqq7f8sx8lg.fsf@gitster.mtv.corp.google.com>
        <1477712029.2904.64.camel@mattmccutchen.net>
        <20161029133959.kpkohjkku3jgwjql@sigill.intra.peff.net>
        <1477757311.1524.21.camel@mattmccutchen.net>
        <20161029191023.ztrfe76u4gi4l3ci@sigill.intra.peff.net>
Date:   Sun, 30 Oct 2016 00:53:52 -0700
In-Reply-To: <20161029191023.ztrfe76u4gi4l3ci@sigill.intra.peff.net> (Jeff
        King's message of "Sat, 29 Oct 2016 15:10:23 -0400")
Message-ID: <xmqqy416uvan.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 010757F8-9E76-11E6-B930-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ... It is not thinking about what secret things are hitting the
> master that you are pushing, no matter how they got there.
>
> I agree there is a potential workflow (that you have laid out) where
> such lying can cause an innocent-looking sequence of events to disclose
> the secret commits. And again, I don't mind a note in the documentation
> mentioning that. I just have trouble believing it's a common one in
> practice.

I'd say I agree with the above.  I am not sure how easy people
employing common workflows can be tricked into the scenario Matt
presented, either, but I do not think it would hurt to warn people
that they need to be careful not to pull from or push to an
untrustworthy place or push things you are not sure that are clean.

> The reason I brought up the delta thing, even though it's a much harder
> attack to execute, is that it comes up in much more common workflows,
> like simply fetching from a private security-sensitive repo into your
> "main" public repo (which is an example you brought up, and something I
> know that I have personally done in the past for git.git).

Yup.
