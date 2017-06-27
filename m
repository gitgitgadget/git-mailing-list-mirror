Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB02720401
	for <e@80x24.org>; Tue, 27 Jun 2017 12:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753092AbdF0MKu (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 08:10:50 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32839 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753071AbdF0MKr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 08:10:47 -0400
Received: by mail-wm0-f66.google.com with SMTP id j85so5432509wmj.0
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 05:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0nUddlcmV0ePc2BbStzzI+UiFUK9MmCCwfwxXZ0arew=;
        b=SQLfRQTbHsztO+FbCQHX7ToH6flyRC95ObfOZC4ibgxEsPRMcmnCs6wvuZ1ZUUZrMK
         dydAa8tgUcFWvl1KTGv9XEdz/prAN5i7Wqr4Pn9n3gHm5iX9FNf+OvnDL+QzmFm40jJJ
         nkDg8F4McOapz+OHVupJZ9MRSt6S4sHjs1HOc8MVphLdizLLy1pWyD8HFWk3afzWpCu3
         SLNFYzekdxOWZJYI166UpWNodVJwetYssPGoO91+ku83NLIhidvkONk0OU5jahwCeu8l
         4meeZXNuVulpXEBN8zZ2BqFlgWioqIzanCjGwDk+PDDB8fE+Zifuo3rPZoi/PjyWUZzn
         47kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0nUddlcmV0ePc2BbStzzI+UiFUK9MmCCwfwxXZ0arew=;
        b=W3Cxj/66V/FgnKeMaDyl4GHIYO8k2c00FQGd6KvVO9TlcF4hbGcxaUQJGP38zIg52u
         0/wafWShz7uhnlCsvJYb9TJhWsjjhrYPwOXDSWDOvAnGtIl8tC3HT6TpGQs5FUVpZ7YP
         DcN3b+vLhLLx0cBbgUQEfMqYtTOKE2DPFOQjCT/GjT560RufyuboCimr8s30zln8/JwS
         sRotVUU9TQC1iGEYbFyLg/dER9bkysuw825Zb225oUphmWp3dSMHpY+tq4K3k55Ynhbw
         0JeQ+B2KVcqA3UzJMJFjgNneOCJ0A0NU0DJQXKHIr/f5WZzVwKSG5PDXHB/s9cy04xBp
         EohA==
X-Gm-Message-State: AKS2vOwx36JHg9K4A2tt5pAbzsLFrGRmhEjQRj/2n/nU2+lQU5QQim24
        J5vEIXCslTqtL4d4
X-Received: by 10.28.107.87 with SMTP id g84mr3274214wmc.63.1498565444932;
        Tue, 27 Jun 2017 05:10:44 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id 32sm17873976wry.31.2017.06.27.05.10.41
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 05:10:44 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Subject: [PATCH v7 3/6] t0021: write "OUT <size>" only on success
Date:   Tue, 27 Jun 2017 14:10:24 +0200
Message-Id: <20170627121027.99209-4-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20170627121027.99209-1-larsxschneider@gmail.com>
References: <20170627121027.99209-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"rot13-filter.pl" always writes "OUT <size>" to the debug log at the end
of a response.

This works without issues for the existing responses "abort", "error",
and "success". A new response "delayed", that will be introduced in a
subsequent patch, accepts the input without giving the filtered result
right away. Since we actually have the data already available in our
mock filter the debug log output would be wrong/misleading. Therefore,
we do not write "OUT <size>" for "delayed" responses.

To simplify the code we do not write "OUT <size>" for "abort" and
"error" responses, too, as their size is always zero.

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
2.13.2

