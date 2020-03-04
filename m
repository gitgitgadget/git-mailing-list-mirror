Return-Path: <SRS0=VPsx=4V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16E7C3F2CD
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 15:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B4C621741
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 15:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZDiR9Jp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgCDPQm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Mar 2020 10:16:42 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:40065 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbgCDPQm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Mar 2020 10:16:42 -0500
Received: by mail-ed1-f54.google.com with SMTP id a13so2726478edu.7
        for <git@vger.kernel.org>; Wed, 04 Mar 2020 07:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iEba4ojd0gF+ZyiDs2br0JisgNoatyF6FiAXyAjdf6I=;
        b=lZDiR9JpVn2NkCQC+x5lnIC0TFaTQyS1Q0Gro5XBQEOhP0RTeGxQrHHx5TowuUuETf
         fkDrsmVSc0LU8gq2r0yJ1l+qhp4i1GP6d7j6pGzo7O17vO3RYAdn+Pw6jg018/lUKBXM
         /8ULtDuipfHcGf+fVxB/CCYU9O91yHwYGjEzJdaMBESaplBgBeC7brR0sx+NL+0NNkrp
         UTn0VGEgYGzKDBdOR9vclT9QDHXHdWl4N6WnNuGE/NW/+1XSqXyv7ZZ/R9lknuXBI9Vu
         EXIn6xhZO1L58qTWufkGYyMxAn05YMeaF7RCiqsiu44xvpnxodO5rg6oDkjuLg9zml3L
         zwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iEba4ojd0gF+ZyiDs2br0JisgNoatyF6FiAXyAjdf6I=;
        b=FjdosorKM77DQJ+IRry6v7bQ1TaHZxLc8KYq06lIstFwn6f926gij6zqe+c7thM9HQ
         hjh4ntRz7dJ0c3QY29Gnj6YbnX3nlKRUNmTnslFXr2AN8A8UB+Ktu2atz7rnt4NgoT4Q
         sBaP6wL5J1D0UAZZSAEhDhRrHzRVxrJmeZ1cVn9HOL8hwdyJKYzPHHgt52Ivj11NWOmF
         huN9qQTBR0BEw61saS9IgpE0hNK7ijAeLGBQKTT4kOsXSxzZ1/1VX7Jx9fQbfNvw38R+
         VWlXR5GbQcaKVOwrOoNKVbVNsWvxN7bzMi04lf0EJx2MR+zZRHccpzKHxZUJGSjgQEWP
         92yw==
X-Gm-Message-State: ANhLgQ0BWB40p4pzo2VfmPer0S2SNWj344xfkHL9XmyOmRlA7xlHCcTH
        nXHedsumQgRd5zvs+ikkaLkNygEP/tSXTlS71B4=
X-Google-Smtp-Source: ADFU+vvrcqQJ0+bI6zHoRaU3EAxODSI8ZnJRzcRS+sS3ZOh9lLJMtLfOHy1GH16F5rsoVgB5V7azDuChM9UnKjIoB1E=
X-Received: by 2002:a05:6402:caa:: with SMTP id cn10mr3205134edb.362.1583335000041;
 Wed, 04 Mar 2020 07:16:40 -0800 (PST)
MIME-Version: 1.0
References: <CA+CkUQ9Pnta8Ut9ZaeKLSPn_EyQwh=Wgm1eiSWirghgtcWZqoA@mail.gmail.com>
In-Reply-To: <CA+CkUQ9Pnta8Ut9ZaeKLSPn_EyQwh=Wgm1eiSWirghgtcWZqoA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 4 Mar 2020 16:16:17 +0100
Message-ID: <CAP8UFD2516a1inME4nUeo6f8K5TJGEJ3RXFg_Xk2+GqBv=ouRA@mail.gmail.com>
Subject: Re: [GSoC][RFC][PROPOSAL v1] Unify ref-filter formats with other
 --pretty formats
To:     Hariom verma <hariom18599@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Jeff King <peff@peff.net>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Thanks for your proposal!

On Wed, Feb 26, 2020 at 1:03 AM Hariom verma <hariom18599@gmail.com> wrote:
>
> Here is the initial version of my proposal. I would really love to
> have comments on it.
> Also, how should I manage the project timeline?

My advice would be to look at previous proposals on the mailing list.
We mostly want a project timeline that makes sense and show that you
have studied on a high level the work that you will have to do.

> Project title says some past GSoC and Outreachy Interns had worked on thi=
s.
> I would also like to be redirected there. So I can learn from there
> work as well.

Thanks Abhishek for your answer about this.

