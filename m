Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75627C48BDF
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 10:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B03461248
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 10:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbhFXKNs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 06:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbhFXKNr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 06:13:47 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348EFC061574
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 03:11:28 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id df12so7731493edb.2
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 03:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=VFVXQWOzLW6GkqjRsebB6qEtF0A2Z0wSZZ5D/NTa1aA=;
        b=KlEwzZPLTh628mLW+rVwZp4RjEds7s0CdR9cvD8eOMVaJgDLmEkori+Nw4VFG1gg9U
         dKwCrOeyWQfBJ2hIzcgZDqq+NUpZHkT8koIS28fleGkgcmOVhJHplPExMMQDUWgZllq8
         W6F0RwE3GYZuZzYtO2oDS9TEVspgdEwmr1knHgE9W7BldrRQiNty8AUdq7L4+6Ayrg9z
         Kh9vHqLQkGTpW8z5HEif6+qkPS8lvlnSAEXCqk1n3HE0N3vsiHtJnte+ox6VmVAJi4ZX
         TC+ORjhz1sa5z/K3U50sYEyq66ew/aEIUVZZL4wCANQMoZLII0eqOyS1Fr5jO41RQH7T
         7K3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=VFVXQWOzLW6GkqjRsebB6qEtF0A2Z0wSZZ5D/NTa1aA=;
        b=K6h0hgqP6gt9oPxmdqMZUROZSCOP0Eav6VBNut0gqt7gEohcgWsMz+paKLn+Dz9v4/
         pWuwPfm4m+5MMersH6vq+3nVrn675q+IJR3NYPwd26tmHGqeLRShFz9oRk80MsuLWC6V
         ZAgXj2CkEjZMWymRpY0IYq5EqdHAixuF/Ec9d7e+uUuFqzI8j+U4wOLh3mZB59D6qAio
         j4v6+DPvtHz75yA03uKqU33kA/t7pnqtn7dVVed4DSwIOjnzAA56WC7orcuSppMapv9O
         v1aQ1rxU8ei/Yk3lqGFM8k0EtKZ2mU44HY3YXo/e/SmtDJsnJJRCBe8yAMUO1JZvPtqP
         uZHw==
X-Gm-Message-State: AOAM533lEdHHikAKkhnT9o+XoXrsodvJY8JOSurcaZf4Qk9JG0L+vchX
        MoM6Nsy5R5slRH6AosAPalQ=
X-Google-Smtp-Source: ABdhPJxrTzuX2vSx071Hd/1DUxjO4eB8XBQaBWZNI2CMVvBSr0s3AGSF2r/ODOaz/RhDDj3KAnKJ+w==
X-Received: by 2002:aa7:c04e:: with SMTP id k14mr5839662edo.157.1624529486704;
        Thu, 24 Jun 2021 03:11:26 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id jz12sm951345ejc.94.2021.06.24.03.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 03:11:26 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, szeder.dev@gmail.com,
        dstolee@microsoft.com, gitster@pobox.com
Subject: t5324-split-commit-graph.sh flaky due to assumptions about ulimit
 behavior
Date:   Thu, 24 Jun 2021 11:51:09 +0200
References: <cover.1587677671.git.me@ttaylorr.com>
 <2b8ee726690861405f41adede5582b96749e98c5.1587677671.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <2b8ee726690861405f41adede5582b96749e98c5.1587677671.git.me@ttaylorr.com>
Message-ID: <87im231sj6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 23 2020, Taylor Blau wrote:

