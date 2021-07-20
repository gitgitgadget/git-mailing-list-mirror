Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC36C07E9B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 14:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FBD0611F2
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 14:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237295AbhGTNqm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 09:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240214AbhGTNkl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 09:40:41 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268CAC0613E1
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 07:20:31 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id c17so5337178wmb.5
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 07:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oOX4EeBNxVMn4u3V7Cv5nyxqvmKyv37jmj5mY5GHheM=;
        b=uZq8j2nZM7iWLh5aMLWrfLzlQ412ov3V5kInSIYxsopPHmqcUghsMGg24dt5qN89x4
         aDrB9Es7r9m250RSpnHOo+KFLJ9iZ3L7xkTltYsmpZzhJtiKXNIqu+35Z5pY3ZlYMLei
         LlZCBSaD+ZHPIeS72WHvbV+TjswxjB7yWte9UnGzZEXH3FDciGVchcU2PAmqoW93OVEm
         TXjboXqqotRmyc4lUMk2iyWA/+wTdllfuJ1cwI2yFoREjLMIQU0rHyPDb8SQbupxn9s0
         B/ZNo6WtQF8QW3tQNNm/yARZEfhsS48UaM5OjhiQqBate9WsCze7Kn8wmcEXLflwRhsZ
         3iRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oOX4EeBNxVMn4u3V7Cv5nyxqvmKyv37jmj5mY5GHheM=;
        b=rjMO06rZ8QZlNbg+DdOnaO15M662W/kCYRxFGf5RUUdNvWBeYke/YifXCZrUTpQfn6
         adOaaeVvUB4In78y1DkxmOBzBd8ZWOentIYA4xxGRRwhfsooQSTYDZasrzEnHGpEfQuj
         1UTaYw90dUNzO+CCVHSqEC7+ziVrMZMB45ItcqTuBPWnFV0P1Up1F995OtZ2PTZggLBT
         Dy2oxI4dYBsq3ThU/uvtQLc0TlNh/gn7W2VQ8Fu0DVnEhWUD+gGR5ofAyr08BCzAuC3R
         tHVv0WmP8ExXRxt7NQTyus+ZuVc5wPFM7x8dKbufPUfZi+w1V4gPr5Vnb4kZFVwrYJJF
         qNHg==
X-Gm-Message-State: AOAM530aq71Tjb1JK5TkhEC8A2iitqBsUPOGtC/VpGkGFZJqJ8hAMWJG
        DajEFHP1689w3PK8icDaj7zG+IjUEErnOw==
X-Google-Smtp-Source: ABdhPJzK1vDC3HXR6hEIgcWGOe06gV8wromsNkQWxiEQI25jQEdDaPkGWxRzzceqOq8dYJZanG/zlg==
X-Received: by 2002:a1c:6a1a:: with SMTP id f26mr32415275wmc.61.1626790829439;
        Tue, 20 Jul 2021 07:20:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c2sm23785370wrn.28.2021.07.20.07.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 07:20:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 0/3] bundle doc: generalize & elaborate
Date:   Tue, 20 Jul 2021 16:20:23 +0200
Message-Id: <cover-0.3-00000000000-20210720T141611Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.ge7a9d58bfcf
In-Reply-To: <cover-0.3-00000000000-20210702T112254Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210702T112254Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A v6 of improvements to the "git bundle" documentation. See
https://lore.kernel.org/git/cover-0.3-00000000000-20210702T112254Z-avarab@gmail.com/
for v5.

Junio, I think this addresess the points you raised in
https://lore.kernel.org/git/xmqq7di8rbtj.fsf@gitster.g/

I used your suggested wording, but changed "empty repository" to "a
repository with no common history" for the purposes of the
documentation that's trying to talk about what you can unbundle where
without ambiguity.

Ævar Arnfjörð Bjarmason (3):
  bundle doc: rewrite the "DESCRIPTION" section
  bundle doc: elaborate on object prerequisites
  bundle doc: elaborate on rev<->ref restriction

 Documentation/git-bundle.txt | 141 ++++++++++++++++++++++++++++-------
 1 file changed, 115 insertions(+), 26 deletions(-)

Range-diff against v5:
1:  3b447500da9 = 1:  d5360bb6f74 bundle doc: rewrite the "DESCRIPTION" section
2:  444b06740bc ! 2:  a0f95ce3a1d bundle doc: elaborate on object prerequisites
    @@ Documentation/git-bundle.txt: contained in the union of the given bases.  Each b
     +OBJECT PREREQUISITES
     +--------------------
     +
    -+When creating bundles it is possible to create a fully self-contained
    -+bundle with all the prerequisite objects, as well as providing
    -+negative revisions to exclude prerequisite objects.
    ++When creating bundles it is possible to create a self-contained bundle
    ++that can be unbundled in a repository with no common history, as well
    ++as providing negative revisions to exclude objects needed in the
    ++earlier parts of the history.
     +
    -+A revision such as `new` will produce a tip with all the prerequisite
    -+objects needed for the `new` reference.
    ++Feeding a revision such as `new` to `git bundle create` will create a
    ++bundle file that contains all the objects reachable from the revision
    ++`new`. That bundle can be unbundled in any repository to obtain a full
    ++history that leads to the revision `new`:
    ++
    ++----------------
    ++$ git bundle create full.bundle new
    ++----------------
     +
     +A revision range such as `old..new` will produce a bundle tip that'll
    -+require any objects existing before `new` to already be present in the
    -+repository performing the 'git bundle unbundle' operation.
    ++that'll require the revision `old` (and any objects reachable from it)
    ++to exist for the bundle to be "unbundle"-able:
    ++
    ++----------------
    ++$ git bundle create full.bundle old..new
    ++----------------
     +
     +A self-contained bundle without any prerequisites can be extracted
     +into anywhere, even into an empty repository, or be cloned from
3:  6d8f2f27088 = 3:  6d66d4480ff bundle doc: elaborate on rev<->ref restriction
-- 
2.32.0.874.ge7a9d58bfcf

