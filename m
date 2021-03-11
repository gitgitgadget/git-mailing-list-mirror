Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F2CC433E9
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 20:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ED6664F92
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 20:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhCKUTg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 15:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbhCKUTS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 15:19:18 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E999C061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 12:19:18 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id z9so550339iln.1
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 12:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=KldTajwZjeoz82xMUEE56I9sjBI6jZAhLVjJJj5co+k=;
        b=P1Z7msSe+uIHerV10HYNA+Nb1TC9yDp4CGbeTy1zNz9dOtnNCWLlb2VbNuk4OTpHgU
         V9F5jpicvggdGq3FAGilbHWXCc2teV6JpcGWazuV87P7SWhjX4n4cRLiDlV5Mwe9P07P
         vDl5YulRZ0rOaaQu6PRn6mUQs3LcMqNBSBSL6GimW5WNtI2/9iNBOCfiCWi8sivWxVMk
         RSovLawVPmmSRhdKhDgaWFaudioXCn3MbFJUZKjSPBKG5j265gr+mjjhwroTUGHihIX0
         cnmneWHlw53uw5q0soUquVoVoBH4VArttbFc7k7U3WaTM7jx0QcRJp9wfunFg7meK6/S
         9klw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=KldTajwZjeoz82xMUEE56I9sjBI6jZAhLVjJJj5co+k=;
        b=hD/Wm3oOocJ2TOgHIYBLokOzGhaBAFhdvDURwHob20IVZbnFY4ditIeVI5vwK3SiA5
         rtnLmThvMPZn4ev0P1pFrlMWwzsFmGbQ/YGTAbGaELkLPBSHZi9hg8MHQbji7OjEPBN5
         0T4xiGHMI9XkOOKmYRFdOCQ8oRVQlHN4G7P1l28RJB4UUTbPArfiZEUJ9rkkamtb08Xy
         raWNfFd/PQBJFVvxeyfIpdGNyZJLCTK1qVSsQjiLN6f3SrfRypqC68XTTshQOZfMglTg
         SE5/dAuunwcgChVwKg2eX9aL8prM5C/cZEvnT730i+IPmGI0SpUrSpNOs9Z9TBh+n5LE
         nS3g==
X-Gm-Message-State: AOAM5305URz89gr6yiRWsA47sbgBx/1Lf0bhaZG0sWUaSQ0sk00eRQVO
        a4D2sZiI9JLHKRuJEywduZaM6NGtAotP/HzyxxT0fkL6Av9VcA==
X-Google-Smtp-Source: ABdhPJxi0PH9D8w3bN7LuByqhxyCC89qzjbZFRzt2LRpD5r970Qd7DyqthkkJBDxvLFG7dcvg+hdj04gll/aX/Lnl64=
X-Received: by 2002:a05:6e02:152f:: with SMTP id i15mr160998ilu.277.1615493957848;
 Thu, 11 Mar 2021 12:19:17 -0800 (PST)
MIME-Version: 1.0
From:   Mustafa Zengin <mzengin88@gmail.com>
Date:   Thu, 11 Mar 2021 12:18:50 -0800
Message-ID: <CAJ-1jP7fy95V5ROj0gE3UC9zn5f=8pTTGy1Y7cwQtx7DidEhqw@mail.gmail.com>
Subject: git difftool -I and git diff -I behave differently
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

git difftool and git diff behave differently for option -I.

Repro steps:
1. Add a line with "text" into a file (without the quotes)
2. Run
  git diff -I"text"
3. Observe that no output is returned
4. Run
  git difftool -I"text"
5. Observe that the assigned diff tool is opened with the change
including "text".

Expected:
In step 5, no diff is shown.

My expectation is based on three things:
1. -S and -G options behave the same for `git diff` and `git difftool`.
2. Quote from https://git-scm.com/docs/git-difftool
    "See git-diff[1] for the full list of supported options."
   It implies that all `git diff` options are inherited to `git difftool`.
3. It looks like the command is attempting to parse the option so it
is not completely ignored. If I make the regex malformed, e.g.
     git difftool -I"*text"
   I get back:
     error: invalid regex given to -I: '*text'

StackOverflow post:
https://stackoverflow.com/questions/66574689/git-difftool-with-i-option

Versions tested:
Windows: git version 2.30.0.windows.1
Ubuntu: git version 2.30.2

Thanks,
Mustafa
