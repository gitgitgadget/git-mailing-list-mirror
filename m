Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDACC4320A
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 17:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C46C61374
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 17:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhHWRfE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 13:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbhHWRfC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 13:35:02 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D83C061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 10:34:20 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id m11-20020a056820034b00b0028bb60b551fso5636290ooe.5
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 10:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mOQWEs0C/yfiZqkAFyHArknJPlwF57NIQCY8o79QewI=;
        b=bMKOh6zdAumcnL193l+gZOKzqyXkcB2Pkd0/ecL4lRjXYEJ1pDup8QEVhkIv2hEw1J
         Er73n/IaWGYMmm7cDUqEQ5cqlh5sm6oZ793gCiK50GVzCvwax5KWCrg99PJ2e//8ZDTQ
         6Q7+oMe0hnD1YhFS/IC/eqX78547MwjEpvtpuSt7s0SADvIZPb9IrU3+tnfDAIdqM74x
         d1fFAlzZ+0ZuYXlxn8dfuq7IemwuLHy/jgWsmvPfHg4HfDJVDSJ5yQRp6G7lBRRWes70
         g0Y25DiCAzvYPAoHY69/YXCV41LYnbffkSFTjD2xL22yY9Z0GF7kk1TNr2T4GUkS7PQG
         94qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mOQWEs0C/yfiZqkAFyHArknJPlwF57NIQCY8o79QewI=;
        b=sVYhMr13FKD5GB/BjHTOL1YYpY2olGp2Cqmq1JmbFlwmmbDQjBOHyV5ExnwUuF4M8U
         oAqlvu77r8l6qSgcJEECqm60OkYX6VcoCuie4yTiDunyvkT9UXci+09Li0mfMoeRlW8H
         oKpg67Fnm6mYOO7kceWsHwAI+JZzHjPyUi4MgaGHOb83jph/nM1qnhwN500CXs9Yu1Q6
         9HISK52/fhp52pKmYBQf6EkWSe3UxhS3Tu0NMK6kyz7p2qgbXqhBn2W0LyprlBoO7L+b
         o7LjQpE8Ca+E9TvxZAoK3UQewS7746iyxyTiamo8G8HNzxz3L6GyFInFDPDlVHcE6TP9
         MU2A==
X-Gm-Message-State: AOAM533Nepx7ZiRYvV2WZWmSoGz+dYBG75eXmlzAQCkRxifZQPM70vRF
        szp/0nx0Mz3MI3VzUC02fUS7ve/+QeOP0do3HjVe9oVwKNZi9Q==
X-Google-Smtp-Source: ABdhPJzn+3zui0H/RXNM8DziC++tszd1xzhjmTbfiGOV+ESyXwr308fwqGUnNJQQbEtRSi8o+/j55kpkwjlwjIpf+P4=
X-Received: by 2002:a4a:b601:: with SMTP id z1mr26167467oon.7.1629740059420;
 Mon, 23 Aug 2021 10:34:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210818043749.85274-1-gwymor@tilde.club>
In-Reply-To: <20210818043749.85274-1-gwymor@tilde.club>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 23 Aug 2021 10:34:07 -0700
Message-ID: <CABPp-BF3EopyXGtKomnVjuavg2dX+79qLwkPjjyX+PO5JBSXtg@mail.gmail.com>
Subject: Re: [filter-repo PATCH] filter-repo: add new --replace-message option
To:     Gwyneth Morgan <gwymor@tilde.club>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Aug 17, 2021 at 9:38 PM Gwyneth Morgan <gwymor@tilde.club> wrote:
>
> Like --replace-text, add an option --replace-message which replaces text
> in commit message bodies, so that users can easily replace text without
> constructing a --message-callback.

Interesting idea.

Missing a Signed-off-by trailer.

