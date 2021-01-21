Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC98C433E6
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 13:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D862239A4
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 13:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbhAUNuK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 08:50:10 -0500
Received: from eu-smtp-delivery-120.mimecast.com ([185.58.85.120]:39184 "EHLO
        eu-smtp-delivery-120.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730352AbhAUNuA (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 21 Jan 2021 08:50:00 -0500
X-Greylist: delayed 6547 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Jan 2021 08:49:57 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=visionrt.com;
        s=mimecast20191204; t=1611236887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qswJaVpI5EprOrfyZDJdEg34bsD4JfKSkQFL73fV7+4=;
        b=LSxEIk9fHbuaQQEm0HCtjFAUg7dfneloraTl5isXCQNWUiIwq2Hbg+7XNBwB2G9KXifS7N
        337EETSwcw6SRCrwluCQl0W0LN/dbSMjQL/7NkUyvX0KdAZl+CLgwsrPGeXtE9yhWX5KyO
        181b5avSE11XJilxXzulHg5arsnWupg=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2058.outbound.protection.outlook.com [104.47.9.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-108-AQ4BsRyHOw-Tt92-rReuZw-1; Thu, 21 Jan 2021 13:48:03 +0000
X-MC-Unique: AQ4BsRyHOw-Tt92-rReuZw-1
Received: from PA4PR08MB6096.eurprd08.prod.outlook.com (2603:10a6:102:eb::17)
 by PAXPR08MB6637.eurprd08.prod.outlook.com (2603:10a6:102:153::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Thu, 21 Jan
 2021 13:48:02 +0000
Received: from PA4PR08MB6096.eurprd08.prod.outlook.com
 ([fe80::839:64a5:5a8a:77fd]) by PA4PR08MB6096.eurprd08.prod.outlook.com
 ([fe80::839:64a5:5a8a:77fd%6]) with mapi id 15.20.3784.011; Thu, 21 Jan 2021
 13:48:02 +0000
From:   Tim Yorke <TYorke@visionrt.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: FW: Bug Report: changes to submodule's files can be silently lost
 forever
Thread-Topic: Bug Report: changes to submodule's files can be silently lost
 forever
Thread-Index: Adbv7FfIjDgyzKf5RZGSZ0Td4WKuGQABLU2g
Date:   Thu, 21 Jan 2021 13:48:02 +0000
Message-ID: <PA4PR08MB60967539EC75C9AACC4C46A5A9A10@PA4PR08MB6096.eurprd08.prod.outlook.com>
References: <PA4PR08MB60969AFFD0607BDBE3ACBBE6A9A10@PA4PR08MB6096.eurprd08.prod.outlook.com>
In-Reply-To: <PA4PR08MB60969AFFD0607BDBE3ACBBE6A9A10@PA4PR08MB6096.eurprd08.prod.outlook.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [81.111.196.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74ca824c-3026-4075-0cff-08d8be132c20
x-ms-traffictypediagnostic: PAXPR08MB6637:
x-microsoft-antispam-prvs: <PAXPR08MB66371237C44BCFD28A0FF704A9A10@PAXPR08MB6637.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: WYRf7PGiWXxH1xD8mL3JV7sAMFEpK4HXCpGIMQIjvuZIJ9hEkhR74Nx3eyG1ma5L0kfj/j2NCMVgyW8YUV/DpOn7xpI2K1xCvWa3DvBW204bx6fcodJZkMaV/FY/4IRytTotgDKBR7kQd/GltTQrBTreZrDRwv+GuJMQIbohkCWrmmfTFkWBVwd+tX2AiUNix3wTuUt4PeG1qRDE8KfbLRnKnWiqdNIcmgUQM/1jrePN+7ZjwVfNTfaDEKSmA8Uy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR08MB6096.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39830400003)(376002)(396003)(346002)(366004)(71200400001)(52536014)(7696005)(6916009)(4270600006)(2940100002)(73894004)(316002)(2906002)(8936002)(8676002)(33656002)(621065003)(55016002)(9686003)(86362001)(6506007)(64756008)(26005)(66446008)(66616009)(99936003)(76116006)(66476007)(66946007)(478600001)(66556008)(186003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?L4vMxg2tr+CnXFGdTnljkYGAdCF9Ds9uS6eJLaT6WnEyTYTwmim958oMwKjy?=
 =?us-ascii?Q?wzChLqMlAGlOyCtuTTEUmZb4zhatWRMm2E1wE0eo8zijL+0P9N9za2p7Ggcd?=
 =?us-ascii?Q?gkdehjRvk4cm0AOS92GOuQBdy8ypr0sOqWvqlobXTlL1nEh/Z8FGJdMOhtIk?=
 =?us-ascii?Q?+tBiKzFsPas7r46u3LtT6nkZfV99mKHMbqTa7lCQy81SliYW8NKVuxASKYo8?=
 =?us-ascii?Q?1V/NgcUSXOcbKKQPQWR43wWnF861KVen/sFEZEEu2V7O0JNUy8URto133CuO?=
 =?us-ascii?Q?mLYs551JC25yMryd36QKO3Y4dyxhRqaqH5UL0qFpRtK/PtMAhP+KxI/XIkRU?=
 =?us-ascii?Q?2rppvdn6YYpQNrb7y/SuqpjzqbAKFkLNSdXMmLwa1vpTkzXims/J+Zyb41OZ?=
 =?us-ascii?Q?l6tWAWelihIgXiCNh6WnuMnfGRpFP9Fcg8zNk6LaPk4YBbvpcCq8ppatsjPb?=
 =?us-ascii?Q?H3WUWYTrdsc0RBz573OEV9b3JgrjrUlsWo5IKxQHqU9+/y1r+jKd657DEppI?=
 =?us-ascii?Q?tJxFG0Iw3ByQHuwBISmcISUxUDJ1zA8QxcRBE2FfBCDmb0iypvDfVkl7aEf3?=
 =?us-ascii?Q?ZLyNulLba4I+V1LeHsgzG7IeAGpp8IQXbZgmRwi/EueQFc9lFqOnhWXIyyW+?=
 =?us-ascii?Q?RWDZnAY0PT3utGLkQgJGOea9PmnbiIdHldPmh7+IhoLhl+w8IpGwjkCipF9b?=
 =?us-ascii?Q?8omyqP0uIXNbJV2BUawS00Z45rxdv6RMqw6P4XNeRPecm7MBvbF4uZd+XT1s?=
 =?us-ascii?Q?PriVKK2PuXCRdMlMz5M5x55ReDJ68u6CzVAJ19+7xXegHZMtB75mtwVky+Hd?=
 =?us-ascii?Q?ax8Bh3uUgimNBJZ6MSYn8myNgVHZeI9Df30a0kYhScd3Y2ngo8zlvT6jJSS3?=
 =?us-ascii?Q?X3i3oVFIOnKW5BCXdM4i4UhY+0tRPs7t/TNcBNDJGeBRyajXifGfSBt1Lwtt?=
 =?us-ascii?Q?597nnZ+60iP8oRdhZU18dzbBsXWmRRhjV5GQhqnd4JE=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: visionrt.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR08MB6096.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ca824c-3026-4075-0cff-08d8be132c20
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2021 13:48:02.6072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1ab1dc98-6ebd-4bd6-ab7b-282733886435
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6kTvJ8szDtOda1boF50PBZeirfEJihNDBl14tpOb/QUq+RTkJgMF+o1tE4y9AaNMMG/8hvaDF1SRum/2n25NaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6637
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C20A144 smtp.mailfrom=tyorke@visionrt.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: visionrt.com
Content-Language: en-US
Content-Type: multipart/mixed;
        boundary="_002_PA4PR08MB60967539EC75C9AACC4C46A5A9A10PA4PR08MB6096eurp_"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--_002_PA4PR08MB60967539EC75C9AACC4C46A5A9A10PA4PR08MB6096eurp_
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable




--_002_PA4PR08MB60967539EC75C9AACC4C46A5A9A10PA4PR08MB6096eurp_
Content-Type: text/plain; name=git-bugreport-2021-01-21-1110.txt; 
	charset=WINDOWS-1252
Content-Description: git-bugreport-2021-01-21-1110.txt
Content-Disposition: attachment; filename="git-bugreport-2021-01-21-1110.txt";
	size=1607; creation-date="Thu, 21 Jan 2021 11:53:11 GMT";
	modification-date="Thu, 21 Jan 2021 11:55:43 GMT"
Content-Transfer-Encoding: base64

VGhhbmsgeW91IGZvciBmaWxsaW5nIG91dCBhIEdpdCBidWcgcmVwb3J0IQpQbGVhc2UgYW5zd2Vy
IHRoZSBmb2xsb3dpbmcgcXVlc3Rpb25zIHRvIGhlbHAgdXMgdW5kZXJzdGFuZCB5b3VyIGlzc3Vl
LgpXaGF0IGRpZCB5b3UgZG8gYmVmb3JlIHRoZSBidWcgaGFwcGVuZWQ/IChTdGVwcyB0byByZXBy
b2R1Y2UgeW91ciBpc3N1ZSkKCi0gSSB1c2VkIHRoZSBjb21tYW5kICJnaXQgY29uZmlnIHN1Ym1v
ZHVsZS5yZWN1cnNlIHRydWUiIGluIG15IHRvcC1sZXZlbCByZXBvc2l0b3J5Ci0gbWFkZSBhIGNo
YW5nZSB0byBhIGZpbGUgaW4gYSBzdWJtb2R1bGUgKGxvY2F0ZWQgd2l0aGluIG15IHRvcC1sZXZl
bCByZXBvc2l0b3J5KQotIHBlcmZvcm1lZCBhIGdpdCBjaGVja291dCBpbiB0aGUgdG9wLWxldmVs
IHJlcG9zaXRvcnkgdG8gYSBjb21taXQgdGhhdCBkaWRuJ3QgaGF2ZSB0aGUgc3VibW9kdWxlCi0g
cGVyZm9ybWVkIGEgZ2l0IGNoZWNrb3V0IGluIHRoZSB0b3AtbGV2ZWwgcmVwb3NpdG9yeSBiYWNr
IHRvIGEgY29tbWl0IHRoYXQgZG9lcyBoYXZlIHRoZSBzdWJtb2R1bGUKCldoYXQgZGlkIHlvdSBl
eHBlY3QgdG8gaGFwcGVuPyAoRXhwZWN0ZWQgYmVoYXZpb3IpCgpXaGVuIGF0dGVtcHRpbmcgdGhl
IGZpcnN0IGNoZWNrb3V0IChpLmUuIHRvIGEgY29tbWl0IHdpdGhvdXQgdGhlIHN1Ym1vZHVsZSks
IEknZCBleHBlY3QgYW4gd2FybmluZyB0ZWxsaW5nIG1lIHRoYXQgdGhlIHN1Ym1vZHVsZSB3YXMg
bm90IHVwLXRvLWRhdGUgKHVuY29tbWl0ZWQgY2hhbmdlcykuIAoKV2hhdCBoYXBwZW5lZCBpbnN0
ZWFkPyAoQWN0dWFsIGJlaGF2aW9yKQoKVGhlIGNoYW5nZXMgdG8gdGhlIGZpbGUgaW4gdGhlIHN1
Ym1vZHVsZSB3ZXJlIGxvc3QgZm9yZXZlciB3aXRob3V0IGFueSB3YXJuaW5nCgpXaGF0J3MgZGlm
ZmVyZW50IGJldHdlZW4gd2hhdCB5b3UgZXhwZWN0ZWQgYW5kIHdoYXQgYWN0dWFsbHkgaGFwcGVu
ZWQ/CgpNeSB1bmNvbW1pdHRlZCBjaGFuZ2VzIHdlcmUgc2lsZW50bHkgbG9zdCBmb3JldmVyLCB3
aGVyZWFzIEknZCBleHBlY3QgZWl0aGVyIAotIHRvIGJlIHdhcm5lZCBiZWZvcmUgSSBjb3VsZCBj
b250aW51ZSBvcgotIHRoZSB1bmNvbW1pdGVkIGNoYW5nZXMgdG8gYmUgcmV0YWluZWQuCgpBbnl0
aGluZyBlbHNlIHlvdSB3YW50IHRvIGFkZDoKClBsZWFzZSByZXZpZXcgdGhlIHJlc3Qgb2YgdGhl
IGJ1ZyByZXBvcnQgYmVsb3cuCllvdSBjYW4gZGVsZXRlIGFueSBsaW5lcyB5b3UgZG9uJ3Qgd2lz
aCB0byBzaGFyZS4KCgpbU3lzdGVtIEluZm9dCmdpdCB2ZXJzaW9uOgpnaXQgdmVyc2lvbiAyLjI5
LjIud2luZG93cy4yCmNwdTogeDg2XzY0CmJ1aWx0IGZyb20gY29tbWl0OiAzNDY0Yjk4Y2U2ODAz
Yzk4YmY4ZmIzNDM5MGNkMTUwZDY2ZTRhMGQzCnNpemVvZi1sb25nOiA0CnNpemVvZi1zaXplX3Q6
IDgKc2hlbGwtcGF0aDogL2Jpbi9zaAp1bmFtZTogV2luZG93cyAxMC4wIDIxMjkyIApjb21waWxl
ciBpbmZvOiBnbnVjOiAxMC4yCmxpYmMgaW5mbzogbm8gbGliYyBpbmZvcm1hdGlvbiBhdmFpbGFi
bGUKJFNIRUxMICh0eXBpY2FsbHksIGludGVyYWN0aXZlIHNoZWxsKTogPHVuc2V0PgoKCltFbmFi
bGVkIEhvb2tzXQo=
--_002_PA4PR08MB60967539EC75C9AACC4C46A5A9A10PA4PR08MB6096eurp_--

