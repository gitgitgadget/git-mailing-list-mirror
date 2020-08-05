Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DB5C433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 22:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C294422CAE
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 22:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSVSr+Ln"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgHEWIy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 18:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgHEWIu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 18:08:50 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B78FC061575
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 15:08:49 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id t23so25960650ljc.3
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 15:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ew1wCNw5tF6q5EgrnNUTLW9o7GeUKivK/iISo3ZzTBc=;
        b=BSVSr+LnOrO/ZMQ9EaCucp3NJWT1ZpemTpZ8SzfFRwVT1zgg5cIRAKsApFZ3Sf10MZ
         7l05oJMkNRw7aaRZqNl91PFbZvz8H5u+Zgjr10/Zbnhh+Pn/hYPLOiWkyFzu1s2dy23v
         8ZMdPlDkqs/iLBV5la2A20tPrMAZHtvwTlfEQ/N8tCOprZXBQdD0IKdmkt3kEL5HA17J
         QoYlf3U6tmtSN1QhjfGDHrdbDRVJYbGyK0IU6q1zpStdwFG3kHpqL6ply5lJC8GFDCs0
         yRMHIikKHU2Hc7qgcGatJfnex26P+VpeNXrJYRspCZKpY9ta6eoG0vEqEF2BzoQrTq2n
         KZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ew1wCNw5tF6q5EgrnNUTLW9o7GeUKivK/iISo3ZzTBc=;
        b=V4jkOoKy9bHEt8xThrmLhfboFAYYYiRPHjLYbv4O9wk6gfPIRlYWXVMHfGHaCXgjoV
         IXDvxMXvJJ8iMoS4n6k6v75HIemLP++2JukReqBbg6zwnYo/gX1cyQxBCosAtTHt6Fr9
         8dADEmg+E/TfnH/nwkFmLUFDwQHzX5BKpAr9z6Ftf5UuttO5t9DAzpoLHYWtY2UAm9nl
         Lsozww+CWmg+PmpK8BqRzlLvQUzKiP+pTAiyEuF7ly+PWK0fXsga2OVYN/r2XgVjaa08
         oB9etg8uqYEkNHrnUJRcniaDuGY4p0RdzbJPDGu38BrH859llQS8ctUbLBFEGM/+C+nU
         6n0A==
X-Gm-Message-State: AOAM531pialtrk41+09Htn2zktQmbGjd+FfLEqjkGEIL18jvESzdEJrH
        qdmxLpmeccU22rUQJ5lp4Ow=
X-Google-Smtp-Source: ABdhPJxRH507xn1/fTjpHgoNGXv5dUpim9loXp9tdb0z64sDm7bml5WO8o6JGcJyOxK8fr5D7Zj99g==
X-Received: by 2002:a2e:b80b:: with SMTP id u11mr2494290ljo.286.1596665328082;
        Wed, 05 Aug 2020 15:08:48 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id g18sm1544183ljk.27.2020.08.05.15.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 15:08:47 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH  0/3] Change "--diff-merges" to require parameter
Date:   Thu,  6 Aug 2020 01:08:29 +0300
Message-Id: <20200805220832.3800-1-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches present a minimal set of changes to turn --diff-merges
to require parameter. For now we only introduce --diff-merges=off as
synonym for --no-diff-merges.

These are on top of jk/log-fp-implies-m "making --first-parent imply -m"
by Jeff King, that introduced --[no-]diff-merges as a boolean option to
provide ability to override implied -m by --no-diff-merges.

Sergey Organov (3):
  revision: change "--diff-merges" option to require parameter
  doc/git-log: describe --diff-merges=off
  t/t4013: add test for --diff-merges=off

 Documentation/git-log.txt                     |  6 +-
 revision.c                                    |  9 ++-
 t/t4013-diff-various.sh                       |  1 +
 ...--diff-merges=off_-p_--first-parent_master | 78 +++++++++++++++++++
 4 files changed, 92 insertions(+), 2 deletions(-)
 create mode 100644 t/t4013/diff.log_--diff-merges=off_-p_--first-parent_master

-- 
2.20.1

