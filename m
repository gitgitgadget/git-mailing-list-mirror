Return-Path: <SRS0=LMRs=AT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	PLING_QUERY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492C7C433E0
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 23:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E96E20772
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 23:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrVR0aJq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgGHXDy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 19:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgGHXDt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 19:03:49 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DA1C061A0B
        for <git@vger.kernel.org>; Wed,  8 Jul 2020 16:03:49 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id g13so281248qtv.8
        for <git@vger.kernel.org>; Wed, 08 Jul 2020 16:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:subject:message-id:date:to
         :mime-version;
        bh=DBh/YoF42aAb6sbMpc02FJpBBamkq8sSqna8vsMPHxI=;
        b=jrVR0aJqJGWkYSOOJUDTvfU9IweTm37IX90ESxDYDNzCM9h1nXXflEu2Wc5suwGgqQ
         SjMYsRkIu/2xeb/OKrHyvWREbPRHwUCzHffxpt/r3E3mPA+QDHOzbL73Lg77+P7Ur9ER
         MuSEB4LXSdSYuIS4VK1wLmHvompz+N+blInJqH2s49iXS7gVq1+YLsW51GyaF3vbt/KQ
         YbeIVHnYVz0JTmccGasWGjNz32h+7g6owV2tsinkS6wBiA/ZGjKZDfh5nV+DB2WReGPC
         9rhWpdIe0Hg0XnY/f0C6k1jOsxciDqOLrTavslWmzPPUOGV0zz6A08Xd2fwT95W8eTEE
         /unw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:subject
         :message-id:date:to:mime-version;
        bh=DBh/YoF42aAb6sbMpc02FJpBBamkq8sSqna8vsMPHxI=;
        b=UYlGOjbxW9NCEarCMNcJ3WlHyt4QS04RH4KE7tI96QvwK/nGzBcw/zO9aimFufc/1y
         oprWkoDiyJQr4IEDuuMG/spoz26sf1DniUnR4oIs64FDi17VlU47HdNNIQMBhCaGkrHO
         d8VSlCWDIIdhXw2z3X8VMiPxp5qi8C5GAdithe6SI3w5xU2glQAS+sff2hh1QcJv7FeC
         I1U+OvLHlv0ZVSnE99TfbMEvKp/qp0ADi4vafOLvLcgApGNz/l/uTf6r+WjDeTBMoLVw
         BYirFtK7sGGgoYZQQSxdsL3G1haNQMHwJhkcboM/3CA4ExWFxQZMsEBLe2cdtFF1RiIE
         VO4Q==
X-Gm-Message-State: AOAM530v5FZatswvJf450pK27+LSgghTLdB7DIbXcKguD3Xu99uhbPzF
        J4J8lBVD6AntlC9Z8W1hSmB2MGHA
X-Google-Smtp-Source: ABdhPJylmMGhmAZ9xSa4caqDe7+6Ipyk/m6GhV5I+e7CKQn/WsRt+Mp2kJJjK4Zv0tqWLFWMlKY9VQ==
X-Received: by 2002:aed:2a75:: with SMTP id k50mr60579517qtf.27.1594249428225;
        Wed, 08 Jul 2020 16:03:48 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id y45sm1446364qtk.19.2020.07.08.16.03.46
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 08 Jul 2020 16:03:47 -0700 (PDT)
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: rebase - "fixup!" conflict applied at the wrong code location, why ?
Message-Id: <7A30EA48-72E3-47E1-9792-136D7B96DC84@gmail.com>
Date:   Wed, 8 Jul 2020 19:03:44 -0400
To:     git <git@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I've been working on a branch for a while. I've been using `git commit =
--fixup`  and `git commit --squash`
when I noticed that I had forgotten to add something to a previous =
commit.
Today I did `git rebase --autosquash` to clean up my history, and the =
rebase failed at the
first 'fixup!' commit with a conflict. However, the conflict is not =
located at the right place=20
in the code (it's not in the right subroutine!). This is very surprising =
to me, and I would=20
like to understand why it happens.

Steps to reproduce:

git clone -b branch-to-be-rebased https://github.com/phil-blain/CICE.git =
cice
cd cice
git rebase -i --autosquash my-first-commit
# save the todo list without modifications
  Auto-merging <file>=20
  CONFLICT (content): Merge conflict in <file>
  error: could not apply e8bfa55... fixup! <commit message of f4e1ae6>
# the rebase stops at f4e1ae6
git diff
# tangential question : for some reason the hunk header does not appear =
here, I don't know why...=20
git diff -2  # but it appears here
git grep -p -e '<<<<<<< HEAD' -e '>>>>>>> e8bfa55...'  # or here
# ok, the conflict appears in subroutine 'picard_solver'
git show REBASE_HEAD -U5
# but the original "fixup!" commit only modifies the subroutine =
'anderson_solver' !!

I would have expected that the conflict be created around lines =
1118-1132=20
(line numbers in f4e1ae6), in the 'anderson_solver' subroutine.

I don't know if this plays a part here, but commit f4e1ae6 (where the =
rebase stops)
is the commit where the 'anderson_solver' subroutine is added to the =
code...

Thanks,

Philippe.


