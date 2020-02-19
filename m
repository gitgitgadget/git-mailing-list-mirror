Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79680C34047
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 16:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D16420675
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 16:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4LbLU4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgBSQOC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 11:14:02 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55427 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgBSQOC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 11:14:02 -0500
Received: by mail-wm1-f65.google.com with SMTP id q9so1270110wmj.5
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 08:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C/7RGLONgc2bAI+tF57ksrBr6rZyMExcywPUb14oKZI=;
        b=l4LbLU4tUBkI8hfP3np0K+jQUnXbhX78UDAN4pxCGI7xaYFbvGJD56Bd8TZAuc3DNx
         xSAfArK/vSvisGOFb+rr87vBKfJL0jsn85lxDt8u0puYYpto+OIjJu35wA9ljSOflIJb
         4zg6Ie4NjRQEVsAE/uzgLrfIougP191TXLwrQAzdaJFLjIHQ+xZX5B5qJ6y1+lVlMewh
         vDXkv7oECww3LR/SYLO8Cscl6NeaocRDT4nlmcN1rz5gFV3mjqoVQYroHjhYlF2nJjpJ
         4Q3S9z3M+c2ITPlw/bS0QGDk5P0pAgQEXi6KsqaTcrX0NKRCZtLtSm6QGDLk2pSu2/6J
         29oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=C/7RGLONgc2bAI+tF57ksrBr6rZyMExcywPUb14oKZI=;
        b=TceIE3c3FxppsVOWFLo5J8nMsFdc5CQyndxnlCgYZcR+r7J1k3KPt7SPLRp3r0s2Dl
         vksevWqLLeTNWYNp+mJL1fdzGkB4I7WZjNrrBJJsq0tmAKyGhDD9bNP7VCivVfFllFr2
         YlyRykTBCXcNw3LpAXy9kFm8pdtJ/7kWNKY+AVLYM5cK1cL+lHSnKxNV6C2ZkvEGwIw7
         HZ3+n2zGQmPjJlA+Z4IYklwLWq0m0kGjWIMeaVkvTph8D6tksRhb643TeWoA3S4TXdyy
         9vuPq6Ksv2oWkHn73R4WLL+Y0+P8KH7SlyvtlAiNCBKw6Xd7U7vJ3Kk+5TW3O8J2IdDO
         ipiA==
X-Gm-Message-State: APjAAAWLwABGmVVmuv4JNrzNQzWXIL8hZ9EdlMTSuaTJ/fyQMOJYxI5G
        2b1XqauMzRhex+4s8MmQ7KZy0wPF
X-Google-Smtp-Source: APXvYqw6ON3+oe6fNeIee7BiVKlTWMa4s6e6kcqUcLEXzDw8+Jm1QCk8IqGE2l2hj0pyRoJdhdTi2A==
X-Received: by 2002:a1c:490b:: with SMTP id w11mr10358895wma.96.1582128839636;
        Wed, 19 Feb 2020 08:13:59 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:6468:f312:ec41:5e57:ff4d:8e51])
        by smtp.gmail.com with ESMTPSA id w7sm376771wmi.9.2020.02.19.08.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 08:13:58 -0800 (PST)
From:   pbonzini@redhat.com
To:     git@vger.kernel.org
Cc:     bfields@redhat.com
Subject: [PATCH 0/4] am: provide a replacement for "cat .git/rebase-apply/patch"
Date:   Wed, 19 Feb 2020 17:13:48 +0100
Message-Id: <20200219161352.13562-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

When "git am --show-current-patch" was added in commit 984913a210 ("am:
add --show-current-patch", 2018-02-12), "git am" started recommending it
as a replacement for .git/rebase-merge/patch.  Unfortunately the suggestion
is misguided; for example, the output "git am --show-current-patch" cannot
be passed to "git apply" if it is encoded as quoted-printable or base64.

This series adds a new mode to "git am --show-current-patch" in order to
straighten the suggestion.  "--show-current-patch" grows an optional
argument, where the default behavior can now also be obtained with
"--show-current-patch=raw" and ".git/rebase-apply/patch" can be retrieved
with "--show-current-patch=diff".

This requires a little surgery in patches 1 and 2 in order to convert
--show-current-patch from OPTION_CMDMODE to OPTION_CALLBACK.  After this,
the last two patches implement the new syntax and feature.

Thanks,

Paolo

Paolo Bonzini (4):
  parse-options: convert "command mode" to a flag
  am: convert "resume" variable to a struct
  am: support --show-current-patch=raw as a synonym
    for--show-current-patch
  am: support --show-current-patch=diff to retrieve
    .git/rebase-apply/patch

 Documentation/git-am.txt               | 10 +--
 builtin/am.c                           | 96 ++++++++++++++++++++------
 contrib/completion/git-completion.bash |  5 ++
 parse-options.c                        | 20 +++---
 parse-options.h                        |  8 +--
 t/helper/test-parse-options.c          |  2 +
 t/t0040-parse-options.sh               | 18 +++++
 t/t4150-am.sh                          | 20 ++++++
 8 files changed, 140 insertions(+), 39 deletions(-)

-- 
2.21.1

