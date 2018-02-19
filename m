Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 717AF1F576
	for <e@80x24.org>; Mon, 19 Feb 2018 11:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752667AbeBSL30 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 06:29:26 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:12480 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752633AbeBSL3X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 06:29:23 -0500
Received: from lindisfarne.localdomain ([92.22.21.220])
        by smtp.talktalk.net with SMTP
        id njdCe9qQuoNnDnjdHeU68x; Mon, 19 Feb 2018 11:29:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1519039760;
        bh=yzNdZx9hB530TsCSom4/auMBOMXI4Tj6Ir6RWLTcrPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=aP8LocbaGIJ8f6bG5qnIvKpc3JZCN898JHRDmsEmUxZhROfAszAoU9WFySntzO/MR
         FJG7jdDSCobFNciAkbM/NAk8uR7d+qkR7mTD0INJXw7zs55CVnLIIcApnQYq9vZ+L4
         n/H4PJw+HEEQKGa4bqRGvA4LOnkWMiP6H0zq06tE=
X-Originating-IP: [92.22.21.220]
X-Spam: 0
X-OAuthority: v=2.2 cv=ZZ9tDodA c=1 sm=1 tr=0 a=VSxTZYxioCnvaH7igEU67w==:117
 a=VSxTZYxioCnvaH7igEU67w==:17 a=evINK-nbAAAA:8 a=W1d3ZkXJKmyTQXOkrsQA:9
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 0/9] Correct offsets of hunks when one is skipped
Date:   Mon, 19 Feb 2018 11:29:01 +0000
Message-Id: <20180219112910.24471-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180213104408.9887-1-phillip.wood@talktalk.net>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfAYuBUv9AtovsLXYEZYrWJMkkPRPTXn+Uraj2AnL6O9bzVyl0QQ49Q7u95z9f7HmZmQ73m5Kii0viDgZ+Ng4SKbOPwXcbyVN3P0xKzDnPIk9Otvg0IOJ
 TPOenD++JySxE8WOWTUkXs/aWW90pKb9TYjfrO1wuzfOT4K7KhXdeyeuOCinsltf44b6mEvQfiBsEs4kiiaN2vbSnmszEDlqINbIO4jExmaYauTk+KOuBjpm
 57DJxnstyGvbJuLmIOlKhz+T7/LeXlhagN/oomlCi91PzAVeOZ/zdk1akf4BEPia
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Since v1 I've added some test cleanups for t3701, fixed the counting
when splitting and coalescing hunks containing "\ No newline at end of
file" lines and added a patch to remove '--recount' from the
invocation of 'git apply'. There are minor changes to patches 5
(previously patch 2) and patch 7 (previously patch 4) which I've
explained in the comments on those patches. Otherwise the original
patches are unchanged.

Cover letter to v1:

While working on a patch series to stage selected lines from a hunk
without having to edit it I got worried that subsequent patches would
be applied in the wrong place which lead to this series to correct the
offsets of hunks following those that are skipped or edited.


Phillip Wood (9):
  add -i: add function to format hunk header
  t3701: indent here documents
  t3701: use test_write_lines and write_script
  t3701: don't hard code sha1 hash values
  t3701: add failing test for pathological context lines
  add -p: Adjust offsets of subsequent hunks when one is skipped
  add -p: calculate offset delta for edited patches
  add -p: fix counting when splitting and coalescing
  add -p: don't rely on apply's '--recount' option

 git-add--interactive.perl  | 106 ++++++++++++-----
 t/t3701-add-interactive.sh | 281 ++++++++++++++++++++++++---------------------
 2 files changed, 229 insertions(+), 158 deletions(-)

-- 
2.16.1

