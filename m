Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580DCC38A2A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 17:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AF4920663
	for <git@archiver.kernel.org>; Thu,  7 May 2020 17:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kz+Ek4YR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgEGRd2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 13:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726308AbgEGRd1 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 13:33:27 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819B8C05BD43
        for <git@vger.kernel.org>; Thu,  7 May 2020 10:33:27 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id s11so3883908vsm.3
        for <git@vger.kernel.org>; Thu, 07 May 2020 10:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=larrPBJpA1MXcDzInmvhkA9D7robLDdQeCb8cVgYYpM=;
        b=kz+Ek4YRGexQBeglX+vIZgs0bJliQ83fOu7dHqSt7vDbIgDOTOX1wzLGU2WcfKnze+
         YnaXQPYD7wovAhUCs1TLZ/W6z+q+ndbNAJMmmFZ6sWTDOhBU7plwCiPLl83ji5sgDeTI
         MEpAng6LClmYv4KTYwI/DA/Bt9iNqqqB1Jd9R8hungqFEjQOFs7H4kVQHwYkSjYQncNh
         Sn/vT2TnE+G0Z/FoCCI6x9mk4yI34ad7mnVG7kLgQXRkDkhybFXYPWWniCMjMk9g+ZuS
         N8rYTIgIIZRpZhdcPhIzxsArZGWc726B6+dzZqYnJxBugUWng82ASWV32w/uy8DW8jtU
         p5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=larrPBJpA1MXcDzInmvhkA9D7robLDdQeCb8cVgYYpM=;
        b=fFKMY0sAGmJIYDh5MSqa/LOsyDTPkpiqUqLz68cfGNrXWbwNkcu+/PESEVWdfCSrXa
         kxlEWlbnCQBQ25Nns0wNw/yyQ/wg/33whnGLGYX4HCRAvOkxZtMbnGtPHnnqykCvakIg
         KZmKjqQvqDHKhCMWy309Fr10fbbwzxOzKba4DlInrrLfnlFFnf3WSe1xHVvWlU3zYhNF
         A6xzUOgiHQ+pIRMTeUrVvqO9YH8GuSR8eHTg7R1nRsvT6HeAXGGVPAmD8QCw96eqAUEh
         QKHvU2hLdRvAUKYT/c+h03P0JiwZDS84gcKpwvUCf+n3gkhc51f2anrqjKlJDbYqwNyf
         iOOA==
X-Gm-Message-State: AGi0PuahyPZ1FU2U3iMFbeyTG/6FHP27TRnBrqe05O/hzEgPvQjdDgxl
        gYOckU2jmlpChUekcQyZsl4MGxu2L+7uljuKF6KHbA==
X-Google-Smtp-Source: APiQypIzbjnE+1Xjo2onvy42sdOyyRfAc16XtdbhF2fucBJhQYMBk3ZOplTNyuDo905Q2s1J093gJJqG2fFlcVdH7nQ=
X-Received: by 2002:a67:334a:: with SMTP id z71mr13910634vsz.87.1588872806331;
 Thu, 07 May 2020 10:33:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200507055118.69971-1-carenas@gmail.com> <xmqqr1vv4wzo.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqr1vv4wzo.fsf@gitster.c.googlers.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 7 May 2020 10:33:15 -0700
Message-ID: <CAPUEspiPduAoxL4L-p97A-DR46EBp1HcpFMLgd4YfJbNv653xQ@mail.gmail.com>
Subject: Re: [PATCH] t/test_lib: avoid naked bash arrays in file_lineno
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, congdanhqx@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 7, 2020 at 7:53 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:
>
> > 662f9cf154 (tests: when run in Bash, annotate test failures with file
> > name/line number, 2020-04-11), introduces a way to report the location
> > (file:lineno) of a failed test case by traversing the bash callstack.
> >
> > The implementation requires bash and is therefore protected by a guard
> > but NetBSD sh will still have to parse the function and therefore will
> > result in:
> >
> >   ** t0000-basic.sh ***
> >   ./test-lib.sh: 681: Syntax error: Bad substitution
> >
> > Enclose the bash specific code inside an eval to avoid parsing errors
> > and while at it, simplify the logic so that instead of traversing the
> > callstack just pop the two topmost entries that are required.
> >
> > Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>
> Is the rewritten bash-snippet in the evaled text what Dscho
> suggested us to use, or is it totally yours?

It is all mine, but Dscho's detailed description of the implementation it
is replacing allowed me to validate its correctness (under the documented
use cases)

my hope was that Dscho's and Danh would quickly agree as it is simpler
and faster, as well as providing some more description of its operation in
the commit message for future reviewers.

> I know Dscho helped to
> shoot down some "simpler" reimplementations you came up with,
> pointing out how they were broken, but it is unclear how we ended up
> with this version.

I made the wrong assumptions while focusing on translating the code
to posix sh and ended up with a broken version.

Another reason why I did the "while at it" was to avoid someone else
having the same problem by simplifying it and making sure that uncommon
syntax (like ${1+$1..}, or the use of $LINENO which would never apply
to our code)
weren't needed.

> I wish you didn't do the "while at it" rewrite in the same patch.
> If it were only "put bash-only stuff in an evaled string", it would
> have been a lot more comfortable applying it and merging quickly
> down, as it would be clear that we won't be breaking bash codepath
> and we'd be helping other shells.  With the "while at it", you made
> it quite unclear.

fair enough, and considering that "fixing other shell" has higher priority
will send a v2 to do so.

will do any "simplification" on a follow up and try to monitor these issues
early

Carlo
