Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF86320969
	for <e@80x24.org>; Fri, 31 Mar 2017 18:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751767AbdCaSgL (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 14:36:11 -0400
Received: from zandvoort.avirtualhome.com ([96.126.105.64]:56046 "EHLO
        mail.avirtualhome.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbdCaSgK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 14:36:10 -0400
Received: from [192.168.1.161] (pool-108-40-123-60.bltmmd.fios.verizon.net [108.40.123.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.avirtualhome.com (Postfix) with ESMTPSA id C81D1174C2;
        Fri, 31 Mar 2017 14:36:08 -0400 (EDT)
To:     git@vger.kernel.org
From:   Peter van der Does <peter@avirtualhome.com>
Subject: [PATCH v2] git-gui: Error on systems with TK < 8.6.0
Cc:     Pat Thoyts <patthoyts@users.sourceforge.net>
Message-ID: <ca09fdf0-43e5-0bc6-1fe1-9331e3820d6a@avirtualhome.com>
Date:   Fri, 31 Mar 2017 14:36:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:53.0) Gecko/20100101
 Thunderbird/53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using git-gui on systems that run a TK version below 8.6.0 results in a
crash when checking for the current theme.

Catch the error on those systems and use a different command to check
for the current theme.

Signed-off-by: Peter van der Does <peter@avirtualhome.com>
---
 lib/themed.tcl | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/themed.tcl b/lib/themed.tcl
index 351a712..bb4e8f2 100644
--- a/lib/themed.tcl
+++ b/lib/themed.tcl
@@ -248,7 +248,11 @@ proc tspinbox {w args} {
 proc ttext {w args} {
 	global use_ttk
 	if {$use_ttk} {
-		switch -- [ttk::style theme use] {
+		# Handle either current Tk or older versions of 8.5
+		if {[catch {set theme [ttk::style theme use]}]} {
+			set theme  $::ttk::currentTheme
+		}
+		switch -- $theme {
 			"vista" - "xpnative" {
 				lappend args -highlightthickness 0 -borderwidth 0
 			}
-- 
2.12.2
