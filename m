Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E1D91FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 18:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933439AbdCaSOL (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 14:14:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62437 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933258AbdCaSOJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 14:14:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0AA577C451;
        Fri, 31 Mar 2017 14:14:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bITzUlBCa8IgRjnRLj4tOj46JyM=; b=Y68Ohb
        2afPCeSO0R2d9pu2FMaJ8Jf6Hbyj4gwhL9qfS2of0LjqCLsj1HTejOOgdfItnoP4
        3lYUdseRMOEGOfUVokF1fNEZhKZ/XendnFgn9I5FFU8KR1yMl5HvfZEywd/JgmxU
        B+jCH5yxqXtPZPgk74stT8mCmYVNvR48a4HOI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=n4Y2mLcUA6z62zL/hvVDpLW3cOh2bRM/
        H+57HBThRHB7USwp7kXqPV9ljFvpy8+eNIEj5GQokfCoUkyEmO4cH2OIPbPXQwp8
        zc4qXUAsiQ9zRF+OMiExT2kfJOXjjvaEbqP8GRRV2RKl1CIN6CXJ3pYZB1yrYrDx
        nDoOagHNUJc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 039DA7C450;
        Fri, 31 Mar 2017 14:14:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 68B827C44B;
        Fri, 31 Mar 2017 14:14:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] status: show in-progress info for short status
References: <2c3c8028cd057428758bb1e21a064a264936de90.1490968428.git.git@grubix.eu>
Date:   Fri, 31 Mar 2017 11:14:05 -0700
In-Reply-To: <2c3c8028cd057428758bb1e21a064a264936de90.1490968428.git.git@grubix.eu>
        (Michael J. Gruber's message of "Fri, 31 Mar 2017 15:59:17 +0200")
Message-ID: <xmqq8tnlz53m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D40AFB52-163D-11E7-9CC7-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@grubix.eu> writes:

> Ordinary (long) status shows information about bisect, revert, am,
> rebase, cherry-pick in progress, and so does git-prompt.sh. status
> --short currently shows none of this information.
>
> Introduce an `--inprogress` argument to git status so that, when used with
> `--short --branch`, in-progress information is shown next to the branch
> information. Just like `--branch`, this comes with a config option.
>
> The wording for the in-progress information is taken over from
> git-prompt.sh.
>
> Signed-off-by: Michael J Gruber <git@grubix.eu>

I haven't formed an opinion on the feature itself, or the way it is
triggered, so I won't comment on them.  I just say --porcelain (any
version) may (or may not) want to be extended in backward compatible
way (but again I haven't formed an opinion on the issue--I just know
and say there is an issue there that needs to be considered at this
point).

> diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
> index 458608cc1e..103e006249 100755
> --- a/t/t7512-status-help.sh
> +++ b/t/t7512-status-help.sh
> @@ -74,7 +74,6 @@ test_expect_success 'prepare for rebase conflicts' '
>  
>  
>  test_expect_success 'status when rebase in progress before resolving conflicts' '
> -	test_when_finished "git rebase --abort" &&
>  	ONTO=$(git rev-parse --short HEAD^^) &&
>  	test_must_fail git rebase HEAD^ --onto HEAD^^ &&
>  	cat >expected <<EOF &&
> @@ -96,6 +95,15 @@ EOF
>  	test_i18ncmp expected actual
>  '
>  
> +test_expect_success 'short status when rebase in progress' '
> +	test_when_finished "git rebase --abort" &&
> +	cat >expected <<EOF &&
> +## HEAD (no branch); REBASE-m
> +UU main.txt
> +EOF
> +	git status --untracked-files=no --short --branch --inprogress >actual &&
> +	test_i18ncmp expected actual
> +'

This is not a good way to structure the test.  If the one in the
previous hunk is what creates a conflicted state by running
"rebase", check the status output from within that test, after the
conflicting "rebase" fails and other things the existing test checks
are tested.  That way, you do not have to worry about this new check
getting confused if the previous one fails in the middle.

Likewise for the most (if not all---I didn't check very carefully)
of the remaining hunks in this test script.
