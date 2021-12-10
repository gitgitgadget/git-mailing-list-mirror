Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF9BC433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 10:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbhLJK5m (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 05:57:42 -0500
Received: from mail-bn8nam12on2068.outbound.protection.outlook.com ([40.107.237.68]:31072
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236820AbhLJK5m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 05:57:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ofCday0KH25wRmGowq6jgnJfYA1Uoye2T2ZvKhE6TiIPaW7wE98hnVAZlh7NcgWyg0HKuzGGDh6aBYAZ/xLBBLX66wuPnFHIO6p3pqYJ2jPtVJw0lOvVVIt6E7y65uT26meuigwXj4mF8kYHwe9/ZaQgejVQPcEqoU11+kdhzAEEKDenwI0JiSMz15gzqsjI6r8oGMUtkBcakvyCZeJULvtEGnIFeMG34/y9yKPZgx0riE+fJDtFN4Sl6Eoh6tapKOUuXx20vzdibcyUKKyKwGJQoJpvD5cpJr39EdyGWI5D0J20htjFgzfohBN4bZ03Eb4UpVICuGp7U3WTbZwN/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3PBk15BOfT0d5M8sE0Dw+6XgaYiEq8GMKAtx6hfqUE=;
 b=HDcTLToSuGRtMXyHK9Db145B9qRM18TFLv2wStD5TOi1gb3nzfuYBJ2B2F3uSmTUQOIG9rr7Z6a8ya8cYjsKp2o2bSHoWWdfJFGb5bHLLrcnSmlWghsTAscz0mgkOF/TJucbq4XyGduci4tOX8wD8KdtVjU4y89QNcHMYdIKG5k04PnN1K10aV0qfJxFroUuJceGs0Nhf1Baazy+Y27ziNlhro3+3QKFSq4zGDnqPmuVXQcxqgtim1m1m/2/Yn5XVE/ir+vcrSrIJE7JK9tVSajujajvnTa5kvbUWbMfOZQUDAovnM2MaJpQKB13/6f7dU0bKRbhqGVxYLPdjA3tlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3PBk15BOfT0d5M8sE0Dw+6XgaYiEq8GMKAtx6hfqUE=;
 b=M4wQ7RAleZharK87UbJ40s9ZeP93B5ogYx8LunvYMqr4ju/6Ej4ATFdRtokPFLWr9qJqI5N4y6XIsaKS0tRhfS3nWYLoJYCI1UOvGVKMfPUujUZAt5UwIyLeUBi2uBH8dKfs8E6ENCRWxiwbN1JdrU9QoRUjORQBeJkoctMkz29eGT7dHRqlWhDJUP8suNZeNHNm9NJh3Gsi+f5l+5KE5RaZZLvWU17pK2U8Obo2mRhsdM8HQho0EQFqdCowhEVXkXFIkJy7qAGc0LA73fp7iEYmuLtHDrVkp8SjifZwNse2T2vhZXvijxcVX4He03msvQmAs1LHSNwyAzgaHMm88Q==
Received: from BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 by BN8PR12MB3363.namprd12.prod.outlook.com (2603:10b6:408:48::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Fri, 10 Dec
 2021 10:54:06 +0000
Received: from BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592]) by BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592%3]) with mapi id 15.20.4755.025; Fri, 10 Dec 2021
 10:54:06 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     Luke Diamand <luke@diamand.org>
CC:     Git Users <git@vger.kernel.org>
Subject: RE: [PATCH 0/6] Transition git-p4.py to support Python 3 only
Thread-Topic: [PATCH 0/6] Transition git-p4.py to support Python 3 only
Thread-Index: AQHX7TjcBdyuTAN1MEKv4eIoPWSSjawrW5kAgAAx4fA=
Date:   Fri, 10 Dec 2021 10:54:06 +0000
Message-ID: <BN8PR12MB33613E4CCDF13E6D0DE155BEC8719@BN8PR12MB3361.namprd12.prod.outlook.com>
References: <20211209201029.136886-1-jholdsworth@nvidia.com>
 <CAE5ih7872E8X-qRfBrBOHmKcUCX46GkXwq2WD3UUX8TuYczZDw@mail.gmail.com>
