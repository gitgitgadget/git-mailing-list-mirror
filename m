Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C52820282
	for <e@80x24.org>; Thu, 22 Jun 2017 10:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753215AbdFVK1H (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 06:27:07 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:37962 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752988AbdFVK1A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 06:27:00 -0400
Received: from lindisfarne.localdomain ([92.22.42.39])
        by smtp.talktalk.net with SMTP
        id NzK5dhmIPxR4bNzKEdWEVR; Thu, 22 Jun 2017 11:26:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1498127219; bh=02r9YWYD+M2etYNHrpasjUmHj991Zo5Whvt74znrItQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=rH2+lbdYvvjwcr5XSFWPDaFhrmdG3xX/ht5QKVpyZAGMacKCxP890KItPHfuSOvPR
         MFFW1Oj2fv3qN7cwbBMNoXl3710RspXfGwcocmpmyQo40nTxZyA/RsHXy9qzdXJLPv
         QRzY/2hyZNF6JlocY9rcdkCnqT5RofZAONnr7ANs=
X-Originating-IP: [92.22.42.39]
X-Spam: 0
X-OAuthority: v=2.2 cv=JNN5iICb c=1 sm=1 tr=0 a=0UCMmuyk8Ln1ykD6Z38Clg==:117
 a=0UCMmuyk8Ln1ykD6Z38Clg==:17 a=evINK-nbAAAA:8 a=HhPA1Zu1Id1Cj8__UdYA:9
 a=xWT67Tv2KBUqqxcK:21 a=vCd91sBY12AHedfm:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 3/5] Git::unquote_path() throw an exception on bad path
Date:   Thu, 22 Jun 2017 11:26:20 +0100
Message-Id: <20170622102622.26147-4-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170622102622.26147-1-phillip.wood@talktalk.net>
References: <20170622102622.26147-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfCW2A9KhDL6F1M1H/ziWIMMl7sCGTyJX283X9kmmG3E7WI++Tsd9sSocU8DeDnNz0riR/pjGJZcAVuE1kwkA7HdK2EYmpv283vCfwCYMc88TB5a4Vgp+
 12x2wUrePhzw/as1ZS4WlQ4sEHON3LdbjDDKMRtyXQWcHbcrn0UjOv71P+CqQB06wVCC9oGIZKT08CCstS85VJYo+4l8zdgrFS6LNsj8LB1Pk94zMinx30vg
 vx6HoSD0+VIbHPHJIdRj+Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This is what the other routines in Git.pm do if there's an error.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 perl/Git.pm | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 889bf88cfcd34136e24e166fb3b72cced6debf9d..51cb3446088dd12e8fd93d47b95e29fab22a8466 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -1493,8 +1493,8 @@ when not using -z
 					$_ = $2;
 					last;
 				}
-				# This is malformed -- just return it as-is for now.
-				return $_[0];
+				# This is malformed
+				throw Error::Simple("Invalid quoted path $_[0]");
 			}
 			$_ = $remainder;
 		}
-- 
2.13.0

