Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC0081FF40
	for <e@80x24.org>; Sun, 11 Dec 2016 23:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754037AbcLKXei (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Dec 2016 18:34:38 -0500
Received: from mx1.2b3w.ch ([92.42.186.250]:51978 "EHLO mx1.2b3w.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753896AbcLKXei (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Dec 2016 18:34:38 -0500
Received: from mx1.2b3w.ch (localhost [127.0.0.1])
        by mx1.2b3w.ch (Postfix) with ESMTP id BAFB2C344A;
        Mon, 12 Dec 2016 00:34:34 +0100 (CET)
Received: from drbeat.li (21-244-153-5.dyn.cable.fcom.ch [5.153.244.21])
        by mx1.2b3w.ch (Postfix) with ESMTPSA id 89C39C33DD;
        Mon, 12 Dec 2016 00:34:34 +0100 (CET)
Received: by drbeat.li (Postfix, from userid 1000)
        id 5A27F20AB7; Mon, 12 Dec 2016 00:34:34 +0100 (CET)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 3/3] update_unicode.sh: restore hexadecimal output
Date:   Mon, 12 Dec 2016 00:34:25 +0100
Message-Id: <1481499265-18361-3-git-send-email-dev+git@drbeat.li>
X-Mailer: git-send-email 2.7.2
In-Reply-To: <1481499265-18361-1-git-send-email-dev+git@drbeat.li>
References: <1481499265-18361-1-git-send-email-dev+git@drbeat.li>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The uniset upstream has decided that decimal numbers are The True Way, so
let's convert them back to the usual format that's closer to the U+nnnn
standard.

The generated unicode_widths.h file again looks exactly the same as two
commits ago.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 update_unicode.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/update_unicode.sh b/update_unicode.sh
index e595bf8..d7720d5 100755
--- a/update_unicode.sh
+++ b/update_unicode.sh
@@ -5,6 +5,12 @@
 #Mn Nonspacing_Mark a nonspacing combining mark (zero advance width)
 #Cf Format          a format control character
 #
+
+dec_to_hex() {
+	# convert any decimal numbers to 4-digit hex
+	perl -pe 's/(\d+)/sprintf("0x%04X", $1)/ge'
+}
+
 UNICODEWIDTH_H=../unicode_width.h
 if ! test -d unicode; then
 	mkdir unicode
@@ -29,7 +35,7 @@ fi &&
 		make
 	) &&
 	UNICODE_DIR=. && export UNICODE_DIR &&
-	cat >$UNICODEWIDTH_H <<-EOF
+	dec_to_hex >$UNICODEWIDTH_H <<-EOF
 	static const struct interval zero_width[] = {
 		$(uniset/uniset --32 cat:Me,Mn,Cf + U+1160..U+11FF - U+00AD)
 	};
-- 
2.7.2
