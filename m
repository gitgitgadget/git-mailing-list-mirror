Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FFBC63777
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 22:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FA0D2073C
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 22:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=knyt-tl.20150623.gappssmtp.com header.i=@knyt-tl.20150623.gappssmtp.com header.b="m5xhkYdN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbgK3WMU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Nov 2020 17:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730451AbgK3WMT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Nov 2020 17:12:19 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B044AC0613D2
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 14:11:33 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id v14so24932136lfo.3
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 14:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=knyt-tl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=tLbsrLLmpv0GWBWL2zb5z0IkPl+eBFoVR+Q15X7YhMM=;
        b=m5xhkYdNPtPawj+h6jZnvFMCp+lMz3LxF3WTOTSqIRjo0tD3t4JG2biNB9PKBMPaui
         OjMndzAJZX/NPQOe3eurSY7QdFgw+Odafn68OuKLCMj2h2TBrP5geGIxPqw5Ylb45ghu
         hLw6rcGboUSRhVY9PmdHs67MN7SvcmOXApZcLMcAuOncOiNA9JUDlw9V8rAsnxJnSG9Z
         eTNmtHzzVfe4F3LS+2vntpjsyFreWKiPmVgUSWKLdTuAixi1AMyiEJtBUkRLsO9uIBm3
         CschO/+pAqwcBBDw9SKpmU1kCx2IMEZtcwegtuffXhGYvV7VS/6TQ195zZC/94j+3r+F
         XNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=tLbsrLLmpv0GWBWL2zb5z0IkPl+eBFoVR+Q15X7YhMM=;
        b=dqn71ovmTtlriIwrUYQxGfFz9qJcaDxBiDe4nZYxZ6MVcbvr+/I6jv8CT2EmD8ZYVR
         zfRYZpj78q1BMAn3T3XLkXf+A7z7T7ydjmjdJvTK7iFPmlYjVKRodeQ4zzkoCEDb4tE9
         krARiuJydSbiPDizzYWwM+4XysmfBjM6zvt//DOQC/EA69eoZUzL5wlMenEX9UOxuKqA
         YdJxxwH2r+mrAXGJUfxSEO4RCjWk34oc5Zmz7lmNg3YYi4ghvCORa+RM5hLPfl1aR0bR
         YX84Xk1Vwl6xvMqCucMSS88OF4LvlXomIE6tAoeH9vwMW0S8gZ1nc6V0HFiXFbGhs6Lj
         zFuQ==
X-Gm-Message-State: AOAM530LS4sQtUJEykW/fsfe4YDscfBc/OHp/ysIWE2xIACQNHHGUnU+
        XouhbrRi1dwG0T3WWBWN1YHR/qg6XPo1TC+CcZMPgcjmHJyF7wwKMtLw2Q==
X-Google-Smtp-Source: ABdhPJzQuYWn8iYH3bD+RWs+Cci+3AVJvRvn1obpBknew7uLsioibzhvLOpYFpP7sPlmdLO+2am10MCTnc6yHU7HL2k=
X-Received: by 2002:a19:42cd:: with SMTP id p196mr10496640lfa.228.1606774291714;
 Mon, 30 Nov 2020 14:11:31 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?Vojt=C4=9Bch_Knyttl?= <vojtech@knyt.tl>
Date:   Mon, 30 Nov 2020 23:11:20 +0100
Message-ID: <CANVGpwZGbzYLMeMze64e_OU9p3bjyEgzC5thmNBr6LttBt+YGw@mail.gmail.com>
Subject: What did you do before the bug happened? (Steps to reproduce your issue)
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)

1. Create a commit with hash-issueId, eg. '#87 Fix wrong indent'
2. Create a second commit with any commit message.
3. Use interactive rebase and 'f'ixup the second commit to the first one.

What did you expect to happen? (Expected behavior)

I expect a single commit with message: '#87 Fix wrong indent'

What happened instead? (Actual behavior)

There is a commit with empty commit message. This happens without any
warning and one notices even too late.

What's different between what you expected and what actually happened?

The commit message disappeared as it was probably treated as a comment.

Anything else you want to add:

[System Info]
git version:
git version 2.28.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Darwin 20.1.0 Darwin Kernel Version 20.1.0: Sat Oct 31 00:07:11
PDT 2020; root:xnu-7195.50.7~2/RELEASE_X86_64 x86_64
compiler info: clang: 11.0.3 (clang-1103.0.32.62)
libc info: no libc information available
$SHELL (typically, interactive shell): /usr/local/bin/bash

[Enabled Hooks]
pre-commit
