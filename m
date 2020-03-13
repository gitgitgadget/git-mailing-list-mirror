Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7A3C10DCE
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 17:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFFE6206BE
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 17:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUOKcd1S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgCMRRp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Mar 2020 13:17:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45017 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbgCMRRo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Mar 2020 13:17:44 -0400
Received: by mail-wr1-f66.google.com with SMTP id l18so13036369wru.11
        for <git@vger.kernel.org>; Fri, 13 Mar 2020 10:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=2FGbbdOkST4/Hri069Y2x5iZclEbBqL94x896vAANGU=;
        b=lUOKcd1S5PNWdl6t2fT9GKTWcwvXnBkRhEWY6JZMDzAfMGgzJ6V4mo06NLP0RGzfIh
         GQxW7qlu3yCB9HdgoQxTf8zV2N5V27lw7BGh4qXgdAyD/SgtQwD6CRc09k+CTdORYVc5
         3D3D+D4h2v2uLHauyly7EBI7W37jDxv9aNDWy4LWIMlo9TqN2NWSa9AKiP5JLILJu06Q
         +A5DLdRsurdoCLDLCqoeD8LwMmakrpkA1zaSsZUMaJ1Up5q14injYogc5Y0exvz0jK/J
         OXoTeCVGl/xplrHTbHDuf2s4GwiMUpQYdB58BlI1avWZsxBwuEFmMDeEvNZjqHu9UI7r
         /onQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2FGbbdOkST4/Hri069Y2x5iZclEbBqL94x896vAANGU=;
        b=FSPW6cs47e9h8Ejwe6R817IJmoqLPOm+p6b3i4P8QleYpYjDUpYtGrovDY1F2K0Tsp
         zvCYnhKn1Sv1LZH/XUC+N9kqTNPfZbGcAm0a4QDlmF/ySPXXl3PjA8R2R/fHyII4Pn5+
         N3jbTnTkribnrGWWNyP8WWoFDKKV9gLG0NAecornfO0kJyvYdZ5jx8qiMKc0Nuc/+N8c
         7Ih+iXUu0HG4ibRBZtPDS3lYSXHb7s9rKWQveTfPL+8KJvYjpXXmZ56bOC+zK8wujKok
         PsjNkdT1KRdfU0D9a1v9lkP4IKRZdaK3RM26VW5uaK5dNA8U9vBd8IwJfepv8uIpt6w4
         uSfg==
X-Gm-Message-State: ANhLgQ0sik27l9iFUHF0cqI9uHIZyizxfQ9mo54s8+iQo037OOYkEPFF
        XhQQTQHDMXuZynGDC9UWqtqsxAWf
X-Google-Smtp-Source: ADFU+vsDIdjxxt4ivXHPMI+drrhPKq880t/ldsn8qU45aO2PBgni9BA8y9zuezFEoH6HX/oFyXi8Sw==
X-Received: by 2002:adf:a419:: with SMTP id d25mr19733734wra.210.1584119861969;
        Fri, 13 Mar 2020 10:17:41 -0700 (PDT)
Received: from szeder.dev (94-21-29-150.pool.digikabel.hu. [94.21.29.150])
        by smtp.gmail.com with ESMTPSA id v8sm77864100wrw.2.2020.03.13.10.17.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Mar 2020 10:17:41 -0700 (PDT)
Date:   Fri, 13 Mar 2020 18:17:39 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 4/5] t6022, t6046: test expected behavior instead of
 testing a proxy for it
Message-ID: <20200313171739.GF3122@szeder.dev>
References: <pull.716.git.git.1582762465.gitgitgadget@gmail.com>
 <26d0c34cd1d4a54dab28d0c9c2242336244e8a3c.1582762465.git.gitgitgadget@gmail.com>
 <20200312132032.GD3122@szeder.dev>
 <CABPp-BEa7pvqgH+EytGPp2AO5nBmEgW0+7HnjK-e3MqrBnthnA@mail.gmail.com>
 <CABPp-BGR_eDHJmNOPVQLx8WkL5WLV6J0NtQJ2=AE7CQB2sck5g@mail.gmail.com>
 <20200312200157.GE3122@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200312200157.GE3122@szeder.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 12, 2020 at 09:01:57PM +0100, SZEDER Gábor wrote:
