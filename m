Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8D3C1F516
	for <e@80x24.org>; Mon,  2 Jul 2018 18:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753274AbeGBS2Y (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 14:28:24 -0400
Received: from mail-eopbgr700129.outbound.protection.outlook.com ([40.107.70.129]:56081
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753158AbeGBS2X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 14:28:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=404+Bu5waRutIRl/oLzYo62D0hXUNtDCGD4NH0L0xng=;
 b=Y5xKFSQMOkkL7vAqWdNb8H3xNKitEi+hmA5xm+oPNV6K36isaMLW55zMdDC3yctfb/Ly2H+pFZUkCDtvcTUNHP8p4AWsNE9lbuOzuK2fR1y9mxsLkrLTS/hZEXrvm0qDi9nEVstKI8jQjLy15HW7C+fZ66RTkp3ILq+cdTzqh2o=
Received: from DM5PR21MB0780.namprd21.prod.outlook.com (10.173.173.7) by
 DM5PR21MB0155.namprd21.prod.outlook.com (10.173.173.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.4; Mon, 2 Jul 2018 18:28:20 +0000
Received: from DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::3995:4fe6:93dd:1989]) by DM5PR21MB0780.namprd21.prod.outlook.com
 ([fe80::3995:4fe6:93dd:1989%4]) with mapi id 15.20.0952.005; Mon, 2 Jul 2018
 18:28:20 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "peartben@gmail.com" <peartben@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>
Subject: RE: [PATCH v5 6/8] mem-pool: fill out functionality
Thread-Topic: [PATCH v5 6/8] mem-pool: fill out functionality
Thread-Index: AQHUDuhVdd0dsCLiMkOrFCaPeXTvyKR2CWf5gAY6peA=
Date:   Mon, 2 Jul 2018 18:28:20 +0000
Message-ID: <DM5PR21MB0780A5E4F75D3BB1384DB9C3CE430@DM5PR21MB0780.namprd21.prod.outlook.com>
References: <20180620201557.77155-1-jamill@microsoft.com>
        <20180628135932.225288-1-jamill@microsoft.com>
        <20180628135932.225288-7-jamill@microsoft.com>
 <xmqqo9fuwwvy.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqo9fuwwvy.fsf@gitster-ct.c.googlers.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=jamill@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-07-02T18:28:18.3792111Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2001:4898:8010:1:9210:e227:f68e:61a]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0155;7:PV2ttPCbDN+HksySVDRYtAKFG4z7rvDloRuX331nibqOnePl2A7ApXNqTA/aG9mqnrL+BIror6hHyRtY5sN1GqNncRBOX4OzvIce4Awc7Jdhdpq5yuxNdZ7gVEAh5a3X9WWMpikZCGF+rVF1ilRNrK6tjEhtcSpPGUgWtjLIfUXOnvDPhCXtg8tInMqV/hUohhvFjY/+51NwGMVf9oL/AzG/rtsIxD6Hbh//tQQ8e/Lg0Y4zUJMoMhq2NByF0JlN
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 91b26817-fc0b-4aca-afd8-08d5e04996a2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:DM5PR21MB0155;
x-ms-traffictypediagnostic: DM5PR21MB0155:
x-microsoft-antispam-prvs: <DM5PR21MB01551C60C39EFB138D51DE80CE430@DM5PR21MB0155.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(35073007944872);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231270)(2018427008)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM5PR21MB0155;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0155;
x-forefront-prvs: 07215D0470
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(366004)(346002)(39860400002)(396003)(189003)(199004)(22452003)(81166006)(6916009)(86612001)(316002)(86362001)(93886005)(81156014)(6116002)(9686003)(97736004)(8676002)(6246003)(39060400002)(74316002)(305945005)(10290500003)(6436002)(53936002)(7736002)(46003)(25786009)(478600001)(5660300001)(68736007)(55016002)(105586002)(106356001)(33656002)(229853002)(4326008)(446003)(99286004)(6346003)(2906002)(256004)(8990500004)(5250100002)(14444005)(11346002)(7696005)(76176011)(10090500001)(186003)(476003)(486006)(102836004)(2900100001)(6506007)(8936002)(54906003)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0155;H:DM5PR21MB0780.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-message-info: GtfmzOVQje+R5kWaTVYkzBL33sa8l0TKuU1mxIlh7LM3q5rw6dJLYS3EIR+7r9teWfDpI7Eg7OObauCk1CIM3xi8miVD2fckMYgq22qljdECkUOLwf+PBa50CrntS5fCcmP2oMHH3LbzmqG0OMmhNBwtJFVB7wXpFUd37V60bIitq+pnoOoQDBVxzqKSNQ1vx5COrSb4YvR1N12OdKSR7kHtUBP6YWJ3mzPGuh8rZa9h1QtDFxVxI7QGo31T8eAKyrbBFrsD5ZhOH/KFAmR+/KtBNU+AyQ2Mejx6P3UPZze4SfDjuVgMoVX6mnCFykVqn13/tzX1IsA8YFmgOla+m17K4WRkSWT84jA7FXBgi3s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b26817-fc0b-4aca-afd8-08d5e04996a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2018 18:28:20.6021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0155
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > +void mem_pool_combine(struct mem_pool *dst, struct mem_pool *src) {
> > +	struct mp_block *p;
> > +
> > +	/* Append the blocks from src to dst */
> > +	if (dst->mp_block && src->mp_block) {
> > +		/*
> > +		 * src and dst have blocks, append
> > +		 * blocks from src to dst.
> > +		 */
> > +		p =3D dst->mp_block;
> > +		while (p->next_block)
> > +			p =3D p->next_block;
> > +
> > +		p->next_block =3D src->mp_block;
>=20
> Just being curious, but does this interact with the "we carve out only fr=
om the
> first block" done in step 4/8?  The remaining unused space in the first b=
lock in
> the src pool would be wasted, which may not be such a big deal and may no=
t
> even be worth comparing the available space in two blocks and picking a l=
arger
> one.  But we do want to decide _after_ thinking things through neverthele=
ss.

Good question - and this is something I had thought about.

In the context of current usage, this function is currently not
used frequently. It is only used in split index with
move_cache_to_base_index and remove_split_index. In either case,
the cache_entries should already be loaded into memory, and I
don't expect a big enough difference in the amount of left over
space to make a meaningful difference.

In the general case I could see this being a bigger case.

For now, I thought the logic as is was an appropriate tradeoff. I
don't think it would be complicated to do something smarter here,
but I also didn't see much benefit in current usage. If we prefer
something else here, I can update this logic.
