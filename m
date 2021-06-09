Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E14C47095
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 09:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AE0661185
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 09:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237554AbhFIJHU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 05:07:20 -0400
Received: from mail-eopbgr50084.outbound.protection.outlook.com ([40.107.5.84]:18657
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232943AbhFIJHT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 05:07:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpfZIh/+xzA7NMTvD8o0Qp3GANJqQF7WtvFKgMSbfyLJhRIoAWTn1XhqYhbcbao+eueVsaPeKo9k3DIyLV1h7Et+PHLOFhTcta4ifwxhhAhZMSJB2YFrMj1KqixjlDY5VdcR60B67IvIP99EABauRc8NJ4vrCVW5sZI/cxmEKatXZShuONeUDT1w2n3/lS1JHQMk4Qz2NL7cNPuTD4rN09a2GGafVmxQTJbRNUZC387rrfzWV9Z2bW0tqSUjTyV1Y8OUgWF743Q1FhKMhryD5luJ+DFUaggG8zvGlpkEt9U9eWe6hBUlF9yoJjq8Bqx7nS+TFXxNTpFJ2zORxroQjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6RQEZJVY5NRIKYCcVsgC0HZGzMCMcq2QZI0kVVmjwE=;
 b=K54abkP0+6uuCOHSjRIeq7gggvnAvO4xZUdd+rmckTUvKX3gdhikvMdsZpALzaF9C3zmgs5aV74i1vbEbmPKGuauMDQwtO8U3D7mYDN7ztmEcgnpUMNbQi3hUuW4qVZF4utC8mcSNn05iHi1JCtndl75mRPjVYX+qDmwFha0QZExGWJrFPWk1hzwyIPHhWxE34wO266DjefZvYB+KZe1NUPNs7x1eOYT8I/btSlMM4R1aX3v1CzHh5uiZvRmvbVzUqfNcB25WLthtiG1M7pyGJ/WMhj8NYks5zPNMlmLg7de8vetzHiBpoShHeURkdTCGq2Jebds8NKM+whn8gQo8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=velux.com; dmarc=pass action=none header.from=velux.com;
 dkim=pass header.d=velux.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=velux.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6RQEZJVY5NRIKYCcVsgC0HZGzMCMcq2QZI0kVVmjwE=;
 b=N+75IfqyEVFbhxWcvRldwbz7lF6ZD0Lemms1wFtqyTnvL2VdseD8Y+H0tvpNvDSEaPmd6XXjrSx+Jq7BbokoXsx6As5KcdBK9Zgx3MAJSOz9Df3GrJGr/CHbGXuYfqbjpmS7XHcPObZoMScv+wkoJKQtxrryBzr7OLYXeJUvjpw=
Received: from DBAPR05MB7510.eurprd05.prod.outlook.com (2603:10a6:10:1a9::9)
 by DB6PR0501MB2245.eurprd05.prod.outlook.com (2603:10a6:4:4d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Wed, 9 Jun
 2021 09:05:22 +0000
Received: from DBAPR05MB7510.eurprd05.prod.outlook.com
 ([fe80::4c3b:2076:6e5:7fef]) by DBAPR05MB7510.eurprd05.prod.outlook.com
 ([fe80::4c3b:2076:6e5:7fef%7]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 09:05:22 +0000
From:   =?iso-8859-2?Q?Vojt=ECch_Vladyka?= <Vojtech.Vladyka@velux.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Removing fully-merged branches
Thread-Topic: Removing fully-merged branches
Thread-Index: AdddDebS75P0rtSWR/qqamRC1aNRGg==
Date:   Wed, 9 Jun 2021 09:05:22 +0000
Message-ID: <DBAPR05MB7510441970BA87A456B8C0D8EC369@DBAPR05MB7510.eurprd05.prod.outlook.com>
Accept-Language: cs-CZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=velux.com;
x-originating-ip: [31.30.173.188]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 790f9c51-60da-413a-da47-08d92b25b688
x-ms-traffictypediagnostic: DB6PR0501MB2245:
x-microsoft-antispam-prvs: <DB6PR0501MB2245C95E43288EF739CA181DEC369@DB6PR0501MB2245.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rzNmC7JX0XnnxZzONWg48qBgW9lsH5bJLaw8Xc+WKQWURs3QeXUrOdbTbSI8MozkE5nEUVAYa4goc4OPzIcwL4M89F2naiUE2txJ6n2CvnenfCjEzLUzBjmDi/icOvXfr6k20F6Xf/ugnYAB25WrZ42cw8y8mIye9DVR0CIAUb5qe9JlsPVzvK2PkpixPQhVfdVibc5dFRKTWbXO4V8ec7tenGszwW2yoYiSIi2So13rTglP58keh/hOfVYHE8l76/mv19iePOmq9doIyOHJ/sVYRubgWDvJ9nh4oKcAcFSJTCjcR42jPVXkFdhdBL3DxSzASznmHt8Rc7T/WAjb6I56XONGpLVUNq3B20oEMumYL5EyKQAglwZjcRAF+h+nic50jWjDjL55slQk7XuFxVSyD9Z78XfWG9N+zCicCMeOleBMEZx5IL+CRgx9Ron5OsNAaNhpRg7BrfUipooH92gBaS35m4GlBKEuaStddSQlGi8HAvixqoK6ST83MVJDyLnH0MH1BjmNiKxHUhMcq9UUQnOVIYmIdC1SJq1I1nHOVblPYtDBof0zJkjy5A78EdSWEFzJ3y50+4aX1SZ4l99QtrhRtB4y9f8K9nG2Jto=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR05MB7510.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(26005)(55016002)(186003)(4744005)(71200400001)(76116006)(66556008)(6506007)(7696005)(66476007)(64756008)(66446008)(5660300002)(66946007)(33656002)(122000001)(9686003)(316002)(38100700002)(8936002)(52536014)(478600001)(86362001)(8676002)(6916009)(2906002)(3480700007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-2?Q?qARVvQARY7H8dU2ji8G4It8bGz8bkcWvWdsRMUkuJie3v1siUQtyA7DS5t?=
 =?iso-8859-2?Q?oWvJ2CAzHIcwPvz7wsw+xLWMOD6J4sgXnoPTdxJI9FBnLi57HjnO9g4+ho?=
 =?iso-8859-2?Q?67goUnanzPchUEYnRaLdZMuSyWwNmRkeRfSBZQgk/QMjFRRigosSqwCMSY?=
 =?iso-8859-2?Q?O91PWLxTBHY2XuwbSGIz/DmVu3SF+G1vBnstuM4oDZ9G9i3251iz5vGKWK?=
 =?iso-8859-2?Q?LywHUk2OfiqxTOBVRvFQsStsfLioE10k2CZDete8bXihmTBG2Vc990rWT9?=
 =?iso-8859-2?Q?DHCu4CWpK+JmTNvUR7fGm2c4dxiqKA60W1H/QZz+QoPmOpVdAIotsfujoA?=
 =?iso-8859-2?Q?PaH+jhi69vxiiWEPbqWPm+bOVGP3Fm2bPfE5g+6c3nh+VOYix3WAPwuqE6?=
 =?iso-8859-2?Q?5piRx/hjT708BzCZcSx2bVmkxGFyNWuukinET4k8TWUK0uYcMYLM3ejeY7?=
 =?iso-8859-2?Q?S1KLiX0abmnz9PPAD1NEkT3r8DPUElj/N+mdWjMxws19gsflUhHeslLvf2?=
 =?iso-8859-2?Q?Zw5aYUfIBhW3UVJc1mc/F0tGwOGoKP+HVCX05iD03n+41ssoFF/KDkCWf3?=
 =?iso-8859-2?Q?dNghYxtNBw54Z60LXpoRKunwwcYjICwxcQ/qCUzKuFh2heEH8aJAsz9q7E?=
 =?iso-8859-2?Q?psM8nOlegIWeiXXjQd88xGINtGTrcWZVwOKZYx1a1uGwdYNlhqD5NnGUav?=
 =?iso-8859-2?Q?avWck3PfXiASf4CdC4DQOuev0VUfLwJ/hAp8f73h3SKroO1PsBNVw5/9tL?=
 =?iso-8859-2?Q?NUnpyh/cqcULKO8BXaoUg7sNT8RLu2yqVOrX8kH7WYLnz5PTnp2tdMipn5?=
 =?iso-8859-2?Q?z94xLHd1QEBwZKBzUuwTmh3z7teyGR3KKHIxnw0GeidVMBdOxVJcarCsoS?=
 =?iso-8859-2?Q?i1QGBwfmy3TIGOLQjCy+k3Mu0C7NVu0QRJ7IytfurmrC51WNl280zJWLNg?=
 =?iso-8859-2?Q?VqRJaUguk6p2GaqHLnAR/bZm7y8csvA74f5nEYnLkL1NErKu+G9Si1sdTk?=
 =?iso-8859-2?Q?SgIw6Erzuyv6tK1BBw0mqML0Xtlzzn9BfnMaOg11b2CbfM67+ZnCkhvaEk?=
 =?iso-8859-2?Q?PBxN/84rkICTaRSWmKsOssVbMsL/MVCRrAjPBt3LIlDt/mJzpbjcP3JuYZ?=
 =?iso-8859-2?Q?DW2zxoipoS26NfC0roSB0wxJOAC/K6spnMboNeYFuhHapZd0tjycmiYD2K?=
 =?iso-8859-2?Q?5kjXl8x8k61OCDybmgqbhosii253gRb6Lu05+gy23tuojgyRjjpb3Bgg1R?=
 =?iso-8859-2?Q?LL/+At/MUB7fqcn/JRyrY9zD/KRDMTAlfhVMZdgvoe1w5S3+BbXbf8IzjE?=
 =?iso-8859-2?Q?PiqMaElP5SXKaT98ljCOxIGuLgrp1rrQVsGd9IK3PCt8i/wehkv9YUSZjt?=
 =?iso-8859-2?Q?5ZfwQXw1rt?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: velux.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBAPR05MB7510.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 790f9c51-60da-413a-da47-08d92b25b688
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 09:05:22.4010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9a3f3f0f-95b6-4766-93f1-6bd07de19cea
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xdW46/W4tKwl7trKRvAi/uf071i8qUT+vsLBo/BeRLNDEGgyLBrO16u0qEZwqRjv8xVfHkHC/2W7PJts720cj8j68PybYOOKA21aFNmJWro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2245
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello!

Permanent issue popping up in our team is removing local branches which wer=
e fully merged.=20

I know there are command chains doing this job usually starting with git br=
anch --merged followed by grep and ending with git branch -d but my point i=
s why such functionality isn't in git client already when he has all pieces=
 of information already and ability to do all of that. Maybe I am missing s=
ome reason behind that but to me it looks like missing feature.

Thank you for your answers,
Vojtech Vladyka
