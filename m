Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D77DC433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 23:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A93A61371
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 23:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhJUX2q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 19:28:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50605 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhJUX2q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 19:28:46 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C5CBEDC65;
        Thu, 21 Oct 2021 19:26:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=j3VpmBL9xBXW
        b54kUWGJtlAoclOJU0n3xRBqF1v6zIU=; b=VbBk7goaDMPkRqFJwYVdBb/eN8EG
        54L20Ashh976oELHufYk4AIqz+aQ/6x3Km7dYPQuXHxHZ1DsTSKWtJid2HQqsyML
        vGIbMTv94F9fOvtCmzSenEaif0E2f9ZkLw5D4+0MzWCsz2pIkWEWhC8ImOWEvAl4
        6+xPETIu23oCWog=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 72B7DEDC64;
        Thu, 21 Oct 2021 19:26:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DA52FEDC63;
        Thu, 21 Oct 2021 19:26:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Andrzej Hunt <andrzej@ahunt.org>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v2 1/3] refs.c: make "repo_default_branch_name" static,
 remove xstrfmt()
References: <patch-1.1-5a47bf2e9c9-20211021T114223Z-avarab@gmail.com>
        <cover-v2-0.3-00000000000-20211021T195133Z-avarab@gmail.com>
        <patch-v2-1.3-4f8554bb02e-20211021T195133Z-avarab@gmail.com>
Date:   Thu, 21 Oct 2021 16:26:27 -0700
In-Reply-To: <patch-v2-1.3-4f8554bb02e-20211021T195133Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 21 Oct
 2021 21:54:13
        +0200")
Message-ID: <xmqqsfwugdss.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5136E916-32C6-11EC-8B8A-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> In addition the xstrfmt() to get the "full_ref" in the same commit
> isn't needed, we can use the "REFNAME_ALLOW_ONELEVEL" flag to
> check_refname_format() instead.

Reading the code of check_refname_format(), I do not think one-level
is the only thing that the prefixing of refs/heads/ is defeating,
and more importantly, I'd expect that this will block later changes
like enforcing "HEAD might be OK in onelevel because we want to keep
.git/HEAD working, but we do not like refs/heads/HEAD" at this level
to enhance usability from happening.

Making the function file-local static is a good thing to do, though.
