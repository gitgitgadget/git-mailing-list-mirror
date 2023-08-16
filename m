Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6EAC0015E
	for <git@archiver.kernel.org>; Wed, 16 Aug 2023 00:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240783AbjHPAT1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Aug 2023 20:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240798AbjHPATK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2023 20:19:10 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B501FF9
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 17:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692145148; x=1723681148;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=paEJFmw+kjHl6a2YFi6FxEtYS8mWbOveeaEzzVpaRrg=;
  b=DTjyTi2AuNoXQwswJHTdDbNVzXWLnLg82cFA0IUay1uHzZ2i4OxdRpAu
   bDyUaxVfd8gN4IMljq5xvv96RFeyakgZ0cbjI3JswKsRNOh0LoexDBA9o
   HEchXqlrXhwHcuXXYKx0GvzMhokud2EtmgsX5e5y/o2UeoyYhSdruYDt9
   FZvuah2UnJSFZyUJhJFr2jzqXxarzlW2dnbQpAMGu+A9EC8zJymH5DOb3
   hiBJjABERFuDcOccAcVY6PgyKvTF/mRZY1HyPCPY17A18I8RQStrgncxD
   Cg4kbxppt1tKY9unLVvT/DMQnHTuxCiwKh173LXJxoLmxnUv/p0fsTaR7
   g==;
X-IronPort-AV: E=Sophos;i="6.01,175,1684771200"; 
   d="scan'208";a="241107716"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2023 08:19:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/03oYNsrcX/nmBOv1iNQwNcWA4ejcpi9iDl0EEPgED2UlwXI+daVmyY6BYMWysZjvozvY2zKiAnKBWmzDLgIxVgipj3H2ynEfzmMwDnrCM8FOikXp0Ojfp/kBH2apof/RSz5BznfaSgZCrEINjiF24VAgMK3EbIn5aKgy0O9Fo1nPN8pKEqm4BYX8pluvoyH09aDCfvyB40whaVvSaNiW9qKn/o6fTB83lO5AIGstOQyoCE3DbEzEj8CfEq1FF/361s+yvpNdYkm6I/YF0lLqSkxa+lY5QWsxKUKIDSD6Ka7FO6QhY6rpwFdLizHJqyMAhLLO9VEuEq2/oMkowyKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAVZJhnZx3X6jmZqBxkx3T4/5eNWL1CVBjNEOGOsWkw=;
 b=jF8Nx+9hjAyMTArqbnoFiOSXDGVvmU5TSvxIklSAKr/v7l7xlnFYe3eWkJa0wwi6ygAi0iNocW+glir+vSDKeV3T27TWM1TNxWTXcZBnShlWPQ23aTScuHgLJfeZNkdKA0iwc3ptUF5XNCY15NHE2DlDl07Yha9NIPMZtx6X1w95xFOS5Yx1kJq+1vO8Ct5kndYrzZUwnrVf0cehFtDJ6zCwY4B05YkIbQcc/SswcVKcuQvKMufeFn5hVNLikAkaKUTQ8UufXUaw8Ec7BlXn0Uixjk5CkNLKLYk3+Zs+yBuu/c9Q1uG2opKjHBv8H4PoQQf+1tf+5/8ErT6YJ1Ek9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAVZJhnZx3X6jmZqBxkx3T4/5eNWL1CVBjNEOGOsWkw=;
 b=Izl4U88agFZWY762EanT1zoq75B2onNA1E67LvyiCy2wK+H6Qpjv8NSSViw0uFw6UMBwbx7xyKkP2ljQ2tTTKmD+e9fpMiYZGG2XRddn0ES9uc+HpD4g+MxF8k7wakHdW+Q2l/q4Rrn3e4D4kpYByZryfFVrNQwK21zLryNbTaQ=
