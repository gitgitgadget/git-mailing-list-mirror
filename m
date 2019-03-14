Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10DAC20248
	for <e@80x24.org>; Thu, 14 Mar 2019 01:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfCNBML (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 21:12:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43585 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfCNBML (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 21:12:11 -0400
Received: by mail-wr1-f68.google.com with SMTP id d17so3996835wre.10
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 18:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ygDBfs8BoUBz8/cMKX4dhHbij/ykHrjOFoWtv6jJcQ0=;
        b=KsEtB81p1Lppt0tujrS+Ig7RyQRDZTnWLt/e50ZswUVb7rby1yLc0R27NdpEoKuTgy
         00Ua/s3NcH1ylcLC4W+QG85Bytv5Hprt23f5WbckkHT0E1JMFcTkPUdO5B5URAL70ftf
         ti3oZpLyxfaLqiGBN4c5W5KinTmAi0u+mbx9EsK8+O475cSbHSvckguzQZ2CV5WUlOIM
         xEXyNhhlwSJUUYkS5ZLn0V/TtHnOWTrLaviGGeiVrsHqwBIztJwcHOevA/bsVnjLfOUw
         0fLhxiCrISMJNoeLdwS22UDDlMvz2b058xL1foChHFP3p8Z7Vhno/5XZXSos2tC3UWM4
         7u8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ygDBfs8BoUBz8/cMKX4dhHbij/ykHrjOFoWtv6jJcQ0=;
        b=NHr3O5z9Oyi7RM/XfqRY6t3jA1NG7ZashlljZu25l7njhryoYcJqsKw7tshZNKL5SS
         L1HZ5ZiBXN4DNAzuVrOpoDdJ2NL9Uiudg/0hbbaARmd23CfaHfs0lETGHvRjzjqNd2R7
         80hEJZI74gEETi18/sA9rrL7OEtjfB5IdxRK0jdY2A7SKnjR0XRuHyKFrIc8vRlmfQCT
         Yx+jvXVCvMT60+r9Gh26h4d35DQ2pkPed6/qZHq2provjUMc2L0kFISxHOcs+qj50ibo
         qKbxvHU//OrA9YHf+BWsl5EPQBso8+guvs7oQjMvnWStFcn1lSvWhsVyuu2TGDxCZ32C
         3vBg==
X-Gm-Message-State: APjAAAWp29lzQyox67M/2L3o9KsHdf1s8kYj1UR33r46BPPLFY/qGA0m
        DbQvKL/EbxFw68kt4Eh4MpQ=
X-Google-Smtp-Source: APXvYqyp/9tousz8XkYkKXlsa6Qw/Zhodco5IwX8B7W/iADKrZFLZvVJtdvOWm86wwVJnNloz+GP7Q==
X-Received: by 2002:a5d:5281:: with SMTP id c1mr7384931wrv.83.1552525929319;
        Wed, 13 Mar 2019 18:12:09 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id 12sm1155736wme.25.2019.03.13.18.12.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 18:12:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/4] rebase -i: demonstrate obscure loose object cache bug
References: <pull.161.git.gitgitgadget@gmail.com>
        <b3fcd377652103584b6f307c6ee209980b44529f.1552472189.git.gitgitgadget@gmail.com>
Date:   Thu, 14 Mar 2019 10:12:08 +0900
In-Reply-To: <b3fcd377652103584b6f307c6ee209980b44529f.1552472189.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 13 Mar 2019
        03:16:31 -0700 (PDT)")
Message-ID: <xmqqimwmcl93.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> +test_expect_failure SHA1 'loose object cache vs re-reading todo list' '
> +	GIT_REBASE_TODO=.git/rebase-merge/git-rebase-todo &&
> +	export GIT_REBASE_TODO &&
> +	write_script append-todo.sh <<-\EOS &&
> +	# For values 5 and 6, this yields SHA-1s with the same first two digits
> +	echo "pick $(git rev-parse --short \
> +		$(printf "%s\\n" \
> +			"tree $EMPTY_TREE" \
> +			"author A U Thor <author@example.org> $1 +0000" \
> +			"committer A U Thor <author@example.org> $1 +0000" \
> +			"" \
> +			"$1" |
> +		  git hash-object -t commit -w --stdin))" >>$GIT_REBASE_TODO

In the generated append-todo.sh, as the <<EOS above is quoted, we
will see ">>$GIT_REBASE_TODO" literally (not the actual pathname
that begins with .git, but a reference to the variable).  test-lint
may or may not catch it, but redirecting into variable reference
would trigger a(n arguably misguided) warning when run with some
versions of bash.  Quoting

		echo ... >>"$GIT_REBASE_TODO"

would work it around, of course.

> +	shift
> +	test -z "$*" ||
> +	echo "exec $0 $*" >>$GIT_REBASE_TODO

Likewise.

> +	EOS
> +
> +	git rebase HEAD -x "./append-todo.sh 5 6"
> +'
> +
>  test_done
