Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77F6ECAAA1
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 16:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiISQXx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 12:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiISQXv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 12:23:51 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DA532D93
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 09:23:50 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3B5D71CE932;
        Mon, 19 Sep 2022 12:23:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4Q4HLJ3tlOwg/diOrDYCB4NaYEZveWNhWEWBJj
        SoLpc=; b=ho1FsnIfB62me4eUj43peol+cYZMBYzD3tDgDwGQjwrUJE+LiU1/kH
        lKeSap1B+Fg4j3blDKYn2t23rEVk+9ehQjDInd9DbWx5LehlgOVrrwTFf1JeJrjn
        vZDfQ2LMADlm7l9KHa4SnafB/CW/ZHiwt7DIvYa2FoogWPEMwL5Ag=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 33EC21CE931;
        Mon, 19 Sep 2022 12:23:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C01EB1CE930;
        Mon, 19 Sep 2022 12:23:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     Erik Cervin Edin <erik@cervined.in>, git@vger.kernel.org
Subject: Re: [PATCH] sequencer: avoid dropping fixup commit that targets
 self via commit-ish
References: <YyZWDkZWAkS7q+Wf@gmail.com>
        <20220918121053.880225-1-aclopte@gmail.com>
        <xmqqh714dv7n.fsf@gitster.g>
Date:   Mon, 19 Sep 2022 09:23:44 -0700
In-Reply-To: <xmqqh714dv7n.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
        18 Sep 2022 18:11:24 -0700")
Message-ID: <xmqqleqfcoz3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6F2E1FC6-3837-11ED-958A-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Your solution looks somewhat surprising to me, as I would naively
> have thought to fix the use of _by_name() and limit its use only
> when the input token is all hexadecimal, or something.  I'd need to
> think more to convince myself why this is the right solution.

OK, we try to find what to amend with the current "fixupish" from
the todo slab, which by definition must be something that we have
already dealt with.  The current "fixupish" should not be found
because we haven't finished dealing with it, so delaying the
addition of the current one to the todo slab is a must.

There is no leaving or continuing the loop, other than an error
return that aborts the whole thing, that may break the resulting
todo slab in the normal case due to this change, either.  

The fix makes sense to me.  Will queue.

Thanks.
