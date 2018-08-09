Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC94C1F405
	for <e@80x24.org>; Thu,  9 Aug 2018 17:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732317AbeHIUBS (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 16:01:18 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33024 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731115AbeHIUBS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 16:01:18 -0400
Received: by mail-pg1-f196.google.com with SMTP id r5-v6so3082100pgv.0
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 10:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=6ciZuG+waAQrmckijopIfdzypWpvHM7WEwM5fMyuMnk=;
        b=VGasAH5gnJFpRGSoy7L1uIcubD+KyG1yCIO7W4kdl1KUj80M52MlitzKqJy4NqR9F+
         xG3e183UOFS208RcDaBky4e30ZuA+bWAfS+QVGZ1gRhDtG7dJxijg8xNrd5BuAXQ1Btv
         YfxQ1dV7WG3uKrsZ9zbo5VNYHtO/kbuoPWM56o0Ba7Cv8JPWOdilh0SblJFP4NRZwQop
         5KgT2DWekrFGQlMEvXdGfjI9B1NuaWKLfxroeINaxYRhW8AmPs1uNm4bC5Eqh1+4E9a1
         L+KMEZ9252TS4k2UZSuCAlToZtJA4II40Zi8wwopSArPBW5FZkSyfauj9d93m/FhRvQI
         oarg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6ciZuG+waAQrmckijopIfdzypWpvHM7WEwM5fMyuMnk=;
        b=uXdIKFemrd4wJRBIUEgZsD/5ffNSrR4V3gsI8dAbQEZONMdhjqkip6+j+u5O0p0wIN
         XZ3ZypVpWg3xHvPsOwNZpHVX5XbB42UXnoNEExwi+OWUEmPVYrwAvsojnauAd+xrt4tW
         DalWkacMmtU/vlyTvlvb0JOfc0spkdOrsBipGC50eRyEnPKeQ+sp8Gv9HldHI4e9qcz/
         uZ9DeIEXGOWsiNshcFgG0KfitxHO9icumhImjgCaP6qriYRwIw3d50Pdt6Ukqt/IoQ6f
         XoFWrPXzWttQ4SKHiYE4+XdumGcMsyrZGHjkVr92rcxdxUmSZLS6nhdnvH+AQf+O9Kmq
         KNXg==
X-Gm-Message-State: AOUpUlE9tAC5TJ0hGw/BC9zcPmWV7eIjP8lYW7/A4qT+TnOoos6p7toC
        W4WaKIc3bLyCO6sG5RaNmsOnDar6
X-Google-Smtp-Source: AA+uWPyYvDy60p36pPr/pKgC3MAL2+TER9yB22+pqCZoTD0Uj+emeGTDj+Xzkp/1ENAwkNb+IY8zrw==
X-Received: by 2002:a63:ef54:: with SMTP id c20-v6mr2995983pgk.368.1533836125110;
        Thu, 09 Aug 2018 10:35:25 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id j5-v6sm9164940pff.139.2018.08.09.10.35.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 10:35:24 -0700 (PDT)
Date:   Thu, 09 Aug 2018 10:35:24 -0700 (PDT)
X-Google-Original-Date: Thu, 09 Aug 2018 17:35:17 GMT
Message-Id: <pull.17.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/4] t5552: fix flakiness by introducing proper locking for GIT_TRACE
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I reported a couple of times that t5552 is not passing reliably. It has now
reached next, and will no doubt infect master soon.

Turns out that it is not a Windows-specific issue, even if it occurs a lot 
more often on Windows than elsewhere.

The culprit is that two processes try simultaneously to write to the same
file specified via GIT_TRACE_PACKET, and it is not well defined how that
should work, even on Linux.

This patch series addresses that by locking the trace fd. I chose to use 
flock() instead of fcntl() because the Win32 API LockFileEx()
[https://docs.microsoft.com/en-us/windows/desktop/api/fileapi/nf-fileapi-lockfileex] 
(which does exactly what I want in this context) has much more similar
semantics to the former than the latter.

Of course, I have to admit that I am not super solid on flock() semantics,
and I also do not know which conditional blocks in config.mak.uname should
grow a HAVE_FLOCK = YesWeDo line, still. Reviewers knowledgeable in flock() 
semantics: I would be much indebted if you helped me there. Also: is it safe
to call flock() on file descriptors referring not to files, but, say, pipes
or an interactive terminal?

Johannes Schindelin (4):
  Introduce a function to lock/unlock file descriptors when appending
  mingw: implement lock_or_unlock_fd_for_appending()
  trace: lock the trace file to avoid racy trace_write() calls
  trace: verify that locking works

 Makefile               |   1 +
 compat/mingw.c         |  19 ++++++
 compat/mingw.h         |   3 +
 config.mak.uname       |   3 +
 git-compat-util.h      |   2 +
 t/helper/test-tool.c   |   1 +
 t/helper/test-tool.h   |   1 +
 t/helper/test-trace.c  | 130 +++++++++++++++++++++++++++++++++++++++++
 t/t0070-fundamental.sh |   6 ++
 trace.c                |  11 +++-
 wrapper.c              |  14 +++++
 11 files changed, 190 insertions(+), 1 deletion(-)
 create mode 100644 t/helper/test-trace.c


base-commit: 42cc7485a2ec49ecc440c921d2eb0cae4da80549
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-17%2Fdscho%2Ffetch-negotiator-skipping-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-17/dscho/fetch-negotiator-skipping-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/17
-- 
gitgitgadget
