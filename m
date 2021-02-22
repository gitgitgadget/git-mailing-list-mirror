Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0ADAC433DB
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 19:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C02D64E15
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 19:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbhBVTY7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 14:24:59 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:50244 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbhBVTUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 14:20:25 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MJIb6K049704
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 19:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-id : content-transfer-encoding
 : mime-version; s=corp-2020-01-29;
 bh=Ml7RlKb2/1g+3uP0OgjSHgqqv4bYwv3QtQ/QYrmxE5A=;
 b=vKT7g6b094Yu+JciDVxzL3pv600mipa9GJBoKSKsFTDptuJMJlCLV690NJbjPiEPwOgo
 +e3ldPOlC5xiLxCD9Kxqf2qK79wbUwBRoee0+Io/ZdEAwRKIL00oMUV4jC4bKdtCqBgL
 AFjn5rV5XiGBNENKNCusBwYw68ANTvawiUPuSQVBB2xSsH7nyMQ+ylYWyyKu/vF3W/80
 FomqkgyNpvByn+Sxkhuc8VE1QUUxHTm4QK13CXZYq8gDYi/RnPssW9Zu4gBU+sByxex9
 O/z5aqFF9vCfO8JSNw6ALr32kWeA2TWziETxIQ0lK3LItnUKJnl4kF6WY2avC34H7pZf mA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 36tqxbcxjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 19:19:39 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MJGIhU162769
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 19:19:39 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by aserp3030.oracle.com with ESMTP id 36v9m3nkca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 19:19:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cu0R8tf3O0LNDSQJpOEqZB4e3D5Vv8qp0KyeWbCfhImIB6gAT6o5ScqAlTsfIFujIjUP/waW6uKpGODJoCfQQ14aXkhOg8g7i1Q681oIGJEM+3tOjr1BwpMf5yF7PzK1t9rmF3D/1yIznQUM5UF4YL5VTBKpf5zFOhXoK0RjqvWKITpqrriPcfe6/O3WVBBIQAaodojnWPo6O+wKny1CiYeZPFEfieTgcyaxctupjbLJbuOpsL3AZoreJMdKW9ddZAZxXOuV/Q+Vv+g4X76u6OEhu0TFTsI2XGifrFhHcLz1ukNgiBYqLWNmtDx6mhbg39wu1nQ7NhtpD/HsFC2ZQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ml7RlKb2/1g+3uP0OgjSHgqqv4bYwv3QtQ/QYrmxE5A=;
 b=Di60YIWBBkmIDZe1shY9PVrzD5fUqtq9/Bp22bTgreoV2Wa8JCsUTmfIitaU2EpYEYlLstNlXWdfFjwDRR3TRFg0/C4bJdTMIEg2NQHm+qyIZcTg40iszIrWG6SfaIeYBhPUKfzGtzpNrqqUsMYCy5fVTMy+I8JhYNkq/Uu9leFtlP9Bc5Vd4u7ks14+WtdFgg7SG/9THZUzo1f1S/eQ956I7RiVcS5duqhDdQfBo95cajP+0Vxj3CceJfRh6tFQ52dTRGl6hQCswHU7Szaa735AQjOSHiQqoL9iweJxfRT1r9hNMRrBgaXQvhONF7s+0x5pps9GVyF5Nmhb50bw9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ml7RlKb2/1g+3uP0OgjSHgqqv4bYwv3QtQ/QYrmxE5A=;
 b=Vb691Qpy+Nj54tHsmkA3m5ZOciVdfvP6nEMB1gApvX2oMmFWkNV8NgLjYN/7CftAmJDPEsEANq3OgmW4uvlcdALPLVu/OKRviVldTTCphgQoKAtID5oxA2h7sVHT6tDLSMRhID9WFZodShp5VSxyhuvQRI5M6xR9lRxjJmfDZ0g=
