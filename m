Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB94C433DF
	for <git@archiver.kernel.org>; Fri, 29 May 2020 05:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E4B1208A7
	for <git@archiver.kernel.org>; Fri, 29 May 2020 05:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GTfKntkL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgE2Fnf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 01:43:35 -0400
Received: from mail-eopbgr1320104.outbound.protection.outlook.com ([40.107.132.104]:10000
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725790AbgE2Fne (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 01:43:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GelqJpD9TYi8Z+nL+kg9z6s05Ff+FD0meRZH4hGMit/qF4yo4POqiWXydIVFgvOoaV0wLNYA7gqi7Rk9XxVIXcvEutgeL8K31gw7dBUK1orRFQSR2I8Q/1Gg8MSxaPJ1GXAOWJyVI/U3fBENWOopLZ/3cIcakKd+QAgt8oFAt+rq6fDSzLyeFqwQx1ih6nwBGmF0U0cmZ1Hpf5PGm8G9HV/TjNoUtIubL6vlTkXX+Edyd/Dup6i4Z4Oj5Rjpw3OyruwFdalsmeEqvLAmDdaOlhAMk3V186tYLt5wNVxr04UJApO9WN9Ys7jqVBosoHzOnar8lwkxWjK/s0qHT9z7YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcX8zTXezOMMdgCpeCLsOLxdRi87WhBo48VufcqUJzA=;
 b=HDyAQ6ckuUKRLe3UbV5p6FQxlWr4i0w1KlOVG2zl4exArR1l42p7YlpyxGf5Ss7T+izTud58S1noyNLi22zrwOG90WSQKrbqctRoxPdaEigyZZUIrycRz9U0SIEGCz3tso6SJXIJxt4G4PaYGead2NDYwvocO+hVVEGa8V1GCilvuivFun8TkrGvtKct1cjyBXYv8jD3XNM6POffdjqqqLgHPsqhYvWFWeo8nW8zzZPMO/yVR8s/r6di3dFdlTa3t0LA3oggjSkAPb+gLgluEieBch93vNO85iJ0MQg0mXRBTo36jH8UFchNeyx+a2TlbMi48eQBBd3Cg/ONxMCQFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcX8zTXezOMMdgCpeCLsOLxdRi87WhBo48VufcqUJzA=;
 b=GTfKntkLv1lWt6s/3Mw5LSNt+k0I3poEDzvGHfYzRsk7ZefvE43UthrS0+eAf5lfJJxunJhHZr69B2V0jMDA7G7s/HzMeBJfht5iqxNrdi47A0QO03JYxsJ9TyFoZrJvENLXR9EFmvVJHTbFGpu1JRB1Hd998mBJ+iHEJQipUfc=
Received: from HK0P153MB0113.APCP153.PROD.OUTLOOK.COM (2603:1096:203:19::14)
 by HK0P153MB0180.APCP153.PROD.OUTLOOK.COM (2603:1096:203:29::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.3; Fri, 29 May
 2020 05:43:30 +0000
Received: from HK0P153MB0113.APCP153.PROD.OUTLOOK.COM
 ([fe80::c196:a6cb:9d5:c814]) by HK0P153MB0113.APCP153.PROD.OUTLOOK.COM
 ([fe80::c196:a6cb:9d5:c814%6]) with mapi id 15.20.3066.010; Fri, 29 May 2020
 05:43:30 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [BUG] New git unable to show this commit completely?
Thread-Topic: [BUG] New git unable to show this commit completely?
Thread-Index: AdY1e90QgQZ+lnAgT725z0zgKS9EiA==
Date:   Fri, 29 May 2020 05:43:29 +0000
Message-ID: <HK0P153MB0113E08900C5C8B8311A4B24BF8F0@HK0P153MB0113.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-05-29T05:43:27Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5a65efbe-ddbe-4420-ad57-7407c6263222;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [2601:600:a280:7f70:29e9:a365:d0a8:25d2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cfd5d859-3ce3-4df1-d6bd-08d8039337b7
x-ms-traffictypediagnostic: HK0P153MB0180:
x-microsoft-antispam-prvs: <HK0P153MB0180F8F9262A7AFB0249AF19BF8F0@HK0P153MB0180.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-forefront-prvs: 04180B6720
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y0F1qqReYQuBUTmrSCXS5UuuFIz627BbSA5PQIv09CKRHjJP3EtfYlE0N6N14BllU3gJcxSksb04x1tLeX1KxeSOlk91M4+LQDFpir1ksEqF2561w3dZEqqJbkGgN9fB6FuYLQeF9LehBG04B3cUQhdmPQga74Z7VTRdQ0ewYCVoZvn310aiG+sGRex7/JIevnRLfPovH3hIfWD3sRC6RYbykUF1y/Jndp2FuVT6G0RQPXefFBKubHrekIx4Jo62DPUKfdX5tdCCi4bppA2hB84xli8aJHfRvffNjlgsPxpIV9kw8pDXfQSdF1fcDIUlnHN3u6lfpxgQ08s/jaf9Z+qQwVJ0/a8LcF4QNzy3yrXzjNXzV6/Tf5etuhVijX0xCl78beN6n4WVt7yZIrdzhg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0P153MB0113.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(478600001)(71200400001)(6916009)(86362001)(8676002)(8936002)(7696005)(8990500004)(33656002)(83380400001)(186003)(2906002)(6506007)(5660300002)(316002)(76116006)(66946007)(55016002)(966005)(66476007)(9686003)(66446008)(82960400001)(52536014)(66556008)(64756008)(82950400001)(10290500003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: pmVLNzJ6q3CvyJkMQJbzILsELSupgcdAa5CMdTfjcOMoLSrs899lEGGZeiElaMcHZWpaur6s9iikytcD+PaIa8ltHmGYxScuWegFn9g26jlvtU62FEqB7hkFeBWnVTwDirmYZo12DKomviO5yyBbLbPWD36ercaOpfGner4NZ5lIuLQzHP73DEzEDmdtxwBeLkpo+8U0miRFBP/KeYZslRNSrJNrsJRdYBNzkKJ0AmMfPIIidLvRPrTXcSNQNoSvaPXVdRR7iYoqOp3bLmxBROf2KlPt30a8tBEWSzvZcMfsDFRVQzgxAkt4caMZoJfN7m82Fm45EW+Cigpi2zY2xSslZjaIoKNX/NtByJ88Co+pU2GcRc0dxT5Fb5NbZUkCQ8zoPFtLbH3ca5BhjT1umudecrAEh63AtyvxVhjFy57WiE6tn7uD6Ox+fd9jgzgyahgIwVKzqwXOjxWcjg94ST+mKzMr00jmBjbVkB8NnVp/BgFUSIQ4IAKDUof3w/J+V/hvZK0ZH4qzKI2YipIFCQWWH6qAs3S/uyYbTWacSE7owvYaTJojOILcuGn7ZuJV
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd5d859-3ce3-4df1-d6bd-08d8039337b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2020 05:43:29.8368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J95OJLHQk4ghYE2UMDbsuHObCC7w/lcxgb+puzxMyWOS7GiLweqxgRY89VCxn+wbMmvdzXSqMIee1IXg8ggfLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0180
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
In CentOS 7.8, git 1.8.3.1 can show this commit from the mainline Linux ker=
nel correctly:

[decui@localhost linus.git]$ git --version
git version 1.8.3.1

[decui@localhost linus.git]$ git show --stat 7b38725318f4517af6168ccbff9906=
0d67aba1c8
commit 7b38725318f4517af6168ccbff99060d67aba1c8
Author: Ingo Molnar <mingo@elte.hu>
Date:   Wed Jan 28 19:11:44 2009 +0100

    x86: remove subarchitecture support code

    Remove remaining bits of the subarchitecture code. Now that all the
    special platforms are runtime probed and runtime handled, we can remove
    these facilities.

    Signed-off-by: Ingo Molnar <mingo@elte.hu>

 arch/x86/Makefile              |   5 --
 arch/x86/kernel/Makefile       |   2 +-
 arch/x86/kernel/probe_32.c     | 248 +++++++++++++++++++++++++++++++++++++=
++
 arch/x86/mach-generic/Makefile |   7 ---
 arch/x86/mach-generic/probe.c  | 156 -------------------------------------=
--
 5 files changed, 249 insertions(+), 169 deletions(-)


However, in Ubuntu 20.04, the git doesn't show the deleted file
arch/x86/mach-generic/probe.c at all:

root@decui-u2004:~/linux# git --version
git version 2.25.1

root@decui-u2004:~/linux# git show --stat 7b38725318f4517af6168ccbff99060d6=
7aba1c8
commit 7b38725318f4517af6168ccbff99060d67aba1c8
Author: Ingo Molnar <mingo@elte.hu>
Date:   Wed Jan 28 19:11:44 2009 +0100

    x86: remove subarchitecture support code

    Remove remaining bits of the subarchitecture code. Now that all the
    special platforms are runtime probed and runtime handled, we can remove
    these facilities.

    Signed-off-by: Ingo Molnar <mingo@elte.hu>

 arch/x86/Makefile                                    |  5 ----
 arch/x86/kernel/Makefile                             |  2 +-
 arch/x86/{mach-generic/probe.c =3D> kernel/probe_32.c} | 92 ++++++++++++++=
++++
 arch/x86/mach-generic/Makefile                       |  7 -----
 4 files changed, 93 insertions(+), 13 deletions(-)

I tried the latest git release git-2.26.2.tar.gz from kernel.org, and it al=
so has the
same issue.

The web interface has the same issue too:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D7b38725318f4517af6168ccbff99060d67aba1c8

It looks there is a bug introduced in some git verson newer than 1.8.3.1?

Thanks,
-- Dexuan

