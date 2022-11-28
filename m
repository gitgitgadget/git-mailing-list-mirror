Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6864C43217
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 14:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiK1OWm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 09:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbiK1OWg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 09:22:36 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B549C65F5
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 06:22:35 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id vv4so26222921ejc.2
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 06:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WWeKCoIfsUwMLjcQmPxzltEstMfUNzND0loQN0pWgJU=;
        b=FBb8foX/8mCfl8ffTUDBQWtZ6wrymDDUqsbDMOGKrXrJiiIc7TezQkiczzK88WmZ/K
         XTGaTOXniMkmR+Dbg6PrJjZcXEOu++A1h4Egba/FlM7ft4a54GeY1XtFpsFLVJRpZR4D
         LG6YFDxJileXAsKtyUV5YnTtQG44XpCNWXt5blHIJbTA9MPmCqaOkZk8rCLam0hrHJ4h
         MKNax2BRvJj9Z9JsFvpiJ40RamtLh4azzB0BldZabChieA52cyTNr8aa/mPV/Psf+30O
         L9ytPcjrKAHF2ceyyEX9sQcusdJPhJbBmKLDSmqKxPuEqZDLLFvbF8BZbR6ZfHoLEzp9
         2HfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WWeKCoIfsUwMLjcQmPxzltEstMfUNzND0loQN0pWgJU=;
        b=ZO9xqVzi2zruoNnSBlbXjLfwGXIqYADfQEg9Q57mjDUoPOUfaAk0TXpkBTtMjwThLp
         mZI+Rt98CecYqYMMvG2It/FCfQDrbMV+pwTrr+Z8orhQldQBB8rLrvHLPXtOEqRb/DuL
         x2xZzipKnGYn4aLsFnsWlvmD6LVwPTO+MItIhlcVsWZDzBAkfHqpzH/A+FbEhe6ovmqU
         cTh8sGXusOUwnJYCvMfBgl+H2VqPFqqwXie/ujaLiZYoqnbzwJpi/hWOVjRDZ8f5TUde
         oeyg1odguokrcvMELCOTFmhigCOIcJHxAa0EzVzviyd3sM1Pb1QHnASyKQFOa/FTOK56
         4gyA==
X-Gm-Message-State: ANoB5pmn9X//FWPeb+W243C2P7ABvcz9BnExgqtLON65NKOlh6MWYAv6
        a8IiAm+OkDsHe3rRIr0IHE8=
X-Google-Smtp-Source: AA0mqf7D8gZBx1CnaLjXp8iZMf6BJa2NTpCbla0oFFiWagqd32d5JeVARC+4r+79P20prseMizk/Vw==
X-Received: by 2002:a17:906:71c2:b0:7ab:2de1:2e45 with SMTP id i2-20020a17090671c200b007ab2de12e45mr35661623ejk.422.1669645354102;
        Mon, 28 Nov 2022 06:22:34 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id b15-20020a17090630cf00b007a9c3831409sm4967682ejb.137.2022.11.28.06.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 06:22:33 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ozf1l-00169e-0e;
        Mon, 28 Nov 2022 15:22:33 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v2 1/3] t1301: fix wrong template dir for git-init
Date:   Mon, 28 Nov 2022 15:21:14 +0100
References: <20221127145130.16155-1-worldhello.net@gmail.com>
 <20221128130323.8914-2-worldhello.net@gmail.com>
 <221128.86edtnky39.gmgdl@evledraar.gmail.com>
 <CANYiYbHxgktZ27C0tPReS4m-esU9PD4jRacO08tmnrgyrq+jOg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <CANYiYbHxgktZ27C0tPReS4m-esU9PD4jRacO08tmnrgyrq+jOg@mail.gmail.com>
Message-ID: <221128.86a64bkvkm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 28 2022, Jiang Xin wrote:

> On Mon, Nov 28, 2022 at 9:28 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>>
>> On Mon, Nov 28 2022, Jiang Xin wrote:
>>
>> > From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>> >
>> > The template dir prepared in test case "forced modes" is not used as
>> > expected because a wrong template dir is provided to "git init". This =
is
>> > because the $CWD for "git-init" command is a sibling directory alongsi=
de
>> > the template directory. Change it to the right template directory and
>> > add a protection test using "test_path_is_file".
>> >
>> > The wrong template directory was introduced by mistake in commit
>> > e1df7fe43f (init: make --template path relative to $CWD, 2019-05-10).
>> >
>> > Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>> > ---
>> >  t/t1301-shared-repo.sh | 3 ++-
>> >  1 file changed, 2 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
>> > index 93a2f91f8a..7578e75d77 100755
>> > --- a/t/t1301-shared-repo.sh
>> > +++ b/t/t1301-shared-repo.sh
>> > @@ -140,7 +140,8 @@ test_expect_success POSIXPERM 'forced modes' '
>> >       (
>> >               cd new &&
>> >               umask 002 &&
>> > -             git init --shared=3D0660 --template=3Dtemplates &&
>> > +             git init --shared=3D0660 --template=3D../templates &&
>> > +             test_path_is_file .git/hooks/post-update &&
>> >               >frotz &&
>> >               git add frotz &&
>> >               git commit -a -m initial &&
>>
>> This fix looks fishy to me. The code you're changing looks like it was
>> buggy, but this looks like it's sweeping under the rug the fact that
>> "templates" never did anything at this point.
>>
>> So I'm not saying you should squash this in, but if you do so you'll see
>> that we only ever used this later.
>>
>>         diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
>>         index d4315b5ef5a..106ccc5704e 100755
>>         --- a/t/t1301-shared-repo.sh
>>         +++ b/t/t1301-shared-repo.sh
>>         @@ -129,15 +129,12 @@ test_expect_success POSIXPERM 'git reflog =
expire honors core.sharedRepository' '
>>          '
>>
>>          test_expect_success POSIXPERM 'forced modes' '
>>         -       mkdir -p templates/hooks &&
>>         -       echo update-server-info >templates/hooks/post-update &&
>>         -       chmod +x templates/hooks/post-update &&
>
> The "post-update" is used in this test case. A wrong template dir
> leads to an empty hooks dir in "new/", that cause the test at the
> end of this test case passed by accident.
>
>         # post-update hook must be 0770
>         test -z "$(sed -n -e "/post-update/{
>                 /^-rwxrwx---/d
>                 p
>         }" actual)" &&

Yes exactly, which is what I was pointing out with "isn't the real
fix...?". I.e. this does seem to improve things, but as this shows this
test is really fragile already.

So I think if we're poking at this it makes sense to change that "test
-z" to use "test_modebits" or something instead, so it'll actually do
what we expect, and not just silently pass if the hook is missing...
