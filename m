Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F13C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 08:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFB4C610A3
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 08:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbhHXIwW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 04:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbhHXIwP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 04:52:15 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDC5C061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 01:51:31 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id s25so17751957edw.0
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 01:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=NggPWLXq7wX6Om6WMYS0K7oTJ81j7tnm3/WH8bXi5Gg=;
        b=hCjvMpa++Qr9NWopkT7KKllSmcwKCprGtcXOwGjuTtUet+5+P4+wpmMd9Q3b/06Y7Z
         m26urEQDzGrtfpcnRcXH1XYNeoiewCVvG62cLV1RB1W6HgbJGkH/LeAIZt8cdHLe6pSZ
         9fW2zHrBR1BBtAmLdlMuaPN3EFgeIf6+qNhsz0lGC2j4qxfw948xYrVEoE48xRufHSzm
         oqbIl+IzHocKOUBna9SlO8DOt/j0XrQvtGvdARXXmOtKdfpVRh5o9eLdTVxw3NTw0KMf
         0cHgFVYoqWsEoIc7eNqcmMzUqnaFtAsaaXhol4j5O7gSSZAtdHl7PiKbFxG1okLORjSr
         Teuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=NggPWLXq7wX6Om6WMYS0K7oTJ81j7tnm3/WH8bXi5Gg=;
        b=bhbdVrRrrqYbCB7AcbhTM6OEyxFBUjnudPuHpUAxNzKa4GASO1HXE/3t7oMCZubISN
         IapEx2Nw+Sl3oDx/Jaf7uamw1d36+28/ej8EwpZHNG/p0vXwO+ZnPeY8rwvZlKiqVd6S
         BfLYOAAPw2b8KOzaaf9lcFz/Iix3fjW4jx+n7xccLaFHNfIppz110RKqbVdXldCL5omw
         B2Ss5++KEC6YawCwVOuAL0jtX9zVo1TPK9VD7ZfxOQ2lPhrGPbLiALPMXG0KqqxqTeXO
         Y371ug/MTh19PAWrckK4L48h9LYjUpWEOPYbqL5RReYfN8Q41CfHUg3j3zYXMYdyX4W9
         sNQQ==
X-Gm-Message-State: AOAM532qLZCuOCQHJHMswHp7sNEZknatC0wVQKOlMqrsyRQjL26rIkC3
        LPaT1XbbilMtizcxXdEY9mM=
X-Google-Smtp-Source: ABdhPJw9YzHAelDM1fKDWsgH65n2nrvB+AZ4pti4KfgfpDZrbsUV8dtdLgPXu38CQBf8CdnDy+TN5g==
X-Received: by 2002:a05:6402:5249:: with SMTP id t9mr40852294edd.260.1629795090214;
        Tue, 24 Aug 2021 01:51:30 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m15sm11154171eds.92.2021.08.24.01.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 01:51:29 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Clemens Fruhwirth <clemens@endorphin.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jan =?utf-8?Q?Pokorn=C3=BD?= <poki@fnusa.cz>,
        Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>
Subject: Re: [PATCH v2] pull, fetch: fix segfault in --set-upstream option
Date:   Tue, 24 Aug 2021 10:49:26 +0200
References: <patch-1.1-2d8f3e59e1f-20210719T142808Z-avarab@gmail.com>
 <patch-v2-1.1-9e846b76959-20210823T125434Z-avarab@gmail.com>
 <CAG6gW_s6FHG6muJ6Hai-Sb2ntmygLymQZr8YrN212_SV1VhBAw@mail.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <CAG6gW_s6FHG6muJ6Hai-Sb2ntmygLymQZr8YrN212_SV1VhBAw@mail.gmail.com>
Message-ID: <87bl5nfcof.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 24 2021, Clemens Fruhwirth wrote:

> On Mon, 23 Aug 2021 at 14:56, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <ava=
rab@gmail.com> wrote:
>>
>> A proposed replacement of cf/fetch-set-upstream-while-detached which
>> as noted in What's Cooking has been languishing for a while. I changed
>> the die() in my version to a warning() as suggested by Junio & updated
>> the test and commit message accordingly.
>
> Thank you =C3=86var, for taking care of that and adding tests and my
> apologizes for not responding in a timely manner.

No worries.

>>  builtin/fetch.c         | 11 +++++++++++
>>  t/t5553-set-upstream.sh | 22 ++++++++++++++++++++++
>>  2 files changed, 33 insertions(+)
>>
>> diff --git a/builtin/fetch.c b/builtin/fetch.c
>> index 25740c13df1..ca487edd805 100644
>> --- a/builtin/fetch.c
>> +++ b/builtin/fetch.c
>> @@ -1623,6 +1623,17 @@ static int do_fetch(struct transport *transport,
>>                         }
>>                 }
>>                 if (source_ref) {
>> +                       if (!branch) {
>> +                               const char *shortname =3D NULL;
>> +                               if (!skip_prefix(source_ref->name,
>> +                                                "refs/heads/", &shortna=
me))
>> +                                       shortname =3D source_ref->name;
>
> Is skip_prefix ever able to fail?
>
> - If yes, then shortname will be left pointing to NULL when we print
> the warning below. Warning probably won't die because of NULL, but it
> still will print something weird.

If it fails we'll use source_ref->name, so it won't be NULL...

> - If no, then an assert(!skip_prefix(source_ref->name, "refs/heads/",
> &shortname)) might be more idiomatic.

Which means that this would be a bug, since it's not handling the case
where the source doesn't start with refs/heads/*.

I.e. it's the same as doing it this way (on top of this v2), which
perhaps is a clearer way to express the same idea. What do you think?

diff --git a/builtin/fetch.c b/builtin/fetch.c
index ca487edd805..2bc9159690d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1624,10 +1624,9 @@ static int do_fetch(struct transport *transport,
 		}
 		if (source_ref) {
 			if (!branch) {
-				const char *shortname =3D NULL;
-				if (!skip_prefix(source_ref->name,
-						 "refs/heads/", &shortname))
-					shortname =3D source_ref->name;
+				const char *shortname =3D source_ref->name;
+				skip_prefix(shortname, "refs/heads/", &shortname);
+
 				warning(_("could not set upstream of HEAD to '%s' from '%s' when "
 					  "it does not point to any branch."),
 					shortname, transport->remote->name);
