Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478F2C433E0
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 03:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BE7D224B8
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 03:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731895AbhARD4j (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jan 2021 22:56:39 -0500
Received: from mail-ej1-f42.google.com ([209.85.218.42]:46480 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731870AbhARD4h (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jan 2021 22:56:37 -0500
Received: by mail-ej1-f42.google.com with SMTP id rv9so2933145ejb.13
        for <git@vger.kernel.org>; Sun, 17 Jan 2021 19:56:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/GAWGcEl/tNNA0CZI7MFCfuB1B5rrSDMszOmqklgsZU=;
        b=brUawz2zGazcB3jMbPU+a7FfZmmoCRSRFDbLTUyP/z8QkLEoa1DDPcvBpuEOI3UoD7
         duMexqmsFiOF9kxazsU0S1TeLNd1cdx/8HEPyelhKbIYfPR1KDpdu04LRu1Onbsxlupy
         HfoOfafsIwHBIo6E4onWfZ1z9fe6qAhaGnLBsN7nObRumXCN/aHivVk0zco5v/lZcG9Z
         +ELmcI3sEW1iUvXO3nvjoI1KVjN8V7rD9PcAkshpI5T+YNFGNgowxvO+mjR+ucwUrxIb
         hNW2iDdpzKpU9+OlL9UAtEDMe/qUITOmUpQHZVpsZD00J8tUmpH/hh6htq8gccHb1TSs
         DMAQ==
X-Gm-Message-State: AOAM533GUAU9acbKSCrDen+P8B5WNtRsJGgC2MME1PWaBxC6cbPtY5YK
        1vuwIhj/BIWQMcKccni4ZiyJyky6vqeDCdnrRExWhhCkv3zM7A==
X-Google-Smtp-Source: ABdhPJyAfrVp8F5+hTrVR8VtQsj69uMCmK8to8RbiRICfoCcm80wEUbdTe/nkO51rc9H8DXbMRw2O08Y4qd7/8PFOyg=
X-Received: by 2002:a17:906:4348:: with SMTP id z8mr16326768ejm.371.1610942153561;
 Sun, 17 Jan 2021 19:55:53 -0800 (PST)
MIME-Version: 1.0
References: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
 <20210117234244.95106-1-rafaeloliveira.cs@gmail.com> <20210117234244.95106-5-rafaeloliveira.cs@gmail.com>
In-Reply-To: <20210117234244.95106-5-rafaeloliveira.cs@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 17 Jan 2021 22:55:42 -0500
Message-ID: <CAPig+cSHpP8-QxmQhNuBd3sgn7D6ZfBnK7+1Yw50aakD2UqGFg@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] worktree: teach `list --porcelain` to annotate
 locked worktree
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 17, 2021 at 6:43 PM Rafael Silva
<rafaeloliveira.cs@gmail.com> wrote:
> Commit c57b3367be (worktree: teach `list` to annotate locked worktree,
> 2020-10-11) taught "git worktree list" to annotate locked worktrees by
> appending "locked" text to its output, however, this is not listed in
> the --porcelain format.
>
> Teach "list --porcelain" to do the same and add a "locked" attribute
> followed by its reason, thus making both default and porcelain format
> consistent. If the locked reason is not available then only "locked"
> is shown.
>
> The output of the "git worktree list --porcelain" becomes like so:
>
>     $ git worktree list --porcelain
>     ...
>     worktree /path/to/locked
>     HEAD 123abcdea123abcd123acbd123acbda123abcd12
>     detached
>     locked
>
>     worktree /path/to/locked-with-reason
>     HEAD abc123abc123abc123abc123abc123abc123abc1
>     detached
>     locked reason why it is locked
>     ...

All good.

> The locked reason is quoted to prevent newline characters (i.e: LF or
> CRLF) breaking the --porcelain format as each attribute is shown per
> line. For example:
>
>    $ git worktree list --porcelain
>    ...
>    locked worktree's path mounted in\nremovable device
>    ...

I have a bit to say about this below.

> Additionally, c57b3367be (worktree: teach `list` to annotate locked
> worktree, 2020-10-11) introduced a new test to ensure locked worktrees
> are listed with "locked" annotation. However, the test does not clean up
> after itself as "git worktree prune" is not going to remove the locked
> worktree in the first place. This not only leaves the test in an unclean
> state it also potentially breaks following tests that relies on the
> "git worktree list" output. Let's fix that by unlocking the worktree
> before the "prune" command.

The actual code change to fix this bug is about as minimal as it gets,
but the explanation you've written here is lengthy enough and nicely
self-contained that it suggests splitting it off to its own patch. And
since you can re-use this paragraph almost verbatim as the commit
message, it shouldn't require much work to do so. On the other hand,
it is itself not necessarily worth a re-roll, but if you do re-roll,
perhaps it's worth considering.

> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> @@ -377,8 +377,10 @@ Porcelain Format
>  The porcelain format has a line per attribute.  Attributes are listed with a
>  label and value separated by a single space.  Boolean attributes (like `bare`
>  and `detached`) are listed as a label only, and are present only
> -if the value is true.  The first attribute of a working tree is always
> -`worktree`, an empty line indicates the end of the record.  For example:
> +if the value is true.  Some attributes (like `locked`) can be listed as a label
> +only or with a value depending whether a reason is available.  The first

Perhaps:
s/depending whether/depending upon whether/

> +attribute of a working tree is always `worktree`, an empty line indicates the
> +end of the record.  For example:
> @@ -393,6 +395,16 @@ worktree /path/to/other-linked-worktree
> +worktree /path/to/linked-worktree-locked
> +HEAD 5678abc5678abc5678abc5678abc5678abc5678c
> +branch refs/heads/locked
> +locked
> +
> +worktree /path/to/linked-worktree-locked-with-reason
> +HEAD 3456def3456def3456def3456def3456def3456b
> +branch refs/heads/locked-with-reason
> +locked reason why is locked

I was momentarily confused by the branch named `locked` with the
`locked` attribute in the first new stanza. Perhaps take a hint from
the second new stanza and call the first one `locked-no-reason`:

    worktree /path/to/linked-worktree-locked-no-reason
    HEAD 5678abc5678abc5678abc5678abc5678abc5678c
    branch refs/heads/locked-no-reason
    locked

Again, though, not worth a re-roll.

> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -579,6 +582,16 @@ static void show_worktree_porcelain(struct worktree *wt)
> +       reason = worktree_lock_reason(wt);
> +       if (reason && *reason) {
> +               struct strbuf sb = STRBUF_INIT;
> +               quote_c_style(reason, &sb, NULL, CQUOTE_NODQ);
> +               printf("locked %s\n", sb.buf);
> +               strbuf_release(&sb);
> +       } else if (reason)
> +               printf("locked\n");

This needs a change, and it's totally my fault that it does. In my
previous review, I mentioned that if the lock reason contains special
characters, we want those special characters escaped and the reason
quoted, but _only_ if it contains special characters. However, I then
incorrectly said to call quote_c_style() with CQUOTE_NODQ to achieve
that behavior. In fact, CQUOTE_NODQ gives us the wrong behavior since
it avoids quoting the string which, as Phillip pointed out, makes it
impossible to distinguish between a string which just happens to
contain the two-character sequence '\' and 'n', and an escaped newline
"\n". So, the above should really be:

    quote_c_style(reason, &sb, NULL, 0);

The example in the commit message should be adjusted to account for
this change, as well:

    In porcelain mode, if the lock reason contains special characters
    such as newlines, they are escaped with backslashes and the entire
    reason is enclosed in double quotes. For example:

    $ git worktree list --porcelain
    ...
    locked "worktree's path mounted in\nremovable device"
    ...

And, of course, the new test will need a slight adjustment.

> diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
> @@ -66,11 +66,43 @@ test_expect_success '"list" all worktrees with locked annotation' '
> +test_expect_success '"list" all worktrees --porcelain with locked' '
> +       test_when_finished "rm -rf locked1 locked2 unlocked out actual expect && git worktree prune" &&
> +       echo "locked" >expect &&
> +       echo "locked with reason" >>expect &&
> +       git worktree add --detach locked1 &&
> +       git worktree add --detach locked2 &&
> +       git worktree add --detach unlocked &&
> +       git worktree lock locked1 &&
> +       git worktree lock locked2 --reason "with reason" &&
> +       test_when_finished "git worktree unlock locked1 && git worktree unlock locked2" &&
> +       git worktree list --porcelain >out &&
> +       grep "^locked" out >actual &&
> +       test_cmp expect actual
> +'

So, the purpose of the `unlocked` worktree in this test is to prove
that it didn't accidentally get annotated with `locked`? (Since, if it
did get annotated, then `actual` would contain too many lines and not
match `expect`.) Is that correct?

> +test_expect_success '"list" all worktrees --porcelain with locked reason newline escaped' '
> +       test_when_finished "rm -rf locked_lf locked_crlf out actual expect && git worktree prune" &&
> +       printf "locked locked\\\\r\\\\nreason\n" >expect &&
> +       printf "locked locked\\\\nreason\n" >>expect &&
> +       git worktree add --detach locked_lf &&
> +       git worktree add --detach locked_crlf &&
> +       printf "locked\nreason\n\n" >reason_lf &&
> +       printf "locked\r\nreason\n\n" >reason_crlf &&

The trailing "\n\n" is unneeded. Due to the way `$(...)` expansion
works (dropping trailing whitespace), you'll get the same successful
test result with:

    printf "locked\nreason\n" >reason_lf &&
    printf "locked\r\nreason\n" >reason_crlf &&

and even with:

    printf "locked\nreason" >reason_lf &&
    printf "locked\r\nreason" >reason_crlf &&

> +       git worktree lock locked_lf --reason "$(cat reason_lf)" &&
> +       git worktree lock locked_crlf --reason "$(cat reason_crlf)" &&

You could also just embed the `printf`'s here rather than using these
temporary files.

    git worktree lock --reason $(printf "...") <path> &&

Or, if we care only about testing LF, and not about CRLF, even this would work:

    git worktree lock --reason "reason with
    newline" <path> &&

but that gets a bit ugly.

Anyhow, all the line terminator commentary about this test is a matter
of personal taste, probably not worth a re-roll or even changing.
