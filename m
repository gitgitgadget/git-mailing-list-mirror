Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCA9C33CB3
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 22:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80AF32077C
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 22:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lZrsz0bO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389898AbgAPWNX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 17:13:23 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60837 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732190AbgAPWNV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 17:13:21 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 97F30967A4;
        Thu, 16 Jan 2020 17:13:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DGieSfqAYFnYsTh0gtDtfzXLffs=; b=lZrsz0
        bOw6iUokdNaSIYL9dsFT/Azy62wVI0qvO6LrN9GvDa5e/FF7nglFQ6QiGy0IS90y
        4r8MfbESsSghiniSKlJTugt2wnMrWke5c6ua7zGN4VKhBrkDbfRYsr6jid1wFhqw
        Ih6TwIGnkRcSt0k00Yzc+P4btwEVjzzfkEQg8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=obmbhlhUlLmQX+zFsS9V9rUPJnRUPp9I
        lQp875edb/SXsx/ThTUM7lXUpE5a2AbMRrAcL1RJwXUIVsztq9HoB8FXjdh+9+4n
        Vj2DSZqz/mW4q6qdFAsl1ehg2IWwwJyJAIgHW2EPS4RWWn5bCeE2qVdgwHVY9DY5
        PJnt1Bm0jSY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 90535967A3;
        Thu, 16 Jan 2020 17:13:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BAD8E967A1;
        Thu, 16 Jan 2020 17:13:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] built-in add -i: do not try to `patch`/`diff` an empty list of files
References: <pull.528.git.1579163587.gitgitgadget@gmail.com>
        <353c748838d341bb325149234657c27215a9fab3.1579163587.git.gitgitgadget@gmail.com>
Date:   Thu, 16 Jan 2020 14:13:15 -0800
In-Reply-To: <353c748838d341bb325149234657c27215a9fab3.1579163587.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 16 Jan 2020
        08:33:06 +0000")
Message-ID: <xmqqzhenf3t0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 65DEA602-38AD-11EA-AA16-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When the user does not select any files to `patch` or `diff`, there is
> no need to call `run_add_p()` on them.
>
> Even worse: we _have_ to avoid calling `parse_pathspec()` with an empty
> list because that would trigger this error:
>
> 	BUG: pathspec.c:557: PATHSPEC_PREFER_CWD requires arguments
>
> So let's avoid doing any work on a list of files that is empty anyway.
>
> This fixes https://github.com/git-for-windows/git/issues/2466.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  add-interactive.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Makes sense.  No tests?

>
> diff --git a/add-interactive.c b/add-interactive.c
> index f395d54c08..14d4688c26 100644
> --- a/add-interactive.c
> +++ b/add-interactive.c
> @@ -915,7 +915,7 @@ static int run_patch(struct add_i_state *s, const struct pathspec *ps,
>  
>  	opts->prompt = N_("Patch update");
>  	count = list_and_choose(s, files, opts);
> -	if (count >= 0) {
> +	if (count > 0) {
>  		struct argv_array args = ARGV_ARRAY_INIT;
>  
>  		argv_array_pushl(&args, "git", "add--interactive", "--patch",
> @@ -953,7 +953,7 @@ static int run_diff(struct add_i_state *s, const struct pathspec *ps,
>  	opts->flags = IMMEDIATE;
>  	count = list_and_choose(s, files, opts);
>  	opts->flags = 0;
> -	if (count >= 0) {
> +	if (count > 0) {
>  		struct argv_array args = ARGV_ARRAY_INIT;
>  
>  		argv_array_pushl(&args, "git", "diff", "-p", "--cached",
