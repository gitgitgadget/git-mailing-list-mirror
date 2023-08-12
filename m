Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F571C001E0
	for <git@archiver.kernel.org>; Sat, 12 Aug 2023 05:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbjHLFjE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Aug 2023 01:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjHLFjD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Aug 2023 01:39:03 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99138F5
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 22:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1691818741; x=1723354741;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3GWIsnBL719dDWOdeGRzaGxPH8gvVL3/5/FgHBOrtzk=;
  b=nZaKrrR81jmMGb8ADgCjYgNFd1/Y0w/1TBEwftm8T7SRUfBQd7p3v+bB
   1WUT8qNOxxFkYJYASjkO/DYsVqcmqB80jLMw3/AY4ByJn9gEt+G+pQqiL
   6s8qcUd59b78oQdMF6U02ziD5ws4x3kurV0nuh1JW0zh1nIe1R2ks2XMx
   4l5gg9SQVzxpcaMuLdSIG/mHpg2lzERCuVcXdZiJ3FHgMqXcVbBeQP+j8
   9jWdbUSYfFs0XpkgFcRU2ITjuLaLXIJiXfDW/LksmG2DNHO7WQkqI+3oW
   sBMdO7vM49YxqO3hSiZ3puY9VYEHzMz2XMs2cNEvfScFYmno/m+qoGi9N
   w==;
X-IronPort-AV: E=Sophos;i="6.01,167,1684771200"; 
   d="scan'208";a="352859944"
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
  by ob1.hgst.iphmx.com with ESMTP; 12 Aug 2023 13:38:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzkhS9Isqcp4LV43ISnncq7nJuBTBQWFPY2i6mOLLlHc4r6t9o2jOkLX99WlWD7Sk1JMtO1EjsGxWNOs3ZsJdQZliOrNfy7oj9bWhu0l6NXDcp8S5/5R/ziO1wW2rXYYsxGNeI4IVG3G/8fnjNFZVYv6N57cmQGWYZEh2/eojvOhVJ11MrtkRFZmSi2vF2OnMGrgoI5IfuCcnhau7wh9dVarFs9AJQafOEFbFPEljVX3or27FfeUomeP4j6q+epbKgotfMHiosWm+jvaodtrnj7MOZLCQ/6ul+Uu76ef96g6jcQcY683Qc8Q3lPtyzQ8Tb0jn+P7yG/PLM86W5xt/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9L8b+06eoT98YPeaehtZtV/Oo+bgLWDVMTSls8GS6E=;
 b=CUzL9QrMxRYYIdCR368n6JQ4Yp45ME+oknW5sA+A9tYPaVd5wGat1ihy+0atmwPS48+ubcH5b+hWEGmg/Szs23IaDfWMeJ4+/v/v41MLEpI1Sr4aOQ5b4ch+v/8n1jFQOnzPC6mKLAzYiz5AZ0UlVQ62zsozJAoHyFWX4PgtrnRf3FLMbAo+YiPNzJUtJY97SCFp6gC/+4Fqw+zz64HykchCEP0ZdijTR1j1idg5oalY2eBn0RN7at0NE14qbaYCPNTbgrFVC6zcnya9zrPbXnfEtsXam2w5sPtRKFM9Gy8++Qwh2v2jfrrbCSPizPY6ZRKerEBYdymiCs3zjpJaYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9L8b+06eoT98YPeaehtZtV/Oo+bgLWDVMTSls8GS6E=;
 b=lhBzxmYozVCYwq4hSDE2CgUtKBYERWzi5bNPGoS5qrWx1UF5V0Q9ODuqyPOpH/mRYswOAF33cvWQnM0UXot8CSNkKtlfrdPrGXVMYLpokjELDHZ2WuwW6Ry7+sNnIVgDoSMZHSCqtT2YeoOVEfoWaqrStiHwrRL4/N0hjs/WD4M=
