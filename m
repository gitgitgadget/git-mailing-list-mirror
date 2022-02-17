Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A593EC433F5
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 21:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245609AbiBQVGZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 16:06:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245142AbiBQVGT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 16:06:19 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE13165C1D
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 13:06:01 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 09417186A3B;
        Thu, 17 Feb 2022 16:06:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=DejfjpYks0xJmhX8mRVmdajJe5cvKWGXplwJWiDrRnE=; b=XZgJ
        UGs4b/ToLte8syNg6KgRNd14nMUsUE46YS2x7G9buoHVRWLI4rwvzYQ0t6+LaZX0
        iqUtq0Bs6u8+Tr/8epR4SDuxoqEi4h0YigyuKsTHyfu3WbZm7U0Ei3c7iGTwPh82
        Ac9gyOIuM0KVENmwf8cISObIKFx7fV+voFdeFrQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 00CD9186A3A;
        Thu, 17 Feb 2022 16:06:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 06035186A37;
        Thu, 17 Feb 2022 16:05:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     git@vger.kernel.org
Subject: Re: Supporting --depth when cloning from a bundle
References: <20220216220710.td4vp6mile5m6hjn@meerkat.local>
        <xmqqzgmqbfq7.fsf@gitster.g>
        <20220217141910.oaa6i4lvnotrbecq@meerkat.local>
Date:   Thu, 17 Feb 2022 13:05:55 -0800
Message-ID: <xmqq7d9t8aq4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6695B7CA-9035-11EC-883A-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> Sorry for the potentially stupid follow-up question. I know that git makes a
> distinction when cloning locally between a direct path and a file:// URL (e.g.
> it's only possible to do a shallow clone from a local repository when using
> the file:// scheme).

The local optimization uses hardlinks into an existing repository
bypassing most of what makes Git Git, and there is no negotiation.

"clone --no-local $PATH" or "clone file://$PATH" runs the "server
side" inside $PATH and talks with it, which is ONLY possible because
$PATH is a real repository.  A bundle file is not a repository, and
nobody has written the "server side" to workin inside it, so...
