Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF30CC432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 04:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E8B207DD
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 04:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="gN+Dfo+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfK0ED4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 23:03:56 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:59905 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbfK0EDz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 23:03:55 -0500
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dddf5a80000>; Wed, 27 Nov 2019 12:03:52 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Tue, 26 Nov 2019 20:03:51 -0800
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Tue, 26 Nov 2019 20:03:51 -0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Nov
 2019 04:03:50 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.56) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 27 Nov 2019 04:03:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwvFsT5xQujicGlQO8lN6BC1VMsPoLrf8uaKRPEko7mnK3B9FNcF0N7bZOLPcVlKmYgN8+xlVLkQaKae13M8vhSXGktbRFbz9lrpi+rGNxrRuUvSO1mLzUN5xGQlYk80knnOL8Joz5NjqEMww+BQxq77eAyDSiCdWO6b9mlVcVcf1xSQ6h76YBtRGuy3MLZ7PPCcBHPpdk+pa5YyP7PgA+2Oue5VaVWNkVWqhwq9xZPen31Ng9/TyYnHsjZGlfyoiSS7kmZI1KTFxGw+jRcpOFSI0Rw6+CzYCkiOmurbB/IZrNBwtfDCJhQldIcv5J6trcjrtZazVtGEA3vKdW/V/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IQ+BOf9d5S33bcOOOkax3gWtruhdbiCuQc36/6rqHE=;
 b=gaW5UCoe5Y7nC6NDhV91YDHCiOGyedevJ76DNoGTebH8HgDGanNzxf9YiF2MDtxBFwRCwmxeqwJ9hORsU7NSAUnGwJ7n3Lyv+uZM5puiHUfQaMw618YJcdV6XL72JIpydnxtjjj+KngnItwl80CBs6L5out+kmTTM3ZmjmkWHM17/w4IEG0TzHiybP9qmvdIboRa2Pp3pGpu+NRm5pp3/RiUxHbk9DAecvp8KRn8VuYPpN9bAuDzREqbwS0BPaIzDwXC5PFP3trC3TPwZcO0XHOgIrt4Ad3Xdwq1uqN6dldfpyqLX5FLzFSSMxkTjFTpkTx1B5q2KIdZ0SK0ZTY/sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from MN2PR12MB2896.namprd12.prod.outlook.com (20.179.80.214) by
 MN2PR12MB3007.namprd12.prod.outlook.com (20.178.244.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Wed, 27 Nov 2019 04:03:48 +0000
Received: from MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::9821:4373:684f:f580]) by MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::9821:4373:684f:f580%6]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 04:03:48 +0000
From:   John Ferreira <jferreira@nvidia.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: "git diff --no-index" Implies "--exit-code"
Thread-Topic: "git diff --no-index" Implies "--exit-code"
Thread-Index: AQHVpNeAVfsFwd3HTUytV8h7mlDvjg==
Date:   Wed, 27 Nov 2019 04:03:48 +0000
Message-ID: <MN2PR12MB289677B16DBF67772627B595DE440@MN2PR12MB2896.namprd12.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jferreira@nvidia.com; 
x-originating-ip: [39.110.237.146]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d2301de-8650-41d2-99b0-08d772eece57
x-ms-traffictypediagnostic: MN2PR12MB3007:
x-microsoft-antispam-prvs: <MN2PR12MB30074EC8F7C11D2BA751675EDE440@MN2PR12MB3007.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(199004)(189003)(99286004)(71190400001)(2501003)(33656002)(71200400001)(52536014)(6436002)(478600001)(102836004)(81156014)(1730700003)(81166006)(6916009)(25786009)(86362001)(8676002)(256004)(9686003)(5660300002)(8936002)(305945005)(6116002)(7696005)(74316002)(7736002)(55016002)(6506007)(4744005)(5640700003)(2906002)(186003)(6306002)(26005)(64756008)(66556008)(66446008)(76116006)(66476007)(91956017)(14454004)(66946007)(966005)(66066001)(2351001)(3846002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3007;H:MN2PR12MB2896.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8RrJqe4CstfLhcLfviix1W7Nxgvj0lRaHLMAtakCqibRSoDoKS0t/LXUZRcpACQJJMBLJF8ENOZcurR4BmEMZ1hm+fmN/SBTil44JYmNmW6u60yEtNOqGO0F+cVNW6g18M6VeRtXFSLuXbOY6ZDErdA36PTcamE2knN/ocU/qo6X6FW0Lk74HUcAwKiJmLPH7oOcEoWt3mItSxd6J+KKehp05AEM3Yzh0HI89jy1ez+NIy7jbiCYHawnGjltI/PuVi04dSZ2DiLtmz824MMxajyrqp1PZWjevz8LMmFIK4dD8fzv91riDtsCYfRbrnVcD7xTxzTQH9UepOcM1VNFTOtk7gZxDSua7jBKHXsXWv3v9T/rleGS6j+iWEZ4qLbyR33howiMYMAJB5i0ZgMJB4I5A8PKiBpuCmZ7cy0bUYfCk8oXH38XIF/c3jr85tuPsyYpx+jWp/bIBIS5Ci5w6XQ7CDABC0oaXAEz1JQlZyQ=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d2301de-8650-41d2-99b0-08d772eece57
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 04:03:48.5505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j4twP3ayl396UxS3hd+1kfg5i2+qoaHePAdI9jnkIqPSpDNoc/vqjM5IvYuEK6L9fJZAAEQ1iULjGtzGCrjD7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3007
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574827432; bh=GSHoDOnusQfmOjY5Q813TYXwbmY/OIJBqEvTFWvTpA8=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:From:To:Subject:Thread-Topic:
         Thread-Index:Date:Message-ID:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
         x-ms-oob-tlc-oobclassifiers:x-forefront-prvs:
         x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam:
         x-microsoft-antispam-message-info:x-ms-exchange-transport-forked:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=gN+Dfo+EpFi2Z5oO3g0FEmvtL9IIpnEoQEj/lf/yWnAGlKpaLoEhaxuIUq8VgzF9K
         tj4HE5tBx9qXrj3kguUBMUbNmeuHUwG5XggrvOdIGhFPoxRw6bbP5wvOkjdSVmA8Uk
         qv3wH8LM4z/ja9rkv1QHiy/YLlsdlEsoyot4LIayjbsGfz+21fLnFfRdw1OhoWfhW4
         ClHPWKgadp6NwLeXik5VehM1sn4Ez4w/+pDcUMNmViHEM57xi7Vx/zH33io+kQa9dO
         Eg3R5MXyBGiCyA2h4UeAkiE9VWrEX68VFmOQT5ABqAlvX7clJBsrNZk2bK7Gw4gVuF
         f27++1r6vCj/g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I suspect this may be a bug:=0ABecause I am not specifying the "--exit-co=
de" flag,  I expect "git diff --no-index" to have the same exit code styl=
e as git diff.=0ABut it does not.  =0ASee comment in source linked below.=
=20 =0AOr, if this is intended, this side effect should be noted in the d=
ocumentation for --no-index.=0A=0Ahttps://git-scm.com/docs/git-diff=0A--e=
xit-code=0AMake the program exit with codes similar to diff(1). That is, =
it exits with 1 if there were differences and 0 means no differences.=0A=0A=
git diff [<options>] --no-index [--] <path> <path>=0AThis form is to comp=
are the given two paths on the filesystem. You can omit the --no-index op=
tion when running the command in a working tree controlled by Git and at =
least one of the paths points outside the working tree, or when running t=
he command outside a working tree controlled by Git.=0A=0A=0Ahttps://gith=
ub.com/git/git/blob/83232e38648b51abbcbdb56c94632b6906cc85a6/diff-no-inde=
x.c#L307=0A/*=0A * The return code for --no-index imitates diff(1):=0A * =
0 =3D no changes, 1 =3D changes, else error=0A*/
-------------------------------------------------------------------------=
----------
This email message is for the sole use of the intended recipient(s) and m=
ay contain
confidential information.  Any unauthorized review, use, disclosure or di=
stribution
is prohibited.  If you are not the intended recipient, please contact the=
=20sender by
reply email and destroy all copies of the original message.
-------------------------------------------------------------------------=
----------
