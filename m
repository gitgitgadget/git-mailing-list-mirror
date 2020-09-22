Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261DDC4363D
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 17:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9ED22376F
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 17:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vG0m6SxY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgIVRzS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 13:55:18 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58440 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgIVRzS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 13:55:18 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8E105103C8B;
        Tue, 22 Sep 2020 13:55:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LxCWRFlY9Vr5CmoCaYd+8sulTiE=; b=vG0m6S
        xYflBFBz/To2LC+zur6Mw3LrFqe5I1AncTBB3GMYRH/vmAyI6ZjY0PJPLXdJJ1Uu
        jAlx51419aQbbUkYNkj8kcYQx88fN8Npfvj2uH7yn3dH7PV5sv6BLwFpTHncuBJi
        r1Vo+y6+4wshkZX5bWaFL6LaC35bIMcNcWFII=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iXWnSkATy6waK33t5GUGbuDpJ3U7PmEZ
        mxhgZS5cmQD1oaff6J/jzMCxL33/VM8KtImF6DRLc2QXqW9cbZzIZklPD2YVQcTs
        TKieuHQ0QeJHuFlGBg4jC9Nuau5RU0yiYZvVyRF6YgR1+UDBJSI0kVSWSzT7lS3C
        MgLkfyYYvJU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 74B73103C8A;
        Tue, 22 Sep 2020 13:55:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B5CD5103C87;
        Tue, 22 Sep 2020 13:55:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "Chris. Webster via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, "Chris. Webster" <chris@webstech.net>
Subject: Re: [PATCH] ci: github action - add check for whitespace errors
References: <pull.709.git.1600759684548.gitgitgadget@gmail.com>
        <20200922170745.GA541915@coredump.intra.peff.net>
Date:   Tue, 22 Sep 2020 10:55:11 -0700
In-Reply-To: <20200922170745.GA541915@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 22 Sep 2020 13:07:45 -0400")
Message-ID: <xmqq1ritlmrk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C3F20C7A-FCFC-11EA-BEF7-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>  - this will run only on PRs. That's helpful for people using
>    GitGitGadget, but it might also be useful for people just running the
>    CI by pushing branches, or looking at CI builds of Junio's next or
>    seen branches. Could we make it work there? Obviously we wouldn't be
>    able to rely on having PR data, but I wonder if "git log
>    HEAD..$branch" would be sufficient.

Yes, I like that very much.  If a push triggers a CI run to notice
whitespace breakage and other mechanically detectable errors, that
would prevent embarrassment before even a pull request is opened.

For me, 'next' is way too late to catch mechanically detectable
errors, but an extra set of eyes, even mechanical ones, on the tip
of 'seen' is always appreciated.

Thanks.
