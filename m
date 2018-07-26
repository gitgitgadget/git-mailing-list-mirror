Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 531D51F597
	for <e@80x24.org>; Thu, 26 Jul 2018 10:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbeGZLir (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 07:38:47 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:50317 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729077AbeGZLir (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 07:38:47 -0400
Received: from lindisfarne.localdomain ([92.22.19.104])
        by smtp.talktalk.net with SMTP
        id idPhfHPXuoI6LidPlfsjbO; Thu, 26 Jul 2018 11:22:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1532600554;
        bh=pCCcaIxh7XX7xaXSqbGXouYV8HIBcqQaOCyZyEfL0yU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=arCejRiSWazAOaCXnqp//UErTnlcZZ16Fjr+kV1VSWlJCkxP97agNqh6x0YEsEnIq
         ldrWrtFh/X6OdFiktBnqCbCbl94xBg9lkpKf2ovqMdnQc899ePPmbR07yhMFIfXu5x
         OLYIkvXSrHYpfaP0CLzzdoaL3Rz4gSbAOHkqEYgg=
X-Originating-IP: [92.22.19.104]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=f/8ZdrXn5sPnqdHA06GUHw==:117
 a=f/8ZdrXn5sPnqdHA06GUHw==:17 a=IkcTkHD0fZMA:10 a=evINK-nbAAAA:8
 a=tGVuKMeZVuHrdcQMkpMA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=QEXdDO2ut3YA:10
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [RFC PATCH v4 0/4]  add -p: select individual hunk lines
Date:   Thu, 26 Jul 2018 11:22:23 +0100
Message-Id: <20180726102227.997-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180219113619.26566-1-phillip.wood@talktalk.net>
References: <20180219113619.26566-1-phillip.wood@talktalk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfHNIjCO39PGSPYq4HW2g3Xtj8edSkxFo4YFu9A0X+T8oQteDcfNZ8i4+RLPVWEFZdx4PI1mPzu87U5vZW28/wX56U860Vzs7ERfddy2qOFDtYHbNEqku
 eJqdvgjzp1wjchMCyt+tQy9D+2fD2rowpTwxJtnp0wz+ZI8KlUd60MN3IjFEcIR60OdGAFxcbNvcpQqSeFc0oByMoaO0k29UvM/gNsroiAPlszgSCGB+l7io
 7u3EIFjPGcEyO4Gk78D/7kKT4jfZCsud0Gv0r0QI/l/8I0FmPDUgnKEEPWmZgNAIUiXmIgOeufaHlResOVMekT0tclxbWd7jfI9nvO1jpBE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

I've updated this series based on Ævar's feedback on v3 (to paraphrase
stop using '$_' so much and fix staging modified lines.). The first
patch is functionally equivalent to the previous version but with a
reworked implementation. Patch 2 is new, it implements correctly
staging modified lines with a couple of limitations - see the commit
message for more details, I'm keen to get some feedback on it. Patches
3 and 4 are essentially rebased and tweaked versions of patches 2 and
3 from the previous version.

This series is based on pw/add-p-recount (f4d35a6b49 "add -p: fix
counting empty context lines in edited patches")

The motivation for this series is summed up in the first commit
message:

"When I end up editing hunks it is almost always because I want to
stage a subset of the lines in the hunk. Doing this by editing the
hunk is inconvenient and error prone (especially so if the patch is
going to be reversed before being applied). Instead offer an option
for add -p to stage individual lines. When the user presses 'l' the
hunk is redrawn with labels by the insertions and deletions and they
are prompted to enter a list of the lines they wish to stage. Ranges
of lines may be specified using 'a-b' where either 'a' or 'b' may be
omitted to mean all lines from 'a' to the end of the hunk or all lines
from 1 upto and including 'b'."

Phillip Wood (4):
  add -p: select individual hunk lines
  add -p: select modified lines correctly
  add -p: allow line selection to be inverted
  add -p: optimize line selection for short hunks

 Documentation/git-add.txt  |  10 ++
 git-add--interactive.perl  | 350 +++++++++++++++++++++++++++++++++++++
 t/t3701-add-interactive.sh | 209 ++++++++++++++++++++++
 3 files changed, 569 insertions(+)

-- 
2.18.0

