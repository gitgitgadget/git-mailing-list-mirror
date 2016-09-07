Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E103820705
	for <e@80x24.org>; Wed,  7 Sep 2016 07:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751130AbcIGHAB (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 03:00:01 -0400
Received: from mga02.intel.com ([134.134.136.20]:30127 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750791AbcIGHAB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 03:00:01 -0400
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP; 07 Sep 2016 00:00:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,295,1470726000"; 
   d="scan'208";a="165296495"
Received: from vgt-dell.bj.intel.com ([10.238.135.73])
  by fmsmga004.fm.intel.com with ESMTP; 06 Sep 2016 23:59:59 -0700
From:   changbin.du@gmail.com
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, "Du, Changbin" <changbin.du@gmail.com>
Subject: [PATCH] send-email: use sanitized address for cc
Date:   Wed,  7 Sep 2016 14:57:33 +0800
Message-Id: <20160907065733.28467-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Du, Changbin" <changbin.du@gmail.com>

Some username in the email address may include a ','. In this case,
we need quoting the username field so it will not be parsed as two
single addresses by Mail::Address->parse().

For example, my eamil address "Du, Changbin <changbin.du@gmail.com>"
can be parsed as two addresses "Du" and "Changbin <changbin.du@gmail.com>"
if username is not quoted. ("Du, Changbin" is a legal format of signature
in Chinese)

The sanitized address can be used because quote is added automactically.

Signed-off-by: Du, Changbin <changbin.du@gmail.com>
---
 git-send-email.perl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 6958785..6ec189e 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1554,9 +1554,9 @@ foreach my $t (@files) {
 				next if $suppress_cc{'sob'} and $what =~ /Signed-off-by/i;
 				next if $suppress_cc{'bodycc'} and $what =~ /Cc/i;
 			}
-			push @cc, $c;
+			push @cc, $sc;
 			printf("(body) Adding cc: %s from line '%s'\n",
-				$c, $_) unless $quiet;
+				$sc, $_) unless $quiet;
 		}
 	}
 	close $fh;
-- 
2.7.4

