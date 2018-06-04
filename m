Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70AF81F403
	for <e@80x24.org>; Mon,  4 Jun 2018 07:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751624AbeFDHz6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 03:55:58 -0400
Received: from mout.web.de ([217.72.192.78]:54303 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751097AbeFDHz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 03:55:57 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MQvgI-1frhtY0ZKA-00UJxI; Mon, 04
 Jun 2018 09:55:50 +0200
Date:   Mon, 4 Jun 2018 09:55:49 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Anthony Sottile <asottile@umich.edu>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Regression (?) in core.safecrlf=false messaging
Message-ID: <20180604075549.GA21063@tor.lan>
References: <CA+dzEBm_doNMjEs_OWwia_mm7u3ztAFpCpaFJP3DRpFhEo93jg@mail.gmail.com>
 <20180604073855.GA20922@tor.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180604073855.GA20922@tor.lan>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:flPlCBX0M61icJUTVdfMG9zxXWAIUospXSP33IJx1ZtDTlywX+j
 Ol2bVrb0pFKZbpmF+Rp4f5rT1VDkQtstc5CLWob8F9vB7bwePrSFayRjVu3P4l19Qdx8kQi
 3mwOOkrFhLlAQrBR8OsrSDx8RBsl2aO2EUUMs+yYnv92qOiGQQw8PN7cuLxcxgQLmDKGjv8
 99od2oadjnxUXj8XbwsQg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:G1/bZ5wme3c=:MFDvjywtmpNOhmkEB/SsYx
 zQc4e8j8FdGLarVvgMWlbQGC9TRRWxM0DgzWQnpN/xeIkm4+seObfirI6meLbog8+UdR5ZV3o
 6kwr61jXE61t5IeIyYeU5xoaZ6h0VlsrPo2ly+fSvgqTIGqN9XHxZ6pTunxJEqoZ5DEAqecHP
 5XEjHYRZ3oWVuz/wGhGwKuhixad3wOZgjeo7gHLDE9k3xF7umwlxy3d0YmnQvKoXOd87DSSwV
 6qBY83vXtEWXIIrV5B+eBwpv6yoMUV1WSYvo2P4rzetdvDjV3CSeV0ZL/5RBBTjsjdECDCUvj
 wJ2ccFhmcCWSScA559bGlra5wiZNDhgtvzHycf2pmL7u9Eu+R7N51rqFk06G+CQEDhS/z/N+0
 BXmNJ73e6ubB11gL48pVjz8ZedU2EJob+uv+o9CX0dBl0sdnLN2Q8AwZiWhNqC4nRiSfUsiim
 J3khsrsHoZ1WrN15MOpsWbwqG8LgoFZUCi7gLSuouhUbZlXiiLQtPjQFZHy7x100GJN29vh8w
 B+4BF+d2YntkJvwgJjP57Uf7A7LvKdAm55HNu0kCpcSRkkZ1HvV3IFUQAhKRVrdmz11UL5LnU
 u6dY6fkbuHKipcAGEmS5UM626SoIvKsUZNAmlKqs8JHGvaj4mbGixVM+Bh9aISlgWs24Nc8sc
 pyWS6lGajYgr1Gf73vyDud0gzB01qcc5MWWNSYekoKuJKkgXDX0LuzcM+Pxn3sbbqZElCfOBW
 V07JLFoaFOVpxceQjbge6Fj1mgBRgjYvcIZbupvl4PVZlFx/hlfZ/NM12Qc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Does the following patch fix your problem ?

diff --git a/config.c b/config.c
index 6f8f1d8c11..c625aec96a 100644
--- a/config.c
+++ b/config.c
@@ -1233,7 +1233,7 @@ static int git_default_core_config(const char *var, const char *value)
 		}
 		eol_rndtrp_die = git_config_bool(var, value);
 		global_conv_flags_eol = eol_rndtrp_die ?
-			CONV_EOL_RNDTRP_DIE : CONV_EOL_RNDTRP_WARN;
+			CONV_EOL_RNDTRP_DIE : 0;
 		return 0;
 	}
 
