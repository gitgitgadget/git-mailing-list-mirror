Return-Path: <SRS0=OyOp=6K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B957C54FCB
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 00:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D13542071E
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 00:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="I80kr1uA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgDZARF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 20:17:05 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52557 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgDZARE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Apr 2020 20:17:04 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C5C7EDB181;
        Sat, 25 Apr 2020 20:17:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=MZOr886lmuf4
        8vff4Gv3/GWwT8g=; b=I80kr1uADU3q9LUbJI3uoh/92vQaHnNbHzZDSwnVf3mZ
        YQhb7UWduZao/sPTAOwZ8TiLw30U+/auEWX9ZC0kKVxXRYDHYQYDXOqw3AUI7A1E
        LQr9lgscTKXoHJDokjBr2+Nrull0bjhOVQZIJ88vn9DuKq8SANdk7207WwQ97sQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=irsNca
        R4LbtZGrFfCkk0XqDLCHDXt8+rlTe/88cdAAf/Oc9BKnUKYMmcYxmtjqlA3bxLEY
        0UEKb05LmPZxxYDYb5y36ax6hUVGFdI0YmaYYDZDanDvQsVb/jTLnIWEyxDUbKt6
        GId0ybE1ecuO/fH2OOlQKOa2qFt2DMLY7pURA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B17A8DB180;
        Sat, 25 Apr 2020 20:17:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CDD5ADB17D;
        Sat, 25 Apr 2020 20:16:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mateusz =?utf-8?Q?Nowoty=C5=84ski?= <maxmati4@gmail.com>
Cc:     git@vger.kernel.org, mattr94@gmail.com, bwilliams.eng@gmail.com
Subject: Re: [PATCH] config: use GIT_CONFIG in git config sequence
References: <20200425235716.1822560-1-maxmati4@gmail.com>
Date:   Sat, 25 Apr 2020 17:16:56 -0700
In-Reply-To: <20200425235716.1822560-1-maxmati4@gmail.com> ("Mateusz
        =?utf-8?Q?Nowoty=C5=84ski=22's?= message of "Sun, 26 Apr 2020 01:57:16
 +0200")
Message-ID: <xmqq5zdn9k3r.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3E7C34B8-8753-11EA-8387-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mateusz Nowoty=C5=84ski <maxmati4@gmail.com> writes:

> Currently, there is no way to use config file other then ~/.gitconfig.
> This can cause a problem, for example, when running tests of software t=
hat
> depends on git. In such a case user's gitconfig may contain settings th=
at
> are incompatible with tests.

While I can remotely imagine how an environment variable that
overrides everything might be useful at times, we already use
GIT_CONFIG environment for a different purpose, so even if such a
feature were desirable, the name is already taken, and you'd want to
hunt for another one.  Also, I do not think I'll take this patch if
the justification were solely the above, as it is a solved problem,
together with the use of GIT_CONFIG_NOSYSTEM and GIT_ATTR_NOSYSTEM.

Tests of a software that depends on git, and perhaps other things,
will be affected in things under the testing user's home directory,
and not just ~/.gitconfig file.  Providing stable environment to run
in to your tests is a useful thing to do, but it is not a viable or
a particularly smart strategy for doing so to tweak each and every
software that your software may depend on, and your software itself,
with a custom change like this patch.

You can prepare a pretend-home directory for the use of your tests
and point the environment variable $HOME to it while running your
tests.  See how we do this in our test suite for inspiration---it
all happens in t/test-lib.sh, I think.

Thanks.



