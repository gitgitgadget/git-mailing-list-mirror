Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D226E208DB
	for <e@80x24.org>; Thu, 24 Aug 2017 07:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751255AbdHXHRO (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 03:17:14 -0400
Received: from 4.mo64.mail-out.ovh.net ([46.105.45.191]:44847 "EHLO
        4.mo64.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751231AbdHXHRN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 03:17:13 -0400
Received: from ex2.mail.ovh.net (gw1.ex2.mail.ovh.net [164.132.80.186])
        by mo64.mail-out.ovh.net (Postfix) with ESMTPS id 2848173CF4;
        Thu, 24 Aug 2017 08:57:12 +0200 (CEST)
Received: from [10.0.2.127] (86.200.152.136) by EX7.indiv2.local (172.16.2.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 24
 Aug 2017 08:57:11 +0200
Subject: Re: [PATCH v3 1/4] imap-send: return with error if curl failed
To:     Junio C Hamano <gitster@pobox.com>
CC:     <git@vger.kernel.org>, <peff@peff.net>
References: <087f5907-6558-ce32-2f5c-2e418522c030@morey-chaisemartin.com>
 <da29995c-3c56-ac43-9f8f-12bf381711f3@morey-chaisemartin.com>
 <xmqqy3qaxcur.fsf@gitster.mtv.corp.google.com>
From:   Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Openpgp: preference=signencrypt
Message-ID: <59827003-6f84-712c-bbc8-33e3ac90f590@morey-chaisemartin.com>
Date:   Thu, 24 Aug 2017 08:57:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:56.0) Gecko/20100101
 Thunderbird/56.0
MIME-Version: 1.0
In-Reply-To: <xmqqy3qaxcur.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: fr-xx-classique+reforme1990
X-Originating-IP: [86.200.152.136]
X-ClientProxiedBy: CAS4.indiv2.local (172.16.1.4) To EX7.indiv2.local
 (172.16.2.7)
X-Ovh-Tracer-Id: 8703206282371459063
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelledrtdefgdduvddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecufedttdenuc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Le 23/08/2017 à 22:12, Junio C Hamano a écrit :
> Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com> writes:
>
>> curl_append_msgs_to_imap always returned 0, whether curl failed or not.
>> Return a proper status so git imap-send will exit with an error code
>> if womething wrong happened.
>>
>> Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
>> ---
>>  imap-send.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/imap-send.c b/imap-send.c
>> index b2d0b849b..09f29ea95 100644
>> --- a/imap-send.c
>> +++ b/imap-send.c
>> @@ -1490,7 +1490,7 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
>>  	curl_easy_cleanup(curl);
>>  	curl_global_cleanup();
>>  
>> -	return 0;
>> +	return res == CURLE_OK;
>>  }
>>  #endif
> Wait a bit.  Did you mean "res != CURLE_OK"?  If we got an OK, we
> want to return 0 as success, because the value we return from here
> is returned by cmd_main() as-is to main() and to the outside world,
> no?
>
>


Good catch. I remember testing this out but I messed up somewhere along the line.

Nicolas
