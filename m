Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 067B81FAD6
	for <e@80x24.org>; Fri,  8 Sep 2017 18:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756749AbdIHSBj (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 14:01:39 -0400
Received: from mail-sn1nam01on0096.outbound.protection.outlook.com ([104.47.32.96]:32016
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754777AbdIHSBg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2017 14:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=thQR0ySl4F1xdku7y+zNuMsKgB752zvImgu1Dzvsruo=;
 b=TWgZbvRuirR42bc2q4GSEIgZaUERCtvUUhUoS8z9sZJ0FcWJmdu1Ss8GkHP4eRqzHaUQcjSfLggSx6QBbd+4RuHhsUWdhVfVvqHkcz2HgFgKjPHM29qbygU4xmQos3uB8h4O2AuZDTdfVAucbPskp9LvX6/Pp0JLoLC/SKWwc/E=
Received: from kewillf-01.northamerica.corp.microsoft.com (174.126.250.66) by
 CY1PR21MB0008.namprd21.prod.outlook.com (10.161.168.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.56.0; Fri, 8 Sep 2017 18:01:32 +0000
From:   Kevin Willford <kewillf@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, pclouds@gmail.com,
        Kevin Willford <kewillf@microsoft.com>
Subject: [PATCH 1/1] reset: fix reset when using the sparse-checkout feature.
Date:   Fri,  8 Sep 2017 12:00:50 -0600
Message-Id: <20170908180050.25188-2-kewillf@microsoft.com>
X-Mailer: git-send-email 2.14.1.474.g4443e2d25a
In-Reply-To: <20170908180050.25188-1-kewillf@microsoft.com>
References: <20170908180050.25188-1-kewillf@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [174.126.250.66]
X-ClientProxiedBy: CY4PR0101CA0031.prod.exchangelabs.com (10.171.218.44) To
 CY1PR21MB0008.namprd21.prod.outlook.com (10.161.168.155)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fd03d0c-1f94-4b57-b392-08d4f6e3a3e4
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(48565401081)(300000503095)(300135400095)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:CY1PR21MB0008;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR21MB0008;3:sKh+4E0XdqOq9RmFarS0D9uaBzo86GqAJXO4v/Q/gHqbsVhC0ifrwf+ACX7N1d1NLQPt2FzwlUhg16rYMQU/ipgbf2jbMuqyeLm/gYRLf8KFKul0pQ6OTGZwL0dxzf6q+fZAtTjKImJBJlr9b/eWWeevL/rcs3d5eQ0rQrdHV0SdfcU7qhsHhFYYY/6uzZ0vY6B6SHzcK5/dy++kkIA/1Ekk6sL/9wghgp1L1YxLkMzHNV1nmyGLs0jRvUjD6RFM;25:LIri4kUEHeUbz704YGbzn5qSI/vKhR+1CqDTY7qeG6h+huml+Ns++jJnV1BlmmC9TmDV++GWxJV9fSkVS7i7XOkxwVRKdyeVaMf3kVicvK27xS4XCsyJRigk3/bGVTgz7Dk0/385hH8YZGiVewEVuoN1I3KGApOf39jXjY04kRDvcgLM8P4BH7uf+Vv06BKfU5sanaebF2UqPt9dbR+1jik3sGyPehqxd4G4VDBaggWfdEPsU61l1NiVTqKAcXNNc3g4W+XRpt/YHQYXRRGu4k5GmxGhvSB93vrZAd6pBGP8I71uOho8l1dGScbuGKlP+S56sHtBrHrnme0U4l9/Ag==;31:WY5gXu5E/6e4RNb02tZpAuuTZIvAwUnO4UIFUpYZigIdznhlPc/TqxP0jzFhMH2107wFxG4mr6eyYV1GqLIWV6X+Q3aS7V4bNUnkZvsJY2TZKIkOlLCTP4RmnzAYW/46jpRz+1dxrfsV+/XuBD7Op9ar+DERVaibvLOuxMM8WGnJ8SO0XmNGl/CKo2SvnxNElcOUWjje88wRhm85YYYzVwnFm5sf4R/soJ5MQWUlOJc=
X-MS-TrafficTypeDiagnostic: CY1PR21MB0008:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kewillf@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;CY1PR21MB0008;20:1pbLYFsN4bfqdUBVq4lxvUc1zEIwXLET+leDrfsqgupkmfgfr3Dhaz8mF/Va2LCB8j8maLqPtnxO7pAmPmIpm7kxePo9JxSdQBX9YipDoSMdWf/HFZB5lRDrphSM9/rPFkU+YwO5WmvM/DILvEm/e0PP9jUDWTDs1HJaXNatcLv2Q+5kYeY1G8/KPaFUlRtNgY4JcS4tg07j7NB34zc2nbdT4yAxlS8k6DfdW/3r22c4Hi8aGkxD2JiRYR9RiF7LKq8/6MsLHbSrdVumztNF8WvFhC8t/2sdacGZ2CaeMckfBdHShKDbixiZG8K/XJjD1UHDIs+jSRbJKhQFYB8xAEtpcGVF/7uPABE2rvX4gijCC9O32fRfpJHSXpsXBuaCcUkHScOw9wgBzWBx9VATr4vD9ulR8WMRXpyGKvYkppn6xtXAJFGDyRQTVsRczzze0d+Lvj21NK/tIg9vr/6hVwuENx2H7OWrNcQ/Re8HCRrbTC+BB2CMcKv7RLrJFWWb;4:rMnvzqSM9lh0gOZiXQpD4dLYrSCfTkEOVJnR0F87+3cOk0xlrfCESl40U3ZIzpmRC0JBQAgX3BLkel6lT/WDNdP1f+gkmPzEQRglEP5la/2oTGV1a/O1kEMhqkUIgV/g0h4lwzHK27GkQGN807kxYNN8RBJ8eGYi3nAHv07AA0NqSEFMhBOIyStVHmoxd6jiUqjo4gtHNI192PLMM1mNXorXdKQ57gnc5FAgenIOrT2VUXTlE3MEUB078HGIbcTTEM4bXj5UuWD7SaRnh043yY7+lCSlTYP2XU5fABlezS4=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <CY1PR21MB00083698942884BD590507E5B7950@CY1PR21MB0008.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(100000703101)(100105400095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123555025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123564025)(20161123558100)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY1PR21MB0008;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY1PR21MB0008;
X-Forefront-PRVS: 04244E0DC5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(39860400002)(47760400005)(199003)(189002)(2361001)(110136004)(107886003)(5003940100001)(189998001)(39060400002)(42186005)(4326008)(10090500001)(86362001)(86612001)(2906002)(8656003)(2950100002)(6116002)(3846002)(6666003)(6486002)(6916009)(1076002)(53936002)(478600001)(66066001)(47776003)(68736007)(81166006)(106356001)(8936002)(48376002)(105586002)(7736002)(5660300001)(25786009)(8676002)(81156014)(2351001)(305945005)(50466002)(97736004)(36756003)(22452003)(33646002)(10290500003)(101416001)(50986999)(50226002)(76176999);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR21MB0008;H:kewillf-01.northamerica.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR21MB0008;23:eZJ0aUvvdTpee2hzA7lXWcqF9ROU/mhyoQ/SPaR9M?=
 =?us-ascii?Q?0jRT7SwSg3FemP5mco+Wb/Vig+nDTzLs/aYV7Bo3mLjxDrLnVkjNAy18l33o?=
 =?us-ascii?Q?X0T4Us+sMQ8M8SvVjPxH4e+1Ow2GNTJ4+d1xgbTZNNfPsmBmTvxZfjzLDTnk?=
 =?us-ascii?Q?kx9EaSWsAy5hyl2/kBD39ixF3nzrLPiAxq9ayn7Nolen/Ub/CwCj5k/mraH7?=
 =?us-ascii?Q?fX6Gxzps3g3VHtEh7pFbTMQrPtppr+b2at/I9L7oHTL54rE+0598nMbzrge1?=
 =?us-ascii?Q?zDUvJfHBCab8yWCm9SFL0BWI+pex4OAB0s7gNpBYLP9cUasCZq7WjGYyrgfH?=
 =?us-ascii?Q?UzOQKww+giOl09F4PhNd29TCNRNgZr9ksGU76MgpYufpnyLcIfres9MQQpg8?=
 =?us-ascii?Q?645ExX0h7s3IcgE3Cmf/0YUdt1lNYXCOm1RERSrKzI0NEUlV+TLBsQWmIcUu?=
 =?us-ascii?Q?Pqx1D0n6giy/atoLXGStPcP+sJciM5lXYdypVzgGQ8U4gTf7jxMydb26Q80A?=
 =?us-ascii?Q?PleD7A+oXdmLiUMFgHl1kRMHH3juO6fT3SPSlhJSrwyyqw7GHKt/KVTwVBfH?=
 =?us-ascii?Q?NEcTEK18KCXwHbumvY4VRzkgpMdAoV6kKMjQrSCp2AyDMWXr7lwyU5iw4aP4?=
 =?us-ascii?Q?0YGDrVbPqVvXJ8NqdjL25KnN4l8GqCLCQga9uTXCZ0f9rIUH9vYKDTp2+J81?=
 =?us-ascii?Q?2DHLalfCtWr8hYgklhHMcvwBE2Tw4vTDfanKomsD+v71F0+rHTp7HDzT2uqQ?=
 =?us-ascii?Q?j9ZDMRlEOLEgcMCRyIEt9cV/E5ntXibw1YUR5EnHIBcHdTXXnzZ5DNsX4Aof?=
 =?us-ascii?Q?B1lCpvVGmlQ78PWYxOQJTpLtDoQ7XsSBBjA4xiBqE5ItiGWj9QQUCTxVDS/X?=
 =?us-ascii?Q?nOT3NlM6JVwXWeZMuk07QcrkJn5t/aaAFxqrw9U1pGSUzaNBUsLn3othy0LP?=
 =?us-ascii?Q?wGR1m97WsT7HC2qzBRWu6bLpSyNfuF0L+Byodie2daI9zpNSYwpPMjr8DZP6?=
 =?us-ascii?Q?a8Cjj7hqIFRkEwZJEiAAnLQGQzJ3XGNEq9/ZfP9wFBVQC08z7LroqskA9H5X?=
 =?us-ascii?Q?kLpF4rR9NYvviiu6AvYo/z91o0nDZ5hlOkq/vmnaK0bhM1wiJzV/bLmdsSDT?=
 =?us-ascii?Q?cOu33tWo84pddoZFYXWUAir95BeUXWWJ3To3me7ZLwCTs/NsSU20ozHh4Jum?=
 =?us-ascii?Q?I4V4Q9hk2Yd9ORyuPUca+cvI1XaE3t8KBnw3MRm9ySWgeNe48oRAc9RmQYav?=
 =?us-ascii?Q?aeN5FvH7JceDiDb41Y=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR21MB0008;6:s8x9Q2zJGjRFq/hYGTUJ0eycF3wlucaVm5kZVMNn+NyhlvgaapA8a5+zJKqyaRNZw/4+yUpPp3K1cH5rcpDXFq6/l4UzgRn3DRpjVtu5p/XsnK9W1TWFcWb9ChpqogRLq5mhdlS64J/47SFQWe2auhmRTDm8xrTe5qer+MHXOP2kI+utvnJYIQdHLmbqUnHBFya67UgxpC+SI60MuVu3h4gZDbprC+3GKwQS4s8K0mJtRWilBK+cTI+U6xH++Yj1bSxx0VNObZyJKoFURkXqK9571SXsEsu21v19kpjljfIhfxh+N4Ov4z9VXh/16uqmAQpDl8OEDU85sN76fwEsFw==;5:bHYAjg024L+2ziN/euY+m9WkVVRl2b5ra6cGc4eDruI8FZ4OVh97aTVZrPCPEiqXSlGR/FU19Eh+aHbvLQdagBAHOAkEcZkFWBUAM8MQj5uhsmEMcwY7U++TCqGQmpDo93TMEmEuobsp5xthMcyXSg==;24:ErGbkJnvzy17SbqYQ4nartf5gdqHH/bbXptKsYWrQolrMssztlidyAY2Ytw90gFmtriz0CwbywPFBWULJ62XDBeS0wQTcAnC46STQfxWxe8=;7:E/8ox5uKP0hLusGtA3JzcWjtoAKmEmG/RBUcA8CY8ubR0g6ZKliIxlJjeFn+XHpkepVLVD3pFHg1ByorCmBAFGhqoBZm/BOQHhMBex7Mv+L/X59Pf+pCv++TpQAtYRpqJdKh3hLDdal7zQqzGeH8vfuiEAXjmo0oC97uoP7KNAsPz55yJj6Jlzm6/ltfrQ946Dy2TuVlHHOI8mSn9yKUcYghxv4vPrHiqY6qDnbTstc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2017 18:01:32.9547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR21MB0008
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using the sparse checkout feature the git reset command will add
entries to the index that will have the skip-worktree bit off but will
leave the working directory empty.  File data is lost because the index
version of the files have been changed but there is nothing that is in the
working directory.  This will cause the next status call to show either
deleted for files modified or deleting or nothing for files added.  The
added files should be shown as untracked and modified files should be
shown as modified.

To fix this when the reset is running if there is not a file in the working
directory and if it will be missing with the new index entry or was not
missing in the previous version, we create the previous index version of
the file in the working directory so that status will report correctly
and the files will be availble for the user to deal with.

Signed-off-by: Kevin Willford <kewillf@microsoft.com>
---
 builtin/reset.c                  | 25 +++++++++++++++++
 t/t7114-reset-sparse-checkout.sh | 60 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)
 create mode 100755 t/t7114-reset-sparse-checkout.sh

diff --git a/builtin/reset.c b/builtin/reset.c
index d72c7d1c96..1b8bb45989 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -24,6 +24,7 @@
 #include "cache-tree.h"
 #include "submodule.h"
 #include "submodule-config.h"
+#include "dir.h"
 
 static const char * const git_reset_usage[] = {
 	N_("git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<commit>]"),
@@ -124,8 +125,32 @@ static void update_index_from_diff(struct diff_queue_struct *q,
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filespec *one = q->queue[i]->one;
+		struct diff_filespec *two = q->queue[i]->two;
+		int pos;
 		int is_missing = !(one->mode && !is_null_oid(&one->oid));
+		int was_missing = !two->mode && is_null_oid(&two->oid);
 		struct cache_entry *ce;
+		struct cache_entry *ceBefore;
+		struct checkout state = CHECKOUT_INIT;
+
+		if (core_apply_sparse_checkout && !file_exists(two->path)) {
+			pos = cache_name_pos(two->path, strlen(two->path));
+			if ((pos >= 0 && ce_skip_worktree(active_cache[pos])) &&
+			    (is_missing || !was_missing))
+			{
+				state.force = 1;
+				state.refresh_cache = 1;
+				state.istate = &the_index;
+				ceBefore = make_cache_entry(two->mode,
+							    two->oid.hash,
+							    two->path, 0, 0);
+				if (!ceBefore)
+					die(_("make_cache_entry failed for path '%s'"),
+						two->path);
+
+				checkout_entry(ceBefore, &state, NULL);
+			}
+		}
 
 		if (is_missing && !intent_to_add) {
 			remove_file_from_cache(one->path);
diff --git a/t/t7114-reset-sparse-checkout.sh b/t/t7114-reset-sparse-checkout.sh
new file mode 100755
index 0000000000..f2a5426847
--- /dev/null
+++ b/t/t7114-reset-sparse-checkout.sh
@@ -0,0 +1,60 @@
+#!/bin/sh
+
+test_description='reset when using a sparse-checkout'
+
+. ./test-lib.sh
+
+# reset using a sparse-checkout file
+
+test_expect_success 'setup' '
+	test_tick &&
+	echo "checkout file" >c &&
+	echo "modify file" >m &&
+	echo "delete file" >d &&
+	git add . &&
+	git commit -m "initial commit" &&
+	echo "added file" >a &&
+	echo "modification of a file" >m &&
+	git rm d &&
+	git add . &&
+	git commit -m "second commit" &&
+	git checkout -b endCommit
+'
+
+test_expect_success 'reset when there is a sparse-checkout' '
+	echo "/c" >.git/info/sparse-checkout &&
+	test_config core.sparsecheckout true &&
+	git checkout -b resetBranch &&
+	test_path_is_missing m &&
+	test_path_is_missing a &&
+	test_path_is_missing d &&
+	git reset HEAD~1 &&
+	test "checkout file" = "$(cat c)" &&
+	test "modification of a file" = "$(cat m)" &&
+	test "added file" = "$(cat a)" &&
+	test_path_is_missing d
+'
+
+test_expect_success 'reset after deleting file without skip-worktree bit' '
+	git checkout -f endCommit &&
+	git clean -xdf &&
+	cat >.git/info/sparse-checkout <<-\EOF &&
+	/c
+	/m
+	EOF
+	test_config core.sparsecheckout true &&
+	git checkout -b resetAfterDelete &&
+	test_path_is_file m &&
+	test_path_is_missing a &&
+	test_path_is_missing d &&
+	rm -f m &&
+	git reset HEAD~1 &&
+	test "checkout file" = "$(cat c)" &&
+	test "added file" = "$(cat a)" &&
+	test_path_is_missing m &&
+	test_path_is_missing d
+'
+
+
+
+test_done
-- 
2.14.1.474.g0558484247.dirty

