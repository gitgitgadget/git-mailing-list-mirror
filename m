Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3257CC2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 11:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCE2921D95
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 11:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rHQ7ZVXH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgI1Lk1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 07:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgI1Lk1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 07:40:27 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B023C061755
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 04:40:27 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x14so903667wrl.12
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 04:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=02G9vU1M/aaAKTiW+jhxcjO/avZXYUrLh0A9Kr1YANc=;
        b=rHQ7ZVXHINVSX/SY2dnXhoCKIC7QwKuVzm0p6TWvueNv8iniablOl1VMAOcce+ILna
         OG4r2g4WcRNlbMfq1FQG+ujdkNLMw0dxe74GFTNIvzQbUZn10x722Tr+ZKEExOlNYkMB
         zkSg4aF1rdp0Uo91DR/krmTMMpuztModvnUVVdHdjCI2kO4rzOPTvcmENyKYVHgZK2/J
         KBMvPXu9VIdYzBqYxKHTvV/WStQTjn9Wkr1/DBjGnuE2ZVaiWKvEAlKIEYU3mVB5NFTf
         5fONiAxDiS57x1AI+6P00zh7Bd6rDed/vPEOLmMBE9pG/TAODJKzVst8Ht6QQuHFK14i
         FlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=02G9vU1M/aaAKTiW+jhxcjO/avZXYUrLh0A9Kr1YANc=;
        b=ucBwlYZ1rN3xCLbO97+JmqUTXCMdNTrKFCcgIPcO7ZYheU/h+/svBjAOKFdMitySA3
         HvXjrmiOKqsNGVlUw6gYj5jkvsBvQjM2t1pdiSbCO4ZsyHkdUxLpf1MD7yPB/z7uYjTH
         mAprangrBAtS03KO9lhTjQ0UrF4/WA+wCntAhbQOAYfLpnWkmkrQ6ERyF0G+BhO72dRl
         LP5GwVFTg1OCTlap3QN0zVp9BTrRXLZyQddKLxagAH77XZqgpftSGpkTWMg44n/qQX2F
         LAvHDq9e+VFix5CcVbjfdyVMKAFDFtCBAS/JF+OePk86rtyR44qKxF3jKSFgK42cZPuF
         g4Tg==
X-Gm-Message-State: AOAM531qwh2QG6ATEFoK61IN06HFr6Ziz/TTevhOD5sQBDmevfw98iMK
        eLggRPWvF6MkqAPQdPNo6SdunJaX8kI=
X-Google-Smtp-Source: ABdhPJwsDOIbC2/IDKGabbsYdCqcb0idfNtHlowVh7T76zJ/TR3t2FbSd3Un0iLgRXmXswelJGZl3w==
X-Received: by 2002:adf:f6c8:: with SMTP id y8mr1308885wrp.217.1601293225519;
        Mon, 28 Sep 2020 04:40:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b188sm6998872wmb.2.2020.09.28.04.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 04:40:24 -0700 (PDT)
Message-Id: <pull.710.v2.git.git.1601293224.gitgitgadget@gmail.com>
In-Reply-To: <pull.710.git.git.1581688196706.gitgitgadget@gmail.com>
References: <pull.710.git.git.1581688196706.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Sep 2020 11:40:21 +0000
Subject: [PATCH v2 0/3] Prepare git credential to read input with DOS line endings
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This contribution came in via Git for Windows
[https://github.com/git-for-windows/git/pull/2516].

Sadly, I did not find the time to go through all the changes of 8f309aeb
("strbuf: introduce strbuf_getline_{lf,nul}()", 2016-01-13) (as Junio asked
[https://public-inbox.org/git/xmqqmu9lnjdh.fsf@gitster-ct.c.googlers.com]).
Rather than delaying this patch indefinitely, I admit defeat on that angle.

Changes since v1:

 * Added a commit to adjust credential-daemon and credential-store in the
   same manner.
 * Adjusted the documentation accordingly.

Nikita Leonov (3):
  credential.c: fix credential reading with regards to CR/LF
  credentials: make line reading Windows compatible
  docs: make notes regarding credential line reading

 Documentation/git-credential.txt   |  4 +++-
 Documentation/gitcredentials.txt   |  2 ++
 builtin/credential-cache--daemon.c |  4 ++--
 builtin/credential-store.c         |  2 +-
 credential.c                       |  2 +-
 t/t0302-credential-store.sh        | 16 ++++++----------
 6 files changed, 15 insertions(+), 15 deletions(-)


base-commit: 9bc233ae1cf19a49e51842c7959d80a675dbd1c0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-710%2Fdscho%2Fcrlf-aware-git-credential-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-710/dscho/crlf-aware-git-credential-v2
Pull-Request: https://github.com/git/git/pull/710

Range-diff vs v1:

 1:  2a9cc710bb = 1:  27f6400a21 credential.c: fix credential reading with regards to CR/LF
 -:  ---------- > 2:  f69076036f credentials: make line reading Windows compatible
 -:  ---------- > 3:  61baea1061 docs: make notes regarding credential line reading

-- 
gitgitgadget
