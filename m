Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7905C433EF
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 19:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbiGRTCD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 15:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235309AbiGRTBd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 15:01:33 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2113.outbound.protection.outlook.com [40.107.92.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E107C30543
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 12:01:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=matMNDJK6EWf3unjqAEKLS2rdLIFW3zAyfYCAOX4XWcK/wMMAB0gjYVA+HM7SRVMifX5UP1W+uWbVsRGhiQOetwUB0p3MxcHbWLnmO36uqkoC/pSbMhmkHI7AG44NBuNquNQX7QgFIT48gfH2XQHi8aHwOrO7U3lTz1l3E6BUUnWyLc21xDjeqlNMqN20LjLSZVo1KZanK5i1NL/d7AGfmmMZysb9zkpisFtuh0+vYfNJaaEHFItuoEFFqckJuGAfKwXLLW0Yv2kAWuEk7Q5w+Db1jgq1t4oAK45PeUhY66B2r+yKbZ3AUFok3rbiObUDnON5az4CEL/wLm3ZeoS2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/6He3ks+if9FIA5BEWh6C0MMwdSjjzkYLkaujUafgQ=;
 b=F4xJbs5LSvtUZq84+IY4iiIz2oF1qtJWZegQvH5Nfeb1vKBKiLXFVkKUfVY/PYQ34IpA09D/6LwLEi6omD01P4ozjgaVZv4vqEOzrm0ywmz6LcavIiubsRD0QQcueeKv6tf+WS7frHwNLV4KTpx2FWLJwAWK+LjqXJje1FXewNRr1HXraqy+GFVtLrvy4e77Hwg4UXnF/UpDuZAycSlWWJGVe3JszxfFO/ATl6y/gIS1kEVQyq7uq9XDaevsrTTb6i0SIzB386AZG/xGjo8IwyLGbtb2rEfLk+I1kbTSt8zKKeQdImrshwPwmv+qONXw6s2j7vj3oHRHUtRFw3LYow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/6He3ks+if9FIA5BEWh6C0MMwdSjjzkYLkaujUafgQ=;
 b=OX/qqP4iTVNXM0WtiL2+LgYDHFofrejZlWoxT7w1KheuwqOHus3gYRWLykZfWs1iDRosEucYwyRAKmDkZHvG0gdA9yuJw9wU3pDtmYn0WUm9dxy5u7xWhroa0T4qdjxAwabbU0DQBhGsoPl50x7AhRZmQaBfXCMMYH9C4CyxdlE=
Received: from LV2PR21MB3157.namprd21.prod.outlook.com (2603:10b6:408:175::15)
 by BL1PR21MB3304.namprd21.prod.outlook.com (2603:10b6:208:399::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.1; Mon, 18 Jul
 2022 19:01:23 +0000
Received: from LV2PR21MB3157.namprd21.prod.outlook.com
 ([fe80::94da:c0b6:fbd9:588d]) by LV2PR21MB3157.namprd21.prod.outlook.com
 ([fe80::94da:c0b6:fbd9:588d%5]) with mapi id 15.20.5482.000; Mon, 18 Jul 2022
 19:01:22 +0000
From:   "Neeraj Singh (WINDOWS-SFS)" <neerajsi@microsoft.com>
To:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Han Xin <chiyutianyi@gmail.com>
Subject: RE: [EXTERNAL] Re: [PATCH v3] trace2: only include "fsync" events if
 we git_fsync()
Thread-Topic: [EXTERNAL] Re: [PATCH v3] trace2: only include "fsync" events if
 we git_fsync()
Thread-Index: AQHYmsaLFY5uu/eItkavG/MgI2rS7K2Ee8iA
Date:   Mon, 18 Jul 2022 19:01:22 +0000
Message-ID: <LV2PR21MB3157899077CD86F1949024D1CC8C9@LV2PR21MB3157.namprd21.prod.outlook.com>
References: <patch-v2-1.1-a1fc37de947-20220630T084607Z-avarab@gmail.com>
        <patch-v3-1.1-979dea5956a-20220718T102747Z-avarab@gmail.com>
 <xmqq5yjus6u2.fsf@gitster.g>
In-Reply-To: <xmqq5yjus6u2.fsf@gitster.g>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=62bb1720-fcc1-4305-bdc3-57e5d7814966;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-07-18T19:00:37Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3acda2a-b7ca-4a09-717b-08da68efe83f
x-ms-traffictypediagnostic: BL1PR21MB3304:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uDSyaatzOFSpdCRPWUoIYK/f2K15+fcbo4dX2faqjv/3FPuvtZa4fnw3Ba11/KDq6RuySFA+wHZxLSGOX72MqzQuFmjeurz9CYB7sl/C83q+RPpJjuwFraiL38vYJ5CYlO0vtbblj+KwfBUYaSZN4DESx5QXajQXQhXSjq1I98al2VkYay69ZR1mKXT7gC4pRxdGkouvj3hcXsp+ZtFN+KhbzneIKQl0LZQeuWSo3k2osm+eTsuzvzewka6lS8eH8KWtLzjoS9uVWw+2ezCFbv1XluPlGPNVbSLQWo0Y64AI89bMK/qOTEq4rf9vomiYS1dxw3f4WBa1nTivuc8jBZw32QHMlWrEbcN+wpIjhJz0tdX7aaw3UT7tlBDyuhl9Jpr5URrTXL719qVTL05qFs312gWdTVIGb0/a5fRHwOm0k7xAcPzERmG6hxNisEtJ8lpaIZIcrjd7eR9OWreu+CT14dS0a40ZYNfbVEXFD6mlYfTq8+eFe83/9jK3W8rcAvSpAaJdABnqE6qJCtIwmF0egVZX6TwbFsu1ZjkIqLuS1tKCEvUW+IGdJ9jwtdLhsHJNbDvAyNG7FgPeexpN8dk5Jh6sS7goUNaKDfIXOXdHAIzvbeHubt/2wT5zlk94FNPqCEz2Dl+aTHvk57Yh47PH1AOsctJQij1AkS0TSnHkUo5vMrNbHSjxZ3WnFZ14tqUxIFp+A8iSIqKeAIQgd0R8ZA5YjHIUjaWW2b+lqF3x5i7JnEEeZ8x607S/srdYtk3dIjyIvKyDBZD8dlkUI9230JW94lxE6hjrTDaJsfVok7gN7mvZ196wx4cTUzikLQfHKGejXJj10JMeZ3F1wj2KV0V2RMKaaT3XZqCtQMA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR21MB3157.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(396003)(39860400002)(346002)(136003)(451199009)(478600001)(66556008)(64756008)(66446008)(8936002)(41300700001)(6506007)(4326008)(8676002)(33656002)(558084003)(76116006)(7696005)(52536014)(9686003)(82960400001)(8990500004)(38070700005)(82950400001)(122000001)(186003)(71200400001)(316002)(55016003)(54906003)(2906002)(110136005)(86362001)(38100700002)(66476007)(10290500003)(5660300002)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVlnTG0ydDYwNGN0UkwvdkdFZVhObVhBczV1dWpVWlI5T1NHUXIzNk9TYTdq?=
 =?utf-8?B?TE9PdmJIdTZ5eU1pTVNPZ0FtWXZGZTNsUlBCZ1NCbS9uTTA3RGtOS0pPOXB4?=
 =?utf-8?B?QVlXZ1I0NGRGQlhjYllaaVJ0aTdMUGgrd1Q2Nzc5bkM4VlNYdnJnbm9FcTNI?=
 =?utf-8?B?UE8wL1o1dFdpWmRVOVpmRXZYTmdYR2lzSVgrRzd0d1Ura2pqbTFSYjBXK01w?=
 =?utf-8?B?TGl2RHJEcUZMZTlrQ29UUkt6V3FaVXo5Tjg3bi9tazRwZDNzdzd2VVAycFFW?=
 =?utf-8?B?OU13ZFk5OGxOcmRHZFBJUTNobERLbk5LeTNicEllWjBCM1pBYjdHNHlocHUw?=
 =?utf-8?B?cmwzak9uRU5CamtBZjQvcFNGTXFBaUFmTVQ5ZDFRYkZxSjZLTW8rbTdjUWtH?=
 =?utf-8?B?S3NKRVBPcWhsMVM3dzhOOTBIVFNyNFpuL2JZNVZmYmg3UE1pb1R5T0VZMmZ2?=
 =?utf-8?B?ZUxLSW9zTkFEY3lKYVlicUI2ZEpPSDhSMWJZNDg1TFpJNk9sM1VmUVJLYjJZ?=
 =?utf-8?B?a0lsMWl3ZDEvbW5IcitLdm9BVi9QSGlnNE85RDBFZytiN2pUdmw4cmFOTVVx?=
 =?utf-8?B?bHlSenl1aXdoakRmSEpBNTg1RzY5c25yMW5GU081bjA2UkdJaUF2MnR2Y2cz?=
 =?utf-8?B?SHZNd1pjemNxSlVXZFR4OHJHVHIyL2xISTJNU3Z1ZnNQK2JydVh0RUIzdjZ4?=
 =?utf-8?B?eTd1Y2V3ckhPYlpvTWVIczY3Nm1hQmM2bUZZeEswT01TMDJySXRwQ3Y4Rzgv?=
 =?utf-8?B?QzBJMVlVWmVNWXdMaXZxa3I2VjRXZlNMRWxWQUVxS3pNaG1RdmRVZGIxclBZ?=
 =?utf-8?B?bzdpRng0ZWNJL1FLTnNSaUxiWXM3dC9nOHU2RU85WTZoeCtpLzBiaWNNWmFN?=
 =?utf-8?B?UHB5ZDY3RWpRNjkvenBWMXc0NlhndTc4SnN2d2o0SmQwbUEydXFnbmJHdU1B?=
 =?utf-8?B?WTk1RlN6MC9EQy9nRXJKMlRjTlpxS0RMVnBMRlJEYytiNXM0UXBET2hucC9a?=
 =?utf-8?B?UFA1TGZkV1hTY3M1YWFNV2F0dEVlWU9XMkN0OU15KzFJaUFSVnZzd3BlQlRU?=
 =?utf-8?B?RFY5bzhiU3VUc0JvNUxpaDVnMHY0SnRNZ095V043WGtpRFJSMjlxV05VL0kz?=
 =?utf-8?B?c3EzaGZtaW1qQmdRb2FzNnhmUkxRMGp1Sm1qb214eWMwdGpCY1ErMExBc2lC?=
 =?utf-8?B?TklKd24wc01xT3duVUN5bU1ZNkxEakhUcEd1L08rZm5CNWl3YjBXNG82MWNY?=
 =?utf-8?B?RkFmT0hMcUptKzhqT1VrYnhHSGk2cGFnK0ZSRFIrRng5UUhicW0vS2pGVUdM?=
 =?utf-8?B?UVVFcFREOW1qMml6Qm5wRDNwbjlsRExZVzh4bmlVSkdyV0hXY3pVR3ZKMTVK?=
 =?utf-8?B?SE92dHhMOW4xai9RSmtZUzNsaGJiZzltWks5S1ZrOGU3azhtVm9pV3V1Mm9v?=
 =?utf-8?B?cThsaVFhWUcwL3BYeFF4aC9LaldhS1VWS0FzSUUyOFptZml2M1pMUnpOOEk5?=
 =?utf-8?B?K3ZGdlg0Y2tiaUduS0MzbHRmSE9Ib0o0Q2FvZXlsM3RBaStJSzZFZ0hSWTAw?=
 =?utf-8?B?eWVIMksrdEVBcnBubDAvRW14QURIbEh4dzNDV1BDd0paRjNMbEZyLzhQMng1?=
 =?utf-8?B?eThCU1NZTjVQT29Qc1dsdGdERVFHQXdBbTk2aklUSDhUcmV4UllXdVIwSnk1?=
 =?utf-8?B?UFk2RkxIajd4b3hVWFVjb2hiSE1EQmVKb3IvbUxDV0dtOEZmMGJFcmhvMmt5?=
 =?utf-8?B?Rm1EdXpOWEhtM2xuczF4b2dleEZJSDJuRWR6TTJ4b1lKNC85bnlKallFL1dh?=
 =?utf-8?B?YmtXYnljK1JTTXduUW5NUVZGbG83VUNOeW56TENubW5Fc0JMVlZOUHhhdGs2?=
 =?utf-8?B?NTJvaDYwdHB3MFJ6ekE4ZHFvbnNSSXJqTi94ODYvb2gwaWEwUEZGM01mdlYy?=
 =?utf-8?B?ZTVZelhDaUNlODJzelpPNllZQm4zczZ6cHNnSE9LWUtXbHUySVNpWEUvUDcy?=
 =?utf-8?B?U3FXZFJ4QU1CRHB1eDVUWWtuRTFuK3h1Skd0YlR5dlY2SEJjSDFFSXZldGE4?=
 =?utf-8?B?Mk1ERk0wa05mZjExTGxVd0luWWNOWHhWaE1DZWJHMU05NDR0RjhqWlNEMWJy?=
 =?utf-8?B?V1pzYzBPemxVK2x3bUJyTll6YnJqMGdkR0JCL2JEUzN5ZmxtVlMvNVMwY0xh?=
 =?utf-8?B?Z2dXQkJEK0pXRktSQm1zNlViNFBzRXd6RDNLL2t6a1NHaWs0azZ5S1RlaDhH?=
 =?utf-8?B?Ry9scXNNeVRzYmRvRzRBcXNhaHV3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR21MB3157.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3acda2a-b7ca-4a09-717b-08da68efe83f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 19:01:22.8665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hUEpd3DjR6v1izgjujz/ZLXnbZwrRXw50H6WG0ehUbCui11FnNaybsMQz81Dw3h0mfYL+LadQGNAFablvCWTgC6P9ZrVD18Ut5eFnVxbDzs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3304
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

WWVzLCBBQ0suICBMb29rcyBmaW5lIHRvIG1lLiAgVGhpcyBpcyBzdGlsbCBlbm91Z2ggaW5mbyB0
byBkaWFnbm9zZSBpZiB0aGUgY29uZmlndXJhdGlvbiBpcyBiZWluZyBwYXJzZWQgcHJvcGVybHkg
YW5kIGlmIHdlJ3JlIGdvaW5nIGRvd24gdGhlIHJpZ2h0IGNvZGVwYXRocy4NCg0KVGhhbmtzLA0K
TmVlcmFqDQo=
