Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EBBA1FE4E
	for <e@80x24.org>; Thu, 30 Jun 2016 19:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752276AbcF3TsJ (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 15:48:09 -0400
Received: from sdaoden.eu ([217.144.132.164]:37480 "EHLO sdaoden.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751487AbcF3TsI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 15:48:08 -0400
X-Greylist: delayed 588 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Jun 2016 15:48:08 EDT
Received: by sdaoden.eu (Postfix, from userid 1000)
	id 269DF1604A; Thu, 30 Jun 2016 21:38:16 +0200 (CEST)
Date:	Thu, 30 Jun 2016 21:38:45 +0200
From:	Steffen Nurpmeso <steffen@sdaoden.eu>
To:	git@vger.kernel.org
Subject: --abbrev-commit gives longer hash than necessary
Message-ID: <20160630193845.TbelqPPHx%steffen@sdaoden.eu>
User-Agent: s-nail v14.8.9-269-g036bccc
OpenPGP: id=95F382CE;
 url=https://www.sdaoden.eu/downloads/steffen.asc
X-BlahBlahBlah:	Any stupid boy can crush a beetle. But all the professors
 in the world can make no bugs.
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hello, for your possible interest.

For some time (currently with 2.9.0) know see that a single commit
gives a longer hash than necessary, even though there is no
ambiguity:

  ?0[steffen@wales ]$ git longca|
  awk 'BEGIN{l7=0;l8=0}\
    /^[[:alnum:]]{7} /{++l7;next}\
    /^[[:alnum:]]{8} /{++l8;print}\
  END{print "L7 " l7 " L8 " l8}'
  786d0c9c [mimepipe.2] send.c:sendpart(): force iconv(3)+ for TEXT part handlers..
  L7 3364 L8 1

So it is only this single commit.. but why?

  ?0[steffen@wales ]$ git long1 786d0c9
  786d0c9c [mimepipe.2] send.c:sendpart(): force iconv(3)+ for TEXT part handlers..
  ?0[steffen@wales ]$ git long1 786d0c
  786d0c9c [mimepipe.2] send.c:sendpart(): force iconv(3)+ for TEXT part handlers..
  ?0[steffen@wales ]$ git long1 786d0
  786d0c9c [mimepipe.2] send.c:sendpart(): force iconv(3)+ for TEXT part handlers..
  ?0[steffen@wales ]$ git long1 786d
  786d0c9c [mimepipe.2] send.c:sendpart(): force iconv(3)+ for TEXT part handlers..

Not really ambiguous:

  ?0[steffen@wales ]$ git long|cut -f1 -d' '|grep ^786
  786d0c9c
  786f219

Ciao!

--steffen
