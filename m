Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541CEC433E1
	for <git@archiver.kernel.org>; Thu, 14 May 2020 16:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F30A2065F
	for <git@archiver.kernel.org>; Thu, 14 May 2020 16:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgENQ4U (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 May 2020 12:56:20 -0400
Received: from mail-oln040092073015.outbound.protection.outlook.com ([40.92.73.15]:6032
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726032AbgENQ4U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 May 2020 12:56:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OwlmW6dESDbQCkaADJrpYC3IUGKL2AuKuns2VOfdhESyy5KFOV3pa+o7HJGAfTx3hJFe72W4vgSPNINYr1DvyAgyyCx/UUBlMt5bWxRgDT3DjlTrpn0vwtpgyvSgQwuqFUbYEdunk3ZzEfpVwqrLN9KqEz7qYUWL3BLPRfD5EJ4Jw2kMVJUWWw4VMGoD8QIKWZ79c567OJd/vMyy4/BE2UtaW81ddL5mQrjgjzpd/esCdfriqAe8Jkx0Bd+nKuArYYWwgZOnNHmD0VZjXn2mK18snBjHOJoR28JmwsGYgIYENt6X9U9QffyeQAwYpVye7q68IiS8nvQKANevV5o7eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QuAJpDsxGV8hubho5tP+8YQZ0iYIXhEor8pJH3BaSU=;
 b=FmD8zKn1TSYtDRZTwlXhSYG77ZBKWWM7uhqCHtfJycZN0nvm5LqerZl1pqCUlTsXD9vOCWGEpJvOXUhkiFavFxVzdsVb0uWe4mVomS3OzMIarXmrJRvJz2X9uMOUZ3pMIosp1RJEMO70/grPKBY7EZ6aU/cNYCObJR7qAiZbonCmfv7ujaqweO3G0imwERlkfcjDd+cEaz2RiwbGlPwcNgPb5MvowrqajUI60BRBWhkGnJD8gr8Ag7KSGaQ2XH/hVsJFwcPy/QEqFQlCVfnq1tai45qU7WzPk09CqDDh4Iw/jjvmaTt8EAcE1+4TKgGNEf+Bm7zfq+ntGNT71hYDtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.de; dmarc=pass action=none header.from=live.de; dkim=pass
 header.d=live.de; arc=none
Received: from HE1EUR04FT006.eop-eur04.prod.protection.outlook.com
 (2a01:111:e400:7e0d::40) by
 HE1EUR04HT163.eop-eur04.prod.protection.outlook.com (2a01:111:e400:7e0d::87)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.19; Thu, 14 May
 2020 16:56:16 +0000
Received: from AM0PR04MB4771.eurprd04.prod.outlook.com
 (2a01:111:e400:7e0d::47) by HE1EUR04FT006.mail.protection.outlook.com
 (2a01:111:e400:7e0d::276) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.19 via Frontend
 Transport; Thu, 14 May 2020 16:56:16 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:A3036742B50753FEEBAF899582B33D249AD27DC383877A9A7232DCA634E9E7CD;UpperCasedChecksum:42EEDF527391A62F1D79023532E5F7F6A709CC893FA606256845A62E9548EC39;SizeAsReceived:8853;Count:49
Received: from AM0PR04MB4771.eurprd04.prod.outlook.com
 ([fe80::58d1:c985:ce97:ee84]) by AM0PR04MB4771.eurprd04.prod.outlook.com
 ([fe80::58d1:c985:ce97:ee84%6]) with mapi id 15.20.2958.035; Thu, 14 May 2020
 16:56:16 +0000
To:     someden@ya.ru
Cc:     git@vger.kernel.org
References: <D9813694-67FF-403B-8C7D-8DF013C96D98@ya.ru>
Subject: Re: Update git version for apt-get
From:   =?UTF-8?Q?Matthias_A=c3=9fhauer?= <mha1993@live.de>
Message-ID: <AM0PR04MB47716326F8E69F7AF6E39471A5BC0@AM0PR04MB4771.eurprd04.prod.outlook.com>
Date:   Thu, 14 May 2020 18:56:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <D9813694-67FF-403B-8C7D-8DF013C96D98@ya.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0120.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::25) To AM0PR04MB4771.eurprd04.prod.outlook.com
 (2603:10a6:208:c4::28)
X-Microsoft-Original-Message-ID: <31989f17-f7f4-db70-e28e-10e5dd84b661@live.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:d3:bbc7:c800:8970:ad8b:c399:ade7] (2003:d3:bbc7:c800:8970:ad8b:c399:ade7) by AM0PR01CA0120.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend Transport; Thu, 14 May 2020 16:56:15 +0000
X-Microsoft-Original-Message-ID: <31989f17-f7f4-db70-e28e-10e5dd84b661@live.de>
X-TMN:  [dAaN1mPh5lQpqW75jH3kIsGyBIltjb9cNe/aFRC57JJerjWPxsJd8NvVuyCaeZHj]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 49
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: c784f351-4076-40dd-8aa1-08d7f827b74e
X-MS-TrafficTypeDiagnostic: HE1EUR04HT163:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vGK7KyW6PrO62W/waJiMchJFWXl6BvqFIQQ4ZcJG6OxQ0WfRFyGpAZcd1TU6BaEKlb+eq+LpDLCk1ARfLPranipOVfUTleEYuf3ecq3/GyWPCfQRn7cEPfJ8HXsTSXeuGVRKvFi6pmXIeOsZXqan9fD21FL1i58O5StrvOmuyb5WLQGyfu6jQp9NbW4f1V2UiHrl+mnvFY+TMlCge2WbZxeA/CbZxbvvQuEp1uJOQKl/utQ+OfH6pfcDBjJ4wzc7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4771.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: 2WqDOwuvg9UzixNXjt3BZwdn5gz2H1soYlKHctrusuLo4dq45FyJMokN04Fy0y/UvPpZcpQr/b6TBiU69A3EnAm4ui8ntVmuY04J0cqrNzIndrbpbOyfO4HuTLsgsbU79NbZfx7zT2GxFAn54RiwzYHYL7qG0474q0Lh3T9gJkS54ikTD3CAIyZSkTgZSguaQV7BqmOBo8Ie9YgGqPyV8w==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c784f351-4076-40dd-8aa1-08d7f827b74e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 16:56:16.6161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1EUR04HT163
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It seems like you're on debian stretch. You should be able to update to 
2.20.1,

if you set your apt up to use strech-backports package sources.

For newer versions you'll probably need to upgrade to buster, though.

https://packages.debian.org/search?keywords=git

https://backports.debian.org/Instructions/


Best regards

Matthias

