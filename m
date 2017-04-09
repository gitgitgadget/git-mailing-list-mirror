Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C9981FAFB
	for <e@80x24.org>; Sun,  9 Apr 2017 19:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752529AbdDITLR (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Apr 2017 15:11:17 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35011 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752444AbdDITLO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Apr 2017 15:11:14 -0400
Received: by mail-wm0-f53.google.com with SMTP id w64so24330043wma.0
        for <git@vger.kernel.org>; Sun, 09 Apr 2017 12:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cEUZQn4BRSt/wdDaRf+c6fp93K3vLpSynx7v/XYFkAo=;
        b=mlvZO3bPNBiZIAhZBNQ0EqgaMWn2cwV9E4HdCrrfBeSI+mLhQexMkDx45ekcKhXyYo
         9tn0+5fd37urEBKNxIT8GyhfYVaEWQ4VkRFzAHTbv2PVCb1VnXSQiB6fo/dG/PV+xUiI
         ZG90FIZbQ3bbHmy7ODqIKvKW7upEJ8NuwjH5yEtKbt5G+yoeU5ri1ymHPR2YDwiPPdke
         AJAJutTrKWirXkO58CyUvP3wunlSq9ok1jp8oqqDtzkpcS01v3UW96BFYxsVbVv4MN08
         A04KdV8mJZpyaJNBVmOa+spH4xPVUSeUAfbEoTsXns/f9GnF4WGD0kn2EU1ucmCAW4Jm
         J/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cEUZQn4BRSt/wdDaRf+c6fp93K3vLpSynx7v/XYFkAo=;
        b=aeLs5Ai89uQnvn1YoYo1GdyI/m5Y9pUMEqZW25IWFZuH0WsBaFmYWxn10kf7wZZdkl
         ST6/lYAERhDaZTTgiFF6KYqVDqSiL4/Zrcu7TAkA0ALuRN9FeWHLCOPWRIJQXAz2xAJX
         5H7aTC8p6d9MD4RB0FxGmszjux3QNfDdXp1zqwDpxAytIeRr2NLfbFkBk/toKmK/I+Nz
         1ifYSanzofMpTmpy1qVmBrnv7APen8kSE0cBQ+DVdOBDcK7iMngylw2kC+xfcvVTDNJN
         SKJuSXDCje0Cm72TWqEjbcpokgcWNol4eANlji8eQ7dV/9FDjVuVHMOs61MDzH00DFFy
         THWQ==
X-Gm-Message-State: AN3rC/7vFYHEFSXwLEx0cSq/SlCvIWu7iPNUJLgrz0O5OS87RmSg6Jiu
        RocB5ADCSWcCuw==
X-Received: by 10.28.130.142 with SMTP id e136mr7589854wmd.66.1491765072841;
        Sun, 09 Apr 2017 12:11:12 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB5F77.dip0.t-ipconnect.de. [93.219.95.119])
        by smtp.gmail.com with ESMTPSA id k13sm7319675wmi.28.2017.04.09.12.11.11
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 09 Apr 2017 12:11:12 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com
Subject: [PATCH v3 3/4] t0021: write "OUT" only on success
Date:   Sun,  9 Apr 2017 21:11:06 +0200
Message-Id: <20170409191107.20547-4-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170409191107.20547-1-larsxschneider@gmail.com>
References: <20170409191107.20547-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"rot13-filter.pl" used to write "OUT <size>" to the debug log even in case of
an abort or error. Fix this by writing "OUT <size>" to the debug log only in
the successful case if output is actually written.

This is useful for the subsequent patch 'convert: add "status=delayed" to
filter process protocol'.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 t/t0021-conversion.sh   | 6 +++---
 t/t0021/rot13-filter.pl | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 0139b460e7..0c04d346a1 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -588,7 +588,7 @@ test_expect_success PERL 'process filter should restart after unexpected write f
 		cat >expected.log <<-EOF &&
 			START
 			init handshake complete
-			IN: smudge smudge-write-fail.r $SF [OK] -- OUT: $SF [WRITE FAIL]
+			IN: smudge smudge-write-fail.r $SF [OK] -- [WRITE FAIL]
 			START
 			init handshake complete
 			IN: smudge test.r $S [OK] -- OUT: $S . [OK]
@@ -634,7 +634,7 @@ test_expect_success PERL 'process filter should not be restarted if it signals a
 		cat >expected.log <<-EOF &&
 			START
 			init handshake complete
-			IN: smudge error.r $SE [OK] -- OUT: 0 [ERROR]
+			IN: smudge error.r $SE [OK] -- [ERROR]
 			IN: smudge test.r $S [OK] -- OUT: $S . [OK]
 			IN: smudge test2.r $S2 [OK] -- OUT: $S2 . [OK]
 			STOP
@@ -673,7 +673,7 @@ test_expect_success PERL 'process filter abort stops processing of all further f
 		cat >expected.log <<-EOF &&
 			START
 			init handshake complete
-			IN: smudge abort.r $SA [OK] -- OUT: 0 [ABORT]
+			IN: smudge abort.r $SA [OK] -- [ABORT]
 			STOP
 		EOF
 		test_cmp_exclude_clean expected.log debug.log &&
diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
index 0b943bb377..5e43faeec1 100644
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -153,9 +153,6 @@ while (1) {
 		die "bad command '$command'";
 	}
 
-	print $debug "OUT: " . length($output) . " ";
-	$debug->flush();
-
 	if ( $pathname eq "error.r" ) {
 		print $debug "[ERROR]\n";
 		$debug->flush();
@@ -178,6 +175,9 @@ while (1) {
 			die "${command} write error";
 		}
 
+		print $debug "OUT: " . length($output) . " ";
+		$debug->flush();
+
 		while ( length($output) > 0 ) {
 			my $packet = substr( $output, 0, $MAX_PACKET_CONTENT_SIZE );
 			packet_bin_write($packet);
-- 
2.12.2

