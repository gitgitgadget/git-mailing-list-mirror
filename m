Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53CCA1F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 01:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbfJ3BnK (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 21:43:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62115 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfJ3BnK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 21:43:10 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 518061C93D;
        Tue, 29 Oct 2019 21:43:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eC4zY5UuTDTZ5EQXWTBsxYL35Fc=; b=QBIS/s
        feNI2HaO9hDSErbprMUHWg5aCAlGx2zq+sToIYMpRJWhQ2I1oTy25KrHnjigJGLB
        oiuYMBeKJVKuWxw95bl7Cs3FFbc/laxYM+vFWVuFT2B01tdhuBHbgTybo3MUCx9f
        FeTVBKWnI2mw6SUuNBEGzIAehtbfffQKwOsuo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=u764fhAQUuimc0RjBCGJbrsCYknwQk36
        qM87CFkDlkvPanTlwc8WCU/WE+UrGjVi1IK/0jhL0R7zF0kylTX7B3skbywoVXS+
        0/wICXJgh7F3xGfBafl8dIIe7XHMoUgwbPuMpEgSHxZ4dbP6+EW30WUC64PWLJMq
        juThXHugdE4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CA1341C93B;
        Tue, 29 Oct 2019 21:43:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BE6831C93A;
        Tue, 29 Oct 2019 21:43:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Re: [PATCH 1/1] vreportf(): avoid buffered write in favor of unbuffered one
References: <pull.428.git.1572274859.gitgitgadget@gmail.com>
        <455026ce3ef2b2d7cfecfc4b4bf5b588eebddcfe.1572274859.git.gitgitgadget@gmail.com>
        <xmqqeeyw6xyr.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1910291222500.46@tvgsbejvaqbjf.bet>
        <20191029134932.GA2843@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1910291510330.46@tvgsbejvaqbjf.bet>
        <20191029143246.GA3683@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1910292101300.46@tvgsbejvaqbjf.bet>
Date:   Wed, 30 Oct 2019 10:43:02 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1910292101300.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 29 Oct 2019 21:09:14 +0100 (CET)")
Message-ID: <xmqqsgnb3t5l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9E4D860A-FAB6-11E9-867F-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I really believe that the care I put into the patch to safeguard against
> overly long prefixes is seriously overkill.

If it was buggy, the care given to it probably was insufficient, not
overkill ;-)

As long as we know there won't be an overflow, and our compilers
won't complain about possible overflow, simpler code that is easier
to reason about is better.  I tend to think that Peff's
"consistently count based on offsets, instead of pointer arithmetic
that you can easily get wrong" would give us an easier-to-read
result in this case.

Thanks for simplifying the original "overkill" version.  Except for
the bug resulting from misunderstanding of strlcpy() return value,
the version I saw was a quite pleasant read.


