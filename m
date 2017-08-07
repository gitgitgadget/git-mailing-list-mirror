Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 960482047F
	for <e@80x24.org>; Mon,  7 Aug 2017 17:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751541AbdHGRGK (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 13:06:10 -0400
Received: from 5.mo176.mail-out.ovh.net ([46.105.43.127]:41671 "EHLO
        5.mo176.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751426AbdHGRGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 13:06:09 -0400
X-Greylist: delayed 10921 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Aug 2017 13:06:09 EDT
Received: from ex2.mail.ovh.net (gw1.ex2.mail.ovh.net [164.132.80.186])
        by mo176.mail-out.ovh.net (Postfix) with ESMTPS id 4DE516B55F;
        Mon,  7 Aug 2017 19:06:08 +0200 (CEST)
Received: from [10.0.2.127] (86.200.136.234) by EX7.indiv2.local (172.16.2.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 7 Aug
 2017 19:06:07 +0200
Subject: Re: [PATCH 3/4] imap_send: setup_curl: use server_conf parameter
 instead of the global variable
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
CC:     Git Mailing List <git@vger.kernel.org>
References: <c74c8c386f2c2d8b6cebd4addf925d0121986067.1502114584.git.nicolas@morey-chaisemartin.com>
 <4a1f931c-9813-36a5-9c37-63b8abc4fecd@morey-chaisemartin.com>
 <CAN0heSqyiisjWyDBXLJcyx=Hh3NA562DoFqP8rpFyi_zuGKLEA@mail.gmail.com>
From:   Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Message-ID: <71817815-4e52-4623-b226-bbb57ca08047@morey-chaisemartin.com>
Date:   Mon, 7 Aug 2017 19:06:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:55.0) Gecko/20100101
 Thunderbird/55.0
MIME-Version: 1.0
In-Reply-To: <CAN0heSqyiisjWyDBXLJcyx=Hh3NA562DoFqP8rpFyi_zuGKLEA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: fr-xx-classique+reforme1990
X-Originating-IP: [86.200.136.234]
X-ClientProxiedBy: EX1.indiv2.local (172.16.2.1) To EX7.indiv2.local
 (172.16.2.7)
X-Ovh-Tracer-Id: 11385099861340121053
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelkedrkedugdduuddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 07/08/2017 à 18:34, Martin Ågren a écrit :
> On 7 August 2017 at 16:04, Nicolas Morey-Chaisemartin
> <nicolas@morey-chaisemartin.com> wrote:
>> Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
>> ---
>>  imap-send.c | 24 ++++++++++++------------
>>  1 file changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/imap-send.c b/imap-send.c
>> index 682a06551..90b8683ed 100644
>> --- a/imap-send.c
>> +++ b/imap-send.c
>> @@ -1415,37 +1415,37 @@ static CURL *setup_curl(struct imap_server_conf *srvc)
>>         if (!curl)
>>                 die("curl_easy_init failed");
>>
>> -       server_fill_credential(&server);
>> -       curl_easy_setopt(curl, CURLOPT_USERNAME, server.user);
>> -       curl_easy_setopt(curl, CURLOPT_PASSWORD, server.pass);
>> +       server_fill_credential(srvc);
>> +       curl_easy_setopt(curl, CURLOPT_USERNAME, srvc->user);
>> +       curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
> Here you change the server_fill_credential-call that you just added.
> Maybe do this patch earlier, perhaps even as patch 1?
>
> I'm snipping lots of s/server/srvc/-changes... There's a less noisy
> way of addressing the fact that srvc is unused: dropping it. I'm not
> saying that's a good idea, but it could be considered, then explained
> why this approach is better. There are some other functions which
> access "server" directly, and some which take (and use!) a "srvc".
> Maybe make the whole file consistent?
>
> Martin
That's why I applied it after #2. I was not sure if this one made sense or not. And it  can be dropped with the rest of the series still applying.
I don't know what is the right approach here. Someone with more knowledge of why there is a mix of global variable and local can maybe help ?

Nicolas
