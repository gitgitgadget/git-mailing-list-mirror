Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5F251FF40
	for <e@80x24.org>; Fri, 16 Dec 2016 17:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756057AbcLPR1z (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 12:27:55 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55130 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755151AbcLPR1x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 12:27:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 86361569F8;
        Fri, 16 Dec 2016 12:27:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+MyW5eo9FvWHE2faJfs5pkU5b8I=; b=Nol/uT
        BC3ss0FI7GdDq0HhDvMa27OPkOlA15f5cAXbjMqKFTcPWBm5wRB39JtASuguyQJ4
        YneZVMhOElcU3sr2Xhgj3FgZOu15/MOZ4zzI7rpfv12Pq7WCl8I1GykTOIlmRP91
        kLgDaLVzXkL3on3bgPVfgr0KNfpdZufCf+D4E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=izlbmBBjYSQu/BkNIut38ksiVeSl+f2u
        o2x52MB2emF6sbE1BPk6oteKQvkDoqMOIeZzZ5afIwKRvXHewmFS411hih0LRaKw
        ZavL6RUX+Mv4N8Xvc3K8I7r+Y/5uJkDy0ZXG0MrX1BlqqBbgqtj0tlCuYdlcBnt1
        Nd5bdu3jUvk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7F21D569F7;
        Fri, 16 Dec 2016 12:27:52 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 05F29569F6;
        Fri, 16 Dec 2016 12:27:51 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Allow "git shortlog" to group by committer information
References: <CA+55aFzWkE43rSm-TJNKkHq4F3eOiGR0-Bo9V1=a1s=vQ0KPqQ@mail.gmail.com>
        <CA+55aFxSQ2wxU3cA+8uqS-W8mbobF35dVCZow2BcixGOOvGVFQ@mail.gmail.com>
        <20161216133940.hu474phggdslh6ka@sigill.intra.peff.net>
        <20161216135141.yhas67pzfm7bxxum@sigill.intra.peff.net>
Date:   Fri, 16 Dec 2016 09:27:50 -0800
In-Reply-To: <20161216135141.yhas67pzfm7bxxum@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 16 Dec 2016 08:51:41 -0500")
Message-ID: <xmqqlgvfu6ll.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F8FFC770-C3B4-11E6-9431-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> It obviously would need updating if we switch away from "-c", but I
> think I am OK with the short "-c" (even if we add a more exotic grouping
> option later, this can remain as a short synonym).

Yeah, I think it probably is OK.  

As it is very clear that "group by author" is the default, there is
no need to add the corresponding "-a/--author" option, either.  The
fact that "--no-committer" can countermand an earlier "--committer"
on the command line is just how options work, so it probably does
not deserve a separate mention, either.

Thanks.

> -- >8 --
> Subject: [PATCH] shortlog: test and document --committer option
>
> This puts the final touches on the feature added by
> fbfda15fb8 (shortlog: group by committer information,
> 2016-10-11).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Documentation/git-shortlog.txt |  4 ++++
>  t/t4201-shortlog.sh            | 13 +++++++++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
> index 31af7f2736..ee6c5476c1 100644
> --- a/Documentation/git-shortlog.txt
> +++ b/Documentation/git-shortlog.txt
> @@ -47,6 +47,10 @@ OPTIONS
>  
>  	Each pretty-printed commit will be rewrapped before it is shown.
>  
> +-c::
> +--committer::
> +	Collect and show committer identities instead of authors.
> +
>  -w[<width>[,<indent1>[,<indent2>]]]::
>  	Linewrap the output by wrapping each line at `width`.  The first
>  	line of each entry is indented by `indent1` spaces, and the second
> diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
> index ae08b57712..6c7c637481 100755
> --- a/t/t4201-shortlog.sh
> +++ b/t/t4201-shortlog.sh
> @@ -190,4 +190,17 @@ test_expect_success 'shortlog with --output=<file>' '
>  	test_line_count = 3 shortlog
>  '
>  
> +test_expect_success 'shortlog --committer (internal)' '
> +	cat >expect <<-\EOF &&
> +	     3	C O Mitter
> +	EOF
> +	git shortlog -nsc HEAD >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'shortlog --committer (external)' '
> +	git log --format=full | git shortlog -nsc >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
