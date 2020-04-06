Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5F7C2BA1A
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 23:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E13F206C0
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 23:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="irg8KG93"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgDFXbN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 19:31:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51581 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgDFXbN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 19:31:13 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 14BC566C58;
        Mon,  6 Apr 2020 19:31:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Zz2oC1NYgQXDrawxcbE5CGMDRL4=; b=irg8KG
        93whWK4rDG7rlSZvzfYQ+dEGaVZJx0KHlS1Mmn7qGmBXnVrG8vV0H+9WU8k4isDD
        4SbnAz8ApDe0cSNtT4Wl7FeBJ/x1KNhw3cKAnwLbeSamMgbs2O9+rAcPIwfFAsdJ
        glJY6ydA29fvCDOA8FpoyeOBTtviut6F0CccE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Eg+m5dqsuDEuMPJAZ1VyTOyd+t8Tt49B
        5kWhpAj1+bN3LjU4+fYauGcSxQHBMQHpvIH1C6ScfNr8Z9YaYjBk6wbjushwzclW
        AcKk69gn9+eI4OK4g4Q1mawlQmCpWYm6R4NqVBzocZyaUJX2kOwfxP4Guem3fXhb
        H7ozohJxhfU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0BFB666C57;
        Mon,  6 Apr 2020 19:31:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 87D7266C56;
        Mon,  6 Apr 2020 19:31:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Danh Doan <congdanhqx@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v12 5/5] bugreport: add compiler info
References: <20200406224526.256074-1-emilyshaffer@google.com>
        <20200406224526.256074-6-emilyshaffer@google.com>
Date:   Mon, 06 Apr 2020 16:31:10 -0700
In-Reply-To: <20200406224526.256074-6-emilyshaffer@google.com> (Emily
        Shaffer's message of "Mon, 6 Apr 2020 15:45:26 -0700")
Message-ID: <xmqq5zecur7l.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B287C100-785E-11EA-A489-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> To help pinpoint the source of a regression, it is useful to know some
> info about the compiler which the user's Git client was built with. By
> adding a generic get_compiler_info() in 'compat/' we can choose which
> relevant information to share per compiler; to get started, let's
> demonstrate the version of glibc if the user built with 'gcc'.

This one is not about "what system are we running on", but more
about "how were the various pieces of Git binaries the user has
trouble running built?".  While it may be useful to learn how "git
bugreport" was compiled, the same question about the other binaries
of Git (e.g. "git" itself, or "git ls-files" that is builtin) may
have different answers.  It should be fairly trivial to teach the
"git" binaries (i.e. "git" itself plus builtins, and standalone
subcommands like "git-remote-curl" and "git-bugreport") to report
how they were built (e.g. with what library and compiler) by calling
the helpers you added in [3/5] and [5/5] and once that is done, it
would be straight-forward to teach "git bugreport" to collect
properties of them by invoking them and reading their output via the
run_command() interface, as I mentioned in my review on [3/5]
earlire.

Thanks.

