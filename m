Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD3EC07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 10:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4302610CB
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 10:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235373AbhGLKfB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 06:35:01 -0400
Received: from smtppost.atos.net ([193.56.114.176]:17734 "EHLO
        smarthost3.atos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S236292AbhGLKee (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 06:34:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=atos.net; i=@atos.net; q=dns/txt; s=mail;
  t=1626085906; x=1657621906;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ooSq1qktIUvAEeg1viqSv4o5V6t77DN52O884K6G5P0=;
  b=uoSNPKnIvnB9avD9vzyYAVheCP0KvXvTOqNxQQ1mS+9ygguglo7XBmot
   2fEXGMm4fPlKGXjzZgx/o/35bF8hNBe/HWecZkCHuZu4rWEtVotq7cOh3
   HQ8ACE5mC9rGVc5+9UOVzaQ84PCkRqzHfeCIYkMJhf+SjE9iecU4N43ym
   4=;
X-IronPort-AV: E=Sophos;i="5.84,232,1620684000"; 
   d="scan'208";a="226482590"
X-MGA-submission: =?us-ascii?q?MDEleqpRvvB10g9h+pKPUDRMziiSpfSregSgyV?=
 =?us-ascii?q?MJ7Q+Kx+X6DgpvgfF82GYmKGPGDalW9tpPXrceqoCwCRGzbUEmDXbxIH?=
 =?us-ascii?q?2KsDOwP8GqT6pecvypJ0GPiQNCCYBRD3coKHiFkv5m1BJ4hZqdXbN+Cp?=
 =?us-ascii?q?/Q?=
Received: from mail.sis.atos.net (HELO GITEXCPRDMB22.ww931.my-it-solutions.net) ([10.89.29.132])
  by smarthost3.atos.net with ESMTP/TLS/AES256-GCM-SHA384; 12 Jul 2021 12:31:43 +0200
Received: from GITEXCPRDMB22.ww931.my-it-solutions.net (10.89.29.132) by
 GITEXCPRDMB22.ww931.my-it-solutions.net (10.89.29.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 12 Jul 2021 12:31:43 +0200
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (172.16.214.170)
 by GITEXCPRDMB22.ww931.my-it-solutions.net (10.89.29.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Mon, 12 Jul 2021 12:31:43 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFxkgVIqZWUoRwCxw2O8V1OjaN0BT8BMFRmk1JKzAKn8vZ/yI26+6xFvRCLM4b8XjLrJUTOPZNexRaCSGXUPO4p0i2Ushllcde3EOUUMFZ+3TVNpyDGl2Y0j4RoNay8pI8sS6zeD7/ng5lm4jkF0OjHmPyHCEcOhmFL0L6g4kVmOsSJRS1TQBDsikmpU/4ABZ0qaZPPHZteqsblnI/MWThLfNQhDK7f6E888rFFnpsjDIz5z6U7btzfOvimi895X2f4kSPcYJsJIu8HhgPRgFIojqMpuDpPu3Km6e8LqvtkzM/bpaYPN17dy6toNZ+aniJdzi85iekam96aQPdtlYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooSq1qktIUvAEeg1viqSv4o5V6t77DN52O884K6G5P0=;
 b=ZFUCypQPNY021chThVBZzojuePo8uKVVG2KvyX+lq5hrVDO2vfuyAVq3RcGMT7NfnFqracb0TsIs4rPAm5Zo/3FcQPmdr39Zl1nIzdKEnvu6L8DZRn/ScjNnocjEEDGTM2rsnkhos3eNE6o5b6RouD7IWXdefZqjuECo8Fwj9AG7OIfi54fkiwfRA+56eYKRfeAhDTjdY6CHqgkCbx0VciTrMPqNRYRsJJzzUo1YX8WVbuN6saJ9XvfymRo5cWWkPlV2n8hKWBvJSCiquC/e7p6PxOLSsJ5YU2x+mIKFVTOSvx77DbM4QjZ6rJD5RiZW8o+7KvKjU7KY7jCbk+iMxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atos.net; dmarc=pass action=none header.from=atos.net;
 dkim=pass header.d=atos.net; arc=none
Received: from AS8PR02MB7302.eurprd02.prod.outlook.com (2603:10a6:20b:3f8::19)
 by AM6PR02MB3701.eurprd02.prod.outlook.com (2603:10a6:209:37::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Mon, 12 Jul
 2021 10:31:41 +0000
Received: from AS8PR02MB7302.eurprd02.prod.outlook.com
 ([fe80::69eb:7f0f:3dfd:8484]) by AS8PR02MB7302.eurprd02.prod.outlook.com
 ([fe80::69eb:7f0f:3dfd:8484%8]) with mapi id 15.20.4308.026; Mon, 12 Jul 2021
 10:31:41 +0000
From:   "Kerry, Richard" <richard.kerry@atos.net>
To:     Sergey Organov <sorganov@gmail.com>, Martin <git@mfriebe.de>
CC:     Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: PATCH: improve git switch documentation
Thread-Topic: PATCH: improve git switch documentation
Thread-Index: AQHXdM7l3r4gDnYeikCbe6+PveZcK6s60CmAgAALeACAASZAX4AAC5sAgABbYj2AAD1wAIAA2A5TgAAQcwCAACda54AAFIWAgAA2iXmAAST40A==
Date:   Mon, 12 Jul 2021 10:31:41 +0000
Message-ID: <AS8PR02MB730258D0643373CB476A18D39C159@AS8PR02MB7302.eurprd02.prod.outlook.com>
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
        <877di13hhe.fsf@osv.gnss.ru>
        <c740a4f0-011f-762e-4f49-f85d1b3abc99@mfriebe.de>
        <60e67389a4adc_306ac1208fd@natae.notmuch>
        <4057b3ac-a77c-0d5f-d3f4-ad781754aae4@mfriebe.de>
        <60e736e72da68_30939020850@natae.notmuch>
        <155308af-42ad-b044-fb37-676251a9b7e1@mfriebe.de>
        <60e762243aab1_30a7b02089@natae.notmuch>
        <2b85a7eb-d0be-65e7-ecbb-1750abf53e53@mfriebe.de>
        <60e79c31aaa72_30b8a4208c1@natae.notmuch>
        <65362688-b65b-661c-20c1-94d7dc2118c7@mfriebe.de>
        <60e874e1c6845_215320861@natae.notmuch>
        <dbfa96f0-558e-ccaf-6e34-6d95c43848b5@mfriebe.de>
        <87im1ieaba.fsf@osv.gnss.ru>
        <1bd36aa2-ac90-f7d4-9d48-1aa39159b263@mfriebe.de>
        <87a6mudt9b.fsf@osv.gnss.ru> <60e9ff4430c57_7ef20815@natae.notmuch>
        <874kd1gr0q.fsf@osv.gnss.ru>
        <6ffd7f1c-97be-a57c-b738-31deae26e8fc@mfriebe.de>
        <871r85f39n.fsf@osv.gnss.ru>
        <33af677c-8fec-5b49-0e00-878918c4ea1d@mfriebe.de>
 <87bl78eqv3.fsf@osv.gnss.ru>
In-Reply-To: <87bl78eqv3.fsf@osv.gnss.ru>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Enabled=true;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SetDate=2021-07-12T10:31:39Z;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Method=Standard;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Name=All Employees_2;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SiteId=33440fc6-b7c7-412c-bb73-0e70b0198d5a;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ActionId=595c93f2-3ac4-4620-b2a5-2c27c364489e;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=atos.net;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ecfb09d6-849c-4287-00c5-08d945203d0b
x-ms-traffictypediagnostic: AM6PR02MB3701:
x-microsoft-antispam-prvs: <AM6PR02MB3701EB4367857B0DEEF8D7059C159@AM6PR02MB3701.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pKPznl5EDSPyTUc7E0QATTHpq9fegZsXun9C9oQksaIcbgZBevFSqFMkgxFRsnBsWxXQgSrSIcrIwbfXjKgCxI3W90oORpk57RSRCIAA7dU3PDnoDQiZmiddz4ADwAZ5mkKFmp187hYyQ58kdPl+S54ILfmnRPUwfDBn5+7BuHcE0Dpqn0p9p70/KBVnng2/zeffgnOhd2RgJS3LW1Qhe51VaChwj4dAluZFQZjOuRCi8L8UqpdYnY2ujiVTe6Ls/6dbeyZet1XSmp1I5TA7p211IWz5dUqj7n/k033DJzm9AfEZP5DCw2n/tMT4gNi9SMZ29EvzGh5zSoCWY/GAJSYetQonAbhL90tZ72NtfcYvor/bbZrH8sNvDZXuEn9DYLv2cjvti5IgPpNjNKhbiZLY2DL8X0PtVQj0G3/fJQyAcqodsA50BPzE+Pwck/Ef0uFHPytcowDwW9UwRk+GeGWXDqY6ChwC6oDcEXR14QkWxNtG2MzuJ2N/D4rspAsFzg0Km6o2PZDiT5ccxfdj7i+n3xDtzRLCOjUIm3mxQvLVjtJEK7z4yeUqrOLn/tIY1GJVzkdV9TqTezrkYrkKCI+N9QhMLl9UTlmRjBNhZ2RAkwMFXNq/IvLL3i/9kVw27ZwqDRDA3Nk26JCbEIlNQA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB7302.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(26005)(66476007)(66556008)(7696005)(6506007)(110136005)(186003)(64756008)(55236004)(83380400001)(8936002)(316002)(8676002)(76116006)(55016002)(54906003)(52536014)(5660300002)(66446008)(66946007)(86362001)(71200400001)(4326008)(2906002)(478600001)(4744005)(122000001)(33656002)(38100700002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5JBTEFxlmAbjXwMxojDDXhQexg6JMANDU1pW1Ji0eXBLdyRg66aJn3Q03oPv?=
 =?us-ascii?Q?uxXNlYl1fBaoAqmCc+s73R7dr/bMCouPOwqVcTGpvc2V53uXeBZjL4wKxb1o?=
 =?us-ascii?Q?HcqpupqlHlO7jhyELnb1NxSL5vO4UQIL+h7mINqiHZtFgB5oZY9b5+f7yBBk?=
 =?us-ascii?Q?coGihKOIUZlXEGf0E9+Ei50PXwz++L3RzwJxmWdGzxtpljE8+9lc93AP5oaP?=
 =?us-ascii?Q?FL3xCJWwttp7ekrlKzlKvDYC5HKXoIuzdJcxcB79H3PiY2vZ2IpnaTNMD7qU?=
 =?us-ascii?Q?JWUsKUY6srFX+ZS2W0fXbbAsZQPWiEBDfi9F2ZLKsEw4+JZB75kPoaWqJ2xo?=
 =?us-ascii?Q?fhFZlzH8S3UiPEjfkzZArlOTJ50WSr/SnvRh8d/VqsXQebwFFlxhFZC3ngTS?=
 =?us-ascii?Q?3Kb3oVz275VSEzEkTpMA9xT7+D93tW37yunSWGWTdIjhVC3vR+KEmy9h+M3Q?=
 =?us-ascii?Q?iHsU3VYiw0c2ehgSosaZ0hUMwvTEOQM4v+kLVcTzNMlQZf1z2PG9rNHa7ghC?=
 =?us-ascii?Q?5RUgLE0CWjB8yWVxSfj+qtnLZj9IaI1riV+sPZ6Qy2l5xfz26HaOzcXFFcAr?=
 =?us-ascii?Q?Swl7jiOoMgoXNJUhhM74K7cP+P+RidA6B48U0Asu0GIyeyAsTFrFg35aYjit?=
 =?us-ascii?Q?Q3wPuu1Al0Thazf1Z5WZmc6MU2EsxPUkvM8pZ0NO4mCKUOb0HyQ4R+U81CV1?=
 =?us-ascii?Q?FbS5RLV9TtuTN4AVRGfIJvlJiAzOLdbGacLahM+7JuDt8CRI8Z/Z6Wm5KHkn?=
 =?us-ascii?Q?lii1gEYW0S9QfJ/9uFf1dW/2RgTt6PHxmSUwe6DP3Np7UDcm0HnsrHI5uYMY?=
 =?us-ascii?Q?/quMvzC7AKPiR9BFzXS0CHEjZ9p/UoqLXHtlCQL5Q8gR5WUP1H6qrpo9DbhW?=
 =?us-ascii?Q?w879oJG2WVy5D3+rl2Th35L+Kuc6eIeum9D13EtuBe9X5Z88C/LBOZdLuQFf?=
 =?us-ascii?Q?40N2+rEBDYO5wwaYulwPKYoxYpkBNjnOYeuhgZhlVrBMDG+2nwSmjtWmOhjv?=
 =?us-ascii?Q?WkHEq07v1MIZoiXRN9su9kXsAkQNrqV3MVp1YZo8irCDzLjFqANbaFbGHYFB?=
 =?us-ascii?Q?nANBv29vqTk1tRUtDY2oqjckz7W3ZBVyIJnCp/mhRw+h5K9/Eccew79vD0Yu?=
 =?us-ascii?Q?dpFaVmmZy97cgMzvQgj7Oaqrm8V09eAFtOUyfC5HZAZ2cBEJx4K6iXNe4u4c?=
 =?us-ascii?Q?osxrBvCtLn41ml3RsxA0tsdVdv25rPeOz8fYy9Vdyxdp+RZ8lavlUPvodmiw?=
 =?us-ascii?Q?1aqC+Uv1sASZJC2XGaULU8CNeGAoypHYbIzg9g4JrGI2BZJ6NCdk4i03rhyc?=
 =?us-ascii?Q?hng=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7302.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecfb09d6-849c-4287-00c5-08d945203d0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2021 10:31:41.4021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pgPQOw/YctV1wqgvJDN4g1DMWuPW+sUZi0wThPWa8g7ls1qFhzc+Ci0xC4iuN+7HIX10jGs/yogmvvj1Wnt1BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB3701
X-OriginatorOrg: atos.net
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> >    git branch switch
> >    git tag switch   // detach
> >    git commit switch   // detach
>=20
> Why? You don't switch tags or commits. You switch only branches,=20

Yes you do.
You can switch to branches, tags or commits.

If I remember correctly, "branch" is used in Subversion and CVS only for th=
e creation of a branch.  Likewise "tag" for creating a tag. =20
And I think they both use "update" to load the required branch/tag/commit i=
nto the current working area.

If git were to do that then I think we might get around some of this confus=
ion.

In that case:
git branch =3D create a branch
git tag =3D create a tag

And then a new "update", so:
git update <branchname> =3D make the current working area contain a copy of=
 the given branch, and similarly "git update <tagname>" or "git update <com=
mit-id>"

In all these cases the keyword after "git" is definitely a verb, even where=
 the actual word used could be either, and you need to look at all the defi=
nitions in the dictionary to check.

Regards,
Richard.


