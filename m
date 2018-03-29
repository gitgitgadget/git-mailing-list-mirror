Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB7DD1F404
	for <e@80x24.org>; Thu, 29 Mar 2018 14:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752653AbeC2OMN (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 10:12:13 -0400
Received: from mail-co1nam03on0093.outbound.protection.outlook.com ([104.47.40.93]:49120
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752561AbeC2OMM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 10:12:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=y6vkm93+YPnwP/B0BYqiw2S7vCqkWoNRHs6kg6+1TO8=;
 b=iCZVyMyK4eccBhI1CJBzy3NEWO/3Ft/y/Uz29uWsVKk6KWfjbmQCem358f32w7UJ7V3e82BnEK0nXQMIbX96zZlsU3JRB+EyEvYdz1N7Fjhv6j6v99gUvdx4MpUi38G1Gea3rPMMTfBmD+Y81HlwvAJXPgY5BnOG5TKMqO2GUFc=
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com (52.132.24.29) by
 BL0PR2101MB0898.namprd21.prod.outlook.com (52.132.23.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.653.0; Thu, 29 Mar 2018 14:12:10 +0000
Received: from BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::1516:5e9f:5649:ef8b]) by BL0PR2101MB1106.namprd21.prod.outlook.com
 ([fe80::1516:5e9f:5649:ef8b%4]) with mapi id 15.20.0653.006; Thu, 29 Mar 2018
 14:12:10 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>
Subject: Re: [PATCH v3 3/3] Move reusable parts of memory pool into its own
 file
Thread-Topic: [PATCH v3 3/3] Move reusable parts of memory pool into its own
 file
Thread-Index: AQHTxSSBfMIdzjrnm0qr1t/e4C12ZaPkS1hygAL2Ltk=
Date:   Thu, 29 Mar 2018 14:12:10 +0000
Message-ID: <BL0PR2101MB11061477A78E978A65C0E4D4CEA20@BL0PR2101MB1106.namprd21.prod.outlook.com>
References: <20180321164152.204869-1-jamill@microsoft.com>
        <20180326170351.197793-4-jamill@microsoft.com>,<xmqqlgeda2pd.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqlgeda2pd.fsf@gitster-ct.c.googlers.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=jamill@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-29T14:12:08.9693272Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2001:4898:8010:1:b2ec:da36:1ccf:fa06]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0898;7:i4VkFEA1L15qShoBqU5OLZ5bax8vvq4Rh1HhbHUKCrDZ9SC+MYyOnlBEIwxaD3wSLag7vAIXqIq5bWirIrtIWO+vITVYSWXkNvtCxQuGoZVpcoIq29gognbnG22zBD+g9CWWFiQF3B+WYItLj1IHOz0Sq9LJQVdhz0K1o6SiI0B3tz4w8AddTGVEwDroHgBwwwlJS7gYGwrccS4zPhaDbFqK4fhIbEs65tcRd4eXPsH8W7yH17MOGR7ZeI0Zjsvb;20:48P5i5lnx6cx6MHUyXzp+4mdkwh5F0H+uid0ssm1W8LqiQWdTESN+ntOYVP2F5mkqD8HJ2dnDtb/elLVEDFHPGuX5FYS/cq3y/jjFSD0L9ewHAk7+4aL3wiz7ZcanjL8khKWoZlpa3pi3dnuY/EU/cJs4JHagGcg91DRuGD89fo=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c459bdb8-906f-4ca0-6b40-08d5957f0fff
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0898;
x-ms-traffictypediagnostic: BL0PR2101MB0898:
x-microsoft-antispam-prvs: <BL0PR2101MB089878FFC329DF77A83DFDA0CEA20@BL0PR2101MB0898.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158)(100324003535756);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:BL0PR2101MB0898;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0898;
x-forefront-prvs: 0626C21B10
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(346002)(396003)(366004)(376002)(189003)(199004)(81166006)(11346002)(3280700002)(8676002)(81156014)(486005)(476003)(486005)(99286004)(6246003)(5660300001)(14454004)(6346003)(106356001)(97736004)(53936002)(446003)(3660700001)(59450400001)(33656002)(68736007)(8936002)(86362001)(345774005)(76176011)(8656006)(46003)(6116002)(2906002)(7696005)(22452003)(305945005)(25786009)(7736002)(186003)(6916009)(9686003)(478600001)(102836004)(8990500004)(54906003)(86612001)(2900100001)(229853002)(74316002)(55016002)(4326008)(105586002)(10290500003)(53546011)(6506007)(5250100002)(316002)(6436002)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0898;H:BL0PR2101MB1106.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
x-microsoft-antispam-message-info: vXwOkVAD1Il+fYzQQrLerXazBVIRzUEv0/dOrynjNOVssxxSE+sOfOi267wfhCuST+6HbP6WIhTeqfgrpsX15IIP9K7MdH1SRQ9mGIylMMwW8V+aFjA2pb8faz7tD2G3oC/2IoD3ONgDa+NCRjmEBKG8OZbjb6COOYpc2giePC+unJIlDeH56RL/rPA82sl030kR+uZ1va822ht0LqQzYoA6uF9NXlVcHpPc/z2N1TxaGjmuwsi7+BdgXxsG01T8/FssZJlmndcwX7lDh9IVOpEvVsvAh07p9xHInmzJ3ilQlvw20+8UqTKvDpJEzdMyzdgysFt9p1wgwH7Sr+OMOw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c459bdb8-906f-4ca0-6b40-08d5957f0fff
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2018 14:12:10.3455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0898
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for the thorough and detailed review - I very much appreciate it.