Received: from SJ0PR04MB8289.namprd04.prod.outlook.com (2603:10b6:a03:3f1::19)
 by SA1PR04MB8825.namprd04.prod.outlook.com (2603:10b6:806:388::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.20; Sat, 12 Aug
 2023 05:38:40 +0000
Received: from SJ0PR04MB8289.namprd04.prod.outlook.com
 ([fe80::1032:2a66:96ce:fef6]) by SJ0PR04MB8289.namprd04.prod.outlook.com
 ([fe80::1032:2a66:96ce:fef6%6]) with mapi id 15.20.6652.029; Sat, 12 Aug 2023
 05:38:39 +0000
From:   Mun Johl <Mun.Johl@wdc.com>
To:     Todd Zullinger <tmz@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: "fatal: Not a git repository" issued during 'make' from source
 code
Thread-Topic: "fatal: Not a git repository" issued during 'make' from source
 code
Thread-Index: AdnMjcTVJgLV9DzbQRekliVLGjBYJQAKb8uAAAnLomA=
Date:   Sat, 12 Aug 2023 05:38:39 +0000
Message-ID: <SJ0PR04MB8289E60CA76DF65C17A79DF49C11A@SJ0PR04MB8289.namprd04.prod.outlook.com>
References: <SJ0PR04MB8289FF1D6BAC59833D922BA89C10A@SJ0PR04MB8289.namprd04.prod.outlook.com>
 <ZNbYNxEfPYAB3ILb@pobox.com>
In-Reply-To: <ZNbYNxEfPYAB3ILb@pobox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB8289:EE_|SA1PR04MB8825:EE_
x-ms-office365-filtering-correlation-id: e41958ee-31d9-42fb-52fc-08db9af661d2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4MabBqac1uzXy4fFjQGqfNtEuDqpR2vbc7QeH0iHaCeLSbYERDj7+XERxddfL96gTCJhHWrgr14uvjlkypEH2/J20j1CayBM5h+DZISVgC7TCGQ754HNXo12NA65hugRraXHqQSXBzSyK6t+rkMZhwFp8JEovCyiDOYohKeoyo3dDdhevXraEndL8nfTGLTHgU9llIsT/W56K9Cc0DGH/qDKOKWoJQOP1riXlwlcEXhYBwfacKdpaEaMR76XcJvOUBpW96KcE2ROkV7mtOg8XlLvtJ5Eodgr5XOvkNNRGM5Evwx50fWUA1t8BPCX4LqcLS1+kcNlhqqz3PpzkEXA5hwCLOt+RNBX0tCc9+XbcHscnjeSXA62zADEB/RDVTEAwBZFqKE0P83snzFICuMCaBrPurOcFPrts3qKO80bdtS3ZWmowiR3XM344iUe26q5PzgWsVW5s2ZLa7jvay247bF8uwvS49Bi+q8eNfR21A8JRlFzw0tjAlHyfGe9tN+Yb+dKAcgfBnjOBm5TVolAeScU3dB9EGqXVdPNjfXfQMbT+HlFhvQPLmdY360T6fs9VatT0m2IxxjJ0kiNwqm2/8pg96Q6GbR61uVsorf8mdQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB8289.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199021)(1800799006)(186006)(966005)(9686003)(71200400001)(7696005)(478600001)(26005)(83380400001)(6506007)(66476007)(2906002)(64756008)(52536014)(5660300002)(66556008)(66946007)(66446008)(6916009)(4326008)(76116006)(8676002)(41300700001)(316002)(8936002)(86362001)(33656002)(38070700005)(55016003)(82960400001)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Q097H/+KVSoTyjdNDhNI8fhjm3VgwFpCpAJeQn9a/kyiAqMMbOvo7cWDeU?=
 =?iso-8859-1?Q?4M0kBBrK9bMy8ruV11AziDPJK6YnDeRkNT4eC50ZtzNMpIq1xukvoYPt9A?=
 =?iso-8859-1?Q?2Eb1696595IsAGcm+UFl/1/ReJKDOL9Rv7t4o/kwLxRcU/xLaSrc1ZFoOf?=
 =?iso-8859-1?Q?1ob4O031Q3hCxXF6ryCVd465YV5ofiPIDWjJ/k6uLG5DBg8GANKaO+qXXt?=
 =?iso-8859-1?Q?IvZ/yfN0rXELzpDjC1RlOsX3f+osOrpdSx2Xjcv9/idpv3t7z2mBSA98RI?=
 =?iso-8859-1?Q?G9jXJ3lvHAoxAtjplYzcg6aG22LWSoiHU9vHWEDivJd2JKZme4lquGces5?=
 =?iso-8859-1?Q?IiRMit/7zTeAfKO5vkXUszuzVLhBCNjN8ocB4v6Nmm48uvGdt8aVSn2dIy?=
 =?iso-8859-1?Q?EdHo9god9YrWdGRphCObqb/ZkNzdGyDo1pFqSBQzoWP4otl4i9Q6LwQp9X?=
 =?iso-8859-1?Q?T/m9yaerGjEZHou2AYPqEO3s/dL0MScRYaCsshGiime57CxRfDRUOkEksg?=
 =?iso-8859-1?Q?GpMJAkgDJGEd3mOtcnMe9ecpRfxHYjt0wHAET6esEpfAwWWjnrrjTRjrJN?=
 =?iso-8859-1?Q?SltiCINNJzeVaJqvDZVf0YhEMDIKKDQHo4BkJy180keG/E4KIl717aoOhM?=
 =?iso-8859-1?Q?5cb3ELzHyBmwioHeIa4JqUHe/4Fca66GHoJjKhIijupIZXrynzbmRnS8L/?=
 =?iso-8859-1?Q?7GLHG8yvRrNYmf+FpTo2bV49AgP6nKMPk4q27jxpsq+VZU+DuNTuTukK32?=
 =?iso-8859-1?Q?7JoxVcLKLhsqCDMwz/LDZarY7E8tmsUgQv4B2oXzcXH6yLeuMKxtm3eyIR?=
 =?iso-8859-1?Q?JUIIInfLkgA6GCt64Py3pVYM9OsGchuP4NP02jQgF7BbQaKr+QUtCjoF17?=
 =?iso-8859-1?Q?QiPP7KPedqpYq3CIVfT4kK5HhlIpr8uyQwkCO2aEc4ekPsXAm4pOS0lMOU?=
 =?iso-8859-1?Q?e8YSFMxljRN239EC/aSPpgphzV3nWjY3AWUt66v+FD+aMnHjllr3Y8U8Vu?=
 =?iso-8859-1?Q?TZZEBlDTYk5uiB61MEsfiNNv8d3k2cm3hSb5Zyr+eNkHrc88fkMj/MLXag?=
 =?iso-8859-1?Q?HNjuG7EZobgv2mQC/b7b9MJpP6H0VLYfBy2Z5W34Sc1OsyBmzYWAasgx4B?=
 =?iso-8859-1?Q?2M/e+bH+jPKaVC+Dtr5FV1PRpXQu0LiB0iBQ9zVe2EUISOHlDmcb0AYIkD?=
 =?iso-8859-1?Q?bBVGvagps3kuQnOBsWG4DPHIBFHU/LC7bLz4JmjddnrecLbHwK1XPTcEJr?=
 =?iso-8859-1?Q?wcUWGxx+Laf7Vsz4nlnRHgTtKKFa+xJyKALrJwyvdc/6db+AwwBX33cmQ/?=
 =?iso-8859-1?Q?ychpOL6pjWoCyqW4ZWQqUujsQCdjsry531+osaF1pqK7ccUOzlaavpLPq/?=
 =?iso-8859-1?Q?KI2rzFE6BTSV33+jyiZdP/ab3ENaXxr9FYZXdE6j3Qou+shETarHme1RWd?=
 =?iso-8859-1?Q?XwoiXO2gobrUAgDpbPGrjNR50wFsvnOQKsbTLdttDTfCHxOEKo7AX3xurY?=
 =?iso-8859-1?Q?944UTAeK7pYJ4GIFB1RPrAiH0ukGxM3DslYVyaeff/21vi1XRMdQEFIa/p?=
 =?iso-8859-1?Q?HdswACCNRELMuiGNkGG2gH/ayeqiMczFpKTfYpNI/2hWcLKMmLyeD3E5+Y?=
 =?iso-8859-1?Q?gs5RdYybIFCvE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3agZaLKYQpfVdz+1CulOz1ITAIWquMd8hysPYRQ+NulsNrptgAXO90OMUloBIkGc211kFMR82NJuFzTzlT3B1IVV0nj9WNv6uoJsvwM/iQQnlw3px3doLG2VT4KWY4plnmgKcrR5wn614mhbXLK+5yp5Nbpfyim5M4IokFw6PyrAWw4ngLu376V/89+5rDXm4t5goR9jQzCio3IyR7Epj7y3X2jVP20RRjNwgxcLCfbp4YiQrbGainRZOrcUJ/N9dvU+jGI2WVmnTzvGlkvlGufRLFfXuBJc0HU7A2yYnlzNt1w5cAuhFgXUyu2FvQ/dKyDz2aJnj126FcVwBrYMab2H/PDdHgBTdyBwpDMV6kp1XZZidGw1bb0vpm/86cN3NaSzM+AYd43qKk1Aa3y9BRpULNLsT08IJKzdEJCsiZptJa1UFntGH06xr7/M/UIHbWmfdHWulDAN08djAEs1PCz80nOE1gETPyU4uGvLemAQvajN5Q56ENAXegcof2PZMdLM8rXOnPgFBuAS4vRmGHSkFB7arHHz8dgNLZC+9jtXLoQqO4FFe7HDB0RcfEKraRKFzp/ETdEwh1SVjG+CG5MYccdGpIi+dycjV9zDY7Ll9Bojnm6/69gbo+7GOkA9wNQL80Y/jTJ69qhH/JzH3k4gdcdjHOGrAnzxpEBhbl4CIEFJdnRQdSzZp6Z3fnZfqtEXonZMCk9HyFQFHW9aSCCRkwJGgYE6/JCWXkveSEbZyvN9rxjCBfvyV4tuZgN/v94tX9UvdnT4hVY7Z+3Sci3YUGZLDacWbappHYBzOGm1aqk3h2mNJpe9fXTW0sxO
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB8289.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e41958ee-31d9-42fb-52fc-08db9af661d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2023 05:38:39.6347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: obqvsFXzO7fJdq5ctddScKlwCEXaYRMHAgncKptebk1V4Z1Q/j8IfsonuJTG2pzhmAIKAT3IWpwiuoaI+JMotg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8825
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Todd,

