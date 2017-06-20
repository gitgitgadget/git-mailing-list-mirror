Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C71120401
	for <e@80x24.org>; Tue, 20 Jun 2017 07:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751819AbdFTH4G (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:56:06 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34278 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750863AbdFTHz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:55:59 -0400
Received: by mail-wr0-f194.google.com with SMTP id y25so14131898wrd.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4tWKdAZOVYhDwm682iltrZgQwwqAo2/P9apPkrFB6TY=;
        b=Y890fhym4sPkHmhN2FLVVvCkKGLBTeRXaFCe6SsZqcgRaOo1zXkk0aAVQmg4azJGDL
         K/1QnZbQ2LxclwBzScl12Qh3PJxRHGDGIhFBr6t4lMTG/XzQKcFhLIFva25wV+Ft4E6J
         orTurlDJJ51BqLjKlLHYJJssITVHfQhCLELer4EJe8tI/3Gba1100ipIcRbEoh0GQJFR
         XUzxvJwnHClKmUxiRaTazHvS8QjHFYoA9ZLV3W8EzgoxJRDF/TGT68F15IXRG1cevoWK
         vg8G0mA8gnmL3Phc9dywYWxhcgcrD663hWHlEMJnnAhUe+7FeuPeSUWU2SolMW2cyCoT
         KlNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4tWKdAZOVYhDwm682iltrZgQwwqAo2/P9apPkrFB6TY=;
        b=lJFt9WDStHl0jn7jnN82pwAxJuAycOlixyjwRMMpQcCtkvfpRkDc5k0NKHUzxWnL98
         Hj9hOdZ1BAiVT4zsjIFoxDS+UQ11Cxqd/dNnBiV004CnG00iYvC36cdpmIew6iKTd/N2
         NVcF8wQuDytlO+Ppc529vMR3XCnC46BwVXzdTRRLZTpbA7jx+rPC29kXC9ZIwdWDX/AA
         dQeIMXo7n0ymsFCHG91Mec7ubcK53aZaSiW75TK44dzhZwThMh3dBL7lKLirm3fzGH6K
         7U7QT0PbHavozx6vjvtnVbdBDAh8CvONTaCX0xI2RFxOie/VV+VCv8FdzG8rY2aVCnM7
         /3Ag==
X-Gm-Message-State: AKS2vOwBSlBwaZAdLhpelZYEtIhduODXPmx7NdF7aESljfQya9zWRj1M
        lJ0qN9DBi10xJ/gt
X-Received: by 10.223.182.136 with SMTP id j8mr11579426wre.122.1497945357758;
        Tue, 20 Jun 2017 00:55:57 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k86sm11577890wmi.16.2017.06.20.00.55.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 00:55:57 -0700 (PDT)
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
Subject: [RFC/PATCH v4 07/49] Git/Packet.pm: add packet_initialize()
Date:   Tue, 20 Jun 2017 09:54:41 +0200
Message-Id: <20170620075523.26961-8-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.565.gbfcd7a9048
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a function to initialize the communication. And use this
function in 't/t0021/rot13-filter.pl'.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 perl/Git/Packet.pm      | 13 +++++++++++++
 t/t0021/rot13-filter.pl |  8 +-------
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/perl/Git/Packet.pm b/perl/Git/Packet.pm
index 2ad6b00d6c..b0233caf37 100644
--- a/perl/Git/Packet.pm
+++ b/perl/Git/Packet.pm
@@ -19,6 +19,7 @@ our @EXPORT = qw(
 			packet_bin_write
 			packet_txt_write
 			packet_flush
+			packet_initialize
 		);
 our @EXPORT_OK = @EXPORT;
 
@@ -70,3 +71,15 @@ sub packet_flush {
 	print STDOUT sprintf( "%04x", 0 );
 	STDOUT->flush();
 }
+
+sub packet_initialize {
+	my ($name, $version) = @_;
+
+	( packet_txt_read() eq ( 0, $name . "-client" ) )	|| die "bad initialize";
+	( packet_txt_read() eq ( 0, "version=" . $version ) )	|| die "bad version";
+	( packet_bin_read() eq ( 1, "" ) )			|| die "bad version end";
+
+	packet_txt_write( $name . "-server" );
+	packet_txt_write( "version=" . $version );
+	packet_flush();
+}
diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
index 36a9eb3608..5b05518640 100644
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -40,13 +40,7 @@ sub rot13 {
 print $debug "START\n";
 $debug->flush();
 
-( packet_txt_read() eq ( 0, "git-filter-client" ) ) || die "bad initialize";
-( packet_txt_read() eq ( 0, "version=2" ) )         || die "bad version";
-( packet_bin_read() eq ( 1, "" ) )                  || die "bad version end";
-
-packet_txt_write("git-filter-server");
-packet_txt_write("version=2");
-packet_flush();
+packet_initialize("git-filter", 2);
 
 ( packet_txt_read() eq ( 0, "capability=clean" ) )  || die "bad capability";
 ( packet_txt_read() eq ( 0, "capability=smudge" ) ) || die "bad capability";
-- 
2.13.1.565.gbfcd7a9048

