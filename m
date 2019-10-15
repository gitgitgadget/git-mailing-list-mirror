Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DB491F4C1
	for <e@80x24.org>; Tue, 15 Oct 2019 03:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfJODU1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 23:20:27 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52818 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfJODU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 23:20:27 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0BD1E96377;
        Mon, 14 Oct 2019 23:20:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H7hHxnoPIAjM3U7NzYKDFgvwEyU=; b=j+JYfl
        cp0N/P4RWrL3XpC64eyY4a8kS+WhbN9t7CoFhFQAr/zXJtVPE7rJiiP4nmRhwYo9
        k/BKmH+FplDDc0NH1H9IjUl8OWPxP0QHht1x3u/JnFvVZH7RW5CdFmxndDbfwDw2
        6dPprf7YNQlaPv3EvbVjHLJG/d9wr8/liFwGI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LqorXosZ0yJHSscEIeRlLk3mj6zO/wWP
        Kpr1kSWXn/6yeFlT0n+0mIB0q1ltM+r1PyWKUHmMruxJqSO574gYH07wsRKZn4qe
        X47pzd32/bT2guLrQtYq1opv+ez9YmS653uJ6WRlSrurN/ADwTVUcs4WobQVOBxN
        gEBMfA/cgfo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 042A196375;
        Mon, 14 Oct 2019 23:20:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2A55396372;
        Mon, 14 Oct 2019 23:20:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: ds/sparse-cone, was Re: What's cooking in git.git (Oct 2019, #03; Fri, 11)
References: <xmqq8sprhgzc.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1910122327250.3272@tvgsbejvaqbjf.bet>
        <20191015015052.GA19636@dcvr>
Date:   Tue, 15 Oct 2019 12:20:19 +0900
In-Reply-To: <20191015015052.GA19636@dcvr> (Eric Wong's message of "Tue, 15
        Oct 2019 01:50:52 +0000")
Message-ID: <xmqqzhi2bsp8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B8D74DF2-EEFA-11E9-906D-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> I just took a brief look, but that appears to leak memory.
>
> "hashmap_free(var, 1)" should be replaced with
> "hashmap_free_entries(var, struct foo, member)"
>
> Only "hashmap_free(var, 0)" can become "hashmap_free(var)"

I deliberately avoided merge-time band-aid fixups on this topic and
ew/hashmap exactly because I was sure that I'd introduce a similar
bugs by doing so myself.  Using evil merges can be a great way to
help multiple topics polished independently at the same time, but
when overused, can hide this kind of gotchas quite easily.

A reroll on top of ew/hashmap would be desirable, now that topic is
ready for 'master'.

Thanks.  
