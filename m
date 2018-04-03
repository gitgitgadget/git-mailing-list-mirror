Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0A231F42D
	for <e@80x24.org>; Tue,  3 Apr 2018 16:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752650AbeDCQwO (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 12:52:14 -0400
Received: from mail-by2nam03on0113.outbound.protection.outlook.com ([104.47.42.113]:45952
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752600AbeDCQwK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 12:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=XBmbT6E4F17jbzCvQFyVGw6vbS3o0KpfnRoCdre4xA8=;
 b=OTb00pNzbMYWY8/qJTxYvJaN2hyRoXtJPkMV6AHx6XRft8nQT+6gV+o6ZjSxVG+3VkPEdcHdGo6RJiVeXDNRun4p/Y/3xkGIDILpggqNeQdfBsTzCY8CsLtO7bvDbD+P2aPIyLAN2WKWFa/Xp4I2zC9xv4HKCTmsTjvOcJAEZ/Y=
Received: from stolee-linux-2.corp.microsoft.com
 (2001:4898:8010:0:eb4a:5dff:fe0f:730f) by
 BL0PR2101MB1011.namprd21.prod.outlook.com (2603:10b6:207:37::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.675.1; Tue, 3 Apr 2018
 16:52:07 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, sbeller@google.com, larsxschneider@gmail.com,
        peff@peff.net, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 1/6] object.c: parse commit in graph first
Date:   Tue,  3 Apr 2018 12:51:38 -0400
Message-Id: <20180403165143.80661-2-dstolee@microsoft.com>
X-Mailer: git-send-email 2.17.0.rc0
In-Reply-To: <20180403165143.80661-1-dstolee@microsoft.com>
References: <20180403165143.80661-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
X-ClientProxiedBy: BL0PR1501CA0018.namprd15.prod.outlook.com
 (2603:10b6:207:17::31) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 918cead1-3f29-4d91-c9a8-08d599833c9a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1011;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1011;3:uI6TKtMLN7gGMzXuNtULCupHJhKga5rBLCTf6zVjLExg3DSbdmHL2k3PtRDrCZK9Iwb2SYe6WqDcY3J9iJg2JuyVHNOhXF71dNATu/03zInVojRlpNmUBM4JY3G7qgVLcjNhoNzwzwRFjoU2vT+Y2tLianow3dlB6GTyojbTV252z6fXA0gBW2vZDwmwfLmBQA/XpSivZT8pYXKyJTfxcS4w64loMGhLvBqB6E5E7x1Ckz10HE/WJmP5xarsxaLz;25:gjKd23HXxXgIy7jcNVfbxJpFtEYIlRm1CbGqr/aAejAHgC779AhpvH2ucSK6MvvngAJB7Emy3gcG6N3ePX0EMZPq2+Hrfitr3DRSqkpkezzTP1ouLtLi3gGKMnpD/5ld3JwdqjQ7J9QP3FT+h+bJrswh3Pe4px9foAyYKQQ6EJ6vc/UC5viswaINxpIu7/RqFfQZABkXpMltB1K/4CCXexezTHITwOahDNBvxehvCD4QiSXJPWTKuY/YJLo/54tbBYIyfkuPvEE+yjid/FnqJLvTUNjKmAos7ZI6yBbm6Y20OqSR/bWl+1scz7KVk3lCf3vgB9mhzYY1yv3TqOjdiQ==;31:m29rKajqy/MFuUqqIrx4IuQe1tP153J/gV66TH2u+EU+m0JpQ6OHARVwfQUFuEEhn/2kYTX/3e4NR9yFpUqJiYJTwJzwhqB8CFWY5VhLEe49oYQaQvJ5+XJ8VhPpaFhy3Ahj46eu14QkYmEokXITDrS0ha859PqTqg9pCMK5jPvuSeT5HMugJ0pUuAg+qgIIQvUefF8ugOHjvf1w81nKo7JSMc+Pv30hjW9U3qPgCmY=
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1011:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1011;20:IJ+SvnH4AmYvZHfdkwHwfJCpr6IWVPknh1oKJzYvoSqZKpB91xB8eCZvv8hzG0BK7a4k0SaJJDPf7WbyUWOjRAnYy0ORNKRiNfrOBnt90KeaffXo0X/2oRzP2S/Yv6ZGnXDnUzgRz0fwJlZGvTp7ilHlVUCNIF4/cBV/06KBrbpr+g8zeYy6DBNzCnTPHRaYJPN28dAWH13fxMRGEqgPUCVnuZcXFy7cpSXCFqL9b+5VyosUtWc6TWQUaUswGQmFsG0cY4NtjScz4s1YSAshgPWhE447+ChCuyDgurRvuxUhQaVd7lckG/F3QebPQJpwTYWnmEmr/KcSrKkBmaDnCmPRHcFplty3+DV0Qs+UsqDH9KfLXXrOwaAwFOrMrbv494BK4hBDfaF29FMNafyJIjG9YDFWjICUi8/Zzx8XMz9BDpe91cYqUFDOeJVXfn6iCMYzttMsfcUv0b+ygJ7hhDMcYVtgkXMs1yhi1tX1Mrq6386OJ12q2TGBMsK/5uK5;4:hX+GvRlalaI9kek64tTi62EMCcL9yi1ahq+ekMEUQuPLRy0lYX3YvbH01WeHkptyqA9CBbt6VKrWO1j1HkFb9/vABLI6pd1bIK2MzW1Dke1oX6Pmnu8BmCk5/qee1nmPQ1TLjy0rPtkTtscz1anW3BiYQgt/d3Xis9tPN2AU1eGlDrgdGfAEmNKNXhzfyZu6hCok7s05yJxf3QfY7nido08+mdTi+9HU9qBZuMTSkfsabcqtH/33TxpYjSgNyAC93jmDK+YwHSHcj3vhrs6Y5CqS2r7tMqyY04QEv5tW/9zEUUkZIawgQqF0fsFBnXKdKaP/f0zweUG6FwBHoDMLyao3MA8nqgWFVd/O2j+tq0g=
X-Microsoft-Antispam-PRVS: <BL0PR2101MB1011C960835FAD5FD3366587A1A50@BL0PR2101MB1011.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(89211679590171);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1011;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1011;
X-Forefront-PRVS: 0631F0BC3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(39860400002)(39380400002)(366004)(199004)(189003)(6666003)(6916009)(105586002)(53936002)(7696005)(52116002)(68736007)(51416003)(76176011)(4326008)(52396003)(1076002)(107886003)(86362001)(386003)(106356001)(59450400001)(39060400002)(6116002)(22452003)(478600001)(86612001)(2906002)(16586007)(316002)(50466002)(2616005)(5660300001)(25786009)(97736004)(81156014)(486005)(486005)(50226002)(186003)(476003)(16526019)(305945005)(81166006)(48376002)(11346002)(8676002)(7736002)(47776003)(46003)(6486002)(446003)(2351001)(2361001)(10290500003)(10090500001)(36756003)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1011;H:stolee-linux-2.corp.microsoft.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR2101MB1011;23:8yryRQyQ+Ndbxntl+oR9HUUDdh1FFKrf4ToYYwQ?=
 =?us-ascii?Q?qceAiYFfU1vEs63daIMzyTRoLqYI+LwrGPNxAr011BtE/rseVAH/DxK3mgyL?=
 =?us-ascii?Q?XOIgacQJnLJzQDZT4289+jRal0J4mnQsEFJGqmxrcUfaiytoQPSxD5ICFWf6?=
 =?us-ascii?Q?dkA7mTHGKY9XaqtdrjYvXDmklyL1P2orC/G4vUihlQ/u2RF4/dF+LcQuMQXy?=
 =?us-ascii?Q?g/9hbzDqI4In7T6tdNTBCy7PHkLtrG+kPcPkCNKUCNlDwKsJkWZ+5rNsjvoZ?=
 =?us-ascii?Q?JXLwKhrPniTff2kBPKEn1r13mnHKoyByhmsXj/y56hJtlVNSNOUoIt4wfyS0?=
 =?us-ascii?Q?HWStbZ9406/W3knS3IgJdp6r7A8Hc/BAZYPrNWGe0cYdxhzCked3ny312tVf?=
 =?us-ascii?Q?/0+JeWmRKvYxfId4os3i5n/VQH4Xsn3WFMiAHEy4OHteSDtoSt40Nne8D3Mw?=
 =?us-ascii?Q?24O+k40FPOXTLs7u/Eoiu2uM84eOLqE7OgRIvQ7unCc8+yETUScFBaIwivGE?=
 =?us-ascii?Q?dkN8Itmv6B4ckDYxV6uvCiblzH1JxNtDhbT1a27J2bAGVniZS9hiBv2L2SeY?=
 =?us-ascii?Q?p0yiWTm7lhdl6x3+DpmszuI0PKaH2UzjaSj+vnKLV9SHoQY/SN9tPkRFbg7F?=
 =?us-ascii?Q?R+jYHDPwMWuYFDr2q+KNrLAy4Bg0AogAbuOOXjgVbWkGbsRWPSE9VhwKpOd3?=
 =?us-ascii?Q?lBSEs6IDilCic4oInEmOgleoBC5RupELVLR543zMomRXpnZ7Mrn7Y8HXXWvi?=
 =?us-ascii?Q?lrZLv7KWFsMPr8DwzD23Mn/7CwzL4smhp60fw44si3zacsch9GfN7RRxEVMT?=
 =?us-ascii?Q?wmZNs4XmcZKr9QDSo1xkWgNelppvzPYVBn4A3lo6ELqCPayy4fbt3L3D2Xpo?=
 =?us-ascii?Q?o4PeYitzpvlwE6LNJ7V1cqygwOr2Slwy41D43toE38phrcGh3xGhuIIt2rXF?=
 =?us-ascii?Q?Ucxw8FKlrl4D8/fo6eKgLuhtd64uplrQ2uIMevpmmOd380JrIuudrsRo2Grs?=
 =?us-ascii?Q?VoOXPcrUxO+kctcapMM84ZRU5XyP72RADak4w3el2ApBEF83nx6UJECjpv2N?=
 =?us-ascii?Q?PXckXCyScwhtJx47Av8SAv3iaB4zOHTGRUkUELhjOdtxtHzjaC3KwCVyzzrL?=
 =?us-ascii?Q?VZAddT6pECujkRc74vR2Hqq97WnWqgyy1qeiJlVl+rQZxRkDzpnrJq11qG5k?=
 =?us-ascii?Q?7NXcODwc3ygz7HEGIVoK9ZhIspw4nF4VGzc51VXJ6R2u5gll7ahR8OcyJT+w?=
 =?us-ascii?Q?po1B3RKJDjqWPyWblm5ftQb6Ycp3Ot2VEA1W1S6rKDrLHlfb4MFhj++uUltO?=
 =?us-ascii?Q?S3NsvZAwyvnS8RO8/9G7ToYJwtqFjyAHvBs6k/UnqmUKAp1aU4E/suRWK4os?=
 =?us-ascii?Q?MiwlzSBO2f4Ih39qhIHy2iz8KcQM=3D?=
X-Microsoft-Antispam-Message-Info: 5M0X+1FeoYVnpd+Z+Z4JJiWNzmZ0ghwpjqRb6RnKCZWuHQVbyMrZnHdgCCmkwkzQuDeeJAtrmwYz/Czcy6tjGiYHUjCtIEgKki0Qq3V8LgGsQMc+gwayIprGjlhKt5/h2wTbLUsa4jhuk8CxNDG/1iTlAV1ODS4Lv1Hw9+Wxv1RCYh6v4iXFbuWewGpHbSnY
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1011;6:waTEfGE/QVbsrbp82CdrQ5ZnT25giWIZvfG+U/z1jRvdkDsskkVqmlv/vA4ZPULbA6aedT2tR3yJZCv4LcHHn7qv27Y/HhH/XkH/EC5yxVVERds0ijNNlQh97aJzFkXWm1F0L8wZGNFpJ2HRshd6Sj+txFg39jLfo2JVPKyRhv4C7vx+QFP6xU4M52a021idy+qM3YsbkDCCo7KxQbUJRmisPXdQP3NHf8kvbfXtWqgYAYK670Eggils+HfOiV2iEDZoIvMsqwGe5JeHW2087uz5fqs+i0giHS+TqQ4Vr5n+OKk31qltB3A9NEprTwvElyge1G1b5OrC0XmH4bV7lIkrq4Ci7O9Faq8STwujeA8nAqMGFWHllIGx24bkfV1D1c29t3moRhxcGwNLzf3uJWwB4uHR3sUxIKpjW+Z+izRQpmqHycgbk3gENfG+U4lf4J8ItK0KF3uP14pXyHYDvA==;5:ufRAA6IkPeEbv5oG42ODGTm0Iv6PrdkZhdeCfHWpUZRkQwIV9Io4m4W3UNSTHelcvzk1V434O70k5OeRd8NSRZgou2gtuc5jIHtQF5NtkDhm3V5Cv8QUwqsuhD1+X49bXHbJEXLxWCpcEVglgXsykBb2tBr5HUNWn1cGI4O9lHU=;24:FvVR10+4hf9F/guU8GLbPmz6CK0EvuDjxV2EdpykftVA8HKJZmrGbf5eBi+eLRyKFb+9xBjN8jAcPD4kt1NOoAUU3Is7QU3lKhaK1FoR31s=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1011;7:fU+P68DKEEKxeMxvloLwGXpaI42Zx+mPYjOH+yHkJH7RpPjAUUA0wrJ0eMvCa6V7Uq4Se/5hhHJ8A2qd+TX5ie4trCgtR/N1otNzIpP/SIq66pHz2NaKAJaXvIRZlfAx74gcsCBeirzSslq8vWxOBdq4tnVXa5jQfiTC2nbqZvIfLbHt3X0OpbV8UWu2Y6cd12gS9uGgORM4lxjmAoZsXFapFhTVKUdSHreQ3uFhryGNKqIE7LA4JNXsWzkfUyU6;20:gZucDWQy83lSrKLcPafeViA/dOp2bA0UVdIz3Rd/FGmZJDUhLrhtITsI4owVbsoRzZArn735qLpmqzFSxyWHOcAgE30VOC6F0a4fA2QSQNEF88xA85j95z4rNhvhAKumSFszmjK3gv+GjPH6yBD8M44tMUHRm92urhPRNqDVCwk=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2018 16:52:07.6679
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 918cead1-3f29-4d91-c9a8-08d599833c9a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1011
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Most code paths load commits using lookup_commit() and then
parse_commit(). In some cases, including some branch lookups, the commit
is parsed using parse_object_buffer() which side-steps parse_commit() in
favor of parse_commit_buffer().

Before adding generation numbers to the commit-graph, we need to ensure
that any commit that exists in the graph is loaded from the graph, so
check parse_commit_in_graph() before calling parse_commit_buffer().

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 object.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/object.c b/object.c
index e6ad3f61f0..4cd3e98e04 100644
--- a/object.c
+++ b/object.c
@@ -3,6 +3,7 @@
 #include "blob.h"
 #include "tree.h"
 #include "commit.h"
+#include "commit-graph.h"
 #include "tag.h"
 
 static struct object **obj_hash;
@@ -207,7 +208,8 @@ struct object *parse_object_buffer(const struct object_id *oid, enum object_type
 	} else if (type == OBJ_COMMIT) {
 		struct commit *commit = lookup_commit(oid);
 		if (commit) {
-			if (parse_commit_buffer(commit, buffer, size))
+			if (!parse_commit_in_graph(commit) &&
+			    parse_commit_buffer(commit, buffer, size))
 				return NULL;
 			if (!get_cached_commit_buffer(commit, NULL)) {
 				set_commit_buffer(commit, buffer, size);
-- 
2.17.0.rc0

