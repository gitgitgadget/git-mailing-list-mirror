Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71924C433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 23:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 592F36135C
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 23:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242628AbhDLXE2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 19:04:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64528 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242596AbhDLXE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 19:04:26 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CB539C7E17;
        Mon, 12 Apr 2021 19:04:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uGJm3rFUhcH9+0NiL9v+wF2yrKg=; b=mdbhIP
        bYwZehR6VNErStI51pTFueyNT+X9hZMrMqg8DUafmwspOVXOm6HANzcalxa90xlv
        2qinJYM+5q8AsBP76DiR4dptpE4/8YChJAXr5JoQV0FRRAAv4A8G0GmQf/hhnVQG
        OdabdjLY/vOt6nSCUvB3wK+K+8CrPEPZlauvI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=v1+OFRYaaLtnoJmf9sH+icioUr5siaCC
        EgU3+/P4x2gnlFrWi+XVg9vxqv0WaiOoWSSnP5RVvODmJvP/7IujUBV3suCKr/lc
        MPfs27m5v5VXrDtYNA5ZzEUH6YCsDDfLk7gOqP428oL/l0qvb4+1u8B8FEfnY2lb
        3p05h6RdO/o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A8593C7E16;
        Mon, 12 Apr 2021 19:04:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D753AC7E15;
        Mon, 12 Apr 2021 19:04:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v3 1/1] userdiff: add support for Scheme
References: <20210403131612.97194-1-raykar.ath@gmail.com>
        <20210408091442.22740-2-raykar.ath@gmail.com>
Date:   Mon, 12 Apr 2021 16:04:04 -0700
In-Reply-To: <20210408091442.22740-2-raykar.ath@gmail.com> (Atharva Raykar's
        message of "Thu, 8 Apr 2021 14:44:43 +0530")
Message-ID: <xmqqzgy39kbf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6167E3FA-9BE3-11EB-97B4-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Atharva Raykar <raykar.ath@gmail.com> writes:

> Add a diff driver for Scheme-like languages which recognizes top level
> and local `define` forms, whether it is a function definition, binding,
> syntax definition or a user-defined `define-xyzzy` form.
>
> Also supports R6RS `library` forms, `module` forms along with class and
> struct declarations used in Racket (PLT Scheme).
>
> Alternate "def" syntax such as those in Gerbil Scheme are also
> supported, like defstruct, defsyntax and so on.
>
> The rationale for picking `define` forms for the hunk headers is because
> it is usually the only significant form for defining the structure of
> the program, and it is a common pattern for schemers to have local
> function definitions to hide their visibility, so it is not only the top
> level `define`'s that are of interest. Schemers also extend the language
> with macros to provide their own define forms (for example, something
> like a `define-test-suite`) which is also captured in the hunk header.
>
> Since it is common practice to extend syntax with variants of a form
> like `module+`, `class*` etc, those have been supported as well.
>
> The word regex is a best-effort attempt to conform to R7RS[1] valid
> identifiers, symbols and numbers.
>
> [1] https://small.r7rs.org/attachment/r7rs.pdf (section 2.1)
>
> Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
> ---
>  Documentation/gitattributes.txt    |  2 ++
>  t/t4018-diff-funcname.sh           |  1 +
>  t/t4018/scheme-class               |  7 +++++++
>  t/t4018/scheme-def                 |  4 ++++
>  t/t4018/scheme-def-variant         |  4 ++++
>  t/t4018/scheme-define-slash-public |  7 +++++++
>  t/t4018/scheme-define-syntax       |  8 ++++++++
>  t/t4018/scheme-define-variant      |  4 ++++
>  t/t4018/scheme-library             | 11 +++++++++++
>  t/t4018/scheme-local-define        |  4 ++++
>  t/t4018/scheme-module              |  6 ++++++
>  t/t4018/scheme-top-level-define    |  4 ++++
>  t/t4018/scheme-user-defined-define |  6 ++++++
>  t/t4034-diff-words.sh              |  1 +
>  t/t4034/scheme/expect              | 11 +++++++++++
>  t/t4034/scheme/post                |  6 ++++++
>  t/t4034/scheme/pre                 |  6 ++++++
>  userdiff.c                         |  9 +++++++++
>  18 files changed, 101 insertions(+)
>  create mode 100644 t/t4018/scheme-class
>  create mode 100644 t/t4018/scheme-def
>  create mode 100644 t/t4018/scheme-def-variant
>  create mode 100644 t/t4018/scheme-define-slash-public
>  create mode 100644 t/t4018/scheme-define-syntax
>  create mode 100644 t/t4018/scheme-define-variant
>  create mode 100644 t/t4018/scheme-library
>  create mode 100644 t/t4018/scheme-local-define
>  create mode 100644 t/t4018/scheme-module
>  create mode 100644 t/t4018/scheme-top-level-define
>  create mode 100644 t/t4018/scheme-user-defined-define
>  create mode 100644 t/t4034/scheme/expect
>  create mode 100644 t/t4034/scheme/post
>  create mode 100644 t/t4034/scheme/pre

We have seen reviews on previous rounds, and haven't heard anything
on this round yet.

If I do not hear from anybody in a few days, let's merge it to
'next'.
