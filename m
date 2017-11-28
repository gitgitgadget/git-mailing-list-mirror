Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5BE220C11
	for <e@80x24.org>; Tue, 28 Nov 2017 02:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753398AbdK1Cbu (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 21:31:50 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59172 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753285AbdK1Cbu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 21:31:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 81148C0F0F;
        Mon, 27 Nov 2017 21:31:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dFpFL0326eHkN2zozXZpYF6NEaA=; b=qt/dQV
        OVIfTvLtgI4iMZBOJj/VNo1sCCKRKZgslAh+c1Iwgs9AKJOdKdYAKp9Jum/c+pts
        oM/HhZdDrtwUHbfZsm40HAKDr3wuvb+wlojvp+m9aETQpluoTtr97Es36HOEVuPK
        +5E4kB/aPZrX/KllygOSBb1LLu04p6PiKLtnk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yiHrd7JTdDY9ukvG7u2Z5EtRynWRtjNK
        kblNHqQt/u8zpaBDFC0suryN+i1mjjDuB+HJRrHDyoC1emEb6TW0gP/wLFYdlDFC
        FvoBzB9oyOFuUOpJIE9x5Vzobo5RUnKwNlOPfmtuiDQMiJn7tT7t9iwL9Idj3LRF
        2Vk4wkiEzcY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A758C0F0E;
        Mon, 27 Nov 2017 21:31:49 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EFA78C0F0D;
        Mon, 27 Nov 2017 21:31:48 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] rebase: rebasing can also be done when HEAD is detached
References: <xmqq60a3xdpw.fsf@gitster.mtv.corp.google.com>
        <20171127172104.5796-1-kaartic.sivaraam@gmail.com>
        <20171127172104.5796-4-kaartic.sivaraam@gmail.com>
Date:   Tue, 28 Nov 2017 11:31:47 +0900
In-Reply-To: <20171127172104.5796-4-kaartic.sivaraam@gmail.com> (Kaartic
        Sivaraam's message of "Mon, 27 Nov 2017 22:51:04 +0530")
Message-ID: <xmqqlgir8770.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 491144E2-D3E4-11E7-AE2A-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> +		if test "$branch_or_commit" = "HEAD" &&
> +			 !(git symbolic-ref -q HEAD)

Did you need a subshell here?  Now with a proper test with
"symbolic-ref -q HEAD", I wonder if you'd need to check if the
original was named HEAD in the first place (I do not feel strongly
enough to say that checking is wrong, at least not yet, but the
above does make me wonder), and instead something like

	if ! git symbolic-ref -q HEAD
	then
		...

might be sufficient.  I dunno.

I find what 2/3 and 3/3 want to do quite sensible.  They depend on
1/3, which I find is more a needless churn than a clean-up, which is
unfortunate, though.

Thanks.
