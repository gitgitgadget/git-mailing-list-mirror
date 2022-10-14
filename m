Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23394C4332F
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 21:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiJNVRb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 17:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiJNVRX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 17:17:23 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A28F9861
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 14:17:20 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4BD341C2308;
        Fri, 14 Oct 2022 17:17:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=M1SMDhzb/CrLHvMcAir6wlWXXjoJdBdmvL0i47
        dove0=; b=XddbNq9FIAlAOoHfMHI53HUptbN2zQZFsQMVqt7MfawDa82Q5V8bx3
        9PFlrENQhzFS/ALNrQAE1REGP/hMZ4K9CaMLzcya3aQazdzY/3HKhaFYSsA6rUpW
        Zb/zUDGR/8fZ7RLqrA93T08h3xsHSIXv3ERUjmKkaez8EHU54wqnw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 45F8F1C2306;
        Fri, 14 Oct 2022 17:17:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7E05C1C2305;
        Fri, 14 Oct 2022 17:17:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jerry Zhang via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jerry Zhang <jerry@skydio.com>
Subject: Re: [PATCH v3 4/7] patch-id: fix patch-id for mode changes
References: <pull.1359.v2.git.1663654859.gitgitgadget@gmail.com>
        <pull.1359.v3.git.1665737804.gitgitgadget@gmail.com>
        <6e07cfd56917db16a281e06118cce312eb39a488.1665737804.git.gitgitgadget@gmail.com>
Date:   Fri, 14 Oct 2022 14:17:16 -0700
In-Reply-To: <6e07cfd56917db16a281e06118cce312eb39a488.1665737804.git.gitgitgadget@gmail.com>
        (Jerry Zhang via GitGitGadget's message of "Fri, 14 Oct 2022 08:56:41
        +0000")
Message-ID: <xmqqilkm6r6r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 94EACD0E-4C05-11ED-856F-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jerry Zhang via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Currently patch-id as used in rebase and cherry-pick does not account
> for file modes if the file is modified. One consequence of this is
> that if you have a local patch that changes modes, but upstream
> has applied an outdated version of the patch that doesn't include
> that mode change, "git rebase" will drop your local version of the
> patch along with your mode changes.

Hmph, it may be a feature and a curse depending on the phase of the
moon and what you are using the patch-id computation to see if you
already have an identical change.  But attempting to apply a patch
after applying the same patch with different mode bits will likely
do either the right thing (i.e. taking the mode changes only) or
result in conflict to draw human attention, so this change is a
definite improvement over possibly dropping a change silently.

Good.

