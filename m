Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC6FC433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 09:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC19861057
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 09:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbhDTJUc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 05:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbhDTJUb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 05:20:31 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6974AC06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 02:20:00 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id w6so10580304pfc.8
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 02:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mjEyFuiPGVEiA6+PSpMRAT7Vv9aBWpKDNrrAMp3Y5NQ=;
        b=Fw+h+Lqx3isZlVRDkwpbvKRvpI7bhIvpySIAj1H5EQOXpMshAgPyCb39wiIF3KlYH5
         0uDJNEb+oQOjBkBfiDfsx3atCQUIuRr1M3bzlumOXYtPDk16phnfG9qVpfsn80LHQQvy
         tjda344s2pCZgIsmj7Ekk9a+zoM5QQCK6z7g40wNZoO+eCWst8HRov6Xo+Sq1dSIjBcG
         5eUT7Krvld4lqMKNRoZJNYSnv3Wbuf8hJYAgbJ0Um14oMgXSXfM3czVQWP0pX+73Yizp
         J7QMmd18VarSdB0IRoIMmL5nvFoBgm6LAa2/P4oOuuT3yaTNu7GDMZNwZ+orSpPy22GE
         dIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mjEyFuiPGVEiA6+PSpMRAT7Vv9aBWpKDNrrAMp3Y5NQ=;
        b=foFwzs8hJ/iqXqnR7JxnX8T+K2FBDr/P+7/uApWWKL4ig0SrqBZ7IN8XUsYSOBNP0n
         T9PVqfFT+4PGoQOg8e0EKO0B7zMHQgmidbRBsjXq/NpSRaOf2uFCae3P65NdDxVD67ej
         pLmZ1fvgyEWCGoX+bqPqPXqIR6+FrjtiwtAAmK8YeRMOg6GvynltGuicwdjlDIjPWDe1
         ZNyRsoWd9l4IUu7d2wxQ/JKucvfFhBBWcIZupPHX3ZJ7sI8bIJJ3nbwsglF0ITv3g+3y
         L+SPOV+F7sohGAvtPnmVlg86LKhpG9nB0AJBgRjBfgApT/rINt4BA4tn8lrnqv7HrxVo
         DUqA==
X-Gm-Message-State: AOAM5320Zblpk58ZXFm381dN2cCFdhwn7+EtKnEe6WLEYY9t8GTfS+gZ
        aD3q7B13HgkVet2N0O+7LxYKn3sQO30=
X-Google-Smtp-Source: ABdhPJwTK4gKUjvsdNyNByS+qj78wtoFCd1oFqggeqzVUZ7xlvaEQJbemNyzRbEbA8I63n8t4HddPw==
X-Received: by 2002:a05:6a00:16c2:b029:228:964e:8b36 with SMTP id l2-20020a056a0016c2b0290228964e8b36mr24468580pfc.11.1618910399650;
        Tue, 20 Apr 2021 02:19:59 -0700 (PDT)
Received: from archbookpro.localdomain ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id k15sm15247630pfi.0.2021.04.20.02.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 02:19:58 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/5] git-completion.bash: fixes on top of 'dl/complete-stash'
Date:   Tue, 20 Apr 2021 02:19:46 -0700
Message-Id: <cover.1618910364.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.31.1.424.g95a8dafae5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gábor pointed out some potential fixes what's currently queued in
'dl/complete-stash'[0][1][2][3]. This series addresses those concerns.

Sorry for the long wait, I've been quite busy over the past month.

[0]: https://lore.kernel.org/git/20210327183554.GD2271@szeder.dev/
[1]: https://lore.kernel.org/git/20210328103134.GF2271@szeder.dev/
[2]: https://lore.kernel.org/git/20210328103057.GE2271@szeder.dev/
[3]: https://lore.kernel.org/git/20210328110427.GG2271@szeder.dev/

Denton Liu (5):
  git-completion.bash: separate some commands onto their own line
  git-completion.bash: rename to $__git_cmd_idx
  git-completion.bash: use $__git_cmd_idx in more places
  git-completion.bash: consolidate cases in _git_stash()
  git-completion.bash: consolidate no-subcommand case for _git_stash()

 contrib/completion/git-completion.bash | 118 +++++++++++++------------
 t/t9902-completion.sh                  |  19 ++++
 2 files changed, 80 insertions(+), 57 deletions(-)

-- 
2.31.1.424.g95a8dafae5

