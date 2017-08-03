Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B6722047F
	for <e@80x24.org>; Thu,  3 Aug 2017 09:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751968AbdHCJTv (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 05:19:51 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36518 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751948AbdHCJTs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 05:19:48 -0400
Received: by mail-wm0-f66.google.com with SMTP id d40so1421400wma.3
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 02:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XjBiYYy+Vj6h4s+HoD/eQuhEo/5RZZ+ihqYN4h3mGfw=;
        b=t703nNYKbMDQYDQm0oAnRIXojx6wWFoGnbLjcudhs0NKY7knOduC5sn2kL/MxMvllu
         RBkjZnkhC1tXFsLEuKrKVXR7xCw7V11D+82z/K0FapQEoLCoOUAPZX1UQ2mKvcWm68Eb
         syqHj7WKj0Dy0/TfsrpgQV1WhafyJBHPyx/wz4tTa/8L+o0QksWtCjapil5x5t2d+m8l
         +t9cj8zHemRJkNgFdZ6rHyIiXms6NC/znv4uA6ta/xhQ1GI52fy1/2qCr05W29kzQHad
         9cWgiDuzn3wyWqCfkxTLZ4E0DbhNqCu2dKjZuQg1/M/qD3iHr37WTvjBsVFUFYdi2rpo
         kgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XjBiYYy+Vj6h4s+HoD/eQuhEo/5RZZ+ihqYN4h3mGfw=;
        b=jjiSIpaFq5g+fCdskDwRIDpl0C3VZcNgQN430YdGPCG2xHAYGRoGBQxW0zoIY9fM5D
         afBWE7Hvt7VugJsrvTUZMUjIYR0oLBlO3wyszgPgX8cBVdtfYMbdhFdh2K0QGA6UgsFh
         7GE6hN6SvPVPLI4zFhAmbMNGHm6MqFWYV9KmYCm3UjJlzHSmNSYxmZn+P1x2kttTw1vS
         gYMoD1H1idGIh2kW+lD4v7mGTovkW9RAlLnP3cqv7CmLA68s2+SMDjt528FpBvzdMICO
         Lkp8az8T+Lb8jF7UFfEzQf7+1zEvHK2bq0qwtrL9pRpya5e4oXl5r9MlELS5kvmSccM3
         StuQ==
X-Gm-Message-State: AHYfb5gixfPDhv53z6zzmv1bq2vFEOIhSUAHCQ9zHnSVvUi/++k/Q0Yn
        V8RwkGAjLI17AWvx
X-Received: by 10.28.14.149 with SMTP id 143mr677491wmo.102.1501751987459;
        Thu, 03 Aug 2017 02:19:47 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id n184sm1308051wme.33.2017.08.03.02.19.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 02:19:47 -0700 (PDT)
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
Subject: [PATCH v5 08/40] Git/Packet.pm: add capability functions
Date:   Thu,  3 Aug 2017 11:18:54 +0200
Message-Id: <20170803091926.1755-9-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.0.rc1.52.gf02fb0ddac.dirty
In-Reply-To: <20170803091926.1755-1-chriscool@tuxfamily.org>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add functions to help read and write capabilities.
Use these functions in 't/t0021/rot13-filter.pl'.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 perl/Git/Packet.pm      | 33 +++++++++++++++++++++++++++++++++
 t/t0021/rot13-filter.pl |  9 ++-------
 2 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/perl/Git/Packet.pm b/perl/Git/Packet.pm
index b0233caf37..4443b67724 100644
--- a/perl/Git/Packet.pm
+++ b/perl/Git/Packet.pm
@@ -20,6 +20,9 @@ our @EXPORT = qw(
 			packet_txt_write
 			packet_flush
 			packet_initialize
+			packet_read_capabilities
+			packet_write_capabilities
+			packet_read_and_check_capabilities
 		);
 our @EXPORT_OK = @EXPORT;
 
@@ -83,3 +86,33 @@ sub packet_initialize {
 	packet_txt_write( "version=" . $version );
 	packet_flush();
 }
+
+sub packet_read_capabilities {
+	my @cap;
+	while (1) {
+		my ( $res, $buf ) = packet_bin_read();
+		return ( $res, @cap ) if ( $res != 0 );
+		unless ( $buf =~ s/\n$// ) {
+			die "A non-binary line MUST be terminated by an LF.\n"
+			    . "Received: '$buf'";
+		}
+		die "bad capability buf: '$buf'" unless ( $buf =~ s/capability=// );
+		push @cap, $buf;
+	}
+}
+
+sub packet_read_and_check_capabilities {
+	my @local_caps = @_;
+	my @remote_res_caps = packet_read_capabilities();
+	my $res = shift @remote_res_caps;
+	my %remote_caps = map { $_ => 1 } @remote_res_caps;
+	foreach (@local_caps) {
+	    die "'$_' capability not available" unless (exists($remote_caps{$_}));
+	}
+	return $res;
+}
+
+sub packet_write_capabilities {
+	packet_txt_write( "capability=" . $_ ) foreach (@_);
+	packet_flush();
+}
diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
index 5b05518640..bbfd52619d 100644
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -42,14 +42,9 @@ $debug->flush();
 
 packet_initialize("git-filter", 2);
 
-( packet_txt_read() eq ( 0, "capability=clean" ) )  || die "bad capability";
-( packet_txt_read() eq ( 0, "capability=smudge" ) ) || die "bad capability";
-( packet_bin_read() eq ( 1, "" ) )                  || die "bad capability end";
+packet_read_and_check_capabilities("clean", "smudge");
+packet_write_capabilities(@capabilities);
 
-foreach (@capabilities) {
-	packet_txt_write( "capability=" . $_ );
-}
-packet_flush();
 print $debug "init handshake complete\n";
 $debug->flush();
 
-- 
2.14.0.rc1.52.gf02fb0ddac.dirty

