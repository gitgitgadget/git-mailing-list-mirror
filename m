Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A6EC433B4
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 16:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 917B3610E6
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 16:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236487AbhDVQRv convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 22 Apr 2021 12:17:51 -0400
Received: from mail-ej1-f42.google.com ([209.85.218.42]:40808 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236333AbhDVQRv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Apr 2021 12:17:51 -0400
Received: by mail-ej1-f42.google.com with SMTP id n2so69619831ejy.7
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 09:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ABEK9TlBVB0/t4252DKqRNCzgvKDxV79/g6KB83BqEk=;
        b=JfakZ2f4Fo2nzy8I4cP8nlAfajyUSLoYFJ6NS7SYacnSQ+hUgom7AiYKR0DiLM90+a
         a3uwds+0HMaOqua4jn58ZHa/NIt2G3hm24IeA5BYgaICUmBLXBODYqe6OBFP2HNTiFY4
         rkKVMKK1laqYUQCVCyE5GLs/sA1V+0B+ET6cbEYVGBrCVjxKFNd8PbFCA1OegxomnDMJ
         8Hm1ooEIhr/miPhEHOHC9I8ELWWtKIYfvlsamICjGN2B+TJI7jXhvHDj+Ab5/oFSGdsb
         GY2zY15koP+zvKfL5S/v8xkDaosN69tGyqWgfAxiHn6ESBE8DKQTlb3b7bQvGXjCSOr8
         FgEQ==
X-Gm-Message-State: AOAM532UlqYTbdPZMuao7vLjz2drC9bG12KlSbIPlzp4TCm1k2ETOdr7
        Nd0Szm0Y2R+qRUaZ9FmDLeJlEzuqnTznX7Zd6/axzqM+ObPfPA==
X-Google-Smtp-Source: ABdhPJyCzF8sNCRI1u5O4k143E9hR+pqve+eFOjYEaaQTJeAofRapcFmUNap4ocrFTQnzOJ94QsOizPe3Lw8mm5xeY8=
X-Received: by 2002:a17:906:37d7:: with SMTP id o23mr4217320ejc.202.1619108235613;
 Thu, 22 Apr 2021 09:17:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAKu1iLWfaAaKH4Uui4wfa0STFEaXqqtc304b5V0ZNtmBg78J+w@mail.gmail.com>
 <20210422050504.441-1-tzadik.vanderhoof@gmail.com> <20210422155047.3unltvv3mh5uq7wp@tb-raspi4>
In-Reply-To: <20210422155047.3unltvv3mh5uq7wp@tb-raspi4>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 22 Apr 2021 12:17:04 -0400
Message-ID: <CAPig+cQE0oHHY89D6fLyymduY3=zSe8y246cz1P2MjTZhrMHNQ@mail.gmail.com>
Subject: Re: [PATCH v3] add git-p4.fallbackEncoding config setting, to prevent
 git-p4 from crashing on non UTF-8 changeset descriptions
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 22, 2021 at 11:51 AM Torsten Bögershausen <tboegi@web.de> wrote:
> On Wed, Apr 21, 2021 at 10:05:04PM -0700, Tzadik Vanderhoof wrote:
> > +if test_have_prereq !MINGW,!CYGWIN; then
> > +     skip_all='This system is not subject to encoding failures in "git p4 clone"'
> > +     test_done
> > +fi
>
> Out of curiosity: Why are Windows versions (MINGW, CYGWIN) excluded ?

The answer to this question is probably worthy of recording as an
in-code comment just above this conditional so that people coming upon
this test script in the future don't have to ask the same question
(which is especially important if the author is no longer reachable).
If an in-code comment is overkill, then it would probably be a good
idea for the commit message to explain the reason.

> > +test_expect_success 'clone succeeds with git-p4.fallbackEncoding set to "cp1252"' '
> > +     git config --global git-p4.fallbackEncoding cp1252 &&
> > +     test_when_finished cleanup_git &&
> > +     (
> > +             git p4 clone --dest="$git" //depot@all &&
> > +             cd "$git" &&
> > +             git log --oneline >log &&
> > +             desc=$(head -1 log | awk '\''{print $2}'\'') && [ "$desc" = "documentación" ]
>
> Style nit:
> See Documentation/CodingGuidelines: - We prefer "test" over "[ ... ]".
>
> desc=$(head -1 log | awk '\''{print $2}'\'') && test "$desc" = "documentación"

Style also suggests splitting the line after the &&.

We normally want to avoid using bare single-quotes inside the body of
the test since the body itself is a single-quoted string. These
single-quotes make it harder for a reader to reason about what is
going on; especially with the $2 in there, one has to spend extra
cycles wondering if $2 is correctly expanded when the test runs or
when it is first defined. So, an easier-to-understand rewrite might
be:

    desc=$(head -1 log | awk ''{print \$2}'') &&
    test "$desc" = "documentación"

Many existing tests in this project use `cut` for word-plucking, so an
alternative would be:

    desc=$(head -1 log | cut -d" " -f2) &&
