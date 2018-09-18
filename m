Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C9F01F453
	for <e@80x24.org>; Tue, 18 Sep 2018 23:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730491AbeISFEe (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 01:04:34 -0400
Received: from mail-by2nam03on0128.outbound.protection.outlook.com ([104.47.42.128]:52352
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727326AbeISFEe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 01:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54auV7nrWb1Fhh3DQPpB6FCqM1a71fvjCvyP2+MXjR4=;
 b=UXw5jEEUh02fKnoV0129vtW9TwWdWV4/oUe1FrCNhSlOhUrlJKLSwlyeYCYkXJ85E9NBuBhCu4JYP/r9WX0Hl/IfvCTBD6mr2a1hbwoOR82YMnhyEwVJhW0RJhV+Bd0t1n6IoGbVoM6NqTDqEVjkMSDRrcxvv620rNDt3ZHhSHs=
Received: from BL0PR2101MB0962.namprd21.prod.outlook.com (52.132.20.155) by
 BL0PR2101MB0994.namprd21.prod.outlook.com (52.132.23.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1185.6; Tue, 18 Sep 2018 23:29:35 +0000
Received: from BL0PR2101MB0962.namprd21.prod.outlook.com
 ([fe80::f0b9:d24f:2522:d7be]) by BL0PR2101MB0962.namprd21.prod.outlook.com
 ([fe80::f0b9:d24f:2522:d7be%2]) with mapi id 15.20.1185.006; Tue, 18 Sep 2018
 23:29:35 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "jrnieder@gmail.com" <jrnieder@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v3 2/5] preload-index: use git_env_bool() not getenv() for
 customization
Thread-Topic: [PATCH v3 2/5] preload-index: use git_env_bool() not getenv()
 for customization
Thread-Index: AQHUT6d1SVlL0SwPJ0WgpIvxPELPxA==
Date:   Tue, 18 Sep 2018 23:29:34 +0000
Message-ID: <20180918232916.57736-3-benpeart@microsoft.com>
References: <20180914143708.63024-1-benpeart@microsoft.com>
 <20180918232916.57736-1-benpeart@microsoft.com>
In-Reply-To: <20180918232916.57736-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.18.0.windows.1
x-clientproxiedby: BN6PR19CA0107.namprd19.prod.outlook.com
 (2603:10b6:404:a0::21) To BL0PR2101MB0962.namprd21.prod.outlook.com
 (2603:10b6:207:30::27)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0994;6:WnHDuXsRwK3QjLLxUIMRWF2IbOHba1cG31VegcyPLE17NmO77iqRXRFONCsGugS1K/pyTestibxs6YrKWii9nrENbWbpG33PQ0j52lbVkquEaqNNtxVZ+83rpLJu5ca6NWSU4MBN5ux+KWIK8BUFUoTXFZ9d+IILroauZMbatEGFOv/M142qllfmLF05+qJxW8yKhZRgsX/h0y2aP+oY466poMtbEyaKvdUABiP+5LK3I1+f+NFohBKau7OYrZlqctUDwuBD/+VWAtT1AAIB7GCc9BzznKmKl6H26I1zk6UvkmEbeYM9P+MYfo8G4KfNrt3if7DudsRmbImo8nG8Q+Iyb8LtJYz86XENxStHzuuPFO2aINax7Y72rMsaxwzoRtQ3ARiMZrhKsHvzUj5GvkhHf8QAf4g/6AYaW6yLQo5FQRy2tb/W3EFQR+ZV6gljdG6/EWFOJAWpoKpG7JVtZA==;5:jViwffs6rBIohdgjgq4ZqQrlvxS2nFNTle7pcG3LVweEakrrBWcZLgOooX2QOa6TBhkSvs9uF44Z0ygbri3rrtiXRK/zqU0VI0fFKg5Vr2Tr7BH1d6i1YVj9Z4T6gtl6anky2FckJywW803imj9F/PSNpdRuiMX6JCD16P5Q79Y=;7:/Z5m8D63igoXCgpVB1f6MHdESLLG/x4Q8rxLtL18vNEsLM1WX9XT9+V8/KeUYopjyvqMIM6vaWxxQaHj9eMGTpcVXdM/eUtJcqlVR8KHw4Ccs3J/OicudeXShkgUP1Ntb3TsM7GPNbX4vecr3Nifr3fvb0u0TzqJWyiZ7UgrzWaHWZUDLX6rZYLLxWn+al+cQjWESXEwUE3yLjLjkgN1vZDDn34HaK/ukKoV8D3yIAIo8J6tsJ1nVOFlwzRQNz3h
x-ms-office365-filtering-correlation-id: a4b0e518-bd80-4ba8-7206-08d61dbe97bf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:BL0PR2101MB0994;
x-ms-traffictypediagnostic: BL0PR2101MB0994:
x-microsoft-antispam-prvs: <BL0PR2101MB0994BD0293E2A3CC7EC1861CF41D0@BL0PR2101MB0994.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:BL0PR2101MB0994;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0994;
x-forefront-prvs: 0799B1B2D7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(366004)(136003)(39860400002)(199004)(189003)(54906003)(14444005)(68736007)(2616005)(2906002)(86612001)(5640700003)(476003)(11346002)(256004)(6506007)(386003)(102836004)(8676002)(3846002)(6512007)(50226002)(36756003)(6116002)(446003)(316002)(486006)(6916009)(1076002)(2900100001)(8936002)(66066001)(10290500003)(5660300001)(81156014)(478600001)(1730700003)(72206003)(186003)(14454004)(99286004)(26005)(105586002)(52116002)(53936002)(2351001)(4326008)(81166006)(6486002)(2501003)(97736004)(107886003)(22452003)(76176011)(106356001)(5250100002)(6346003)(39060400002)(10090500001)(6436002)(305945005)(25786009)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0994;H:BL0PR2101MB0962.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-message-info: NgXMkyPleLLJbrFPuC2CbRNLCY0uTniYfbkPRosDHFdS8qMp9MZv5fWaOKB4Q1ATlf6MxUEblqNUhj6V1/DepqGx9ZnhlDYivc/EtvEjR7RnMvHNWm8vqMlpPlPeWcIlOsqJ6RwPyY3UsQfZ4y1O+DgyVp7ePLMvIXtfzxvlIV5KvyFMUFmJQsKvdkIafWiFzusM8msDlzVthyUZ8qBv1guvcJN7TgNMBocxK1/sQgbOL5m24US+eUDf/MuGvbNLRoXIWU+85yX/RjzmqInvIBo+D5br3wVukyDj35CnARvS75Mr6219CldvWaycGjAl7BBdZMIt3/T98uTGQWcrOi7X/g8NHd2CRIWuQ6uYAoM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b0e518-bd80-4ba8-7206-08d61dbe97bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2018 23:29:34.9058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0994
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

GIT_FORCE_PRELOAD_TEST is only checked for presence by using getenv().
Use git_env_bool() instead so that GIT_FORCE_PRELOAD_TEST=3Dfalse can
work as expected.

Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
---
 preload-index.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/preload-index.c b/preload-index.c
index 71cd2437a3..0a4e2933bb 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -5,6 +5,7 @@
 #include "pathspec.h"
 #include "dir.h"
 #include "fsmonitor.h"
+#include "config.h"
=20
 #ifdef NO_PTHREADS
 static void preload_index(struct index_state *index,
@@ -84,7 +85,7 @@ static void preload_index(struct index_state *index,
 		return;
=20
 	threads =3D index->cache_nr / THREAD_COST;
-	if ((index->cache_nr > 1) && (threads < 2) && getenv("GIT_FORCE_PRELOAD_T=
EST"))
+	if ((index->cache_nr > 1) && (threads < 2) && git_env_bool("GIT_FORCE_PRE=
LOAD_TEST", 0))
 		threads =3D 2;
 	if (threads < 2)
 		return;
--=20
2.18.0.windows.1

