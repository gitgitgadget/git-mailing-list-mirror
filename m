Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A00401FE4E
	for <e@80x24.org>; Mon, 21 Nov 2016 18:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753874AbcKUSPs (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 13:15:48 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63922 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752818AbcKUSPr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 13:15:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5296051D68;
        Mon, 21 Nov 2016 13:15:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Hf9Jj0gMmmJNDPqG0PWxBZtOHOg=; b=vnzF3B
        TDJnPiNywU4ZoF9ehRhNdmfRBI2Ez7qJt3r74PtWgUxaO60VWbfVSOFX7avTTM2z
        UzQUo17Sb3NUKYAjUgxd+e6AHq92/EYu0VhnczVB0tBBm7Byi0oCiTEcicN+0Xc+
        0P9O6+CuqufiwSQqAXhhMkAzYRa5CTdc8EpOw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JqVHu3ubqWS5Rq447gpSzfNYa3e0A4qW
        VQBL1+0Uga0KPnfWwnM5AKZv2GusNjpX2qw0dtEbaw4f0SFt23ZfGF3fq/tECrs+
        ialVBQeZIKZiLeN/uiqdqB2QV+bJUNwTuww+8pzKrjI8CAyndX5iJ1F1UOHCBAvC
        qFPcLV6SD0k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 48F8851D67;
        Mon, 21 Nov 2016 13:15:46 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BBEC651D66;
        Mon, 21 Nov 2016 13:15:45 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Taufiq Hoven <taufiq.hoven@gmail.com>
Subject: Re: [PATCH 1/3] rebase -i: identify problems with core.commentchar
References: <cover.1479737858.git.johannes.schindelin@gmx.de>
        <f47dce15719954d6d4d8a550856757366871143e.1479737858.git.johannes.schindelin@gmx.de>
Date:   Mon, 21 Nov 2016 10:15:43 -0800
In-Reply-To: <f47dce15719954d6d4d8a550856757366871143e.1479737858.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Mon, 21 Nov 2016 15:18:05 +0100
        (CET)")
Message-ID: <xmqqbmx8k8c0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 85980F4C-B016-11E6-AD9B-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> diff --git a/t/t0030-stripspace.sh b/t/t0030-stripspace.sh
> index 29e91d8..202ac07 100755
> --- a/t/t0030-stripspace.sh
> +++ b/t/t0030-stripspace.sh
> @@ -432,6 +432,13 @@ test_expect_success '-c with changed comment char' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_failure '-c with comment char defined in .git/config' '
> +	test_config core.commentchar = &&
> +	printf "= foo\n" >expect &&
> +	printf "foo" | git stripspace -c >actual &&

We'd want "\n" on this printf to match the one before as well, as
this test is not about "does stripspace complete an incomplete
line?", I think.  

I could amend it while queuing, but I need to know if I am missing a
reason why this must be an incomplete line before doing so.

> +	test_cmp expect actual
> +'
> +

Is this a recent regression?  When applied on top of 'maint' or
older, it seems to pass just fine.

    ... Goes and looks ...

Interesting.  Peff's b9605bc4f2 ("config: only read .git/config from
configured repos", 2016-09-12) is where this starts failing, which
is understandable given the code change to builtin/stripspace.c in
[2/3].  

The analysis of the log message in [2/3] is wrong and needs
updating, though.  In the old world order it worked by accident to
call git_config() without calling setup_git_directory(); after
b9605bc4f2, that no longer is valid and is exposed as a bug.  

Your [2/3] is a good fix for that change.

In any case, well spotted.

>  test_expect_success 'avoid SP-HT sequence in commented line' '
>  	printf "#\tone\n#\n# two\n" >expect &&
>  	printf "\tone\n\ntwo\n" | git stripspace -c >actual &&
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index e38e296..e080399 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -976,6 +976,18 @@ test_expect_success 'rebase -i respects core.commentchar' '
>  	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
>  '
>  
> +test_expect_failure 'rebase -i respects core.commentchar=auto' '
> +	test_config core.commentchar auto &&
> +	write_script copy-edit-script.sh <<-\EOF &&
> +	cp "$1" edit-script
> +	EOF
> +	test_set_editor "$(pwd)/copy-edit-script.sh" &&
> +	test_when_finished "git rebase --abort || :" &&
> +	git rebase -i HEAD^ &&
> +	grep "^#" edit-script &&

This was added for debugging that was forgotten?

> +	test -z "$(grep -ve "^#" -e "^\$" -e "^pick" edit-script)"

This says "There shouldn't be any line left once we remove
'#'-commented lines, empty lines and pick insns.".  OK.

The correction in [3/3] seems good.

> +'
> +
>  test_expect_success 'rebase -i, with <onto> and <upstream> specified as :/quuxery' '
>  	test_when_finished "git branch -D torebase" &&
>  	git checkout -b torebase branch1 &&
