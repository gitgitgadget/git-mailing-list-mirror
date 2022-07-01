Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAADC433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 19:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiGATb4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 15:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiGATbz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 15:31:55 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A683218
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 12:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656703888;
        bh=2AY+QQR9eGcdH4YmueeWSsjI/w6P2dO2awrXwCN80HM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Vd439YtXnCfg/ose5UAMe1VXQBni2gH9gf1sU1mLaEEG6rbpiyM+E4Jx1dTXQEfjD
         whVJNVdDCR/MVItxwa/iOfQwO4FkPrVmxhTjfxP2Nhj+GDNYuXkYiQAV7eBItSNCrg
         dzJKxRjrLnNaVgAIGojeMprSD619HlocMmUS/b0g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.204.148] ([89.1.213.137]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0oBx-1nk4iD0unN-00wmIE; Fri, 01
 Jul 2022 21:31:28 +0200
Date:   Fri, 1 Jul 2022 21:31:26 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Han Xin <hanxin.hx@bytedance.com>,
        chiyutianyi@gmail.com, derrickstolee@github.com,
        git@vger.kernel.org, haiyangtand@gmail.com,
        jonathantanmy@google.com, me@ttaylorr.com, ps@pks.im
Subject: Re: [PATCH v3 2/2] commit-graph.c: no lazy fetch in
 lookup_commit_in_graph()
In-Reply-To: <xmqq5ykignwb.fsf@gitster.g>
Message-ID: <n3p471no-671q-2701-1r72-s0q02ns09053@tzk.qr>
References: <cover.1656044659.git.hanxin.hx@bytedance.com> <cover.1656381667.git.hanxin.hx@bytedance.com> <3cdb1abd43779844b8e8dc094e2fd2da1adc461a.1656381667.git.hanxin.hx@bytedance.com> <220628.865yklgr6g.gmgdl@evledraar.gmail.com> <xmqq35folmgf.fsf@gitster.g>
 <5n35o008-pso2-6440-424p-q387q9n4so41@tzk.qr> <220630.86v8siclh5.gmgdl@evledraar.gmail.com> <xmqq5ykignwb.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-193857070-1656703890=:10220"
X-Provags-ID: V03:K1:GSlpiuqOnjJ2YdxsmDe1Ec6+i2xJVrJYb4I9OTPbce4ZyZ5LTAG
 mGExNBB8Pgu/rGdVUZBDGxpRGH9U8bkZkvZ/6s1LhXKvfcsmhIHhhsQ23bv4o0eqDlGZZrV
 qAXW+1ipoQTAJVzY+BoERJsV8fQrUjH5Xrg+qBk/Fv6XxEyuvEVsNJbDfo2bCxJWPzJ1w8K
 O9rMmAKhc+J6UMvxJgAbg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+dvzkNwE4Eg=:9gYKBT8xLFmy9Dbz/L6b0p
 YLddZvTW9Sk8IWMka5ROJ1p1hW3Yfhc080bXdFBSDO+Ja/OoMYv9QG2eUbEKIIsJZPEfhFJW9
 SiosCO7g0kMYBJbHJdzugNo3mymoRN4/2ESohic93+gdXTorUmvCDaRNeMNuHZRqqot+iPUOp
 HR4bTmT96oiwuyMZ1XP6F0k17C7MxbRpqU5dn5hgfooJvzn/YaqLQJsUlPBmAZkzDAQ+jXHqa
 77t4ueWs1N0T3D5xUiAmcvHF9vscPe3hP01jX6xD4XbURxKGx3I0tx1D0EVEwrMHJusdchdq3
 WbNK+KFeenXTA6UNZl9rgUXTk/LDnGY7Ku/rkWqbs0v8TQJTbd4PWoUhYcrXJxi8ilqXSVmMn
 M6YRov/d/xP2Swow7144dZv0WnynuLcV6l2+w0bj+HXxMYHlSEMKw8goV7GIqq5smzIZCul2I
 971OmGXdXdM6NxRNIgMnf3IRbj32t7daDqIMstiWUmBMl/fbOSb/xleELYf9Bk7Cu8gtLELUk
 PDO0SPciabOLtlNhDf2diNe48ov4Q9aF3Sxe6WYOxIQTIH1M8uIhKxLWWJb6cKcNmxMtpwjd9
 pdyiIPpl6T02bwpbFOrBRvFj1RuLyHAIpXpF3cN0lQpynXf86pvKoxSa1FaL0Dz1KNxEngEaL
 cyRBFr1Bm7g9zNXHobSrk4oFobLxEVoND1giO3/IVvcFtoZoc/Ynt5Ju3fU1A7ljHStstpNxq
 t3EiwpUC5Yh6OE9CmtDh9b6sCT8ouAiwwP7l+2Tcb4j06lQDeV8sPKSx8H+L7lUf7sG1h9VAe
 bcGe9Y2itEmP6gn2lfAhlX0zZhL6Qga2QLkYZD1w3/lvSgX8XX4eUa/1pOYmrmPu59ISPY7Q6
 43sGhI/kAdBxqEWat1Jj5mlhVeuQcmKcurE6DtET2uuHmL+JsUntd28pN7xDVIyyVQBe7xpgp
 u1P5o7nA1IAimqpJFq99ZRsbWeXj/RItihkax3aU9GgTN4nnKblXDRwoM7eyv3THWbGneLnjp
 hdHL+20ImgApehLZfxTdOufSpC1NVkOveYt2KmBKhvdlx0asywiO3F/Wxc7CArdL53WbVt28N
 +Wp6YbnHJPjY2l9IcRb8iUFL9txY6k410A3PQ/EAXT1At8sLSgO9WGcqQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-193857070-1656703890=:10220
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Thu, 30 Jun 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
> > On Thu, Jun 30 2022, Johannes Schindelin wrote:
> >
> >> On Tue, 28 Jun 2022, Junio C Hamano wrote:
> >>
> >>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> >>>
> >>> >> +test_expect_success 'setup: prepare a repository with commit-gra=
ph contains the commit' '
> >>> >> +	git init with-commit-graph &&
> >>> >> +	echo "$(pwd)/with-commit/.git/objects" \
> >>> >> +		>with-commit-graph/.git/objects/info/alternates &&
> >>> >
> >>> > nit: you can use $PWD instead of $(pwd).
> >>>
> >>> We can, and it would not make any difference on non-Windows.
> >>>
> >>> But which one should we use to cater to Windows?  $(pwd) is a full
> >>> path in Windows notation "C:\Program Files\Git\..." while $PWD is
> >>> MSYS style "/C/Program Files/Git/..." or something like that, IIRC?
> >>
> >> Indeed, and since the `alternates` file is supposed to be read by
> >> `git.exe`, a non-MSYS program, the original was good, and the nit
> >> suggested the incorrect form.
> >
> > I looked at t5615-alternate-env.sh which does the equivalent of:
> >
> > 	GIT_ALTERNATE_OBJECT_DIRECTORIES=3D"$PWD/one.git/objects:$PWD/two.git=
/objects" \
> >         	git cat-file [...]
> >
> > We run that test on all our platforms, does the $PWD form work in the
> > environment variable, but not when we write it to the "alternates" fil=
e?
> > Or is there some other subtlety there that I'm missing?
>
> I am also curious to see a clear and concise explanation so that we
> do not have to repeat this discussion later.

Unfortunately, I do not see any way to explain this concisely: MSYS2 does
hard-to-explain things here, in the hopes to Do The Right Thing (most of
the time, anyways).

Whenever you call a non-MSYS program from an MSYS program (and remember,
an MSYS program is a program that uses the MSYS2 runtime that acts as a
POSIX emulation layer), "magic" things are done. In our context,
`bash.exe` is an MSYS program, and the non-MSYS program that is called is
`git.exe`.

So what are those "magic" things? The command-line arguments and the
environment variables are auto-converted: everything that looks like a
Unix-style path (or path list, like the `PATH` environment variable) is
converted to a Windows-style path or path list (on Windows, the colon
cannot be the separator in `PATH`, therefore the semicolon is used).

And this is where it gets _really_ tricky to explain what is going on:
what _does_ look like a Unix-style path? The exact rules are convoluted
and hard to explain, but they work _most of the time_. For example,
`/usr/bin:/hello` is converted to `C:\Program Files\Git\usr\bin;C:\Program
Files\Git\hello` or something like that. But `kernel.org:/home/gitster` is
not, because it looks more like an SSH path. Similarly, `C:/Program Files`
is interpreted as a Windows-style path, even if it could technically be a
Unix-style path list.

Now, if you call `git.exe -C /blabla <command>`, it works, because
`git.exe` is a non-MSYS program, therefore that `/blabla` is converted to
a Windows-style path before executing `git.exe`. However, when you write a
file via `echo /blabla >file`, that `echo` is either the Bash built-in, or
it is an MSYS program, and no argument conversion takes place. If you
_then_ ask `git.exe` to read and interpret the file as a path, it won't
know what to do with that Unix-style path.

You can substitute `$PWD` for `/blabla` in all of this, and it will hold
true just the same.

So what makes `pwd` special?

Well, `pwd.exe` itself is an MSYS program, so it would still report a path
that `git.exe` cannot understand. But in Git's test suite, we specifically
override `pwd` to be a shell function that calls `pwd.exe -W`, which does
output Windows-style paths.

The thing that makes that `GIT_*=3D$PWD git ...` call work is that the
environment is automagically converted because `git` is a non-MSYS
program. The thing that makes `echo $PWD >.git/objects/info/alternates`
not work is that `echo` _is_ an MSYS program (or Bash built-in, which is
the same thing here, for all practical purposes), so it writes the path
verbatim into that file, but then we expect `git.exe` to read this file
and interpret it as a list of paths.

Hopefully that clarifies the scenario a bit, even if it is far from a
concise explanation (I did edit this mail multiple times for clarity and
brevity, though, as I do with pretty much all of my mails).

Ciao,
Dscho

> We have
>
>  - When a test checks for an absolute path that a git command generated,
>    construct the expected value using $(pwd) rather than $PWD,
>    $TEST_DIRECTORY, or $TRASH_DIRECTORY. It makes a difference on
>    Windows, where the shell (MSYS bash) mangles absolute path names.
>    For details, see the commit message of 4114156ae9.
>
> in t/README, but even with the log mesasge of 4114156a (Tests on
> Windows: $(pwd) must return Windows-style paths, 2009-03-13) [*1*],
> I have no idea what makes the thing you found in t5615 work and your
> suggestion to use $PWD in the new one not work.
>
> GIT_ALTERNATE_OBJECT_DIRECTORIES is a PATH_SEP (not necessarily a
> colon) separated list, and I think the way t5615 uses it is broken
> on Windows where PATH_SEP is defined as semicolon without the $PWD
> vs $(pwd) issue.  Is the test checking the right thing?
>
>
> [Footnote]
>
> *1*
>
>     Tests on Windows: $(pwd) must return Windows-style paths
>
>     Many tests pass $(pwd) in some form to git and later test that the o=
utput
>     of git contains the correct value of $(pwd). For example, the test o=
f
>     'git remote show' sets up a remote that contains $(pwd) and then the
>     expected result must contain $(pwd).
>
>     Again, MSYS-bash's path mangling kicks in: Plain $(pwd) uses the MSY=
S style
>     absolute path /c/path/to/git. The test case would write this name in=
to
>     the 'expect' file. But when git is invoked, MSYS-bash converts this =
name to
>     the Windows style path c:/path/to/git, and git would produce this fo=
rm in
>     the result; the test would fail.
>
>     We fix this by passing -W to bash's pwd that produces the Windows-st=
yle
>     path.
>
>     There are a two cases that need an accompanying change:
>
>     - In t1504 the value of $(pwd) becomes part of a path list. In this =
case,
>       the lone 'c' in something like /foo:c:/path/to/git:/bar inhibits
>       MSYS-bashes path mangling; IOW in this case we want the /c/path/to=
/git
>       form to allow path mangling. We use $PWD instead of $(pwd), which =
always
>       has the latter form.
>
>     - In t6200, $(pwd) - the Windows style path - must be used to constr=
uct the
>       expected result because that is the path form that git sees. (The =
change
>       in the test itself is just for consistency: 'git fetch' always see=
s the
>       Windows-style path, with or without the change.)
>
>     Signed-off-by: Johannes Sixt <j6t@kdbg.org>
>
>

--8323328-193857070-1656703890=:10220--
