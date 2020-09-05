Return-Path: <SRS0=od8b=CO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AF6C433E2
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 19:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB39A2074B
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 19:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hra/B978"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgIETIi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Sep 2020 15:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728397AbgIETIg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Sep 2020 15:08:36 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30DEC061244
        for <git@vger.kernel.org>; Sat,  5 Sep 2020 12:08:35 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d22so6438590pfn.5
        for <git@vger.kernel.org>; Sat, 05 Sep 2020 12:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CCmnYQSHPhxL/k54JFmWDhbKTZ+REUAX3oG/4fqTOoM=;
        b=hra/B978Bhw9KDyy7FPLf9keTlb02PlXw4Yd81w/mD1FxcZnRL/G+hqbJiaesYx/Y/
         1/iNNg6FlAxVbYBIAihHegTV9+s/RthzcpF9aTmfH/3ngXOzyuvnfXDTTlrPEomstQKD
         BFqGKQwgmHQ2Xg2lmFot3LphhbJCZiRPgKxu6FKGAu9RO9RBsOS29BlG42stE6yDzysc
         3tx2DDD89q7tZqVbAtjSJS71W411uka39CVCSp+gdm1/UJ5vkiwjyHmUF2Zpl4fAWYAZ
         t0aKOUbjsvan4i5nNNzbufEdT5SbPdTruhPaeP8nYVNT3RI35AUSXrAIJTPY8Ez8W2MU
         +HIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CCmnYQSHPhxL/k54JFmWDhbKTZ+REUAX3oG/4fqTOoM=;
        b=PA0Cz7N0pAQpS/oTcHGHbgtg3GrfhsX/3OBOTF3zLEvZ8KcMesFKxa2bXJmUQfmyP3
         qUD6Pd84fxByA4wCBJCYqVdiG4wlAAfDSChtT3rwCwkkR6bQdiOgOH1Xvdc6vWQnzG0Y
         EUIxae6bXI0ox7XOG+NNorQmInMcgNL/kEJsG2It59otgUua+Ev00u/rBHMXadp7I13Q
         UA9tOBMsM5ap4j9JMYS+fR1QWM/ebVtTqIWficaxibzQpV4P+MUgNzxPruJY8dJhXBZV
         akfDqnsddL/MNaFZ9j9ttPZSVW6o5IOExL6BHVOMxnKbW8cNywaFXb1U0XLH3BA79ObW
         E1/A==
X-Gm-Message-State: AOAM531VehZ8Kx/xn0+Qd8BmCDm1swUrVsFhUKBO1F1i8lmAPnixerb2
        LamCWJIIQ9a8cPzQ5I0IH9Wpt+oGh2c=
X-Google-Smtp-Source: ABdhPJxcydZ1Ba4THz+jCqA3RP8yEoXhKwS9pYMu/nXM2Fu9ZovLM3TNKTIl7u6ghV9SdICbQBIO4A==
X-Received: by 2002:a62:b60f:: with SMTP id j15mr7037046pff.260.1599332914589;
        Sat, 05 Sep 2020 12:08:34 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:5900:d670::1ab5])
        by smtp.gmail.com with ESMTPSA id u5sm3045459pfh.215.2020.09.05.12.08.33
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 12:08:33 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 0/4] builtin/diff: learn --merge-base
Date:   Sat,  5 Sep 2020 12:08:17 -0700
Message-Id: <cover.1599332861.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.rc0.135.gc7877b767d
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The range-notation in `git diff` has been cited as a mistake since diff
compares two endpoints, not whole ranges.[0]  In fact, the ranges seem
to take on the opposite meanings when compared to range notation in
`git log`.

In an effort to reduce the use of range notation as much as possible,
introduce the `--merge-base` flag, slightly modified from a suggestion
by Jonathan Nieder.[1] This flag allows us to replace the first commit
given on the command-line with its merge base between the first and
second commits. This allows us to gently deprecate the `...` form
entirely, although that is left as an exercise to the reader ;)

One additional bonus is that this flag allows the "after" side to be not
just constrained to a commit (like with `...` notation). It can now be
the working tree or the index as well.

[0]: https://lore.kernel.org/git/xmqqy2v26hu0.fsf@gitster-ct.c.googlers.com/
[1]: https://lore.kernel.org/git/20191223215928.GB38316@google.com/

Denton Liu (4):
  t4068: remove unnecessary >tmp
  git-diff.txt: backtick quote command text
  builtin/diff: parse --no-index using parse_options()
  builtin/diff: learn --merge-base

 Documentation/git-diff.txt | 40 ++++++++++++-----
 builtin/diff.c             | 92 +++++++++++++++++++++++++++++++++-----
 diff-no-index.c            | 15 ++-----
 t/t4068-diff-symmetric.sh  | 89 +++++++++++++++++++++++++++++++++---
 4 files changed, 197 insertions(+), 39 deletions(-)

-- 
2.28.0.rc0.135.gc7877b767d