Yeah, please look at the work that was done, which includes what was
sent to the mailing list and maybe things that weren't sent.

> **Unify ref-filter formats with other --pretty formats**
>
> Name  :  Hariom Verma
> Major  :  Computer Science and Engineering
> Mobile no.  : <<mob_no>>
> Email  : <<email>>
> Time Zone  : IST (UTC +05:30)
>
> ## About me
> I am a Computer Science undergraduate at Shri G S Institute of
> Technology & Science, Indore, India. I am passionate about software
> freedom and open source communities. I've been writing in C, C++,
> Python & Dart for almost 3 years, and contributed to some projects
> which can be seen on Github.

Please add a link to your GitHub page here, so that we can quickly
take a look at what you contributed.

> I=E2=80=99m contributing to Git since Oct 2019 and would love to be a mem=
ber
> of such a versatile community.
>
> ### Contact:
> IRC: harry-hov (on #git-devel@freenode)
> GitHub: harry-hov
> Linkedin: https://www.linkedin.com/in/harry-hov/

Please move this contact information along with your name, email and
time zone above.

> ## Me & Git
> My contributions have helped me understand the review and patch
> submission process in a batter way. Also, I now feel a bit more
> comfortable with Git=E2=80=99s codebase.
>
> Commit
> Status
> -------------------
> receive.denyCurrentBranch: respect all worktrees[1]
> Status: next
>
> t5509: use a bare repository for test push target[2]
> Status: next
>
> get_main_worktree(): allow it to be called in the Git directory[3]
> Status: next
>
> git-compat-util.h: drop the `PRIuMAX` and other fallback definitions[4]
> Status: Merged to master
>
> builtin/blame.c: constants into bit shift format[5]
> Status: Merged to Master

I would prefer to have the links here rather than at the end of the
document. Also please add links to the commits on GitHub or GitLab.

> ## Proposed Project
>
> ### Abstract
> Git has an old problem of duplicated implementations of some logic.
> For example, Git had at least 4 different implementations to format
> command output for different commands. The foremost aim of this
> project is to simplify codebase by getting rid of duplication of a
> similar logic and, as a result, simplify adding new functionality.
> The current task is to reuse ref-filter formatting logic in pretty to
> minimize code duplication and to have one unified interface to extract
> all needed data from the object and to print it properly.
>
> ### Plan
> As Thomas Gummerer suggested[6] I=E2=80=99ll start by first looking at wh=
at
> actually needed to be replaced (for example by studying the PRETTY
> FORMATS section in 'man git-log', what which verbs you can use in the
> ref-filter ('man git-for-each-ref') to achieve the same thing.
> Then I=E2=80=99ll research how one format is implemented in 'pretty.c', a=
nd
> see how a similar thing using the ref-filter is implemented in
> 'ref-filter.c'.
> e.g. the "%(objectname:short) %(contents:subject)" (this is missing
> coloring, but just to get you the idea) is similar to
> '--pretty=3Doneline'.  Now one can try to find how 'oneline' is
> implemented in 'pretty.c', and could translate that to use the
> 'ref-filter' API.
>
> ### Potential Problem
> The biggest challenge is to maintain backward compatibility while
> using reuse ref-filter formatting logic in pretty. One can't just
> delete some commands, rewrite them and change their interface.
> Also, bugs could get introduced.

It would be nice if you could talk about what previous people
especially Olga did and what problems they faced.

> ## Availability
> My exams will end on 30 April. I might travel home after that. So, I
> can start actively writing code for this project after 3 May. My
> college resumes on 15 July. I can easily devote 45-50 hours a week
> until my college reopens and 35-40 hours per week after that. I'm also
> free on the weekends and I intend to complete most of the work before
> my college reopens. Other than this project, I have no commitments for
> this summer. I will also periodically post my status through blogs.
>
> ## Post GSoC
> As I said, I would love to be a member of Git=E2=80=99s community. So, I
> intend to keep contributing even after the GSoC period ends.

Great!

> ## Experience with Open Souce (Optional)
> -> Organized many Git workshops for newcomers with HackSocIndore[7].
> HackSocIndore is a group of developers that organizes Hackathons,
> Workshops & Technical Events. I=E2=80=99m the core team member at HackSoc=
.
> -> Mentor, Kharagpur Winter of Code (KWoC)[8]
> Kharagpur Winter of Code is a 5-week long online program for students
> who are new to Open Source Development.

Nice!

> [8]:https://kwoc.kossiitkgp.org

The above link is failing for me.

Thanks,
Christian.
