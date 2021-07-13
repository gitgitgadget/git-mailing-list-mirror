Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45513C07E96
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 23:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EE806135A
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 23:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236835AbhGMXOF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 19:14:05 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52398 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236787AbhGMXOE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 19:14:04 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2237D156BC0;
        Tue, 13 Jul 2021 19:11:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MlO9geGlKwopwYEBX0QyGjn4c6BKrUgZh9xkG7
        HkAAM=; b=N1+WQzoVzSJGxGFAHaAP2XfcwZvsa1mZ1PvAJg71c8cP4joY60Zotu
        BFWRmXNTX15MOhps8nLzUhD2/aKKcSAh+4iuFkGf1nEWBjNtV79zwnv/srIMPiWr
        Sutwf0Q0So/BDO6H4hcPuOrv+P7gzuLq5vutAQ5KOnIF4QBfsvYAM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 19994156BBF;
        Tue, 13 Jul 2021 19:11:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7673F156BBC;
        Tue, 13 Jul 2021 19:11:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jordi Mas via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jordi Mas <jmas@softcatala.org>
Subject: Re: [PATCH] l10n: allows to translate diff messages
References: <pull.1045.git.git.1626177676801.gitgitgadget@gmail.com>
Date:   Tue, 13 Jul 2021 16:11:08 -0700
In-Reply-To: <pull.1045.git.git.1626177676801.gitgitgadget@gmail.com> (Jordi
        Mas via GitGitGadget's message of "Tue, 13 Jul 2021 12:01:16 +0000")
Message-ID: <xmqq4kcx24j7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9C7DCCC2-E42F-11EB-A532-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jordi Mas via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Subject: Re: [PATCH] l10n: allows to translate diff messages

"allow to translate" would be the right phrasing, but it is too
vague to say "diff messages".  You are only marking 3 messages for
translation when there are probably a handful more.  

You need to explain which ones, not just vague "diff messages".

I think you are focusing on the words on the "git diff --stat" and
"git diff --shortstat" summary line, so

    i18n: mark "git diff --[short]stat" summary for translation

perhaps?  And remember, i18n is the act of making the code capable
of being translated, while l10n is the act of actually translating
what i18n prepared into a particular language.  Here, i18n is more
appropriate.

> From: Jordi Mas <jmas@softcatala.org>
>
> Allows to translate the diff messages shown when the
> user commits, indicating the number of insertions,
> deletions and files changed.

Our log message first explain the current status/behaviour of the
code (and highlight the problem in it), and then gives an order to
the codebase to "be like so" in imperative mood.  Perhaps like this:

    "git diff --[short]stat" summarizes the number of paths touched
    and lines inserted and deleted.  Mark this message for
    translation.

Note that I didn't explicitly say what's wrong with the current
behaviour, but "mark for translation" as the order given to the
codebase, it should be clear enough from the context that the
problem is that it is not marked for translation.

Having said all that, I am not sure if this patch stop at a sensible
point.  At least "git diff --summary" output should also be updated
to match, as they often go hand-in-hand, no?

Also, when showing "git diff --stat" for a binary file, we'd say

	$path | Bin 1234 -> 1236 bytes

I wonder if that should also be translated.

While I am at it, there are a handful things that should NEVER be
translated in the "git diff" output.

> diff --git a/diff.c b/diff.c
> index 52c791574b..29db9ce079 100644

Between "diff --git" and "--- a/$path", there are metainfo lines
that are read by "git apply" (including this "index" line).  They
should never be translated.

Thanks.
