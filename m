Return-Path: <SRS0=tGm0=AR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6674AC433E1
	for <git@archiver.kernel.org>; Mon,  6 Jul 2020 20:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FA3F206F5
	for <git@archiver.kernel.org>; Mon,  6 Jul 2020 20:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="x5PsfMHC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgGFUag (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jul 2020 16:30:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64916 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgGFUag (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jul 2020 16:30:36 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 297C86F27B;
        Mon,  6 Jul 2020 16:30:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DLqc2J8jgNX3bOckJnOinK3bz/4=; b=x5PsfM
        HCgKBwLudVwCrI18Cx84QivJBVjNO7qfF/HUehtRTgq+a50FeKeOIXD0gG2H2/iX
        nEuH/f9aAwinZ+75jf5bNNkQ2SVm5mC1WIyeMHBKeeVdglH9/sP4zwZiGHsHP36s
        cky1TPQIXhKPuWZI2TDzu65ZGMwa84lvxwV+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bzv4uoXy0p2TvF6aT6fUB3oYfJrzw8wk
        u7aaK0ArTTApHFycY5W7e+lRAVkQN2kqvoUNUzRoRPlK7WB6jMFnE/ptMCMx23y8
        wZ3HgUm7f0hhvOlrczsQXEbPw5hDBn8nTRc6+gXVFexGH/eNNjF/o8ULLZ5QZBrw
        hPzw06OzpiE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 209C86F279;
        Mon,  6 Jul 2020 16:30:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 941906F278;
        Mon,  6 Jul 2020 16:30:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 2/2] Make HEAD a PSEUDOREF rather than PER_WORKTREE.
References: <pull.673.git.1594056572.gitgitgadget@gmail.com>
        <470821dc6d4b72c6414b3458883277ad36952892.1594056572.git.gitgitgadget@gmail.com>
Date:   Mon, 06 Jul 2020 13:30:32 -0700
In-Reply-To: <470821dc6d4b72c6414b3458883277ad36952892.1594056572.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Mon, 06 Jul 2020
        17:29:32 +0000")
Message-ID: <xmqqeepo9yjb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8ACBB8D2-BFC7-11EA-B9D9-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> This is consistent with the definition of REF_TYPE_PSEUDOREF
> (uppercase in the root ref namespace).

I wonder if some special casing we saw for "HEAD" in 1/2 (e.g. we no
longer do this to pseudorefs in this codepath but HEAD is different
and will continue to be dealt with in the codepath) needs adjustment
after this change?  HEAD still needs to be able to have a different
value (either detached or pointing to another ref) per worktree, but
it is unclear where that knowledge now resides in the new code.  Are
we declaring that all pseudorefs are per worktree (which I think is
not wrong)?

> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  refs.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index a2fd42364f..265767a234 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -676,10 +676,9 @@ int dwim_log(const char *str, int len, struct object_id *oid, char **log)
>  
>  static int is_per_worktree_ref(const char *refname)
>  {
> -	return !strcmp(refname, "HEAD") ||
> -		starts_with(refname, "refs/worktree/") ||
> -		starts_with(refname, "refs/bisect/") ||
> -		starts_with(refname, "refs/rewritten/");
> +	return starts_with(refname, "refs/worktree/") ||
> +	       starts_with(refname, "refs/bisect/") ||
> +	       starts_with(refname, "refs/rewritten/");
>  }
>  
>  static int is_pseudoref_syntax(const char *refname)
