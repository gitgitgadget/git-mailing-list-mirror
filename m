Return-Path: <SRS0=RXbn=3E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCD9C33CB3
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 19:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D361D2084D
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 19:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pearson.com header.i=@pearson.com header.b="GE/A8TxE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbgAOTr7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 14:47:59 -0500
Received: from mx0a-000e6001.pphosted.com ([67.231.144.81]:62174 "EHLO
        mx0a-000e6001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726362AbgAOTr6 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 Jan 2020 14:47:58 -0500
Received: from pps.filterd (m0082678.ppops.net [127.0.0.1])
        by m0082678.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 00FJlO6s028331
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 14:47:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pearson.com; h=from : to : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=pp;
 bh=VKc2IYlptymOjP3/yheTQJss1mGBkF1bCCOeEaGUkSE=;
 b=GE/A8TxEu+b2UnNfFRMpPsqEh/NcxLR9+dpPrOyDAtvM+LIzoejyFx0UpiUrWu0hJxcu
 V/YTJInhiDaN/eFCSIIicQ2K1Y8fPW7JF5qK9iDH3kyJMta/eQNfPmN0T8GGCo4riDhY
 rkCeYzhB5xWk5iPHA8CIWvUvKaIUfqZsm8WahjEczFuuxXgYzjTuQE1aX/by5R+ljCZy
 Dyp+4uxHLqX2scJ1AhphQCtCk0LmLg2Om2LOxzk98aHlz7iQH4CW3SV5JACr30xb+KD7
 /ats+Y9atRtILyCDv1+xhznMq2BWMtY9t9u25r9YMwVT+YFsZRHVsmIV4cGxtEVgAW3X 5g== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by m0082678.ppops.net with ESMTP id 2xh8h3swx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 14:47:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JlHt/tTRUt60jarELcnFOc0aKom76t/gmXmd8QBrJLWtnwPPRDWWJF948Ob3+FbRIzqeB6hYV6pWUe+i55iTycNrvZqZcH2WgPgC+BYQmdcOfLiFvdFa9mokhc8iFq6U4CzopM0X3izTtCwZl6DBQVTuTwg6biVJxR+pepju+oJ/CHW3OvsKsMCs6HlmJczxt5G33iZIlhe1X5Nl0TSyv4ILxsd2fz6upzSYJ1JdPkj0+WMGWvD1ciJFQhE4v3wJ6lfLoQy49SEzBjaIUUvcsHqJC9kzinANZCCAJAdC2WJNUIi+WoFXW7xnqeJ/3woj+TvTYmKTvoX8irrN+ksoGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKc2IYlptymOjP3/yheTQJss1mGBkF1bCCOeEaGUkSE=;
 b=WDTVPysCJQlB94YIJ5XKj+liEktAEab/brsVKq1F62cLKjN2oDgDUHIzefkLq8vNC88vL4FOQ9FoeR3rZdbgO0DgQEKd6YJWJ/QK1W2fGbivi9Nh5x09AWXCtI040urHJbaV2kB8s7x51M/ZFfEpjHFOJ6T/dSqA4yFjJg8+gpin6EatgEI2W2+UMjcUo1iEyTgf+uNdl6pnJvAd2iJguIa5ltizdGX1kWOcHVatpCagwErgZratqJUE3taiiL6LaO11B2KHpo+OIj7O0T19PtubrZf5GfpPscrZOPsVaLud8C8Oe6dccXUVNLjq/lEYXoPSy78qXZt50/t0drRxcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pearson.com; dmarc=pass action=none header.from=pearson.com;
 dkim=pass header.d=pearson.com; arc=none
Received: from MW2PR07MB3963.namprd07.prod.outlook.com (52.132.178.156) by
 MW2PR07MB4140.namprd07.prod.outlook.com (52.132.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Wed, 15 Jan 2020 19:47:56 +0000
Received: from MW2PR07MB3963.namprd07.prod.outlook.com
 ([fe80::5177:42fb:4e73:b154]) by MW2PR07MB3963.namprd07.prod.outlook.com
 ([fe80::5177:42fb:4e73:b154%6]) with mapi id 15.20.2623.018; Wed, 15 Jan 2020
 19:47:56 +0000
From:   "Stewart, Tim" <Timothy.Stewart@Pearson.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: See Fault when running git diff
Thread-Topic: See Fault when running git diff
Thread-Index: AQHVy8yRzsSTIO/wMUC1ULTfvq4Rzg==
Date:   Wed, 15 Jan 2020 19:47:55 +0000
Message-ID: <771f0c5de3874158acdeb18003ac62495F73D361-1387-42DA-B582-725ADA24BB21@pearson.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
received-spf: None (protection.outlook.com: Pearson.com does not designate
 permitted sender hosts)
x-ms-publictraffictype: Email
x-originating-ip: [64.215.115.222]
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7fa5c139-0ed7-47ba-01c0-08d799f3d11f
x-ms-traffictypediagnostic: MW2PR07MB4140:
x-microsoft-antispam-prvs: <MW2PR07MB4140443C71AE994C67316F32E7370@MW2PR07MB4140.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02830F0362
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(136003)(396003)(346002)(366004)(189003)(199004)(15974865002)(81166006)(81156014)(8676002)(71200400001)(186003)(2906002)(26005)(6512007)(6916009)(36756003)(66946007)(86362001)(478600001)(64756008)(5660300002)(6486002)(316002)(786003)(76116006)(2616005)(91956017)(66556008)(6506007)(66446008)(8936002)(66476007)(18886075002);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR07MB4140;H:MW2PR07MB3963.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RT/QZBUBQZlz3f+tPka/5rCX3cvkLDNlz4vyZ55JO1uD3V9ra+UN2WUPh7In4tSLx56dGFb84fNaPvMl0VT9FdMD29QCSrGx6m/S66rYnao6UdyfzLwHSzH4BMRMFz/GrShIuemVKWHOiOgZltwBu+neE0+JZapDiPrKlUMB7pGljlqWFu/jtv/JrAfAw8iHD32bzQ8/TDMHuXk2xhzQ1EebKxVkqdiXPRYSgtTlqV5wh/9zTfA4oFx5/2RX2i9s+tuiXHUEwqKgRt2BP6I4cO3XK46rEtBdBzCWDzMG8D9gJ2fPWiTgLvveXjReOpadNlbJ7yl1p9K4r5raMmjnA/PEupnZ62OuSYnEdX6MEnOdOSiYkGbO4BeKDbUmnEYbTATaojez0aUtbFFCCUjssQFjHZ5PudE0HFNPedisuNdJw3B5dLra4ZmozS7NUX4B8v5jsVKKil5Vcer9FqFLFim62DzL1vYkJWciIrjmp8s057xqr5lGLz/ZNSRjXxreHlOp8e8N32GWRoppVCZ4CKpXHrvjUn0hvIu27UMHnhQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <1D17F76E609B1F4784EBA9E02A151056@namprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: pearson.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa5c139-0ed7-47ba-01c0-08d799f3d11f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 19:47:55.9897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8cc434d7-97d0-47d3-b5c5-14fe0e33e34b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: faIcgCK/ztXv4bKj1Xf9+iGRDJika6k9iVEKnNaYetlHWyMsh64S7zYiVk77b+zEdza6Zw5diOIphpyc186u1kIKclU/UxC/QpEiu75E2wo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR07MB4140
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-15_02:2020-01-15,2020-01-15 signatures=0 Internal
 Virus Policy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=0A=
=0A=
Hi, =0A=
=A0=A0=A0=A0I=92ve been using git for years and this is the first time I=92=
ve ever seen a crash.=A0 What a testament to the quality of the software yo=
u are developing!=A0 Thank you!=0A=
=A0=0A=
Git Version: 2.25.0 (installed via homebrew on Mac OS X)=0A=
Homebrew Version: 2.2.3=0A=
Mac OS version: 10.14.6 (18G2022)=0A=
Reproduced under zsh and sh shells.=0A=
=A0=0A=
Steps to reproduce:=0A=
=0A=
=0A=
Start a rebase operation that results in one or more conflicts in one or mo=
re of the repository=92s sub-directories.=0A=
List the conflicts with the following command: git diff --name-only --diff-=
filter=3DU =96relative=0A=
Identify one of the conflicts that is in a subdirectory.=0A=
cd to that directory=0A=
Run the same command again: git diff --name-only --diff-filter=3DU =96relat=
ive=0A=
Receive segmentation fault error.=A0 I would have expected to see a list of=
 files relative to the current directory.=0A=
The following commands work just fine in the subdirectory you cd=92ed to (I=
 introduced spacing to make which arguments are present or absent more clea=
r):=0A=
git diff --name-only --diff-filter=3DU=0A=
git diff =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0--diff-filter=3DU =96relative=0A=
=0A=
=0A=
=A0=0A=
It appears that the =96diff-filter=3DU argument is not required to induce t=
he seg fault making the minimal failing case: =91git diff --name-only =96re=
lative=92 when run from a subdirectory.=0A=
=0A=
=A0=0A=
Thanks!=0A=
=A0=0A=
--=A0=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
Tim Stewart=0A=
=0A=
Principal Research Engineer=0A=
=0A=
=0A=
=0A=
=0A=
Intelligent Systems R&D, AI Research Engineering=0A=
=0A=
AI Products & Solutions=0A=
=0A=
=0A=
=0A=
=0A=
=A0=0A=
Office: =A0 +1 303.658.1505=0A=
Mobile: +1 303.912.2312=0A=
=A0=0A=
BRAVE | IMAGINATIVE | DECENT | ACCOUNTABLE=0A=
Learn more at=A0www.pearson.com=0A=
=0A=
=0A=
=A0=
