Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB570C433E0
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 08:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A513A64E05
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 08:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbhBWI3c (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 03:29:32 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59684 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbhBWI3a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 03:29:30 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C5DEA123CAF;
        Tue, 23 Feb 2021 03:28:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yaY8A4EvskNsMsZHnFDd/f0KH5A=; b=m4ITId
        ANKOGjr8Y1Z+sP6iALnh980JW4SiSDmRUug72djDSiKhDpJ0GZsRhuBVW66NBrS9
        6x9+ueEGRtUhbE9NjyXHGsUqk5Bq8rY1WFaWQjItCcjr0WLUl67Vk2vioZ1Cr0gR
        9MD6RHU8aixMLzeccxXiK5xvb9+H7f1/GVFdM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HeVuWxr40E4v4QPEgQVwbchxynDF9pLN
        CboLCOrgfboRJu7ea7X2y5uCMRXBjAH6VH2OKmveUOpgV5E2Vg7zmu8FKk2LxhDg
        UBgM1+Nph22HBdHhto220NdxjYKvnhhLtV9hGKR28jNY/Qe2jihWBXIsoUjgF0jW
        TQTQhH+2Sxc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BE00B123CAE;
        Tue, 23 Feb 2021 03:28:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0FE63123CAC;
        Tue, 23 Feb 2021 03:28:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] replace "parameters" by "arguments" in error messages
References: <40b2fedc-fdde-1fc0-ef98-86d8ea638193@kdbg.org>
Date:   Tue, 23 Feb 2021 00:28:43 -0800
In-Reply-To: <40b2fedc-fdde-1fc0-ef98-86d8ea638193@kdbg.org> (Johannes Sixt's
        message of "Tue, 23 Feb 2021 08:38:52 +0100")
Message-ID: <xmqqk0qz4284.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 24BA5832-75B1-11EB-AFE9-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> When an error message informs the user about an incorrect command
> invocation, it should refer to "arguments", not "parameters".
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  Recently, I was greated by an accidental `git tag` invocation:
>
>  $ git tag one two three
>  fatal: too many params
>
>  This is bad in two regards: (1) There's a techie-speak abbreviation
>  in a user-visible text, (2) and it is wrong terminology to refer to
>  "parameters" when "arguments" would be correct.
>
>  Then I looked at every single occurrence of "parameter" in Documentation/
>  and half-way through the rest and wanted to  correct all incorrect uses,
>  but things are by far not as clear-cut as I hoped.
>
>  So, I stopped here and fixed the one pain point that triggered the voyage,
>  which I hope is not too controversal.
>
>  bisect.c                    |  2 +-
>  builtin/notes.c             | 20 ++++++++++----------
>  builtin/stash.c             |  2 +-
>  builtin/tag.c               |  2 +-
>  t/t3301-notes.sh            |  6 +++---
>  t/t6030-bisect-porcelain.sh |  4 ++--
>  6 files changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/bisect.c b/bisect.c
> index 75ea0eb57f..ae48d19acf 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -1064,7 +1064,7 @@ enum bisect_error bisect_next
>    	if (!all) {
>  		fprintf(stderr, _("No testable commit found.\n"
> -			"Maybe you started with bad path parameters?\n"));
> +			"Maybe you started with bad path arguments?\n"));
>    		return BISECT_NO_TESTABLE_COMMIT;
>  	}
> diff --git a/builtin/notes.c b/builtin/notes.c

The above hunk is curious for a few reasons.

 - The hunk header claims that both the preimage and the postimage
   are 7 lines long, but they only have 5 (2 precontext, 1 change
   and 2 postcontext) lines.

 - There are spaces before tab on a few context lines that do not
   exist in the patch target.

Ahh, format=flawed, that is.

    Content-Type: text/plain; charset=utf-8; format=flowed
