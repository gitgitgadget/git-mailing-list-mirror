Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC59C433E2
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 08:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94A2120C09
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 08:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tEoKaSHG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgIJI2y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730335AbgIJI1v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 04:27:51 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5801C061573
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 01:27:50 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id k15so4185823pfc.12
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 01:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UJ/LnA01rg+cAwxYZXo+BUaLnGtziQjaaX+SMFiEwd0=;
        b=tEoKaSHGAp3YUTPcbpL6JnATiJBu/UKz3WrPphdjeVOEwXpadNsNjmxGQxH5wfgsP3
         VLf4m9jthIoKo95aunKjUfOd/whdRK1QNkcdBBIuNtH1/pepzA1D8PyDqtDDWSeU3e3O
         Dca8N6MbePUT0+80CS8i5fAC/l60wLgdJZq446tOuEd0bzr5xwq+Ds3bYAerm+RMskIJ
         gg4AHtHNUEEm7fkFXV314/MkrbIHhjRVWI9KSR3NdV7GmsLcPzchLNsccw0SopCu1z3/
         MdFP0SHO4kZK5eqpAaouYjEVBKMbuFjJGNqukanvpYvwydTFg9LrkfzgMUv5zlXLuhAk
         dbZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UJ/LnA01rg+cAwxYZXo+BUaLnGtziQjaaX+SMFiEwd0=;
        b=R1LNyJaOngb4oBecS0+C3JreQxMubxjsMhbTtazvwo2rWSmGbAf7T7bqZ2n9nV3sea
         /fqB82mRBmDwyWYDg5j6vBL+TYYMKPjrCYO6+9bR6WD4zN4UePWNz3XYC7YOdQSXvZY6
         A8eATmrTtaoair846XdlItP36P8jQxa4oPXAdMpaT+HPEjAnUE1duZRsGHbryiIUd9jN
         +CCz1AwzS4XQ5Z1IdHe2I3BFQ/4X2J2yeXaMeSFO4uardcHeG0ty5hdYBd6A2PDJ7E2P
         YNSjoPNN4u6R2kzHL20QQjaKgRYWEPygSD9V1FGa/qqmc3Dmh+gyOHWmSl+8nuiwzP/y
         hMoA==
X-Gm-Message-State: AOAM531VMNCdcdk25ri9JEcNu6bKaXQhEchseAkv+9YNUNHY9D3a/nNw
        Z1uE/Lt1E4aEPA8yQiSeOlYLS/Rlrr4=
X-Google-Smtp-Source: ABdhPJyvVHX6rz8r6cHlIF9wN0L4/7Ci5itSo5aR/RBRw3AfE8h4JL479eyviFhwF17EIxTUrxjjYg==
X-Received: by 2002:a63:4405:: with SMTP id r5mr3641338pga.382.1599726470194;
        Thu, 10 Sep 2020 01:27:50 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:5900:d670::1ab5])
        by smtp.gmail.com with ESMTPSA id p11sm1345155pjz.44.2020.09.10.01.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 01:27:49 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH 0/2] gitk: fix mix of tabs and spaces in indentation
Date:   Thu, 10 Sep 2020 01:27:40 -0700
Message-Id: <cover.1599726439.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The source code of gitk has some funny indentation. It uses four spaces
per level indent but uses tabs every other level (eight spaces).
Reindent gitk to just use tabs instead.

This series should be empty with `--ignore-all-space`.

Denton Liu (2):
  gitk: replace spaces with tabs
  gitk: manually fix whitespace errors

 gitk | 20404 ++++++++++++++++++++++++++++-----------------------------
 1 file changed, 10202 insertions(+), 10202 deletions(-)

-- 
2.28.0.618.gf4bc123cb7