> > > > I saw this test fail today in one of my custom CI builds:
> > > >
> > > >   +git checkout change
> > > >   Switched to branch 'change'
> > > >   +test-tool chmtime =-1 M
> > > >   +test-tool chmtime --get M
> > > >   +GIT_MERGE_VERBOSITY=3 git merge change+rename
> > > >   +test-tool chmtime --get B
> > > >   +cat old-mtime
> > > >   +cat new-mtime
> > > >   +test 1583967731 -lt 1583967731
> > > >   error: last command exited with $?=1
> > > >   not ok 12 - merge of identical changes in a renamed file
> > > >
> > > > The contents of 'out', i.e. the output of the 'git merge' command
> > > > before the failure is:
> > > >
> > > >   Auto-merging B
> > > >   Merge made by the 'recursive' strategy.
> > > >    A => B | 0
> > > >    1 file changed, 0 insertions(+), 0 deletions(-)
> > > >    rename A => B (100%)
> > > >
> > > > This is a rare failure, this is the first time I saw it, and to make
> > > > things worse, this one time it happened on big-endian and with all the
> > > > GIT_TEST_* knobs enabled.
> > > >
> > > >   https://travis-ci.org/github/szeder/git-cooking-topics-for-travis-ci/jobs/661294571#L4020
> > >
> > > This is very troubling.  The workflow is basically:
> > >   - Manually set the mtime to a file to something old (I happened to
> > > pick 1 second before now, but picking something from 1970 would have
> > > been fine too).
> > >   - Run a merge which is known to need to overwrite the file.  Your
> > > output ("Auto-merging B") suggests that we should have been in such a
> > > case.
> > >   - Verify that the file was actually updated as expected.  Since the
> > > OS is supposed to update the mtime when it writes the file, it should
> > > have set it to something recent, i.e. something *different* than what
> > > it had before.
> > >
> > > So, now I'm left wondering how the mtime possibly could have been not
> > > updated.  Maybe the file wasn't actually written?  (But if so, why
> > > didn't other people see the failure?  Or your stress runs not see it?)
> > >  Or maybe it was written but all file contents and metadata were
> > > delayed in writing to disk such that a subsequent command still sees
> > > the old file??  Or maybe it was written but the mtime update was
> > > delayed and the test was able to check it in that intermediate
> > > state???  Or perhaps the mtime check before the merge raced with the
> > > setting of the mtime backwards and got the mtime before it was
> > > rewound????
> > >
> > > I don't have a plausible scenario under which any of these should be
> > > possible; I'm at a loss.
> > 
> > Hmm.  Maybe leap seconds, or clock updates via ntp at an unfortunate
> > time?
> 
> I'm now fairly confident that 'git merge' is OK, and suspect that it's
> an issue with Travis CI's s390x environment (multi-architecture
> support is an alpha-stage feature).

I could finally reproduce the issue on my own machine, so apparently
it's not an issue in Travis CI's multi-arch environments.

>   test_expect_success 'test' '
>   	touch file &&
>   	old=$(test-tool chmtime --get =-1 file) &&
>   	touch file &&
>   	new=$(test-tool chmtime --get file) &&
>   	test $old -lt $new
>   '

I wanted to report the issue to Travis CI, and in order to do so I
turned the above test case into a script that doesn't at all depend on
out test framework and 'test-tool' but uses only coreutils commands
(with a whole lot of GNUisms...):

  cat >timestamp.sh <<-\EOF
  #!/bin/sh
  
  set -ex
  
  i=0
  while true
  do
  	printf "$i\r"
  	i=$((i + 1))
  
  	# set a file's mtime to one second ago
  	now=$(date "+%s.%N")
  	one_sec_ago=$(date -d "@$((${now%.*} - 1))" "+%Y%m%d%H%M%S")
  	touch -t ${one_sec_ago%??}.${one_sec_ago#????????????} file
  	# save its actual mtime
  	old=$(date -r file "+%s.%N")
  	# set its mtime to now
  	touch file
  	# the current the mtime should be different, but sometimes it isn't
  	new=$(date -r file "+%s.%N")
  	test "${old%.*}" != "${new%.*}"
  done
  EOF
  chmod u+x timestamp.sh
  ./timestamp.sh 2>out
  echo
  tail -n11 out

And this script usually fails after a few hundred iterations on my
machine:

  308
  + date +%s.%N
  + now=1584118408.002458987
  + date -d @1584118407 +%Y%m%d%H%M%S
  + one_sec_ago=20200313175327
  + touch -t 202003131753.27 file
  + date -r file +%s.%N
  + old=1584118407.000000000
  + touch file
  + date -r file +%s.%N
  + new=1584118407.997464837
  + test 1584118407 != 1584118407

Note that the mtime update at the end of the iteration results in an
mtime that is _before_ the current time at the beginning of the
iteration.  Well, I'm puzzled :)

> > Perhaps just setting the "old" time to something more than one
> > second in the past would avoid this?

Yes, setting the old timestamp 2 seconds in the past seems to be
sufficient, at least I haven't seen it fail in a few 100k repetitions.

