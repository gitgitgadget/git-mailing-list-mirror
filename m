Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE94B2047F
	for <e@80x24.org>; Sat,  5 Aug 2017 00:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753046AbdHEAPG (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Aug 2017 20:15:06 -0400
Received: from oker.escape.de ([194.120.234.254]:57900 "EHLO oker.escape.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752820AbdHEAPE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2017 20:15:04 -0400
Received: from oker.escape.de (localhost [127.0.0.1])
        (envelope-sender: urs@isnogud.escape.de)
        by oker.escape.de (8.14.4/8.14.4/$Revision: 1.86 $) with ESMTP id v750F2eO028728
        for <git@vger.kernel.org>; Sat, 5 Aug 2017 02:15:02 +0200
Received: (from uucp@localhost)
        by oker.escape.de (8.14.4/8.14.4/Submit) with UUCP id v750F2il028718
        for git@vger.kernel.org; Sat, 5 Aug 2017 02:15:02 +0200
Received: from tehran.isnogud.escape.de (localhost [127.0.0.1])
        by tehran.isnogud.escape.de (8.14.9/8.14.9) with ESMTP id v750CGaC002275
        for <git@vger.kernel.org>; Sat, 5 Aug 2017 02:12:16 +0200
Received: (from urs@localhost)
        by tehran.isnogud.escape.de (8.14.9/8.14.9/Submit) id v750CFVk002272;
        Sat, 5 Aug 2017 02:12:15 +0200
X-Authentication-Warning: tehran.isnogud.escape.de: urs set sender to urs@isnogud.escape.de using -f
To:     git@vger.kernel.org
Subject: [PATCH] git svn fetch: Create correct commit timestamp when using --localtime
From:   Urs Thuermann <urs@isnogud.escape.de>
Date:   05 Aug 2017 02:12:15 +0200
Message-ID: <ygf8tiyx480.fsf@tehran.isnogud.escape.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In parse_svn_date() prepend the correct UTC offset to the timestamp
returned.  This is the offset in effect at the commit time instead of
the offset in effect at calling time.

Signed-off-by: Urs Thuermann <urs@isnogud.escape.de>
---
 perl/Git/SVN.pm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 98518f4..bc4eed3 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -1416,7 +1416,7 @@ sub parse_svn_date {
 			delete $ENV{TZ};
 		}
 
-		my $our_TZ = get_tz_offset();
+		my $our_TZ = get_tz_offset($epoch_in_UTC);
 
 		# This converts $epoch_in_UTC into our local timezone.
 		my ($sec, $min, $hour, $mday, $mon, $year,
-- 
2.1.4
