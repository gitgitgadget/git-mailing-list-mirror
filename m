Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 082D11F954
	for <e@80x24.org>; Mon, 20 Aug 2018 18:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbeHTVlm (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 17:41:42 -0400
Received: from mail-cys01nam02on0132.outbound.protection.outlook.com ([104.47.37.132]:10688
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726229AbeHTVlk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 17:41:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSqdSK2wuuirNqf4L+GidgmLyoHxIMKrza40pDHmUE8=;
 b=nLIYI/cYvs1RJ9NuDsv/8syqoNPOcDG+neT/aGYoOel96Eju07Eir6IIsv9fthb8WQMfPpAvU84stc6meZYuQmTPEdpi3ukBaIzuEhnKvgPnax9EpBXggxmxAxSjfqmluUPoY+6Al/imz5E88H6ctiHYUfAfiMfo8qhsaWAK1w0=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0995.namprd21.prod.outlook.com (52.132.23.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1101.1; Mon, 20 Aug 2018 18:24:21 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c997:1e4b:40d8:1a49]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c997:1e4b:40d8:1a49%2]) with mapi id 15.20.1101.000; Mon, 20 Aug 2018
 18:24:21 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 3/8] commit-graph: update design document
Thread-Topic: [PATCH v2 3/8] commit-graph: update design document
Thread-Index: AQHUOLMD2Ps2dPaCfES6jki5V1tcmA==
Date:   Mon, 20 Aug 2018 18:24:21 +0000
Message-ID: <20180820182359.165929-4-dstolee@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0995;6:BqJtPgOIYr7qARbE2GQn/MJ8b0szO5u0Qxt2iOU3jxAiRWFQ3fjBGNoEmRhivxwzw1XyjcobUAgQrZBQC07KRwQv1qv/ZM8k4Yk+ZB1bp92B/7HglfaYKTD73FxYqUtCZkWHlo7Bv868RjCjieNY79JmI66GxRZZZM7HxIgflqFKATj1D+Rm8eJVZeXR20p7G79m2QgLGWIr9xgM+q+iFlI0fwKO5IyKjgsJ6HDEPzMMLrNF7wC99ux05uOjT5/6M/8eo9hr77yTnwkIHgxsLMEpzoZVB4gyqwZTbtYvqe2whNsDiuk1flxfXKjM79TeDOB0/CDCsObowVYneKwdGSXND8NUlhGAOZloe+yOAfxb/Day8nelnXKVWjH0oqwwdy+9qEmCjj3HcHe5FF67+FhCgtT0lPU8j8o+dhlSvQiirw6pdffO5wjqnBuN7S2sLliUAURBZTe0Q9IPVw11pQ==;5:H2HuDj5Vp34CQF3wnvf6c6ChTQg3Ap07jObKlSQJ9HZ6qH9cgvSm7NsaL7trUy8rNptsm/TI9/QGqr/fpVXgy+Lc+930ivOaClTeM33XJhP2FFEoQAXJNCUf93FIqiWW4s1ZBJmTyenb+OoZzioZ3SqktEG8hDR5iM6JfQnwtpk=;7:MHtOARCEzMlRhiCFNv88uahs0kaOL4t6l4ft7ZItsvRdndiYqhEfaPvcJAEpPJg0+K4mZXUar6tC0t0r7V5iftEGtHKOApSPJA/PNroLJTYVCBGkJ/0Un8FL5ZTrBSbibvONuGjp6EWk7K8EGPvZvK/gr6lE9NxshimsA5JtIDYbWC0GXnNl5X7iX4EZS+NHWfm5JTfBSITLDa3bjE+JPZa6tsnNz6FgBKY8nl4xAvz5us7smV4psiJMgAsOh/b+
x-ms-office365-filtering-correlation-id: 727dc264-cffe-443c-1ea7-08d606ca260e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:BL0PR2101MB0995;
x-ms-traffictypediagnostic: BL0PR2101MB0995:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0995C7002CBA241EC1E2C7E8A1320@BL0PR2101MB0995.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(788757137089);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(20180801012)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231336)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699016);SRVR:BL0PR2101MB0995;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0995;
x-forefront-prvs: 0770F75EA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(366004)(39860400002)(346002)(189003)(199004)(1076002)(4326008)(8936002)(2616005)(105586002)(86362001)(6486002)(5640700003)(6436002)(106356001)(5660300001)(10090500001)(8676002)(11346002)(446003)(486006)(14454004)(39060400002)(305945005)(81166006)(86612001)(81156014)(10290500003)(7736002)(6916009)(1730700003)(478600001)(6116002)(107886003)(102836004)(25786009)(476003)(2906002)(46003)(68736007)(53936002)(6512007)(2900100001)(15650500001)(5250100002)(2501003)(97736004)(2351001)(99286004)(22452003)(52116002)(14444005)(36756003)(256004)(76176011)(316002)(386003)(186003)(54906003)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0995;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: p2Ibn+X3L2q7TNBLXkO4BizE/1fm+KJMVj/ly71nNaSVC1sM3KLOevASwlZvuxoCuK9ZC4NzGrUm+NzDa1aaP0ItfQ/7aOr0F3shwsoDNNy38AyRlcLmETowz9XJyMIIctSwBsVbgygAXJdEvv2VeiIqI0PEWkOuWD6aCGQ0TE4y2ER6uTPr9wfpVLNhhxBJR5kJylgDqFdv7XNjF/2Xk54S9HjZrfts3XHUIPzFpdz+yB5cVkyOr9okb5wcra2eAopobKZcWXEX2pHDNPPW/ACSV9xye8vhbSdUFxa4qsZgfy8nyOHtQ9nAw2RKd1NJtmkf6JG3Ww/DkqxaVJDQPYGNC/rV7qyQY1Wa6zqLJHE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 727dc264-cffe-443c-1ea7-08d606ca260e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2018 18:24:21.6587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0995
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As it exists right now, the commit-graph feature may provide
inconsistent results when combined with commit grafts, replace objects,
and shallow clones. Update the design document to discuss why these
interactions are difficult to reconcile and how we will avoid errors by
preventing updates to and reads from the commit-graph file when these
other features exist.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/commit-graph.txt | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/commit-graph.txt b/Documentation/techn=
ical/commit-graph.txt
index c664acbd76..001395e950 100644
--- a/Documentation/technical/commit-graph.txt
+++ b/Documentation/technical/commit-graph.txt
@@ -112,12 +112,24 @@ Design Details
 - The file format includes parameters for the object ID hash function,
   so a future change of hash algorithm does not require a change in format=
.
=20
+- Commit grafts and replace objects can change the shape of the commit
+  history. The latter can also be enabled/disabled on the fly using
+  `--no-replace-objects`. This leads to difficultly storing both possible
+  interpretations of a commit id, especially when computing generation
+  numbers. The commit-graph will not be read or written when
+  replace-objects or grafts are present.
+
+- Shallow clones create grafts of commits by dropping their parents. This
+  leads the commit-graph to think those commits have generation number 1.
+  If and when those commits are made unshallow, those generation numbers
+  become invalid. Since shallow clones are intended to restrict the commit
+  history to a very small set of commits, the commit-graph feature is less
+  helpful for these clones, anyway. The commit-graph will not be read or
+  written when shallow commits are present.
+
 Future Work
 -----------
=20
-- The commit graph feature currently does not honor commit grafts. This ca=
n
-  be remedied by duplicating or refactoring the current graft logic.
-
 - After computing and storing generation numbers, we must make graph
   walks aware of generation numbers to gain the performance benefits they
   enable. This will mostly be accomplished by swapping a commit-date-order=
ed
--=20
2.18.0.118.gd4f65b8d14

