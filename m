Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB29C203E1
	for <e@80x24.org>; Tue, 26 Jul 2016 09:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754334AbcGZJtc (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 05:49:32 -0400
Received: from smtprelay02.ispgateway.de ([80.67.31.40]:57551 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753423AbcGZJtb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 05:49:31 -0400
Received: from [84.46.92.130] (helo=book.hvoigt.net)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.84)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1bRyzP-0001K6-Ed; Tue, 26 Jul 2016 11:49:27 +0200
Date:	Tue, 26 Jul 2016 11:49:25 +0200
From:	Heiko Voigt <hvoigt@hvoigt.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: [PATCH 2/2] submodule-config: combine error checking if clauses
Message-ID: <20160726094925.GB3347@book.hvoigt.net>
References: <578E7A07.8080006@web.de>
 <20160720082515.GA823@book.hvoigt.net>
 <57911AFF.7030107@web.de>
 <20160725143706.GA4872@sandbox>
 <xmqq60rt933m.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq60rt933m.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

So we have less return handling code.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 submodule-config.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 853989e..cb9bf8f 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -416,12 +416,7 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 	}
 
 	config = read_sha1_file(sha1, &type, &config_size);
-	if (!config) {
-		strbuf_release(&rev);
-		return NULL;
-	}
-
-	if (type != OBJ_BLOB) {
+	if (!config || type != OBJ_BLOB) {
 		strbuf_release(&rev);
 		free(config);
 		return NULL;
-- 
2.4.2.387.gf86f31a

