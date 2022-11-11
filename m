Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09231C4332F
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 02:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbiKKCPg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 21:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiKKCPd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 21:15:33 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFB360356
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 18:15:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+8C0MM6snHRRdjz45vP94VG9Wd0hQv3ew58OaEYX8WG1pChhi/2RIU/FpbH19rRI7PXjr0+QFNNI5x5yEo+GvDD0FkiNVpM04OktMrYL2kvqlWsvgWmlDhqV+gKOpbqFxprE9v29KQY5VG20tT0lsM4eD/SZ42Yhb9Lc8L1b7BqvRypwLKIGVRyr70Re6ScRRc+ix+oPGbqicSHXuK5CV4Y9rvelv5guEAtmJWlWtchgW6GBYUW3p7RJ2kh8d3x5/KLitjXnVNYLXZKkygRenB2DHuiYub3iVKYg9sIDuUTMYE64EDvFOtL3ZcJoD1R13/fjRRnO0vL6mNZ1maqEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2EQpht7SwVrC7cYIEU6mIaJOjwT6C8xAqfUXZoza2k=;
 b=ZCwETKb8lEvhsdYw2C0WCFoOX8TykJZNSnYfRJ09DBCTlvq9ItiFN31dZ9SBqBsqclNfF95DvddwpKlIvjQUVxyt2velUlqLjs/gH6G8OAlO1sN1XQmM2uZ6RrRavsK/dKIsl5CSQm53DPnNdBoWadZD794WWL1XPw5LM6eUN+zp4//4df1vz7zWcA+l/9kzunCBmfXXFI3bvS5ahA8ydnTW8M+SeB0llq9JnIbk/xVVGz0+lvnflNavR3MyE4gdUaVyO8o7aGpGcPfhWbV8rQa5jl3cKo4/zG1f/QMwJeLjkjMQZfo/uslLoEFvakZX8kL94avtnwpEaUDKVhHK5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2EQpht7SwVrC7cYIEU6mIaJOjwT6C8xAqfUXZoza2k=;
 b=oMiyBNDVoChEjbNMRi9vhzUnIo5vVMFzCHBLeAlDb2r39ZU6PTXLnUI/Daas6KdNkfvUnYbIZNzr28T28a+wbIyarj54UvQjmcijl70hPh/DGvBTxnaE1dNnLEriZazBZwO6pA6JAoPf3QqrmB/I+J1V+5yatUQXX9jQDrFWbeg=
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 DM6PR12MB4107.namprd12.prod.outlook.com (2603:10b6:5:218::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.13; Fri, 11 Nov 2022 02:15:27 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::70fe:fd7e:da10:fd66]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::70fe:fd7e:da10:fd66%6]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 02:15:27 +0000
From:   "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>,
        "Tuikov, Luben" <Luben.Tuikov@amd.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 2/2] Update sendemail-validate hook docs to add header file
 parameter
Thread-Topic: [PATCH 2/2] Update sendemail-validate hook docs to add header
 file parameter
