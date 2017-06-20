Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADB1320401
	for <e@80x24.org>; Tue, 20 Jun 2017 07:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751732AbdFTHz5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:55:57 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33812 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750863AbdFTHzx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:55:53 -0400
Received: by mail-wm0-f67.google.com with SMTP id f134so3643059wme.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=stX9fmQySUFS3lYxJYMg578jFmjRJV+frQOkK7VyNSA=;
        b=BeHIeA1wIdG2paUpHU4uBgmDYadf0PL2tg0jQ4fWiiywJq3v3icNfDj/ZtS6K6JsW0
         HQxFudPIV2VVMD3j8BxKI1sx9n/bADUt9XlX4kpyMX+VkVibKLY/+fGbMsMfmfDOuHbb
         I9Kftfo7KP1WKd87yq61FybWOb6mrtZBcTN9+DqZkqF6/FpTO2WlrcPhg++/3cUpEiuT
         LEEQJsvgGmHvcSkJ8BJ8aCanjl+Ln9upemgUAnQLJ1AHa7/fLlnTUw+L/vkvyzk0PFsJ
         qvGc/Dbzm02CtOaGanN8JBO0GoSz0UFx/AMitU+YUIwJVmFvMjA4qt6sCzz4/gSaCcAi
         gREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=stX9fmQySUFS3lYxJYMg578jFmjRJV+frQOkK7VyNSA=;
        b=VxWOiQ91Kpdl9YxzXIg2r/nA9LYQq9WAkoAcPT6jcICTOkVEcrL8P2r1aK0C4L5pf+
         zbxvvi55DvfLbuI5K5fQ6Ha1nJiSz8t51q9sMrJePZbJbSJZPKH5UCo9I7WxAC+j85wc
         Vzu37xl1aUAzWXeOPo1fhPcDRxMVs6b3hQn6CkblwJzgNS6MdcdL02CSaDnb0uEKyMWo
         jnT7pKo769CNnuWcElWTHHEJM2YUyPHXD4twaLwq2i8uT4bQETI9OscL1i4vEt2MQSC/
         fyDAguzM/8ElLSw2yOhpj3KMYeKIfXs5PWWLxILiGaSA78iig7be6R+hPUUuFWLsLH72
         0zoA==
X-Gm-Message-State: AKS2vOz8Oac8J9eDfwiWoHiFl6LaJH+xH7e8mh3998U5Xo//zI9M1A3I
        oEtYn4CdcHr+3RJ4
X-Received: by 10.28.95.135 with SMTP id t129mr1757995wmb.61.1497945351655;
        Tue, 20 Jun 2017 00:55:51 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k86sm11577890wmi.16.2017.06.20.00.55.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 00:55:50 -0700 (PDT)
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
Subject: [RFC/PATCH v4 02/49] t0021/rot13-filter: refactor packet reading functions
Date:   Tue, 20 Jun 2017 09:54:36 +0200
Message-Id: <20170620075523.26961-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.565.gbfcd7a9048
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
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
2.13.1.565.gbfcd7a9048

