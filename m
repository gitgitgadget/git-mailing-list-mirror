Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4EFC433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 22:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234850AbiCAWqx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 17:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbiCAWqw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 17:46:52 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C2978049
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 14:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646174770; x=1677710770;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RRv1W2AH3M2NHykZoV6ED3nkgfuIMkFtmulxxsRkaeg=;
  b=mL7zDrjJHhf0aFlKI3X/+As5OA0sACNVZlBHzCEFsaNEetTR7c/B6vh/
   4A063IG8Y7bk8F2EDBiy6ps05ZtxvOJfKM5//LdrwXLF/LI7mfVA+W8Bn
   6CMPvH+JeqfsqVwaJURDDHpw63mGxObdvJ6AsqoQzK/y8cR1KV0US6oKj
   +WZ31i2CSoRiqAW7zTHV+se0yJiZYp/nv2sywRA+HMHykklEyiKkoHLD2
   sDT5Taalkqj+8jWASIrYRlO2emilphZqx4wUh3fmvLmmmiEkoQTQx35LC
   77J8fHwX8KpWjNmzcfWJQ7RRvhUZcPcHyiH5/lwon6HfRQyplfKkjVH6a
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="233874624"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="233874624"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 14:46:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="608976147"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga004.fm.intel.com with ESMTP; 01 Mar 2022 14:46:09 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Mar 2022 14:46:09 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Mar 2022 14:46:08 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Tue, 1 Mar 2022 14:46:08 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 1 Mar 2022 14:46:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHMZ3OuJ/L0ZllQ/nWnSrtI2MU9jxUvWhcB72YO1vTkTr2YWyU71io81E1aNApXY+4Wjal4MeRhHu+t0ZzeYOY7lRIZC97vBOSPp5Lx3BVITfNj7QFY3AryTC8RO5BqFkrPtPqNXLiPRyhHa9M334K+F623V5Vd9WvC0NDRTmtGwOoooYvZ5pFbfhGaW5dypmJujqpJDDziz/vvWyNQ2Lkri6lyHN6lkaq758tex29pKuiWmBzMM2WjdZFbeWWqpErmiBMAaSN1yb2OFwOIAEXcbENv5JICJkgBrwuaoZPm6nt94v7VnvIOrv6Kzs6jUtKum/xqP+DSVJMBnVfGuDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRv1W2AH3M2NHykZoV6ED3nkgfuIMkFtmulxxsRkaeg=;
 b=OUn1gAnGL7dZ9tClH9Lh6JEKkqzJ3wG3hfr8Z0NZujwCzuwWaym4aptmMt/UB8VPOpWtgZDr13CHOqMMnCYN9EHGMv1srm8LZyhz4m+VdoPBx5BDwvLYmQoUJstNcJehu+T38GCPEgGVCaJJTWS2f+0dFFk4tp/zJVtmCsBa+ReGMl+vBuna6yAGEJkbl0N7V2umgieHZWWQPooaZcMU8uMEVEEpL+eEsRj6LUsTBjmFIZu3e3VA+OS3dTjgsoodABmgKF5KfvI4z9SALKDTW0E67mKAHHNhA93pb2USsNHjfVzSGnWuM/+YmIqTO98h5sCUYkibEQLerSSeCkbrmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MN2PR11MB4520.namprd11.prod.outlook.com (2603:10b6:208:265::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Tue, 1 Mar
 2022 22:46:06 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::bd9e:6244:4757:615a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::bd9e:6244:4757:615a%9]) with mapi id 15.20.5038.014; Tue, 1 Mar 2022
 22:46:06 +0000
From:   "Keller, Jacob E" <jacob.e.keller@intel.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
CC:     Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: RE: [PATCH] name-rev: use generation numbers if available
Thread-Topic: [PATCH] name-rev: use generation numbers if available
Thread-Index: AQHYLO0/kx7y23fqQU2fGaub7n7TLayp0IwVgABL24CAAAc+aoAAfzoAgABO6ICAAAE/AIAAB3t0gAAjEQA=
Date:   Tue, 1 Mar 2022 22:46:06 +0000
Message-ID: <CO1PR11MB5089DC997DB42023324F1BF0D6029@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20220228215025.325904-1-jacob.e.keller@intel.com>
        <20220228215025.325904-3-jacob.e.keller@intel.com>
        <xmqqpmn6wg98.fsf@gitster.g>
        <CA+P7+xoECs-rXb4vpRrw40Q-oRvfu97kMig9zu0rEE6KagAyiw@mail.gmail.com>
        <xmqqfso2t9cu.fsf@gitster.g>
        <6b00c67b-01c9-bf22-a8e6-904f47fa7acf@github.com>
        <f5ca62f4-eb3d-eeb7-e7c8-7fb800f3d6cd@intel.com>
        <3c3e6063-7eb4-7ff4-3a1b-a07db1fe969f@github.com>
 <xmqqfso1pgmv.fsf@gitster.g>
