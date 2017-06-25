Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E05E2082E
	for <e@80x24.org>; Sun, 25 Jun 2017 18:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751371AbdFYSVd (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Jun 2017 14:21:33 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34696 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751346AbdFYSV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jun 2017 14:21:29 -0400
Received: by mail-wr0-f195.google.com with SMTP id k67so25612100wrc.1
        for <git@vger.kernel.org>; Sun, 25 Jun 2017 11:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vl17oZuQ9/gs2fSqvZACv3prCDuZKgJnuj2u+IcGsvU=;
        b=FQXIHzPF/dTkub/+rqb2tJaylXOkuDrR7crpGdVNQwxuI2LtBqjg1P7sQwDBI7rvSt
         d/25GQLCAlObBZeYqMkulS0IFLbtm6Alh2VCjDjSs+WoS0+NmOFASVsJdzKh8g2vbDAd
         lJuLggYgqNBY2gznXshI6IRMK35ezoRrF4Uq2qtXburdzUBs05Tk3lXKd1NLrwj7S5qI
         wXIs40LrvCmgrPhbDdh8LLujXB7Ix5jRh8mSOJqs8DKyfoFpoBuqd5pYtavIA5qUY/yk
         p8AO3lgL/HOMGN+B1cathtfYl1BqUFYjy4GbQ4gfOFWR2IOnBseWVd7NN4K7dwZ/pIv+
         4Ieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vl17oZuQ9/gs2fSqvZACv3prCDuZKgJnuj2u+IcGsvU=;
        b=Iztp/7EeJyGsMvxBveiUmVZdwkBkEZxgl4MGfXrbR51kXL69rbDwYiwgDK6wJGMW1V
         cx7f1JO1Nx+b7Bun7PtJ8RKSsArHiArsztTTIFlyXSH+bX35b6AcXBnC+QiB6SqubQed
         sHfYwT5p6SnxIgznNZRUt7gYUa3Dh0MC2Q+Cr3KtFklkYNDZrjzjLVrd/u1X9xYrfXcJ
         XSoMYyjUfJvnGT6N8v/Sw8Q7SUGkAYnMmNOHwDhrvANPFCfH70uME6ZYd0enGBAf6W9V
         XOxCE+AnuV0V1FHQGg+wDXna1HgbH7v9ZQHIb/CWhfmvZIyh6Yu4I2g+n+adegCZECvb
         ufiQ==
X-Gm-Message-State: AKS2vOxJ6CFEQ8JDUxhCdz9O3NNjb3uD6h2xMhUCZHsthBGnscDBJCcI
        zprd2YooGyEfs39w
X-Received: by 10.223.179.65 with SMTP id k1mr12090488wrd.5.1498414888109;
        Sun, 25 Jun 2017 11:21:28 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB71F6.dip0.t-ipconnect.de. [93.219.113.246])
        by smtp.gmail.com with ESMTPSA id u13sm13313926wmd.22.2017.06.25.11.21.27
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 25 Jun 2017 11:21:27 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Subject: [PATCH v6 3/6] t0021: write "OUT" only on success
Date:   Sun, 25 Jun 2017 20:21:22 +0200
Message-Id: <20170625182125.6741-4-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.13.1
In-Reply-To: <20170625182125.6741-1-larsxschneider@gmail.com>
References: <20170625182125.6741-1-larsxschneider@gmail.com>
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
2.13.1

