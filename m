Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00B5C55185
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 10:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DE542071E
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 10:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qFL9A2Gg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgDYK5p (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 06:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726050AbgDYK5p (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Apr 2020 06:57:45 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47C1C09B04A
        for <git@vger.kernel.org>; Sat, 25 Apr 2020 03:57:43 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id k6so13254538iob.3
        for <git@vger.kernel.org>; Sat, 25 Apr 2020 03:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kGDY8qmNz2v+2Ai0nl5aNE1GThN4HRtnzznBhBip0Vk=;
        b=qFL9A2Gg6SDhp6hsxaFk1VgKEOjb2ylTNmOkvGG+74D7lrIqIV4N+Wli0ccD01bkWL
         XxR3b6RWLZNKs0rwbHKRrjfAo47wSk0H/cT9SU/ZhyhLo40IFX6qENKcYw/9DPnsYen0
         yLFKuOLMXblrdwhGuJFQ8EX8rxdKqaQOwqnJW2p44pm3VXwezfirBxYtdvst06HpfwCy
         QonLAG58DC9dJSIef116rOWiThcnSK2bMmimKSpdaIa/Bhw7MBHSQKo3mPkCochAlUxt
         xrqlhTRS8AdQXOoXzAIDfP3ibmrKINZ2H5qk4YE1GAK0E48W6AFgG97wkMX4+M/B2hKd
         eGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kGDY8qmNz2v+2Ai0nl5aNE1GThN4HRtnzznBhBip0Vk=;
        b=LLU7PsPJCilw6FnN0sJ+GiCjGwd2p4y1PGLghYAEt9Nu/vinSoSS4QM2zxsyrhH0M4
         ae1hRocBI8Y/fnb+u1Kq3v66eKJCtz7ZVHkMTgL6L0QoumBeFjxEmlcRg/LbHNouBdSd
         Ahma6rwySNYezwqPMyJfBahDf64xO5EreFF/MVbYu16tfdgzcTaGnEzkVfhCzRl1qxxh
         jTZIIxS/b9NCLiniEwl6EJFVVpsVz9bprkbh3VqXrV0elaAtdtGpbpbAr2tdmrs9pQy6
         TPf5Yu7CRgsz2e4bt+mFYgxQkt7ivINKQZTaVH6Wrq+8QVHN4u25jSx8JL8kPK/+Y9K2
         DIMQ==
X-Gm-Message-State: AGi0PubQd6VGzoDbd2ZVy5S+prDJsDXEce5vj5SJBmgyJ/XR7eU8S4wf
        TiNkFo16X3z78sANCfHNcvT96Vtk8iiflcjn/yW1sf8y
X-Google-Smtp-Source: APiQypLR/pdulpVqFWQVVYTb6GUyFEZudT1IjwYmS15nbpKAGVB1Le3CuO7UaKQpu2xcdA5JhPgIiwFCxA96/PemnO0=
X-Received: by 2002:a05:6638:155:: with SMTP id y21mr12601892jao.79.1587812262905;
 Sat, 25 Apr 2020 03:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200423070704.39872-1-mirucam@gmail.com> <xmqqa732gee8.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqa732gee8.fsf@gitster.c.googlers.com>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Sat, 25 Apr 2020 12:57:32 +0200
Message-ID: <CAN7CjDA04+9UOmzu-XtwPTnLRmwWakpVeGQuRMkuh4ruGAaZug@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] Finish converting git bisect to C part 2
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

El jue., 23 abr. 2020 a las 22:01, Junio C Hamano
(<gitster@pobox.com>) escribi=C3=B3:
>
> Miriam Rubio <mirucam@gmail.com> writes:
>
> > --- Changes since v2 Finish converting git bisect to C part 2 patch ser=
ies ---
> >
> > General changes
> > ---------------
> >
> > * Rebase on master branch: efe3874640 (Sync with v2.26.1, 2020-04-13)
>
> Was there a particular reason why you needed to do this rebase?  It
> seems that the patches apply cleanly on the same base as v2 has been
> queued?  Does the result cause hard-to-resolve conflicts when merged
> to the 'master', 'next' or 'pu' branches unless you do that rebase?
>
No particular reason. I use to do a rebase on master before applying
reviewers suggestions if I see there are new commits on master.

> > Specific changes
> > ----------------
> >
> > [1/12] bisect--helper: fix `cmd_*()` function switch default return
> >
> > * Use `BUG()` instead of `return error()` in default switch.
>
> This rings a bell.  range-diff looks good.
>
> > [2/12] bisect--helper: use '-res' in 'cmd_bisect__helper' return
> >
> > * New patch: use '-res' instead of 'abs(res)'.
>
> Alright.
>
> > [3/12] bisect--helper: introduce new `write_in_file()` function
> >
> > * Rename input parameter `filepath` to `path`.
> > * Change `error_errno()` to `error()` in mode checking.
> > * Change error message when file cannot be opened.
> > * Add `fclose()` before error return.
>
> OK.  I am not sure if the error behaviour when fclose() fails is
> ideal, but I do not think it is worth further polishing.
>
> > [4/12] bisect--helper: reimplement `bisect_autostart` shell function in=
 C
> >
> > * Reorder patch before `reimplement `bisect_next` and `bisect_auto_next=
`
> > shell functions in C` to use `bisect_autostart()` function in
> > `bisect_append_log_quoted()`.
>
> OK.
>
> Will take a look at individual patches later.
Great, thank you!
>
> Thanks.
