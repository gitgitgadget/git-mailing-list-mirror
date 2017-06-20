Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98B7E20401
	for <e@80x24.org>; Tue, 20 Jun 2017 07:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752019AbdFTH4F (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:56:05 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:32887 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751819AbdFTH4B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:56:01 -0400
Received: by mail-wr0-f194.google.com with SMTP id x23so16334607wrb.0
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xpw1Z74VDnWX4mSsl4gYaF+mxVbxBdzxx0jpO2iLJEM=;
        b=uIXx0TVuo1X9ZvOuG9s0khyNU+vrN/+Bu6fft1CwXrKyJSQZjWjiYNiCLWSPjPO1/b
         +dr3bwYJQU7LHI7A136s20gfY5qDO8dgvu2wFOPWmOK2EUHLfQ6oVRX5ZEJN/gdHK8fO
         vL+1cjrsTPy2hPJMXig371MyJpOFIvMcvHz3f7gWKPv5/cLbdeRgOsJy6c+kPZO23Dbe
         st/d++Je7xALI+RAdu/BwQ3XhV3s7ZPCTcHOUXWiOYzMt1yv2bt/8lzyU0+5FqD47DSB
         NjQJlP+jrfSWHcosJDroOmX8LL6BrMXWYCYHOiGIVbo2KXFIzeUVfxZCEmOw2uXU97b5
         deeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xpw1Z74VDnWX4mSsl4gYaF+mxVbxBdzxx0jpO2iLJEM=;
        b=g9Ny2KzcGkBZCUqev3CH9cgv637NDQ5gSyM1ZWJxsKByMJpkyx2iNQjyyoXTq4PZBl
         Lob1MKD/qzbuHC1m413kf5nT52Exj6vMdd9cvr3dvkx4mKvOB2HshcNNaYRCH1LehHf9
         ZgJEMUsWWi4QpLacxuIU3iq0n+ENRLkp+JydWaKoYYNQsSujULYeg4gbeeAQIDw+t75+
         EpZY6X+MnVe2C0emXKkJqhyzdS64vt3urf5G1ZwtZYdE4jEu8g0Jr1DQ8BObCrgGRj2l
         +mx1biSr0JSXnoYFnDKh+UItFAPnLyRRjMnGKsXtoVpKrWMCkTaF4+rhPBBnTffiCqQz
         x26Q==
X-Gm-Message-State: AKS2vOyROQxbzpS85z9CENQW9VIzTFkIh+n0CL+PxT+UnOt6/pO6dJxe
        zhBPOwaMl65B8WIt
X-Received: by 10.223.172.231 with SMTP id o94mr19078275wrc.201.1497945359308;
        Tue, 20 Jun 2017 00:55:59 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k86sm11577890wmi.16.2017.06.20.00.55.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 00:55:58 -0700 (PDT)
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
Subject: [RFC/PATCH v4 08/49] Git/Packet: add capability functions
Date:   Tue, 20 Jun 2017 09:54:42 +0200
Message-Id: <20170620075523.26961-9-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.565.gbfcd7a9048
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
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
2.13.1.565.gbfcd7a9048

