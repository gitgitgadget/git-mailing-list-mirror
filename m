Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CD3C4338F
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 08:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C8EF60C41
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 08:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbhGaIXV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Jul 2021 04:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhGaIXS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Jul 2021 04:23:18 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA934C06175F
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 01:23:11 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b7so14392178wri.8
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 01:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Codb7u1Bz9Ag8SAPR6hTzawr6V6+KYMzrfyNAR09GI0=;
        b=TpCWWkkOuFgLlH2SbTj/YiCI25t2C1JkgFljdUd8G/CHc+0YZOnKa2q7kL7IUniuta
         KOBFuK1dYExZ5VwWQSJiku0Ii9xuwCdIk+uP+oM2AiaguVAqAZBEPvqFzR8bQOQs0O75
         KGw8kwakPO5mxds1VB/e3bLYEXR2rTngmpflRS5at1FNRtSSVi0j5Tvt0toensVZYVfa
         qj4jcQ6VW0CuyoHu8ulzvdZgNwjXt6w1WOrUcpSBWw+YKkvKRR+OsCLsK8MRCPfJ3irO
         zNaCdglpKojJE/gClZTJpxNcfwQHkcJrpMEBxJ19vA124QBBqnz8qtzEpKOOA8EsGD1I
         QJUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Codb7u1Bz9Ag8SAPR6hTzawr6V6+KYMzrfyNAR09GI0=;
        b=Psl0otNKh8vQjfTrvnsstJALi9MfQJ3Uy8U1pKGiIFQv0HHasPhbdqa4FO61hRp13F
         CefH0MD6iWskNz2+Dl9KpwHHt4I2vQfCtdGlH+CHHkSgd3BOwPpi2aCwSQ6l5M3LRvkV
         9GrPMGzlQY+KTxcgmqrgMBfwN/buDPMmU1HNevEm6HAxaciGubVjqUV1heIilF0I65Oj
         AvVb23gObQ2mE9Bmn8VWW0Lv4TFbXjpSmdq/ppMvtXuZtOT4CnlWSYljMEt+RXhk69DR
         RPbuwvBpK6hVsVxIaBAkpOWzgo9tdkG3lVGcEcd6PSAj0fzHth4Co6/smFSbOfHB/HWa
         AK9A==
X-Gm-Message-State: AOAM531y3iSIvxWk2Rn0178QvdyTOBjbq8CHQVuHoBF/vVZRedyQXFPC
        iURRyZvdtYS3Jcfw0ta9Axr1EEpFYdE3BQ==
X-Google-Smtp-Source: ABdhPJx5gIxOTBbUkJAJ+m4cEzmtA3vY9cRFsVUhsxiA21vvM0n0290Nfy7EGbSi9iXJlr5xleb1HQ==
X-Received: by 2002:adf:f512:: with SMTP id q18mr7293386wro.305.1627719790015;
        Sat, 31 Jul 2021 01:23:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n11sm4877548wrs.81.2021.07.31.01.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 01:23:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 0/3] bundle doc: generalize & elaborate
Date:   Sat, 31 Jul 2021 10:23:03 +0200
Message-Id: <cover-v8-0.4-00000000000-20210731T082120Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.1069.g545f0888808
In-Reply-To: <cover-0.3-0000000000-20210727T002001Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210727T002001Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As mentioned in v7 I got rid of the comparisons of the bundle header
to the format of show-ref:
https://lore.kernel.org/git/cover-0.3-0000000000-20210727T002001Z-avarab@gmail.com

Except I managed to miss that it was in two places in the series,
sorry. Here's an update with what I meant to send in v7.

Junio also mentioned it being confusing that we mix "basis" and
"object prerequisites", I agree, but wanted to keep these changes
minimal, so I wasn't rewording the existing occurances of "basis".

This now has a minimal patch-on-top which follows up and rewords those
existing and moved-around occurrences of "basis" to "[commit|object]
prerequisite(s)".

1. https://lore.kernel.org/git/xmqqa6m69uvh.fsf@gitster.g/#t

Ævar Arnfjörð Bjarmason (4):
  bundle doc: rewrite the "DESCRIPTION" section
  bundle doc: elaborate on object prerequisites
  bundle doc: elaborate on rev<->ref restriction
  bundle doc: replace "basis" with "prerequsite(s)"

 Documentation/git-bundle.txt | 147 ++++++++++++++++++++++++++++-------
 1 file changed, 117 insertions(+), 30 deletions(-)

Range-diff against v7:
1:  b8f8a20e789 = 1:  b8f8a20e789 bundle doc: rewrite the "DESCRIPTION" section
2:  5f344bd24aa = 2:  5f344bd24aa bundle doc: elaborate on object prerequisites
3:  88e7ad1cf49 ! 3:  0e702337c7f bundle doc: elaborate on rev<->ref restriction
    @@ Documentation/git-bundle.txt: unbundle <file>::
     -specified explicitly (e.g. `^master~10`), or implicitly (e.g.
     -`master~10..master`, `--since=10.days.ago master`).
     +Revisions must accompanied by reference names to be packaged in a
    -+bundle, since the header of the bundle is in a format similar to 'git
    -+show-ref'.
    ++bundle.
     +
     +More than one reference may be packaged, and more than one basis can
     +be specified.  The objects packaged are those not contained in the
-:  ----------- > 4:  1f3dcd42863 bundle doc: replace "basis" with "prerequsite(s)"
-- 
2.32.0.1069.g545f0888808

