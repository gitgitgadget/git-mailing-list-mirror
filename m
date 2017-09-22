Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8644D202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 16:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752550AbdIVQgb (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 12:36:31 -0400
Received: from mail-cys01nam02on0112.outbound.protection.outlook.com ([104.47.37.112]:49189
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752516AbdIVQgP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 12:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=bF/gQpw1hPUjm9yamAYglxBnVRHaMMjkwKTM3l8W0CQ=;
 b=dH8Plpzmhv81ayo4YXO4mSXX6/1iAhl4dL5equqL2OJFJy2eNvJbLqlHSAflVYw5udKRkYkWJafrGMDMSt/yKHLHhf2+sKy2yJ8dElmFo++yx5WnvnHpTFReF6a5qBi87rF+XXFNFVMzYwqjmpjXtCbqIMC4O7bA7qMWqEHRm3A=
Received: from localhost.localdomain (65.222.173.206) by
 BN6PR21MB0466.namprd21.prod.outlook.com (10.172.111.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.98.0; Fri, 22 Sep 2017 16:36:09 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     benpeart@microsoft.com
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: [PATCH v8 03/12] update-index: add a new --force-write-index option
Date:   Fri, 22 Sep 2017 12:35:39 -0400
Message-Id: <20170922163548.11288-4-benpeart@microsoft.com>
X-Mailer: git-send-email 2.14.1.549.g6ff7ed0467
In-Reply-To: <20170922163548.11288-1-benpeart@microsoft.com>
References: <20170919192744.19224-1-benpeart@microsoft.com>
 <20170922163548.11288-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [65.222.173.206]
X-ClientProxiedBy: BN6PR06CA0048.namprd06.prod.outlook.com (10.174.93.37) To
 BN6PR21MB0466.namprd21.prod.outlook.com (10.172.111.144)
X-MS-Office365-Filtering-Correlation-Id: cf19aa6b-0be9-4f05-188a-08d501d807fb
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:BN6PR21MB0466;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR21MB0466;3:cv/F4lhC6/2seSzJrsswtPuQHgxMA+D1hhSDJN6oAKuS1vwMgkxV5iAbgRO7Eqipv/adpMgghRQZy5UJj9PgURx6heBqwEDFZ2Oz/K5UFYnzv5kafakove0s93Cf5MR8FA5ewAfpjCKEXHXJpOBdP9vX/LZLVbPNZzVYIiw4D4fZlbu2rBf+bKQqAcV3KNfFCTyRvL1vUBppXtvYcjRRh9eeUF1rtmkk2X6WDcHy7n7cVJqgvWTL7dXGW8P8+UI/;25:FvTo0eFq8XpRHnGbhvpc3eyKKK6EKdMBqqoLXIb2bKU0N5nHdY4MH1ViKLBYjAsRQOHZOhaLSjteESOvdANRBGJuL0p/Lj53KbtDn5nUESq2y9TeMMpCKWNVybpo3oio4wDOnJZFXUNVTBIFFf5/E/b2I6DC2hAlECvr8/vC7WmVWFUYUqrgOJJdZ47jkueuZ/k62KMrvA2UgTbSpLinS/LGpqLP0Xb26K97KHyyZItLM/kPud3ZDy2a7pa1BY17mHJZC4Y4JHLjTkK+vjLP19N3utew7VDP73EyxZvovHukDy+ls85m+7ofMqR6mw59cbkAReA06HoiNV5Q7Estvw==;31:afJXwVN8ngDfoUuKhl9o8fdvaZ5HSKjSiM7msN0DEm3mG42QDnLemC/+Ml8o64f160wvq6hETP6YBm8SRCEkStRfHbg4XMsIb5nZSdKsFYdAWVJ0hHgdiIkshYO6Of7h3hq+cwItbEGYAkXulIbQM3yMadHbOL5ssXEuBUauNiM65EvuP+PIRzxcF/HprKH8RUXgaqsMuKqtvvAcP0YB8rm3EFSJcxi7qT641TK72Nw=
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR21MB0466:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;BN6PR21MB0466;20:mRCURcVXHX/in+LKNy/ETHxTUaEwBOyF/J0IYd1qdqFy/YgG6rqdhgnyanLaagDidVEITrmIXV71neKBWPe7pQeHyz0OaBewZRyeNFBqAmSivQ/dZ4r8127zSfYLOqcgRLUoBQxnW+h8cAOp8ONB1/CTbOxn/4/uE6leQVNLg51YBeq9I7+N1BMw+GQF3baoI0GfnWiawMde0UoOAM7JSeqiWWa9/k2CIapVwBwIupFw3vujmnRCvhP+BQ0DlW47qGWcwnSG2OQmrUOMvDwKy7WkRgjwwr0t823nXQ5U5/DYSgLIaIK52NboauVBsCjwh5/pbZ1mxq1iNGQZ9ESI2PCPqE+f7b/PkYlrdsF7A2AZF9roCCKJqiea3f/XnrDHmPMim6eX0NPQUNftxqja7SA9VmFUShcPu7kClATt1kbk3+Q1/Gt0L/y6aPxBgDwNMpz8717jPN3uMw6MmsQ6UtATUtz0YdaUDllyBme4CjLVHhbJx3r+zifzEtx5s5qt;4:21o+ykrIAOxBasFRXk1jorRa0C/12Mpqqvlpf9I8O0P7aZM7fIw8HH4GQ2tMmp03bBjzhbUhXkN3OWvr0vhPIDT5TGYBUuDlLZXQ3bylaacfiiQxI0/Qm3IBFrGGE1vvUiDAT9CR8pJobxHuPpooUK93KLhPQCxYKJv9NaYLMuLgo1e7MuVMEXpsUqiFIT23df5+btpKR+gHwtBAiZIztoQH/hFLtkr6M0OI8XUGqGkVGJdghX/cdT850VL990+IgShN82gnJoi1XQ4upCtcte2k4VWUmoI6BDPWbdYy6aY=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <BN6PR21MB046641F29E4F16DAE13C2764F4670@BN6PR21MB0466.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(100000703101)(100105400095)(6055026)(61426038)(61427038)(6041248)(20161123558100)(20161123564025)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123555025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:BN6PR21MB0466;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:BN6PR21MB0466;
X-Forefront-PRVS: 0438F90F17
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(6009001)(346002)(376002)(39860400002)(47760400005)(199003)(189002)(2351001)(6506006)(10290500003)(6486002)(86612001)(2906002)(5660300001)(66066001)(4326008)(10090500001)(101416001)(97736004)(5003940100001)(1511001)(47776003)(50986999)(230783001)(68736007)(76176999)(50226002)(15650500001)(106356001)(16586007)(6666003)(16526017)(478600001)(53936002)(48376002)(2361001)(37006003)(50466002)(81166006)(81156014)(8666007)(8936002)(316002)(72206003)(36756003)(22452003)(6512007)(189998001)(8656003)(25786009)(2421001)(33646002)(2950100002)(6116002)(34206002)(39060400002)(3846002)(1076002)(305945005)(7736002)(105586002)(8676002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR21MB0466;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR21MB0466;23:yCwimhjuV3uYwHEmlvXNCQji0KpTNqfZL6oSLlfqo?=
 =?us-ascii?Q?ijViy9srAuRe73+txIPSXiQdFtRtHxV4ONIDdrgeN/pF4nbr+T4oHOhKr+if?=
 =?us-ascii?Q?qdNhH8VDxJGqLJ5QhbMUqAc3G+Rv1/6waWyc551JBBciMRyWO/FywQOFJ3M/?=
 =?us-ascii?Q?M4X+RKCet4qRtUOGCPTK1vTOgZxUwKmP+zMmPUD/6kJffeQN7H9bsQbPy4SO?=
 =?us-ascii?Q?7q0KCP1Nc2JPr/ne5VqGH7AmX2t0h1llm4gc+rIJ8mjUPVFIsyYt+G5G5dol?=
 =?us-ascii?Q?xfXY4oC41lEKwDeou0KvDMwOw0DjFZ2PoWgp5SY4wNR/eg6fkqqsY3xeZezj?=
 =?us-ascii?Q?pXGAW0oXQN6ZA1KpMh9RxHkAzpDb5Y6tX28qg+F/6DiAtPfK8hXMmqOTGJwA?=
 =?us-ascii?Q?kqRQ59IQz4BDO4e4PE4WGwjGaMdv4csFja/iNqQXMzXom+4QFuUP5KZV3hA7?=
 =?us-ascii?Q?fl5OxCLWQiuW0ZhtXvI1xuC4XZGN/fkIsCYnY21Lp0OtLRBfvnoa5FCv0EfP?=
 =?us-ascii?Q?ZMPd+nHbgERE5oRIPIaaCJr3JoS3xUA65r3ARmwDe7Uxh4fuSHyl6or1wedc?=
 =?us-ascii?Q?Z/1qHMr7ebM0E7Sv9liV5BAFsKC5+E6zM65QrGtNb6Bt/KggU1/Qph5FMILu?=
 =?us-ascii?Q?GIm3hdKnd3Vym3Y4W+YjOtGCysHIDSKEYvRjElta3PpKmoESK6mDAB5cbhTc?=
 =?us-ascii?Q?fjGF8wYbRTVZH0WTXPP1azOoPyKJKvJIw7RpSvEAWuPN3nZjLqWxlrj0vWSL?=
 =?us-ascii?Q?rAYDuL+G5u/xAwxr2Nzp38Y/EJZRJFoZlsA7gFrHRcABwEDCue48+D5q0yq4?=
 =?us-ascii?Q?0nIkdiw/6iAhDTX8a1+dgLNlxQkgbqU+t/meYjAitPh8YHn6V7Ct8eWvD+Ep?=
 =?us-ascii?Q?ykbDdei9iWHLvV2JgKsHpZJf0nLF7A5iSzW74x71AmgqIGZUGJ1CySwhkCnZ?=
 =?us-ascii?Q?bCrVZfRKiurGkZpd5s2dlO0gSgTroceOGLXuD6Ri3pmJzfJLy8pdZWuFv196?=
 =?us-ascii?Q?VlfMcQ5TeLCl+4b38DoTIHrk353aquJP8estbaccLbMHqoZm5bGt8TvHnlMm?=
 =?us-ascii?Q?xLcK9XDPKpG7n5OcPOjy6g8AjemyOu0kTbNq35vrAlPP+ZbflLHXKLO+TZ8o?=
 =?us-ascii?Q?yYa5oWFOPwSUxobOaSlVpvGkAl3I25KFJWaN50+kt9jOhil9eyGcuVIa6Wfs?=
 =?us-ascii?Q?vQSDfhlaOjxYalPe6gdk6x/h2Ma9SU5CXb0Xipd1LNSn/SG8PVJnzhNOC6ON?=
 =?us-ascii?Q?q8vpat+fHQhH+QAaSY1ImzT8bIk2Ti6o1QvIogEARPVcajt8bJN5GBbJXq2t?=
 =?us-ascii?Q?PcWrEWHnxQ0piR08lQod9JJEPXKRAsOOKQvk+0h6y0EuyN7Uag87XV0sO7TD?=
 =?us-ascii?Q?vON+7NyO739bB7Xl/tvQGfjcB9l56l2nnwPMPhdRzXJFfttkruiZ7iU8zxAH?=
 =?us-ascii?Q?P0vSPiXAWdwWYpvLt55wphEk7qtf6Gw6Mm66XSfq0jLy1QJOn63OQn1uapj2?=
 =?us-ascii?Q?domCFQZxCi8Hw=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR21MB0466;6:mrOnXOUYcrk+75GgCjk74cZ1Oi20phSOKxufO0jSRTDikWSgfOzjUbCMAqB1VfXM0GP2U210QqpXRe45A6ItEo8Nb3HoscG7/p8KZIqqOEL0rG8vLkNmcCC2hgEpRlsIfrkYBtUIe+XXl9Esz9Gn+9lX2jiI1eGORAKM1E9V66NjFc6w8kUWPHV9s2WvDBuPBAwXXvIpO8XDe11GtuaGgNxZDbn9jVqTSdUEVUCAfaLL/WKMCMKpNBMMm+vIvIzwY6aN9IJcLA4CadNcG+qvkggTH8zHokot5pJzVjfZJo3uuf02h54Cw55en76Nd2cwntYbxyo/WI+/U2E4kzW3CA==;5:M0deLr8OJ8klzxe1Q4JscCKQZoTtaG5CA2q1ome2EN9A8z+ruNU74D1izIH8km8RXuxJ0K8rIawfj7z8aWtx/Swbw3JspJ4p+i2555IpT5N7lw51qCYw7sxwFIsPZwKTHw9YBHB90ltZI35m8mbuCg==;24:hW/QqoxkdYEtvaBzlBrxkQNsmTDE30Tcv0TMl4JB7A3wKAeT2YswTq/tpj4rJt+IqTul01ycgl0aUklbR8wImu9dQs+McagXl5XitgI63TU=;7:ORJG3Z5HD02oLmXPG3lkHuufoAcJkD+j3n0GFpIcI0QomaaoREFf7bsC92mrn0cWkOXxLVxVz5nN2IYqGziIdwuqQ3dob6iWERq6xgrOEMTC3lHiKzKZibob+onnNa5H+w0EVctb5lAVs1eYHV2Ri8Tx42gwpsekzKLA3oRa06IU9LHdjaQL/0WjR1nC2iVDSE5yUonWYRtWFkJLjghzR13Teke+7rqQF0TZ6UhnIc0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2017 16:36:09.7034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0466
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At times, it makes sense to avoid the cost of writing out the index
when the only changes can easily be recomputed on demand. This causes
problems when trying to write test cases to verify that state as they
can't guarantee the state has been persisted to disk.

Add a new option (--force-write-index) to update-index that will
ensure the index is written out even if the cache_changed flag is not
set.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 builtin/update-index.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index d562f2ec69..e1ca0759d5 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -915,6 +915,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	struct refresh_params refresh_args = {0, &has_errors};
 	int lock_error = 0;
 	int split_index = -1;
+	int force_write = 0;
 	struct lock_file *lock_file;
 	struct parse_opt_ctx_t ctx;
 	strbuf_getline_fn getline_fn;
@@ -1006,6 +1007,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			    N_("test if the filesystem supports untracked cache"), UC_TEST),
 		OPT_SET_INT(0, "force-untracked-cache", &untracked_cache,
 			    N_("enable untracked cache without testing the filesystem"), UC_FORCE),
+		OPT_SET_INT(0, "force-write-index", &force_write,
+			N_("write out the index even if is not flagged as changed"), 1),
 		OPT_END()
 	};
 
@@ -1147,7 +1150,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		die("BUG: bad untracked_cache value: %d", untracked_cache);
 	}
 
-	if (active_cache_changed) {
+	if (active_cache_changed || force_write) {
 		if (newfd < 0) {
 			if (refresh_args.flags & REFRESH_QUIET)
 				exit(128);
-- 
2.14.1.549.g6ff7ed0467