> Hi,
>=20
> Mun Johl wrote:
> > I am new to git and am trying to compile git-2.41.0 on RHEL7.
>=20
> This isn't a direct answer to the question (which Randall
> and Junio have covered well), but if you're interested, I
> build git-2.41.0 for RHEL/CentOS 7 (as well as newer
> RHEL/Rocky/Alma and Fedora release) in the Fedora Copr
> ("Community projects"):
>=20
>     https://copr.fedorainfracloud.org/coprs/g/git-maint/git/
>=20
> I currently maintain the git package in Fedora and try to
> ensure it always builds for all supported RHEL releases=B9.
>=20
> For RHEL/CentOS 7, the steps to install would be:
>=20
>     yum install yum-plugin-copr
>     yum copr enable @git-maint/git
>     yum install git
>=20
> The upside is that it's a current git build packaged the
> same as the RHEL package.  The downside is that it updates
> the RHEL package, which may not be acceptable in your
> environment.
>=20
> It's certainly a big jump from 1.8.3.1 to 2.41.0.  I had
> forgotten how ancient the RHEL 7 git package was. :)
>=20
> Alternately, building a git package for RHEL 7 from the
> current Fedora git package is another option, if you'd
> rather have an rpm to install on multiple hosts.
>=20
> =B9 I may not continue this due to Red Hat's recent decision
>   to restrict access to RHEL source code, unfortunately.[Mun]=20

[Mun] Thank you for the link and the additional information!  I am going to=
 try a little more to see if I can get git compiled from source code; but i=
f I get blocked I may download your build :)  It's nice to have options.

Thank you and best regards,

--=20
Mun

