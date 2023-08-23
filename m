Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39DCEE4993
	for <git@archiver.kernel.org>; Wed, 23 Aug 2023 09:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbjHWJAq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Aug 2023 05:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235219AbjHWI6O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2023 04:58:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9CF2105
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 01:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692780895; x=1693385695; i=johannes.schindelin@gmx.de;
 bh=vBEqjceQf8HDcI/MikSLkIT+vr1Pxr5iron8/amV+NE=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=esFM2tvkpB95qVdThZp0r058rK/kl98wXFV+6Q54fZnozhOW9Gj1298fDx+RLCwncbiYiy/
 flq5wtQVuzlEv5tXZmrGDO8cjbvn/XW0Ek9/FXNWOUCzh06mppeoVw+xvUmnK4teY6dfkkfcz
 bYn/rv0ZMJJN35JDbKGcO8AmBmNXQSJgxN62TBf6LU8J6Lxw5UpxPFFW5NXwdanAlcwvb1+hb
 TcaD63WYEaPmhLAKK7RhwLPP2nHbu6Sb1akBbB+Zy8CFcycsEuRt62L/uagOaVng1W+XjiRIO
 KQn/04inNudCySMbZABP3Ya5XUKQBZqh7aNjXuLRKHi8i69IgYkg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.15]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTzb8-1q8r2D2bFy-00QzVw; Wed, 23
 Aug 2023 10:54:55 +0200
Date:   Wed, 23 Aug 2023 10:54:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Stefan Haller <lists@haller-berlin.de>
Subject: Re: [PATCH] rebase -i: do not update "done" when rescheduling
 command
In-Reply-To: <d20ffc1f-c3b5-0f64-d508-976098f418e0@gmail.com>
Message-ID: <03d6f4df-d175-350c-7e75-ba78be80ba4e@gmx.de>
References: <pull.1492.git.1679237337683.gitgitgadget@gmail.com> <f05deb00-1bcd-9e05-739f-6a30d6d8cf3b@gmx.de> <d20ffc1f-c3b5-0f64-d508-976098f418e0@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1651994079-1692780895=:2363"
X-Provags-ID: V03:K1:FwV55h8OIAbaQ0XCOvXnzVwB/dYKAUKC/6rEpssOMN5UWKfr+GW
 xsEbZBHSe6nqI9BDInM54Yuu3LGRd8JJRkmY0T3br/Qcra1qvYeXKFhoBywF7hSLVxI7jjD
 JLhMmAlQMoUJXVyQdMwQHkWR279sS5AvXxja1TKh90Cbel7j9XfSWm2E8BWmK1FmpiJzpiW
 Ifby9pjtxvNbT9a9dvt8g==
UI-OutboundReport: notjunk:1;M01:P0:zbJlQNCEr74=;14Uqo0h+erRsXxnpBvW+UfTy+PF
 ASKJtnD8gX4tfPjzsXhDoFXZDnXgbWnNoVKwMSwn3ekN1+u9nvrOOup8NYl9Qvv9Zw1SbIOeY
 nmSAtybtKwxqdaxRI15xI/YQfOfyX6mNBuOicoKJ9r6sCTCOlQXjbjvFAYHttDExn8kvIyd3b
 qDMzg7SRqz3xV1xPlNt3vU1zqYYP9JY9aKqHL3FcbPSULiingz0t5u7kfhwMvxVraDi1X3PCd
 VZyz3MuBXlaSKkVJps2vAvh+t21PPOWehv0sZuSdWUg2P5+7zDdowrKori7C6fIQl0FLJ6Lb0
 Vr7Sx0HP9QzPubq35FIEOCp/Nwh53J5iIy0hb7q+ibZqyBjgYiqijmKRjqEryvlyebQIJly2R
 I2BslBXHvQy8YqdcmQ++BGHFCFG8zfgHOxwxPXkn9udil5TbU2BueDmklyQxJvTP3skbxf/ZW
 dSOqz325zzbNEXTXlnDR7XRi97L1yGszC6qP5iyzmFiIuDQDNtEsPWWM23p8XRu+cdr5AIoau
 h4ccV6sLUlYSvP1/DrzOaX66vr/FItiDo1paG3FGZw+ouHcq1bi0Ng52Eqo39Rr9D3eHgogza
 PRt+d3b9WtaDM7h0SQJDVdwEae8usDlaZH5DMo8Y092+B1S5GJI9L6DW+Q/5bVbAh5dEBWlYP
 ip9yYLfUMCMwA+kCocRpcAuC4+qaoQCWhxhTPrrRNGolpnPTbngXdEkOoJN3zi9KX3C3oxp/a
 JsUognJnC4ZAZt7fnsVHiyDUZaf8/pI0JTpDZ6HtyALgiRAQr1vgwjWaTCbVogKDmlriqO6i5
 rI3Ul8IYjY8KeGcf8xVKksy2tq6ps8cbTY7ikYDXxpd+jHT4tBpP2Y6e1N1+WZYYz5wBkSFn4
 F2Dr+FKwYhmIVDAdl45uWeDAzloZuB12SHw77b9tbWbpUv562OjPQl7mSd0Z3QmAxscyDZylC
 PnCquQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1651994079-1692780895=:2363
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

