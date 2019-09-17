Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C13F1F463
	for <e@80x24.org>; Tue, 17 Sep 2019 19:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730085AbfIQTW0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 15:22:26 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54544 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfIQTW0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 15:22:26 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 32208754D2;
        Tue, 17 Sep 2019 15:22:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=xEcvzwAD2YH6Pb+5Li3c6J04dG4=; b=SMdgPPYTewqrkbkyQXYd
        3M7ojTXLlmY3q/KWZ0kSCn5GqI7VQCuTG+sUWvYf0tx/OeuBdWsFr2dF+XqgWoCt
        nMzFUleb3YpdTChfkD3TGw54LbQAOGNScL2OiPV3Kbq+AeMmnUHlF5n3y6PpdY25
        UReNWXGHey7igTNYrRUc6qY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=vomEFBPYtvaVUc81b8nQx0DDubZX2nsCRMm+FKoz5zzqyt
        dVCXKK+SThnFMxGakmDZ6C7e8NLbjtqM5QbuesUXPcY0GvoVEoqFkqGfh1cRmQiW
        ZWoVDRCiykXdB9PF6U3thKDuXaU+rrfeBkdnI9uhYcdyzV11V1/Cnk/tbbW6o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 29D88754D1;
        Tue, 17 Sep 2019 15:22:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 53BEE754CF;
        Tue, 17 Sep 2019 15:22:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jon Simons <jon@jonsimons.org>, git@vger.kernel.org,
        me@ttaylorr.com, sunshine@sunshineco.com, stolee@gmail.com
Subject: Re: [PATCH 2/3] list-objects-filter: delay parsing of sparse oid
References: <20190915010942.GA19787@sigill.intra.peff.net>
        <20190915011319.GB11208@sigill.intra.peff.net>
        <20190915161244.GA2826@sigill.intra.peff.net>
Date:   Tue, 17 Sep 2019 12:22:19 -0700
Message-ID: <xmqqef0e9190.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 789551A6-D980-11E9-A437-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> It's a good idea to parse as much as we can in step 1, in order to catch
> problems early (e.g., a blob size limit that isn't a number). But one
> thing we _shouldn't_ do is resolve any oids at that step (e.g., for
> sparse-file contents specified by oid). In the case of a fetch, the oid
> has to be resolved on the remote side.
> ...
> We can fix both by moving the oid resolution into the sparse-oid init
> function. At that point we know we have a repository (because we're
> about to traverse), and handling the error there fixes the segfault.

Makes sense.  Thanks for a clean solution to a messy problem.

