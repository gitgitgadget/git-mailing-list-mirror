Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B43AC4707E
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 13:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbiDENKT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 09:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237266AbiDENAo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 09:00:44 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A32617E1E
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 05:04:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQKrLeXyAUIBWS0EJuvWHNhE1xDgtih5slgO57DD5zLhVLcIAWGcHYRz3XpBL4OJpaR/NtUHtgywgNqpCehdW/bSXSPCR2gQpQ76Ue0EwodKZvOLOCakLVBjjb3WIBHpl2XNb8dEBSfVzyO6SJbnSE8EBZGUOVmlH1Fi5Fn8vRSmxpOWC1+lc53A2KbR6OpT1ygqk/RzVu9E800L+bPtoDsVksASCMSaemzX99NDVlnNhAorK/ufQr4xtSxmr7kM66ndCyv7t3ntZYO4h8WwZnYh/Rs53DleQZQHIoKxaBke+tqc6vlwVzihT0bEK44uzWgpCjceOujHI0Gkea7GOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0H91j+1TBCP8BnZCt2q6c5wlcudYTtRtO3NTwZ/Yc0s=;
 b=auMll3gdRT2c8/MJ8OGwSXqAV9huiwmSqbbSsuizoFcZp9IGj1IEiw9qBkar8o45JR097ZPXowa0w/odd4rewMSRpax9UkTc/ELatqe1lqIZctwmp8Hk2aY8AMqUHDFl6vxHPIgP04hDG5thIWXAAXtxM7chg6Oswk82kJ7+zTyrcCxK3IDBVBE3/HSgKb560rPNqYiK72WYSeF3FpWTS6017Nndnh2u+uNgTN8EN2FHm5f7wnPzUXY8MZoZ3ow7fHSKlOS17lk7oATaf2trYUx1VmGGWl1sZkzIWfb+eOhAxdEsW4k/1njOI6TgokqDyEvOakuTLEdRyuVZZntQDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0H91j+1TBCP8BnZCt2q6c5wlcudYTtRtO3NTwZ/Yc0s=;
 b=XWkGA/1IgspsugL982MHQDh0gnyJaCkIASpUh4m3Zg0P7vATUdfY5/QAcgUD2ZgRWwf9PP/Sv7kGz/IfqnhwXv7DZFJtj/KwMEdZmt6p18TW4jLJjcpYnfv8HuXlcFmE1BWr4fndo4/hxhhDLEhNpgjq9gL9TZcKuK1AuU6I2zuZGhtGNSjltgTxblhvqVO5A5bw5M+oQ5nBNk+ddcgT8XN+2kg0pR+A4EqHCPkhqwu+fu4Vxva1OU3rlFh1n7d9VybVufKzSgWhiByYMURNfkcarwIdk8yjuO9TGJRbWOPDQu4zwkUvl9dax/y2qNiToesvHxEX8IBVLJa6CtHNBg==
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by BN6PR1201MB0210.namprd12.prod.outlook.com (2603:10b6:405:59::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 12:04:32 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::94d:8b2b:ad19:a2d3]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::94d:8b2b:ad19:a2d3%5]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 12:04:32 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     Tao Klerks <tao@klerks.biz>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Subject: RE: [PATCH v4 00/22] git-p4: Various code tidy-ups
Thread-Topic: [PATCH v4 00/22] git-p4: Various code tidy-ups
Thread-Index: AQHYHp3NpnMnyJaeRU6TK2LFtcePFqzc2RwAgANLYLCAAOlKAIAAdemAgAAGvlA=
Date:   Tue, 5 Apr 2022 12:04:32 +0000
Message-ID: <BL0PR12MB4849BAE614E63BBB0B77EC29C8E49@BL0PR12MB4849.namprd12.prod.outlook.com>
References: <20220210164627.279520-1-jholdsworth@nvidia.com>
 <CAPMMpohZxpMFc-rVE96QbeGzN6NdF5CdYVp6FLrHD6Ngi=mu4A@mail.gmail.com>
 <BL0PR12MB484938E9950EBCA08315544CC8E59@BL0PR12MB4849.namprd12.prod.outlook.com>
 <CAPMMpoggSvPox5tM3B_NZ0GwLzg7LtHkXGhby1mZqpkehZ1G0Q@mail.gmail.com>
 <CAPMMpohm74nVbi-dR=YOLoT+CbPiHGuVo35EoufKGKHP9Urexg@mail.gmail.com>
