Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEE0C43334
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 13:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243166AbiFNNgl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 09:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbiFNNgj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 09:36:39 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FB61C125
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 06:36:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIFCNd9RR5p+1F3aOge5T73ppVdcpbzV1TYyjYrxG9GG/o4n9uSJ/BQM4rgscU3yLwMBWrGTdWcUeZJi7cwq5E4pfZhCF3NlG9vSlvY71pRlKfSBNF69IEVh0DxC+0861YnwCyqd3uwo0/gqAWP3eq+4N4A2mCqgapLUL+EFeha/HulJKYEMnDdsNht/ZXhwAh9IMxUFUM+Os9n4sn+EqP98Zo43zMvLtX7kIhnl7+GdmYH6Omht/m9EtQzvXn/ruQ48BoXbDsxNh8CWsslKQI99aNKz2GXvSD2OHfEIbtXeXAEYUOK/eypbb7skvHL5mbv0ikuD1F2QXupfU8A1MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFARtGjiplzS3iULxvn90pdXIzRaJgmZKshtJUVdGCg=;
 b=bgU3deMUO96N66LFGzfwQ5Y1t7R/YODGxu46iHKZ1jtMNEkErreG7RS/FxobTpAzCgATR+TntwMi9KpzfvfxqaZAoCVwCZqaOGthlb8v+oBwtKFcHYJ9KzUg7hKKGHIWoER15CClZ/vSdDVwtUvpBU8qBhwDVkyxutGiBi/l2cgNhGaesxMCZPzMq9eRxciCtIw9QvEIX8z9rFGqwA6gcKzE40VTxgum/Pdio00yvlO4zZUBAcKJo0sEkAKNMSWHQp2BNOHlkUCxC9eHCiyJqhg82sg2VtCfNYlrGsGhwgPi4Xpljkkgv78z5vIUILATajfgDk1vMdYVO0OBOub38A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=roku.com; dmarc=pass action=none header.from=roku.com;
 dkim=pass header.d=roku.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=roku.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFARtGjiplzS3iULxvn90pdXIzRaJgmZKshtJUVdGCg=;
 b=e8auKxTVdtyLdNUO6VBBAgHDtG6jVmpg9JdKPyGCxQMwBLmF8ycF6/i58xqDGU8A+FjO3O9mYtS4NRvXTyKGB89J2w8zdV/4UBDXnNZOpFTqHGRcmthhSI9FKI5pfZdVyYO1IYvCo5t4Inf8oKwDXpCsletOm6LdfJ4Th7NnaHvXn3LLCSrfGSZZzZz3JkWPp4oOYgrlbCswk+cqKqtsXxsTcxnRlL+rCBKEHFBm5GO7gYuZjRJ6OdUW8sLbk7SroyMhIw0u0Oatp/TTFYF3GfM6tMqZ1NUU1wxcj/klg3QDf+I32w8MrXF9aHQWatkxT0rpG6vTNoGey5qzSQdqxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=roku.com;