Thread-Index: AQHY9XN3JiXZNo7x70eId07QZtOeKA==
Date:   Fri, 11 Nov 2022 02:15:27 +0000
Message-ID: <20221111021502.449662-3-michael.strawbridge@amd.com>
References: <20221111021502.449662-1-michael.strawbridge@amd.com>
In-Reply-To: <20221111021502.449662-1-michael.strawbridge@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4356:EE_|DM6PR12MB4107:EE_
x-ms-office365-filtering-correlation-id: 22872178-3e85-427e-a684-08dac38a99a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WyD4WnLX9Qx5CAy9CF2u2Iks2gD3x90IIw/Epn+ar83nHdrVIhDH12sLe1+l4TKykZhHh/0RGftz1Xf7BKVly8mNEA6A/TprrZwAai6gL8dYPURBqTBBTCoHdN8cMTvtl67ZJcxlj4+pYerGvAAokaOarfmkLyc4lVuuBNlEiM1FnZfYFggRRbStJdZo7UWSYIJMK9lAZJrODKhlFm74l9n9CaH6OJL4/CsXsjhsfX7sSZCOBWNHXLsFXTvfV4kYUllh6YDIMe6kYOnccROcFbwoajq8pbcZzORmZfjrnUon3SbRidWrF8O+x2IbHjaXpLhAChSHQY4mWZTHJRHokTQ44HpfA6+bWWfLGBUs3bziv38C2G+VmWUQOnQMMsRZPr5TWl1HDvUwLGOB55ED/Vvq9E8jyPtecimyhIfuHDqZ8JKMBXYYvV3hL+G/9h0h5WE+o1lpjQl3e9nPtZTspuoVoLRJw76Uk26dKNGCxvm7reTAFI8+ir93h3X9Ezkq6vGeaL2IA4ktxWJfk7m5o4Vcll88dwvdF+SOcOOKBEmcMYkyCZqg5MJSXpaz3CHjIgQ3/j0N2zOchHq3PD8vVibP2imzrDS52CzO6CowXnQwrAEENqOoOfcJr80BX4hXBypKQpmeE2yWSm7dnE0cJIXYi3xw9NXZd5iH03TbQjDg2xLVgJUi2Q3+sImcAKfLA3CuQk9Ug+2tDCrGH7antJHyloHYjNbO3Wk6b69uJ1ufpUl6jB3tji5BGTMzyx7nSVPAtyQ3R+pjD6Qz4NC4tw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(451199015)(38100700002)(122000001)(15650500001)(86362001)(38070700005)(4326008)(6506007)(2906002)(26005)(66556008)(6512007)(66446008)(66476007)(2616005)(64756008)(76116006)(91956017)(66946007)(6486002)(71200400001)(8676002)(316002)(83380400001)(8936002)(5660300002)(1076003)(6916009)(41300700001)(36756003)(478600001)(186003)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?sHwP+Y4GVbI2ImKzD0yHivrCczab7EVAhrJZPsBXlsb+q5WDVMHYxYalVd?=
 =?iso-8859-1?Q?xLIFzBKleMohoLZmQjLSrPrAman6Bx1gzahkO43iU/N8AWW9CcDwupOp0S?=
 =?iso-8859-1?Q?RHjjekbrrBLLg6lLI8G5NDkjFXd87efUl8DSFsx+M/HmgkgNexgxBYSmrY?=
 =?iso-8859-1?Q?S0lU5niJrnUdRpeXzgZRC21PpHa7s/VvrfBvljip0JLwrK+QKLP+/fzLHL?=
 =?iso-8859-1?Q?n7Plo5l6juAsuTKNFxMKxO96hbsf3xyoNZ5cS2nF19iEnlaNKxOkr9bXYl?=
 =?iso-8859-1?Q?XBgBWWusHG3NMJPmHNmkuiIeusL0lvQN1KHEDH7wAkHcQPwmWMP9tg93H5?=
 =?iso-8859-1?Q?//a/MqM1hmz6KwaotHIA0PeGFaCwfeoLPTZ9huWTaDfn98apoLdT6tOA4Q?=
 =?iso-8859-1?Q?kxtOs75ecqU+nIA7K51psUEJfNq3FwCLgt6DMfcHNxbQONAP3yp/zeQpLR?=
 =?iso-8859-1?Q?72+kS27uO8pGGOhcYMG1jogvjZRJpwNa2NeGcG57ThIMzAwvUjjXhDfycs?=
 =?iso-8859-1?Q?lGG98TW4TT/sxh2ZxUcOfdP4/7uVopsxQsq+P1GOCTIK4lxldsKLe8CEnB?=
 =?iso-8859-1?Q?vy6aLYz056XB94i9CMxywRGtCfbOlZS/EBjnmcSJ5L4teEltZ/xBmxd/m1?=
 =?iso-8859-1?Q?jhb8THIT9yQ+fEeUu/0fyPNpff2GFLrebPSjGtneM5dKPFWyfS/c6z3HNj?=
 =?iso-8859-1?Q?FlKP1nvI6JfTdaVGodFdbYRvV7Am/LzxYi3b3zXc+w7j67oH1TBg8gQr/B?=
 =?iso-8859-1?Q?QKnk7e5QQDKR1gHUgweiKaSGUDYqd/kjpqmHjfYmvUxVnUDQQjdQimA3Jw?=
 =?iso-8859-1?Q?j3x/1+wzeyFfqSc8DBFGWtl+QKasorWKEATR/SM5ZoC0NcvBu2N6gxynFD?=
 =?iso-8859-1?Q?4rTBpyyMNJ2H1J0z5RHFakpGpRW8ohlHwORyxZNKaiK9xjpzE5vS8Kh9Tm?=
 =?iso-8859-1?Q?vF4U2tuK5PskdKlYBdGVxKg57YsKTAL4r/6P7DiQwH3jwgvisjUMGtnwl6?=
 =?iso-8859-1?Q?DKrmK0kDynA2UNUiwB9GA1xJcnZJuqHvlADb2YMl45wVaCjWrc7M/58P/q?=
 =?iso-8859-1?Q?HyJEF5s9sH9XlN8916lYSN+uuN/1HL0w/mOPdy8gRrlCDftC9Be/taty3H?=
 =?iso-8859-1?Q?49e0VjQlxQjhP8CayxORkuZFJSl7tOHek0X7yuVxfSxRMcS5aH5YOF3xPX?=
 =?iso-8859-1?Q?0QRTsFE58cWXHUSD9m1HvDLqf7uA0JkR0UAHC85PqRSrEAkTlRwPvz9PLo?=
 =?iso-8859-1?Q?TQzHmDsrtqZc3r1YQ0oGSobjCgVzjMyK4rXvLkpQwzcn1GoKZRJzrxsa75?=
 =?iso-8859-1?Q?VeSUGavMbGpzmxaAzLWu1djsTmOVozIy4eiZuMu6tH9kLsJl4EufHpg+mK?=
 =?iso-8859-1?Q?pV8eDuEjswHymmFqNttH2bTwgpLfccOUlJlkxnT+SisqIb7bIq6gM6mPh2?=
 =?iso-8859-1?Q?ilR566uNxDcqVzciHyDY59oDby638+qvuxTI1CFvvmDSwykFXyPZtyhjTx?=
 =?iso-8859-1?Q?kDfs7fbnBk1O0t7bWHNkdj67pWTN9gmI49HXnuhOSfUrZNAaNxVDiBbZv+?=
 =?iso-8859-1?Q?Dpe2Zq91ETBT0a2k+txizsVN3RbLBpy6iDfKv5b3hvb/BoFV/U7GowerOw?=
 =?iso-8859-1?Q?eaMI0lHwd23vFvf4OOYIpPb/J7WdIikMlE?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22872178-3e85-427e-a684-08dac38a99a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 02:15:27.6510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6JfjTtzcFKTM00KLmiEeWqY2zCEVWOSvGeSsEpCJ+YFbbxA/s2yvkSpzwONjrE+q2hlCJdgSbFtkf3fRyY1L3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4107
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add documentation for the new smtp header file parameter used by the
sendemail-validate git-send-email hook.

sendemail-validate accepts the patch file as the first parameter (same as
before) and now also adds the smtp header information as the second paramet=
er.

Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Michael Strawbridge <michael.strawbridge@amd.com>
---
 Documentation/githooks.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index a16e62bc8c..c1baf34454 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -583,10 +583,10 @@ processed by rebase.
 sendemail-validate
 ~~~~~~~~~~~~~~~~~~
=20
-This hook is invoked by linkgit:git-send-email[1].  It takes a single para=
meter,
-the name of the file that holds the e-mail to be sent.  Exiting with a
-non-zero status causes `git send-email` to abort before sending any
-e-mails.
+This hook is invoked by linkgit:git-send-email[1].  It takes two parameter=
s,
+the name of a file that holds the patch and the name of a file that holds =
the
+smtp headers.  Exiting with a non-zero status causes `git send-email` to a=
bort
+before sending any e-mails.
=20
 fsmonitor-watchman
 ~~~~~~~~~~~~~~~~~~
--=20
2.34.1
