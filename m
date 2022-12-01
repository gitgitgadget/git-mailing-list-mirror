Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45137C43217
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 07:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiLAHDe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 02:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLAHDc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 02:03:32 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FFB5C0C7
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 23:03:30 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id c7so494205iof.13
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 23:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:date:subject:to:from:user-agent:from:to:cc
         :subject:date:message-id:reply-to;
        bh=45NhduSq1qzgFSGQwhelmNyGljlst7CR/UQuShXP83I=;
        b=M9KWMBrs+s6CSkfjUcfjGu0gaUA3jXSDi+7XZ2vO+dUCE4+y3YXv4Ah7MVYHLtQ+M4
         O2JPLsJWhfE4u3c2NVGbQbZgt7w0qy/FjIJy0GzQTNBSFxL6sYPQN0hMDOwwfM0Xd7Fm
         OzxyFsLEklCWbvnl3ZwY28b/YpYBGESbTeRo5PX7y97DKtZmH36O3wp9CJKrfuhBZZbi
         yLtDIjs1lwmOt3xgh9qAZ8lIoRflTTj+d9BuQCeIIUIyFTVV7KEMYEKFpXJrOdnQg7fs
         ehlg/WnppDc1heQRUsy9Nnh19havvibwMpkLOX4cBV3K4bJAGPohUnriq4fT8u85g0yB
         Zi5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:subject:to:from:user-agent
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=45NhduSq1qzgFSGQwhelmNyGljlst7CR/UQuShXP83I=;
        b=ZEezerJK7mGoviy7xSBoEQ3fQ5F+W20lVE8XeD8wVxXXbRQdHHes922V0Yb/0rR5/V
         w0eROXWM5OOjpkzuBK7nXUMSDfRVVNgOoRSpyFSaH5U9AefDeA3Id4aGtZyBt1kbRFQa
         gzVVtfmUxHEouYbafmLX6nEf+pxQ41QZ4jIYI2bmlpUu2jzOphL9rg+cIlxT9Dyz7N1W
         Loxfb/9Cazhrp2UhCjbR7UIVMSvsN0WWJikTizYI+GtNxPjIqt4aJoneXLiTD4rjpEUy
         X6iZ/6TkcPOimyy37Bf1mcwzmkDd0iBiLwLt3BmdstREuyqFFOOoBWAJDjUCpR+FU2FY
         UrWw==
X-Gm-Message-State: ANoB5pld4RqjdORVVON1feiZRDvYSYLPVFqiGXc2Uki8itIlr4gddIgh
        Us3/Tlyl9HvQu0veVbCx2aS5vUkzZgw=
X-Google-Smtp-Source: AA0mqf7kyUxaHk+sCnL3ktIVbds6McKJHdzGR3BLqOntc8tLlGARPQdIJrZiBchV4ZnwETl5WyOIHA==
X-Received: by 2002:a6b:7318:0:b0:6d2:5d8a:bb55 with SMTP id e24-20020a6b7318000000b006d25d8abb55mr22532799ioh.72.1669878209446;
        Wed, 30 Nov 2022 23:03:29 -0800 (PST)
Received: from stargate ([2620:72:0:a40:ae86:2b20:51ed:d36d])
        by smtp.gmail.com with ESMTPSA id i38-20020a026026000000b00389dbc74fc5sm1369214jac.78.2022.11.30.23.03.28
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 23:03:28 -0800 (PST)
User-agent: mu4e 1.9.0; emacs 28.1
From:   Sean Allred <allred.sean@gmail.com>
To:     git <git@vger.kernel.org>
Subject: What are cherry-pick's exit codes?
Date:   Thu, 01 Dec 2022 00:39:35 -0600
Message-ID: <878rjry5a7.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

We're developing some internal tooling wrapping git-cherry-pick and need
to be able to distinguish its different error codes. Problem is: these
exit codes don't seem to be documented in git-cherry-pick.txt.

Looking at the source, I found myself down the rabbit-hole very quickly.
I'm not too familiar with the coding patterns quite yet -- but I'm
pretty sure I eventually found myself redirected to git-commit in one
case. At that point, I thought it better to ask here.

I'd like to document these exit codes in the manpage and I'm more than
happy to submit the patch, but I thought I'd confirm my understanding
first since it's based purely on reading the cherry-pick tests:

Exit code:

  - 0: success, sequencer complete -- no conflicts

  - 1: 'success', sequencer incomplete -- conflicts encountered

  - 127: fatal -- lots of reasons -- I'm guessing this is value for the
    'return -1' and 'return error(...)' statements speckled throughout
    the code, but it's been a long time since I cared about two's
    complement so I may be wrong here.

  - 128: fatal -- sequence is interrupted, possibly due to some other
    fatal error, e.g., 'commit doesn't exist' or 'mainline parent number
    doesn't exist'

  - 129: fatal -- there was nothing to cherry-pick at all (e.g. empty
    range)

I'm reasonably confident about 0/1 just anecdotally -- I'm less sure
about everything else.

Obviously the actual text put in the manpage should be friendlier and
possibly vaguer for clarity (paradoxical, perhaps, but it seems more
direct to say '0 for success, 1 for conflicts, and anything else is a
fatal error'), but I wanted to make sure that I have an actually-
accurate understanding rather than something only surface-level.

Two questions:

  1. Are the exit codes actually documented somewhere already that
     should simply be linked from git-cherry-pick.txt?

  2. If not, is the above listing the exit codes accurate and complete?

Thanks!

--
Sean Allred
