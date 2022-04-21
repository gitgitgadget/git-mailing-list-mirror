Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D6BC433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 21:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442019AbiDUVge (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 17:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbiDUVg2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 17:36:28 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B2A49F9B
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 14:33:37 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 491FC1962CB;
        Thu, 21 Apr 2022 17:33:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1k1Ni7FBvGAUcz5I8NbOm2yt24Fi3gFgGBJcnz
        JUmrA=; b=GBbhW8CL4n5xcaGnieNVs2Kj8Y04EacxEmke/OrT2lqY+cLwNDpyaE
        GhxgtExjcE/Twq7yrozkgsljSXTYgFaa1c+wWyvnldEdEjAyogJ9J3GSSpKRUste
        mXEhD34bWeXL8gENoAKPuL0QTakfc8NE5/dedG8APz6U6vq0JrIps=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4105E1962CA;
        Thu, 21 Apr 2022 17:33:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BB2081962C9;
        Thu, 21 Apr 2022 17:33:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Thomas Koutcher via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Thomas Koutcher <thomas.koutcher@online.fr>
Subject: Re: [PATCH 0/2] diff- family --stat width
References: <pull.1256.git.git.1650572159.gitgitgadget@gmail.com>
Date:   Thu, 21 Apr 2022 14:33:32 -0700
In-Reply-To: <pull.1256.git.git.1650572159.gitgitgadget@gmail.com> (Thomas
        Koutcher via GitGitGadget's message of "Thu, 21 Apr 2022 20:15:57
        +0000")
Message-ID: <xmqqczhaf7f7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B21AC9AE-C1BA-11EC-A971-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Thomas Koutcher via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff- family commands do not use the full terminal width. This is visible in
> Tig which uses git diff-files to show diffs for unstaged changes. When
> trying to display diffs with long filenames, the diffstat does not improve
> when the Tig window size is increased.
>
> This patch makes diff-files, diff-index and diff-tree --stat behave like
> diff --stat and use the full terminal width. The handling of the config
> option diff.statGraphWidth is also added.

I do not think it is a good move to change the output from these
plumbing commands, whose purpose of existence is to give more
predictable outcome, to be affected by dynamic elements like the
width of the terminal the user happens to be using.

A program or script that spawns the plumbing commands should be able
to pass --stat=<width>, --stat-graph-width=<width> etc. to control
its behaviour without affecting (and possibly breaking) what other
programs have been depending on for the last 15+ years.

Thanks.
