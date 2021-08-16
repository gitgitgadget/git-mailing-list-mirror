Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CC1C4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 18:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C46FF60F36
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 18:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhHPSx6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 14:53:58 -0400
Received: from mx0b-00209e01.pphosted.com ([148.163.152.55]:64818 "EHLO
        mx0b-00209e01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230143AbhHPSx5 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 16 Aug 2021 14:53:57 -0400
Received: from pps.filterd (m0184430.ppops.net [127.0.0.1])
        by mx0b-00209e01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17GIpXIL029984;
        Mon, 16 Aug 2021 14:53:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ncr.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pod1119;
 bh=2EyG9KINz5JeqS9dNmYCN5BnjEVDsuMpOqyTrH6Qy0w=;
 b=lFOD6AqO8NsSb1r1GgMBBAUa8jUNCG0sxNJkTYyS0T758rLvhyexwE+I9S0pgd8TY0zT
 x+jeoTr9GsUbwLL4rtPI1/mWiE9bnvIEnh9w8Va3+Gw8V4MquZXuoqYsFRijXWwOFYCs
 XJ4bzSpR0y/1aHx2rxTJlSBPz+Ue15zKhI20YH7iM7UBFPHv2gfvqm52EQ5ceiPYQ/OI
 oK4JkOp15gd0J4nrTLvkNrwgj2Jh3tskpKoA6jBfffrgP5bhH6dtISP/7q4DkxQnvGIA
 Un3t+QLpca+5701BTqb3HJsyWpdZBsbauZjIJSESHK6pIFxTtdUT2ZX+jCblypjlk/20 qg== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by mx0b-00209e01.pphosted.com with ESMTP id 3aetqpjtfy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Aug 2021 14:53:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1puNrNwcMbbBR55J5iFiEnS4KZANv5S369ZNVM9oRzQJxF2J4Rl+vIJK8LvVu+0RuoUxNP5NQsdmSU2rCC3jlmwws9d3pNac7/F2jh+oDKQ763GwaFZW6lpWBXLVPlSPASiCWQ25u3vJPw9fDMsP0YElIwar/Ih4qtifm7eJ3PqZvoPJ/NH66GV9iSt9pQTQ/VpIxGkcZe3zZe4oQ8AeOCb+mazNozyL8/gHgqJaLOlWH/Boq3fUZxormN2yvX+Onpv5lAnoIUXcdTIs8RChycBgUpPP3yHyDQn3uRVGyY+KEfDDaIwCgAR8+klRemBtQJOQcEvUpUjCyw9LPXG6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EyG9KINz5JeqS9dNmYCN5BnjEVDsuMpOqyTrH6Qy0w=;
 b=nTQuYwwuvPMXSZvLKXBWJdJ/CUNgq9/ZE+3Nd77OhQiZb/MdbhdIz6bHhuACAgtFoOrYvLgV9ybgYmNKHOtGKktMwb21sv6bC34grbfJ4C0ltnxl5JAiXfvkaHX6AcCc5TUO7aqidOZPwVJZUlgUOoIBTPT8d3hNoEf7WC2dKhJvmhUxn/GUMb4H77zhbp0J/L83lnCbxJPfSTSLQnGnzNt42R6dmyxhY5Mbw/UHk5hESMytKGLKhUCU/V1GYAM53ZecbXRbTA/3Vr68s4Il+IFQmtfDLQmWi8s0d5WDUJnGY3BeQf/NCzRk/J47Q1zwHpG08OQmxD46cTjaww/rzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ncr.com; dmarc=pass action=none header.from=ncr.com; dkim=pass
 header.d=ncr.com; arc=none
Received: from BN6PR15MB1426.namprd15.prod.outlook.com (2603:10b6:404:c4::18)
 by BN6PR15MB1121.namprd15.prod.outlook.com (2603:10b6:404:e7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Mon, 16 Aug
 2021 18:53:14 +0000
Received: from BN6PR15MB1426.namprd15.prod.outlook.com
 ([fe80::21ab:b879:3cff:87c3]) by BN6PR15MB1426.namprd15.prod.outlook.com
 ([fe80::21ab:b879:3cff:87c3%6]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 18:53:14 +0000
From:   "Russell, Scott" <Scott.Russell2@ncr.com>
To:     Jeff King <peff@peff.net>
CC:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: git clone corrupts file.
Thread-Topic: git clone corrupts file.
Thread-Index: AdeQbBTmFYBcWaT2QVKI1LhsxFP/CQAAfQYQAAGNnwAAB6C0gACE7ckwAAYxx4AABBpiAAAAEXgQ
Date:   Mon, 16 Aug 2021 18:53:14 +0000
Message-ID: <BN6PR15MB14268392DBC2F0C210EBE803CBFD9@BN6PR15MB1426.namprd15.prod.outlook.com>
References: <BN6PR15MB1426E50F03A0530CA9140F98CBFA9@BN6PR15MB1426.namprd15.prod.outlook.com>
 <BN6PR15MB14261C40E614CC11416388B4CBFA9@BN6PR15MB1426.namprd15.prod.outlook.com>
 <BN6PR15MB14264C9A96F4B5F6B01FA7FACBFA9@BN6PR15MB1426.namprd15.prod.outlook.com>
 <YRbya0UO2+PvOjL5@camp.crustytoothpaste.net>
 <BN6PR15MB1426E99386269CCBDA888D51CBFD9@BN6PR15MB1426.namprd15.prod.outlook.com>
 <YRqYD+SszvhhySwl@coredump.intra.peff.net>
 <YRqzmC5ubd0TEWL/@coredump.intra.peff.net>
In-Reply-To: <YRqzmC5ubd0TEWL/@coredump.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Enabled=true;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_SetDate=2021-08-16T18:53:01Z;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Method=Standard;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Name=dc233488-06c6-4c2b-96ac-e256c4376f84;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_SiteId=ae4df1f7-611e-444f-897e-f964e1205171;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_ActionId=15cf1863-da88-4d95-90ca-c0b8c0bb961c;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_ContentBits=0
dlp-product: dlpe-windows
dlp-version: 11.3.0.17
dlp-reaction: no-action
authentication-results: peff.net; dkim=none (message not signed)
 header.d=none;peff.net; dmarc=none action=none header.from=ncr.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9268c2ec-cebe-4d1f-1642-08d960e71a62
x-ms-traffictypediagnostic: BN6PR15MB1121:
x-microsoft-antispam-prvs: <BN6PR15MB11219E91FA0840819BF738A1CBFD9@BN6PR15MB1121.namprd15.prod.outlook.com>
x-from-ncr-tenant: Processed
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HuXSzfd8gj+j9TIOle9adwzlt5qt2PP27SmkIPCuErIhtsjzpzuPqlTvEZwTeZfC1MMHSCJSpMusc5p7+zPGBL1XqiMPjrUZz0d8AvyXGFuiMOM5641lLmGyR+gSasKa/PSE320nX+fEThk0Cc0Yk/CtmEr1F5SBK6CZ1eZdg/Zny8qOObWVhPL2wkjj5hV19mnZixNI4flQGy8yvmCw34ZQB8vIIoldyR6rBgS/sT7xGgYOl+KNQ8a8MKDKj5/SalWObrEjgwEj2bQO8BimcqnqYCHYZ5tyYMH1vn4VWSdd3Cw+jyd4MELAMCkZkbUtlG68NRx5N6OYAOeJMSya339EJTxFwZRRaacmk3/EjdMYSjgZ8ivw5x4t+8AWJtdy0JR6hpoVFKTs5JgnWihQoXqs3o4hpvMAeVcG7DnkJqAJDt00+2ys+s1trM7tqArjlPMs/oPYpvXUulp2swnOJP8d0HzRw4TWS8pnyuaqLJnA8YM/hRklvS8UTLepPUM5h5OpNPg7bLHjH6PF+1G+6VlzDpx+u+crcPjgPtlTRtu6ZScEU575fY5ip41EMHFh8O6w8+HZYGyMDNGajAGwRF5tBmBqAL2P68Gl9sayIQ6Hnod99gnQRwmVo25/ZVqgeUqrSW7Qbq9mX+H2k+PPYs8YPt9JBvZVivyzSUpklWbmEZqVHCeDhzuHkQopd+Tdww8ttGY/37pOE6a2wMZmTg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR15MB1426.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(346002)(39860400002)(396003)(64756008)(52536014)(38070700005)(6916009)(66946007)(66556008)(66476007)(7696005)(26005)(83380400001)(33656002)(478600001)(76116006)(71200400001)(5660300002)(6506007)(3480700007)(55016002)(53546011)(66446008)(9686003)(186003)(8936002)(54906003)(316002)(86362001)(8676002)(38100700002)(4326008)(122000001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnBDMzRFMVFLVnJKL2JkcnErOXZ5eHd5M1F3VmsxZVVhV3dnU00rKzBLZjZ1?=
 =?utf-8?B?TmxGaWpUZHpzMmhxUlpZU2FHc0NyelRNV2pDWG9aeVNZNDBpWmRtNzA0WWN6?=
 =?utf-8?B?VFNOcm1vV251bzRKTzdvSXRaMWhpaUxBeUdPZWtNa0ppdDhJbjQ1dEJjY1RQ?=
 =?utf-8?B?MzNpcCtxZTd2L1BPWDB4bS9KSXordEdaa1dEd3k0QWhUYXhmRkM5aU1pbmdR?=
 =?utf-8?B?QmFKYnRlVUJ5SUozdnY2OVpRRkI0WTdjNTh3YngrankwMWdURklCWDZ5QXVv?=
 =?utf-8?B?U2lPdlVPMnlCeUdKTENaOUMxQlNJY0cyUFQ1bS8zSXpjc09TZWJsZ29uVHE3?=
 =?utf-8?B?ZU9IUkVpdzVOYzRnV2tRZEVwRUQvZUVCV1A2cnJQVTF6UkNFUjNCNHhVNjRn?=
 =?utf-8?B?ZHYweXRTYllwMXdLMWk5NW5tdmhHRGJWQ0l4NnRzZm16T0ZCQjZJVTJmNmdq?=
 =?utf-8?B?ck5kcHpjR0htMXpGd1VjVnpoUEVXWUd2UjFGdENYMFJ4VEgrek53QkRKekFV?=
 =?utf-8?B?VG9zM3hERmR6eEhSUmJIRHFtaWhIbWVlemRlRi9kS1pmMTYvVnh1TGkyVjlh?=
 =?utf-8?B?cW5sNEFXZU9QL3RKTHlSRDUvSjA3R3UvRURyVklLc01rdmsvQTk4K3NiaVNY?=
 =?utf-8?B?WUVpREo5YjMxTGthSEZUTnZYblVudTAvbTRwaFltR29zQ2w3SUJvb1R4K2ZM?=
 =?utf-8?B?SG9DbGJHN1lGemhLazJhb29HVGF4R1c1dGNMbEZyT3YxVTJ1V0R0TTlUalRx?=
 =?utf-8?B?OGhodUN5MDh2eW9jNEZCeURabGJ6THF3L1ZBS01MWEtzZ0dUK1lMUVpvTHpO?=
 =?utf-8?B?Q3pyYXJPdi9tRnVNVHA0MzRUVDhsOG9BaytobW55MVpzL0VYaWVXa3pKUkJq?=
 =?utf-8?B?cjRxMFY4ZFhBcmcwV1V0MTE5WDRSdTUwTFpIVFk2WVlnVGphTFgwQ3dZckp3?=
 =?utf-8?B?elhZakVkNVdLNVRWdXRmQ2Y5OHk5Q1ZOMEthdFNVNEN2amxPREZOZGhlczR4?=
 =?utf-8?B?T2hHQ25PNW93N0pGVWsrYVZoL283T01FOXM0TTNnMnp1enRZR1hGVjJKR2pz?=
 =?utf-8?B?Q3RmbWhiNlZBRTdST2I0Q0g5Q0hDRGV6QS9mU0M4VWR2OGszZzVia2JncThO?=
 =?utf-8?B?N3pGajkwRTJiOFBqSksvdzJRcUswcTI2Uy9wQWI4MjBwMExKUkl4anJIaThB?=
 =?utf-8?B?V243YTNYYTcvWWxZL3hIOHQyTTR1ZmVncDRNWUsxMGRSWkZ4V25BK3NiNHh0?=
 =?utf-8?B?V1hrbllrSjFtVGQyMmd5RGdRQWtFaFV3VURWbEJyc2VWSjdRMVFidVREbkcw?=
 =?utf-8?B?T1k4bTQySWlqTGhiVzZsT00wTU1lVDBOVE52M3I5SEZVZjJWQlQ5UklybVFk?=
 =?utf-8?B?cjAraWNtVEozMUVkeDhVRjU4Y1RwUm9ZYmc2ZDRQSGd1anpiMUhYUmRkdTA5?=
 =?utf-8?B?THY5dkhwR000VjMvY2grOUxFT3JVUzl5ci9hUUVuYWN1eStaN0JTRlNWNlU4?=
 =?utf-8?B?N3h0cmlubmtEcjBxOHJHTzNscHhyaldLZllIblBSTWhvWWdMV2dOcTJZVkM5?=
 =?utf-8?B?aDBOa3lFYmQ4UzkvR1lNUWE2a3p0K0kzallvY285MTdEdjZOK2lFdHlJbHdT?=
 =?utf-8?B?a3EyTk5zVEpNWUtOa2tkR0Q4UlM5dCtkMDJobzl2TVF3TTRKOEpMMHhmbmwr?=
 =?utf-8?B?YzB2VzI3R3RrOWFTRGVrTGZjSHRhd2todmViKzI2V1hVUWh4WC95bTZsUWJN?=
 =?utf-8?Q?MSoGWfc40it1kN/zWBiBNP2jd6hc2NCyQCGSBjr?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ncr.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR15MB1426.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9268c2ec-cebe-4d1f-1642-08d960e71a62
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 18:53:14.5143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ae4df1f7-611e-444f-897e-f964e1205171
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zq58ZheQoqhk0WD9WpjdoQgAAzu5k3IjrM9M1dNgbpdwxXEe3nPRvaF0QI6cBON7KWC5bvHKKe80FHk2glY0qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1121
X-Proofpoint-GUID: rpaGPGiA3WFR9eTGHraTze7yorVNxMc_
X-Proofpoint-ORIG-GUID: rpaGPGiA3WFR9eTGHraTze7yorVNxMc_
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-16_07:2021-08-16,2021-08-16 signatures=0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

T2theSwgdGhhbmtzLiAgSSB3aWxsIGxvb2sgZm9yIHRoYXQuICANCg0KDQpUaGFua3MsIA0KDQpT
Y290dCBSdXNzZWxsDQpTdGFmZiBTVyBFbmdpbmVlcsKgDQpOQ1IgQ29ycG9yYXRpb27CoA0KUGhv
bmU6ICsxNzcwNjIzNzUxMg0KU2NvdHQuUnVzc2VsbDJAbmNyLmNvbSAgfCAgbmNyLmNvbQ0KICAg
ICAgIA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogSmVmZiBLaW5nIDxwZWZm
QHBlZmYubmV0PiANClNlbnQ6IE1vbmRheSwgQXVndXN0IDE2LCAyMDIxIDI6NTEgUE0NClRvOiBS
dXNzZWxsLCBTY290dCA8U2NvdHQuUnVzc2VsbDJAbmNyLmNvbT4NCkNjOiBicmlhbiBtLiBjYXJs
c29uIDxzYW5kYWxzQGNydXN0eXRvb3RocGFzdGUubmV0PjsgZ2l0QHZnZXIua2VybmVsLm9yZw0K
U3ViamVjdDogUmU6IGdpdCBjbG9uZSBjb3JydXB0cyBmaWxlLg0KDQoqRXh0ZXJuYWwgTWVzc2Fn
ZSogLSBVc2UgY2F1dGlvbiBiZWZvcmUgb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KDQpP
biBNb24sIEF1ZyAxNiwgMjAyMSBhdCAxMjo1MzozNlBNIC0wNDAwLCBKZWZmIEtpbmcgd3JvdGU6
DQoNCj4gQnV0IGFuIGFsdGVybmF0aXZlIHdvcmtmbG93LCBpZiB5b3UgcmVhbGx5IHdhbnQgVVRG
LTE2IGluIHRoZSB3b3JraW5nIA0KPiB0cmVlLCBpcyB0byBjb252ZXJ0IGJldHdlZW4gVVRGLTgg
YW5kIFVURi0xNiBhcyB0aGUgZmlsZXMgZ28gaW4gYW5kIA0KPiBvdXQgbyB0aGUgd29ya2luZyB0
cmVlLiBUaGVyZSdzIG5vIGJ1aWx0LWluIHN1cHBvcnQgZm9yIHRoYXQsIGJ1dCB5b3UgDQo+IGNv
dWxkIGRvIGl0IHdpdGggYSBjdXN0b20gY2xlYW4vc211ZGdlIGZpbHRlci4gVGhhdCB3b3VsZCBs
ZXQgR2l0IA0KPiBzdG9yZSBVVEYtOCBpbnRlcm5hbGx5LCBkbyBkaWZmcywgZXRjLg0KDQpPaCwg
YnkgdGhlIHdheSwgSSB0b3RhbGx5IGZvcmdvdCB0aGF0IHdlIGFkZGVkIGFuIGludGVybmFsIHZl
cnNpb24gb2YgdGhpcywgd2hpY2ggaXMgZWFzaWVyIHRvIGNvbmZpZ3VyZSBhbmQgbXVjaCBtb3Jl
IGVmZmljaWVudC4gU2VlIHRoZSAid29ya2luZy10cmVlLWVuY29kaW5nIiBhdHRyaWJ1dGUgaW4g
ImdpdCBoZWxwIGF0dHJpYnV0ZXMiLg0KDQpKdXN0IGluIGNhc2UgeW91IGRvIHdhbnQgdG8gZ28g
dGhhdCByb3V0ZS4NCg0KLVBlZmYNCg==
