Return-Path: <SRS0=E3tc=7P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BDDC433E0
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 19:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A63712074B
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 19:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcSmvbpU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgFBTV0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgFBTV0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 15:21:26 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C84EC08C5C0
        for <git@vger.kernel.org>; Tue,  2 Jun 2020 12:21:25 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id e8so1954355ooi.11
        for <git@vger.kernel.org>; Tue, 02 Jun 2020 12:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=YpIFREdAE88dN87RMr6DlroEh4klu901a3Q03mOwG0I=;
        b=AcSmvbpUfpdBRbKBQ95+Mnj6rfBmPURsVs2/w1yuEdoYFNMsvqdl0cj2tjE6uefH4/
         yVw3td0llohsoptH2tuMJ3B4Wm1sxwEEDC1hdsAl7cTCQUJN+dn/+A8PNNyDY7sH38Zl
         amUegZODqUMfbW30mwJCR87dvznAAalGwMzMIP82NuCJQADs/AmjiIyQ5RRtwCEpqBOw
         RHD5HdzoeNvE4O80OZ+ial9W4uuNr0rFs7se0waqNtptppNkNMM9rRg+y+HICpF8/k18
         SRnR1MxqGjhYcMfJjT7PNmoHDhZU3qnJD38eqwZO0kvVxxVIe7zVrR0MTp4f2M1MVfaD
         MExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=YpIFREdAE88dN87RMr6DlroEh4klu901a3Q03mOwG0I=;
        b=Ar6f88o6CnzNJ1Mxo8JSth0tb6as1If0HFtvUCx5rhOIAtDi5RHkoF4JQ0OLiHh6R5
         lw3q+mdUNF+9+a/2b/0kkuiPyyEzyfX+MrkVgU/8WR1yOoJ2ELBm0f9zRJVsC3KvL7AX
         rLgR5IXYVqx3RcJIBCX5HZOhSF/nzfEkyd9PunPR/0RAAQwA2vyNcAPU8kCXBwc699YL
         ec7dblyyYcEApDDILjnzOIdKSCBbzJ4OtzeMnshZOt4j+spGaTdjtvhXf3Vwi14USOfl
         SdVdOz5WF5K44dOKXdn9FGr2Oyx1SFK7Gzp9FGgx0AiTk1aAkdeikiZZgdWSB+hCHwRC
         6nzQ==
X-Gm-Message-State: AOAM532MBAPdNJarPY6X3goIBAj+CVlBd9LUamkJ+YJULxF/9NAuTqPA
        cGSe/iBSfBiPiRX8MN74UDGdipZGweNqagF4BFFAzTuyxhM=
X-Google-Smtp-Source: ABdhPJzVTTkHmhTss19RVnDDOD1chssK31G3/PUCldy+szNpdgP47hxgJAs4hOXXRKu07ZokmRsjWnsio5TJWUGuTCg=
X-Received: by 2002:a4a:91c2:: with SMTP id e2mr21607113ooh.45.1591125684539;
 Tue, 02 Jun 2020 12:21:24 -0700 (PDT)
MIME-Version: 1.0
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 2 Jun 2020 12:21:13 -0700
Message-ID: <CABPp-BEswHLhymQ1_07g3qqu=7kFR3eQyAHR0qMgSvi6THy=zQ@mail.gmail.com>
Subject: Huge push upload despite only having a tiny change
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I had a user report that two nearly identical pushes (the second being
an amended commit of the first) took dramatically differing amounts of
time and amount of data uploaded (from 4.5 seconds and about 21k
uploaded, to 223 seconds and over 100 MB uploaded).

I'm curious if this might be a known issue; it sounds similar to some
push protocol discussion I remember from the contributor's summit (but
I don't know anything on the protocol side and tend to work on other
things during protocol discussion).  If this does sound like a known
issue, does anyone have links to some relevant discussion I can read
up on (and perhaps pass long to this user)?  If it doesn't sound like
a known issue, what other things would be useful for me to dig up?

Additional details:
* Both pushes involved cases where the user had a single commit that
the server didn't.
* The parent of the commit that needed to be pushed was the same in both cases.
* The commit in question was small; modifying either 13 or 15 lines of
two files that were each less than about 8k in size.
* The user was pushing up a new branch each time, but the new branch
was closely related to an existing branch (i.e. had all but a few
commits of history in common)
* The user was two commits behind the closely-related branch at the
time of the first push, and 10 commits behind at the time of the
second push.  Running format-patch on these 10 commits that were on
the server at the time shows their size is at most about ~55 k.
* The server has a huge number of refs; about 470k of them (most of
them related to code reviews).
* The server was running Gerrit 3.1.4 (i.e. jgit).
* The user was using a version of git based off master from a few
weeks ago, in particular, with a few changes on top of commit
b994622632 ("The eighth batch", 2020-05-08).  I don't think the few
internal changes could affect anything here, but those changes were:
(1) making features.experimental default to true (which only turns on
two fetch settings as far as I can tell), (2) making
merge.directoryRenames default to true, and (3) setting a few trace2.*
config settings by default.

Thanks,
Elijah
