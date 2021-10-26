Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80545C433FE
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 15:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63A5A61090
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 15:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236854AbhJZPnG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 11:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236716AbhJZPmt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 11:42:49 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE41C061745
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 08:40:25 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 131-20020a1c0489000000b0032cca9883b5so2283216wme.0
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 08:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=DdeGXMtECpBNGKdKwHDHuMs03DusyYuWWfQ4yTQ4iek=;
        b=L8NXK1fC28pADWWefUM/PgQCWt98lXy7kJcHE17dQcrDLLaRJ7AfbRPUkvz8dWccja
         2J3WJblhXsCd2zY0Z7KcgFhw3tq9+sAFdBe2oimRTd8a6vPN4FVjRNLVZd+1QEfrjqJE
         G8Fhngt4SWVKH+I8QsQbEviw737tqhTPCSFjRMvAV4GiQe70oWxQUrlq4HhqplcCY3Qc
         jc6wL2TGOiAcsh0UfJVHq/cYREn+fRcoEtl3dCISNwqVPRQdcImPzIH7WJvDs3Y0rPtl
         A9jpYFj91c3+DVwqkxQHl+C1DQAS0S5XbtQpafMhMWC80xpA3Vz++GsOuZ7bvNqA1tvg
         VwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=DdeGXMtECpBNGKdKwHDHuMs03DusyYuWWfQ4yTQ4iek=;
        b=LzRgdD1QJmZ02Lhh5rXDQ+zVHZA4TWCj1uZR8BAebiut7QeLOeiU79VhPmYMmuqI7L
         +oScT1FqL4QenD9ojPmU4bXMuI/Wq9IGBxmBd+cuuXu8yFMDTlGrkjDeJmzd3b9BHXEB
         BcI0e5kIwQ+M2Mv/74VTJ9a+wZIrO+sYCeoGYEpaDBaQHJQG5RGPi6hZ1M4ntrNu+fdq
         C4caKamNrLaU2tlTcKEfugwAQ22vbjCyiwGDCEbontXpXFYWUlTC5hKQWHPFokEQxXq4
         FOWaSBgPLcVyo64WYuXX7JMiDs5yxIHVVaXOrrrkz/LhUODHEKPZbUSRsVso3j8nJE8x
         OChQ==
X-Gm-Message-State: AOAM530EroSfDIKn+bH3ZU4YWuWtrIdLr+1lNXe67rdQXXkC3wqvsOqn
        BP8ZO7NpY6Xf+ssELVmjyUa9Oq2tlDRnTQ==
X-Google-Smtp-Source: ABdhPJz3E5n+218RUuZe4zO6Gve2BSVrP+rt1mp4IV0LXb3WHF3R6XftZt7AEnz/yAM/9GSB8H5vRA==
X-Received: by 2002:a1c:7911:: with SMTP id l17mr58212459wme.138.1635262823550;
        Tue, 26 Oct 2021 08:40:23 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k22sm19823660wrd.59.2021.10.26.08.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 08:40:23 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mfOYo-001uIe-Jw;
        Tue, 26 Oct 2021 17:40:22 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>
Subject: Re: pre-v2.34.0-rc0 regressions: t7900-maintenance.sh broken due to
 'systemd-analyze' (was: What's cooking in git.git (Oct 2021, #06; Mon,
 25))
Date:   Tue, 26 Oct 2021 17:34:18 +0200
References: <xmqq5ytkzbt7.fsf@gitster.g>
 <211026.8635oo11jk.gmgdl@evledraar.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <211026.8635oo11jk.gmgdl@evledraar.gmail.com>
Message-ID: <211026.864k93zteh.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A
On Tue, Oct 26 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Mon, Oct 25 2021, Junio C Hamano wrote:
>
> [Spinning off some "before rc0" threads]
>
>> The fifteenth batch of topics are in 'master'.  I expect that this
>> is more-or-less what we can expect in the -rc0, unless there is a
>> hotfix to what's already merged.
>
> I reported a breakage with $subject in [1], which I see L=C3=A9na=C3=AFc =
tried to
> fix in [2], but which I managed to miss. Sorry about that.
>
> On that machine (gcc135, on the GCC farm) it's still breaking, relevant
> trace output:
>=20=20=20=20=20
>     ++ printf '%s\n' 'prerequisite SYSTEMD_ANALYZE ok'
>     prerequisite SYSTEMD_ANALYZE ok
>     ++ return 0
>     ++ test_set_prereq SYSTEMD_ANALYZE
>     ++ test -n ''
>     ++ case "$1" in
>     ++ satisfied_prereq=3D' POSIXPERM BSLASHPSPEC EXECKEEPSPID REFFILES C=
OLUMNS_CAN_BE_1 PERL PTHREADS PYTHON GETTEXT XMLLINT SYSTEMD_ANALYZE '
>     ++ lazily_tested_prereq=3D'EXPENSIVE XMLLINT SYSTEMD_ANALYZE '
>     ++ total_prereq=3D1
>     ++ case "$satisfied_prereq" in
>     ++ satisfied_this_prereq=3Dt
>     ++ case "$satisfied_this_prereq,$negative_prereq" in
>     ++ ok_prereq=3D1
>     ++ test 1 =3D 1
>     ++ systemd-analyze verify systemd/user/git-maintenance@.service
>     Failed to open /dev/tty0: Permission denied
>     Failed to load systemd/user/git-maintenance@.service: Invalid argument
>     error: last command exited with $?=3D1
>     not ok 34 - start and stop Linux/systemd maintenance
>
> I haven't looked into it, presumably easy-ish to fix, just moving on now
> and checking for other regressions...
>
> 1. https://lore.kernel.org/git/874ka618n4.fsf@evledraar.gmail.com/#t
> 2. https://lore.kernel.org/git/20210927213016.21714-2-lenaic@lhuard.fr/

I looked into this a little bit, the immediate problem is that the
prereq testing is different from the command we actually run, and I can
run one but not the other on that box for some reason. I.e.

    [avar@gcc135 t]$ systemd-analyze verify /lib/systemd/system/basic.targe=
t; echo $?
    Failed to open /dev/tty0: Permission denied
    0
=20=20=20=20
    [avar@gcc135 t]$ systemd-analyze verify systemd/user/git-maintenance@.s=
ervice; echo $?
    Failed to open /dev/tty0: Permission denied
    Failed to load systemd/user/git-maintenance@.service: Invalid argument
    1

So "fixing" that is easy, just have the prereq test that thing in
particular, and why does one thing have a /lib/ prefix, but not the
other?

But presumably this points to a bigger problem. I.e. we just did a "git
maintenance start" a few lines earlier.

If I could start something via systemd then presumably it's either up,
or our "start" is buggy and we didn't actually start something, or are
using the wrong (non-portable?) invocation to check the running status
of the thing we just started?

Also aside from that shouldn't this be:

    test_when_finished "systemd-something stop-it some-service" &&
    systemd-something start-it some-service &&
    [...]

Or are runaway services handled somehow by systemd magic (tied to the
PID of the test run?).

So in trying to fix it myself I ran into the boundaries of the little
systemd knowledge I've got.
