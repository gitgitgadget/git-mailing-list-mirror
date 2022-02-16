Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A16BC433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 01:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245602AbiBPBQs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 20:16:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245325AbiBPBQo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 20:16:44 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68E2A6452
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 17:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644974192; x=1676510192;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sxXcijRE1suh6f2bKT2kzlDIs3GwcMo+dOGCYIwBz0o=;
  b=UoCJUAbRpEGfOIdmLuU/1PtNDi+KiiiBHKOT8e3hdm6aEvWm4wZVWE/y
   DKbVZpjA4E/wUkL9QYlvgqPCpQz+VXh+f4qM+Yqx2EaNKEtCqKr1Ez4Sg
   zaKuv3mqpxMSJkzJ30tvQPbSGok1XtMu9XBCfaF/N3FfvCbehrn7uffZu
   SYAuBHHaQ1KWpp4+j/uUMxKouRg3KpXNDTRj4Kiv2ZL4g/SagaxhRSjsg
   bfK67yKhvo5UtLmVF08cwoFmu5pr8Q6JhMoou8xByuveL0q/wGklJagL6
   eB9amL0Fz/L+pIQADgo4Tz+rXJMbbIXVH81ihxijxuVcCFBk+njm6cBO4
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="248094563"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="248094563"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 17:16:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="497893452"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga006.jf.intel.com with ESMTP; 15 Feb 2022 17:16:32 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 15 Feb 2022 17:16:32 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 15 Feb 2022 17:16:31 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 15 Feb 2022 17:16:31 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 15 Feb 2022 17:16:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0rZ/vYo2FF3iIgwy9r964/rIsfcglvR6w1/J6T1px2DWvYLMwAELhNqoEr+4dWQNxW48B4T6Una2veQ72DlmxWCFCgYtCUtnja8DCpuGxWkzN7zP6H7fxOYbYLD928g1E6iURwFvSsKvmiI3ssWtuYroeBB9+oguGVn6owf/sV8yDgHLLKx3ncvBsL7IfzRh46BiqgHbN+ZVx+Oz/1yFiOvLwSggW19o2MHsIcqCfngoZrdTXvp8BJk9w+1ACQgIzDTQvn8L4E6R2e4R2CrR4UdtRPe6GENYdg9ypKdSEDdjKq6pB9NawbiCjT62sbwnzwUGOGI8qV2X+2VpfoPww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QiOwNpN+tCXs6VsaPBLuiae5h9XMiuUxfLH05DO3YAU=;
 b=Id+SD/4/JhYyBgdvgpIX1jLcbz6Wh7cZ0fo9Mw8U+CCAplx4Suedyqc4YjDQaD00MtMjc7FLskWTaf67CO+U7f9yncEs1wrEC+k80wa5dg/0LE0GH02q4KrpgCYrTK0BwgcGw3Z+NLRbHQKJ5kVk3+pEVWDQDEe4SmXw5QXODXTvZ2F/m2nTYSEe/MwVhHCmdtrLiwZfEEnyCaljT9hhQIY1DQNq84c0inxMP+VK4z+i+u9N++MrI+2Okb4gcloVKu41iIJXKlNm4xlpSXj4LogZenDPilXJKHM/KuCfCpUx86JvPAY4KJHKH/KAhL0rSAf5T+L+mdoxDdtdlPsClQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM4PR11MB5501.namprd11.prod.outlook.com (2603:10b6:5:388::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 16 Feb
 2022 01:16:30 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::bd9e:6244:4757:615a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::bd9e:6244:4757:615a%9]) with mapi id 15.20.4995.015; Wed, 16 Feb 2022
 01:16:30 +0000
From:   "Keller, Jacob E" <jacob.e.keller@intel.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: RE: [PATCH] name-rev: test showing failure with non-monotonic commit
 dates
Thread-Topic: [PATCH] name-rev: test showing failure with non-monotonic commit
 dates
Thread-Index: AQHYIeZRsk1qBkD/FUyMjBUmt6bxlayUM/UAgAEtQEA=
Date:   Wed, 16 Feb 2022 01:16:30 +0000
Message-ID: <CO1PR11MB5089008D502F964AF9425F86D6359@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20220214210136.1532574-1-jacob.e.keller@intel.com>
 <220215.868rucy4t6.gmgdl@evledraar.gmail.com>
