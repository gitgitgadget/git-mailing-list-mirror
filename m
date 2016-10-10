Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E69C120989
	for <e@80x24.org>; Mon, 10 Oct 2016 22:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752221AbcJJWOq (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 18:14:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51270 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752232AbcJJWOp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 18:14:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1400946B46;
        Mon, 10 Oct 2016 18:14:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=QoFAYWmYW501AOeNs+8OTJytKiI=; b=Gr/hPzYjsvd3B5mtSfAz
        ltM9OFUjLeVdg25j1XPHU5MD04T4igp8UgMQvnx6ckf9PboJnwAf7YMFKCyxUF1e
        LhtTgDIzYLZ2bQ+P0zJk0qb+ClJIE9suARr2aSOjIKB71Jx1TfzIML0xLkJFzwvx
        4/DNyC92oJrr7BOYELh35HQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=xDXW6Ej3xYv6n26kYRqMWEgEo821+jYIXu76anaDQoweSz
        evOsXGq+0oTEKDAUcmjkBn5FPqzLWC631KgHsaPhQO31pOX2OPZ22v69trXFX7Yg
        XFHZ4PGMr0cCoC+z/KMwHTjvugE4YtVkcRwo8yn2Xo38mr9VuULMEIiTVCrtg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0A5C546B45;
        Mon, 10 Oct 2016 18:14:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 71CF746B43;
        Mon, 10 Oct 2016 18:14:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 03/25] sequencer: avoid unnecessary indirection
References: <cover.1473590966.git.johannes.schindelin@gmx.de>
        <cover.1476120229.git.johannes.schindelin@gmx.de>
        <336cefca0bda214b5b43b1094af13d787d1a79e3.1476120229.git.johannes.schindelin@gmx.de>
Date:   Mon, 10 Oct 2016 15:14:33 -0700
Message-ID: <xmqq7f9fdf7a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ED5E9D2C-8F36-11E6-BBCF-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> We really do not need the *pointer to a* pointer to the options in
> the read_populate_opts() function.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

I vaguely recall seeing this in the previous round and finding it
pretty sensible.  And I still do ;-)


[the remainder left as-is to help those who are reading from
sidelines]

> diff --git a/sequencer.c b/sequencer.c
> index cb16cbd..c2fbf6f 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -813,7 +813,7 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
>  	return 0;
>  }
>  
> -static int read_populate_opts(struct replay_opts **opts)
> +static int read_populate_opts(struct replay_opts *opts)
>  {
>  	if (!file_exists(git_path_opts_file()))
>  		return 0;
> @@ -823,7 +823,7 @@ static int read_populate_opts(struct replay_opts **opts)
>  	 * about this case, though, because we wrote that file ourselves, so we
>  	 * are pretty certain that it is syntactically correct.
>  	 */
> -	if (git_config_from_file(populate_opts_cb, git_path_opts_file(), *opts) < 0)
> +	if (git_config_from_file(populate_opts_cb, git_path_opts_file(), opts) < 0)
>  		return error(_("Malformed options sheet: %s"),
>  			git_path_opts_file());
>  	return 0;
> @@ -1054,7 +1054,7 @@ static int sequencer_continue(struct replay_opts *opts)
>  
>  	if (!file_exists(git_path_todo_file()))
>  		return continue_single_pick();
> -	if (read_populate_opts(&opts) ||
> +	if (read_populate_opts(opts) ||
>  			read_populate_todo(&todo_list, opts))
>  		return -1;
