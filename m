Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0273C10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 20:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 559222071B
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 20:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIGo5edA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgCLUCE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 16:02:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38176 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgCLUCD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 16:02:03 -0400
Received: by mail-wm1-f66.google.com with SMTP id t13so1424556wmi.3
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 13:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kh4RJ97WhlWpCwDfSqKV+kVQyYuQFJaLf0K10R8HMKs=;
        b=gIGo5edA+jQe137VhCweLGXpn4AvJmOONYTKXA1MY1VapWPZQNtwGy590kCNrky5WQ
         xomxG27udH1ZWl9zFhgKo0dd2Qakmv3K+NsE76jZR3fHktqstQXCvzxDOfz3wA2VST6U
         CfH+uHe/kcaSO4PknsTatccgkHh7YoBESJAasw5bpXZvqhGO3xuUeoC/FKjdnKf8blEh
         iPIEy7PJ4oOyS4Cw08Rw7dRWrLSTWT8olNorpXA8XfjZcbzfjupwj2L6xVRJ7Pu6lKSv
         j6lLHs0UlW8TblOKF86XP+PS+qa1vcJZjdnHhiUyFtNQK5HOlgS7RIvT/kpfX7zR4Nxu
         VdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kh4RJ97WhlWpCwDfSqKV+kVQyYuQFJaLf0K10R8HMKs=;
        b=NKTsa3LO5hIUEf+7BQp+pZGWqIfPjsLCNPWNNMYaGY5vmEgVD4v8A7/9KauaELzuAb
         dRJDTdg+EuWEjIpqQ0gTJkH3P0gjPu1x7sy4Masn+71FuhsIV/NytnAvk1+aaU5T2ZhK
         7T75jsrSPeQTsjBuujPhRycQYNPI9f+NnB8PTegRBuFTaTZUA25mPvo4xpqZsF3QXlmP
         mikmCgqt5slIw1crvykbAm7BLID8vB9d+P3uoekynC3aRoDJf1QJB4I4BkxSbOkYhqTu
         qALd1ODPnMaTVqApQitQW4oftN5anQthHLIJ4Vyc2mkuCAiLqBH7Avpe7HBGt7LF6+TN
         poYw==
X-Gm-Message-State: ANhLgQ3IzvytPJplwSff7e2yDgFYb0Mvynen3CUcdUgyVz6q8At9/yTy
        9sehv/YsrmOHhxLq5GqnG9Zu+1mQ
X-Google-Smtp-Source: ADFU+vvTcHGdaSqlDLHIreRlGtg2Fqe4AFROOHRX2HnFgVZ3mL6lBlT49JR25CHz7sw1cvu8+EOAeA==
X-Received: by 2002:a05:600c:4107:: with SMTP id j7mr6363098wmi.169.1584043320656;
        Thu, 12 Mar 2020 13:02:00 -0700 (PDT)
Received: from szeder.dev (94-21-29-150.pool.digikabel.hu. [94.21.29.150])
        by smtp.gmail.com with ESMTPSA id o11sm67761875wrn.6.2020.03.12.13.01.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Mar 2020 13:01:59 -0700 (PDT)
Date:   Thu, 12 Mar 2020 21:01:57 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 4/5] t6022, t6046: test expected behavior instead of
 testing a proxy for it
Message-ID: <20200312200157.GE3122@szeder.dev>
References: <pull.716.git.git.1582762465.gitgitgadget@gmail.com>
 <26d0c34cd1d4a54dab28d0c9c2242336244e8a3c.1582762465.git.gitgitgadget@gmail.com>
 <20200312132032.GD3122@szeder.dev>
 <CABPp-BEa7pvqgH+EytGPp2AO5nBmEgW0+7HnjK-e3MqrBnthnA@mail.gmail.com>
 <CABPp-BGR_eDHJmNOPVQLx8WkL5WLV6J0NtQJ2=AE7CQB2sck5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BGR_eDHJmNOPVQLx8WkL5WLV6J0NtQJ2=AE7CQB2sck5g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 12, 2020 at 10:35:52AM -0700, Elijah Newren wrote:
