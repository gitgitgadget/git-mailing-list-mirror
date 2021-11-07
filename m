Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92A8C433F5
	for <git@archiver.kernel.org>; Sun,  7 Nov 2021 23:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABE9161390
	for <git@archiver.kernel.org>; Sun,  7 Nov 2021 23:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbhKGXu4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Nov 2021 18:50:56 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53]:36686 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbhKGXuz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Nov 2021 18:50:55 -0500
Received: by mail-ed1-f53.google.com with SMTP id o8so55366739edc.3
        for <git@vger.kernel.org>; Sun, 07 Nov 2021 15:48:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yM7H/+KPRewseW05p8f8fHRQ92+Q4ZXTUXOSeYiAaiY=;
        b=FdJwVVHxLMP+pZG2llsRKSb4kbOyUWK7kkDP809KnoNHn+qMkxfh4mvUufkY8qya63
         RuzbzLqJsIV8Ok1Og7yvRgp8PbHB5IXlvYDTsd91BquxvGljEfW87zzWlhTl08D0ksS+
         aHA8qeA7eq49WQAGcZZmkiu5MEKcWJbYn25XHgUprAU8PPp4qtAjQwSW6rYmw4kbQ/8I
         XfTwUSs2djxwTNg1hIpYm21KV3gtqK0GHtOJvsCF/mG9Psj/nxpBjKT6gHEsFo2JR8XN
         yvJuMmM5s7RZGvYmQfbpfvLt4p+xQFR3cFzD9qPOlyFyXXqRIvHN+IUfpIexJ4yCK6nX
         JtFQ==
X-Gm-Message-State: AOAM532uwsXL0b5+4yvEFito4FoKWaaUDrXaiWFe9roxjzHsdgMzNw/L
        CvX0Jc4oeyLVPXf1r1oS690b8pkYFeOb15kNsw4=
X-Google-Smtp-Source: ABdhPJxk04doJ8Q9+oup6ZvVmqHhmQaEszAmiBczuvzoDMLixNh9Xfu0qX7DUIpJMurYVRaZ5UXeHep3TAbQbm3uZsI=
X-Received: by 2002:a05:6402:206c:: with SMTP id bd12mr1475783edb.283.1636328891243;
 Sun, 07 Nov 2021 15:48:11 -0800 (PST)
MIME-Version: 1.0
References: <20211107225525.431138-1-sandals@crustytoothpaste.net> <20211107225525.431138-3-sandals@crustytoothpaste.net>
In-Reply-To: <20211107225525.431138-3-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 7 Nov 2021 18:48:00 -0500
Message-ID: <CAPig+cRkbjt=bJngcbzVPRGqY=14Zs57V0i=RR_5=m+k8fu+hg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] gitfaq: give advice on using eol attribute in gitattributes
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 7, 2021 at 5:55 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> In the FAQ, we tell people how to use the text attribute, but we fail to
> explain what to do with the eol attribute.  As we ourselves have
> noticed, most shell implementations do not care for carriage returns,
> and as such, people will practically always want them to use LF endings.
> Similar things can be said for batch files on Windows, except with CRLF
> endings.
>
> Since these are common things to have in a repository, let's help users
> make a good decision by recommending that they use the gitattributes
> file to correctly check out the endings.
> [...]
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
> @@ -469,14 +470,25 @@ references, URLs, and hashes stored in the repository.
> +With text files, Git will generally ensure that LF endings are used in the
> +repository, and will honor `core.autocrlf` and `core.eol` to decide what options
> +to use when checking files out.  You can also override this by specifying a
> +particular line ending such as `eol=lf` or `eol=crlf` if those files must always
> +have that ending in the working tree (e.g., for functionality reasons).
> ++
> +For example, the following might be appropriate in some projects:
>  +
>  ----
>  # By default, guess.
>  *      text=auto
>  # Mark all C files as text.
>  *.c    text
> +# Ensure all shell files end up with LF endings and all batch files end up
> +# with CRLF endings in the working tree and both end up with LF in the repo.
> +*.sh text eol=lf
> +*.bat text eol=crlf
>  # Mark all JPEG files as binary.
>  *.jpg  binary
>  ----

I like the concrete explanation in the commit message of why `.sh` and
`.bat` files need to be configured specially, and was expecting that
quite useful information to be repeated here in the body. That does
seem exactly like what someone would come to the FAQ searching for,
and even though the above content hints at it, the hint may be just
vague enough to be overlooked. Consequently, I'm wondering if it ought
to be spelled out more explicitly here. In particular, if we give
examples of actual error messages people might encounter when
attempting to run a CRLF shell script or an LF batch file, that would
really give a FAQ searcher/reader something to latch onto when trying
to solve a problem. This could be done as a lead-in paragraph
immediately before the "For example, the following...".

Also, following v1 review, I think you had intended[1]: s/end up with/have/

[1]: https://lore.kernel.org/git/YW9wgbN%2Fb8NkVp4z@camp.crustytoothpaste.net/
