Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DDCD20966
	for <e@80x24.org>; Wed,  5 Apr 2017 16:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932172AbdDEQFM convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 5 Apr 2017 12:05:12 -0400
Received: from smtppost.atos.net ([193.56.114.166]:19695 "EHLO
        smtppost.atos.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932102AbdDEQDs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 12:03:48 -0400
X-Greylist: delayed 308 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Apr 2017 12:03:47 EDT
Received: from mail1-ext.my-it-solutions.net (mail1-ext.my-it-solutions.net) by smarthost2.atos.net with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-SHA)
         id 7ec2_9c35_6410c512_a49a_4e5f_aaae_e1a6520f1bc6;
        Wed, 05 Apr 2017 17:58:28 +0200
Received: from mail2-int.my-it-solutions.net ([10.92.32.13])
        by mail1-ext.my-it-solutions.net (8.15.2/8.15.2) with ESMTPS id v35FwSvD019263
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Apr 2017 17:58:29 +0200
Received: from DEERLM99ETTMSX.ww931.my-it-solutions.net ([10.86.142.105])
        by mail2-int.my-it-solutions.net (8.15.2/8.15.2) with ESMTPS id v35FwSMK029953
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Wed, 5 Apr 2017 17:58:28 +0200
Received: from DEFTHW99EX6MSX.ww931.my-it-solutions.net ([169.254.13.6]) by
 DEERLM99ETTMSX.ww931.my-it-solutions.net ([10.86.142.105]) with mapi id
 14.03.0339.000; Wed, 5 Apr 2017 17:58:28 +0200
From:   "Franke, Knut" <knut.franke@atos.net>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
CC:     "Tom G. Christensen" <tgc@jupiterrise.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 4/7] Handle missing HTTP_CONNECTCODE in curl < 7.10.7
Thread-Topic: [PATCH 4/7] Handle missing HTTP_CONNECTCODE in curl < 7.10.7
Thread-Index: AQHSrhO7yFRpjwMLGESm9Qm1dLEIGqG2zT6A
Date:   Wed, 5 Apr 2017 15:58:27 +0000
Message-ID: <20170405155827.GE6493@science-computing.de>
References: <CACBZZX450tRRsy-Sj8igZthYov7UxFMRJ51M-b1cgYBLo782jQ@mail.gmail.com>
 <20170405130424.13803-1-tgc@jupiterrise.com>
 <20170405130424.13803-5-tgc@jupiterrise.com>
 <CACBZZX4OVy0QOnPLYNY0pptvno+OJ-c6=sRtVWcT+40aaEGY2w@mail.gmail.com>
In-Reply-To: <CACBZZX4OVy0QOnPLYNY0pptvno+OJ-c6=sRtVWcT+40aaEGY2w@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.86.142.15]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <C9CE85EE5936944081A2DB5D4EB0C94C@mail.sis.atos.net>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-04-05 15:50, Ævar Arnfjörð Bjarmason wrote:
> This effectively disables that code & this later check:
> 
> +               if (results->http_connectcode == 407)
> +                       credential_reject(&proxy_auth);
> 
> What's the impact of not taking that branch when the proxy returns a 407?

We might be storing incorrect proxy credentials via the credential helper. If we can't get the
proxy's connect code, we should probably invalidate proxy credentials whenever http_code indicates
failure, since that's the only effect we'll see of a mistyped proxy password.
