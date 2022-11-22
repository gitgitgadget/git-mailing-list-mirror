Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FABC433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 22:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbiKVWUv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 17:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235196AbiKVWUs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 17:20:48 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39647C689
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 14:20:46 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id vv4so29596410ejc.2
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 14:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kR39AnBNCMdTRvau7BmCh2TzFdzPJCj4iX2ePe6/BUw=;
        b=SBTpgkdzYUTRQalfF5FjUS7wP5VQGHWC4H3byCqgcFbcVB0pnDxBJZwdQmu8RS6GIG
         KSJqC8kunTSHR1qlcaUuL4ph5t82QpkFPlVrvKRRGUihwds9ZtoxshmDl4DmqDIXjdvI
         Z1e+ERMNXlg1qcvLhKfIkZ5DULuPN1t6UzptwLD4lCOJf9yuuCQbmmI15K/Zo2O6zv3d
         2r+ydwJM1TEHWw3r+zx7lvQ0AwTnSTSgqCiZQfrZ2b/4/yQcjyCM/ej9lzMi8BMnie3Z
         2jyKysU1OpI2m1daBeC4/c8FBj7+JABV62GzGjesAhGe7bD21FHNLqK+mbqSUG4KKUA4
         0nQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kR39AnBNCMdTRvau7BmCh2TzFdzPJCj4iX2ePe6/BUw=;
        b=Cg4CvTL1sQAGeKyeW0rAfaCkW4yDXnqb7F987QfHEZoEuLjeYWXlDehIjfIY1QUc/d
         dtvuRVegrWhsNu+xqaflO35k+ff9sKkcfWIa6fb6MYGji16WCNrXdsaPAW0UmH06qhNr
         3JZ9BSqI5oE/lvglzFgiys71Xj/k/kUxu/sbKQcKrMvRkGqZwp9ClhHZrEYfgu93Ovg3
         ClQNcVDVDM4FuPKZC9g5+5f8AlFqZ84v6b3idKdziKlJrHYkC4feA62FEN3dKS5u4TWX
         /zPxluAn44F+X3SxQOEqPEdExTzqt58hWKIt5RlBNuEjb09Jigmxd+i58mWLz50Eix8Z
         14DA==
X-Gm-Message-State: ANoB5pnsydKay0FUjvfr++c9PIn6EJ6CTuum0xbF4DdjjrMoRXGbqBTt
        TYOWBHfD42nBOCzOyOdSL58=
X-Google-Smtp-Source: AA0mqf6zmR1nZU4/Mb+Hrax9ow64GnQt8jgO0GZCniDNzc/cLoXJtCjl4d945L+LvklzY+wyUUpIQw==
X-Received: by 2002:a17:906:1e8a:b0:7b2:b992:694d with SMTP id e10-20020a1709061e8a00b007b2b992694dmr16990025ejj.651.1669155645358;
        Tue, 22 Nov 2022 14:20:45 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id u21-20020a170906125500b007a7f9b6318asm6478955eja.50.2022.11.22.14.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 14:20:44 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oxbdE-000nsc-1A;
        Tue, 22 Nov 2022 23:20:44 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric DeCosta <edecosta@mathworks.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Git ML <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: fsmonitor: t7527 racy on OSX?
Date:   Tue, 22 Nov 2022 23:12:20 +0100
References: <221121.86y1s4bfp6.gmgdl@evledraar.gmail.com>
 <Y3t/YbZUIuIJkSil@danh.dev>
 <BL0PR05MB55715FF24BD1AD53EE81A5A2D90D9@BL0PR05MB5571.namprd05.prod.outlook.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <BL0PR05MB55715FF24BD1AD53EE81A5A2D90D9@BL0PR05MB5571.namprd05.prod.outlook.com>
Message-ID: <221122.86r0xuaawz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 22 2022, Eric DeCosta wrote:

