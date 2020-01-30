Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75424C33C9E
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 11:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F5F2083E
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 11:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=diamand.org header.i=@diamand.org header.b="C9m4AO5H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbgA3LeL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 06:34:11 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33147 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgA3LeL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 06:34:11 -0500
Received: by mail-wr1-f67.google.com with SMTP id b6so3671779wrq.0
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 03:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Vx9wC3kuIG+Q9asTHuP0cis5eWATsvyyRB+4y8BrI90=;
        b=C9m4AO5H73ee4EwsdT0KXVcjGgh+jmDFZPto7AO+P4eERbfSUe97/hXdy86Quwhpv9
         5IpTCyAVnTyjRtj1cK5Ed2aLwDL/suzBHo7ShI+QE3BIjK3xm3BkIEjEJz6ZCvXxDFas
         EXk+P/HDDc/I59a332QVK1SDjEvAZx5NGL3/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Vx9wC3kuIG+Q9asTHuP0cis5eWATsvyyRB+4y8BrI90=;
        b=J4PXGsuQ78zLrCTXpxnRCpEDbSoJJsn5B/HNVfhzZLgVoo21QPoyXFN2ywXLluV1lP
         d4KYtqfEiRz1U3iqdUF6x1U04sMeAZ7tsGSxi7laRR2mMhch33hYfz+la6Br4bWmPiTQ
         WP5/mtdxm0OcihLfDjwt+Q+Qzhwx9GRJl04IlTY3zgtmsShlFqDIz+8d7+FjOl0V1DXp
         7FepuucHj17r3hG3XYu6zD1VJKQjj4Rco/IHLDjg5QFEiS8QkgLfis7s1JpF9WI109X1
         MqBFd/2MHdxZFcu24b3QvMhD+3n3vS2kbDFKIlFUNBIGz84kmt/hsH7LGbRJGK8iE/Zk
         9fZw==
X-Gm-Message-State: APjAAAUKvR9Mw2TJxfGjsC38+/B259LC7TzMDiXpKwcbJL30nTlUvUzN
        xm0kWKns2rkTYiwIhBa5TVqBfh04pvdVcwlESpk/DVkT7mk=
X-Google-Smtp-Source: APXvYqwXLYbxE5KjnJcAbq19w6tvMsfrpuloMIGbEDwMPLyRFT+j295o5GiCq5tfiq4/xaqFhhex94KW4IjLzrvqcBA=
X-Received: by 2002:a5d:6852:: with SMTP id o18mr5115075wrw.426.1580384047128;
 Thu, 30 Jan 2020 03:34:07 -0800 (PST)
MIME-Version: 1.0
References: <20200129111246.12196-1-luke@diamand.org> <nycvar.QRO.7.76.6.2001301131280.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2001301131280.46@tvgsbejvaqbjf.bet>
From:   Luke Diamand <luke@diamand.org>
Date:   Thu, 30 Jan 2020 11:33:57 +0000
Message-ID: <CAE5ih7_Rh7L=nOfWEY9FhFYX4swHqS0LqTLG=7L_K363__gJkA@mail.gmail.com>
Subject: Re: [PATCHv1 0/6] git-p4: wait() for child processes better
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Users <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Yang Zhao <yang.zhao@skyboxlabs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 30 Jan 2020 at 10:52, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Luke,
>
> On Wed, 29 Jan 2020, Luke Diamand wrote:
>
> > git-p4 handles most errors by calling die(). This can leave child
> > processes still running, orphaned.
> >
> >     https://public-inbox.org/git/20190227094926.GE19739@szeder.dev/
> >
> > This is not a problem for humans, but for CI, it is.
>
> Just to make sure that we're talking about the same thing. Looking at
>
> https://dev.azure.com/git/git/_test/analytics?definitionId=3D11&contextTy=
pe=3Dbuild
>
> I am not even sure that `git-p4` is our biggest problem there. In that
> list, the only flaky `git-p4` test I see is t9806.5. And it failed only
> once recently:
> https://dev.azure.com/git/git/_build/results?buildId=3D1640&view=3Dms.vss=
-test-web.build-test-results-tab
>
> The log looks like this:
>
> -- snip --
> [...]
> expecting success of 9806.5 'sync when no master branch prints a nice err=
or':
>         test_when_finished cleanup_git &&
>         git p4 clone --branch=3Drefs/remotes/p4/sb --dest=3D"$git" //depo=
t@2 &&
>         (
>                 cd "$git" &&
>                 test_must_fail git p4 sync 2>err &&
>                 grep "Error: no branch refs/remotes/p4/master" err
>         )
>
> + test_when_finished cleanup_git
> + test 0 =3D 0
> + test_cleanup=3D{ cleanup_git
>                 } && (exit "$eval_ret"); eval_ret=3D$?; :
> + git p4 clone --branch=3Drefs/remotes/p4/sb --dest=3D/home/vsts/work/1/s=
/t/trash directory.t9806-git-p4-options/git //depot@2
> Initialized empty Git repository in /home/vsts/work/1/s/t/trash
> directory.t9806-git-p4-options/git/.git/
> Perforce db files in '.' will be created if missing...
> Perforce db files in '.' will be created if missing...
> Perforce db files in '.' will be created if missing...
> Perforce db files in '.' will be created if missing...
> Perforce db files in '.' will be created if missing...
> Importing from //depot@2 into /home/vsts/work/1/s/t/trash directory.t9806=
-git-p4-options/git
> Doing initial import of //depot/ from revision @2 into refs/remotes/p4/sb
> + cd /home/vsts/work/1/s/t/trash directory.t9806-git-p4-options/git
> + test_must_fail git p4 sync
> + _test_ok=3D
> + git p4 sync
> Performing incremental import into refs/remotes/p4/master git branch
> Depot paths: //depot/
> + exit_code=3D1
> + test 1 -eq 0
> + test_match_signal 13 1
> + test 1 =3D 141
> + test 1 =3D 269
> + return 1
> + test 1 -gt 129
> + test 1 -eq 127
> + test 1 -eq 126
> + return 0
> + grep Error: no branch refs/remotes/p4/master err
> Error: no branch refs/remotes/p4/master; perhaps specify one with --branc=
h.
> + cleanup_git
> + retry_until_success rm -r /home/vsts/work/1/s/t/trash directory.t9806-g=
it-p4-options/git
> + nr_tries_left=3D60
> + rm -r /home/vsts/work/1/s/t/trash directory.t9806-git-p4-options/git
> + test_path_is_missing /home/vsts/work/1/s/t/trash directory.t9806-git-p4=
-options/git
> + test -e /home/vsts/work/1/s/t/trash directory.t9806-git-p4-options/git
> + echo Path exists:
> Path exists:
> + ls -ld /home/vsts/work/1/s/t/trash directory.t9806-git-p4-options/git
> drwxr-xr-x 3 vsts docker 4096 Jan 24 22:20 /home/vsts/work/1/s/t/trash di=
rectory.t9806-git-p4-options/git
> + test 1 -ge 1
> + echo /home/vsts/work/1/s/t/trash directory.t9806-git-p4-options/git /ho=
me/vsts/work/1/s/t/trash directory.t9806-git-p4-options/git
> + false
> + eval_ret=3D1
> + :
> -- snap --

