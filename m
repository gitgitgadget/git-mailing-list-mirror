Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395CEC433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 20:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2260D61241
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 20:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348509AbhIXUv1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 16:51:27 -0400
Received: from mx0a-00209e01.pphosted.com ([148.163.148.55]:11662 "EHLO
        mx0a-00209e01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348503AbhIXUvP (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Sep 2021 16:51:15 -0400
Received: from pps.filterd (m0131214.ppops.net [127.0.0.1])
        by mx0b-00209e01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18OEbr7H014686;
        Fri, 24 Sep 2021 16:49:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ncr.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pod1119;
 bh=4DWVM9FrtND0LYYpO8x1w9MVOfgX7SE4bB5jyYbLNtk=;
 b=xb1aVed16UB6BSVlKpzVCNvZjJLUeXzBuNmr3BPu99aymsNA9E2lZW/8FhFhQZvzc7ED
 fHo+nlr/g5US5bl4NG75PB6wum2dqoml+b/BgdXfPomMTsfFa8LiCy/42WsK/nW1Oswp
 y/g4MxFAZ5rw/TKTogAEZdAlY53Oa7+EqV+lQ9sdb5ZJ6GH1Wx7ztQ2fdNBCnJr+9W9C
 Say4pAhBlTgsJxRapFDGzTkfOIcTfPxMkXMnLaGihDmQqXpysH0WNo4WBXqK9p7eVlcZ
 D05qNM5G6rMWEYig0uLL+64vx+Kby7Y6gcZ6PR0YHnVEseV4KAdlNRzPbk1erXWrwXII tA== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by mx0b-00209e01.pphosted.com with ESMTP id 3b93f35mc3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Sep 2021 16:49:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdqjR+tOU07QdTIEarF+XcoLXNGjNS1c8KPpcBDJQiBWu49OUlXXaWV03R7LOpJrVrRiOyDpnAIzBQDH5hl8SAfCPkmhcw2jjQqK9f/z2X/RJkHH5T078RMMjjvifJliOndUQ3R+jyv/HgoV7iSq0k912xlNSiSQGhWirOzFlFwycyz9t/okRd6Bz/49WmJjrpte8lKjXwtR3Evmuzpg2Zw4U6sHlHVYIC/IH6IWYb9v4GnzazISQu+afMHspv0dL+BqbDQ4+TxB5NOcbx0sJdRlHh6RNi4RW1tN9oMEi9PSsVeGEXOZLWfJZFJYZNQpLP3GievQhGsS+f85zktyJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=4DWVM9FrtND0LYYpO8x1w9MVOfgX7SE4bB5jyYbLNtk=;
 b=AggjJTxKdLDa7ZGtRQg6GD9coDoYRimjhtL0nK4i40zDF6huzbna+d2fvAgD+yWXgBzcvL2aPd7S8EIOdmOT9va0NPqiqMVJP5ah5Vf+yDwmwhMxJDY3xYm3Qq5tbzLHyK+55OiXtj5AV7OZL0ApAatyPZ81WFKpHbwlaZpEGKUZ4dm4x6DCs5/bHkdZ6vveDPk7Ca7+0j7WW6PL01AZ+7yZgH9sXlZnAy2KStGM7pS037OqRHdvr2hWUJcI3P3xGF3JN0liwhEqIgecOZbYcJ/+j0bXJuLb9WPVgsHl7y51CmTa3PFtJlOeykJyLaPvCB7NwGAnbePRQOQzC/f5yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ncr.com; dmarc=pass action=none header.from=ncr.com; dkim=pass
 header.d=ncr.com; arc=none
Received: from BN6PR15MB1426.namprd15.prod.outlook.com (2603:10b6:404:c4::18)
 by BN7PR15MB2483.namprd15.prod.outlook.com (2603:10b6:406:87::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Fri, 24 Sep
 2021 20:49:19 +0000
Received: from BN6PR15MB1426.namprd15.prod.outlook.com
 ([fe80::fdf3:7fad:62b4:e015]) by BN6PR15MB1426.namprd15.prod.outlook.com
 ([fe80::fdf3:7fad:62b4:e015%12]) with mapi id 15.20.4544.014; Fri, 24 Sep
 2021 20:49:19 +0000
From:   "Russell, Scott" <Scott.Russell2@ncr.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
CC:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Emily Shaffer' <emilyshaffer@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: pull failed - why should I receive this message.
Thread-Topic: pull failed - why should I receive this message.
Thread-Index: AdexUt9vq4ww6wDrT/SkOsyNHqWUqQAFrpQAAAAqpgAAAPPngAAA0WowAAN6l4AAADvH4AABOyOAAAAawOA=
Date:   Fri, 24 Sep 2021 20:49:19 +0000
Message-ID: <BN6PR15MB14269C590D004F7E1B9BE448CBA49@BN6PR15MB1426.namprd15.prod.outlook.com>
References: <BN6PR15MB1426A342CBA9D993C0C49E55CBA49@BN6PR15MB1426.namprd15.prod.outlook.com>
 <CAJoAoZ=DuqHe2brN8Y2Ts0_afEhUNrdasRBb1O8HHomLKRJ4PA@mail.gmail.com>
 <BN6PR15MB14261D1A350398C0C26793E1CBA49@BN6PR15MB1426.namprd15.prod.outlook.com>
 <000401d7b16e$17ea02d0$47be0870$@nexbridge.com>
 <BN6PR15MB14262C7036B3C792CCE861D8CBA49@BN6PR15MB1426.namprd15.prod.outlook.com>
 <YU4vG0TI+BkK6xiW@camp.crustytoothpaste.net>
 <BN6PR15MB1426EBF10C9E8634EF317DDBCBA49@BN6PR15MB1426.namprd15.prod.outlook.com>
 <YU4475ZbWfnvKomP@camp.crustytoothpaste.net>
In-Reply-To: <YU4475ZbWfnvKomP@camp.crustytoothpaste.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Enabled=true;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_SetDate=2021-09-24T20:48:34Z;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Method=Standard;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Name=dc233488-06c6-4c2b-96ac-e256c4376f84;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_SiteId=ae4df1f7-611e-444f-897e-f964e1205171;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_ActionId=da2839e1-a3c1-423a-bdf0-89860777556d;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_ContentBits=0
authentication-results: crustytoothpaste.net; dkim=none (message not signed)
 header.d=none;crustytoothpaste.net; dmarc=none action=none
 header.from=ncr.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5bca22de-0824-4ece-2238-08d97f9cc7d3
x-ms-traffictypediagnostic: BN7PR15MB2483:
x-microsoft-antispam-prvs: <BN7PR15MB2483912367E195843347D211CBA49@BN7PR15MB2483.namprd15.prod.outlook.com>
x-from-ncr-tenant: Processed
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O0K0PeDyBHpzkUP/nX2QbjMvrYfQ/G/Ioml3Lf3zD702pSZuuPc2oSQ4yjo03jrMzfPnE6OCMkIApKIa3gkyymwPST0n+8kW3Rf6gfCZmkphs6RcmmHpYreUMMMjOXePQuG1KMAfMz2S6MczsjeytF5eepWAgL6bn6+l1EHlh36srkOWYQmopUComFTqHu2fyN+smDyFfxpIm2dfOedPXNb0yxrvCp30XeT8hCnTRaeRTgpGFtKFZVyeEJP4O4KlEYnyWuEBzwRxCXcKt07SBsDAeWPlYOXRhMBR33rxRs0xzTdcd5msWr9kVUHmmItUwzDbqf1yxaCRdcJGgr9OHT6FrAc8RnU4VQ9esMbWSbRFrBEStrnXzr1TENw29tRCPilajvixx7JTABPWZn/1XqLwBcGXtKL2UQZrvZh7xfVVZMo6N6+t+xDNbkhqMxdkp6xd/RIhCqRKWX+CKwziuSvBKp9NiyV0FKyRApLOmTseLDW6vl9KusrYKNqgUvstfAwiQr4XaA0zfFCrPp6jCasGfUMJd4n8UufoVS89YiNTxCqgNxFZTl29w5/cB8oh/7g3UoWx6MzfWBm1OHHEmsPWB+LEXc4tMjdVYrSue22XxbEZpaYHtcvDUjFF1P4lXBXKuZdZZSHw5X1VNbNzfNDc+YeyGT/ynpEEQINHX/w/eT3B9ALLXFJ1vGXNSao77VokKfmlAjqAWoiMitNR8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR15MB1426.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(66446008)(76116006)(7696005)(66556008)(8676002)(316002)(26005)(508600001)(52536014)(53546011)(33656002)(15650500001)(6916009)(66946007)(38070700005)(6506007)(64756008)(66476007)(186003)(5660300002)(2906002)(54906003)(4326008)(122000001)(8936002)(71200400001)(86362001)(38100700002)(55016002)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2VIUTR2cCtCdEdsU2hZZTVEK3BLUG44MXorc2pWbWlHSzBxbDJCMFRPMnJN?=
 =?utf-8?B?N1lVWmhRSlN6MXRGMXhrRkk5T2JDcHY1NENjMDM4aW1RY0s2Q2YyejFNNnRn?=
 =?utf-8?B?eXhsN3ZGaWk1UXZ2VnJDUnB4ZGJxaFhLRXVZa2xxQTQzeGwxa25vaVBVRlVD?=
 =?utf-8?B?anNXUUdobUtxdXFlRWc1NGZRa0t2TlZjc1M2RkZGMDZyNXhRb2NpSVNjc1dF?=
 =?utf-8?B?YW0vYUxIcXNNK2RtTFI1ZkxLMGZ3dlc5NzVsd3FMdmVzQ1k1WWwrd1EzUEpZ?=
 =?utf-8?B?a2F2SmpZUGFYMVIxNXpFb1Jtb2t3YUpJQ1RoZFFEVVpVZWs0N1h1M0JjY3dK?=
 =?utf-8?B?VzBNVWlGaHpHTWdPNU04Y2FTcHlmTjM0ZG5waFpON2V1ZWFaK2Q0QXJWMUpV?=
 =?utf-8?B?Q1QzS1ZPU0JsS25XY0tkeWI2TEI0YnNGbnRBbkZITkE2ekt6ZGdzb25hRjNx?=
 =?utf-8?B?Y2NTa04yT2Yxb2xTWmovWDMyNEUzTThmVlVoVUVvOEkyTFE5TExQNXJQMnBO?=
 =?utf-8?B?N0FRZ0F5eGtzVVNKWjZtZDJtblppeFRabTUvbWc4VGMwWGJGOU5lcWxmVmRz?=
 =?utf-8?B?eVpvSWRSSUgxbTJFRXhEK2ZrWGhjU3QvS3RTbTRQYlhFQ3FJVXdaT2RHYS9P?=
 =?utf-8?B?L0l0cmtianNmeWh0NDR6Nk5hbkR2dWFuZC9hZEswdGtPbFVOL1dpK3lBZ0J5?=
 =?utf-8?B?T2p3Mng5ZjZ5RURaU1NNU29CVm45MHNUMitwUHFqai9pU3FWU3JGeDhtYlU1?=
 =?utf-8?B?RmFHNzZlSkJhaDE1dVQ2WVRnMEUxaW0wL2o2M3Nuejk5V0hZTGpxRENORUxx?=
 =?utf-8?B?RHZyRERKeGRUc3VwRnlxUnUvTTZQa2VjZDJ0YWlKY3liY0gyRWFjSzFkc3h5?=
 =?utf-8?B?WmYvVVk5dGpjU2gzOTR6N201MUt6T2Y3eGdxY3NDM0NQUHViSUNvWW50VXhx?=
 =?utf-8?B?Um0vUGxsajR5eTFWRVdCcExLQ0pBa250UVFPMWhYYVI4MFVGd0tZOEJsM0l0?=
 =?utf-8?B?MC8rZ2lnc09tdWR2OUNISlJYcXF6Y21aWHhKRytlaVZYclRSVHJ2WlNXMXJu?=
 =?utf-8?B?UFFUOW9uQVVabytnc255NzV4Ti9qaEpYVHRhaUNKNDdMaXdTdUV1R0E2eHlY?=
 =?utf-8?B?a0pzRUh1UmtNQkpzR2hxT1VHaXJHNlplOTZTTmRmUEhqbk5BclRGeEZiSUtx?=
 =?utf-8?B?R2pjWkRHa1dDalBCY2hhMGF5ZGM1ZXhqdTIrZGtGQUF1K1c0QmpXNFkzNG44?=
 =?utf-8?B?MXYzNE5sSS9RYXYvWUF2N1hQdDJDNjNHbC8vdE9kclRMQTNWeGtSSHFudnh2?=
 =?utf-8?B?dEZDR2VqZmYxU0p0VG0zc0pheElQZmZqcmwxVWJSdFJ6WWNvZTVrb2tPQURu?=
 =?utf-8?B?bXhsYUNHSDJ2dHhQZFE3Z2VyS1IzenZ3Z1ZHMWIrdjlnMmxFZCsvbXJuTERS?=
 =?utf-8?B?bGFpWmZITVc3WklFWGxIWjkvekx2cnBlOU9Mb0N0TVdEaklubUUweDJoUDhT?=
 =?utf-8?B?emthanFKR3dEa0dBWVpwa1hvVkZtbURaczloeERhaXJWR01zOVVibUVWWlBP?=
 =?utf-8?B?RVEvTzlSUnAvbWxxUlZyNGVuL0J3eVU4OU9GY1drYUJpMFFsK01OcURxNkwy?=
 =?utf-8?B?KzRZK2RZSk56TDNOUXFVNllPNjNjeHlPWGR0RmswekdyMlIwU3BEcXRqdDBC?=
 =?utf-8?B?M21sekRYcWNpQWYvb0lxSURaelpiTUpOUTZySDZrZTlNS2Z1NnE1SUJzcTIr?=
 =?utf-8?Q?9lKXLU6V5MK7hgC0NUZKkowQN2DgawgOX2UF+j2?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ncr.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR15MB1426.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bca22de-0824-4ece-2238-08d97f9cc7d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2021 20:49:19.2075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ae4df1f7-611e-444f-897e-f964e1205171
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5VWx6MYBdW60FQRdU2CJUHnEFSv/yoT/R+ksUnl62S7GBAatHdL+6mwGgeLF2gy46rlM/WeXFyJZ9eIVf5tyLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR15MB2483
X-Proofpoint-ORIG-GUID: _RpOhdi0jHcI4q6dXUP7qYkEDAPlkkk8
X-Proofpoint-GUID: _RpOhdi0jHcI4q6dXUP7qYkEDAPlkkk8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-24_05,2021-09-24_02,2020-04-07_01
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhhbmtzIEJyaWFuLCAgDQoNCkkgZXhwZWN0IHRoYXQgbWF5IHdlbGwgc29sdmUgdGhlIGlzc3Vl
LiAgSSB3aWxsIHRyeSBpdC4gDQoNCg0KVGhhbmtzLCANCg0KU2NvdHQgUnVzc2VsbA0KTkNSIENv
cnBvcmF0aW9uwqANCiAgICAgIA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTog
YnJpYW4gbS4gY2FybHNvbiA8c2FuZGFsc0BjcnVzdHl0b290aHBhc3RlLm5ldD4gDQpTZW50OiBG
cmlkYXksIFNlcHRlbWJlciAyNCwgMjAyMSA0OjQ2IFBNDQpUbzogUnVzc2VsbCwgU2NvdHQgPFNj
b3R0LlJ1c3NlbGwyQG5jci5jb20+DQpDYzogUmFuZGFsbCBTLiBCZWNrZXIgPHJzYmVja2VyQG5l
eGJyaWRnZS5jb20+OyAnRW1pbHkgU2hhZmZlcicgPGVtaWx5c2hhZmZlckBnb29nbGUuY29tPjsg
Z2l0QHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDogUmU6IHB1bGwgZmFpbGVkIC0gd2h5IHNob3Vs
ZCBJIHJlY2VpdmUgdGhpcyBtZXNzYWdlLg0KDQoqRXh0ZXJuYWwgTWVzc2FnZSogLSBVc2UgY2F1
dGlvbiBiZWZvcmUgb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KDQpPbiAyMDIxLTA5LTI0
IGF0IDIwOjEzOjE1LCBSdXNzZWxsLCBTY290dCB3cm90ZToNCj4gQnJpYW4sDQo+IA0KPiBZb3Ug
YXJlIGNvcnJlY3QuICBUaGlzIGlzIGEgYnVpbGQgc3lzdGVtLiAgQW5kIHlvdXIgcmVzcG9uc2Vz
IGFyZSB0aGUgbW9zdCB1c2VmdWwgc28gZmFyLg0KPiANCj4gImdpdCBmZXRjaCBvcmlnaW4iIC0g
b2theQ0KPiANCj4gRm9yIHRoaXMgb25lLCBpcyB0aGVyZSBhIHdheSB0byBzcGVjaWZ5IGp1c3Qg
dGhlIGhlYWQ/ICAgSSBqdXN0IHdhbnQgdGhlIGxhdGVzdCAtIGFuZCBkb24ndCB3YW50IHRvIHRy
eSB0byBmaWd1cmUgb3V0IHdoYXQgJ1JldmlzaW9uJyBtYXkgYmUuDQo+IA0KPiAiZ2l0IGNoZWNr
b3V0IC1mIFJFVklTSU9OIg0KDQpQcmV0ZW5kIHRoZSBicmFuY2ggeW91IHdhbnQgdG8gb3BlcmF0
ZSBvbiBpcyBjYWxsZWQgIm1haW4iLiAgQXNzdW1pbmcgdGhhdCB5b3VyIHJlbW90ZSBpcyBvcmln
aW4sIHRoZW4geW91IGNhbiB3cml0ZSAiZ2l0IGNoZWNrb3V0IC1mIG9yaWdpbi9tYWluIiwgb3Is
IGlmIHlvdSB3YW50IHRvIGJlIG1vcmUgcHJlY2lzZSwgImdpdCBjaGVja291dCAtZiByZWZzL3Jl
bW90ZXMvb3JpZ2luL21haW4iLiAgVGhhdCB3aWxsIGNoZWNrIG91dCB3aGF0ZXZlcidzIGF0IHRo
ZSB0aXAgb2YgbWFpbi4NCg0KTm90ZSB0aGF0IGRvaW5nIHRoYXQgd2lsbCByZXN1bHQgaW4gYSBk
ZXRhY2hlZCBIRUFELCB3aGljaCBwcm9iYWJseSBkb2Vzbid0IG1hdHRlciBmb3IgeW91LiAgSW4g
Y2FzZSBpdCBkb2VzLCB5b3UgY2FuIGNoZWNrIG91dCB5b3VyIGxvY2FsIGJyYW5jaCB0byBtYXRj
aCBpdCBieSBkb2luZyAiZ2l0IGNoZWNrb3V0IC1mIC1CIG1haW4gcmVmcy9yZW1vdGVzL29yaWdp
bi9tYWluIi4NClRoYXQgd2lsbCBtYWtlIHN1cmUgeW91J3JlIG9uIGEgYnJhbmNoIGNhbGxlZCAi
bWFpbiIgYW5kIHdpbGwgcmVzZXQgaXQgdG8gd2hhdGV2ZXIgd2FzIG9uIHRoZSB0aXAgb2YgbWFp
biB3aGVuIHlvdSBkaWQgeW91ciBmZXRjaC4gIElmIHlvdSB3YW50ZWQgeW91ciBsb2NhbCBicmFu
Y2ggdG8gYmUgY2FsbGVkICJkZXYiIGluc3RlYWQsIHlvdSBjb3VsZCBkbyB0aGlzOg0KDQogIGdp
dCBjaGVja291dCAtZiAtQiBkZXYgcmVmcy9yZW1vdGVzL29yaWdpbi9tYWluDQotLQ0KYnJpYW4g
bS4gY2FybHNvbiAoaGUvaGltIG9yIHRoZXkvdGhlbSkNClRvcm9udG8sIE9udGFyaW8sIENBDQo=
