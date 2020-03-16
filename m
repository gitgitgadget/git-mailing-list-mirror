Return-Path: <SRS0=/LSK=5B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F52C0044D
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 03:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E739120663
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 03:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="iZ9CUG9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbgCPDri (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Mar 2020 23:47:38 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:43417 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729387AbgCPDri (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Mar 2020 23:47:38 -0400
Received: by mail-qv1-f66.google.com with SMTP id c28so8072937qvb.10
        for <git@vger.kernel.org>; Sun, 15 Mar 2020 20:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1htkrf2tkT/2ZRf8itOAWGfY/nqTGnUak7dxqoZXD6Y=;
        b=iZ9CUG9TUxP08JhlKpgtLVmTAd/Auq1LmDZFbM3PWcLhkfphDwpAJIJnsZmGbYKZn6
         jvoz0ecggvuZWcwGi19HAB7IkrJzuKX+f8/g6IRUL1YkoiDRDJswEhwn3jStMbzRaKqV
         rC7FZwzXGowajYWZ922/NHvgOeBgEtHxmJNdoENLgQkVDw7BH7oAUD6F0PwroHR51YFm
         elQ4fJzHbAJfSUA4Mh1Is/jG72EiAmxv7esd6UVw5bj+MZqq+cfVxTwWugMjaF5q0hVo
         0Y2Nr5u9icMiXjKJmSMV0NGPOAadMLEVtFMQNqs5yli2257uLZaGt8C5qIN+mFkcfxMG
         ycQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1htkrf2tkT/2ZRf8itOAWGfY/nqTGnUak7dxqoZXD6Y=;
        b=V9hykPRkWtsPCPfdDT54n1AwwVpkXivk163hReuJYj5z5CPDYgkK2uc4nMgaRop3wv
         HU0YtnOr6tuCNiZZhmjjHBV2R/y1zyNtxc1lszBqlKutxOQGnKlEnLS0tWbERKmNPhDM
         XzBDpPSxZO7rkd7ORQwb7JVf+0/gfkfr42Eu4CNlP1UioukSulQMeYlcaUZewvTaqArd
         ZBCHSVs/lirCQcJVbQ4gYuw1gT40ACoslIX41o3pSuxlvqMMCV7EnsXpANhnKNw+Kf+l
         uZqogoac11XicmtWQU22VIaSFGtXno3JtUVdVaY0zPS0cnWokrTuKEF9ZmjhITqYSoW5
         Xbqw==
X-Gm-Message-State: ANhLgQ384jPF87qdYUfqOqESrhR1MHLyhKnEUyP5pMnNQ1rFSotCjwgY
        jJ3Lq9kN3Mz0EKHL4+uD7di62E8VG2k=
X-Google-Smtp-Source: ADFU+vuAjhHfS2TIOGxObN42IkmWZ95sRl2IBmT+hl9xXGU2IBPiH9/QJQQdPL2X85HaVyZO05ipXA==
X-Received: by 2002:a0c:eccb:: with SMTP id o11mr22846581qvq.129.1584330456441;
        Sun, 15 Mar 2020 20:47:36 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id r3sm3705930qkd.3.2020.03.15.20.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 20:47:35 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH 0/2] dir: update outdated fields and comments about oid_stat
Date:   Mon, 16 Mar 2020 00:47:25 -0300
Message-Id: <cover.1584329834.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 4b33e60 ("dir: convert struct sha1_stat to use object_id",
2018-01-28), we renamed "struct sha1_stat" to "struct oid_stat".
However, there are still some comments and struct field names which
refer to the old sha1_stat. The two patches in this series update those
places to avoid confusion.

Matheus Tavares (2):
  dir: fix outdated comment on add_patterns()
  dir: improve naming of oid_stat fields in two structs

 dir.c                                | 35 ++++++++++++++--------------
 dir.h                                |  8 +++----
 t/helper/test-dump-untracked-cache.c |  4 ++--
 3 files changed, 24 insertions(+), 23 deletions(-)

-- 
2.25.0

