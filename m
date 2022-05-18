Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124C8C433F5
	for <git@archiver.kernel.org>; Wed, 18 May 2022 15:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239608AbiERPv1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 May 2022 11:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239602AbiERPuy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 May 2022 11:50:54 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DF323177
        for <git@vger.kernel.org>; Wed, 18 May 2022 08:50:51 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4101C1375CF;
        Wed, 18 May 2022 11:50:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/jU5VIvSeLtZ8TcCtU/aFb6T0Ru/Hx4mxvCSpj
        rvx0Q=; b=tlYyPa6gpgTvX0p6ez2R04J1jpJnNQT5IYk/KkgfCX/H1yIe/7HvMh
        ZhP8V4YUGThUnZ2Bou4SH1LBmOzyd5Kk8QvoCle+IvoCtASojufyeVbPRjqH/vFX
        zXCpQRCI812PrXf1NCpQYXNnAW3zSaC0oOnfWDWq1ZAATYv984I+k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 37AFD1375CE;
        Wed, 18 May 2022 11:50:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 784F91375C9;
        Wed, 18 May 2022 11:50:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Orgad Shaneh <orgads@gmail.com>
Cc:     Orgad Shaneh via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH v2] fetch: limit shared symref check only for local
 branches
References: <pull.1266.git.git.1652690275625.gitgitgadget@gmail.com>
        <pull.1266.v2.git.git.1652690501963.gitgitgadget@gmail.com>
        <xmqqv8u54gcm.fsf@gitster.g>
        <CAGHpTBJDeOMCfv36Sey1tGadQThS8mGR00YiK4C16BbV==W8XQ@mail.gmail.com>
        <xmqqtu9oxxmv.fsf@gitster.g>
        <CAGHpTBK_K+GK5z3XD-7ob7JPLrUnohfMCRVD2wrwbMhDyy3TEw@mail.gmail.com>
Date:   Wed, 18 May 2022 08:50:46 -0700
In-Reply-To: <CAGHpTBK_K+GK5z3XD-7ob7JPLrUnohfMCRVD2wrwbMhDyy3TEw@mail.gmail.com>
        (Orgad Shaneh's message of "Tue, 17 May 2022 13:41:14 +0300")
Message-ID: <xmqqilq2yh49.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 48CE852C-D6C2-11EC-B6DE-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Orgad Shaneh <orgads@gmail.com> writes:

> This would require shuffling the code. check_not_current_branch() is
> called by do_fetch before fetch_and_consume_refs (which updates
> ref->old_oid and ref->new_oid).

Oh, that's unfortunate.

We may not be matching them with the current values of the local
copies in ref_map in today's code until fetch_and_consume_refs()
calls store_updated_refs() to update the .new_oid member, but I
would have thought that we learned the equivalent of "git ls-remote"
output a lot earlier, at least most of the time, via a call to
transport_get_remote_refs(), and that was why I thought such an
optimization was doable.

Thanks.  