> ---
>  Documentation/git-filter-repo.txt | 19 +++++++-
>  git-filter-repo                   | 12 ++++-
>  t/t9390-filter-repo.sh            |  1 +
>  t/t9390/basic-message             | 78 +++++++++++++++++++++++++++++++
>  t/t9390/sample-message            |  2 +
>  5 files changed, 110 insertions(+), 2 deletions(-)
>  create mode 100644 t/t9390/basic-message
>  create mode 100644 t/t9390/sample-message
>
> diff --git a/Documentation/git-filter-repo.txt b/Documentation/git-filter-repo.txt
> index 2798378..7a71375 100644
> --- a/Documentation/git-filter-repo.txt
> +++ b/Documentation/git-filter-repo.txt
> @@ -181,6 +181,10 @@ Renaming of refs (see also --refname-callback)
>  Filtering of commit messages (see also --message-callback)
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> +--replace-message <expressions_file>::
> +       A file with expressions that, if found in commit messages, will
> +       be replaced. This file uses the same syntax as --replace-text.
> +

Just commit messages?  What about tag messages?

>  --preserve-commit-hashes::
>         By default, since commits are rewritten and thus gain new
>         hashes, references to old commit hashes in commit messages are
> @@ -894,7 +898,20 @@ YYYY-MM-DD.  In the expressions file, there are a few things to note:
>      beginning and ends of lines rather than the beginning and end of file.
>      See https://docs.python.org/3/library/re.html for details.
>
> -See also the `--blob-callback` from <<CALLBACKS>>.
> +See also the `--blob-callback` from <<CALLBACKS>>.  Similarly, if you
> +want to modify commit messages, you can do so with the same syntax.  For
> +example, with a file named expressions.txt containing
> +
> +--------------------------------------------------
> +foo==>bar
> +--------------------------------------------------
> +
> +then running
> +--------------------------------------------------
> +git filter-repo --replace-message expressions.txt
> +--------------------------------------------------
> +
> +will replace `foo` in commit messages with `bar`.

You've added this text to the "Content based filtering" section of the
manual, which doesn't make sense.  It should go in a section about
updating commit/tag messages.

