Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA8E12047F
	for <e@80x24.org>; Thu,  3 Aug 2017 09:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751743AbdHCJWh (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 05:22:37 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33173 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751941AbdHCJTp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 05:19:45 -0400
Received: by mail-wm0-f66.google.com with SMTP id q189so1445728wmd.0
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 02:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XGkwu7T5+DMdaXO3G0kzZgfdBGr1B/sMoE1dRQ0yPHg=;
        b=Ai/07/qk8mfbDSgZPDU6pTRe2diMytR5ni2/DYqayl9CmyliYcEepJAKA/jrhh3Bho
         Tu3P9lzAc0iIk0rLSvoQRSlCj07lavnAxjGaxpzVf2S2IPObk35PmnjRYnKvhaGZ/Pjv
         hlfeMf6+K8qpLXpGk415/6eFuchNB0N4Zi4k6Hqvo+v946SaOs9pSRv4HAh3nsRwUnmB
         jOZ0QNJFnjAFLZKMDyIKG3MaOo9xKBHf+2ZQlJT//jMacX/o0+gUfWU9B7Z/5EWhYrLK
         vzuBAnbHICgS18sscq3tpCqifHxnu/9DPP3VEmy9IWQUOUhSJoDUjobaWwBJ//g/xdzy
         36Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XGkwu7T5+DMdaXO3G0kzZgfdBGr1B/sMoE1dRQ0yPHg=;
        b=WpODsWxGJ63yTWSqJh7wfCJjiIuly+iNNKgG1akukhCOMZZ+S+s07bPzfK1cMfNtqw
         QXL5c8cKR195u0yq+R1a99mWblW7LMI2Sk5E+BDNzoYrmDgkQ5Rz6Ey2YWI9IDJd8Rlq
         5vQ82yncZyIcsbjBrWzY1FSRoiMC95DOdImEavxkZwwhxEqHdixSs4zxEI9g1zssIQ12
         bzNVgvWpX1rgWBrPjSB7LMTpGfA2j75I/9BGQcJAYK7MdXkqPYqO/NATX/XxbVb+Zlnn
         xB9IHTwSIW4cIVQjeO9uRk2YOSntx6/913LLwfuLEMq/G9w+xryUkKhuKATPnwKAJPoz
         qmiw==
X-Gm-Message-State: AIVw113CPELEIjeROk5ZAd0LIqToBKi0ze9H0+Uw5NOz93xKdi2B8bvu
        txO0uoJA7x5SLKe2
X-Received: by 10.28.238.85 with SMTP id m82mr714685wmh.107.1501751983900;
        Thu, 03 Aug 2017 02:19:43 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id n184sm1308051wme.33.2017.08.03.02.19.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 02:19:43 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 05/40] t0021/rot13-filter: use Git/Packet.pm
Date:   Thu,  3 Aug 2017 11:18:51 +0200
Message-Id: <20170803091926.1755-6-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.0.rc1.52.gf02fb0ddac.dirty
In-Reply-To: <20170803091926.1755-1-chriscool@tuxfamily.org>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After creating Git/Packet.pm from part of t0021/rot13-filter.pl,
we can now simplify this script by using Git/Packet.pm.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0021/rot13-filter.pl | 51 +++----------------------------------------------
 1 file changed, 3 insertions(+), 48 deletions(-)

diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
index 1fc581c814..36a9eb3608 100644
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -19,9 +19,12 @@
 #     same command.
 #
 
+use 5.008;
+use lib (split(/:/, $ENV{GITPERLLIB}));
 use strict;
 use warnings;
 use IO::File;
+use Git::Packet;
 
 my $MAX_PACKET_CONTENT_SIZE = 65516;
 my @capabilities            = @ARGV;
@@ -34,54 +37,6 @@ sub rot13 {
 	return $str;
 }
 
-sub packet_bin_read {
-	my $buffer;
-	my $bytes_read = read STDIN, $buffer, 4;
-	if ( $bytes_read == 0 ) {
-		# EOF - Git stopped talking to us!
-		return ( -1, "" );
-	} elsif ( $bytes_read != 4 ) {
-		die "invalid packet: '$buffer'";
-	}
-	my $pkt_size = hex($buffer);
-	if ( $pkt_size == 0 ) {
-		return ( 1, "" );
-	} elsif ( $pkt_size > 4 ) {
-		my $content_size = $pkt_size - 4;
-		$bytes_read = read STDIN, $buffer, $content_size;
-		if ( $bytes_read != $content_size ) {
-			die "invalid packet ($content_size bytes expected; $bytes_read bytes read)";
-		}
-		return ( 0, $buffer );
-	} else {
-		die "invalid packet size: $pkt_size";
-	}
-}
-
-sub packet_txt_read {
-	my ( $res, $buf ) = packet_bin_read();
-	unless ( $res == -1 || $buf =~ s/\n$// ) {
-		die "A non-binary line MUST be terminated by an LF.";
-	}
-	return ( $res, $buf );
-}
-
-sub packet_bin_write {
-	my $buf = shift;
-	print STDOUT sprintf( "%04x", length($buf) + 4 );
-	print STDOUT $buf;
-	STDOUT->flush();
-}
-
-sub packet_txt_write {
-	packet_bin_write( $_[0] . "\n" );
-}
-
-sub packet_flush {
-	print STDOUT sprintf( "%04x", 0 );
-	STDOUT->flush();
-}
-
 print $debug "START\n";
 $debug->flush();
 
-- 
2.14.0.rc1.52.gf02fb0ddac.dirty