In-Reply-To: <220215.868rucy4t6.gmgdl@evledraar.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e5199ed-c55c-4573-6aa8-08d9f0e9f68a
x-ms-traffictypediagnostic: DM4PR11MB5501:EE_
x-microsoft-antispam-prvs: <DM4PR11MB550118FB408725B1D61D7B9AD6359@DM4PR11MB5501.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /rtnTBcdAMhgmY3Bx7IRJ7VksmWdZgKayZPSUQEgelK19CZVB1OCsdAqspF5e0AOo+73sd6V4LrzlBc7QWPjajaShGAgMb20fCmtP3YBHjoCVUqDUeCmdy5bdRL5+1p26FgknsBaF11lswhFN3M7/z9Zj0P+V8jRoxk1pWoOUFxTggQdEohoKggnJDu42jifCVMizSQZD33Nz5t9I6vlrcgeTkPAPOTaX6J2W5GkONkc/7qIIAGcjxHw0UiYoZaD8jWjeVuWy/i27DM3JfYC9cqh9XWVCi9cZwZsR6BV7SA47AMLugoVsguUOPmpwh0iznj0oGoWGRKt/5b2gsQbbe4Tvf8SBVc5R9v8ocV3bSLvIqzcVozy5tKs/C3sMRJPmpY7hSBfqu/dVd8YcoUJaqGfGNG1OzZWKV53cdzXHlR8hggjSBxE2p4uwhH5JbSvY+W8Yx8ttR/ha+CNFjgKr24gjY9CVEdCrVsTuTcK2r2eX9QGiiNndx0okfjOjFxlfs7XLehyKHSevYOx+JnaoQwCdEIBt1EvAorfDm0IBXd7siz8VaqQyyJPc3Vkgjxh1gklNFMsukCkHaUXRyxFOw/4rBUj4j/m+ILdzCN1rmIJ/o/5IR0kDmJEzXjkEHil6MRaoOVqvx8PbVUhb+RLKi/smYpo6bG/xX44JUYjGnLfljRhJcD6nE4yuS3jXVKZxMxIoesVwIxpqcirR8tgBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(4326008)(76116006)(66556008)(83380400001)(64756008)(66946007)(66446008)(5660300002)(9686003)(122000001)(66476007)(38070700005)(55016003)(66574015)(186003)(508600001)(33656002)(2906002)(54906003)(6916009)(6506007)(7696005)(8676002)(26005)(52536014)(82960400001)(8936002)(53546011)(71200400001)(38100700002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?urjN8hyFy6MiwGf4HjewraNhWDOiAwDl/RbzAidx6T+stGD+hFlYpuSf7R?=
 =?iso-8859-1?Q?424Pp91jLG7sgQNrKYYrRB2hPyEqg6P0Ve+6BGS1lycGNu/41ewHduPMcf?=
 =?iso-8859-1?Q?jKXry9oxHOg/c9REW/RlLmQb0OTNoja4ntxml3jg3UKh9SkcFlJCvSlTQa?=
 =?iso-8859-1?Q?3jGeogAcRR2bglBWGzcpF82z0SDGfdZLrqKFZzRSxXby+IkGMiF6aumrHV?=
 =?iso-8859-1?Q?s95Uhbyh4gnNPx7T+cOkYbp4O9pTmAQhguPpuUuwMikEjID8VwMFno6JLC?=
 =?iso-8859-1?Q?qzS9xnf+ShysxrXQMIwbAXpa3thlZh8mEXmwWz8GGTiV665brGCtiUs1d0?=
 =?iso-8859-1?Q?y2L/Ix1jUA42AaDe+2X+tCf7GAHTJ9rkXIDaMqE6DRCtKaje1JJFOF2Nrq?=
 =?iso-8859-1?Q?/HXXb5opMwOL3O2CS1iFuYsV44sgrsb9v2iBckUDxZfE6uf/vWYwJvcM6r?=
 =?iso-8859-1?Q?ztz9sibG/vEJTXtJgsMKbvxBsC8w9Db5pgJeYdHi4O2AXoDuiJFZqRFAm3?=
 =?iso-8859-1?Q?mMltekHGuWB80AGmJFgEhNDHRCbMd5AVurFnj9biurYmN3K+T5LmdurDiM?=
 =?iso-8859-1?Q?4CJ6FgjC3dgH2a/apTVu2c4S6DoTXxtfnSXeJiuIjNPmuQxGekHVhihyDw?=
 =?iso-8859-1?Q?MTcbaSXzSZr4eQ3ZdVV72WTzp+AQSVxwp53hnp3R48wWY9sKaGGbreJUMA?=
 =?iso-8859-1?Q?foOlipoLb8hBsetX7L6WXEyZdozCrajfhBDN1Ej/vX08dCaVeIzjADEfAC?=
 =?iso-8859-1?Q?ZnlcnMekfQ0karnjcSNfHv6b//QScrHmrbWs2+6W+ad7R+OVsTl+NXxmv1?=
 =?iso-8859-1?Q?mEzHK1bGdsjROf6kJ8ZsA5lz3W0wnwCkvlmmGk4DHFyvG0jXH3OZc5MWUd?=
 =?iso-8859-1?Q?9BrVuH3C42nGPa+ZCieLwaCY+odKv1HHz4zZH163anyVM37j11eEfXdKlz?=
 =?iso-8859-1?Q?CntrtIAErT7Kn7g72HG0nHOrrOUq83VooEqL7ydYiyE/ucn8oVBjhzmmBk?=
 =?iso-8859-1?Q?4dQZBxG/d8nHTOqHeGSpe10/oD2+qnlmICjwUl3KG7nnJJ37iKYIGAz/6N?=
 =?iso-8859-1?Q?UX7hhloJduv+yNBX3Opa7kYLb9HHwRWSCTHKpZ4B8e45vcLN4wziD5oGkC?=
 =?iso-8859-1?Q?jRBHTSlFad5h4HO+pF75Y97OIlz3sfIcbPwbQ6JQXb6ukvGO8xyoJH+Gqe?=
 =?iso-8859-1?Q?aSjAILg1Ks6rMlcBK/hRV+CiWzcokhOS0w7SHcNNx6hB669ChjGPmXIJLu?=
 =?iso-8859-1?Q?8BpUIN6VFLeXwoQnTHsUkBmI4XdjF5ivQOOiKTRri/CSveymA9YjZH4Svc?=
 =?iso-8859-1?Q?XoGAeJnpmGCilD/a8HarNPEElSDVKWHj+VydPO7xRB0ktHIAkon4I1vIw8?=
 =?iso-8859-1?Q?xt5HF1bHqKikR6QK9YUBEELOGcXd/HrV6/drw2cXETg80962PNkJnmdLoR?=
 =?iso-8859-1?Q?RkLR2Tex+VMNsmM8vcc2tpnKYcj0qrpLf++2jWKIo3P1Ey0hxcrtYb5vFh?=
 =?iso-8859-1?Q?A6F6awjfTf6zEi4ThJ4PaOB7qSbqz5K2YtlaTJP5FH6mPtIf81cQRgwlDm?=
 =?iso-8859-1?Q?ocP4hctJzVeJiQq0vuZ0qovb9bzxEY8oTOE5R85hQaSV0j2vI9oiAMKHCT?=
 =?iso-8859-1?Q?ZpstQMJezXqYWVyRZVYh34YgyFuLIEAwLNcpPmSQUYFbooDdbq0XGm8WGz?=
 =?iso-8859-1?Q?DeRJLjzFQKs4xvr1qmtqCY3pZsClNQtddNiYjZJfI+A/XY25Y5DZmVyo4u?=
 =?iso-8859-1?Q?s5hg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e5199ed-c55c-4573-6aa8-08d9f0e9f68a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 01:16:30.3323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sv31avom8mW10i3ngoj/G/kmHMAvkltnNG1CbcIzbu761rCQoPK/A49DrHdZ4LiwKleJN9YXM585kqkdt3aJ8InzRTn7KjEqEN5u4qUklSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5501
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> -----Original Message-----
> From: =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com>
> Sent: Monday, February 14, 2022 11:16 PM
> To: Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: git@vger.kernel.org; Jacob Keller <jacob.keller@gmail.com>
> Subject: Re: [PATCH] name-rev: test showing failure with non-monotonic co=
mmit
> dates
>=20
>=20
> Shorter & avoids the needless subshell as:
>=20
>     git init repo &&
>     test_commit -C repo --date=3D"2020-01-01 18:00" A &&
>     test_commit -C repo --date=3D"2020-01-02 18:00" B &&
>     [...]
>=20
>

Sure. I can pick these improvements up if if we end up actually wanting the=
 test case. I think we're still discussing the core problem in this thread =
too.

=20
> > +test_expect_failure 'name-rev commit timestamp prevents naming commits=
' '
> > +	(
> > +		cd non-monotonic &&
> > +
> > +		B=3D$(git rev-parse main~3) &&
> > +
> > +		echo "$B main~3" >expect &&
> > +		git name-rev $B >actual &&
> > +
> > +		test_cmp expect actual
> > +	)
> > +'
>=20
> I haven't checked, but is the explicit peeling to $B really needed here,
> are the results different with a main~3 or main~3^{commit}?
>=20
> I.e. the first column of the output will of course be, but will the
> result on the second column? I suspect not, but haven't run this. In any
> case I tihnk teh test/commit message could do with an explanation.
>=20

The first column is the commit id, so we need to get that either way to com=
pare the expected and actual output. As far as I know passing "main~3" inst=
ead of the commit id to name-rev doesn't change this.

Thanks,
Jake

