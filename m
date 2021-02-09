Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE09AC433E9
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 16:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD68364D9D
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 16:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbhBIQhM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 11:37:12 -0500
Received: from mail-mw2nam08on2085.outbound.protection.outlook.com ([40.107.101.85]:21889
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232788AbhBIQgq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 11:36:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhNYSPMC2L5cH/DoQY4S42uNa5VCHFxUd+vcXSmUrVnKPFt/E49lwwSzOC7xq3LHdEWqFYW1eAHJNbdFWgALOu4qn4bmlUg1I1KJaePD34vpLXD/zzMoj1aE9sFbOxvANOLXQ7Ds7pVO7qw9bp4vB1fD0tc5scBskrJDbjGNhQTwLc2GXb9w3UX069e0JqVInpn3ATSwfuCeIlGJn8yV6cgaOimv4SDALJ5ySTHkZQmhFJrCkGbH6+hUYyQAN1jPFQFIfFsna5oad2LSBNpMRqSLz9tqsFR2Et4a02HSVWdio7NxfVZL4/GhG+ML3y5UaZcXs6Wpvx0XOzPNNs8cuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqCRwjlITt5HK+hPIQmqlYsjIWHTSHhmIS6oOJd3haw=;
 b=GpwiMQk5bgCrMBlNPgEkrl93uKNzO9H7V0Dod6/3B6E5SqP/V/dfBqWpby/CoGELLMolPFhLWce3KuEDFTenb+9oy/Al2IvikhDnY86b7hgYdVihDTrqjHSKviFymXtXHX5hkDQBFrDHjjKQpNXo5PUqkqMzgAuOPTWXaFgYLnxgAN5xA4DNgXv/w9swSaMYCEqc1guF3Y6pNFayhouzGB0+1jfiT1s/sezdQKpKfeam9BG0d4aB6XAFduec/Y5WiDIIE5vaxJNuvQcGnzyuoSZC8Kink3WecG04APa9wX5aU8pcZTBnHUmCQpU1YGQe/Jf0GhLaesBcgSW8rkwmHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ubisoft.com; dmarc=pass action=none header.from=ubisoft.com;
 dkim=pass header.d=ubisoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubisoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqCRwjlITt5HK+hPIQmqlYsjIWHTSHhmIS6oOJd3haw=;
 b=NSN5hPUscvmpEvgyckc/DjTrUfvJhy0Ult0g5yc6wy2ezRo6W4j9zNzRV2aFlJ9tx5XWdND9fGJHAW2idsnWQPfQJX00V8bCF5SW8Jt9d+BeM8cZvQpaYrjiNUFgiIz5UiAWffMG1I9Q4IrcQswxknDhc3LS6peNMlcq9B5f9ab5hov7Bobu+33/2JBhyhG3wd9rs6UeF5FofWK6p+mWxLX2epOWsEABNR3kKCRavJJdZOeon7OUgxwamJWjk7dluO+NijwmvJ3UltDnUu1V+PBR+zxfmVQUUjefv1+lc15u0qQDfF0SflgTbf+Sflt/EvUoRt3BGy3Jy/7VzPYIxw==
Received: from DM5PR1701MB1724.namprd17.prod.outlook.com (2603:10b6:4:18::13)
 by DM6PR17MB3963.namprd17.prod.outlook.com (2603:10b6:5:25f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Tue, 9 Feb
 2021 16:35:58 +0000
Received: from DM5PR1701MB1724.namprd17.prod.outlook.com
 ([fe80::d9b4:9ff7:d2b5:a2bb]) by DM5PR1701MB1724.namprd17.prod.outlook.com
 ([fe80::d9b4:9ff7:d2b5:a2bb%4]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 16:35:58 +0000
From:   Dominick Latreille <dominick.latreille@ubisoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: The argument "--recurse-submodules=no" when doing "fetch --all" is
 not passed to the following commands which can ends up fetching submodules
Thread-Topic: The argument "--recurse-submodules=no" when doing "fetch --all"
 is not passed to the following commands which can ends up fetching submodules
Thread-Index: Adb/AGR/ualdKnbwQEyg60yEZe6OCA==
Date:   Tue, 9 Feb 2021 16:35:58 +0000
Message-ID: <DM5PR1701MB1724CCBB1AC5CF342BA9ADD5898E9@DM5PR1701MB1724.namprd17.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=ubisoft.com;
x-originating-ip: [216.98.60.148]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9782011a-2a73-4f23-45ab-08d8cd18c78c
x-ms-traffictypediagnostic: DM6PR17MB3963:
x-microsoft-antispam-prvs: <DM6PR17MB396395E3433F5AB0E3213A43898E9@DM6PR17MB3963.namprd17.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BQb4adg+g5/6Jrhb4Dt9Jn8K+IxwPxcbVEViY0VCtTdU5U48O3H/lroUNmyBzpK0HsoZgOYrYHB2OIFVYg0hU9Fe1EDsgMMksRnlqoAdyVKTJu+/0GwtsQtdPVCIrb+pPi9vMTCb7g1fYd+8Ljms63uc6hqkF0+6XL2i5XxSs6coKcksmN6YdfNhYUfKEoi5Y5aRtAhQU6nSZwmoIlh1JCVPMtzIjqiomIq8LvbI4y8Xg/sZdT7O9H2rew5g/B2t2uhlETZpqrB3RwhPIBtLd6VG4gUFQp2gPf/WHfPdPoGIXC4ae3lM/LZKV2jhQlF1nfu3GmYntSejt2MqBkM7fQZHg0zm2uZ4bjwMTUk/mRLiCY9hrbQaIuQi9vnbFLhERUbksCBWQD7w4qFGmXY9/DJmUpH2Bj2kFwEd2lKUuIHjqD86oRZt58RNvCGxTX+g9iqyXtkYgVjKMKfkd4h5WNiS8sDjNvOOEIEmB8wyCWJaC3mGnm9aFyoJf0UvVStYSMl/zeOaFvc+9hGmZZFA1j/CwbMJrEJsTEnKJvm36LdI75lqyR7iF6Y7FFkQwEnWuyXAawoBFgwe9SzHvtGwxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1701MB1724.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(346002)(376002)(136003)(396003)(44832011)(33656002)(186003)(66476007)(5660300002)(6916009)(478600001)(8676002)(7696005)(83380400001)(316002)(52536014)(64756008)(66446008)(66946007)(9686003)(6506007)(26005)(66556008)(55016002)(76116006)(966005)(71200400001)(8936002)(2906002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?dzADp0p6RJcLk8DlwPMqRiTNJXszJo6Aqa81kJeMxAJSNSLsQ7s5+n9s2QWk?=
 =?us-ascii?Q?tbNnnJ2vC2QnYGMgHWQOl3/XQ9kppgjZQrAv4JBsdSPxb7oKccUBI64lA2Ma?=
 =?us-ascii?Q?sZeKRkpC0z41jY40vAN5hFCjejKg6ylXGlXTs2X/NMvVvvD64Y1Q+0DVt+/v?=
 =?us-ascii?Q?vqVeYM81vo3CvS6QLpL+5W8tUQJ+sqx1zOvgH+zDmpG3WbhIoEeES56SlOO2?=
 =?us-ascii?Q?JgRXYSv8ta6J6m5MhXS/7L5i5MSOPS43CHdNlKPWooril8fkmEWxZn9k3s8f?=
 =?us-ascii?Q?579ZYJEDUe6BO6GUabG0icyGqyZkkszPqUyhVRKJGhwi03B5ywqeujFvKbK7?=
 =?us-ascii?Q?u+X8Z/n52MfNQ62IRRmofFzPgAATMfXjEZ6FJ0VGmLwBpoj8tEVgsK33MYws?=
 =?us-ascii?Q?J+pKmjSRN9V7jbG9oFt9TXYdC1cX4W96Qjhadu8CBAtJH11NMyRjpLfrQ+WN?=
 =?us-ascii?Q?wzv7WII/NllnBO66oQ2vxzn4RkNGeXjhaatTirB9lv5DrQJ3KcBF4KDFb71G?=
 =?us-ascii?Q?1Vh+OJCeO64JJ+qL/pGbUHeq18/KMIe9rf1vQ8CGQa1jIBWpTmtrxkEB1caj?=
 =?us-ascii?Q?XjGXkoSQzBB0Jwoes16tGrr5kZibly0EAaQaYulSvvKQswxMfvkid60I2cGs?=
 =?us-ascii?Q?Ix+zNJTyIgsj03bYDdbVQTOhZaf+MgHICU8EJiqIhd1rzat6cCvhc7OLiLcq?=
 =?us-ascii?Q?KZGjjLQbKfZFSZ1DFl+2aflRYDOk6qs4in1PJK9nvRZIzIgO+W5dMxAfU/gN?=
 =?us-ascii?Q?xaafFkmZIEQa7CGmCcnCl+AQdzXzssg3wVmxpLoyyaTdS7JAWYLOwxnpivRU?=
 =?us-ascii?Q?L/Ct6uviiF7BhxIOdHjIn+U4htmdAKM1+rnkQZ1KEhVIOpU7Xky870j4lwbq?=
 =?us-ascii?Q?JHdCHvAeocXVO7qCP4dU8uPF+iGYETd+DxG9vjCbEnXbiaorfbUr+a1DZjPs?=
 =?us-ascii?Q?pFT+Ef6kM5Qmdrj3dJyHNfry/9M5AmIBflstzCGYjM19Xv9NlRXoyYZml/EJ?=
 =?us-ascii?Q?7jvTG0UWhJQO5Z20c3NMMy3H3QR5quQMyEo836b3t2Qp8bnN3gY/a0BvjM6f?=
 =?us-ascii?Q?xRlZuYu0Tc4BnvPuZKHzbI1sJuK68Oy+1skqtPqZEiNGbOBpBhsNQqpBP9Z+?=
 =?us-ascii?Q?NdG8WBcuvjQiAEhpTN2lz8MTwe35EDQh3s/9eRfgUWSXgr7MrU1qjzTG4Nxo?=
 =?us-ascii?Q?du6rJ63Sg0Su3C5qzYdrsl8JYXehKriiSQRYU38zsw6f3uxfsNz8be0QOwoo?=
 =?us-ascii?Q?zkKiz6+CQtGcHSH4OpzF8HT6+cz8QLSev0lvxemUulrOB7RqpL/yoirCvJcM?=
 =?us-ascii?Q?E01S5R0MrapESWwdPUzYiLks?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ubisoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1701MB1724.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9782011a-2a73-4f23-45ab-08d8cd18c78c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2021 16:35:58.3073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e01bd386-fa51-4210-a2a4-29e5ab6f7ab1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 92NfYG3OQS3FkzKUJ2vJ2iYSSoVScJ/ytzRumcsj333P8ara7PP82tfTsJmUmovj/r4Ug+ny+FULsAGBja6VXxIvWFn2fVnTdJCWG7eOjzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR17MB3963
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!=20

I opened the following issue https://github.com/git-for-windows/git/issues/=
3027  , but it also happen when using git on Linux. I have been told to sen=
d an email here for the issue.

The git version I am using is the following:
```
git version 2.25.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
```
Terminal used : Bash

Here is the command I ran to trigger this issue
```
GIT_TRACE2=3D1 git fetch --all --recurse-submodules=3Dno
```

I expected the submodules to not be fetched and to see this command with tr=
aces activated
```
git fetch --append --no-auto-gc --recurse-submodules=3Dno --no-write-commit=
-graph origin
```

But, here is the command line I got with traces activated and the submodule=
s were fetched later on.
```
git fetch --append --no-auto-gc --no-write-commit-graph origin
```

Here are some repro steps with a repository on GitHub.

1. Clone with git bash https://github.com/DomLatr/RepoWithSubmodule
2.  In the repo, run the following command : "git submodule update --init"
3. In the file .git\packed-refs, remove the line "f5165dbd5441d97e7fba6b559=
17a4c7865e5d7ee refs/remotes/origin/change-submodule" to simulate that the =
repository does not have the branch.
3a. If the line is not present in "packed-refs" or is straight up absent, y=
ou can remove the file ".git\refs\remotes\origin\change-submodule", that wi=
ll have the same result.
4. Run the command : "GIT_TRACE2=3D1 git fetch --all --recurse-submodules=
=3Dno"
5. Notice that the submodules **are** fetched since it uses the default val=
ue "--recurse-submodules=3Don-demand" instead of the value passed in the CL=
I

It happens in a repository with submodules that needs would need to be fetc=
hed. The value of "fetch.recurseSubmodules" by default is "on-demand", whic=
h translate to "yes" when you need to fetch a new SHA that you don't have l=
ocally. I tried the 3 command line possibilities with --recurse-submodules =
and GIT_TRACE2=3D1. Here is the following results:

GIT_TRACE2=3D1 git fetch --all --recurse-submodules=3Dno
=3D> git fetch --append --no-auto-gc --no-write-commit-graph origin

GIT_TRACE2=3D1 git fetch --all --recurse-submodules=3Don-demand  =20
=3D> git fetch --append --no-auto-gc --no-write-commit-graph --recurse-subm=
odules=3Don-demand origin

GIT_TRACE2=3D1 git fetch --all --recurse-submodules=3Dyes
=3D> git fetch --append --no-auto-gc --no-write-commit-graph --recurse-subm=
odules origin

Since the  "--recurse-submodules=3Dno" is not passed to the following comma=
nds that are ran automatically, I can see that it is using the default valu=
e of "--recuse-submodules=3Don-demand", which will end up fetching the subm=
odules in this case.

Thanks!

Dominick
