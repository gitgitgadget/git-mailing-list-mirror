Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB31AC433E0
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 20:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9513B2072E
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 20:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="FLk03g4+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407139AbgFYUdI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 16:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389406AbgFYUdH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 16:33:07 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03F1C08C5C1
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 13:33:07 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id e2so3476308qvw.7
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 13:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RkO6j9QCtlS9qbWWpLqqXOYKBgOx/Di0lUOvDe3g4wM=;
        b=FLk03g4+xZzhQawQHIIII3BWUC89BsQn7bxxVDUJWyJtBrnM3B3mjiT6qpQHmG0mOI
         gawWtj0Egd5fnWMaaQDizEWxLLZ5dalF6RHUwTBEAWC87J2mgVoprAFs3sdlDOt56F+i
         xgrO+eQsZW32J4AfqOT049REd6wKswg3RPi+9hhiwQFQd2BAl+fdOm9G7oHqy2rl87ab
         J8mJ8q4X35KVmK2OuQgjsIbPGYAGz2mUpZfMUEioXBjqwBbM1C/jeO8FMwZvIt9tM69W
         XKlhBzxSsnOJ60pPdrKB2Uz55MlXkmyBUneqAKETslw2pETCmEPThBjIK1fbDpdtlXcW
         MzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RkO6j9QCtlS9qbWWpLqqXOYKBgOx/Di0lUOvDe3g4wM=;
        b=b0Q3rftQREeXh0FEelDDc76Xl38+hsJB4pmSV5L5DBBPYimDpuJuAGSLHttOm/jj02
         ffk8sQeE0T4F4U8kuhx8OYfDCV1tZFeZYl/uJDVLqCcfhGCcm+pnNK2qPZ+BvSaCmk5t
         O6mzVQeQWnzPR2Kh3uGJx0gdefEdHdxX6sXhgyuSjEHaXZmP7iX29xdh9S8XZ8dOClG+
         26Y8+X59scxBHCTV8ZGNZy2QLWitsnCpPisgcp7hi5i7sf66p+MsZ6q8iPzAUMOBaz6v
         zmkRLrzPAkdW1wKIogkZq46uBGOE4k68U0ybSv++BbShAWKBhK9v2+nryT1itIdAp/SA
         dffA==
X-Gm-Message-State: AOAM532CTtL5PHG2k/3xsGA2Jc8bzz28N5mzeHZI101xTmNuPWmM2k8h
        OHN+3auk0G7oDIuWcDV2WINF6y3F/Po=
X-Google-Smtp-Source: ABdhPJwdEz4GZfK19sFpmlVNPTCTX7+Fd0g/NmCxl/JDQFBLC5qYbkhMxJoxJSwGovCWB9xvQade2w==
X-Received: by 2002:a0c:8d8c:: with SMTP id t12mr24067628qvb.234.1593117186379;
        Thu, 25 Jun 2020 13:33:06 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:9a16::4])
        by smtp.gmail.com with ESMTPSA id n63sm6745118qkn.104.2020.06.25.13.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 13:33:05 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, j6t@kdbg.org,
        jonathantanmy@google.com, peff@peff.net, Johannes.Schindelin@gmx.de
Subject: [PATCH 0/2] Make oid_to_hex() thread-safe
Date:   Thu, 25 Jun 2020 17:32:55 -0300
Message-Id: <cover.1593115455.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200625013851.GA9782@camp.crustytoothpaste.net>
References: <20200625013851.GA9782@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some thread-unsafe functions of our codebase appear very down in the
call stack, which can be hard to notice (or avoid). Thus they are
sometimes used in threaded code unsafely. In this series we add
pthread_once() to compat/win32/ and use it in conjunction with
pthread_key to make a subset of the said functions thread-safe.

As a next step, I would love to make [warning|error|die]_errno()
thread-safe as well. strerror() is not safe on *nix, and there are some
thread functions today that call these (although the actual risk of a
race condition must be very small...)

My idea was to implement a xstrerror() wrapper which calls the
appropriate thread-safe function (dependant on the OS), or even call
strerror() itself but holding a lock to copy the result for a local
buffer (which should be OK as we don't expect contention in strerror).
We could also set a thread local buffer array, as in the second patch of
this series, to excuse callers from allocating/freeing memory.

One concern with this idea is the risk of an infinite recursion if
xstrerror() or any of its childs call [warning|error|die]_errno().
However, if we are only using strerror() and pthread_*() within the
wrapper, there should be no problem, right? Has anyone thought of
other problems with this approach?

Finally, should such change also come with a coccinelle patch to replace
usages of strerror() with xstrerror()? Or better not, as the change
would be too big?

Matheus Tavares (2):
  compat/win32/pthread: add pthread_once()
  hex: make hash_to_hex_algop() and friends thread-safe

 compat/win32/pthread.c | 22 +++++++++++++++++++++
 compat/win32/pthread.h |  5 +++++
 hex.c                  | 45 ++++++++++++++++++++++++++++++++++++++----
 thread-utils.c         | 11 +++++++++++
 thread-utils.h         |  6 ++++++
 5 files changed, 85 insertions(+), 4 deletions(-)

-- 
2.26.2

