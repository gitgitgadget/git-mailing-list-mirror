Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A83C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 21:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06AC660232
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 21:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238706AbhH3V77 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 17:59:59 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51215 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbhH3V76 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 17:59:58 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 87E2614F5F3;
        Mon, 30 Aug 2021 17:59:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=l/et3i1NEbXHW+0VgjXe8By7ttGKwndswPgsSP
        MJDJI=; b=nFrUBdcr+Li+t5UDz7bYa3LoXU5xB6OxRctnVA90FrZ2CRJcp9pAU8
        xVKGQ/yCxyKkhtiejUarsvUY657C1SWpANa/Zc5O8s+CjBMjQT51qyKVE07QdSI4
        yT23tI+t9C8ZwK8CzBSSP+zbpoB8oc+PnchB8HLRHfszjtNQ4BdtA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8074014F5F2;
        Mon, 30 Aug 2021 17:59:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BFFE614F5EC;
        Mon, 30 Aug 2021 17:59:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 1/4] test-ref-store: tweaks to for-each-reflog-ent format
References: <pull.1067.git.git.1630334929.gitgitgadget@gmail.com>
        <d48207d6858502f04fd501a24ff7c2a80062dfbe.1630334929.git.gitgitgadget@gmail.com>
        <xmqqpmtu3bbn.fsf@gitster.g> <YS1GXNoPgjIjO3B7@nand.local>
Date:   Mon, 30 Aug 2021 14:59:00 -0700
In-Reply-To: <YS1GXNoPgjIjO3B7@nand.local> (Taylor Blau's message of "Mon, 30
        Aug 2021 16:58:04 -0400")
Message-ID: <xmqqv93m1tnf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7C369E34-09DD-11EC-9269-9BA3EF469F85-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> Shouldn't we be instead making sure that the callback functions get
>> the msg argument in a consistent way, whether it is with or without
>> terminating LF, instead of forcing the callers to cope with the
>> differences like this each_reflog() function does in this patch?
>
> ...that is a much more sensible resolution than what I saw in this
> patch. (At the very least, strchr is confusing since we don't expect LF
> characters anywhere in the reflog message, and this is really dealing
> with how the callback is invoked, not the actual bytes-on-disk).
>
> I would probably prefer that the callback be standardized to either
> always or never give a trailing LF.

True, and I agree that the use of LF by on-disk reflog storage
format is just as the record terminator, so I do not mind if we
decide to standardize on a single incomplete line without LF.

Thanks.

