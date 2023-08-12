Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E62C001E0
	for <git@archiver.kernel.org>; Sat, 12 Aug 2023 05:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235461AbjHLFaX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Aug 2023 01:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbjHLFaW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Aug 2023 01:30:22 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B6D2728
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 22:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1691818222; x=1723354222;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6MDcqMfQCjVNoKGdDQzcuh7CIJAr1WojIENTWcoyu+k=;
  b=Bp7Uz8ttZm3vH2ypUidqdMAldPJxCF6olAde0h87gBwVUhH57trWCvrP
   jzqVtuONr+TEA69blrMe/aVQOlU+KijQTKeJ7KL/meZ1RkfIQRgbEG23H
   8ghhh5KAbj7ndppEHmqZrNmSchvB67zYNiddWvIaz5gSZTkG1vC1htxY6
   TnVLg4T/gFBtnf4RWtFzhdEi3Oxp1Uu93ZUe5hekFFdcreccAACLXIIl4
   HkVnQ5AHDWiLVajFlvfWTUdm5DZhUt2zN1/h8WxUP9qQ2K1NUhSLb4+MU
   yBevjnejZkLxnp8Jb/M8BWs/E2SAf0EidPT9wEhlqH8F4q50EeYJDm25d
   A==;
X-IronPort-AV: E=Sophos;i="6.01,167,1684771200"; 
   d="scan'208";a="240721192"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 12 Aug 2023 13:30:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TliXTD0hAt2vypihMVCJ5ws4LCUM2ruxehRYNavoTf485L3YuYKQHeeg8VUPRHZlFayIB26Qa+eCZVk3lw94f2le6pXcGRULj9K/VZ332EOu7J32L9dhVeHAlguss573BxdbqSuu7IKvYBsxZi2dMPc2KFhAzi3are/CTs2EfOo9hnCe+fJGHckVRVuF0oe2w58KCEuy836Ha8JhE7hvySMe9/PxgEQ48NQCdsItymzdHd7OnxpAyInORTMljYDAce3mXoU7/K68gHr4zt3shJJQzG/B2lAGWrtv26nlCL79FfahtiA93Os/non3KRLK8oCAy4Z61uxMpTLDsInxyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQTB1m2tmKOt9qC4IPF9rCCS6cLHUYpbK8OFu/oJuxE=;
 b=EIiDJk2BWkiK96lEQfoODntHWneNAvNkQcuCyDQJtDExVTOsrA8L4zdT2ioRlQReJSid+OIkCrJEkckj2zjKB1VDENbgMnuvjcl6xvIjnbAhMwic2AOjNVH3JWLM/s3jNz1MeZfY40ADW3jLoI9nnWU+WcR8osercXJ3O54qika/BTGiuY6lRdXbTpJzUP842QeGkZ7d3FnOHVBmGR2Wq37c72hM/sM1MpBKnNMV0wYNUj7K+OefcX9ZcXRLRIxTxYHvV2zJZ1U/sVQ5QyXa9bLXWYjIHBd5En+OcY9vNrTAQxxnoXhWbOadW/IOIIV177AYIrtGVJ2V3UQkZgY2BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQTB1m2tmKOt9qC4IPF9rCCS6cLHUYpbK8OFu/oJuxE=;
 b=abkSrHcAPSc3eZKIYu8WuDinILYaJuS0TzFHAQVOLOat/xhocGvaE22OpJbG1YqQqqt4XspGvnFPIIETjIy0w39HQImPkqdtUVHUaH95XGlEuSBzCwVFxXbeTxGWxVhtFkRfQHAZ+D484xsuv4PDkLvKbmOGIUP5AQpPdwikJSs=
