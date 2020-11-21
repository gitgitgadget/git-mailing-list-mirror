Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11283C388F9
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 18:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC72E22202
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 18:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEqkRf/4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgKUSbg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Nov 2020 13:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbgKUSbf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Nov 2020 13:31:35 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24280C0613CF
        for <git@vger.kernel.org>; Sat, 21 Nov 2020 10:31:35 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id 74so18132410lfo.5
        for <git@vger.kernel.org>; Sat, 21 Nov 2020 10:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V8m8K+ZLRPagUwoPGsVaSab+490njpBeekj1xFIgIJM=;
        b=EEqkRf/4UH22vDpRQrPEUj6C4H4PAomYg4jkZoAU9LQ6VSSmBWBnXTGnGh/f8Ux97s
         gc7zeLeL7Xv03pGXb6tf6mmZT8cbmKR/b1ffOhE0SU7GPWSwWiB3hY9XBRxnWUkFfaPL
         Aeg6Co1CK7PC/dJbCtWDsVThRbS6qvIb9EtNhAzinJk4SRChCFtvUhcMznsHdoxgYdDx
         FLRVHZMA4smN9GZXHpIR3MVA5hq0z8RDogKS8dYuHBF7JdClsDJU3Q7UmLvmuMT2SYOK
         jdUUrG0aixA3K9R20/M+4M2GATbesFysO1hDcdi1/KOyKAQscl3QDMCG4zYyUf9WrL62
         v70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V8m8K+ZLRPagUwoPGsVaSab+490njpBeekj1xFIgIJM=;
        b=Fqt/yM8uL7SLuAfGFlzC6iBO3AD6ywD0v6qmpGYElvQPRmVQrjBpCGGCp0QWRZuc2G
         eQDtcP+Qesgt2hyt6tQaB8TjqdtymlfddmeeIlKoCdUiR1UlBNlEBDlnI2Ws/3IGuzUt
         7HQkpGRGerwyDj1EqgEhgH/s66u+/2uifn2BOxrPx4i3xOKABf8EZtAnUFS/6t8YxCGk
         UoI1fjmLvVH7Mrt7//CBpZ9Wp5w72D6qOYjgZLdrm2vQRx06U3QvTJuhVHSoVPKtjQCM
         fgWOPV01EX5ZiSp0mDiD/dfyYLyeAwht6K0rpBHUryCOJMtwRKAEda2yI284wh3Lox1b
         kyAg==
X-Gm-Message-State: AOAM531bhW/OXghP50UDF5HZb7qSBJIT6U5I6YMgHahjn0urVEoHpU3P
        8vezhpkoPbmGkO+jvx6HOx0iheI4Ty4aFQ==
X-Google-Smtp-Source: ABdhPJwFRJ7rmFO/coVBDZ0L81txYS3oCi49asfRRNWD+3fTjLK4caw17htfwdXTod9J5q+mVKnoIQ==
X-Received: by 2002:a05:6512:6d:: with SMTP id i13mr11456993lfo.491.1605983493348;
        Sat, 21 Nov 2020 10:31:33 -0800 (PST)
Received: from localhost.localdomain (h-79-136-100-70.NA.cust.bahnhof.se. [79.136.100.70])
        by smtp.gmail.com with ESMTPSA id m7sm786531lfj.113.2020.11.21.10.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 10:31:32 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH 0/4] grep: retire `init_grep_defaults()`
Date:   Sat, 21 Nov 2020 19:31:06 +0100
Message-Id: <cover.1605972564.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Users of the grep machinery need to call `init_grep_defaults()` to
populate some defaults. There's a comment: "We could let the compiler do
this, but without C99 initializers the code gets unwieldy and 
unreadable, so...".

We have such initializers now, so we can simplify accordingly.

Martin Ågren (4):
  grep: don't set up a "default" repo for grep
  grep: use designated initializers for `grep_defaults`
  grep: simplify color setup
  MyFirstObjectWalk: drop `init_walken_defaults()`

 Documentation/MyFirstObjectWalk.txt | 34 +------------
 grep.h                              |  1 -
 builtin/grep.c                      |  1 -
 builtin/log.c                       |  1 -
 grep.c                              | 74 ++++++++++-------------------
 revision.c                          |  1 -
 6 files changed, 27 insertions(+), 85 deletions(-)

-- 
2.29.2.454.gaff20da3a2

