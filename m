Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61454C433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 21:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbiADV70 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 16:59:26 -0500
Received: from mail-mw2nam10on2059.outbound.protection.outlook.com ([40.107.94.59]:35873
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232504AbiADV70 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 16:59:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7O7kNGXx+LdrO4OnZ+iXrA8RACYZOF6gSfBAeeAJo9mROUyzvSsTsges9b1TGZuJ9M7gWboRxaHR2b1Tq1U7/drlGVoNgXn3CaU+VT5sXBT8QnvZ9ws3KSN0dXunICHMw3b9Nx947sBuhdorbt4UGyZHr7Qjlev1WO2AhKZzqAhJwaDlOWHQsCHj15ubJGgP7alMqeOgPuzT8s/5/uLCJJtq4niPoCgrmAEn4bSYGfV1RptAN2gJllXnNVPFVl60yNFwi5FCL9jDpB+Ys4o6240pLOQJeVfEP6N8geF1leoLPNWGm39WRkUClhfaoHsaDlLvj6qEhWaB32NQk3wfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAElxkQ298HVYDv5zKJZKX/v4pMbHSXKSbEqCg+t8cQ=;
 b=IQVyZUoO1V25bhjtynQ8RLr2w27/i4h41AzQo7a0hIn20WkduaZppx68fJtqsT8B5YJRgw8+3z7U4ESp8vU7aNR4qeyHKwPyhJyiDO5ktjs5Rz+xkOKmBUtT3b1+ZqJiuGQ5Jr3K7uTful/NrrhvrnJJQxquV0m5M25865TeZwPCYLYgTLlTw0KtYgg6zXuXYdughYhMDGBDKUdGjp4nEvtAi7AQ8cXZBciKPwCUXh36jIokBMFWK2rOHW8QUAaRueUxFR4zbt+/rZ62dEfldJEnC5+2LFw5+ZGqWG9bT9B17/rMzxHbHPnzNWNxkseA+2Aep3MZgRTxlpdh0mVokA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAElxkQ298HVYDv5zKJZKX/v4pMbHSXKSbEqCg+t8cQ=;
 b=BxC0pmRDV+vW5gJykuWGf3qED+8Y2rvG1ZTQFvSs8rTVoqzPd//wMmZ/i2c9m1g6eYvr1xWkZ9ivPvkPEbo9jXmlSCDq5x3ho7zGqn9fvDsUN8yKzlmhA6QCvtJHQsvF0KCHnVi+5UytjfRQ0Pu8y9X/zY4YtxnYm8VqQi/lzj/65uX5KxVO6jhqUkB4EGDKWL164MXQvONgzhhHNKJ3SKDnsBCh49VRwz/zqKKPFNUylKi1eHSFPWcY1sjo4gGYG3XCsVLIpfg5LS4zXqUeqvrnq1Hl3UzMgTowF/iDfmXM675TfUsTwccxVJmDQHBtBSzxRYdzKrMItMt2Nrk87w==
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by MN2PR12MB4456.namprd12.prod.outlook.com (2603:10b6:208:266::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Tue, 4 Jan
 2022 21:59:25 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::516f:3a1f:4951:ebd6]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::516f:3a1f:4951:ebd6%5]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 21:59:24 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Luke Diamand <luke@diamand.org>,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Subject: RE: [PATCH v2 RESEND 0/5] git-p4: fix RCS keyword processing encoding
 errors
Thread-Topic: [PATCH v2 RESEND 0/5] git-p4: fix RCS keyword processing
 encoding errors
Thread-Index: AQHYAWmEyhWcLMf1TUK09flpbAVlNKxTZqNvgAACxEA=
Date:   Tue, 4 Jan 2022 21:59:24 +0000
Message-ID: <BL0PR12MB4849438B1245FC1FCEE7ED0CC84A9@BL0PR12MB4849.namprd12.prod.outlook.com>
References: <20220104124913.2894-1-jholdsworth@nvidia.com>
 <xmqqh7ajb2bi.fsf@gitster.g>