Received: from CO1PR01MB7225.prod.exchangelabs.com (2603:10b6:303:160::21) by
 BN0PR01MB6845.prod.exchangelabs.com (2603:10b6:408:14a::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.14; Tue, 14 Jun 2022 13:36:35 +0000
Received: from CO1PR01MB7225.prod.exchangelabs.com
 ([fe80::1062:158b:2993:5535]) by CO1PR01MB7225.prod.exchangelabs.com
 ([fe80::1062:158b:2993:5535%8]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 13:36:35 +0000
Message-ID: <77035a0f-c42e-5cb3-f422-03fe81093adb@roku.com>
Date:   Tue, 14 Jun 2022 14:36:28 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com
From:   Richard Oliver <roliver@roku.com>
Subject: [PATCH] mktree: learn about promised objects
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0465.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::20) To CO1PR01MB7225.prod.exchangelabs.com
 (2603:10b6:303:160::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73621f28-4860-4b54-bb95-08da4e0ae65f
X-MS-TrafficTypeDiagnostic: BN0PR01MB6845:EE_
X-Microsoft-Antispam-PRVS: <BN0PR01MB68452B8BCE08697A5F5C71A1CFAA9@BN0PR01MB6845.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lJ5/JAC0xbIrgcy6vPkyqFeT2+zw5XKNdzuTzfZgUhR/8GAJL/E1jVzBRe79wftM1CuKlydlcASVRPrvPDgv5G0aiuDwNQSdWxEBvUfmUkfDXeQU4IidTFEFhjdxawH/Ifc3izhRf+/mzq0LzevJyRTki5n2AtxLKLfMbvPoPB98vvszT6L4acwvZKVDkf1fRyGpvrShUH6iCvFKDCM5y4VCYA65OVmXRPvNkihOO81SU6utz6AN+Z7dLIC1Vhu6eA2wCqU719L0v671Vx33lnCs9/TwCyx9jBCyZi/7tSdWIg9PoXCKVbcsrh66k7FzLvEgogG93WhNCRFLQqSMNhrwMMYPkRsiKFzWYEoGmA+WjBiWUcx0BfJn/zNb4Kyd3MPaLgggqlRmu0gt1KjZOMWTDVGluLQS3nE8P2ZjzZfSThbr18KJbZnnjEan3UrpI7/6JttBCed+UIP8s35XjErs9xUzeuIBgzt2CDwiOmkTKp9gc2idEuaijC9OsAlHjAshNXtM4jmNJxf/ybwVBHMPSlMEL+FIwM4XaxDJxop8ySA5fuNs984t0tTkumyt8Ebj/2Lt0r/PrPLV+9rhxwPUs01zrn7SOSa+ZVJe1nieRLs1+LasTfnxYwpm9JU0KITeBojAY/PxygvY0pW+/yqSaGBbupHGtrOpCdgraBLtq41VDVvtSKAJZ7jPdC63jDmWFmRELmwnSpuy7AH43w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR01MB7225.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(4326008)(6916009)(8936002)(2616005)(86362001)(316002)(8676002)(66476007)(31696002)(38100700002)(186003)(6666004)(66946007)(26005)(6506007)(6512007)(31686004)(66556008)(6486002)(83380400001)(508600001)(2906002)(36756003)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFFYQVgyYnp0QWUyOWhpaUVaV2ZiNUROWjNQaWY0aUo2WHRxbjlSLzVTSksw?=
 =?utf-8?B?QjQ2ZzZtNG9NYm5KeEhveVZjNjRjekNEUlg4RHJwZExuZTgwcWdMdXQyMEYz?=
 =?utf-8?B?U0FJbnZWcUV4RWdTTzJxNXFuUVJzbnoySlFKS3p4Qmh1TW9zYlBrUmllUkE2?=
 =?utf-8?B?K2NScUl0QVlPRk1yUC93ODJVc3VRZmRsWkUzWkswODdzV2c2ZGpDZDZCTW8v?=
 =?utf-8?B?QjNuWUlCMmxORXltQ21CbTNPMmE2S29QbkNjcVFwaStnNGNtdFR1OVZvMTdj?=
 =?utf-8?B?Z1A1eWxYQVZ6YmdNVmZLTVJtdUU0SnBEZTIyeEw3VXZ3YjNhOXNDOWdkSTZm?=
 =?utf-8?B?NktGTjNWTENFTTErZDZVbnNYV0paOVBGTVI0eFhoUXlNaG9Zak0zelFydXhk?=
 =?utf-8?B?SlhUcEViWThub3M1QmU2VlNSUjE1RllMVE05RThxZW12RlBnVlBhWjV0bS9u?=
 =?utf-8?B?Rjl6ajh4a25YRkp5L1VKOGhmMnk4d2hLNWpMbWhIdVFhZU5Ed1RGeEh2RVpp?=
 =?utf-8?B?ZkVRL2E0UGRxQ3Ezd2JBaHU1K1RWTFl6bUhGSmFpOHZIVTQwWHc0T0ZCVjMv?=
 =?utf-8?B?YnhiaXVTd1hxbG1HNXZvR0xVWWs5NHpoVU9XbHlQVlJVL2dsaUNGRDd6bURx?=
 =?utf-8?B?cU5POGFOV1M0bWhpMEswWWIzNkx4NndPS1ViMlh2UUtFb3hMaEtoYXdJbFVj?=
 =?utf-8?B?YlkvY3JMNk1RaUdHRUV6RVVEYXpSSEFnUVRWTFV0NGtLUXdQclFjNGQ4ajY5?=
 =?utf-8?B?bkpDc0pyakI0UTVnNjFyWENyNmxJN2RuWE5tUWJYZmJjWmZDU3ljNC8xakF2?=
 =?utf-8?B?dGRNMDhxZ2lrVVd4UGh6bTdmNEF0MVJUaHhZT2I0V0s4b1YrSHRsUmQ1M1RT?=
 =?utf-8?B?TVQremNhT2tJT21qL2I2eHErSldyTG0zaGdwK01oNzI5WGpXdXdaMDBXMjVn?=
 =?utf-8?B?MlNjUlpiMSt4c0w0UW1yS1lJTy8rVlhhdHhBNlcybDN6UC9EOUZDWlA2OUNa?=
 =?utf-8?B?NFpqeW42QTY1VWZWSnlab0VhYUZhZXhmaFpzMng1SVNnT09Hd3ozakl3V1RY?=
 =?utf-8?B?TG85TDJCamdjcFhBVGxXTWxwY3lCMU1uVzhmZVRQZGMvcnJWeFhLNGtYMnk1?=
 =?utf-8?B?NzZoWnRlQ1B4MjdpRzYzR3pjYjlGMVMvcFVjb1Zzb0cyNzgycWF6VFZ4aXhH?=
 =?utf-8?B?YlBVUVlKVDN1d25zUS9oSTJqWGM3YjN6dWVSa0d0bXlCVG15Ny9XLy9OWlNE?=
 =?utf-8?B?UVlwWHZVRTNoTG1ralVSODJtOXdWdDRRbTBBb0UwdlZYa2JJc1BlbktCTHkx?=
 =?utf-8?B?cXlLUlZWc09hTGNnazZVbnROamJybDdCNVFSQ201a29wT1dJMDZRMTlFcVpl?=
 =?utf-8?B?dW9TUGJYTVhRZjdHbndzQmlXaGpCaWtBZWJYc09GdTVvQ3hCK3lCaklrejZJ?=
 =?utf-8?B?bStvQVRLYi9WRzlNQ2F5elduKzVEWVFhcEptYVNzNmdrUHFkc2xtYkNnVjJi?=
 =?utf-8?B?MlRLOTRDbFVzbm9ydS9SM2I4Ym94eGFkTTBlVGxqUFdkck9uWGx6MHpYRDdZ?=
 =?utf-8?B?RlZZamVoMjNtVlJnU0s5T2RmWnVtMlBFR3lnQjNXY2F1dDNmWGdDZTJTQWdr?=
 =?utf-8?B?TnBTdm1WTVNjUGljdWU1Ni95MXpyTzdwek4rTG5Ta2grUG9xc0xtSlAzdWNW?=
 =?utf-8?B?ekZKSzFyeHZWZTFZaTllcThKcDV6Zzd5UGtJMW1GTC9pdHhwVmhrTngwT1hK?=
 =?utf-8?B?NlNja1BXeW5kV1IwNzJKSDAxZ2FCa1g0R1U0dzJqVVpzYXViLzNSRUZhQWRR?=
 =?utf-8?B?dU11Y0V6UFZEWGhhc2ZSc003VFhlKzE1SjdDK3prVHdEbEsrZDNXYXBGbGcw?=
 =?utf-8?B?alczQUFmRzhLcVZ0aTF2TUd6dVFkRGYwd2YyOWdBdTdGb21HcFh5QTRyVzR0?=
 =?utf-8?B?MkpPYVAwWkg5MWZmd3J0dUJZVUNOR3BXMDlKNU1vQjZWeGZYUlFaS3liNXZO?=
 =?utf-8?B?RjlEbnRrQmt4aDAxZFBlOExRUWI5bjJwRzVjN2lVV2RpOUlnSE5pcWlMK01L?=
 =?utf-8?B?N05zRDVnMEc4NVRPRlhiUFJLWnY2R2x4ZHpoaFVzOE5DR285UEsrSDBoMXVM?=
 =?utf-8?B?QXJvSHZwUnkwMDUxeHZwb3ptNWsvemNaY2FTZUplb1MrbzNIRDdpUWdMNVIz?=
 =?utf-8?B?MHFCT1Nvekt0ek41RkFOa05xcklEcTREN2hTMGZHK1hwK3FRTjJZZkxYTTZQ?=
 =?utf-8?B?R24zeHlWdlVmQUo1THE0dmUwTkg2aElnVnRYT2xycUpYUkN1RzlGaGVSUTZa?=
 =?utf-8?B?dTJKaGlra003aUQ5eHRTRURWb3ZBZ1BBTjZNTlpqWGFrUGZHY2gvdz09?=
X-OriginatorOrg: roku.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73621f28-4860-4b54-bb95-08da4e0ae65f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR01MB7225.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 13:36:35.1768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00fc7e42-ad65-4c4c-ab54-848ba124a5b7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iQ+or6jZbBUNPFfMTcEKvzghhVnYgtGSZYMDf9ume1HDossZewNGJ9L/xrnKNnzj42xrGSRl66kUokV4la5oqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB6845
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Do not use oid_object_info() to determine object type in mktree_line()
as this can cause promised objects to be dynamically faulted-in one at a
time which has poor performance. Instead, use a combination of
oid_object_info_extended() (with OBJECT_INFO_SKIP_FETCH_OBJECT option),
and the newly introduced promisor_object_type() to determine object type
before defaulting to fetch from remote.

Signed-off-by: Richard Oliver <roliver@roku.com>
---
 builtin/mktree.c         | 19 ++++++++++++++--
 packfile.c               | 49 ++++++++++++++++++++++++++++------------
 packfile.h               |  6 +++++
 t/t0410-partial-clone.sh | 28 +++++++++++++++++++++++
 4 files changed, 86 insertions(+), 16 deletions(-)

diff --git a/builtin/mktree.c b/builtin/mktree.c
index 902edba6d2..a783767b28 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -8,6 +8,7 @@
 #include "tree.h"
 #include "parse-options.h"
 #include "object-store.h"
+#include "packfile.h"
 
 static struct treeent {
 	unsigned mode;
@@ -116,8 +117,22 @@ static void mktree_line(char *buf, int nul_term_line, int allow_missing)
 			path, ptr, type_name(mode_type));
 	}
 
-	/* Check the type of object identified by sha1 */
-	obj_type = oid_object_info(the_repository, &oid, NULL);
+	/* Check the type of object identified by oid without fetching objects */
+	struct object_info oi = OBJECT_INFO_INIT;
+	oi.typep = &obj_type;
+	if (oid_object_info_extended(the_repository, &oid, &oi,
+				     OBJECT_INFO_LOOKUP_REPLACE |
+				     OBJECT_INFO_SKIP_FETCH_OBJECT) < 0)
+		obj_type = -1;
+
+	/* Has the object been promised to us if we can't find it */
+	if (obj_type < 0)
+		obj_type = promisor_object_type(&oid);
+
+	/* Try to fetch the object from the remote */
+	if (obj_type < 0)
+		obj_type = oid_object_info(the_repository, &oid, NULL);
+
 	if (obj_type < 0) {
 		if (allow_missing) {
 			; /* no problem - missing objects are presumed to be of the right type */
diff --git a/packfile.c b/packfile.c
index 8e812a84a3..d27cb106c1 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2223,17 +2223,26 @@ int for_each_packed_object(each_packed_object_fn cb, void *data,
 	return r ? r : pack_errors;
 }
 
+static void map_put_type(kh_oid_pos_t *map,
+	const struct object_id *oid,
+	enum object_type type)
+{
+	int hash_ret;
+	khiter_t pos = kh_put_oid_pos(map, *oid, &hash_ret);
+	kh_value(map, pos) = type;
+}
+
 static int add_promisor_object(const struct object_id *oid,
 			       struct packed_git *pack,
 			       uint32_t pos,
-			       void *set_)
+			       void *map_)
 {
-	struct oidset *set = set_;
+	kh_oid_pos_t *map = map_;
 	struct object *obj = parse_object(the_repository, oid);
 	if (!obj)
 		return 1;
 
-	oidset_insert(set, oid);
+	map_put_type(map, oid, obj->type);
 
 	/*
 	 * If this is a tree, commit, or tag, the objects it refers
@@ -2250,34 +2259,46 @@ static int add_promisor_object(const struct object_id *oid,
 			 */
 			return 0;
 		while (tree_entry_gently(&desc, &entry))
-			oidset_insert(set, &entry.oid);
+			map_put_type(map,
+				     &entry.oid,
+				     object_type(entry.mode));
 		free_tree_buffer(tree);
 	} else if (obj->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *) obj;
 		struct commit_list *parents = commit->parents;
 
-		oidset_insert(set, get_commit_tree_oid(commit));
+		map_put_type(map, get_commit_tree_oid(commit), OBJ_TREE);
 		for (; parents; parents = parents->next)
-			oidset_insert(set, &parents->item->object.oid);
+			map_put_type(map,
+				     &parents->item->object.oid,
+				     OBJ_COMMIT);
 	} else if (obj->type == OBJ_TAG) {
 		struct tag *tag = (struct tag *) obj;
-		oidset_insert(set, get_tagged_oid(tag));
+		map_put_type(map, get_tagged_oid(tag), OBJ_COMMIT);
 	}
 	return 0;
 }
 
