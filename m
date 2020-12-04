Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F14EC433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E63C0229C6
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730238AbgLDUCv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 15:02:51 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59795 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgLDUCv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 15:02:51 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 824B711AF59;
        Fri,  4 Dec 2020 15:02:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xTN+Vz18dyUglrrPrP7DTodijKQ=; b=QJQw6k
        wPG9VzI+Hgigk9o141hyhwzZuayL8AbAaryZ+2MSJ5miIvt0Dj7q4XHVWXRl9BZS
        5eHltaZTGQ+xvX/N058JVG9h0irHWQCK0XWVkA3EA8g1K4PJRe6mekjd/lt7ZfVp
        A4GmmtohX4XhgdLLIl9KLw5hhSih3EzcKe27U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YG63nq+iG7fHOL4vxCH7RFLUq2u3CFaQ
        y9AFYXotxDsFH+Fzd/WNgERoP9rc8GRCjtqaDBSU+uFGtIy1CKoXJZ7yFJT5FyNA
        x+DmrHnyUJdZcShuzKRxRqefQc5+nCI/ft6EouNeecUa8FAyTKTQr0pQtuUV5VQV
        Hbro+XBTX/Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7AA6711AF58;
        Fri,  4 Dec 2020 15:02:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B9BA211AF57;
        Fri,  4 Dec 2020 15:02:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Dennis Ameling <dennis@dennisameling.com>
Subject: Re: [PATCH] ci(vs-build): stop passing the iconv library location
 explicitly
References: <pull.805.git.1607091741254.gitgitgadget@gmail.com>
Date:   Fri, 04 Dec 2020 12:02:05 -0800
In-Reply-To: <pull.805.git.1607091741254.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Fri, 04 Dec 2020 14:22:20
        +0000")
Message-ID: <xmqqv9dhe3wi.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 95D02CCA-366B-11EB-B12B-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Dennis Ameling <dennis@dennisameling.com>
>
> Something changed in `vcpkg` (which we use in our Visual C++ build to
> provide the dependencies such as libcurl) and our `vs-build` job started
> failing in CI. The reason is that we had a work-around in place to help
> CMake find iconv, and this work-around is neither needed nor does it
> work anymore.
>
> For the full discussion with the vcpkg project, see this comment:
> https://github.com/microsoft/vcpkg/issues/14780#issuecomment-735368280
>
> Signed-off-by: Dennis Ameling <dennis@dennisameling.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     ci: fix the vs-build job so that CI builds pass again
>     
>     This was noticed first in a Git for Windows PR.

This is probably the same breakage I've been seeing, e.g.
https://github.com/git/git/runs/1494253517

Thanks for taking care of it.

I guess we should just apply directly to 'master' (or 'maint' and
merge up), but I can queue it just like all other topics and have it
traverse through 'seen'->'next'->'master'.