In-Reply-To: <CAPMMpohm74nVbi-dR=YOLoT+CbPiHGuVo35EoufKGKHP9Urexg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5edc70ea-17aa-4eed-421c-08da16fc71f7
x-ms-traffictypediagnostic: BN6PR1201MB0210:EE_
x-microsoft-antispam-prvs: <BN6PR1201MB02101B8ECF0E2C99726C29D7C8E49@BN6PR1201MB0210.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qoCpxoT/QmJunkm62qVAjua/dpfa3FqwKbRFsckHFSCt2ikA14ocEuLQsdZDSDwmPyCx4bBQ2YkF3GRXQUH3ypChMdY7FGBoZQvosR1/nhOhzeMEfRjaV4sNQJ7I338u0OTz/28r/AMWP4tqZcz9OodNRYFm1MFoQVVnxyKnqX8eh37gFzcTSrfDbLO5m3L4xRnOU9I7Gkx5W1npZDtVE0WOZwEQFMqKzyd8JHDuIBxwCTscb6pIf3Gqx2V0StYBmy8N92qr9VSjg3HQ2B0dObV6iFYWc9EBRZTkIaHAt/esuGFSmnuFw3h0tPAG0XZ7RuCzYHw6MJ4F9ZKSMGFPTQBjJ9GjEmkb3EOpbwkCuIbkT1ArzTpoSs98PwqbukAyVAba0bdKoITNIJPdoetbimz9EuMTocb9AIxFObnqSGl3T96pvYbMHZVjFiflGii0rLK8fR9wXf4hmhm1CUiaMAvW/KDWAcujRBm1xp23fO2dv2MjkrLRrKGCTnNt9c22qntizcuhfYMLeu7BXck+itkfBBLYym/a2a63O98tyJ2KCqeKnoU+Skn8SpeoS/N707RqPxAqLAQjZMAlRH8PyzwxjT63yfxasukeH27SnqehVBgTpQRrS1H2FBL1gztwKM6mkrkJqkDYLelHN3IsnNqzi71qAezyDnL31/sHuyrI2NfqqMI+3v+YlrwB5hnNrBebXEW1DTgltrlW//Q/WA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(52536014)(4326008)(54906003)(66476007)(6916009)(66556008)(66946007)(8676002)(55016003)(76116006)(5660300002)(66446008)(64756008)(2906002)(7416002)(316002)(38070700005)(83380400001)(86362001)(6506007)(7696005)(33656002)(508600001)(71200400001)(38100700002)(122000001)(9686003)(55236004)(26005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1BmYzd5R3FaVDVRbE5yK1FxOTlmK2ZISVdvczZLNFFBaHp4ejdmSzIzK2I3?=
 =?utf-8?B?aFcrNlpBZ2FOZ2VZSTVDVGliZWlLSEZEeThlOGZkMm10YllaSGZhZzRqVmdT?=
 =?utf-8?B?TkN5bEY5aW1rL1dmeFg3blAyRUlaSjZZQVRmUTNQZ1ZMNW9vdFhwNlFjMUh2?=
 =?utf-8?B?M3ZrdzhMenNNVXFIVEV6OVljTFR1d3VUMER0QlEreHlQOUQzbUswQm5pWkhG?=
 =?utf-8?B?K3FVZFRzQm43WmhDRXFwZlVTdGJ4aE96SUdwVWgwMGFjTHhiTi85Mm9uYTY3?=
 =?utf-8?B?cnJRSlJ5YUNzNmlBNTBsa3NqVktQZFZsS25MUWJDQ1VlSHhIOUVpMHpwSXAy?=
 =?utf-8?B?OVdySUlEL2xpZFVzR3FScEpNV29udElYcVdTVlhHL09ycU1Fd29yS2JWa0ZQ?=
 =?utf-8?B?QTgrYUdzSXlWbUI2ZDNjN04zSjlUZ1Z1QVY2LzF6aDdkYjBZUmpXVmRvRkxj?=
 =?utf-8?B?YlJLbVpmN1FiVFpIRUE1VHpDWTVpdDBzdTJSSVczemF1d0llRmYzOGx5YUV6?=
 =?utf-8?B?Qm5oRHhSMERkZnh4dG01ajNKTHdhb3pvWUR3ZkFFeXpldU83bnI4SVliMXY5?=
 =?utf-8?B?T0VUN1FzWW5kQVhpZ1NzanluZDhPOFBrT2o4cVNBMktNZHd4S0pxeDZ6Rmxn?=
 =?utf-8?B?ZVdGN3lHY0Noai8zMGJSRlpvR3p2ZDZEYndUVHdLbWZhbGhGT1k2aGJUczNI?=
 =?utf-8?B?N21nVzkxODFwMFhSYzlQbGk3Y014dlJiZ09YYUVDTVZQNStiWUVIVE1hU016?=
 =?utf-8?B?UytDZ29WNlNYaWNrb2NEQzJ2ekFQV0FHUUdvd0JVRUdhbFVsVVBHSUF1WndC?=
 =?utf-8?B?RElsZWVaZmVYSzRHekVUaGdWRzBSb0s2N1czYmFNV1k5cUVZSW8vNGJjNUNP?=
 =?utf-8?B?c2JjdDUvb3hjai9CV2VCVFZuV3loODNaa1VCaWx0alBkVy9jUWU3SmZ5d016?=
 =?utf-8?B?V1p6QTl3czhxcU4xYittSEdZN2p5UHlHWDkydDQ1cEZ0RDdjWnpkMnB1WGhM?=
 =?utf-8?B?U2tZZXBEQWFVOWJVV3YxV0JwTThDWGZtZTc3SzV0bkg5YkF0RC9KYWF4akFM?=
 =?utf-8?B?d0VuTE5xU0NDME9kVzVQZHlqZ1l2RmFpSU91MHZsR1FJNjhMeXExemtsalVx?=
 =?utf-8?B?UlJNc1ViTFpYRmdOUXU3UjJWUVQ0ejY4QXhOOE0ra0JUNkJUUmxVaitkY0tW?=
 =?utf-8?B?YmZndmtxTTM2ZmVMOGNqb0oxTVBVYnpsVFlZR0gyQ1VGSThHcEkxR3RrQUtH?=
 =?utf-8?B?aE42Zm1HNmFNL2Z5RWwwL3BLcnJwcCt3Vzg1UTM1cWFxTk50MjI0cVZiMlUx?=
 =?utf-8?B?YzZ4dFJrTXg3WnZmK0VoRGc0K0xpWlhrNW9DK2RIQ1JGRmxIUTZvRzJ2dXhE?=
 =?utf-8?B?NWR2bzkvUmcrbkNxUmF1RUN1TVpOVlQ4RGtSbmtuZm92K3h3Wi8xKzJVM2Zk?=
 =?utf-8?B?U2RzTm5scmlYZlFzSTJsN3ZpWnl6OEdLcCtCMjFXQzVucEx5SElyY240dmlN?=
 =?utf-8?B?dVM4RXgzRTZvKy9oekhoY3JyS1NEaU1ma0xSem11RE9GczVzTW0xZ0lXOHlh?=
 =?utf-8?B?UHZoOWxCSXNWSlhhSjJSRC9uV0l3TGxRcklMeURIL1dEcTIrK2VDYTFuK0hF?=
 =?utf-8?B?OWhzSHhCb0xxV0FHN0NnNlhySE5EMTZGWnZWTmdzcmJlYUc4Q25NbjhBdTdN?=
 =?utf-8?B?Zk9kVCtXdGFxL1RwVXdDQ20yRG9tQzZOSWR0SUFoLzllRTJzZE55QWQwMGRT?=
 =?utf-8?B?MkM5TkpzbktnZEFtZE8rNnZMN016MnByNXVoL2paMFYzR2xzRGRIWmIrMXpU?=
 =?utf-8?B?VENjZ1dyWVNKQ2lHT0I1dUkrMTA4eWY5VmR4YUZKTndnaDZlREZQdUNhUDRU?=
 =?utf-8?B?eTBza2hqOVBlUXJPSWVkZTFOS1dPU2tlM0NBQ3paZWkraHBzYytiSDZrOVdq?=
 =?utf-8?B?SEhhNk9ZUzl4VDZGQ05ucVJCQmU1YVY5dFE3K3RKVi9odWNSa1JDdkxUQVh0?=
 =?utf-8?B?MFg1MnRHQ0FsdldZVk5LOUMzTEwwMTNnQWlaS000Uk1xTHBoaUU5RnRRWVZK?=
 =?utf-8?B?SVpYZ3l3ZU42bTZEd2x3bERkbU9oVk04R1Fjamc2UlQrcno5czFZalVtckhW?=
 =?utf-8?B?RlBmUWFXc2VpS0wxTzBKeFZrTGxOckNnQk8raStZd0tnUXBwZTZGdzJNak9n?=
 =?utf-8?B?anhBWkVaS05lTEdSenJ0YmlPOUh1ZzNUYXRiWlhsWkVvTTdNcm93KzhQNFBk?=
 =?utf-8?B?ck90aUh1K2JRbmphZlpUZDhUaEFjaDljczZuVFh3djNsSmJtN1ZFVE5QVzE1?=
 =?utf-8?B?L0ZUQWhGRDR6dVN5YmNRZmh6V0lMWHRXcW9aYTM3UTFqeW5xbFpudz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5edc70ea-17aa-4eed-421c-08da16fc71f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2022 12:04:32.1103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hm1xRLOY8V7kvOY7FFgSoeOpH2N2afd2ZEn7PZLK9JtfHg2fy8dSdtlFSv9wM/i9lltaszNhzuBYGcoymhjqYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0210
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiBTbywgYW4gaW5pdGlhbCB0ZXN0IHN1Z2dlc3RzIHRoYXQgYSByZWNlbnQgdmVyc2lvbiBvZiBn
aXQtcDQgYXQgbGVhc3QgZG9lc24ndCBmYWlsIGluDQo+IHRoZSBzYW1lIHdheSB1bmRlciBweXRo
b24zLCBpbiB0aGUgZmFjZSBvZiBhdCBsZWFzdCBzb21lIG9mIHRoZXNlIGVuY29kaW5nDQo+IGlz
c3Vlcy4gSSBkb24ndCBrbm93IHlldCB3aGV0aGVyIGZhaWx1cmVzIHdpbGwgb2NjdXIgaW4gb3Ro
ZXIgcGxhY2VzLCBub3INCj4gd2hldGhlciB0aGUgbm90LWZhaWxpbmcgYmVoYXZpb3IgaXMgYmV0
dGVyLCB3b3JzZSBvciB0aGUgc2FtZSBhcyBJIGhhZCB1bmRlcg0KPiBweXRob24yLCBidXQgaXQg
c2VlbXMgcGxhdXNpYmxlIHRoYXQgSSB3b24ndCBiZSBmaWxpbmcgYW55IHRlc3RfZXhwZWN0X2Zh
aWx1cmUNCj4gdGVzdHMgYWZ0ZXIgYWxsLCBhbmQgd2lsbCBpbnN0ZWFkIHNheSAieWF5LCBweXRo
b24zIGZ0dyEiDQoNClRoYXQgd291bGQgYmUgZmFidWxvdXMuDQoNCkkgbXlzZWxmIGhhdmUgYSBy
ZXBvc2l0b3J5IHRoYXQgaGFzIGEgdmFyaWV0eSBvZiBzdWNoIGlzc3Vlcy4gQSBjb21tb24gY2Fz
ZSBpcyBDUC0xMjUyIFNtYXJ0IFF1b3RlIGNoYXJhY3RlcnMgcHJvZHVjZWQgb24gV2luZG93cyB3
aGljaCBhcmUgaW5jb21wYXRpYmxlIHdpdGggVVRGLTgsIHdpdGhvdXQgZXhwbGljaXQgY29udmVy
c2lvbi4NCg0KSG93ZXZlciwgYSBsb3Qgb2YgdGhlc2UgcHJvYmxlbXMgY2FuIGJlIGF2b2lkZWQg
Ynkgc2ltcGx5IGF2b2lkaW5nIGNvbnZlcnNpb24gdG8gdGV4dCBpbiB0aGUgZmlyc3QgcGxhY2Uu
IEluIG1hbnkgY2FzZXMgdGhlIGluY29taW5nIGRhdGEgZG9lc24ndCBuZWVkIHRvIGJlIGNvbnZl
cnRlZCBhbmQgY2FuIGJlIHBhc3NlZCBhcm91bmQgYXMgYmluYXJ5LiBJJ20gc2xvd2x5IHdvcmtp
bmcgdG93YXJkIHRoaXMgZ29hbCwgYW5kIG9uY2UgdGhpcyBwYXRjaC1zZXQgaXQgbWVyZ2VkIEkg
aGF2ZSBhIGNvdXBsZSBvZiBvdGhlciBkZWNvZGluZyBwYXRjaGVzIGluIHRoZSBwaXBlbGluZS4g
SWYgeW91IGhhdmUgYW55IG90aGVyIGZhaWx1cmUgY2FzZXMsIHBsZWFzZSBkbyBzdWJtaXQgdGhl
bSBhcyB0ZXN0IGNhc2VzLCBvciBidWcgcmVwb3J0cyBhdCBsZWFzdC4NCg0KSSB3b3VsZCBwcmVm
ZXIgdGhlIHNjcmlwdCB0byBkaXNjYXJkIFB5dGhvbiAyIHN1cHBvcnQsIGJ1dCBldmVuIGlmIHRo
ZSBjb25zZW5zdXMgaXMgdG8gcmV0YWluIGl0LCBQeXRob24gMyBmb3JjZXMgdXMgdG8gYWRkcmVz
cyB0aGVzZSBpc3N1ZXMgd2hpY2ggaXMgYSBncmVhdCBzdGVwIGluIHRoZSByaWdodCBkaXJlY3Rp
b24uDQoNCkpvZWwNCg==