This should be fixed by my change. When that error occurs, the current
version calls die(), with my change it raises an exception, and then
cleans up further up the stack.

-                            die("Error: no branch %s; perhaps specify
one with --branch." %
+                            raise P4CommandException("Error: no
branch %s; perhaps specify one with --branch." %


>
> FWIW I see the same test being flaky in Git for Windows (but it _also_
> only happened once in the past 14 days):
> https://dev.azure.com/git-for-windows/git/_test/analytics?definitionId=3D=
17&contextType=3Dbuild
> and
> https://dev.azure.com/git-for-windows/git/_build/results?buildId=3D49174&=
view=3Dms.vss-test-web.build-test-results-tab
>
> The log suggests to me that there is a path that has not been cleaned up,
> and _maybe_ it is timing-related, but it is also possible that a child
> process is still running that should have cleaned it up.
>
> Are your patches about this failure?

I was actually looking at G=C3=A1bor's report. He has a nifty hack which
makes the errors crop up very rapidly, so I just fixed all of the
failures that arose from that.

It's easy to see from inspecting the code that there are plenty of
other places where this is not handled properly. Probably those should
wait until the python3 fixes have been merged and/or there is some
demand for them.

>
> I see that PATCH 5/6 talks about G=C3=A1bor's analysis of t9800.6 in
> https://public-inbox.org/git/20190227094926.GE19739@szeder.dev/ which
> _looks_ similar.
>
> FWIW I looked over your patches and they seem relatively obvious, even fo=
r
> somebody like me who barely gets to code in Python anymore.

Thanks!
Luke

>
> Thanks,
> Dscho
>
> >
> > This change improves things by raising an exception and cleaning up
> > further up the stack, rather than simply calling die().
> >
> > This is only done in a few places, such that the tests pass with the ch=
anges
> > suggested in the link (adding sleep strategically) but there are still
> > plenty of places where git-p4 calls die().
> >
> > This also adds some pylint disables, so that we can start to run pylint
> > on git-p4.
> >
> > Luke Diamand (6):
> >   git-p4: make closeStreams() idempotent
> >   git-p4: add P4CommandException to report errors talking to Perforce
> >   git-p4: disable some pylint warnings, to get pylint output to
> >     something manageable
> >   git-p4: create helper function importRevisions()
> >   git-p4: cleanup better on error exit
> >   git-p4: check for access to remote host earlier
> >
> >  git-p4.py | 180 +++++++++++++++++++++++++++++++++---------------------
> >  1 file changed, 109 insertions(+), 71 deletions(-)
> >
> > --
> > 2.20.1.390.gb5101f9297
> >
> >
