Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1885620D11
	for <e@80x24.org>; Tue, 20 Jun 2017 07:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751990AbdFTH4C (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:56:02 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36031 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751754AbdFTHz6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:55:58 -0400
Received: by mail-wm0-f67.google.com with SMTP id d17so21329319wme.3
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fOKGE1qpLsFbM+mwB+9mU66ui+0MnkR8JslZKFYDQMA=;
        b=RCdXQrgIhogw720qZMYJ89yV8PQailQUPYU/Upwr8yiR6xX2GUqgqCT4G8d5B8JfYi
         RIe3HLIW1WNKy86qi1WW1xVALqO8xtlIS0EGmrooVPXsnv7jTH0/GQdYaxIiL2kFTHzO
         MqFkYw9IewpNdFEwj0ylaymcfAnKCaQ8StQ67C9xgXQYcFnYFyyf0CF5yO8Vb6u7HXEL
         jjteOIK7yG1Jd3QPLbba8MVcuQZvOX8Q23UH6TD03ak6HVTHV9K3SZI1WbKPs013A5zh
         5b2eL0yJ8u8YIl/zbfgG18+2zwMycIVC0vFF9ajyoXufpVl6+m2UkoNboI88nvoUexA9
         0IUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fOKGE1qpLsFbM+mwB+9mU66ui+0MnkR8JslZKFYDQMA=;
        b=Ur33DwhETWHGfoUSXhfbZGFijFeW6buujtiRVC1x+FVG1i6CedFVnkyskWlPonwgBR
         +dYVxXFA20BeB9uNaq4yGEfpSAEg3MMQ6FpaVK6SCK3UrfML0THb4uUkmLAm+Bb99fht
         lVFItwo5QYbM7VHb+F5u+OmbfzG6Ahz7UCEM0lEIA769zROpd07r0XuUK4rzZkKtOmki
         3elgczZrB+9kb0JPNlceEvx4NMHjIW1eHV3Jjw1ifEl2I2lyTm9/bL6gN5klPjBSnFzS
         efowNdmafWON9FWEkuEjI7LXSnPDXycDgI0pbNbZN6JxqjS9DylB91w7owNrjbOIG2jz
         8Fag==
X-Gm-Message-State: AKS2vOxMN7QzHgW+N0LrdDUJJTuDmelW2RZll+BfRnqPAbacay2PAwWb
        ho5lQZ1Y5EOLD+YI
X-Received: by 10.28.143.149 with SMTP id r143mr1713507wmd.61.1497945356522;
        Tue, 20 Jun 2017 00:55:56 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k86sm11577890wmi.16.2017.06.20.00.55.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 00:55:55 -0700 (PDT)
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
Subject: [RFC/PATCH v4 06/49] Git/Packet.pm: improve error message
Date:   Tue, 20 Jun 2017 09:54:40 +0200
Message-Id: <20170620075523.26961-7-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.565.gbfcd7a9048
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Try to give a bit more information when we die()
because there is no new line at the end of something
we receive.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 perl/Git/Packet.pm | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/perl/Git/Packet.pm b/perl/Git/Packet.pm
index aaffecbe2a..2ad6b00d6c 100644
--- a/perl/Git/Packet.pm
+++ b/perl/Git/Packet.pm
@@ -49,7 +49,8 @@ sub packet_bin_read {
 sub packet_txt_read {
 	my ( $res, $buf ) = packet_bin_read();
 	unless ( $res == -1 || $buf =~ s/\n$// ) {
-		die "A non-binary line MUST be terminated by an LF.";
+		die "A non-binary line MUST be terminated by an LF.\n"
+		    . "Received: '$buf'";
 	}
 	return ( $res, $buf );
 }
-- 
2.13.1.565.gbfcd7a9048

