Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEAD21F424
	for <e@80x24.org>; Tue,  3 Apr 2018 12:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755504AbeDCMBd (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 08:01:33 -0400
Received: from mail-bn3nam01on0131.outbound.protection.outlook.com ([104.47.33.131]:22187
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755300AbeDCMB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 08:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=zDuQBi38Q5mwZkCwiG3hYv3JDOgFtHSvkTktVkGADnE=;
 b=Mw90/rPYF3ZiLmBj6b392ZVXXtP4l7L1WW17mUkg2lfpRN/UmTy45HMcesljJZTpVbuL9kYud4N/kkkXxwNULVJ56/eSSwBg826Hmc5MhdQwoYvlmtid3MNiluyAsGtlxmo/IFwaCkh3lbZ9tcBP8HifpHjniie2Bdq5bu+b3z8=
Received: from stolee-linux-2.corp.microsoft.com
 (2001:4898:8010:0:eb4a:5dff:fe0f:730f) by
 MW2PR2101MB1019.namprd21.prod.outlook.com (2603:10b6:302:5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.675.1; Tue, 3 Apr 2018
 12:01:22 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, sbeller@google.com, larsxschneider@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 2/3] treewide: use get_commit_tree() for tree access
Date:   Tue,  3 Apr 2018 08:00:56 -0400
Message-Id: <20180403120057.173849-3-dstolee@microsoft.com>
X-Mailer: git-send-email 2.17.0.rc0
In-Reply-To: <20180403120057.173849-1-dstolee@microsoft.com>
References: <20180403120057.173849-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
X-ClientProxiedBy: DM5PR06CA0049.namprd06.prod.outlook.com
 (2603:10b6:3:37::11) To MW2PR2101MB1019.namprd21.prod.outlook.com
 (2603:10b6:302:5::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a081725e-a14f-4596-efe7-08d5995a9e96
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MW2PR2101MB1019;
X-Microsoft-Exchange-Diagnostics: 1;MW2PR2101MB1019;3:RpuZgnD6n1/UX4aH874TgyjfM82fV+UcLJwD+JGxhZxXT43uFlPZOL6nKhOx3ljFYZwCOoG64kG1ZBVLhrUnPrYfXSuxNUzMUQV4pOLZ4FWiAcARr8wPcwDK+b6HvFLWfe6PxdTq4o3FmdlIS0Mr8paoBI1IgDS0Jvv5QiiQyezRzZdLdy2StbTOoEiPQHbrnN3nfGdm+ZaRlBo25zhQ7IcvcPHSAiMwgsN8ffkAtRVji7360SHQFM8lPix/jHkj;25:PkCSCO4JRRpnqElOjooGDvDBgvnKLqdYTPiF+OggC3vBKEbLqUuPrXTj9o4ZDQDJHC85PrpK4T+FTT+/UBJek+T2QIWtDLmRTItcevQCXcaNHZoucvAJ5knKhK6uYyuDM2PZzYePxZElPz1nu2mz2c6X1ZJwNUs6C4xUbZiluTaFv5kQCBjVTGXfjRYRAyuQeGfHE/2/oPdFPD+PF9jW+QDklRRv80wGkMsPVLRbsPRhMZyIiri1Wnmec2H7k9r8zKTAqZNreuFsHyUnUCQfwsuXXIdWZtk699i4iUlAne6k7XjbGnV3rPhBEg8hD5a27ynU16HpEctvRDsDsfcbcw==;31:XItK8n9PUDS0V5sV/j7kEtx5QfU2DD+K2m5YfxbOjUOsBFKBnF74WTG01yZ0I9bKmPEOqzlTv3aMQD7T+S9q298/v1aVv9dk/SyTsjb1jjyjZoISgZistPeFTNwq8c/DjJ9cLD2nSf5IGvH5vxIclXUUxI0pQrnAP5isO2b5VXT5MSXqnFUWyKlXvoTvnxHXj6wuf3sntjrrfqyiA5pZDwtkDhB62sHjpcqTLcmYi68=
X-MS-TrafficTypeDiagnostic: MW2PR2101MB1019:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;MW2PR2101MB1019;20:+XZOCclEnDd1KaP67d4lyKK6BU7HN22+aBiSjgWFnrEkvnAWPd5A/W+sbLd6yEMvIdI+oPYWRHPZ9SbFZDPIH22c49+Zw8eOWyZ1HrQb1Efxt9m4PRf2YzjJlTMMOfpwHhH7UuafanGWu6xVPuWdMMIJeOeCBsXh6sqeIwRVg+IXuhfG8R/Xyjc8Z3ycrL1nRJ4Ki30M+tBDOnqZp+5XSbFEt3tcbMk0z32s+eHdsQ8rrQYFSxo0pKKqXIV/yAfUVr7DGNtvcCMSppJu5y7DqOzFjyxojJn6KPnwNN1AnY3OI3RhKIpbWfznBA+N9SynTtNoRW2TwPEhPsca036Qm99sY/a7vllOLOe69lckFnFHhfxujdCCnwS2xMwmrRJQAecWmxM+H6uPwqirlH71x0pMzvbZmh9432Oh+SOrupfZVh77RBTmPVO2oI4u88bxXeYeMuWtiahY9KrFf/8JPcTnAaafBNBH45w80xVYORBL5nEc5A/VLZjlm8hw1+LU;4:Njpq4yMO0eApCTea0U1RTVxxjRsMLiQbkY+LxsRsIfJXXJG8J3xKHpLLKLGMSQ+rbUEVCu8Ko7ZBGawgBYP+UyE8U97E3Nd1VLmv5h3ev8E/Pz/3wSYC/m+EjuxtuEhfOGk9rmb9Nku6qRIEVSDlhSz35PxaGAD1ReTyvGzmpIeF01Xs4ziTu6O6VrPwBSUSjqRiUR+6k2NVIeJ9fR25T0iEObdFQtIQhk7dqDMGxPRrzqGO15thVpMvDljiohw5bpf23Hfrw64asuaIbhuBpdfb/oQtlNC9o2+AjPQb+Y482NMlcZTy9dMe6GnRdeNkUzLdu5gwtxbhAa4FnM7f+T4+MQXzca7BpgKusdA9pzpQm5oe2AKmpjNVYsxuBaaq
X-Microsoft-Antispam-PRVS: <MW2PR2101MB10190EE276D95002856155DEA1A50@MW2PR2101MB1019.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(89211679590171)(788757137089);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:MW2PR2101MB1019;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1019;
X-Forefront-PRVS: 0631F0BC3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(39860400002)(376002)(346002)(189003)(199004)(47776003)(7696005)(59450400001)(6116002)(16526019)(1076002)(52116002)(50466002)(476003)(68736007)(97736004)(486005)(486005)(51416003)(11346002)(25786009)(106356001)(186003)(6916009)(10290500003)(6666003)(76176011)(52396003)(386003)(305945005)(46003)(7736002)(16586007)(316002)(86612001)(48376002)(2616005)(50226002)(22452003)(478600001)(36756003)(8936002)(81156014)(81166006)(39060400002)(575784001)(2361001)(86362001)(2351001)(6486002)(10090500001)(53936002)(8676002)(4326008)(107886003)(105586002)(446003)(5660300001)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1019;H:stolee-linux-2.corp.microsoft.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MW2PR2101MB1019;23:uS6bH1vJncfeJI014hdY2kFnSIheZF12CvgkL8o?=
 =?us-ascii?Q?QLZrM3RINkJQMuLfrFN5p/1XEWWUC/nV5aMn9ju4rqrrYUxXExUAqEBK/FvJ?=
 =?us-ascii?Q?rWZS7qW6DjjXp8M+moxOLUKsmR9V5unPTyf8B37DHoTuXS1ZMCpWMI6ZgIVg?=
 =?us-ascii?Q?zOBOtb3/k6XDpcvAUmJ9Y5f515aaX19zGsQXhy4Wnj5YkhXKIbnykeRKYm2Q?=
 =?us-ascii?Q?DvIhyj3bUMOSJPFNVi6G+oBKtJ5U9+pJOl0kzQRl3Ik2WvU/h0JBXVEv5cPD?=
 =?us-ascii?Q?uaym8otmoiYlvh/BOGxqS/76U6fvEF+4Rb9ybm8XDHnFs7K1CejUcJJwB9YA?=
 =?us-ascii?Q?B7EcqSNTOlLa4Pee12Z+heoHwPotPWotw/n1wWMO10UWIXwzx9DrKIGOPv+D?=
 =?us-ascii?Q?RVflRhZ8uWPsPjxZrpY07QEduWKXr64Ho0NdgkVjC3+uPSy5KmDePFUUCkhY?=
 =?us-ascii?Q?4RTTwmKrSIzE+TO+PyPGWms5GuSJ+Bq5ZvcRQy5pblKTbuoP5KYUuZQtOKQe?=
 =?us-ascii?Q?zjgDaTThWG48VSaJj2GMFkkzAmQCBB/JmUbNBiicn7fp1FE1zbfheA3hnPPr?=
 =?us-ascii?Q?n5lF0E1yD+AnHJWBgG6ysLVdWEEDS2KQmR+B2hksi3KJuw3Bf3CYDFWR4CJ+?=
 =?us-ascii?Q?9FfabLswVxibFcEBL9xvHkfJNLb1WHHnvtRfCcRNTjUxbzyJ31Mf6DqhtNjL?=
 =?us-ascii?Q?sari5zlgG1+Ds4iotOwfMjopxvuxsmItUhNFy4PVotqOy+iHuiYG1Wt8aSmc?=
 =?us-ascii?Q?sGe6F9MvwKdLAC+Cx/i4sCauHPS3MpYDxEsmN67ocW/6Dixnh+RTE0KjoGKe?=
 =?us-ascii?Q?qB2zLFQYy0Izh5T2Z+KY5h2rlOgGGyQ4JsNWSeR8IJ+44JpuMAUGFv8Rp/Rg?=
 =?us-ascii?Q?IcpOupGaJVJBEPyt5i0w7JaR7ZYoJGTahWvR9m//rIcyVIC+99d6cYNX+pfV?=
 =?us-ascii?Q?HvSapMHgUG7oOi9gYKVRZWIEZDA+OI2SULvmhX2Ln0WPIvmyrILCyQ9Yo6fd?=
 =?us-ascii?Q?55hmPDQk4+QRX9D1/DH9N/IuRnJfOLFwlqJ6iRX9Ees/5IPCpx2Y2c9iO9yd?=
 =?us-ascii?Q?rrPTfw5Q8EA/MSQP5fG+Gc+t415CfREG+jehLqndvUpWYBxEFrlQh1P4nALU?=
 =?us-ascii?Q?KkfX2a5rvQWd6xgPZZCNMSdsiqjtigomTVsa7n9QUo5HIGFk7aYpmyYgwpAS?=
 =?us-ascii?Q?Nf8ERUBFdqb6QNv6AQ/hzb2reG0Bz7+UWIJgyXuoJMvHOv2QBLz2v2tpO88Z?=
 =?us-ascii?Q?ZYe9LISIkoLrYY+3hVLLSZFGtKV1ULf6e/UgZbM73BDJyPekOjD0DAqNt3/5?=
 =?us-ascii?Q?/QSZEy8QZz5pxumEcd/i2CvUONt9B5xXmxlvinOGfvGaEPukErBkXZsu82bM?=
 =?us-ascii?Q?UXbhPcP2tT7/RUpF7MG2T9PzEGU9PUXvxg3vbnGdTCHXb1wPD?=
X-Microsoft-Antispam-Message-Info: Qv4dMt2RX3eLCRtTga45fUzCSP1e4u7tbJ6ZwIO3YMP4Kj+FjsjAOvt9eg4Y98FxuCjBZjb7PLf43Aoaohc+8gVhAx1Pi/iQJw1NUPBIMlPi5d8Pu/pcPO959VSsGcUsprcT8zBbjAIjxMWACqDZL84+p2SXzaoMqkl7rFaUQOV9H0OiADvU4de9XYX2UGbH
X-Microsoft-Exchange-Diagnostics: 1;MW2PR2101MB1019;6:WqYx/F8x+sobR9yOYdBnxMDggyD1I0KDuqrXZsqrL1kCiOx6DIYz1IIus3w56AWHRacykO/ybKB3bpalcnAZbb96zRTjrVolnrpHDLPubYk5Gakak97YwVlp65OpNBMeHVUmzpOUAJl3RWf/zYrUMyKwnKGuN9Zw7K7TY4LCqiLwKsjeOnKF1djjXxPTZ9PQ8vyo+cH8irG7J6HLlwnTPs4gC7Mh5gOJ7+OD2dCV1bs/vxOEcpnrhXaqwZ9ZT9dbbFcA/Z4kRm4MQAv8dhLNKC4YpbajUL51G/KIDsOKnQhLf0QSBrV8Cm54/o8vjZDtZ1uuSbN/Nd7Cn/w3vb/Yr2vJWftKzzfnf0YNb7If9O99k7GAFUNQn/EG3Q0SmOsFNNW93IaXAxwRBRcywvwRELzWbjwIoXqXji4nG+M5pirHmT8/cyjKqXDYbqVk5jiwNL15/vuq3lOjJ47ikXLULQ==;5:Akdp0eek8gyyafVcdGCHlBmgtfXU+b1F7yI/vpg9zV1lBExXyIw1gccpEZWP58GFiOmayKy1poRo6vsnU8GfgsT8hc74JCn+Yw3aJomuYdwb73FAAMiMmP2jb3qSQQB1Sky4A+mko9d7HtGe04GQzlJ+Ah49m12QZmZ3u6EcWJs=;24:FpWqCPARKlbUwck8ofo1clbHu3E/FjLOdY9eUvs+1QsEAA4ivOufIz7Z7kWMUpCaday7jyu9UtD9SeOOGxkr5j8fdy8ojCDuYGcAUkazXcs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MW2PR2101MB1019;7:3TPNII2NkMG5aneB0gLWM3wgf+B8eWGYH06xlMgvKnzMbmEU3ZkNODTXIXDyPRfyXlD388XHvlONt74581fzL+4UAOQFcS8cGMh4Y8/FJxmc+lDvBOy2nAkH+MNwbc36aYt/SLS3+3inbb0GxSxAnO1g1tijMHHm/d7X1RNQ+ySESzOg1T3qAkb11TBuS5KLcCgdFv+erBmXg0WKr6oFxfDtjENW+hPX30xFUeATp19BTsoeOw6YjJ6MVOfmEgiM;20:APMVVo2ZdpplFLLgGMqc7DXxeEin47bhvKTrZ34lrvYRvDrZeSfC+yWAjXFEJkugZ9CGmMhoQeOh4K+Do/WiKaXMZJOizvm2YO3VXZ84tVPmCnxYYDg+STc2IFeSzZnElm3TmVDwaoVpg715vPNb8vnZrF4eCClanCkg49YnQlM=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2018 12:01:22.2872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a081725e-a14f-4596-efe7-08d5995a9e96
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1019
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace all direct accesses of the 'tree' member in 'struct commit'
with calls to get_commit_tree() or get_commit_tree_oid().

This patch was constructed starting with the following Coccinelle
script, then removing false-positives:

@@
expression c;
@@
- &c->tree->object.oid
+ get_commit_tree_oid(c)

@@
expression c;
symbol m;
@@
- c->tree->object.oid.m
+ get_commit_tree_oid(c)->m

@@
expression c;
@@
- c->tree
+ get_commit_tree(c)

To ensure all references were removed, the 'tree' member was renamed
to 'tree_renamed' along with the few allowed accessors. A successful
compilation demonstrated a correct transformation.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 blame.c               | 18 +++++++++---------
 builtin/checkout.c    | 17 +++++++++--------
 builtin/diff.c        |  2 +-
 builtin/fast-export.c |  6 +++---
 builtin/log.c         |  4 ++--
 builtin/reflog.c      |  2 +-
 commit-graph.c        |  2 +-
 fsck.c                |  8 +++++---
 http-push.c           |  2 +-
 line-log.c            |  4 ++--
 list-objects.c        | 10 +++++-----
 log-tree.c            |  6 +++---
 merge-recursive.c     |  3 ++-
 notes-merge.c         |  8 ++++----
 packfile.c            |  2 +-
 pretty.c              |  5 +++--
 ref-filter.c          |  2 +-
 revision.c            |  8 ++++----
 sequencer.c           | 12 ++++++------
 sha1_name.c           |  2 +-
 tree.c                |  4 ++--
 walker.c              |  2 +-
 22 files changed, 67 insertions(+), 62 deletions(-)

diff --git a/blame.c b/blame.c
index 200e0ad9a2..7f5700b324 100644
--- a/blame.c
+++ b/blame.c
@@ -553,10 +553,10 @@ static struct blame_origin *find_origin(struct commit *parent,
 	diff_setup_done(&diff_opts);
 
 	if (is_null_oid(&origin->commit->object.oid))
-		do_diff_cache(&parent->tree->object.oid, &diff_opts);
+		do_diff_cache(get_commit_tree_oid(parent), &diff_opts);
 	else
-		diff_tree_oid(&parent->tree->object.oid,
-			      &origin->commit->tree->object.oid,
+		diff_tree_oid(get_commit_tree_oid(parent),
+			      get_commit_tree_oid(origin->commit),
 			      "", &diff_opts);
 	diffcore_std(&diff_opts);
 
@@ -622,10 +622,10 @@ static struct blame_origin *find_rename(struct commit *parent,
 	diff_setup_done(&diff_opts);
 
 	if (is_null_oid(&origin->commit->object.oid))
-		do_diff_cache(&parent->tree->object.oid, &diff_opts);
+		do_diff_cache(get_commit_tree_oid(parent), &diff_opts);
 	else
-		diff_tree_oid(&parent->tree->object.oid,
-			      &origin->commit->tree->object.oid,
+		diff_tree_oid(get_commit_tree_oid(parent),
+			      get_commit_tree_oid(origin->commit),
 			      "", &diff_opts);
 	diffcore_std(&diff_opts);
 
@@ -1257,10 +1257,10 @@ static void find_copy_in_parent(struct blame_scoreboard *sb,
 		diff_opts.flags.find_copies_harder = 1;
 
 	if (is_null_oid(&target->commit->object.oid))
-		do_diff_cache(&parent->tree->object.oid, &diff_opts);
+		do_diff_cache(get_commit_tree_oid(parent), &diff_opts);
 	else
-		diff_tree_oid(&parent->tree->object.oid,
-			      &target->commit->tree->object.oid,
+		diff_tree_oid(get_commit_tree_oid(parent),
+			      get_commit_tree_oid(target->commit),
 			      "", &diff_opts);
 
 	if (!diff_opts.flags.find_copies_harder)
diff --git a/builtin/checkout.c b/builtin/checkout.c
index d76e13c852..0b448fd179 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -484,7 +484,8 @@ static int merge_working_tree(const struct checkout_opts *opts,
 
 	resolve_undo_clear();
 	if (opts->force) {
-		ret = reset_tree(new_branch_info->commit->tree, opts, 1, writeout_error);
+		ret = reset_tree(get_commit_tree(new_branch_info->commit),
+				 opts, 1, writeout_error);
 		if (ret)
 			return ret;
 	} else {
@@ -570,19 +571,19 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			o.verbosity = 0;
 			work = write_tree_from_memory(&o);
 
-			ret = reset_tree(new_branch_info->commit->tree, opts, 1,
-					 writeout_error);
+			ret = reset_tree(get_commit_tree(new_branch_info->commit),
+					 opts, 1, writeout_error);
 			if (ret)
 				return ret;
 			o.ancestor = old_branch_info->name;
 			o.branch1 = new_branch_info->name;
 			o.branch2 = "local";
-			ret = merge_trees(&o, new_branch_info->commit->tree, work,
-				old_branch_info->commit->tree, &result);
+			ret = merge_trees(&o, get_commit_tree(new_branch_info->commit),
+					  work, get_commit_tree(old_branch_info->commit), &result);
 			if (ret < 0)
 				exit(128);
-			ret = reset_tree(new_branch_info->commit->tree, opts, 0,
-					 writeout_error);
+			ret = reset_tree(get_commit_tree(new_branch_info->commit),
+					 opts, 0, writeout_error);
 			strbuf_release(&o.obuf);
 			if (ret)
 				return ret;
@@ -1002,7 +1003,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 		*source_tree = parse_tree_indirect(rev);
 	} else {
 		parse_commit_or_die(new_branch_info->commit);
-		*source_tree = new_branch_info->commit->tree;
+		*source_tree = get_commit_tree(new_branch_info->commit);
 	}
 
 	if (!*source_tree)                   /* case (1): want a tree */
diff --git a/builtin/diff.c b/builtin/diff.c
index 16bfb22f73..bfefff3a84 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -398,7 +398,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 		if (!obj)
 			die(_("invalid object '%s' given."), name);
 		if (obj->type == OBJ_COMMIT)
-			obj = &((struct commit *)obj)->tree->object;
+			obj = &get_commit_tree(((struct commit *)obj))->object;
 
 		if (obj->type == OBJ_TREE) {
 			obj->flags |= flags;
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 27b2cc138e..c1304234cd 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -578,11 +578,11 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 	    get_object_mark(&commit->parents->item->object) != 0 &&
 	    !full_tree) {
 		parse_commit_or_die(commit->parents->item);
-		diff_tree_oid(&commit->parents->item->tree->object.oid,
-			      &commit->tree->object.oid, "", &rev->diffopt);
+		diff_tree_oid(get_commit_tree_oid(commit->parents->item),
+			      get_commit_tree_oid(commit), "", &rev->diffopt);
 	}
 	else
-		diff_root_tree_oid(&commit->tree->object.oid,
+		diff_root_tree_oid(get_commit_tree_oid(commit),
 				   "", &rev->diffopt);
 
 	/* Export the referenced blobs, and remember the marks. */
diff --git a/builtin/log.c b/builtin/log.c
index 94ee177d56..25b4cb3347 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1067,8 +1067,8 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 
 	diff_setup_done(&opts);
 
-	diff_tree_oid(&origin->tree->object.oid,
-		      &head->tree->object.oid,
+	diff_tree_oid(get_commit_tree_oid(origin),
+		      get_commit_tree_oid(head),
 		      "", &opts);
 	diffcore_std(&opts);
 	diff_flush(&opts);
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 4719a5354c..88d0c8378c 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -154,7 +154,7 @@ static int commit_is_complete(struct commit *commit)
 		for (i = 0; i < found.nr; i++) {
 			struct commit *c =
 				(struct commit *)found.objects[i].item;
-			if (!tree_is_complete(&c->tree->object.oid)) {
+			if (!tree_is_complete(get_commit_tree_oid(c))) {
 				is_incomplete = 1;
 				c->object.flags |= INCOMPLETE;
 			}
diff --git a/commit-graph.c b/commit-graph.c
index 1fc63d541b..3080a87940 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -369,7 +369,7 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 		uint32_t packedDate[2];
 
 		parse_commit(*list);
-		hashwrite(f, (*list)->tree->object.oid.hash, hash_len);
+		hashwrite(f, get_commit_tree_oid(*list)->hash, hash_len);
 
 		parent = (*list)->parents;
 
diff --git a/fsck.c b/fsck.c
index 5c8c12dde3..695fd71b13 100644
--- a/fsck.c
+++ b/fsck.c
@@ -396,9 +396,11 @@ static int fsck_walk_commit(struct commit *commit, void *data, struct fsck_optio
 
 	name = get_object_name(options, &commit->object);
 	if (name)
-		put_object_name(options, &commit->tree->object, "%s:", name);
+		put_object_name(options, &get_commit_tree(commit)->object,
+				"%s:", name);
 
-	result = options->walk((struct object *)commit->tree, OBJ_TREE, data, options);
+	result = options->walk((struct object *)get_commit_tree(commit),
+			       OBJ_TREE, data, options);
 	if (result < 0)
 		return result;
 	res = result;
@@ -772,7 +774,7 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
 	err = fsck_ident(&buffer, &commit->object, options);
 	if (err)
 		return err;
-	if (!commit->tree) {
+	if (!get_commit_tree(commit)) {
 		err = report(options, &commit->object, FSCK_MSG_BAD_TREE, "could not load commit's tree %s", sha1_to_hex(tree_sha1));
 		if (err)
 			return err;
diff --git a/http-push.c b/http-push.c
index 7dcd9daf62..53a217291e 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1330,7 +1330,7 @@ static int get_delta(struct rev_info *revs, struct remote_lock *lock)
 	int count = 0;
 
 	while ((commit = get_revision(revs)) != NULL) {
-		p = process_tree(commit->tree, p);
+		p = process_tree(get_commit_tree(commit), p);
 		commit->object.flags |= LOCAL;
 		if (!(commit->object.flags & UNINTERESTING))
 			count += add_send_request(&commit->object, lock);
diff --git a/line-log.c b/line-log.c
index cdc2257db5..437d44c00a 100644
--- a/line-log.c
+++ b/line-log.c
@@ -817,8 +817,8 @@ static void queue_diffs(struct line_log_data *range,
 	assert(commit);
 
 	DIFF_QUEUE_CLEAR(&diff_queued_diff);
-	diff_tree_oid(parent ? &parent->tree->object.oid : NULL,
-		      &commit->tree->object.oid, "", opt);
+	diff_tree_oid(parent ? get_commit_tree_oid(parent) : NULL,
+		      get_commit_tree_oid(commit), "", opt);
 	if (opt->detect_rename) {
 		filter_diffs_for_paths(range, 1);
 		if (diff_might_be_rename())
diff --git a/list-objects.c b/list-objects.c
index 168bef688a..3eec510357 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -195,7 +195,7 @@ static void mark_edge_parents_uninteresting(struct commit *commit,
 		struct commit *parent = parents->item;
 		if (!(parent->object.flags & UNINTERESTING))
 			continue;
-		mark_tree_uninteresting(parent->tree);
+		mark_tree_uninteresting(get_commit_tree(parent));
 		if (revs->edge_hint && !(parent->object.flags & SHOWN)) {
 			parent->object.flags |= SHOWN;
 			show_edge(parent);
@@ -212,7 +212,7 @@ void mark_edges_uninteresting(struct rev_info *revs, show_edge_fn show_edge)
 		struct commit *commit = list->item;
 
 		if (commit->object.flags & UNINTERESTING) {
-			mark_tree_uninteresting(commit->tree);
+			mark_tree_uninteresting(get_commit_tree(commit));
 			if (revs->edge_hint_aggressive && !(commit->object.flags & SHOWN)) {
 				commit->object.flags |= SHOWN;
 				show_edge(commit);
@@ -227,7 +227,7 @@ void mark_edges_uninteresting(struct rev_info *revs, show_edge_fn show_edge)
 			struct commit *commit = (struct commit *)obj;
 			if (obj->type != OBJ_COMMIT || !(obj->flags & UNINTERESTING))
 				continue;
-			mark_tree_uninteresting(commit->tree);
+			mark_tree_uninteresting(get_commit_tree(commit));
 			if (!(obj->flags & SHOWN)) {
 				obj->flags |= SHOWN;
 				show_edge(commit);
@@ -300,8 +300,8 @@ static void do_traverse(struct rev_info *revs,
 		 * an uninteresting boundary commit may not have its tree
 		 * parsed yet, but we are not going to show them anyway
 		 */
-		if (commit->tree)
-			add_pending_tree(revs, commit->tree);
+		if (get_commit_tree(commit))
+			add_pending_tree(revs, get_commit_tree(commit));
 		show_commit(commit, show_data);
 
 		if (revs->tree_blobs_in_commit_order)
diff --git a/log-tree.c b/log-tree.c
index bdf23c5f7b..c106bd70df 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -806,7 +806,7 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 		return 0;
 
 	parse_commit_or_die(commit);
-	oid = &commit->tree->object.oid;
+	oid = get_commit_tree_oid(commit);
 
 	/* Root commit? */
 	parents = get_saved_parents(opt, commit);
@@ -831,7 +831,7 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 			 * we merged _in_.
 			 */
 			parse_commit_or_die(parents->item);
-			diff_tree_oid(&parents->item->tree->object.oid,
+			diff_tree_oid(get_commit_tree_oid(parents->item),
 				      oid, "", &opt->diffopt);
 			log_tree_diff_flush(opt);
 			return !opt->loginfo;
@@ -846,7 +846,7 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 		struct commit *parent = parents->item;
 
 		parse_commit_or_die(parent);
-		diff_tree_oid(&parent->tree->object.oid,
+		diff_tree_oid(get_commit_tree_oid(parent),
 			      oid, "", &opt->diffopt);
 		log_tree_diff_flush(opt);
 
diff --git a/merge-recursive.c b/merge-recursive.c
index 869092f7b9..050729665f 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2154,7 +2154,8 @@ int merge_recursive(struct merge_options *o,
 		read_cache();
 
 	o->ancestor = "merged common ancestors";
-	clean = merge_trees(o, h1->tree, h2->tree, merged_common_ancestors->tree,
+	clean = merge_trees(o, get_commit_tree(h1), get_commit_tree(h2),
+			    get_commit_tree(merged_common_ancestors),
 			    &mrtree);
 	if (clean < 0) {
 		flush_output(o);
diff --git a/notes-merge.c b/notes-merge.c
index c09c5e0e47..65cf731106 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -600,14 +600,14 @@ int notes_merge(struct notes_merge_options *o,
 			printf("No merge base found; doing history-less merge\n");
 	} else if (!bases->next) {
 		base_oid = &bases->item->object.oid;
-		base_tree_oid = &bases->item->tree->object.oid;
+		base_tree_oid = get_commit_tree_oid(bases->item);
 		if (o->verbosity >= 4)
 			printf("One merge base found (%.7s)\n",
 			       oid_to_hex(base_oid));
 	} else {
 		/* TODO: How to handle multiple merge-bases? */
 		base_oid = &bases->item->object.oid;
-		base_tree_oid = &bases->item->tree->object.oid;
+		base_tree_oid = get_commit_tree_oid(bases->item);
 		if (o->verbosity >= 3)
 			printf("Multiple merge bases found. Using the first "
 				"(%.7s)\n", oid_to_hex(base_oid));
@@ -634,8 +634,8 @@ int notes_merge(struct notes_merge_options *o,
 		goto found_result;
 	}
 
-	result = merge_from_diffs(o, base_tree_oid, &local->tree->object.oid,
-				  &remote->tree->object.oid, local_tree);
+	result = merge_from_diffs(o, base_tree_oid, get_commit_tree_oid(local),
+				  get_commit_tree_oid(remote), local_tree);
 
 	if (result != 0) { /* non-trivial merge (with or without conflicts) */
 		/* Commit (partial) result */
diff --git a/packfile.c b/packfile.c
index b1d33b646a..88ba819151 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1925,7 +1925,7 @@ static int add_promisor_object(const struct object_id *oid,
 		struct commit *commit = (struct commit *) obj;
 		struct commit_list *parents = commit->parents;
 
-		oidset_insert(set, &commit->tree->object.oid);
+		oidset_insert(set, get_commit_tree_oid(commit));
 		for (; parents; parents = parents->next)
 			oidset_insert(set, &parents->item->object.oid);
 	} else if (obj->type == OBJ_TAG) {
diff --git a/pretty.c b/pretty.c
index f7ce490230..74d6f69605 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1161,10 +1161,11 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		strbuf_addstr(sb, diff_get_color(c->auto_color, DIFF_RESET));
 		return 1;
 	case 'T':		/* tree hash */
-		strbuf_addstr(sb, oid_to_hex(&commit->tree->object.oid));
+		strbuf_addstr(sb, oid_to_hex(get_commit_tree_oid(commit)));
 		return 1;
 	case 't':		/* abbreviated tree hash */
-		strbuf_add_unique_abbrev(sb, commit->tree->object.oid.hash,
+		strbuf_add_unique_abbrev(sb,
+					 get_commit_tree(commit)->object.oid.hash,
 					 c->pretty_ctx->abbrev);
 		return 1;
 	case 'P':		/* parent hashes */
diff --git a/ref-filter.c b/ref-filter.c
index 45fc56216a..e201bf60c6 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -815,7 +815,7 @@ static void grab_commit_values(struct atom_value *val, int deref, struct object
 		if (deref)
 			name++;
 		if (!strcmp(name, "tree")) {
-			v->s = xstrdup(oid_to_hex(&commit->tree->object.oid));
+			v->s = xstrdup(oid_to_hex(get_commit_tree_oid(commit)));
 		}
 		else if (!strcmp(name, "numparent")) {
 			v->value = commit_list_count(commit->parents);
diff --git a/revision.c b/revision.c
index b42c836d7a..496db63b4b 100644
--- a/revision.c
+++ b/revision.c
@@ -440,8 +440,8 @@ static void file_change(struct diff_options *options,
 static int rev_compare_tree(struct rev_info *revs,
 			    struct commit *parent, struct commit *commit)
 {
-	struct tree *t1 = parent->tree;
-	struct tree *t2 = commit->tree;
+	struct tree *t1 = get_commit_tree(parent);
+	struct tree *t2 = get_commit_tree(commit);
 
 	if (!t1)
 		return REV_TREE_NEW;
@@ -477,7 +477,7 @@ static int rev_compare_tree(struct rev_info *revs,
 static int rev_same_tree_as_empty(struct rev_info *revs, struct commit *commit)
 {
 	int retval;
-	struct tree *t1 = commit->tree;
+	struct tree *t1 = get_commit_tree(commit);
 
 	if (!t1)
 		return 0;
@@ -615,7 +615,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 	if (!revs->prune)
 		return;
 
-	if (!commit->tree)
+	if (!get_commit_tree(commit))
 		return;
 
 	if (!commit->parents) {
diff --git a/sequencer.c b/sequencer.c
index f9d1001dee..a5798b16d3 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -499,8 +499,8 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	o.show_rename_progress = 1;
 
 	head_tree = parse_tree_indirect(head);
-	next_tree = next ? next->tree : empty_tree();
-	base_tree = base ? base->tree : empty_tree();
+	next_tree = next ? get_commit_tree(next) : empty_tree();
+	base_tree = base ? get_commit_tree(base) : empty_tree();
 
 	for (xopt = opts->xopts; xopt != opts->xopts + opts->xopts_nr; xopt++)
 		parse_merge_opt(&o, *xopt);
@@ -561,7 +561,7 @@ static int is_index_unchanged(void)
 			return error(_("unable to update cache tree"));
 
 	return !oidcmp(&active_cache_tree->oid,
-		       &head_commit->tree->object.oid);
+		       get_commit_tree_oid(head_commit));
 }
 
 static int write_author_script(const char *message)
@@ -1118,7 +1118,7 @@ static int try_to_commit(struct strbuf *msg, const char *author,
 	}
 
 	if (!(flags & ALLOW_EMPTY) && !oidcmp(current_head ?
-					      &current_head->tree->object.oid :
+					      get_commit_tree_oid(current_head) :
 					      &empty_tree_oid, &tree)) {
 		res = 1; /* run 'git commit' to display error message */
 		goto out;
@@ -1216,12 +1216,12 @@ static int is_original_commit_empty(struct commit *commit)
 		if (parse_commit(parent))
 			return error(_("could not parse parent commit %s"),
 				oid_to_hex(&parent->object.oid));
-		ptree_oid = &parent->tree->object.oid;
+		ptree_oid = get_commit_tree_oid(parent);
 	} else {
 		ptree_oid = the_hash_algo->empty_tree; /* commit is root */
 	}
 
-	return !oidcmp(ptree_oid, &commit->tree->object.oid);
+	return !oidcmp(ptree_oid, get_commit_tree_oid(commit));
 }
 
 /*
diff --git a/sha1_name.c b/sha1_name.c
index 735c1c0b8e..1608b51c3c 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -896,7 +896,7 @@ struct object *peel_to_type(const char *name, int namelen,
 		if (o->type == OBJ_TAG)
 			o = ((struct tag*) o)->tagged;
 		else if (o->type == OBJ_COMMIT)
-			o = &(((struct commit *) o)->tree->object);
+			o = &get_commit_tree((struct commit *) o)->object;
 		else {
 			if (name)
 				error("%.*s: expected %s type, but the object "
diff --git a/tree.c b/tree.c
index b224115e0f..dec53f3eca 100644
--- a/tree.c
+++ b/tree.c
@@ -109,7 +109,7 @@ static int read_tree_1(struct tree *tree, struct strbuf *base,
 				    oid_to_hex(entry.oid),
 				    base->buf, entry.path);
 
-			oidcpy(&oid, &commit->tree->object.oid);
+			oidcpy(&oid, get_commit_tree_oid(commit));
 		}
 		else
 			continue;
@@ -248,7 +248,7 @@ struct tree *parse_tree_indirect(const struct object_id *oid)
 		if (obj->type == OBJ_TREE)
 			return (struct tree *) obj;
 		else if (obj->type == OBJ_COMMIT)
-			obj = &(((struct commit *) obj)->tree->object);
+			obj = &(get_commit_tree(((struct commit *)obj))->object);
 		else if (obj->type == OBJ_TAG)
 			obj = ((struct tag *) obj)->tagged;
 		else
diff --git a/walker.c b/walker.c
index dffb9c8e37..f51b855872 100644
--- a/walker.c
+++ b/walker.c
@@ -87,7 +87,7 @@ static int process_commit(struct walker *walker, struct commit *commit)
 	walker_say(walker, "walk %s\n", oid_to_hex(&commit->object.oid));
 
 	if (walker->get_tree) {
-		if (process(walker, &commit->tree->object))
+		if (process(walker, &get_commit_tree(commit)->object))
 			return -1;
 		if (!walker->get_all)
 			walker->get_tree = 0;
-- 
2.17.0.20.g9f30ba16e1

