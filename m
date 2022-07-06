Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689F9C433EF
	for <git@archiver.kernel.org>; Wed,  6 Jul 2022 17:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbiGFRbj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jul 2022 13:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233863AbiGFRbi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jul 2022 13:31:38 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCFC26557
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 10:31:37 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E2A431B0E79;
        Wed,  6 Jul 2022 13:31:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hrZZWP93i0jz8AwWb3ARJktSCaDZEnM25rYX5e
        84Q7o=; b=Jq0GVvJ/MsOo3nZJJnVAcNtpeYcQ2IZsxqxKQGMcZDSBFdLUQtAXab
        FnskjCUnU1V/HjQeynn7PdoN7sHte3FQ8EZ46z4C+b9t8fuVEJ2NjGvH5/QJPe0J
        DAYvvvpkwCA+9e/aEMAibfPoX4P8SNcivfBYq2d5B2pr3Hnx93wKE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D9E321B0E78;
        Wed,  6 Jul 2022 13:31:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8445B1B0E77;
        Wed,  6 Jul 2022 13:31:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Konstantin Khomoutov <kostix@bswap.ru>,
        wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>, git@vger.kernel.org
Subject: Re: How to display "HEAD~*" in "git log"
References: <17411d88-b27a-2d20-623d-85c49dc7754e@mails.ucas.ac.cn>
        <20220705092514.hsm7cou5bqvajvgq@carbon>
        <YsWebbaOJbaOZ6i7@coredump.intra.peff.net>
Date:   Wed, 06 Jul 2022 10:31:32 -0700
In-Reply-To: <YsWebbaOJbaOZ6i7@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 6 Jul 2022 10:38:37 -0400")
Message-ID: <xmqqo7y2i1vv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7AC55B0E-FD51-11EC-843E-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> And finally, if you really like this, you can configure git-log's pager
> to always pipe through name-rev, like this:
>
>   [pager]
>         log = "git name-rev --stdin | less"

I was about to suggest "name-rev --annotate-stdin" (which happened
during your sabbatical) but this is even better.

> ... (and I
> wouldn't be surprised if it's a little challenging, just because you'd
> have two traversals going on at once in the same program).

A little challenging ;-)

But it may not be so bad.  The "name-rev" traversal uses none of the
usual "revision" traversal machinery and keeps track of its state in
its own commit slab.  It would not be as hard as running two usual
revision traversals simultaneously.
