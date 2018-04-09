Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2264F1F404
	for <e@80x24.org>; Mon,  9 Apr 2018 16:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753242AbeDIQm6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 12:42:58 -0400
Received: from mail-sn1nam02on0137.outbound.protection.outlook.com ([104.47.36.137]:14508
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753413AbeDIQmN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 12:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=JsaZ9RAGh/6/Qwkb3HJlF9ofcaOlHRmqYsi/3j5nBUA=;
 b=JohW4+aiqGcIcFt3dJghWeil/+BFj+aYNhMxUlNUPn3HUnfDXhlu6UoDA6t1PSftLlvrHtVzD3fIeb921v7SRZFf1jcEs8Xf7jZKmVn55MuJSPQDMwpKWPSBQPgomU06cIW3i+3ec1JyNXxLJWYiL1TcaMzt19/fy3UMHo5JDF4=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0962.namprd21.prod.outlook.com (52.132.20.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Mon, 9 Apr 2018 16:42:11 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1%2]) with mapi id 15.20.0696.003; Mon, 9 Apr 2018
 16:42:11 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "bmwill@google.com" <bmwill@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 09/10] commit: use generation numbers for in_merge_bases()
Thread-Topic: [PATCH v2 09/10] commit: use generation numbers for
 in_merge_bases()
Thread-Index: AQHT0CG0xyCI3K1YRECsBvwT+Z80Cw==
Date:   Mon, 9 Apr 2018 16:42:10 +0000
Message-ID: <20180409164131.37312-10-dstolee@microsoft.com>
References: <20180403165143.80661-1-dstolee@microsoft.com>
 <20180409164131.37312-1-dstolee@microsoft.com>
In-Reply-To: <20180409164131.37312-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR13CA0029.namprd13.prod.outlook.com
 (2603:10b6:903:99::15) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0962;7:MtiAot8mmAaEEZBDlz8B0FsWH91ql3pbzSWEx0JwZhDCo0s6+laqXsEzCskE/cp88hsxasg38XCM64nz4jwVH5lD/2B1aMtqVsPl9T7XEGtDjRV07hXws/cSLmpARUWLx6/sb5Z4dMUfZTxyiwkrHRQOh+ug69f5TNmIJ5Ll+GVJWnRpll+fHTJ8zTdLjyeo6F5jVE4ONYYyhJ53GHbVB4QcV7rrFQpeJ4US+t6+9PIeHrXgky38xiwI4UXg4tHM;20:nRXZazBMEmdw5DXDryNmxbIsaMJ/jB+P4Q0YE+aaEVM+RUcGOpCsD/MzwGed44vHeufdDH12jYdt4BgP54p76+P906NTD4mA5JypjKRc9rAojHuuCD1j+llovMylqVZt9VD6+5g0S3I+8W/7lq1kAILpHlsp1evtEQYLDXunpJA=
X-MS-Office365-Filtering-Correlation-Id: 9b1d008d-ebbd-42f3-5d9c-08d59e38d712
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:BL0PR2101MB0962;
x-ms-traffictypediagnostic: BL0PR2101MB0962:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0962EBBE87029FA8470C151EA1BF0@BL0PR2101MB0962.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB0962;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0962;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(39380400002)(366004)(346002)(199004)(189003)(107886003)(59450400001)(105586002)(76176011)(14454004)(2906002)(316002)(68736007)(97736004)(8676002)(46003)(86612001)(3280700002)(39060400002)(386003)(6506007)(1730700003)(5640700003)(6116002)(3660700001)(102836004)(8936002)(25786009)(36756003)(54906003)(22452003)(4326008)(10090500001)(81156014)(81166006)(186003)(486006)(5660300001)(6916009)(5250100002)(2501003)(99286004)(1076002)(6512007)(2900100001)(53936002)(6436002)(305945005)(7736002)(106356001)(86362001)(2351001)(478600001)(476003)(52116002)(446003)(6486002)(11346002)(2616005)(10290500003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0962;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: LuoehaEYpPbyDXHF3kZsR8m7pCYALdnxhMvc/hJaZj5NoHDKSXyRYt9KiVphh2xEpyO6qx941GI3zGLPQGnLbdqw+3gr9j8g/m3M2FMJb9RFfUDxK2r3jUIQL8zm6TvJHmtxO9rxA84f9Fgxl661W4RE2p7TVTElZhbhIVfN34l5tvNF+8+zTLocLSWm4/Nz21UEh+GjQ3Pbr/wJy2xFaAamMQnUKbCCiJhwmAXdmkZBozxEvYWEkTY+FkcL//Nx4GQyPotzB/fhu8oFyfEj9dSa23+RT97crlQy4Kr4NJlBDbD6KuD8ClpeT+ZEMCwaY40zzPrMukuPjolQ9lSGanAn21F6RMde+o3y2G7x+tTIq7cJ6fLN9YpVXnn3tbU1yvfIMuPNdRfAJ6MJ57ECmqc4SRSXnkWHAuXOWE45T2A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b1d008d-ebbd-42f3-5d9c-08d59e38d712
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 16:42:10.9927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0962
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The containment algorithm for 'git branch --contains' is different
from that for 'git tag --contains' in that it uses is_descendant_of()
instead of contains_tag_algo(). The expensive portion of the branch
algorithm is computing merge bases.

When a commit-graph file exists with generation numbers computed,
we can avoid this merge-base calculation when the target commit has
a larger generation number than the target commits.

Performance tests were run on a copy of the Linux repository where
HEAD is contained in v4.13 but no earlier tag. Also, all tags were
copied to branches and 'git branch --contains' was tested:

Before: 60.0s
After:   0.4s
Rel %: -99.3%

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/commit.c b/commit.c
index 00bdc2ab21..0b155dece8 100644
--- a/commit.c
+++ b/commit.c
@@ -1059,12 +1059,19 @@ int in_merge_bases_many(struct commit *commit, int =
nr_reference, struct commit *
 {
 	struct commit_list *bases;
 	int ret =3D 0, i;
+	uint32_t min_generation =3D GENERATION_NUMBER_INFINITY;
=20
 	if (parse_commit(commit))
 		return ret;
-	for (i =3D 0; i < nr_reference; i++)
+	for (i =3D 0; i < nr_reference; i++) {
 		if (parse_commit(reference[i]))
 			return ret;
+		if (min_generation > reference[i]->generation)
+			min_generation =3D reference[i]->generation;
+	}
+
+	if (commit->generation > min_generation)
+		return 0;
=20
 	bases =3D paint_down_to_common(commit, nr_reference, reference);
 	if (commit->object.flags & PARENT2)
--=20
2.17.0

