Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E45C432BE
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 18:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAC4D60F91
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 18:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbhHMSzg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 14:55:36 -0400
Received: from mx0b-00209e01.pphosted.com ([148.163.152.55]:3414 "EHLO
        mx0b-00209e01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229554AbhHMSzf (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 13 Aug 2021 14:55:35 -0400
X-Greylist: delayed 3478 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Aug 2021 14:55:35 EDT
Received: from pps.filterd (m0115756.ppops.net [127.0.0.1])
        by mx0b-00209e01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17DIk093001571
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 14:54:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ncr.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pod1119;
 bh=qQ6idCMoHb0deEvrn84y1zpRJTQz0jdrtt6m75Fl6Bc=;
 b=sCGU/hIpULHWBP6xiW0VpiiPkzxZTaC6FulsjE9s1yh0MOQ+0uDAt2oBAzkFhl7hUQjA
 f/KmBdDWjP5gPK+qqu5ur6RC4zAvl9bnJHUFq0Uyfh+x++Yf6cieAWGHO8MiQYMq6oWQ
 mFnGcaUngTnxhMFm/Hs3zm/608Q0Y0IvgnPHJGpommcMpyWZmRnfwEpTLwaO03f+sp1R
 1fef5FKFGOrNgOqhhiI71P/ssB0Y7vC/GgSZk7vrXHungibYAtISVB5m1L1Kxvl+26WQ
 pVmTXIrO8esrzn863AjfSpvd+88EbosYXbwAtsMucajmXGFHKxt/CnXkvMN6NnWEG6hd Nw== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by mx0b-00209e01.pphosted.com with ESMTP id 3acy1s3vvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 14:54:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dnGFWN3FjHcaMqZgoWdrBfFB4M4vyjIe4eKqLTd5zdIoDPqpRSKky3iJIX2Y838xQrcqF2xdN1KkJV1L8Mfqtx30kiIqj77gIKWUuxzg7gZCOgveZsB0FQ0csuu8XfI1cr7gbdEOFNaims4pcQeeVcCBSMZvjOjgJP/1eGPBJZ7Zg+jB7P7zcAz7Ye5NZNUt2hTRmiwAM9ZZeb97qV70RSYQmk2kG+Vjfq56IGo3nDuZWgchCR+H+1D0OS66B6+s/mOf6kJiU/lPdka/Wy90dKZ+opsNjcrh3+oHmnNQ6DcWlMU5ggUH/m7YpHRe+DASesrIuyttm7ZmTpp6hUxvBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQ6idCMoHb0deEvrn84y1zpRJTQz0jdrtt6m75Fl6Bc=;
 b=eHCHcUUvI434OAW6jisIw5JsUVf4Sv1/u2YDJQur2FBAn3S+75SIc44Vpskva4VlH4uFZ2LnQKnR2EIc2Ok8QGcg9zsSMkP6PEB3CJwG46+MQST7kuDPnzrWjij4o14dvqsB+0ObijTftc2C7MJtcmAgvL6ubWkOT/LRtLSAj9dC3JbPinKbi9QXNDU85y5lg4P1WtZn/zS+f6eqptstVpB14ai+oygZR5KKjdil6hOJZksgEtQqNriHUdwjNBkpCYgVkdUU0Yg4D+MtL7IjQLvkwcpMHsqreSl3Rk0nnxLFmYJ5jJM3I3/RpAqZFDvwicZmSeYG7kao5494SNDC+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ncr.com; dmarc=pass action=none header.from=ncr.com; dkim=pass
 header.d=ncr.com; arc=none
Received: from BN6PR15MB1426.namprd15.prod.outlook.com (2603:10b6:404:c4::18)
 by BN8PR15MB3265.namprd15.prod.outlook.com (2603:10b6:408:72::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Fri, 13 Aug
 2021 18:54:43 +0000
Received: from BN6PR15MB1426.namprd15.prod.outlook.com
 ([fe80::21ab:b879:3cff:87c3]) by BN6PR15MB1426.namprd15.prod.outlook.com
 ([fe80::21ab:b879:3cff:87c3%6]) with mapi id 15.20.4415.017; Fri, 13 Aug 2021
 18:54:43 +0000
From:   "Russell, Scott" <Scott.Russell2@ncr.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git clone corrupts file.  
Thread-Topic: git clone corrupts file.  
Thread-Index: AdeQbBTmFYBcWaT2QVKI1LhsxFP/CQAAfQYQAAGNnwA=
Date:   Fri, 13 Aug 2021 18:54:43 +0000
Message-ID: <BN6PR15MB14264C9A96F4B5F6B01FA7FACBFA9@BN6PR15MB1426.namprd15.prod.outlook.com>
References: <BN6PR15MB1426E50F03A0530CA9140F98CBFA9@BN6PR15MB1426.namprd15.prod.outlook.com>
 <BN6PR15MB14261C40E614CC11416388B4CBFA9@BN6PR15MB1426.namprd15.prod.outlook.com>
In-Reply-To: <BN6PR15MB14261C40E614CC11416388B4CBFA9@BN6PR15MB1426.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Enabled=true;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_SetDate=2021-08-13T17:49:16Z;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Method=Standard;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Name=dc233488-06c6-4c2b-96ac-e256c4376f84;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_SiteId=ae4df1f7-611e-444f-897e-f964e1205171;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_ActionId=76c876d2-3769-414f-9092-98078064bec1;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_ContentBits=0
dlp-product: dlpe-windows
dlp-version: 11.3.0.17
dlp-reaction: no-action
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=ncr.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 121a1049-58ad-42e4-09cd-08d95e8bd00b
x-ms-traffictypediagnostic: BN8PR15MB3265:
x-microsoft-antispam-prvs: <BN8PR15MB3265537FFF8588E386B15E38CBFA9@BN8PR15MB3265.namprd15.prod.outlook.com>
x-from-ncr-tenant: Processed
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e1vBKcDgtz+HPXfjAC5HDqfz7wYJvtqEpGwyk31tQXzQ0JjW/vUgDPHNUsPPvxLon67iOWdiIvahCa8oNQDttTrllsAFzapM/X5RFcW+QjU9fgvfmdHV3CRjluoHjY6k47btuV8QKaZ0/mVF/jENKqGLz8MSBtypyXGvsTv6WD1ooQPWMJ6IR2LNjI+zteIYBT1DMoWt8KrRbQG7k1vcS3z+B+eAoVUR84IVWwOdbKZP5vLUgSC1EyJJJQDU45ZYTHmBJ2+QmNa67B3cms6TggtIZaCwwIyXv6fnQJKZv+uXHo6PJO4AdpXD/fF1YpuP0aeS9G8Z8g48iMbMLpxhuYMIokLuKq9heKFFu8iQP9O0Ndyehzt4cTVhDImcCMlK8auQHdOdmJEBVHUMA4tWSJ+gMQNEfiz5CvrVbiJiU6FUEWOEUc7MbihvSN8IxXE5HYXnLmQmvwd6pRISn8AYIWzK8aSY+zLBJh0hfNxg4knlrKSmlV1w5eQ674ckTIap/rmbYZC33pBMcUyAD9W9CfoFBmgu8FAUynQ6tHkoUqjfgc+OqKI5o/fc8nyL8T3k3cRfkB25EOWhsQ7ye2WlyBqHN2+a7iNXAw7fO9iSmsFm0x3fAzZU2oE+JIxiX4B5WSaCvAyvP62LJiuqs3UE1AONrqqoHOhFrMQ27vCHh08HSlM17gG1FDETmT124i8pqKyk9hrnvIP4ssVOLSXRt2r4jk0hJ6zGIFSApQ5EAMEdeBYer3WNKqahht1iR5Po29sDujCpqwoP33H7RbYyh3nFQYW4kabq68QlmMjGE8RmVhhgd/B8W0UGdqARGIjhyl9WSC7QSCRXDctNAblh2w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR15MB1426.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(366004)(396003)(136003)(376002)(71200400001)(186003)(66446008)(66556008)(66476007)(2940100002)(122000001)(45080400002)(7696005)(38070700005)(26005)(6916009)(38100700002)(966005)(478600001)(5660300002)(2906002)(316002)(55016002)(6506007)(3480700007)(52536014)(8936002)(76116006)(64756008)(66946007)(8676002)(86362001)(9686003)(33656002)(18886065003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2RHajAxdVdwWWFLUmZRVzlQUExlY0loc2lPMTlENlZkQkhmZVM5QWFvb2xI?=
 =?utf-8?B?WWVxckEvUHRkSlhoVy9HRFk5SVRRMk9XMFh3am1LeG1DVDQ0NkZBMXpmcGNE?=
 =?utf-8?B?VkRHZFR4Q3ZwWit4TUZyVmYvWklPZXRCMVpSWlIvb0JIYm0wNUdLN1ZOaUp2?=
 =?utf-8?B?bXVIQm5IblFubjRhTzc5SnU1Yjh3OE1YYkFNS2dOYjFKdDNFWkVTaGZabUZR?=
 =?utf-8?B?bHZ0cU1MRHJEK1RrS1Rjb1BvWnlMdjVDams1KzZBK3huZThTb0JxcHo4amJS?=
 =?utf-8?B?Q2JRaDE0d2xjeTRQOU1KOWZwRE42bnB0Q1ppeDBPNEYza2dqNmt1eGhjY1pS?=
 =?utf-8?B?bmh1WjA2VVJweXIyOFFRYkVnTTc4bHpLaTkvZFdNdFFZQURaZXFJdmp0aFlk?=
 =?utf-8?B?MjlPY2FJQURuS1JhYzRRTndma1Zkd09GV0NNVlNKeGRJWDRMUVVuL0dMUzJy?=
 =?utf-8?B?K0JJdjh1UitsR1pLS0VnRVduSE1sWTJtanZ1dFRscUozYmNSUlJ4bmM4ODdV?=
 =?utf-8?B?cTJwd3hIZEpWR2ZGRmpXdEhaamF2MkIrd0RGMHF1eG1vQnh4Yng2ZDRsWUpY?=
 =?utf-8?B?d2xvd1dzTlBlVE1UOUhRNURRdTFXclZKa256TTd4NTVEWVY3UW1yeWVXNElM?=
 =?utf-8?B?VHg5cGxtVmlVSjBUelVLZ21HcndSdnR1YXI2Z3BPSlJncDZ3QVVKdU92UHJa?=
 =?utf-8?B?YjMyU0VXOVVkc3lsQ0lZY2JnNWJLVzJLRnBkdFhYQ1g0ZFZPSjRKcklOTE1N?=
 =?utf-8?B?d1lYN1AxUld0VUxaZFllL2tzam5aam9aaGc1S2NuNS9ScjVkWXlRSnI1aWdU?=
 =?utf-8?B?U2FCdS80bHhNTGpNYlF1NDRzWUR3QkFWYlFyUFhiVG9RMnYyUUtwY1hxK3A1?=
 =?utf-8?B?VTNtanhzMlB2NU8wcENkdmg4cGdvRlJza1lVQ2hnWnk1Vlp3SmtjWG5rQXND?=
 =?utf-8?B?UlNmRzNvYktvWkhSeE5WRzVpcVJBRUt5NXkxMnVGUENRRVF1dlp0VUwzVlB5?=
 =?utf-8?B?RmtDRG9TOEpuUzJES29DUXhnUC9DaTdkSzFSZXU3bE9YYm5xeGwxdEdBekMz?=
 =?utf-8?B?MXNXaDd2UDJUSm5wMVVEa2FXWEErdU5HVGx5MW9qK3VGVWVGeC80blF2QW9M?=
 =?utf-8?B?bGRVZVlFZ2hiY1ZnaTErQmdldm4wSmRHazNDbkVEUWNqaUNXclA2RWthVWRW?=
 =?utf-8?B?WWVMK0Y2UGZqUnR6amZmd3BPdmNNKzZ0MHhranFhK09YVmxnZWIwZVBFeFNq?=
 =?utf-8?B?SzZ1Uk1FZUtwd0EvK3dmUzlyWitmcitxQU5WUWs0a0NlRWRLTmN6TUVWUm5l?=
 =?utf-8?B?UURlU0Jkb3phbmVsVTVXVi93UWNIeU02MzhLSno5MWxLNVdTWjA1eXJYNE8x?=
 =?utf-8?B?ZzdTbE9yRTd2S2JVM3kzSjVRaXY5OW8zT09kNzI2VkpaaVZTMzJuY0pNL0F5?=
 =?utf-8?B?MGtINHNjMjBmTUkvRHdIMmRHTlVXSTNLODR2cGN1c1hNK09ZOCtXbmRCSzRs?=
 =?utf-8?B?OGlvMFFQOTdseGljZ0dRM25NOGNOSnMyNzd4WmpJd1Jxc3BzMk1EV21rTlNy?=
 =?utf-8?B?Q1JTZ3VyM3VDNnRIUEZzem9BN1JFQXc2QzAvSk4vbkVQNngyYVB1QTlyc0ZT?=
 =?utf-8?B?QVJTWG1jTUk1cHlGWnR4bnVnZTM1NEZtN3VreXNIaVFhNlRzc0dxVjVzeVgx?=
 =?utf-8?B?TTVVVVdJUCtlQXdzdG8wVUlqTW1OZUZuQlc0dU9mRHBkSXNwdWllZ29CdUh1?=
 =?utf-8?Q?W+mJrthp9gWEnhwIVUgN7HRW6jDKjhO1ZtZ1LDY?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ncr.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR15MB1426.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 121a1049-58ad-42e4-09cd-08d95e8bd00b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2021 18:54:43.1955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ae4df1f7-611e-444f-897e-f964e1205171
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qhb9MXhhArHB+nLAXquroM6X0d9vz6rUd/OQetXqBy4JUStIZsQxd+QPfjZh2LmRj7hwhVlN302tEq5x+p5FoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3265
X-Proofpoint-GUID: jmkykqqxVNdq62bZ48Emy2GJbVJH-kUi
X-Proofpoint-ORIG-GUID: jmkykqqxVNdq62bZ48Emy2GJbVJH-kUi
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-13_07:2021-08-13,2021-08-13 signatures=0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

V2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyBnaXQgY2xvbmUNCldoYXQg
ZGlkIHlvdSBleHBlY3QgdG8gaGFwcGVuPyBmaWxlIGNsb25lZCBtYXRjaGVzIGdpdGh1YiBjb3B5
DQoNCldoYXQgaGFwcGVuZWQgaW5zdGVhZD8gZmlsZSBjb3JydXB0ZWQsIGRvZXMgbm90IG1hdGNo
IGdpdGh1YiBjb3B5wqAgc2VlIGV4YW1wbGUNCldoYXQncyBkaWZmZXJlbnQgYmV0d2VlbiB3aGF0
IHlvdSBleHBlY3RlZCBhbmQgd2hhdCBhY3R1YWxseSBoYXBwZW5lZD8gwqBjb3JydXB0aW9uDQoN
Cg0KW1N5c3RlbSBJbmZvXQ0KDQpnaXQgdmVyc2lvbjoNCmdpdCB2ZXJzaW9uIDIuMzEuMS53aW5k
b3dzLjENCg0KY3B1OiB4ODZfNjQNCg0Kc2l6ZW9mLWxvbmc6IDQNCg0Kc2l6ZW9mLXNpemVfdDog
OA0KDQpzaGVsbC1wYXRoOiAvYmluL3NoDQpmZWF0dXJlOiANCmZzbW9uaXRvci0tZGFlbW9uDQp1
bmFtZTogV2luZG93cyAxMC4wIDE3MTM0IA0KDQpjb21waWxlciBpbmZvOiBnbnVjOiAxMC4yDQoN
CmxpYmMgaW5mbzogbm8gbGliYyBpbmZvcm1hdGlvbiBhdmFpbGFibGUNCg0KJFNIRUxMICh0eXBp
Y2FsbHksIGludGVyYWN0aXZlIHNoZWxsKTogPHVuc2V0Pg0KDQpbRW5hYmxlZCBIb29rc10NCm5v
dCBydW4gZnJvbSBhIGdpdCByZXBvc2l0b3J5IC0gbm8gaG9va3MgdG8gc2hvdw0KDQpGaWxlIGZy
b20gZ2l0LiANCg0K4KiN4ryA4ryA4oCA5LSA5qSA5oyA54iA5ryA54yA5ryA5piA55CA4oCA5ZiA
5qSA54yA55SA5oSA5rCA4oCA5IyA4qyA4qyA4oCA5pyA5pSA5riA5pSA54iA5oSA55CA5pSA5pCA
4oCA5qSA5riA5oyA5rCA55SA5pCA5pSA4oCA5piA5qSA5rCA5pSA4riA4LSA4LSADQovLyBVc2Vk
IGJ5IENhbVRlc3QucmMNCuCojeK8gOK8gOC0gOC0gA0KI2RlZmluZSBJRE1fQUJPVVRCT1jCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAweDAwMTANCuCojeKMgOaQgOaUgOaY
gOakgOa4gOaUgOKAgOSkgOSQgOSQgOW8gOSEgOSIgOS8gOWUgOWQgOSIgOS8gOWggOKAgOKAgOKA
gOKAgOKAgOKAgOKAgOKAgOKAgOKAgOKAgOKAgOKAgOKAgOKAgOKAgOKAgOKAgOKAgOKAgOOEgOOA
gOOAgOC0gOC0gA0KDQpGaWxlIGluIGdpdGh1Yi7CoCANCg0KLy97e05PX0RFUEVOREVOQ0lFU319
DQovLyBNaWNyb3NvZnQgVmlzdWFsIEMrKyBnZW5lcmF0ZWQgaW5jbHVkZSBmaWxlLg0KLy8gVXNl
ZCBieSBDYW1UZXN0LnJjDQovLw0KDQoNClRoYW5rcywgDQoNClNjb3R0IFJ1c3NlbGwNClN0YWZm
IFNXIEVuZ2luZWVywqANCk5DUiBDb3Jwb3JhdGlvbsKgDQpQaG9uZTogKzE3NzA2MjM3NTEyDQpt
YWlsdG86U2NvdHQuUnVzc2VsbDJAbmNyLmNvbcKgIHzCoCBodHRwOi8vd3d3Lm5jci5jb20vDQrC
oCDCoMKgwqDCoMKgDQoNCg==