Received: from SJ0PR04MB8289.namprd04.prod.outlook.com (2603:10b6:a03:3f1::19)
 by BL0PR04MB6532.namprd04.prod.outlook.com (2603:10b6:208:1c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.20; Sat, 12 Aug
 2023 05:30:17 +0000
Received: from SJ0PR04MB8289.namprd04.prod.outlook.com
 ([fe80::1032:2a66:96ce:fef6]) by SJ0PR04MB8289.namprd04.prod.outlook.com
 ([fe80::1032:2a66:96ce:fef6%6]) with mapi id 15.20.6652.029; Sat, 12 Aug 2023
 05:30:17 +0000
From:   Mun Johl <Mun.Johl@wdc.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "rsbecker@nexbridge.com" <rsbecker@nexbridge.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: "fatal: Not a git repository" issued during 'make' from source
 code
Thread-Topic: "fatal: Not a git repository" issued during 'make' from source
 code
Thread-Index: AdnMjcTVJgLV9DzbQRekliVLGjBYJQAAz3CAAAC6tsQAADubAAAALjhAAAHumxEAEBeoMA==
Date:   Sat, 12 Aug 2023 05:30:17 +0000
Message-ID: <SJ0PR04MB8289EB7CF0F2EF1803925D929C11A@SJ0PR04MB8289.namprd04.prod.outlook.com>
References: <SJ0PR04MB8289FF1D6BAC59833D922BA89C10A@SJ0PR04MB8289.namprd04.prod.outlook.com>
        <034501d9cc91$069bd360$13d37a20$@nexbridge.com> <xmqqr0o9qpon.fsf@gitster.g>
        <034d01d9cc94$df9db0e0$9ed912a0$@nexbridge.com>
        <SJ0PR04MB82892A7EB350531DBE4701BA9C10A@SJ0PR04MB8289.namprd04.prod.outlook.com>
 <xmqqv8dlp80a.fsf@gitster.g>
In-Reply-To: <xmqqv8dlp80a.fsf@gitster.g>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB8289:EE_|BL0PR04MB6532:EE_
x-ms-office365-filtering-correlation-id: 74454db7-a3f7-480a-bf11-08db9af5364a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ovQtNsp1WCF2YB3Cc8X6c2Z5EhUQfthh+xG6NnrfVAiqdenpEc1wUmy3yzQagKBge+ntClZqaqYNNblOUCCxO9Sa66hh8i4eoKavjJdWcPdtVVh6XhMd1pPxGEt4fBC4hR+b8JLcHnZhc6k++rSINDFhNj1An6cZDFvK05B+vUvpEEGCNzjiUoT73sfoMFVV+XuBhWGXVxxwKvhNwfXvqgQagvFCiskZz0MR2Ncl+c7dPr+05d24SIIEphr8QgMrGjEwPEr18T/N6fG/IXUErWNU1J4CKdRfbypGSF55WcMwVIl3bPeO7rh/xM86eBe+jR0cTJyvZ7Bf/nILuN5yGCEN1DEaI5ajSXldCrgyU5/ZOhIpcqdk4zZj5I8AWhetjplHksa3Hc8C0ndaHS7lN2rJ8DPqVwm5h4A7iqFBdEnYF7CZA8jr76pyCegSzRzyfMSvLLQDERaAU3tx33mB+5JUcvt8AOHetjbTRAU8SLJwH5lJHD3IJ40/SDuyAEjoL5j8+0sE/F2xV9L4aCcCIRTeXetS2a4uA3mmKUgG/P0/U4paaF/0LNW6YERfL1FJi5zRJjbWmr61jtqp/bgvMQRKTQJZaLNS/4wc9Q3Z+rU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB8289.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(136003)(346002)(366004)(396003)(451199021)(186006)(1800799006)(9686003)(966005)(478600001)(54906003)(71200400001)(53546011)(26005)(7696005)(83380400001)(52536014)(66446008)(64756008)(2906002)(5660300002)(66556008)(66476007)(66946007)(8936002)(6916009)(76116006)(6506007)(8676002)(4326008)(41300700001)(86362001)(38070700005)(55016003)(33656002)(122000001)(82960400001)(38100700002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mvETghOaURqZfbDzO2OwVHmgeQIvyLYdhWTzb0jwITtrwq/+OB6zNdzDNnkb?=
 =?us-ascii?Q?fE13mVSAZzAnQQyRJNA9IeLeDIat3uvWQYsreCS6CIemROdqln8+U6Ec0PUi?=
 =?us-ascii?Q?fyZSX9SB7XAHNkcvWX8Zz8v4NMjnARDOFxfd3gu5rsG6Rmyb9mA9kKhjvMSm?=
 =?us-ascii?Q?YsmrflNXKRQKTk7c6E5rPKzCNC42h9J8LTYRO5q16o+neMR/9I/34EURMpO5?=
 =?us-ascii?Q?Fp0AbfseRTKVzz6Ljh8W1As2jElhop4yUDsenB9XZNON458y7zrX/ECJyriL?=
 =?us-ascii?Q?ksptAomcD0KnITcVQUg9DvaMGILd6dkAfti9vIUJKJDgFBH3ptaSivv7o6rm?=
 =?us-ascii?Q?CdTTSZdG5GjouM/ofL+UAoyxyq9KXQf7ZxHWFKvnGOxyNWVqFztGYCJvsS7g?=
 =?us-ascii?Q?S2E7yKFA7EykCGWP/YORo60+o4TWc1ETq38jfQkP8qVCHCv1fvLvosMA2//h?=
 =?us-ascii?Q?gyVzFdI0LZeT8+iGYgPe2l0QPA7cLSxEhMfRn5JbF9mm//KW1B1vfwHhcA5I?=
 =?us-ascii?Q?4B1Zebo99p969a/2Gmoz+BNHc3mho3G6x4IYGUIX1Rbg1Zyss9krqPReooxi?=
 =?us-ascii?Q?NroTX9WQFQVojobqivhEPfLnwF4l76N2pH4XcuPlip732p9GNpHjF7sxsKUG?=
 =?us-ascii?Q?7uOvkJyr/NuMvcDWeWLy7vnw7KOEyXbtuT4y12Q+eqtpeCvrsAmHzFmvicT7?=
 =?us-ascii?Q?+fknJ4m3EnTiMueG9q5k4yfXwL73LpYGcCCEEsVBiK7kxmSOk4WFWZpKeLwY?=
 =?us-ascii?Q?g90WN8CluQEhC4UOK1c5K3lPm6J4aDwU6XRlJA71CV+2ub34gI6JKcxq8xrJ?=
 =?us-ascii?Q?24bu1Mtn0vtCQtm2T1uKUnd33RhL0rzdWmtjO51fDKtUpO+4BZIx6adeSphS?=
 =?us-ascii?Q?6sA8IjpWW3ZZvxvacViXwvOvZ4dIXU3loDeGz3ump2N4ElZ54U3OR7Zc2p3X?=
 =?us-ascii?Q?6NjeXSicYAb2Hgr3kkghFMQqxo9/MdcpcFR+RYqEM6mroBlXCECNlQgwDFaQ?=
 =?us-ascii?Q?GaUok+58RrbKP4I9eL9eYJqsWa/GHNDI/c3yK/TU4zpmUc7bT15E1pOf0atd?=
 =?us-ascii?Q?bGHiYGnyMjrKIdvkFT1DZLL39osu0MLFhLVngB6/XRQh6A85u2NVdU3Z107j?=
 =?us-ascii?Q?c36nXH7K2FxiH39RXDwTmdYMqh4GsPLDFbnL0qonMIHRgPDWhbXZ17lc0a9w?=
 =?us-ascii?Q?NyCUsQLvUh2QMbokIijN/OgOurinaTK+6SBT+r6RXHrxW0T8J0ytnePprr4y?=
 =?us-ascii?Q?LB/hOXePueZG9LTmLhUItvNc79mdktj+EOXrHanFYH9E4BpPAGTRJnmxyfjT?=
 =?us-ascii?Q?LNfIKLa5uJ8xoWuZ1W12obynP++O3J5153IDen7R5d1J7ooVJHr2fuh5uupT?=
 =?us-ascii?Q?LYAVNk4w8e9nV916IbQGX++QUrbH1vqE4r+BauftBRaDKjCwBZGKM/rBFchS?=
 =?us-ascii?Q?ont7Uc8Mw62jvsco43lCcht+XnbyIDA0Q6GGdxemhET4o4QidOxKuqBSbtfy?=
 =?us-ascii?Q?O6ZCKG0XW1xs22bq8Dk/XwNYhOEH8fAb5UdIczhwIBoQ9duox1sc7Uhnu/Xe?=
 =?us-ascii?Q?XL/GZlAbr3AvU91qFl0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +cIltzftIav7WrPfe5S7KRrf9Ji6XTu/sj8nAyFHCbfGwLtox321A6koCs9XylUgTS8ujhWFDG2RflAf5X+5q/qp35CNKYcaqEmY2J9Kha1Vp6kWQb6NZzyRkt1v05PNxeHeZnT8rpr6fF5DGu9Pf6tth4ocP5MLW7ysyjA925VUDI98jdaEsgWO22p79HZkAF2+lfSZ99xjfr/iiuefOTaMZTnzaWFU5DOBs2arOgP6AMWqJKuDzf3xjDpdwwXiJv3Df1fw21j3JH1eM4gFX6Wh09Xf8KhGFyQBuHyAIuhHCX0qJl239WiBoeJpK+Zt3krXs0gBRawTjt9GakXj0eJ7V2oaeq0JLLBKT3htH39Dp9UpG4/kCnlqqBXZ4SQXGrkvWgj4rJExDXEFv4gur9BdAGRssyLwc4B0irwpwsINaJ+3RSdlBQZB3dsWrIJVe8m1PPGtVa54Kcx1QefJpq09KSPDbzinwFpu2glOtBikdOUmDvVmqJrx0csrC1IO0H533hephVgFeF0R5NPEJKeQ+Yn2hnfTL1g89BzshOOMILkZj5k+ctiFhRqDYUivjqthG2MYSo+YHy1gN/JooL3ubIr4D8+u5jBgKTtIWwLF5AxUXPjrnrnL5vdlXkp33zUjaG6W+AYf7PCNgOzAp+95XmR3bY+CrLNQaeCtTL+i8N5xUQOoFtDdSEdXFRfK6ZFMfZQLt+KOHqIN41R4lMyzp3B8Pa0pEPUMxlm9/3ae8Nw+9BViuWiWfyJUIofZ1ocUyc8wMm9Z8GLtLbIQ1hT6/Rnh5Z8J7IZXfcKzzMsV1SLDaSmSX5niZ3I1WGfA+2/x8I2XM/9vxG0HSMx/Og==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB8289.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74454db7-a3f7-480a-bf11-08db9af5364a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2023 05:30:17.0991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pjSYJMJDPscK01Kwdf2RqNwLZhw3tP+QSDsM7ZbQsZsex1m+HTmTz0DtTzqmlnw/fwzdheTiVMVsG8s0ZKORzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6532
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

> -----Original Message-----
> From: Junio C Hamano <gitster@pobox.com>
> Sent: Friday, August 11, 2023 2:46 PM
> To: Mun Johl <Mun.Johl@wdc.com>
> Cc: rsbecker@nexbridge.com; git@vger.kernel.org
> Subject: Re: "fatal: Not a git repository" issued during 'make' from sour=
ce code
>=20
> CAUTION: This email originated from outside of Western Digital. Do not cl=
ick on links or open attachments unless you recognize the
> sender and know that the content is safe.
>=20
>=20
> Mun Johl <Mun.Johl@wdc.com> writes:
>=20
> > Due to some "security precautions", I am unable to use 'git clone
> > https://git.kernel.org/pub/scm/git/git.git' to download the source
> > code.  But I can try to figure out a workaround for that if that
> > is my only option at this point to successfully compile git.
>=20
> If building from tarball extract fails with "not a git repository"
> there is something very wrong with what you are doing, and we do not
> know what it is.
>=20
> Most likely cause new folks fail to build from the source is lack of
> necessary development libraries and packages that need to be
> installed in their build environment, but I am reasonably certain
> that if a tarball extract build is failing due to their environment,
> build in a clone of the source repository would fail for exactly the
> same reason.

[Mun] Good point.  I'm certain I don't have all of the requisite packages. =
 I was expecting to see errors about missing packages, but was thrown off b=
y the fatal error.  I will go back and look closely at the output from 'mak=
e' and see if I see any errors prior to the fatal error.

Thank you and regards,

--=20
Mun
