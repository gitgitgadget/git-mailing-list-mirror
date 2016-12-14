Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 354D81FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 17:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755955AbcLNRG6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 12:06:58 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61142 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752737AbcLNRG5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 12:06:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C7B256873;
        Wed, 14 Dec 2016 12:01:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=46t036vOA43j48gSLFx+WdtqSuI=; b=dRzDeS
        SX8EaoIjya4kT5zK9nuRlcfamWeWZt7RI0Y2AaFLMVfOUc8GfXPOtmBQQiPzavcn
        koEyv4/rDEKuGSI9W07d8PiDQrA+NCA+lNbUpDU73QQ0qfYqSV+Vewq98tFBPD7A
        DGZqDObtWNtSIgQOPRjlYBvNhv98ow4etn/Fo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fUXxyeJu6Yieka9y6lW/I4oKyXUk435G
        ZSyaE2Zrgxhh8I3Hm+RBoyIbU3cCPsXqrQNVSUkx45opq5nBTq04tCOFmrmuzO4r
        r9C3Of58/Zf4EcAqmE+R3IVGD2Xj1kcQDIo6xrs8pha3Qd58eTcvi0DPSaWBRXoe
        bkW93x6WwJE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 22CF456872;
        Wed, 14 Dec 2016 12:01:48 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8BA8956871;
        Wed, 14 Dec 2016 12:01:47 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Chris Packham <judge.packham@gmail.com>, git@vger.kernel.org,
        mah@jump-ing.de, jacob.keller@gmail.com
Subject: Re: [PATCHv3 1/3] merge: Add '--continue' option as a synonym for 'git commit'
References: <20161213084859.13426-1-judge.packham@gmail.com>
        <20161214083757.26412-1-judge.packham@gmail.com>
        <20161214152039.swtll7xrmcdwz7bc@sigill.intra.peff.net>
Date:   Wed, 14 Dec 2016 09:01:46 -0800
In-Reply-To: <20161214152039.swtll7xrmcdwz7bc@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 14 Dec 2016 10:20:39 -0500")
Message-ID: <xmqq4m26zbph.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FFB0309C-C21E-11E6-B79A-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So not too bad (and you could probably refactor it to avoid some of the
> duplication). Though it does get some obscure cases wrong, like:
>
>   git merge --continue --verbose --quiet
>
> I dunno. Maybe I am leading you down a rabbit hole, and we should just
> live with silently ignoring useless options.

I think you need to handle this in parse-options API if you really
wanted to do this correctly.  

<xmqq60mn671x.fsf@gitster.mtv.corp.google.com> may serve as a
reasonable outline for building one.
