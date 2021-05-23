Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0F4C4707A
	for <git@archiver.kernel.org>; Sun, 23 May 2021 18:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B40F61244
	for <git@archiver.kernel.org>; Sun, 23 May 2021 18:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbhEWSNZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 May 2021 14:13:25 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57586 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbhEWSNY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 May 2021 14:13:24 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C9B58128304;
        Sun, 23 May 2021 14:11:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=8UFJhnz8+hEyU7Vs2hYv/ozgxw8RSWNpkzh+bCw6XUk=; b=mWcB
        Fza72XAmXFIRj5/UKF91j5usw033CrswT2RjLqZ9F1wMfk0t1Fp2qmS2mxSipwZQ
        uz33Ty0h5G+ihGaIo8ZRZcUHceqtx4F6QBK/fXRlaV0I0xH6XFi7nNGPvQRgTf8d
        PHT88ZlDLU1g3pqpMVsfs+Fia/4eceZM+vY6vSs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C2958128303;
        Sun, 23 May 2021 14:11:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 15C7D128302;
        Sun, 23 May 2021 14:11:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     aidgal2@gmail.com, git@vger.kernel.org,
        Thomas Rast <tr@thomasrast.ch>
Subject: Re: Formatting options are ignored when tracking functions
References: <EE7D39E6-D826-49E2-AD0E-090A83DFDEC1@gmail.com>
Date:   Mon, 24 May 2021 03:11:53 +0900
Message-ID: <xmqqczthnwuu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5B2C4524-BBF2-11EB-A09F-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> I believe this is working as advertised: only the first line of
> the commit message is shown.
> However as mentioned in the doc, the -L option also triggers patch
> output (-p), which you can omit if you explicitely add --no-patch
> (or shorter, -s).

Heh, I think "working as advertised" is not wrong per-se, but this
feels like a clear design mistake to me, at least at the UI level.
Admittedly, I've never used "log -L" in scripts and I've always used
it interactively, in a context that I want to see the patch output,
so this did not bother me so far.

But what commits -L decides have relevant changes and how these
commits are shown ought to be orthogonal.  It surely may need to run
the content-level diff machinery to see if each commit affects the
area of the code specified via the -L option, but just like "git log
-S<text>" can be used to find commits that change the number of
occurrences of <text>, and allows the users to choose to view them
with "-p" (but not force the --patch mode on), it should behave the
same way, I would think.

With a clear migration plan, we should be able to fix this over
time, I would think.

