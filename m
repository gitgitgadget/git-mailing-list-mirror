Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44657C433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 07:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D51E60FD9
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 07:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbhJHHQm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 03:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhJHHQk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 03:16:40 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A765C061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 00:14:45 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id d3so5277572edp.3
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 00:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=IOKq9xl1XQF8WfvxWV+gtL1fkz6pTODZzcUPA4r0UVo=;
        b=lVDw8ZU+mG/B1NoznArLwMuE0rm0mIYrTkJltXFPvzq8Z/6Y7gHpyQjIT1jKjNMO17
         gdQcaL9LQj4Z+jWy6ezDG0sISH6w5lb+STeRqoEC8V1CWkOzVqblSVipgqTPD5j2aQf9
         RdIbTpF7hFa2nS5mi88XdDmOG//l6I0kXVNxbHcTMZZxLv/H+xOpG2mTYDq4hBSFbcJz
         6rTEE8xqIh/JLl8oHt/e1/eS5JibO83/MsYqoFZQ+EWRR8BJD522/N/L9Jp3pOrasoab
         J6lKIFDu2/3SjeyMmhCo+cVySsaKcguSxZTlBuYzYqU2gMD8U69rM9HvTsGtR3PE6mKp
         BzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=IOKq9xl1XQF8WfvxWV+gtL1fkz6pTODZzcUPA4r0UVo=;
        b=lE3QYRDS1fSKT9OTKut6W+bpk1+/DfZTbWJydiRd6M0Bp/tb3OOWkW+HDntLrNZCXv
         LQor9oCmBvukrNDbp+oVkG3DLZAFZ3FnImkIwYW3lypwqybapyank7+S3KK9+5i/MCSd
         b0s822C2cQnAtyWvAYbzQyu/trB1q3+eBAMxv/1t647/MebUbGjmQBTfRqbk7uFJtKIQ
         4MDaImDiunQsVk8a8u9yDzDQstlhnUOnAPx5XmjeZRprqJILITr1Ru6+grAJ3DzqtAsL
         2lQ7SJS+VhjrFdHn5ohm4fqrljjnLRqOwXDZpeoOdavXXDYPLoQIGdJ+AnbS1ooYw1M5
         5giw==
X-Gm-Message-State: AOAM530t98REXbXKollGnzsUueaTE44J16JkVJzYDB6dvyxFeKati0gQ
        /jWyWpGmuEfcd3gbtTI/LNQ=
X-Google-Smtp-Source: ABdhPJzg7uVGNij5JFbk/g0sFj1d5HxqrfoDHUhxeLT+S9O242QRUdciP9z2nyM3DTVrnMoT/TwIzA==
X-Received: by 2002:a17:907:62a2:: with SMTP id nd34mr2089275ejc.356.1633677284069;
        Fri, 08 Oct 2021 00:14:44 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id x13sm601767ejv.64.2021.10.08.00.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 00:14:43 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 5/8] progress.c: stop eagerly fflush(stderr) when not
 a terminal
Date:   Fri, 08 Oct 2021 09:01:43 +0200
References: <cover-0.8-0000000000-20210722T125012Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com>
 <patch-v2-5.8-250e50667c2-20210920T225701Z-avarab@gmail.com>
 <YV/CNSdntvm1QetC@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YV/CNSdntvm1QetC@google.com>
Message-ID: <8735pcgf8c.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 07 2021, Emily Shaffer wrote:

> On Tue, Sep 21, 2021 at 01:09:26AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>=20
>> It's the clear intention of the combination of 137a0d0ef56 (Flush
>> progress message buffer in display()., 2007-11-19) and
>> 85cb8906f0e (progress: no progress in background, 2015-04-13) to call
>> fflush(stderr) when we have a stderr in the foreground, but we ended
>> up always calling fflush(stderr) seemingly by omission. Let's not.
>>=20
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  progress.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/progress.c b/progress.c
>> index 7fcc513717a..1fade5808de 100644
>> --- a/progress.c
>> +++ b/progress.c
>> @@ -91,7 +91,8 @@ static void display(struct progress *progress, uint64_=
t n, const char *done)
>>  	}
>>=20=20
>>  	if (show_update) {
>> -		if (is_foreground_fd(fileno(stderr)) || done) {
>> +		int stderr_is_foreground_fd =3D is_foreground_fd(fileno(stderr));
>> +		if (stderr_is_foreground_fd || done) {
>>  			const char *eol =3D done ? done : "\r";
>>  			size_t clear_len =3D counters_sb->len < last_count_len ?
>>  					last_count_len - counters_sb->len + 1 :
>> @@ -115,7 +116,8 @@ static void display(struct progress *progress, uint6=
4_t n, const char *done)
>>  				fprintf(stderr, "%s: %s%*s", progress->title,
>>  					counters_sb->buf, (int) clear_len, eol);
>>  			}
>> -			fflush(stderr);
>> +			if (stderr_is_foreground_fd)
>> +				fflush(stderr);
>
> Looks like a straightforward refactor, although I wonder what's the
> difference between is_foreground_fd(fileno(stderr)) and isatty() in
> practice.

Good question. Whether you have a TTY is different from if it's in the
foreground. In this case we don't want progress bars to display their
full output if they're not in the foreground, just the summary line.

I.e.:
=20=20=20=20
    perl -MPOSIX=3Dtcgetpgrp,isatty,getpgrp -wE '
            say "TTY: ", isatty(1) ? "yes" : "no";
            open my $tty, "/dev/tty";
            my $tpgrp =3D tcgetpgrp(fileno($tty));
            my $pgrp =3D getpgrp();
            say "Foreground?: ",  $tpgrp =3D=3D $pgrp ? "yes" : "no"
    '
=20=20=20=20
Then:
=20=20=20=20
    $ <that>
    TTY: yes
    Foreground?: yes
    $ <that> &
    TTY: yes
    Foreground?: no
    $ <that> >f && cat f
    TTY: no
    Foreground?: yes
    $ (<that> >f &); sleep 1; cat f;
    TTY: no
    Foreground?: no

But having written that I can see that this commit of mine is buggy,
because when I wrote it I conflated the two. I.e. we don't want to defer
eager flushing in that "&" case. I.e. to have our line-buffered summary
line be held up by I/O buffered flushing.

> Reviewed-by: Emily Shaffer <emilyshaffer@google.com>
>
>>  		}
>>  		progress_update =3D 0;
>>  	}
>> --=20
>> 2.33.0.1098.gf02a64c1a2d
>>=20

