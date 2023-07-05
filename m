Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C916C001B0
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 05:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjGEFaV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 01:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjGEFaT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 01:30:19 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B11E4
        for <git@vger.kernel.org>; Tue,  4 Jul 2023 22:30:13 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D28818383D;
        Wed,  5 Jul 2023 01:30:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=w1fuWMU384u9L4xuHvnkgbP/fRXIQ+g/7ZXVov
        QFbRE=; b=Wr3kvCPtqApxn/IJSyvI8Blr5GPQ4+uks1WHMGhgYziE8VpaV/t3ox
        noYgJM8QTAkV49R9SVwn+gAB3RuIQMLv5I/Rt66BdYIRcq7RSJEjtkso1aVhPP7T
        rsNyx/FPWR4oCNImpcKyOaHFpkUZDnpcBLzRdE7gDJWRlOZNTVFyw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9377318383B;
        Wed,  5 Jul 2023 01:30:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B9ECF18383A;
        Wed,  5 Jul 2023 01:30:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
        git@matthieu-moy.fr, christiwald@gmail.com, john@keeping.me.uk,
        philipoakley@iee.email
Subject: Re: [PATCH 0/2] advise about force-pushing as an alternative to
 reconciliation
In-Reply-To: <CAMMLpeS5QJrFFnN14n33_LiaN9MP5Ea=HV24ZFM30zPnmhoqZw@mail.gmail.com>
        (Alex Henrie's message of "Tue, 4 Jul 2023 16:24:00 -0600")
References: <20230702200818.1038494-1-alexhenrie24@gmail.com>
        <c3c36f93-3fc5-7f7d-1c24-e6925729cc96@gmail.com>
        <xmqqv8ez4ajb.fsf@gitster.g>
        <CAMMLpeS5QJrFFnN14n33_LiaN9MP5Ea=HV24ZFM30zPnmhoqZw@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date:   Tue, 04 Jul 2023 22:30:09 -0700
Message-ID: <xmqq5y6z3oym.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0296A5B2-1AF5-11EE-9FAB-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> I hope that's more clear now. Please let me know if it's not.

I think the description in the cover was prone to be misunderstood,
but I think I got it now.  Where you are pushing from your topic
branch is your "publishing" branch that only you would push into,
and the primary way you update it is by rebasing your local copy of
it on the updated 'master' branch to keep up with others' work
integrated into the shared 'master'.

In such a workflow, the way to update your "publishing" branch will
normally be to force push to overwrite.  And in this very narrow use
case, where nobody else is pushing into your "publishing" branch,
your remote-tracking branch would be always up-to-date with the
remote repository and use of --force-with-lease that does not say
which commit you expect there to be is safe.  In fact, you do not
even have to use --force-with-lease in such a use case, because its
additional safety (relative to --force) relies on the assumption
that you would be the only one who is pushing into the remote
repository to update that branch---and at that point, --force
without lease is just as good.

Thanks.
