Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 061011F516
	for <e@80x24.org>; Fri, 29 Jun 2018 16:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966005AbeF2QMm (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 12:12:42 -0400
Received: from mail-cys01nam02on0130.outbound.protection.outlook.com ([104.47.37.130]:7270
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S936537AbeF2QMk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 12:12:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdD8ClZLA1Cv5BoH5y1OdCFMMOPK9PttB/znoX6zdOE=;
 b=bBqx5d45qwragXiOl1KyrzNiWRCB9/sMcj4KhebMZhGtf6NKGmlDCALExGei4NLsl51RbSQsg778c3B4vpc/ZDcQY+Loi4vqlkG198kTXWcdzztzYaWCQ2QO0Qbkcu55si+MTPcQIfqAw4XAgqhPHtQ63Ugy9VwSo1vxSJkTfsM=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0994.namprd21.prod.outlook.com (52.132.23.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.930.2; Fri, 29 Jun 2018 16:12:37 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05%2]) with mapi id 15.20.0930.012; Fri, 29 Jun 2018
 16:12:37 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [RFC PATCH 01/13] commit-reach: move walk methods from commit.c
Thread-Topic: [RFC PATCH 01/13] commit-reach: move walk methods from commit.c
Thread-Index: AQHUD8P+gbci1xKXIkquz8jY4m/DLw==
Date:   Fri, 29 Jun 2018 16:12:37 +0000
Message-ID: <20180629161223.229661-2-dstolee@microsoft.com>
References: <20180629161223.229661-1-dstolee@microsoft.com>
In-Reply-To: <20180629161223.229661-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN7PR06CA0026.namprd06.prod.outlook.com
 (2603:10b6:406:80::39) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0994;7:EEuiYboHMr6abOUC9DKR/SUviPkNMyjxXZp/pAXRLlZF9wUcW5/9BcawrMGFTSA68XyKtr/6I09c8fOTs2r2xHnLGRM+oqq5VDmnmy6g39gFl1hXmZnjCZ1jwvCWWXrRgPMI8Rg4kMQtoLZvmpOqtX+l97oTl3IUX2vJxnTYE/oLslRV5xPoEIzk1U3AEiTPS1OzXfcbdnhofT5uPMjzgmd10/1nwh/zHqhblEy5zYYU0zaWnl6/YOHQ14we1/S+
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7c9e117d-f561-4cb6-078b-08d5dddb214d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(48565401081)(5600033)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:BL0PR2101MB0994;
x-ms-traffictypediagnostic: BL0PR2101MB0994:
x-microsoft-antispam-prvs: <BL0PR2101MB0994C4CDA7884BF54DCC48BBA14E0@BL0PR2101MB0994.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(131327999870524);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231270)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0994;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0994;
x-forefront-prvs: 0718908305
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(396003)(366004)(136003)(189003)(199004)(6346003)(486006)(476003)(97736004)(46003)(107886003)(6506007)(386003)(186003)(446003)(86362001)(11346002)(86612001)(102836004)(6916009)(25786009)(6512007)(39060400002)(4326008)(2351001)(8936002)(1730700003)(14454004)(99286004)(81166006)(76176011)(81156014)(8676002)(5250100002)(14444005)(256004)(10290500003)(305945005)(7736002)(2501003)(53946003)(52116002)(478600001)(2616005)(53936002)(5660300001)(36756003)(54906003)(106356001)(105586002)(68736007)(1076002)(316002)(2906002)(6116002)(22452003)(10090500001)(6436002)(2900100001)(5640700003)(6486002)(217873001)(579004);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0994;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-message-info: 7oNXkA7iYG5sCGgYHprvtzFnB/BPXronrUxSP6nGOp/bLlz3Yy6UHuGIM0w0czZXAJ83bXsPNQHSN3pap2eZ/OS/yCz9u+Wj1pYpur8fvi1hB6TeNKJexyJZwi7U27TofJ8V0Y3sRqAGOAUc8ro9TjZ9Bktz2p9qO5uxEttNjddcgFnlii3l2orPOL0uFl+Sv1EhfMlP7yvgUPekzCDAUrfOUdLUFCT0N5soCRGJvnT6YzzUqE7Q0PnFxpmK3xJrLGQ6yS77EWxoJVZnajb4jm0KxJNZWUJOUqmeGxcJunEO5ASiFO6ToldCBJ6h3KcztWoEelGXwSOWN816vuKVsHGi9NOZ+LFTFO8cBTGo39o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c9e117d-f561-4cb6-078b-08d5dddb214d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2018 16:12:37.4309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0994
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Makefile       |   1 +
 commit-reach.c | 359 +++++++++++++++++++++++++++++++++++++++++++++++++
 commit-reach.h |  41 ++++++
 commit.c       | 358 ------------------------------------------------
 4 files changed, 401 insertions(+), 358 deletions(-)
 create mode 100644 commit-reach.c
 create mode 100644 commit-reach.h

