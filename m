Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EFE9208DB
	for <e@80x24.org>; Mon, 28 Aug 2017 20:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751298AbdH1U3q (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Aug 2017 16:29:46 -0400
Received: from mail-bl2nam02on0113.outbound.protection.outlook.com ([104.47.38.113]:56768
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751243AbdH1U3m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2017 16:29:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=v0IFoKtf87GE/XwU/GalKFNaD6mg+JLeJY3GdkOW2bA=;
 b=bK8wk99zeV/vcDQkoGdOroiDfRKrJuzm7muwmap3Z2kFvvMKBZFOuctcTAgTqsKrFs8pEGZXhdopW/6iLsjOGGkjGcYAoLvadobptdVfNDYWlvA/VddGb9EDJzS7/ck7BZEOgqzbXU3eie7/71Azznf+en77rf7BWzNq5wvoL3Y=
Received: from kewillf-01.northamerica.corp.microsoft.com (174.126.250.66) by
 DM2PR21MB0043.namprd21.prod.outlook.com (2a01:111:e400:50c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.13.0; Mon, 28 Aug
 2017 20:29:37 +0000
From:   Kevin Willford <kewillf@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Kevin Willford <kewillf@microsoft.com>
Subject: [PATCH 3/3] merge-recursive: change current file dir string_lists to hashmap
Date:   Mon, 28 Aug 2017 14:28:29 -0600
Message-Id: <20170828202829.3056-4-kewillf@microsoft.com>
X-Mailer: git-send-email 2.14.1.gvfs.1.1.g44deceb
In-Reply-To: <20170828202829.3056-1-kewillf@microsoft.com>
References: <20170828202829.3056-1-kewillf@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [174.126.250.66]
X-ClientProxiedBy: CY4PR15CA0014.namprd15.prod.outlook.com
 (2603:10b6:910:14::24) To DM2PR21MB0043.namprd21.prod.outlook.com
 (2a01:111:e400:50c4::21)
X-MS-Office365-Filtering-Correlation-Id: cb5581c4-f69d-4f66-6b83-08d4ee538132
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(48565401081)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:DM2PR21MB0043;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR21MB0043;3:D4+8pN+Fi9gbcUPwALoSuGeVNZAYisOSDhD+GHiUOjed3V6OLwsjSCoXpjTmeENLQtWUwhXpf/a1S6RUhPX73uP/gJQdGE2gz3TiAoXmE2A5RcW3DHuNdPejSYpKkIfuq6u/tkgR3CbSeDX4lkZ1zocoOHdjMJ9i9uksqGFOLQ+ODjI/srvCpCiUX+YZOXYrX36Lb1FifhOyKKyzCtTVF5EsKWX04cEoV7qFRDez1lELnof5M7cdMGtPFm8EndBs;25:7/J4EjrZNr0fcsFmAgKjcggJP+P6FB+OOxW4XAtk4VDll80eqUdQtKq9FV4cfvvi64MNBaY/6m4Ij9UNl8YtaoOvrpuY/uyfGgpOyWAqRK4xeUgw6DrKr5NJONJ2q1y5Vnu/WXORjzXWDkfzsQ7jYFWDA1pMkm4jVNPURDZgY6SYmxnziqvDTG6IFQKPjFeraUCIvlQMKth5bwQZm9UkefJvizV7tCAuuupiUG7Ij6CMp4uCzyX6ToopC1TgABXdaFKsR8c5RRxz4aBKtQX8iK4KHVGvUuZaye9ss9MMfavO2ALyKucxBILXuFwe1oUj1FcANDJ8N/L4ZPla00gB0w==;31:mdgQxzpc27gGQSBHD5zyA2HAzi4P494bflUZxrP44fSZKN2Ernrni8D/hU1+dLslQLAj56MBzusk/rhQUErOabgXISDYSG+iiIfWvIAavnmG7BcsEHualoICUUtjsF56XLkRqSOzUC5Cy7LMxFN0H+H0aJiq1wE5BILZZBBgq8ZY/A4Yj2qss8SmUi71UpXKRTSxrVGzT88/9DUsOrIqc1EED1EqHubztCFPvpiRD5g=
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PR21MB0043:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR21MB0043;20:BxHFlSgjKcXosbQ+JNiR+A5ogX+YYoZlrBg5lTl5Q0XWtk1XAjGEqhgys0N8UhnRjjtA1J33dx5hrghJk7JaYuwePRm50Xyt7meWPBEquJFUMCTuHkquv2cYKJiH6CiURiuOd2zcjLZdMYAZphb6aJRho4cErfVGZocmcmKRAZWvBisEVX6aVktBJb0TnmtrPci4qUH9hJUEcXuZdea70h1qCJovpxxmF7/BsrP+VlFOZKzJZGQOvq5jbE4ZWjMvMwd6zud+J4FNuvHS6eG4Ngf8OSLAhWIQchD6I7sgQn+EQZlH2dR0vTbAvI7HvDaje4mcEZmn1H7uKYFNmRugGi1oCqjV2ywV2nZYpug8BUW/NHn/ajTZQx81Dfnzc7yxKKqQLlXZBuMI8IivlkqQgeseX0835VtMPFhaAv/4XrWraPo2coo9+ZjAJoW8VvV4bl6EM4XTOaFvG0IVk4/W/jOKzJi/IHNO89dEwELU9xuE34pz+5nfOYKIuZ6KEoP8;4:1y7y8jGkQh8zaOOSCqMFWdiLYJM/d+PPdHNqKniSuh/MFVVA/40ey/ENXMKDlnBNvzWZslNJEpHZcfID+GPy0zol7B55ntlIqO4ITvuty+nzI7F7vpqZFqYp1GsxrA6b1t2wcc87vkhk/vayDs12pnJzLwVVIFvPG+vY+Il1/zP5dsROK5+St50Vu621N9L8piwm4mPHAEjuY9tUs7NMc7RS4Ek1/rN2+5MarbIOhIiFDF3hZR1+WuEp/dbO1/GyBIIFxBzXya3gf9EN3MVeSWgWY/gowoL6EtfgC6FoLs4=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <DM2PR21MB0043A0D3F963A74D77643B7DB79E0@DM2PR21MB0043.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(100000703101)(100105400095)(10201501046)(6055026)(6041248)(20161123555025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(20161123562025)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:DM2PR21MB0043;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:DM2PR21MB0043;
X-Forefront-PRVS: 0413C9F1ED
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(7370300001)(4630300001)(6009001)(39860400002)(47760400005)(189002)(199003)(36756003)(10090500001)(8656003)(68736007)(53936002)(101416001)(48376002)(50466002)(6486002)(5003940100001)(106356001)(33646002)(2351001)(5660300001)(10290500003)(42186005)(189998001)(105586002)(2906002)(2361001)(478600001)(5005710100001)(7350300001)(4326008)(47776003)(6666003)(66066001)(1076002)(110136004)(6916009)(107886003)(3846002)(6116002)(2950100002)(305945005)(25786009)(575784001)(76176999)(50986999)(8676002)(50226002)(86362001)(97736004)(7736002)(81156014)(81166006)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM2PR21MB0043;H:kewillf-01.northamerica.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kewillf@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR21MB0043;23:piOcllxefFskjayBuhgyrJLQNtB4KG/Njp77DMQcO?=
 =?us-ascii?Q?inD6g9SAbK5iDYhwbpOSxfOgLT1CwvrDUp5nA2IKO5u6zkDhdLGdYfu7EC8c?=
 =?us-ascii?Q?jOrxeNupYTqulLXtoiqlkQBd1a2A55Ecn+MPsn/howtGJF3aLqw+/c2zj4Vz?=
 =?us-ascii?Q?YXxtXyaxrQCAJTAEba/5+wU1T0mTIn3juC6NnuZj3/SUL71jNyPGL6jrplbP?=
 =?us-ascii?Q?WHaZDVYEgu/A3GqpenO4dF7Tiagl8BlmqE5ljL+C7Ylgu+DAiWpPCdmjTKrx?=
 =?us-ascii?Q?kE1zeWLfC8wCuAr0HllRtWkK3smlBSX5KQUUvxl1qJAO0KZ1m+CEyjgXextS?=
 =?us-ascii?Q?EiRyFQouT6wi/EW+hhoNAFjREB9htm06KPvckX+mbVW4SxW+nupbCAuhdcbX?=
 =?us-ascii?Q?giD6UBjr1/kQNj1IIWLztryROGGuulkcq74LRdI7GwQjHMQ6ggmu2/6y+hgK?=
 =?us-ascii?Q?ORDdUdOra3qqpMkpNS2MXhwzI7cgTd5Ip2BsNheyPsuaQMEMCRI9njgsaH3x?=
 =?us-ascii?Q?9mWEfahNCRzg2SdD5dF9IG/zMkz7sX464+YU0osNr2JZ6nptF1O2Ac6U4ZYs?=
 =?us-ascii?Q?/oxpNBEdv5dgSoxbgWin2sNKO88QZJ2rb38SaqSsvEdIT6cJsLR7jwSz/fzt?=
 =?us-ascii?Q?A6OpNkdT6C0YKZR5zh1XutMIZhR12lgDy7jZ7aK2+NPPgRneP2zEK8e/fGWO?=
 =?us-ascii?Q?VvGRy45rkGL8KOkXMwEM9hkoJQpM1D73ZpPqJkHH5jhgdW7FIXdUvbhHzHpU?=
 =?us-ascii?Q?syyW00EOXeU71K1dl5tFjjaB5UnlnKWElpUZekckBBzOyZt+QV+QoICh+Nc0?=
 =?us-ascii?Q?CcekgRyw6tzhw1RHQ3i+kKl/2w/f8KPiVqSmwfmalpWNyNmpOao0in6yPS96?=
 =?us-ascii?Q?Q+eET1Q9BUX831JhsqEEWsXOUx0nnQE4YBvfYhk2Do21e4qe+N4EK4chBjKL?=
 =?us-ascii?Q?0Epe737yphqQkrW0yYyaR+NZ/Xs2L9SP/cIB4rsoDxaP1ByHVip146xllnj9?=
 =?us-ascii?Q?qgZ83O4bdbrBcd6T1LNdXXak/J0CJc+xWHNRN7HRVTDZrMf1j9BmYP9EiN9A?=
 =?us-ascii?Q?LKtm0MRsMSQBwUQubWqTDxZK+mZ8prmL68rsyjT06q8qsZBXuAab0M9rSnCs?=
 =?us-ascii?Q?9s+lk05her+rhBQUs+DprBaXsnA6rRkeZh6uAddkX2chz3XD/Br2F8AVHkLf?=
 =?us-ascii?Q?dsbnsLFrbujzFeQ0mdpDZZhVBRDZGzHv8tikmbRybYRAJS8mh5+9YikxhbKG?=
 =?us-ascii?Q?gV6SJS3eO3H2IM9jw2Q1g6jNT6FydUZ/ThXlyMDGIDiSEdAXDGo6fJZl78Xj?=
 =?us-ascii?Q?tV5vQnSyUqcQ0Ig+05uEQJ7+fVkd36tuFAXur2hHF2x?=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR21MB0043;6:S8Kk3KB3KbWxNG44rghW0jYLUj1cGr6/oBSbhzLLZZ8piJSkKg7qTjRF0SJ22ViQxFbck2Gxz7Jrx6l7sYYpCOhnvjj0bKQ2mw+Jw4hk8k75nkhi7JhkDcpMpyDWYlvGtdjUYFuFTAxuSbvGTngcexs+LKuXKMdkqMXLU4Wkemsx8YniBiNLPXKQsrxiK5r95CE9CHW8BjAUk7X9ow/lxxhT3aA0WywZ1RtfqTcxt4/Hnx1l8ZMVzUUj8DH1X6yWwHtuhcHZEW0DppnJJXtNujftvoujBjiycaadazh4PvRIFCIqhB6RJ8FG+XuaAz2VHeirWKl2IhAJlMdzQCQX8Q==;5:rXby7KeRCn36wx+XO51jolgxtNLEpFys+qnAg6Kizb/+JIwYpd2/TXPnu9qge+EHa8nvtS8sS7IfADBSyiBJLNOoOOHPeOvk9xF7Yj99dMpoD/RCQe2u19LGE6YgIiOz278KdpqLSytTxkcmS0H+4w==;24:XWxN21vEA1NeLOkKbv41BZ3XRnwEO8jMn4jGsFqv2EhmVNIRXyZdnyAFVmDEHV7MhXitbv72tN/3CG7fWRhb73use3hhm7y4nY2SaOtXQls=;7:HRg4YFplTrVowzPlYYyaX0L1mR6Ij/5YmP5JOOVnrl/NFgmKZS9CGfBpJtiyJNB1hs8KbqUxi+0aHy90CQ8d9ybFKioG1+n3Nemlci8SQZlo9v+Uled8da7jqYVIf8SG9x1IgJTuApewea+FJWB7kP188INgZvp1jGYVYd5LfqbHKPwkrTMxkb4M0l9SMFmSmIenOuznlhFeiuRvyDOHFuhVUx8ys9qSd/H4ytGFxVM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2017 20:29:37.8812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR21MB0043
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
 merge-recursive.c | 48 +++++++++++++++++++++++++++++++++++++-----------
 merge-recursive.h |  3 +--
 2 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index d47f40ea81..ef4fe5f09f 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -24,6 +24,26 @@
 #include "dir.h"
 #include "submodule.h"
 
+struct path_hashmap_entry {
+	struct hashmap_entry;
+	char path[FLEX_ARRAY];
+};
+
+static unsigned int (*pathhash)(const char *path);
+static int (*pathcmp)(const char *a, const char *b);
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
+	return pathcmp(a->path, key ? key : b->path);
+}
+
 static void flush_output(struct merge_options *o)
 {
 	if (o->buffer_output < 2 && o->obuf.len) {
@@ -314,15 +334,15 @@ static int save_files_dirs(const unsigned char *sha1,
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
+	hashmap_entry_init(entry, pathhash(entry->path));
+	hashmap_add(&o->current_file_dir_set, entry);
 
 	strbuf_setlen(base, baselen);
 	return (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
@@ -642,6 +662,8 @@ static void add_flattened_path(struct strbuf *out, const char *s)
 
 static char *unique_path(struct merge_options *o, const char *path, const char *branch)
 {
+	struct path_hashmap_entry dummy;
+	struct path_hashmap_entry *entry;
 	struct strbuf newpath = STRBUF_INIT;
 	int suffix = 0;
 	size_t base_len;
@@ -650,14 +672,17 @@ static char *unique_path(struct merge_options *o, const char *path, const char *
 	add_flattened_path(&newpath, branch);
 
 	base_len = newpath.len;
-	while (string_list_has_string(&o->current_file_set, newpath.buf) ||
-	       string_list_has_string(&o->current_directory_set, newpath.buf) ||
+	hashmap_entry_init(&dummy, pathhash(newpath.buf));
+	while (hashmap_get(&o->current_file_dir_set, &dummy, newpath.buf) ||
 	       (!o->call_depth && file_exists(newpath.buf))) {
 		strbuf_setlen(&newpath, base_len);
 		strbuf_addf(&newpath, "_%d", suffix++);
+		hashmap_entry_init(&dummy, pathhash(newpath.buf));
 	}
 
-	string_list_insert(&o->current_file_set, newpath.buf);
+	FLEX_ALLOC_MEM(entry, path, newpath.buf, newpath.len);
+	hashmap_entry_init(entry, pathhash(entry->path));
+	hashmap_add(&o->current_file_dir_set, entry);
 	return strbuf_detach(&newpath, NULL);
 }
 
@@ -1941,8 +1966,7 @@ int merge_trees(struct merge_options *o,
 	if (unmerged_cache()) {
 		struct string_list *entries, *re_head, *re_merge;
 		int i;
-		string_list_clear(&o->current_file_set, 1);
-		string_list_clear(&o->current_directory_set, 1);
+		hashmap_init(&o->current_file_dir_set, path_hashmap_cmp, NULL, 512);
 		get_files_dirs(o, head);
 		get_files_dirs(o, merge);
 
@@ -1978,6 +2002,8 @@ int merge_trees(struct merge_options *o,
 		string_list_clear(re_head, 0);
 		string_list_clear(entries, 1);
 
+		hashmap_free(&o->current_file_dir_set, 1);
+
 		free(re_merge);
 		free(re_head);
 		free(entries);
@@ -2179,8 +2205,8 @@ void init_merge_options(struct merge_options *o)
 	if (o->verbosity >= 5)
 		o->buffer_output = 0;
 	strbuf_init(&o->obuf, 0);
-	string_list_init(&o->current_file_set, 1);
-	string_list_init(&o->current_directory_set, 1);
+	pathhash = ignore_case ? strihash : strhash;
+	pathcmp = ignore_case ? strcasecmp : strcmp;
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
2.14.1.329.g6edf0add19

