Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEEEC433E0
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 00:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9554E64F5D
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 00:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbhCPA4r (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 20:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbhCPA4a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 20:56:30 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4EFC06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 17:56:30 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id q5so8845912pgk.5
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 17:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g0UfENVx6lA1VfbV4XnJlJdbLG4QbjLVJw09EP5xKgo=;
        b=JvO1jcq2kE22DOpo3Oub8lORI4hWzOHHfnVJZveE8n7pHuQM0qJUvrasaC1XfYR6kV
         MveWweFGWWvjW3qqEdUJjyopxHp6rdHW9hFJBKpeqbe86Bthq90TrDRakozOxMRF/ugp
         OSBfgPh9tPjyOSxA6mqKPwXmn1biUiOyOLTG47cmkFmnaVVN3jKyGDzOAtsVbSvtDNhs
         TQ93x8JZk+3nF+g9SVRrJfr4F50aM4GtaB2eKZQsfFh+nufLZIGUA6yCVTyBfDe7Fp3C
         /flIMUmcA3jENk8EC+LFuDMTyfJFQDwywLSkacdmgDw6LKdLisVt9tU+ior/2/rBhAAg
         Hlag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g0UfENVx6lA1VfbV4XnJlJdbLG4QbjLVJw09EP5xKgo=;
        b=YJnCzPBucAjkB18VIcuCdjPMtFvGI/uTT59NZDi5u0c2/4BirivwSd409S+5tzB06N
         RqnJeUU4LF4YsHf3HEiv22XG0u2V2HVA932Vqd4fixsLes9adk7uFW4mZIePfXbBSM8s
         XDbuuFaK9aqBrbCGqiKQRsSTKu97n7Vqu5Vss5H3TnIIiABftU+Y4BADOjnBGu6DD6/5
         KXhNfSgSBL22VYYUEKPKcRVoBvWdUKo5VSmZAxCvA8hLt3j9YOIKR36JiuLyroxLC83+
         Hnp0ZoRcsX1fC8DLzUJV0XCDICD2ACiBNi7AzNz/U/41uotXgibSmv36JHOYurpIvljy
         r8Cg==
X-Gm-Message-State: AOAM533L/3upWmdn7l5vB7XAJhipgpKa/wM0FB0gv/tLuVyFohUTilMd
        6tg2a+BkO83DpQ+TC6pr3Rk+lpvgfxI=
X-Google-Smtp-Source: ABdhPJzZIw2cUATGSK8sytOwUFVZZYg+xbchJYuAuXATlwMtNVHdy2ix/duveb2/I3tczn3O788Wyw==
X-Received: by 2002:a62:a507:0:b029:1ce:ddad:79de with SMTP id v7-20020a62a5070000b02901ceddad79demr12792546pfm.19.1615856189598;
        Mon, 15 Mar 2021 17:56:29 -0700 (PDT)
Received: from archbookpro.localdomain ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id h186sm14670312pgc.38.2021.03.15.17.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 17:56:29 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/7] Sort lists and add static-analysis
Date:   Mon, 15 Mar 2021 17:56:19 -0700
Message-Id: <cover.1615856156.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As a follow-up to [0], sort some file lists and create a static-analysis
check to ensure that those lists don't ever become un-sorted.

[0]: https://lore.kernel.org/git/nycvar.QRO.7.76.6.2010081156350.50@tvgsbejvaqbjf.bet/

Denton Liu (7):
  Makefile: mark 'check-builtins' as a .PHONY target
  Makefile: ASCII-sort LIB_OBJS
  builtin.h: ASCII-sort list of functions
  test-tool.h: ASCII-sort list of functions
  Makefile: add 'check-sort' target
  ci/run-static-analysis.sh: make check-builtins
  ci/run-static-analysis.sh: make check-sort

 Makefile                  | 30 ++++++++++++++++++++++++++++--
 builtin.h                 | 22 +++++++++++-----------
 check-sort.perl           | 31 +++++++++++++++++++++++++++++++
 ci/run-static-analysis.sh |  2 +-
 t/helper/test-tool.h      |  6 +++---
 5 files changed, 74 insertions(+), 17 deletions(-)
 create mode 100755 check-sort.perl

-- 
2.31.0.rc2.261.g7f71774620

