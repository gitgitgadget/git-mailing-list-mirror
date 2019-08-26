Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC0C51F461
	for <e@80x24.org>; Mon, 26 Aug 2019 16:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733066AbfHZQpl (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 12:45:41 -0400
Received: from smtp01.domein-it.com ([92.48.232.141]:49602 "EHLO
        smtp01.domein-it.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732627AbfHZQpk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 12:45:40 -0400
Received: by smtp01.domein-it.com (Postfix, from userid 1000)
        id 1975480190B4; Mon, 26 Aug 2019 18:45:39 +0200 (CEST)
Received: from ferret.domein-it.nl (unknown [92.48.232.148])
        by smtp01.domein-it.com (Postfix) with ESMTP id B7864810EDC1;
        Mon, 26 Aug 2019 18:45:16 +0200 (CEST)
Received: from 80-112-22-40.cable.dynamic.v4.ziggo.nl ([80.112.22.40]:57188 helo=ben.local)
        by ferret.domein-it.nl with esmtpa (Exim 4.92)
        (envelope-from <ben@wijen.net>)
        id 1i2I7H-0001oK-5W; Mon, 26 Aug 2019 18:45:15 +0200
From:   Ben Wijen <ben@wijen.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Pratik Karki <predatoramigo@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ben Wijen <ben@wijen.net>
Subject: [PATCH v4 1/1] rebase.c: make sure the active branch isn't moved when autostashing
Date:   Mon, 26 Aug 2019 18:45:12 +0200
Message-Id: <20190826164513.9102-1-ben@wijen.net>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190821182941.12674-1-ben@wijen.net>
References: <20190821182941.12674-1-ben@wijen.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Domein-IT-MailScanner-Information: Please contact the ISP for more information
X-Domein-IT-MailScanner-ID: 1i2I7H-0001oK-5W
X-Domein-IT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-Domein-IT-MailScanner-SpamCheck: 
X-Domein-IT-MailScanner-From: ben@wijen.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dscho's review got me thinking about the rationale behind the 'HEAD is now at...'
message.

A 'stash push' is followed by a 'reset -q' but since 'stash create autostash' is
not, we must do it ourselves. I guess the legacy implementation could have been
'reset --hard -q' which would have also prevented the 'HEAD is now at...' message.

Ofcourse I'm happy to reinstate the message, but I'm convinced it doesn't add
information, as with this commit the original branch is no longer moved and 
- as before - the autostash is re-applied after the rebase, leaving nothing
to be guessed about.


Thank you,

Ben Wijen (1):
  rebase.c: make sure the active branch isn't moved when autostashing

 builtin/rebase.c            | 18 ++++++------------
 t/t3420-rebase-autostash.sh | 12 ++++++++----
 2 files changed, 14 insertions(+), 16 deletions(-)

-- 
2.22.0

