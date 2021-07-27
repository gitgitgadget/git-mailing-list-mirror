Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC3BC432BE
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 17:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 483DA60F57
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 17:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhG0RlR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 13:41:17 -0400
Received: from mxo2.nje.dmz.twosigma.com ([208.77.214.162]:35085 "EHLO
        mxo2.nje.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhG0RlR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 13:41:17 -0400
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Jul 2021 13:41:16 EDT
Received: from localhost (localhost [127.0.0.1])
        by mxo2.nje.dmz.twosigma.com (Postfix) with ESMTP id 4GZ3pR4vDQz8sj0;
        Tue, 27 Jul 2021 17:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=twosigma.com;
        s=202008; t=1627407311;
        bh=H5/cH+jqT2X476wTNH9lE53oyIb8HggRzmnYo4dq7SI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=a9b8J3N8+9h+NOTqxrRnaLUumcI9gJsd185dnsEO8vd3yrA0rNazClLVI8RF3WIBN
         KMdMFNR0dzsyJd3EH+7n7GF2jcuh9qPbKAbv+vcwW65fCEV2/5ExkC/jr5MTFrZw0z
         TdhPLgsIfl11GB4mOWn5cyi0WBu3/cldr/910PWjeEh71rshUIEoInkMCQSoiAiMDf
         Y/70x7Up434MhGer/c0/X7g8pzAlOzzmPw8z9f5NiBHWjp51s0OKR4w9eg19nlDNEy
         MXs1fGhdlU+0Nc14G4vFoGku6HfHFwU69cV8iJoTXL7X+aR0KEt1Yq3IEiGAim38Se
         RYPy4VGjXpcWw==
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo2.nje.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo2.nje.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id I3gv0OoE68RH; Tue, 27 Jul 2021 17:35:11 +0000 (UTC)
Received: from exmbdft6.ad.twosigma.com (exmbdft6.ad.twosigma.com [172.22.1.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo2.nje.dmz.twosigma.com (Postfix) with ESMTPS id 4GZ3pR41CNz8sfG;
        Tue, 27 Jul 2021 17:35:11 +0000 (UTC)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft6.ad.twosigma.com (172.22.1.5) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 27 Jul 2021 17:35:11 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%19]) with mapi id
 15.00.1497.012; Tue, 27 Jul 2021 17:35:11 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "novalis@novalis.org" <novalis@novalis.org>
Subject: RE: [PATCH 2/3] diff --submodule=diff: do not fail on ever-initialied
 deleted submodules
Thread-Topic: [PATCH 2/3] diff --submodule=diff: do not fail on
 ever-initialied deleted submodules
Thread-Index: AQHXgnGhUBKz8KCJskWdL+/4E0rKgatXFbdw
Date:   Tue, 27 Jul 2021 17:35:10 +0000
Message-ID: <91f6fc69470d4291a982cb9c4b3cd6c1@exmbdft7.ad.twosigma.com>
References: <20210726183358.3255233-1-dturner@twosigma.com>
        <20210726183358.3255233-2-dturner@twosigma.com> <xmqqv94wfzu0.fsf@gitster.g>
In-Reply-To: <xmqqv94wfzu0.fsf@gitster.g>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.191.47]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Junio C Hamano <gitster@pobox.com>
> Sent: Monday, July 26, 2021 6:57 PM
> To: David Turner <David.Turner@twosigma.com>
> Cc: git@vger.kernel.org
> Subject: Re: [PATCH 2/3] diff --submodule=3Ddiff: do not fail on=20
> ever-initialied deleted submodules
>=20
> David Turner <dturner@twosigma.com> writes:
>=20
> > If you have ever initialized a submodule, open_submodule will open it.
> > If you then delete the submodule's worktree directory (but don't=20
> > remove it from .gitmodules), git diff --submodule=3Ddiff would crash=20
> > as it attempted to chdir into the now-deleted working tree directory.
>=20
> Hmph.  So what does the failure look like?  The child process inside
> start_command() attempts chdir() and reports CHILD_ERR_CHDIR back, and=20
> we catch it as an error by reading from notify_pipe[0] and report=20
> failure from start_command()?  Or are we talking about a more severe=20
> "crash" of an uncontrolled kind?

It's the first kind.

> Bypassing the execution of diff in the submodule like this patch does=20
> may avoid such a failure, but is that all we need to "fix" this issue? =20
> What does the user expect after removing a submodule that way and runs=20
> "diff" with the "-- submodule=3Ddiff" option?  Shouldn't we be giving=20
> "all lines from all files have been removed" patch?

Just a note: this only matters if the submodules git dir is
absorbed.  If not, then we no longer have anywhere to run the
diff.  But that case does not trigger this error, because in that
case, open_submodule fails, so we don't resolve a left commit, so
we exit early, which is the only thing we could do.

If absorbed, then we could, in theory, go into the submodule's
absorbed git dir (.git/modules/sm2) and run the diff there.  But
in practice, that's a bit more complicated, because `git diff`
expects to be run from inside a working directory, not a git dir.
So it looks in the config for core.worktree, and does
chdir("../../../sm2"), which is the very dir that we're trying to
avoid visiting because it's been deleted.  We could work around
this by setting GIT_WORK_TREE (and GIT_DIR) to ".".  This
actually seems to work, but it's a little weird to set
GIT_WORK_TREE to something that is not a working tree just to
avoid an unnecessary chdir.  To my mild surprise, it also seems
to work correctly in the case of deleted nested (absorbed)
submodules.  What do you think of this idea?

(Side note: The same bit about chdir into the working tree is
true for diff-tree even though it normally does not need anything
from the working tree.  I say "normally", because in the case of
nested submodules, it might need to look inside those submodules,
which might themselves not be absorbed.  Of course, this case
cannot obtain if the submodule in the worktree has been deleted.
We should consider fixing the docs for git diff-tree
--submodule=3Ddiff to specify that it only works if -p is passed.)

(Sorry if the formatting on this email ends up bad -- corporate
email is... corporate .  I'm going to CC my personal address so
that I can use a better mailer on future replies).=20
