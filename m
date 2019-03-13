Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77BC620248
	for <e@80x24.org>; Wed, 13 Mar 2019 16:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfCMQLu (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 12:11:50 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38434 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfCMQLu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 12:11:50 -0400
Received: by mail-ed1-f65.google.com with SMTP id h58so2033188edb.5
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 09:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=pZC0KzAicJXgWr+gSEMakF4TxQqCzYiW39TAK8tZ4UQ=;
        b=YdHycVedn1iNmb8A5cl7lGyHFxsy5oawPxmxIOXYe0elQVWSwD0Id5C2Jx8jI0QthQ
         ZPAj9KqQOSqBF7LpagbeeODyOv+nC5M/tPBgZina5mmYASzCThTa4bKDmGrgWBhuZaUl
         9JO5nZA52Z4/oSv7CbFRI57MMfyICSsEmaaeKP47y3qgJ0SMTJAHlozMZ8RePPUpBKoY
         7royMSjNNu6NaT94Y2C++SliPitWlXyvCI4pDZXCc0k+xYxHlItCqDS5CvlHDHq+i6oq
         pftfYk9W7Ph3ZIKw7G0gRVHDIWimlhTgneRXxyq2/mCdQDx0utsY7D3XDX2TwcXbFuUZ
         jBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=pZC0KzAicJXgWr+gSEMakF4TxQqCzYiW39TAK8tZ4UQ=;
        b=MkwoG9/AwEgmAylPt+aRt0v/RkzoN9CoHLbanxTIZ8ruUo7s7WeqgpKk+RUltHxlIH
         KwLDCLfyP8PDym/WTxXEna0QJPV4Or2d//Rv4rrd1Rmwss6VV5uC9x3wPfa3ZX7if5AO
         5xzwOuKcPd/+21xlVN48dxL4OENzm0ZR33HCjYID53OFa0uWpSBPEtqV6Q2fGswqtdeD
         odqNqbnb9HR9ifGyK6blEYw3Idwnjmoywg+N9Jc0Ghf3U5jjtdxmpKCv1Yn2ekMKEfuV
         MekRdVnu7yOq4BKlxiWeW87zfEeJawLeeofPk6cmaK5her8uRsHr5Lb/RTMSUgL3Qk0o
         E29w==
X-Gm-Message-State: APjAAAW8iPMKelhduHJfCGHnokBYlXxMHkJrsnbGBOPCCL2GiIHpBTia
        GvGtD/JYR1luXCrsEfnMIX4sZ4Yr
X-Google-Smtp-Source: APXvYqwePVrQomAxLU1kHOryHkyNFO7vfPCpDUAVL0Q9cjoMjSm/VFK/gWyQKXgZHVJWCHSUcdtIZw==
X-Received: by 2002:a17:906:3592:: with SMTP id o18mr3193351ejb.28.1552493507848;
        Wed, 13 Mar 2019 09:11:47 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id g63sm181534edd.66.2019.03.13.09.11.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 09:11:47 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/4] rebase -i: demonstrate obscure loose object cache bug
References: <pull.161.git.gitgitgadget@gmail.com> <b3fcd377652103584b6f307c6ee209980b44529f.1552472189.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <b3fcd377652103584b6f307c6ee209980b44529f.1552472189.git.gitgitgadget@gmail.com>
Date:   Wed, 13 Mar 2019 17:11:44 +0100
Message-ID: <87k1h2bvpb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 13 2019, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> We specifically support `exec` commands in `git rebase -i`'s todo lists
> to rewrite the very same todo list. Of course, we need to validate that
> todo list when re-reading it.
>
> It is also totally legitimate to extend the todo list by `pick` lines
> using short names of commits that were created only after the rebase
> started.
>
> And this is where the loose object cache interferes with this feature:
> if *some* loose object was read whose hash shares the same first two
> digits with a commit that was not yet created when that loose object was
> created, then we fail to find that new commit by its short name in
> `get_oid()`, and the interactive rebase fails with an obscure error
> message like:
>
> 	error: invalid line 1: pick 6568fef
> 	error: please fix this using 'git rebase --edit-todo'.

As a further improvement, is there a good reason for why we wouldn't
pass something down to the oid machinery to say "we're only interested
in commits". I have a WIP series somewhere to generalize that more, but
e.g.  here locally:

    $ git rev-parse 80b06
    error: short SHA1 80b06 is ambiguous
    hint: The candidates are:
    hint:   80b06b942e commit 2019-03-13 - Revert "this patch fail whales"
    hint:   80b063bb9b blob
    hint:   80b06f0714 blob
    80b06
    $ git rev-parse 80b06^{commit}
    80b06b942ed33e597a0152b3e6ba45b7d8ead94b

I can't remember if there's some caveat with that particular peel syntax
I meant to fix, but I mean if we could pass something down to say "no
blobs or trees" shouldn't we?

Then stuff like this wouldn't die:
    
    $ git rebase -i
    hint: Waiting for your editor to close the file... Waiting for Emacs...
    error: short SHA1 80b06 is ambiguous
    hint: The candidates are:
    hint:   80b06b942e commit 2019-03-13 - Revert "this patch fail whales"
    hint:   80b063bb9b blob
    hint:   80b06f0714 blob
    error: invalid line 2: p 80b06 Revert "this patch fail whales"
    You can fix this with 'git rebase --edit-todo' and then run 'git rebase --continue'.

> [...]
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
> +
> +	shift
> +	test -z "$*" ||
> +	echo "exec $0 $*" >>$GIT_REBASE_TODO
> +	EOS
> +
> +	git rebase HEAD -x "./append-todo.sh 5 6"
> +'
> +
>  test_done

This is a test for rebase, but perhaps it would be best put in
t1512-rev-parse-disambiguation.sh. Then when we finally port that
somehow to SHA256 we'll have all this SHA-1 golfing in the same file &
can fix it at once. Just a thought...
