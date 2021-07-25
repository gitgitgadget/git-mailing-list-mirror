Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2FBC4338F
	for <git@archiver.kernel.org>; Sun, 25 Jul 2021 12:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B86A460F26
	for <git@archiver.kernel.org>; Sun, 25 Jul 2021 12:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhGYLlg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Jul 2021 07:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbhGYLlf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jul 2021 07:41:35 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C92BC061757
        for <git@vger.kernel.org>; Sun, 25 Jul 2021 05:22:05 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id n10so8513848plf.4
        for <git@vger.kernel.org>; Sun, 25 Jul 2021 05:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=vrQ33mqXGMyygEQOyeRag9YL7RKHl2kkqR45ZBJxuhY=;
        b=JYdLSXj2SfJw5OeIvkaKPgs4lEsFzzi/WJqkZnISHQMEK5fe6stQfLdcdw4URiPLK6
         +jRpruQsIxqmepFv15xyz5WgW7LBqFNMSYpMLywAY4b5IfUtNeSdCssGeS/9Ek4GpjMC
         A6pY9+0A5JjM9Manl6vVhiVzwK19H6AcvbY0nsdNb8j11KfuonS4/Gu6Y3eU7OmYLErU
         7GCUBbB2FL6IQ4R+OgeubqgwMTbjY/kkdZixqmlF0PzY9+pwLhPGkiXV9wquKIeTr9vu
         PtqAolKI3FYNOn8V9XwyUD0sfVFSrpZyW6gKsHKisgBwmtqFluS64s4cCeRszX3dO7/X
         Wxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=vrQ33mqXGMyygEQOyeRag9YL7RKHl2kkqR45ZBJxuhY=;
        b=S2UCugbAQbeMCcJ13Ud4fhhEfw5hm9JqJPgqvPEXZIl83vdaXpWs2EdtaX5BiSoDtQ
         KheS8Gpy0Cy/GX/RBLgyJ8FX0HT69VoHpSzVBGHMPS/bgiMlfDjE4ARrmRWL2g8B+KNi
         tTMvUUIigK4T0ivTwS8VpT87Ib4c2NiqX210D15FGfeiQXFE928k3ga0xYPoEqDc1WN/
         0LQtzJ920Ht5YuIklbKQ+4QxStyvV3GgcqWhm7bptnTKefWX5xHBAZdXnFZDmPFNGiEd
         2A9x0Q6T8plx3GNuU8tj4CslwXV7S3TCTKH0D4vezLsAWXh3FWqdLQ9u7IFqirS+drxE
         Z+DA==
X-Gm-Message-State: AOAM532Kh/8853mSveOqpDOenVwwUNimzmiRjEIJm+4JayT8y33WMvJm
        rytV7hZhUsIf6nrgZQ8BSX6ceSr1+F96iQ==
X-Google-Smtp-Source: ABdhPJzaol33lS6AktqpeLZRxt1KEszs1WTPsa6THOaHzOZ8eGsl6Ho76jhXqATPe6G/vSc2ZDuO2Q==
X-Received: by 2002:aa7:8704:0:b029:328:c7ca:fe33 with SMTP id b4-20020aa787040000b0290328c7cafe33mr12779699pfo.12.1627215724695;
        Sun, 25 Jul 2021 05:22:04 -0700 (PDT)
Received: from [192.168.0.46] ([119.82.121.47])
        by smtp.gmail.com with UTF8SMTPSA id u3sm11006210pjn.18.2021.07.25.05.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jul 2021 05:22:04 -0700 (PDT)
Message-ID: <90b6bd2d-71e1-b8af-e027-8023f8d4f14c@gmail.com>
Date:   Sun, 25 Jul 2021 17:52:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.0
Content-Language: en-GB
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        avarab@gmail.com, Emily Shaffer <emilyshaffer@google.com>
From:   Atharva Raykar <raykar.ath@gmail.com>
Subject: [GSoC] A small survey + My Git Blog, week 10
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

Week 10 of my Git blog can be found here:
https://atharvaraykar.me/gitnotes/week10

As for the "survey part", jump to the section here:
https://atharvaraykar.me/gitnotes/week10#the-mailing-list-developer-workflow

...feel free to reply in this thread.

A preview of the other contents of this post:

- Project progress (relevant to mentors)
- Me trying to find a good MUA to work with Git:
  (https://atharvaraykar.me/gitnotes/week10#blooper-of-the-week-woe-is-email)
  [responses to this appreciated as well!]

Have a great day!

-- 
Atharva Raykar
ಅಥರ್ವ ರಾಯ್ಕರ್
अथर्व रायकर
