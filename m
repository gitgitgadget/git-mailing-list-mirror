Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCB6C43463
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 22:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE40A2087D
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 22:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=acmeaomllc.onmicrosoft.com header.i=@acmeaomllc.onmicrosoft.com header.b="F0QIKECL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgIQWuZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 18:50:25 -0400
Received: from mail-dm6nam11on2044.outbound.protection.outlook.com ([40.107.223.44]:23392
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725858AbgIQWuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 18:50:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d05PPEGEfXdVu+Fcn1aLfO4qQMWaTXZumn/vZyGoulFv3yPyxqZuGbPrQ1kKYhWRX1F52aV53jGbsCsz4cfm7qc6x2w+/IAxMHftx740JUZh+zL7WgXOl6cDmGDmR6FmNdw9gq2vQg2gnWe+oeu+MyD7gFCSFU09m1DoJxxCvZ2OhMGLB6Wznx90yGhzIaEelWEQJJt+3YJ96eWUM74RhwXTkz2RU+h0AfpOj2KIqGrBLYUxqJLQd2RLj052tkiXAS/ME8mOMYgH1InPZVOEjZqqHkR1TkrM7pbz5r/5kIzwzwsXUycxnDF0QLSOETM2aVIJ7gIUKtnx/DwnqIFhSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O15jatIPkQUrzTjJN/1VUhes16tLxBmlCFqIoeUCb0A=;
 b=hJ3oWr9fNYqyTEyuQg2m7ckp2+aF5ZA89HZI1e27S6Dr5agvPd7vWdIq9Jh2uxuUTQYbReXtHUr6WxXIWcbQZpLJq/WMvHUAHPU1ma81FNCy4PZ0RNod2Rh5fMTeum6wN86qhL7BgQTeojbJw04d1Pp4HbgpqyOhMhCrmpcrMi6CaLfaod7u0eGVaiB1uYp0Lzl5m4x88YW+0h+WbyNIvpdoliTXAZmV6smGRJc4U29jvGHxm5RafZB6i5NL4nEqymMIWtPaZGWHVWlgEDuGn1S8fBEM/8NQjgEl2ejVBOmpkzoUXgZBjDFGAfOWBPmeAaAG+1mTv8NNNYqso4QeCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=acmeaom.com; dmarc=pass action=none header.from=acmeaom.com;
 dkim=pass header.d=acmeaom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=acmeaomllc.onmicrosoft.com; s=selector1-acmeaomllc-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O15jatIPkQUrzTjJN/1VUhes16tLxBmlCFqIoeUCb0A=;
 b=F0QIKECL4vHae0ktSLwMoVFXgrvTBlY0d65bN5cYs28P2TBuw8ysoFdx51cbfRyApe6rSBJdOYjBA8ms+a9rMkkWdQHmTOpgs3ejgi3f2wdZMGSeOADAhlcqwFFV7DyQIDDWO7K0zNkpc9E5XB50evgp+7BjZ2n0WSJSR2UP7RI=
Received: from DM6PR02MB5164.namprd02.prod.outlook.com (2603:10b6:5:50::10) by
 DM6PR02MB5161.namprd02.prod.outlook.com (2603:10b6:5:51::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Thu, 17 Sep 2020 22:50:22 +0000
Received: from DM6PR02MB5164.namprd02.prod.outlook.com
 ([fe80::6550:74d0:7122:73b1]) by DM6PR02MB5164.namprd02.prod.outlook.com
 ([fe80::6550:74d0:7122:73b1%7]) with mapi id 15.20.3391.011; Thu, 17 Sep 2020
 22:50:22 +0000
From:   Nathan Ramsey <nathan@acmeaom.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Bug merging submodule 
Thread-Topic: Bug merging submodule 
Thread-Index: AQHWjUTs8dWolRqCu0yPM8PuYgkw/A==
Date:   Thu, 17 Sep 2020 22:50:21 +0000
Message-ID: <71C47B1E-863C-4A9C-AD4D-8A05AB6327B5@acmeaom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.1)
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=acmeaom.com;
x-originating-ip: [73.67.140.173]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32643456-58ce-4f3f-5de8-08d85b5c0f23
x-ms-traffictypediagnostic: DM6PR02MB5161:
x-microsoft-antispam-prvs: <DM6PR02MB51612AFE24E76A3F4263EA22C03E0@DM6PR02MB5161.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LmTtpPsjXWNSaMZujrIBi6omIjqY1Hc8YpJC+/VdBpOsKEp0Xeuct8P+qDVlxQfMn6jv6869av0VBjywBTsWbbMYWD1Sdnz7/P0+GZZHQbzSeVr1beNFn0mlSeyqxCk27YyvSnCzLqANXW3pX+umnidI3JaCTm04rvjpZPgK9aDkW1ws0DzNQya/IdO91PBvAILN4ghAXiuO4TF2PO0yucxHukeZE0RW9/5X25HeZc/D9rGY6uxjtvoxJGHoksAVWzwqCRTkA/59llXsoZJ1kIB9wfZ/eZMJmd5dQ3A4oAHz04tbU2ttGdjxbuqPNAMqJPmu2UUjPpxyzRGliOeRdg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB5164.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(39840400004)(366004)(346002)(316002)(6916009)(8936002)(6506007)(7116003)(6512007)(6486002)(478600001)(83380400001)(33656002)(3480700007)(26005)(4743002)(2906002)(186003)(91956017)(2616005)(36756003)(86362001)(5660300002)(66946007)(8676002)(71200400001)(64756008)(66476007)(66556008)(66446008)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ycZGjTBgtePEHz7Y0HMTMlTvLFFq1JcyX6IzVIkHeAwqRMI+N8PGbO/6LWWtgZf2nteJYJ9uWlAhQEZIDBqZwLz1suUWUNft7ophPRGuFYBMTAx7ITm2hDsxfjSnhptjLq0Koir2K3tRAjwRHFVVeA0Q/qo1q+G8Tt2xU+jBR0ez3N+fcB0UpTCLrfGYAgOb3oIueap4hpe5MdXEZOn1rzml7tX/TeWaeFUZhp0FxSvqjRJNHlAMTqa8cXTkcDLa8n8Ibwy3iTrqML7UtRayT6D+T1fS8HrAOjvQVff4vNv9UtH9im8O4s56jepB3cfO2BCly/wpc9UKZUe43jPfmE+wlr7RJ6AWoplu1UIvx7ZiY4O2S/YLSqWzRYSIzVySRtNu5jqvcEjRmVdGP3Yjj3TLEL/OxngscwjeIsElvVJh2S+Klm8/jBs7hXm9Ufj2gD6UGCnFzukjqIdwtFTltO5fiK3VF15EjuW3XtFystdgMSQlbcVOBPmXnOdTQEemKHGhDItpOjDjdMZpz8Dirv2CMeUgq9WCRvT74HEcEXVmCUINsfrJ7e+heFe1BwHfOXG3ZugzATcKBbCbs8vF32dIrbwBnN7C0ChUg660IpJG2KpgYsknUoJgckjVgqExjNEmZoCrZ7kxEp9jATm26Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E819D50EAA9D3A47A0718C9B26F05B95@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: acmeaom.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB5164.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32643456-58ce-4f3f-5de8-08d85b5c0f23
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2020 22:50:21.9811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dba34e50-ff0d-4ff2-909c-64ca775bb019
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9AdNLYpokvalZVWbqDB6OG9onkMX+bcU/CPlMljZV7JGHmj4CG83eGgfd8oHn9stRskwk8rqcYuxC94tmpDeug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5161
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

git rebase origin/development

What did you expect to happen? (Expected behavior)

successful rebase?

What happened instead? (Actual behavior)

An error message was displayed

nmr2:MyRadar nathan$ git rebase origin/development=20
Fast-forwarding submodule MyRadar/Tectonic-CPP
Auto-merging MyRadar/Tectonic-CPP
error: add_cacheinfo failed to refresh for path 'MyRadar/Tectonic-CPP'; mer=
ge aborting.
hint: Could not execute the todo command
hint:=20
hint:     pick 9a864cc2da187ebc5ef9720165c0656d4f35c6fd Pick up latest for =
demo
hint:=20
hint: It has been rescheduled; To edit the command before continuing, pleas=
e
hint: edit the todo list first:
hint:=20
hint:     git rebase --edit-todo
hint:     git rebase --continue
Could not apply 9a864cc2da... Pick up latest for demo


What's different between what you expected and what actually happened?


Anything else you want to add:

I recently renamed the submodule's main branch from 'master' to 'main', fee=
ls like it=20
could be related. The following also fails:

nmr2:MyRadar nathan$ git submodule update --remote=20
Submodule path '../ACMEGraphics': checked out '2f07030f28a8c4f7d9e540ff455b=
73b7cb99d9e6'
fatal: Needed a single revision
Unable to find current origin/master revision in submodule path 'MyRadar/Te=
ctonic-CPP'

(I have since fixed .gitmodules to refer to the new branch name. 'git submo=
dule update' succeeds=20
now, but rebase still fails with the error:=20
add_cacheinfo failed to refresh for path 'MyRadar/Tectonic-CPP'; merge abor=
ting.
..)




Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.28.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Darwin 19.6.0 Darwin Kernel Version 19.6.0: Thu Jun 18 20:49:00 PDT =
2020; root:xnu-6153.141.1~1/RELEASE_X86_64 x86_64
compiler info: clang: 11.0.3 (clang-1103.0.32.62)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]

