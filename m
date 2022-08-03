Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B892C19F2B
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 20:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238643AbiHCU1g (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 16:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236138AbiHCU1f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 16:27:35 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7245A2EC
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 13:27:33 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 64BA31AA0E8;
        Wed,  3 Aug 2022 16:27:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jIyLndIknpV+6AH5uJ0S1F/0htdLa2zAB2xNAE
        pmI/E=; b=OgBUqoWowNsPHqErMq91AbRLAw9pfwZHK/Do/3G+LBqcjGg8Hw1BM0
        O7gIAILBRe9QJcShq5VeYgUV21ZXBAF1DcGGuZtt6pHTs9xhYOKamATN8hzWHP2E
        GYiBsOAaJEoXwZHPexun4wir8DlHeMZt05++2Wk3QK1ImRmJtr5RI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5CF801AA0E7;
        Wed,  3 Aug 2022 16:27:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0BF6A1AA0E6;
        Wed,  3 Aug 2022 16:27:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Sun Chao via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Sun Chao <16657101987@163.com>
Subject: Re: [PATCH 0/3] refs-advertise: add hook to filter advertised refs
References: <pull.1301.git.git.1659543457.gitgitgadget@gmail.com>
Date:   Wed, 03 Aug 2022 13:27:28 -0700
In-Reply-To: <pull.1301.git.git.1659543457.gitgitgadget@gmail.com> (Sun Chao
        via GitGitGadget's message of "Wed, 03 Aug 2022 16:17:34 +0000")
Message-ID: <xmqq35ed9iof.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B2819BBE-136A-11ED-A670-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Sun Chao via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Gerrit is implemented by JGit and is known as a centralized workflow system
> which supports reference-level access control for repository. If we choose
> to work in centralized workflow like what Gerrit provided, reference-level
> access control is needed and is possible if we add a reference advertise
> filter hook just like what Gerrit did.

It may be one starting point, but is it sufficient to call it
"possible"?  The server side needs to tighten "fetch by object name"
to refuse to serve objects that are not reachable from any of the
refs advertised to the client requesting them.  IIRC, fetch protocol
v2 is wide open and does not limit the requests to those that are
only reachable from the advertised refs.

