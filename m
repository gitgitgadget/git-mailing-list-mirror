Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBA0C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 17:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54DF360F57
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 17:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237924AbhH3RN1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 13:13:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60123 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbhH3RN0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 13:13:26 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 27A9AE52C0;
        Mon, 30 Aug 2021 13:12:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7cSidJwrRLsl6swQoP3hQqCR+dt0dC1hJdwOyB
        vVzoo=; b=Elw7Ef8cpHH1ZVF/X4Jvl+ispsx8plEaxs3BMOylx3fkUcAQ4FXgQ4
        onIGklayd0rip2KDbyOnvnh2dPFGKUqPYuZj3L0yEnI6gvaY3lqilkSACZ9/f9TH
        XrvhqDn6y31NkhO2paOpiZMOPb53jANcFb4fHSludjGHAankpCqLo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1F084E52BF;
        Mon, 30 Aug 2021 13:12:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9C80CE52BE;
        Mon, 30 Aug 2021 13:12:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>
Subject: Re: diff-index --cc no longer permitted, gitk is now broken (slightly)
References: <e6bd4cf7-ec8b-5d22-70f6-07089794df0c@kdbg.org>
Date:   Mon, 30 Aug 2021 10:12:28 -0700
In-Reply-To: <e6bd4cf7-ec8b-5d22-70f6-07089794df0c@kdbg.org> (Johannes Sixt's
        message of "Mon, 30 Aug 2021 10:03:18 +0200")
Message-ID: <xmqqsfyq501v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 74E62302-09B5-11EC-BBB7-ECFD1DBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Since 19b2517f95a0 (diff-merges: move specific diff-index "-m" handling
> to diff-index, 2021-05-21) git diff-index no longer accepts --cc. This
> breaks gitk: it invokes
>
>    git diff-index --cached -p -C --cc --no-commit-id -U3 HEAD
>
> to show the staged changes (when the line "Local changes checked in to
> index but not committed" is selected).
>
> The man page of git diff-index does not mention --cc as an option. I
> haven't fully grokked the meaning of --cc, so I cannot tell whether this
> absence has any significance (is deliberate or an omission).
>
> Is gitk wrong to add --cc unconditionally? Should it do so only when
> there are conflicts? Or not at all?

I think --cc is designed to naturally fall back to -p when there is
only one parent.  Use of both -p and --cc has also long been an
acceptable combination, and even if we say the later --cc overrides
-p, there is no reason not to show single parent patch here with
--cc.