In-Reply-To: <xmqqh7ajb2bi.fsf@gitster.g>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec5db4a7-4497-4ced-f50c-08d9cfcd78ac
x-ms-traffictypediagnostic: MN2PR12MB4456:EE_
x-microsoft-antispam-prvs: <MN2PR12MB44569435E7C0D78FD919D056C84A9@MN2PR12MB4456.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mECTlgOR+bSe+8CRZLSw53gv1lDbCGtd6eielftqhhECxEMgNvfuCyjoIZ5q8oVuTVaT379wgWFNDeWkrlBlkq8uAZFuw1usP9R2EhE949LITXJULjiUYCJLTBKGo3h/fLjZZgfKHIssP3pQrTTC20BhUGKrSlJKVlfMF0JAuXW/dKzozWaEoSFRulOpoa66I+5h58Gfr+bKyPRQgT6KF1LCL9MtZHcY8WqES+VpoxxaP8EK+PTpaFMQVa/keqYDuOQMcV7w6iVP11Cg0oLZqE7nvSsQRHANYIP/QdwmPy92bAGUfINPq4jSttkewn8ws62ZBw3K64UPW1pQ84V8G4XSkVHY78Fxy2cjAxB5V472nXAyE+sIc75LKy6LhaqxviUV6xa7boALHsh1tIHs0hbav4K4/h9cGEuda9J7zDcfrhzKCa9ODauAHvTBq4gBHCoLEWd7lqwYkBXpakMqznHSPD4MJYmmSu1bCyKupg6Zz8CqK/cDVpG43TW2QfNVh5ld6u22gDINRacZ7gb+4esglxkYojCyhPkTGSGz0TytOm0UcVld/eqEAdr9OPI2MsWkohLHpGIzT2qKmpEXZejuq0R8kwkJVNB9oHpOIP8TkiXERc1WD/MP2PhopekId0/KwK1BGzgiESqpVm8vSZJe/KUTqGnLNfn4+77yislYkuYojaOk/8pMY4zApLWouBZrH3zm/zu92JoqWYezng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(186003)(4001150100001)(6506007)(7696005)(5660300002)(54906003)(66946007)(7416002)(2906002)(71200400001)(64756008)(66476007)(9686003)(26005)(558084003)(76116006)(508600001)(66556008)(52536014)(55016003)(38070700005)(8676002)(8936002)(6916009)(316002)(33656002)(66446008)(86362001)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HFgXRKtWEf7FXxREoIh4y5wNiC1Xf2XGH4gF1FMGESVkBhSDokbfGCsRbEDO?=
 =?us-ascii?Q?N9hGr/QGUKRlUXnfMR/TGFx/n2G+KXXH3QvKzGuGYe7kURS3qi06EioZusdt?=
 =?us-ascii?Q?UaEt1qRAAC6GuVKXZCUCscy1zQyn7eahk1SSa3cq2+EptLv7Hj43TUu6bX3X?=
 =?us-ascii?Q?zYdGzWVuOrusuiLxlyKur/AR5cnE6GQkcStj7hKEfJxA1YAwGTsMg+YHYLFk?=
 =?us-ascii?Q?ovdA7e0HCbFJ60QYNNXO9D5mELfknZR6Zh5kHEFADckZXbVEg4E66nY7M5L/?=
 =?us-ascii?Q?fJRhCsVfi92BVAw3M6lMHbppOYKC2XB1KhUp9e9q3o1Ky4Pc+ZZ6m61VN7C9?=
 =?us-ascii?Q?hL7dQgUWWuu20gcH3Ws3sBEoRusEzNSj/8qsMiocUCuVimK92lB8O6k4+/PX?=
 =?us-ascii?Q?Aw4rjgpyjP8PnIc9kZgEyes9B4GLlCG1iqZH7hODfzbEqAUO6fu9gzRIcmJ5?=
 =?us-ascii?Q?KM/8gVWI0+0WR63nGbcM/nC0o4Zmkk+IWuU2fll7zAe9yLeF8lijDzv/J9UW?=
 =?us-ascii?Q?y3y+OWFUvyv3lyOF5DmfZLu3tGQ3CsVG/334dmIKzpotowIJDSUWKYhwJ/1V?=
 =?us-ascii?Q?7St+JCW6mv4kyxDw89tmoTSnhmjGlWxwcd58SJmdNLXOYYxGDUNz7ghvIZL0?=
 =?us-ascii?Q?wsrfsLLEuVpBGBaT6qDpwOUmGmClLI1sdFEWQGalWrnB7BeAofS5YRD62fd3?=
 =?us-ascii?Q?hXOrBbgzErGbOQVOGZ1Uy7MfF68i0T9WV0Cev+f4uA8lEsN9uaxGjxSNCcje?=
 =?us-ascii?Q?q6QyJ1hAuk3HcWfqHy4PZKelpmo42j38MfDjep2PZ/2SMhaA4oyycOoEP52t?=
 =?us-ascii?Q?CmsM5Uln+rT8ABDYA6yKutJkEPEMViWIES+kQcs/H0h149oC3kCRsr9EY8YU?=
 =?us-ascii?Q?KwXbm0oYF3x64oI2XePrMLGssFQcrN7kItFGM/M4dPvhPRT87OXKFtT/Kbkj?=
 =?us-ascii?Q?A+Xx7p8aG7cz+HQpoYsLnwUhyq2AmIrQnsHUH/NvwytyH3oCt7cVkEsExb48?=
 =?us-ascii?Q?9Q9KFPX3Q7b6O459jAPyraEPYhnSpOwnUc9jCximWhgR8fDHGan+y+gKKdV6?=
 =?us-ascii?Q?dtzp5N0s8ufP74SG1Pq+M3pkBDdq+BWCuVSFbM/9fdXHgDLd5erP94JP/BkB?=
 =?us-ascii?Q?vIajIi9Czku9Xl7iXggpGOA1zV2w6tUjNDsdnV9pwUenM9r6MkOojpiCr8pE?=
 =?us-ascii?Q?OrCQ1ZBhBTVJR1DiGr5eeI5Ox2T9Ma+O9zrr0fBS5haKGXKoS5iChqb5HYcu?=
 =?us-ascii?Q?C8S/BD95+aPJ+ggXz6DBwrqPgLNQpfXLYS8TbiSHsG0aDL/CjE8Vtpri7vpU?=
 =?us-ascii?Q?2j0bba6xkvZsq8zoeuVEwbW8QPBQWqLxN8NNDEWKe992BBLJnYJlwdtxpfEW?=
 =?us-ascii?Q?uOg/g8K0R6WuNjewbSw5D/HrigpN1z5AQP86Ui4WeienEMOR4ue+MMeU6okX?=
 =?us-ascii?Q?qSXBwS1XKWLmYqFOX5TPLsr2S8SFktFtlaTT89XDMlztw+lehmrhW3msKU8v?=
 =?us-ascii?Q?v2cNB6M0HdB5YKDNVFpK3F75SQumSrBzbDoxwoH2vU8cJ0+1TAw2Hea3F/oq?=
 =?us-ascii?Q?kwWU10N1ozcWX0Hlwmi1exFyiOSZqXGr5uG7/pYPgX6Xwtcs4T3C0JcPEZJd?=
 =?us-ascii?Q?aw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec5db4a7-4497-4ced-f50c-08d9cfcd78ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2022 21:59:24.8857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uJ9IvQ14DaJt/movIuvAc85/EHvepEOxs7SdSl2+t3Gun7RoPRBG1EfMgacYmvcBw2/UDZVzIPaRBsvsdvSomg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4456
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I do not see any difference between this version and what has been merged
> to 'next' at 650cb248 (2021-12-27).  Sent a wrong version?

Ah ok. I didn't realise that's how things are done around here. If the patc=
hes are accepted then this patch-set is unchanged and can be ignored.

Joel
