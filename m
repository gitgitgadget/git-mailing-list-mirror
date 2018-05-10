Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51A8C1F406
	for <e@80x24.org>; Thu, 10 May 2018 17:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966765AbeEJRm5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 13:42:57 -0400
Received: from mail-bn3nam01on0136.outbound.protection.outlook.com ([104.47.33.136]:13536
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966701AbeEJRm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 13:42:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=+d8PAJO/H3wbACbhL9J0HYsn2eT5wJThszbZ14de11Q=;
 b=kGThmWg9tlJtSaK3usDQTcISjV+B2j0VU4X+uaKzBx28iwPRnrHreZehiv2KV1pexA1GoiUiBH0x+2RvII8oh9Naq0yp8v+6HS28aj+giT6Vwa/O6WeX4symazF2ThekBiBj+xcCFO72XeoZZRqZdVMwThNPp9VfOKwxcpOnqW4=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1060.namprd21.prod.outlook.com (52.132.24.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.776.3; Thu, 10 May 2018 17:42:53 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8%3]) with mapi id 15.20.0776.004; Thu, 10 May 2018
 17:42:53 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2] commit-graph: fix UX issue when .lock file exists
Thread-Topic: [PATCH v2] commit-graph: fix UX issue when .lock file exists
Thread-Index: AQHT6IZSTTKlFE74UUGnqZFZBuqzEw==
Date:   Thu, 10 May 2018 17:42:52 +0000
Message-ID: <20180510174242.44346-1-dstolee@microsoft.com>
References: <20180509141523.89896-1-dstolee@microsoft.com>
In-Reply-To: <20180509141523.89896-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR08CA0080.namprd08.prod.outlook.com
 (2603:10b6:404:b6::18) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1060;7:B2zqUDX4AE5QsMRxj78jatWRGCcrE+IZWJgUJTCmIIC2UuBwv4JKWN1g5Qomg1cQJxkhqXYjj285bksc6JjAEn1VbSsVcWpjU5GQHIkJFVR1gBsqRfISkWI8s7SSgvNA10YxuDsjnxosFfxUbLuvDvoTjl3TB4huZ6C2NB4jkErVYSOciMn0xfetBW9KgjCg7gXasI390MFA4CFoQpO5LxTkPfFsg4XkGk9h7c18+E9CyWZH5udxSmKMTTMwe03y;20:YIXN92A++CWuK00Pnko227ir7vwwHxPnMYkO60Sys2ASuiU9N2L56xScgpv4MfdWpQeMzlpumcdRaw4Q+5BknQshgeiZ3KeGLsP4W3PfwBPxO8LcTG1xT9/ePCvspTW01kgTtFoNswCwrGHmiUYcYd4HjPit6E/oRbKDjcVPO+8=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1060;
x-ms-traffictypediagnostic: BL0PR2101MB1060:
x-microsoft-antispam-prvs: <BL0PR2101MB10605C7EF4491ACCC3BCF7ECA1980@BL0PR2101MB1060.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR2101MB1060;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1060;
x-forefront-prvs: 066898046A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(39860400002)(39380400002)(396003)(199004)(189003)(76176011)(22452003)(5250100002)(86362001)(575784001)(10290500003)(102836004)(52116002)(5660300001)(36756003)(3660700001)(54906003)(6512007)(14454004)(6346003)(6916009)(6506007)(316002)(11346002)(476003)(2616005)(186003)(39060400002)(486006)(478600001)(4326008)(6436002)(5640700003)(59450400001)(86612001)(446003)(7736002)(3280700002)(6486002)(105586002)(2900100001)(2351001)(2501003)(25786009)(68736007)(46003)(81166006)(8656006)(106356001)(8676002)(53936002)(2906002)(386003)(1730700003)(305945005)(99286004)(97736004)(81156014)(107886003)(6116002)(1076002)(8936002)(10090500001)(22906009)(142923001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1060;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-message-info: wpml7Kd0811vbx8m4f4stGwxHOUZOeYTH0qROxguMfgORKhIda6EdLy2Su2s5U2agGmsQTV4ZUC0T9gslHasoRmKVToXuzrUZTvN6VEFW8YwxZFzpeUseuG57yTNHuxE5TqvONZ0XHPCtlyx+yLgu0eXoiCsDVUK4zicJsn63i4PgarYxR0vhB3PUi5SvAJH
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: d5b09746-e554-4ad3-e2d5-08d5b69d7460
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b09746-e554-4ad3-e2d5-08d5b69d7460
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2018 17:42:53.0466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1060
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We use the lockfile API to avoid multiple Git processes from writing to
the commit-graph file in the .git/objects/info directory. In some cases,
this directory may not exist, so we check for its existence.

The existing code does the following when acquiring the lock:

1. Try to acquire the lock.
2. If it fails, try to create the .git/object/info directory.
3. Try to acquire the lock, failing if necessary.

The problem is that if the lockfile exists, then the mkdir fails, giving
an error that doesn't help the user:

  "fatal: cannot mkdir .git/objects/info: File exists"

While technically this honors the lockfile, it does not help the user.

Instead, do the following:

1. Check for existence of .git/objects/info; create if necessary.
2. Try to acquire the lock, failing if necessary.

The new output looks like:

  fatal: Unable to create
  '<dir>/.git/objects/info/commit-graph.lock': File exists.

  Another git process seems to be running in this repository, e.g.
  an editor opened by 'git commit'. Please make sure all processes
  are terminated then try again. If it still fails, a git process
  may have crashed in this repository earlier:
  remove the file manually to continue.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index a8c337dd77..bb54c1214c 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "config.h"
+#include "dir.h"
 #include "git-compat-util.h"
 #include "lockfile.h"
 #include "pack.h"
@@ -640,7 +641,6 @@ void write_commit_graph(const char *obj_dir,
 	struct hashfile *f;
 	uint32_t i, count_distinct =3D 0;
 	char *graph_name;
-	int fd;
 	struct lock_file lk =3D LOCK_INIT;
 	uint32_t chunk_ids[5];
 	uint64_t chunk_offsets[5];
@@ -754,23 +754,11 @@ void write_commit_graph(const char *obj_dir,
 	compute_generation_numbers(&commits);
=20
 	graph_name =3D get_commit_graph_filename(obj_dir);
-	fd =3D hold_lock_file_for_update(&lk, graph_name, 0);
-
-	if (fd < 0) {
-		struct strbuf folder =3D STRBUF_INIT;
-		strbuf_addstr(&folder, graph_name);
-		strbuf_setlen(&folder, strrchr(folder.buf, '/') - folder.buf);
-
-		if (mkdir(folder.buf, 0777) < 0)
-			die_errno(_("cannot mkdir %s"), folder.buf);
-		strbuf_release(&folder);
-
-		fd =3D hold_lock_file_for_update(&lk, graph_name, LOCK_DIE_ON_ERROR);
-
-		if (fd < 0)
-			die_errno("unable to create '%s'", graph_name);
-	}
+	if (safe_create_leading_directories(graph_name))
+		die_errno(_("unable to create leading directories of %s"),
+			  graph_name);
=20
+	hold_lock_file_for_update(&lk, graph_name, LOCK_DIE_ON_ERROR);
 	f =3D hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
=20
 	hashwrite_be32(f, GRAPH_SIGNATURE);

base-commit: 34fdd433396ee0e3ef4de02eb2189f8226eafe4e
--=20
2.16.2.329.gfb62395de6

