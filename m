Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AEEC20D12
	for <e@80x24.org>; Tue, 20 Jun 2017 07:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751997AbdFTH4H (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:56:07 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33571 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751969AbdFTH4B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:56:01 -0400
Received: by mail-wm0-f65.google.com with SMTP id f90so21267457wmh.0
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q+ARwAJja2yS2iZ9eIenGO7l7kXIjQzlCMptogDL8QQ=;
        b=auuQYC+j3qqheFPv88VCQAPOBBiI/YEMWgQA0Jh5cWVNeSxLx0eYcT5vzSzq9q70I4
         Z8dIoWctlidVwwhHN8045TXcEkEe/C2gTWQBaSJL2OcSJkx0jZuZJhQNNCGV9uOdsDyN
         4vZm2eSZvyGHGRg5uTp5tTQ1B8cmPL1KffyIhqNb1PVt+/X7r6jbssbTDt6sGt+4+yE/
         oaJEd5B4mPAS18/zrpr1+SQUHKtjmc9W+uU5Qxls0WvmZzsvV1L1qPfgf4WwQ9ZtCx7W
         URiM/oj2pMHGypmQX13Fk5cZG30znYve86cHMxEk8F5OpwKjAJSl8AVbOvFjyRUpcxso
         2UYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q+ARwAJja2yS2iZ9eIenGO7l7kXIjQzlCMptogDL8QQ=;
        b=SV/e1xvkr+BrAtwBD2FVcjnhgLCUapEHjLtRRqrF3mn2EKsEdqSjf8j5FnjJZDG+wo
         BOZcguXig2Gu8Tu3La9D0drxUJyF+hL+1JOXG6NFzzEyUXtY3BrFLMcCBTYIIEDT3Qhz
         KOA+JbQFcjroSUBJYImFe3ia20ExdIUA8wG2Sg/1zKzKFbjz5L8rJXZ4NrJDGgzD1qbj
         wuLR91iVAQqlVIfHpCSy2/tLrdHMrhjSX3/RZrOouXu2RfrVLOrbF5bkcAplvVjhKo+X
         44TmkgPffaB9ZBmXsA3AOWfpGgVyIbKrr6v73zDQ8Pdxh6ckB7tz3KcSNYb7O2QELtdb
         7wdQ==
X-Gm-Message-State: AKS2vOz8+Zvdg7+r1vq9O4FhvMLCr2YbNKNykN/T+J9rOjtfS6zU3VOI
        p/yMqpEova0UJZfo
X-Received: by 10.28.128.198 with SMTP id b189mr1577597wmd.79.1497945355286;
        Tue, 20 Jun 2017 00:55:55 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k86sm11577890wmi.16.2017.06.20.00.55.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 00:55:54 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v4 05/49] t0021/rot13-filter: use Git/Packet.pm
Date:   Tue, 20 Jun 2017 09:54:39 +0200
Message-Id: <20170620075523.26961-6-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.565.gbfcd7a9048
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
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
2.13.1.565.gbfcd7a9048

