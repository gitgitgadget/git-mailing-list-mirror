Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1480C48BDF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 13:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3F0061153
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 13:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbhFMNk1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 09:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbhFMNkZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 09:40:25 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192B3C061574
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 06:38:08 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id k7so8244199pjf.5
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 06:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=5je3ZZs4tDZmN+jN5PRojIqKaIzKJ50KM9mYU+0otqA=;
        b=UT84Oc36erUIhWdxKa1QnyX+W1XwyAv7ds5c6NnXO3N0YvWHa6zePF6s9/4HhMUwEs
         ET9rt4A/AXNEXvGAoA0KVFu94E6aIS2AZDevlQXTe4eH9tVIRmAw/oj+ZHMdKxBC1p1x
         k9ixmjAiImuY13HvoTzsWvt5KFc6lcqAN56iPTJiEM0qtauGqtJg6d5VfgGLDK+Qxonw
         VJfhEdPEfGH1d6OklSfRAH45jSFP0D6lNZfR+JcsS4lf/TPjQjJgInPn+0+MPSlOKdWs
         m1yo0PZP2EpP/smzUN9godzuRVzlmS8isu7w/uq+wPIQe3NRe4trBN8znFDCG0BY4vMG
         OdcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=5je3ZZs4tDZmN+jN5PRojIqKaIzKJ50KM9mYU+0otqA=;
        b=TfJSLJHpjOsjrl+jvc30sLUF3J2YUnTu1Jb42BTZzAK0zXHIoCnFvrVp2PMxj+6/Yg
         7QzI7FsHBEoUduDD2S7ymfR+nMAWrpZmTU3KmsJDEPku/heRkG+ys3zZDaLj4PAp/g4p
         NLfi1uQuCjlCFrceZx1TUv5/MKUtBYlaAhUiZhkSU3jMeZLhNUI616/RW9ynabJDBbOz
         H7P/rSl3uKGSqPYiVavHTXKN7ankuOi771ixoMrlgbptBj2A96lXTwdPLSXiDkg5HjUi
         gY9ydjPasUQn8qbIRrCQRJusDyE/uo1eebAnt9Y0+sSKBhM9umuqPnKmhLagyjVf+GV6
         6PqA==
X-Gm-Message-State: AOAM530DTdVAKos3n2SKZehd+Q+7vnx7m4ZsghH0P+/Isi6IvME6bsN1
        FxBruBFPihyTRVCHMbWznQD0C8l2DdI6AmqtoSY=
X-Google-Smtp-Source: ABdhPJwtgvt7AF9FQ91ivsVH+4PCev5HPZAUaXf2e9wjFcSZwGmDJd7OTI6UHG7b+RwHiWQSt46obw==
X-Received: by 2002:a17:902:9a01:b029:11a:d4e:8f4 with SMTP id v1-20020a1709029a01b029011a0d4e08f4mr5473823plp.52.1623591487340;
        Sun, 13 Jun 2021 06:38:07 -0700 (PDT)
Received: from atharva-on-air.dlink ([119.82.107.60])
        by smtp.gmail.com with ESMTPSA id z3sm1636294pgl.77.2021.06.13.06.38.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Jun 2021 06:38:07 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: [GSoC] My Git Dev Blog - Week 4
Message-Id: <155ED50C-F11A-4ACC-A8A5-C31896449348@gmail.com>
Date:   Sun, 13 Jun 2021 19:08:02 +0530
Cc:     Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>
To:     git <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

This is the fourth instalment of my blog series:
http://atharvaraykar.me/gitnotes/week4

Here's an overview of what's in it (feel free to only skim a section):

 * My Progress and what's next
   (Relevant to mentors):
   Section link(s):
   =
http://atharvaraykar.me/gitnotes/week4#what-i-have-done-since-the-last-pos=
t
   http://atharvaraykar.me/gitnotes/week4#whats-next

 * An obstacle I'm facing with converting an ls-files invocation
   (Relevant to: people familiar with the cache internals. Help is =
appreciated!)
   Section link: =
http://atharvaraykar.me/gitnotes/week4#current-obstacles
=20
 * just some thoughts on being ok.
   (Relevant to: future new contributors to Git, but mostly myself)
   Section link: http://atharvaraykar.me/gitnotes/week4#i-am-just-ok

 * On obviousness and new contributors
   (Of interest to: All potential reviewers in the mailing list)
   Section link: http://atharvaraykar.me/gitnotes/week4#on-obviousness

Have a great weekend!

---
Atharva Raykar
=E0=B2=85=E0=B2=A5=E0=B2=B0=E0=B3=8D=E0=B2=B5 =E0=B2=B0=E0=B2=BE=E0=B2=AF=E0=
=B3=8D=E0=B2=95=E0=B2=B0=E0=B3=8D
=E0=A4=85=E0=A4=A5=E0=A4=B0=E0=A5=8D=E0=A4=B5 =E0=A4=B0=E0=A4=BE=E0=A4=AF=E0=
=A4=95=E0=A4=B0

