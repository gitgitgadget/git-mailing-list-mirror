Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DF462047F
	for <e@80x24.org>; Thu,  3 Aug 2017 09:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751931AbdHCJTo (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 05:19:44 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34820 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751809AbdHCJTl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 05:19:41 -0400
Received: by mail-wm0-f65.google.com with SMTP id r77so1442444wmd.2
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 02:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j/WcuvjqFWcisLjpHAFxVomqhfnZ+YRAfPiNGl41tvI=;
        b=u/tfpB6gef/C91534zNjb/0I/DNjKKN16EgoEId+RcN48N3/UUV2nTwTXQE+9j3mdH
         7sAcX2f2m7lbPZaurqY1dbWGyiXcbWg/IIxR4+DnaDR8NErfAVb0WVG1Nn7lrS4PXLWV
         ByYfkjPTeeta6h+MLi0xcjrZS+UXZdIClJ27BJOwb660Ocvs0d3sL0ztZhjHsq3rCOQA
         QD4u1smMfzqUFcC4nCda28KrTMDfuSjcV1Ig2fAlK0xe0CbXSRvDmP6fJvRft40yCFm8
         zN7BGJLPPciU4XHxKae8XsYiEJCOUED00XMDFuDVSMyT08Z6VKsdFblQ5NNumokaadis
         q0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j/WcuvjqFWcisLjpHAFxVomqhfnZ+YRAfPiNGl41tvI=;
        b=jbbm6/dEvktnQrSmzFtVZCVXIsKbCtp0RpvLZHFKO8UB+L28hPRidfjmy6T720f0vO
         bYmnvRYV3NCGCBqJDgGl50NetlNS0Q2QjJWxztQA3n3jrIWGuaIZCPx90jTNI1kSXjZY
         QfKydBzcl5q9A4n4EBHTzPNXpddEaB/hIsvprtt+7MaIT2YNSEdLU4PV218s7MET1rpF
         BeV/5pSPyqmZx5D82u5on8gMOT7r5N1cryU48hi188qxfdAlyHr0CSvxyLleUlfGqqTS
         DSL5/hjrLeudhQ0vR3C3YWRXnVrzkQZBmWcT1NgManYXCGDV5NxvxSxobD49KPZW9UbY
         HyHg==
X-Gm-Message-State: AIVw1125iAcBeElcrez8RsUG1cjYr6IY+0F/rf0jiZFaI51ke8AQtqJw
        XFTYsiVdCAamzTlG
X-Received: by 10.28.35.73 with SMTP id j70mr660561wmj.94.1501751980202;
        Thu, 03 Aug 2017 02:19:40 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id n184sm1308051wme.33.2017.08.03.02.19.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 02:19:39 -0700 (PDT)
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
Subject: [PATCH v5 02/40] t0021/rot13-filter: refactor packet reading functions
Date:   Thu,  3 Aug 2017 11:18:48 +0200
Message-Id: <20170803091926.1755-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.0.rc1.52.gf02fb0ddac.dirty
In-Reply-To: <20170803091926.1755-1-chriscool@tuxfamily.org>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To make it possible in a following commit to move packet
reading and writing functions into a Packet.pm module,
let's refactor these functions, so they don't handle
printing debug output and exiting.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0021/rot13-filter.pl | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
index 617f581e56..d6411ca523 100644
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -39,8 +39,7 @@ sub packet_bin_read {
 	my $bytes_read = read STDIN, $buffer, 4;
 	if ( $bytes_read == 0 ) {
 		# EOF - Git stopped talking to us!
-		print $debug "STOP\n";
-		exit();
+		return ( -1, "" );
 	}
 	elsif ( $bytes_read != 4 ) {
 		die "invalid packet: '$buffer'";
@@ -64,7 +63,7 @@ sub packet_bin_read {
 
 sub packet_txt_read {
 	my ( $res, $buf ) = packet_bin_read();
-	unless ( $buf =~ s/\n$// ) {
+	unless ( $res == -1 || $buf =~ s/\n$// ) {
 		die "A non-binary line MUST be terminated by an LF.";
 	}
 	return ( $res, $buf );
@@ -109,7 +108,12 @@ print $debug "init handshake complete\n";
 $debug->flush();
 
 while (1) {
-	my ($command) = packet_txt_read() =~ /^command=(.+)$/;
+	my ($res, $command) = packet_txt_read();
+	if ( $res == -1 ) {
+		print $debug "STOP\n";
+		exit();
+	}
+	$command =~ s/^command=//;
 	print $debug "IN: $command";
 	$debug->flush();
 
-- 
2.14.0.rc1.52.gf02fb0ddac.dirty

