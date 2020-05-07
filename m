Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA04C35280
	for <git@archiver.kernel.org>; Thu,  7 May 2020 23:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D51220CC7
	for <git@archiver.kernel.org>; Thu,  7 May 2020 23:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ErV+K0NK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgEGXl7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 19:41:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61321 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgEGXl7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 19:41:59 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 15C06550FB;
        Thu,  7 May 2020 19:41:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zfhjBXslIf0QA1oBlFSjySFcAKw=; b=ErV+K0
        NK756kUDTeamnwuOxSl0QfwvMrH2RjtdCQdRWsuCTNtKW+/6xgdv7C0t8VRGOnOC
        g4hf645BjnwoY6sB/dzKbdcvhJR9GggNKGxFWhuUMELL8cXC6OtNGcyz40163Ky3
        jA+Jb6hTW/7WxxSkJYppmH+Z543nLr36hrsUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SLwavK+tRN7nYD0mZ3a5DsaKBtI1v4wl
        satl/hYi//3GxFlU/kSU7GbtRawzaek9t6GnEtgNqd2cGYM4vvX+dde26NFO66Fp
        kwAh/olJ4dw6wZcU4HMm3co78jpt4ohi3Fa+kM/nV2GdxKWtxHp+Ax7hQDrXGZ4v
        MCZR7//9Aao=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D809550FA;
        Thu,  7 May 2020 19:41:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 95708550F9;
        Thu,  7 May 2020 19:41:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alexander Mills <alexander.d.mills@gmail.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org
Subject: Re: check if one branch contains another branch
References: <CA+KyZp7TELrswPjNgB99BXXHEXi5pRr5bO3g_wy7zBvv1R4Kww@mail.gmail.com>
        <06da01d624c7$acb17090$061451b0$@nexbridge.com>
        <CA+KyZp7Ur3kW3qrCe3hOz16gA9y_B7rSGin62=eKMjCCqLsR4w@mail.gmail.com>
Date:   Thu, 07 May 2020 16:41:56 -0700
In-Reply-To: <CA+KyZp7Ur3kW3qrCe3hOz16gA9y_B7rSGin62=eKMjCCqLsR4w@mail.gmail.com>
        (Alexander Mills's message of "Thu, 7 May 2020 16:37:34 -0700")
Message-ID: <xmqqwo5n1fej.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 566A83B4-90BC-11EA-BDA9-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alexander Mills <alexander.d.mills@gmail.com> writes:

> I assume that:
>
> git branch -d  xxx
>
> will prevent a delete if the current branch doesn't contain xxx..
> I don't want to have to checkout  origin/dev in order to run that command,
> that's one part of the problem

In that case, don't you want to learn, not just if your 'dev' has
anything that is not merged/accepted by origin/dev, what commits
in 'dev' are not yet merged in origin/dev?

 $ git log origin/dev..dev

would show them.

