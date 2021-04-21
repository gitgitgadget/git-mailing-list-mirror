Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6DBC433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 18:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 924116143B
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 18:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245146AbhDUSN0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 14:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242286AbhDUSN0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 14:13:26 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5EAC06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 11:12:53 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id v19-20020a0568300913b029028423b78c2dso31109098ott.8
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 11:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z+dHOzvabBn2hgIBWiQ1orjDodkoaPTmwZauL3SCVys=;
        b=qylgOCqeDLrNW3r52a4PSNulkzaSYurX+S7kjyxV+Uui/pdjD1VzteSTP6LiozaQ4I
         0JG4i/x64A+bAXe2ocqpThHazir2G8PZKI3KlKz/DmQaRIrdeRmmg9sn4K/m2rbQjtb3
         wL14O9gUDGBpbfqgvLaS/2m2s03fTZ9VNHIBCQ67/edPlzBR3pk9JqHdsdN6Gjzw3dP6
         ZkvUtR0dqLybXbOFndcmbAhtYztSSWYVJh1JhgzGZhRzO7R7D7uFpiet1gROqGKmHGci
         hietRCovWqEuP67qXbBSAX9b5kmDQJljNIYuQsfxlFN47lnJgv+rmk+JeBhvp63W4BA+
         PTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z+dHOzvabBn2hgIBWiQ1orjDodkoaPTmwZauL3SCVys=;
        b=KIy4v2GxshzFHcwDh3nZB8sSW+AYpu9+JZkv/h9TR8l+vFsx4xyvx7aJak/8Ex46AJ
         5LU+TgpjHkgvLkaxs0//ZSjOW+S2JVbSSqxIS7H4I74Ttg896txEShwQYRpuEv37Yf2q
         OTdEOXWGAtqcz+UikAeoxBHMM/TC9y+r2UXj9LWJVFw45X//m/z6jWuJHTM1hkoXpRxp
         t+LI2sz+fGd73+DbShO62KM6dOddJZH1uB1O042mTYQ+FhjjXALz6akwWhWFxQnkw69p
         g7WPmHNFEuYd86ki5MXlrK5/4OuwujyPT45ECf88D6PSI0HvSUM1I854lnqlPQYteNri
         6h0A==
X-Gm-Message-State: AOAM530AIiYskZx5VGBLldN02fTFF8YQAVrqfWBYrLHNMs0ovHOvcUhN
        8zlrMRDGCuLdGj+EfYWw0n0rqVIuROAekxNttcI=
X-Google-Smtp-Source: ABdhPJxe4P5V8a3+pvzdufDVftUNcChnmLSH5Gb+ZVKJi9a1vOxt5LVlsOzQv4XYbfpezMqhypy8uCunuzq3wXYCM0s=
X-Received: by 2002:a05:6830:906:: with SMTP id v6mr24365051ott.345.1619028772299;
 Wed, 21 Apr 2021 11:12:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210419225441.3139048-1-lukeshu@lukeshu.com>
In-Reply-To: <20210419225441.3139048-1-lukeshu@lukeshu.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 21 Apr 2021 11:12:40 -0700
Message-ID: <CABPp-BEz-QykELpvofsrZzbQtQUE0fvijUcaJXhRFbCZpKJuYQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] fast-export, fast-import: implement signed-commits
To:     Luke Shumaker <lukeshu@lukeshu.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Luke Shumaker <lukeshu@datawire.io>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 19, 2021 at 3:54 PM Luke Shumaker <lukeshu@lukeshu.com> wrote:
>
> From: Luke Shumaker <lukeshu@datawire.io>
>
> fast-export has an existing --signed-tags= flag that controls how to
> handle tag signatures.  However, there is no equivalent for commit
> signatures; it just silently strips the signature out of the commit
> (analogously to --signed-tags=strip).
>
> So implement a --signed-commits= flag in fast-export, and implement
> the receiving side of it in fast-import.

I understand adding an option to fast-export, but shouldn't there also
be one for fast-import?  In particular, I can see users wanting any of
the following:

* I want these signatures exported and imported because I know I won't
tweak them and they'll still be valid.
* I want these signatures even though they'll be invalid.  Whatever,
I'll just deal with it.
* I want the signatures exported and imported *when they will remain
valid*.  Always exporting them makes sense, because fast-export
doesn't know about tweaks I'll be making to its output before feeding
it to fast-import.  But fast-import should have options to
strip-if-invalid/warn-if-invalid/error-if-invalid/import-without-warning
for these tags (though they don't have to use these exact names).

I know fast-import doesn't do anything of the sort for signed tags,
but fast-import also doesn't support signed tags as per this comment
in the documentation:

"""
Signing annotated tags during import from within fast-import is not
supported.  Trying to include your own PGP/GPG signature is not
recommended, as the frontend does not (easily) have access to the
complete set of bytes which normally goes into such a signature.
If signing is required, create lightweight tags from within fast-import with
`reset`, then create the annotated versions of those tags offline
with the standard 'git tag' process.
"""

it just happens to "work" since the signature is part of the
annotation and fast-import doesn't attempt to read or validate the
annotation in any way, treating it as free-from text.  I'd say users
relying on this are on somewhat shaky ground.

But here you're adding explicit fast-import directives to the language
for signatures of commits, so you clearly do need to care.  And I
suspect fast-import's default should be error-if-invalid rather than
import-without-warning.

> Luke Shumaker (3):
>   git-fast-import.txt: add missing LF in the BNF
>   fast-export: rename --signed-tags='warn' to 'warn-verbatim'
>   fast-export, fast-import: implement signed-commits
>
>  Documentation/git-fast-export.txt | 18 +++++--
>  Documentation/git-fast-import.txt |  9 +++-
>  builtin/fast-export.c             | 88 +++++++++++++++++++++++++------
>  builtin/fast-import.c             | 15 ++++++
>  t/t9350-fast-export.sh            | 82 ++++++++++++++++++++++++++++
>  5 files changed, 191 insertions(+), 21 deletions(-)
>
> --
> 2.31.1
>
> Happy hacking,
> ~ Luke Shumaker
