Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83CAC433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 20:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A175F610FC
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 20:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbhDZUqC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 16:46:02 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:16046 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233501AbhDZUqC (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 26 Apr 2021 16:46:02 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13QKjF9V002812;
        Mon, 26 Apr 2021 13:45:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=uuY3mYiJbXyJ6pCDB6z3eezGAplwqwHKNVm+n7R151A=;
 b=ICYUhC0u0/yrgIvYY57owt+wtvX5pCDshJA39kqF7bH/QEYpID6U0Ljkh2DWolEaU57Q
 FGlaK7liUH1GAei5BkR4DnaWIapFZatCpUPIo/R72cOLxm/HRg6/iYIbduAWZX9eCpEy
 MHpau6Nun0P+wDiqlVH4lkFt6yKV16OjIFM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 38535yqucd-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 26 Apr 2021 13:45:18 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 26 Apr 2021 13:45:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FlbIUCe7RBflFLI0Q0cqbpOgkdUUoitNiqVKQYJlz77UlSQL0ImPO+1mFPj5sGHX6im5KyyMV9ImXHHDMqtiWS/KsqB83GDhGLWw6UlhCS6ZFcFAc/nBYlXzNc6nrHMolbV28/jl/lLdKxuitwyTA8UqxeROakk1mGrvQdAH9jMt6bt2956NBqhQXw8Poc9eHVaCEDCag8Z4tEOYyqAdGTCN7lEvO2J/wWxkCxhpYnyKjFu/RLZWLR2rfLhnoAIT+3Q0qXJXEccy/rV6BnoM1CJuU4f1fimCA/CXrPC4tiA1OI9ywpTuYzo9yBqb6WP+4oouCITduRVTBXsR+YVVCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuY3mYiJbXyJ6pCDB6z3eezGAplwqwHKNVm+n7R151A=;
 b=YH2M0tMLMq6gKk5+5Sf88/CXEt2+XH7zsi8vEORbCr3O7M/4wmMg+qncgSwvRRT/Hv7/fkNq1fqSOqaibcnkRPOmXqMHdPsuLcDTrcIwdNHtMfSQigYQS4QWYMSE2tGKtOg1pi8Nja2WQqwuWUNoHt9mRdyyifiGiT483nUQFaWMtQdCTzg3lu2z22GapZY/GpUYevfoiEBMAJ/i8oJW9JyUXYV4NP1oefwPNK429QIFxDKCAZYVI3/o208NQVN4Mz7nF6MspCSArwhXHnukN97nuW6OeGMuMWkHK3BLezGN0SjgvuIoZbREaa3dk8W/LKqzlG2XHtCh4h0RyookXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3697.namprd15.prod.outlook.com (2603:10b6:a03:1b3::32)
 by BY3PR15MB5041.namprd15.prod.outlook.com (2603:10b6:a03:3c8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22; Mon, 26 Apr
 2021 20:45:06 +0000
Received: from BY5PR15MB3697.namprd15.prod.outlook.com
 ([fe80::60ca:e5a2:a17b:70e7]) by BY5PR15MB3697.namprd15.prod.outlook.com
 ([fe80::60ca:e5a2:a17b:70e7%5]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 20:45:06 +0000
From:   Shoaib Meenai <smeenai@fb.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [BUG] ** glob pattern in git diff doesn't match root directory
Thread-Topic: [BUG] ** glob pattern in git diff doesn't match root directory
Thread-Index: AQHXOLTY90qVDB3WrkWA7U/v+Lwk5KrDA1OAgAPP/YA=
Date:   Mon, 26 Apr 2021 20:45:06 +0000
Message-ID: <123C2F2F-7B85-4EDD-A8D9-172CA566391D@fb.com>
References: <79834D18-EAF4-4748-9B96-38AAA0760499@fb.com>
 <608391297345f_10cb920875@natae.notmuch>
In-Reply-To: <608391297345f_10cb920875@natae.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [67.188.238.35]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4cea4c9f-52ac-4c02-a91b-08d908f42ca9
x-ms-traffictypediagnostic: BY3PR15MB5041:
x-microsoft-antispam-prvs: <BY3PR15MB5041A7F566E2E6177A4AA7D7C9429@BY3PR15MB5041.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oBtQbdrFbLNOAgXB17Z5E/wYY5vTOxDuldo0jatXFBeWxt/rBGKUpzIRUu+0AKsR3xP76+bombfw/jzIXkKt05Fko/L5RRGVYZfX/z33s7+Y+3XmxiO+slJgGZO8EzcTvoLbd9PWy6/EQTdK4vlpJl6Zaslz1U7KlJDqdeInKHpIO/JLfDDcYmgaIayvlogoVaVAiQFbc2NgyG91WIktpSFbtsZcbe9kOeX27ek7GRrBhpa8chF6kKtFPFg+7g+rish8sgWQrIUtvUuB0EqzRxxQcXs8xABlXfhcEB4LY8G0EM/NRhGfP3FB30yiLAv2zTLf33ktrCUoz4FD1UDM2cUnjvs6NpJv9w4by4z4Q2wXYyDywGdpveMLDlHurlFqF9k5IG/tVrwBnU2teig1l/IMHaanvqNHkrYHgxeGZH0VYMOdJLH4sN+4iKGoI5KCZcffxrJc1rJianmPlrRmUbCWl//hOJDWphCxo1EW7Ldhgdm45UX23FhKOQAAyEruiDg7cAz64ozgbtZUm7HnK8xLk1tyHg+aK9k+tXDzkvlG11pkR4e0jMN7FN1PMn1+8GmtxPtOeeyjqiVenyoerUZ4hfaifwQZxJlA0a7zCaqNC+LBf2dUJk7DebmbTlU4FKNvaS+oJmxAEnthqgyk/1cAGnfYSKEq82it+6WTTLo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3697.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(38100700002)(110136005)(186003)(64756008)(71200400001)(2616005)(76116006)(86362001)(6486002)(66476007)(33656002)(122000001)(4744005)(498600001)(26005)(66446008)(6512007)(8676002)(6506007)(8936002)(66556008)(5660300002)(2906002)(36756003)(53546011)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?OGszeEUzaGdFVHNHN1VObW4wdXZsNU9hcWdOSlAxTmhOWkhUUkwyeWR6cnNN?=
 =?utf-8?B?MHlvRC9PaTNnQUk5NEVOV0U5MysyQWRJdWVPVTVHL1pqZUhBditYS251dVN3?=
 =?utf-8?B?dWtMbzYzUnhRYUUxYWNoNklvQ0JwMTVqU1ZNUm9zbmhndjRJT0N1THRHSkFn?=
 =?utf-8?B?WUFzT053bExZNlk5Y2libTJialVNRlZBeXpmRE9SclN2K1ltcmprSUZqaTJw?=
 =?utf-8?B?aHA2ZmVpWnVVb2xLM0lvQmFVL05vRWVWWVJOS0JkRGp0TmpoT0NVQTdTMmNz?=
 =?utf-8?B?Tm93RGovd1ltTlhUNHZxNFAra204RWJvYm9oRWJMektJTlkzemFYZDlCMU9T?=
 =?utf-8?B?WmlJeDlLZ043aEZTYkVmZXRzV0FoRFpmeWREUGJlZG43K3hDVUNIVHZ3NUxE?=
 =?utf-8?B?QVVidUEzaURCclQvZDAyZHA1VFZmSjVQVFdqL2RuN3Z0bWZqUnRGOVdOMGRL?=
 =?utf-8?B?dVl0Ui9HNmszbEFWRG9LUTZWQmxVL0tUcUF0akJNT1V5cU1xMWkzOTRwMU84?=
 =?utf-8?B?M25vQVNzU3FTN2wwbllnSklsdmNDRzFlMXhpWGhMbGU2Y05xZnViaG8wZXlD?=
 =?utf-8?B?UVkrSWsyb3hiaUxMMFhTSmZlTDUzL25BSWd2ZThDL09NNmpiQWdONi8zV3VU?=
 =?utf-8?B?SG5WK0YyZlQwajd5Q1lsK05XSUJORnhOSnFWSndJVTYrcnJKeE9nRHFwKzdX?=
 =?utf-8?B?S0s4M1NEWmtSa2prUnkzSENWemRPVTQxSUF3WWxURHBqb0lFT1l4VVp0RUlr?=
 =?utf-8?B?Q1N1S0pNQ3Mrek04d3RxVk5lbUZxNFE5NWhQVzQyU1hYUEFUS2N5RE55UWUx?=
 =?utf-8?B?ZFlhU3c0Vmw4Sml2UDNpMFBiaFZMM0p4K3JpYzE4WkduckJkcTFFaUQ1Uytx?=
 =?utf-8?B?TmVGWGJtNHZhdUlSaFFzMW1reTh1ZXZtc3dyczlHc01wd1oxWU1ndDVxN1Rk?=
 =?utf-8?B?Q1N1eERFbmpyY2xFWUpGbG0yRlFkeVB3ZW05TkxjT1NndXB0VUZrUm5NSWlP?=
 =?utf-8?B?aGFpMDhwYWRIU2xTOGw0Zm5QSFVjNHlsRWhWUVdiRFQ5RUloazFPSE1wOWxw?=
 =?utf-8?B?N005WGtlV1ZWa2JoRHhYd2xEbkhLTnIyZjR5QlQwVVRabHNReWZUMzZSSUFv?=
 =?utf-8?B?N0VreCs2aUxjTUxWS1VtZjljdGdDUXdrakxZa2R3a3NzVkp0RmJBNS92TCs5?=
 =?utf-8?B?akFRVmEzMGN4WTlGcWIxYTdpYzlyTDgySXFFRGN5K1locDFSaGE0Zk5YZThl?=
 =?utf-8?B?dng5Y21ESmRqa1AxdzdqanBRVUF1djM3dFZRR2g5dUlxZkpoaGdUcERPK1pH?=
 =?utf-8?B?UE12bnRIMDVBT1AwM1ZkQjJQWEw2Mkgwelg0Y0ZMc2d3TXRZbTRwRWQvRkht?=
 =?utf-8?B?QitRZFNuL2I2VTRtN2JidkhxS2RPUWtUdlNJb0s4UHRYbHdlRkFKYjFRTlcr?=
 =?utf-8?B?eFNzOGRkT2EwUmZyN3Foa2FWeHU0cE9iY0JLRS9CYU5wWmg1OXZtQ0drbkhx?=
 =?utf-8?B?MlBaMVNsZ3FkeWV5R0NLZVRTWHE0bGYwTVRwc29xWFppenpLN3lCUGNGRE9m?=
 =?utf-8?B?ZmJERWhRVGR5cWdRSkwyTGsvV3UyU1NaY2hIMjFhMmZBRGNlQ1ZkUnJGTTJR?=
 =?utf-8?B?UGt4U1hsQkNJY0hWM3F3b1FScmJpTlIzb1Q2WUZ2OWJVb2tjSVRLaW5lVWNS?=
 =?utf-8?B?ZGJJQzVmdWdnQjdEc1dBNnp6MkZtOXkyb1hqRkR1UkZZRzRTaFp6NzRyQlRr?=
 =?utf-8?Q?FQhJCTEnwaaUD+8LlaibURxK/Ib8VAte9H+7tNW?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C157246364C47241870AD6A8E4CD87EA@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3697.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cea4c9f-52ac-4c02-a91b-08d908f42ca9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2021 20:45:06.2155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L9/+AY6uOSEW6tdmADUXNETNHEczueBfvnplx12qPb1saCGjhkpLlExbc9ihxv/p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB5041
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: yGRwdPm5eYSzzvL0NW7kitnJksbjQ2Pq
X-Proofpoint-GUID: yGRwdPm5eYSzzvL0NW7kitnJksbjQ2Pq
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-26_09:2021-04-26,2021-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 adultscore=0 clxscore=1011
 lowpriorityscore=0 suspectscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104260159
X-FB-Internal: deliver
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiBPbiA0LzIzLzIxLCA4OjMyIFBNLCAiRmVsaXBlIENvbnRyZXJhcyIgPGZlbGlwZS5jb250cmVy
YXNAZ21haWwuY29tPiB3cm90ZToNCj4gU2hvYWliIE1lZW5haSB3cm90ZToNCj4+IEFtIEkgbWlz
dW5kZXJzdGFuZGluZyBob3cgYCoqYCBzaG91bGQgd29yaywgb3IgaXMgdGhpcyBhIGJ1Zz8NCj4N
Cj4gSSB3b3VsZCBzYXkgdGhpcyBpcyBhIGJ1ZywgYnV0IEknbSBub3QgZmFtaWxpYXIgd2l0aCBw
YXRoc3BlY3MuDQo+DQo+IEkgc3R1bWJsZWQgdXBvb24gYSB2ZXJ5IHNpbWlsYXIgaXNzdWUgKEkg
d2FudGVkIHRvIGZpbmQgYWxsIHRoZSAqLmpwZyBpbg0KPiB0aGUgcmVwb3NpdG9yeSkuIEkgY291
bGRuJ3QgZmluZCBhbm90aGVyIHdheSB0byBkbyBpdCBidXQ6DQo+DQo+ICAgZ2l0IGRpZmYgJzoo
Z2xvYikqKi9mb28nDQoNCkFoLCAicGF0aHNwZWMiIGlzIHRoZSBwaWVjZSBvZiB2b2NhYnVsYXJ5
IHRoYXQgSSB3YXMgbWlzc2luZy4gTG9va2luZyBhdA0KdGhlIGdpdCBkb2N1bWVudGF0aW9uIGZv
ciBwYXRoc3BlY3MsIEkgY2FuIHNlZSBob3cgdGhpcyBpcyBzdXBwb3NlZCB0bw0KYmVoYXZlLCBh
bmQgYDooZ2xvYilgIGlzIGV4YWN0bHkgdGhlIGJlaGF2aW9yIEknbSBsb29raW5nIGZvci4gVGhh
bmsgeW91IQ0KDQo+DQo+IENoZWVycy4NCj4NCj4gLS0NCj4gRmVsaXBlIENvbnRyZXJhcw0KDQoN
Cg==
