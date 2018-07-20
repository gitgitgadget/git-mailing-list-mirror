Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 125F01F597
	for <e@80x24.org>; Fri, 20 Jul 2018 16:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388089AbeGTRWq (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 13:22:46 -0400
Received: from mail-sn1nam02on0124.outbound.protection.outlook.com ([104.47.36.124]:17920
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387858AbeGTRWp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 13:22:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/45HQNeN9lL89/QrDguuBavu7nt8Nvs3cNr4qSDIII=;
 b=R0N+duHYhD7qVI0ugSKymBWaVi6VLA14+9q3ilakllYUA0EazXlO4lL5906v9/wPf2gUpfnnDXx3K6EvgU6DwiqXSee7wzdYxXKzgOLuko7j53Vs7zz0Zew+Dy+R90BpJDZ9ni1Tjag+lC8Jg73Q4FC87SaU4Auh3Nsr0xa1jLQ=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0929.namprd21.prod.outlook.com (52.132.20.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.1; Fri, 20 Jul 2018 16:33:30 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05%2]) with mapi id 15.20.0995.008; Fri, 20 Jul 2018
 16:33:30 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "sbeller@google.com" <sbeller@google.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 18/18] commit-reach: use can_all_from_reach
Thread-Topic: [PATCH v2 18/18] commit-reach: use can_all_from_reach
Thread-Index: AQHUIEdkCcQNOzHhf0KVpLHDhhLxCg==
Date:   Fri, 20 Jul 2018 16:33:30 +0000
Message-ID: <20180720163227.105950-19-dstolee@microsoft.com>
References: <pull.10.git.gitgitgadget@gmail.com>
 <20180720163227.105950-1-dstolee@microsoft.com>
In-Reply-To: <20180720163227.105950-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR02CA0084.namprd02.prod.outlook.com
 (2603:10b6:405:60::25) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0929;6:1ybRldO65Trbnvy+o27uLSCI/a54UiHL4vMWet890lelHuT4Rmyh+2vX3ZFZwABNgZoBcaoevxySEL3z/a0RsI44rtyvWDO88Qn/vrAuLPJSUDzT/TYYBXZrLLQEwmHhL4PjBSvcLv8QlUY+D+CFIYeGak5Zxk+iZzOdfLdHTQBT4G9k2+RA6/dHiQOZ5gXhRLIsuh7P14on38RKLErep0jr/1rsQEwDiB/o8Cg6xJuBwPwF5RSJrndj11zgzao0GqHFU/R/hNnFtfVRjy0QJjQZ7CNK6RqYWcBUPnzpA5OIiMVdB+jwX4ZNiaXjihTPfUHS+9ihOXKwpZy2IMFKuhUeIZ2ZWWp27tT1QD+09NtJtDF+sgbOyWDwRi/XUpzaqxx//eXZGMilcaF2UPmdeaiXgHWEcmsnh4PU074TjDiQKvujXw+9t5WvHsWKRieIPtfsW9rY16wMIGpVFLb0/Q==;5:LbnHhlHxUAO5rBFcf6b2TYbCVZ04B8V62CLSibx1yU54rqcBOVEEUrPLNgQrXMrqE806ml3z9B8EzyH9YaJjj4aE4Qz4wcmD0IDAYeGZVsJ0F3n+mt+9JEKG6OjP2qRrJh9UYiOrBuPxzsIzkWPV1L5n5uvDE5WVTaZf/VoiOjk=;7:PKUqH86XC9bxX+JWa3GXnSxTt02CSc6IHARnYkYL9naPEK3ZTvZi96ivvQIU8BriNGsn6wNRvj1KNyFcKdG8P/YgyLqt3hx81afr8gggwxx8XuOCnHwr+ArShdyORnXcN6rwn8Trw64YU8t5hNsEVOldg2hwGu5hNyrxNiXhEQOnZbDgCY4G/J39Nvn7wM4a5RVS+ldzGJ7LI/Rec3NOZUIHS5uEipmzzSwppudOwIlkLzPv11+xN+6Wm01W7pvS
x-ms-office365-filtering-correlation-id: 488238b2-0625-4bd4-4b2a-08d5ee5e86d3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:BL0PR2101MB0929;
x-ms-traffictypediagnostic: BL0PR2101MB0929:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB09297CF6959E65AE09BB5124A1510@BL0PR2101MB0929.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0929;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0929;
x-forefront-prvs: 073966E86B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(1496009)(346002)(366004)(136003)(396003)(376002)(39860400002)(189003)(199004)(6512007)(305945005)(7736002)(14454004)(5640700003)(6116002)(6436002)(105586002)(54906003)(53936002)(25786009)(52116002)(76176011)(106356001)(2501003)(446003)(46003)(478600001)(68736007)(11346002)(6506007)(2900100001)(2906002)(5250100002)(386003)(186003)(102836004)(2351001)(10090500001)(97736004)(6916009)(8676002)(107886003)(8936002)(1730700003)(81156014)(6486002)(4326008)(486006)(81166006)(10290500003)(39060400002)(5660300001)(86362001)(575784001)(22452003)(1076002)(14444005)(316002)(2616005)(36756003)(256004)(476003)(86612001)(99286004)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0929;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8ITKdFTXuhIeBMA1wIaA8u5JCtwjC6hKELRdvOu6HJft3labZVkEUd7sfdrds+jadIpgjdgYk/GXFJcWElYKjj7eMqyYVV5fUDOCFcF+HGlAPJV8vHkWbuzAmGALkWp/dsyz0vJ9i+4dvGL8gj8TJXG/6BhQ8pdEKGYiBTMOBtjcSRUQ3Tm+Ks5n3QlFjFZRyw0UxIuaYCIBFH+mOq7x7PjIB9/MBrZW8pLCsnAi3hUxDtSPVH9DDt7q1YnqVTmgwSzX8TPjYUEqpATn1Rpan/1+01tiMQovqAYe2mbOvu3pP9DHZ75ljiX5D7BJFS5JdKGtJOmBSWFD5WwgbiLZLzY1hYeGH4q+95yeG/NJvr8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 488238b2-0625-4bd4-4b2a-08d5ee5e86d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2018 16:33:30.4167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0929
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The is_descendant_of method previously used in_merge_bases() to check if
the commit can reach any of the commits in the provided list. This had
two performance problems:

