Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBB4CA0FF8
	for <git@archiver.kernel.org>; Tue,  5 Sep 2023 16:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbjIEQAo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354393AbjIELSN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2023 07:18:13 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D636F1AE
        for <git@vger.kernel.org>; Tue,  5 Sep 2023 04:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693912678; x=1694517478; i=johannes.schindelin@gmx.de;
 bh=MDswNS+zwORLE7YHAWrt5JQDF9JYO7xTuWYxAIk3QPg=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=A3KyOrGHMi8w3CjWTwG2SpjptvhjRL+w2JESno6rJRFjaeAC6qs6v8gIvy7eNWpN7NZPbQq
 6Wf6oTXQXU+0wGZAbRXbMYjlp1KFBydb/GLwvDIRfUIhVYhVrLmg7+H4LcbgkfREbcfqaO7O3
 wfJD3QUBfwB460NO6suOM/6kUGNhSuinypmFskZssm1z2JENjU/g+TyDKjzTt6aXpF6uQBhD5
 JA3D40p6CMgTfyUNshhljLlefMg71quKAwj1sx3ffFZ6jpcAnqz44ULvH43szqIPt5rzC6V7n
 NQJ1mewbFZzp5xunT+MtDnbf+YoDZH+L2rxWYDX1lQkLX94avp/A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.152]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQvD5-1qFdnG3Wat-00O3aP; Tue, 05
 Sep 2023 13:17:57 +0200
Date:   Tue, 5 Sep 2023 13:17:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Haller <lists@haller-berlin.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v3 6/7] rebase --continue: refuse to commit after failed
 command
In-Reply-To: <02c28b26-4658-43c8-b1d1-7f1e09bda609@gmail.com>
Message-ID: <87fbc8c9-f42b-b374-fee1-57c58f5e8fc0@gmx.de>
References: <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com> <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com> <2ed7cbe5fff2d104a1246783909c6c4b75c559f2.1690903412.git.gitgitgadget@gmail.com> <a5bfea5f-0d0d-f7ed-3f72-37e3db6f5b2c@gmx.de>
 <02c28b26-4658-43c8-b1d1-7f1e09bda609@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:mDTTxGwAZXj1BgiJxbCOj6mEUrhMv+Y0PgWJxbMFzBQwYXAxEOC
 RsHzqkx6D8x/t1MxKQeDyHF4h/h0x7sclHXKUgx4Z+KOPsZ0mqQSVNPF1VGyrEFT2AP0mTE
 Y9DRJJr7vdAiCiYtbzHtC8ibRH9vIHs3red5rE1Cp6w2EiLbPl8T6lkh/K4M+Kv1OR/XBpE
 MmrtcwSCUZUr2XBFV+naw==
UI-OutboundReport: notjunk:1;M01:P0:qg8lS8VNyFo=;X1WmcmsrNDJVeGPoLAyN6zDJMjd
 6hMPSom51NaOOzzKMKSz3uYlvd5x1E4sd5Cx6o6fYmkUE/d7JOSXpjuYUV23n46urLjeCDISH
 pXFX2haHKN6t3sWI9bMLRIjFNENX6SL0+XDz4YFmuHueso4OBvRGOy8Z2uG6yqcPcKrRt0mKd
 PxMnCzTSGAikZn4MVNg5dlEv3NbuHm/BQL/K27j1HKpE+hLkV2/+T49391ttLTC0pVpyssZ3v
 FsgkDxLY3rntjoFO46faUfMyMVolsYI+DfQDhQlJak5j7+ipqiFfRW2iWHBQ99sUOoNagjmUh
 FlFWm4FQ7mOWPjHoT6nwAnwTvoMJubhFIA4iDhT8JvxExbgIJRz1H04gJxyjFAiqiEfnorOfz
 k+6O5kpg9OdizpINkmueK5lR/iGJkbbMZwN7zdpKvveETAw0jLwb51Qm0+pWfvZnD4zvYbFOk
 vmYE/zv3mRQU5B2Rt34C8t8h9dqeTeMtsIrEkDJoTfOIxSGdmSWsOK+W2v9EIKzkdt4kpVIGe
 aJcjZEpaBw3tH4w+0MWcJhhIySC6Reg45l5S9oLu4cRrXfWoo5DNKSSTaUx8BQrHLvke9YP9R
 XySNGPdzDcd61h9RRITCSzMs+7QI9sP/ukHGCSiRtM11vDK2ZYN0M/oPwoOVbxT6+RA8e0tQl
 5wZLUa6YCn2HebOfUYJbRe3GAvEpYs7Qe2JC1YsUveEwNrM1v3jNtdG+upi+8pRAvq2UllF8z
 ND6ZxwH3pHG8id3xYRoAk38+b22/E1WBkIgfBUPcCzFMbk4oumDWxVzdxTYBJSWnRE7wt3cfR
 r2C2c0OM/RAHkFabc99KIsN1ejrD0eS/IkihKFpB6AiNZ8YQ1JCRtD/2GOVVROGddrmLu2DUO
 r03oJ5xaUQ0DkfjP7xrq1AIh3RZHgP8/LsDXflqrKRs28gQzaszBGnpHOoNo2DbTu79sKeNjg
 p1b+5vW1cEfxMHsz18VvX5fxZ2M=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Mon, 4 Sep 2023, Phillip Wood wrote:

> On 23/08/2023 10:01, Johannes Schindelin wrote:
>
> > On Tue, 1 Aug 2023, Phillip Wood via GitGitGadget wrote:
> >
> > > From: Phillip Wood <phillip.wood@dunelm.org.uk>
> > >
> > > If a commit cannot be picked because it would overwrite an untracked
> > > file then "git rebase --continue" should refuse to commit any staged
> > > changes as the commit was not picked. This is implemented by refusin=
g to
> > > commit if the message file is missing. The message file is chosen fo=
r
> > > this check because it is only written when "git rebase" stops for th=
e
> > > user to resolve merge conflicts.
> > >
> > > Existing commands that refuse to commit staged changes when continui=
ng
> > > such as a failed "exec" rely on checking for the absence of the auth=
or
> > > script in run_git_commit(). This prevents the staged changes from be=
ing
> > > committed but prints
> > >
> > >      error: could not open '.git/rebase-merge/author-script' for
> > >      reading
> > >
> > > before the message about not being able to commit. This is confusing=
 to
> > > users and so checking for the message file instead improves the user
> > > experience. The existing test for refusing to commit after a failed =
exec
> > > is updated to check that we do not print the error message about a
> > > missing author script anymore.
> >
> > I am delighted to see an improvement of the user experience!
> >
> > However, I could imagine that users would still be confused when seein=
g
> > the advice about staged changes, even if nothing was staged at all.
>
> If nothing is staged then this message wont trigger because is_clean wil=
l be
> false.

Ah. I managed to get confused by the first sentence of the commit message
already. You clearly talk about "any staged changes". As in "*iff* there
are any staged changes". Which I missed.

A further contributing factor for my misunderstading was the slightly
convoluted logic where `is_clean` is set to true if there are _not_ any
uncommitted changes, and then we ask if `is_clean` is _not_ true. Reminds
me of Smullyan's Knights & Knaves [*1*].

With your patch, there are now four users of the `is_clean` value, and
all but one of them ask for the negated value.

It's not really the responsibility of this patch series, but I could
imagine that it would be nicer to future readers if a patch was added that
would invert the meaning of that variable and rename it to
`needs_committing`. At least to me, that would make the intention of the
code eminently clearer.

Ciao,
Johannes

Footnote *1*: https://en.wikipedia.org/wiki/Knights_and_Knaves
