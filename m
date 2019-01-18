Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F3D01F453
	for <e@80x24.org>; Fri, 18 Jan 2019 06:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfARGSI (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 01:18:08 -0500
Received: from fed1rmfepo102.cox.net ([68.230.241.144]:46565 "EHLO
        fed1rmfepo102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbfARGSI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 01:18:08 -0500
Received: from fed1rmimpo109.cox.net ([68.230.241.158])
          by fed1rmfepo102.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20190118061807.YMTJ12708.fed1rmfepo102.cox.net@fed1rmimpo109.cox.net>
          for <git@vger.kernel.org>; Fri, 18 Jan 2019 01:18:07 -0500
Received: from thunderbird.smith.home (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 7CAD8B82414;
        Thu, 17 Jan 2019 23:18:06 -0700 (MST)
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090212.5C416F9F.0012,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.3 cv=OtL7NB3t c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=3JhidrIBZZsA:10 a=WDhBSedXqNQA:10 a=kviXuzpPAAAA:8 a=ZRg8tKC3IdvpwZkzal4A:9
 a=qrIFiuKZe2vaD64auk6j:22
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
From:   "Stephen P. Smith" <ischis2@cox.net>
To:     git@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.org>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 3/5] Add 'human' date format documentation
Date:   Thu, 17 Jan 2019 23:18:03 -0700
Message-Id: <20190118061805.19086-4-ischis2@cox.net>
X-Mailer: git-send-email 2.20.1.2.gb21ebb671b
In-Reply-To: <20190118061805.19086-1-ischis2@cox.net>
References: <20181231003150.8031-1-ischis2@cox.net>
 <20190118061805.19086-1-ischis2@cox.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Display date and time information in a format similar to how people
write dates in other contexts. If the year isn't specified then, the
reader infers the date is given is in the current year.

By not displaying the redundant information, the reader concentrates
on the information that is different. The patch reports relative dates
based on information inferred from the date on the machine running the
git command at the time the command is executed.

While the format is more useful to humans by dropping inferred
information, there is nothing that makes it actually human. If the
'relative' date format wasn't already implemented then using
'relative' would have been appropriate.

Signed-off-by: Stephen P. Smith <ischis2@cox.net>
---
 Documentation/git-log.txt          | 4 ++++
 Documentation/rev-list-options.txt | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 90761f1694..1d2d932c76 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -193,6 +193,10 @@ log.date::
 	`--date` option.)  Defaults to "default", which means to write
 	dates like `Sat May 8 19:35:34 2010 -0500`.
 
+	If the format is set to "auto:foo", then if the pager is in
+	use format "foo" will be the used for the date format, otherwise
+	"default" will be used.
+
 log.follow::
 	If `true`, `git log` will act as if the `--follow` option was used when
 	a single <path> is given.  This has the same limitations as `--follow`,
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index bab5f50b17..5d58f35d19 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -835,6 +835,12 @@ Note that the `-local` option does not affect the seconds-since-epoch
 value (which is always measured in UTC), but does switch the accompanying
 timezone value.
 +
+`--date=human` shows the timezone if it matches the current time-zone,
+and doesn't print the whole date if that matches (ie skip printing
+year for dates that are "this year", but also skip the whole date
+itself if it's in the last few days and we can just say what weekday
+it was).
++
 `--date=unix` shows the date as a Unix epoch timestamp (seconds since
 1970).  As with `--raw`, this is always in UTC and therefore `-local`
 has no effect.
-- 
2.20.1.2.gb21ebb671b

