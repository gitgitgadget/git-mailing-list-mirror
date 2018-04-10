Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B02CC1F404
	for <e@80x24.org>; Tue, 10 Apr 2018 18:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752832AbeDJSns (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 14:43:48 -0400
Received: from mail-cys01nam02on0119.outbound.protection.outlook.com ([104.47.37.119]:45338
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751940AbeDJSnq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 14:43:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ni8DFPeiE8JSrsDpFrTWP/Wsn29VrNbsMhJYybZjwOY=;
 b=F3d1rZbsIzoCf+NYUY+MZJxIhipDStcq1+DSDplDfTBDltsVzYFM78g82+jFS3aEznRtp4vogw3qHbnc9fYb2rI7IShfP+kassgNfxGl0W6bgpN2TyvJUhH+c/NkIUO8PLNW85vOUhwZuOhwI9NvsCrZ3gxezi6nZQqHmosK7Z4=
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com (52.132.133.38) by
 DM5PR2101MB0903.namprd21.prod.outlook.com (52.132.132.160) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Tue, 10 Apr 2018 18:43:43 +0000
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::5d76:2e71:c400:8b83]) by DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::5d76:2e71:c400:8b83%4]) with mapi id 15.20.0696.003; Tue, 10 Apr 2018
 18:43:43 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "alexmv@dropbox.com" <alexmv@dropbox.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>
CC:     Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v1] fsmonitor: fix incorrect buffer size when printing version
 number
Thread-Topic: [PATCH v1] fsmonitor: fix incorrect buffer size when printing
 version number
Thread-Index: AQHT0PvZ+EYLMOy7C0KQoK6NvTP3Qg==
Date:   Tue, 10 Apr 2018 18:43:43 +0000
Message-ID: <20180410184327.13896-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.16.2.windows.1
x-clientproxiedby: BN4PR12CA0004.namprd12.prod.outlook.com
 (2603:10b6:403:2::14) To DM5PR2101MB1016.namprd21.prod.outlook.com
 (2603:10b6:4:a8::38)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0903;7:CS87tDjJ9VDwcWiD5eXO0Q/yYXZOgbxALiwVdBJzw12koY2K6r6wwmknHCl2zHpuaMugeKR2GaGtUfTrDqU1FbWg00UWXgUoIttbWTrrJjrFwLV77Qwvos9vhBYHwBfaDJNSg9k2F7Zx+YmQMrJYr/kx2/EXtb+sw+djOJzBCGzpeX2Y485nB4HKEzJgJoOV8Z0JOTm/f5qMQzVrnzPs1KN/NFrfxuTUaSuf1dCTpqOSxHSe98qek5MUgCuojZBM;20:qQ1Lb70XhTP8urSZyQNuZ2FW62MnYExN6xQuwdnu+yG3qZakPCxpenxS2pDg4ej/bVE6Y8k+Tf8LTcLlo0DVS5AcuGrOmjxK8c9bMFFOKilwtkMvioyQYI4ADnP8P2Yvjn0INRvm43wvpaijzSoNq7SNUv9RV4pjXh4fpblJbzo=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0903;
x-ms-traffictypediagnostic: DM5PR2101MB0903:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB090378D4BE07AC99566D30EBF4BE0@DM5PR2101MB0903.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(166708455590820)(15185016700835);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0903;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0903;
x-forefront-prvs: 0638FD5066
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(39860400002)(39380400002)(396003)(199004)(189003)(575784001)(14454004)(386003)(59450400001)(6506007)(102836004)(8656006)(2201001)(186003)(26005)(99286004)(52116002)(3846002)(6116002)(476003)(2616005)(86612001)(1076002)(4326008)(966005)(3660700001)(110136005)(68736007)(2906002)(316002)(3280700002)(22452003)(72206003)(6486002)(10290500003)(5660300001)(486006)(97736004)(105586002)(478600001)(53936002)(10090500001)(39060400002)(107886003)(50226002)(8936002)(6436002)(8676002)(6306002)(6512007)(81166006)(81156014)(8666007)(36756003)(5250100002)(2501003)(25786009)(66066001)(2900100001)(106356001)(305945005)(7736002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0903;H:DM5PR2101MB1016.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: PtDVew9xctnemrq3qCtWxblsZX34z3ZsrgAJZg4XYrGs8uOBaeNu1gtcPMzCWv3m9aZ24Kv+lMHeXLA/iAKmEmN5YFDooQRsf5TdiOSO0aZg30vHHdblfACuUV1nxa5xVcefvQTljLvoiS6QQ7yqKj+3vA9KAiahp6W8iT0myL8QVKMBTd+teVX20GowqpTgfCW4yIIi2tVwnhQ2DLDh2l6rE3/vuHifCelnpcD6hthc/VRUH121Z6gFsU35nl6hemH1ecAOrHezGDoFYxv1vCv/t7X5xi1vPmdp849tcII2UZ0/3eHkHmQLWmYqDd6+rHfhRNax/R2R7eXVjLRK4jiISe9xWnfL1S3IeRvk2hJan/7R2AG03uBnDhXKEwnLvh+0VUXz5pG/TlzC/eaaSAKdSqdx5YRSsbjbozZT8+o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: f22eb93e-5970-4586-e45e-08d59f12fc32
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f22eb93e-5970-4586-e45e-08d59f12fc32
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2018 18:43:43.8038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0903
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a trivial bug fix for passing the incorrect size to snprintf() when
outputing the version.  It should be passing the size of the destination bu=
ffer
rather than the size of the value being printed.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---

Notes:
    Base Ref: v2.17.0
    Web-Diff: https://github.com/benpeart/git/commit/0bc3fc3b74
    Checkout: git fetch https://github.com/benpeart/git fsmonitor-version-v=
1 && git checkout 0bc3fc3b74

 fsmonitor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index 6d7bcd5d0e..eb4e642256 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -104,7 +104,7 @@ static int query_fsmonitor(int version, uint64_t last_u=
pdate, struct strbuf *que
 	if (!(argv[0] =3D core_fsmonitor))
 		return -1;
=20
-	snprintf(ver, sizeof(version), "%d", version);
+	snprintf(ver, sizeof(ver), "%d", version);
 	snprintf(date, sizeof(date), "%" PRIuMAX, (uintmax_t)last_update);
 	argv[1] =3D ver;
 	argv[2] =3D date;

base-commit: 468165c1d8a442994a825f3684528361727cd8c0
--=20
2.17.0.windows.1

