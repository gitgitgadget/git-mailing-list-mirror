Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CAF01F954
	for <e@80x24.org>; Mon, 20 Aug 2018 18:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbeHTVlo (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 17:41:44 -0400
Received: from mail-cys01nam02on0132.outbound.protection.outlook.com ([104.47.37.132]:10688
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726147AbeHTVln (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 17:41:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgvkHn6ylHTqWW9jY03wMgBpFQeTHKhWG9JGN9GRluA=;
 b=K2TSotuS5pWjjJeEk4NX6sFlcOk6wgT4yV7JgCjkjU0ASgcPurFfka18/gI+CadNNaVEBXJtJqaHLFcOI9e21Sl24rM1AkYU7oJph5Nxg/KxMG67iEIMwZ8ZBsOeVhnB5U88wrIY9nhW1JYDHfYM3lV0JkJ1qj1AItFk0HMe/58=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0995.namprd21.prod.outlook.com (52.132.23.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1101.1; Mon, 20 Aug 2018 18:24:24 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c997:1e4b:40d8:1a49]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c997:1e4b:40d8:1a49%2]) with mapi id 15.20.1101.000; Mon, 20 Aug 2018
 18:24:24 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 4/8] test-repository: properly init repo
Thread-Topic: [PATCH v2 4/8] test-repository: properly init repo
Thread-Index: AQHUOLMF5njswzfYMUq6CULioZMfHw==
Date:   Mon, 20 Aug 2018 18:24:24 +0000
Message-ID: <20180820182359.165929-5-dstolee@microsoft.com>
References: <pull.11.git.gitgitgadget@gmail.com>
 <20180820182359.165929-1-dstolee@microsoft.com>
In-Reply-To: <20180820182359.165929-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1201CA0002.namprd12.prod.outlook.com
 (2603:10b6:301:4a::12) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:e008:1:8b51:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0995;6:zB+Zu9h9qvos4O42bparL2mlkqQsBmyPkx9l2RSNoyHCFQlTHvZESnRQoTmce3mOHvITNBzlKqt438jUmF4ksajdkq9tkY7HC603qHkrmNQJXkyN9SBIHRmZxHwkN5aamVM8nBTFPsaO1ods69XNlNc/UtIdyFsCN5j2HULES4rP3MgjJOlJoHzraZDLY4ap0w+CwV78bpSSbA/ryCdTbnaTXdHELP1zRjSz/pVzwjo6BrvRea3nAqHQhWLPAL+zblhehJMGzECzKUIrW8U62f6OG6UMbieSiShZB42hEyLWETWrHexfSbvYB3UX5fcbK7umdB6/9qU8NH3aJjP0Mt91J45KKBKoBnI4UIOr6uol+arsFN2GZa0AZSthx5wIjrqXC39cZLHZDjqmRIgl+SOv9byfyxi87a0KWZuUB0iDdEBcdgrRD0wvqAdiMd/ZwzaAICtj5R65SQuX0BXP1A==;5:hhxZgb0NBEVntY7sgJHLEIGan/BTaZ/+Y23B/Hv7kNzNr1KGQ0pnsf9yWPsCRgHKSDe/SBzz7i4ywK4uvo0Cqi6xTk3o+WsmR+zmedrMR/XOn8snWs7oTTc82DXQCfEfY6trvVHbZ2c0gKFbwljXfElabi2XUOHv7VoLZUt3Qa0=;7:Re2CFyjk+nJDInLcJsFBg54u0EzNzt5O7LgwsLhtaZas9uxQNOO5K9tLowVkb7680OQDmHp/H9dN1CbyctjBE/zMfV0MTPGQQsjwmSM31S6s4C5AH5y57pVxBuSAZnMmHlnY5iboj457s4XvPJFz3iX1XmX6wBIRzsOWvrjWDOQnsJ8/eGf01oid8zR0iq7biATn6CveHy2gM7tvwhbo56UuE9i1eCwlf9bGZOVWvmgwpSqlxzaJjztykBMH81WU
x-ms-office365-filtering-correlation-id: d8267df9-91f3-45bc-09d2-08d606ca27d1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:BL0PR2101MB0995;
x-ms-traffictypediagnostic: BL0PR2101MB0995:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB09955B10CC7965404679AF9CA1320@BL0PR2101MB0995.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(20180801012)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231336)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699016);SRVR:BL0PR2101MB0995;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0995;
x-forefront-prvs: 0770F75EA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(366004)(39860400002)(346002)(189003)(199004)(1076002)(4326008)(8936002)(2616005)(105586002)(86362001)(6486002)(5640700003)(6436002)(106356001)(5660300001)(10090500001)(8676002)(11346002)(446003)(486006)(14454004)(39060400002)(305945005)(81166006)(86612001)(81156014)(10290500003)(7736002)(6916009)(1730700003)(478600001)(6116002)(107886003)(102836004)(25786009)(476003)(2906002)(46003)(68736007)(53936002)(6512007)(2900100001)(5250100002)(2501003)(97736004)(2351001)(99286004)(22452003)(52116002)(36756003)(256004)(76176011)(316002)(386003)(186003)(54906003)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0995;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9OnRviKl5k1GYQaVweiPx4cWR7/I6u8ZlJYoVmyHNnHApAjt3GMh/3B1Ln6Lw+t4yC/g9aabyNtW/x5jYzZfKxJWxrtROPpOt5xKpzr9euAdk1xF9+W4vBUHfPYFipYoDF6vuxy+zUZOqte/Okze/0i2eLpeO1CYvWJc0lIYvn7+qyfNFunzzhJczYCyDZBy6/3CV4PxS+2cBmj6Vs9K8jwt8SvOaS0O64gXTjoW6dLmkPuQOW30hQUYQzCEV+54t1nApFkabsArnVGK7I6IF2RstuIvrQa6oe8198Lxqj8tHT4oSq/B/LBqTMRYg0oYUiIqcmkRtxps83HaL40NEivdddHAn2x+ERALwuQgraM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8267df9-91f3-45bc-09d2-08d606ca27d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2018 18:24:24.5448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0995
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/helper/test-repository.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-repository.c b/t/helper/test-repository.c
index 2762ca6562..6a84a53efb 100644
--- a/t/helper/test-repository.c
+++ b/t/helper/test-repository.c
@@ -15,7 +15,10 @@ static void test_parse_commit_in_graph(const char *gitdi=
r, const char *worktree,
 	struct commit *c;
 	struct commit_list *parent;
=20
-	repo_init(&r, gitdir, worktree);
+	setup_git_env(gitdir);
+
+	if (repo_init(&r, gitdir, worktree))
+		die("Couldn't init repo");
=20
 	c =3D lookup_commit(&r, commit_oid);
=20
@@ -38,7 +41,10 @@ static void test_get_commit_tree_in_graph(const char *gi=
tdir,
 	struct commit *c;
 	struct tree *tree;
=20
-	repo_init(&r, gitdir, worktree);
+	setup_git_env(gitdir);
+
+	if (repo_init(&r, gitdir, worktree))
+		die("Couldn't init repo");
=20
 	c =3D lookup_commit(&r, commit_oid);
=20
--=20
2.18.0.118.gd4f65b8d14

