Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD8FA1F45F
	for <e@80x24.org>; Wed,  8 May 2019 05:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfEHFdV (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 01:33:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55559 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfEHFdV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 01:33:21 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B9CD514FADA;
        Wed,  8 May 2019 01:33:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QJNCDOz73MoA0zBN1FKv7slnJn0=; b=vFa8Ct
        SlFPHXDdPdZbq3I9fWwxVr9Qbq7lRzA+9hKY9ktsJm1ijDncGJB0u36bSksQ3qDi
        dFgWTIJn/PHepUdYFds55p/9iS80V/BUIkqmJVWQuJ0OMMeBQCwCgsFh45i5/NfK
        N4vMg1cJAZ1YQKFNonF8WL3AKWV65z5ebOLes=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nEsTfPkPDuVfI4lwBwWficWvcHihep0E
        TtvTUXMQlAENslBWgO/6CQrLU4ZuJCOtbMsVHiI2ue/JsrPq71KtR4MUWl1dXvHt
        DfKasHf2oEtoNYjS60M8pcw0T4N7srgfhZIYHoCg3ATt+E2e7txVI9ljXNPpCrpg
        HwTkZLUdyjQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B124C14FAD9;
        Wed,  8 May 2019 01:33:18 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 25C7A14FAD8;
        Wed,  8 May 2019 01:33:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Dr. Adam Nielsen" <admin@in-ici.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] make slash-rules more readable
References: <20190507104507.18735-1-admin@in-ici.net>
Date:   Wed, 08 May 2019 14:33:16 +0900
In-Reply-To: <20190507104507.18735-1-admin@in-ici.net> (Adam Nielsen's message
        of "Tue, 7 May 2019 12:45:07 +0200")
Message-ID: <xmqqzhnxh5nm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C8CD95F2-7152-11E9-BD4E-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Dr. Adam Nielsen" <admin@in-ici.net> writes:

> + - A pattern that contains a non-trailing slash is matched
> +   For example, `doc/frotz/` matches `doc/frotz` directory, but not
> +   `a/doc/frotz` (relative from the `.gitignore` file).
> +   Note that the pattern `doc/frotz` and `/doc/frotz` have the
> +   same effect in any `.gitignore` file, while `/bar` and `bar`
> +   have not the same effect (`/bar` will not match `foo/bar`).

The "note" is not incorrect per-se.  The behaviour described is
because the leading slash is removed for the purpose of textual
matching against paths, but still counts as a non-trailing slash for
the purpose of anchoring the pattern to the level of recursion.

I am not sure if that is obvious to the readers, though.  Especially
because the "a leading slash matches the beginning of ..." which was
in the original is still left and appears two bullet points after
this one, the presentation order seem a bit suboptimal.

How about deleting that "A leading slash matches the beginning..."
bullet, and then splitting the above bullet into two?  That is

- A pattern that contains a non-trailing slash is matched
  For example, `doc/frotz/` matches `doc/frotz` directory, but not
  `a/doc/frotz` (relative from the `.gitignore` file).

- A leading slash, if any, is implicitly removed before matching the
  pattern with the pathname, but the pattern still counts as having
  a non-trailing slash for the purpose of the above rule.  For
  example, a pattern `{asterisk}.c` does not have any slash in it,
  so it would match a file or a directory whose name ends with `.c`
  anywhere in the directory that has `.gitignore` file in it
  (e.g. `sub/foo.c`, `bar.c`). By prefixing a slash to make it
  `/{asterisk}.c`, it can be limited to match only at the current
  level (i.e. `bar.c` but not `sub/foo.c`).

> + - An asterisk "`*`" matches anything except a slash.
> +   A pattern "foo/*", for example, matches "foo/test.json"
> +   (a regular file), "foo/bar" (a diretory), but it does not match
> +   "foo/bar/hello.c" (a regular file), as the asterisk in the
> +   patter does not match "bar/hello.c" which has a slash in it.

s/patter/&n/

> +   The character "`?`" matches any one character except "`/`".
> +   The range notation, e.g. `[a-zA-Z]`, can be used to match
> +   one of the characters in a range. See fnmatch(3) and the
> +   FNM_PATHNAME flag for a more detailed description.
>  
>   - A leading slash matches the beginning of the pathname.
>     For example, "/{asterisk}.c" matches "cat-file.c" but not

Then this last paragraph can be removed.

