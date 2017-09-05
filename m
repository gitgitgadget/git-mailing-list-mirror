Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17B21208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 19:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753036AbdIEThc (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 15:37:32 -0400
Received: from mail-bl2nam02on0128.outbound.protection.outlook.com ([104.47.38.128]:27680
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753021AbdIEThb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 15:37:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=3JgXc6eqPwpysr1ZifDup4aKhZIirCa1WPieJdaevUc=;
 b=cgyk0iq+P4UNSnun/Ja2aJY1uCFkp+6IxW1fDXFLx9TGUDyNjJBppbLVRsKEph221hgo7HMiRti/i0fjNiMftzuvDdIneTZGq/M/cqPpbeb4k3Js+BvwDnEOaY2MvnIg+7WZNGE5MwcQftvQyhG8NwYMG3y4AdpIIxiJgbM3Sp0=
Received: from SN1PR21MB0014.namprd21.prod.outlook.com (10.161.254.12) by
 SN1PR21MB0094.namprd21.prod.outlook.com (10.161.254.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.35.5; Tue, 5 Sep 2017 19:37:29 +0000
Received: from SN1PR21MB0014.namprd21.prod.outlook.com ([10.161.254.12]) by
 SN1PR21MB0014.namprd21.prod.outlook.com ([10.161.254.12]) with mapi id
 15.20.0035.009; Tue, 5 Sep 2017 19:37:28 +0000
From:   Kevin Willford <kewillf@microsoft.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Junio C Hamano <gitster@pobox.com>
Subject: RE: [PATCH] read-cache: fix index corruption with index v4
Thread-Topic: [PATCH] read-cache: fix index corruption with index v4
Thread-Index: AQHTJdE90oNVc7oVNkmoKOcqvI3FwKKmodwA
Date:   Tue, 5 Sep 2017 19:37:28 +0000
Message-ID: <SN1PR21MB001457E4DD1AE17D041C6C77B7960@SN1PR21MB0014.namprd21.prod.outlook.com>
References: <20170904225807.22139-1-t.gummerer@gmail.com>
In-Reply-To: <20170904225807.22139-1-t.gummerer@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Ref=https://api.informationprotection.azure.com/api/72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=kewillf@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2017-09-05T13:37:27.4416692-06:00;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [174.126.250.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR21MB0094;6:YEbnAx4zQaBY/GVhvIWiZJNCPypuaiGcn/U5tOlCnuhk6dC7HTt9lr6j9hMCDyTg2fY/NzsdCK6zLWRfgxjAOItlcSoYGt91XTHQ/yPrKvFj4UaUv32W58oE10Rx9luTcMxeYh9TWOGjUd4nHrxyeqI3PSTGXzxoxtPyiNlO1P03VNkG9T4Tap7cleZFLfsyqq5F51FwWDK7Z8PlKgJEh09KTbVhZFz0ELM/CKMMY1QmnPfDfzJRnvWP5SLCHzwxvTpYr6jOrxXmd0NfdltT1tdvVww2iWcf2YMMShaWKcypJXoOZ5E9eFe3wLiq5QDx/JXr+xXuo7E+3zlDKbE6fg==;5:5k+LprFRTT5nbhSx+0OiXZQCqskBpwlMSj5XcFAh3oX09p5mwBYatKilCOBHwYZlqD8txD7rNMHaIG3TVZtN1TWbynPsuqLu3SQZ9lg3dR5qN6YnRcc12+ErzbysH+a0e8Z5+SJrlczQMTDqKTHeXw==;24:ZrJk8/Zi4Vd9xuqkSTMoCY/soMiF0THuaccoY+LGHV4IyeAb8Krj39QG/H+Q8qdoyrxsmJETltahTZINKufOhEgIgZ1OeJPqPGEKIkJYk1E=;7:K3mcG60dNq6JMo6wi1vyTZTVeYUyfByq4CPHgx1TI7r/U3eDqAZ3t1VfQOSgqx3PklyE3fyyXP7WHSZJ374cau9yX/dmD+ZMnatlM6Ey/Cf2c8qjQl4hrSR0XAgG0wzvPKw3N1kJ4gWEEIfDT+F0O6g0Hd0ZXHBlhD+z/AgFylLV41cn7Xz4Bb7phNFJZyIbEnavHDrMSmCiCEppvZg/N4RSP4p/Gp6GyKVrNZFTJMo=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3a12d56c-c1f0-4171-5527-08d4f4958b3c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(300000502095)(300135100095)(22001)(2017030254152)(300000503095)(300135400095)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:SN1PR21MB0094;
x-ms-traffictypediagnostic: SN1PR21MB0094:
x-exchange-antispam-report-test: UriScan:;
x-microsoft-antispam-prvs: <SN1PR21MB00942B87B44F45B38609444EB7960@SN1PR21MB0094.namprd21.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(100000703101)(100105400095)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123555025)(20161123562025)(20161123564025)(20161123558100)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN1PR21MB0094;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN1PR21MB0094;
x-forefront-prvs: 0421BF7135
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(39860400002)(47760400005)(189002)(377424004)(377454003)(199003)(76176999)(102836003)(6116002)(3846002)(2950100002)(7736002)(66066001)(2900100001)(14454004)(39060400002)(50986999)(74316002)(54356999)(106356001)(3280700002)(3660700001)(10290500003)(229853002)(478600001)(105586002)(8936002)(6246003)(77096006)(55016002)(8990500004)(53936002)(99286003)(86362001)(2906002)(2501003)(6506006)(101416001)(189998001)(25786009)(33656002)(10090500001)(97736004)(305945005)(8656003)(81166006)(86612001)(81156014)(4326008)(5660300001)(68736007)(7696004)(5005710100001)(9686003)(6436002)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR21MB0094;H:SN1PR21MB0014.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kewillf@microsoft.com; 
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2017 19:37:28.7499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR21MB0094
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Thomas Gummerer [mailto:t.gummerer@gmail.com]
> Sent: Monday, September 4, 2017 4:58 PM
>=20
> ce012deb98 ("read-cache: avoid allocating every ondisk entry when
> writing", 2017-08-21) changed the way cache entries are written to the
> index file.  While previously it wrote the name to an struct that was
> allocated using xcalloc(), it now uses ce_write() directly.  Previously
> ce_namelen - common bytes were written to the cache entry, which would
> automatically make it nul terminated, as it was allocated using calloc.
>=20
> Now we are writing ce_namelen - common + 1 bytes directly from the
> ce->name to the index.  As ce->name is however not nul terminated, and
> index-v4 needs the nul terminator to split between one index entry and
> the next, this would end up in a corrupted index.
>=20
> Fix that by only writing ce_namelen - common bytes directly from
> ce->name to the index, and adding the nul terminator in an extra call to
> ce_write.
>=20
> This bug was turned up by setting TEST_GIT_INDEX_VERSION =3D 4 in
> config.mak and running the test suite (t1700 specifically broke).
>=20
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>=20
> I unfortunately didn't have more time to dig so
>=20
> > As ce->name is however not nul terminated
>=20
> just comes from my memory and from the patch below actually fixing the
> corruption, so it's really the most likely cause.  Would be great if
> someone who can remember more about the index could confirm that this
> is indeed the case.
>=20

Digging into this and ce->name IS nul terminated.  The issue comes in when
the CE_STRIP_NAME is set, which is only set when using a split index.=20
This sets the ce->ce_namelen =3D 0 without changing the actual ce->name buf=
fer.
When writing the entry for the split index version 4 it was using the first=
 character
in the ce->name buffer because of the + 1, which obviously isn't correct.  =
  Before
it was using a newly allocated name buffer from the ondisk struct which was
allocated based on the ce_namelen of zero.

>  read-cache.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/read-cache.c b/read-cache.c
> index 40da87ea71..80830ddcfc 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -2103,7 +2103,9 @@ static int ce_write_entry(git_SHA_CTX *c, int fd, s=
truct
> cache_entry *ce,
>  		if (!result)
>  			result =3D ce_write(c, fd, to_remove_vi, prefix_size);
>  		if (!result)
> -			result =3D ce_write(c, fd, ce->name + common,
> ce_namelen(ce) - common + 1);
> +			result =3D ce_write(c, fd, ce->name + common,
> ce_namelen(ce) - common);
> +		if (!result)
> +			result =3D ce_write(c, fd, "\0", 1);

You could use the padding variable here as well which is used in the < vers=
ion 4
ce_write.

>=20
>  		strbuf_splice(previous_name, common, to_remove,
>  			      ce->name + common, ce_namelen(ce) - common);
> --
> 2.14.1.480.gb18f417b89

While looking at the code I was wondering if we could get around the
whole setting ce->ce_namelen to zero bit but that would be much bigger
patch and possibly introduce other bugs so this seems the appropriate
fix for now.

Thanks for finding this!
Kevin=20
