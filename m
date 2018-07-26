Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C36801F597
	for <e@80x24.org>; Thu, 26 Jul 2018 16:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731801AbeGZRXw (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 13:23:52 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:50460 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729801AbeGZRXw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 13:23:52 -0400
Received: from lindisfarne.localdomain ([89.242.182.230])
        by smtp.talktalk.net with SMTP
        id iimGfHvLPoI6LiimTfsryU; Thu, 26 Jul 2018 17:06:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1532621182;
        bh=oJPseFfeJ+C9EWgiMxHGr45L1tXkM7JHWKluWNtYM1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=bgh9MV6hlrhpY1u8Fm510RkiWWmzlqZ9q8eaEbmduIIDeggzKpBQ/JbBFYlOFU/au
         3p1VJydOGyCZK/I4Yh9FpWvWkRZQ2para9YB2iJePjMiEWSkrZ+Q6YaubUp/SEBPjf
         QA5r098ehZOp+lFPaiO9Ii+MhChPntWsPW7mlNb8=
X-Originating-IP: [89.242.182.230]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=tQBg3IHG1C6KDs2Ec9TG5Q==:117
 a=tQBg3IHG1C6KDs2Ec9TG5Q==:17 a=IkcTkHD0fZMA:10 a=evINK-nbAAAA:8
 a=tGVuKMeZVuHrdcQMkpMA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=QEXdDO2ut3YA:10
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [RFC PATCH v5 0/4] add -p: select individual hunk lines
Date:   Thu, 26 Jul 2018 16:58:50 +0100
Message-Id: <20180726155854.20832-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180219113619.26566-1-phillip.wood@talktalk.net>
References: <20180219113619.26566-1-phillip.wood@talktalk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfKDa4zuLqRT+nKrNnzeIMLztuSB39gPwYLS0jOme6VIrqpBABR3+rvDHlEjhp5gd3wErSS2QO+xOvw+5X4mX4alRslwu3KBQNmSsGhODhvj9td4CEgXy
 DqPwo7tV4MWq3gxB/VZCf0Uyf7jFf9GDYN5Tk3WLu58m9LPI3B2ryyWtql574byqJt9ZuR0WR4EOXirD8mhvyCxYorlYSC2fbdBAAOoTt7UtlvJyL3sIHFjy
 nhPim83wxE/1AxdJ2DSKIvmGku6bhmNBP7r86qIEDAQMcDWdzfidRSeV5xapCXIMy4+hJBRcrn+vg80Lxbz5VSoupf/28wJ2LAedinbf28c=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Unfortuantely v4 had test failures due to a suprious brace from a last
minute edit to a comment that I forgot to test. This version fixes
that, my applogies for the patch churn.

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
 git-add--interactive.perl  | 349 +++++++++++++++++++++++++++++++++++++
 t/t3701-add-interactive.sh | 209 ++++++++++++++++++++++
 3 files changed, 568 insertions(+)

-- 
2.18.0

