Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C4CC433EF
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 01:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EC2561053
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 01:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237225AbhKIBkK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 20:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238968AbhKIBkH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 20:40:07 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DDFC0432DF
        for <git@vger.kernel.org>; Mon,  8 Nov 2021 17:11:18 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id c8so53108105ede.13
        for <git@vger.kernel.org>; Mon, 08 Nov 2021 17:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=J5kIutB+RB5Hko//Hhbd9DAuYziv+X3v9PVPorS9I84=;
        b=hEllc6t3nw+xLoC8FfrCkQE3mxxFGo2clLAsnxOMD2+97V85LejzSYUtO+cO4Fnowo
         Ojp4yCVXiEq12A5b89qNn/Qt6z8CSh18JTyvaMKF7h95OOo2GTHMN898cYT4k8aAtNYt
         Z++NYtk9DBihvIC91iAsLmXufNu7QP/lYikmFxBByGoF6befs8shM6SA93g247pjQtez
         dbw+/1IZQN/Hb4GtLrtTJw92daB/kUMdM6dVQKwMGJzbmaHQ/OVkCnYklVWQ8qJqMpY5
         QiOKZrs/5/IPjV5ubstYwpcN5DmVax9dBFNQfLieJJ0/wjGYQ1p7/otKzVISTCAY6+KW
         U7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=J5kIutB+RB5Hko//Hhbd9DAuYziv+X3v9PVPorS9I84=;
        b=3iyiLGxoo60239sC0d+B65EdQZ5v4OWxf38RlleWsNiOnV6MRugWK3VLtpYn9xDw5B
         j09+jXf2eN9+BEdD+rqEHFW0qlpOctzR8sveCQ3j7rpc3B9XGFUfGtzuyHJM7J2vxDi2
         SyqbDgTenign0XKnCkCzueUavYmkb7IVm56sTvmsu5WTJL79Idb8iPA0TJUmC0g/kG10
         jE44Y4EvfjcsmExYh3/XbAzBs+p2NAcyF3RdoNFl4UKPkoZtFBb8KKp4zO+czImQW28o
         pkuqqiVToq9uEbbKtgtKBkwVoe91ILUmdcsdUnH0gg0wYKwDKkuqBX3rhTPwBNsUM0JQ
         1UnA==
X-Gm-Message-State: AOAM531ro7yDZQEWVPwnS8xM0WOVMQidngpQUqDildJ/7pRGUbfeJZlI
        43+cRIyR8CjTkFwo0coPHSq/iY7kpPw=
X-Google-Smtp-Source: ABdhPJyXXS/LrKwLD/nZoNe0eDvl+Q8RpFVUSA+w8uAkHuXvfUW+sXyDyA+NYtgpcwrBAuHFMHs+Zw==
X-Received: by 2002:a17:906:a10c:: with SMTP id t12mr4358120ejy.429.1636420276846;
        Mon, 08 Nov 2021 17:11:16 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id c11sm2978855ede.8.2021.11.08.17.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 17:11:16 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mkFfP-001IAp-US;
        Tue, 09 Nov 2021 02:11:15 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v5 4/4] submodule: record superproject gitdir during
 'update'
Date:   Tue, 09 Nov 2021 01:42:03 +0100
References: <20211104234942.3473650-1-emilyshaffer@google.com>
 <20211104234942.3473650-5-emilyshaffer@google.com>
 <xmqqzgqjxl4e.fsf@gitster.g> <211105.861r3vhtot.gmgdl@evledraar.gmail.com>
 <YYmw8vEyFnQpe58z@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <YYmw8vEyFnQpe58z@google.com>
Message-ID: <211109.86v912dtfw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 08 2021, Emily Shaffer wrote:

