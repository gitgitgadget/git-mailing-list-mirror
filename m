Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F10CD37B2
	for <git@archiver.kernel.org>; Sat, 16 Sep 2023 04:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbjIPEqG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Sep 2023 00:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbjIPEpp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2023 00:45:45 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C75173C
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 21:45:40 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 801AA1A4C94;
        Sat, 16 Sep 2023 00:45:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=4SiStYxiVCvo/W+Vo4LTrs1UTKrqr5UQFwD3jJ
        4aKCo=; b=oJ6JpTdiXTef3GZ3mjOa2ruTMH0zlzOq+mWci9JkeEhlZRtxNbQ49J
        D1Wax1N7ThI9c1Apg47KOcGfjkQwxi58FgPtLlmQcCRIotKtiWb0NEhoXl80EcBX
        o1M96Br5ggseX1NLvNxxu2DHucUj/AbVxv3dlVfH5d5KUpY31M0ZA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7797C1A4C91;
        Sat, 16 Sep 2023 00:45:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DDC051A4C90;
        Sat, 16 Sep 2023 00:45:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mark Levedahl <mlevedahl@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        me@yadavpratyush.com
Subject: Re: BUG: git-gui no longer executes hook scripts
In-Reply-To: <454d8b7b-96df-ec8f-2285-e022de66c66c@gmail.com> (Mark Levedahl's
        message of "Fri, 15 Sep 2023 19:33:55 -0400")
References: <bd510f6d-6613-413b-6d64-c3d2fd01d8a9@gmail.com>
        <xmqqa5tngynh.fsf@gitster.g> <xmqq5y4bgxy1.fsf@gitster.g>
        <454d8b7b-96df-ec8f-2285-e022de66c66c@gmail.com>
Date:   Fri, 15 Sep 2023 21:45:36 -0700
Message-ID: <xmqqil8ad8un.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E198FB5E-544B-11EE-89F0-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark Levedahl <mlevedahl@gmail.com> writes:

> I think a simpler fix is just to examine the number of path components
> - more than one means a relative or absolute command (/foo splits into
> two parts). The below works for me on Linux.

That is clever, but I cannot convince myself that it is not too
clever for its own sake.  The "pathtype" thing Dscho used in his
original is documented to be aware of things like "C:\path\name",
but I didn't re-read the Tcl manual page too carefully to know what
"file split" does for such pathname to be certain.

