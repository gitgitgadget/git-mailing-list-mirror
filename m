Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF71EEB562
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 17:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245439AbjIHRiz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 13:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245098AbjIHRiy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 13:38:54 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35651FCF
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 10:38:50 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 328281AECD9;
        Fri,  8 Sep 2023 13:38:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=7mcNDWgfsD8qmNRRCqxq8OBVY1RaWfobEihFO9
        0WN70=; b=YubOKtPZ9hZjd3nGOT+FH5BHai4FEmnD8IFTywuRzG7gXr5bdfpMcr
        gp3k/hhjMtvRri8yPLZu2CF3GagpISB1JKIfBfOcIRELHLDsrGl7zKhuDqN6+2DO
        juDPBJLiq90CQsxVZJECd/eyX3prUarjxxCGcan5cuwPLlSWxrx54=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2925B1AECD8;
        Fri,  8 Sep 2023 13:38:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8D8511AECD7;
        Fri,  8 Sep 2023 13:38:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Wong <e@80x24.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] start_command: reset disposition of all signals in child
In-Reply-To: <376d3ea0-a3eb-4b25-8bf2-ca40c4699e26@gmail.com> (Phillip Wood's
        message of "Fri, 8 Sep 2023 17:43:33 +0100")
References: <pull.1582.git.1694167540231.gitgitgadget@gmail.com>
        <xmqqedj8vfht.fsf@gitster.g>
        <ba69ab35-3204-4360-a36d-3253680b2479@gmail.com>
        <xmqqmsxwtyy3.fsf@gitster.g>
        <376d3ea0-a3eb-4b25-8bf2-ca40c4699e26@gmail.com>
Date:   Fri, 08 Sep 2023 10:38:48 -0700
Message-ID: <xmqq8r9gtviv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 91E2DDE2-4E6E-11EE-8FA2-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Oh I should have looked more carefully at the existing uses. It looks
> like it is only my sequencer patch that does
>
> 	sigchain_push(SIGINT, SIG_IGN);
> 	sigchain_push(SIGQUIT, SIG_IGN);
> 	res = run_command(...);

Hmph, does it mean this patch would become unnecessary, once you fix
the above sequence to follow the pattern "to spawn and then ignore"?
