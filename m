Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6449AC54EBC
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 12:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbjALMTY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 07:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbjALMSn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 07:18:43 -0500
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2045.outbound.protection.outlook.com [40.107.11.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934BF5130B
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 04:17:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UqOdMcxXl2XnBxEkIm/XJ8Qq4R2UviOpIvCQ7zFwMTroXjYT4ptjVVWh7ba1AbyB8fUyZioWb9tm5gGW8hPRM9WhSZ3R0A+GtUkD8zsZ+lmYgGgrkp/SOjmmw/KWsx7Hc8A51FdzL1GsX0IbL+z/B+gLnhTofZMOou8WE00KPxC2HZrjAajp48e1Q2+pVEN5hyzYtob6b/5Xs+XaIOtou+m8evb783P0meNnpkRY6lqtZiS7LG7wAwhGL7/OuwvyuoA7u4wHFo3C/lI26Jx/ett1Hx1LL76FnjdxfIydP4x3AIr8Ko3F6DoYTI6XD6+YMX8mujZ/IYdU2NWU9vCp1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRNceFxF6SkMSdaU/WRP6G1uhR9rp8TlxXwNUoP0aW0=;
 b=P6XgY6yuDKVIvIPEZuxTOs2fjlkTpZSrZcW27TOOjAM6aI4+lQ3LkWcHWPvLgMp5KUIeXO7vt017YABCrE/219AYUFL0ECKGhZnMOTi7WcinrzMvz7UnlJJEiw1KDIE8Swc0x8f08gjlv7Wc1ACqixmlnRXfjIhTx6aOEYrUzS4+1YE0JVDaSqA1nY2E3E1kxVh4UZmXEdV55yQA4JDFey3VrplSj99K3vYBK0g11cVt0yntoWqEDkKcfvGHW4tHLP+tn3iGNVzww8BtgZTXgM+/9qZCUqK+oRJ3lWJZHiG4uFxkVU7QJvuPFhxJg+i3y1dFZtmMwFYs+Ie/Tmz3GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=codeplay.com; dmarc=pass action=none header.from=codeplay.com;
 dkim=pass header.d=codeplay.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codeplay.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRNceFxF6SkMSdaU/WRP6G1uhR9rp8TlxXwNUoP0aW0=;
 b=q0he3PWh2yrI5xHSY8vSuZbHDlQklnnAbdMqd6WOBGErf2R4/zgSOqRz9E4tJcWXC9yu+tv1MZ5XTGERE1tzCuIzY6yzllhzqSzdt3Xy2j7IsD2l+UUEf3MXOiUBm/XEpD4qHJH3udyfayTUB7TD6vs5YAR7GMau2iEhhjELFIg=
Received: from CWXP265MB3688.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:f8::7) by
 LO3P265MB2380.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:101::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.12; Thu, 12 Jan 2023 12:17:25 +0000
Received: from CWXP265MB3688.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a3af:b884:87e4:57f7]) by CWXP265MB3688.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a3af:b884:87e4:57f7%4]) with mapi id 15.20.6002.013; Thu, 12 Jan 2023
 12:17:25 +0000
