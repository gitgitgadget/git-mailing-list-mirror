Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 311031F858
	for <e@80x24.org>; Thu, 28 Jul 2016 12:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757517AbcG1MuN (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 08:50:13 -0400
Received: from smtprelay02.ispgateway.de ([80.67.31.40]:50382 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757401AbcG1MuM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 08:50:12 -0400
Received: from [62.224.174.160] (helo=sandbox)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1.2:AES128-GCM-SHA256:128)
	(Exim 4.84)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1bSklL-0007B7-47; Thu, 28 Jul 2016 14:50:07 +0200
Date:	Thu, 28 Jul 2016 14:50:05 +0200
From:	Heiko Voigt <hvoigt@hvoigt.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Stefan Beller <sbeller@google.com>, Git List <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: [PATCH 3/3] submodule-config: fix test binary crashing when no
 arguments given
Message-ID: <20160728125002.GC2530@sandbox>
References: <578E7A07.8080006@web.de>
 <20160720082515.GA823@book.hvoigt.net>
 <57911AFF.7030107@web.de>
 <20160725143706.GA4872@sandbox>
 <xmqq60rt933m.fsf@gitster.mtv.corp.google.com>
 <20160726094913.GA3347@book.hvoigt.net>
 <CAGZ79kaOf3NRAXh+krM=onwswSjAF3yy_zpa1d+9CFOBNke6-w@mail.gmail.com>
 <xmqqmvl4xdlm.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmvl4xdlm.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Since arg[0] will be NULL without any argument here and starts_with()
does not like NULL-pointers.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
A small fix I found while developing the test.

 test-submodule-config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test-submodule-config.c b/test-submodule-config.c
index dab8c27..a4e4098 100644
--- a/test-submodule-config.c
+++ b/test-submodule-config.c
@@ -23,7 +23,7 @@ int main(int argc, char **argv)
 
 	arg++;
 	my_argc--;
-	while (starts_with(arg[0], "--")) {
+	while (arg[0] && starts_with(arg[0], "--")) {
 		if (!strcmp(arg[0], "--url"))
 			output_url = 1;
 		if (!strcmp(arg[0], "--name"))
-- 
2.0.2.832.g083c931

