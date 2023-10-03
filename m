Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2E6E8FDBF
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 23:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjJCXLL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 19:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjJCXLK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 19:11:10 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF319E
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 16:11:03 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AD4692E46E;
        Tue,  3 Oct 2023 19:11:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=XjIfYt6k33pKozx7bBseMQRFzn79R4vrR9E4TC
        38Ot8=; b=h4uoD4sLyYnYmfSBhzvOb0BlosmZixftLG6dNCOlRndI3F1x9b9PUS
        A+ojnM3tSRd4GppEBmdhI6M/3QEGG3Fm9QTSTsX0F2bAIBWHcDAXojUfakwe5OtZ
        leGpPv0ZP1IClcrzvtj1jaJj04spOnKylv/BE7RB1voSDdHugxA24=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A618D2E46D;
        Tue,  3 Oct 2023 19:11:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3C4A42E46A;
        Tue,  3 Oct 2023 19:10:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/6] submodule--helper: return error from set-url when
 modifying failed
In-Reply-To: <20231003185047.2697995-2-heftig@archlinux.org> (Jan Alexander
        Steffens's message of "Tue, 3 Oct 2023 20:50:43 +0200")
References: <0a0a157f88321d25fdb0be771a454b3410a449f3.camel@archlinux.org>
        <20231003185047.2697995-1-heftig@archlinux.org>
        <20231003185047.2697995-2-heftig@archlinux.org>
Date:   Tue, 03 Oct 2023 16:10:57 -0700
Message-ID: <xmqqsf6ruwse.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1D37D532-6242-11EE-8175-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jan Alexander Steffens (heftig)" <heftig@archlinux.org> writes:

> set-branch will return an error when setting the config fails so I don't
> see why set-url shouldn't. Also skip the sync in this case.

Two other failures in this helper function gives end-user readable
message (parameter errors are greeted with usage, giving wrong path
is greeted with a die()), but this new error condition will silently
die unless config_set_in_gitmodules_file_gently() complains.

I wonder if we should give an error message in this case, too.

In any case, not calling sync after failed set_in_gitmodules is a
sensible design decision.