1. The performance is quadratic in worst-case.

2. A single in_merge_bases() call requires walking beyond the target
   commit in order to find the full set of boundary commits that may be
   merge-bases.

The can_all_from_reach method avoids this quadratic behavior and can
limit the search beyond the target commits using generation numbers. It
requires a small prototype adjustment to stop using commit-date as a
cutoff, as that optimization is no longer appropriate here.

Since in_merge_bases() uses paint_down_to_common(), is_descendant_of()
naturally found cutoffs to avoid walking the entire commit graph. Since
we want to always return the correct result, we cannot use the
min_commit_date cutoff in can_all_from_reach. We then rely on generation
numbers to provide the cutoff.

Since not all repos will have a commit-graph file, nor will we always
have generation numbers computed for a commit-graph file, create a new
method, generation_numbers_enabled(), that checks for a commit-graph
file and sees if the first commit in the file has a non-zero generation
number. In the case that we do not have generation numbers, use the old
logic for is_descendant_of().

Performance was meausured on a copy of the Linux repository using the
'test-tool reach is_descendant_of' command using this input:

A:v4.9
X:v4.10
X:v4.11
X:v4.12
X:v4.13
X:v4.14
X:v4.15
X:v4.16
X:v4.17
X.v3.0

Note that this input is tailored to demonstrate the quadratic nature of
the previous method, as it will compute merge-bases for v4.9 versus all
of the later versions before checking against v4.1.

Before: 0.26 s
 After: 0.21 s

Since we previously used the is_descendant_of method in the ref_newer
method, we also measured performance there using
'test-tool reach ref_newer' with this input:

A:v4.9
B:v3.19

Before: 0.10 s
 After: 0.08 s

By adding a new commit with parent v3.19, we test the non-reachable case
of ref_newer:

Before: 0.09 s
 After: 0.08 s

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 18 ++++++++++++++++++
 commit-graph.h |  6 ++++++
 commit-reach.c | 24 +++++++++++++++++-------
 3 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index b0a55ad128..e9786fa864 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -233,6 +233,24 @@ static int prepare_commit_graph(struct repository *r)
 	return !!r->objects->commit_graph;
 }
=20
+int generation_numbers_enabled(struct repository *r)
+{
+	uint32_t first_generation;
+	struct commit_graph *g;
+	if (!prepare_commit_graph(r))
+	       return 0;
+
+	g =3D r->objects->commit_graph;
+
+	if (!g->num_commits)
+		return 0;
+
+	first_generation =3D get_be32(g->chunk_commit_data +
+				    g->hash_len + 8) >> 2;
+
+	return !!first_generation;
+}
+
 static void close_commit_graph(void)
 {
 	free_commit_graph(the_repository->objects->commit_graph);
diff --git a/commit-graph.h b/commit-graph.h
index 76e098934a..0de8f88316 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -51,6 +51,12 @@ struct commit_graph {
=20
 struct commit_graph *load_commit_graph_one(const char *graph_file);
=20
+/*
+ * Return 1 if and only if the repository has a commit-graph
+ * file and generation numbers are computed in that file.
+ */
+int generation_numbers_enabled(struct repository *r);
+
 void write_commit_graph_reachable(const char *obj_dir, int append);
 void write_commit_graph(const char *obj_dir,
 			struct string_list *pack_indexes,
diff --git a/commit-reach.c b/commit-reach.c
index bc522d6840..c996524032 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -277,15 +277,25 @@ int is_descendant_of(struct commit *commit, struct co=
mmit_list *with_commit)
 {
 	if (!with_commit)
 		return 1;
-	while (with_commit) {
-		struct commit *other;
=20
-		other =3D with_commit->item;
-		with_commit =3D with_commit->next;
-		if (in_merge_bases(other, commit))
-			return 1;
+	if (generation_numbers_enabled(the_repository)) {
+		struct commit_list *from_list =3D NULL;
+		int result;
+		commit_list_insert(commit, &from_list);
+		result =3D can_all_from_reach(from_list, with_commit, 0);
+		free_commit_list(from_list);
+		return result;
+	} else {
+		while (with_commit) {
+			struct commit *other;
+
+			other =3D with_commit->item;
+			with_commit =3D with_commit->next;
+			if (in_merge_bases(other, commit))
+				return 1;
+		}
+		return 0;
 	}
-	return 0;
 }
=20
 /*
--=20
2.18.0.118.gd4f65b8d14

