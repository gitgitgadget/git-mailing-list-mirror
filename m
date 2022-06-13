Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0901C433EF
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 20:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351166AbiFMUSy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 16:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351361AbiFMUS0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 16:18:26 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821F4C6E79
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 11:57:00 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ACE231977C7;
        Mon, 13 Jun 2022 14:56:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=h7P+SdTyAYUS2+aTNznAej4O+6INiA75rhXxk9
        33eAs=; b=IkqizbVxZ79NLxAB9m9efaQTLh5QpouA4t/4K0EEnPCBSbaQXP/Z/h
        WkzmXx6FZtluVBsddnCfSUdLqQRVnNrfCDsOG0cOcfcTAx1ER3E8F9UafGynAF3t
        kRUCADgWZCrC1vm3eibErWmFPioCEpdjl+ftalK5fYrtJlWwfV87I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A3A8F1977C6;
        Mon, 13 Jun 2022 14:56:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4D7901977C0;
        Mon, 13 Jun 2022 14:56:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 2/3] diff-format.txt: correct misleading wording
References: <pull.1259.git.1655123383.gitgitgadget@gmail.com>
        <5ff3a52556716e92f7207c75660cec2eb3da2587.1655123383.git.gitgitgadget@gmail.com>
Date:   Mon, 13 Jun 2022 11:56:55 -0700
In-Reply-To: <5ff3a52556716e92f7207c75660cec2eb3da2587.1655123383.git.gitgitgadget@gmail.com>
        (Philippe Blain via GitGitGadget's message of "Mon, 13 Jun 2022
        12:29:42 +0000")
Message-ID: <xmqqtu8o5r48.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 98AE9D60-EB4A-11EC-93CE-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> Near the end of the "Raw output format" section, an example shows the
> output of 'git diff-files' for a tracked file modified on disk but not
> yet added to the index. However the wording is:
>
>     <sha1> is shown as all 0's if a file is new on the filesystem
>     and it is out of sync with the index.
>
> which is confusing since it can be understood to mean that 'file' is a
> new, yet untracked file, in which case 'git diff-files' does not care
> about it at all.

I do not think such an understanding is sensible, as "untracked
file" cannot be "out of sync with the index", because even its stale
version wouldn't be in the index if it is untracked.

But I agree that not all people are sensible, and it would be nicer
if the documentation helped them, too ;-)

> When this example was introduced all the way back in c64b9b8860
> (Reference documentation for the core git commands., 2005-05-05), 'old'
> and 'new' referred to the two entities being compared, depending on the
> command being used (diff-index, diff-tree or diff-files - which at the
> time were diff-cache, diff-tree and show-diff). The wording used at the
> time was:
>
>     <new-sha1> is shown as all 0's if new is a file on the
>     filesystem and it is out of sync with the cache.

Yeah, I remember this version of wording.

> Rework the introductory sentence of the example to instead refer to
> 'sha1 for "dst"', which is what the text description above it uses, and
> fix the wording so that we do not mention a "new file".

That's good.  We may need to upgrade them to 'object name' to wean
ourselves away from SHA-1 but that should be a separate topic.

> While at it, also tweak the wording used in the description of the raw
> format to explicitely state that all 0's are used for the destination
> hash if the working tree is out of sync with the index, instead of the
> more vague "look at worktree".

I am not sure if that is a good idea.  Those who understand what the
"work tree out of sync with" phrase mean would understand "look at
work tree" but the reverse would not be true.

The other hunk about "new" -> "dst" is a good change regardless, but
even there, "out of sync with" may need to be rewritten to make it
easier to understand.  Is it different from "the index does not know
the exact value (hence you need to look in the working tree if you
really cared to find it out, perhaps with hash-object)"?

Thanks.

> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>  Documentation/diff-format.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
> index b8319eeb41d..a3ae8747a22 100644
> --- a/Documentation/diff-format.txt
> +++ b/Documentation/diff-format.txt
> @@ -43,7 +43,7 @@ That is, from the left to the right:
>  . a space.
>  . sha1 for "src"; 0\{40\} if creation or unmerged.
>  . a space.
> -. sha1 for "dst"; 0\{40\} if deletion, unmerged or "look at work tree".
> +. sha1 for "dst"; 0\{40\} if deletion, unmerged or "work tree out of sync with the index".
>  . a space.
>  . status, followed by optional "score" number.
>  . a tab or a NUL when `-z` option is used.
> @@ -69,8 +69,8 @@ percentage of similarity between the source and target of the move or
>  copy).  Status letter M may be followed by a score (denoting the
>  percentage of dissimilarity) for file rewrites.
>  
> -<sha1> is shown as all 0's if a file is new on the filesystem
> -and it is out of sync with the index.
> +The sha1 for "dst" is shown as all 0's if a file on the filesystem
> +is out of sync with the index.
>  
>  Example:
