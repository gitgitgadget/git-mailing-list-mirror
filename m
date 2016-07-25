Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DBFE203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 14:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752143AbcGYOhO (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 10:37:14 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.27]:36668 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751418AbcGYOhM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 10:37:12 -0400
Received: from [62.224.170.225] (helo=sandbox)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1.2:AES128-GCM-SHA256:128)
	(Exim 4.84)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1bRh0H-0003Kc-8A; Mon, 25 Jul 2016 16:37:09 +0200
Date:	Mon, 25 Jul 2016 16:37:07 +0200
From:	Heiko Voigt <hvoigt@hvoigt.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH] submodule-config: use explicit empty string instead of
 strbuf in config_from()
Message-ID: <20160725143706.GA4872@sandbox>
References: <578E7A07.8080006@web.de>
 <20160720082515.GA823@book.hvoigt.net>
 <57911AFF.7030107@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57911AFF.7030107@web.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

On Thu, Jul 21, 2016 at 08:57:03PM +0200, René Scharfe wrote:
> >diff --git a/submodule-config.c b/submodule-config.c
> >index 077db40..dccea59 100644
> >--- a/submodule-config.c
> >+++ b/submodule-config.c

[...]

> >@@ -431,14 +432,19 @@ static const struct submodule *config_from(struct submodule_cache *cache,
> >  		submodule = cache_lookup_path(cache, sha1, key);
> >  		break;
> >  	}
> >-	if (submodule)
> >+	if (submodule) {
> >+		strbuf_release(&rev);
> >  		return submodule;
> >+	}
> >
> >  	config = read_sha1_file(sha1, &type, &config_size);
> >-	if (!config)
> >+	if (!config) {
> >+		strbuf_release(&rev);
> >  		return NULL;
> >+	}
> >
> >  	if (type != OBJ_BLOB) {
> >+		strbuf_release(&rev);
> >  		free(config);
> >  		return NULL;
> >  	}
> 
> A separate patch could combine the previous two conditionals; free(NULL) is
> allowed.

Thats a good idea. Can send a patch, but I noticed that your change is
already in next and my change has not been picked up. So I am unsure if
I should base my patches on next or if Junio wants to keep your change?

Cheers Heiko
