Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C915DC0015E
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 20:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjHKUXD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 16:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjHKUXC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 16:23:02 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF149D3
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 13:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1691785382; x=1723321382;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=lF8VJzzRU7ZA9AHCPUXh4N9cDAExvTcWfHR/DuGejFA=;
  b=oP00wxNZbyT+UUAA1HZw16BM24mZuIvZJrT1e1u9sG1Evv4o+v1EZ+xV
   odtDwvy0d63gJaJdovw3h688Ak39vldkElJAttcsVC4z0Yv/uXZi0pPmG
   tUywPdGeFO5CLV2ZrkCxYPurC9o+eKYbI3JacE3Coyzytu/Oum/lSo465
   DAM6d8gTowIEb9B2OW0I7oPxiMH57dLXQzjLYaf9qQ/QbePoEMCjt2ei4
   FYkCUHfy5gIOnuM+0jPMLiW7rfaVAvEAcp42TRXg+iANrPyINQP2pAnUf
   PWqFtsZxG5O9jf0v4wh/HYKAbu8TW5sEzpzI/dJ8mHCXdpBP0ev270aSv
   w==;
X-IronPort-AV: E=Sophos;i="6.01,166,1684771200"; 
   d="scan'208";a="240682995"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by ob1.hgst.iphmx.com with ESMTP; 12 Aug 2023 04:23:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8ZCd34KmWvcxCBRUwdQQSq7gJbQAFQcSGInZV2gfEGWs0OiT6lpObjgcuecbWg7hBLbF/FyASdUptK4ma7qisGQF6Ts41ySLUrd/hT3RTY+9c/Liuc/+t1Uh/pnt9X0U3NzfVyP70H5HvE6eVNH4CrUcQ1YlPsyZ2z1RLattFjE3wmiP61FbTi2DGuIEE7btZi2Ataz1RDgd8ELYFfjapizPoZi0ekafqiqz4aORFyyS9o18VwZ1oXhyVHFtjkEU4z2CH/193NGT8WOoUvortjqSBSXOQejUDmoME5L8dBDfZC5ss2e+IUG4ozJ2JJC7Y5XpDyCyzZwsjn4h0pCjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jj/a40LLSnAmVeO4wjL0QApeMtp1salNo15/TtK61B0=;
 b=G8EpxTBnxDMuBZG6PI5l+Hk6QS6qJ5RAsVysm0yKqFGNgX5QjTed5BzZHUIYryxNDg5xhD8jeJERHAYq36UZcdXQfSVeURUapy4MHrfnLs8XOVv+uQm4i2JdT8yEOL+6sOI2PibhDDuiBvVk3SWO65KlAGmv+jnurTtRJMIW/YQ0txl/PXYFVOOW/6rKz/Yesr93Ydvat4DoN9rK9Liw9Jk4WX6C8HLLdg4KJ7DXnN8O3JeP7DI3f3qAg8QiRbQFlAoW6z0aUFw6U8YEaSHeOtfgm3BT2GmiPZIEalJ3pCxsy7SutOgDsM8vjQ0aqX12iCh2pUWxUZIL7HtSQNRr/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jj/a40LLSnAmVeO4wjL0QApeMtp1salNo15/TtK61B0=;
 b=djJ3oA4SprxzPQRCBLI3F5jh4GfPbvdCVXPpZZnc9NbST3yisqsO7WJ0Q7iH2ZPVk8DETmC31ns8pvQOwVf08YOO10CMvhM6XrLRURXm2OnbNzCnBSbYPK7GLyrymDIFxE3StE2mAQ8JrtEpmdBBoJuP2t6VgEDN7vPfRJI9m0Y=
