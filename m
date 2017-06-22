Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3252820282
	for <e@80x24.org>; Thu, 22 Jun 2017 10:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753177AbdFVK1B (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 06:27:01 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:53127 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752960AbdFVK07 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 06:26:59 -0400
Received: from lindisfarne.localdomain ([92.22.42.39])
        by smtp.talktalk.net with SMTP
        id NzK5dhmIPxR4bNzKEdWEVN; Thu, 22 Jun 2017 11:26:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1498127218; bh=VNjSRKSCazG1jWg34F4ClTtLbwE4GkkCSt/sF5z6BNk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=s3oFh0i/qhp7KBUu2hkS7LEq7W6UhKboy8v5bChWPAw60k0CT3R/0AifbBxCgOQ+N
         6OjQN8de0rCEOgnXjkJAKJBydMod8/WIbkHAycJhaVCGArC3kNZ6o9zpLdzVJFbcGD
         5uRCNL+ZaSQlNkhrlLUSDT3xXNGn1D1X4U2FLueg=
X-Originating-IP: [92.22.42.39]
X-Spam: 0
X-OAuthority: v=2.2 cv=JNN5iICb c=1 sm=1 tr=0 a=0UCMmuyk8Ln1ykD6Z38Clg==:117
 a=0UCMmuyk8Ln1ykD6Z38Clg==:17 a=evINK-nbAAAA:8 a=TKfsREZqI9Y0XWvoPdYA:9
 a=LsMHBw6SYadqt1jD:21 a=81HVJKmb7TdT7A2E:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 2/5] Git::unquote_path() Handle '\a'
Date:   Thu, 22 Jun 2017 11:26:19 +0100
Message-Id: <20170622102622.26147-3-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170622102622.26147-1-phillip.wood@talktalk.net>
References: <20170622102622.26147-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfKNYu7KyeyZLH+iB14yhrlwTll0RXVMyy2NM6YQF5MJLQ9Dez2qXsDjY70c9FtTJs/2scuoW01vjpBeCqlN4bCqpJCPChyrQOJmIP5M8qoY/XYoSsgyP
 GODX6g3IYloPime6EBH3XC5yU41Ntazgwp5YA+IpmEg1f2IWtNiVKJBr6je7EYo9YdTEFyWnbFxuX9MwS1qOKx+h1WR/g0Me2RfDE1IRY5WkH8ttgr7YG8bC
 5SoT3+GldwqiGlE6VxR9Pg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The version copied from git-add--interactive did not handle quoted
paths containing '\a'.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 perl/Git.pm | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 8afde87fc8162271ba178e0fff3e921f070ac621..889bf88cfcd34136e24e166fb3b72cced6debf9d 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -1461,6 +1461,7 @@ when not using -z
 
 {
 	my %unquote_map = (
+		"a" => chr(7),
 		"b" => chr(8),
 		"t" => chr(9),
 		"n" => chr(10),
@@ -1487,7 +1488,7 @@ when not using -z
 					$_ = $2;
 					last;
 				}
-				if (/^([\\\042btnvfr])(.*)$/) {
+				if (/^([\\\042abtnvfr])(.*)$/) {
 					$retval .= $unquote_map{$1};
 					$_ = $2;
 					last;
-- 
2.13.0

