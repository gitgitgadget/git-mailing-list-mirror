Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9017BC2D0FD
	for <git@archiver.kernel.org>; Wed, 13 May 2020 05:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DCC6206CC
	for <git@archiver.kernel.org>; Wed, 13 May 2020 05:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="d59N39mc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgEMFCJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 01:02:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51092 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgEMFCI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 May 2020 01:02:08 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8EC284E1FC;
        Wed, 13 May 2020 01:02:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CparA3CZ4uhSnxcCemLKdqYKBN0=; b=d59N39
        mcI0Ji6FlVgprN+3Wmy6cV91CkmBRw4biHAeIjJ95h7LnDxjGDMYc6CwUG2jieq9
        bAhhYabXUeuvotTQOjSfMrGDIi8rSaHgyJ1Ll9jxttRlItEGQ+UualX/w3ykUp92
        YXup9EMIeLOwxSpU1XWy3qrA+v81pR6+qnhOM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sI0oH4e/FSZMOqQM5FNqdMCdE3aQ+ENw
        TWOLj/VuHOTS8vgXmwVlHbdKIb2m6zxD1DxH5ULMbZV8guSNtDFnS9ARDJSKAOD7
        muI2HL8KTkkcyj11msMQhO6OcaMIfVf299Tmxwdy/Z8BNVUvgaAK5H6LZzYoMAVc
        ElIlEIlQUdg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7FF634E1FB;
        Wed, 13 May 2020 01:02:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4EFBB4E1F9;
        Wed, 13 May 2020 01:02:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] help: add shell-path to --build-options
References: <20200512234213.63651-1-emilyshaffer@google.com>
        <20200512234213.63651-2-emilyshaffer@google.com>
        <20200512235924.GC6605@camp.crustytoothpaste.net>
Date:   Tue, 12 May 2020 22:02:04 -0700
In-Reply-To: <20200512235924.GC6605@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Tue, 12 May 2020 23:59:24 +0000")
Message-ID: <xmqqo8qswhpv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E3C3CC16-94D6-11EA-AE3D-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> This seems straightforward and logical (as does the rest of the series),
> but I wondered if it might be a good idea to try to interrogate the
> shell for more information.  The reason I mention it is that Debian
> permits any shell that meets certain standards to be /bin/sh, and all
> programs that invoke /bin/sh must depend on only those features.  The
> default is dash, but people could use bash, which is more featureful, or
> posh, which is intentionally designed to provide the bare minimum
> /bin/sh experience[0], among others.  A value of "/bin/sh" doesn't
> necessarily tell us very much on Debian (or on macOS, for that matter).

Good point.  Perhaps readlink(3) on it, then?

lrwxrwxrwx 1 root root 9 Mar 11  2018 /bin/sh -> /bin/bash

> Now, that of course does mean that we have to have some way to
> distinguish between shells, and that is the hard part, so I'm completely
> fine with us leaving it out until we have a good way to do it (or until
> we decide we need it, which may be never).  I just wanted to mention it
> as a potential approach for the future.  I'm happy with this series as
> it stands right now.
>
> [0] Quite literally, in that it's supposed to be a tool for testing
> compatibility with the policy requirements.
