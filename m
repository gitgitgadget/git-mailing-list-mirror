Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8894C2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 20:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88202206E9
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 20:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XLWz+WE7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442203AbgDOUw7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 16:52:59 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50513 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442190AbgDOUw5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 16:52:57 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8D906C68B7;
        Wed, 15 Apr 2020 16:52:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=O6iwLn5vqmwMHdr8uyCXc5l0bO0=; b=XLWz+W
        E72bUGM8hrcwKn9bFoDYkMlgSan15H2y5pk+nV5DDT60bmTdSSYaUlmyTaaJyztp
        nvfRazqrutuey8ZuNdqQQVuxN2FrkMhifCURaSt7ipvXpg3RxCxgkF0OdykTEUVS
        ieBsMtgO3zE6qQOP0MFYv+iPuKlMrIvpj3HXY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LffQSfwlW//O6/Pu4/XXD1q6uHVD8iNB
        Z+YtbtkuHAjTH6bm/p4USYMB2jVg/4TeHyD1s8hMNifxQzRGY+OioFIGUGBOYMHC
        /KdYgVycIEU1xwUW4Mb6V6A3Ad8wlG4qKJAyqcgKqy+vf+qdjM+fbA/P6d+0jcpe
        u7bW5YvkBlg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 84B25C68B6;
        Wed, 15 Apr 2020 16:52:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BE4A3C68B5;
        Wed, 15 Apr 2020 16:52:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de,
        bturner@atlassian.com, sami@boukortt.com,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 1/4] rebase -i: mark commits that begin empty in todo editor
References: <pull.757.v2.git.git.1586541094.gitgitgadget@gmail.com>
        <pull.757.v3.git.git.1586573067.gitgitgadget@gmail.com>
        <0d94eea376a65304bc31fd1841216a04b5c15709.1586573067.git.gitgitgadget@gmail.com>
Date:   Wed, 15 Apr 2020 13:52:49 -0700
In-Reply-To: <0d94eea376a65304bc31fd1841216a04b5c15709.1586573067.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Sat, 11 Apr 2020
        02:44:24 +0000")
Message-ID: <xmqqd0885v4u.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 11F10F90-7F5B-11EA-95B6-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/sequencer.c b/sequencer.c
> index e528225e787..ce9fd27a878 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4656,6 +4656,9 @@ static int make_script_with_merges(struct pretty_print_context *pp,
>  			strbuf_addf(&buf, "%s %s %s", cmd_pick,
>  				    oid_to_hex(&commit->object.oid),
>  				    oneline.buf);
> +			if (is_empty)
> +				strbuf_addf(&buf, " %c empty",
> +					    comment_line_char);
> ...
> @@ -4861,6 +4864,8 @@ int sequencer_make_script(struct repository *r, struct strbuf *out,>  		pretty_print_commit(&pp, commit, out);
> +		if (is_empty)
> +			strbuf_addf(out, " %c empty", comment_line_char);
>  		strbuf_addch(out, '\n');

While I was re-reviewing the topics in flight, it occurred to me
that this change may hurt automation if people feed the insn file to
their own machinery to process, as the title in "git log --oneline"
and in the file no longer matches.  I am not sure how big a deal is
(even when I am scripting, I only use the commit object name and
ignore the title string, but there are people with diferent taste in
this world, so...).  It might be safer to add this as a comment on
its own line, next to the usual "pick <commit> <title>" line, but I
dunno.

This is more about raising awareness of possible regression than a
suggestion to change anything.

Thanks.
