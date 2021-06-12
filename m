Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D912C48BCF
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 05:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60F70611C9
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 05:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbhFLFJX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Jun 2021 01:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhFLFJW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Jun 2021 01:09:22 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99F6C061574
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 22:07:16 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id e7so3841895plj.7
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 22:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x9QKbWxHnleNQV1em4L5UxWkJmPUGpkIWuMLmBpzXXQ=;
        b=Yr+Y2QzBFdOtlWTBvX6xknwHiTlBKwdz8iuyIEy8m3KcSHTl8MgdScf97xBzZhAN4A
         AtydezioeKqlfdSG0CESnJ5L9Ytslo4mvrboBrik9pVdTFRWwfZV03T6vEOBp9mQkLgZ
         J8x8PhGSsWKgTGEij2gJZ0teynxXXtDsxxvcymrvOK2KoxEeA4Xcm6BPMDU55/bl8t1y
         7v/xI6qM6aC+IiXe1CIbH4bBmWbSed8dVkmheCaw4lKReRYK/P/BK9xcVNQy0RRoyZMC
         AJIar32sVmvhXonC4vSdjxYxfOpxEWdD41S+tn1w4qGVynyPly8PQJdalHc/ALRuD/PQ
         KNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x9QKbWxHnleNQV1em4L5UxWkJmPUGpkIWuMLmBpzXXQ=;
        b=IubGM5/8D96qlb3RCUNFfVyic/oNOlNnV/BOW1GE3QZ8oPrpzJxjy88rzJWXS/ASHR
         qGzBl+F48BSsiecy1K6XsW/N49J8jVVK7S8QXaVZl7U+zbaIHWb0QbvxNi6/duiRCxTX
         etjPOssvjKgiNKVTvqgHKFhRs1/P9fuKGlVHJZeK7BZROBGcycJdBApJGFPzStdUO7sQ
         g+PMscW10Eh4hxMPRMR0E/ACeE77E9Lk9O+8TuVHVWuRAnBmM7QtoCgsKDut3ri3k9KA
         PJFoZxybHjlVUtzYoZps5SLjIP75kykZXKODPCxy5ewqytrrojyJlPOr2WAH4CnHrrI3
         ovXg==
X-Gm-Message-State: AOAM532e9D1PA5LPoiCfrbQqGGmU1A3Je1jiJc01Z70pIgd6lZwjLDHO
        qb40ydznLjBtnJ/fqDx2Ums=
X-Google-Smtp-Source: ABdhPJxIx6suqOnyZXJALaKV5ESrg2ElX7pOchu4f75jEoW7SQdRBJ3sJpteeXHadpAjIgy8miSCHA==
X-Received: by 2002:a17:902:e812:b029:112:3047:272a with SMTP id u18-20020a170902e812b02901123047272amr7002833plg.67.1623474436096;
        Fri, 11 Jun 2021 22:07:16 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id n23sm6651745pff.93.2021.06.11.22.07.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jun 2021 22:07:15 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 0/4] Fixed t6020 bash compatible issue and fixed wrong sideband suffix issue
Date:   Sat, 12 Jun 2021 13:07:07 +0800
Message-Id: <20210612050711.4057-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <87im2s5jjm.fsf@evledraar.gmail.com>
References: <87im2s5jjm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

In addition to fix the bash incompatible issue of t6020, find another
issue when try to rewrite t5411 to compare raw command output.

Function "demultiplex_sideband()" will try to split the sideband-2
message by line breaks, and append a suffix to each nonempty line
to clear the end of the screen line. But in the following example,
there will be no suffix (8 spaces) for "<message-3>":
    
        PKT-LINE(\2 <message-1> CR <message-2> CR <message-3>)
        PKT-LINE(\2 CR <message-4> CR <message-5> CR)
    
This is because the line break of "<message-3>" is placed in the
next pktline message.

With this fix, we could rewrite t5411 to test raw output of "git push"
which has a stable suffix for each remote sideband-2 message.

Jiang Xin (4):
  t6020: fix bash incompatible issue
  test: refactor create_commits_in() for t5411 and t5548
  sideband: append suffix for message whose CR in next pktline
  test: compare raw output, not mangle tabs and spaces

 sideband.c                                    |   4 +
 t/t5411/common-functions.sh                   |  54 +++--
 t/t5411/test-0000-standard-git-push.sh        |  82 +++----
 .../test-0001-standard-git-push--porcelain.sh |  90 ++++----
 ...st-0003-pre-receive-declined--porcelain.sh |   8 +-
 t/t5411/test-0011-no-hook-error.sh            |  40 ++--
 t/t5411/test-0012-no-hook-error--porcelain.sh |  42 ++--
 t/t5411/test-0013-bad-protocol.sh             |  62 +++---
 t/t5411/test-0014-bad-protocol--porcelain.sh  |  80 +++----
 t/t5411/test-0020-report-ng.sh                |  32 +--
 t/t5411/test-0021-report-ng--porcelain.sh     |  36 ++--
 t/t5411/test-0022-report-unexpect-ref.sh      |  26 +--
 ...est-0023-report-unexpect-ref--porcelain.sh |  28 +--
 t/t5411/test-0024-report-unknown-ref.sh       |  18 +-
 ...test-0025-report-unknown-ref--porcelain.sh |  20 +-
 t/t5411/test-0026-push-options.sh             |  58 ++---
 t/t5411/test-0027-push-options--porcelain.sh  |  62 +++---
 t/t5411/test-0030-report-ok.sh                |  20 +-
 t/t5411/test-0031-report-ok--porcelain.sh     |  22 +-
 t/t5411/test-0032-report-with-options.sh      | 186 ++++++++--------
 ...est-0033-report-with-options--porcelain.sh | 200 +++++++++---------
 t/t5411/test-0034-report-ft.sh                |  22 +-
 t/t5411/test-0035-report-ft--porcelain.sh     |  24 +--
 ...t-0036-report-multi-rewrite-for-one-ref.sh | 132 ++++++------
 ...rt-multi-rewrite-for-one-ref--porcelain.sh | 138 ++++++------
 t/t5411/test-0038-report-mixed-refs.sh        |  74 +++----
 .../test-0039-report-mixed-refs--porcelain.sh |  76 +++----
 t/t5411/test-0040-process-all-refs.sh         |  80 +++----
 .../test-0041-process-all-refs--porcelain.sh  |  82 +++----
 ...t-0050-proc-receive-refs-with-modifiers.sh |  90 ++++----
 t/t5548-push-porcelain.sh                     |  97 +++++----
 t/t6020-bundle-misc.sh                        |  93 ++++----
 32 files changed, 1047 insertions(+), 1031 deletions(-)

-- 
2.32.0.rc0.27.g7b1e85181b

