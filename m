Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE04C433E0
	for <git@archiver.kernel.org>; Sun, 27 Dec 2020 23:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 407CE224DE
	for <git@archiver.kernel.org>; Sun, 27 Dec 2020 23:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgL0Xpv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Dec 2020 18:45:51 -0500
Received: from mail-eopbgr770137.outbound.protection.outlook.com ([40.107.77.137]:13803
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726303AbgL0Xpu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Dec 2020 18:45:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ux1r44UFO29kt/xCgXB4xpG9QPlFMHHbY0bdE7FIrD1V/Ry4cGDLDeD/AfIbAAXxuUHI9OUAZXRtHh/SrW1i7CUQ5jk74+dhACMr3pgB4CHKO65rLkoPXs3OoFoHWLoxRauZPJis8oqZACIVOLrFFUKV06MogX/wvyemKCjROC5pUJgetLtRBQ8E7IB7szpN33SIUUhFNzFbp4cfEmfkf89VijVWRzsC5QMkalO1m2xioV1V+c5rXq19EGLzsX3sJMWZ6CC6PEckMSwormEmLh8/HkIVnY/ljhz/MY53ZIvRk6N5XHoCKSgwIN9n38873tCyl6MyNwC07aIFYfXf9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtXeBt2YfOhRUjr925F7ZfUlZDGmCX7zklb5pEISgDo=;
 b=X06Fc3v5RoXkCEA8iKrQV9RQxln2DsQOtiorFjEUqhrHIJ5C+wsOYz/P4wX/H1ny7JD6pGff5w16gQVRm934u9CIv+7ZHTrzb87RmtNsZWdfJqlT2qQSr8lotaoLx4gpV4AEaOQjw2sHm3P94+FmopkCi8szbqI492IUFeR6fCqO3jSTHM+9SCSxDTTKmD8TOwiNZ1AvTKOzp08fhncJ4MswHTR68dC4OWd6IkyIV8JnspBYfaWk9oBGJZLZQeykh957mFU5AnESC/o3U2oyZ1wvK2F6dxWryuoaUVhSc+EVd8zgnWjphxBBe8fKLdrp3j5Ie6XgiWaEMl4MPsQJ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtXeBt2YfOhRUjr925F7ZfUlZDGmCX7zklb5pEISgDo=;
 b=Fv8bNDA7LRM5V1BrfUn9i94tvi6eMkhrKCXebrca5y4dltXMcu6HQieqlc3O8rKjSlJ5daW/V9mvlOfdOvfqpOcYNAIFHrNK/IXxxzjF3n4GKmmO9/fMZRHalS/A770NERCqeUKZN4OgMutTU1dm3Mnjuzo6CMnA4zc3F5woBmM=
Received: from (2603:10b6:a03:104::13) by
 SJ0PR21MB1869.namprd21.prod.outlook.com (2603:10b6:a03:2a2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.2; Sun, 27 Dec
 2020 23:45:08 +0000
Received: from BYAPR21MB1158.namprd21.prod.outlook.com
 ([fe80::99ba:5c75:8ec4:bf45]) by BYAPR21MB1158.namprd21.prod.outlook.com
 ([fe80::99ba:5c75:8ec4:bf45%9]) with mapi id 15.20.3742.002; Sun, 27 Dec 2020
 23:45:08 +0000
From:   Dan Moseley <Dan.Moseley@microsoft.com>
To:     "peff@peff.net" <peff@peff.net>
CC:     "carenas@gmail.com" <carenas@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "sunshilong369@gmail.com" <sunshilong369@gmail.com>
Subject: RE: How can I search git log with ceratin keyword but without the
 other keyword?
Thread-Topic: How can I search git log with ceratin keyword but without the
 other keyword?
Thread-Index: AQHW3J2P/8NpyCHupE260gKPtUVMyaoLmzLw
Date:   Sun, 27 Dec 2020 23:45:07 +0000
Message-ID: <BYAPR21MB1158BDAEA538A78A528B6010E0DA9@BYAPR21MB1158.namprd21.prod.outlook.com>
References: <BYAPR21MB11587632058438090FE265B8E0DA9@BYAPR21MB1158.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB11587632058438090FE265B8E0DA9@BYAPR21MB1158.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-12-27T22:13:53.6751185Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Privileged
authentication-results: peff.net; dkim=none (message not signed)
 header.d=none;peff.net; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [216.9.31.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 771b8510-615a-4d48-e269-08d8aac17170
x-ms-traffictypediagnostic: SJ0PR21MB1869:
x-microsoft-antispam-prvs: <SJ0PR21MB1869FF34E6CB1148E46FDCFDE0DA9@SJ0PR21MB1869.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cPGSa8XI/JCbO1K8ZHl5Uw20fRE/dj/xSTl+Zf21qvH0VqoC1Semp/h96SCJqXIlA3cWNsYQolXsRSYVoE2AXvLCh+AfvXqU7qN5URp2kFNGwQfiK7v9rlwx7ntRHCIp0YKtNSrPu6MI5pB4bNz0HQPMCfyBfxHJkkptCd+3nvjzNfQKhBZOEy1wVHwI/wbNEpkcw8lbzdtoOudDDei1/MnM1BZqfFmnSouMthz9XSjADeGzWQceY+g0sSRrIk8PM1O4vzM+xfekAaPqJgb8MJMN3HLcLuOmrin31SYS5Nd1bldW4N8T2qnCtLaoD6MDRXFs37Ov7dQHA/oH6rAJ//IXyYgPtBG8MjTHZP8mxikN31aJvi5Qb1gSru2M6QBQ/aOva+ESdQ4pAvuIbjoYLw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1158.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(376002)(396003)(366004)(2940100002)(82960400001)(6916009)(66556008)(66946007)(66476007)(66446008)(52536014)(64756008)(82950400001)(71200400001)(8990500004)(5660300002)(2906002)(8936002)(33656002)(8676002)(9686003)(86362001)(55016002)(76116006)(10290500003)(53546011)(7696005)(6506007)(316002)(186003)(26005)(4326008)(54906003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?krXI8tbw4rcTHoE19jus+IWK+OWWoXM0MW3qfqL3Di+TaRol/ZHIT41bow?=
 =?iso-8859-1?Q?AlCSE3daXsCp8+HDaJcBjoPFVyXTPAUWwpJlXsjoOPxRR/3druaSn4xGG6?=
 =?iso-8859-1?Q?TByCSDBjPUMVezmd5XGz/19voGHEq5NIPxnNlAbGc9wTZfNizHjOpEmuYt?=
 =?iso-8859-1?Q?6U8B041jJUmpHQ8tNXWRRtkFy+pODw3+ZO+gnto+Gu634qk77CVLLizybb?=
 =?iso-8859-1?Q?T0wP02tTjvplossVWPlLGw5NXXKrmZPX6EfiHSEItCNDkRgXUunBM/Mm2J?=
 =?iso-8859-1?Q?hYk39xwhgkRoCLXs4nOSkaGpknTW1ZpSYd5y1SAvUfOgwi0+njwXrmw/Te?=
 =?iso-8859-1?Q?XM43qQe4/RUYI6a6+26BAFQX/3iset0r+cVDKgCd+0iDOuMSuaP6pI7pbg?=
 =?iso-8859-1?Q?iZvyXRBKi4GVxI7huWSn58XeY005R7nwNJw49fctJfwybcBY6gu6Jla3Dd?=
 =?iso-8859-1?Q?NiVW6tZ+VItDgrG8wwdPU5gkbIUlYPejc3rUzlNeNKFXVKMHvrhGpsSJnC?=
 =?iso-8859-1?Q?UJEygZ6FPOvMHmu79HsXj+d+BfxaPdTAB3+KaIjs5GVlrFl/QRh8pM91GS?=
 =?iso-8859-1?Q?hEaeMF13Mx2T+y15q2cDMKlpe/ciRATwR4rNu6WZqBiOFJiECg2i4hpyDU?=
 =?iso-8859-1?Q?4XDCSG7XiYw97q+BsXZyqLJS6iCezgvnHaFrvUKGnrNkTWPt7rMXQb/1CS?=
 =?iso-8859-1?Q?hab0z9eXK4gB+R6LE52BhknbAoTYlQlEJoo88b208yPG1tGub7K/O3X7r3?=
 =?iso-8859-1?Q?y3b0Qm8+MoUZ0f0XuF1SfZUS9XiPPPKPRhojwxmyS5cp2WoEFnZUGEh2OC?=
 =?iso-8859-1?Q?47qCUeYk5ZsFBPb+2jpxtnGGv1OPoIVi+0jcNQ0KDw746va+Qvaqg4/KIM?=
 =?iso-8859-1?Q?BDN2FgLCkWG5F8WM5tjBlOYuGABx2uygxawezO7ptqqEszljOoR4mEEicq?=
 =?iso-8859-1?Q?5f8EGpQ9E3qGROafh14WvIsPRx0GLg7WWngtyPXGKCb63eKQDAWNwhlU0v?=
 =?iso-8859-1?Q?lAQ6/gojk2HlAXWtA=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1158.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 771b8510-615a-4d48-e269-08d8aac17170
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2020 23:45:08.0089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7RPTRu1E7iFQ60XGKwkMSMXsRKvoZ+1cxQwGwDpolbDzjvokQ6JJfw42qGKi18NLRx/IvOQvo3fHzZJ38nPguw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1869
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apologies, that was HTML.=20

From: Dan Moseley=20
Sent: Sunday, December 27, 2020 3:42 PM
To: peff@peff.net
Cc: carenas@gmail.com; git@vger.kernel.org; sunshilong369@gmail.com
Subject: Re: How can I search git log with ceratin keyword but without the =
other keyword?


>> I wonder why this command doesn't work well.
>> I intend to find the comment with the keyword "12" but without "comments=
"
>> whereas the output is something like this:
>>=20
>> git log --perl-regexp --all-match --grep=3D12 --grep '\b(?!comments\b)\w=
+'
>> commit f5b6c3e33bd2559d6976b1d589071a5928992601
>> Author: sunshilong <mailto:sunshilong369@gmail.com>
>> Date:=A0=A0 2020-04-12 23:00:29 +0800
>>=20
>>=A0=A0=A0=A0 comments 2020.04.12 ng
>
>I think this is the thing I was mentioning earlier. That negative
>lookahead means the second one wouldn't match "comments", but it would
>still match "2020.04.12" or "ng". So it won't do what you want.
>
>I can't think of a way to do what you want just a regex, but maybe
>somebody more clever than me can.

git log --perl-regexp --grep=3D'^(?!.*comments).*12.*$'

The first part fails to match if the line contains 'comments' but it does n=
ot consume anything, so the second part '.*12.*' begins at the start of the=
 line and matches '12' anywhere in the line.

Of course you can extend the positive and negative parts, e.g.,

git log --perl-regexp --grep=3D'^(?!.*(comments|abc)).*(12|def).*$'

means "lines that don't contain `comments` and don't contain `abc` but do c=
ontain `12` or `def`

- Dan