>  Refname based filtering
>  ~~~~~~~~~~~~~~~~~~~~~~~
> diff --git a/git-filter-repo b/git-filter-repo
> index b91bd96..5fe0f91 100755
> --- a/git-filter-repo
> +++ b/git-filter-repo
> @@ -1843,6 +1843,10 @@ EXAMPLES
>
>      messages = parser.add_argument_group(title=_("Filtering of commit messages "
>                                                 "(see also --message-callback)"))
> +    messages.add_argument('--replace-message', metavar='EXPRESSIONS_FILE',
> +        help=_("A file with expressions that, if found in commit messages, "
> +               "will be replaced. This file uses the same syntax as "
> +               "--replace-text."))
>      messages.add_argument('--preserve-commit-hashes', action='store_true',
>          help=_("By default, since commits are rewritten and thus gain new "
>                 "hashes, references to old commit hashes in commit messages "
> @@ -2189,6 +2193,8 @@ EXAMPLES
>        args.mailmap = MailmapInfo(args.mailmap)
>      if args.replace_text:
>        args.replace_text = FilteringOptions.get_replace_text(args.replace_text)
> +    if args.replace_message:
> +      args.replace_message = FilteringOptions.get_replace_text(args.replace_message)
>      if args.strip_blobs_with_ids:
>        with open(args.strip_blobs_with_ids, 'br') as f:
>          args.strip_blobs_with_ids = set(f.read().split())
> @@ -3374,9 +3380,13 @@ class RepoFilter(object):
>      if not self._args.preserve_commit_hashes:
>        commit.message = self._hash_re.sub(self._translate_commit_hash,
>                                           commit.message)
> +    if self._args.replace_message:
> +      for literal, replacement in self._args.replace_message['literals']:
> +        commit.message = commit.message.replace(literal, replacement)
> +      for regex,   replacement in self._args.replace_message['regexes']:
> +        commit.message = regex.sub(replacement, commit.message)

Makes sense.

>      if self._message_callback:
>        commit.message = self._message_callback(commit.message)
> -

Why this stray line removal?

>      # Change the author & committer according to mailmap rules
>      args = self._args
>      if args.mailmap:

As noted above, just as --message-callback affects both commit and tag
messages, shouldn't this option affect both (i.e. should there also be
a section in tweak_tag() similar to the one you added to
tweak_commit())?

> diff --git a/t/t9390-filter-repo.sh b/t/t9390-filter-repo.sh
> index 3f567e7..6d2d985 100755
> --- a/t/t9390-filter-repo.sh
> +++ b/t/t9390-filter-repo.sh
> @@ -39,6 +39,7 @@ filter_testcase basic basic-filename --invert-paths --path-glob 't*en*'
>  filter_testcase basic basic-numbers  --invert-paths --path-regex 'f.*e.*e'
>  filter_testcase basic basic-mailmap  --mailmap ../t9390/sample-mailmap
>  filter_testcase basic basic-replace  --replace-text ../t9390/sample-replace
> +filter_testcase basic basic-message  --replace-message ../t9390/sample-message
>  filter_testcase empty empty-keepme   --path keepme
>  filter_testcase empty more-empty-keepme --path keepme --prune-empty=always \
>                                                    --prune-degenerate=always
> diff --git a/t/t9390/basic-message b/t/t9390/basic-message
> new file mode 100644
> index 0000000..4ac1968
> --- /dev/null
> +++ b/t/t9390/basic-message
> @@ -0,0 +1,78 @@
> +feature done
> +blob
> +mark :1
> +data 8
> +initial
> +
> +reset refs/heads/B
> +commit refs/heads/B
> +mark :2
> +author Little O. Me <me@little.net> 1535228562 -0700
> +committer Little O. Me <me@little.net> 1535228562 -0700
> +data 9
> +Modified
> +M 100644 :1 filename
> +M 100644 :1 ten
> +M 100644 :1 twenty
> +
> +blob
> +mark :3
> +data 11
> +twenty-mod
> +
> +commit refs/heads/B
> +mark :4
> +author Little 'ol Me <me@laptop.(none)> 1535229544 -0700
> +committer Little 'ol Me <me@laptop.(none)> 1535229544 -0700
> +data 18
> +add the number 20
> +from :2
> +M 100644 :3 twenty
> +
> +blob
> +mark :5
> +data 8
> +ten-mod
> +
> +commit refs/heads/A
> +mark :6
> +author Little O. Me <me@machine52.little.net> 1535229523 -0700
> +committer Little O. Me <me@machine52.little.net> 1535229523 -0700
> +data 8
> +add ten
> +from :2
> +M 100644 :5 ten
> +
> +commit refs/heads/master
> +mark :7
> +author Lit.e Me <me@fire.com> 1535229559 -0700
> +committer Lit.e Me <me@fire.com> 1535229580 -0700
> +data 24
> +Merge branch 'A' into B
> +from :4
> +merge :6
> +M 100644 :5 ten
> +
> +blob
> +mark :8
> +data 6
> +final
> +
> +commit refs/heads/master
> +mark :9
> +author Little Me <me@bigcompany.com> 1535229601 -0700
> +committer Little Me <me@bigcompany.com> 1535229601 -0700
> +data 9
> +whatever
> +from :7
> +M 100644 :8 filename
> +M 100644 :8 ten
> +M 100644 :8 twenty
> +
> +tag v1.0
> +from :9
> +tagger Little John <second@merry.men> 1535229618 -0700
> +data 5
> +v1.0
> +
> +done
> diff --git a/t/t9390/sample-message b/t/t9390/sample-message
> new file mode 100644
> index 0000000..a374d61
> --- /dev/null
> +++ b/t/t9390/sample-message
> @@ -0,0 +1,2 @@
> +Initial==>Modified
> +regex:tw.nty==>the number 20
> --
> 2.32.0

Testcase looks good.

Thanks for sending this along; if you fix up the issues I pointed out,
I'd be happy to apply this to git-filter-repo.
