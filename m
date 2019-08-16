Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72CE11F45A
	for <e@80x24.org>; Fri, 16 Aug 2019 22:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbfHPWBa (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Aug 2019 18:01:30 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61132 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727696AbfHPWBa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Aug 2019 18:01:30 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 598EA7F4B0;
        Fri, 16 Aug 2019 18:01:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qk5TUMs4DSZcepW2JRGJtNNAeNo=; b=KBktSF
        0+L8eC60jIi2HS0wirsLaFuoMD1vSQRemBWpcLFllLwh1k1y/jUGYZE3cWc6elz9
        /9g0Aj4pEsVe05Tt1uArMFf/RD1yZS+rkMyIgh8itlFWnCs43q9R4IyU9aMH2SHm
        Qog7ljACOufMg/+18sypy0KEnw2YnoIMnV6EY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mz2EbcFhIEqmEiLf/TO1H1TnSLDACGx2
        zhEK3Khmhdmj8ODly2/O/EO6SBlYfUS0unWv/wYS2P3lp8QmxAXJyEO2mNhRySn/
        HkiEUFMslx/MXTjrGAWkSyz9f0IgvKXOg9tcQxWX/HNHCt5sBFsO7ED8PPRkkxaM
        TFU5Oo0+Uwo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 52C417F4AF;
        Fri, 16 Aug 2019 18:01:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7FBB17F4AE;
        Fri, 16 Aug 2019 18:01:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 12/24] cache-tree: share code between functions writing an index as a tree
References: <20190726155258.28561-1-newren@gmail.com>
        <20190815214053.16594-1-newren@gmail.com>
        <20190815214053.16594-13-newren@gmail.com>
Date:   Fri, 16 Aug 2019 15:01:24 -0700
In-Reply-To: <20190815214053.16594-13-newren@gmail.com> (Elijah Newren's
        message of "Thu, 15 Aug 2019 14:40:41 -0700")
Message-ID: <xmqqlfvszs5n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 64BBE26C-C071-11E9-B2FA-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> write_tree_from_memory() appeared to be a merge-recursive special that
> basically duplicated write_index_as_tree().  The two have a different
> signature, but the bigger difference was just that write_index_as_tree()
> would always unconditionally read the index off of disk instead of
> working on the current in-memory index.  So:
>
>   * split out common code into write_index_as_tree_internal()
>
>   * rename write_tree_from_memory() to write_inmemory_index_as_tree(),

Somewhat minor, but I find "inmemory_index" hard to see while
scanning the patch.  Perhaps call it "in_core_index" instead?

I originally started the above with "Very minor, ...", but as this
is exposed to the public in a header file, the name matters a bit
more than that.
