Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF88C433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 16:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245471AbiEYQca (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 12:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiEYQc2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 12:32:28 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B2037A35
        for <git@vger.kernel.org>; Wed, 25 May 2022 09:32:28 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 82329188BFA;
        Wed, 25 May 2022 12:32:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9Shh+un6LLOglyXzNcdHh5i/pBsHPpO7u8MLQk
        Sfy9s=; b=FFpQ+QSGNAtsfKd+7MytO17YM494vWOuhHmNSws2222uVRlsHFnJ3u
        G8bPXcZltyrAmlhDVeydONqfeDd8ioOw9lGiJsdTOJaOblI3DVV+EEiuIaGf6/rc
        n6fifpSOw12c4SGfLRtw6ADIDNSF/tOuknNzizEXGDUZm/ainw7W8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7AF10188BF9;
        Wed, 25 May 2022 12:32:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2DEEB188BF8;
        Wed, 25 May 2022 12:32:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 08/10] sparse-index: complete partial expansion
References: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
        <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
        <ed640e3645ba4f60f06bd335b9ac7bf350dd81f9.1652982759.git.gitgitgadget@gmail.com>
        <xmqqsfp3coqy.fsf@gitster.g>
        <5909f466-c323-0874-b175-51fe5e93dc12@github.com>
        <xmqqv8tvlvao.fsf@gitster.g>
        <f0327fd6-f2b3-64b6-3a34-2a7bbad20a01@github.com>
Date:   Wed, 25 May 2022 09:32:23 -0700
In-Reply-To: <f0327fd6-f2b3-64b6-3a34-2a7bbad20a01@github.com> (Derrick
        Stolee's message of "Wed, 25 May 2022 10:26:41 -0400")
Message-ID: <xmqq35gxa7zc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 41D718F2-DC48-11EC-94C9-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> If a user is in a conflict state and modifies their sparse-checkout
> cone, then we will hit this "recompute the cache-tree" state, fail,
> and cause full index expansion. I think that combination (have a
> conflict AND modify sparse-checkout cone) is rare enough to not
> optimize for (yet).
>
> Does that make the situation more clear?

Yes.  "AND modify sparse-checkout cone" part was what I was missing.
I didn't see it because it wasn't there at all in the code that was
removed or added---it comes from the fact that the user is running
the "sparse-checkout" command in the first place, and that was what
I missed.

Thanks.
