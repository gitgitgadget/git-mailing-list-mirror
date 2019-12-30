Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91573C2D0C3
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 21:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B51020658
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 21:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iC/sSy6p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfL3VtJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 16:49:09 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62050 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfL3VtJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 16:49:09 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 306633BFEC;
        Mon, 30 Dec 2019 16:49:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fo4he9hT1SxnuGfdriGDiJJNhNM=; b=iC/sSy
        6pwSB6cbs94VIu8FdZIrti8eJJLEfHeBauyKho900qQQMEwZho3mqlWbJnNk97v6
        dpK7BiSxjx7AQ/cBBnaIcukXv5nQJfTfnEmfBczw0FhvMVtUfdcOqTFE8Ldzj7S7
        VFFnEo/1tPsgIKWSZMpx0UWn9pPTUP+oMO1pY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JwnNYUljoV5w0NJDGjz5Oh1JA8mt9E7Q
        mMwFJEoiE9wMbhZnPug3iq0jzEnC2LjG8kUVra3DuGNsDJe+AC7D3Hg0adqza/ZV
        DdQkShWKGaWWOLSJQjbDNLgmG/AYywcdTW7lml2nU2C+IitFcZIw68wYfL/GOdCA
        /0/F5Ldecrw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 279AC3BFEB;
        Mon, 30 Dec 2019 16:49:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 791603BFEA;
        Mon, 30 Dec 2019 16:49:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 00/17] merge: learn --autostash
References: <cover.1571246693.git.liu.denton@gmail.com>
        <cover.1577185374.git.liu.denton@gmail.com>
Date:   Mon, 30 Dec 2019 13:49:05 -0800
In-Reply-To: <cover.1577185374.git.liu.denton@gmail.com> (Denton Liu's message
        of "Tue, 24 Dec 2019 06:04:57 -0500")
Message-ID: <xmqqo8vpfpri.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 33D2AF58-2B4E-11EA-B4AC-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Alban reported[1] that he expected merge to have an --autostash option,
> just like rebase. Since there's not really any reason why merge can't
> have it, let's implement it in this patchset.

Sigh.  

I would actually have preferred to remove the autostash from rebase
if the goal is to have a consistent behaviour between the two,
though ;-)

But it is OK as long as it does not degrade the codepath with
changes that wouldn't have been necessary if this weren't added.

Let's see how it goes.  Queued.
