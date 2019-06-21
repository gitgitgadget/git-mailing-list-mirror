Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07A911F461
	for <e@80x24.org>; Fri, 21 Jun 2019 20:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfFUUpq (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 16:45:46 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65228 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfFUUpq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 16:45:46 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7F3F16A9FF;
        Fri, 21 Jun 2019 16:45:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hXVPeFT3oaYPrj9iABpwy5mwLUY=; b=rhpCFb
        1MGkPzrZHrqx/mB21i5V+qeaONCU0XRafILAx0Pto2PsPlSF6afESFX5ULe7mHqV
        UrpAC3DQuoJh+OEkrC4jzFwZPIH9bqMRhB2ZxUfECk+guo3KChYLlvxAPeukxORg
        chyJYDk5P9EKxJvLjebhREfVBXZ/uGVHezZlw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dwkOpdMbnFIRZXHFBQpuFuXsGbd0BVpH
        6WwHMRAxQvGzCsysIq7qauPxfVUcokpYBQl6YQgqS4sjsNNSX3GX+VdQZu/eAG67
        1GvXLCyoFJ9gykqve5w6D+7WcMonsw1tsOOl8v1we7ahXxv45XA4M7Jj/1tY4mU0
        2eQtRyaEnuM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 771FC6A9FE;
        Fri, 21 Jun 2019 16:45:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A97456A9FD;
        Fri, 21 Jun 2019 16:45:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 15/20] msvc: support building Git using MS Visual C++
References: <pull.149.git.gitgitgadget@gmail.com>
        <pull.149.v2.git.gitgitgadget@gmail.com>
        <245f28ac3beda03c980220657ccc6e4d75269c00.1560978354.git.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.1906212216410.44@tvgsbejvaqbjf.bet>
Date:   Fri, 21 Jun 2019 13:45:39 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1906212216410.44@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 21 Jun 2019 22:17:36 +0200 (CEST)")
Message-ID: <xmqqv9wyis5o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 88ABEF74-9465-11E9-BBA0-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>>  ifdef SANE_TOOL_PATH
>>  SANE_TOOL_PATH_SQ = $(subst ','\'',$(SANE_TOOL_PATH))
>> -BROKEN_PATH_FIX = 's|^\# @@BROKEN_PATH_FIX@@$$|git_broken_path_fix "$(SANE_TOOL_PATH_SQ)"|'
>> +BROKEN_PATH_FIX = 's|^\# @@BROKEN_PATH_FIX@@$$|git_broken_path_fix $(SANE_TOOL_PATH_SQ)|'
>
> Aaargh! I totally managed to mess this split up. This line should *not* be
> touched by this patch.
>
> Will fix locally, in preparation for the next iteration.

Thanks for stopping me soon enough.  I am in the middle of picking
which ones should go 'next', as we can now start 'next' from the tip
of 'master'---hat I pushed out some time ago has master and next
with identical trees ;-)
