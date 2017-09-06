Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52C48209B1
	for <e@80x24.org>; Wed,  6 Sep 2017 22:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755406AbdIFW3X (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 18:29:23 -0400
Received: from mail-bn3nam01on0119.outbound.protection.outlook.com ([104.47.33.119]:45339
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933036AbdIFW3P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 18:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=3nzKK6PQ3/fIJMtddyqzQuQ/zjwSYvDSsBZb+whyTtA=;
 b=KjRGq18n8QsfLIcZEVJ5ObG+lhR+8fBxcFFjSsIY5IzhrZuDQPxp7CnEgEpy3SGG4W/suzWjkLresC7f6Qa9dL+R+6eyZl/+YYJNGb1swwOnK7zIUzlQuttqErb4OU43RaGRH5LboHOkTj0DVv/b/BVHSo1bjctHYY06zmfLjCA=
Received: from kewillf-01.northamerica.corp.microsoft.com (174.126.250.66) by
 CY1PR21MB0007.namprd21.prod.outlook.com (10.161.168.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.56.0; Wed, 6 Sep 2017 22:29:10 +0000
From:   Kevin Willford <kewillf@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Kevin Willford <kewillf@microsoft.com>
Subject: [PATCH v2] merge-recursive: change current file dir string_lists to hashmap
Date:   Wed,  6 Sep 2017 16:28:34 -0600
Message-Id: <20170906222834.77116-1-kewillf@microsoft.com>
X-Mailer: git-send-email 2.14.1.327.g8cf34b7ac7
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [174.126.250.66]
X-ClientProxiedBy: CY4PR01CA0007.prod.exchangelabs.com (10.169.249.17) To
 CY1PR21MB0007.namprd21.prod.outlook.com (10.161.168.154)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f45c535-5aec-41fa-fc53-08d4f576b24d
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(300000502095)(300135100095)(22001)(2017030254152)(300000503095)(300135400095)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:CY1PR21MB0007;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR21MB0007;3:vr9vTNI8WbFZsmMFJJBeZDkQRB6yuEzYWx4JlyGhBAfQWp8JcQW1ezNM+ExMbf0l2X4EUXg+sbVSITcv3/yUGgaU9X1EwuqWTcjwzT/NQGgTyoBu5RtaUDZdzejYgBP5jlV+qjloYRZz+L+pfsAzz/BV3ve8mxd/FPqb+pE6fPJ2EhdnP1Dyyk4HkIzWmzHDogPk0prZVMmrF4adx6BJpVbdc9NmVWf5OxuB4Vy4IKctCQLg3zG6SFFtFVSlesDE;25:cCVDFOtLIW6xPO9Yh1l8aWKWg9xYfg+w7/ogJz0ITSeoF3G0A4CzXP/ZJ4U1lOJwKGPdVCTO5maaAg7IHlDHcoLqNEqvHomCfpb8ZErjBDiavtbVIBhzdF5UUbz5h8CFGK1GOZ4gRYdGPl6fUmIlT4aLmnAFV/6ndyqBJi9mbEz9rrwXIE+0IA8zfEvi9cSP4e5Vmp8veAtWHxUiwSqvnl2XiwW+7ReqXlIAB2UW04tOa8KI4cJtfCepy61eOQlRl8KxePaY+S3JtwDKhYwe4TCaWLJFVF/fj9fhN4H9OAbd43pxM9MwpSOz+OCsp/sGz1/7BQZ2K5yjkDB3fpSUPw==;31:qk6haZjUDgpGEH78un2PZT9buErOxlla/oZI6Vey3Tl7atC6aq2oWhWTjroqXUXy18iWFh6bzveIfrnBG8UF2k+CwNu02RDG/5hlsL97PUxdCz5d6q5XO7/wvGbz78Y/24M/DypGFBRlOxjIPFdqf+vMNEnf/6Gq1BNlc3OOAH7PL5Ar8bxRl5kHlXptZz7nXJ9AYL5XI+BmF+VMQZEpX//YGhD08cPBGshV+bE5pg8=
X-MS-TrafficTypeDiagnostic: CY1PR21MB0007:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kewillf@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;CY1PR21MB0007;20:/1kth/8/clCSNsZcPq2O1VedN7d9+rbPHLfIzuDiMZ/7GJOyXzkfOpJ24Mr8WAcDBP5sX0a3FfF8xNkMT7nl/I+9m6oXWfJdojIf2e3PodM7Fc0EBfBCqZ0NEVEOr6EWep3vOtL5bA1xlDZw/+0HQQ/MRI2mVk5+ayHAbJLBTmcZOE5SV1rgfRbbvjaazOZ4IKErnV+KFGPAPY2oiX7CSqhpDPj+++F2CObQeRAHc7YbYU8yGLdfsLG7XiXADSHMhJhcR2ZRDdPeRZi1XLgtEVblE3rfLKa2jvZVoa2fAoS33Q1LFf0HKPXPi8JT3SvVkdBNqMoPXGbNWr4vecmVDEelNZXyVWTP0C4/7UNCGgHFhQviu+6dq3ckObC2h5lL/aHQZ3F0pkB2IK6/bgvIiNEwry5CVkEsQ9nq3VVa2xy33iaxoE92QtEjd4Zjwou1l5r0vrIqVjYw+/JMHOxHKwR8+uQnLBnp43Jdp1OWsK2Q2LQRWfGfvteVcfy+LQ21;4:y+J9PYXgBcE2abdZzFTPA9LqtJmf5T2/os3pCsOH11j1lbRWo0tr/O0yGXDc1fuWJRmESIQHn8uvX6uVNysCPxRni8NsITJT0k1L3UOm+4lCv7EK3XSm7i5hvgaOn31rKW2+NuNnduotC7Tq76hFp4MlY0HciUa/pZ5rvbfmXAkgkwmYP84PdebOcDHI4blPDXBuObWCtOfQWsrJttDH83ao/KiXp12f8dipoyifZukZmI43aKr6dJHJV9sk3hx1/52WqxNyevmq4zWtDyNLICBpFT+3lUWNbkoyCmgfgzs=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <CY1PR21MB0007490C8C844283ED8EF203B7970@CY1PR21MB0007.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(10201501046)(100000703101)(100105400095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(20161123564025)(20161123555025)(20161123558100)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY1PR21MB0007;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY1PR21MB0007;
X-Forefront-PRVS: 0422860ED4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(39860400002)(47760400005)(199003)(189002)(2361001)(2351001)(66066001)(48376002)(101416001)(4326008)(47776003)(110136004)(42186005)(478600001)(107886003)(50466002)(36756003)(10290500003)(105586002)(106356001)(53936002)(10090500001)(5660300001)(2906002)(25786009)(305945005)(189998001)(6666003)(1076002)(6486002)(33646002)(6916009)(5003940100001)(3846002)(6116002)(7736002)(81156014)(8676002)(68736007)(81166006)(97736004)(50226002)(8936002)(86362001)(5005710100001)(86612001)(8656003)(50986999);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR21MB0007;H:kewillf-01.northamerica.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR21MB0007;23:r2rwAxMBKbmvwfPXdBDETgQx4sbe0p6rbsi8iNqtQ?=
 =?us-ascii?Q?FRHhHnLtDxhcyvD+ZL6MKywbulu5TmEHJE7BANHtBwAp+9HOyCrMYxKFt3wc?=
 =?us-ascii?Q?VJXbe3CR330r1PAr2oZu4JFGZS4soZu4pjA5C3JqIBWASfoo0HlFFRIsAltm?=
 =?us-ascii?Q?g/8lkTt00oPrNwCkj5Ym8JXDhiaqSYkRHqqkie8w6D3Ga06I0SmS6mm3vrIo?=
 =?us-ascii?Q?Pqh8dEv7TUvjx26esMN8nx6xsEyXVXas/Ljv0q01x+9tQzvq8Iu8UyX9yhrT?=
 =?us-ascii?Q?EJ7hnZsdLAxh5Lh3nkEVZMX+SNAg4da+K5HknjkicjEMmEWVb01N73NlyI7o?=
 =?us-ascii?Q?Iq8eSrGSbk8LJfzseEe6AmsAahx/wJX9ofdO51CQYpULqYkJrCJ9XDoeoVK+?=
 =?us-ascii?Q?Ju9Oo++G2ODqtZuM1rsQOZgLGQD7Qvvg/kV99ozy1RIoWGtkEtFpZtq7LwIs?=
 =?us-ascii?Q?HJk57WCG4Bw1U/PAhBHNEAkW0HP9JGUgyB6TelwCFDkzWSg+GLlEQkQg/VRl?=
 =?us-ascii?Q?yzSLkseqnU/8rTePoB6cE9o6pwhzByfwWi8C5GQiwAPUAY46m2XS24OQJJ1F?=
 =?us-ascii?Q?/EjzdIBBSe61QfzGZoqBzZX1+U7KnoWEUqPd9ojgOwAuW1O1afCDB96QGVDT?=
 =?us-ascii?Q?06G5pX20OdbzBwMxqA4/OFQReKQcb7hQYBC1c7ipmcKKjhcpo0v5znTS7ag2?=
 =?us-ascii?Q?pnj0z+QS4POkwrTOJ1zwPW6jCB5wBSxjTg376h/wyHEQHd/CVIjCMaX9TO6f?=
 =?us-ascii?Q?28gJFQQH6wt/vhrp5Zpp+yxKprfYY7GB4wEYsWR4Ud1dlysYyKQ/nPJFmKBp?=
 =?us-ascii?Q?CPRzPXrqkdqRpweaKGItYd5fsh7vEm92KyRuX0JAVxtZ9kuovt0Cr3DuM8ld?=
 =?us-ascii?Q?6LlYNKee97YVMBwr5lPUpg5PpDcZh8w3OwIqbU2BdtMGQoHOf0rh6CrqHZDv?=
 =?us-ascii?Q?XYX0xQmO6t3qO60Xue5dXDz7SxJK/srJdnT5GyD0Rqw7w/OsZzRsTAgl5Rk0?=
 =?us-ascii?Q?+Q7yn1xJXUeiw0lLAgCdWJWlKerdmKEtPWthFEKypGoxF3gl1keuXbOAH0Hz?=
 =?us-ascii?Q?y2MA+mV2Jbe5cSAGAtZSFk3xW7dQRrYxNOo0pRIwxLUcRuQ/Y7ngt8RFLjds?=
 =?us-ascii?Q?bT5/hXLZKUutIL/aHjzjbu24eMj/ZeZtet81aWz2f79WX7cKCR3KtbBo+CEM?=
 =?us-ascii?Q?kP56lpJE+9jAXY=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR21MB0007;6:xWkttxms9V6DKz3q5uWwo/jFTlb6YiYeYeJcKugKZwRRwfBOTaxVgQ9tmEpoJZsF0BplhiqS66IDjiNjPMfnJLoVgg7pc+81+rGjDDfUfOl6fdHIFibdrFTYjDDxrxeWLKrx4353VPU+iKiQzyXOaK+U5XwQi0SyvD5pGhs+Z6edQgKBlAURIYNz8+4SDXCtDTPl5pOhJg8MNsOFjwNtzp4b+3iR860P/Dn73fj/9S13GiSqroi7Gc7dPXPw723s2uyYcXFr5scQDEeWmcqEc4dG1n+HvhNL02LrRVjndL4wAXn1ZlWxnpMSoduItYGAJtZEJ0N+Ao0feoW0Yma5ew==;5:geMaZeU/TY6kRclVkKXtnqhcmPa1J6Dy9sZuPtHe79fCHNqqulHCr9/1Cx36YuU2h6+zu2YHjsleDG9bAaeHaiUqNgBt7H/1S6Ti75y/Vm6924JQ+woxACwxv9wjDDTo5ctlDGNyhixFG6xmLn/+kQ==;24:ncZ08VJ8jrBtsAwrluSBzgWn6VMknUuCHLWKYgDBSytn6vJbBWQX4lUPxJ+FG3sFuFwWgwzbBmYbBzTmHSK6xqLUODlT63tadWK1PQ81YS8=;7:yY3eBNRmDe2l9BrWTRyTEM8apo+6l2n8BxObb5BAOcSyz/WLYHv2Kt84p5JnG90wPpq4QgJmVISsW2+4USPaSsCxfbf0Fil8P5eJrAlq0LYlq9V2yLi5LOVUcbxkqmqPeAy4pbFtaHJXCldxott8aM+HpzBhctet8dsUZwYnKvrPz4spdFoae/iY6zs3Wwc+WZzTsep+UQs/1ysD8l+184nbG5cYSAGJwYUX6M5qnLk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2017 22:29:10.8890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR21MB0007
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code was using two string_lists, one for the directories and
one for the files.  The code never checks the lists independently
so we should be able to only use one list.  The string_list also
is a O(log n) for lookup and insertion.  Switching this to use a
hashmap will give O(1) which will save some time when there are
millions of paths that will be checked.

Also cleaned up a memory leak and method where the return was not
being used.

Signed-off-by: Kevin Willford <kewillf@microsoft.com>
---
 merge-recursive.c | 76 ++++++++++++++++++++++++++++++++++++++++---------------
 merge-recursive.h |  3 +--
 2 files changed, 57 insertions(+), 22 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 1494ffdb82..ebfe01017f 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -24,6 +24,31 @@
 #include "dir.h"
 #include "submodule.h"
 
+struct path_hashmap_entry {
+	struct hashmap_entry;
+	char path[FLEX_ARRAY];
+};
+
+static int path_hashmap_cmp(const void *cmp_data,
+			    const void *entry,
+			    const void *entry_or_key,
+			    const void *keydata)
+{
+	const struct path_hashmap_entry *a = entry;
+	const struct path_hashmap_entry *b = entry_or_key;
+	const char *key = keydata;
+
+	if (ignore_case)
+		return strcasecmp(a->path, key ? key : b->path);
+	else
+		return strcmp(a->path, key ? key : b->path);
+}
+
+static unsigned int path_hash(const char *path)
+{
+	return ignore_case ? strihash(path) : strhash(path);
+}
+
 static void flush_output(struct merge_options *o)
 {
 	if (o->buffer_output < 2 && o->obuf.len) {
@@ -314,29 +339,25 @@ static int save_files_dirs(const unsigned char *sha1,
 		struct strbuf *base, const char *path,
 		unsigned int mode, int stage, void *context)
 {
+	struct path_hashmap_entry *entry;
 	int baselen = base->len;
 	struct merge_options *o = context;
 
 	strbuf_addstr(base, path);
 
-	if (S_ISDIR(mode))
-		string_list_insert(&o->current_directory_set, base->buf);
-	else
-		string_list_insert(&o->current_file_set, base->buf);
+	FLEX_ALLOC_MEM(entry, path, base->buf, base->len);
+	hashmap_entry_init(entry, path_hash(entry->path));
+	hashmap_add(&o->current_file_dir_set, entry);
 
 	strbuf_setlen(base, baselen);
 	return (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
 }
 
-static int get_files_dirs(struct merge_options *o, struct tree *tree)
+static void get_files_dirs(struct merge_options *o, struct tree *tree)
 {
-	int n;
 	struct pathspec match_all;
 	memset(&match_all, 0, sizeof(match_all));
-	if (read_tree_recursive(tree, "", 0, 0, &match_all, save_files_dirs, o))
-		return 0;
-	n = o->current_file_set.nr + o->current_directory_set.nr;
-	return n;
+	read_tree_recursive(tree, "", 0, 0, &match_all, save_files_dirs, o);
 }
 
 /*
@@ -646,6 +667,7 @@ static void add_flattened_path(struct strbuf *out, const char *s)
 
 static char *unique_path(struct merge_options *o, const char *path, const char *branch)
 {
+	struct path_hashmap_entry *entry;
 	struct strbuf newpath = STRBUF_INIT;
 	int suffix = 0;
 	size_t base_len;
@@ -654,14 +676,16 @@ static char *unique_path(struct merge_options *o, const char *path, const char *
 	add_flattened_path(&newpath, branch);
 
 	base_len = newpath.len;
-	while (string_list_has_string(&o->current_file_set, newpath.buf) ||
-	       string_list_has_string(&o->current_directory_set, newpath.buf) ||
+	while (hashmap_get_from_hash(&o->current_file_dir_set,
+				     path_hash(newpath.buf), newpath.buf) ||
 	       (!o->call_depth && file_exists(newpath.buf))) {
 		strbuf_setlen(&newpath, base_len);
 		strbuf_addf(&newpath, "_%d", suffix++);
 	}
 
-	string_list_insert(&o->current_file_set, newpath.buf);
+	FLEX_ALLOC_MEM(entry, path, newpath.buf, newpath.len);
+	hashmap_entry_init(entry, path_hash(entry->path));
+	hashmap_add(&o->current_file_dir_set, entry);
 	return strbuf_detach(&newpath, NULL);
 }
 
@@ -1945,8 +1969,14 @@ int merge_trees(struct merge_options *o,
 	if (unmerged_cache()) {
 		struct string_list *entries, *re_head, *re_merge;
 		int i;
-		string_list_clear(&o->current_file_set, 1);
-		string_list_clear(&o->current_directory_set, 1);
+		/*
+		 * Only need the hashmap while processing entries, so
+		 * initialize it here and free it when we are done running
+		 * through the entries. Keeping it in the merge_options as
+		 * opposed to decaring a local hashmap is for convenience
+		 * so that we don't have to pass it to around.
+		 */
+		hashmap_init(&o->current_file_dir_set, path_hashmap_cmp, NULL, 512);
 		get_files_dirs(o, head);
 		get_files_dirs(o, merge);
 
@@ -1956,7 +1986,7 @@ int merge_trees(struct merge_options *o,
 		re_merge = get_renames(o, merge, common, head, merge, entries);
 		clean = process_renames(o, re_head, re_merge);
 		if (clean < 0)
-			return clean;
+			goto cleanup;
 		for (i = entries->nr-1; 0 <= i; i--) {
 			const char *path = entries->items[i].string;
 			struct stage_data *e = entries->items[i].util;
@@ -1964,8 +1994,10 @@ int merge_trees(struct merge_options *o,
 				int ret = process_entry(o, path, e);
 				if (!ret)
 					clean = 0;
-				else if (ret < 0)
-					return ret;
+				else if (ret < 0) {
+					clean = ret;
+					goto cleanup;
+				}
 			}
 		}
 		for (i = 0; i < entries->nr; i++) {
@@ -1975,13 +2007,19 @@ int merge_trees(struct merge_options *o,
 				    entries->items[i].string);
 		}
 
+cleanup:
 		string_list_clear(re_merge, 0);
 		string_list_clear(re_head, 0);
 		string_list_clear(entries, 1);
 
+		hashmap_free(&o->current_file_dir_set, 1);
+
 		free(re_merge);
 		free(re_head);
 		free(entries);
+
+		if (clean < 0)
+			return clean;
 	}
 	else
 		clean = 1;
@@ -2177,8 +2215,6 @@ void init_merge_options(struct merge_options *o)
 	if (o->verbosity >= 5)
 		o->buffer_output = 0;
 	strbuf_init(&o->obuf, 0);
-	string_list_init(&o->current_file_set, 1);
-	string_list_init(&o->current_directory_set, 1);
 	string_list_init(&o->df_conflict_file_set, 1);
 }
 
diff --git a/merge-recursive.h b/merge-recursive.h
index 735343b413..80d69d1401 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -25,8 +25,7 @@ struct merge_options {
 	int show_rename_progress;
 	int call_depth;
 	struct strbuf obuf;
-	struct string_list current_file_set;
-	struct string_list current_directory_set;
+	struct hashmap current_file_dir_set;
 	struct string_list df_conflict_file_set;
 };
 
-- 
2.14.1.327.g2b87382360.dirty

