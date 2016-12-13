Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD33D203EC
	for <e@80x24.org>; Tue, 13 Dec 2016 18:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941081AbcLMSIL (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 13:08:11 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61856 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S938612AbcLMSIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 13:08:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EA7A95670B;
        Tue, 13 Dec 2016 13:08:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=t+B8xioROYxhHQmWlDujuWDPxG8=; b=Tvja6E
        HZAFbfGyhS0DTW4DCzVXffcCB7SRokJNtXZEr3FAmTixV6vj36AcY1AyZGPF9yXZ
        Af13uH+5tleAW4a6g1AVBK9ZddHAE9WfOl2I22/wIfuTkBLo62N9X+KQloOUzyTT
        wjJqrV2N7v1/5TR1Zlwq+HAU6Y4AUmU3zK18Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gnefwiBG0X3fr8PTvTB8m5HSsk4xlHIp
        lvnWLmDNdh2sXmhpsQSseqmaQ9fFQ5Z5nVzlqBwW718+oE04DKlPL3cw2Ndc7mea
        9aCfjsxdptXRhnuK/2Kss6JP6OSCu+nS65/ajt69Q5JOsjJbjZYGdLN8A2DyCiJp
        yP6WCbWg+M0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E30195670A;
        Tue, 13 Dec 2016 13:08:07 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6779256709;
        Tue, 13 Dec 2016 13:08:07 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Klaus Ethgen <Klaus@ethgen.ch>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] alternates: accept double-quoted paths
References: <20161212194929.bdcihf7orjabzb2h@sigill.intra.peff.net>
        <20161212195222.rxnabok6amklt2zf@sigill.intra.peff.net>
        <CACsJy8B52ZDRTUjGLqub_1wELtugv99xbDnBg1PX1LUTb6nVMQ@mail.gmail.com>
Date:   Tue, 13 Dec 2016 10:08:06 -0800
In-Reply-To: <CACsJy8B52ZDRTUjGLqub_1wELtugv99xbDnBg1PX1LUTb6nVMQ@mail.gmail.com>
        (Duy Nguyen's message of "Tue, 13 Dec 2016 18:30:15 +0700")
Message-ID: <xmqq1sxb66t5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 19731F1E-C15F-11E6-AFD2-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> At least attr has the same problem and is going the same direction
> [1]. Cool. (I actually thought the patch was in and evidence that this
> kind of backward compatibility breaking was ok, turns out the patch
> has stayed around for years)
>
> [1] http://public-inbox.org/git/%3C20161110203428.30512-18-sbeller@google.com%3E/

Seeing that again, I see this in the proposed log message:

    Full pattern must be quoted. So 'pat"t"ern attr' will give exactly
    'pat"t"ern', not 'pattern'.

I cannot tell what it is trying to say.  The code suggests something
quite different, i.e. a line like this

	"pat\"t\"ern" attr

would tell us that a path that matches the pattern

	pat"t"ern

is given 'attr'.  

The log message may need to be cleaned up.  The update by that
commit to the documentation looks alright, thoguh.

