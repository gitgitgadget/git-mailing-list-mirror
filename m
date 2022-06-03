Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315A5C433EF
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 21:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343944AbiFCVXs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 17:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiFCVXr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 17:23:47 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B542FE6E
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 14:23:46 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DFB42187C88;
        Fri,  3 Jun 2022 17:23:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hssyMOaGe6cNMBqkbofR0SJH/xYYoFHukquIoS
        Wxx2A=; b=HpelvnFIhyBreBNz3hWPIVeB0jPr5dxeiuw0ViHm7MFfNng3Pz0JQD
        KJ/JzcdG6Xc8c2bzFiNDKqR7hP9vdW3mj2TBw4qkV1s25HJLcEgnPLA8klhRXCib
        JIXZl+3lqmSJHkCv/AZEnByIVpjXhgvLp1C98ZoHwIuAHd+7gTKyk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D8548187C86;
        Fri,  3 Jun 2022 17:23:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8244A187C85;
        Fri,  3 Jun 2022 17:23:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/4] rebase: update branches in multi-part topic
References: <pull.1247.git.1654263472.gitgitgadget@gmail.com>
        <YppSl4rOvVciLuXE@nand.local>
        <9d2752dd-6029-e71a-4149-0641fea879fe@jeffhostetler.com>
Date:   Fri, 03 Jun 2022 14:23:41 -0700
In-Reply-To: <9d2752dd-6029-e71a-4149-0641fea879fe@jeffhostetler.com> (Jeff
        Hostetler's message of "Fri, 3 Jun 2022 15:59:00 -0400")
Message-ID: <xmqqmtetcug2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 71774842-E383-11EC-9494-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> I agree. I could have really used this while juggling all of the
> parts of FSMonitor recently.  And yes, it should write the updates
> at the bottom in case of an abort.
>
> Should this take a branch pattern/regex to limit the set of branches
> that are updated (or offered to be updated)?  For example, if I have
> an intermediate commit in the series that has 2 branch names pointing
> at it, do we want to offer to update both of them or only the one
> that matches some pattern related to the tip?  Or is it sufficient to
> just enumerate them at the bottom of the todo list and let the user
> delete the lines they don't want?

The latter sounds sufficient (starting from something simpler should
work well in this case).

> Should we actually do the update-ref's or should we write a script
> that lets the user do it later?  The latter would let us also write
> out the commands to force update the remote refs if that would be
> helpful.

Aren't we writing "a script" already by implementing it as an
additional "exec git update-ref" in the todo list already?  I
found that, combined with the idea to use the "label" Taylor
mentioned, was the most brilliant part of this proposal.

