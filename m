Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0859720195
	for <e@80x24.org>; Wed, 20 Jul 2016 02:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752644AbcGTC4b (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 22:56:31 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:42868 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752430AbcGTC4b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 22:56:31 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54A2F20195;
	Wed, 20 Jul 2016 02:56:30 +0000 (UTC)
Date:	Wed, 20 Jul 2016 02:56:30 +0000
From:	Eric Wong <e@80x24.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org
Subject: [PATCH] config.mak.uname: set PERL_PATH for FreeBSD 5.0+
Message-ID: <20160720025630.GA71874@plume>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Perl has not been part of the base system since FreeBSD 5.0:

	https://www.freebsd.org/releases/5.0R/relnotes-i386.html

Signed-off-by: Eric Wong <e@80x24.org>
---
  Does anybody still run git on FreeBSD 4.x or earlier?
  4.11 was released a few months before git in 2005:

	https://www.freebsd.org/releases/

 config.mak.uname | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index a88f139..6c29545 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -202,6 +202,11 @@ ifeq ($(uname_S),FreeBSD)
 		NO_UINTMAX_T = YesPlease
 		NO_STRTOUMAX = YesPlease
 	endif
+	R_MAJOR := $(shell expr "$(uname_R)" : '\([0-9]*\)\.')
+
+	ifeq ($(shell test "$(R_MAJOR)" -ge 5 && echo 1),1)
+		PERL_PATH = /usr/local/bin/perl
+	endif
 	PYTHON_PATH = /usr/local/bin/python
 	HAVE_PATHS_H = YesPlease
 	GMTIME_UNRELIABLE_ERRORS = UnfortunatelyYes
-- 
EW
