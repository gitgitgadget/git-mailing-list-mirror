Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCBEC4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 20:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21A1960ED4
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 20:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhG2UDS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 16:03:18 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64749 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhG2UDS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 16:03:18 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3259A14817C;
        Thu, 29 Jul 2021 16:03:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0xv2bWFzuenx0To97cnHdHBGdBIVY7uoOOpBgq
        6LNPc=; b=u54mBHg0POVORusIUv5l2dufCWA9Ttbyom9uAN2sbhCvQUOr+d9e3l
        no6G9Qj9wGUMQIBGi1fWdP0/4V+LA7kz1Q18VoTAjO4dGAldwUImMAzDO8wXn+Pp
        qOBrLmdz7G+QX7gYafALmR0BwXF4zYGJGdbwkELtapyACY8Axyjls=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2ABEB14817B;
        Thu, 29 Jul 2021 16:03:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7497614817A;
        Thu, 29 Jul 2021 16:03:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] mingw: align symlinks-related rmdir() behavior with Linux
References: <pull.1008.git.1627586493659.gitgitgadget@gmail.com>
Date:   Thu, 29 Jul 2021 13:03:06 -0700
In-Reply-To: <pull.1008.git.1627586493659.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Thu, 29 Jul 2021 19:21:33
        +0000")
Message-ID: <xmqqo8ak51mt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FE80715C-F0A7-11EB-BFE0-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When performing a rebase, rmdir() is called on the folder .git/logs. On
> Unix rmdir() exits without deleting anything in case .git/logs is a
> symbolic link but the equivalent functions on Windows (_rmdir, _wrmdir
> and RemoveDirectoryW) do not behave the same and remove the folder if it
> is symlinked even if it is not empty.

The distinction is understandable, and I can see this justifies the
patch really nicely.

It is curious why "rebase" causes rmdir on the reflog hierarchy,
though.  It is also unclear if "rebase" is special in having this
behaviour (and if so why), or just an example the problem was
observed with and other subcommands may benefit from the same fix.

Will queue with authorship corrected (as you reported in the
follow-up).

Thanks.


