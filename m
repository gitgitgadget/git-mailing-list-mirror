Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B2CC33C8C
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 16:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D65FF214D8
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 16:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PTIofF7J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgAGQiG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 11:38:06 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51561 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbgAGQiG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 11:38:06 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 887B596564;
        Tue,  7 Jan 2020 11:38:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gcC0vSMn0Xai4a9Nnl/InzCUQ4I=; b=PTIofF
        7JksPA9/x9qPOXqnElPYipYVmkau4uBRv8xuJ0VoClqKbr3R11xZAAqG89yZ1TR+
        laWoZHe6Xq0OIzxRtnqHyGBj6MeCbe5cdS0+E4zPo/T8a+yDdQsw1Q5n87TqF3UY
        4miWFcReixy5jjgmAMJ0Sv8yRR9CanNlMGTGc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sGrZTlOxlJkIQ3Kh+nBVvIUT8kcPZ38A
        jfzzY8unBV4nJMN/CIOCCtjQDcg5Znh+OT+BT/E9qhsJxbgCMixLMKvA0j3cIdqW
        i8VtDyhd8lrifh4IjWeMOti8/FCOIANsl9QtxULEgI8VBtgr8/l+2RzcyDek6nI0
        xSmrx8qCyus=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 80ADE96562;
        Tue,  7 Jan 2020 11:38:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8FD8E9655F;
        Tue,  7 Jan 2020 11:38:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/1] unpack-trees: exit check_updates() early if updates are not wanted
References: <pull.686.git.git.1578087730.gitgitgadget@gmail.com>
        <pull.686.v2.git.git.1578380277.gitgitgadget@gmail.com>
        <dd277273324eaba5e1f4a368bf2e4d046033c776.1578380277.git.gitgitgadget@gmail.com>
Date:   Tue, 07 Jan 2020 08:37:59 -0800
In-Reply-To: <dd277273324eaba5e1f4a368bf2e4d046033c776.1578380277.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Tue, 07 Jan 2020
        06:57:57 +0000")
Message-ID: <xmqq8smj6x3s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 11FA18FC-316C-11EA-A3AC-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> check_updates() has a lot of code that repeatedly checks whether
> o->update or o->dry_run are set.  (Note that o->dry_run is a
> near-synonym for !o->update, but not quite as per commit 2c9078d05bf2
> ("unpack-trees: add the dry_run flag to unpack_trees_options",
> 2011-05-25).)  In fact, this function almost turns into a no-op whenever
> the condition
>    !o->update || o->dry_run
> is met.  Simplify the code by checking this condition at the beginning
> of the function, and when it is true, do the few things that are
> relevant and return early.

Thanks; will queue.

