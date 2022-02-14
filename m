Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C64AC433EF
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 21:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbiBNVus (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 16:50:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbiBNVup (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 16:50:45 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9CC198DA8
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 13:50:37 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AF79B16841B;
        Mon, 14 Feb 2022 16:50:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WGLUQp6vPRmavcwF6ijfLU0Knfez36WZCswjyt
        3IsmQ=; b=eSbaG8pYOBJd0DFgK96c2j9xHTC2MhMCU1Vsu6F0GgCVyBL3VLIQS+
        Per0L5Cpo3p6hW2yhTgsayjGVAEghMlF+KGQXES1a/HEm9EgmajR7rMWzcRCFJRT
        P/21TiGhxGP2jx7xcXHrxdIyCqhrcweGM2s3R2ZwKIRCcxB/Pgpb8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A890B16841A;
        Mon, 14 Feb 2022 16:50:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1358A168419;
        Mon, 14 Feb 2022 16:50:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] name-rev: test showing failure with non-monotonic
 commit dates
References: <20220214210136.1532574-1-jacob.e.keller@intel.com>
Date:   Mon, 14 Feb 2022 13:50:32 -0800
In-Reply-To: <20220214210136.1532574-1-jacob.e.keller@intel.com> (Jacob
        Keller's message of "Mon, 14 Feb 2022 13:01:36 -0800")
Message-ID: <xmqqr18515jr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 22FEA3FC-8DE0-11EC-9459-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> If a commit in a sequence of linear history has a non-monotonically
> increasing commit timestamp, git name-rev will not properly name the
> commit.
>
> However, if you use --annotate-stdin then the commit does actually get
> picked up and named properly.

IIRC, this is to be expected.

When preparing to answer --annotate-stdin request, the command has
to dig down to the root of the history, which would be too expensive
in some repositories and wants to stop traversal early when it knows
particular commits it needs to describe.

Dscho?  I think this is pretty much a fundamental part of the
initial version added by bd321bcc (Add git-name-rev, 2005-10-26) and
kept that way to this day, I think.

