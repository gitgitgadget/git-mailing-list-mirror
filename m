Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22535C433E1
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 22:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E818520737
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 22:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dEn19FQh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgGWWcD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 18:32:03 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57987 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgGWWcC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 18:32:02 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 032D8D5431;
        Thu, 23 Jul 2020 18:32:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=t8BbDVvr2YPc
        tbfOqNyr9nKPDAc=; b=dEn19FQhhc1/RfVzHsCnGEVC907wF1FaP6vXMfRWAnAi
        Uwg3d9HGV2mE7q+TUjTZSxc0NaWl9EugVosuUo7z/44K0j/QTi+keE9g/42ljCxl
        Ht8euZV6nma+gd4ghqkA8czt91ShyiuAQmTdpAjq6tCR4GY3epqWe5Rt5KYw6Cg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=mMlklY
        PId5u96hyBfEx5lSQd3LpWJHYM/4EYROEF9J6o9yn9HKr4hJHbmy4JiwwAagFZOS
        79WwUJUa5GfkWkuzTFwzl6OLCK3HNz8udPISXImyDbTjAcGo697r2Wxhz6D2XyZ6
        n1yTD8/OysVC8fXFsF0ARsgIVvLpTGY518yKM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EF031D5430;
        Thu, 23 Jul 2020 18:32:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 39ABBD542D;
        Thu, 23 Jul 2020 18:31:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] ci: use absolute PYTHON_PATH in the Linux jobs
References: <xmqqsgdk7gkq.fsf@gitster.c.googlers.com>
        <20200723213848.30032-1-szeder.dev@gmail.com>
Date:   Thu, 23 Jul 2020 15:31:56 -0700
In-Reply-To: <20200723213848.30032-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Thu, 23 Jul 2020 23:38:48 +0200")
Message-ID: <xmqqwo2toobn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 51CBA9AA-CD34-11EA-B9E8-843F439F7C89-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> In our test suite, when 'git p4' invokes a Git command as a
> subprocesses, then it should run the 'git' binary we are testing.
> Unfortunately, this is not the case in the 'linux-clang' and
> 'linux-gcc' jobs on Travis CI, where 'git p4' runs the system
> '/usr/bin/git' instead.
>
> Travis CI's default Linux image includes 'pyenv', and all Python
> invocations that involve PATH lookup go through 'pyenv', e.g. our
> 'PYTHON_PATH=3D$(which python3)' sets '/opt/pyenv/shims/python3' as
> PYTHON_PATH, which in turn will invoke '/usr/bin/python3'.  Alas, the
> 'pyenv' version included in this image is buggy, and prepends the
> directory containing the Python binary to PATH even if that is a
> system directory already in PATH near the end.  Consequently, 'git p4'
> in those jobs ends up with its PATH starting with '/usr/bin', and then
> runs '/usr/bin/git'.
>
> So use the absolute paths '/usr/bin/python{2,3}' explicitly when
> setting PYTHON_PATH in those Linux jobs to avoid the PATH lookup and
> thus the bogus 'pyenv' from interfering with our 'git p4' tests.
> Don't bother with special-casing Travis CI: while this issue doesn't
> affect the corresponding Linux jobs on GitHub Actions, both CI systems
> use Ubuntu LTS-based images, so we can safely rely on these Python
> paths.

Good.  This does not need to touch pyenv but take advantage of the
fact that we know where Python 2 and 3 are.  Nice.

>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>
> Junio, I see that you picked up the first/RFC version and applied it
> on top of v2.26.2.  This patch won't work on v2.26.2, because its 'git
> p4' is not compatible with python3 yet.

Thanks.  Which means that we do not need to touch maint track (not
that we'd be merging the SHA-256 topic down to the maint track
anyway).

Will queue.
