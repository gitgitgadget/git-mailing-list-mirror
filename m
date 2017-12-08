Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 609331FC34
	for <e@80x24.org>; Fri,  8 Dec 2017 23:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753336AbdLHXV1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 18:21:27 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52661 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753112AbdLHXV0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 18:21:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 95946AF1F2;
        Fri,  8 Dec 2017 18:21:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PnnFCCnt//6rYNN3Jiyd8bEi/XA=; b=RgXW3G
        iDe4xAg8pAT27I2AS5CnCk3b0RI8H1Aj2rtAWCXUMUQzI3lD9DJvOjZuw6Y2F9ML
        1ByvrwgsBCDUyVbBGCx2IBN5RupkT/u6HNOK6AkJDGBoYgVnQxpZgYCd1hoIMDka
        KIQRF8OACVAfYJiX9DNUFNd9tbohzkxEYYObw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lBluafjsl7Vx5rxn22I6dOkjRsHENVKM
        yIh7whQdccvD6enJDQcz6e8VKh+TLfViOBY4denXmom3OENbo4qYPfNFaqZXgVG2
        NAnCiUrL4CdnlRkDzWxS77BkJf5MlH7+WHXUIqGPNB84gCty24YPc3LSEVch3nWq
        HsqEUv7caFs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D169AF1F1;
        Fri,  8 Dec 2017 18:21:25 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DF5CAAF1F0;
        Fri,  8 Dec 2017 18:21:24 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 4/5] Makefile: use the sha1collisiondetection submodule by default
References: <20171208223001.556-1-avarab@gmail.com>
        <20171128213214.12477-1-avarab@gmail.com>
        <20171208223001.556-5-avarab@gmail.com>
        <xmqqo9n86dde.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 08 Dec 2017 15:21:23 -0800
In-Reply-To: <xmqqo9n86dde.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 08 Dec 2017 14:53:01 -0800")
Message-ID: <xmqqk1xw6c24.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 825FCC86-DC6E-11E7-A722-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> That endgame allows us not force people to grab an essential part of
> the codebase as an external dependency from another place, which
> feels quite bad, especially when their primary interest is not in
> dogfooding submodule but in building a working version of Git.
>
> Removing one and keeping the other between the two will make the
> distribution more streamlined by removing the build-time knob we
> need to tweak, but the one that gets removed does not have to be the
> in-tree one that allows people to "git clone" from just one place.

Perhaps this may deserve a bit more explanation.

I wouldn't be so against "let's do submodule-only" if this were not
SHA-1 implementation but something like gitk and git-gui.  An optional
part of a system that it is safe to leave to individual builders if
they want to fetch and use that part *is* an ideal target to bind as
a submodule to the system.

It's just the "default SHA-1 implementation" is at the far opposite
end of the spectrum from "an optional part", and our use of
submodule to bind this code is definitely *not* because it makes
sense to use submodule in that context; it is because developers
(not necessarily those who consume Git sourcecode) *wanted* to use
submodule there, regardless of the real merit of doing so.

And that is why I do not feel entirely happy with the step 4/5 and
also I feel moderately strongly against the step 5/5.  These two
steps have a "developer first" smell that disgusts me.

