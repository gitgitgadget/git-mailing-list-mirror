Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 753802047F
	for <e@80x24.org>; Thu, 28 Sep 2017 04:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750857AbdI1EOd (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 00:14:33 -0400
Received: from p3plsmtpa08-08.prod.phx3.secureserver.net ([173.201.193.109]:54063
        "EHLO p3plsmtpa08-08.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750731AbdI1EOc (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 28 Sep 2017 00:14:32 -0400
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with SMTP
        id xQDRdH7D8y0RFxQDWdU4IP; Wed, 27 Sep 2017 21:14:32 -0700
From:   Max Kirillov <max@max630.net>
To:     Paul Mackerras <paulus@ozlabs.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Max Kirillov <max@max630.net>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: [PATCH] gitk: expand $config_file_tmp before reporting to user
Date:   Thu, 28 Sep 2017 07:14:17 +0300
Message-Id: <20170928041417.28947-1-max@max630.net>
X-Mailer: git-send-email 2.11.0.1122.gc3fec58.dirty
X-CMAE-Envelope: MS4wfAmu5yaJ5qMhQ62+UtazmzsZI39xyrfpmp2l/tQiUfTMFjdUB981sTzb+EZ7GEvxa/JShZvAKa49565JeKmeR0kGY3n6HS/Cx1GagHeMfMT6P5PczDTt
 UnjpBOxlDWzM1KxtQ5ie6jCU6r4T45BOYgzuKVv7uOLlvIrBkceYWi0GjeXjLBEfrRWUuDeAfepsQtZAkcGVs4EarhDZ8XYOEBqJ0nehUq+x7RzrBb0CM+Eo
 OiP9kkWRIrSOg3FvPz2TrW7oUoSIc8q1d7cmQ6zWv/BBwIrlQEJzS2XRId8ozgJL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tilda-based path may confise some users. First, tilda is not known
for Window users, second, it may point to unexpected location
depending on various environment setup.

Expand the path to "nativename", so that ~/.config/git/gitk-tmp
would be "C:\Users\user\.config\git\gitk-tmp", for example.
It should be less cryptic

Signed-off-by: Max Kirillov <max@max630.net>
---
 gitk | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/gitk b/gitk
index 877d49e1de..48c1d3e714 100755
--- a/gitk
+++ b/gitk
@@ -2844,7 +2844,8 @@ proc config_check_tmp_exists {tries_left} {
 	if {$tries_left > 0} {
 	    after 100 [list config_check_tmp_exists $tries_left]
 	} else {
-	    error_popup "There appears to be a stale $config_file_tmp\
+	    error_popup "There appears to be a stale \
+ \"[file nativename $config_file_tmp]\" \
  file, which will prevent gitk from saving its configuration on exit.\
  Please remove it if it is not being used by any existing gitk process."
 	}
-- 
2.11.0.1122.gc3fec58.dirty

