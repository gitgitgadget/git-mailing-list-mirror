Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE99C00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 22:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7642B22258
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 22:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hCS69YdX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbgKBWPF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 17:15:05 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60742 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbgKBWPF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 17:15:05 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EB3B78F6FE;
        Mon,  2 Nov 2020 17:15:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Ntkboz4b3CBX
        yidvj7Yfd2d6Hmk=; b=hCS69YdXLHLnghxa4dAoPbaikCxjhgrPnVUrNgE14SCl
        klzGMViYx+aan/18978yWqRJBi4z6uUbyrQdxIxenUJNMgAgaqkIGYZkcGAUe29z
        lpyeMkPS2nvslUzq26jfGnwyVpiv6VN+17uhksw5yukrTrC/Ivwx95KSb4sAEWs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=xo8/jv
        e3i2IiQG78nJMQGl27bXyvTtmyDSRyFOctcEPivxdPFOwBshBWy/AJofzUl9ewZu
        k5asI62O/BHviW8gPNnh6kP4uJGXsVuVlPBlHoUbPrQhuLf/YiwiVD7kwxU97VSb
        NpU6YQ8BsgzlrPpB/zMxl02zqTdl71JrEN2Vs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A890B8F6F9;
        Mon,  2 Nov 2020 17:15:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 858958F6F2;
        Mon,  2 Nov 2020 17:15:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eli Barzilay <eli@barzilay.org>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        git <git@vger.kernel.org>
Subject: Re: git-diff bug?
References: <CALO-guviA4xKjUi0HfA+RLkTPPaQw7KArj__A9fKz0oP3m5MGw@mail.gmail.com>
        <72cfef26-e986-d34c-eea4-46ec0fda2688@web.de>
        <CALO-gusRt4J5ar45mo7un-EENyt5cX2SQvcXgyMmaHNZg5bFUg@mail.gmail.com>
Date:   Mon, 02 Nov 2020 14:14:59 -0800
In-Reply-To: <CALO-gusRt4J5ar45mo7un-EENyt5cX2SQvcXgyMmaHNZg5bFUg@mail.gmail.com>
        (Eli Barzilay's message of "Mon, 2 Nov 2020 16:06:49 -0500")
Message-ID: <xmqqlffjs8ws.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D958877A-1D58-11EB-96A3-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eli Barzilay <eli@barzilay.org> writes:

>> This matches your results.  That the order makes a difference is a bit
>> odd.  Both are valid diffs of the inputs and neither one changes blank
>> lines, though, so it doesn't look like a bug.
>
> How is it valid?

Just this part.  Any patch output that correctly explains how the
preimage text changed to the postimage text is a "valid" diff, and
that is how Ren=C3=A9 used the word.  There are multiple "valid" diff
to bring the preimage to the postimage:

    (preimage)          (postimage)
    aaa                 aaa
    bbb                 bbb
    ccc
                        ccc

In an extreme case, this diff is even valid.

    @@ -1,4 +1,4 @@
    -aaa
    -bbb
    -ccc
    -
    +aaa
    +bbb
    +
    +ccc

It's just that it is not as _useful_ as other valid diff that
explains how the preimage changed to the postimage.

HTH.
