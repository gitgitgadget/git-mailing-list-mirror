Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57B171F462
	for <e@80x24.org>; Sat, 15 Jun 2019 01:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfFOByl (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 21:54:41 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:39960 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfFOByl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 21:54:41 -0400
Received: by mail-lj1-f182.google.com with SMTP id a21so4135539ljh.7
        for <git@vger.kernel.org>; Fri, 14 Jun 2019 18:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=MH18kHYf63ViVJAm5KNStEzFpSggtkKM7s7hosIftms=;
        b=C4yeIFr2xgf2TiLkxq+OGo6bid2U/nvVjtM+LdXA6DIWN8o6f0chRiFoGHGo/RcnoV
         3iUtLD//csSwjy51xrV1rAYCMRrYSFrDMsHylwiUQ4XaKB1aT+y/HuUxibTjBAaHo4EI
         oIfmgmqmg2GilND2nki1+TI1fh0qEnI7jOCPdOZulkdiVury8es9xWXuXoaDudgMHUIm
         X57sjp/84qnXmP+rW2NS7zXPJ4TejfZKN0ZTz60Wsen+8P+fa+r+q2T0RFsmxyzARIvG
         7EnlYNPPS7zfBzd4w1MBp5I/12YT5PvewhjM7kCnmoWorP4nWPqP0i77nn1JfGb8OAvr
         RriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=MH18kHYf63ViVJAm5KNStEzFpSggtkKM7s7hosIftms=;
        b=poKG5p+SrCri6F9qTxv5han+mhs0h7sHEkGSYBQXuH7sgjzreVVNbVmdsZLSMO88wR
         Y2X7D8bi1M/etgiH/HxcMpQ8v23z9Kcs98O4mY+u8BAYF8KuosypUS/CJKPZA+PkdVh1
         Y2Q045BeRyn7DxOOKgSG6ExRYFWTa7JvB7gpV71+EEsWJU7nrqJ/NvVPWQq5aCv8+XnY
         7IztBjzyTyUIbKKQ8P9nvIlrTi7wNEOYatQ6T0ke90s4rTge+veNq554d9QhkUolV84a
         UyZ4+EiXSOdEl1cqcC4vxCx3KEA+R6QwGljXpY4HlNYI+m3sJpD0aL4pWa+IeLHV4z4Q
         E5yg==
X-Gm-Message-State: APjAAAVO5HlOP5d9xfChGYIofrQqJHmXDC8iu4WsFJY01GboHt4l8jEI
        tJHlPKjo/3+LBHU37DBTISRsFXs7/RHPmBxbw4QD1yUne4U=
X-Google-Smtp-Source: APXvYqwtx94uSkgXY/SuHkcvIfgDjUJzR9dcBahriAmNV07/db1SDUSzF7AjKG6EQjfWOsjwh6FJfs6Lcve1sfKK8T4=
X-Received: by 2002:a2e:6e01:: with SMTP id j1mr51882976ljc.135.1560563678431;
 Fri, 14 Jun 2019 18:54:38 -0700 (PDT)
MIME-Version: 1.0
From:   Phil Hord <phil.hord@gmail.com>
Date:   Fri, 14 Jun 2019 18:54:26 -0700
Message-ID: <CABURp0poUjSBTTFUXP8dAmJ=37qvpe64=o+t_+mHOiK9Cv+=kg@mail.gmail.com>
Subject: Deadname rewriting
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I know name-scrubbing is already covered in filter-branch and other
places. But we have a scenario becoming more common that makes it a
more sensitive topic.

At $work we have a long time employee who has changed their name from
Alice to Bob.  Bob doesn't want anyone to call him "Alice" anymore and
is prone to be offended if they do.  This is called "deadnaming".

We are able to convince most of our work tools to expunge the deadname
from usage anywhere, but git stubbornly calls Bob "Alice" whenever
someone asks for "git blame" or checks in "git log".

We could rewrite history with filter-branch, but that's quite
disruptive.  I found some alternatives.

.mailmap seems perfect for this task, but it doesn't work everywhere
(blame, log, etc.).  Also, it requires the deadname to be forever
proclaimed in the .mailmap file itself.

`git replace` works rather nicely, except all of Bob's old commits
show "replaced" in the decorator list. Also, it doesn't propagate well
from the central server since `refs/replaces` namespace isn't fetched
normally.  But in case anyone wants it, here's what I did:

git log --author=alice.smith --format="%h" --all |
   while read hash ; do
      GIT_EDITOR='sed -i -e s/Alice Smith/Bob Smith/g' -e
's/alice.smith/bob.smith/' \
      git replace --edit $hash
   done
git push origin 'refs/replace/*:refs/replace/*'

I'd quite like the .mailmap solution to work, and I might flesh that
out that some day.

It feels like `.git/info/grafts` would work the best if it could be
distributed with the project, but I'm pretty sure that's a non-starter
for many reasons.

Any other ideas?  Has anyone here encountered this already?
