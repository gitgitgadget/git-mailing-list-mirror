Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8748AC433E6
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 01:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43DC764ED0
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 01:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbhCNBLK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Mar 2021 20:11:10 -0500
Received: from mail-ej1-f53.google.com ([209.85.218.53]:44818 "EHLO
        mail-ej1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbhCNBKr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Mar 2021 20:10:47 -0500
Received: by mail-ej1-f53.google.com with SMTP id ox4so44861532ejb.11
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 17:10:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xZb2baESz1dgWvkyUZOyscKlhLrVM93S9zVPdVbfKIk=;
        b=IIjf3b9TXQD/huDNu+NVm3IfFKl5qQho8BdiZbNc/xVBkx8pIxoAMXs51d1zE50QsN
         5xEsm8tiKxka/YCPeYAh0N5cFdxePs6IQQjVeAqtSr9Jw1mUCl9mLHr3nKg2Q+G7hBHy
         6ZIjUYTUVljchhdNsXVMdZuoyiLH5/tm7b7D016/AzI7gL2ZDMNJUxSiCT7L/tOMmzdO
         UZOcL8BvVC86vM39JpXKhAW4LjyGuXjbhhsa991f4NBnuSYkc6Lgr64YbIHBd6e57Qgz
         3jkvtQWiM7Oc3SVVOebQoX/SozrtMIf3bhEqWrmlPhp393aS7LIIqzh9pPjGXChLuZi4
         v96g==
X-Gm-Message-State: AOAM533NpaN6SEhgC9DVd6DIbDPNYSXzdLDmnC4/dpRrmXe4nk4TFWqp
        HifASTprFgqHF8Rcb/E461/FqwM+L/oZ0CIyceQ=
X-Google-Smtp-Source: ABdhPJxHkLEWDtUNo5sF4R37/cmx2huqQOcsIEi3leoqb7JSzXuXA4zfUNTwWd+RDaOzyw6MMcEUxIpFnsVWn/k4fbU=
X-Received: by 2002:a17:906:7c48:: with SMTP id g8mr16545211ejp.138.1615684246632;
 Sat, 13 Mar 2021 17:10:46 -0800 (PST)
MIME-Version: 1.0
References: <20210310194306.32565-1-charvi077@gmail.com> <20210313134012.20658-7-charvi077@gmail.com>
In-Reply-To: <20210313134012.20658-7-charvi077@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 13 Mar 2021 20:10:35 -0500
Message-ID: <CAPig+cRQe3EURfXYQ9QwxfiSjJom3gZoZ_Q07ON4B+YgHu6dCw@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] doc/git-commit: add documentation for
 fixup=[amend|reword] options
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 13, 2021 at 8:43 AM Charvi Mendiratta <charvi077@gmail.com> wrote:
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>

It may have been more accurate to retain the Helped-by: with my name
while adding the Signed-off-by: (which I offered in case you
incorporated my significant rewrites), rather than replacing the
Helped-by: altogether. Not worth a re-roll, though.

> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> @@ -86,11 +86,44 @@ OPTIONS
> +--fixup=[(amend|reword):]<commit>::
> +       Create a new commit which "fixes up" `<commit>` when applied with
> +       `git rebase --autosquash`. Plain `--fixup=<commit>` creates a
> +       "fixup!" commit which changes the content of `<commit>` but leaves
> +       its log message untouched. `--fixup=amend:<commit>` is similar but
> +       creates an "amend!" commit which also replaces the log message of
> +       `<commit>` with the log message of the "amend!" commit.
> +       `--fixup=reword:<commit>` creates an "amend!" commit which
> +       replaces the log message of `<commit>` with its own log message
> +       but makes no changes to the content of `<commit>`.
> ++
> +The commit created by plain `--fixup=<commit>` has a subject
> +composed of "fixup!" followed by the subject line from <commit>,
> +and is recognized specially by `git rebase --autosquash`. The `-m`
> +option may be used to supplement the log message of the created
> +commit, but the additional commentary will be thrown away once the
> +"fixup!" commit is squashed into `<commit>` by
> +`git rebase --autosquash`.
> ++
> +The commit created by `--fixup=amend:<commit>` is similar but its
> +subject is instead prefixed with "amend!". The log message of
> +<commit> is copied into the log message of the "amend!" commit and
> +opened in an editor so it can be refined. When `git rebase
> +--autosquash` squashes the "amend!" commit into `<commit>`, the
> +log message of `<commit>` is replaced by the refined log message
> +from the "amend!" commit. It is an error for the "amend!" commit's
> +log message to be empty unless `--allow-empty-message` is
> +specified.
> ++
> +`--fixup=reword:<commit>` is shorthand for `--fixup=amend:<commit>
> +--only`. It creates an "amend!" commit with only a log message
> +(ignoring any changes staged in the index). When squashed by `git
> +rebase --autosquash`, it replaces the log message of `<commit>`
> +without making any other changes.
> ++
> +Neither "fixup!" nor "amend!" commits change authorship of
> +`<commit>` when applied by `git rebase --autosquash`.
> +See linkgit:git-rebase[1] for details.

I see that you took my entire rewrite verbatim. That's fine. My bias
is probably showing, but I do now find this documentation patch easier
to understand.

Thanks.
