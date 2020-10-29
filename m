Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C0DC4742C
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 20:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E91542076E
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 20:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DkAKZGO3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgJ2Uk5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 16:40:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52493 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbgJ2Ukd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 16:40:33 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6442294BCF;
        Thu, 29 Oct 2020 16:40:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8R6Tp1P7q3pNKgJj58u0/75jAhs=; b=DkAKZG
        O3LA/Mh1Uy+9sDxwdmLZyctQzrK7RAnt0nDijM86Ym7DKsi5YIa+sSmbEmiLVoaa
        OKo0EWo009arcRfdd04b0UMOS/p9+VyN8hjSZBn83b5920g0exGJ+YmPN7PA+eWZ
        k5JWjt0hdbx0Wv+7ToH2KG2J5vEfVR/wXW0Ak=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rqTvI2piYbvCCbFyw2DSRh7hOH0rUQtf
        bLyrjWcEjXlvZ8AzFvD2mss+jk53DOEUhtIPHYhG0tQFE2OWKSEHE5XrFnj4TRY0
        i1UyQAKWsvmC7bD5+OPdhK8PRdAa6SPm9Z/YbASS2kmDYg49JNwSIJIho38N1I6b
        VWCYbwpI050=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B65E94BCC;
        Thu, 29 Oct 2020 16:40:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D766A94BCB;
        Thu, 29 Oct 2020 16:40:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 6/6] blame: enable funcname blaming with userdiff driver
References: <pull.774.git.1603889270.gitgitgadget@gmail.com>
        <a1e1c977d0978424fb07c97be0479f43a325cbea.1603889270.git.gitgitgadget@gmail.com>
Date:   Thu, 29 Oct 2020 13:40:28 -0700
In-Reply-To: <a1e1c977d0978424fb07c97be0479f43a325cbea.1603889270.git.gitgitgadget@gmail.com>
        (Philippe Blain via GitGitGadget's message of "Wed, 28 Oct 2020
        12:47:50 +0000")
Message-ID: <xmqqy2jo6a0z.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FB1D5FE6-1A26-11EB-8A31-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> In blame.c::cmd_blame, we send the 'path' field of the 'sb' 'struct
> blame_scoreboard' as the 'path' argument to
> 'line-range.c::parse_range_arg', but 'sb.path' is not set yet; it's set
> to the local variable 'path' a few lines later at line 1137.
>
> This 'path' argument is only used in 'parse_range_arg' if we are blaming
> a funcname, i.e. `git blame -L :<funcname> <path>`, and in that case it
> is sent to 'parse_range_funcname', where it is used to determine if a
> userdiff driver should be used for said <path> to match the given
> funcname.
>
> Since 'path' is yet unset, the userdiff driver is never used, so we fall
> back to the default funcname regex, which is usually not appropriate for
> paths that are set to use a specific userdiff driver, and thus either we
> match some unrelated lines, or we die with
>
>     fatal: -L parameter '<funcname>' starting at line 1: no match
>
> This has been the case ever since `git blame` learned to blame a
> funcname in 13b8f68c1f (log -L: :pattern:file syntax to find by
> funcname, 2013-03-28).

Good find.

> Enable funcname blaming for paths using specific userdiff drivers by
> sending the local variable 'path' to 'parse_range_arg' instead of the
> yet unset 'sb.path'.

Hmph.  The reason why sb.path is not set to path at this point but
later gets set is?  I am wondering if this is leaving an unneeded
room for sb.path and path to diverge by mistake.  IOW, I wonder if
it is better to set sb.path as early as we figure out which path we
are interested in, forget we have local variable "path" and use
sb.path consistently throughout the code.

But that is merely a potential future clean-up.  The local variable
path is still used one more time in the error message given when
this parse_range_arg() fails, so at least this change makes the use
of path more consistent.  I like the simplicity of this fix.

> Add a regression test in 'annotate-tests.sh', which is sourced in
> t8001-annotate.sh and t8002-blame.sh, leveraging an existing file used
> to test the userdiff patterns in t4018-diff-funcname.

Thanks, that change also makes sense.