In-Reply-To: <xmqqfso1pgmv.fsf@gitster.g>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 157970c1-8801-41fb-f2a8-08d9fbd54583
x-ms-traffictypediagnostic: MN2PR11MB4520:EE_
x-microsoft-antispam-prvs: <MN2PR11MB4520735368E210DF61FCAD0CD6029@MN2PR11MB4520.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3as6gjrJ6ISGIWLmT7qwc43fcTifMKxR2Jt5PxSTk/zYDMIp0VHCLyYHboZHXxHp2/wDiN3plICfuCq+TkzfySq8XqsjQjvpqvvXEuZeKn6KmeDZN6KTNAMCnF/8lBud2Y2dsVrFeAgYqsg/AarogfOs0Kiy0mylWMT9GFDYOSTOGAQC6J5Oiuw8rE0AzcRy5v6u1kcRHbvO4689cHUJt7mWsEarHPXaJddGpiS5SyaHiFb8Rx2LwRHydp3m88h3eftMeWUIYq0H/kn4h9AnvYbrUoxV+v9jWg4kDHSIyPphbGsmKhE++EVrt/1M8IYa8T2DZVi240NDrlqMEBZhCKtRB/Mr6Ufv9oxGgYw6/EVBO1/BWhnD5/I33zWlZOcbK4PewBozhApNQRkqjdBSPnaVAMltAxZ2VSUWPLdpKmC8Eyfb90V3Jcxt59PO5/BW/k1BVLpc1NMJ6QufqbCyrRRKpWWKDqsmycVyG2f0KtLlSKXDuZB37GVZkwot3HSTyXpSo2jmDXOKi6wf7v+Rxno9oX/4rLtJlPIsJ+ZGj9TR9Bo0Ei+SyHv60R6K0yerh2j0HEb6cwnOYKaGxbBerfrXlW7f6r3joKfaOLZYXbZ4Y7akBYMDkWYrx9bChbKuwEUt9YYPS4jpIBUCkIx06rpP31K4zQPmnE7lxBwZBEE4UbNYusB1frtOqktuyfVxwATTxD3azEAc/18WQRh+Ww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(33656002)(8936002)(52536014)(508600001)(86362001)(38070700005)(2906002)(82960400001)(5660300002)(122000001)(38100700002)(55016003)(186003)(66946007)(76116006)(66446008)(66556008)(64756008)(66476007)(8676002)(4326008)(83380400001)(26005)(316002)(54906003)(9686003)(53546011)(71200400001)(110136005)(6506007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eCEoWSvvJ8KfDRcIitPkR0igVtT8MbwEPbvGrRLqtFvYeC69W9F1U2HGTp+S?=
 =?us-ascii?Q?YPQf+o1tvez1V3YYvhIbxNiwZzhaf8a+41XCkm25sZl2Z/xpjVpe4yIQwTUT?=
 =?us-ascii?Q?M74Q7I6R21J9tIlUxGrZQsRFXnhritnpTPMYJmyWp+MMKoHpy447bF2//OqA?=
 =?us-ascii?Q?qZnHtcMf17/+J+z4BekdU5kLItTIxR/nZwXFrbRD8XvM+EP1L9lamDxcEq+7?=
 =?us-ascii?Q?/goMahJJ9c2OnI/Cuz5PXDF7TX+/F43U4AD4JQREWQxAWOF8ljtflU9rknFq?=
 =?us-ascii?Q?FFBbNG7TeqQZL6RAm3TrC9gVj23OL5Fy1hhcLYQ2mvJcht7yaX8QqE3I6Bji?=
 =?us-ascii?Q?l1gmL7lDScaPX+1mKbiBngJuJPobGb1CKzAcHL/V/pzp8iEIHwa3LxqzUyyJ?=
 =?us-ascii?Q?cdu0Nj7Uj3TngzkSvwc/jZN9S7Jd50yaPgR9pPG1ElrkrH+c0Ef4s0idWLBL?=
 =?us-ascii?Q?qS9GK9ss9yDrCbzNt6RqRz64nraDGAgf/rn4Sycdqy1r0UKJD4fMR6R8c/gb?=
 =?us-ascii?Q?nUzM77LJzGrg2LAoGocBUTy0/CGI9fGr/TRdXY52N81bUbKmQLX+MCICiR7w?=
 =?us-ascii?Q?TL6shihV5kodLCO4B1M6/SdNMmlINeazeCO8smKQfz/Y/P065tT5zOlJzOq4?=
 =?us-ascii?Q?7bWvzs0o+gnQB5DywctqmakLoakTMbuaEwk4lu+2aIJGXPpPTFikgTmUEpj4?=
 =?us-ascii?Q?+YR1Q8uevfajxtWHEbaDxOoS3HICOhEphrmQCM5D8iwuWRPrsoIwKm1xRPvP?=
 =?us-ascii?Q?Tkrj+qYGaG+jFQj5Z3ezKSdQkNyEvR5o3iDMqP9aGSuHmxxKNliUcPRyHnhS?=
 =?us-ascii?Q?EbWc8jdtF6Zemvsl3DrtmjF3Wzte1uFuxSOcPOelJG3Yi2XVRCgze4SAmghA?=
 =?us-ascii?Q?lghybtaj9TJ9nibdhW1gxTPtc7sizcDiaHVjjIgSm5lZcyRgXEd5qssLTEwX?=
 =?us-ascii?Q?RhvdXRoCCfbxCPTWoJpP5Gb+ZhKggRfxi8qllpAF04pfGlu09jcvRnsHupzB?=
 =?us-ascii?Q?c2DsODEqqWR3jnqhxgkWD/KjCkDm+rS54+Sif0CNF9/ALzOzOSIQziVdrWlZ?=
 =?us-ascii?Q?qov4lSEHF5HJ0E6T5KlG+vOMzhoQHDKOKffzSr1tl2sDvaLfqYfJXva0X3el?=
 =?us-ascii?Q?wP//NpyVPIHDXte40dJ6Q4VL4dWIRvd84bOuqTISGrFF+42vFolrAHLdfdnX?=
 =?us-ascii?Q?ITnkifbyxIpesHOVGpO/Rwmib4MT7g6EFdxgz3CZaRjNCmqtjFU6GzgHGNJG?=
 =?us-ascii?Q?yoN/ruM8ZjgxJT3hR20RJO4FXxB5cYwzvWXA9DviOEge/s3XBCvY3LGzsBqp?=
 =?us-ascii?Q?jDMAHqWxyU/8YpFgdfx4Noe8mkBPxSsM6t7osEDOHleSKwILmUg9ZMPuE3dZ?=
 =?us-ascii?Q?MNZQrEfV+MilA6gKCQ2VaXN5dugDr2UBTLcZSVC4+evAAfDzFsVAzb75QHi7?=
 =?us-ascii?Q?u2jouFpI061aYxCizsvjGm4/5E8qZeoWNOC8fQ+tAp3uBg2tglRWFE73QId0?=
 =?us-ascii?Q?/tNn7te4NBxoSAOBNBy35F4g22/8CsaYsBxuTiFUAU4mp0NiUUWD6sn5yVCl?=
 =?us-ascii?Q?Nfd8PUNyl59B/URWGIDMD1/IPRrU7nMbYa/jPpYYH2oKLnLPxMkcQl4uYOcW?=
 =?us-ascii?Q?ZjtfyYHtAeINaplIvZ1R0fRdl0XxAWx9zQWeEVwuzeE8PeeoEi8RZTQOQtzE?=
 =?us-ascii?Q?ZgGP+A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 157970c1-8801-41fb-f2a8-08d9fbd54583
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2022 22:46:06.1267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NIl3QabiGevLKlVyVoW04hXxkmAeS8cXRTg1AE3VFTsNJdXpxo+d5xtj9d+fMInpYJZceq0JTTpfseKnCes4ifleLg/pq3llU5/xnusNbBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4520
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> -----Original Message-----
> From: Junio C Hamano <gitster@pobox.com>
> Sent: Tuesday, March 01, 2022 12:23 PM
> To: Derrick Stolee <derrickstolee@github.com>
> Cc: Keller, Jacob E <jacob.e.keller@intel.com>; Jacob Keller
> <jacob.keller@gmail.com>; Git mailing list <git@vger.kernel.org>
> Subject: Re: [PATCH] name-rev: use generation numbers if available
>=20
> Derrick Stolee <derrickstolee@github.com> writes:
>=20
> >> I think the "tests should document current behavior" is handled by the
> >> fact that this specific test fails if you revert the name-rev changes
> >> but keep the test.
> >
> > Ah, so this _is_ documenting a new behavior that didn't exist
> > before the series. That is good to include, then. If it was
> > "just" testing the behavior before this series, then it would
> > have less reason to exist.
>=20
> With of without the additional codepath to handle the case where
> commit graph is available, the original heuristics that is based on
> commit timestamps are fooled by a history with skewed timestamps.
>=20


Let's clarify. There are two versions of the test in this version:

1) test which enables commit graph and tests that it does the right behavio=
r.

2) test which removes commit graph and tests that it behaves the old way.


test (1) checks the flow with the commit graph enabled, and verifies that w=
ith a commit graph the new behavior is used. This test will fail if you rev=
ert the name-rev commit-graph support.

test (2) always performs the way we don't like. (since we disable the commi=
t graph and the new flow doesn't kick in) This is the test I think I will e=
liminate in the next revision.


I will remove the 2nd test, since the first test covers the change in behav=
ior just fine, and I think I agree we don't need to set in-stone the implem=
entation without commit graph.

I will also look at adding a test which performs a count of which revisions=
 get inspected and makes sure that we actually are doing the optimization.

> So I thought this "without commit graph, the algorithm must fail
> this way" test would be testing the current behaviour *and* the
> behaviour of the new code, no?
=20
