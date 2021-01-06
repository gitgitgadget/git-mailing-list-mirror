Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A65BC433DB
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 09:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E40852310C
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 09:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbhAFJ6x (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 04:58:53 -0500
Received: from mail-ej1-f52.google.com ([209.85.218.52]:46792 "EHLO
        mail-ej1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbhAFJ6w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 04:58:52 -0500
Received: by mail-ej1-f52.google.com with SMTP id t16so4148937ejf.13
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 01:58:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ek51VsHdgX7If/RqZLZSM6vameev2G/RHLe6Pp06NzE=;
        b=M8fsBP1jv5HWg9Q3ZpCfvm3RIbnmnn8Djl6NIi9ufP5UzCVqexFYPhUEvMwwS3ev8P
         qdN8HUAncpvOyUkKRcg9zNPGsnwnReBWNhCOpQ/tRFagVW++SWRJdwQLxqCxjIQ5LlF/
         YKoq/uQkqA/rznGwSUwiMKjC4uSqX8cPN5wGXi/0hMi5zTZra/jcLkGQO3z5zohI4pSR
         RjdrJaBlOb57CTE9lvwmilqTfs3H77GjkkDZsbM7QP6EnG8qIlnbx67rtpQm4eku9ABC
         CaHT2P/qBJRsGq/RBK9u4ap6xCxXw7RT+Wp7cXXbTlJRcT4shiiAmYfMrxkZs+Jlsrik
         NOoQ==
X-Gm-Message-State: AOAM532GU+dnylpYY3AmpEeG3LTBi0XzsAoGi9MWXVmfC1J4e+IgIf2A
        zjcpY2Yny1bzMn3/Jk+0iClQmebZ9B+n0k7afxo=
X-Google-Smtp-Source: ABdhPJzQOYb5m8hwiS+DdfkqJTyizX2wNjHGtL4EVPWU9pZq30W1k85faW/oSMV7vrr4DQgMpgDT/wnTOdQeK5g3JO4=
X-Received: by 2002:a17:906:4348:: with SMTP id z8mr2310021ejm.371.1609927090309;
 Wed, 06 Jan 2021 01:58:10 -0800 (PST)
MIME-Version: 1.0
References: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com> <20210104162128.95281-8-rafaeloliveira.cs@gmail.com>
In-Reply-To: <20210104162128.95281-8-rafaeloliveira.cs@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 6 Jan 2021 04:57:59 -0500
Message-ID: <CAPig+cRtd9V_ko1gNmueKWbJvna80mMgdvj6_06afK8JzypAOg@mail.gmail.com>
Subject: Re: [PATCH 7/7] worktree: document `list` verbose and prunable annotations
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 4, 2021 at 11:22 AM Rafael Silva
<rafaeloliveira.cs@gmail.com> wrote:
> Update the documentation with "git worktree list" verbose mode, prunable
> and locked annotations for the default and porcelain format as part of
> teaching the command to show prunable working trees and verbose mode.
>
> Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
> ---
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> @@ -226,9 +227,12 @@ This can also be set up as the default behaviour by using the
>  -v::
>  --verbose::
>         With `prune`, report all removals.
> +       With `list`, output additional information for working trees.

This leaves the reader wondering what additional information is output
for `list`. Perhaps a small tweak will help:

    With `list`, output additional information about worktrees (see below).

>  --expire <time>::
>         With `prune`, only expire unused working trees older than `<time>`.
> +       With `list`, annotate unused working trees older than `<time>` as prunable
> +       candidates that will be remove by `prune` command if the same option is used.

Perhaps just minimal:

    With `list`, annotate missing worktrees as prunable if they
    are older than `<time>`.

> @@ -367,13 +371,48 @@ $ git worktree list
> +The command also shows annotations for each working tree, according to its state.
> +These annotations are:
> +
> + * "locked", if any working tree is locked
> + * "prunable", if any working tree can be pruned via "git worktree prune".

s/any/the/g

We might want to use backticks around these annotations rather than
double quotes, and we certainly do want to use backticks around the
`git worktree prune` command to ensure it is styled consistently with
other commands in this document.

> +Note that, the annotation is only moved to the next line only if the
> +additional text is available, otherwise the text is kept on the same.

Drop the comma between "that, the". Also, too many "only"s in this
sentence. You can actually drop both of them and the sentence will
still read fine:

   Note that the annotation is moved to the next line if the
   additional information is available, otherwise it stays on
   the same line as the worktree itself.

or something.

>  Porcelain Format
>  ~~~~~~~~~~~~~~~~
>  The porcelain format has a line per attribute.  Attributes are listed with a
>  label and value separated by a single space.  Boolean attributes (like `bare`
>  and `detached`) are listed as a label only, and are present only
>  if the value is true.  The first attribute of a working tree is always
> -`worktree`, an empty line indicates the end of the record.  For example:
> +`worktree`, an empty line indicates the end of the record.
> ++
> +In case any of the working trees are locked or is a candidate for pruning
> +(See DESCRIPTION above) the labels "locked" and "prunable" is also shown
> +followed by a reason, if available, otherwise only the labels are listed.
> +For example:

s/(See/(see/
s/is also/are also/

Let's also use backticks rather than double quotes around `locked` and
`prunable` to ensure consistent formatting with the other porcelain
labels `bare` and `detached` which are already in backticks.

Also, the unnecessary `+` line (seen as `++` in the diff) makes this
render incorrectly. It renders as:

    +In case any...

To fix it, just leave the line blank between paragraphs.

(If possible, install `asciidoc` and `xmlto` and then run `make html`
to render the documentation yourself, and open
Documentation/git-worktree.html in your browser to check the output.)
