Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BEAC433DF
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 19:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 706822074D
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 19:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgHYTB7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 15:01:59 -0400
Received: from mail-oln040092072087.outbound.protection.outlook.com ([40.92.72.87]:11747
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726149AbgHYTB7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 15:01:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHYGdbHyynIvRcODcEShByAymwtjTg/Ow+hEA02Mg7bPYQPAXbTVCZPs4OlrK4m21lbEM0bk9SfkDfIHFijkocsCrZIZ6mGhVdRBENFaAWpFIf34Pp3bDfE1UyNn5QlFMkXK85HtkcpVhHtVSzE9ktVJfVJGKIybzqAe5YGrEbSrS1Zckrr0KQKQaZVBy65d330tfVUoo+6KeEM7XU3sMcZyXwzQPncY2Wbl9EDDYus+ZrlM2T82o5U3UndhoY5QRPLzU7mUjC97lCAfq3ftFrGrj3xzPDcyxaaxV039EQJiEbkbxsdCrcOgDpMXifmexn5OJ4DmfkE4gttcsbehOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvigHZiZV1cQEQw5zkS5odlLkVp4YOyZt4v5QDus/qE=;
 b=dA5wPozJV/SqxZVFRjQBe6Aku8FBLRboL9OrsWelqMNshE+/K1Ppn5b0eW+wL5lfTIBSNnQSedhVZYcVbEMr9EWS25X2Y501abW+90krTkftFFJWELPW1ac0t+LeCefmpyT2SWEyXlG74rzY+0A77fR3FzKUci4OVEFMV1dCcb1M+FQmwnbcKCOpkG8lFab51xZynef8iZGNeTeC8QRB5bpaEppGDyTXPw38dFVcs5m0B0PSlrpdfew5d5j8cZrPNbSvSvnPK4jusKhwAacbOEXs2uzjl3XN24BLzfEZ8BczrsxftVNsG37LKlHGptPXI3fLwohOQwM02KsPNz7Ucw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DB5EUR03FT053.eop-EUR03.prod.protection.outlook.com
 (2a01:111:e400:7e0a::51) by
 DB5EUR03HT111.eop-EUR03.prod.protection.outlook.com (2a01:111:e400:7e0a::264)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Tue, 25 Aug
 2020 19:01:56 +0000
Received: from AM0PR04MB4771.eurprd04.prod.outlook.com
 (2a01:111:e400:7e0a::4d) by DB5EUR03FT053.mail.protection.outlook.com
 (2a01:111:e400:7e0a::375) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Tue, 25 Aug 2020 19:01:56 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:70BCBD60243F0F72532F386DE2F120A97E3E89C6BB3D927BE805F744E2771090;UpperCasedChecksum:34C1818B38BAE9334546E4FDE857BAE851C491ABA8423D5339119E232B5E108F;SizeAsReceived:8849;Count:48
Received: from AM0PR04MB4771.eurprd04.prod.outlook.com
 ([fe80::e085:aa99:33d3:81a2]) by AM0PR04MB4771.eurprd04.prod.outlook.com
 ([fe80::e085:aa99:33d3:81a2%5]) with mapi id 15.20.3305.026; Tue, 25 Aug 2020
 19:01:56 +0000
To:     serg.partizan@gmail.com
Cc:     git@vger.kernel.org, Pratyush Yadav <me@yadavpratyush.com>
References: <20200824154835.160749-1-serg.partizan@gmail.com>
Subject: Re: [PATCH] git-gui: Basic dark mode support
From:   =?UTF-8?Q?Matthias_A=c3=9fhauer?= <mha1993@live.de>
Message-ID: <AM0PR04MB4771FE6F6A9284489A3D5660A5570@AM0PR04MB4771.eurprd04.prod.outlook.com>
Date:   Tue, 25 Aug 2020 21:01:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200824154835.160749-1-serg.partizan@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR03CA0071.eurprd03.prod.outlook.com
 (2603:10a6:207:5::29) To AM0PR04MB4771.eurprd04.prod.outlook.com
 (2603:10a6:208:c4::28)
X-Microsoft-Original-Message-ID: <090e236f-1848-f3a2-41a2-461b9877f36c@live.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:d3:bf15:6300:9c66:b85:2b4:b5bb] (2003:d3:bf15:6300:9c66:b85:2b4:b5bb) by AM3PR03CA0071.eurprd03.prod.outlook.com (2603:10a6:207:5::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Tue, 25 Aug 2020 19:01:55 +0000
X-Microsoft-Original-Message-ID: <090e236f-1848-f3a2-41a2-461b9877f36c@live.de>
X-TMN:  [3qrVLsxkBwe8qwurQVlCj5b6FPakZb4mnAPSsKfF4Uf0NiGoq3aEw8bzv+st5CR4]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 48
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: e5ba6d16-5a2c-4864-718c-08d84929561d
X-MS-TrafficTypeDiagnostic: DB5EUR03HT111:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5VSjKD6NCIdwkGpLV/zgofvDmikeCdpqcGTBP8MNzQGDfnLODfH/hM1/K09EZPy+572OdG3Lkno9FujGNErTg6kndPiYhAyx4OLIukomHLm7+QHUchkoSnhd0f1LddKhcpLyFVJJNZ2WKePWrpz6ICpKHqr7ZZ18QnGzX5cfQTl22FZB0ZH4w9gyUfzazUtyaV+HYh0c8MjecFmoFKJJZQ==
X-MS-Exchange-AntiSpam-MessageData: hkP4HcpKfugK334yGEGYmUzRFQcSe5LW0LLXetWnS120WLXYpxOvgqShyQoIvHSCj2NmYaXXZ0BU7Tb0p5+HhJ/0FGIcty7XlsV1Ou9Hx3NGRakganidlESV4MACFDEoZ7c1tSyl6iqBlpSDSFal9SShVyxJnyu7VUl6GpEjEwkqaBcmpYx4puZ3zqWbb4rgIelCwwUVi2eizfGgEF2EIg==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ba6d16-5a2c-4864-718c-08d84929561d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2020 19:01:56.4639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT053.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5EUR03HT111
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 >One problem that i can't yet fix: gray background for files 
inchangelists. Any advice on this?

If I understand the issue and the tcl/tk docs correctly, you can change 
that color using -highlightcolor on the ttext widget.

I've cc'ed in Pratyush, the current git-gui maintainer. He's probably 
best suited to review this patch.


Best regards


Matthias


