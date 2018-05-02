Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0617421847
	for <e@80x24.org>; Wed,  2 May 2018 16:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752024AbeEBQBY (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 12:01:24 -0400
Received: from mail-dm3nam03on0104.outbound.protection.outlook.com ([104.47.41.104]:10962
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751794AbeEBQBT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 12:01:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=1apP304koTpwCmAb5JGqZhexvK9vSaVFhHTv3h9TZ58=;
 b=VpnbNxAwj+Ks9lkwe/j6rxgxKhl+GGK0E0+mgD50U9IRSr/Tw6dWbeYXuMeB8RKEXWfgDPIOr21l57SePQ86Z+54bp8Igl0ARhvOADWsqbafkGWNJovvgGB01Am7MICqKRIlsWYsfbXzHvCtUVZSRpSaI8GVcrs0zI4mwbSEsr8=
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com (52.132.133.38) by
 DM5PR2101MB1015.namprd21.prod.outlook.com (52.132.133.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.755.1; Wed, 2 May 2018 16:01:16 +0000
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::5d76:2e71:c400:8b83]) by DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::5d76:2e71:c400:8b83%4]) with mapi id 15.20.0755.002; Wed, 2 May 2018
 16:01:16 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Ben Peart <Ben.Peart@microsoft.com>,
        "newren@gmail.com" <newren@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>,
        "eckhard.s.maass@googlemail.com" <eckhard.s.maass@googlemail.com>
Subject: [PATCH v4 3/3] merge: pass aggressive when rename detection is turned
 off
Thread-Topic: [PATCH v4 3/3] merge: pass aggressive when rename detection is
 turned off
Thread-Index: AQHT4i7MYAz/IDnn9U+wph7XM77HBA==
Date:   Wed, 2 May 2018 16:01:16 +0000
Message-ID: <20180502160056.5836-4-benpeart@microsoft.com>
References: <20180420133632.17580-1-benpeart@microsoft.com>
 <20180502160056.5836-1-benpeart@microsoft.com>
In-Reply-To: <20180502160056.5836-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.17.0.windows.1
x-clientproxiedby: BN4PR12CA0016.namprd12.prod.outlook.com
 (2603:10b6:403:2::26) To DM5PR2101MB1016.namprd21.prod.outlook.com
 (2603:10b6:4:a8::38)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:wvKj55rdWkRZtRxTsYqaj1hSMYoqNFifzFBJaZwrVmlGtWITzg4VwK9//TtoiaBnSjzkOXQi9OHEhUpd2oOMXkTFOKvyYNXQuH8+buXa0wWW121Hh2z5sA76CEcrczWe9qK20UBRMIGUEYSwpJnulqL//XgjLwQcU8bklmeT6vHaG7smjyCNUa3Xg4JFFUAoHlX3kswUXxtgpogp7Cnz3xrw2NPQeSW6mia4t7Yb+n4kCloeKOvB/tLYFhJHqscI;20:ahN55eyjcYQcfJ54BFx6wy20y7vz8a78kzcSdCvT6GTmoPN8B+f1IhZhFx+1yzgXSFyZbwrS2dDiKOw/XSoZ6rZmCVJiO6e9PoqRzw8BYpMAGIA1Z2syj0jI0Mz0dtn0E9DoKJIXl86Dv3TIQWaKfxhGMbN3Trxpy2O9m6V67GQ=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
x-microsoft-antispam-prvs: <DM5PR2101MB1015DBB0879B04F94BDF5CB5F4800@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(26323138287068)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(2018427008)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 06607E485E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(366004)(376002)(396003)(346002)(199004)(189003)(36756003)(39060400002)(102836004)(6346003)(486006)(26005)(25786009)(81166006)(81156014)(1730700003)(8676002)(14454004)(5640700003)(68736007)(316002)(54906003)(22452003)(11346002)(476003)(186003)(2616005)(52116002)(6116002)(76176011)(2906002)(59450400001)(386003)(6506007)(66066001)(3846002)(1076002)(446003)(86612001)(2351001)(53936002)(6486002)(478600001)(50226002)(6436002)(3280700002)(10090500001)(7736002)(8656006)(72206003)(305945005)(10290500003)(99286004)(5250100002)(4326008)(8936002)(105586002)(2900100001)(106356001)(97736004)(2501003)(8666007)(5660300001)(6512007)(3660700001)(6916009)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1016.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-message-info: zoWq2voiXGfxTYmfxyGdeIyCvJLC77gbB6VGiyQCuT86YeGnHa2OHjHcBymjpORN6YHxGcdNAzq14MfmsgQkAJAQIocQ8NquiKuR06WCEtLiEfEIPmgPJb+Q0vJgGwX+H7zeimvN2MqSdjwy0jow4wGmcX0ldvuxedSyeuDUOiYKWNJOfDqfTxLJ1eCvCwa6
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 3202acde-8d2c-4a02-a715-08d5b045ef44
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3202acde-8d2c-4a02-a715-08d5b045ef44
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2018 16:01:16.1122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Set aggressive flag in git_merge_trees() when rename detection is turned of=
f.
This allows read_tree() to auto resolve more cases that would have otherwis=
e
been handled by the rename detection.

Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 merge-recursive.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/merge-recursive.c b/merge-recursive.c
index 372ffbbacc..cea054cfd4 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -355,6 +355,7 @@ static int git_merge_trees(struct merge_options *o,
 	o->unpack_opts.fn =3D threeway_merge;
 	o->unpack_opts.src_index =3D &the_index;
 	o->unpack_opts.dst_index =3D &the_index;
+	o->unpack_opts.aggressive =3D !merge_detect_rename(o);
 	setup_unpack_trees_porcelain(&o->unpack_opts, "merge");
=20
 	init_tree_desc_from_tree(t+0, common);
--=20
2.17.0.windows.1