Received: from SJ0PR04MB8289.namprd04.prod.outlook.com (2603:10b6:a03:3f1::19)
 by MW4PR04MB7441.namprd04.prod.outlook.com (2603:10b6:303:78::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.19; Fri, 11 Aug
 2023 20:22:56 +0000
Received: from SJ0PR04MB8289.namprd04.prod.outlook.com
 ([fe80::1032:2a66:96ce:fef6]) by SJ0PR04MB8289.namprd04.prod.outlook.com
 ([fe80::1032:2a66:96ce:fef6%6]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 20:22:56 +0000
From:   Mun Johl <Mun.Johl@wdc.com>
To:     "rsbecker@nexbridge.com" <rsbecker@nexbridge.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: "fatal: Not a git repository" issued during 'make' from source
 code
Thread-Topic: "fatal: Not a git repository" issued during 'make' from source
 code
Thread-Index: AdnMjcTVJgLV9DzbQRekliVLGjBYJQAAz3CAAAATMUA=
Date:   Fri, 11 Aug 2023 20:22:56 +0000
Message-ID: <SJ0PR04MB8289D45EE7A495B0ED7F69CD9C10A@SJ0PR04MB8289.namprd04.prod.outlook.com>
References: <SJ0PR04MB8289FF1D6BAC59833D922BA89C10A@SJ0PR04MB8289.namprd04.prod.outlook.com>
 <034501d9cc91$069bd360$13d37a20$@nexbridge.com>
In-Reply-To: <034501d9cc91$069bd360$13d37a20$@nexbridge.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB8289:EE_|MW4PR04MB7441:EE_
x-ms-office365-filtering-correlation-id: f462e78b-4569-4c33-d003-08db9aa8bf9f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dp7FuM+FvoSyazWo1zotTnpIQTj8L7CsXQpi5iRlP5X4tfptNAPfMBRABJP1D5CNSemAdqKI42pmTOH5AaUprg+fFoyVtZ5/Fkj1CG/ip3amleCAIW5EFhWBUOZpnJMydDNuHRcBbBEAu3f17IFrIqh24ERtIBAiqCRXXVFhEBGLUnBlVnioCStp4z06XxUIvQk0N1x5NkOac+NY1bX4X4O4owqB3GzCAp21lfYJb60d06+U9hEwwA91GK+47XJn15GL/lJmnB4RFbYbieiVHDZi4tuK6ZqNo2DzL0PJeFqz+eQXm/pqfZVfdU636AmdFtB/BYcirgarg9mqHNWPFKu6kloj5/xJtkIK1WEjetKw40e/RBBPrARlaphSnohH2jy6/CCkuHCd2XEetcYBSLJ8Q4a6thIKp7PFHMmNmMldW0mDOZbZ8kMElUHzLhxWQiEZxCYADVBciHT6m3Re00mbN+8iQkt10MJnIwWCg1w+xFmkwc5uF23Ua/950bZHykSur4jPqcjy4k/7+X7zSWK5dY69FTL2JGgjUIljHeBDT+q8jUwM5QgZQSLt0e0Pke56Et3PRIzQMoudivB610zO+I2Lwzo4zil8rDIJwSaz2OjATRh+RAV8+UGPijDN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB8289.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(396003)(376002)(366004)(39860400002)(451199021)(1800799006)(186006)(2906002)(52536014)(8676002)(8936002)(5660300002)(41300700001)(316002)(66446008)(66476007)(66556008)(66946007)(64756008)(76116006)(110136005)(71200400001)(83380400001)(478600001)(7696005)(9686003)(26005)(33656002)(55016003)(6506007)(53546011)(122000001)(38100700002)(82960400001)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eweGZy1a1NfWWPbwe99GfptVdt8lTMDix5UM4qMuxOFTicdbpiQNeeHhPskE?=
 =?us-ascii?Q?CmmdJjcf0bUHfsLHZOTs1ka3Otbl/aWoKvFW4H+8qOXlFuNKyiFcp8qKuDXX?=
 =?us-ascii?Q?IBEcO/gsOQIAeNw3Jg7BkmdRwcFboERQ56q/oyOClw2QQg+sEuRXWqmY2V+z?=
 =?us-ascii?Q?AdJGs3ouPIJW63HmaEXKl1nsrmbqxNGUEMScszzyEMkCxqaBiw6h49YiaekS?=
 =?us-ascii?Q?tLUmsHEu/jmGXCiRKXhKXWNh/YUVUCJNK5noK13VbaA9g1Ze0AGUkM+74kWy?=
 =?us-ascii?Q?ocREMKMGPSL/e6K/NAQKwCVm7EQfin1jomHHYrXrOVrgl9zNcRcGKJ+GJw6t?=
 =?us-ascii?Q?4RdToMfcOwPRx74szAgwSAR1dLFDlttH1GYn2TG7phdlWVYYxxBf+Lb5orFB?=
 =?us-ascii?Q?w0CLd3hAPzmkmHD6punEHCu05C6TiVJqf2PH9akYAJSdyrVplDg2OAB0EdNv?=
 =?us-ascii?Q?8b90iQR1VUHcH2YSV+naThznnJAq/+FwMak91zuowtjGlRY3MtfGTb1l3UIL?=
 =?us-ascii?Q?kN3sCmW1Pdko9fwPS5fGqxarbq4VkbmN0TEXhH7vxMiZkeFhZPUKfIDMXTGj?=
 =?us-ascii?Q?WTvgdUVzI9iwyKd3WvnCna3UxlTLmfO/ePt0Te7u8DhJOxsqw/DJeV9zQiIG?=
 =?us-ascii?Q?Q5vUKVsAQHgxorCfz4ZkdsQzF7WiVVvRt2w57hRMxHEqnrr/WqTaf5YZohVl?=
 =?us-ascii?Q?ddxLF6bNXghEmHW8JoywGoe+SawkEFe7D3jInhHWnTvSNrn7hA8ZhnqF5YXa?=
 =?us-ascii?Q?AaMxO7bYg8UJnNCZlKU7OL9i//m+jtlYXBPy25X4qSX+pyswf2FYcA+UVYVi?=
 =?us-ascii?Q?YW2gnmPrjJ5yga7HGiSwcyy/Aw8rPDHlk0iTTiNTwcHZaLKSnGF+nCYxqh9B?=
 =?us-ascii?Q?uknzANsQtRHt3N/nW/9iqILQGOqyPPgZnvqhoc+y8b4ix0Nx+L9mjlLCv8S2?=
 =?us-ascii?Q?bd04Im5ujX2F1QKOLhpLTtsnwQ2nPUVTeIGLNOMDG/d6quJ6X190RF1V44W9?=
 =?us-ascii?Q?lbo+FohPvaTIdxRlgpkswcnr7VLLpFHzU46E4woaRGvgI+xGYF3mvhleZTbL?=
 =?us-ascii?Q?ewghewzSKS60lJGOMV9Uwq3hKMrisW7HHaXpjpWfyXBYATvr2+zSJIhpHQBI?=
 =?us-ascii?Q?hv2+93GSuxuG1x+/LzzG7M8QfFvwQA2Ix5tGe2AgdJyDLdeXNBXKplKdCUJj?=
 =?us-ascii?Q?wz42f/doEOrTgJ7QV40QZVS4vprRaLss5o1H27eHIr9Mrj/9NWmJ0aljdSkx?=
 =?us-ascii?Q?nHuCxnbFIsygctQedXtD993bVMuIrgoia69cFVY6v81yKl8gu++u65cRiGWK?=
 =?us-ascii?Q?LhqdWxDYewxOzEWA1Qv/p6zCRA5XpJjklatEAG2tyHg+Pi6YPYhPTvOVFIEy?=
 =?us-ascii?Q?NiYcAvjU78kYBE4uow7set1IZ60lqcNxKJIWSerbW5IHBtxlt6HfbWuUsonW?=
 =?us-ascii?Q?8abYBlFio9y4QJbIjuYYr3pn0jyLio0lr3pdas8Z96mX/hQO7CLIn1E0H/7L?=
 =?us-ascii?Q?6FsSCzhq/irgXQfn7FX5ffgXpCHuGssk7OSEcWuOSHJIULplPAfrDHdTi0a0?=
 =?us-ascii?Q?rXEKE2x5heqFjqvp41E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: r9f+k5iLKC79QEi90Y3isr2FHzRcAtyU6ZDV2MmCDyLfxxvulKwQWvQs09qPiVHFpAEKq6rZEqE/KXdX84klsUFvp/seZgguSMSq36TVG6j2ugc/kP9rqDQjIb6vcvqVSDHYAnIWekF0H6XJ2wy5qphUxEp5tkJF6WbtXrVWHOPZK4y2ul1AZWL5hW2C8hunVa3h+Rv8HYYGHOkM8mjQcEoP6NbMZaNeLEdRAGU9xG2ssz/sMscGv6Vae8EGt13UrK2ExCkvZaRBLN/t3rjSZg6ms3ujbGu1L7LckJyrD8An69wk9w+TcowFVeGj/lCk1vixtTSc08qFe0F6xRJOTTH7Gr7mDmIoXVbzQkTPWLuEDaG3Hp0obk3HTLh9dkVFDxJj/Nuq6SUqNXJm+7dFcGPKhN55rCkdHmTG+PbgktmpOUt7DBGUKyKZ6WoNANvN8XeFMVHxtI51TtP0C/XwXek3dnVLRKn/QNFgxv1NySs4EzTsQmSl4sUBenE9toQRc0fztKlRjGsWhWo6WghlGRbnytR+Y0a5EGLkfjD18cfCGO780YmMbWn5I4T2LY6D/PUiX4DDJCJLP70ruYUAwjJFJFXAeOzn2ebIDYiNCCrEepvARoBB1pj33Y7EXYEB3HwKH8J2uAuMvr+mC2BD03j9rrtb3pxrGa/mu0GBAiSLcsyrTv56vaTwcfgtrlcE9WsUrAo0J/7oHMtKQDZpXW80dA9/QPxDVZWKM2h6KtU1T4XJHysmVU4o0FC5EJ2Z79y0yKb51ghv5T24FOQDdF/MoJJdK6wV7YC3b0RGvJAa7YEoe6rHMvrRmVbYAyWY
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB8289.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f462e78b-4569-4c33-d003-08db9aa8bf9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 20:22:56.2828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /QJ6PJE3ZMJiv6734b4WLmpep7ARugfXIAWkPWClEjWg4FRMAJFtzNuiGObjIfdAi70XtBt2o1MvXV2AMfPl+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7441
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Randall,

Thank you for your quick reply.

I'm just wondering... Can I "trick" the compilation process by simply creat=
ing a .git directory where I am running 'make'?

Thanks again and best regards,

--=20
Mun

> -----Original Message-----
> From: rsbecker@nexbridge.com <rsbecker@nexbridge.com>
> Sent: Friday, August 11, 2023 1:19 PM
> To: Mun Johl <Mun.Johl@wdc.com>; git@vger.kernel.org
> Subject: RE: "fatal: Not a git repository" issued during 'make' from sour=
ce code
>=20
> CAUTION: This email originated from outside of Western Digital. Do not cl=
ick on links or open attachments unless you recognize the
> sender and know that the content is safe.
>=20
>=20
> On Friday, August 11, 2023 3:57 PM, Mun Johl wrote:
> >I am new to git and am trying to compile git-2.41.0 on RHEL7.  When I ru=
n
> 'make
> >prefix=3D/usr/local all doc', I get the following error:
> >
> >fatal: Not a git repository (or any parent up to mount point /tools)
> >
> >Which I infer means that I need to do the build within a git repo.  Is t=
hat
> correct?  Or
> >have I missed some basic step in the build process?
>=20
> Yes, you must be in the cloned git repository in order to run the build.
> --Randall

