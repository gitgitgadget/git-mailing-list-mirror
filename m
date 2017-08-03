Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87E63208CB
	for <e@80x24.org>; Thu,  3 Aug 2017 09:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751974AbdHCJTw (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 05:19:52 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33187 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751821AbdHCJTr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 05:19:47 -0400
Received: by mail-wm0-f67.google.com with SMTP id q189so1445831wmd.0
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 02:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FaRIzeJSqOlc2CiL76dCoVlHZ5JzDqJ00OeHAIwutpk=;
        b=lrIdYtAvsdUMeHQu5b3pAao++usHBhcT2VXgcaiOA6dIfMHzIL7zCZ5KM2YwC9daBA
         ONJNqQCw7wG2AdNWd+QTJr5whiThMNIQCarg4bY4AFJvZcij0L9idwtDTpyI3BvOwwWb
         Osel45kxi3rq+0NwFX/ymSevu2nYYc/ER4oTwunQlMCeTE5VkoHXmx3MtuI2/A1Uahx/
         sFvrGasDT84Y9ENOtv+lna/3XFEjxySYgTXsxGzqDSOCeKTAwum9o3y2DbLqWXA4GvC8
         /RUJBAy/3mWg0wHekbQBiLErxsmaICeBXiP81zQ5MJhmpDMdgFGR+z6u8GE/3Q3J3Zxu
         WetA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FaRIzeJSqOlc2CiL76dCoVlHZ5JzDqJ00OeHAIwutpk=;
        b=W8n2YcAIC5rRbM9TKNCCAzN3LCv15MKEjCBiQKGBLQSGMvTBBxw1YLpK4X/VJn2hI0
         a/x0EJ0GN1DNPsNG7PiTyIswMUt++W+odVmc3xpD+VF1bPvDEqX5ymXdpOPEV1VTGNzz
         gRaivQ9U6oxAsoTfXCGOHonRNAoZKMaq9vlnpQYXQy/Qm111Ladulxt+5wYf4lmef8wC
         /OJneSSAFvtzRGtReYsQfNj0KswZvxk7eWE2C8a9xejwz+WrwknS/byF4SwlA7Dpl+Gb
         DsJu9z8VZAkyCQlCpuJvJOZxhhdmLlInzcSmeZFm66gYtN6DGZwg7h24K2yejWqUEB/N
         MEgw==
X-Gm-Message-State: AHYfb5iz+INw3O0BGt4wWboqCVx/3kEvDZlR9wb1cZa6PZl8bprvljkb
        i7/xi1FVoKH3anti
X-Received: by 10.28.236.70 with SMTP id k67mr699128wmh.30.1501751986358;
        Thu, 03 Aug 2017 02:19:46 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id n184sm1308051wme.33.2017.08.03.02.19.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 02:19:45 -0700 (PDT)
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
Subject: [PATCH v5 07/40] Git/Packet.pm: add packet_initialize()
Date:   Thu,  3 Aug 2017 11:18:53 +0200
Message-Id: <20170803091926.1755-8-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.0.rc1.52.gf02fb0ddac.dirty
In-Reply-To: <20170803091926.1755-1-chriscool@tuxfamily.org>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
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
2.14.0.rc1.52.gf02fb0ddac.dirty