-int is_promisor_object(const struct object_id *oid)
+enum object_type promisor_object_type(const struct object_id *oid)
 {
-	static struct oidset promisor_objects;
-	static int promisor_objects_prepared;
+	static kh_oid_pos_t *promisor_objects;
 
-	if (!promisor_objects_prepared) {
+	if (!promisor_objects) {
+		promisor_objects = kh_init_oid_pos();
 		if (has_promisor_remote()) {
 			for_each_packed_object(add_promisor_object,
-					       &promisor_objects,
+					       promisor_objects,
 					       FOR_EACH_OBJECT_PROMISOR_ONLY);
 		}
-		promisor_objects_prepared = 1;
 	}
-	return oidset_contains(&promisor_objects, oid);
+	khiter_t pos = kh_get_oid_pos(promisor_objects, *oid);
+	if (pos < kh_end(promisor_objects))
+		return kh_value(promisor_objects, pos);
+	else
+		return OBJ_BAD;
+}
+
+int is_promisor_object(const struct object_id *oid)
+{
+	return (promisor_object_type(oid) > OBJ_BAD);
 }
diff --git a/packfile.h b/packfile.h
index a3f6723857..35d0b600d2 100644
--- a/packfile.h
+++ b/packfile.h
@@ -182,6 +182,12 @@ int has_pack_index(const unsigned char *sha1);
  */
 int is_promisor_object(const struct object_id *oid);
 
+/*
+ * Return the object type if the given object is in, or referred to
+ * by, a promisor packfile; OBJ_BAD otherwise.
+ */
+enum object_type promisor_object_type(const struct object_id *oid);
+
 /*
  * Expose a function for fuzz testing.
  *
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 1e864cf317..12bfb02187 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -660,6 +660,34 @@ test_expect_success 'lazy-fetch when accessing object not in the_repository' '
 	! grep "[?]$FILE_HASH" out
 '
 
+test_expect_success 'missing blob object promised by tree, passes mktree' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	echo foo >repo/foo &&
+	A=$(git -C repo hash-object foo) &&
+	git -C repo update-index --add --info-only foo &&
+	B=$(git -C repo write-tree --missing-ok) &&
+	printf "$B\n" | pack_as_from_promisor &&
+	delete_object repo "$B" &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialclone "arbitrary string" &&
+
+	printf "100644 blob $A\tbar" | git -C repo mktree
+'
+
+test_expect_success 'missing blob object, not promised, faulted-in by mktree' '
+	test_create_repo server &&
+	A=$(echo foo | git -C server hash-object --stdin -w) &&
+	test_commit -C server 1 &&
+	test_config -C server uploadpack.allowfilter 1 &&
+	test_config -C server uploadpack.allowanysha1inwant 1 &&
+
+	rm -rf repo &&
+	git clone --filter=blob:none "file://$(pwd)/server" repo &&
+	printf "100644 blob $A\tbar" | git -C repo mktree
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 

base-commit: 1e59178e3f65880188caedb965e70db5ceeb2d64
-- 
2.36.1.384.gcc60f6fd7d

