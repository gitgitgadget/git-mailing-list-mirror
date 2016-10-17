Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A23971F4F8
	for <e@80x24.org>; Mon, 17 Oct 2016 17:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030269AbcJQRae (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 13:30:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52787 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933945AbcJQRac (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 13:30:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5738346803;
        Mon, 17 Oct 2016 13:30:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/Zai93+QtnLZp6PtETewY4ouF80=; b=JPxHkh
        4AXtzRkZsef6ywaeY9pN+ye7yYZmFZ5asv6NbBGnBP27HSEsdwbG7pkWs1CGpDAz
        7sVsv9Py+ig45DaVPkddybpiFnLbm9exyonVIKSaaU8NbUIVhSBS1qKVyxOMgCKP
        4knUovD0D9d/aqkPsQMJddyCQ1ixeT64rLbsg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=g2P0J9K5ZuDiGBGEya3F8JDMT3YaluVn
        tcC1QzAc5c6Tj2+T1q7TTY2JYbD9LY3w8OBFz+FVT1S76ynuI+j+HIy2G+Xiis/b
        JLQIgLMNR+nFqpMJWIqFFxZB9giUyyGJZaREOZG/ZMlqqN/DW72DD18WANXgwfxd
        6mRTpLfDH14=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4C9B146802;
        Mon, 17 Oct 2016 13:30:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BF43646801;
        Mon, 17 Oct 2016 13:30:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>, git@vger.kernel.org,
        Quentin Casasnovas <quentin.casasnovas@oracle.com>,
        Shawn Pearce <spearce@spearce.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] fetch: use "quick" has_sha1_file for tag following
References: <fb66dc02-fb75-5aad-74e5-01b969cf9f9a@oracle.com>
        <af801f22-0e24-525d-a862-f2114941719a@oracle.com>
        <20161013152632.ynsabbv3yrthgidy@sigill.intra.peff.net>
        <20161013165344.jv7hyj74q33yb4ip@sigill.intra.peff.net>
        <20161013170443.43slna3zvcvrse5r@sigill.intra.peff.net>
        <20161013200644.lnustevmpvufbg5y@sigill.intra.peff.net>
        <xmqqfunyzv6f.fsf@gitster.mtv.corp.google.com>
        <20161014185953.k4b5xwihlgvxurjc@sigill.intra.peff.net>
Date:   Mon, 17 Oct 2016 10:30:28 -0700
In-Reply-To: <20161014185953.k4b5xwihlgvxurjc@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 14 Oct 2016 14:59:53 -0400")
Message-ID: <xmqqeg3ex4qz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 66D72752-948F-11E6-A78D-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Still an impressive speedup as a percentage, but negligible in absolute
> terms. But that's on a local filesystem on a Linux machine. I'd worry
> much more about a system with a slow readdir(), e.g., due to NFS.
> Somebody's real-world NFS case[1] was what prompted us to do 0eeb077
> (index-pack: avoid excessive re-reading of pack directory, 2015-06-09).

Yes.

> It looks like I _did_ look into optimizing this into a single stat()
> call in the thread at [1]. I completely forgot about that. I did find
> there that naively using stat_validity() on a directory is racy, though
> I wonder if we could do something clever with gettimeofday() instead.

It feels funny to hear an idea to compare fs timestamp with gettimeofday
immedately after hearing the word NFS, though ;-).

>> I agree that the fallout from the inaccuracy of "quick" approach is
>> probably acceptable and the next "fetch" will correct it anyway, so
>> let's do the "quick but inaccurate" for now and perhaps cook it in
>> 'next' for a bit longer than other topics?
>
> I doubt that cooking in 'next' for longer will turn up anything useful.
> The case we care about is the race between a repack and a fetch. We
> lived with the "quick" version of has_sha1_file() everywhere for 8
> years.

A very convincing argument.  I stand corrected.

Thanks.