> I
> am OK if the structure of this series is to make that change after
> these three steps we see here.=A0

I will add (back) the accounting of large memory blocks in a future patch
series, taking into account your existing feedback. As this patch series di=
d not have
any consumers that "discarded" a memory pool, I decided to wait until I had=
=20
a consumer that used this functionality.

> Will queue; the proposed log for step 2/3 may want to be a bit
> polished, though.

I am away the rest of this week and next week, but will update this patch
series when I get back (Week of April 9th).

Thank you
Jameson

________________________________________
From: Junio C Hamano <jch2355@gmail.com> on behalf of Junio C Hamano <gitst=
er@pobox.com>
Sent: Tuesday, March 27, 2018 12:43 PM
To: Jameson Miller
Cc: git@vger.kernel.org; peff@peff.net
Subject: Re: [PATCH v3 3/3] Move reusable parts of memory pool into its own=
 file=20
=A0
Jameson Miller <jamill@microsoft.com> writes:

> This moves the reusable parts of the memory pool logic used by
> fast-import.c into its own file for use by other components.
>
> Signed-off-by: Jameson Miller <jamill@microsoft.com>
> ---
>=A0 Makefile=A0=A0=A0=A0=A0 |=A0 1 +
>=A0 fast-import.c | 70 +--------------------------------------------------=
--------
>=A0 mem-pool.c=A0=A0=A0 | 55 +++++++++++++++++++++++++++++++++++++++++++++=
+
>=A0 mem-pool.h=A0=A0=A0 | 34 +++++++++++++++++++++++++++++
>=A0 4 files changed, 91 insertions(+), 69 deletions(-)
>=A0 create mode 100644 mem-pool.c
>=A0 create mode 100644 mem-pool.h

OK.=A0 This is indeed straight-forward line movements and nothing else,
other than obviously a few static helpers are now extern.

I said I'd anticipate that the allocation that bypasses the pool
subsystem would want to become traceable by the pool subsystem,
which would allow us to free() the pieces of memory allocated
directly with xmalloc() in mem_pool_alloc() instead of leaking.=A0 I
am OK if the structure of this series is to make that change after
these three steps we see here.=A0 When that happens, it will start to
make sense to bill the "this is too big so do not attempt to carve
it out from block, and do not overallocate and make the remainder
available for later requests" to the pool instance mem_pool_alloc()
is working on, as that piece of memory is also known to a specific
pool instance.

After I wrote review for 2/3, I found out that you changed the
meaning of total_allocd (which should probably be described in its
log message).=A0 Unlike the original that counted "total", it now is
used only for memory that is allocated directly by fast-import.c and
does not account for memory obtained by calling mem-pool.

The output routine is changed in 2/3 to add fi_mem_pool's pool_alloc
to it, so billing oversized allocation that does *not* belong to any
specific pool to _some_ pool and ignoring total_allocd would cancel
things out.=A0 It still feels a bit fishy, but I think it is OK.

So all in all, I think we are in no worse shape than the original
(we call it "bug-to-bug compatible" ;-)), and successfully extracted
a reusable piece in a separate file in a clean way so that we can
refine and extend it further.=A0 Nicely done.

Will queue; the proposed log for step 2/3 may want to be a bit
polished, though.

Thanks.
