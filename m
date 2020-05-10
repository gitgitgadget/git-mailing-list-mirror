Return-Path: <SRS0=RpNG=6Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F159DC54E49
	for <git@archiver.kernel.org>; Sun, 10 May 2020 10:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB00220A8B
	for <git@archiver.kernel.org>; Sun, 10 May 2020 10:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgEJKJu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 May 2020 06:09:50 -0400
Received: from mail-vi1eur05olkn2079.outbound.protection.outlook.com ([40.92.90.79]:24416
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725839AbgEJKJu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 May 2020 06:09:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWBs/aB6YQGrViyIVvZj7u5rJgqaz2r/gdGbT8Qgb6zt6+nsa02l3b65u0HDvoh0o0wQikGshb86U/dgKgi0Iw3+JbSKPzvyZse5GZiCNqFjC1ldj0aq5bK0By7rhnO6Kr6gcg55tSG+d+yyg8wn80yVULjvmUwCfAQGyzWzTcl5sGyDsVxuWVNHYqI1FJlfLfGj1zWgEZazFm7dNSbOgzzpM02FBENfd8Si9ua+zRdQ3AcYj3nyF9MgQ2xh9ziBrPw3BieI7wFtQGihke9qG67GUnK/+dzSlUmmXxExyth8fJ9mQB6VVg4yNFX1HCRH3cFAnGcBx462EqF2Lmhr4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SmlUo/BVf1Hvcv3BSF5zGNgfqY2i3H4fOoOp9kCKQQ=;
 b=hRgMGvmrDCqxP9+HsEAtMFrOAHNgbamQQcWMN35tAyZvUOM+Sp+rkPtlNAZTULxbk+qVcpDgwX5dWJ3LQ0eSLUTSuq01WS0Ff1dUPmc2+Ka/icWo9r1R37iPEpPcYVZh5NHz77VpTehgl8XpX23VPCoONFDTiBMei+AiN1WUUJvoO6SbKAjU3ThHP+WlxWKR9UJx+gBlWxjZnkQ7+PTuW0mlz3MLjXAfh8NzNS7VCyDCzdpM5YypJ9XuE3SLamOHZHVNaLKFP3cW7839Dnjqt3fXN3jfPEu7Yhv/rrLzFJeJQGTl5VZRkMg1F1TOrSjDx6K1RRw044ZTuuNrfQ0vYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.de; dmarc=pass action=none header.from=live.de; dkim=pass
 header.d=live.de; arc=none
Received: from VI1EUR05FT012.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc12::50) by
 VI1EUR05HT103.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc12::317)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27; Sun, 10 May
 2020 10:09:44 +0000
Received: from AM0PR04MB4771.eurprd04.prod.outlook.com
 (2a01:111:e400:fc12::42) by VI1EUR05FT012.mail.protection.outlook.com
 (2a01:111:e400:fc12::304) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend
 Transport; Sun, 10 May 2020 10:09:44 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:E7E4EB0E319C9217281348B9D882F63DAD272D575B417333FF7EDBA518C5CDEF;UpperCasedChecksum:E4B48939D1267A1593BF8ED95C2F96F2C246D5A77EE282D120ED967B0E3C0C47;SizeAsReceived:9236;Count:49
Received: from AM0PR04MB4771.eurprd04.prod.outlook.com
 ([fe80::58d1:c985:ce97:ee84]) by AM0PR04MB4771.eurprd04.prod.outlook.com
 ([fe80::58d1:c985:ce97:ee84%6]) with mapi id 15.20.2958.035; Sun, 10 May 2020
 10:09:44 +0000
To:     mha1993@live.de
Cc:     Johannes.Schindelin@gmx.de, abhishekkumar8222@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        hariom18599@gmail.com, heba.waly@gmail.com, jnareb@gmail.com,
        kaartic.sivaraam@gmail.com, peff@peff.net, philipoakley@iee.email,
        shouryashukla.oo@gmail.com, stolee@gmail.com, sttaylor@google.com
References: <AM0PR04MB47710F0BED399BA85C5DEC89A5A00@AM0PR04MB4771.eurprd04.prod.outlook.com>
Subject: Re: [ANNOUNCE] GSoC 2020 Students and Projects
From:   =?UTF-8?Q?Matthias_A=c3=9fhauer?= <mha1993@live.de>
Message-ID: <AM0PR04MB477183F214CD69F0A510BED9A5A00@AM0PR04MB4771.eurprd04.prod.outlook.com>
Date:   Sun, 10 May 2020 12:09:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <AM0PR04MB47710F0BED399BA85C5DEC89A5A00@AM0PR04MB4771.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0028.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::41) To AM0PR04MB4771.eurprd04.prod.outlook.com
 (2603:10a6:208:c4::28)
X-Microsoft-Original-Message-ID: <b6f0a90e-b53b-ea8f-3d7c-0c2f5a6e983e@live.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:d3:bbe8:2e00:c986:e469:9bb7:fd94] (2003:d3:bbe8:2e00:c986:e469:9bb7:fd94) by AM0PR02CA0028.eurprd02.prod.outlook.com (2603:10a6:208:3e::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.33 via Frontend Transport; Sun, 10 May 2020 10:09:43 +0000
X-Microsoft-Original-Message-ID: <b6f0a90e-b53b-ea8f-3d7c-0c2f5a6e983e@live.de>
X-TMN:  [+HvUdMK8wId/kB51d2m1VZ8EKDTqzbY0gDFLt4aIEz2iz1uJUajGGj6IQmknvQag]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 49
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 8d9f659d-6c27-4416-039f-08d7f4ca42de
X-MS-TrafficTypeDiagnostic: VI1EUR05HT103:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H5HddL+IbAJBPrzUjVNzYTbCl9XRW6FUKsbCFTd8jWM3pNgJ09aMMma/hkZ9pZEgTJXFbiOQr8ador18IXyYdnLE22JKShFEtzcWyPr7ufbOEY9+A7IDpfmddKS+eDwy/dSrkbV1HKXOow5KPvHoTRsjVaecUFTPgSB2I+LK4/i0DMSamElpyZIRr08qBDBT8BScc8PS+L+5FFxiA6jqzm9F9zpZahxsiiezqI75+f1k9u5Lj6WfZKGMdT1Euaxh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4771.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: AXBPm8ec1Yfk4Bg9JJK+IcYmoBsqSsYAjt7lGEUKOBaY0jwEzSATKpwGvzsBHsFOYhQFwdPEDCxLbDH4zC6tfOfmz2w1mprXSz9S3Scs6ceqI59iilGWNsUfaqbx/xAKBCYZzhIM/P+UyewqEpKDIXSi0AXeKJJfdVClvcaBWHs7j1rs+FjR3ceL5fhuPIZjeXGXSE/xAG6ExbJpB+Ak6A==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d9f659d-6c27-4416-039f-08d7f4ca42de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2020 10:09:44.1180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1EUR05HT103
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since my mail client mangled the previous mail badly I'm sending
it again with slight changes to hopefully prevent the mangling.

These modified links should be accessible without any login.

"Implement Generation Number v2" from Abhishek Kumar will be
co-mentored by Jakub Narebski and Derrick Stolee.

https://summerofcode.withgoogle.com/projects/#6140278689234944

"Unify ref-filter formats with other --pretty formats"
from Hariom Verma will be co-mentored by Heba Waly and
Christian Couder.

https://summerofcode.withgoogle.com/projects/#4593212745842688

"Convert submodule to builtin" from Shourya Shukla will be
co-mentored by Kaartic Sivaraam and Christian Couder.

https://summerofcode.withgoogle.com/projects/#6451304047575040

Best regards

Matthias

