Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98581C433DF
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 21:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 783112068D
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 21:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgFHVmA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 17:42:00 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36919 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgFHVmA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 17:42:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id x13so19078016wrv.4
        for <git@vger.kernel.org>; Mon, 08 Jun 2020 14:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4o3yS8jBcELI8Zodd1KIgoUTogvShDcfJq6mlr3VE1o=;
        b=ZLx9SkaDnQliQwEIOwznReOE35CfZXuC3YmWOmC0BoL/e1JpfsD5GoTwQNpVd27ysb
         Dyu5i88nf+0pCtm+ac/4FPjU/5yfN9JYXWOmnfFppIsGnhstVWYyjH3jgQoOqazvdw4E
         M2BTlGUc38qQJfWGWm3XXRzT65Ntzhj+bVnpQezGgh7FtjrBL1uwC+s2fTcMVV/Erxq3
         EhRA1N5qt7tQ2Es2ExPGcZ7EWlayus56fBbC59txclkVihzH31zimnZYBWy66AJUHwfg
         s50zzgb8NCg5qzAZdlFYW3H+hC/dba3fedDABiR/RmxhrRnYWha0CuOAbgyB83s6wxGz
         i09w==
X-Gm-Message-State: AOAM5310Mu7sNLSTZi+dJ3rwjGASnIuOf7y9NhxzJPNGMEJ8ieBUN3RY
        MubIG3zSKpewiBfT7zVqXfn1SceRn0EOmrzsUKk=
X-Google-Smtp-Source: ABdhPJxphKanOE4QJAboCXA1xTOq3Sqm8Vv1MVPqV3YJuJ/BibtkAJMHk0uiPkU5zH/PwJEcSFxeS4HYRWyDRT89t8w=
X-Received: by 2002:adf:fd48:: with SMTP id h8mr894297wrs.226.1591652517977;
 Mon, 08 Jun 2020 14:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200608062356.40264-1-sunshine@sunshineco.com>
 <20200608062356.40264-2-sunshine@sunshineco.com> <20200608193834.GA4196@konoha>
In-Reply-To: <20200608193834.GA4196@konoha>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 8 Jun 2020 17:41:46 -0400
Message-ID: <CAPig+cTRsyPWGb1J+28dWESKqK84RQr-yhZEmTf1=mtkmO4Y0w@mail.gmail.com>
Subject: Re: [PATCH 1/8] worktree: factor out repeated string literal
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?Jonathan_M=C3=BCller?= <jonathanmueller.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 8, 2020 at 3:38 PM Shourya Shukla
<shouryashukla.oo@gmail.com> wrote:
> On 08/06 02:23, Eric Sunshine wrote:
> > Although this change seems to increase the "sentence lego quotient", it
> > should be reasonably safe, as the reason for removal is a distinct
> > clause, not strictly related to the prefix. Moreover, the "worktrees" in
> > "Removing worktrees/%s:" is a path literal which ought not be localized,
> > so by factoring it out, we can more easily avoid exposing that path
> > fragment to translators.
>
> Could you explain the above paragraph just a bit more? The English is
> confusing me a bit.

Which part is confusing you? The "sentence lego" bit or the bit about
not wanting translators touching a path literal? Or something else?

The path element bit is easy: A literal path, such as
".git/worktrees/foo" should not be translated to a user's local
language.

Sentence lego refers to the process of composing text from several
pieces. Doing so can make it difficult for a translator to localize it
to a particular language because the standalone pieces don't
necessarily provide sufficient context for a proper translation. For
instance, this example is from [1]:

    Translatable strings should be entire sentences. It is often not
    possible to translate single verbs or adjectives in a
    substitutable way.

    printf ("File %s is %s protected", filename, rw ? "write" : "read");

    Most translators will not look at the source and will thus only see
    the string "File %s is %s protected", which is
    unintelligible. Change this to

    printf (rw ? "File %s is write protected" :
             "File %s is read protected", filename);

    This way the translator will not only understand the message, she
    will also be able to find the appropriate grammatical
    construction. A French translator for example translates "write
    protected" like "protected against writing".

[1]: https://www.gnu.org/software/gettext/manual/html_node/Preparing-Strings.html