> When writing a layered commit-graph, the commit-graph machinery uses
> 'commit_graph_filenames_after' and 'commit_graph_hash_after' to keep
> track of the layers in the chain that we are in the process of writing.
>
> When the number of commit-graph layers shrinks, we initialize all
> entries in the aforementioned arrays, because we know the structure of
> the new commit-graph chain immediately (since there are no new layers,
> there are no unknown hash values).
>
> But when the number of commit-graph layers grows (i.e., that
> 'num_commit_graphs_after > num_commit_graphs_before'), then we leave
> some entries in the filenames and hashes arrays as uninitialized,
> because we will fill them in later as those values become available.
>
> For instance, we rely on 'write_commit_graph_file's to store the
> filename and hash of the last layer in the new chain, which is the one
> that it is responsible for writing. But, it's possible that
> 'write_commit_graph_file' may fail, e.g., from file descriptor
> exhaustion. In this case it is possible that 'git_mkstemp_mode' will
> fail, and that function will return early *before* setting the values
> for the last commit-graph layer's filename and hash.
>
> This causes a number of upleasant side-effects. For instance, trying to
> 'free()' each entry in 'ctx->commit_graph_filenames_after' (and
> similarly for the hashes array) causes us to 'free()' uninitialized
> memory, since the area is allocated with 'malloc()' and is therefore
> subject to contain garbage (which is left alone when
> 'write_commit_graph_file' returns early).
>
> This can manifest in other issues, like a general protection fault,
> and/or leaving a stray 'commit-graph-chain.lock' around after the
> process dies. (The reasoning for this is still a mystery to me, since
> we'd otherwise usually expect the kernel to run tempfile.c's 'atexit()'
> handlers in the case of a normal death...)
>
> To resolve this, initialize the memory with 'CALLOC_ARRAY' so that
> uninitialized entries are filled with zeros, and can thus be 'free()'d
> as a noop instead of causing a fault.
> [...]
> diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
> index e5d8d64170..0d1db31b0a 100755
> --- a/t/t5324-split-commit-graph.sh
> +++ b/t/t5324-split-commit-graph.sh
> @@ -381,4 +381,17 @@ test_expect_success '--split=replace replaces the chain' '
>  	graph_read_expect 2
>  '
>  
> +test_expect_success ULIMIT_FILE_DESCRIPTORS 'handles file descriptor exhaustion' '
> +	git init ulimit &&
> +	(
> +		cd ulimit &&
> +		for i in $(test_seq 64)
> +		do
> +			test_commit $i &&
> +			test_might_fail run_with_limited_open_files git commit-graph write \
> +				--split=no-merge --reachable || return 1
> +		done
> +	)
> +'
> +
>  test_done

This test started failing for me, and now I can't reproduce it anymore,
but I reproduced enough of it to think it was odd that it hadn't failed
before.

I.e. here we do an "ulimit -n 32" and then run a command, which makes a
lot of assumptions about how git is compiled, starts up etc, a lot of
which are outside of our control and up to the OS. It's not 32 files we
open, but 32 everything. When I could reproduce this it was failing on
opening some libpcre file or other, so maybe I linked to one too many
libraries.

The one other test that uses this pattern seems like it could be
similarly affected, but I haven't had that fail: d415ad022d8
(update-ref: test handling large transactions properly, 2015-04-14)

Since I can't reproduce this anymore maybe I'm reporting a
nothingburger. I just wonder if this can really work reliably in the
general case, and whether a reliably version of this pattern doesn't
need to be one/some of:

 1. Some GIT_TEST_* mode that sets the (unportable) ulimit itself in the
    code, after we reach some point. This is how e.g. web-based REPLs
    often work, load all your known libraries, forbid any file openings
    (or just N number) after that.

 2. Ditto, but have the GIT_TEST_* print to stderr if we reach some
    "checkpoint", have the test only run under limit N if we can reach
    that point (i.e. binary search or brute force to find the exact N
    limit).

 3. Maybe we can assume this would work reliably in cases of a really
    high limit of N, i.e. the d415ad022d8 test doesn't do this, but my
    understanding of it is that we're trying to guard against having all
    loose refs opened at once. So if we create e.g. 2k refs and operate
    on them we can set the limit to "1999".

    That's still assuming the same things about ulimit that make/made
    this test flaky, but we can probably safely assume that just getting
    to "git <something>" being invoked won't open >1k files, but maybe
    not >32.


