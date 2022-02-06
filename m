Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC473C433EF
	for <git@archiver.kernel.org>; Sun,  6 Feb 2022 09:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiBFJIt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Feb 2022 04:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiBFJIs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Feb 2022 04:08:48 -0500
X-Greylist: delayed 466 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 01:08:46 PST
Received: from mx0f-00379502.gpphosted.com (mx0f-00379502.gpphosted.com [67.231.155.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95159C06173B
        for <git@vger.kernel.org>; Sun,  6 Feb 2022 01:08:46 -0800 (PST)
Received: from pps.filterd (m0218362.ppops.net [127.0.0.1])
        by mx0f-00379502.gpphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21690MD4003884;
        Sun, 6 Feb 2022 01:00:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=llnl.gov; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=02022021-podllnl;
 bh=VhUTJCVd1PSJSAU1OjcZHdGoKevYJeS2ASDRIKO5ST8=;
 b=sF3ousZPrCxUS2qxAgk8/vmgmLhROTDK8CDknw+6rAw14qCv/3ihkcpj/E1zl6fSYfDB
 mRtCS79zBYj6txZmJf5nPX7G0wLXyd+/sJSUCltFwCTv9vMA+/MOKsS+jC7sdZvXQIIu
 ++sYLoHMYsrWe9Yq7J/xRyEP6E8yvcQP/uuXVbqmrDLBHDenj5d/wAU5CDYrQh3xNDFH
 CzXTxwuZoJhRObdp3x+GFLWT5cptZGOm9VrexwN8M9YsGHfy9k6bZvdq6p0xjBxRp13C
 dmxoqHnk7St6UQs7QM8wSaMpsdQEVi5KUSDRaStyyoHR6VjIULffsTzt53zl6GVrBqcP ew== 
Received: from gcc02-bl0-obe.outbound.protection.outlook.com (mail-bl2gcc02lp2103.outbound.protection.outlook.com [104.47.64.103])
        by mx0f-00379502.gpphosted.com with ESMTP id 3e1rfwhmw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Feb 2022 01:00:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBq17bJaAL01bv2TGsDF3QOluEOGKJRpUPKqISXenp4XVdg6eADsnAWg4G3Rl0yKBLIGOXtoTdca/vNMojY9Ks7aR0m17Hj6+a36G1mz+mJAiytolBFmhwaZz0KjLXIlGAX9PJvcVF9rSi9sjqKTd90XEhsVlV2sA4Fw1BabJfQjjzKGFHkNdizmmMEUkkxaLLPUNZYCdmTZVbhAcwn3F+CyMjcZrI95LiB+UN6bV4yzPtxPXCSM5GZ0xX1d3vtadHLnWvtVHRXV5+2d7VQlPNHxmWacJdcghcKyBYe+qZ8peb/ZA5X/i7NN0L6aufMUHYznbBJp7jSZG8dNrTHbMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhUTJCVd1PSJSAU1OjcZHdGoKevYJeS2ASDRIKO5ST8=;
 b=luGlbs/nPIyE+LDR/TM6tH2/osFBt47dqOc9P6rbTW6IceJc9oTa9HOsQZ/hO71TeBDdhv63zEB8CDTvKR/V/6Zl4aZQSRPWlaGNjNoDrwH7l9InuD7YqMelFZhxqszRFjBhscmD2Hf1s1QPuxquVXRInNe/Csd+3PTKg+EVUJCZU/5AFJXVEk/gR3DblmqQfjz0nSFWkA1xh/xyhQzKUatgPLy4/q9BRX1npLuHfIxXOJu1aHZyTQyiL4dUYY19gAoX+ckXVoR1pwLmRtPJGS3oWpypWTeGeCFqWdJpGafOv0Pk6I7HKV1j51n9a1FNqivpbTWrrmTq+BijfrPYmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=doellnl.onmicrosoft.com; s=selector1-doellnl-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhUTJCVd1PSJSAU1OjcZHdGoKevYJeS2ASDRIKO5ST8=;
 b=vWyQVqtn7+qkpAx5q1pdKazpD7FjCqrnEpHunigJu+7hAQgkC+F7vjPlILCFA8gDeTH3gBxmAaqXroZWG/mn04593vc3A/PenpSWoLN7hBuebrJ69pq1kNvG/55lk23DzwTiTQPqohLvzy3wFNT1L6qgPKoemp5ff6AjNs9QyXY=
Received: from BY5PR09MB5972.namprd09.prod.outlook.com (2603:10b6:a03:242::12)
 by BY5PR09MB5059.namprd09.prod.outlook.com (2603:10b6:a03:24e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Sun, 6 Feb
 2022 09:00:42 +0000
Received: from BY5PR09MB5972.namprd09.prod.outlook.com
 ([fe80::1152:ffb:b909:9231]) by BY5PR09MB5972.namprd09.prod.outlook.com
 ([fe80::1152:ffb:b909:9231%2]) with mapi id 15.20.4951.018; Sun, 6 Feb 2022
 09:00:42 +0000
From:   "Gamblin, Todd" <gamblin2@llnl.gov>
To:     Philip Oakley <philipoakley@iee.email>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Commit SHA1 == SHA1 checksum?
Thread-Topic: Commit SHA1 == SHA1 checksum?
Thread-Index: AQHYGi5p7M1/4kXYKkqhLSADSBwD+KyFqvkAgACQsoA=
Date:   Sun, 6 Feb 2022 09:00:42 +0000
Message-ID: <188C988E-F679-4AD6-AA04-E51F11F7D9A7@llnl.gov>
References: <ED97E252-CABA-41BB-B18C-819A5EF305E3@llnl.gov>
 <121ce485-bea8-3168-aa35-d11eb13022da@iee.email>
In-Reply-To: <121ce485-bea8-3168-aa35-d11eb13022da@iee.email>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15441cc1-7f48-4ce8-cb4c-08d9e94f2766
x-ms-traffictypediagnostic: BY5PR09MB5059:EE_
x-microsoft-antispam-prvs: <BY5PR09MB5059FD6460F4992D72EFF064F82B9@BY5PR09MB5059.namprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gszwP0WXGk8lrrN6om98UzZyXXmYszMbLBHcOg5w4KLdo340aNmPOpq21zumXfceZDtI83O0/OILnZmwAZPCzjaowTVFk4AXR92Wk9BLq5ynXSl9aUndTkXSnxTU1ovda/qimaZ53GUGCQWAzz+L4yqtP4PEoAsU4sNu/XR0SDGX9/WLxXymQidnUVfvEsItf6KmSJAFmq8yk0m4bbq5a+2ZV6Cc266hZwbaPWOezrXS9CMyWS4+jW35VKJpfhBK0+eLqnjFl79NISwoG8aAFnZ7AOeXgIUL7EXkhNswVBxKwDxTQzmcPlC9ygqYOerzi2fcD2bcBqYtKAYh3t1IUNsIV2w3rLjUykIYHH3ttOko9PgI2CN1C1+OBFQppsbaaNr7VdL3ViezHbra1E814dwGwNFrzbCywWljtNbInjjm8TUzaqjhELP5gftg/UJKPlhLtHK70TZC7J36iRhfD97Y9e3A0Xe+oRAt9Fs9r25ndVwTEheg5FXDG3IuLcwo3UOpXWkhtmGIRk+EYAl5UqRZVqrLOMrKDUVQZPWDbNFcJ2rjFLEaqeT4/LDS/Osmd+LaPLsQpIX1mrUvF1kcJwod1mlwfak6tEAI6J6gEij9xiFS4nLw3v8JhpjexouLvpS50Cw053niCM9nikiVYBUHxZlqYwuxU3whR55zGK58EZgfNQGLikPliaINkT8YBKcDkR0V15HdXE8YuwRtG5WYo3FiuYVBaJQDGYwYbRii3DBUhWsO3oiXlU6CO+tuBKJncHbnKSnZP6FsPrfyDmGDWkFzqfApYLRo4ODF9oxVqzmFlDznQq4LDqX/8/EWi5CxyYZtbj3G80ac06/oTQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR09MB5972.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(86362001)(83380400001)(38100700002)(66446008)(6506007)(71200400001)(66556008)(64756008)(66476007)(36756003)(8936002)(76116006)(66946007)(4326008)(8676002)(6512007)(966005)(33656002)(6486002)(5660300002)(508600001)(2616005)(2906002)(82960400001)(38070700005)(122000001)(6916009)(316002)(186003)(26005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnUzSWwwbEVoUE5mOVJDUVd5VXloV2NwdDVkSEx3dmIrc25mb2dzVXpVcWtG?=
 =?utf-8?B?RHZOZVlLY3plV2VrZU5aYll0QmFLajhCL3o5a09XaHFSb3JWa1NvNk9uem1O?=
 =?utf-8?B?elRjT2xzYnU5czZjMlFZamFtSndDTDdpakRaS0VXKzJUaFlHbEtNKzRnWjE2?=
 =?utf-8?B?Z2VBeTdoSEd1Y0wwS213V1YwQ2NCaHNLVG4vYnlXZWdLdXM3eFo1QXNwU01B?=
 =?utf-8?B?UEJpQjZFajY2UFVMLzJVOEtRdHliU0ovL1RpOVNxL2thbVU5cXMyNHp3UkRa?=
 =?utf-8?B?Tnd3Q3dIbU1FM1dIM1RwZ3QrMnh3c0VUTlRjZGtiQS9iRTA5dDIwanBMbjF5?=
 =?utf-8?B?ZlplYytjYUtqbGJwR3dEcEM1WEJuc3AyY1F0eDFtcGFNUlV1WkZKZnlVUXhL?=
 =?utf-8?B?ZU9HTWtFNkhSUXhZYS8rSVNoYmQxMWw3OWUzTG9ZaFcwMGk4SGpVYWdpK2Zo?=
 =?utf-8?B?TTd6dVorQkt4OWNrdy9aWDVXU2x4anMrcHk4YWYzTHJTZmYyMEo1SnVnRktO?=
 =?utf-8?B?TGlYNGp6WlowQmJqMkNrTm9kQUJ6UXVnL0c0YXp0RnFROWlOeGQrUlB6MHpu?=
 =?utf-8?B?L0haVmx2em9jYUZycGtOeEVzQUcxaDFLNU1NL25vUXZRbkdwd0x0MHBVd1Ir?=
 =?utf-8?B?TkJYcjdpMUxGdHJFd2lVNHVlRTcrRE1HVmcwZWQ5SmttRm9TVzNyRlE1M2Fo?=
 =?utf-8?B?Uk53S2E2dHBxOEtRWlB4aURVVUFJU204cUtwM25GZEF1cWV2Vy9XalVRTTQ3?=
 =?utf-8?B?SEVwMmNqM1lveXkzdHNoUitaaWRRNC8vMmR0V2xDT2VRYm0yQlFjUXVacXhx?=
 =?utf-8?B?ZndDdHRFZXJoNmZlWi9RTE4zUzRYNm4wREdQa1VGamorWGlFOWhkbFJyaGdT?=
 =?utf-8?B?dUdmUEIyVXlhN01KS29ESms1Uk5vcnZrVnlnSUJRb0QyRm9QcVhuMEtsYjl2?=
 =?utf-8?B?dEhHOG92U3JFZXQvbUpyMWhJeTNiY3VER3dRR25HdnNzdUMydkNlWXRHSW1R?=
 =?utf-8?B?QU9qeEZvbmh6YkRZQ3lQRGlVaVVmTkRTemRKNERNcFZla0Q5WWwrWmV2Q2h0?=
 =?utf-8?B?cnNybDFUaUtzSVNFY0ZiRTJMTjcwS1g2NHExWW9GUllzUWk5aEpUSnpqMEdz?=
 =?utf-8?B?Tk1mSmNtM0ZNVWFpVkF6U1pTQlpCR0k1OGdPQlRpcE1LWUNBRnhsajRXVnJT?=
 =?utf-8?B?NytHTnpQTms0Q0Y1ZGJzUTFlSXpHN1pNYzRFWjJzbmRoNzdOZ3VHdTEwU0c2?=
 =?utf-8?B?QWRlMTVFTUNNaENraTFHVmtYdzBIVnYvNDNTb3V0dzJJTUtsV3Ixb2tBSnh6?=
 =?utf-8?B?Ry9CY21IUHRSZkt6WXZkakRpclNMOWFuVk1QM2tPa1VRTWtkcXpSTERJaTF6?=
 =?utf-8?B?Ky9CL0U5ODh5RjhVZEl2d01SK0ZvS1NLSUI2SUJXSlZpeDRyZ3dwdmJyRnc4?=
 =?utf-8?B?TnRwNmRBM253R1hPMENDWjJPUis1NDJPTHJzeFZhOTRVclJSak9oRWRxM2RE?=
 =?utf-8?B?eHhXR0R3TUZPQXVLN01uZ0k1MldKVGZYazhTY0RXVWNLSlFjRDNVazJ4MXhN?=
 =?utf-8?B?RnJic0xjVXVjdDhEdFQ0eVdRc0d3ZVVyU1BDRitvdUNsSTdpeWd5bEMrUlIy?=
 =?utf-8?B?aDgwdXRRN25iNWQrdlNHZzd5OWwwSWtIeE9tVlorbDRoZEtab2U5NFF6OURG?=
 =?utf-8?B?VXVHN0lwZGVveVg4WUxFUmxjUnBTRFJGRXBaZVpRRkgrUDhFR2VCWThLZXBB?=
 =?utf-8?Q?xtzZH+mW+4+fiD3OvLhNTWfpG/8m9YvamHiqFlF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE8A5EC9331547428DA4A91FED9094D3@namprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: llnl.gov
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR09MB5972.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15441cc1-7f48-4ce8-cb4c-08d9e94f2766
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2022 09:00:42.0497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a722dec9-ae4e-4ae3-9d75-fd66e2680a63
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR09MB5059
X-Proofpoint-ORIG-GUID: lPoSOB7a1hwq1dFvvnVDC3fxuxzRXaga
X-Proofpoint-GUID: lPoSOB7a1hwq1dFvvnVDC3fxuxzRXaga
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.816
 definitions=2022-02-06_02:2022-02-03,2022-02-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202060065
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhhbmtzIGZvciB0aGUgcXVpY2sgcmVzcG9uc2UuDQoNCj4gSSBkb24ndCB0aGluayB0aGVyZSBp
cyBhbiBvYnZpb3VzIGNyb3NzLWNoZWNrIGZvciB0aGUgdGFyYmFsbCBzaGExDQo+IGNvbXBhcmlz
b24gd2l0aCB0aGUgcmVsZWFzZSB0YWcncyBzaGExLCBpZiB0aGF0J3MgdGhlIHF1ZXN0aW9uLg0K
DQpUaGlzIGlzIHByZXR0eSBtdWNoIHRoZSBxdWVzdGlvbiDigJQgZG9lcyBnaXQgZG8gYW4gaW50
ZWdyaXR5IGNoZWNrIG9uIGNsb25lIHRvIHZlcmlmeSB0aGF0IHRoZSBjb21taXQgaGFzaCAoYW5k
IGl0cyB0cmVlIGhhc2gpIGFyZSB2YWxpZD8gIERvZXMgZ2l0IHZlcmlmeSBvYmplY3RzIGFzIHRo
ZXnigJlyZSB3cml0dGVuIHRvIGRpc2sgd2hlbiBpdOKAmXMgY2xvbmluZyBhIHJlcG8/DQoNCj4g
VGhlIHRhZyBjb250YWlucyB0aGUgc2hhMSBoYXNoIG9mIHRoZSByZWxlYXNlIGNvbW1pdCwgd2hp
Y2ggaW4gdHVybg0KPiBjb250YWlucyB0aGUgc2hhMSBoYXNoZXMgb2YgdGhlIHRyZWUgdGhhdCBp
cyBiZWluZyByZWxlYXNlZCwgYW5kIHRoZSANCj4gcHJldmlvdXMgY29tbWl0IGluIHRoZSBnaXQg
aGlzdG9yeSwgYW5kIG9ud2FyZCB0aGUgaGFzaGVzIHJvbGwuLi4NCg0KSXQgc2VlbXMgbGlrZSBn
aXQgZnNjayBpcyBzdXBwb3NlZCB0byBjaGVjayBhbGwgb2YgdGhlc2UsIHNvIHdvdWxkIHRoYXQg
YmUgdGhlIHBvdGVudGlhbCBhbmFsb2c/IEl0IHNlZW1zIGxpa2Ugb3ZlcmtpbGwgaWYgYWxsIEkg
cmVhbGx5IHdhbnQgaXMgdGhlIGludGVncml0eSBvZiBvbmUgY29tbWl0IHNuYXBzaG90LiAgV291
bGQgaXQgYmUgc3VmZmljaWVudCB0byBoZWNrIHRoZSBoYXNoIG9mIHRoZSBjaGVja2VkIG91dCBj
b21taXQgYW5kIHRoZW4gdG8gY2hlY2sgaXRzIHRyZWUgaGFzaOKApiBJIGd1ZXNzIEnigJltIGp1
c3QgY3VyaW91cyB3aHkgZ2l0IGRvZXNu4oCZdCBoYXZlIGEgY29tbWFuZCB0aGF0IHZlcmlmaWVz
IHRoZSBpbnRlZ3JpdHkgb2YgdGhlIGN1cnJlbnQgd29ya2luZyB0cmVlIGFnYWluc3QgaXRzIGNv
bW1pdCBzaGExLg0KDQo+IC9naXQvWUEzbndGY1l6NHRiaHJsT0BjYW1wLmNydXN0eXRvb3RocGFz
dGUubmV0LyBpbiB0aGUgdGhyZWFkIG5vdGVzDQo+ICJUaGUgc2lnbmF0dXJlIGlzIC4uIG92ZXIg
dGhlIHVuY29tcHJlc3NlZCAudGFyIC4uLiBZb3UgdGhlcmVmb3JlIG5lZWQNCj4gdG8gdW5jb21w
cmVzcyBpdCBmaXJzdCB3aXRoIGd1bnppcC7igJ0NCg0KVGhpcyBpcyBhIGdvb2QgcG9pbnQgYW5k
IHdvdWxkIG1ha2UgaXQgaGFyZCB0byB0YXIgdXAgYSByZXBvIGludG8gYW55IHZlcmlmaWFibGUg
c2luZ2xlIGZpbGUgZm9yIGRvd25sb2FkLCBnaXZlbiBvbmx5IGEgY29tbWl0IHNoYTEgZm9yIHZl
cmlmaWNhdGlvbiDigJQgZ3VuemlwcGluZyB3aXRob3V0IHRoZSB0YXJiYWxsc+KAmSBjaGVja3N1
bSBpcyB1bnNhZmUuIEkgZ3Vlc3MgSSB3b3VsZCBsaWtlIHRvIGtub3cgaWYgSSBjYW4gZXZlbiB2
ZXJpZnkgdGhlIGludGVncml0eSBvZiBhIGNoZWNrZWQgb3V0IGdpdCByZXBvIGJ5IGNvbW1pdCBz
aGExIGJlZm9yZSBJIHRyeSB0byBkbyBhIHRhcmJhbGwgb3IgYW55dGhpbmcgbW9yZSBjb21wbGV4
Lg0KDQpUaGFua3MgYWdhaW4sDQpUb2RkDQoNCg0KDQoNCj4gT24gRmViIDUsIDIwMjIsIGF0IDQ6
MjIgUE0sIFBoaWxpcCBPYWtsZXkgPHBoaWxpcG9ha2xleUBpZWUuZW1haWw+IHdyb3RlOg0KPiAN
Cj4gT24gMDUvMDIvMjAyMiAwMToxOSwgR2FtYmxpbiwgVG9kZCB3cm90ZToNCj4+IEFwb2xvZ2ll
cyBpZiB0aGlzIGhhcyBiZWVuIGFza2VkIGJlZm9yZSwgYnV0IHRoZSBjbG9zZXN0IHRoaW5nIEkg
Y291bGQgZmluZCB3YXMgdGhpcyB0aHJlYWQ6DQo+PiANCj4+IAlodHRwczovL3VybGRlZmVuc2Uu
dXMvdjMvX19odHRwOi8vcHVibGljLWluYm94Lm9yZy9naXQvUGluZS5MTlguNC42Mi4wNTA0MTYw
NTE5MzMwLjIxODM3QHF5bmF0LnF2dHZhZnZnci5wYnovX187ISFHMmtwTTd1TS1UeklGY2h1IWs3
ZFJTSHo4bXMzcU5ZbGR1MkhPNkJaenZOOTFxcXRQazdVWHNtUXp3M2hnSVFOMzMtOUVkZkx0empO
OVh6R00xUSQgDQo+PiANCj4+IFRoYXQgdGhyZWFkIGRldm9sdmVkIGludG8gYSBkaXNjdXNzaW9u
IG9mIHRoZSBzZWN1cml0eSBvZiBkaWZmZXJlbnQgaGFzaGVzIGFuZCBkaWRu4oCZdCBhbnN3ZXIg
bXkgcXVlc3Rpb24uDQo+PiANCj4+IEkgd2FudCB0byBrbm93IHdoZW4gYW5kIHdoZXJlIGdpdCAq
Z3VhcmFudGVlcyogdGhhdCB0aGUgc25hcHNob3QgSSBoYXZlIGNoZWNrZWQgb3V0IGhhcyB0aGUg
Y2hlY2tzdW0gdGhhdCBnaXQgc2F5cyBpdCBkb2VzLCBvciBpZiBpdCBkb2VzIGF0IGFsbC4NCj4+
IA0KPj4gVGhlIHVzZSBjYXNlIGZvciB0aGlzIGlzIGZvciBwYWNrYWdlIG1hbmFnZXJzLiBJIHdv
cmsgb24gU3BhY2sgKGh0dHBzOi8vdXJsZGVmZW5zZS51cy92My9fX2h0dHA6Ly9naXRodWIuY29t
L3NwYWNrL3NwYWNrX187ISFHMmtwTTd1TS1UeklGY2h1IWs3ZFJTSHo4bXMzcU5ZbGR1MkhPNkJa
enZOOTFxcXRQazdVWHNtUXp3M2hnSVFOMzMtOUVkZkx0empQcC1IM0NjZyQgIGlmIHlvdeKAmXJl
IGN1cmlvdXMpIGFuZCB3ZSBkb3dubG9hZCBzb3VyY2VzIGZyb20gdGFyYmFsbHMgYW5kIGdpdCBy
ZXBvcyAobGlrZSBtYW55IHNpbWlsYXIgdG9vbHMpLiAgRm9yIHRhcmJhbGxzIHdlIHJlcXVpcmUg
YSBzaGEyNTYsIGFuZCB3ZSB1c2UgaXQgdG8gdmVyaWZ5IHRoZSB0YXJiYWxsIGFmdGVyIGRvd25s
b2FkLg0KPj4gDQo+PiBGb3IgZ2l0IHJlcG9zLCB3ZSB3b3VsZCBsaWtlIHRvIHJlcXVpcmUgYSBj
b21taXQgc2hhMSwgcHJvdmlkZWQgdGhhdCBpdOKAmXMgYmFzaWNhbGx5IGFzIHNlY3VyZSBhcyBk
b3dubG9hZGluZyBhIHRhcmJhbGwgYW5kIGNoZWNraW5nIGl0IGFnYWluc3QgYSBrbm93biBzaGEx
LiAgU28sIGlmIEkgYGdpdCBjbG9uZWAgc29tZXRoaW5nLCBpcyB0aGUgY29tbWl0IHNoYTEgYWN0
dWFsbHkgdmVyaWZpZWQ/DQo+IEZvciB0aGUgR2l0IHJlbGVhc2VzLCB0aGUgbWFpbnRhaW5lciwg
SnVuaW8sIHdpbGwgUEdQIHNpZ24gdGhlIHJlbGVhc2UNCj4gdGFnIHdpdGggaGlzIGtleSBlLmcu
DQo+IGh0dHBzOi8vdXJsZGVmZW5zZS51cy92My9fX2h0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHVi
L3NjbS9naXQvZ2l0LmdpdC90YWcvP2g9djIuMzUuMV9fOyEhRzJrcE03dU0tVHpJRmNodSFrN2RS
U0h6OG1zM3FOWWxkdTJITzZCWnp2TjkxcXF0UGs3VVhzbVF6dzNoZ0lRTjMzLTlFZGZMdHpqTmFO
STU5aHckIA0KPiANCj4gVGhlIHRhZyBjb250YWlucyB0aGUgc2hhMSBoYXNoIG9mIHRoZSByZWxl
YXNlIGNvbW1pdCwgd2hpY2ggaW4gdHVybg0KPiBjb250YWlucyB0aGUgc2hhMSBoYXNoZXMgb2Yg
dGhlIHRyZWUgdGhhdCBpcyBiZWluZyByZWxlYXNlZCwgYW5kIHRoZSANCj4gcHJldmlvdXMgY29t
bWl0IGluIHRoZSBnaXQgaGlzdG9yeSwgYW5kIG9ud2FyZCB0aGUgaGFzaGVzIHJvbGwuLi4NCj4g
DQo+IGh0dHBzOi8vdXJsZGVmZW5zZS51cy92My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2dp
dC94bXFxaDduNXp2MmIuZnNmQGdpdHN0ZXIuYy5nb29nbGVycy5jb20vX187ISFHMmtwTTd1TS1U
eklGY2h1IWs3ZFJTSHo4bXMzcU5ZbGR1MkhPNkJaenZOOTFxcXRQazdVWHNtUXp3M2hnSVFOMzMt
OUVkZkx0empPUHVVWkpkUSQgIGlzDQo+IGEgcmVjZW50IGRpc2N1c3Npb24gb24gdGhlIHJlZnJl
c2hpbmcgb2YgdGhlIFBHUCBrZXkuIHRoZSBwb3N0DQo+IGh0dHBzOi8vdXJsZGVmZW5zZS51cy92
My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwub3JnX187ISFHMmtwTTd1TS1UeklGY2h1IWs3ZFJTSHo4
bXMzcU5ZbGR1MkhPNkJaenZOOTFxcXRQazdVWHNtUXp3M2hnSVFOMzMtOUVkZkx0empQbFdjX2VT
USQgDQo+IA0KPiAvZ2l0L1lBM253RmNZejR0YmhybE9AY2FtcC5jcnVzdHl0b290aHBhc3RlLm5l
dC8gaW4gdGhlIHRocmVhZCBub3Rlcw0KPiAiVGhlIHNpZ25hdHVyZSBpcyAuLiBvdmVyIHRoZSB1
bmNvbXByZXNzZWQgLnRhciAuLi4gWW91IHRoZXJlZm9yZSBuZWVkDQo+IHRvIHVuY29tcHJlc3Mg
aXQgZmlyc3Qgd2l0aCBndW56aXAuIg0KPj4gDQo+PiBUaGFua3MsDQo+PiAtVG9kZA0KPj4gDQo+
PiANCj4+IFBTOiBJIGtub3cgdGhhdCBzaGExIGhhcyBiZWVuIGRlY2xhcmVkIOKAnHJpc2t54oCd
IGJ5IE5JU1QgYW5kIHRoYXQgZm9sa3Mgc2hvdWxkIG1vdmUgYXdheSBmcm9tIGl0LCBhbmQgcGxl
YXNlIGJlIGFzc3VyZWQgdGhhdCB3ZeKAmXJlIHVzaW5nIHNoYTI1NuKAmXMgZXZlcnl3aGVyZSBl
bHNlLiAgSGVyZSBJIHJlYWxseSBqdXN0IHdhbnQgdG8ga25vdyB3aGV0aGVyIGNsb25pbmcgYSBn
aXQgcmVwbyBhdCBhIHBhcnRpY3VsYXIgY29tbWl0IGlzIGFzIHNlY3VyZSBhcyBkb3dubG9hZGlu
ZyBhIHRhcmJhbGwgYW5kIGNoZWNraW5nIGl0IGFnYWluc3QgYSBzaGExLCBub3Qgd2hldGhlciBv
ciBub3Qgc2hhMSBpcyBzZWN1cmUuDQo+PiANCj4+IA0KPiBJIGRvbid0IHRoaW5rIHRoZXJlIGlz
IGFuIG9idmlvdXMgY3Jvc3MtY2hlY2sgZm9yIHRoZSB0YXJiYWxsIHNoYTENCj4gY29tcGFyaXNv
biB3aXRoIHRoZSByZWxlYXNlIHRhZydzIHNoYTEsIGlmIHRoYXQncyB0aGUgcXVlc3Rpb24uDQo+
IA0KPiBUaGUgcmVwZWF0YWJpbGl0eSBvZiB0YXJiYWxscyBoYXMgYmVlbiBkaXNjdXNzZWQgYnV0
IEkgZGlkbid0IGZpbmQgYQ0KPiBtYWlsIHJlZmVyZW5jZSBpbW1lZGlhdGVseS4NCj4gDQo+IFBo
aWxpcA0KDQo=
