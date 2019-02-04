Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E20B11F453
	for <e@80x24.org>; Mon,  4 Feb 2019 19:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfBDTof (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 14:44:35 -0500
Received: from avasout04.plus.net ([212.159.14.19]:32924 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbfBDToe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 14:44:34 -0500
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id qkARgrrDvAOoyqkASgNiH1; Mon, 04 Feb 2019 19:44:33 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Rdm+9Wlv c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=vS6L6dtdCaZhYJcMGsoA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] trace2: fix hdr-check warnings
To:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <ba0549c5-25f1-efcc-e49a-d7e76be73fe3@ramsayjones.plus.com>
 <00e08dc3-a610-0429-e819-1d29d0ddb81a@jeffhostetler.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <d680fda2-7e54-2200-cd00-97772de45b47@ramsayjones.plus.com>
Date:   Mon, 4 Feb 2019 19:44:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <00e08dc3-a610-0429-e819-1d29d0ddb81a@jeffhostetler.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfObePbYCTDNs4o9MivcLqnEcDJ23G16TmTy36BmTYmpzX78iV7kwF+Nez+JU2Z50aHiDdcY0jqgsXIpfX8IDDrJmczKBacPujfqpCtJxz++OSVZMjpo5
 8pQVlggD9ejqx4T3bra2EHqNFR33dMQ+fjaVPoyMLCu2by9EPPPYgw+6vr/HA1VM+eEs9NPlqu6LYQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 30/01/2019 12:29, Jeff Hostetler wrote:
> 
> 
> On 1/26/2019 4:07 PM, Ramsay Jones wrote:
>>
>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> ---
>>
>> Hi Jeff,
>>
>> If you need to re-roll your 'jh/trace2' branch, could you please
>> squash this into the relevant patches (sorry, I didn't look to
>> see which patches need to be modified).
> 
> Will do. Thanks.
> 
> BTW, how do you find these?  I ran both "make sparse" and
> "make DEVELOPER=1" and it didn't complain about these items.

Carlo already replied about 'make hdr-check', but you seem to
have missed squashing half of the original patch, since the
re-rolled series still causes 'make -k hdr-check >phcout 2>&1'
to show:

  $ diff nhcout phcout
  22a23,34
  >     HDR trace2/tr2_dst.h
  >     HDR trace2/tr2_cfg.h
  >     HDR trace2/tr2_tgt.h
  >     HDR trace2/tr2_cmd_name.h
  >     HDR trace2/tr2_sid.h
  >     HDR trace2/tr2_tls.h
  > trace2/tr2_tls.h:12:16: error: field ‘thread_name’ has incomplete type
  >   struct strbuf thread_name;
  >                 ^~~~~~~~~~~
  > Makefile:2739: recipe for target 'trace2/tr2_tls.hco' failed
  > make: *** [trace2/tr2_tls.hco] Error 1
  >     HDR trace2/tr2_tbuf.h
  131c143
  < Makefile:2725: recipe for target 'sha256/gcrypt.hco' failed
  ---
  > Makefile:2739: recipe for target 'sha256/gcrypt.hco' failed
  164a177
  >     HDR trace2.h
  $ 

So, quoting the last part of the original patch:

diff --git a/trace2/tr2_tls.h b/trace2/tr2_tls.h
index 99ea9018ce..bb80e3f8e7 100644
--- a/trace2/tr2_tls.h
+++ b/trace2/tr2_tls.h
@@ -1,6 +1,8 @@
 #ifndef TR2_TLS_H
 #define TR2_TLS_H
 
+#include "strbuf.h"
+
 /*
  * Arbitry limit for thread names for column alignment.
  */
-- 


ATB,
Ramsay Jones




