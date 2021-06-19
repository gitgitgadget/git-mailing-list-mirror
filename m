Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910E2C2B9F4
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 13:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 719C56135A
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 13:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbhFSNem (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Jun 2021 09:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbhFSNel (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jun 2021 09:34:41 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEB5C061574
        for <git@vger.kernel.org>; Sat, 19 Jun 2021 06:32:29 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so5452642pjo.3
        for <git@vger.kernel.org>; Sat, 19 Jun 2021 06:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=fSOnboNy2OLFxOTDPvrE0rLMM+kgYRieWOMwRwdWHb0=;
        b=kUx1cEvq2ypaGcx74YQOE6rNB0/8oUbNwQsMIeFw2kNzLWPwXJTC9h71qtdj3UHHLD
         8amFQvaZKTDTxftkIgXZVTnkqWisxtO2FLF462rxDvGROZl5dJxZpRbxtDAkzDXzmg/A
         WEGRrmhsJdolgg1mvr5IsTPx9L7JP75bL5EBI96AQUP2O9eRs1daH+2clNmUO3Ep+0kn
         mnv/Q9iXDogzQ3CzsUzEHqrztYE7I059RJrAVR9M2rZJ1vaUz1Fi8SpQIKK+84abTrSf
         jP6KlzqQ7FPn8WOqq917v9JsZtC9NgApqE9l9TB2ldOawkbJcWPxNbB04WlZs8YA3AOy
         9BPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=fSOnboNy2OLFxOTDPvrE0rLMM+kgYRieWOMwRwdWHb0=;
        b=m4W++6cl1HAKDQE0WWNA64fHV2FKgiyZm0SRPO7boAIaM8BId8KhEQ9cRpBV2EBw8n
         HF+lcOR8c6r7tyXtjcRiad6HCHVd18HS+RuSM5TpPXZ4SJPasmga6y72AipFSMKoN3Uc
         ojQ0aNm83Dxe5kYlSsYY/Xy90YDmAraprVIGZYG+OzQdXsVTn9KmLwJCPxLycHGj3w3A
         N6EVRzjTiAi+N34dJ0DtcslSakMzTRyukPvm04n7PDRDz7nn5U1Ws+yZ2zyg8nueNtGk
         CeXaamAkz+TnpQ4MuOT6tass6LAoeXCtR7ot1SxFGmGfJHvkPQ6c8UOK+chISV77No5A
         eJDA==
X-Gm-Message-State: AOAM531aRA/HMRPJylikY7eSg2ifyOlQ51tiN99Hl6pkeze2VQdcRIyz
        VmCiWoJ/XD31ia5JH+UQfJmsdoHVwqV+ZuUC
X-Google-Smtp-Source: ABdhPJyYkkz8GytNZKmNFgKf0a9FxOu0tu9f2ePVd0y7axPznOBrUigw5adq3tzJRHXzTGxlChjYiw==
X-Received: by 2002:a17:902:8e88:b029:11e:b703:83f1 with SMTP id bg8-20020a1709028e88b029011eb70383f1mr9218952plb.79.1624109548774;
        Sat, 19 Jun 2021 06:32:28 -0700 (PDT)
Received: from smtpclient.apple ([119.82.107.60])
        by smtp.gmail.com with ESMTPSA id g18sm10613573pfi.199.2021.06.19.06.32.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jun 2021 06:32:28 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: [GSoC] My Git Dev Blog - Week 5
Message-Id: <D32894F5-FC76-4DD2-A2F6-E69AAE88C645@gmail.com>
Date:   Sat, 19 Jun 2021 19:02:24 +0530
Cc:     Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git List <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's the latest instalment of my weekly Git blog:
http://atharvaraykar.me/gitnotes/week5

A peek at what's inside:

 * The blog starts with a summary of all the relevant things
   that have happened so far in my time with Git, including
   the status of my submodule-related work.

 * A question I had about reading the index into memory
   (any kind of help would be appreciated!):
   =
http://atharvaraykar.me/gitnotes/week5#some-challenges-with-the-changes-th=
at-are-cooking

 * Reflections, mostly as a note to myself and to people who
   might be in a similar position as me in the future.

Have a great weekend :)

---
Atharva Raykar
=E0=B2=85=E0=B2=A5=E0=B2=B0=E0=B3=8D=E0=B2=B5 =E0=B2=B0=E0=B2=BE=E0=B2=AF=E0=
=B3=8D=E0=B2=95=E0=B2=B0=E0=B3=8D
=E0=A4=85=E0=A4=A5=E0=A4=B0=E0=A5=8D=E0=A4=B5 =E0=A4=B0=E0=A4=BE=E0=A4=AF=E0=
=A4=95=E0=A4=B0

