Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DB271F4F8
	for <e@80x24.org>; Mon, 17 Oct 2016 17:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030485AbcJQRWL (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 13:22:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54490 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1030397AbcJQRWK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 13:22:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C20D466D7;
        Mon, 17 Oct 2016 13:22:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=prlXyEXFoS6FuEF61Zcro/iQ52c=; b=YcrwY4
        fPh0sFYQ9wMHu7yQFb6uscAexOxSmYvnmwXwOhZh+s2CD6/o8Cch8FFF9jQf53xB
        H8cH/IzyO7S8510USwRCLrOENYIwZaFVLF2nNkGW32/eah/W6saC+eiLOedSTKRo
        YXEWRW8uCcyLeylY4oQkB1qvaB9ZmJ0+Qt3P8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LhVtY2Vd4dtjnlI57tzPTsq4NUV7Y5b2
        l9MlA+0B+IQ8iZ6gHRcP1721rJLewDMHw+E9Fl7xS2M8qOEVvo7A3bPkWrmPLbFv
        vYR+M6N75nzsg27Or6wO+PCIA1tka9I0rIweTWe3lqhnztA/lLAt6N7ZxHu20S4b
        ziTIKVL7tco=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3305F466D6;
        Mon, 17 Oct 2016 13:22:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A4E5A466D3;
        Mon, 17 Oct 2016 13:22:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 16/25] sequencer: support amending commits
References: <cover.1473590966.git.johannes.schindelin@gmx.de>
        <cover.1476120229.git.johannes.schindelin@gmx.de>
        <ec146dc2f3a3698bd433bbec4d7ecbab762c1bfb.1476120229.git.johannes.schindelin@gmx.de>
Date:   Mon, 17 Oct 2016 10:22:05 -0700
In-Reply-To: <ec146dc2f3a3698bd433bbec4d7ecbab762c1bfb.1476120229.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Mon, 10 Oct 2016 19:25:53 +0200
        (CEST)")
Message-ID: <xmqqinsqx54y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3B005492-948E-11E6-AE78-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> This teaches the run_git_commit() function to take an argument that will
> allow us to implement "todo" commands that need to amend the commit
> messages ("fixup", "squash" and "reword").

Likewise to 15/25, i.e. Good, though the growth by these two steps
starts to make me wonder if these three options should be crammed
into an unsigned "flags" bitword.

I see you have v4, so I'll ignore the remainder of this stale round
and start reading that updated one instead.

>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index b621f4b..403a4f0 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -481,7 +481,7 @@ static char **read_author_script(void)
>   * author metadata.
>   */
>  static int run_git_commit(const char *defmsg, struct replay_opts *opts,
> -			  int allow_empty, int edit)
> +			  int allow_empty, int edit, int amend)
>  {
>  	char **env = NULL;
>  	struct argv_array array;
> @@ -510,6 +510,8 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
>  	argv_array_push(&array, "commit");
>  	argv_array_push(&array, "-n");
>  
> +	if (amend)
> +		argv_array_push(&array, "--amend");
>  	if (opts->gpg_sign)
>  		argv_array_pushf(&array, "-S%s", opts->gpg_sign);
>  	if (opts->signoff)
> @@ -785,7 +787,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
>  	}
>  	if (!opts->no_commit)
>  		res = run_git_commit(opts->edit ? NULL : git_path_merge_msg(),
> -				     opts, allow, opts->edit);
> +				     opts, allow, opts->edit, 0);
>  
>  leave:
>  	free_message(commit, &msg);
