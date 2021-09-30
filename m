Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD00C433EF
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 20:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23F7D61269
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 20:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344414AbhI3UI2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 16:08:28 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50897 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhI3UI2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 16:08:28 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 48A4B15C101;
        Thu, 30 Sep 2021 16:06:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Oh8uyoCVf3DZ9Kz3tggsFzDBlZmeUpMvNKViaH
        5yRac=; b=xmWlPus3BWp1X8OojzNbu2ZNnF9rr9azeUMcNFm1HAH9i8INEU3z2I
        8++8+jIeciYjPdQJewTZ7srErEBzJ7XEQg7PhkYuX30mA4Qtg95XKSZQrkCYRWEO
        84cGwtxGXuIQjMjaaQrSko/Fwk4BhluUKF/EivNuc7RDHZcvmP/9c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4077D15C100;
        Thu, 30 Sep 2021 16:06:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A472915C0FF;
        Thu, 30 Sep 2021 16:06:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH 5/7] tmp-objdir: new API for creating and removing
 primary object dirs
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
        <67d3b2b09f9ddda616cdd0d1b12ab7afc73670ed.1630376800.git.gitgitgadget@gmail.com>
        <YVOiggCWAdZcxAb6@coredump.intra.peff.net>
        <CABPp-BFuj3W20J-aKU4BL9cqgA-GPZ2prEbAebY_kR0adaGzHw@mail.gmail.com>
        <YVVmssXlaFM6yD5W@coredump.intra.peff.net>
        <YVVrY0/kXfWHCWJ1@coredump.intra.peff.net>
Date:   Thu, 30 Sep 2021 13:06:41 -0700
In-Reply-To: <YVVrY0/kXfWHCWJ1@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 30 Sep 2021 03:46:43 -0400")
Message-ID: <xmqqbl49bzfy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EE320FDC-2229-11EC-BE7D-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>   - is it possible for the merge code to ever write an object? I kind of
>     wonder if we'd ever do any cache-able transformations as part of a
>     content-level merge. I don't think we do now, though.

How is virtual merge base, result of an inner merge that recursively
merging two merge bases, fed to an outer merge as the ancestor?
Isn't it written as a tree object by the inner merge as a tree with
full of blob objects, so the outer merge does not have to treat a
merge base tree that is virtual any specially from a sole merge
base?