On Thu, 3 Aug 2023, Phillip Wood wrote:

> On 27/03/2023 08:04, Johannes Schindelin wrote:
> >
> > On Sun, 19 Mar 2023, Phillip Wood via GitGitGadget wrote:
> >
> > > From: Phillip Wood <phillip.wood@dunelm.org.uk>
> > >
> > > As the sequencer executes todo commands it appends them to
> > > .git/rebase-merge/done. This file is used by "git status" to show th=
e
> > > recently executed commands. Unfortunately when a command is reschedu=
led
> > > the command preceding it is erroneously appended to the "done" file.
> > > This means that when rebase stops after rescheduling "pick B" the "d=
one"
> > > file contains
> > >
> > >  pick A
> > >  pick B
> > >  pick A
> > >
> > > instead of
> > >
> > >  pick A
> > >  pick B
> > >
> > > Fix this by not updating the "done" file when adding a rescheduled
> > > command back into the "todo" file. A couple of the existing tests ar=
e
> > > modified to improve their coverage as none of them trigger this bug =
or
> > > check the "done" file.
> >
> > I am purposefully not yet focusing on the patch, as I have a concern a=
bout
> > the reasoning above.
> >
> > When a command fails that needs to be rescheduled, I actually _like_ t=
hat
> > there is a record in `done` about said command. It is very much like a
> > `pick` that failed (but was not rescheduled) and was then `--skip`ed: =
it
> > still shows up on `done`.
>
> We still do that after this patch. What changes is that when "pick B" fa=
ils we
> don't add "pick A" to the "done" file when "pick B" is added back into
> "git-rebase-todo"
>
> > I do understand the concern that the rescheduled command now shows up =
in
> > both `done` and `git-rebase-todo` (which is very different from the fa=
iled
> > `pick` command that would show up _only_ in `git-rebase-todo`). So may=
be
> > we can find some compromise, e.g. adding a commented-out line to `done=
` =C3=A0
> > la:
> >
> >  # rescheduled: pick A
> >
> > What do you think?
>
> If a commit is rescheduled we still end up with multiple entries in the
> "done". In the example above if "pick B" fails the first time it is exec=
uted
> and then succeeds on the second attempt "done" will contain
>
> 	pick A
> 	pick B
> 	pick B
>
> It might be nice to mark it as rescheduled as you suggest but this serie=
s
> focuses on removing the incorrect entry from the "done" file, not
> de-duplicating the "done" entities when a command fails.

After having had plenty of time to let this issue simmer in the back of my
head, and after reviewing the latest iteration of the patch series, I am
no longer concerned, as it now sounds more logical to me, too, that
rescheduled commands don't show up in `done`.

Thank you,
Johannes

--8323328-1651994079-1692780895=:2363--
