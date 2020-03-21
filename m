Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BA3C4332E
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 04:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 192CD20757
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 04:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zu3NPWpO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbgCUE4U (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 00:56:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62323 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgCUE4T (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 00:56:19 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F05D53768;
        Sat, 21 Mar 2020 00:56:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+NVFJRp6uqJKLzxo36FN5ao6rP4=; b=Zu3NPW
        pOM4NRhiN+cRcYqT9ivM4gAQkZRx4v2zijZ0NaErAUD5YKibzB9wXavTxXv6OtPG
        e0YB3Kou6m5sK6rE1mKYlB64EpXrrylUp6HD4N955HceBhlf79v7hs+2D/o/IO0E
        dljdDaHPGIPfzzJdVmfB7kdIVRNUApG5yHeSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JhBqCnHnS8PWsYMrdOAT753tbtSfPF2S
        B4RUQsPbTqPDg0WsnAV/JdbkschbyYOpCoBwfX7FlQybbBDeIhOB3BBT7IjLnlhj
        JZ06HMoS1p+Y2gM4C5uPcSYkeQf1HZtLjokakTSKdN+4fU/GiP/RvoJAL0Nk77Wk
        enWbqCWpbPs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8779F53767;
        Sat, 21 Mar 2020 00:56:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 191D653765;
        Sat, 21 Mar 2020 00:56:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com
Subject: Re: [PATCH 0/1] commit-graph: avoid unnecessary tag deference when merging
References: <cover.1584762087.git.me@ttaylorr.com>
Date:   Fri, 20 Mar 2020 21:56:16 -0700
In-Reply-To: <cover.1584762087.git.me@ttaylorr.com> (Taylor Blau's message of
        "Fri, 20 Mar 2020 21:44:16 -0600")
Message-ID: <xmqqo8sq9uhb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4C5095E6-6B30-11EA-B6BE-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> This patch avoids an unnecessary tag dereference in
> 'merge_commit_graph()', which can improve the running time of a
> commit-graph write by around ~7.4% on average.

That I suspect depends heavily on what portion of your total
committishes consist of tags, no (in an absurdly extreme case, if
there is no tag in the repository, there won't be any improvement)?

What tag-vs-commit ratio is the above "average" number based on?

Thanks.
