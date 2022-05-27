Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB38EC433F5
	for <git@archiver.kernel.org>; Fri, 27 May 2022 19:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354550AbiE0T7h (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 15:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiE0T7g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 15:59:36 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A41411157
        for <git@vger.kernel.org>; Fri, 27 May 2022 12:59:34 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 402661A6F60;
        Fri, 27 May 2022 15:59:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EMuigCyRaTTMbk88eA3Iwvylo1+ewaJDDHnLGU
        NF3r0=; b=QYkBO0//dUxUJD119x0FtUn+J7PUftl1TKWsEV7Y7DXUXCIYvIYoXs
        fYYvOG9lldfPUwCvkymUVWdvtKZqrJJw0WkgNUE4VHvcCXyQsilBzaMzH7IZ83oR
        GSJrmRzM4a9QNLfk2FF8sxnbdETKOwiuXaUj6YitMPfRQVDn1yVtU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3989A1A6F5F;
        Fri, 27 May 2022 15:59:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 991651A6F5E;
        Fri, 27 May 2022 15:59:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org,
        derrickstolee@github.com, newren@gmail.com
Subject: Re: [WIP v2 5/5] mv: use update_sparsity() after touching sparse
 contents
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
        <20220527100804.209890-1-shaoxuan.yuan02@gmail.com>
        <20220527100804.209890-6-shaoxuan.yuan02@gmail.com>
        <077a0579-903e-32ad-029c-48572d471c84@github.com>
Date:   Fri, 27 May 2022 12:59:29 -0700
In-Reply-To: <077a0579-903e-32ad-029c-48572d471c84@github.com> (Victoria Dye's
        message of "Fri, 27 May 2022 12:36:13 -0700")
Message-ID: <xmqq8rqm3fxa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 85671378-DDF7-11EC-AC74-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

> Note that you'll also probably need to check out the file(s) (if moving into
> the cone) or remove them from disk (if moving out of cone). If you don't,
> files moved into cone will appear "deleted" on-disk, and files moved
> out-of-cone that still appear on disk will have 'SKIP_WORKTREE'
> automatically disabled (see [1]).

Does it also imply that we should forbid "git mv" of a dirty path
out of the cone?  Or is that too draconian and it suffices to tweak
the rule slightly to "remove from the worktree when moving a clean
path out of cone", perhaps?  When a dirty path is moved out of cone,
we would trigger the "SKIP_WORKTREE automatically disabled" behaviour
and that would be a good thing, I imagine?