In-Reply-To: <CAE5ih7872E8X-qRfBrBOHmKcUCX46GkXwq2WD3UUX8TuYczZDw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb123d1b-bae2-4730-4306-08d9bbcb62f1
x-ms-traffictypediagnostic: BN8PR12MB3363:EE_
x-microsoft-antispam-prvs: <BN8PR12MB33638D8866087D28274F0137C8719@BN8PR12MB3363.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P+cM2jShiV88Z3WdgJLbsx0llfbJ9KNINxLHESA7LjPCKgYBPVTKRivoaiz1LVuCejAGdrn5Z9RgmSJnD1x6TnOMVXb4YcqjPWIQKQy/EBO1Pcn56mmZPJoUMicthGlmjjpGIuHBmAJ5KT7a/rb7Z96fzXg4J5nbqF6xirP2Wd5+jzmNln8K718PKQvmNKhcUwe31x1rzwUHPetYai3UuBJvd5hr9cjUTX0L7Hnt+UkOZmIZ/qAwIbxIFmUbORLN3G6do1MsRHTslBHFKV/HDWfqIFrhoLGUNLus0LPMLwa1LWDHByS/cGnzL/hWwSjAsYUxJXGnrnBjfAOIyI699LCWuht0XYq0EHsmYHVU/JvcS9ToY+6yEim/cZd9HQG2qs0X7bqo0NWUI/34FsAYmLTWyCZoP26og1pxlyCEaa30VEpaVPe+qACwQ666SQ5iIjKRu+wKWjg6+RIJ9T1uDRegQZkUxI7dd8ZOgBdhtUSqIDTRfTqqFdiB/+KVgM9WjQ5j5GACZDzM272/uNq7MZ/nC+EDFNe0T6pvu2aPwpRMYRknIEsPQkA1wTD8J5cLm4F1c7gS79ReILViOwb4xQZXtvxvSYWbKCxUfymt6CJgJALx8N5WBV1NBm5fHmHk/T+JqNW3AkfYmXhrJ65zHECOfjo+GttZJFIu9fPLF+tr2WVfG/GZHgm5op2FXb0rQpd++JhfXUu31zbZkWydJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3361.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(316002)(2906002)(7696005)(4326008)(55236004)(9686003)(6916009)(86362001)(76116006)(122000001)(66476007)(64756008)(71200400001)(66556008)(66446008)(66946007)(52536014)(508600001)(55016003)(8676002)(186003)(26005)(5660300002)(8936002)(38100700002)(38070700005)(4744005)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjhPQk5ZWmFpRFJvU2JCSlJPK3hSMWJqZWVUZHg4MWh5NWRmczZzY2JWQVVu?=
 =?utf-8?B?ZWFXRDc2ckM0Z29PTXduRDBna2NtaExycXhDNU5qWlpXbjd4THVUUFJ5a0Mv?=
 =?utf-8?B?SDdRem5yVzlNL1pTSmhLWTRVNEZSb2sweFJoVDA4M1h5YlVGcXpCbmpJcnN0?=
 =?utf-8?B?a3VxSWZhT3lldjY3QjJkaWV6QUhXRml5azYrN09XRC8yNUhMNmk0RWhsN0hS?=
 =?utf-8?B?V1BlVlJjRTdrVHhQZDU1bkZ4QUN3cFV6Nnk5VlBpdTl5WWtQR3dVclBoTDlZ?=
 =?utf-8?B?YWtzbnk2YjVHL1hmTThIcXEyMWtBUFNrYUV0Y2ltK081RC9qVy9abTVQVThs?=
 =?utf-8?B?WktXMU5GTzNuRXBHYzk1a1hWN3FiYk4wQlRwcmxkSDFwVU1yM2Z0clowcERq?=
 =?utf-8?B?bTlYaERVckxQZ2VqOU9WUEZRdnZvZk1lZ2duSWR6ZzROK0piM3VNU09FYXB6?=
 =?utf-8?B?blFoenZ5bkxxdWM2YVYybUZZN09zZnBxU3plU3lDK0xwM1JVWXR1d1o0SlNa?=
 =?utf-8?B?VExqcEtDbHRNYXRuVTI2NnJBVkRrS0xWYStjQVJ2cXp4TVhleFcwWU9VdG43?=
 =?utf-8?B?d1BLbU8yckkrVWQ2MUFMODJVbHJ5VllnR2xHQWhvcnRDbXRhVzAzczhkd090?=
 =?utf-8?B?M0RIblhxeUU4YlNkWkRlRk5ZeFlRTE0rN0JOQ1ZnY0V6R2VlVHpMcDM4eEcr?=
 =?utf-8?B?QUt2cUpidUlmY2VPWVhRTGhBWEI3WHN5Y3ovNko4OWlXZ2lxZ1ZWVC83WDdi?=
 =?utf-8?B?MFdPRmpPSk1YVGcwWlpYTkJnQlFEc3ltZWgvazhlakRHeW5GV3BKSU5GK0pw?=
 =?utf-8?B?cnhuZUpGb3RQSkc4dlFCVTdoMDNjbk5BMlU5ZWY0eXZFUzRqSVdIWElYMHNm?=
 =?utf-8?B?M3F2MHIrUGNVZUU3WVBXQVNDdTBpRUJtTStVbjF2TjJ5ZktrWXJ3SDlQSXor?=
 =?utf-8?B?ZzI0WkZVUjFXd20vV1Z1UFBMOUtncDNRTXF4NHJtS0pmVy9YbWJmTG9Nd3g1?=
 =?utf-8?B?ZTRyMjJvQjdBMzJCbllQRTR3bzNGMCtPcy8rNkZCcmhIYWlTRk12UEl2TGtn?=
 =?utf-8?B?cUUybEhtRDMvb2txbUpsVG9ZZ1dlZ1RtMEZzRGxFRjdPVWNTMVV3ZzVYTVFR?=
 =?utf-8?B?NUgwREI0UkpPT0F6akYvVmtCRktGOXNQak5VQi9zWTFWQitHTm1ueXNwQ1Y4?=
 =?utf-8?B?eTltV21SRWRRbTFGQ1RMWjBEWFlueGJoL2hCbEF3L1c3QjRPT0t0R2FtZWdL?=
 =?utf-8?B?TlpKdWdpQVhLU3Q2bUJyME1Jamp6b2Fvb0JYT1hyVzlOOFFYVTJRNFVWOC9N?=
 =?utf-8?B?TzlIL3NyT1pmQ1RrU3c2cm1ZakhZMEFKcmMwaHVaaWhwdEhzSzAyRmZML0ht?=
 =?utf-8?B?SjVwQUlwb3JBdk1hRUNHS0NQOThnamNXZGxiYW0vMkxDcGxLYmVVUFRDSDg0?=
 =?utf-8?B?Z1krV2ZjM3RFeEt3MUhWYkpueEpmTE1qOGdCV1lXNzdzZFVyL1Y3d3oxQVBH?=
 =?utf-8?B?M3lUSWZReFJac2h4VlVUV05lUTIwQW1lcTFPbGFHdVhSZ3Y2V1UzSytpaUp0?=
 =?utf-8?B?SDR2VXBEWS8vUHpPSXpwT256N20xblFUNkljazF1LzFEUkhBRGlaK0EzVm1M?=
 =?utf-8?B?aWE5cXNPQTdqMVIzY2dhbmUwWldCVllYd25IOHRjOGxoSFE1SnI4SzNJWkpa?=
 =?utf-8?B?c3VVcTlQRjlZNHFLZHVudjZJMWl1VmRka2RvNnlBZ0M5WWtTYlJjZUlQY0lm?=
 =?utf-8?B?WWJSRitxSG5HU25wWWZWK3d3T3VudytXSDkzd05ubzYybGFCeGFIbW5hZUN2?=
 =?utf-8?B?UjcvMlhaL1lRQThacS9OQUJ4Y2hBemhNV0Q1YXpPbytMQUpVNUFaSFNjcXp4?=
 =?utf-8?B?RWJlQytpektGczN3S09FejFraVJBNVhaVkZ2OTdoQVVFWXhuOWpTcVZNR2NB?=
 =?utf-8?B?Mkt4RjBMSHJJd096MXQ0ZThKOGQvL3J3cm96amUweXI0dWlWLzJad0prRmkv?=
 =?utf-8?B?QnE1TCt0Q2xKWGl0a2VxTVhUV2l2SlBDUUxwdlFzUEFhREh0RDRJYmVsaFgz?=
 =?utf-8?B?c09DZFFGYlpNZTFSeFVNekxXTHRGTXQzR2JrNzU3ekpJY0tiSitacDBkNGpw?=
 =?utf-8?B?YUlKTCtXWVpvVUQwdElHa1UzTmNFdGpFMkZJb096UGlpMnRidExBL2lDeG1o?=
 =?utf-8?Q?7HKZ4xiZR7HeGvkZmKgZBiU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3361.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb123d1b-bae2-4730-4306-08d9bbcb62f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 10:54:06.1839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aA6J5vVWFnL4u8Xpj1Ij4gfPK0HWWmQD6zOK5eXl0rgpp/QMvP+uZzL1IHBc1b3yUSjPJf+PVftGiP0wLGtZgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3363
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiBJIG1pZ2h0IGFzIHdlbGwgdGFrZSB0aGlzIG9wcG9ydHVuaXR5IHRvIHNheSB0aGF0IEkndmUg
c3RvcHBlZCBuZWVkaW5nIHRvDQo+IHdvcnJ5IGFib3V0IGdpdC1wNCENCj4gDQo+IEh1cnJhaCEN
Cg0KTHVja3kgeW91LiBJdCBsb29rcyBsaWtlIEknbSBnb2luZyB0byBiZSB3b3JraW5nIHdpdGgg
UGVyZm9yY2UgYSBsb3QgaW4gdGhlIGNvbWluZyB5ZWFycywgYnV0IGlmIEkgY2FuIGdldCB0aGUg
YnJpZGdlIHRvIGdpdCB3b3JraW5nIHJlYWxseSBuaWNlbHksIHRoZW4gSSBhbSBob3BpbmcgdG8g
aGF2ZSBhIGhhcHB5IHdvcmtmbG93IGV2ZW4gc28uDQoNCj4gSSdtIGZpbmRpbmcgdGhhdCB0aGUg
dW5pdCB0ZXN0cyBubyBsb25nZXIgcGFzcyB3aXRoIHRoaXMgY2hhbmdlLiBJJ20gbm90IGV4YWN0
bHkNCj4gc3VyZSB3aHkuDQoNCldoYXQgdW5pdCB0ZXN0cyBhcmUgdGhlc2U/IEkgYW0gaGFwcHkg
dG8gdGVzdCB3aXRoIHRoZW0uDQo=