>> -----Original Message-----
>> From: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gmail.com>
>> Sent: Monday, November 21, 2022 8:39 AM
>> To: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> Cc: Git ML <git@vger.kernel.org>; Eric DeCosta
>> <edecosta@mathworks.com>; Jeff Hostetler <jeffhost@microsoft.com>
>> Subject: Re: fsmonitor: t7527 racy on OSX?
>>=20
>> On 2022-11-21 14:07:13+0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>> <avarab@gmail.com> wrote:
>> > I have access to a Mac OS X M1 box (gcc104 at [1]) where t7527
>> > reliably fails due to what seems to be a race us doing something, and
>> > assuming that fsmonitor picked up on it.
>>=20
>> See also https://lore.kernel.org/git/YvZbGAf+82WtNXcJ@danh.dev/
>> <https://protect-
>> us.mimecast.com/s/580RCpYn6ETDOBoycYVkUq?domain=3Dlore.kernel.org>
>>=20
>> I raised 3 months ago and it seems like Jeff Hostetler is too busy.
>>=20
>> >
>> > This makes the tests pass:
>> >
>> > diff --git a/t/t7527-builtin-fsmonitor.sh
>> > b/t/t7527-builtin-fsmonitor.sh index 56c0dfffea..ce2555d558 100755
>> > --- a/t/t7527-builtin-fsmonitor.sh
>> > +++ b/t/t7527-builtin-fsmonitor.sh
>> > @@ -428,6 +428,7 @@ test_expect_success 'edit some files' '
>> > start_daemon --tf "$PWD/.git/trace" &&
>> >
>> > edit_files &&
>> > + sleep 1 &&
>> >
>> > test-tool fsmonitor-client query --token 0 &&
>> >
>> > @@ -443,6 +444,7 @@ test_expect_success 'create some files' '
>> > start_daemon --tf "$PWD/.git/trace" &&
>> >
>> > create_files &&
>> > + sleep 1 &&
>> >
>> > test-tool fsmonitor-client query --token 0 &&
>> >
>> > @@ -471,6 +473,7 @@ test_expect_success 'rename some files' '
>> > start_daemon --tf "$PWD/.git/trace" &&
>> >
>> > rename_files &&
>> > + sleep 1 &&
>> >
>> > test-tool fsmonitor-client query --token 0 &&
>> >
>> > @@ -978,6 +981,7 @@ test_expect_success
>> !UNICODE_COMPOSITION_SENSITIVE 'Unicode nfc/nfd' '
>> > mkdir test_unicode/nfd/d_${utf8_nfd} &&
>> >
>> > git -C test_unicode fsmonitor--daemon stop &&
>> > + sleep 1 &&
>> >
>> > if test_have_prereq UNICODE_NFC_PRESERVED then
>> >
>> > The failure is when we grep out the events we expect, which aren't
>> > there, but if you manually inspect them they're there. I.e. they're
>> > just not "in" yet.
>> >
>> > I thought this might be a lack of flushing or syncing in our own trace
>> > code, but adding an fsync() to trace_write() didn't do the trick.
>> >
>> > 1. https://cfarm.tetaneutral.net/news/41#
>> > <https://protect-
>> us.mimecast.com/s/S6YNCqxoXGIWkoNRHEfMzu?domain=3Dcfarm
>> > .tetaneutral.net>
>>=20
>> --
>> Danh
>
> Honestly, I'm not surprised. Stopping the daemon and grepping for
> expected results immediately there after is just asking for these
> sorts of races. Sleeping is a bit ugly, but without an explicit means
> of synchronization is probably the best that can be done. I can take a
> look at it some more as I have access to M1 Macs.

I don't see why it would have to do with stopping the daemon. If
anything that should reduce the odds that you're running into a
race. I.e. on OSX in general this will work:

	echo foo >f &&
	grep foo f

Or, the equivalent with an "echo" that's not a shell built-in. I.e. we
had a process start, print to a file, and then we grep data out of it
agin.

The reason I'm saying it should reduce them is if the "echo" were some
long-running daemon process that was still running the "grep" might fail
because the "foo" was still in some buffer and hadn't been written or
fsync'd to disk.

Anyway, all of that seems inapplicable to these failures, as we're not
stopping the daemon yet by the time we run into the synchronization
problem. We just *started* it, then renamed some files, but when we ask
for those events we don't get them back.

Maybe there's some innocuous reason for that, but I have the sinking
feeling that it might be some race between creating the files, the
kernel getting those events, acting on them, but not having sent notice
of those events to the daemon that's listening.

*That* would be much scarier, and would mean that this fsmonitor
implementation would be racy outside of our tests, wouldn't it?
