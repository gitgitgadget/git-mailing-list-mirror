Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE25C04A94
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 21:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236864AbjHKVP2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 17:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236752AbjHKVP0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 17:15:26 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7799E171F
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 14:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1691788526; x=1723324526;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5wEWUOe5TYhPFKLkrGTr8QJBMd/lDYR9EySulIzaroI=;
  b=gdhnALlaqtI2rxD6O0gRih0/HDOJPqxHM1B+QPvq7M1s4J34RO5oDBW3
   YtpZQB2jO51vh5/Uwnyt158kxAtDnj+X2M8rd9PGWwFvIMyPRFAMMQ8DJ
   zrSVtQVj0lJf7jUnGcH6nr4quOfAPYZIR/zoiTurBKFSNAcLVtlXRs8jT
   j20aAKbYVEGNFXkpOsGROn+bPK9MNcBx9vZvEFI+mHBqpcS3YewMUAmOC
   jfwO8qUB0dldjhvnRQrGCJQe171RzlUtiu/ZTc+HSvVaIhxS0mgMbrf8K
   bXf+JSBLvwKCnwrLCWv4g02foFLTNTfqtsER86/gNlwVidirliwiodY96
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,166,1684771200"; 
   d="scan'208";a="240685680"
Received: from mail-mw2nam10lp2102.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.102])
  by ob1.hgst.iphmx.com with ESMTP; 12 Aug 2023 05:15:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6LnYEPD38WqT7Pqf2gHIBB6B00fw8NKlfwBm8SEEcvkuHaYQO0cba0NxoDOCptlovAT8vzgX9xvDL65v/e2lP2SqDKIWKfoSHd4ZbFjmNVyOtih5B8GjzkUa59FdotNWDLwUvN8nB4dqr0E9NwWuoojQkubRL7MJVTG4j1C19GiV8JbBw5/axNQ5jDnHovXwhlTtja4LFAy0p04BxfXJVdUPAvOcSFp8Zs2oROh7ku8V7hF4F/tb11sfCNBvmiSPPqkKjh0li/7SXmH0roXOZtBC3gkd3PHWBFgWd280qRiAjiTkfwsZlXNqBfZQB1cVBHyJ69WaQJCZqIEFo4A3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29NTggYkm661GrmhPMBym0SU5uq+TV4jTkfNrvWFU3w=;
 b=Xarr/xb0rps1ilTi04P/ofx705Ducv7D/dj2hvamu7vu60nK7alRBkH7pWmlOEcjnOwf/omUGEpyWQo2+tl7VDVpJP73t6fhL6XUIsSqxuXxs97PKlK0oveH6Pb7bCaU81Y810PDEfsLtzTeKp7MoUDpcYi809OCbLTlGiy8bdcLEMGXtd9yDXHnRnVRBNruHwS4tEw8WAyH1WPUgD8RHaLRSQHC2tBsqgwIHmx2F1ZoGOwO/f/BNKv3rlND3kN/7xySs4CZOXiwzPgEkNK4UDbc4DF1G7x+7j5kXsTsNTqlDItDn2yoGVX5BNKfSG56jurYxcgysrKp3ID5Tc/ESg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29NTggYkm661GrmhPMBym0SU5uq+TV4jTkfNrvWFU3w=;
 b=OOtgxSg4V3p6ke0/ba7oAAyP3PAQ9uoDiVjVz60TjoFqSt5HhwIm7KRKJs4oJIZm/sZrJzE29ibDd7JqEWgLPFqgIa8hSshUFbCLs/ePvFjbSMbqp9vJjMJHMlMYbqxEUwHus3FfFNBLo25ZXCjRCZvJswS7A2at4VYvWDdOVdg=
