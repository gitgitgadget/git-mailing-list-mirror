Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96951C4332B
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 07:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6550720735
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 07:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ic7s6/vC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbgCXH5x (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 03:57:53 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35809 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbgCXH5x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 03:57:53 -0400
Received: by mail-ot1-f68.google.com with SMTP id k26so16210438otr.2
        for <git@vger.kernel.org>; Tue, 24 Mar 2020 00:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fi3XwH/pIKfAYADDO2zoWZFI9A3UZVluutZCiHcfMK0=;
        b=Ic7s6/vCza+5SMss7MQzg6kbYnUKPp74YYxSJiM/DG2uIhuJViQXEwJW50ba+m6XFu
         Q9Iwal2ZgQh4ocizuRfpduYG0Oa8qKDvP68QgPK4VPg2XOEMG5z3zLYhq+udpYIFr+9m
         LnfNyrSCf9NKafn5lhBiAIJfBQDor2Gz7WNv/8C7GHyiXwI/bnonpG2xeaEG8Xc5BRaQ
         stspUs3ncYFA5pzt3Kf8gOYpkwypyvmcFxh2Op+l8YRZwp5+pJmwaYLXSReqoSgNJuWk
         ItMJqoOdiPHEzsdhAvzqK3LU/BE+ALk5xDz/VKTeDVe4MTw5YULU1XQK5WQceggInRzk
         XsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fi3XwH/pIKfAYADDO2zoWZFI9A3UZVluutZCiHcfMK0=;
        b=XvroHiYwZpDRF8AKOIHr13oe4zvFcVL8rH6/Si0fhHp4YWv4pYjAsh3wnuWVeimP6y
         XE2pH1pgm8R/32bG0wl8nrgZ8pAN4JnCkjNejiNSm0mg7It526Jb9Iari0uB5A0RGr1/
         Qkmpd2oQiKBTerz6eCT3k6K3cTBh6l1VsC96LuzC66ixRBTBWV0eupBQbzalcPpyHpOJ
         kzKO3zKQT2Qr5CQV+WmTeE0KeXtVqQymn/Bblrxva9Y4wjZ6l8V3O9tHNttLOa2PuMsB
         PikGfbhvQM76Ung864WSyKmyU0w85dQ0SAjArdW0bwshNMzVwNc5PzxpZfakE5TOD/bU
         5tWQ==
X-Gm-Message-State: ANhLgQ2fv/dpWUbcgOm+Su/q1Fb8vIeUz8yHJn89JMSZ1FJmry40n+XJ
        sKTtWKSNhVOu5oTXmOzPKnx4qKkYnDKQ0nzwWHg=
X-Google-Smtp-Source: ADFU+vvPEt5sS8FEFdLr9UUc38NVAeowkOnI8hj477V1XK35D7d1jSy+QpjNFEcSZ0qQu6h9afn9eIR3JJRsf//t51s=
X-Received: by 2002:a9d:6457:: with SMTP id m23mr21407245otl.162.1585036672418;
 Tue, 24 Mar 2020 00:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585027716.git.matheus.bernardino@usp.br> <7ba5caf10de75a2e0909318b04c62f5827a3fa56.1585027716.git.matheus.bernardino@usp.br>
In-Reply-To: <7ba5caf10de75a2e0909318b04c62f5827a3fa56.1585027716.git.matheus.bernardino@usp.br>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 24 Mar 2020 00:57:41 -0700
Message-ID: <CABPp-BGzeL8O73bB82=+4RFvdAXTgofg6H_xgSEXG7Euj=47Bg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] doc: grep: unify info on configuration variables
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 23, 2020 at 11:11 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> Explanations about the configuration variables for git-grep are
> duplicated in "Documentation/git-grep.txt" and
> "Documentation/config/grep.txt". Let's unify the information in the
> second file and include it in the first.
>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>  Documentation/config/grep.txt |  7 +++++--
>  Documentation/git-grep.txt    | 35 +++++------------------------------
>  2 files changed, 10 insertions(+), 32 deletions(-)
>
> diff --git a/Documentation/config/grep.txt b/Documentation/config/grep.txt
> index 44abe45a7c..76689771aa 100644
> --- a/Documentation/config/grep.txt
> +++ b/Documentation/config/grep.txt
> @@ -16,8 +16,11 @@ grep.extendedRegexp::
>         other than 'default'.
>
>  grep.threads::
> -       Number of grep worker threads to use.
> -       See `grep.threads` in linkgit:git-grep[1] for more information.
> +       Number of grep worker threads to use. See `--threads` in
> +       linkgit:git-grep[1] for more information.
> +
> +grep.fullName::
> +       If set to true, enable `--full-name` option by default.
>
>  grep.fallbackToNoIndex::
>         If set to true, fall back to git grep --no-index if git grep
> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> index ddb6acc025..97e25d7b1b 100644
> --- a/Documentation/git-grep.txt
> +++ b/Documentation/git-grep.txt
> @@ -41,34 +41,7 @@ characters.  An empty string as search expression matches all lines.
>  CONFIGURATION
>  -------------
>
> -grep.lineNumber::
> -       If set to true, enable `-n` option by default.
> -
> -grep.column::
> -       If set to true, enable the `--column` option by default.
> -
> -grep.patternType::
> -       Set the default matching behavior. Using a value of 'basic', 'extended',
> -       'fixed', or 'perl' will enable the `--basic-regexp`, `--extended-regexp`,
> -       `--fixed-strings`, or `--perl-regexp` option accordingly, while the
> -       value 'default' will return to the default matching behavior.
> -
> -grep.extendedRegexp::
> -       If set to true, enable `--extended-regexp` option by default. This
> -       option is ignored when the `grep.patternType` option is set to a value
> -       other than 'default'.
> -
> -grep.threads::
> -       Number of grep worker threads to use. If unset (or set to 0), Git will
> -       use as many threads as the number of logical cores available.
> -
> -grep.fullName::
> -       If set to true, enable `--full-name` option by default.
> -
> -grep.fallbackToNoIndex::
> -       If set to true, fall back to git grep --no-index if git grep
> -       is executed outside of a git repository.  Defaults to false.
> -
> +include::config/grep.txt[]
>
>  OPTIONS
>  -------
> @@ -267,8 +240,10 @@ providing this option will cause it to die.
>         found.
>
>  --threads <num>::
> -       Number of grep worker threads to use.
> -       See `grep.threads` in 'CONFIGURATION' for more information.
> +       Number of grep worker threads to use. If not provided (or set to
> +       0), Git will use as many worker threads as the number of logical
> +       cores available. The default value can also be set with the
> +       `grep.threads` configuration (see linkgit:git-config[1]).

I'm possibly showing my ignorance here, but doesn't the
"include::config/grep.txt[]" you added above mean that the user
doesn't have to see an external manpage but can see the definition
earlier within this same manpage?

>
>  -f <file>::
>         Read patterns from <file>, one per line.
> --
> 2.25.1
>
