Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF5C41FF40
	for <e@80x24.org>; Fri, 16 Dec 2016 19:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759158AbcLPTXa (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 14:23:30 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58115 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1759132AbcLPTX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 14:23:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4277255FC1;
        Fri, 16 Dec 2016 14:23:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DWvrpviQ2r9DkTBlgUQpsLzzwnA=; b=c/haK7
        pWJa4ETOFMfr72krXbm7oU3Mt6uLTNqCp1m9oaWn/w4MWl/U8LaujwphZDz2eA9K
        OdS2AgVaXmWKACwDYoranWpXlX6m5lYBKj1vNqRQBSzYWDvNwoC3kIOkAzIcE4vT
        xkaKcIRQFVbgUQqBMn2rJHy8HbOm7PTVhHv9E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GFI1msC++J5+BPHtGVywEEses9XZZLRT
        L1zd4YzpSuT/+zdT5/xHePyAe15rlTqppE+blRlbOE1QS9Hs7h6Sd3Xl++keqcAv
        Zqli76FAPM41Sw970dILrZIvRQ/9AHIaU5EdtzHlYn7W0VMo3h/PdkiPr1vuEbBG
        Pb4qcrd+dSk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3AA1655FC0;
        Fri, 16 Dec 2016 14:23:25 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AB2BB55FBF;
        Fri, 16 Dec 2016 14:23:24 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 15/34] sequencer (rebase -i): leave a patch upon error
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
        <cover.1481642927.git.johannes.schindelin@gmx.de>
        <091217525a7ff71794b3544680571ce9814a297f.1481642927.git.johannes.schindelin@gmx.de>
Date:   Fri, 16 Dec 2016 11:23:23 -0800
In-Reply-To: <091217525a7ff71794b3544680571ce9814a297f.1481642927.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Tue, 13 Dec 2016 16:31:11 +0100
        (CET)")
Message-ID: <xmqq4m23smok.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1D31E7C6-C3C5-11E6-91F1-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> When doing an interactive rebase, we want to leave a 'patch' file for
> further inspection by the user (even if we never tried to actually apply
> that patch, since we're cherry-picking instead).
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Yup.  

The other day, I was kind of surprised to see the "patch" file
produced when I tried to do "git rebase -i HEAD^^ HEAD" with the one
in current Git (not yours), marked the first one "edit", and then it
gave me control back.  Obviously there was no conflict and I could
just do "git show" if I wanted to see what the original change was,
but the "patch" file was there.  I personally never have looked at
the "patch" file in such a situation, and I kind of feel it is
wasteful, but I can see people expect to find one there whenever
"rebase -i" stops and gives control back.  It is good that you are
preserving the behaviour.

>  sequencer.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/sequencer.c b/sequencer.c
> index a4e9b326ba..4361fe0e94 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1777,6 +1777,9 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
>  				return error_failed_squash(item->commit, opts,
>  					item->arg_len, item->arg);
>  			}
> +			else if (res && is_rebase_i(opts))
> +				return res | error_with_patch(item->commit,
> +					item->arg, item->arg_len, opts, res, 0);
>  		}
>  		else if (item->command == TODO_EXEC) {
>  			char *end_of_arg = (char *)(item->arg + item->arg_len);
