Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757ABC2BA2B
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 22:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32E6B21744
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 22:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SkUI1g1J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbgDPW2c (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 18:28:32 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57250 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgDPW2b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Apr 2020 18:28:31 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BE120B59C7;
        Thu, 16 Apr 2020 18:28:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wjfNJMe8KJiasxIRjuZa2dK+IW8=; b=SkUI1g
        1J2s/aEFSu6DGtamlC3LToDaBv5MZuKdjP9vo/IpVaG0+Ou1baa15xl8uEkxjtCV
        c7lS30w9sWyW5wlew/JilTLZn08CDwwCpMUvIdhiJBv5T2fAu5KBFYPHKgRM7vbK
        xZ8+6ZA25GpDOnK1aAiHBpJxehmwQ8z7UKTl0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KiJmWIdH/74Nq9NQ1oCwRJsEukT1Sp0f
        Kro14PiC0leNc5gEBDAVelea8EE3QOYr24sddLA4J6fR93kJjKkg8e0d/1UUKNpA
        L/s2/P8urX/FyIZaSfP1A+yPsiFiLOBveK0I9pBWaewUqgtNyjwQYqmQf4iv3H7z
        ph+iunDUU1s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B5579B59C6;
        Thu, 16 Apr 2020 18:28:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AA08BB59C1;
        Thu, 16 Apr 2020 18:28:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v13 1/5] help: move list_config_help to builtin/help
References: <20200416211807.60811-1-emilyshaffer@google.com>
        <20200416211807.60811-2-emilyshaffer@google.com>
        <xmqqd087xe9x.fsf@gitster.c.googlers.com>
Date:   Thu, 16 Apr 2020 15:28:24 -0700
In-Reply-To: <xmqqd087xe9x.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 16 Apr 2020 15:21:46 -0700")
Message-ID: <xmqq8sivxdyv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96A1582C-8031-11EA-ADE5-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Forgot to proofread and edit the log message into reasonable shape
> when you squashed two patches together?
>
> I wonder if the "squash" action of "rebase -i" can be taught to
> detect a mistake like this?

Without waiting for an improvement to "rebase -i" ;-), here is what
I came up with, with a minimum edit.

Subject: help: move list_config_help to builtin/help

Starting in 3ac68a93fd2, help.o began to depend on builtin/branch.o,
builtin/clean.o, and builtin/config.o. This meant that help.o was
unusable outside of the context of the main Git executable.

To make help.o usable by other commands again, move list_config_help()
into builtin/help.c (where it makes sense to assume other builtin libraries
are present).

When command-list.h is included but a member is not used, we start to
hear a compiler warning. Since the config list is generated in a fairly
different way than the command list, and since commands and config
options are semantically different, move the config list into its own
header and move the generator into its own script and build rule.

For reasons explained in 976aaedc (msvc: add a Makefile target to
pre-generate the Visual Studio solution, 2019-07-29), some build
artifacts we consider non-source files cannot be generated in the
Visual Studio environment, and we already have some Makefile tweaks
to help Visual Studio to use generated command-list.h header file.
Do the same to a new generated file, config-list.h, introduced by
this change.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
