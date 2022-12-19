Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B05AC4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 08:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbiLSICu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 03:02:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiLSICr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 03:02:47 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2134.outbound.protection.outlook.com [40.107.22.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFA92BD1
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 00:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpp.canon;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICZoi3j7T0lWoPYH+mfbbYBapdCWxRnqGp7s00ZSqvU=;
 b=VWlJzDSjeU6I6yli0gxUg5tz6Lxfz1ouIcE1NG/vdl2pPuyXMRmfsQF46/5vC3Yprra62u6ZHDanVdNy1phJzwPn7bA7nGWXV4CqTmIZmIqbLNR8wFMY7v2/eOozmirupF8kZi43Ml2HKWaaIgY2HAKoB9tAMwmLR2qV9oH8M/4=
Received: from DB6PR07CA0012.eurprd07.prod.outlook.com (2603:10a6:6:2d::22) by
 AS8P195MB2357.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:638::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.16; Mon, 19 Dec 2022 08:02:42 +0000
Received: from DB8EUR05FT030.eop-eur05.prod.protection.outlook.com
 (2603:10a6:6:2d:cafe::8) by DB6PR07CA0012.outlook.office365.com
 (2603:10a6:6:2d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.8 via Frontend
 Transport; Mon, 19 Dec 2022 08:02:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.138.15.34)
 smtp.mailfrom=cpp.canon; dkim=fail (signature did not verify)
 header.d=cpp.canon;dmarc=pass action=none header.from=cpp.canon;
Received-SPF: Pass (protection.outlook.com: domain of cpp.canon designates
 193.138.15.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.138.15.34; helo=smtp.cpp.canon; pr=C
Received: from smtp.cpp.canon (193.138.15.34) by
 DB8EUR05FT030.mail.protection.outlook.com (10.233.238.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.16 via Frontend Transport; Mon, 19 Dec 2022 08:02:42 +0000
Received: from oce-exmb04.oce.net (10.95.6.33) by smtp.cpp.canon
 (193.138.15.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Mon, 19 Dec
 2022 09:02:41 +0100
Received: from oce-exmb03.oce.net (10.95.6.32) by oce-exmb04.oce.net
 (10.95.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Mon, 19 Dec
 2022 09:02:41 +0100
Received: from oce-exet03.cppinter.net (193.138.15.33) by oce-exmb03.oce.net
 (10.95.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13 via Frontend
 Transport; Mon, 19 Dec 2022 09:02:41 +0100
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (104.47.12.50) by
 smtp.cpp.canon (193.138.15.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.13; Mon, 19 Dec
 2022 09:02:40 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NAM6HdQLyasSp5NtvkisEsxddlaSlBU2L2Z5N07nC0PZ4dLN7fWh7EAPQmxWV7iTf62dpWdc6hcW1yFzJ4AO2O0i/UjdoGQwwNmnU7kfE5i1duU68OktqOBSFwEo+MP8e0pFd3ISZF5jYptxpLBqkzXT8rqu+YcoaxG+TDjrne95h+y1swIWIcvox6wimMmYWsYIEat8LywhtIw+cppkeF4JmMLTixr5Hgs4wzq6Fw1t6/GEW1/HMEXGjWnVVytcz9oEh2RDIrlMhwdAtZtoPl/zhwGKawU/ul5r7MJJRc+bn3nXow7q7HIwuZjPsiLHjCIp9l8Ug0xxVc1vo1QyTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94C9UUMHddQHUKgUH18gUr3nACK4BXl+yH0cJH6j4R0=;
 b=NPdx+T+V5iRb34jNP6NfRK9wKLNtFqGts+2dhayeazPe+sdN0pH1x8mMrfcjAhwJWdZYUfoTlXuZ+9bolF+3+QXmlo3CmlxXdhtD6tegM/D97K28NCnhRBxVitUKu8O/kx+CdIw4WVoRF4gx8NnunyD2s+qmeoC2ti8oHIE64PlQ6njiT1wKbE7Ca7xlOfK33994GX4eRF2O/ASHimF5QgnycZX0TjpmFta+UekzBNAY5P0zMWFor2YxoOivHLpLsPKQIE+dppVbpIFbt3NpMLQL8HGYIKICm1jgq3n0PHFEKtuxws2GcmnLLh4MBqLNpYT8SlS2pacH9aXwaVQsnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpp.canon; dmarc=pass action=none header.from=cpp.canon;
 dkim=pass header.d=cpp.canon; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpp.canon;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94C9UUMHddQHUKgUH18gUr3nACK4BXl+yH0cJH6j4R0=;
 b=JTrEkrk/oMzb0/rLnGM4mWtttqIvg6x/97yTerGTUvQ32zreVTd2gzXgqVvgw45AJsAVphxj42V7pY9uZ4TFksfB+sr5Wxjk4hrJup+Sv/dct6oYDJEN0MsLi6ukGepef9XQ67aoVuren9+n/jKy133tvg1O8v+/Z0/oyojEyK8=
Received: from AM8P195MB0820.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:1e0::9)
 by DB9P195MB1633.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:37d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 08:02:39 +0000
Received: from AM8P195MB0820.EURP195.PROD.OUTLOOK.COM
 ([fe80::7cd8:8bb1:6d72:6219]) by AM8P195MB0820.EURP195.PROD.OUTLOOK.COM
 ([fe80::7cd8:8bb1:6d72:6219%4]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 08:02:39 +0000
From:   "Nemmaier, Christoph" <christoph.nemmaier@cpp.canon>
To:     "rsbecker@nexbridge.com" <rsbecker@nexbridge.com>,
        'Junio C Hamano' <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: AW: PROBLEM: "git pull -v" fails with exit code denoting a submodule
 syntax error
Thread-Topic: PROBLEM: "git pull -v" fails with exit code denoting a submodule
 syntax error
Thread-Index: AdkRKEgzislgucz/T6+rKojgCV9oPwAAgZyAAANTMA4AHu4mgABycSiQ
Date:   Mon, 19 Dec 2022 08:02:39 +0000
Message-ID: <AM8P195MB0820F8606B7B7A2B91442C4A80E59@AM8P195MB0820.EURP195.PROD.OUTLOOK.COM>
References: <AM8P195MB0820A54FEA04231D440F74D780E69@AM8P195MB0820.EURP195.PROD.OUTLOOK.COM>
        <000b01d9112a$541c4de0$fc54e9a0$@nexbridge.com>
 <xmqqcz8jmz4e.fsf@gitster.g> <006a01d911b3$57e0d1b0$07a27510$@nexbridge.com>
In-Reply-To: <006a01d911b3$57e0d1b0$07a27510$@nexbridge.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cpp.canon;
x-ms-traffictypediagnostic: AM8P195MB0820:EE_|DB9P195MB1633:EE_|DB8EUR05FT030:EE_|AS8P195MB2357:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b97ef70-6af0-4e29-5984-08dae19767dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Ny+HASaZK5cJTYjmWe6IQKaCwJNKGSWqnkL+BwnIgrqLijH902lOIl/KB/o4jOSSRlDyzdU1l2NeC2lnZWERuOipk8rjIB5Ov0fsP/V7ZMYWiNV7VpuywVpugTJNSusm1b98xR+r0TER0BK8So4Mc+02AWDjBkayS9wXCa/O6uhN0fJtrPQjWFLUrLUv98UFk7kVRHjc+AdE+7CfykZMPvV5S6QRHWPkapSUuoaCD/qyUB0fNVZ4K2KFdPztmUOeaSKzFfzxQ/0WWxKkxmjDrq63DDnnxaqHRYHxhKFatxRVuM3PcWgt8bIjBu5ZPM0ySA/1vN3COybqzpi7RF1ylpEVV7fO9CRHm2VEkVE6sWEC/GBbF0Ld63epk1jiipTsLGg/B7nn4ROVjT0UR1YF/6iJtEh+ghLMJp2MtxGn21LfxWSKHmwL0m0neTJGC1HRraaYRJWEeTNkVYZ2JjWM3Ab0aDTd5OI8DBBAjE4SLeZweQukO+c+sLqO/euwV6cFp1ZMhW+Lfnma2wdm7NMt2tyiaeAkZPrB9WDFKX2i4LcJDCn6CU9C6SOU7Jm0Pto035SY3xqS/NPEpLhMt7MWJQE2YSyIwm2veI50/X37g4bS+hkDlEcM+NbcsO+dhVS/FN6bY3sEMm51ZvkyZItrzjMRlgSe3a2Skdjk+TOsHIv2nnS476j6okBKXrQKwIutksK5GetKYSuDJfRs9DACgYrUBdTVZlh2TVlvILKqMCNyhA3DxNcVV0oPq9O0sNfdIJLScR4J7nXu7BesLjJpNjfYHSHXSt35LikILc7K03M=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8P195MB0820.EURP195.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(396003)(136003)(376002)(366004)(451199015)(52536014)(4326008)(8936002)(6506007)(55236004)(8676002)(5660300002)(66946007)(66556008)(64756008)(66476007)(76116006)(66446008)(41300700001)(2906002)(33656002)(110136005)(316002)(86362001)(4744005)(71200400001)(38100700002)(55016003)(478600001)(82960400001)(7696005)(9686003)(38070700005)(186003)(26005)(122000001)(83380400001)(46492015);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB1633
X-C2ProcessedOrg: a6a72299-2f6b-49c6-b092-048da1ac2e4b
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB8EUR05FT030.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6a171ef5-30b1-43d2-c7cc-08dae197664b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jd71wt8ULUbWMfPtBR3/f0GENE7RxotKQjw4LGkEnS1pmv58cv5+qyXlAsSowVkvEI7BzRj/JcQhuvq9Hnt228dZy5fJo2mhaHXaK70KTzdKHP/l919cJyeLu1zBRDFVwhQfeIEelr963moTwechckh3EgiT+e0q2kg0/N3KkNAvCGGfrF8gBEkA84+Q6uEachUskhcC7UmTxzjLVymZdOAVONs9yw++niD61yIBElQLaqClp3a3/Xu2K2wdMQgi982pEx0F0qpundgwTwzJePI45OUg5bEvD4ItUmiqoNJqitQIy3/kFki7mLeI9gThWF4DZxXCt2Qivuz2yXm7Df6vGWh1C2tE8gh4Kt75QQHGtpA5bgOFsifkL8S2wqLCFv8UpA2Ys86LbmY4N7Lqd6yR4U0zvmpvEzKPYdA9GsdAPHd1nPNI3cVlWRNtH3iscJMYz/PrXKWH+saqkULiECu+SqBs5+bvC9orEx6xuJFyEXQD63/ZD0xlhJkjyl7Z93S1u20aJvlFVhmVRqlSHzk6ZdK3NL5Ty7Psmr1ZDHmFhcdHknjvmARf1jQy+4k+JHRRG1z1k3IPdBCFRekIqaxNyXMrf41trv89o9B+W3U7VFIeIZgPamYdNJsWTzpVGN+gphC+hGx8ZssZbdcSaGQ2pN9PKHRQOI2nU4wgU/Bo8zp5XUwWTkH89nKL2fOWbHFlfFpGKHg9/rmUqd/l3lme/arXXbCHoGab9encN14RdwMwB1a4wiT3ltrQ3hKQ
X-Forefront-Antispam-Report: CIP:193.138.15.34;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.cpp.canon;PTR:oce-exet04.cppinter.net;CAT:NONE;SFS:(13230022)(39860400002)(346002)(396003)(136003)(376002)(451199015)(46966006)(36840700001)(40470700004)(6506007)(83380400001)(52536014)(36860700001)(47076005)(8936002)(356005)(5660300002)(478600001)(82310400005)(41300700001)(336012)(81166007)(7696005)(8676002)(70586007)(86362001)(70206006)(82960400001)(82740400003)(4326008)(2906002)(186003)(9686003)(40460700003)(26005)(15974865002)(33656002)(316002)(55016003)(40480700001)(110136005)(46492015);DIR:OUT;SFP:1102;
X-OriginatorOrg: cpp.canon
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2022 08:02:42.4058
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b97ef70-6af0-4e29-5984-08dae19767dc
X-MS-Exchange-CrossTenant-Id: 9c30c788-860c-43db-b7d7-e8337f2f0238
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9c30c788-860c-43db-b7d7-e8337f2f0238;Ip=[193.138.15.34];Helo=[smtp.cpp.canon]
X-MS-Exchange-CrossTenant-AuthSource: DB8EUR05FT030.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB2357
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> ...
>>
>>I suspect it is the same issue as the one that triggered
>>
>>
>https://lore.kernel.org/git/f805f2da-a7e1-9fde-cc0a-04a30f79c9af@cs-ware.d=
e/
>>
>>which came out recently?
>
>If that is the case, perhaps the -v needs to be documented in the online h=
elp if/when this condition is fixed.
>


Good morning,

it pretty sure is. The doc goes like:

> -v
>--verbose
>
>    Pass --verbose to git-fetch and git-merge.

Intentionally or not, git-submodule is not listed.

Anyway, I think the doc is correct, as git submodule doesn't know '-v'. So =
either the internal call should drop '-v', or 'submodule' should ignore it.

Ciao, THX,
Christoph


Canon Production Printing Germany GmbH & Co. KG
P.O. Box 1260, 85581 Poing=20
Siemensallee 2, 85586 Poing=20
Germany | www.cpp.canon
Canon Production Printing Germany GmbH & Co. KG.=20
The company is a limited partnership with its registered office in Poing=20
Trade Register HRA 100955 (Amtsgericht M?nchen) - WEEE-Reg. - No. DE 888 05=
 443

General Partner: Canon Production Printing Gesch?ftsf?hrungsgesellschaft mb=
H Registered Office: Poing
Trade Register HRB 206480 (Amtsgericht M?nchen)=20
Executive Officer: Johann Meyer
?=20

=0A=
This message and attachment(s) are intended solely for use by the addressee=
 and may contain information that is privileged, confidential or otherwise =
exempt from disclosure under applicable law. If you are not the intended re=
cipient or agent thereof responsible for delivering this message to the int=
ended recipient, you are hereby notified that any dissemination, distributi=
on or copying of this communication is strictly prohibited. If you have rec=
eived this communication in error, please notify the sender immediately by =
telephone or with a 'reply' message and delete the message and its attachme=
nt(s), if any, from your system(s). Thank you for your co-operation. =0A=
