Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292A6ECAAD5
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 15:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiH2PiF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 11:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiH2PiC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 11:38:02 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DDA8982C
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 08:38:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWXV57CXE4I6J5LZfsAopgqwyMl5ay5trNkno5qF8vr2DCsSBKzdE+4Ba01F8vOs5jTosxbw210qn8UJ5VTyQGWpel/oebNOTlYSLBtlda7tEEwR71XvKfXngwVMmyM4ZvkVcCmzW2lpDSJDq9BqwaAXBvBhpOIL0ZUfw6t4b0wqx91Rcl/aJtI957sSGtIpI/Q99E4SxmrjtrHr2IeXDYGoFMaQGGjwPN8otS/gdMghlWwfMRz7PAR4CHCENWhUME11tB9e2KCDj60ZEBd73bntKmqxIwVICz65wQb3fsFpPuK02ybL2O7ixaXUPaYaM8yEt4nAzNNap5Ilj7pgwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R7BDnJuFKdcT92cPNNLUhRekR4yrtKuYM7ZRfvl143Q=;
 b=K15EvYxNhTA6Fpk+YhPxpq3IqRF7nJNEg9ZWRbkDxCtsdTiIq0nXurHzWUA6uBe2GU418RGf1etd2eyVYWYNuftp7dVTXjv27PmRmRmP9RoX+STrB/iw5IP2u60pm8c1wO7cn33o9vLoz764AOqYgA7Qdz60CzegWfxyw69XxoBBIlrQSLi48hEpXAWnQP8+e4jgeBT0LNYWXMNiZYlapcs3cyHqLUeGaMU7J4nTBwBLaICBNwM0Lqx+BnI9jbeRmQ3OLL755s4XeKEO0cp6hEnAGdI9uUi7R+zltxgpTFcnUJLKUrQZ5OYgWnNNVSkBEZSiwYLgj7SR4fHrw/ZMiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7BDnJuFKdcT92cPNNLUhRekR4yrtKuYM7ZRfvl143Q=;
 b=VXIwt/I6IbeXfjxTvPbljLbAqBcLxoaN9p+vFKaqwmR5wckc4ztAFvLVx/aNK8RzlYG9R5LzAk6yx5bnE5LwXqq21N21p+TSKhAihlwhCuvyLt9qtRgWNHlIpV28skpDNGM0In++3bXe7cqsJHx0iPO5lgrScc8UNuksnswgCBU=
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 PH7PR12MB6955.namprd12.prod.outlook.com (2603:10b6:510:1b8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15; Mon, 29 Aug 2022 15:37:56 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::e43e:bec3:4746:37d]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::e43e:bec3:4746:37d%5]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 15:37:56 +0000
From:   "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [Proposal] Pass additional metadata to sendemail-validate hook
 from git send-email
Thread-Topic: [Proposal] Pass additional metadata to sendemail-validate hook
 from git send-email
