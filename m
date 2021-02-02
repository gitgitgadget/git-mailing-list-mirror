Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296EAC433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 05:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFC8764ED9
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 05:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbhBBFuc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 00:50:32 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53987 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbhBBFu0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 00:50:26 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AFFE410AB5A;
        Tue,  2 Feb 2021 00:49:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=z0SkHkiMhj3AA/TdNm9oadCEwYI=; b=PqAsH6
        TlQu0WhKL2Yx1z9zI2VTFuNlaC5s5TD6G2+W19BRWGuwrXoLhMlNo63vB309U2rH
        apLjxuwmS95kS1K9XQxth0T/xX0ENcQp3pN15mRep5MS3+wQ0kMjjyIF+9km8twq
        50Zod1Q5nbSGZEZ+ztJugNDhre9q90QzRkWe4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HGn9M7CWp91W4x6bnwBfQqxwE5bmgRd3
        0ufLHI2d+v+7sEQZSr5Vuj/efGGMrWxBDG0l8PzUbhcResgL6pC4ZR3jvQzepXg9
        UE+ZJgB3OzG6dF6YCgG8NC2gB88E4WOuftnyNXp4eS52QAf83Z44AOqvhVzIt/cV
        NDKJ0kZoKxY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9C3F210AB59;
        Tue,  2 Feb 2021 00:49:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D2F7210AB57;
        Tue,  2 Feb 2021 00:49:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Vosmaer <jacob@gitlab.com>
Cc:     peff@peff.net, avarab@gmail.com, git@vger.kernel.org,
        jeffhost@microsoft.com, jonathantanmy@google.com
Subject: Re: [PATCH v5 0/1] upload-pack.c: fix filter spec quoting bug
References: <xmqqpn1ovi4j.fsf@gitster.c.googlers.com>
        <20210201202938.39576-1-jacob@gitlab.com>
Date:   Mon, 01 Feb 2021 21:49:40 -0800
In-Reply-To: <20210201202938.39576-1-jacob@gitlab.com> (Jacob Vosmaer's
        message of "Mon, 1 Feb 2021 21:29:37 +0100")
Message-ID: <xmqq8s87hvd7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 71DCBDDC-651A-11EB-9EF7-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Vosmaer <jacob@gitlab.com> writes:

> I updated the test based on the latest round of feedback.

Thanks, but this came a bit too late to wholesale replace the patch;
the previous round was good enough and is in 'next' already.

Looking at the change between two versions, I guess that the change
in tests may be worth salvaging, so perhaps you can make it into an
incremental "the test we added earlier was good, but let's make it
even better by doing X and Y" patch to be applied on top?

Thanks.




> Jacob Vosmaer (1):
>   upload-pack.c: fix filter spec quoting bug
>
>  t/t5544-pack-objects-hook.sh | 10 ++++++++++
>  upload-pack.c                |  9 +--------
>  2 files changed, 11 insertions(+), 8 deletions(-)
