Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D91FC25B08
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 09:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbiHQJm7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 05:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiHQJm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 05:42:56 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C6D79A56
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 02:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660729369;
        bh=/otrSGcbaINV9YQGINIJOwdw6mGL8j8Efi8c3X7pkIM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=c/nxK3FBLnAKBLdOu+4YTy88m4qBUIG5wsfMj+zZSrSMO4JONcHhbFy3w2yNdoUMd
         0/SR3xEupgepDbvXnzs30JL3edhJPlOmsZHaWyPrg60i72GmsCZvI2Uhkwi5Z6rTo8
         AsyeINZ4/b1LZzKow92RMeEScWTPfL+atXZu3oXY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.183.122] ([89.1.214.151]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOREc-1nzYFL13YU-00Py8J; Wed, 17
 Aug 2022 11:42:49 +0200
Date:   Wed, 17 Aug 2022 11:42:48 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v8 08/14] merge-resolve: rewrite in C
In-Reply-To: <xmqqedxgt1zx.fsf@gitster.g>
Message-ID: <848p4p89-2219-7874-ss50-2o0rp4r02902@tzk.qr>
References: <20210317204939.17890-1-alban.gruin@gmail.com> <20220809185429.20098-1-alban.gruin@gmail.com> <20220809185429.20098-9-alban.gruin@gmail.com> <08ea1eec-58fb-cbfa-d405-0d4159c99515@gmail.com> <xmqqilmzkd7p.fsf@gitster.g> <qs23r0n8-9r24-6095-3n9n-9131s69974p1@tzk.qr>
 <xmqqedxgt1zx.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:60bvUsSy6YbY8t5xgUnb8ULo0pzY9upssjJy3TayXV/XX9E0jwN
 lzx1t2qaDKXmDCrBeyQHSA3RZpREzbop+8n7HW4eLAfDzdOKEv5+G6EIEbULjU7hJkptFMR
 12eUBfI/mHYWuvAM2ILDG5abgmEwfvjfZ7/xKe/tU6WitVkO0JNb4rjV7TX7fTJwEwrEbcY
 pZO1hgB6D7afcu6ssM7Bw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:E42wTRdzBwA=:KcrAD0O+JN25ziCkK3GfM8
 j3Wi8GQy0vZOxyKbjZMTI5012fBsvzB4YqORgsbqfofU4mnaObKUbFqUePGiXUPUVWar9tDaW
 u2MLHr3VSvW+cLrKSw0wFhZzKbHP+2XclxxkdPQi2qWWrKvmNo1xwlnUh6XRL7eYSQ20Of725
 vhewj1S8inHRDCvrkjKoOGbtlgwjZSlqyVc8Yn573cOfCog/8px8up8yxdWrHXeefLEijx8T2
 ujizz5vLeSMGqdf+hRu45BB6fonQ1dRzaKZGCZ3m70ugc+yQ99bSEMxbGLf42VAuI40r00QJj
 z7hObtSFJHjIo0cVDeJWAEa7k3blEQ7aDXa/+FsrcjqUsAH+8VWX0K3oYNshtwOxbqAz1SsFF
 pP7gC91N3X8hu9CrWLYf2Cm2nzKT/P+dQ/+9nxiNDjlk2O0D9/vYMthKy5tnDpOaoUQqx1ox6
 vD3+Xhakzu5GjPpICncS2TSBm/cpMAbY9ZORmgxubBB1D237WU7HZV+ncidhrwHZZT69hYB60
 GE+iKELMU17Y3C8IxyfxKu5IkG5EoI6QeILT3wtLK04PynWavPqH8HWLbG3HSIjwz2MFoOUmr
 glUgTla3I9Ydz8P5sH/yk+dSIguDTb8E4I7DG4KtsR4opdVxliB36c8iaOzDNL+hLp23/HN2e
 xnLpASihfP9nTmFs/0su0213EHCpC9VXhJIj9G5qcLFsXvjglSqOEyZ4hLO/o6qcNLTAzWEIo
 Ov3hmbwKiA6/xGDQNzgjCSt5KM+WL+iT0qhJCa404a4nG72M7n8AJ2KyYwpKQq2s5ULeJO2AF
 BMa2hSqeaId76vlLZBkZMPIvbAQ2fvsSUgc4gECAiWkE5r3y1UUygu+A3vl7Bz1HCrtCNXw9m
 rrSpIy4imX9zh3eVO2uleijUy+mYGOYLqVIildJkhpqn2QoBq6tHtUpsKEYzJB+pylJqNVomI
 BKJUHRCprk1zYZOGIeQg50Zp8J+hkDKGksatj6ewLMcb+PCgDdvsQrBsvt2cCYwluaGtwW6/1
 gtnGuUlkvIHdG1CK6hVa0Riw3dZuOBDiJorPG4hz5Zo7a7WIkyAY+DjbkE3fCWdctKRd/xAj9
 tPeBgTuZClZNYCFFS6+3Zi4iBxk+OH6i8/udOeY/I8I8E88oCgpBQf2Ug==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 16 Aug 2022, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > I'm all in favor of adding such a good example there, but there is no