diff --git a/Makefile b/Makefile
index 0cb6590f24..89ad873ce0 100644
--- a/Makefile
+++ b/Makefile
@@ -828,6 +828,7 @@ LIB_OBJS +=3D column.o
 LIB_OBJS +=3D combine-diff.o
 LIB_OBJS +=3D commit.o
 LIB_OBJS +=3D commit-graph.o
+LIB_OBJS +=3D commit-reach.o
 LIB_OBJS +=3D compat/obstack.o
 LIB_OBJS +=3D compat/terminal.o
 LIB_OBJS +=3D config.o
diff --git a/commit-reach.c b/commit-reach.c
new file mode 100644
index 0000000000..1438393165
--- /dev/null
+++ b/commit-reach.c
@@ -0,0 +1,359 @@
+#include "cache.h"
+#include "prio-queue.h"
+#include "commit-reach.h"
+
+/* Remember to update object flag allocation in object.h */
+#define PARENT1         (1u<<16)
+#define PARENT2         (1u<<17)
+#define STALE           (1u<<18)
+#define RESULT          (1u<<19)
+
+static const unsigned all_flags =3D (PARENT1 | PARENT2 | STALE | RESULT);
+
+static int queue_has_nonstale(struct prio_queue *queue)
+{
+	int i;
+	for (i =3D 0; i < queue->nr; i++) {
+		struct commit *commit =3D queue->array[i].data;
+		if (!(commit->object.flags & STALE))
+			return 1;
+	}
+	return 0;
+}
+
+/* all input commits in one and twos[] must have been parsed! */
+static struct commit_list *paint_down_to_common(struct commit *one, int n,
+						struct commit **twos,
+						int min_generation)
+{
+	struct prio_queue queue =3D { compare_commits_by_gen_then_commit_date };
+	struct commit_list *result =3D NULL;
+	int i;
+	uint32_t last_gen =3D GENERATION_NUMBER_INFINITY;
+
+	one->object.flags |=3D PARENT1;
+	if (!n) {
+		commit_list_append(one, &result);
+		return result;
+	}
+	prio_queue_put(&queue, one);
+
+	for (i =3D 0; i < n; i++) {
+		twos[i]->object.flags |=3D PARENT2;
+		prio_queue_put(&queue, twos[i]);
+	}
+
+	while (queue_has_nonstale(&queue)) {
+		struct commit *commit =3D prio_queue_get(&queue);
+		struct commit_list *parents;
+		int flags;
+
+		if (commit->generation > last_gen)
+			BUG("bad generation skip %8x > %8x at %s",
+			    commit->generation, last_gen,
+			    oid_to_hex(&commit->object.oid));
+		last_gen =3D commit->generation;
+
+		if (commit->generation < min_generation)
+			break;
+
+		flags =3D commit->object.flags & (PARENT1 | PARENT2 | STALE);
+		if (flags =3D=3D (PARENT1 | PARENT2)) {
+			if (!(commit->object.flags & RESULT)) {
+				commit->object.flags |=3D RESULT;
+				commit_list_insert_by_date(commit, &result);
+			}
+			/* Mark parents of a found merge stale */
+			flags |=3D STALE;
+		}
+		parents =3D commit->parents;
+		while (parents) {
+			struct commit *p =3D parents->item;
+			parents =3D parents->next;
+			if ((p->object.flags & flags) =3D=3D flags)
+				continue;
+			if (parse_commit(p))
+				return NULL;
+			p->object.flags |=3D flags;
+			prio_queue_put(&queue, p);
+		}
+	}
+
+	clear_prio_queue(&queue);
+	return result;
+}
+
+static struct commit_list *merge_bases_many(struct commit *one, int n, str=
uct commit **twos)
+{
+	struct commit_list *list =3D NULL;
+	struct commit_list *result =3D NULL;
+	int i;
+
+	for (i =3D 0; i < n; i++) {
+		if (one =3D=3D twos[i])
+			/*
+			 * We do not mark this even with RESULT so we do not
+			 * have to clean it up.
+			 */
+			return commit_list_insert(one, &result);
+	}
+
+	if (parse_commit(one))
+		return NULL;
+	for (i =3D 0; i < n; i++) {
+		if (parse_commit(twos[i]))
+			return NULL;
+	}
+
+	list =3D paint_down_to_common(one, n, twos, 0);
+
+	while (list) {
+		struct commit *commit =3D pop_commit(&list);
+		if (!(commit->object.flags & STALE))
+			commit_list_insert_by_date(commit, &result);
+	}
+	return result;
+}
+
+struct commit_list *get_octopus_merge_bases(struct commit_list *in)
+{
+	struct commit_list *i, *j, *k, *ret =3D NULL;
+
+	if (!in)
+		return ret;
+
+	commit_list_insert(in->item, &ret);
+
+	for (i =3D in->next; i; i =3D i->next) {
+		struct commit_list *new_commits =3D NULL, *end =3D NULL;
+
+		for (j =3D ret; j; j =3D j->next) {
+			struct commit_list *bases;
+			bases =3D get_merge_bases(i->item, j->item);
+			if (!new_commits)
+				new_commits =3D bases;
+			else
+				end->next =3D bases;
+			for (k =3D bases; k; k =3D k->next)
+				end =3D k;
+		}
+		ret =3D new_commits;
+	}
+	return ret;
+}
+
+static int remove_redundant(struct commit **array, int cnt)
+{
+	/*
+	 * Some commit in the array may be an ancestor of
+	 * another commit.  Move such commit to the end of
+	 * the array, and return the number of commits that
+	 * are independent from each other.
+	 */
+	struct commit **work;
+	unsigned char *redundant;
+	int *filled_index;
+	int i, j, filled;
+
+	work =3D xcalloc(cnt, sizeof(*work));
+	redundant =3D xcalloc(cnt, 1);
+	ALLOC_ARRAY(filled_index, cnt - 1);
+
+	for (i =3D 0; i < cnt; i++)
+		parse_commit(array[i]);
+	for (i =3D 0; i < cnt; i++) {
+		struct commit_list *common;
+		uint32_t min_generation =3D array[i]->generation;
+
+		if (redundant[i])
+			continue;
+		for (j =3D filled =3D 0; j < cnt; j++) {
+			if (i =3D=3D j || redundant[j])
+				continue;
+			filled_index[filled] =3D j;
+			work[filled++] =3D array[j];
+
+			if (array[j]->generation < min_generation)
+				min_generation =3D array[j]->generation;
+		}
+		common =3D paint_down_to_common(array[i], filled, work,
+					      min_generation);
+		if (array[i]->object.flags & PARENT2)
+			redundant[i] =3D 1;
+		for (j =3D 0; j < filled; j++)
+			if (work[j]->object.flags & PARENT1)
+				redundant[filled_index[j]] =3D 1;
+		clear_commit_marks(array[i], all_flags);
+		clear_commit_marks_many(filled, work, all_flags);
+		free_commit_list(common);
+	}
+
+	/* Now collect the result */
+	COPY_ARRAY(work, array, cnt);
+	for (i =3D filled =3D 0; i < cnt; i++)
+		if (!redundant[i])
+			array[filled++] =3D work[i];
+	for (j =3D filled, i =3D 0; i < cnt; i++)
+		if (redundant[i])
+			array[j++] =3D work[i];
+	free(work);
+	free(redundant);
+	free(filled_index);
+	return filled;
+}
+
+static struct commit_list *get_merge_bases_many_0(struct commit *one,
+						  int n,
+						  struct commit **twos,
+						  int cleanup)
+{
+	struct commit_list *list;
+	struct commit **rslt;
+	struct commit_list *result;
+	int cnt, i;
+
+	result =3D merge_bases_many(one, n, twos);
+	for (i =3D 0; i < n; i++) {
+		if (one =3D=3D twos[i])
+			return result;
+	}
+	if (!result || !result->next) {
+		if (cleanup) {
+			clear_commit_marks(one, all_flags);
+			clear_commit_marks_many(n, twos, all_flags);
+		}
+		return result;
+	}
+
+	/* There are more than one */
+	cnt =3D commit_list_count(result);
+	rslt =3D xcalloc(cnt, sizeof(*rslt));
+	for (list =3D result, i =3D 0; list; list =3D list->next)
+		rslt[i++] =3D list->item;
+	free_commit_list(result);
+
+	clear_commit_marks(one, all_flags);
+	clear_commit_marks_many(n, twos, all_flags);
+
+	cnt =3D remove_redundant(rslt, cnt);
+	result =3D NULL;
+	for (i =3D 0; i < cnt; i++)
+		commit_list_insert_by_date(rslt[i], &result);
+	free(rslt);
+	return result;
+}
+
+struct commit_list *get_merge_bases_many(struct commit *one,
+					 int n,
+					 struct commit **twos)
+{
+	return get_merge_bases_many_0(one, n, twos, 1);
+}
+
+struct commit_list *get_merge_bases_many_dirty(struct commit *one,
+					       int n,
+					       struct commit **twos)
+{
+	return get_merge_bases_many_0(one, n, twos, 0);
+}
+
+struct commit_list *get_merge_bases(struct commit *one, struct commit *two=
)
+{
+	return get_merge_bases_many_0(one, 1, &two, 1);
+}
+
+/*
+ * Is "commit" a descendant of one of the elements on the "with_commit" li=
st?
+ */
+int is_descendant_of(struct commit *commit, struct commit_list *with_commi=
t)
+{
+	if (!with_commit)
+		return 1;
+	while (with_commit) {
+		struct commit *other;
+
+		other =3D with_commit->item;
+		with_commit =3D with_commit->next;
+		if (in_merge_bases(other, commit))
+			return 1;
+	}
+	return 0;
+}
+
+/*
+ * Is "commit" an ancestor of one of the "references"?
+ */
+int in_merge_bases_many(struct commit *commit, int nr_reference, struct co=
mmit **reference)
+{
+	struct commit_list *bases;
+	int ret =3D 0, i;
+	uint32_t min_generation =3D GENERATION_NUMBER_INFINITY;
+
+	if (parse_commit(commit))
+		return ret;
+	for (i =3D 0; i < nr_reference; i++) {
+		if (parse_commit(reference[i]))
+			return ret;
+		if (reference[i]->generation < min_generation)
+			min_generation =3D reference[i]->generation;
+	}
+
+	if (commit->generation > min_generation)
+		return ret;
+
+	bases =3D paint_down_to_common(commit, nr_reference, reference, commit->g=
eneration);
+	if (commit->object.flags & PARENT2)
+		ret =3D 1;
+	clear_commit_marks(commit, all_flags);
+	clear_commit_marks_many(nr_reference, reference, all_flags);
+	free_commit_list(bases);
+	return ret;
+}
+
+/*
+ * Is "commit" an ancestor of (i.e. reachable from) the "reference"?
+ */
+int in_merge_bases(struct commit *commit, struct commit *reference)
+{
+	return in_merge_bases_many(commit, 1, &reference);
+}
+
+struct commit_list *reduce_heads(struct commit_list *heads)
+{
+	struct commit_list *p;
+	struct commit_list *result =3D NULL, **tail =3D &result;
+	struct commit **array;
+	int num_head, i;
+
+	if (!heads)
+		return NULL;
+
+	/* Uniquify */
+	for (p =3D heads; p; p =3D p->next)
+		p->item->object.flags &=3D ~STALE;
+	for (p =3D heads, num_head =3D 0; p; p =3D p->next) {
+		if (p->item->object.flags & STALE)
+			continue;
+		p->item->object.flags |=3D STALE;
+		num_head++;
+	}
+	array =3D xcalloc(num_head, sizeof(*array));
+	for (p =3D heads, i =3D 0; p; p =3D p->next) {
+		if (p->item->object.flags & STALE) {
+			array[i++] =3D p->item;
+			p->item->object.flags &=3D ~STALE;
+		}
+	}
+	num_head =3D remove_redundant(array, num_head);
+	for (i =3D 0; i < num_head; i++)
+		tail =3D &commit_list_insert(array[i], tail)->next;
+	free(array);
+	return result;
+}
+
+void reduce_heads_replace(struct commit_list **heads)
+{
+	struct commit_list *result =3D reduce_heads(*heads);
+	free_commit_list(*heads);
+	*heads =3D result;
+}
diff --git a/commit-reach.h b/commit-reach.h
new file mode 100644
index 0000000000..244f48c5f2
--- /dev/null
+++ b/commit-reach.h
@@ -0,0 +1,41 @@
+#ifndef __COMMIT_REACH_H__
+#define __COMMIT_REACH_H__
+
+#include "commit.h"
+
+struct commit_list *get_merge_bases_many(struct commit *one,
+					 int n,
+					 struct commit **twos);
+struct commit_list *get_merge_bases_many_dirty(struct commit *one,
+					       int n,
+					       struct commit **twos);
+struct commit_list *get_merge_bases(struct commit *one, struct commit *two=
);
+struct commit_list *get_octopus_merge_bases(struct commit_list *in);
+
+/* To be used only when object flags after this call no longer matter */
+struct commit_list *get_merge_bases_many_dirty(struct commit *one, int n, =
struct commit **twos);
+
+int is_descendant_of(struct commit *commit, struct commit_list *with_commi=
t);
+int in_merge_bases_many(struct commit *commit, int nr_reference, struct co=
mmit **reference);
+int in_merge_bases(struct commit *commit, struct commit *reference);
+
+
+/*
+ * Takes a list of commits and returns a new list where those
+ * have been removed that can be reached from other commits in
+ * the list. It is useful for, e.g., reducing the commits
+ * randomly thrown at the git-merge command and removing
+ * redundant commits that the user shouldn't have given to it.
+ *
+ * This function destroys the STALE bit of the commit objects'
+ * flags.
+ */
+struct commit_list *reduce_heads(struct commit_list *heads);
+
+/*
+ * Like `reduce_heads()`, except it replaces the list. Use this
+ * instead of `foo =3D reduce_heads(foo);` to avoid memory leaks.
+ */
+void reduce_heads_replace(struct commit_list **heads);
+
+#endif
diff --git a/commit.c b/commit.c
index 598cf21cee..d4ddaf4879 100644
--- a/commit.c
+++ b/commit.c
@@ -818,364 +818,6 @@ void sort_in_topological_order(struct commit_list **l=
ist, enum rev_sort_order so
 		clear_author_date_slab(&author_date);
 }
