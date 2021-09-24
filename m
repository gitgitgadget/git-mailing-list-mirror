Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BD4C433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 19:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 647EA61038
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 19:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348227AbhIXTyv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 15:54:51 -0400
Received: from mx0a-00209e01.pphosted.com ([148.163.148.55]:10820 "EHLO
        mx0a-00209e01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348224AbhIXTys (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Sep 2021 15:54:48 -0400
X-Greylist: delayed 3632 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Sep 2021 15:54:48 EDT
Received: from pps.filterd (m0131213.ppops.net [127.0.0.1])
        by mx0b-00209e01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18OEYDCD014984;
        Fri, 24 Sep 2021 14:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ncr.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pod1119;
 bh=INly1/dRsufDnBQoCIA81j0J71KHYPpM2uS+RQAzPMM=;
 b=oe4ItBVOSLfXcmnz/KyxUXMHl62hx2oMtyYDDfLJfTZWIYzZ6JibEUX+N3oSQ9w2/deX
 C7nNqAGBFJsypvgmnUDt+Edk5k9TaIZyJC3HcJ1Jgx5TNzZ9l/TwUf/OSXWRnnZMH8QE
 kl6cJLwEK1FuDj8vw2A7PQv5t8TfX3J/ihcjEmvyDJxvuO7pBeLuT4+F8nIg2rt4ZLd7
 zbmJ17E9DI4H0wyccsCRwiUCDJVXPxm0plkRRkA6jG2sB4B0Pof1YG7HObEKnNG3GIOO
 5XShMUUNYhJBdlLul5jPeMZc+pfjiIpuGToGW5R1fhSjWxNngHhhZxe0G57FqW2RRjkL 8A== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by mx0b-00209e01.pphosted.com with ESMTP id 3b93ew56y0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Sep 2021 14:52:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPNAivrkOVkIGJ5/2KvQn9Ub4xeccKdlj06RtFGLMKU7aafQr/eHpMejeOYaLA8QMfWbOYyoOA/lzGlgvboybDy/ruiAjIl36NyrxjcrGHEhcxGfvhFvyO8t2ikzwfD6O5Nnf3aYwHtwR+Ja5hG3qZlzPlPTEJqk00dGkr2mnIs6ccghzW4dzTq8EXWCt9g63mJul3MpwR6TMVNZ6R+QDfFcQ+4djI9vJ6iF6qn0im0RgLP3TD8ZZMkDT9gtPNnRdGan0wzwNOls9qY0ksjnYxpkKaQy5CyoDM+9fSk8wZ3BVo9TklZ1fp/I/3VtAma7DTWHhUVYOe/qaYSXn4MJZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=INly1/dRsufDnBQoCIA81j0J71KHYPpM2uS+RQAzPMM=;
 b=EUQ5ROJWnwQwUClGUWJHz6n9duYZLfnl0qBZ/iO/j2HjY8NfSeFC0wchwUSZKiBSV+BxtME0RshPRxDXw3TITPTOlj5M10VXFs6uFzDwQYAc5zHH6J1p/btJnID7suEWSlgxqlfZubHJL1+MxfwS9tXR7HLriKIi3LAYqOFaX80HP3nxop2WFQHdHnenHlYSz0eJdRb4eNixxSK/8xNqg0UVyeXzE6ESdi8KSRSHdmDpAPBl0vvcZxbwoGYurF0WnhtgyX/IxWt3vcZRuXMTEFcL/ieqBt+GKZ0ojhKMFpzD48D9EEb/sBP/VVhDkOxCC5usFpYBWa8JI5S2tgbp2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ncr.com; dmarc=pass action=none header.from=ncr.com; dkim=pass
 header.d=ncr.com; arc=none
Received: from BN6PR15MB1426.namprd15.prod.outlook.com (2603:10b6:404:c4::18)
 by BN6PR15MB1745.namprd15.prod.outlook.com (2603:10b6:405:53::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Fri, 24 Sep
 2021 18:52:31 +0000
Received: from BN6PR15MB1426.namprd15.prod.outlook.com
 ([fe80::fdf3:7fad:62b4:e015]) by BN6PR15MB1426.namprd15.prod.outlook.com
 ([fe80::fdf3:7fad:62b4:e015%12]) with mapi id 15.20.4544.014; Fri, 24 Sep
 2021 18:52:31 +0000
From:   "Russell, Scott" <Scott.Russell2@ncr.com>
To:     Emily Shaffer <emilyshaffer@google.com>
CC:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: pull failed - why should I receive this message.
Thread-Topic: pull failed - why should I receive this message.
Thread-Index: AdexUt9vq4ww6wDrT/SkOsyNHqWUqQAFrpQAAAAqpgAAAPPngAAA0WowAACK+YAAABKf4A==
Date:   Fri, 24 Sep 2021 18:52:30 +0000
Message-ID: <BN6PR15MB14267A97C763370316AA76B3CBA49@BN6PR15MB1426.namprd15.prod.outlook.com>
References: <BN6PR15MB1426A342CBA9D993C0C49E55CBA49@BN6PR15MB1426.namprd15.prod.outlook.com>
 <CAJoAoZ=DuqHe2brN8Y2Ts0_afEhUNrdasRBb1O8HHomLKRJ4PA@mail.gmail.com>
 <BN6PR15MB14261D1A350398C0C26793E1CBA49@BN6PR15MB1426.namprd15.prod.outlook.com>
 <000401d7b16e$17ea02d0$47be0870$@nexbridge.com>
 <BN6PR15MB14262C7036B3C792CCE861D8CBA49@BN6PR15MB1426.namprd15.prod.outlook.com>
 <CAJoAoZnuTGoF5J9FiwFTxsrG5VZ78zwKXe9w7__8U6UrCVQmeQ@mail.gmail.com>
In-Reply-To: <CAJoAoZnuTGoF5J9FiwFTxsrG5VZ78zwKXe9w7__8U6UrCVQmeQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Enabled=true;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_SetDate=2021-09-24T18:42:39Z;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Method=Privileged;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Name=dc233488-06c6-4c2b-96ac-e256c4376f84;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_SiteId=ae4df1f7-611e-444f-897e-f964e1205171;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_ActionId=ed6bea82-6386-4044-acdd-caac4a8f579a;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_ContentBits=0
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=ncr.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e61e757a-2a8b-4b25-820a-08d97f8c7690
x-ms-traffictypediagnostic: BN6PR15MB1745:
x-microsoft-antispam-prvs: <BN6PR15MB174597023A9D0A122A057163CBA49@BN6PR15MB1745.namprd15.prod.outlook.com>
x-from-ncr-tenant: Processed
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jj1X+Nh6iK4P3WRgKx9JFtdDtvvpHCiH5q2VSrHXycjYFvc2+Bqj3y/i01a3W+Qz8snPhvmfyXD1qTYf1QD3RtQk0gpU5FG2IJuq5cQETiDvdRL2BlPuqS3F2MaHQ3ysMnF670j/SXMcJZ9HpdbdZTR2dUK31V2XZm53xAJYm127WO7bGP8Co8mSTHOF2iz04oOnqhOG0upAM+qHFM3yJ/D4amxkBKGX9bRbLsroDbiHguBsa6nTy6tY8B5uBhQX1BEq8fvQa5ELSVnTf5MDOe+NOnqzrRosK/xjhZ7rk37YpGYfSSn7yuboug2DSzm7cU5iCEqPV1IKkmj626te7jirmfJYvO0ciEl/8AaIlsbh3GA04cJzdlMJNVPaUqQyTbFgrYPiqbii9Bk28RqOlo3CmfoSw08WnJFs8eCLUt7zxOAVGY+J5m2qpFsCt0iewYJ8MESsax+7Gsp9RjSRW9Bf2hXRLTRZ/lqcxCSTN6/yqpdy08FKBThmORKLVRBDT4uYJl4gV0XnopbM24Y2fnTee+xmZ6U/rBhk9TXSRX7hkMrlgxDU6bp4GJHSiVCsuG+Q69pJB3Qzx5iyzPeBwBC74nauQVUpaH/6ETiwClr3apqAdIMpnoFqQUqOGhlK7TpdpSz6f/FvPAheefQMp14AIyZ9po+PYWf0JZSztzV2Nr9Udyx4c/+cyTPim4t5XxCzpsoL+aeWAcE2iI7ZkQelWCh5vp8Hmbi2anm+kuk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR15MB1426.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(5660300002)(6916009)(26005)(186003)(53546011)(508600001)(52536014)(2906002)(86362001)(33656002)(66446008)(76116006)(71200400001)(9686003)(66556008)(316002)(64756008)(122000001)(6506007)(38100700002)(66476007)(15650500001)(8676002)(38070700005)(7696005)(54906003)(8936002)(55016002)(83380400001)(66946007)(460985005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkczdEJFR01SNFVweW11YUhLNWt2UHB1OHcrSFh0cytldHQ0NG4wSkhNTnNv?=
 =?utf-8?B?ZkdFOVZPZnNLaW04N0ZIaEtVcWExRk5oQitSRHhIbmgzOWhLL21EOVpTOCt4?=
 =?utf-8?B?clZ1VjJSbDBhbWFIMVQ1R0Q5QkZjN2U4MWdqVEorMEh0LzNHMFU2ZGdwK29t?=
 =?utf-8?B?UVY2SzRudjU3cEpLbk5OMWJlanArak1SZ3NscFY2QXA5MGJPNytqWUduLzFG?=
 =?utf-8?B?MFRHMk5mM1ByMHZQMk9BZmNHWXg4a01BYk52SWE4cWN1dFZGa3R3c1lVMDRY?=
 =?utf-8?B?TDFFQjd2TStzT0lNWUlaWWdUZ1N5Z3JWaHFQK3FKM2t3NHI4QmZhYWY0bWhy?=
 =?utf-8?B?bWcrb3J4bDlwMWFLcDZLR2wrZmVJWnpYUXp1blR6bXpPN29KMWRiYm9qMkdl?=
 =?utf-8?B?U0pTQjFTYnRaRGZ3SC9UN2ZoK1hxSzlWaGwwRGlXTmExN1B6TlRqTWYyK3Z3?=
 =?utf-8?B?aHh3cjYvOFJNNks5dDZ1ZFMrSmFveHJCZENVTFhhNmxNc215TGhBSWRYSXQ0?=
 =?utf-8?B?WU9oNjFva2lOWWYybmd2OGIrR25sUndDVytzcVJ5cVdEdDh4Mk0xVG5SZmVk?=
 =?utf-8?B?UGpxTlZJSldma2FKaUJjK3puTG1acmNsMWl0WW9yWmhOdENqanpxbTQ3VFVF?=
 =?utf-8?B?c1RWeVQvS3JOZG5ad2xnQk9URGRIVjdINmx3dEREbFRmenJ4NFdVQzRKTlh5?=
 =?utf-8?B?RVhqWVNiMXFYS1RxYkdQQlR6R2ROUFdsVHVybzBGaU9xOWRmbUNDNnlQN1NH?=
 =?utf-8?B?WEI0QmY1QkJNT3pRZC9hKzZSQUVLYUJpL0dwTGk4Sm1uVjkxOXNlZUNyZEFk?=
 =?utf-8?B?UDZHaDduMElyalRXb0hobUgvMTFBSXpiNzFCQmZuK1gyakRnMmpGQnN3WkVH?=
 =?utf-8?B?dHpLeTFEaWpGcFprRHZPRlFVYmRJYjNBY0JIZHd4SUJ2SWxSM0pVRm5OR0Vp?=
 =?utf-8?B?aEZVYWFSL0RTNmV4V05FOXJlS2VuclZjcytac29PZmh3MlJKengvbWFKSUNr?=
 =?utf-8?B?SlIyUmxKWDZrM1RScnFoZEdlOFo4bXVhTDV0VFRYTURTZ3ZMclFnTm5yeUli?=
 =?utf-8?B?Z2hQTnkwYjN4WVFrYzJuekg5SGRjSFN5WVUxcDZoNHNEYTFaTGVoU08xd3lq?=
 =?utf-8?B?WlhHeDk5T3h4Y2ZLei9odi9EZU91UmtpdTkzT2l4MnpxYU9jcERVU0xERSs4?=
 =?utf-8?B?NUxpM2lObVJzbE1MSENkeGQ3bG55aGFta3FpTkZBYzFvejdKOHdKb2hMb2FE?=
 =?utf-8?B?OGx6bmtQOUgwMGNybyszVGRBWHVmQ2x5RGFrT0tOdVhndGhKTG5UZFRHd3Vk?=
 =?utf-8?B?MjVQY3BYVHYxUjVUT21EQ2xacTgweXNZY0lMdEVLNU15VVhkTzdJYXpDckhH?=
 =?utf-8?B?bkVWK0tHc2tSVDg5UVQ4ZzdyRTZUa3JBR3ArK0dpOU5yY0I2OU5kZmc2Tzk4?=
 =?utf-8?B?YlJXOEFyV3RvVXpMZDR0a1dFajRmV0c1bDk1SmtoYUgrSVJJdmVtN2ZnYStD?=
 =?utf-8?B?ZWVHRTJXY0E0VkNCWXQ1TkN0cHpseGpBMmNLT0lXU2tSNTMvU0k4aXNMM0JL?=
 =?utf-8?B?MWtwcHczbnlIY01CTTREMUs5RXNnNndnUjFOSkFTak12dnNrbWNhYUEybU5m?=
 =?utf-8?B?OW10Y0JRbkk0RWJzNGh6M3hKc2RoTVEzKzJPeDBaSEt6WGEyU2JQYnNJc29x?=
 =?utf-8?B?cElvWFJtV1B3TGhiQXh1cE8rQTI0TEZLOTI4eDFIQnNkbkwzazlsNERCZFda?=
 =?utf-8?Q?0TUAYtdBzjKaoqWMT3fE1mWXrZquiSBfZ1MTpwn?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ncr.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR15MB1426.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e61e757a-2a8b-4b25-820a-08d97f8c7690
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2021 18:52:31.0067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ae4df1f7-611e-444f-897e-f964e1205171
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ajX+HMJRfNv67ghYfD2iS0tOYTL6zKWHn8t/jLoxIR7As4UWiAmWuN9FbtJOSP5qj4Ft6YMQNK0fnvscOLQSng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1745
X-Proofpoint-ORIG-GUID: VgmOg65rpCvqOBcAiVhplZSrcRrT0naa
X-Proofpoint-GUID: VgmOg65rpCvqOBcAiVhplZSrcRrT0naa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-24_05,2021-09-24_02,2020-04-07_01
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

RW1pbHksICANCg0KVGhhbmtzIGZvciB5b3VyIHJlc3BvbnNlLiAgIFdlIGhhdmUgYWxsIG91ciBh
bnRpY2lwYXRlZCBidWlsZCBhcnRpZmFjdHMgaW4gLmdpdGlnbm9yZS4gICANCkhvd2V2ZXIsIHRo
b3NlIG1heSBub3QgYmUgcGVyZmVjdCBhdCB0aGlzIHBvaW50LiAgIA0KDQpJdCB3aWxsIGhhcHBl
biAtIGJlY2F1c2UgZmlsZXMgcHJldmlvdXNseSB1bnRyYWNrZWQgd2lsbCBiZSBhZGRlZCB0byB0
aGUgcmVwby4gIA0KQW5kIC5naXRpZ25vcmUgY2FuIGJlIG92ZXJyaWRkZW4uICAgIEV2ZW4gY2hh
bmdlZC4gICAgDQoNCkhvd2V2ZXIsIHBlcnNvbmFsbHkgLSBpZiBJIHdvdWxkIGJlIGEgZ2l0IHBy
b2R1Y3QgZGV2ZWxvcGVyLCBJIHdvdWxkIHByb3ZpZGUgdGhlIG9wdGlvbiB0byBvdmVycmlkZSB0
aGlzIHB1bGwgY29uZmxpY3QuIA0KTm90IGV2ZXJ5b25lIGRlc2lyZXMgdG8gcGVyZm9ybSBtYW51
YWwgaW50ZXJ2ZW50aW9uLiAgIEl0IGNhdXNlcyBsYXJnZSBkZWxheXMgaW4gcHJvZHVjdGlvbi4g
DQoNCldoYXQgaXMgdHJhY2tlZCBpbiBnaXQgc2hvdWxkIGFsd2F5cyBvdmVycmlkZSB3aGF0IGlz
IHVudHJhY2tlZCAtIGluIG15IHdvcmxkLiAgDQoNCg0KVGhhbmtzLCANCg0KU2NvdHQgUnVzc2Vs
bA0KTkNSIENvcnBvcmF0aW9uwqANCiAgICAgICANCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCkZyb206IEVtaWx5IFNoYWZmZXIgPGVtaWx5c2hhZmZlckBnb29nbGUuY29tPiANClNlbnQ6
IEZyaWRheSwgU2VwdGVtYmVyIDI0LCAyMDIxIDI6NDAgUE0NClRvOiBSdXNzZWxsLCBTY290dCA8
U2NvdHQuUnVzc2VsbDJAbmNyLmNvbT4NCkNjOiBSYW5kYWxsIFMuIEJlY2tlciA8cnNiZWNrZXJA
bmV4YnJpZGdlLmNvbT47IGdpdEB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiBwdWxsIGZh
aWxlZCAtIHdoeSBzaG91bGQgSSByZWNlaXZlIHRoaXMgbWVzc2FnZS4NCg0KT24gRnJpLCBTZXAg
MjQsIDIwMjEgYXQgMTE6MzYgQU0gUnVzc2VsbCwgU2NvdHQgPFNjb3R0LlJ1c3NlbGwyQG5jci5j
b20+IHdyb3RlOg0KPg0KPiBSYW5kYWxsLA0KPg0KPiBUaGFua3MgZm9yIHlvdXIgYW5zd2VyLiAg
IEhvd2V2ZXIsIHRoaXMgaXMgYSBidWlsZCBzeXN0ZW0uDQo+IEdpdCBjbGVhbiAtZHhmIHdvdWxk
IGRlbGV0ZSBhbGwgdW50cmFja2VkIGZpbGVzIC0gbm90IGp1c3QgdGhlIGNvbmZsaWN0ZWQgb25l
cy4NCj4NCj4gV2UgbXVzdCBrZWVwIGFsbCB1bnRyYWNrZWQgZmlsZXMgdGhhdCB3b3VsZCBub3Qg
YmUgY29uZmxpY3RlZCBieSB0aGUgcHVsbC4NCj4gT3RoZXJ3aXNlLCB0aGUgcmVzdWx0IHdvdWxk
IGJlIG91ciBidWlsZCB3b3VsZCBuZWVkIHRvIGRvIGEgZnJlc2ggYnVpbGQgb2YgYWxsIG9iamVj
dHMgYW5kIGJ1aWxkIHRhcmdldHMgLSB0aG9zZSBhcmUgYWxsIHVudHJhY2tlZCBhcyB3ZWxsLg0K
PiBJbnN0ZWFkIG9mIHRoZSBkZXNpcmVkIGNhc2Ugb2YganVzdCBidWlsZGluZyB0aGUgY2hhbmdl
ZCBmaWxlcyBhbmQgdGhlaXIgcmVzdWx0YW50IHRhcmdldHMuDQo+DQo+IFdlIGp1c3QgbmVlZCB0
aGUgcHVsbCB0byBvdmVyd3JpdGUgYW55IHVudHJhY2tlZCBmaWxlcyB0aGF0IG1heSBleGlzdCBp
biBjb25mbGljdCB3aXRoIG5ld2x5IHRyYWNrZWQgZmlsZXMuDQo+DQo+IEkgc2VlIGdpdCBpcyB0
cm91Ymxlc29tZSBpbiB0aGlzIHNpdHVhdGlvbi4gICBFdmVyeSB0aW1lIGEgZGV2ZWxvcGVyIGFk
ZHMgYW4gdW50cmFja2VkIGZpbGUgdG8gdGhlIHJlcG8gLSByZWdhcmRsZXNzIG9mIHR5cGUsDQo+
IEl0IHdpbGwgcmVzdWx0IGluIGZhaWx1cmUgb2YgdGhlIHB1bGwuICAgQW5kIGEgZmFpbHVyZSBv
ZiB0aGUgYnVpbGQuDQoNCkl0IHNvdW5kcyB0byBtZSBsaWtlIHRoZSBjb3JyZWN0IHNvbHV0aW9u
IGhlcmUgaXMgdG8gYWRkIGJ1aWxkIGFydGlmYWN0cyB0byAuZ2l0aWdub3JlLCB3aGljaCB3aWxs
IHByZXZlbnQgY29tbWl0dGVycyBmcm9tIGFjY2lkZW50YWxseSB0cmFja2luZyB0aGVtIGFuZCBi
cmVha2luZyB5b3VyIGJ1aWxkYm90J3MgcHVsbC4NCg0KPg0KPg0KPiBUaGFua3MsDQo+DQo+IFNj
b3R0IFJ1c3NlbGwNCj4gTkNSIENvcnBvcmF0aW9uDQo+DQo+DQo+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+IEZyb206IFJhbmRhbGwgUy4gQmVja2VyIDxyc2JlY2tlckBuZXhicmlkZ2Uu
Y29tPg0KPiBTZW50OiBGcmlkYXksIFNlcHRlbWJlciAyNCwgMjAyMSAyOjAxIFBNDQo+IFRvOiBS
dXNzZWxsLCBTY290dCA8U2NvdHQuUnVzc2VsbDJAbmNyLmNvbT47ICdFbWlseSBTaGFmZmVyJyAN
Cj4gPGVtaWx5c2hhZmZlckBnb29nbGUuY29tPg0KPiBDYzogZ2l0QHZnZXIua2VybmVsLm9yZw0K
PiBTdWJqZWN0OiBSRTogcHVsbCBmYWlsZWQgLSB3aHkgc2hvdWxkIEkgcmVjZWl2ZSB0aGlzIG1l
c3NhZ2UuDQo+DQo+IE9uIFNlcHRlbWJlciAyNCwgMjAyMSAxOjM0IFBNIFNjb3R0IFJ1c3NlbGwg
d3JvdGU6DQo+ID4NCj4gPlRoYW5rcyBmb3IgeW91ciBhbnN3ZXIuICAgSXMgdGhlcmUgbm90IGFu
IG9wdGlvbiBvbiB0aGUgcHVsbCB0byBoYXZlIGdpdCB0byBvdmVyd3JpdGUgdGhlIGV4aXN0aW5n
IGZpbGVzPw0KPiA+DQo+ID4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+RnJvbTogRW1p
bHkgU2hhZmZlciA8ZW1pbHlzaGFmZmVyQGdvb2dsZS5jb20+DQo+ID5TZW50OiBGcmlkYXksIFNl
cHRlbWJlciAyNCwgMjAyMSAxOjI5IFBNDQo+ID5UbzogUnVzc2VsbCwgU2NvdHQgPFNjb3R0LlJ1
c3NlbGwyQG5jci5jb20+DQo+ID5DYzogZ2l0QHZnZXIua2VybmVsLm9yZw0KPiA+U3ViamVjdDog
UmU6IHB1bGwgZmFpbGVkIC0gd2h5IHNob3VsZCBJIHJlY2VpdmUgdGhpcyBtZXNzYWdlLg0KPiA+
DQo+ID4qRXh0ZXJuYWwgTWVzc2FnZSogLSBVc2UgY2F1dGlvbiBiZWZvcmUgb3BlbmluZyBsaW5r
cyBvciBhdHRhY2htZW50cw0KPiA+DQo+ID5PbiBGcmksIFNlcCAyNCwgMjAyMSBhdCAxMDowOCBB
TSBSdXNzZWxsLCBTY290dCA8U2NvdHQuUnVzc2VsbDJAbmNyLmNvbT4gd3JvdGU6DQo+ID4+DQo+
ID4+IEZpbGVzIG5vdCBwcmV2aW91c2x5IGluIGdpdCB3ZXJlIGFkZGVkIHRvIGdpdC4gICBXaHkg
c2hvdWxkIEkgaGF2ZSB0byBtYW51YWxseSBkZWxldGUgdGhlbT8NCj4gPj4gV2h5IGNhbiBnaXQg
cHV0IG5vdCByZXBsYWNlIHRoZW0/ICBUaGV5IHdlcmUgdW50cmFja2VkIGZpbGVzIHRoYXQgYXJl
IG5vdyB0cmFja2VkICBhbmQgc28gdGhlIGdpdCBjb3B5IGlzIGRlc2lyZWQuDQo+ID4+IFdlIGNh
bid0IGFsd2F5cyBrbm93IGFoZWFkIG9mIHRpbWUgd2hhdCBmaWxlcyBtYXkgaGF2ZSBiZWVuIGFk
ZGVkIGVsc2V3aGVyZS4NCj4gPg0KPiA+VG8gdHVybiBpdCBhcm91bmQgb24geW91LCB5b3UgY2Fu
J3QgYWx3YXlzIGtub3cgYWhlYWQgb2YgdGltZSB3aGF0IA0KPiA+ZmlsZXMgbWF5IGhhdmUgYmVl
biBhZGRlZCBlbHNld2hlcmUsIHNvIHlvdSBjYW4ndCBiZSBzdXJlIHRoYXQgeW91ciANCj4gPm5l
d2x5IGFkZGVkIHVudHJhY2tlZCBmaWxlIGxvY2FsbHkgd2lsbCBiZSBzYWZlIGZyb20gYmVpbmcg
b3ZlcndyaXR0ZW4gZHVyaW5nIGEgcHVsbC4gSG93IHVwc2V0dGluZyBpZiB5b3Ugc2luayAzMCBo
b3VycyBpbnRvIG5ld2xpYi5jcHAgYW5kIHRoZW4geW91ciB0ZWFtbWF0ZSBjaGVja3MgaW4gdGhl
aXIgb3duIG5ld2xpYi5jcHAsIGFuZCB5b3VycyBpcyBvdmVyd3JpdHRlbiB3aXRob3V0IGFza2lu
ZyB3aGVuIHlvdSBydW4gJ2dpdCBwdWxsJy4NCj4gPg0KPiA+WW91IG1pZ2h0IGhhdmUgc29tZSBs
dWNrIHdpdGggdGhlICctLWF1dG9zdGFzaCcgb3B0aW9uLCB3aGljaCB3b3VsZCANCj4gPmF0IGxl
YXN0IHByb21wdCB5b3Ugd2hldGhlciB0byBnZXQgcmlkIG9mIHRoaW5ncyB3aGVuIHRyeWluZyB0
byBtZXJnZSANCj4gPnRoZW0gYmFjayB0b2dldGhlciBkdXJpbmcgdGhlIGF1dG9tYXRpYyAnZ2l0
IHN0YXNoIHBvcCcgYXQgdGhlIGVuZC4gT3IgeW91IGNvdWxkIHJ1biAnZ2l0IGNsZWFuIC0tZm9y
Y2UnIHRvIGF1dG9tYXRpY2FsbHkgZGVsZXRlIGFueSB1bnRyYWNrZWQgZmlsZXMgeW91IG1pZ2h0
IGhhdmUgLSB5b3UgY291bGQgZXZlbiBhbGlhcyB5b3Vyc2VsZiBhIGNvbW1hbmQgbGlrZSAnZ2l0
IGRhbmdlcm91cy1wdWxsJyB3aGljaCBydW5zICdnaXQgY2xlYW4gLWYgJiYgZ2l0IHB1bGwnLg0K
PiA+DQo+ID4+DQo+ID4+DQo+ID4+IFdlIG5lZWQgdGhlIHB1bGwgdG8gd29yayBhdXRvbWF0aWNh
bGx5Lg0KPiA+Pg0KPiA+PiBlcnJvcjogVGhlIGZvbGxvd2luZyB1bnRyYWNrZWQgd29ya2luZyB0
cmVlIGZpbGVzIHdvdWxkIGJlIG92ZXJ3cml0dGVuIGJ5IG1lcmdlOg0KPiA+PiAgICAgICAgIFN0
YWdpbmcvQ0FEREFwcHMvQ0FERFVJSGVscGVyL1NvdXJjZS9SZWxlYXNlL0NBRERVSUhlbHBlci5l
eGUNCj4gPj4gICAgICAgICBTdGFnaW5nL0NBRERBcHBzL0NBRERVSUhlbHBlci9Tb3VyY2UvUmVs
ZWFzZV9Vbmljb2RlL0NBRERVSUhlbHBlci5leGUNCj4gPj4gICAgICAgICBTdGFnaW5nL0NBRERB
cHBzL0luc3RhbGxEcml2ZXJzUGFja2FnZS9SZWxlYXNlL0luc3RhbGxEcml2ZXJzUGFja2FnZS5l
eGUNCj4gPj4gICAgICAgICBTdGFnaW5nL0NvbW1vbi9OQ1JDb21tb25DQ0xpYi9Tb3VyY2UvUmVs
ZWFzZS9OQ1JDb21tb25DQ0xpYk1zZy5kbGwNCj4gPj4gICAgICAgICBTdGFnaW5nL0RldmljZXMv
TkZDL0VsYXRlY19SRklEUmVhZGVyL0Jpbi9EaXJlY3Rvci5leGUNCj4gPj4gICAgICAgICBTdGFn
aW5nL0RldmljZXMvTkZDL0VsYXRlY19SRklEUmVhZGVyL0Zpcm13YXJlL0FwcEJsYXN0ZXIuZXhl
DQo+ID4+ICAgICAgICAgU3RhZ2luZy9EZXZpY2VzL05GQy9FbGF0ZWNfUkZJRFJlYWRlci9GaXJt
d2FyZS9mbGFzaC5leGUNCj4gPj4gICAgICAgICBTdGFnaW5nL1V0aWxpdGllczY0L1NTUFNXRHJp
dmVySW5zdGFsbGVyL0Jpbi9ESUZ4QVBJLmRsbA0KPiA+PiAgICAgICAgIFN0YWdpbmcvVXRpbGl0
aWVzNjQvU1NQU1dEcml2ZXJJbnN0YWxsZXIvQmluL0RyaXZlckZvcmdlLnY0LjUuNC5leGUNCj4g
Pj4gICAgICAgICANCj4gPj4gU3RhZ2luZy9VdGlsaXRpZXM2NC9TU1BTV0RyaXZlckluc3RhbGxl
ci9Tb3VyY2UvUmVsZWFzZS9TU1BTV0RyaXZlcg0KPiA+PiBJbnN0YWxsZXIuZXhlDQo+ID4+DQo+
ID4+IFN0YWdpbmcvVXRpbGl0aWVzNjQvU1NQU1dEcml2ZXJJbnN0YWxsZXIvU291cmNlL1JlbGVh
c2UvU1NQU1dEcml2ZXINCj4gPj4gSW4NCj4gPj4gc3RhbGxlck1zZy5kbGwNCj4gPj4NCj4gPj4g
U3RhZ2luZy9VdGlsaXRpZXM2NC9TU1BTV1Rhc2tNZ3IvU291cmNlL1JlbGVhc2UvU1NQU1dUYXNr
TWdyLmV4ZQ0KPiA+DQo+ID5PciBiZXR0ZXIgeWV0LCB5b3UgY291bGQgYXZvaWQgY2hlY2tpbmcg
aW4gY29tcGlsZWQgYmluYXJpZXMgbGlrZSANCj4gPnRoZXNlIGFuZCBpbnN0ZWFkIGFkZCB0aGVt
IHRvIHlvdXIgLmdpdGlnbm9yZSwgdW5sZXNzIHlvdSByZWFsbHkgbWVhbiANCj4gPnRvIHVwZGF0
ZSB0aGVtIGV2ZXJ5IHRpbWUgc29tZW9uZSBtYWtlcyBzb21lIGNoYW5nZS4gV2hlbiBjaGVja2lu
ZyBpbiANCj4gPmJpbmFyaWVzLCB5b3Ugc2hvdWxkIGJlIGF3YXJlIG9mIHRoZSBhZGRpdGlvbmFs
IGRpc2sgb3ZlcmhlYWQgbmVlZGVkIHRvIGRvIHNvIGFuZCB0YWtlIGEgbG9vayBhdCBzb21lIG9w
dGlvbnMgR2l0IGhhcyB0byBtaXRpZ2F0ZSB0aGF0IG92ZXJoZWFkLCBsaWtlIHBhcnRpYWwgY2xv
bmUuIEhvd2V2ZXIsIGluIG1hbnkgY2FzZXMgdGhlIGVhc2llc3Qgd2F5IHRvIG1pdGlnYXRlIHRo
YXQgb3ZlcmhlYWQgaXMgdG8gc2ltcGx5IG5vdCBjaGVjayBpbiBiaW5hcmllcyB1bmxlc3MgeW91
IGFic29sdXRlbHkgbmVlZCB0aGVtIHRvIGJlIHZlcnNpb24gY29udHJvbGxlZC4NCj4gPg0KPiA+
LSBFbWlseQ0KPg0KPiBJZiB5b3UgYXJlIHNjcmlwdGluZyB0aGlzLCB0cnkgdXNpbmcgZ2l0IGNs
ZWFuIC1keGYgYW5kIGdpdCByZXNldCAtLWhhcmQgYmVmb3JlIHJ1bm5pbmcgdGhlIHB1bGwuICBU
aGF0IHdpbGwgY2xlYW4gdGhlIG9iamVjdHMgb3V0IG9mIHlvdXIgd29ya2luZyBkaXJlY3Rvcnku
DQo+DQo+IC1SYW5kYWxsDQo+DQo=
