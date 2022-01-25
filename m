Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A59C433EF
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 07:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443689AbiAYHQS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 02:16:18 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53889 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443166AbiAYHN3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 02:13:29 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1015310EC5E;
        Tue, 25 Jan 2022 02:13:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=IBN//l3lzUBiVU/SHYSjVtM/ixpIdHOjPbKSOA1U2Hc=; b=PxeN
        80xRRkaaAju81cVKqx9MNu/taI0hhunFcVP8Qs6JGyt33tpkNFl/pZ/fgMnBBZDf
        8VCxOpzdPykAuEtyC1tdfqAp4BdhuQg39wDF+Kez0rD5f3QT8CofMt/ZxgvcrIB+
        YPCL/LuXAL7nMx/bZYhCz+ErThqc18iwBYaU5v8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0760010EC5D;
        Tue, 25 Jan 2022 02:13:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6557510EC5C;
        Tue, 25 Jan 2022 02:13:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Kraymer <kraymer@gmail.com>,
        Daniel Hahler <git@thequod.de>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] stash: strip "refs/heads/" with skip_prefix
References: <YYwxVO7A29FcN+hN@coredump.intra.peff.net>
        <20220124205342.41450-1-chooglen@google.com>
Date:   Mon, 24 Jan 2022 23:13:25 -0800
Message-ID: <xmqq7dao1e5m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4A34220E-7DAE-11EC-8157-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

>  	branch_ref = resolve_ref_unsafe("HEAD", 0, NULL, &flags);
>  	if (flags & REF_ISSYMREF)
> -		branch_name = strrchr(branch_ref, '/') + 1;
> +		skip_prefix(branch_ref, "refs/heads/", &branch_name);

The branch_name variable is initialized to a constant string "(no branch)",
so if HEAD is poihnting elsewhere (which you could do manually),
skip_prefix() would fail and leave branch_name intact, which would
give us the desirable outcome, too.

Looking good.
