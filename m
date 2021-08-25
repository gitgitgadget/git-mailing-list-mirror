Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBB6C4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 15:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01D6161100
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 15:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240566AbhHYPJS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 11:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbhHYPJR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 11:09:17 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A13C061757
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 08:08:31 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id o185so13817769oih.13
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 08:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yf38d9Dt+lmI0YIy8C+eg42mnhSwDFa7MlD/ST4npAo=;
        b=tLwoZvUrvTVRYHa0q59BvQlUwcBF93STHTX0iIG8AN/eu9xwZuoEjChji3qpPPbv+N
         hNSDSb38bIMy6o6r9v+lVeZvq3PWKzbfN0eZKm1er/k58ARULXFv7j80AOBUMBnjsHkO
         6U0LqS945LUoIKfggLmenT2Pc1LIPcn5jhKx0vyOu6jDKm0e9IYPFVu3CgN9iRBLqwrn
         /sPOBoeYchgQ6jLtYY7xWMpJHcFOzolXmt7QaIeMIO37gt//EVxUwnjWd0jEQJv38CBc
         EpC4iAvkfVthhgBH+jf64dZW+Iq2spnMUMrgbwK6VTXkhXmlZKyEUeAdGbNhFpqOPSIq
         W71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yf38d9Dt+lmI0YIy8C+eg42mnhSwDFa7MlD/ST4npAo=;
        b=XhYxSRbnVRWEwkfX0Qcs78QQ0/Addb+4ugOsBhHAPD1lA4Vagb7VDbLc1QBMvh5LkV
         r5210T1ndukBnAkbtcnDruRmWtX5cqedoZ6X7qBpKfZbjR6uGeL5Irp6ujXwpgEi4xi5
         CPe2ANwESQDb0a3Zfl0UKYxLQnhzj5eMZEfaV8v5vQgMuaAHfbH6EkIXrsuW+21YWpfn
         zWsUh8RsD3LsjvD3QysQC2I546Tyo3r2wtju4a2xg968PbytHIuy71XXokYM8zMPxJ21
         K+l6dQbfAOuyVfwyTP9KAlUN2w/PRlbIWXY4Sy6+b8euJqjihYYNEGj88xaaBp/KrytS
         43Zg==
X-Gm-Message-State: AOAM531tF+6byHvCfhr70nPGA4uiECOwv1Sj9wdfnkviwyM5nwQ05lDO
        9bYAAl2ExQ74+8OUdxJukUO5J6Rz1szlSjcF03DOoxlMeR8=
X-Google-Smtp-Source: ABdhPJwz8qi/0QTphuTRsarHR5uYyTfGH0okmqYj4Ro0q2Z6JDNbU8S+N/+FXAorC8u4vz06nKb09/g7Dd8yjYQRrWU=
X-Received: by 2002:a05:6808:1787:: with SMTP id bg7mr7115370oib.39.1629904110632;
 Wed, 25 Aug 2021 08:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210818043749.85274-1-gwymor@tilde.club> <20210823205549.18566-1-gwymor@tilde.club>
In-Reply-To: <20210823205549.18566-1-gwymor@tilde.club>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 25 Aug 2021 08:08:19 -0700
Message-ID: <CABPp-BFrYzCeuq18nTgq_+Znb313_77bED+zyapadyOrKHGBSw@mail.gmail.com>
Subject: Re: [filter-repo PATCH v2] filter-repo: add new --replace-message option
To:     Gwyneth Morgan <gwymor@tilde.club>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 23, 2021 at 1:58 PM Gwyneth Morgan <gwymor@tilde.club> wrote:
>
> Like --replace-text, add an option --replace-message which replaces text
> in commit/tag message bodies, so that users can easily replace text
> without constructing a --message-callback.
>
> Signed-off-by: Gwyneth Morgan <gwymor@tilde.club>
> ---
>  Documentation/git-filter-repo.txt | 25 ++++++++++
>  git-filter-repo                   | 16 +++++++
>  t/t9390-filter-repo.sh            |  1 +
>  t/t9390/basic-message             | 78 +++++++++++++++++++++++++++++++
>  t/t9390/sample-message            |  4 ++
>  5 files changed, 124 insertions(+)
>  create mode 100644 t/t9390/basic-message
>  create mode 100644 t/t9390/sample-message
>
> diff --git a/Documentation/git-filter-repo.txt b/Documentation/git-filter-repo.txt
> index 2798378..1e590c7 100644
> --- a/Documentation/git-filter-repo.txt
> +++ b/Documentation/git-filter-repo.txt
> @@ -181,6 +181,11 @@ Renaming of refs (see also --refname-callback)
>  Filtering of commit messages (see also --message-callback)
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> +--replace-message <expressions_file>::
> +       A file with expressions that, if found in commit or tag
> +       messages, will be replaced. This file uses the same syntax as
> +       --replace-text.
> +
>  --preserve-commit-hashes::
>         By default, since commits are rewritten and thus gain new
>         hashes, references to old commit hashes in commit messages are
> @@ -896,6 +901,26 @@ YYYY-MM-DD.  In the expressions file, there are a few things to note:
>
>  See also the `--blob-callback` from <<CALLBACKS>>.
>
> +Updating commit/tag messages
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +If you want to modify commit or tag messages, you can do so with the
> +same syntax as `--replace-text`, explained above.  For example, with a
> +file named expressions.txt containing
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
> +will replace `foo` in commit or tag messages with `bar`.
> +
> +See also the `--message-callback` from <<CALLBACKS>>.
> +
>  Refname based filtering
>  ~~~~~~~~~~~~~~~~~~~~~~~
>
> diff --git a/git-filter-repo b/git-filter-repo
> index b91bd96..5e726c9 100755
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
> @@ -3374,6 +3380,11 @@ class RepoFilter(object):
>      if not self._args.preserve_commit_hashes:
>        commit.message = self._hash_re.sub(self._translate_commit_hash,
>                                           commit.message)
> +    if self._args.replace_message:
> +      for literal, replacement in self._args.replace_message['literals']:
> +        commit.message = commit.message.replace(literal, replacement)
> +      for regex,   replacement in self._args.replace_message['regexes']:
> +        commit.message = regex.sub(replacement, commit.message)
>      if self._message_callback:
>        commit.message = self._message_callback(commit.message)
>
> @@ -3474,6 +3485,11 @@ class RepoFilter(object):
>
>    def _tweak_tag(self, tag):
>      # Tweak the tag message according to callbacks
> +    if self._args.replace_message:
> +      for literal, replacement in self._args.replace_message['literals']:
> +        tag.message = tag.message.replace(literal, replacement)
> +      for regex,   replacement in self._args.replace_message['regexes']:
> +        tag.message = regex.sub(replacement, tag.message)
>      if self._message_callback:
>        tag.message = self._message_callback(tag.message)
>
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
> index 0000000..5b6b41b
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
> +data 15
> +version one :)
> +
> +done
> diff --git a/t/t9390/sample-message b/t/t9390/sample-message
> new file mode 100644
> index 0000000..0412c3c
> --- /dev/null
> +++ b/t/t9390/sample-message
> @@ -0,0 +1,4 @@
> +Initial==>Modified
> +regex:tw.nty==>the number 20
> +v1.0==>version one!
> +regex:!$==> :)
> --
> 2.33.0

Applied; thanks!
