Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF8FC433E0
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 19:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 433D022B2C
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 19:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbgL1TXq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 14:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727767AbgL1TXq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 14:23:46 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4792C0613D6
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 11:23:05 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id j20so10026671otq.5
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 11:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H6OUIV51N4gYKKSqT2ZvG15CK7/cZE1geu9NpQjsBFw=;
        b=cssIFMvHScwLNEbtLOuIbXGOym4xqqbu05zvOu6iq/wVZ3i8zhQTzF3qYQ517hk6pS
         mATbkFhzV/oYAcfjNxE47Ms2+QvdA18GQ/eCb/fqT4WKcLIS1IJaP/ZRESp20iSuKX9n
         561EO6NnkZ1B7IMO7BTpa9CJ31gqbDsOdN6zgOzi695e3/M8TbNxtIPB5/zAfhHYlWAG
         I/oKEsKBM/0sEuoegiCJ1s854UsHie2Fix6paQO3NfaRYAvk+K4ysUVZY9UvKfWNGh4s
         cTOhpF4KAnZVr4qd7YnxUIBWXvb+sjBuigpYLZ2K7s2eSmssJhYRuKTyCC/UA+nc+joA
         LUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H6OUIV51N4gYKKSqT2ZvG15CK7/cZE1geu9NpQjsBFw=;
        b=ahm0Y84fqOoGBe5MkyAUdjtv3e2MG4F36BiSsem1WimkT8E4iWk45cxUYZTSGl45vs
         PDCEk/9TVxWT7VVsJhKgI3EvWjRsTlboIqV6Wrc+f170c8c43o0gJhgpQ+Sn/WqK+tag
         KoH7w1C8eLGN+rhF1asSXZa1O935ykgNfIojrG2/HX3mzNz7aiO1la2yCuGWjdaJTvYO
         ESET8z2x6ZQC9JUvwKI0c+WL/9Gh35bqed1KTk6AsrKkSgAiSbNVfreEIHzBPqVg0sed
         ivKUMv4Wa8Cs63+jwc9Qd5O4XPLsZA8tK3BMj84986vgG4lbjeYvhCk6OW+gZrpcUCGT
         bGkA==
X-Gm-Message-State: AOAM531aiEJr1yfx2/T8YP98XreSagwJPdnx7YtT437YJYUSTnHp13Rf
        9Es4c4+yH8TsGB/EeHzuLZbRs4m5V+6Fyw==
X-Google-Smtp-Source: ABdhPJyPtRwKs69JF9hKxq/2dBPlBqSM+tgtEOSLtwzARjSWfF85owuJ5QxUao1BiTFS8FP2WRT7xw==
X-Received: by 2002:a05:6830:1385:: with SMTP id d5mr6012729otq.295.1609183384612;
        Mon, 28 Dec 2020 11:23:04 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id r25sm9573863otp.23.2020.12.28.11.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 11:23:03 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/2] completion: make __git_complete public
Date:   Mon, 28 Dec 2020 13:23:00 -0600
Message-Id: <20201228192302.80467-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Everything is explained in PATCH 2/2.

Felipe Contreras (2):
  test: completion: add tests for __git_complete
  completion: add proper public __git_complete

 contrib/completion/git-completion.bash | 31 ++++++++++++++++++++------
 t/t9902-completion.sh                  | 20 +++++++++++++++++
 2 files changed, 44 insertions(+), 7 deletions(-)

-- 
2.30.0.rc2