> On Thu, Mar 12, 2020 at 9:48 AM Elijah Newren <newren@gmail.com> wrote:
> >
> > On Thu, Mar 12, 2020 at 6:20 AM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> > >
> > > On Thu, Feb 27, 2020 at 12:14:23AM +0000, Elijah Newren via GitGitGadget wrote:
> > > > From: Elijah Newren <newren@gmail.com>
> > > >
> > > > In t6022, we were testing for file being overwritten (or not) based on
> > > > an output message instead of checking for the file being overwritten.
> > > > Since we can check for the file being overwritten via mtime updates,
> > > > check that instead.
> > > >
> > > > In t6046, we were largely checking for both the expected behavior and a
> > > > proxy for it, which is unnecessary.  The calls to test-tool also were a
> > > > bit cryptic.  Make them a little clearer.
> > > >
> > > > Signed-off-by: Elijah Newren <newren@gmail.com>
> > > > ---
> > > >  t/t6022-merge-rename.sh                | 15 ++++-
> > > >  t/t6046-merge-skip-unneeded-updates.sh | 89 +++++++++++++++++---------
> > > >  2 files changed, 70 insertions(+), 34 deletions(-)
> > > >
> > > > diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
> > > > index 6f196aaf276..d97cf48495b 100755
> > > > --- a/t/t6022-merge-rename.sh
> > > > +++ b/t/t6022-merge-rename.sh
> > > > @@ -242,12 +242,23 @@ test_expect_success 'merge of identical changes in a renamed file' '
> > > >       rm -f A M N &&
> > > >       git reset --hard &&
> > > >       git checkout change+rename &&
> > > > +
> > > > +     test-tool chmtime =31337 B &&
> > > > +     test-tool chmtime --get B >old-mtime &&
> > >
> > > Nit: I think it's possible to change the mtime and print it in a
> > > single invocation with:
> > >
> > >   test-tool chmtime --get =1234 file
> >
> > Oh, cool.
> >
> > > >       GIT_MERGE_VERBOSITY=3 git merge change >out &&
> > >
> > > Nit: The output of 'git merge' is still redirected to a file, but ...
> > >
> > > > -     test_i18ngrep "^Skipped B" out &&
> > >
> > > ... the only command looking at the output is now removed.
> >
> > Indeed.
> >
> > > > +     test-tool chmtime --get B >new-mtime &&
> > > > +     test_cmp old-mtime new-mtime &&
> > > > +
> > > >       git reset --hard HEAD^ &&
> > > >       git checkout change &&
> > > > +
> > > > +     test-tool chmtime =-1 M &&
> > > > +     test-tool chmtime --get M >old-mtime &&
> > > >       GIT_MERGE_VERBOSITY=3 git merge change+rename >out &&
> > > > -     test_i18ngrep ! "^Skipped B" out
> > >
> > > Likewise.
> > >
> > > > +     test-tool chmtime --get B >new-mtime &&
> > > > +     test $(cat old-mtime) -lt $(cat new-mtime)
> > >
> > > I saw this test fail today in one of my custom CI builds:
> > >
> > >   +git checkout change
> > >   Switched to branch 'change'
> > >   +test-tool chmtime =-1 M
> > >   +test-tool chmtime --get M
> > >   +GIT_MERGE_VERBOSITY=3 git merge change+rename
> > >   +test-tool chmtime --get B
> > >   +cat old-mtime
> > >   +cat new-mtime
> > >   +test 1583967731 -lt 1583967731
> > >   error: last command exited with $?=1
> > >   not ok 12 - merge of identical changes in a renamed file
> > >
> > > The contents of 'out', i.e. the output of the 'git merge' command
> > > before the failure is:
> > >
> > >   Auto-merging B
> > >   Merge made by the 'recursive' strategy.
> > >    A => B | 0
> > >    1 file changed, 0 insertions(+), 0 deletions(-)
> > >    rename A => B (100%)
> > >
> > > This is a rare failure, this is the first time I saw it, and to make
> > > things worse, this one time it happened on big-endian and with all the
> > > GIT_TEST_* knobs enabled.
> > >
> > >   https://travis-ci.org/github/szeder/git-cooking-topics-for-travis-ci/jobs/661294571#L4020
> >
> > This is very troubling.  The workflow is basically:
> >   - Manually set the mtime to a file to something old (I happened to
> > pick 1 second before now, but picking something from 1970 would have
> > been fine too).
> >   - Run a merge which is known to need to overwrite the file.  Your
> > output ("Auto-merging B") suggests that we should have been in such a
> > case.
> >   - Verify that the file was actually updated as expected.  Since the
> > OS is supposed to update the mtime when it writes the file, it should
> > have set it to something recent, i.e. something *different* than what
> > it had before.
> >
> > So, now I'm left wondering how the mtime possibly could have been not
> > updated.  Maybe the file wasn't actually written?  (But if so, why
> > didn't other people see the failure?  Or your stress runs not see it?)
> >  Or maybe it was written but all file contents and metadata were
> > delayed in writing to disk such that a subsequent command still sees
> > the old file??  Or maybe it was written but the mtime update was
> > delayed and the test was able to check it in that intermediate
> > state???  Or perhaps the mtime check before the merge raced with the
> > setting of the mtime backwards and got the mtime before it was
> > rewound????
> >
> > I don't have a plausible scenario under which any of these should be
> > possible; I'm at a loss.
> 
> Hmm.  Maybe leap seconds, or clock updates via ntp at an unfortunate
> time?

I'm now fairly confident that 'git merge' is OK, and suspect that it's
an issue with Travis CI's s390x environment (multi-architecture
support is an alpha-stage feature).

I kicked off a build that only runs 't6022 --stress -r 1,12', and it
failed with the same error on s390x fairly quickly, but haven't failed
in any of our "standard" CI jobs until the jobs timeouted.

  https://travis-ci.org/github/szeder/git/jobs/661647673#L2084

Then I kicked off a build to run the test below with --stress:

  test_expect_success 'test' '
  	touch file &&
  	old=$(test-tool chmtime --get =-1 file) &&
  	touch file &&
  	new=$(test-tool chmtime --get file) &&
  	test $old -lt $new
  '

This failed fairly quickly with the same error on s390x as well.

  https://travis-ci.org/github/szeder/git/jobs/661654844#L1275

So I think 'git merge' should be okay, because the failure could be
triggered without it as well.

> Perhaps just setting the "old" time to something more than one
> second in the past would avoid this?
> 
> Anyone have a clue if this is a useful guess or not?

I kicked off a build where I set an older timestamp ('=-10' instead of
'=-1'), to see what happens, but the s390x job in that build just
doesn't want to start...  (alpha feature? :)  Anyway, the job's output
should eventually be available here, will try to check back tomorrow:

  https://travis-ci.org/github/szeder/git/jobs/661657781