Received: from BYAPR10MB2758.namprd10.prod.outlook.com (2603:10b6:a02:ba::12)
 by BYAPR10MB4086.namprd10.prod.outlook.com (2603:10b6:a03:129::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Mon, 22 Feb
 2021 19:19:36 +0000
Received: from BYAPR10MB2758.namprd10.prod.outlook.com
 ([fe80::4061:9843:3939:9cdd]) by BYAPR10MB2758.namprd10.prod.outlook.com
 ([fe80::4061:9843:3939:9cdd%7]) with mapi id 15.20.3868.033; Mon, 22 Feb 2021
 19:19:36 +0000
From:   Mark Nicholson <mark.j.nicholson@oracle.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: bug found in `git apply` sub-command
Thread-Topic: bug found in `git apply` sub-command
Thread-Index: AQHXCU+oQKTA9gB46EqHReUUJFjeeg==
Date:   Mon, 22 Feb 2021 19:19:36 +0000
Message-ID: <3d292e1d7c266eab456a5b9a0587efe702976533.camel@oracle.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [148.87.23.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8d14d1e-00a1-4dd9-e4d4-08d8d766cadb
x-ms-traffictypediagnostic: BYAPR10MB4086:
x-microsoft-antispam-prvs: <BYAPR10MB40869DB9C1CB4486445E8882A1819@BYAPR10MB4086.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LubQQgRfV8z8lplXhcuU4Wv4AZcFatLTVrz4sFov3WlTRayEVd7E4J0q0PBya23USX03byq80X9GCZNvZtcQizvoMYCj57LUaIvuE6PBn0bajM6LS7IC14zAxbxocorPANiOApXFZFOvAzWrvTHFT3HkTAuP1KayWGHMIAd+8M7r79zpWCzWRtPOHUcYgwlqFkoki8LqnN4WtmzrLrBRsGsDMc8Y7NqYzfsA4eWAWZyeHgdk/mJw5+EjPc0YsI2zq2VytZ6Ay23vz4D2DUI2wC47U1L1JyUmULcpqMhNxw7iePdhnF0AdoivRYQQOlnyuqAs+QLiVJyqTfnkbQViwV7xKXy9LANvSnNYO3jDySjAqw2plxsHyV8twmCqtVcS6QJQH2Omo044Nl4vxObdNSoRqrT3/Hw4+k1ba4wjRaFFcdcp8rA4/4fyhO3Bk7SqcUrt4saZ2a5MAlbSZfMmm9Bk5Y3D/JKYBfUjRkhlCs+C5hhvt6dJYc4Ep9dQYYlxKI/CJusNbzsYDUookEgI1O5AeyL7QC4zH0JtzxqOmxZfz7Xzq/f69+KB2sxh2jZf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2758.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(366004)(396003)(346002)(376002)(83380400001)(66446008)(66476007)(76116006)(8676002)(6506007)(5660300002)(66556008)(66946007)(316002)(71200400001)(2906002)(64756008)(2616005)(86362001)(36756003)(6512007)(26005)(6916009)(478600001)(186003)(6486002)(8936002)(81973001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UjVieFprQVpveVhreDBZTktpNG52cHFVN3ZGVjdycmZpbGR3MGFVZEV4ZWpq?=
 =?utf-8?B?amhsRG5NbmE2RWhLMyt2QkwxVUlpbTZmWVRWQm8yNVRKSHJaSkJBb1Fiam1w?=
 =?utf-8?B?T2JpODkveDhDWUo3eFFSd1IrTXpwN2Rkak5DRzJtcWwrQWpOTG5ISUlBN3Bu?=
 =?utf-8?B?T1ZuaUs2a0R4L2w3SjQ4NVFIMHFvRGFqdjhyWW04cEhDOHB0U3V5akhlTTlZ?=
 =?utf-8?B?NGJNVDNXS1BxOFBzdUJBNzdsMVJtSkYrbG96b25pUEprV2FES052eEZ0T0Ro?=
 =?utf-8?B?TVJINTRuS0JGK2Y3SjZOejN6TmYvQ3pDZDZXNlN0S05wenJHWUJVRWIrWjdv?=
 =?utf-8?B?dy9UdnFTTXdycGh3WXAxa204S2tNeWJGV0RDTmpuQzdlWVUrY200UzlJTGxT?=
 =?utf-8?B?VkpnQmMxVEVJczBwWkFmYVVmWHhoVWQ1bENwcXV3Z3NiNUl5bjEyRjFQc3ZR?=
 =?utf-8?B?czIza3pQbEtIcVBVRjNrYjVBc0tlRm1wb05vL3JTMGVQL0ZYSUNBUnZLVXZK?=
 =?utf-8?B?Y1FCbXkxTmxmV0tHU2dKMUVUV21OWTAvYVJER2s5ZDd5MmVlckJDM1BEUklp?=
 =?utf-8?B?cGFyZzJyYTZVUHZ1WVVuWXlJc0RNRFJ3MUkwS2NLTVp3T0hnNlREWVo3bkxL?=
 =?utf-8?B?NDBFamN2ZllacUhjZW8vdEd4bnIzSVlIY2UrQ0JjTkhBSnQxck9xUTNOV1NH?=
 =?utf-8?B?Z1JENXNVRG0zMVFpQTh5M3pRaDFrY1BCMnVqRlFobTRRd1VEVk9DWkNEY25h?=
 =?utf-8?B?SmxiRGVsa0gvaUhCTFpBRXgwM0t5cUhrMTNZbVplUGU5Uks0WEhnbDlDVU9x?=
 =?utf-8?B?K0RGSmVtZi9vSTBENWVlK3lQTVl3Yy9Uc0JBN3p4SEQyMDlCVlhMZDZyV2U3?=
 =?utf-8?B?U0haQk83Q1JXelY1T0pzdVJaOGhsSjBWYmJZeVhrTUpoTlBYSkpCTDJyR25v?=
 =?utf-8?B?V3VOQ0N6QlE0WHFxV1lxSEl1YnptdXRMNGFKeE8xL1pjMlRLRys3K2JPSFMy?=
 =?utf-8?B?NlFxeE1UN0pqM2J4dWNwZXFYVWRuWDNzMEN1WVpTSGE0K3F2RklTOVhXMWp6?=
 =?utf-8?B?aHROeWxKS2Z2dlpEOFd3dnZXa2NtbGhlbWh0akRNSVk2WDJUR0I0ZUR5TlpH?=
 =?utf-8?B?SFJ3U1B6WGZIc3lza21hUlBzTGxyTVo3c1NMZGdjTk5TM1FEMmhJN0w0TE9R?=
 =?utf-8?B?Ukx2N1BVaFJZOXdkZDk4VzBwVFV2UmpFeEFpaGNZR3JVQS8xR054aU1NQVRo?=
 =?utf-8?B?ZG1ma1NFcWNqSFFqWUo5UTBOZUl2NXpCOFIwc2UxNnZwdUVrQmFhK3VadGZm?=
 =?utf-8?B?VC8wdjFqL1RqaE1UQWlRdkt0N08wSzRJRHBkUVhLQnF2QmxDbTIxd0d4YnZM?=
 =?utf-8?B?L3lPeWhGek00Sjkxc0o0V2hKRjNsNXU3TitYZnZjVzJrRFM4cUdzbHA5UTJY?=
 =?utf-8?B?Vm5IdmJKU2tHQU5LWHpTNGhzQlZkZHBkWk0zZTJGNUR6Q0ZGQnlmRndmUzBq?=
 =?utf-8?B?NlowOElyamU0VDJYMHJNRC9ZRUZic1AyTzNSVG1Dd1RwTFRJdm1BYXBnc3k3?=
 =?utf-8?B?bVhXSHN5TUcvbk1MdjlIUnBuaGpES2NXZlAySlFEY2diRTRCL2VWY1V1UnV6?=
 =?utf-8?B?TGRLSkV5a0FERDlheUdTbVRGUVBna2s2bnVBL1BJSzJZU0MyY0lCeFlxY3VS?=
 =?utf-8?B?cUp2dXlreGtxemFkVE1EWUhLYWk0NXAvZktLQlRlbm1iWExQY2EyaXFnWWtN?=
 =?utf-8?Q?7PzYAW1MPZfTKSEl6qdG6G1wy65G+aCwqoTCavp?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C8FB1E906634645A967A96E1896D21B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2758.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d14d1e-00a1-4dd9-e4d4-08d8d766cadb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2021 19:19:36.1550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2lUtHz1E9iJjgKQaIkvQ5lvsNBhJDSNLLnZ1X8roAv62nJS5XP6G7dWqgVnUBDPNpCn8rE3OpOIUxMMhHO0pqPo9MBkvMYptv275GSV25JE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB4086
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9903 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220170
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9903 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1011 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220170
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhhbmsgeW91IGZvciBmaWxsaW5nIG91dCBhIEdpdCBidWcgcmVwb3J0IQ0KUGxlYXNlIGFuc3dl
ciB0aGUgZm9sbG93aW5nIHF1ZXN0aW9ucyB0byBoZWxwIHVzIHVuZGVyc3RhbmQgeW91ciBpc3N1
ZS4NCg0KV2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3RlcHMgdG8g
cmVwcm9kdWNlIHlvdXIgaXNzdWUpDQoNCjEuIENsb25lIHRvcnZhbGRzL21hc3Rlcg0KDQoyLiBD
aGVja291dCBhIGJyYW5jaCBhdCB0aGlzIGNvbW1pdCAodGhlIGNvbW1pdCBCRUZPUkUgdGhlIHBy
b2JsZW1hdGljIG9uZSB0bw0Kc3RhZ2UgdGhlIHBhdGNoIHNvIGl0IHdvdWxkIHdvcmspOg0KICAg
ICAgICAzZTBkZTI3MWZmZjc3YWJiOTMzZjFiNjljMjEzODU0YzNlZGE5MTI1DQoNCjMuIEdldCBh
ICdnaXQgZm9ybWF0LXBhdGNoJyBvZiB0aGlzIGNvbW1pdDoNCiAgICAgICAgY2NmNzQxMjhkNjZj
ZTkzNzg3NjE4NGFkNTVkYjJlMDI3NmFmMDhkMw0KICAgICAgICAodGhpcyBpcyB0aGUgY29tbWl0
IHdoaWNoIGNhdXNlcyB0aGUgZmF1bHQhKQ0KDQogICBJIGRpZDoNCiAgICAgIGdpdCBmb3JtYXQt
cGF0Y2ggM2UwZGUyNzFmZmY3N2EuLmNjZjc0MTI4ZDY2Y2U5DQogICBhbmQgaXQgcHJvZHVjZWQN
CiAgICAgIDAwMDEtc2NoZWQtdG9wb2xvZ3ktQXNzZXJ0LW5vbi1OVU1BLXRvcG9sb2d5LW1hc2tz
LWRvbi10LS5wYXRjaA0KDQo0LiBUcnkgdG8gYGdpdCBhcHBseWAgdGhlIGZvcm1hdC1wYXRjaCBn
ZW5lcmF0ZWQ6DQogICAgZ2l0IGFwcGx5IDAwMDEtc2NoZWQtdG9wb2xvZ3ktQXNzZXJ0LW5vbi1O
VU1BLXRvcG9sb2d5LW1hc2tzLWRvbi10LS5wYXRjaA0KDQoNCg0KDQpXaGF0IGRpZCB5b3UgZXhw
ZWN0IHRvIGhhcHBlbj8gKEV4cGVjdGVkIGJlaGF2aW9yKQ0KDQpJIGV4cGVjdGVkIGl0IHRvIGFw
cGx5IHRoZSBwYXRjaCBjbGVhbmx5Lg0KQUZBSUNULCBpdCBpcyBhIFZBTElEIHBhdGNoIHdoaWNo
IGlzIGFscmVhZHkgY29tbWl0dGVkIHRvIExpbnV4Lg0KDQoNCg0KV2hhdCBoYXBwZW5lZCBpbnN0
ZWFkPyAoQWN0dWFsIGJlaGF2aW9yKQ0KDQoNCkl0IGdpdmVzIG1lIHRoZSBlcnJvciBtZXNzYWdl
Og0KDQplcnJvcjogcGF0Y2ggZnJhZ21lbnQgd2l0aG91dCBoZWFkZXIgYXQgbGluZSA1ODogQEAg
LTQ2NSw2ICs0NjUsOSBAQCB2b2lkDQp1cGRhdGVfc2libGluZ3NfbWFza3ModW5zaWduZWQgaW50
IGNwdWlkKQ0KDQoNCg0KV2hhdCdzIGRpZmZlcmVudCBiZXR3ZWVuIHdoYXQgeW91IGV4cGVjdGVk
IGFuZCB3aGF0IGFjdHVhbGx5IGhhcHBlbmVkPw0KDQpJdCBzaG91bGRuJ3QgcmFpc2UgYW4gZXJy
b3Igb24gYXBwbHlpbmcgdGhpcyBwYXRjaDsgaXRzIGNvbXBsYWluaW5nIGFib3V0IGENCnBhdGNo
LWZyYWdtZW50IF9pbnNpZGVfIHRoZSBtZXNzYWdlLg0KDQoNCg0KQW55dGhpbmcgZWxzZSB5b3Ug
d2FudCB0byBhZGQ6DQoNCk15IGN1cmlvc2l0eSB3YXMgcmFpc2VkIHNpbmNlIHNpbXBseSBkb2lu
ZzoNCg0KICAgZ2l0IGFtIDAwMDEtc2NoZWQtdG9wb2xvZ3ktQXNzZXJ0LW5vbi1OVU1BLXRvcG9s
b2d5LW1hc2tzLWRvbi10LS5wYXRjaA0KDQphcHBsaWVzIF9leGFjdGx5XyB0aGUgc2FtZSBwYXRj
aCB3aXRob3V0IGFueSBndWZmLg0KDQpJIHdvdWxkIF9yZWFsbHlfIGV4cGVjdCBgZ2l0IGFtYCBh
bmQgYGdpdCBhcHBseWAgdG8gd29yayBpbiBleGFjdGx5IHRoZSBzYW1lIHdheSwNCmV4Y2VwdCBm
b3IgdGhlIGV4cGVjdGVkIGRpZmZlcmVuY2Ugb2YgdGhlIGFjdHVhbCBjb21taXQuICBUaGUgInBh
dGNoaW5nIiBwYXJ0DQpzaG91bGQgd29yayBpZGVudGljYWxseS4NCg0KSSB0ZXN0ZWQgc29tZSBv
dGhlciBiZWhhdmlvdXJzIGFuZCBgZ2l0IGNoZXJyeS1waWNrYCBvZiB0aGUgb2ZmZW5kaW5nIGNv
bW1pdA0Kd29ya3MgZmluZS4gKEFsdGhvdWdoLCBJIHN1c3BlY3QgdGhhdCB0aGlzIGRvZXMgbm90
IGFjdHVhbGx5ICJwYXJzZSIgdGhlIGNvbW1pdA0KbWVzc2FnZSwgc28gcHJvYmFibHkgbm90IGFu
ZCBhcHBsZXMtdG8tYXBwbGVzIGNvbXBhcmlzb24uKQ0KDQoNCkkgbG9va2VkIGF0IHRoaXMgcGF0
Y2ggYW5kIGluIHRoZSAibWVzc2FnZSIgc2VjdGlvbiwgaXQgY29udGFpbnMgYSBwYXRjaC0NCmZy
YWdtZW50LiAgTW9yZW92ZXIsIHRoYXQgcGF0Y2gtZnJhZ21lbnQgaXMgbGVmdC1qdXN0aWZpZWQu
DQoNCkEgc2ltcGxlIGZpeCB0byBhdm9pZCB0aGlzIHByb2JsZW0gaXMgaW5kZW50aW5nIHRoZSBt
ZXNzYWdlLWVtYmVkZGVkIHBhdGNoLQ0KZnJhZ21lbnQgYnkgYSBjb3VwbGUgc3BhY2VzLg0KDQpJ
dCBhcHBlYXJzIHRoYXQgYGdpdCBhcHBseWAsIGFzIGl0IGlzIHBhcnNpbmcgdGhlIG1lc3NhZ2Ug
dHJpZ2dlcnMgb24gdGhlIHBhdGNoLQ0KZnJhZ21lbnQgSU5TSURFIHRoZSBtZXNzYWdlIHNlY3Rp
b24uICBDb21wYXJhdGl2ZWx5LCBgZ2l0IGFtYCBkb2VzIE5PVCB0cmlnZ2VyDQphbmQgYm90aCBw
YXRjaGVzIGFuZCBjb21taXRzIGl0IHdpdGhvdXQgaXNzdWUuDQoNCg0KUGxlYXNlIHJldmlldyB0
aGUgcmVzdCBvZiB0aGUgYnVnIHJlcG9ydCBiZWxvdy4NCllvdSBjYW4gZGVsZXRlIGFueSBsaW5l
cyB5b3UgZG9uJ3Qgd2lzaCB0byBzaGFyZS4NCg0KDQpbU3lzdGVtIEluZm9dDQpnaXQgdmVyc2lv
bjoNCmdpdCB2ZXJzaW9uIDIuMzAuMA0KY3B1OiB4ODZfNjQNCm5vIGNvbW1pdCBhc3NvY2lhdGVk
IHdpdGggdGhpcyBidWlsZA0Kc2l6ZW9mLWxvbmc6IDgNCnNpemVvZi1zaXplX3Q6IDgNCnNoZWxs
LXBhdGg6IC9iaW4vc2gNCnVuYW1lOiBMaW51eCA1LjEwLjE1LTE3Mi5jdXJyZW50ICMxIFNNUCBQ
UkVFTVBUIEZyaSBGZWIgMTIgMTY6MzU6NTcgVVRDIDIwMjENCng4Nl82NA0KY29tcGlsZXIgaW5m
bzogZ251YzogOS4zDQpsaWJjIGluZm86IGdsaWJjOiAyLjMxDQokU0hFTEwgKHR5cGljYWxseSwg
aW50ZXJhY3RpdmUgc2hlbGwpOiAvYmluL2Jhc2gNCg0KDQpbRW5hYmxlZCBIb29rc10NCg0K