Thread-Index: AQHYuY7dQt28v+tPjkSID7y+EecLra3GBtuA
Date:   Mon, 29 Aug 2022 15:37:55 +0000
Message-ID: <8735dfkqlo.fsf@amd.com>
References: <87czcm7maf.fsf@amd.com>
In-Reply-To: <87czcm7maf.fsf@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: mu4e 1.7.0; emacs 28.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1fece2e4-5754-4897-8704-08da89d471b7
x-ms-traffictypediagnostic: PH7PR12MB6955:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DAl7xwaQ7MQ3ymE5GsbhVzKihECeBVxS52Nv6hZk0Juklmg1okYk1gDiYM4GoIovYmC/53OuyYnkRA4WOnW5pg2L3tNkiDPutMcU68msI0hstLS+8hBMHJjnkFRtLd94+L/zt7suwnMiMKsazF8T7ku+9CoPFMs/Z23QMiKfFL713P8xaAclQHKIxHQCIiqH9TCntcZc7TlRa1pyPbc9roMeAWknDNEV7Igzke2XD1L9sSwSX3QPGmY7uqsOGmZD4USCKdt9HEFJePVeOg3PvPxrMBg0tcag4RM00m3TiugVYB/uyk5nFGhjiPdOOxLjqp8sLEH71KDdIITUATtbeGDZy9HL+I7YJbUNSl+2CNE6ujFY+Sn32F5fa1rzXgx2UlQbYpDcy7RcetwN7/ny/txozpVdes4Aj2BoDlxfsGrU3746XzWCqVZQp+PHQ8c7yeBOwwwxvGlBTI8gsnGohlkUkrR1ZJ9UB/zfZeuzQKwtNhbAbf0Xu2Z3+g2Exr0Mz2GiVTEl7KfxODqCdHDy0DQl43Qklb48XN4D+dQB7gCtmFKDw2MTybbQccMSZbcIpZAyhWUb58uQmjJvk7mkU11Pm3BxnikcYGFZSKiaNBngUfLur05DN7BjblxeL3zhZSGfuJ7cKdXN3z0K7mVtaOgZkCTQr7mOJ3D9mYy0t8xtwtO7Bnl4LgckcQ6jBr7zbObpm9JzjCXqeSwAZ+AXcgPBN/saK4BBA5ruhb/hNCXeManEmUyGUVUyZjqCngzrA//u8dT2cWZzmKUa/wI6DA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(66946007)(66556008)(64756008)(36756003)(86362001)(66476007)(122000001)(8676002)(66446008)(76116006)(91956017)(38070700005)(38100700002)(6506007)(41300700001)(83380400001)(2616005)(478600001)(6486002)(26005)(53546011)(71200400001)(316002)(2906002)(186003)(15650500001)(6512007)(6916009)(5660300002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Z7gL2KrmyiaWYL1I0Ywcwe6qNjdE16RLI46mK5uaKcGcRKF8SlyFIv2eaN?=
 =?iso-8859-1?Q?b7h8uineWrYGRCtOEBvvZEUDbGU2Oh7eWkrHlN8NQ1A7hA6a38gJIIfgZz?=
 =?iso-8859-1?Q?WeM2YsoEImLxi2Pv+MKAweV8FGCIISlXajW2/t7Wdi9MPo71UZGAV3BV8I?=
 =?iso-8859-1?Q?j2ZWAlm+WuXWxK0dIwItfOObP8QMRebF6ZoJuVcYyVPz2IGu/EtbSlon0x?=
 =?iso-8859-1?Q?P+h8oPG034DZr5ru2bPAFINl0BEohOD+CGx59Z/hpw5yiF4RPYzDo0EX+j?=
 =?iso-8859-1?Q?HQkYKwhITZc3m/CWSJMfVKPTKdr2gwdckyvR+yvd5g+vhzgUzJ5zubXq5I?=
 =?iso-8859-1?Q?HgYcJFFhKmkLLas4SC2sNzhhq+wjZpbH9M70LvursgBDtClWrpJvGrClOh?=
 =?iso-8859-1?Q?bfeI1Tgsrk92FoK80SWgpmkHjGYNvPmfs7Ave+PVwSM0aTpruk5z1EjRN1?=
 =?iso-8859-1?Q?AI1YpryyZd0XWU6m1DuCxlGUbdOEsUegTIjYZOUNrDyKm+ei8NkEAD5DHL?=
 =?iso-8859-1?Q?/vs/6R2qRSsb5gZa/Qw2rfx4iMv2MT/kLp5HWpBBV9dpjbrJt1xjzYg5JW?=
 =?iso-8859-1?Q?j+rVgsQGdFvoda5DozmKpmX1VS7HuPsElJD2lfrVdlLK+iptKxPbGysO0a?=
 =?iso-8859-1?Q?5gXp5Lg63OsQUobhQTU3lZ2JQfaFmoDfZ8AXN5ydOAEHFclJ6ocdq+cJIW?=
 =?iso-8859-1?Q?BHO3nTthxWG6g6FfEFLp+FrvPg/C/mxA+wfVcFeZDbRPBzxUNbljrOoX7V?=
 =?iso-8859-1?Q?Q+pPhbKjw2gGHh9of2pFu/wk1LrhFb7sY2Yq1/nQ3vnO6VPf6aAU1fHEcD?=
 =?iso-8859-1?Q?KhGwJRXrAVxTxm2jbKXDrccFhUG1X8NNSFIqNjkVlFcdRRb5oZaAix0IY9?=
 =?iso-8859-1?Q?MJU0Es979UcZw8bY4RzyX5llN53rlMIgP++5ttCxyANgLhd30w5mA804/U?=
 =?iso-8859-1?Q?xy5Jc+qddav3spWHcBD6gHHKI8JarM6jiAL4j2uOafeaQ7tW7z5oFtTd+o?=
 =?iso-8859-1?Q?MAvm1s20k+13mc39nre4ak+EHYSR47BOz8rIdqknT0Dti0dku3Oi7ijnx5?=
 =?iso-8859-1?Q?HE+c0mSLBDczgtVG7fiAy9p7Lu/+OnAewlkNVynZqxzRIz9m+8IUYd9TrU?=
 =?iso-8859-1?Q?Lsikhd4e6bX6oMgHnZZR7jwOc1rUWWxGXrptBAXsBL+QjhqffP9KhRIubv?=
 =?iso-8859-1?Q?cDEU87t2OSpuTQ/V3t6xT511n98y3nOAitTJHvXtLk3lgFq3VgLfTqJwq4?=
 =?iso-8859-1?Q?mL/yrX6maUlPrPrdQ07hBJOoq8bkVjy8KlkjCtcAWiv2dpd64QQAAUazP1?=
 =?iso-8859-1?Q?WeYhns/Wwej6UES8w6/gxWSxPVjbinE0d6jYLdiPQWECuzLN4AaSyMZWO0?=
 =?iso-8859-1?Q?GHRjgIUDOmaud+5AmbaXwsNJizE3qoSc8w5JO26CfY7jO949pHtJjQorUl?=
 =?iso-8859-1?Q?F7OwoM3mpT43YKTiqME+jVTiR15ld/DWSC8dtYPZ3PZ7Do9Rh4h4TMGcR2?=
 =?iso-8859-1?Q?nKFDPyiewX1w4kHBHMLoztN7OR6Ot+TFLRUpGdPRY+g5ctQzz87sr++l79?=
 =?iso-8859-1?Q?Cc9eUUInJzQAtbK1k+RpHY8PyZUn9Vg4pbzHZNwRw6p6qWiCX5fJl34RXR?=
 =?iso-8859-1?Q?5KZCN27h068XtRGV3FUelGfeRBNBf+vgj9?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fece2e4-5754-4897-8704-08da89d471b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2022 15:37:56.0115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y9B7N5wYO+a5Syf9QrPDPXiMqAGb9f9fDd2uyAVmBRFxfyfMC0/U2wlciQQ3v2EMH/tOj8BaR54L5ufXgQBG9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6955
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Thanks for getting back to me.  I'll write up a patch.

