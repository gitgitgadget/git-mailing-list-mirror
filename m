Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A656E1F461
	for <e@80x24.org>; Thu, 16 May 2019 23:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfEPXVN (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 19:21:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58958 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbfEPXVN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 19:21:13 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D5F4E155B59;
        Thu, 16 May 2019 19:21:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/yTSxTsH3AKBFvnX4yjjvWGO/rA=; b=Yq27I5
        eJHNgd5cy7AYXi7y5/F9cZifdD1qP4FnfYxMl88R++FYfyCkp0fMiBnnqHZxcZOb
        SlX+vn2K9S9d4uemwbknY13vjUKUpvTTZwI4BI5WcgxMDswvUW8rfBn4ZPMW+o5X
        jf4usDd19AWDqCEAqpXI+MKNKoWy4q677Ww8k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=x9rV/ZGn7tFEHd04rmFyqBs0imOOm9uW
        PCbx8wjKssUsbGo2BgwKYmb5yDQ/K9hNb7OzWO/zjMKFUZitF4DECO30mr/jN7oq
        c/mISCHy8+Itcwe2nDjuJb1U2/j+IFrQMnPF3hthr9R+jK6HInvVGTFh/gpKxrlP
        mUGsFdKYjeM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CE823155B58;
        Thu, 16 May 2019 19:21:10 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 416B4155B57;
        Thu, 16 May 2019 19:21:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Michael Osipov <michael.osipov@siemens.com>
Subject: Re: [PATCH] Makefile: remove the NO_R_TO_GCC_LINKER flag
References: <20190516093412.14795-1-avarab@gmail.com>
        <20190516180521.1933-1-avarab@gmail.com>
        <20190516222525.GC11784@sigill.intra.peff.net>
Date:   Fri, 17 May 2019 08:21:09 +0900
In-Reply-To: <20190516222525.GC11784@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 16 May 2019 18:25:25 -0400")
Message-ID: <xmqqd0ki3s0q.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4A103D92-7831-11E9-8C79-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Far be it from me to care about AIX, but it seems like this is ripe for
> regressions, because we don't know which platforms were relying on "-R"
> instead of "-Wl,-rpath", and now everybody will be using the latter by
> default.

I do not have a stake in AIX, either, but I had the same reaction.

Those who found having to give NO_R_TO_GCC_LINKER=NoThanks annoying
could have passed CC_LD_DYNPATH=-Wl,-rpath instead, but that is not
much shorter or sweeter X-<; with this change, they do not have to
do anything, but those who are broken can pass CC_LD_DYNPATH=-R to
unbreak it.  So it may not be the end of the world, but this move
certainly smells like robbing non-GCC users to pay GCC users to me.
