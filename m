Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D274C433FE
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 03:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbiKDDTg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 23:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbiKDDSf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 23:18:35 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3962526554
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 20:17:21 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id io19so3733721plb.8
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 20:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6SCb3LpFOT2wyzZDcqxXO2FoMd4lq8PQVzBDPsEmvMg=;
        b=X+ypvyx+iT7vmbwU+J9/G1Hrh/GBG7YNBs3WrXf0hQpzcELXKoCZrEZRJfLzLa0OPV
         KhLB/1SnY4QnoqTU1eKaPweeB1slTLW4h0B0xoY9BLfsIzMJNtvIvMdGh8meL1WjWUTs
         vdL++Xjn52zjy4736DsSgPdCLZqLaA2JTIL6ZWhQMzi/bjfT5XlHGKl1KtxY95PvEYG5
         aVrHwpNBvUa7AcVF2YLuBx1OQSoRNb351C88CJju72Euxoehbwrq4GNv6UgovXK4oN+I
         JgggEhwOfsDB7GcofKTuAUYkFiwBPgX+5RZ4PDnCV8luznroeoKRa1NUIejtJ5+fbpcl
         qg8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6SCb3LpFOT2wyzZDcqxXO2FoMd4lq8PQVzBDPsEmvMg=;
        b=cEzRS0Cz1tcxjcD16QRtgv/T0jD/nlGksA/nEbyacwiQD20jH+iIGU6LyZ14HkleDj
         0p3PTLIOkoF7kJnlNwlA+nRV/JhQxn1Gx7S+ajYF/+aGWcyVn3QKwCaJEFvtJH++vYXm
         BK6yKk6BkTUITs6QuWbYTqtev+Z+34+PQLNeWyPhE88/3q7F7aw7+vp6eXcrWT38g4uA
         ZmnApgnkwp6Ee1gEmWuw24MNduv7o56FqV2uqiykm0eDcEp4KUxFDF4MSUYH+7LnqOCJ
         fDCOXd0t8Jv7hs0kQMxNrFqfxszP2VksJHbnOVBwbNAVLuRwL7s66WH804CuJUp9NoRQ
         GFVg==
X-Gm-Message-State: ACrzQf2EEe7hlZCH0RQAKZiZYkaFy9EcRHe/rO5c7BmQbV8cFa0wIo45
        W8KLFOQqHU7+6CfqeSVZyRQ=
X-Google-Smtp-Source: AMsMyM5t/cQsvLPSYHkD3sE+P+TCmXjXYpAsyApFM5XSoo9m0y/sbLmPPeg/1jeXKSWoZfJ9DPwwUQ==
X-Received: by 2002:a17:902:f60c:b0:17c:163f:c0a8 with SMTP id n12-20020a170902f60c00b0017c163fc0a8mr32270498plg.38.1667531840612;
        Thu, 03 Nov 2022 20:17:20 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.58])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902e5c600b00172973d3cd9sm1442908plf.55.2022.11.03.20.17.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Nov 2022 20:17:19 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com
Subject: [PATCH v3 0/2] pack-bitmap.c: avoid exposing absolute paths
Date:   Fri,  4 Nov 2022 11:17:08 +0800
Message-Id: <cover.1667470481.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.38.1.383.g35840fde1dd
In-Reply-To: <cover.1667393419.git.dyroneteng@gmail.com>
References: <cover.1667393419.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

Diff since v2:

1. trace2 log will include the path info of pack. not only "basename".
2. A new commit which removes unnecessary "open_pack_index()" calls in
"open_midx_bitmap_1()".
3. The patch v2 still base on 2.37, rebase on 'master' to prevent conflicts.

Thanks.

Teng Long (2):
  pack-bitmap.c: avoid exposing absolute paths
  pack-bitmap.c: remove unnecessary "open_pack_index()" calls

 pack-bitmap.c           | 15 ++++++++-------
 t/t5310-pack-bitmaps.sh |  5 +++--
 2 files changed, 11 insertions(+), 9 deletions(-)

Range-diff against v2:
1:  1591e7ee52 < -:  ---------- pack-bitmap.c: avoid exposing absolute paths
-:  ---------- > 1:  de941f58f9 pack-bitmap.c: avoid exposing absolute paths
-:  ---------- > 2:  7ac9b859f3 pack-bitmap.c: remove unnecessary "open_pack_index()" calls
-- 
2.38.1.383.g35840fde1dd

