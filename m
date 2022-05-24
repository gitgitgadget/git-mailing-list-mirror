Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD8DC433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 20:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241643AbiEXU7j (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 16:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238452AbiEXU7i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 16:59:38 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9990443F8
        for <git@vger.kernel.org>; Tue, 24 May 2022 13:59:36 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id n23so24677409edy.0
        for <git@vger.kernel.org>; Tue, 24 May 2022 13:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Oz6bCzbus9CIioGIqPnsvVqwMJATGv5tBtEXrcujQ44=;
        b=ib5lpV3b7XqZKiY+Y2s0+hylKW9nRSHk/g/Z+oxtWrkNY2xAcJlHz1SZhiabcYqc69
         14KDlSEw99Fky/zD04/vt+QmIOBujno4Md8WpSU3EzhtVU0kjo8HlCz35RhbgRjmtFns
         z+NiEv5z0p52A0L3PCBxubHEBixEDup1+A9Tk1zjW7W33nMZFYUoDBBFbIEOu5aYwPU3
         R/PeP1UVNmo1/C8UpLOgtvyj+TOCDSc+gqBCVQn46nZRI5ptIkQ6ozPD1es0DXvXneMT
         tAYSW1E9l4V/nEFR93H0ScVmgozSxK0W8GN1wHkZe3ZKGBSd4IGh4loNn45Rijonx+E0
         9GQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Oz6bCzbus9CIioGIqPnsvVqwMJATGv5tBtEXrcujQ44=;
        b=itXnhAwJHncX1lFw82CApkrfZ11W0vBxk9efUdvsAQ+oy0g1hMNljSyCdWUXq51FF7
         prKdFHLFpVVivw1H/8wkhTxmPRzY1Bq8SEseDIFmVsN61djVNzfcz6LeTVc23P3bktIU
         UmxfYbcGjUND4zxZfLBfOdVQOO1RsqGbEafadfvfkxCzv8/9rRylln/kBcXqwJ8x8aAK
         r9y15yXmlcOOxrd6jgwUKnA8hnrkfHf//3gus3BprHz6sLBrkmqzbZXrxBtvlh0xSvjN
         X4GkfOYoGvE/O4EZEKxQ6lZn9oZMdXh7+5hx5NHnlIFDe0XKx3/tzCMUnwSXmRc588ni
         aePA==
X-Gm-Message-State: AOAM530+rm5ku3Md7CIy6SAfElozSuTbS4qCEZOrMKt3r0YP/twiQStP
        32ajyo2McJUS/euzT5CwSw0=
X-Google-Smtp-Source: ABdhPJwo89yF9yaYvqn8KQ04m5X7JcIhurj4MU5m6+zREx4yfyJKFrX6grpV50ha2lCcERwB886+CA==
X-Received: by 2002:a05:6402:5415:b0:42b:228:5cf with SMTP id ev21-20020a056402541500b0042b022805cfmr28049691edb.245.1653425975378;
        Tue, 24 May 2022 13:59:35 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id rh6-20020a17090720e600b006fee7b400e6sm2316238ejb.111.2022.05.24.13.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 13:59:34 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ntbcs-003a8d-9Z;
        Tue, 24 May 2022 22:59:34 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH] http.c: clear the 'finished' member once we are done
 with it
Date:   Tue, 24 May 2022 22:45:03 +0200
References: <cover.1651859773.git.git@grubix.eu>
        <3f0e462e86625a3c253653e4a4eefabcd8590bf9.1651859773.git.git@grubix.eu>
        <xmqqtua2jtr0.fsf@gitster.g> <xmqqczgqjr8y.fsf_-_@gitster.g>
        <nycvar.QRO.7.76.6.2205232248360.352@tvgsbejvaqbjf.bet>
        <xmqqr14jluu4.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2205240124280.352@tvgsbejvaqbjf.bet>
        <xmqqa6b7lrw6.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2205241258510.352@tvgsbejvaqbjf.bet>
        <xmqqleuqj1gy.fsf@gitster.g>
        <20220524201639.2gucdkzponddk5qt@carlos-mbp.lan>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220524201639.2gucdkzponddk5qt@carlos-mbp.lan>
Message-ID: <220524.86mtf6ve89.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 24 2022, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> On Tue, May 24, 2022 at 10:15:57AM -0700, Junio C Hamano wrote:
>>=20
>> I _think_ we can even get away by not doing anything to
>> slot->finished at the end of run_active_slot(), as we are not
>> multi-threaded and the callee only returns to the caller, but if it
>> helps pleasing the warning compiler, I'd prefer the simplest
>> workaround, perhaps with an unconditional clearing there?
>
> Assuming that some overly clever compiler might optimize that out (either
> because it might think it is Undefined Behaviour or for other unknown
> reasons) then =C3=86var's version would be better for clearing the "warni=
ng".
>
> But your patch fixed the "bug" that a probably overeager compiler was
> "detecting".

Just briefly for those who perhaps didn't fully read the initial
thread. Per [1] and [2] (search for -fanalyzer in that [2]) it's not a
bug, undesired behavior etc. from GCC that it's "overeager" to warn in
this case.

Most warnings from compilers are in the category of not being triggered
on the basis of exhaustive code analysis which tries to prove that it's
a practical issue for *your codebase*. It's equally about warning you
about patterns that might be a problem in the future.

In this case I don't know how this line of reasoning started, or how the
output is confusing.

E.g. Johannes notes upthread that the "complaint is not actually
accurate". Well, yes it is, because the warning says:
=09
	http.c: In function =E2=80=98run_active_slot=E2=80=99:
	http.c:1332:24: warning: storing the address of local variable =E2=80=98fi=
nished=E2=80=99 in =E2=80=98*slot.finished=E2=80=99 [-Wdangling-pointer=3D]
	 1332 |         slot->finished =3D &finished;
	      |         ~~~~~~~~~~~~~~~^~~~~~~~~~~

I.e. it's telling us that we're *storing* the address, which we're
doing. "Storing" meaning "past the lifetime of the function".

It doesn't mean that GCC has additionally proved that we'll later used
it in a way that will have a meaningful impact on the behavior of our
program, or even that it's tried to do that. See an excerpt from the GCC
code (a comment) in [1].

1. https://lore.kernel.org/git/220127.86mtjhdeme.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/220414.86h76vd69t.gmgdl@evledraar.gmail.com/