> > reason to hold back `git merge-resolve` from being implemented in C.
>
> You did not address the primary point, i.e. why the particular
> change is a bad one.  Sure, you lost a scripted porcelain or two
> that are not used much, but in exchange for what?  That is _the_
> issue and you skirt around it.

In exchange for what I mentioned already in
https://lore.kernel.org/git/qs23r0n8-9r24-6095-3n9n-9131s69974p1@tzk.qr/,
i.e. in the part you deleted from the quoted mail:

	We reduce Git's reliance on POSIX shell scripting, we reduce the
	number of programming languages contributors need to be familiar
	with, we open up to code coverage/static analysis tools that
	handle C but not shell scripts, just to name a few.

To reiterate why reducing the reliance on POSIX shell scripting is a good
thing:

- we pay a steep price in the form of performance issues (you will recall
  that merely rewriting the `rebase -i` engine in C and nothing else
  improved the overall run time of p3404 5x on Windows, 4x on macOS and
  still 3.5x on Linux, see
  https://lore.kernel.org/git/cover.1483370556.git.johannes.schindelin@gmx=
.de/)

  Yes, Linux sees such an incredible performance boost. Surprising, right?

- on Windows, even aside from the performance problems (which I deem
  reason enough on their own to aim for Git being implemented purely in
  C), users run into issues where anti-malware simply blocks shell
  scripts, sometimes even quarantines entire parts of Git for Windows.

- have you ever attempted to debug a Git invocation that involves spawning
  a shell script that in turn spawns the failing Git command, using `gdb`?
  I have. It ain't pretty. And you know that there are easier ways to
  abuse and deter new contributors than to ask them to do the same. In
  particular when large amounts of data have to be passed between those
  processes, typically via `stdio`.

- show me the equivalent of CodeQL/Coverity for POSIX shell scripting? ;-)

- portability issues dictate that we're not just using your grand father's
  POSIX shell scripting, but that we limit it to a subset that is opaque
  to developers unfamiliar with Git project.

- as a consequence, our shell scripts are highly opinionated, often using
  unintuitive idioms such as `&&` chains instead of `set -e`, which makes
  them unsuitable as examples how to script Git for regular users.

- a decreasing number of software developers is familiar with the
  intricacies of that language, leaving us with tech debt.

In short, there is not a single shred of doubt in my mind that avoiding
shell scripted parts in Git is a really good goal to have for this
project.

> The series makes us lose all strategies that are actively tested
> that are spawned as a subprocess, which is the way all third-party
> strategies will be used.

Then have that even-simpler-than `git-merge-resolve.sh` example be tested
as part of the test suite. That's what the test suite is for.

> After this, we have less test coverage of the codepaths we care about,
> which is *not* a scripted "resolve" strategy, but the code that runs
> third-party strategies as externals.

It is better to leave the responsibility of test coverage to the test
suite, avoiding to ship the corresponding support code to users.

tl;dr your concerns are easy to address, without having to incur the price
of keeping parts of Git implemented in shell.

Ciao,
Dscho