Received: from SJ0PR04MB8289.namprd04.prod.outlook.com (2603:10b6:a03:3f1::19)
 by MN2PR04MB6830.namprd04.prod.outlook.com (2603:10b6:208:1ec::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 00:19:04 +0000
Received: from SJ0PR04MB8289.namprd04.prod.outlook.com
 ([fe80::1032:2a66:96ce:fef6]) by SJ0PR04MB8289.namprd04.prod.outlook.com
 ([fe80::1032:2a66:96ce:fef6%6]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 00:19:04 +0000
From:   Mun Johl <Mun.Johl@wdc.com>
To:     "rsbecker@nexbridge.com" <rsbecker@nexbridge.com>,
        'Junio C Hamano' <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: "fatal: Not a git repository" issued during 'make' from source
 code
Thread-Topic: "fatal: Not a git repository" issued during 'make' from source
 code
Thread-Index: AdnMjcTVJgLV9DzbQRekliVLGjBYJQAAz3CAAAC6tsQAADubAAAALjhAAAHs6AAAEDPFMAB4TRiAABUqSCAAGueLAAAVnyXQ
Date:   Wed, 16 Aug 2023 00:19:04 +0000
Message-ID: <SJ0PR04MB8289EAD6BDB5308778B89E979C15A@SJ0PR04MB8289.namprd04.prod.outlook.com>
References: <SJ0PR04MB8289FF1D6BAC59833D922BA89C10A@SJ0PR04MB8289.namprd04.prod.outlook.com>
        <034501d9cc91$069bd360$13d37a20$@nexbridge.com>
 <xmqqr0o9qpon.fsf@gitster.g> <034d01d9cc94$df9db0e0$9ed912a0$@nexbridge.com>
 <SJ0PR04MB82892A7EB350531DBE4701BA9C10A@SJ0PR04MB8289.namprd04.prod.outlook.com>
 <035b01d9cc9d$4c2168d0$e4643a70$@nexbridge.com>
 <SJ0PR04MB82897032646F100BCC9001669C11A@SJ0PR04MB8289.namprd04.prod.outlook.com>
 <045201d9cebf$4f96d260$eec47720$@nexbridge.com>
 <PH0PR04MB8295B799ED69C91BBCCCED3B9C14A@PH0PR04MB8295.namprd04.prod.outlook.com>
 <001001d9cf7f$96a62f50$c3f28df0$@nexbridge.com>
In-Reply-To: <001001d9cf7f$96a62f50$c3f28df0$@nexbridge.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB8289:EE_|MN2PR04MB6830:EE_
x-ms-office365-filtering-correlation-id: 547705d1-25a1-4d1a-51fe-08db9dee6613
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K87lB7PytyGjV3p0hLiaaVB5IXrIvkMZVILqT/oCg/4ezLI/IgqVWlVrjOzDrjmdDQIvLH/zNxy5YG8syXzHYHGfGxCHc37Wqej6htEE/4949Zx+gpvaMQZlktPl2s2x+qNNz++gU6m8pnWvxK8pBtYsZ3By/NToagE/N8RnHdsNfur7Mcig9luVmnL1vKSBlQZa3AfDx8QMk3tusgUPZPPh662XVUn6MU/iRpVBD4YNAB3A9+vFq3xGyNJtlifxpCPoX+0LF3BAykW26NJGGEEaT9JCzZqI9/1MLWNV+IxN9/hIXoZxWWfUYkRFa1u8IZQrs4bi9fy5RhAI90nXAcoeooN1E17TEG9KAp4iGVXbZs+44T4UlU7I8HUdWQmC9wZLczEnKiJkB+2X3tECpGN7sRS8nnozIhdFYFlMdidLksnWJy4lB/QxL9baBqZuIIptn/EEgMxFopRJHccvLNE1I6UVuj6ox5Qv27Jg3Tf6TwwoRQ9nrAZiR12BhwW7nT0tnw4PrMhvMENdRdbWR07miHrTxwvveHj8vho7goWSLZvVp0yPfBNF/5n4nl+UdCae0SWsiTZJSa2Ahg7ipgwqK4pW+tRtnoTPYCpLRAR21bYUyO1rD0RRhRVmUHIa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB8289.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199024)(186009)(1800799009)(478600001)(86362001)(71200400001)(82960400001)(76116006)(55016003)(38070700005)(6506007)(66476007)(5660300002)(66556008)(66946007)(316002)(41300700001)(4744005)(26005)(9686003)(122000001)(33656002)(38100700002)(110136005)(83380400001)(64756008)(7696005)(66446008)(4326008)(2906002)(52536014)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eipBJzdJ5FyKoWdeUXyLBV9+OH2AYjFmBXtoatooWftF1q1Iw+bGgQ+NVDnn?=
 =?us-ascii?Q?o7WLrojI46rRtzzbt/T+gNJY316/7ZIG3bSlwcGifG6Ry8MWa4emO8Vz74qU?=
 =?us-ascii?Q?n0POHG84UmBdszPuO+uZdFil9OqKOOyDYP710zhaUUm2ovuht2OzevRMsl0O?=
 =?us-ascii?Q?0cm42qrimgvKU+PB0Qf+ne9dWH7aH8W9d+pc92Vy6aTdx4SaCUy9dgdydnYN?=
 =?us-ascii?Q?f2BtK3FSFUs/flQd1kdoPGwO+lAhwAfNjqUnvnSUkvlHppVSvUB5K61hnHAo?=
 =?us-ascii?Q?n7iIiKcIQ6YNeis0XKuU3AEIxrPwi8qD9/e1WVrr4anrALmRV6WGZV0v8J6r?=
 =?us-ascii?Q?v1lDzD0lVh/Kzca8iKh74jzrdwa8Ufzu6hWRLXtSMs4uuGH9pFVKpXPXcPlP?=
 =?us-ascii?Q?Gyu33EVKsAJvuSAMncktq0EajobDPN+k9Uj9RSCxQ6abQXYGzzK+xaqnJHtP?=
 =?us-ascii?Q?xvoIie0+TtY8CvBiiILdHKuK8/02gS7tymzCh7DXLcsRYeCbpTYbTJTNM1mK?=
 =?us-ascii?Q?SOoZzoj6YsUpRD7b3BJq3E2PGwi36KH1L0iIBU3HbDncaL3QTfpzk5oiLrl0?=
 =?us-ascii?Q?uA277p/qh0mv83TPtY9EKtAkiu6Z/lPMcKkw1saJyQBNoxIJY7M9HAqE0dAQ?=
 =?us-ascii?Q?xXvnHKYfH9qvYn3CU1D+ONSKrI+1PywTjx8n0YKT1QZ7/Ryq2Zwcybs4u4dj?=
 =?us-ascii?Q?BAb+GELPZ/wdFwtY7l+dRgidl4h58Wjhx9oJfBg1he8LnE53J6ABapUZhVUD?=
 =?us-ascii?Q?uCINdVabPMaUOgHyI3fE42l3skbgnda3nhqVNdN8+KiSDbiZm4obYirT34sK?=
 =?us-ascii?Q?yRSkm9rVpNApnXuh4FakO5XrJ1zAr4rfNCtwspyoy1y8FtZzTVFX1dMmOITe?=
 =?us-ascii?Q?0Ru/IU5JIstBLtUh/RgZXf+XC0sYy2n8P056ptwg1Mb7Uuv3KC5Ou2jalun5?=
 =?us-ascii?Q?yJ39zAein/CIyWMGNykq9zmAa5ikVXowOpDitxqDQP0+DLprYlycsGRRhhm7?=
 =?us-ascii?Q?LrMUm5d7+3XL0fEy4s5w4VSe5wkpQG8ScKMEjKhnOg+qmRBSPKMKf99oDxQs?=
 =?us-ascii?Q?0SctvlOydH0rNeA9Z/ZBcSmKrw0Y88KQnJRhFuSkaYsVuk+raE3xuWXdkDqQ?=
 =?us-ascii?Q?6e/EgmszcqwIJq4w+/QmcE6fkmE9XCJq3psRgxPOywMZJtFbIpCIJCnNnGR8?=
 =?us-ascii?Q?PuY6WEiMN5+mZjRX2K3zqaczpseo2tbg19o/aUXNrUxqdFd8L/B3ID7HiNES?=
 =?us-ascii?Q?O4zsQCFo4O7ehakEQxYB39yd4V1QSepzGrMwvfNNR1k1kbdSe92asLDqHZGj?=
 =?us-ascii?Q?QtrJ4cAalIduU800j2oDU9Oa4ZVO+9nJuupMhHiJAAjuyXX1NyxuRXGJsxWp?=
 =?us-ascii?Q?QtJMrTbYdmCGmGsUb0YlfTlCAQYV4d59FlgADD8hMy8m4IxlgtsCqddzOv7s?=
 =?us-ascii?Q?kS6A2tx1psAHAUs2FFWyCnYTClSFpL9jArmdtw+RA7vIKSPSQRhTloOPtmVF?=
 =?us-ascii?Q?Hao5lWtdWqwfwjonaYPmJNFR67RHSngSHmh9CkKQrTfCHAB4GILi1BoUP9td?=
 =?us-ascii?Q?CYQqt+mtbEiWpWKTXuE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rw47V0HaFxhvRZfrCHLpFBfOVc65333XkeHePEBPM/h2M+jDrAdrfzF5hS/s91QovaLEWYffh8s5vXPkPifT2hyqymxz8eSGLoLUeuHSC2gsqRWQYE/5MupbGaN1nxjoUyDoLiYAeEAAqmmh6cvSun4vKEJOkFKa5PWi8LNYeVHktqdcOO6Abff64n6CWCk0mMWAd6RIU8+rzw78mQfUOSIBNAa/sPlVbOGn0xYTjy2BHOUju1rxev1H1FQo2LI4zu638tkDRwUTyUImuT6eQqOdG5EA1IVt83bC9JELvjRCb6YVlD73QeIrPRIxKz8JOCpP5DCkd9T5htCSYD/jSEvsiO1+/Ztv27cpy5vyQGc9HtNjM/yzMKOW1aICLBSyRFHwU7Gc5/OqEcIkvzVaWriRBKepw+9r8JR11s/wfEkBKelHl54nH3wvxSmRV3Dbig3uhn8DRDHcQOUHg95/HKMFVO0ZmBZ09/Mxg9vS6WtbRvRqVM9U1afUDvzKRZfH7dz3JhcKXJbtlCoWYO0fztreafp2JT2nP/DttLIox4HDPquVPtwWGg0WJeY74KwMaoLoH6RAWvhcrbEg5To68gobb5Opd+NJBgqwzPIwpWp2/uDuxoOn2Yf7IhZWBMLlXKLoBuYB0Q3sfE2CEoqDUSy1sixigf6a6o3TMV00rXYPB/YPmlhxThAYJwFBaMIWpOSfohysY1/9DsDPzOcpYbObpdTr24mXGLBTKl5mlMaAoTtbIChTfcJi6gkWHBk6O9YHSLdoIFKJFK9KxwRLntx7DuMgKzkm65P4hqk5q3D69PYLMNXxDD71K5emq8ts606zoqD2U0bJIYelKBqewMyehF0PxCy+PphO39jY+is=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB8289.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 547705d1-25a1-4d1a-51fe-08db9dee6613
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 00:19:04.3008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZLIwCnRGGJnydgI6UPZ751FUoT4sMo9KBKB5BfXJ8BkZo0AR8c0vJH9wdye1l2ExBaZR5nMMK6bJBjVeZdHRUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6830
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

... Text Deleted ...

> >> >[Mun] My apologies for not providing that data previously: Yes, I did
> >> >run
> >> 'make
> >> >configure' prior to 'make prefix=3D/usr/local all doc'.
>=20
> So this looks just like it is dependencies (like asciidoc), but the
> procedure for configuring and running the git make looks correct. Yes?

[Mun] Yes.

As it turns out, I was able to get the missing RPMs onto our server.  I rer=
an the build commands and I was able to successfully build 'git' and the do=
cumentation.  Oddly, I still got the same "fatal:" messages in the output o=
f 'make'--but apparently the issue was not truly fatal (thankfully).

Now I will move on to migrating our SVN repo to git (but apparently I am mi=
ssing some Perl modules).

I want to thank all of you for being so helpful!

Best regards,

--=20
Mun


>=20
> --Randall

