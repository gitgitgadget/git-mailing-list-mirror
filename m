Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995C0C433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 21:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D89664F92
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 21:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbhBBVYy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 16:24:54 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56362 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbhBBVYi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 16:24:38 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 42066111737;
        Tue,  2 Feb 2021 16:23:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=E1ZRBHcwY+ptnzB4ri6xq5xcw1s=; b=GcTJse
        QcG2pV+TTq7P2asyBL9W/oRaosjheoOp/ASmYzIEcgvXVrZs58FGeNFP+au4g+PP
        o6MHu0ycImSO7rySLHA80bzj6Pw+iXtFI/M7xvHSr+vzK07EL3NjyuHhQ/cxC689
        d3f9x05I+6L1FBRK4iOhQe7e0CKKBowvmEJh8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jdjBZIGJYeB5cKx8oX+0LGgfPe/rE1b5
        rZ7GrmwSk5srpQ9+8dBBg3zzag1F5fCijLelO+zRN/ov5hhYtk13RssUCYT8nYOq
        BTVbkTNid/tBdC83sZ1nXob3JKpmMzE1XR34E9o6Q+8XWQgcRmfh3jnfg2XoCL6C
        9GbP7RELKDk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3C1A5111736;
        Tue,  2 Feb 2021 16:23:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7DE22111734;
        Tue,  2 Feb 2021 16:23:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 01/11] p7519: use xargs -0 rather than -d in test
References: <pull.860.git.1612216941.gitgitgadget@gmail.com>
        <cf252e24b8c4da19ee9f886a1ab9c9c391d89d66.1612216941.git.gitgitgadget@gmail.com>
        <xmqqsg6fid57.fsf@gitster.c.googlers.com>
        <b2c548b7-f641-2398-c200-d774af9cf628@jeffhostetler.com>
Date:   Tue, 02 Feb 2021 13:23:50 -0800
In-Reply-To: <b2c548b7-f641-2398-c200-d774af9cf628@jeffhostetler.com> (Jeff
        Hostetler's message of "Tue, 2 Feb 2021 13:16:36 -0500")
Message-ID: <xmqqpn1if9jt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F2A796B2-659C-11EB-99AA-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> I'm not sure now that you mention it.  I suppose on modern filesystems
> that have mtimes with nanosecond fields we could (are) assuming that
> "touch" is actually doing something.  On older filesystems (such as
> FAT32), you're right it is probably not doing anything at the speed
> that the test runs.

That one is probably the most relevant nit among the ones I raised.
I do not actually mind if we used test-chmtime to force our own
timestamp (e.g. "5 seconds before the filesystem time"), and added
the helper the "--stdin" option to read paths to work around the
"xargs" issue.

> TBH I'm not sure that the test needs the "-h".  Symlinks are not that
> common and it shouldn't affect the timings that much if there are a few.

I agree.

> I'm not sure what to do about "-0".  Not even "--null" is portable.

Correct.  I do not think it is worth "digging", though.  I do not
mind "ls-files -z | test-tool chmtime -600 --stdin -z" to lose
xargs, but we already depend on GNU time to run t/perf, and it is
not too far a stretch to require GNU xargs that knows "-0" or "-d".

Thanks.