Received: from SJ0PR04MB8289.namprd04.prod.outlook.com (2603:10b6:a03:3f1::19)
 by DM8PR04MB7925.namprd04.prod.outlook.com (2603:10b6:8:a::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.30; Fri, 11 Aug 2023 21:15:23 +0000
Received: from SJ0PR04MB8289.namprd04.prod.outlook.com
 ([fe80::1032:2a66:96ce:fef6]) by SJ0PR04MB8289.namprd04.prod.outlook.com
 ([fe80::1032:2a66:96ce:fef6%6]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 21:15:23 +0000
From:   Mun Johl <Mun.Johl@wdc.com>
To:     "rsbecker@nexbridge.com" <rsbecker@nexbridge.com>,
        'Junio C Hamano' <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: "fatal: Not a git repository" issued during 'make' from source
 code
Thread-Topic: "fatal: Not a git repository" issued during 'make' from source
 code
Thread-Index: AdnMjcTVJgLV9DzbQRekliVLGjBYJQAAz3CAAAC6tsQAADubAAAALjhA
Date:   Fri, 11 Aug 2023 21:15:22 +0000
Message-ID: <SJ0PR04MB82892A7EB350531DBE4701BA9C10A@SJ0PR04MB8289.namprd04.prod.outlook.com>
References: <SJ0PR04MB8289FF1D6BAC59833D922BA89C10A@SJ0PR04MB8289.namprd04.prod.outlook.com>
        <034501d9cc91$069bd360$13d37a20$@nexbridge.com>
 <xmqqr0o9qpon.fsf@gitster.g> <034d01d9cc94$df9db0e0$9ed912a0$@nexbridge.com>
In-Reply-To: <034d01d9cc94$df9db0e0$9ed912a0$@nexbridge.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB8289:EE_|DM8PR04MB7925:EE_
x-ms-office365-filtering-correlation-id: 249eacfa-1d5d-4f8f-177a-08db9ab01333
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gmy+FHIaWer7L9qiy162kGk6MonRhdSHl9zBGBF+vZtMZ3Uq8E42lngBoG4FvqfTQj97t3KR0OF0bJdSsZhMhXq8gwnD6qWGWD/fD38qGQ/9nMbUPoTVTHlaweSqPXbIsrrPe0CdB+x3kARzuaOXtLyI3R6przZs82bFNIoDAfNWiZUf47m35MB5Sm/AL+iNgrUpsc9iJWgxr3DnsM3YTmUwnclxHeU0pNjx6VFLyoIYi7EA9LQsDSh/zS8Wh+Go3oaZJ6urRf0nnV5Ws8TL6pLHf/KoXTkFk7nMurDLSVcOFg8A0uOANZDvlrLWog54SPosYSvtsd9LeqUabiUhywwmV79qU9Kn8uJvST26mbY+wpuv4iIWuHmJZaDbNrXx+oXuFZOb9PA/NRPL68bKhV5E1iEJJixbp2Dxj0fbCwYxSl6OGajg5QyY4XWpPy4274kiItVSNAgH53OEH1C/+emNIVR2uRGHZfYG66XwGAtOgkkyv1kjxXGTKTQaoY/urHIJvOqSSEZmsO6I8uiEIl8PlYr1ReHzhRkiBHsVnHKvY9qsYUeXeKRyMF6HAZmJ0P0orAw+v8it5huGj9gcHgyMzJGlzV09Ld2D5eEUaIM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB8289.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199021)(186006)(1800799006)(110136005)(66946007)(66476007)(66556008)(76116006)(83380400001)(33656002)(38100700002)(55016003)(66446008)(5660300002)(52536014)(8936002)(122000001)(64756008)(316002)(8676002)(4326008)(2906002)(41300700001)(38070700005)(82960400001)(71200400001)(86362001)(7696005)(966005)(9686003)(26005)(6506007)(478600001)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ulsw4pT8IqhcihdBS8EZw7NNwUIqpUiQP3HOT95EcjfqI+MpVikJYmNDoO02?=
 =?us-ascii?Q?3XWIUO3cBrhVExjeeRL36DVtaHsPzW6xXUOsoO7tNDpRgWgMaD+LtMszrrwx?=
 =?us-ascii?Q?MKdWf6HcVpUty8ULWylYMl3mjaInctsPlXZZdYAhAmzmZ9NNhexL7rz+mky/?=
 =?us-ascii?Q?hdvnVU5rRB4dWa//RIaWGBDVPZsPM0r6pO3wXcoEd+gJxom9S6LdOJMISa4j?=
 =?us-ascii?Q?BkSqqfZvOdXaCaVy7zor8YUo5CWW4tsfUH4osPP9OcSoXtOWGaXgK+dc8+hY?=
 =?us-ascii?Q?1VIA3ZvRxmmJCaL1ECG3baoAJrMldWYLh+g/eHc6G7PUlUkPJR9ihW6Q5NcL?=
 =?us-ascii?Q?M25dgjuQuzY0nNyaFl/sPhzbjfuvko3Vbqe9ONLN1ZEjZYihJXLCMIPjSfg2?=
 =?us-ascii?Q?aaLChU/TQt0vH2qhSZZmKq7yoJLTS9wTQYV++R7kKPEv7LIs616teUk9O9Lg?=
 =?us-ascii?Q?bLNT9UBDWZIuAe54ULnA6T2ck+S1eAm0x7K1Khbfgxg3jW7qfAadDrqHoaew?=
 =?us-ascii?Q?qavvqBWasiwqkKIObot1Y8PcpQpRe1kt6bWctH3HBoW0tqqYEvXd0OiDc0Bn?=
 =?us-ascii?Q?yb8TFmz+aI7mdjp33qjHzMqdXaIyGjPDXJwN80kAtpT1u98oA/WgdmLha72o?=
 =?us-ascii?Q?kaKQfqbzoa49ze2fzbdQZL3PPDuFeDQGWGufvug2JHAgVqpVOabCjf+dYCaj?=
 =?us-ascii?Q?oRU9JlfTErBB+QbNbxgQc04nrcYBFsicfBT+AzaCpXbkY/Qr0Pyp0C/7FJIL?=
 =?us-ascii?Q?eqqm4rlHcQe0519SytAGdL0ivZVt1N5hYaIRFdfY+Ozsau7Dq4oojQWBqv9K?=
 =?us-ascii?Q?yJFJfHvqS2r3ogq9w9TqWu4PVvMYuWsvuVxDg0IMFk8XORaNGpGWEWOYhjvi?=
 =?us-ascii?Q?5lxrFeeKw8vFi2vBPxrLQbI84tiPjrDqiNtRc4LetHWEW9IZ4zptHQgFOcA9?=
 =?us-ascii?Q?VmGjjcNjmuNyL+mtrybHBDIzheFeS11KdiS/rq0xBVWgbo8SSqeDrzqPmW6v?=
 =?us-ascii?Q?HsNbgdSPP3gQwhIC8bPSrkIHgxDShkCQLXqAOI7PPgafDmxIx2F05nDHOsNu?=
 =?us-ascii?Q?HA5OpKZoAn0DejtSjCoKr3LkETDBjZKfJ5IXynqRVDKL/Eb5tHINO/sxh4QC?=
 =?us-ascii?Q?S8zbyJnr1F6lETeJSagZmGQWBbAez2etPDxFesXz7DMy4NF724azu1rNt3d1?=
 =?us-ascii?Q?L/JtB6up7wAb8DPd5y0o78Mfo+Sj4/+HSTz6w2iDCGCcGDxkpEHd1KROoZGO?=
 =?us-ascii?Q?CHD2EGEXdcNp8LJHj6CN1yFWsS8q65NYDAQM+Lnru63NzcWqxyfc0yxPDg09?=
 =?us-ascii?Q?qJVeSdQI+9CPSZYCFBm7YoKIOv6/TEHg5xjmNMUlLAZ0JUu/1zoRwYtoFvlb?=
 =?us-ascii?Q?eQsGF3jy12YoMRZXyS/xzWfRqAvhT0IAi9+lnoAszN4pgP6rB0m+UOrvndcB?=
 =?us-ascii?Q?XOQoF0iY1B/E8ZK18ecOEuzyfoTVnwpxvO9F9TGdpEeSHBuMHdGhETueBBea?=
 =?us-ascii?Q?tLZa8jvsdfyGpwAwxdJvUppVl/yqBlqrHxwY/OFaBRF1K9cGkBpu+4it/k4C?=
 =?us-ascii?Q?Jbv/wj5ilmLG/y66Qe4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: u5MGeckI9nyL8tSbnYWTexZnGhsIfkSAiJVUuq6ERQXvTme9RTt7EI07lyNbXLOzF23gPTjeWmZHBYSylbWqAbL5ut6GMRo9t1mI4QVMU+Qsds3+hO9PYY/QJdnFvlBJK4gdXX8vobDtO+fQXeJnL+cfZC47iPyjvKr2lwc/4e90+O2EPlgsnDraXyJBT5WK3rTE1oCsdfcOSGpj4BqyHsMONGWqrulOhvETv8h7pCN7oI23Psw3gSV6Lp/0IeM9Er5zCNulwQoK4DPe1Imt25HqFzYEMMDhEbgt2N5VMz1AuqwdMLId1g4zHf2nNyt60/L8gg82F7kbUHSNoXvjw1SHgQTsKNXKH17ryfEUj6HSD0ihpZyPA5pGfp8/PfEB3Y+qbbKi3Cukk+824dBojgQN7/1nf7fINYBptwDH1Sps0pr9I05KFbUHGL7vTSedrOjfp5maLmz6X3uMrsxJxRw8Ul5ewmKpeOQCSH12bVU7oJYpU6rqUDx7Wt1xIs7J0fjVmEZdBtddB5a5gdOSCd/5EWxx+vQG3Lkf0He4Z24vjckVEcd5rD/X6PyO4lL/PmYCbVGBZxQE8v4+ozoroxYOKnMH3YI7zTcBAKATtl57eNoA4Hl4ieBlZowCpCdHOli6jGIAo6KEbDV6VfrwuVQd4wGg2EoWvJeuWt080yWXc18zvh9Com/aqM/4vLImsiRgZfnrzvirUGctT+VuMU/vLlLq2HUXPliQxKeuI/9a8V7KPDxWwO1u65OtUGrtBb4amC5H0S/+W8grkKu5JdNjfNvOQCgUgIESMrSW63HpHmlqnXDe/61I/yrB6QWwyy/4OaO3Dt4gMhQeDkOhrw==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB8289.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 249eacfa-1d5d-4f8f-177a-08db9ab01333
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 21:15:22.9755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vo+eb1dPK9tiALHo+avOWAdJ7Q2JfGOP0S2jkIAGqjD3cJokfcet3ma96JSiZs+5YdZW/oYjUOrwk9vju/gQbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7925
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio and rsbecker,

Please see my comments below.

> On Friday, August 11, 2023 4:39 PM, Junio C Hamano wrote:
> >Subject: Re: "fatal: Not a git repository" issued during 'make' from sou=
rce
> code
> >
> ><rsbecker@nexbridge.com> writes:
> >
> >> On Friday, August 11, 2023 3:57 PM, Mun Johl wrote:
> >>>I am new to git and am trying to compile git-2.41.0 on RHEL7.  When I =
run
> >> 'make
> >>>prefix=3D/usr/local all doc', I get the following error:
> >>>
> >>>fatal: Not a git repository (or any parent up to mount point /tools)
> >>>
> >>>Which I infer means that I need to do the build within a git repo.  Is
> that
> >> correct?  Or
> >>>have I missed some basic step in the build process?
> >>
> >> Yes, you must be in the cloned git repository in order to run the buil=
d.
> >
> >Shouldn't we be able to build out of a tarball?
>=20
> I don't get the impression he started with a tarball, so subsequently sen=
t
> the doc ref for that. Using just "make" is not sufficient from a tarball.=
[Mun]=20

[Mun] Thank you both for the information you have provided!  It turns out I=
 did in fact start from the tar-ball "git-2.41.0.tar.xz" which I downloaded=
 from https://mirrors.edge.kernel.org/pub/software/scm/git/ .  And then I r=
an the 'make' command.  The process went something like this (basically ide=
ntical to what Junio documented):

$ tar xf git-2.41.0.tar.xz
$ cd git-2.41.0
$ make prefix=3D/usr/local all doc

And with the above 'make' command I got the fatal error.

I consulted the Getting-Started-Installing-Git web page that rsbecker refer=
enced, and it basically matches the above--except it uses the 'make configu=
re' process.  So I tried that method as well, but when I got to the 'make a=
ll doc info' step, I again got the same fatal error.

Due to some "security precautions", I am unable to use 'git clone https://g=
it.kernel.org/pub/scm/git/git.git' to download the source code.  But I can =
try to figure out a workaround for that if that is my only option at this p=
oint to successfully compile git.

Thank you and regards,

--=20
Mun



