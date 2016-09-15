Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 875CE2070F
	for <e@80x24.org>; Thu, 15 Sep 2016 17:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753256AbcIORpk (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 13:45:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57973 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752005AbcIORpi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 13:45:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7CBF53D60E;
        Thu, 15 Sep 2016 13:45:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/awZhXBZO2oEJ0apbtbq89wIxfs=; b=nM1awu
        gu4yPUdSxVrG4a7KFAhT175QLoPGXVJxSNpZf9FTUw/XquavW1GzrBFWEIvmz4/b
        odJfWBH7cwVOaVeBhSDOxVsQBtJyMFNYxLi/PLdpS1UjumHMpHoEdmF4pzuw8OWg
        3tSNtDe3Pslk3Npd8vvQ2uSQg1m/IiE6u+GRE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lSAAwGPuVEnOtDMmEZTZtozwsVLB5Zs3
        GfJMtenEpl3l9aAtFh9MzP6jkFSRleLmrOoKUvXB5mG7a014EuH1B77N/uQKPcGe
        MUadyK2fkGJSjMcDtoDt4qAFnArCiv8LAr2iYlGgO/aqdouTah7DuQjGC2qNTxrV
        HQVc2yF9d6s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6DB7A3D60D;
        Thu, 15 Sep 2016 13:45:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D6A2A3D60C;
        Thu, 15 Sep 2016 13:45:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] object: measure time needed for resolving hash collisions
References: <20160915020141.32000-1-sbeller@google.com>
        <20160915064701.c4ishixuynbzpgwx@sigill.intra.peff.net>
Date:   Thu, 15 Sep 2016 10:45:34 -0700
In-Reply-To: <20160915064701.c4ishixuynbzpgwx@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 14 Sep 2016 23:47:02 -0700")
Message-ID: <xmqq60pxoy4h.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 35B26CAE-7B6C-11E6-87D7-2D857A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Measuring _just_ the collisions is more like the patch below. In my
> measurements it's more like 30ms, compared to 10s for all of the
> hashcmps.
>
> So we really aren't dealing with collisions, but rather just verifying
> that our hash landed at the right spot. And _any_ data structure is
> going to have to do that.

The reverse side of the coin may be if we can shrink the hashtable
smaller and load it more heavily without sacrificing performance by
making the necessary "have we landed at the right spot" check cheap
enough, I guess.

