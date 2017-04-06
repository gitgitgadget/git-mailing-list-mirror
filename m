Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B85771FAFB
	for <e@80x24.org>; Thu,  6 Apr 2017 20:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753821AbdDFUcS (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 16:32:18 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:34349 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbdDFUcR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 16:32:17 -0400
Received: by mail-oi0-f53.google.com with SMTP id d2so65174682oig.1
        for <git@vger.kernel.org>; Thu, 06 Apr 2017 13:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Qn2qEy3Jt7z2Jn/2yosnF6vobzmfLY5MZCXcuYOxD5Q=;
        b=ecfiBa7s6CvU15XesjYGw1kaYS2Qc26rnWy8LnoBl2U0+JPTfxqDFAuEm7gGTrBpME
         QDna16duQVLgucajJL2Kw59peCY6ynAIqNajTGhbz5yQ0xHJC9st48997NNlxtbVAbA7
         jJkNcbnqytO5VJPlO2bPRg0BXiQ3dqnX+bLuCqfOPIn259T8nmiRcr73V4NK9pBy9+sJ
         nIcl02Vgu4FeFL0+ZVWuV05vlEPg7F8RrAA4grVWE5KDmORQuUeoN/BypvOCMaOxSaDj
         IE6PJdhDC/27sv+yu9p7AFqeFPKa5cyIBIt5bqNKSyPr1hg3Mkjz17hVVGVJ/J/otqpd
         m59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Qn2qEy3Jt7z2Jn/2yosnF6vobzmfLY5MZCXcuYOxD5Q=;
        b=jvuP6rmHadz3ES4vphLw4972hTuNCPlp2j2ejIdUrIPPe0aMGz/I4JZwRSG1bFJQZF
         IJyLUiAPR9HKTUsUPaDol8A1UqMuEP7JKpdZynX5RpgD7/2bP6hrmHCE2NKt8nPavIRQ
         LH8OiREx4MPxyNP3JjdOQehtGJbCYT/p7GiucSmy7GQScPUY6K/KY3ym76/NlgLg4BtQ
         ld1KjS0nMR1dzkUx55DTabAOkxV4DsQZZR/artwYBZsq04yfrVS+gGOhmfVHhuDobT/i
         O7jiBdR6Fr79AHlvil/1Lz70Vw3U/PrEU9KQ5tnfibwG8tqrfBGjAikGPTwguWBe2olF
         6GMQ==
X-Gm-Message-State: AFeK/H1ulQl82sYvEB+IEWxsRxPq5FbN+p4zg5L2Gx7BPiV/A9Nl8po4rSdNcOvt4tcyeCsx/4M2DrbdsFgKIQ==
X-Received: by 10.202.86.12 with SMTP id k12mr17431111oib.150.1491510736113;
 Thu, 06 Apr 2017 13:32:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.25.7 with HTTP; Thu, 6 Apr 2017 13:31:55 -0700 (PDT)
From:   Javier Domingo Cansino <javierdo1@gmail.com>
Date:   Thu, 6 Apr 2017 22:31:55 +0200
Message-ID: <CALZVapk4zxn-DSdMdy2q-Z0KvsBvx4MCSB5UDVOaBrBvAqw_AA@mail.gmail.com>
Subject: Git branch deletion not based on HEAD branch anymore
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I have noticed that in the "latest" versions of git, `git branch -d
branch` instead of refusing to delete a branch that hasn't been merged
to HEAD, it now throws a warning and deleting the local branch if it's
present in a remote.

Example:
```
> git branch -d command-runner
warning: deleting branch 'command-runner' that has been merged to
         'refs/remotes/origin/command-runner', but not yet merged to HEAD.
Deleted branch command-runner (was 1716ed5).
```

After diving in git blame for a while I have realized that "lately"
refers to a commit done in 2009.

Because the change is over 7 years old, I will explain what is my use case.

The workflow I follow since I started with git is to start an exact
replica of my working environment in a personal fork. Anything deleted
locally is deleted remotely and viceversa. This allows me to move
between work and home smoothly. I also use the default `git config
push.default matching`

My typical day starts and ends pulling master from the central repo,
and `git branch -d`-ing  all the branches I have in local. git would
delete the ones that have been merged, and leave alone the ones that
have been not been merged. Then I rebase all my branches and push the
new master and rebased branches. Because all my local branches track
my personal repo, all of them get deleted if I execute my scripts.

I understand it's not possible / convenient anymore to go back, but
would it be possible to have an option such as `--merged` to support
the old usecase?

-- 
Javier Domingo Cansino
