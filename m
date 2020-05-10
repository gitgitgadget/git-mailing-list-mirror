Return-Path: <SRS0=RpNG=6Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5A1C54E49
	for <git@archiver.kernel.org>; Sun, 10 May 2020 09:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCDEB208E4
	for <git@archiver.kernel.org>; Sun, 10 May 2020 09:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgEJJ72 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 May 2020 05:59:28 -0400
Received: from mail-oln040092075074.outbound.protection.outlook.com ([40.92.75.74]:57897
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725839AbgEJJ70 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 May 2020 05:59:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idlnlA5bD3df31dq+e997ikm0k49AuVThtwn2aNqfqHXUuZff16oFhgXPxVqYJJRHDoQdVnUpp8kQSaSD1WgGzky1NklCFCl7QiKKu3WX8ZtJk6KUUQgn1uGkXLRxFLuC+4xZ0VkC/gFlN3CkqrqI3WIOt6/i54MVKdyfarnctTrirKkLq4bb17aTrU80AgE109Udb8RJv55lNe0qxkXxRRIqzAwqBqA5yWbhtIdVTRN4TiDOoLBzRWNFZQJeHMVQj69dYXCTo2xjr9ub88yBKv1okElG2dwoMWYqIYa6Sb9FdAn8xNz0J/qovTJ5YTmlTPeZW/PNOodtqxJdBDJEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APVUp9K5sxIIr6w9DzXURW433gq7/Yu7OwaqwOzrG3o=;
 b=WyUtpiRUIRsNK6ntq1qUFLTm6Xl/zYboSdD3H0+N2E+XR0gGYkxYpgua2ZTg2PIi8lxiIv5xLNGkJcA9qTmmzPVs5exsWxKe7ic4nO4sSvQGn50/wTxUBDbHGMvAeYvEEc1lxawWY46z+vJnSb3ftFPyLb8k22sP7kOVXUKng+xkVB4Euv1lsO1l0zJj2KWPm5vOrWmfVL8aWuVH8mEA6O0d3Lwm4yTh1FVz5+uouJilQG1W+QgrVhN2JJQei0zHIJGBmfEVofmY5QJntYmAAGh35EvjimHCNE3DQnyRD0v3ymBPMQDeyIs7szzTps9mdrnbWHcDe5Gi+vVYKomhWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.de; dmarc=pass action=none header.from=live.de; dkim=pass
 header.d=live.de; arc=none
Received: from VI1EUR04FT009.eop-eur04.prod.protection.outlook.com
 (2a01:111:e400:7e0e::52) by
 VI1EUR04HT006.eop-eur04.prod.protection.outlook.com (2a01:111:e400:7e0e::353)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27; Sun, 10 May
 2020 09:59:23 +0000
Received: from AM0PR04MB4771.eurprd04.prod.outlook.com
 (2a01:111:e400:7e0e::49) by VI1EUR04FT009.mail.protection.outlook.com
 (2a01:111:e400:7e0e::164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend
 Transport; Sun, 10 May 2020 09:59:23 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:10808AAA4F4730F0F9318AB65EB508CC91C8D4F022AC77D92409D9CDBC01B696;UpperCasedChecksum:4529EB720A5CC137F924870483570A6838CB569109B863789BC1883E5E02F821;SizeAsReceived:9184;Count:49
Received: from AM0PR04MB4771.eurprd04.prod.outlook.com
 ([fe80::58d1:c985:ce97:ee84]) by AM0PR04MB4771.eurprd04.prod.outlook.com
 ([fe80::58d1:c985:ce97:ee84%6]) with mapi id 15.20.2958.035; Sun, 10 May 2020
 09:59:23 +0000
To:     philipoakley@iee.email
Cc:     Johannes.Schindelin@gmx.de, abhishekkumar8222@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        hariom18599@gmail.com, heba.waly@gmail.com, jnareb@gmail.com,
        kaartic.sivaraam@gmail.com, peff@peff.net,
        shouryashukla.oo@gmail.com, stolee@gmail.com, sttaylor@google.com
References: <7f4e687b-fcec-4fad-34fe-a9e7d80735bd@iee.email>
Subject: Re: [ANNOUNCE] GSoC 2020 Students and Projects
From:   =?UTF-8?Q?Matthias_A=c3=9fhauer?= <mha1993@live.de>
Message-ID: <AM0PR04MB47710F0BED399BA85C5DEC89A5A00@AM0PR04MB4771.eurprd04.prod.outlook.com>
Date:   Sun, 10 May 2020 11:59:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <7f4e687b-fcec-4fad-34fe-a9e7d80735bd@iee.email>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0101CA0045.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::13) To AM0PR04MB4771.eurprd04.prod.outlook.com
 (2603:10a6:208:c4::28)
X-Microsoft-Original-Message-ID: <6f8b9e4c-9364-a739-ecb2-ebf47e9baea3@live.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:d3:bbe8:2e00:c986:e469:9bb7:fd94] (2003:d3:bbe8:2e00:c986:e469:9bb7:fd94) by AM4PR0101CA0045.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend Transport; Sun, 10 May 2020 09:59:21 +0000
X-Microsoft-Original-Message-ID: <6f8b9e4c-9364-a739-ecb2-ebf47e9baea3@live.de>
X-TMN:  [I/7WdtH0/FSp2XBqJg1WhhNM5wr2AZPqvXGfbvUZdpffNMgHV6dmQhaotHcFe2yW]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 49
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 840bddf6-f028-4ec7-fdf8-08d7f4c8d05d
X-MS-TrafficTypeDiagnostic: VI1EUR04HT006:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nb1Sbt7812XXrfQ0N4QVbzq47aawzELhjdG+86jC1WEP7qp+e+cGe9Yb3yhi1YjClZbQOWjhQGGtB5UaP30EYp/qbglA2JPwnuE16IoNZjsIQPJV1wCZrWdczZVS6PIBMHHg/yf7VbHG2Rjs4Qbj5CG3vjq2eoeArmaSskqIlQXmJFRAMmeE3BlG0Na3faAoDO/gBE09FTkRgcN4Ar+PrRwwJLeNH/WyWSmYcQ7B103/TK6Y4eqANhlw19bTF4XP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4771.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: gK0cKcKzuceajyMWw9Z18E2WRpQSxq45s1d9F60YXiY/CTmbcNqt5Ajij0tzZjcRhtWEGTsZ4Tua2fHen6kiQNw+idLudyNyqlKs6SZNnuD5cY5vw6UHIPCbnkh3wUvwdv/FVzlDSXuBGY3+GkhOYcbDVt3zvhTXeXRuxuANVsZvvsP26upXfy7bhzzfGRK613kIHenT2W+Tf4QCg86Hlg==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 840bddf6-f028-4ec7-fdf8-08d7f4c8d05d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2020 09:59:22.8888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1EUR04HT006
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These modified links should be accessible without any login. > - 
"Implement Generation Number v2" 
https://summerofcode.withgoogle.com/projects/#6140278689234944 
<https://summerofcode.withgoogle.com/dashboard/project/6140278689234944/overview/> 
 > from Abhishek > Kumar will be co-mentored by Jakub Narebski and 
Derrick Stolee. > > - "Unify ref-filter formats with other --pretty 
formats" https://summerofcode.withgoogle.com/projects/#4593212745842688 
<https://summerofcode.withgoogle.com/dashboard/project/4593212745842688/overview/> 
 > from Hariom Verma will be co-mentored by Heba Waly and Christian > 
Couder. > > - "Convert submodule to builtin" 
https://summerofcode.withgoogle.com/projects/#6451304047575040 
<https://summerofcode.withgoogle.com/dashboard/project/6451304047575040/overview/> 
 > from Shourya Shukla will be co-mentored by Kaartic Sivaraam and > 
Christian Couder.

