Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB654C4BA18
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 18:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA7BC24656
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 18:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hfD0DHvl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgBZSNE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 13:13:04 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60668 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgBZSNE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 13:13:04 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 018A9AB179;
        Wed, 26 Feb 2020 13:12:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8+31CHr9Py2E56sZX8QU84LGkpg=; b=hfD0DH
        vlMTVeU+6w9+9XiY/OLQ5RcXbJI9qCI6kk0U1Wltd/2QX7Pfw190R8z70uZlRR9F
        oWCSwvclc/3YLK2NBN+C/Q+O/kt1/0qdIlQVqvZOF9EQXk/9HkkbjS1ox126pVuj
        JySj2K+n2NMfp0L0w5LdXWzcz/4mIZgispvHg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WpZDZCDkwSrMrI21aIyk6VoxroaVhKKp
        u9ytjzfkFE2+9k4BTYdc4kifSk5fcyfom8GKRF/apFLf/RThvHmepiY2muARJ1jS
        Yc1sMJSddFSWcwo7iE1yOxXnnWhf++bjd6k5D+iKQ/whupqrxzN+svekEEmqB2Xo
        jGb98c/x/l8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EDCFEAB178;
        Wed, 26 Feb 2020 13:12:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 23A59AB174;
        Wed, 26 Feb 2020 13:12:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v7 6/6] Reftable support for git-core
References: <pull.539.v6.git.1582015420.gitgitgadget@gmail.com>
        <pull.539.v7.git.1582706986.gitgitgadget@gmail.com>
        <a622d8066c7fe27accc5101c3341c30bf706dae1.1582706986.git.gitgitgadget@gmail.com>
Date:   Wed, 26 Feb 2020 10:12:52 -0800
In-Reply-To: <a622d8066c7fe27accc5101c3341c30bf706dae1.1582706986.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Wed, 26 Feb 2020
        08:49:46 +0000")
Message-ID: <xmqq8skpjjyz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9C4153EE-58C3-11EA-AAE2-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/t/t0031-reftable.sh b/t/t0031-reftable.sh
> new file mode 100755
> index 00000000000..d35211c9db2
> --- /dev/null
> +++ b/t/t0031-reftable.sh
> @@ -0,0 +1,31 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2020 Google LLC
> +#
> +
> +test_description='reftable basics'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'basic operation of reftable storage' '
> +        git init --ref-storage=reftable repo &&

Test script bodies are supposed to be indented with HT, not 8 SPs.

> +        cd repo &&

You are not supposed to chdir around inside tests, unless you do so
in a subshell.  i.e.

	test_expect_success 'basic operation' '
		git init --ref-storage=reftable repo &&
		(
			cd repo &&
			...
		)
	'

This is because the next test somebody else will add after this one
*will* start from inside that repo (but if and only if this step
gets run---and there are ways to skip steps).

> +        echo "hello" > world.txt &&

A shell redirection operator should immediately be followed by the
filename without SP in between, i.e.

	echo hello >world.txt &&

> +        git add world.txt &&
> +        git commit -m "first post" &&
> +        printf "HEAD\nrefs/heads/master\n" > want &&

There is an easier-to-read helper.  Also, by convention, the file
that holds the expected state is called "expect", while the file
that records the actual state observed is called "actual".

	test_write_lines HEAD refs/heads/master >expect &&

> +        git show-ref | cut -f2 -d" " > got &&

Is the order of "show-ref" output guaranteed in some way?  Otherwise
we may need to make sure that we sort it to keep it stable.

Without --show-head, HEAD should not appear in "git show-ref"
output, but the expected output has HEAD, which is puzzling.

We will not notice if a "git" command that placed on the left hand
side of a pipeline segfaults after showing its output.  

People often split a pipeline like this into separate command for
that reason (but there is probably a better way in this case, as we
see soon).

> +        test_cmp got want &&

Taking the above comments together, perhaps

	test_write_lines refs/heads/master >expect &&
	git for-each-ref --sort=refname >actual &&
	test_cmp expect actual &&

> +        for count in $(test_seq 1 10); do
> +                echo "hello" >> world.txt
> +                git commit -m "number ${count}" world.txt
> +        done &&

Style: write "do" on its own line, aligned with "for" on the
previous line.  Same for "if/then/else/fi" "while/do/done" etc.  

    An easy way to remember is that you never use any semicolon in
    your shell script, except for the double-semicolon you use to
    delimit your case arms.

When any of these steps fail, you do not notice it, unless the
failure happens to occur to "git commit" during the last round.  I
think you can use "return 1" to signal the failure to the test
framework, like so.

	for count in $(test_seq 1 10)
	do
		echo hello >>world.txt &&
		git commit -m "number $count} world.txt ||
		return 1
	done &&

> +        git gc &&
> +        nfiles=$(ls -1 .git/reftable | wc -l | tr -d "[ \t]" ) &&
> +        test "${nfiles}" = "2" &&

No need to pipe "wc -l" output to "tr" to strip spaces.  Just stop
double-quoting it on the using side, and even better is to use
test_line_count.  Perhaps

	ls -1 .git/reftable >files &&
	test_line_count = 2 files

> +        git reflog refs/heads/master > output &&
> +        grep "commit (initial): first post" output &&
> +        grep "commit: number 10" output

Do we give guarantees that we keep all the reflog entries?  Would it
help to count the number of lines in the output file here?

> +'
> +
> +test_done
