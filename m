Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EC1C433E1
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 11:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9BAB20775
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 11:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=metaswitch.com header.i=@metaswitch.com header.b="LVZy5Akf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgGPLDY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 07:03:24 -0400
Received: from mail-dm6nam11on2123.outbound.protection.outlook.com ([40.107.223.123]:59873
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726350AbgGPLDX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 07:03:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePOZcG40wogAUvkPoqHQrINnl5CPUM750/gRPpp2U/c8v/1RzQC5wW88euvVJWYyEvDmiZmldpDmcvqpxhBV5zWWF79tQPSFSUrh1B/rvXLvhpIuswjKeSVkAFK3fmRp03AwJkNRtdEqc17xPZ5Lbl1UCKkgatnSGaRQuVhS+hmDNGBnDVVx2ys4bLS4y4gsw9g1yEk8GIvSDarG+w+QpXVrqhLHVewGr43jcTRgL562BC8DB3bEiQk7yNG2rsVOsJ5flKJVFSpawZQW5udRa9EFC0niM2216M6yiaX/FJGhfav5ERwCmswSJoktrGV0iVlWTthpUKasojNti8y/Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZvtmNPcJzBLcPjd7lNC9rMmviyPe9K/zQ0Y5g627/o=;
 b=mrb3nheHzyr4tCXBT4ggkJUbErqcqkzw/Hy7Yr/Ol/EQ1xPc2y8r2S2ixHHrxFJPvc/+3E7HTZ96hXsy8rE4ZSHJh5qx8sEAU1Zsw2lCJvHRtMzokvuYsoV8FVwUm+g6WUB1Mh3aYzjsAQSeSx5r0+CMtqWyNhtEKY4gUXwrmIuCWHg+YJv4Y98Hg3goGFEVkgejpch1e5EvzUnGjwMTfXxeOFiunM8WaSbIk+0cY1O2wmcsOdym2nPlyCLvN5G0BtEIvSPlW03rSZe1DJWqMYS2ZgyOYTG8aF9yo43wC2Rb+ziVEs4mZ7FXRQiP7n9rt1cfst9tIHWDBB8PzBjtbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=metaswitch.com; dmarc=pass action=none
 header.from=metaswitch.com; dkim=pass header.d=metaswitch.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=metaswitch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZvtmNPcJzBLcPjd7lNC9rMmviyPe9K/zQ0Y5g627/o=;
 b=LVZy5AkfCe6WwPxtoEjtzaEcl0oXQMMnMEEBnJi+/5OsCkTkSn2Ixn6YVAkAZD/75cWEX3z7zV2o3y6Ne9AdhKyfd70o3KBBc5GZcUez5GeMBtcK1uGpaDHl4KXqeoabxOs8S0W7m2vpYhE+MRXbZOZya6iXeNTun6MzqeypPXE=
Received: from DM6PR02MB5276.namprd02.prod.outlook.com (2603:10b6:5:46::19) by
 DM6PR02MB6443.namprd02.prod.outlook.com (2603:10b6:5:17a::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17; Thu, 16 Jul 2020 11:03:22 +0000
Received: from DM6PR02MB5276.namprd02.prod.outlook.com
 ([fe80::a53b:99bf:7f9:b3d2]) by DM6PR02MB5276.namprd02.prod.outlook.com
 ([fe80::a53b:99bf:7f9:b3d2%7]) with mapi id 15.20.3174.025; Thu, 16 Jul 2020
 11:03:22 +0000
From:   "Paul D. Smith" <Paul.D.Smith@metaswitch.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Git bug - Windows subst/net use, Windows drive letter prefix
Thread-Topic: Git bug - Windows subst/net use, Windows drive letter prefix
Thread-Index: AdZbYEo84lY55Xt6QpSyzl9Qqa3e4AAACeYQAAAMVOA=
Date:   Thu, 16 Jul 2020 11:03:22 +0000
Message-ID: <DM6PR02MB5276FB15B1E9E66E98A0B7AFBD7F0@DM6PR02MB5276.namprd02.prod.outlook.com>
References: <DM6PR02MB52762B49AFBA042B541CE039BD7F0@DM6PR02MB5276.namprd02.prod.outlook.com>
 <DM6PR02MB52769C88FFC893FE3D44E901BD7F0@DM6PR02MB5276.namprd02.prod.outlook.com>
In-Reply-To: <DM6PR02MB52769C88FFC893FE3D44E901BD7F0@DM6PR02MB5276.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=metaswitch.com;
x-originating-ip: [79.76.46.241]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d639b61c-1e5b-4cfd-b0a7-08d82977dae1
x-ms-traffictypediagnostic: DM6PR02MB6443:
x-microsoft-antispam-prvs: <DM6PR02MB6443E2E51E16158261F68985BD7F0@DM6PR02MB6443.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tOFJ/LR9UX1h6+gaXm5gqW7Rj0EUFsMGeAiGmoMSbKcuqrE2+UVzl921nIofOcagl6dDyLUipEZxRwe2UtDHEgxRsXVtcw29ZZHEo8jLVjZZ6N1SYSDQDuQkRbOQqncwPge3r7Z2kvuN6zRHXitPK52OqLolEVCVCV9zjF4BOYlZ3DwH1qFS1Ghxt8Bs3IikBPN5nWWoP2BYSIk3F3pPfofy/ObAHfKuB+6p0gQTZygL6cMQv7Ox0lsWuFHN3xLRIwqSdq0dNVAh9F4Dfi/bJSAqcr98cWvxYl1I4AkxVGu1L9V+pMknYti6Aso8xgkN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB5276.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39850400004)(396003)(366004)(376002)(346002)(136003)(8936002)(71200400001)(55016002)(9686003)(316002)(8676002)(2906002)(2940100002)(478600001)(83380400001)(76116006)(7696005)(6506007)(64756008)(26005)(186003)(52536014)(66556008)(66476007)(6916009)(66946007)(5660300002)(33656002)(86362001)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: icB/JQFnqid4d8o4Xt8azjibPG+bT/ATBhU/fieq0dqy0qsbITaJ8o52WVtSpyKSU5zZz8QsArIZs6Ta8qSgjcjTzxTQbOYkCPBsHLRLeqhkuoxeZQgM0adsP2GWqdmTo5NpuujjI9mh55GRugbUySdzz4/iWdLDO48xl8pAi3H91+Zm3kb+cl88M9TRXZO8dkAG28HlZy4P6QvKYynbF+qgbO88U/qfSBiS7gz4JdqNuJUOJyjchb/2Qu6KupE4B0FM+xFCgp2r6N8R31RdccTzOMo80gi+zunbgUqgn9PC+992ozgagmo5Y+GFrKi5KEJ9DWkgu/gnKxbp6zhl+cvU1xE2t/lEGxfKoZyM4BY8QoSgELoO/3LQ9K4UuV5g2WDgKaXGxEmp1ZQbKIDWv7bhWlCCLqanzlvcbyPXhBMnIuVYrlhOql2IyizisKnoLLt3ymzam/9XV9a8cqlOyZHBnCqRNikD30ZQtbzu5qo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: metaswitch.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB5276.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d639b61c-1e5b-4cfd-b0a7-08d82977dae1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2020 11:03:22.2716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d9e56eb-f613-4ddb-b27b-bfcdf14b2cdb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j3uLOn+/aV9gv3iDLMXnWcIzBMej/r1l2Y7CRxZwyIi/Dk5+M6pjXTu/aylv9IbWXKS7fR5hv/vU19XdZsnd6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6443
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I believe there is a subtle bug in Git that can mean that a "git add" fails=
, complaining that "fatal: <filename>: '<filename>' is outside repository a=
t '//<server>/<share>/<directory> /'

It may be possible to reproduce this with simpler steps, but this is what I=
 have that fails.

1. A Git repo on system <server> below directory <directory> that can be re=
ached via the Windows share <share>
2. On a second system, perform "net use z: file://%3cserver%3e/%3cshare>"
3. Now you can "cd /d z:\<directory>" and run "git status" quite happily=20
4. At this point I can also so this:
	a. "cd /d z:" then "git add <z:\some-changed-file>"
		i. Note the drive letter prefixing the full-filename
5. Now do a subst or a net use as follows:
	a. subst v: z:\directory
	b. net use w: file://%3cserver%3e/%3cshare%3e/%3cdirectory>
6. You can do both of these
	a. "cd /d v:" then "git status"
	b. "cd /d w:" then "git status"
7. However both of these FAIL:
	a. "cd /d v:" then "git add <v:\some-changed-file>"
	b. "cd /d w:" then "git add <w:\some-changed-file>"
		i. Note the drive letter prefixing the full-filename
8. Performing the above requests WITHOUT the drive letter prefixing the fil=
ename works!

I assume that this is supposed to work and there is some subtle error mergi=
ng the repository root and the filename-with-drive-prefix.

Regards,
Paul D.Smith.






