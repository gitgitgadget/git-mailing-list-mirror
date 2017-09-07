Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9902920286
	for <e@80x24.org>; Thu,  7 Sep 2017 16:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932357AbdIGQ0x (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 12:26:53 -0400
Received: from mail-cys01nam02on0097.outbound.protection.outlook.com ([104.47.37.97]:26976
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932261AbdIGQ0s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 12:26:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=17Dx07j5YcVuAyVUSV1/QRVKzytomLZH6/xz8uA0X4M=;
 b=nk5y1zmtoKeOuhQuc9d0FxLUiAUpztPdYDmfFjtZyuzYBmQaUIE5gcup/rJTwnM2kfFpA0Ndkvi47QkNJSgt0P4NkMjXNsS39R2Zu6xNwJ/d1hH+dSMwHh0kYR8x34O/YViPkTOGMrYSLPrrfwumOodaZTPOp5Q+3Q0Fgf73x0s=
Received: from kewillf-01.northamerica.corp.microsoft.com (174.126.250.66) by
 SN1PR21MB0016.namprd21.prod.outlook.com (10.161.254.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.56.6; Thu, 7 Sep 2017 16:26:44 +0000
From:   Kevin Willford <kewillf@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Kevin Willford <kewillf@microsoft.com>
Subject: [PATCH v3 3/3] merge-recursive: change current file dir string_lists to hashmap
Date:   Thu,  7 Sep 2017 10:25:56 -0600
Message-Id: <20170907162556.61384-4-kewillf@microsoft.com>
X-Mailer: git-send-email 2.14.1.329.gcdd497e120.dirty
In-Reply-To: <20170907162556.61384-1-kewillf@microsoft.com>
References: <20170907162556.61384-1-kewillf@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [174.126.250.66]
X-ClientProxiedBy: CY4PR08CA0069.namprd08.prod.outlook.com (10.171.251.162) To
 SN1PR21MB0016.namprd21.prod.outlook.com (10.161.254.139)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4369b0c-cdb0-4d37-8028-08d4f60d3b2e
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(48565401081)(300000503095)(300135400095)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:SN1PR21MB0016;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR21MB0016;3:o58xF6gxZKAnDXdnr+eGmk7AFv8FPcDUOpVuLLO56BRTk32kR7eVlkGshfF+t4lIQchZrnSlaWKDhfQrjFtolrfKDCSlG/Kx5lI0qa512BzZbD4nOO5NqbzYvaJEvC60SLbpjFMT+Wngwx7YXWWR1rZYSmK+OOy43oGgWzFsl1FaGH52pp48/Kwp6FeLpqXw/l1iYDf+3zBy9J+FzXgme2rTChhb4UqBnzBMUBJXzM8Pt/QdHEr3Neb8JKLy02yT;25:6reTwyLPkzpvuXsfFVDGqTy2ytb4PP6HyEHxERLIb/s+FK0pJnyiFXsWLFAfFNQ9mJzlgojIr7T/gJV80F2JXN58IsPKQXHNyOCRMvQBd6ndj+evqm40u50/I8RDumlSjsWceFWc9ytqYxTUI0i/BuEODMEXEyQjEb6Up60+eeGeRIj2ig9pkvCJanAbtpnWjGeOAONcMhdRSWlBfsVOFJBqpN823/rBuIAl8ywqW9vdZ3CnZlmBtahXRGfKDB3Wo+3HX0QKFmkKccel7BbQexfSkKDMG7a0PqQbv6+S07h6c5zSco/Rmkky4nRrwcdgKEc065dt9il5JhTAwY13fg==;31:Sd5ob+tRZzhrzAEK8aMr904dgNYwr22YDdGdG12NexHOoZdhqBxNA+cs6PN7IKN3D7Ef7s9nuzFdRD7Qr0eEljsL5Cq3EiRK6PXSqniAXrL52hyBiryNdTGNg3LqxcdG7aIuTFz0O6p8DRMy70vvLQDsY5ZefurNe7uAOQzFwo+XUyVf9VTRTsx/wAkCNpfGdfVRSeQH5/kTHdGiDk7Q4MRA/s2Wwr9GbRS8B4Htqwo=
X-MS-TrafficTypeDiagnostic: SN1PR21MB0016:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kewillf@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;SN1PR21MB0016;20:6buN5EHe4LhmE9KLbaoZjj36AknDKe1fWKulYhPJxjqfpl0XDgJeehdQvzD1Xk3I6BTzUK2yxCEhGiXaRdh/8sawqqfvtR6+Z7JdqpsXT9e9/8UutNjEae8e5Cxv3Etg5eIFWFPbeEy8ARt89wVRjA6WpB/OdNMeZPXTSJ7aJeBllxIKtfKX9vdnrYJPM4jR8ogvYnyVZJZ6rQm1o000Q+/d6whJOqc5RZ99vrx8TfZUB+5u0hVSYBu1+qt3At2igZ9lWWwP3gW53mc1Jq8qBsRHx1d/PjE8Nys7m5JlmsWlf5C3vwSboCWcZaHXIo6NzN1dTkBdp2EZyPKhkQwgXAsqRixyCW6nijBur1X9TdVcw3k6OU12aeT4m0U4s7k5yiAdm1A12Tz1vPDAqU4dthl8RpDBJF61XwChqXxRrOgzJEtFkFZbakhZvjl6hE/Ssutp8s6Po2kLo/RJs0kfJA1T7/49XR20u4qNqJ18FKVN/rGWNyp5hy7HdHs/PDvz;4:y6OCKKgo7E3LOuPSebLd8E+jpMOHwNgytLsYFM7LGffQj9w5+nD0dMd5EyE7jrZb637eZDLoWqjh8ouJH6JIENSWqJ+++BkHdEuo6GVMjOIZ9TKNZIlcrj2tVMJl3rnqG4piO/yr5B2VLj0B+aCZm4zLYxpA7wKh2dP21eaLGHzTi9xpadi2oDim81NnrluR5VtiZgkmNsE78H5c0Vb3+cAhZRb2rkXdkJOHSAdwnAoMrVplDzOvRK7iOlqLH3mN7qQaUBXShQfPE9PVWZNNzz3tY6Ca58t1MhZKPrrjStY=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <SN1PR21MB00169B9F77DA0021FC57DFEFB7940@SN1PR21MB0016.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(5005006)(8121501046)(10201501046)(3002001)(100000703101)(100105400095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041248)(20161123562025)(20161123564025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(20161123558100)(20161123555025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN1PR21MB0016;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN1PR21MB0016;
X-Forefront-PRVS: 04238CD941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(39860400002)(47760400005)(199003)(189002)(47776003)(305945005)(106356001)(53936002)(68736007)(189998001)(66066001)(2361001)(7736002)(2351001)(33646002)(97736004)(105586002)(5660300001)(42186005)(50466002)(478600001)(10290500003)(48376002)(5003940100001)(6486002)(1076002)(3846002)(25786009)(4326008)(6116002)(8656003)(8936002)(107886003)(5005710100001)(110136004)(50226002)(8676002)(10090500001)(81166006)(2906002)(6666003)(2950100002)(81156014)(76176999)(6916009)(50986999)(101416001)(86612001)(86362001)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR21MB0016;H:kewillf-01.northamerica.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR21MB0016;23:Y10gdJNlY8GCrN0k+jU7DWuHwm0QMrBGFhZJUyjPD?=
 =?us-ascii?Q?2C5XJ7UVTeMB5vqs+tdByo7cc+5DhU7BY1JEEsM4Y8i9VpVRAMiV0cEsewD8?=
 =?us-ascii?Q?s1AsJ9OYd5Rig24/qzFvTLlhu6z6HNWukifFTQVA//MvcK1/rX0BbdmPBaFs?=
 =?us-ascii?Q?fdD/KYIoID8SUQnURUZjIEIw0breXle9vliv5rjC1nmsaHCaLmxYit2smE5h?=
 =?us-ascii?Q?X+eQu+ALo2Qq5fIUUzH5NxplPxWBciIA9XIFV5dDdcukpIzNL9DamKhcLpcz?=
 =?us-ascii?Q?nsWV5MS5X4mFvpEeaxi1wBbpm3Cn2gxqVKba1aanMaFaWJtIlnttAE8G3luq?=
 =?us-ascii?Q?h6uXKyuAB7Lq72PJ8FeVM4NBM23s9SkiBvGebO6RjbsAd3ofZXCFo0zD0AYz?=
 =?us-ascii?Q?2A0Y4ntVG3hAa2xeJXgIpcS3qe8UDo+0kTvKVZ52xYIHcZ6ct1dxqplDi702?=
 =?us-ascii?Q?uRlLK5HNM0s36zCNJIFO1TaNOWWf9NGW+WliufjGzivGNaDzTnYftoQS6RSg?=
 =?us-ascii?Q?ukTIVbLT6rWj0fy6ELYh9Th5H9/riR+8C938t/DbewVR0Z+R1xHmtp3UbRXu?=
 =?us-ascii?Q?wB8xbVrAFVK5GxyWyyOXgosb3ibIPDnb9xBRV7nmoklUSG1XvrPywtM0lXUZ?=
 =?us-ascii?Q?gOjMO7YaGJ2fHnZGXxGX/05GBAK5k7b6fFg6ADR+u1RMmQyQllbKVHCaAMEm?=
 =?us-ascii?Q?P5cXJRO1TB1O+DttI+ZX+8BCwV1RFMqi9vPP0CbK69a6dGPbU2ADA2R67UZi?=
 =?us-ascii?Q?cYiaPuWicSR3fUdtATE46OoEwHtgll7u2/gON5x5nh3tWxeUXJGmAMALnkmC?=
 =?us-ascii?Q?0MXGSBaaWOoVUCTXM4WMi+puZXK7rMTSMLd/K8ftJDARTtAS8KbuGjzfE8Dk?=
 =?us-ascii?Q?cbGeYQLNy1ln6C8Bz7obrdFyCTwqODrGuytnJ/kKRakGfTADg5rTjYlzb4TA?=
 =?us-ascii?Q?SKGZyanJL4JIWJ7CLviXOvUjpHfQzh92FoXNpcapGrxGHDNvdLcnniY3meY8?=
 =?us-ascii?Q?FKRO8mMzfwNv7EzDP4pI69/PkMvgmOe3Z5S+bftqdbc7a/PheSDTiafNnG/5?=
 =?us-ascii?Q?FxF20UCYeK//FXWJlOx/e+bfMLL/d1nXSqUQ16mxs+dqnzVnqESsQldkKEfW?=
 =?us-ascii?Q?IBQFCG9iF0WhjCGDnDmI5WN6syCvwJlRwE9ZkvVKIUFXcSv+JDain/3S/Lue?=
 =?us-ascii?Q?Aifmbx23s+6y+Zs3nxFCwfDyHkan0z1d4UjQFbUbpzJgDaN1hWKdqUayh7lZ?=
 =?us-ascii?Q?5JOizsFmB1M89xHkyA=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR21MB0016;6:5qx7vGJY+acZsiqDtPXxn1dEUpX/3bEEW/fRDtGw3PEF8XW+hIMW2a7uPM9HmSg0caf59N9tZVorIBDUjaRD6LGfTqoY+YS25jghSkwsRI68SSDA4wQl00DypraNFQdmox3mttb2R/TEYrzrpfO0D2zjSyxsXabJ4g9m0xrsKX1dOYwid9lO/YhubojH6Mc9+q2OYELRNW599KQnziSC/wxXZ5aumi/eA8hiXT2E7NEPhXkdYS4wvWUwfkjITIo+o0VOeHbC2L8OGsP7hKYaeGiq/9YqTAug/l3FAGTQb3p2AMhJ1tzXXWEsyBAtv8bfJpVE+d+3pQ3h3jEvT8YDvw==;5:dEtwAryf9/ASg8XniHw0zBXs3+or4IxMbyjW03YdmYNe0ZbQt84pvfzmYPZJSLCICTAPMDgCRqKeCYX+LffbljrLazmncAF4qaPSHFeTYdMJyQC+KCOaDStyo+D6OLhpjJD2IhscCgurFrBCvC8pBA==;24:uqajlQIyeVbakPSDZevMRocAWUhwG7WEWbTlOXWyrsm8zvUzKJzY5hMFUH3Pa1V1y68yCxNlywXnh31X1ooEIAjPwSCDUAa8qeyclvbjAYE=;7:hrdNnx/jA4awp3Wf6vUo8DhFJS5NrRfKWVVAdcsK4ztSYRlUlni343Ps2krB5ksV0IjEfG0Eaa/4bxr7RUuliOq3FPVSfVGLXYPTLl11sQETjab384wdMCTQUZnwNPw/HM0spdDkS6rlz9z/ExqplByJ/sUzt7aw5TN0ycnkFV+LRQne2pD9C7/POWBDVYV9djyz6Kqrb/+7f2V7/5hQpD2+SyRhq6DUJAzloVZkm8c=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2017 16:26:44.9149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR21MB0016
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

Signed-off-by: Kevin Willford <kewillf@microsoft.com>
---
 merge-recursive.c | 56 ++++++++++++++++++++++++++++++++++++++++++++-----------
 merge-recursive.h |  3 +--
 2 files changed, 46 insertions(+), 13 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index d47f40ea81..35af3761ba 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -24,6 +24,31 @@
 #include "dir.h"
 #include "submodule.h"
 
+struct path_hashmap_entry {
+	struct hashmap_entry e;
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
@@ -314,15 +339,15 @@ static int save_files_dirs(const unsigned char *sha1,
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
@@ -642,6 +667,7 @@ static void add_flattened_path(struct strbuf *out, const char *s)
 
 static char *unique_path(struct merge_options *o, const char *path, const char *branch)
 {
+	struct path_hashmap_entry *entry;
 	struct strbuf newpath = STRBUF_INIT;
 	int suffix = 0;
 	size_t base_len;
@@ -650,14 +676,16 @@ static char *unique_path(struct merge_options *o, const char *path, const char *
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
 
@@ -1941,8 +1969,14 @@ int merge_trees(struct merge_options *o,
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
 
@@ -1978,6 +2012,8 @@ int merge_trees(struct merge_options *o,
 		string_list_clear(re_head, 0);
 		string_list_clear(entries, 1);
 
+		hashmap_free(&o->current_file_dir_set, 1);
+
 		free(re_merge);
 		free(re_head);
 		free(entries);
@@ -2179,8 +2215,6 @@ void init_merge_options(struct merge_options *o)
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
2.14.1.329.gcdd497e120.dirty