> On Fri, Nov 05, 2021 at 09:43:56AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>=20
>>=20
>> On Thu, Nov 04 2021, Junio C Hamano wrote:
>>=20
>> > Emily Shaffer <emilyshaffer@google.com> writes:
>> >
>> >> A recorded hint path to the superproject's gitdir might be added duri=
ng
>> >> 'git submodule add', but in some cases - like submodules which were
>> >> created before 'git submodule add' learned to record that info - it m=
ight
>> >> be useful to update the hint. Let's do it during 'git submodule
>> >> update', when we already have a handle to the superproject while call=
ing
>> >> operations on the submodules.
>> >
>> > We are hearing repeated mention of "cache" and "hint".  Do we ever
>> > invalidate it, or if we have such a record, do we blindly trust it
>> > and use it without verifying if it is still fresh?
>> >
>> > Also, this step and the previous step both say we record gitdir on
>> > their title, but we instead record common dir.  Whichever is the
>> > right choice to record, let's be consistent.
>>=20
>> I had similar (AFAICT still unaddressed) feedback on the v2[1]. I'd lost
>> track of this series, and see one reason is that the In-Reply-Chain was
>> broken between v3..v4.
>>=20
>> I.e. it seems to me that this whole thing started as a way to avoid
>> shellscript overhead by calling git-rev-parse from git-submodule.sh, but
>> now that the relevant bits are moved to C we could just call some
>> slightly adjusted code in setup.c.
>
> No, that is not the case. It is the case that `git -C .. rev-parse
> --git-dir` is *very* expensive in the case where `../` is not, in fact,
> a gitdir; when I attempted another series which relied on finding the
> parent superproject's gitdir in this way, our testsuite took something
> like 5x longer to run than before. In other words, the expensive part is
> not the shelling out overhead - the expensive part is searching up the
> entire filesystem directory structure in the worst-case ("we are not a
> submodule") scenario. This is still needed, even with 'git-submodule.sh'
> moving to C.

Do you have that test code somewhere? I tried to reproduce this &
can't. I run my tests in /home/avar/*, and just created this:

    $ find /tmp/some/ -name '.git' -type d
    /tmp/some/dir/.git
    /tmp/some/dir/a/b/c/d/e/f/g/i/j/k/.git

I.e. a deeply nested structure in /tmp, if you ask for the git-dir in
/tmp/some/**/k you'll need to search several levels up.

Then with the patch below we'll instrument almost all git commands to
optionally do that search, i.e. anything that does setup_git_directory()
at all:

    $ GIT_TEST_SETUP=3Dtrue GIT_TEST_SETUP_PRINT=3Dtrue ~/g/git/git rev-par=
se HEAD
    warning: from '/tmp/some/dir/a/b/c/d/e/f/g/i/j' found '/tmp/some/dir' (=
'/tmp/some/dir/.git')
    <some hash here>

And as a quick test to run a few tests I tried:

    rm -rf test-results/; GIT_TEST_SETUP=3Dtrue GIT_TEST_SETUP_PRINT=3Dtrue=
 prove -j8 t741*submod*.sh :: -V

Which runs quickly enough for a tight test loop, and does that work >600 ti=
mes:
=20=20=20=20
    $ cat test-results/*.out|grep -c warning.*from.*found
    662

I can't get that to show me any meaningful difference, just to pick on
one test (since it was easier to run repeatedly):
=20=20=20=20
    $ hyperfine -L v true,false "GIT_TEST_SETUP=3D{v} ./t7416-submodule-das=
h-url.sh --root=3D/dev/shm/git"
    Benchmark #1: GIT_TEST_SETUP=3Dtrue ./t7416-submodule-dash-url.sh --roo=
t=3D/dev/shm/git
      Time (mean =C2=B1 =CF=83):     527.5 ms =C2=B1   7.2 ms    [User: 431=
.6 ms, System: 125.9 ms]
      Range (min =E2=80=A6 max):   522.6 ms =E2=80=A6 542.5 ms    10 runs
=20=20=20=20=20
    Benchmark #2: GIT_TEST_SETUP=3Dfalse ./t7416-submodule-dash-url.sh --ro=
ot=3D/dev/shm/git
      Time (mean =C2=B1 =CF=83):     526.7 ms =C2=B1  10.8 ms    [User: 421=
.1 ms, System: 131.6 ms]
      Range (min =E2=80=A6 max):   518.2 ms =E2=80=A6 546.8 ms    10 runs
=20=20=20=20=20
    Summary
      'GIT_TEST_SETUP=3Dfalse ./t7416-submodule-dash-url.sh --root=3D/dev/s=
hm/git' ran
        1.00 =C2=B1 0.02 times faster than 'GIT_TEST_SETUP=3Dtrue ./t7416-s=
ubmodule-dash-url.sh --root=3D/dev/shm/git'

I.e. it's all fuzzy and within the error margins.

Now if we do e.g.:

    GIT_TEST_SETUP=3Dfalse strace -f -c -U calls,name,time -S calls ./t7416=
-submodule-dash-url.sh 2>&1 >/dev/null | grep -A9000 calls >a
    GIT_TEST_SETUP=3Dtrue strace -f -c -U calls,name,time -S calls ./t7416-=
submodule-dash-url.sh 2>&1 >/dev/null | grep -A9000 calls >b

We'll see the syscall difference, in summary:

    -   110086 total            100.00
    +   114765 total            100.00

And some of the real big differences are:
=20=20=20=20
    $ diff -u <(head -n 12 a) <(head -n 12 b)
    --- /dev/fd/63  2021-11-09 01:57:16.023991556 +0100
    +++ /dev/fd/62  2021-11-09 01:57:16.019991593 +0100
    @@ -1,12 +1,12 @@
         calls syscall          % time
     --------- ---------------- ------
    -    11504 openat             2.15
    -    11496 close              2.07
    -    10672 read               4.15
    -    10465 rt_sigaction       0.32
    -     9913 lstat              1.50
    -     9456 mmap               0.67
    -     7545 stat               0.81
    -     6349 fstat              0.62
    -     3896 access             0.61
    -     3490 mprotect           0.26
    +    11783 lstat              1.80
    +    11600 close              1.89
    +    11599 openat             2.19
    +    10887 read               4.36
    +    10465 rt_sigaction       0.33
    +     9742 stat               1.07
    +     9455 mmap               0.75
    +     6346 fstat              0.57
    +     4113 access             0.65
    +     3490 mprotect           0.28

But syscalls are fast, so it doesn't show up in real results.

Now, of course a real implementation could be less stupid, e.g. even if
we think we need *a cache* if these are the performance numbers why do
we need to risk the cache being incorrect v.s. say just writing "I am a
submodule" somewhere in the config (if we don't have that).

Then we'll only do that work for submodules, so not all git invocations
will pay the cost (and it this point we'll usually have read config
anyway).

But I really just don't think it's that expensive at all. I can see how
it would be for actually shelling out, but we don't need to do that.

This could also just be that I'm running this on a really fast FS, which
is true. So I went and tested on an AIX machine I have access to.

I/O on AIX is slow, *really slow*, so slow that if you "rm -rfv"
something you'll have time to read individual lines scrolling by.

That ~500ms t7416-submodule-dash-url.sh test runs in around 50s on that
AIX box (power-aix.osuosl.org), most of which is I/O overhead, I created
the same /tmp/ directory structure and tried with
GIT_TEST_SETUP=3D[false|true] and it's ~55s with/without the env variable,
with no clear winner.

I don't have access to hyperfine on that box, or the patience to wait
for AIX I/O to wait for meaningful results, but to a first approximation
that seems to indicate that it doesn't really matter there either.

diff --git a/setup.c b/setup.c
index 347d7181ae9..8453d397676 100644
--- a/setup.c
+++ b/setup.c
@@ -1209,6 +1209,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
        struct strbuf dir =3D STRBUF_INIT, gitdir =3D STRBUF_INIT;
        const char *prefix =3D NULL;
        struct repository_format repo_fmt =3D REPOSITORY_FORMAT_INIT;
+       const char *str =3D "/tmp/some/dir/a/b/c/d/e/f/g/i/j";
+       struct strbuf a =3D STRBUF_INIT, b =3D STRBUF_INIT;
=20
        /*
         * We may have read an incomplete configuration before
@@ -1231,6 +1233,14 @@ const char *setup_git_directory_gently(int *nongit_o=
k)
                die_errno(_("Unable to read current working directory"));
        strbuf_addbuf(&dir, &cwd);
=20
+       if (git_env_bool("GIT_TEST_SETUP", 0)) {
+               strbuf_addstr(&a, str);
+               setup_git_directory_gently_1(&a, &b, 0);
+
+               if (strcmp(a.buf, str) && git_env_bool("GIT_TEST_SETUP_PRIN=
T", 0))
+                       warning("from '%s' found '%s' ('%s/%s')", str, a.bu=
f, a.buf, b.buf);
+       }
+
        switch (setup_git_directory_gently_1(&dir, &gitdir, 1)) {
        case GIT_DIR_EXPLICIT:
                prefix =3D setup_explicit_git_dir(gitdir.buf, &cwd, &repo_f=
mt, nongit_ok);