=20
-/* merge-base stuff */
-
-/* Remember to update object flag allocation in object.h */
-#define PARENT1		(1u<<16)
-#define PARENT2		(1u<<17)
-#define STALE		(1u<<18)
-#define RESULT		(1u<<19)
-
-static const unsigned all_flags =3D (PARENT1 | PARENT2 | STALE | RESULT);
-
-static int queue_has_nonstale(struct prio_queue *queue)
-{
-	int i;
-	for (i =3D 0; i < queue->nr; i++) {
-		struct commit *commit =3D queue->array[i].data;
-		if (!(commit->object.flags & STALE))
-			return 1;
-	}
-	return 0;
-}
-
-/* all input commits in one and twos[] must have been parsed! */
-static struct commit_list *paint_down_to_common(struct commit *one, int n,
-						struct commit **twos,
-						int min_generation)
-{
-	struct prio_queue queue =3D { compare_commits_by_gen_then_commit_date };
-	struct commit_list *result =3D NULL;
-	int i;
-	uint32_t last_gen =3D GENERATION_NUMBER_INFINITY;
-
-	one->object.flags |=3D PARENT1;
-	if (!n) {
-		commit_list_append(one, &result);
-		return result;
-	}
-	prio_queue_put(&queue, one);
-
-	for (i =3D 0; i < n; i++) {
-		twos[i]->object.flags |=3D PARENT2;
-		prio_queue_put(&queue, twos[i]);
-	}
-
-	while (queue_has_nonstale(&queue)) {
-		struct commit *commit =3D prio_queue_get(&queue);
-		struct commit_list *parents;
-		int flags;
-
-		if (commit->generation > last_gen)
-			BUG("bad generation skip %8x > %8x at %s",
-			    commit->generation, last_gen,
-			    oid_to_hex(&commit->object.oid));
-		last_gen =3D commit->generation;
-
-		if (commit->generation < min_generation)
-			break;
-
-		flags =3D commit->object.flags & (PARENT1 | PARENT2 | STALE);
-		if (flags =3D=3D (PARENT1 | PARENT2)) {
-			if (!(commit->object.flags & RESULT)) {
-				commit->object.flags |=3D RESULT;
-				commit_list_insert_by_date(commit, &result);
-			}
-			/* Mark parents of a found merge stale */
-			flags |=3D STALE;
-		}
-		parents =3D commit->parents;
-		while (parents) {
-			struct commit *p =3D parents->item;
-			parents =3D parents->next;
-			if ((p->object.flags & flags) =3D=3D flags)
-				continue;
-			if (parse_commit(p))
-				return NULL;
-			p->object.flags |=3D flags;
-			prio_queue_put(&queue, p);
-		}
-	}
-
-	clear_prio_queue(&queue);
-	return result;
-}
-
-static struct commit_list *merge_bases_many(struct commit *one, int n, str=
uct commit **twos)
-{
-	struct commit_list *list =3D NULL;
-	struct commit_list *result =3D NULL;
-	int i;
-
-	for (i =3D 0; i < n; i++) {
-		if (one =3D=3D twos[i])
-			/*
-			 * We do not mark this even with RESULT so we do not
-			 * have to clean it up.
-			 */
-			return commit_list_insert(one, &result);
-	}
-
-	if (parse_commit(one))
-		return NULL;
-	for (i =3D 0; i < n; i++) {
-		if (parse_commit(twos[i]))
-			return NULL;
-	}
-
-	list =3D paint_down_to_common(one, n, twos, 0);
-
-	while (list) {
-		struct commit *commit =3D pop_commit(&list);
-		if (!(commit->object.flags & STALE))
-			commit_list_insert_by_date(commit, &result);
-	}
-	return result;
-}
-
-struct commit_list *get_octopus_merge_bases(struct commit_list *in)
-{
-	struct commit_list *i, *j, *k, *ret =3D NULL;
-
-	if (!in)
-		return ret;
-
-	commit_list_insert(in->item, &ret);
-
-	for (i =3D in->next; i; i =3D i->next) {
-		struct commit_list *new_commits =3D NULL, *end =3D NULL;
-
-		for (j =3D ret; j; j =3D j->next) {
-			struct commit_list *bases;
-			bases =3D get_merge_bases(i->item, j->item);
-			if (!new_commits)
-				new_commits =3D bases;
-			else
-				end->next =3D bases;
-			for (k =3D bases; k; k =3D k->next)
-				end =3D k;
-		}
-		ret =3D new_commits;
-	}
-	return ret;
-}
-
-static int remove_redundant(struct commit **array, int cnt)
-{
-	/*
-	 * Some commit in the array may be an ancestor of
-	 * another commit.  Move such commit to the end of
-	 * the array, and return the number of commits that
-	 * are independent from each other.
-	 */
-	struct commit **work;
-	unsigned char *redundant;
-	int *filled_index;
-	int i, j, filled;
-
-	work =3D xcalloc(cnt, sizeof(*work));
-	redundant =3D xcalloc(cnt, 1);
-	ALLOC_ARRAY(filled_index, cnt - 1);
-
-	for (i =3D 0; i < cnt; i++)
-		parse_commit(array[i]);
-	for (i =3D 0; i < cnt; i++) {
-		struct commit_list *common;
-		uint32_t min_generation =3D array[i]->generation;
-
-		if (redundant[i])
-			continue;
-		for (j =3D filled =3D 0; j < cnt; j++) {
-			if (i =3D=3D j || redundant[j])
-				continue;
-			filled_index[filled] =3D j;
-			work[filled++] =3D array[j];
-
-			if (array[j]->generation < min_generation)
-				min_generation =3D array[j]->generation;
-		}
-		common =3D paint_down_to_common(array[i], filled, work,
-					      min_generation);
-		if (array[i]->object.flags & PARENT2)
-			redundant[i] =3D 1;
-		for (j =3D 0; j < filled; j++)
-			if (work[j]->object.flags & PARENT1)
-				redundant[filled_index[j]] =3D 1;
-		clear_commit_marks(array[i], all_flags);
-		clear_commit_marks_many(filled, work, all_flags);
-		free_commit_list(common);
-	}
-
-	/* Now collect the result */
-	COPY_ARRAY(work, array, cnt);
-	for (i =3D filled =3D 0; i < cnt; i++)
-		if (!redundant[i])
-			array[filled++] =3D work[i];
-	for (j =3D filled, i =3D 0; i < cnt; i++)
-		if (redundant[i])
-			array[j++] =3D work[i];
-	free(work);
-	free(redundant);
-	free(filled_index);
-	return filled;
-}
-
-static struct commit_list *get_merge_bases_many_0(struct commit *one,
-						  int n,
-						  struct commit **twos,
-						  int cleanup)
-{
-	struct commit_list *list;
-	struct commit **rslt;
-	struct commit_list *result;
-	int cnt, i;
-
-	result =3D merge_bases_many(one, n, twos);
-	for (i =3D 0; i < n; i++) {
-		if (one =3D=3D twos[i])
-			return result;
-	}
-	if (!result || !result->next) {
-		if (cleanup) {
-			clear_commit_marks(one, all_flags);
-			clear_commit_marks_many(n, twos, all_flags);
-		}
-		return result;
-	}
-
-	/* There are more than one */
-	cnt =3D commit_list_count(result);
-	rslt =3D xcalloc(cnt, sizeof(*rslt));
-	for (list =3D result, i =3D 0; list; list =3D list->next)
-		rslt[i++] =3D list->item;
-	free_commit_list(result);
-
-	clear_commit_marks(one, all_flags);
-	clear_commit_marks_many(n, twos, all_flags);
-
-	cnt =3D remove_redundant(rslt, cnt);
-	result =3D NULL;
-	for (i =3D 0; i < cnt; i++)
-		commit_list_insert_by_date(rslt[i], &result);
-	free(rslt);
-	return result;
-}
-
-struct commit_list *get_merge_bases_many(struct commit *one,
-					 int n,
-					 struct commit **twos)
-{
-	return get_merge_bases_many_0(one, n, twos, 1);
-}
-
-struct commit_list *get_merge_bases_many_dirty(struct commit *one,
-					       int n,
-					       struct commit **twos)
-{
-	return get_merge_bases_many_0(one, n, twos, 0);
-}
-
-struct commit_list *get_merge_bases(struct commit *one, struct commit *two=
)
-{
-	return get_merge_bases_many_0(one, 1, &two, 1);
-}
-
-/*
- * Is "commit" a descendant of one of the elements on the "with_commit" li=
st?
- */
-int is_descendant_of(struct commit *commit, struct commit_list *with_commi=
t)
-{
-	if (!with_commit)
-		return 1;
-	while (with_commit) {
-		struct commit *other;
-
-		other =3D with_commit->item;
-		with_commit =3D with_commit->next;
-		if (in_merge_bases(other, commit))
-			return 1;
-	}
-	return 0;
-}
-
-/*
- * Is "commit" an ancestor of one of the "references"?
- */
-int in_merge_bases_many(struct commit *commit, int nr_reference, struct co=
mmit **reference)
-{
-	struct commit_list *bases;
-	int ret =3D 0, i;
-	uint32_t min_generation =3D GENERATION_NUMBER_INFINITY;
-
-	if (parse_commit(commit))
-		return ret;
-	for (i =3D 0; i < nr_reference; i++) {
-		if (parse_commit(reference[i]))
-			return ret;
-		if (reference[i]->generation < min_generation)
-			min_generation =3D reference[i]->generation;
-	}
-
-	if (commit->generation > min_generation)
-		return ret;
-
-	bases =3D paint_down_to_common(commit, nr_reference, reference, commit->g=
eneration);
-	if (commit->object.flags & PARENT2)
-		ret =3D 1;
-	clear_commit_marks(commit, all_flags);
-	clear_commit_marks_many(nr_reference, reference, all_flags);
-	free_commit_list(bases);
-	return ret;
-}
-
-/*
- * Is "commit" an ancestor of (i.e. reachable from) the "reference"?
- */
-int in_merge_bases(struct commit *commit, struct commit *reference)
-{
-	return in_merge_bases_many(commit, 1, &reference);
-}
-
-struct commit_list *reduce_heads(struct commit_list *heads)
-{
-	struct commit_list *p;
-	struct commit_list *result =3D NULL, **tail =3D &result;
-	struct commit **array;
-	int num_head, i;
-
-	if (!heads)
-		return NULL;
-
-	/* Uniquify */
-	for (p =3D heads; p; p =3D p->next)
-		p->item->object.flags &=3D ~STALE;
-	for (p =3D heads, num_head =3D 0; p; p =3D p->next) {
-		if (p->item->object.flags & STALE)
-			continue;
-		p->item->object.flags |=3D STALE;
-		num_head++;
-	}
-	array =3D xcalloc(num_head, sizeof(*array));
-	for (p =3D heads, i =3D 0; p; p =3D p->next) {
-		if (p->item->object.flags & STALE) {
-			array[i++] =3D p->item;
-			p->item->object.flags &=3D ~STALE;
-		}
-	}
-	num_head =3D remove_redundant(array, num_head);
-	for (i =3D 0; i < num_head; i++)
-		tail =3D &commit_list_insert(array[i], tail)->next;
-	free(array);
-	return result;
-}
-
-void reduce_heads_replace(struct commit_list **heads)
-{
-	struct commit_list *result =3D reduce_heads(*heads);
-	free_commit_list(*heads);
-	*heads =3D result;
-}
-
 static const char gpg_sig_header[] =3D "gpgsig";
 static const int gpg_sig_header_len =3D sizeof(gpg_sig_header) - 1;
=20
--=20
2.18.0.118.gd4f65b8d14

