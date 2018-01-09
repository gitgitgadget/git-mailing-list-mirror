Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEC4E1F406
	for <e@80x24.org>; Tue,  9 Jan 2018 15:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756992AbeAIPRq (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 10:17:46 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:40509 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751263AbeAIPRp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 10:17:45 -0500
Received: by mail-wm0-f48.google.com with SMTP id f206so21289417wmf.5
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 07:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:user-agent:date:message-id:mime-version;
        bh=Kfd+EF5Qi7d5LDrohuUtWN33iO6zDfjhnHKOYDcmlu8=;
        b=nGp11b2llvNm7ywRZsn/VDgX0Qx02/kAs/QgjjgKUMw/zee9nK/kQ81yqvaq1AEKhc
         FTALTktVym1yjGQNC00exDTl/ciSuWYXBrISTa4tqkF2MuyuoF6REN6HyRc/KiZDQKnl
         Z/ZE6+q/7YA91PyjrjsiJZEmdf+jlbJ7vMjt7xA/z5/sXRLAgU7raCn2Y9Gg3ZlSjS3L
         KjCAQq8RCuNx0qU0ig37lCTWPUkirTfzQcOhw6lQinuNPRswXN2vYPs0f/q0YCs7nx8K
         qKH4NNgZrQsb97siPq+EVxu/FbcEmkS9JlbPu7d5rPj/k4LpNWOzIM9psKMhgvARB/C6
         CJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:user-agent:date:message-id
         :mime-version;
        bh=Kfd+EF5Qi7d5LDrohuUtWN33iO6zDfjhnHKOYDcmlu8=;
        b=mJmUmN5lFvgRFr/1BFFfOry06xF6aqCMVXbI6/lqdv0njgysUxY+xsPS5DRW8dFgZ7
         aFUE9P/m8bzxHWdFf0FmmzCgiabQq+gxO15F2zuH9q0Eqcpl+/7ogTwhpWtlzo2Sz1nc
         PtAVG3+6Z4imRjzyN9TdLmeTUsL+uxmaWOO6M9V6F0/zXihGE6cky9tn6a5gHohHvbV7
         8r0X0oYHVNd1ZNqG9CJLglkUohDON5hNi1THSs/fi9hI3sinpTaXvuYnaHt91pdNBpdA
         dU61vsYXv/Rrwg0ur5RyRSD8mKWCcNQ5o5yqFRYCsR4sp88z5eOEmkCiEcGg0EPIYfxu
         0z8g==
X-Gm-Message-State: AKGB3mKOCZAAb4mFZVrfbQl5tOtefeK14x6bYbCeP1nyLiEf6kUZENuz
        q1BTC90nYgL3r+EUrYF1XxwicSAN
X-Google-Smtp-Source: ACJfBouTeLdvCv3E8uT1JkMqqk2jMvym1zbTMEozTlkWEeKShGPZ12rLdcFA0pv5H3kWIqAbeykT4Q==
X-Received: by 10.80.182.38 with SMTP id b35mr21510270ede.273.1515511063788;
        Tue, 09 Jan 2018 07:17:43 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id k18sm8394943eda.20.2018.01.09.07.17.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Jan 2018 07:17:42 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Thomas Rast <tr@thomasrast.ch>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: merge-base --is-ancestor A B is unreasonably slow with unrelated history B
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
Date:   Tue, 09 Jan 2018 16:17:41 +0100
Message-ID: <87608bawoa.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a pathological case I don't have time to dig into right now:

    git branch -D orphan;
    git checkout --orphan orphan &&
    git reset --hard &&
    touch foo &&
    git add foo &&
    git commit -m"foo" &&
    time git merge-base --is-ancestor master orphan

This takes around 5 seconds on linux.git to return 1. Which is around
the same time it takes to run current master against the first commit in
linux.git:

    git merge-base --is-ancestor 1da177e4c3f4 master

This is obviously a pathological case, but maybe we should work slightly
harder on the RHS of and discover that it itself is an orphan commit.

I ran into this while writing a hook where we'd like to do:

    git diff $master...topic

Or not, depending on if the topic is an orphan or just something
recently branched off, figured I could use --is-ancestor as on
optimization, and then discovered it's not much of an optimization.
