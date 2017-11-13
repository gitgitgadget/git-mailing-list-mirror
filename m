Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47747201C8
	for <e@80x24.org>; Mon, 13 Nov 2017 03:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751571AbdKMD7a (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 22:59:30 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52481 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751349AbdKMD73 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 22:59:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F9D3B5CC3;
        Sun, 12 Nov 2017 22:59:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=egxyJJiEmPOTVa2/AGr3b7f1zT8=; b=RE/+Ro
        ac8IBneMT/2x1Wi3DepyV8Kq3G2886+0LjoZ2B8FECAC3DZY7jY4MKU3Ckc5mtDZ
        d7AekttE3s5QTBbbgQdNDXZfyY9AkgwJfifCJua5kPyk7rRQ2HSbgrfvQsOgSW2v
        qSs2JxKUoM068qFwOon9Wohp1ZOH3TwxJx0UI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XRCpgrhCT87ayUreiUpJi0Xuky6iTzb9
        vH/3bEkoTvRWtkxGoNT6G9XIXmAQx+FZAXVTt5WNA2ZSQTcjjZ8+G++Izb+ISuYO
        79xCgsir5ClOPsLVxtdODMV9hH1nJJ7mvUdo43cZG7TLTEvqjF7YS6pXKN2i74z9
        LB7ffH7T68U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 585E5B5CC2;
        Sun, 12 Nov 2017 22:59:29 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C9E4CB5CBE;
        Sun, 12 Nov 2017 22:59:28 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] bisect run: die if no command is given
References: <20171112205533.9593-1-s-beyer@gmx.net>
Date:   Mon, 13 Nov 2017 12:59:27 +0900
In-Reply-To: <20171112205533.9593-1-s-beyer@gmx.net> (Stephan Beyer's message
        of "Sun, 12 Nov 2017 21:55:33 +0100")
Message-ID: <xmqqefp2akww.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0BFB79C4-C827-11E7-A50B-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stephan Beyer <s-beyer@gmx.net> writes:

> It was possible to invoke "git bisect run" without any command.
> This considers all commits as good commits since "$@"'s return
> value for empty $@ is 0.
>
> This is most probably not what a user wants (otherwise she would
> invoke "git bisect run true"), so not providing a command now
> results in an error.
>
> Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
> ---

Makes sense to me.  Thanks, will queue.

>  git-bisect.sh | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/git-bisect.sh b/git-bisect.sh
> index 0138a8860..a69e43656 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -450,6 +450,8 @@ bisect_replay () {
>  bisect_run () {
>  	bisect_next_check fail
>  
> +	test -n "$*" || die "$(gettext "bisect run failed: no command provided.")"
> +
>  	while true
>  	do
>  		command="$@"