brian m. carlson writes:

> On 2022-08-26 at 21:00:25, Strawbridge, Michael wrote:
> > Hi,
>=20
> Hey,
>=20
> > I was hoping to put a feature proposal forward for git=20
> > send-email.
> >=20
> > For git send-email there is a git hook, sendemail-validate=20
> > which
> > gets the body of the email that will be sent but is missing=20
> > some
> > of the metadata that git send-email has access to.  I propose=20
> > that
> > we also pass the extra metadata that gets presented to the=20
> > user
> > later on via stdout such as: From, To, Cc, Subject, Date,
> > Message-Id, X-Mailer, MIME-Version, Content-Transfer-Encoding=20
> > to
> > the git hook.
> >=20
> > I'm willing to work on the patch but want to make sure the=20
> > idea
> > would be accepted first.
>=20
> I think the idea is interesting and would be willing to see a=20
> patch come
> to the list.
>=20
> However, having said that, we typically evaluate patches, not=20
> proposals,
> so to see if it's actually accepted, you'd have to actually send=20
> a
> patch.  We may find that while the idea is interesting, it turns=20
> out to
> be infeasible, or, for whatever reason, the patch is unsuitable.
>=20
> I know that this is different from how other projects typically=20
> work,
> where you typically pitch an idea first and then implement, but=20
> it's
> what we do here.
> --=20
> brian m. carlson (he/him or they/them)
> Toronto, Ontario, CA
