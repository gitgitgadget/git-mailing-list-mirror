Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF116C83000
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 22:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B69602076B
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 22:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="upPOJvXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgD2Wja (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 18:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726164AbgD2Wj3 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 18:39:29 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761BDC03C1AE
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 15:39:28 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id c21so1426568plz.4
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 15:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=OBjqLYQMimkH0yNPFH/8bQl4UzCDWmPNHY6u4QeYUSI=;
        b=upPOJvXcm+8E5HCruxHyxE4lCW5S/r3w+INy65dJpsopudCFFl0tB6bbVb6hsEXDn4
         +iWjRWMb2NeizKA6Ud5mDe66plUgX+cs9dwQcBpCxiaVxrN7pfTo6GFwHcjYqUwrzs+u
         wga7ihQ2o7J+PwiNUdhqw4QgxrQTgib2AiKGlTF3fMbWchQvPm6xEKksygTK89D/T1js
         FT/vtzL6pLGvol4yG4HA0YCicmcMBIe7jNehFjdcNsE9Rci1vzqpJyErEik6thHuG/bI
         dL80N9BFLw0tSDeXPTfzB5lbG8W7+UhYVO1T87GuNcwQRndXAld8kkgzgjf/LQ8yMkrv
         IQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=OBjqLYQMimkH0yNPFH/8bQl4UzCDWmPNHY6u4QeYUSI=;
        b=UdQ46pG8eY5gJIfugS+X2hcCugGazP7M4EtmE+AMbhYQhZ26XBTIsIivGTXs/DsDTW
         CS1k5RjgUtDJUfIJVXG4VqaScMEDAMrjbiFpqgoeg7CeTOZSwiyuXCvKq5YJ+Lx4MKEq
         f/2DGwvOHf3Ct6jeKbkasMe1hZ851iZVq7GJme16urKMzh4ZqugM5u++zYhqbsk3fPeA
         CVyAmck3dIzuatyrf/DESYccR8fcmDXPs9ZUv05mhfCPy4cFsj4oYwgi/k1D1omkatp6
         Le1pw843j9sxsClgrC7JR2zGUhGPyQsqmvYp4n1BQe9q70lOA1sHn8YvZtdjwKt3UWZ3
         TA6g==
X-Gm-Message-State: AGi0PuZEkwPMYZCYGSieUQ2jXnpxl50T3MYZyyqAIiMro9BJ6vYMbKEO
        28uPFu/LLqrX3+Kh/nJjOfzAGAaIFdrwlXBH
X-Google-Smtp-Source: APiQypJ5xxX7MdvhlUqIsXqgfO6aM7Od8TSBSIB8Jl6Xnh0XbCzFPKQA5eJdhEGvxfHjeJnfoLEyfw==
X-Received: by 2002:a17:902:b598:: with SMTP id a24mr653104pls.63.1588199967510;
        Wed, 29 Apr 2020 15:39:27 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id d20sm1755505pgl.72.2020.04.29.15.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 15:39:26 -0700 (PDT)
Date:   Wed, 29 Apr 2020 16:39:25 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jonathantanmy@google.com, jrnieder@gmail.com
Subject: [PATCH 0/5] shallow: extract a header file
Message-ID: <cover.1588199705.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

These few patches are based on a suggestion in [1] from Jonathan Nieder
and in [2] Junio. The gist of this series is to do the following three
things:

  1. Extract a new 'shallow.h' header to collect all of the functions
     that are related to shallow-ness, but defined in 'commit.h'.

  2. Add some documentation from the previous series where it could have
     benefited from it.

  3. Finally, introduce a thin wrapper type 'struct shallow_lock' which
     makes it a type-level error to unlock a non-shallow lock with
     '{commit,rollback}_shallow_file'.

The remainder of suggestions in [1] about the structure of t5537 I
decided to not address in this series, since I anticipate there is more
work there than I want to take on in this series alone.

Thanks in advance for your review!

[1]: https://lore.kernel.org/git/20200423011444.GG140314@google.com/
[2]: https://lore.kernel.org/git/xmqqy2qnidyy.fsf@gitster.c.googlers.com/

Taylor Blau (5):
  commit: make 'commit_graft_pos' non-static
  shallow: extract a header file for shallow-related functions
  commit: move 'unregister_shallow' to 'shallow.h'
  shallow.h: document '{commit,rollback}_shallow_file'
  shallow: use struct 'shallow_lock' for additional safety

 builtin.h              |  1 +
 builtin/receive-pack.c |  2 +-
 commit.c               | 16 ++-------
 commit.h               | 49 +-------------------------
 fetch-pack.c           |  3 +-
 send-pack.c            |  1 +
 shallow.c              | 36 +++++++++++++------
 shallow.h              | 78 ++++++++++++++++++++++++++++++++++++++++++
 upload-pack.c          |  1 +
 9 files changed, 112 insertions(+), 75 deletions(-)
 create mode 100644 shallow.h

--
2.26.0.113.ge9739cdccc
