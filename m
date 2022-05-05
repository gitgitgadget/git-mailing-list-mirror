Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AF2C433F5
	for <git@archiver.kernel.org>; Thu,  5 May 2022 06:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237233AbiEEGkl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 02:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbiEEGkk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 02:40:40 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2071.outbound.protection.outlook.com [40.92.90.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032231A3A7
        for <git@vger.kernel.org>; Wed,  4 May 2022 23:37:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4BrzJawRvWXg8CHGK3m3lIFTKukUfkziRlZtzcx3Qr7NxUBRHRlZOqQS5T6GWegvvJP2BuII0jMMJB+ps5rJhDFiyzV9+Q1XFUvXzObmt7RBe47BG8YmzqOsbDmCXomOVgmHPZYnpapm1495WVaBFmy2Tzpq95G/INJokByx8nXwdhNQugq7Ex2Q2/CY4TfrqZ3U0ugT08KZjTvAlLAjJ42RlTHaO3JafuiAz2nTtl2HEBwu/p660QW6fHvrLtonzg8fglv0czNTsTBRqjFOFrHhzr8KMHQnklM/ijbM3WSLZj9bMJHYyGrYQbyQ7HFmV0aoBctFY0OOMHdFxn/Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRvjhpND3qZsbVQAItP+QAk/kEj1prnc1hlRU/q6Kho=;
 b=YgBH3b/TYHe8VXTFmKw4ZxNho936Nprx4pGe+hhhT/OiMGa6m8lOUGhes3oFpHPSIAF2v2tsfGsWNohKWq9Jw5AzxJNwLtPQtAUUWE7PexrZC+WtdJdDJAEVbaz2LszMcb0/ay4pIIZ2ecCJNWqsOAymSQQ5Yco0MAj//YUce6ktzzdihWIzYJ1iBIjizPmRmJf2Ieet2W7QUToWK2rIyXWj8urqYjSQ7nE5JqoH72D1Gdl9JvHNZMrG2J5/HPf+V8jEGHHYW/cF9gVeroxtGLX1tU/WNeKsdfvJ8TKnvMbDXPiFputLY2Arqo5DLFFdnUgbYGd94e/UDy++xN6o6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRvjhpND3qZsbVQAItP+QAk/kEj1prnc1hlRU/q6Kho=;
 b=WMY/ff2xuxFsgy1K6Gp8+P8FNk8dcPCErHnnUsnn617s10MG/eq5JwDBgn7U8H4XoaCNuYo4z/GB8JP9hmE9kh8+Jd8dtRo+qsTptTUEXvxUxF2XjYsEF0JC2bBbIWGr3znLWT0AbOd/RnCN3rlUxMw7zPqU2UtQgmeKEREhUrGbtEGzuOlc4rD4zmEZXMr1UCmWs6JxDzHAPqWTTbtpvCkIrqB860RJRSjd+PtZZY3R65F3893yPhiNeVtkEid97zxHl/vzYao7Hr2h8CVNNWrWSkU7Iw2Ux0HiVHj+RxjFfJWo99ydPjTSxUN+plLH2fOlJrfVm4sq9L9cR9ZNkQ==
Received: from GV1PR01MB8562.eurprd01.prod.exchangelabs.com
 (2603:10a6:150:25::8) by VI1PR0102MB3581.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:1b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 5 May
 2022 06:36:45 +0000
Received: from GV1PR01MB8562.eurprd01.prod.exchangelabs.com
 ([fe80::609d:709a:dcf7:1641]) by GV1PR01MB8562.eurprd01.prod.exchangelabs.com
 ([fe80::609d:709a:dcf7:1641%5]) with mapi id 15.20.5206.014; Thu, 5 May 2022
 06:36:45 +0000
From:   Rihards Teteris <rihards.teteris@outlook.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Missing commits with git log --follow
Thread-Topic: Missing commits with git log --follow
Thread-Index: AQHYYEbFXBDTjqbBUUCDeskMYWOAvK0P05i8
Date:   Thu, 5 May 2022 06:36:45 +0000
Message-ID: <GV1PR01MB8562EB91A12876611CDD8371EDC29@GV1PR01MB8562.eurprd01.prod.exchangelabs.com>
References: <GV1PR01MB85627EC349E8893EB3B5F47CEDC29@GV1PR01MB8562.eurprd01.prod.exchangelabs.com>
In-Reply-To: <GV1PR01MB85627EC349E8893EB3B5F47CEDC29@GV1PR01MB8562.eurprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: c545050c-bd04-f2d8-30cc-ca83b4493b81
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [/7vLCMS2PSeQdidcxNcnlJ4Ya5OuYYFahMeWZPjR/pw=]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b563f2e3-7d0c-49dc-7bfe-08da2e619ff5
x-ms-traffictypediagnostic: VI1PR0102MB3581:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dByD/apvaUDDctGpvqwjg/AdobjPdqD8sx41PznO9cTThPzBaqN9IfHfy7yFCFeAx0enITYK6T/bxzIbz7o/GBDqvtbTcIvx5YXsgSsy06FIllwTiGuAc6wn9zGvA4Cp3Z8HkuNT+uVwEm3axqwOjIBleuqGEq10jbH4/mu/ClRGzJtwFByIIdn8c96mQElUr3zjQfT8dnwdeQ7i6Hea0lr1FBqh+nwK3zhvTRehMLNYn8ktMvhf/bOuUcJG4KgOJmsQnmxkhJjALBUl86HPQuTvn2oVOYgHVJNquInCD6uLDrYushMuPm+h9ci2pvc+qgRR6Z0X4oY1NC28tzADprO4Lp56/ujKbxj7SGdzBe9MFG7+RgwUZLwlZZxNpbuBH+qL4R/TzqI3QKH6ItNQEaITdU8cSm8esBFaEwcQ5hP71H8oI+gs08sCJih1773ocIgHmUPfalMc1iMZfWFizOS0a0MUsICJIw7lAmCXMuIwOpS1m+D3e2CzfMAO8q4AYxZa3ktOkgSoQUueF1iKayCbVblrVkkyJAC6QpdEu7CoFiIBENWr3oLZOViGwakvEEFF0u10EFeyK2aG4KNiThMzRzFTxXkJjsNbmcF/ivjpCj8UatE4tB4Kpxz9Bs9TxJ3Y+PMWu6L7wfUPzuKmpw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PhcfMDEXXv/Q4w4iuhY4YwYescXQ00Q09t+SgXdXNi/eIxAxi7SLiHOID2?=
 =?iso-8859-1?Q?Hxa20RVXtX+fQtVojFn0v+CCiHo/TsYkZ42hPcEcm9L4SBBiq8XShQIf+g?=
 =?iso-8859-1?Q?HROCVqy7jgQ4dZ033A/hhE6pv4eVbED56hGNe2j308G16C5LvJI455tRlb?=
 =?iso-8859-1?Q?U+J6f0Rw+XXFEO5fKdLnkKAntDrKFRl0U45qWYedS+6b0n/NskxTqMmVbw?=
 =?iso-8859-1?Q?irBBtZMopPA7xfdCzRe0BfumsTENGlzKHkXgSCXdFJqV1n8nUFjxuJ0oev?=
 =?iso-8859-1?Q?djgFEzYk45tYKydEeCIOG2PiwzvIz0upJeBtCXThUyg51lUjzovn2GA/vy?=
 =?iso-8859-1?Q?/pYjqeS0ImjdrYgi5YNSr+gfoyxOrL0iph0C5pmxNxeXTQ6f4MCXD0HHe5?=
 =?iso-8859-1?Q?K5vFx9/+K73Y4xO0NEKFV00iDX5wznRwn3b95BDqQug76rHePvc1/iMWCN?=
 =?iso-8859-1?Q?+mgV/CSpO1nwdEZWGzSSblXmV4xzzBm3jio8f/Q+0tJXClxHbhwp0iffy/?=
 =?iso-8859-1?Q?/5otBGGXcvP6llVItJMfKSwqDP9y7cxvXkODJzyPlo8eVJ1dMOdpJ5RDQb?=
 =?iso-8859-1?Q?0FruP/s9Q7J/WjVwMdMmcms1EsxwfE3uL7U2/RiwkXlNVNwsDyJQoDO4fC?=
 =?iso-8859-1?Q?Ngx9IXsm9y1M9lFb7B7SQU3QL2PELHM2lon52xMNwiMAIp/WeTdXoJxHeN?=
 =?iso-8859-1?Q?Pk8Asf5oyDltn+/0sDtlMmZkjip8N+MH4fubPA2MgbTLh2+z+fOAeQ7oBR?=
 =?iso-8859-1?Q?LGM4ZIk/yobLx1y2867OWdqhhdXHAkninE7sddqtM/FYf3Tqn3OUTlqni3?=
 =?iso-8859-1?Q?NwNatTLu7crLJ+gZ5fdjdqGNT7VLy605jiBEs4q7buclQYWtkrFYM0Fe0j?=
 =?iso-8859-1?Q?O7/l5g65NCL/7/FIPrhGWQvb5YXEj3U/+Manrk4J8URtLWJzUFn6Pug6qh?=
 =?iso-8859-1?Q?UrAKahgpIjmICZjwatJ2dhwLUx9zTEooSblGrCz/fshIeM3hPtSBg64vKx?=
 =?iso-8859-1?Q?ARboUVUjpeiVBJbRFRIwML6kVZo7UApbzlawWp4Zj01k9E4aaYTuwZKdTq?=
 =?iso-8859-1?Q?bUJgg8iC5SrBIK4Q1UOgxfZLMSFGUF4iEoHnMks6KalRPGLWiBN/kcCYiG?=
 =?iso-8859-1?Q?6XilaW6jsZ9IG7jHZE4vCLkOZdRRcWhOqiJSjTo1bRPDDYv9DTkrtH8cj4?=
 =?iso-8859-1?Q?dcQMt7Jr7dYn9tJdnBi0Y6yW+mCQmkYAADuP2KHWEnQwFvr7jL/tdXyQmR?=
 =?iso-8859-1?Q?zq0JTFCGydkHfpH/t59kOu62S0x3beFNldXMMenSEHSaO9Sn9oLkc6UC9I?=
 =?iso-8859-1?Q?ghBxC77XdOI8Lh9Wr6kLdlBUpIlaXcGlR4srwy1wig85eL+lwU/Z6ySbm2?=
 =?iso-8859-1?Q?N92rzhE+fZ2xMyd93H63osseYDyOmAH563OPVetn6zTG2kXHi6yb9wJCaG?=
 =?iso-8859-1?Q?R2n+AV4jmBOm0SYy7/5F5ngHI7PtGZxwQ9bdNnnre2K1vq2yIP+gybK+v8?=
 =?iso-8859-1?Q?q+W4upfCDb36LKJlM9eomM?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR01MB8562.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b563f2e3-7d0c-49dc-7bfe-08da2e619ff5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2022 06:36:45.6248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0102MB3581
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Git,=0A=
=0A=
I think I have found quite interesting bug.=0A=
For some files git log --follow is missing some commits, even though I woul=
d expect it to find more commits.=0A=
I found a case for that in the git repository itself too:=0A=
=0A=
# git --version=0A=
git version 2.36.0=0A=
# time git log --format=3D%H contrib/git-resurrect.sh=0A=
e37eae0c1e13cb418947383f7c803d9463bfa3d7=0A=
d047154e7b2ab9c7191b0d72484012085051d521=0A=
3c833cae446364872b759c7622af2760a2f81a11=0A=
fba275dc93319ffa31ecebe015f8cda671fcf0e5=0A=
51ba8ce372ad9fcab04a013252b819625c44770a=0A=
50ab6558bf688e15048e189bdaf9174b217e1748=0A=
e1ff064e1bffedb917c491681b7bfd4d66633ef5=0A=
real 0m0.631s=0A=
user 0m0.428s=0A=
sys 0m0.120s=0A=
=0A=
# time git log --format=3D%H --follow contrib/git-resurrect.sh=0A=
e37eae0c1e13cb418947383f7c803d9463bfa3d7=0A=
d047154e7b2ab9c7191b0d72484012085051d521=0A=
fba275dc93319ffa31ecebe015f8cda671fcf0e5=0A=
51ba8ce372ad9fcab04a013252b819625c44770a=0A=
50ab6558bf688e15048e189bdaf9174b217e1748=0A=
e1ff064e1bffedb917c491681b7bfd4d66633ef5=0A=
real 0m1.386s=0A=
user 0m1.272s=0A=
sys 0m0.066s=0A=
=0A=
You see that with --follow 3c833cae446364872b759c7622af2760a2f81a11 commit =
is missing.=0A=
=0A=
I also timed it, to note that git log --follow can be much slower. In my pr=
oject I have seen a case, where git log takes ~10 seconds for a file, but -=
-follow takes ~90 seconds.=0A=
=0A=
Thank you for looking at this.=0A=
=0A=
Best regards,=0A=
Rihards=
