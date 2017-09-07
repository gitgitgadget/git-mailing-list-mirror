Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B783120286
	for <e@80x24.org>; Thu,  7 Sep 2017 16:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932349AbdIGQ0u (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 12:26:50 -0400
Received: from mail-cys01nam02on0097.outbound.protection.outlook.com ([104.47.37.97]:26976
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932083AbdIGQ0r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 12:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=+I3wNr2sEZK7PaktDF7aBpKlcNJKsh/2Qf5fgtWf2V4=;
 b=iiilSTUFTqy9H/AiEy9hOpLab4k9Pcd5BD2LhyhfMwnOknmOwQEb8hQQoYQzcdELWvrk5WNQ8PtHslwwbZpSKT3/s+QLz4++AbaDMMmMAZuKW4DqP8TC/IIBnUM73FeRCm6ZiXnif30t+VhERGIptTUteI4ealRzpUEBPIzrn/I=
Received: from kewillf-01.northamerica.corp.microsoft.com (174.126.250.66) by
 SN1PR21MB0016.namprd21.prod.outlook.com (10.161.254.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.56.6; Thu, 7 Sep 2017 16:26:44 +0000
From:   Kevin Willford <kewillf@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Kevin Willford <kewillf@microsoft.com>
Subject: [PATCH v3 2/3] merge-recursive: remove return value from get_files_dirs
Date:   Thu,  7 Sep 2017 10:25:55 -0600
Message-Id: <20170907162556.61384-3-kewillf@microsoft.com>
X-Mailer: git-send-email 2.14.1.329.gcdd497e120.dirty
In-Reply-To: <20170907162556.61384-1-kewillf@microsoft.com>
References: <20170907162556.61384-1-kewillf@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [174.126.250.66]
X-ClientProxiedBy: CY4PR08CA0069.namprd08.prod.outlook.com (10.171.251.162) To
 SN1PR21MB0016.namprd21.prod.outlook.com (10.161.254.139)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c684b91f-955c-412a-49e5-08d4f60d3ab7
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(48565401081)(300000503095)(300135400095)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:SN1PR21MB0016;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR21MB0016;3:bEvVq8C5VGiAvVMoaN/8a7Vn3T/3k901QezXz8vld9xCgyO8gUP49MbXYWrBf06JUZ4gchYFx9msw2trmsP9fROjfYcmExYLd+Gb78hZ/BkAgTsZlriZBAx70aSbmfVJUiVwL4xEALYBPAlgDOUMyt1Y5HJZm1SEhzMST8/IsasL+2XQxrNTUCN0JSFdw/bioNqSYNZaIY2BUNW76cf22PbRt+31gmX+wXtP3+UwNIfBCu591NEtYHlKbCuR+RSF;25:wkDCU/GdtFX+ckpqUoBkY+VtK4lJJaSo585Oq6/22pufO/WG8kcdZzcPKlNYtGx9JnWw2njGZOyjfYbOQL+Ad1RI3CQ+HyKPf8wSXR/5pf66AlPPqHpQgslFYHgeWp8xxTY0Ht5OHdGTY93Z4dkrdZLWeJJ6ZdrN0ZCdhWT74WsdtsUIhO7mBQ0zdGIu7dh0Q+swYvlrFNaD4smRXxI7o3WyogVpaDZlHoGZK0to1jX1lH1nSdPQe0tSh29V8nbo8a09eWDYn5elNFtLlwM12DS8WuG373RfUdCekSKT9mhZ8w0iW8h0TsSF170CxpBj1hAVdyJMMkBcL0rkWtEW8A==;31:66dekHIlKnPCHI84umDGxVuN7hslRcdkn0WnxdSyCItRrKLn0EDKKebXGRy+8fSBUyUswZvrg+Iw6ov4+JW6zCdbFX6oHuiDeCt/DVstCn+8Srk95McWUILMGg8TdEE87GfOgIhy7Rj10MOSGHJEZJDlIRu05CUYilWVK/qphVMOMliKI16xZCSLesn5l0ZxM8oChMp4/ni3bKNyeOAH/2sdyzQn1p/Tn8cLBZfDFzI=
X-MS-TrafficTypeDiagnostic: SN1PR21MB0016:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kewillf@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;SN1PR21MB0016;20:ljZ4Z49dprseBspcn+LNQu67n9ZUKd1Il8mtc6RQlhM9MJgm1m32SffxbjQhzHBS3CRxmuUwwYQLmppqGLSWcv2kWrjPIb32KS8g0zJMqa7XTBUDKfhUygeX9f/1it2kcgF/OSD18j1/VHGLShz1uKFt5rqLK1iGjxmKcegltKZ5ofTVXaao99EW7jz7QiQfBL81+zqFvQKT9ENd2VVoz3/T/WZj2HIWa4TLED1p/Ax2jACkxC46RI+sAksuWjqWasqH0hROm6OT0+SxX3MVte/hWifoEg7qh6h+fGnuq6KRiwO4GJyFsIAjTUxyz+6SMZuAFceNapvgkAKirSM7hEcJow84yZ3fjVntHHwd/MGTLZaJlLr5Ri2eiIA2+kcnjO/RqUuyDFizAZcnS1HRTNVzRa+44MrQbd0ZLvw/DZJfAHDdtv9zl+znX69GgiHSkQtM/p1LAUfSw1lHmS8YnbIq0q7evfa38KfavBeT5Hd9N4c4pYbuX19096nQ8Lsg;4:wBmEKMEc89XMLubpKgjaRwjK3GV33lekM/SWnkMGTwbgzshCfdOahw2jG6cl9EvQ6cWO2WRKvzYIK/y6RmX/HeJGrLGcgTnCCWJ6A6FOSNQbOx9Kujq0JKQtCU5oESQ1yvyOVZn176aWiGOb7R1nkZhcSYaJ6WdDxVOBShAs+ZKrt6mANyrQ5Oy/5PxQ3EeNW6bm+TFeJqf+10z6FLU1C/OlNjrgm5Pbx7UeijJS+LFnpPFVhT5GC7emhIBh7reZLAyCV5/rkgEytTfjNatYImuBU+sysoMHwvYo4HvRhYg=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <SN1PR21MB0016AA89A4F606334B1699F7B7940@SN1PR21MB0016.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(5005006)(8121501046)(10201501046)(3002001)(100000703101)(100105400095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041248)(20161123562025)(20161123564025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(20161123558100)(20161123555025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN1PR21MB0016;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN1PR21MB0016;
X-Forefront-PRVS: 04238CD941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(39860400002)(47760400005)(199003)(189002)(47776003)(305945005)(106356001)(53936002)(68736007)(189998001)(66066001)(2361001)(7736002)(2351001)(33646002)(97736004)(105586002)(5660300001)(42186005)(50466002)(478600001)(10290500003)(48376002)(5003940100001)(6486002)(1076002)(3846002)(25786009)(4326008)(6116002)(8656003)(8936002)(107886003)(5005710100001)(110136004)(50226002)(8676002)(10090500001)(81166006)(2906002)(6666003)(2950100002)(81156014)(76176999)(6916009)(50986999)(101416001)(86612001)(86362001)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR21MB0016;H:kewillf-01.northamerica.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR21MB0016;23:89FbJ1WdYdNZyl5Dnk/oBqAm+3pDFtxJn/l3tA/Q0?=
 =?us-ascii?Q?jyFOZmBlqydb8SRe7GrIlQ8NtByeWxpBVUuODK5ursLkNVHMGJ4mcsVtJNKT?=
 =?us-ascii?Q?mGFl/DMTbgV52a/UraGyh88xwCJfJW/ex/UBpJzr53AGpK1842ViYGJhLD9h?=
 =?us-ascii?Q?NdX/J92v1N7Jf7tuEqjm4vlkmtn1ok01GqCR1aCMVaUgY4HLrqWUWj0I4f50?=
 =?us-ascii?Q?Z00vxCpWD2lKxHVJnoRXoa8dpSGi6V9bXkGCJqmXAdZL3WBRmXjB4I9b8Qqh?=
 =?us-ascii?Q?6UzIbhSWJ49B1/jiPNeP40Tezf07AC5haEg5+5UjHOT7hvZymYoZK7Jxxlxi?=
 =?us-ascii?Q?EUF1Ib7RcQ2BIw2EjqhWo/8lwkaKQOB3Gx9Z+sVGBv315nf5mmPnqoaGzdxC?=
 =?us-ascii?Q?Xb0Npn5edwEscpVf/aK3onPFHvLuqWp/JFVsHiA4wQ4nUEl2SxO4ftQLt6U9?=
 =?us-ascii?Q?dok4UWvL7lW/PDtuRh86uYc9zGNOcMmbXm65PG+a/z6ZabTA273jUm2KdOqm?=
 =?us-ascii?Q?ubLFr+Ci0iqk252Z8HHU7qgz7XZAbu3ugv18XwL6qQ5Mlz1yspjaEvSTd6Nr?=
 =?us-ascii?Q?jhmmWMhoM+xFURwRk3eqgKA1/lKxEThmBYCkpENb3duNzNjMSk7bU48ae0h4?=
 =?us-ascii?Q?AhrK2izLmPoODyne3ZjjhvpivkrUR5JVDl8gtd56ViItJVmbOMyinqadhxEi?=
 =?us-ascii?Q?kl21/h48RLQduzDI830gUVIsQsBDbSfMqJvJSejJH1kP9YR3e+3lAkJBsU2Q?=
 =?us-ascii?Q?ULjJsaF37JURNojGFR+YxSRSQ2FeRlZIkjLcBMYLrN4ZlRM2q5x+TErmafTN?=
 =?us-ascii?Q?gvAsIbPenrGQe1dcyLzeuGAuG+6LhNDnVMNe05aBeUBCqcm8LzswLHGgIh7/?=
 =?us-ascii?Q?gu1xo8eLu5YpdX32+i7ob91bQDv9ARYULk5Rsnj3cgE4zYa/j8F1kpnCjgVe?=
 =?us-ascii?Q?kXuE5pA11RmzIvxPj5q7YomsvRMJv6/qwisJF4P021Ogc6RtdpFpnoobq4JW?=
 =?us-ascii?Q?8Oue1wmWzzzjbUQvKSz1UZdg7gAg3qkR378T4IndxfBT3i1+KNy/bEIHlfmd?=
 =?us-ascii?Q?m61lhcnXGXpDSZdyl8MA3VoliV2BAyZdGIfx8waAKUNcfLDxz7UgxWpPmbEr?=
 =?us-ascii?Q?ywLYkQIfpbcod/OaXyyrjBTqQwu+KbTsNCEgCfaW0tBK7Hv6OQhorj1SpIjz?=
 =?us-ascii?Q?YWK7FyuKjg6UXeJZP2gF21nfP1nyDj2BXr9rfG7Y89SR6//9FkQcLUqSmFOg?=
 =?us-ascii?Q?y5Hq0+qlqfq13PT3Ss=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR21MB0016;6:gSmdKA3LG6M5Fpnv9I30/NXItaoXYuOH7o4ulcZIjTI/qbvwB6GQVtBCLmzKKklTzagWLLP+l3PEw9yrzzMPyww4JW4KKSTtcQ4Kz/0bFaLtU1RF0m3y5Zri7p+r8XYZSY3Ww/3wF8Fm5T4lPxPAwPS7M///ppw1NGVFoa8BhgWYe14clt87rZwDErnrWmaI7PW+lYmzWoLh7zdiKpdpOW7/CBR9JHKAwjFiz5nUCeSQ4N0dBVAT5xpbU0LtDqBweMr9TagypZLYlNPilXUz7KIjIo/ysPp4Wir5dBslwheZCkqHVtAXjoFMXvzkXfeht4FTheQEwtbSdaX3p1+cuQ==;5:GjCiaavuvJN6/DA+XsBJBIyqFhThWguY9udAaCkRDTlsCKwLedfjK2SvH0WED/CHSlHRfOJVENGIt2Nqurb4mxBRmP/JsZidTRWg4ryqmDAJV0wwLhfKLx4Bno+c+5OeV3jen/fFXfpdzGef+Tx0Wg==;24:PR7jsGSBXGfOwNueE2VpYtJMn4E0a6c9JkVc9IGbE8k1zpgD4utTmsIpeFMapfjUSFiSSjOUIhzOSD5p5Wo+zZ5iYuj9Pg8nxSTVIBcZYMQ=;7:d95fgWfDlL5NJ+lSLI6Hu7X5WW0TB9dmnL13pj5opzLlHgQmEm+p+ye4MUpdOBbT5rOLei1GQodpUJAKhDaK2gsRJdOeLl3hw0694vQjuklAQufhEGrSZvzQsa5uIqjnkr0hlSUqZiXUEtR1KbU6wSrcYD9b5rUJpn2JTl0wbiUHI7Ex3OtywDAh2oO9F3CyTA4CeJBGydWHT8sdhtMwFCmrvvfFREC7ftlHyRnwwX0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2017 16:26:44.1336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR21MB0016
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The return value of the get_files_dirs call is never being used.
Looking at the history of the file and it was originally only
being used for debug output statements.  Also when
read_tree_recursive return value is non zero it is changed to
zero.  This leads me to believe that it doesn't matter if
read_tree_recursive gets an error.

Since the debug output has been removed and the caller isn't
checking the return value there is no reason to keep calculating
and returning a value.

Signed-off-by: Kevin Willford <kewillf@microsoft.com>
---
 merge-recursive.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 033d7cd406..d47f40ea81 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -328,15 +328,11 @@ static int save_files_dirs(const unsigned char *sha1,
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
-- 
2.14.1.329.gcdd497e120.dirty

