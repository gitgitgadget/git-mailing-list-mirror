Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B83E31F859
	for <e@80x24.org>; Fri, 19 Aug 2016 22:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754290AbcHSWb1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 18:31:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63574 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754112AbcHSWb1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 18:31:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 807C236907;
        Fri, 19 Aug 2016 18:31:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fVZZeQHU4GIB8UMUOFbk4FQHXgA=; b=iR//ti
        MgVpTqZ+xEi1beX/DTw9QPzaRGS5T8J5JINwZNYLzhx92fOMfvZX2rI8kr422jWN
        vlkreP0PwVBX7l21A6zF6gvWuGNoj0L+S92qpi2+bSqJR+8CRZcivSpZxqkGTIQ/
        xE9HgsexOxBemJYFK+mEGRRYYGMOSeCIPv2OA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gh5VKn/Ns20plQCgAV/Mx6WybY2EvR8p
        syHZxBCo6ePIiu6SQM4nuxcY8FgtBXK45GHsNWmmB80JKjsezC/26KGv9F35QEkv
        D6OXwyJ9ZrWdbFnjpDwAp7MgIDVMupKE8bjM19iBCUASWnYX8aS/rLKo9AzH2on6
        rqP8DoG75Ro=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 78D3D36906;
        Fri, 19 Aug 2016 18:31:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F285D36905;
        Fri, 19 Aug 2016 18:31:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Brian Henderson <henderson.bj@gmail.com>, git@vger.kernel.org,
        e@80x24.org
Subject: Re: [PATCH] diff-highlight: add some tests.
References: <xmqqh9ag39zk.fsf@gitster.mtv.corp.google.com>
        <20160819201837.GA18918@tci.corp.yp.com>
        <xmqqbn0o1ob7.fsf@gitster.mtv.corp.google.com>
        <20160819210431.usy6x3x6sdhe3vbp@sigill.intra.peff.net>
Date:   Fri, 19 Aug 2016 15:31:21 -0700
In-Reply-To: <20160819210431.usy6x3x6sdhe3vbp@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 19 Aug 2016 17:04:31 -0400")
Message-ID: <xmqqeg5kz8zq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A904CD8E-665C-11E6-B7BA-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> For that matter, I'm not sure that:
>
>   cat >a <<-\EOF &&
>   aaa
>   bbb
>   ccc
>   EOF
>
>   cat >b <<-\EOF &&
>   aaa
>   0bb
>   ccc
>   EOF
>
>   dh_test a b <<\EOF
>   aaa
>   -${CW}b${CR}bb
>   +${CW}0${CR}bb
>   EOF
>
> isn't more readable, too. It's more lines, certainly, but it makes it
> very easy to see what the input files look like, rather than cramming
> "\n" into the middle of a string (the existing code does make the diff
> easy to see for _this_ case, because the pre- and post-image line up
> vertically, but that is only the case for pure transliterations like
> this).

Yeah, the simplicity and obviousness certainly is very tempting.

With something like

CW=$(printf "\033[7m")	# white
CR=$(printf "\033[27m") # reset

upfront, the test helper does not even need to worry about feeding a
random string through printf as if it is a format string.

