Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEC0C433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 23:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94299207EA
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 23:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hr4/HXpX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgGaXdT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 19:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgGaXdT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 19:33:19 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395A7C06174A
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 16:33:19 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id d18so33298899ion.0
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 16:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mXMIt8Xl9DrCpSvyU4lQchWcRn5s3oW+yRAk8zWzOAE=;
        b=hr4/HXpX1+ntQfFrw7lc8lfhOCKcjp6p2OXiZ0IPx18+pwwY6zQSNQheQYcSi9NAgy
         P7ZhpNItmXGUR3ucPXsOKDq8YMmD9A8A31jTnHf32xS1YvmLxqvZ+UYcAumOJucFM92/
         YwM/xNhD8IELVuy52XBNatwshLWK1RFH1iH6qsdJWIuG6RJZaRVDAbeEuy8Xzfol3vQ8
         Kl7t910KvRu6+3pK59UDpwxzcU0pA/uBMnjX3L+bAKEaR61ZHZuPZCwwDnx5KCei4ivB
         6u8mXddFSHeXeLTd1Fq5lK1DiPJgILaXjX3u67XLRzWyeHDHoMGFEx7T5M/MCOwBJJ5e
         UHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=mXMIt8Xl9DrCpSvyU4lQchWcRn5s3oW+yRAk8zWzOAE=;
        b=ouNdW1hfi7CVovVFDrwqglNxSV3yjQoImAq8bPhSje3MSag110bKmErWTO355TcKls
         QJMlO1nsT67PIfdXa1sMZKegMv8p7papjNJqD8QiLUXCC5qoybIcoe2JTqL7ygRwgQQz
         Qhjku0jFFPIIC46C9Aaczu5H9yoQNGGDVCV6vGsPEgGCECNnoh4nnntkVn4LvnJPjsyk
         7A86N+yrk6uNiaBMh3kYYzvfkQ+flw9oFXMBuz8mPqrWuk253s/osLZOCSNl2VLJA+0S
         AxndAn/gCU7EAyKQX6mW2kEt8orAMF+09b5elPWQsgjozIgDNYc4F2Yp9NaKHS1i1rd5
         03Fg==
X-Gm-Message-State: AOAM530M1cXoUg/cGKubmO5nzgTrf0JCdWvReWAzNc0qv2Vf4bwkKMdA
        aes8FyBPPYA3p2To1jD3/MFl2eBgB8A=
X-Google-Smtp-Source: ABdhPJy8MJ/32W5P6GDChMEj9iiosOfV2plSQCM2SZ/wyPLA8/RHMaUL6YhSxl1VuIEAw26g6mEp1w==
X-Received: by 2002:a02:aa03:: with SMTP id r3mr7888997jam.38.1596238398250;
        Fri, 31 Jul 2020 16:33:18 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id t18sm3336758ild.46.2020.07.31.16.33.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jul 2020 16:33:17 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        Michael Rappazzo <rappazzo@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 0/4] worktree: cleanups & simplification
Date:   Fri, 31 Jul 2020 19:32:10 -0400
Message-Id: <20200731233214.22131-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.28.0.203.gce1f2e0ef1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The primary change of this series is a response to Junio's
observation[1] that it would be nice if get_main_worktree() didn't
employ special cases for path normalization. I was planning on
investigating the topic eventually anyway but ended up having to
tackle the same sort of manual special case normalization in another
worktree-related topic I'm working on, thus this series fell out
naturally from that other work. Along the way, while re-studying the
worktree code, I came across a few other issues which deserved
attention, but which are not directly related to the other topic I'm
working on, so I bundled all these small changes together here.

Eric Sunshine (4):
  worktree: drop pointless strbuf_release()
  worktree: drop unused code from get_linked_worktree()
  worktree: drop bogus and unnecessary path munging
  worktree: retire special-case normalization of main worktree path

 worktree.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

-- 
2.28.0.203.gce1f2e0ef1

