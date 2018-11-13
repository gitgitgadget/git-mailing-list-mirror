Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A323C1F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 02:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbeKMMDl (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 07:03:41 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55987 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeKMMDl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 07:03:41 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 750E81EDF5;
        Mon, 12 Nov 2018 21:07:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Tn4nQmep9vEfoWRM76s7HUz79+0=; b=higc74
        eSJ1G/pt9krpHTAHS4sX1JLrzZhYtuwi5hBaM6LPjXO6HzSu3OClXofqyXVvDewT
        bTnC5Yco6Yji9QaJ2asLoiVQG1X+Evmc4JBQd1Zeaw5Yi/gRZOXgBpNOoTrsdfdq
        xy/LiRdS2ppasz5HP/1liKZ7i/0nn7cYur8GM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iae27gg9D52xxCb+PMb8fvOML9hWKDKO
        TkGoZ347r9gQphTcIhts/cffeiT80Su2sgWyb7e8YCHZ3+Ps3xMY2b2MsXyAlvjt
        mDr9W9eFK0g6YtcsGb4iH+Tj/3oxNPVzZIa84xVQHlkjCAfD4W9jGpHkLDGy6YQ+
        SLYlKn5ULd0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6D9EC1EDF3;
        Mon, 12 Nov 2018 21:07:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 801391EDF2;
        Mon, 12 Nov 2018 21:07:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/5] rebase -i: include MERGE_HEAD into files to clean up
References: <pull.75.git.gitgitgadget@gmail.com>
        <65f02628f6ef96e88485b66cd2c6e5e57212b4bb.1542065154.git.gitgitgadget@gmail.com>
Date:   Tue, 13 Nov 2018 11:07:42 +0900
In-Reply-To: <65f02628f6ef96e88485b66cd2c6e5e57212b4bb.1542065154.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 12 Nov 2018
        15:25:59 -0800 (PST)")
Message-ID: <xmqqpnv9ybkh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E8AED6B4-E6E8-11E8-ADF5-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Every once in a while, the interactive rebase makes sure that no stale
> files are lying around. These days, we need to include MERGE_HEAD into
> that set of files, as the `merge` command will generate them.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 2 ++
>  1 file changed, 2 insertions(+)

Makes sense.

>
> diff --git a/sequencer.c b/sequencer.c
> index 7a9cd81afb..2f526390ac 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3459,6 +3459,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
>  			unlink(rebase_path_author_script());
>  			unlink(rebase_path_stopped_sha());
>  			unlink(rebase_path_amend());
> +			unlink(git_path_merge_head(the_repository));
>  			delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
>  
>  			if (item->command == TODO_BREAK)
> @@ -3829,6 +3830,7 @@ static int commit_staged_changes(struct replay_opts *opts,
>  			   opts, flags))
>  		return error(_("could not commit staged changes."));
>  	unlink(rebase_path_amend());
> +	unlink(git_path_merge_head(the_repository));
>  	if (final_fixup) {
>  		unlink(rebase_path_fixup_msg());
>  		unlink(rebase_path_squash_msg());
