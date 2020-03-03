Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5642EC3F2C6
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 17:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE8BA20842
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 17:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DrNLd/LR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730547AbgCCRG7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:06:59 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59996 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730532AbgCCRG7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 12:06:59 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0EF5AC57A5;
        Tue,  3 Mar 2020 12:06:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Y1mXcprQBThgFojia0Qhrci4OkY=; b=DrNLd/
        LRZmQNNDAxKs/rGkdYOKcjhpbXIpDNSNLg832emSujoe/FOzSughqfQRByaueJbG
        zlEcPTrxIIO08aZYSh1Yrnuo3dnWlJAbnFA8ceUt6RY0i51MkNCFBmcJKMVgMVo5
        1kgtEbi4cgCNz9W0lh5vTGgtb7K99SJgkWQKo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=maXa7zsd8hH0V0N+Ip3I/nHC83I2oHBA
        pyiKMBGUzDRk7yQNG3Ibw8FYMWE9PlaNMkOX30gNCPFr22MM1rMJM11KOVGxwuFp
        6dOOpJTwth0PO+f3p7zBVVtvOwrresVDUA/qKABA5P724VLTCVs0MTxxSxFSsItr
        doMMxbJ68n4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 05E2CC57A4;
        Tue,  3 Mar 2020 12:06:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0DC9AC57A3;
        Tue,  3 Mar 2020 12:06:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] prefix_path: show gitdir if worktree unavailable
References: <20200303040506.241376-1-emilyshaffer@google.com>
Date:   Tue, 03 Mar 2020 09:06:51 -0800
In-Reply-To: <20200303040506.241376-1-emilyshaffer@google.com> (Emily
        Shaffer's message of "Mon, 2 Mar 2020 20:05:06 -0800")
Message-ID: <xmqq4kv59xlg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 61BD9F18-5D71-11EA-8FD0-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> If there is no worktree at present, we can still hint the user about
> Git's current directory by showing them the absolute path to the Git
> directory. Even though the Git directory doesn't make it as easy to
> locate the worktree in question, it can still help a user figure out
> what's going on while developing a script.
>
> This fixes a segmentation fault introduced in e0020b2f829.
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
> This patch is built on top of es/outside-repo-errmsg-hints. I think it
> doesn't need to be, since that change is in master, though.
>
> Sounds like there's a segfault in the wild:

Thanks.  We should protect the fix with a test, no?

>  pathspec.c | 8 ++++++--
>  setup.c    | 8 ++++++--
>  2 files changed, 12 insertions(+), 4 deletions(-)
