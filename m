Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F09C43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 01:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEED42063A
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 01:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=atlassian-com.20150623.gappssmtp.com header.i=@atlassian-com.20150623.gappssmtp.com header.b="udqNufGz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732537AbgDBBQC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 21:16:02 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:35052 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732435AbgDBBQC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 21:16:02 -0400
Received: by mail-io1-f50.google.com with SMTP id o3so1923876ioh.2
        for <git@vger.kernel.org>; Wed, 01 Apr 2020 18:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cEpMeJkALfZ9ZALzvFaXUqkWL+Fq/tvpkwqih9v0KYE=;
        b=udqNufGzFgCLVeFj/qu3IL11isXYpzqBcJLeL3bS8LDxJPMzyzVOTc1LYkWsdKRArT
         0EEz+8vq+RoLmVavt4sqOvi+9NYk6Eodl/wVraEegFfojiYFJ57jJ+53AW0gmXnXxT1J
         48Q9T1V31YdHK0A3cu4+ahxoJ6+NRixA2kHj/c3CQI9n1OkeptMAI5gHhlf1y1YL+vJB
         SI9e6G77LAksdZvYnDpMV2RIR1I2aaGUXDJuzhX2oxQQRjCXIOJI40FNtYIYnB5JEQ7d
         u8PX0tij7zPCZ2IQBguHysA1YkmHQS/iH6s3AmnLosox2lZFwrImlb5zEIeQ/YjIVxCN
         0QAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cEpMeJkALfZ9ZALzvFaXUqkWL+Fq/tvpkwqih9v0KYE=;
        b=AlhhOEWUT3icK6/cQ4wNTdCwuaTz5yyZZlTZ599+BJkZDld2p7UWCvo1vbnN5V9BmR
         6zg5XS1SixR+/mdH79A4O5xy+9WKuDIhyOIGBZRc6EcVgIPIOkp6fC1ti2bwR2Eyye4+
         IDcesj9ryl7HF8oP8Iucqx4Cy56UU+t8YuLtrrgPmBjIoqmqgo0llpkjJfm99JYmINrK
         ogDVvZCWiqUqVOwN2/GZ6z7HqV6pLULJO7MYHtbXg8Lh9CuQ5p2o7nc6PvNOAHDO6lrF
         NBFTykjul5LNfay5ztpQ6m2aBZm0wAJyVdzf/HGiH6zU97SnuBDxKUgdqn0uF0IXQDTm
         Macg==
X-Gm-Message-State: AGi0PuZOwQw1yQ2leF/D8BQ3XWIGFmLSfIWvnzvDLO59KcAmq5hF7+l5
        YaSqhdU8Sden71z3PPo9RGpiJqRCKgXDK0rcP7mygQ==
X-Google-Smtp-Source: APiQypLJV+JtRmw7xGL98w75lWedRCXj2n2GbnERB/bk0tmk8ogn/Jbd7UtaupHSlrIkrfKdfr52appFnvtyk+bxpjM=
X-Received: by 2002:a05:6602:2e95:: with SMTP id m21mr606738iow.110.1585790160465;
 Wed, 01 Apr 2020 18:16:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAGyf7-FUjCefwGjvCcwmjO=GADd5S0cU_=S_tVy4nMaj07+rQA@mail.gmail.com>
 <CABPp-BFDx2j5Kf584Myb6wuEq5G7wbogJ2vos8OTDsh+ySfk8w@mail.gmail.com>
In-Reply-To: <CABPp-BFDx2j5Kf584Myb6wuEq5G7wbogJ2vos8OTDsh+ySfk8w@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Wed, 1 Apr 2020 18:15:49 -0700
Message-ID: <CAGyf7-FTNOgDbWEoniaOWueWGXwH6=0gj_FzDqP35422vxhYEA@mail.gmail.com>
Subject: Re: Rebase-via-merge behavior difference between Linux and Windows
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 31, 2020 at 11:35 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Tue, Mar 31, 2020 at 4:25 PM Bryan Turner <bturner@atlassian.com> wrote:
> >
> > Using our merge test repository[1], one such test performs the following steps:
> > * Unzip bare repository
> > * `git clone --shared -b branch_that_differ_by_empty_commit_trgt
> > <unzipped> rebase-test`
> > * `git rebase -q --no-verify 7549846524f8aed2bd1c0249993ae1bf9d3c9998
> > 298924b8c403240eaf89dcda0cce7271620ab2f6`
> >
> > 298924b8c40 is an empty commit (i.e. `git commit --allow-empty`), and
> > is the only commit not already reachable from 7549846524f.
> >
> > On Linux, when this test completes, "HEAD" in "rebase-test" is
> > 7549846524f because the empty commit was discarded. This is the
> > expected behavior. On Windows, "HEAD" is a new empty commit, which
> > causes our test to fail.
>
> I don't have a Windows box to test, but it's good that you are seeing
> the correct behavior there.  I do have a Linux box, and cannot
> duplicate the behavior you state, even downloading the zip you
> mentioned and following your steps to reproduce.  Actually, I did
> reproduce that behavior the first time because I was accidentally
> using git-2.25.0.  But with git-2.26.0 on Linux, I see a new empty
> commit after rebasing, as expected.
>
> Is there any chance you accidentally ran with an older git version
> when on Linux?  If you really were using git 2.26.0 on Linux...then
> I'm totally confused at how you got that behavior.

I went back through our build logs and confirmed that we _are_ running
Git 2.26 (phew). I then set up a local Git 2.26 environment and...it
produced the same new behavior as 2.26 on Windows (so the correct
behavior, per the documented changes).

At that point I dug further into our builds and found that while we
were using the right Git version, we _weren't_ running all the same
tests on Linux and Windows. So the successful build on Linux was not
because the tests pass--I've adjusted the builds and confirmed that
the tests _don't_ pass--but rather because the relevant tests weren't
being run at all.

Very sorry for wasting your time, Elijah. I should have looked into
our builds more closely to verify they were running the same tests
before I took the question to the list.

Best regards,
Bryan Turner