From:   Carlos Gonzalez <carlos.gonzalez@codeplay.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Bug report: checkout --recurse-submodules failing
Thread-Topic: Bug report: checkout --recurse-submodules failing
Thread-Index: AQHZJn7cPROlakBXQky/upxyiBtXeQ==
Date:   Thu, 12 Jan 2023 12:17:25 +0000
Message-ID: <CWXP265MB3688191D75A56F27A0C4DDB69CFD9@CWXP265MB3688.GBRP265.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=codeplay.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CWXP265MB3688:EE_|LO3P265MB2380:EE_
x-ms-office365-filtering-correlation-id: 8b7d4f62-9f6b-4eb7-b9fc-08daf496f6e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PLB4hXzJ/StvK5OiloMBd5bFTLhlKszltEMJ0CyUa2TcdJwIb/yu1r8+UtfH8Z2KEz72aqGfUfTgW0YWn1z0UR0KcMnkavUfD4AQhwRQjLjrLt2qkNGsPphYXxpxQbY2RBVuJqShQLjaRLQrtgVqTH7z9nzczuVwraTqpMFgdHTbXMccJy9nDeqC8vdgUMlwRYbITwHZiQbvNampOiUymqvbfYsBj0/rJrjF70SDiBG/Azh7Vk68vR9U4k5ETP4CkTlyKCnCXTHOy9QmVPko7VG/jRpor2JUzlPgBpBi3HQx1yqc+P3c7YLw2NbOoFni5ziZDAZOEr8pYu3NlysQoZJN7T3cVdzYhPtMZPcM65ipMmyKkXHbh71IFt6/hRjfoUd3lZzPh5mxw3v/d9xPA2/3e5msylDhOWKxxALF+DaXS9f05UEaS83R9iwjsMErR+MglEj9Rqvx+snpzRxap3J3Dp3yhWyLI+5WjXJTxScQIhMk0Ov3fR9eOi43JhsMZr4IXgBv1xWHuV8/r6Sq3xRrpd0Ad7gGYzkcuJpRJRUmNCqrjoiP8sLOxFhYYVEaHaXylE7ntjbPHrAQU9yZ1AyBvMU0kZhl5z1KmLaaDGmM0JgLHkhySnEnmBT9M+xDHkq46Ev1xk3mpM8DzXsFL5gNsjlFNlPtRsYPPBFeQljVSgfDPcCPnJlnr01DxzDlHAZbL9mPk3AGU4fEFAi3n3DhimTfc6cCrN/L6/Yr6+M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP265MB3688.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(39840400004)(136003)(396003)(346002)(451199015)(26005)(966005)(7696005)(478600001)(71200400001)(76116006)(91956017)(186003)(316002)(9686003)(8676002)(66446008)(66556008)(66476007)(66946007)(6916009)(64756008)(41300700001)(6506007)(83380400001)(2906002)(52536014)(44832011)(5660300002)(8936002)(38100700002)(33656002)(38070700005)(122000001)(86362001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3z/w4g1/84UdQ84wQHckvn7NgcnmGlQm9EqYz5Bl05erxXdz/tiiYClKuf?=
 =?iso-8859-1?Q?bHtOi+eZ904UGneO3Aaln8ncZMKKVNBgdOzSG2TnrgEV+GTvHXVihi9XpT?=
 =?iso-8859-1?Q?Sh5o+ZdNVxKg70gYQRiCSlA7o0ruXBq58A42pfgDKFGxoYTiN4JhC0Wq47?=
 =?iso-8859-1?Q?aqh1FoQdTcyG3LcAJn6LCm5son3lCTj7OIa2gna6PEMQWKYDO6hlCms8WR?=
 =?iso-8859-1?Q?rmwINQmo+50n+xZhtXAQTzvx8WWy/N7pAu55dtj6TdwTbsbXqYSs8sWXsl?=
 =?iso-8859-1?Q?ageQNAy7c6ulsgj86E8YEVo+cVb+VfqwgeQTQGIxWsrly7sx2X7MmPQ/nV?=
 =?iso-8859-1?Q?bwvjsPtCLgvWJpXkeqUGbXI73TqWxrMjXpvsXciRqMGdL1pwMWRy9M/yLa?=
 =?iso-8859-1?Q?b1WFguyuI+0wFlTaGu58O9Z6dc7CgtlQstkMOxCnHetnWPoNr8bu6vgcWg?=
 =?iso-8859-1?Q?BwRBAfp0oHSsSqEf/7gzdfdB6rBUvBem34vlPLNBz79A0E/hJ7q3hIgLAD?=
 =?iso-8859-1?Q?czmz93Mqx+wKegoX+IDud18nhsS6B8U5ZKtFEh8D3++kUAd4YBvshJ08oe?=
 =?iso-8859-1?Q?O7ZXbZFhfnuNwFYxaLHyTUPozNhmh9+yPlF41M3HdPy+7cMLMr5Kh/3UCG?=
 =?iso-8859-1?Q?CkM78nrGYTHd5198kkSvscJCbxRnbRY3/fkgiiIyhkjqCpBrdv2l24eTl7?=
 =?iso-8859-1?Q?fBv4ORzGmN2igtTdRo/cvuLrcXhftPS7caajVWM0KEz7JZW9FfgIow3ph/?=
 =?iso-8859-1?Q?jf0xGF+WSgwLUj+o7v5OdPvf3O5G56X2bUfTa6Kws6NxyrGF64ykmHfOCc?=
 =?iso-8859-1?Q?dGRz7lRaPf5AJIgUHEu1E9bvjHw022PgiZLYGHmiBb7+jVyBQfYmvVtZ+f?=
 =?iso-8859-1?Q?g75t2c9GRpeh08WgIwzt9nTH+JdIlWc1Y0xk5Uqk9PUL3Vs4OQ1ARnsO4M?=
 =?iso-8859-1?Q?VTAzb9v9JmtqmhkvXf5I17A9IaqaBhVBOZr/Q0LAGuZxPiKRJASNbqRyZ7?=
 =?iso-8859-1?Q?/1/rNbS24S5bL/s9x/haxqDs1C0MDkjGqcF3Dldkn5aBw6ngGW+s2JmgD9?=
 =?iso-8859-1?Q?RIq9dIzX/nuxNwgz8H4Rwid8S8eyoGZ3hraaQboQz48uFVBkYAtfRjgo2p?=
 =?iso-8859-1?Q?t752ZO11PeGIrNaZgR1cykOmjUi6IMsdcqIGCJ8bf6MtKrhv/nEWy0WNnc?=
 =?iso-8859-1?Q?CSzgizzsGbjL7XXJr6LOiZgjMfYbYK0N9YQmKOYRz04bartNMS84Cv0s2r?=
 =?iso-8859-1?Q?ixZUVgY+lbA1Gypw1Id6tX3WFojJz1Dya3J+tb7ey4BXbftj4MFLHkaZef?=
 =?iso-8859-1?Q?ZBZasi1/iLAM7XARvlHzCf8tJUsJjX8DALyPh6FJTjLlkkUXh0KFeJ96f/?=
 =?iso-8859-1?Q?x0xr8J2aDgQoOlVKGjxnF37Ajd/wo+vzS7+h/bYNZbAqSw7TA5CnxLbqwp?=
 =?iso-8859-1?Q?57aaAXzCIQZSkDoAMfoYwbab/NX+fotApV3TkWg8m9sVSrSYHB8dtMoadr?=
 =?iso-8859-1?Q?RPYbRF1hLW74C3kBnDSeyR7q9GCwy2OIJY6SRdNmzZHQqHH4DPY88oPOAG?=
 =?iso-8859-1?Q?mo4b4lWPGGkmuGgIqfZ/Nkt65JYNHZFpj5HfJheNZlC48bp7hCj6RN5W4B?=
 =?iso-8859-1?Q?Q7cJ+Mqpw9Ob4lz13z6XT/j8WuBOWlHj0G?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: codeplay.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWXP265MB3688.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7d4f62-9f6b-4eb7-b9fc-08daf496f6e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2023 12:17:25.0283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2e4de91-8500-415e-a646-3a069a1921ca
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P3Gbs7AzA4gbvCLTLOdPr+wGDfzULDFjB4yyeMjInyy2WIKBtFyBOHe7SXQiwTG0DT50FasjkXFh4tYGwo0ZJZ6SEuR8hxfLm/iQSQ8wGQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P265MB2380
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? =0A=
=0A=
Checking out a custom commit or tag using `--recurse-submodules`, where the=
 specific commit contained a submodule=0A=
not included in the main branch. The checkout command failed. (Detailed ste=
ps below)=0A=
=0A=
What did you expect to happen? =0A=
=0A=
The repository should be checked out to the specified commit and submodules=
 updated, and the one missing in the main =0A=
branch, cloned.=0A=
=0A=
What happened instead? =0A=
=0A=
git checkout --recurse-submodules submodule=0A=
fatal: not a git repository: ../.git/modules/sycl-blas=0A=
fatal: could not reset submodule index=0A=
=0A=
What's different between what you expected and what actually happened?=0A=
=0A=
This only fails when the repository was cloned with --recursive flag.=0A=
=0A=
Anything else you want to add:=0A=
=0A=
I wrote these simple steps to reproduce:=0A=
=0A=
mkdir repo1 && cd repo1=0A=
git init=0A=
git submodule add --name sycl-blas  https://github.com/codeplaysoftware/syc=
l-blas.git=0A=
git commit -m "Adding submodule"=0A=
git tag -a submodule -m submodule=0A=
git submodule deinit sycl-blas=0A=
truncate -s 0 .gitmodules=0A=
rm -rf sycl-blas/=0A=
git add .gitmodules=0A=
git rm sycl-blas=0A=
git commit -m "Remove submodule"=0A=
cd ../=0A=
=0A=
# When repository is cloned without `--recursive`, checkout works=0A=
git clone repo1 cloned-repo1=0A=
cd cloned-repo1=0A=
git checkout --recurse-submodules submodule # ok=0A=
cd ../=0A=
# When repository is cloned with `--recursive`, checkout fails=0A=
git clone --recursive repo1 cloned-repo2=0A=
cd cloned-repo2=0A=
git checkout --recurse-submodules submodule=0A=
fatal: not a git repository: ../.git/modules/sycl-blas=0A=
fatal: could not reset submodule index=0A=
=0A=
[System Info]=0A=
git version:=0A=
git version 2.34.1=0A=
cpu: x86_64=0A=
no commit associated with this build=0A=
sizeof-long: 8=0A=
sizeof-size_t: 8=0A=
shell-path: /bin/sh=0A=
uname: Linux 5.14.0-1055-oem #62-Ubuntu SMP Wed Nov 30 04:54:03 UTC 2022 x8=
6_64=0A=
compiler info: gnuc: 11.2=0A=
libc info: glibc: 2.35=0A=
$SHELL (typically, interactive shell): <unset>=0A=
=0A=
=0A=
[Enabled Hooks]=0A=
=0A=
Best regards, =0A=
Carlos=0A=
=0A=
=0A=
Carlos Gonzalez Vila=0A=
=0A=
Codeplay Software Ltd=0A=
This message is private and confidential. If you have received this message=
 in error, please notify us and remove it from your system. Company registe=
red in England and Wales, number: 04567874. Registered office: 2 New Bailey=
, 6 Stanley Street, Salford, Greater Manchester, United Kingdom, M3 5GS=0A=
