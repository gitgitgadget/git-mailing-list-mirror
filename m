Return-Path: <SRS0=caIn=3X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF64BC35247
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 20:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8AC20658
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 20:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBEeZaMN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgBCUkU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 15:40:20 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:33044 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbgBCUkU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 15:40:20 -0500
Received: by mail-ot1-f47.google.com with SMTP id b18so15020361otp.0
        for <git@vger.kernel.org>; Mon, 03 Feb 2020 12:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bfLS/7Ly/7NwbxXihM1ER/QWtbeYGRU/Z/1KLDsuU1s=;
        b=dBEeZaMNAjfVBzypvMsw1DMM5kZtl9byY5I5YoKsmf2SAHNo8wf9xWejnV+Nf0/1Ws
         HoJ5eg1uEvFoNnDsRC8M8NkxR1MzZimn0zhHHtCjxhVoQpOtCKnc9azW523hW4X1whdJ
         q5/K6TbusjRvnCRZhi9PYOWvAi47C36fVsxhJFrZ/oFcrr/k/WyzKw1pEwv7nzV8Mlqv
         N2kQDTbarpR8dKp0qxHono28jGKjDUFeb+5ZzL3SuReBdGPGGTVuoLShCYB0JXz8w/ds
         YKNjeqNxPjQlibA8HU3L0Um23FiCDyhrPt47l//s/kYQYZ9mqzmfFcx/3JD5ew2kl6qR
         wHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bfLS/7Ly/7NwbxXihM1ER/QWtbeYGRU/Z/1KLDsuU1s=;
        b=bQqrqwqx48+2UbYZI0xdkIjeV7GtCJr81/v/l//e18LBdEGS4QcmIwmmH6KFgHAAhG
         5fapS6eVBAR6YKH9bIP3JfGwOjE/s6MgT7rSLyRFFJaXuvUZxuGniYKdh+INZUO22b2a
         1lWuT8S4fgrFJenK98ljI4qsbU+tmzgP+1VrSwvzxEWVOTpzwC8+K9FjlvmECHg4flmJ
         OayGgZ4t+dUTmfuMWDhBEm1Web4XD11gSg5DxxvfaKH3arjB19C2vEP/XFuW24PB1RQD
         wDmD2pDHlPwFZXoKsvusJjymvayXvpWzmFLw/koz/dmlLGBdVzvzaERVckwKA2McTefu
         8KAw==
X-Gm-Message-State: APjAAAUJoQU/sqpuzWBFC3vnpLrJsb2FG63LiyLJ0DiEQHednGQywJZR
        SRgBPImui/zDzt8nHtYGQ/11GUjwLVrdwDhpHAM=
X-Google-Smtp-Source: APXvYqyQKwqFnrUTTh3+SLuo7Ls+/aooEuR/eoax1FTfRyk1Sd/5PXZizN/4Hn/y3Wx3vu/K1GeJby7YeNhDMSMR+u8=
X-Received: by 2002:a05:6830:c9:: with SMTP id x9mr19258335oto.345.1580762419146;
 Mon, 03 Feb 2020 12:40:19 -0800 (PST)
MIME-Version: 1.0
References: <20200203114549.GA4157558@coredump.intra.peff.net> <20200203203650.31914-1-martin.agren@gmail.com>
In-Reply-To: <20200203203650.31914-1-martin.agren@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 3 Feb 2020 12:40:08 -0800
Message-ID: <CABPp-BHQ_qSMa-VNMbXCvHxRuk04Tyth8HP8yTbktAXSGjFZJA@mail.gmail.com>
Subject: Re: git-filter-branch.txt: wrap "maths" notation in backticks
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 3, 2020 at 12:37 PM Martin =C3=85gren <martin.agren@gmail.com> =
wrote:
>
> On Mon, 3 Feb 2020 at 12:45, Jeff King <peff@peff.net> wrote:
> >
> > On Sun, Feb 02, 2020 at 08:33:19PM +0100, Martin =C3=85gren wrote:
> >
> > > In this paragraph, we have a few instances of the '^' character, whic=
h
> > > we give as "\^". This renders well with AsciiDoc ("^"), but Asciidoct=
or
> > > renders it literally as "\^". Dropping the backslashes renders fine
> > > with Asciidoctor, but not AsciiDoc... Let's use "{caret}" instead, to
> > > avoid these escaping problems.
> >
> > Makes sense.
> >
> > The source is pretty ugly to read both before and after, though. I
>
> Yeah, I was happy to have improved the situation a bit, but didn't quite
> feel that it looked great..
>
> > wonder if using a literal like `5*10^5` would be even nicer. That makes
> > the source pretty readable, and the output would put it in <tt> or
> > similar. Which maybe is a little funny, but kind of makes sense to me
> > typographically as a kind of "this is math" style.
>
> Hmm, that somehow makes sense. How about the below? Outside of RelNotes/
> and technical/, I only saw one spot where we could do something similar
> ("O(n^2)" in diff-options.txt; it has an accompanying loose "n"). I had
> actually expected more. Most hits for "{caret}" are in revisions.txt
> (duh) and the one hit for "\^" that remains after this patch is a shell
> snippet.
>
> Going for "1e5" and so on would be one way, I guess, but suffers from
> the same problem that it somehow looks like a random pile of characters
> in the middle of a sentence (unless it's typeset in, e.g., monospace).
>
> One could of course move in a different direction entirely and talk
> about "a thousand", "a million" and so on...
>
> --->8---
> Subject: [PATCH v2] git-filter-branch.txt: wrap "maths" notation in backt=
icks
>
> In this paragraph, we have a few instances of the '^' character, which
> we give as "\^". This renders well with AsciiDoc ("^"), but Asciidoctor
> renders it literally as "\^". Dropping the backslashes renders fine
> with Asciidoctor, but not AsciiDoc...
>
> An earlier version of this patch used "{caret}" instead of "^", which
> avoided these escaping problems. The rendering was still so-so, though
> -- these expressions end up set as normal text, similarly to when one
> provides, e.g., computer code in the middle of running text, without
> properly marking it with `backticks` to be monospaced.
>
> As noted by Jeff King, this suggests actually wrapping these
> expressions in backticks, setting them in monospace.
>
> The lone "5" could be left as is or wrapped as `5`. Spell it out as
> "five" instead -- this generally looks better anyway for small numbers
> in the middle of text like this.
>
> Suggested-by: Jeff King <peff@peff.net>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
>  Documentation/git-filter-branch.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filt=
er-branch.txt
> index a530fef7e5..40ba4aa3e6 100644
> --- a/Documentation/git-filter-branch.txt
> +++ b/Documentation/git-filter-branch.txt
> @@ -467,9 +467,9 @@ impossible for a backward-compatible implementation t=
o ever be fast:
>
>  * In editing files, git-filter-branch by design checks out each and
>    every commit as it existed in the original repo.  If your repo has
> -  10\^5 files and 10\^5 commits, but each commit only modifies 5
> -  files, then git-filter-branch will make you do 10\^10 modifications,
> -  despite only having (at most) 5*10^5 unique blobs.
> +  `10^5` files and `10^5` commits, but each commit only modifies five
> +  files, then git-filter-branch will make you do `10^10` modifications,
> +  despite only having (at most) `5*10^5` unique blobs.

Looks good to me.

>  * If you try and cheat and try to make git-filter-branch only work on
>    files modified in a commit, then two things happen

It's so tempting to remove "try and" to get rid of the duplicate "try"
at the same time...
