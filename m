Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 073A81F404
	for <e@80x24.org>; Fri, 23 Mar 2018 14:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751897AbeCWOpN (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 10:45:13 -0400
Received: from mail-bn3nam01on0117.outbound.protection.outlook.com ([104.47.33.117]:25505
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751827AbeCWOpF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 10:45:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=zOVash538xSVo0K2zW+mJPlIcHrX7Sk9c8lhI9X+Cfo=;
 b=LCaHotYFSYtYiUB0M+7ln84A2ZRgwkmvbAmVA0sqoaVBwkbJL0vWW4WkaQ60F04bOYBbjmbB0TwKxC3yz4PPJOjIX6RqE0wezaCLY2mjwjtBQEjSKq9J9Wx3fAcu/BW48XdUSOOqBLCP17Mf4uZUPKAU64p3VNBz+PPGQ/SWXLs=
Received: from localhost.corp.microsoft.com
 (2001:4898:8010:1:1060:bd2c:4297:50e) by
 BL0PR2101MB1105.namprd21.prod.outlook.com (2603:10b6:207:37::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.631.2; Fri, 23 Mar
 2018 14:45:02 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jameson Miller <jamill@microsoft.com>
Subject: [PATCH v2 4/5] Move the reusable parts of memory pool into its own file
Date:   Fri, 23 Mar 2018 10:44:07 -0400
Message-Id: <20180323144408.213145-5-jamill@microsoft.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180321164152.204869-1-jamill@microsoft.com>
References: <20180321164152.204869-1-jamill@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:1:1060:bd2c:4297:50e]
X-ClientProxiedBy: DM5PR0102CA0021.prod.exchangelabs.com (2603:10b6:4:9c::34)
 To BL0PR2101MB1105.namprd21.prod.outlook.com (2603:10b6:207:37::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 434cca2d-c02f-488c-57ac-08d590cca95e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1105;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1105;3:X+ot2uw6V6x4/ydJwqPdKaV0EKYM0hU1J0I95k9ZAdBmm8/egXiXdaEOYwq7lAzTseeqPqdhScmQLm9ZAR3TkPMi25VNxWY5RLnXI15QSMLVeKVxoNs4XmUnOeonOn4mAYlaAfEcocO4JH+7hEf49nFQmO/4fsiagWMKApEcbNwlmBHoYNl5AcSmF/8iz90WoCR8ZpPRy41tE+h5xU6KNyqag/3Y2V7gNoEQGHSayUc3KPdT0al4GS4yBmwpd7Vb;25:u7bGKoJjiRZ5PQD9w4C/oNKLMSyBFu3KuxnHCeJHPhWkvMl4SXnfXY2BSDnenpt3RLeRMxW56oiifRXEJQAwGd393bdHpK5K63N6f1jn71OQs7ZoyKy7DiiSOj/QpIPCNl+xPiVzWBoUp2E1XG1oPgHdvZKM/Yv+9R6mfiJQSXqoF5Dk+LSh052QHD//lNy5y1uagmdFpQpcSN90rmQPVeNUYYsC8u6GVVXmVflu2Hq33p3nGapFvUnW3YVy8p3wk+7fzwLPq6ykawr7rSe1r4AHW9+dFG6AjeyQMXH6E4//1uQ1N4fHmZOXtWXMSsC7SEWlgh6HAZJH4UyE8nydJQ==;31:Hsnz2aKmF0jZ7AR9NZdgf0GNv4b6O5EpqLHJlDBx0XjPjRSykxZWgDPTR5Fk2cNljPkA3p1F8AguA4TfEtWj7hW3iIdhGLTHvKJQ+hd6C6tBIaMgIK08gCWJ6E3XD8zHPObW4lm4U/ouczN8v5TOkP4CEAASu+MJ7y2hcIpA9XjKG7cyE3q2EhgbRLPxX8IoJBwE95TWQQ8MpOqnRsMvkm6lcdnFB4oHNvVBDQ/XDnU=
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1105:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1105;20:HnpmhjKvDUsrc99mqx82zBleWePz96PNoBOhbPCYU7/svNG1w48BV1XLXDnZN24tYpapd0RWfLboU4hmSOFTMYfPN0klXIObJrqPpsL4TMPrNqeOYBiiou8DW6uKeYxmnEUzPTg0JNR29+sta9LcBF8Vc+50WFw4HFc8KMZ2rnqkDLVOaDH29wfx/SR5jfIMyxc9Kq6x2cvUwtHFdxANDf6XFRxB/VwYtYO5L7Y2CyyDM2LjlYdVpD4Mnsk7x2gtTatFX2DbussmtULwyOeUMDjCJB7N8vjWqNUM336q2dZrzri3751djR2dJGDvejuKyyOukDOOFYd2q3dY5vjBUCmlx/y+xWThmBMT8n5pa5f4b92j6Lm4uyMf9YC4T55TaauK5FRzFmy1VYuTKpoo8EXeoaDvvqX9FIriqLgJY0CSMC/iWLP7G3P62t7j2+I1AT0n4ZznCNB4zFVEbJJJCR/gj8z++VEKZ58pXwWZm/9j0WII5E7LX0zOLDdaSnUW;4:Vha/0LnJPEtTkvqXAzj7zjq/dzirQ41uDaKWXMoJZm9P1ekoK/E/cXSl7Lcve0b4rBaCFMy8HZgZv5ssGaSFcQAWIWtF/l5rMYDXyeWZecIP4mCTOzbtT886MjwmpTp38zCTcumGsBiXoc/CQ7KZTDupW4yEmxycY9iHAJOhwfMQSopbplLO31onysf74uoQiHw0iimSTYsgbPfHrcQK6qy6bkvafIIAYuFe+UJeHISx9rpCML3ynGFjryMYMSjWtpifO8IM0epDZsiDj2292X09kYbmP1crjC3P1T2upFNCXD30p7GwT3JncJuvxydhPM/ls9M4oe1pWu3T06YNtmDx5276tnobvfBZu5cVxGo=
X-Microsoft-Antispam-PRVS: <BL0PR2101MB1105919F8F38E5D9E81940E5CEA80@BL0PR2101MB1105.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(89211679590171);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:BL0PR2101MB1105;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1105;
X-Forefront-PRVS: 0620CADDF3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39380400002)(39860400002)(346002)(396003)(366004)(376002)(199004)(189003)(305945005)(446003)(46003)(11346002)(36756003)(6916009)(4326008)(5660300001)(2906002)(186003)(68736007)(10290500003)(25786009)(7736002)(107886003)(16526019)(86362001)(2351001)(8936002)(8656006)(22452003)(76506005)(478600001)(50226002)(47776003)(52116002)(6346003)(316002)(52396003)(97736004)(48376002)(86612001)(8676002)(81156014)(81166006)(51416003)(7696005)(1076002)(105586002)(106356001)(76176011)(16586007)(386003)(50466002)(2361001)(53936002)(10090500001)(6486002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1105;H:localhost.corp.microsoft.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR2101MB1105;23:IJAG3NKC4CYMY93FgmyYa88/jnKMJXubU6gi3gQ?=
 =?us-ascii?Q?CpwiS0wjvg/bogpIat07bkfHmOAlMqR/Pvoj4QmOsijguSmz5YxTVq0GwYPz?=
 =?us-ascii?Q?Dyj7aviGja8XEhdq588OOtDtQSvt+HLj5BFibP2hBv9ffJr0CcpoNOnjwghw?=
 =?us-ascii?Q?6OoY9AfOi0oVYERpb1u/qxx/Eowms6OxabWL4PaCzGwxk1sj8q5szBs/sYJQ?=
 =?us-ascii?Q?x9dTqpJgaMPIY532hl/SR5kC1XYOwLNbAI6pn+o/C+jR9nV1SSGIjMlMJ1lo?=
 =?us-ascii?Q?Uh6nP4psMx1A69ieWvVeoLmfoId2c5NsG7u+fNBWbXEj5gbjyScph8d/xW83?=
 =?us-ascii?Q?6/HHul7oHIdKboglpyfBPelkw8sfE7qzIcOnalAJcMZDl0hZJnyuerSYd+W2?=
 =?us-ascii?Q?Blu/C2JbphxD/tHUA0cizdPTU3r8V76YjMHevdSinZ+QmmZZpMNgwt3WAvlY?=
 =?us-ascii?Q?I533Aa4WPGeFoHE+iyCUQKMCnAdYXkWnAd2OklEyx8KGY8CqDmGzVuF4Ac0s?=
 =?us-ascii?Q?FecZ1zLOgB2cTxna84CZ3V44pRvq67MfVgM2GXGzl5APMjhKN9/PR+SZfJPM?=
 =?us-ascii?Q?wiXO/1ZolLmEGmGg0dV4v4273szdv8wHaOgn761p0fNvk1kgD5mJTq87Kz4C?=
 =?us-ascii?Q?cGN3xjhxQpwVcUOH/07gv8XF49xUEeJJSIYSejstMTWxr027zfORNsp0DdTV?=
 =?us-ascii?Q?A1ITR9W4V38TTkAubEKo/mzf/kFwBMwsKEx3G/fbClG3onwrl4GuV5xmy3rW?=
 =?us-ascii?Q?cIFiMvGGO/MuS/+J84bsPNDtD0ujTV0yX40Hvtjb/anz1jchdEtWrzqtrb1X?=
 =?us-ascii?Q?Ur9ymZ7dLSMTQIvNZSKAYHleMhHeIMMC7qnjON8aruoMCaK2US0lqqC65ozs?=
 =?us-ascii?Q?Zd3b4kh/C6SIJG0/hQSeAPo+6erp4pdkV5f1pudz8owqd4u+l96M3ZBWdrG2?=
 =?us-ascii?Q?JGGGF4zzGSsbSoMUR0aToCleRE7Z4CSsqpyJqV9rpybH7R4hqe8mPM4+nUJN?=
 =?us-ascii?Q?BLljLlcOYIXPf4qOpT893yhgeasIZkemGWYyd+DXGtq5trRKrqGdZgD6hGUx?=
 =?us-ascii?Q?X3VSeAl4PVo/2wO+kAZ76XLYRVUrMFR9PsBOrvCv5ohbszv2ok1WjEWYeqYd?=
 =?us-ascii?Q?n/nDCis9iJOedYBjn88E/u1v8qg9TPTrg7guzouEZK/kkYWXbMSqHqVz2xly?=
 =?us-ascii?Q?Q2J5xxC9tDjqyqZmaqCbnvh5+rKzuMl/Yxp3gv4Ib8wwPXvfwGDIYSxaPMiz?=
 =?us-ascii?Q?3QHKPjIx8hTdf280L7Td8vdGFh/bcRui3NyDo05Ek7z9xaJ5w5YGwmideKpM?=
 =?us-ascii?Q?qQ9WIM51rUNEF4zEahWXVLjA=3D?=
X-Microsoft-Antispam-Message-Info: 9B8yY8KxlH35lmxAbrA9xnLVx+ruSGIdfDqkjofcOjlYVhSEG6Hxi6Xuw+v8oSwFSP0cHDMjDxg3eFPje9ScfJl79PfwzX8/PRLONwiurrij6U8a5BgPPoqylmYqOPcU8rCEQUecTB7BXnB5ePojuW8uaX8HE7c+TJb+vMMk7gyRcj0XN1T6mQp1mgK0wnAl
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1105;6:1tjBDu6K/8lK5oGBbySnsgSV1YyKVw5DQqjKnB4nS+oXgLfOUjB3eJdik0SMpEY4YLbEUr9mhUkppZNpCyB/70aJQOl6nR0MkoPDDJ4gwHQKCZkf0Hr4XSyjYUNq7EdWAD4nSQ9m8OodGIR7NQGwaWULm/AREsWzCX9yboYsLK/KNzc83/nxblnXAUlvOOzx+EPbTShKpwYGasXaESro/E6Ak1tExA6H92nQlQjvyO7LM5Gz9xnYUIJqKPrynwOzut4n2GJO5uM9qPsGbsQU9VtAxW78bwvCEMt4SDDiQtUGCCHs6RaVYHRU1wb0ym92xq0aHa/jESWvpDYidcfen0dJw4pSdV6ABiCVmz7rM10wIYRhhRr56qUDNoFIkLrt0ttX63fSZmasw29Dv3SD6JZLeLzRB2XC8ci/R5U75R6xDBgHfPTE3iuWtPl6tg05E/G61BX0vdOu61kGwIvnTg==;5:ovHZ52nOj7LW3+Yy/S5jEaIMTspitHlHm5UvfEwfF9pDtvYoMvjrXVzQ4G5UVvelH5vMaEfJ7ofx6bD7B+vyAn+6qHU+YUiIyQpjTiapf7ZLa8V3wU8YqHWJ358JJGxf4+ofIN8kSebBArW0Mjaf4hJOl4YEmQo968w8FtW1hcM=;24:2cmV+KEiaSDij2AIfFcga8eZ5/8jhtUgqlWWfdfhHW4tmuE8MFnyHIsu3vzBK9sXf24Qr94M+IJOlQmV5Xamm5RBrZ949JUwFPQgh61SO4Y=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1105;7:hSXhfT4U1fvckb2pAH6rHVYTI+bMf/70gP++DlZHfesEA/H/1aCNmqKF+n1qaxoFvpnDOE6kZTC5esfsQy+riTp3WDwUBvXYwQOb3JCGns2ottNs/ChlLOa1WwPgPPQy+ixKljOL+q820JlvRooHqbMUX0z6f4a6VvofhnDi4sHIJhYB+OEBUZY23YqxbGOS7UdCBAQ2H2zFfKOReOa7/GMjfuuOBqt3Nfpu7JjdDnfaPDJKHuhjppuekSvqkgSz;20:VZeyH6R6WjxSgNYKcSTqSTopNeFJ0TD4V6mwFrir78JI6jEUOAIdmHOshN5BWwPAonZeNLGBWB2v5QMuCK2YQ7y5x+2h5oxM/QjnFK/dYmrZ2Yp5weTAj2CDNPYvII9cl3r1Le07O+na9hLfWjRWB6qzuL33AgT8gkXSmdatgUQ=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 14:45:02.6219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 434cca2d-c02f-488c-57ac-08d590cca95e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1105
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This moves the reusable parts of the memory pool logic used by
fast-import.c into its own file for use by other components.

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 Makefile      |   1 +
 fast-import.c | 118 +---------------------------------------------------------
 mem-pool.c    | 103 ++++++++++++++++++++++++++++++++++++++++++++++++++
 mem-pool.h    |  34 +++++++++++++++++
 4 files changed, 139 insertions(+), 117 deletions(-)
 create mode 100644 mem-pool.c
 create mode 100644 mem-pool.h

diff --git a/Makefile b/Makefile
index a1d8775adb..1e142b1dd9 100644
--- a/Makefile
+++ b/Makefile
@@ -832,6 +832,7 @@ LIB_OBJS += lockfile.o
 LIB_OBJS += log-tree.o
 LIB_OBJS += mailinfo.o
 LIB_OBJS += mailmap.o
+LIB_OBJS += mem-pool.o
 LIB_OBJS += match-trees.o
 LIB_OBJS += merge.o
 LIB_OBJS += merge-blobs.o
diff --git a/fast-import.c b/fast-import.c
index 519e1cbd7f..36ac5760d6 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -168,6 +168,7 @@ Format of STDIN stream:
 #include "dir.h"
 #include "run-command.h"
 #include "packfile.h"
+#include "mem-pool.h"
 
 #define PACK_ID_BITS 16
 #define MAX_PACK_ID ((1<<PACK_ID_BITS)-1)
@@ -209,26 +210,6 @@ struct last_object {
 	unsigned no_swap : 1;
 };
 
-struct mp_block {
-	struct mp_block *next_block;
-	char *next_free;
-	char *end;
-	uintmax_t space[FLEX_ARRAY]; /* more */
-};
-
-struct mem_pool {
-	struct mp_block *mp_block;
-
-	/*
-	 * The amount of available memory to grow the pool by.
-	 * This size does not include the overhead for the mp_block.
-	 */
-	size_t block_alloc;
-
-	/* The total amount of memory allocated by the pool. */
-	size_t pool_alloc;
-};
-
 struct atom_str {
 	struct atom_str *next_atom;
 	unsigned short str_len;
@@ -646,103 +627,6 @@ static unsigned int hc_str(const char *s, size_t len)
 	return r;
 }
 
-static struct mp_block *mem_pool_alloc_block(struct mem_pool *mem_pool)
-{
-	struct mp_block *p;
-
-	mem_pool->pool_alloc += sizeof(struct mp_block) + mem_pool->block_alloc;
-	p = xmalloc(st_add(sizeof(struct mp_block), mem_pool->block_alloc));
-	p->next_block = mem_pool->mp_block;
-	p->next_free = (char *)p->space;
-	p->end = p->next_free + mem_pool->block_alloc;
-	mem_pool->mp_block = p;
-
-	return p;
-}
-
-/*
- * Allocates a block of memory with a specific size and
- * appends it to the memory pool's list of blocks.
- *
- * This function is used to allocate blocks with sizes
- * different than the default "block_alloc" size for the mem_pool.
- *
- * There are two use cases:
- *  1) The initial block allocation for a memory pool.
- *
- *  2) large" blocks of a specific size, where the entire memory block
- *     is going to be used. This means the block will not have any
- *     available memory for future allocations. The block is placed at
- *     the end of the list so that it will be the last block searched
- *     for available space.
- */
-static struct mp_block *mem_pool_alloc_block_with_size(struct mem_pool *mem_pool, size_t block_alloc)
-{
-	struct mp_block *p, *block;
-
-	mem_pool->pool_alloc += sizeof(struct mp_block) + block_alloc;
-	p = xmalloc(st_add(sizeof(struct mp_block), block_alloc));
-
-	block = mem_pool->mp_block;
-	if (block) {
-		while (block->next_block)
-			block = block->next_block;
-
-		block->next_block = p;
-	} else {
-		mem_pool->mp_block = p;
-	}
-
-	p->next_block = NULL;
-	p->next_free = (char *)p->space;
-	p->end = p->next_free + block_alloc;
-
-	return p;
-}
-
-static void *mem_pool_alloc(struct mem_pool *mem_pool, size_t len)
-{
-	struct mp_block *p;
-	void *r;
-
-	/* round up to a 'uintmax_t' alignment */
-	if (len & (sizeof(uintmax_t) - 1))
-		len += sizeof(uintmax_t) - (len & (sizeof(uintmax_t) - 1));
-
-	p = mem_pool->mp_block;
-
-	/*
-	 * In performance profiling, there was a minor perf benefit to
-	 * check for available memory in the head block via the if
-	 * statement, and only going through the loop when needed.
-	 */
-	if (p &&
-	   (p->end - p->next_free < len)) {
-		for (p = p->next_block; p; p = p->next_block)
-			if (p->end - p->next_free >= len)
-				break;
-	}
-
-	if (!p) {
-		if (len >= (mem_pool->block_alloc / 2))
-			p = mem_pool_alloc_block_with_size(mem_pool, len);
-		else
-			p = mem_pool_alloc_block(mem_pool);
-	}
-
-	r = p->next_free;
-	p->next_free += len;
-	return r;
-}
-
-static void *mem_pool_calloc(struct mem_pool *mem_pool, size_t count, size_t size)
-{
-	size_t len = st_mult(count, size);
-	void *r = mem_pool_alloc(mem_pool, len);
-	memset(r, 0, len);
-	return r;
-}
-
 static char *pool_strdup(const char *s)
 {
 	size_t len = strlen(s) + 1;
diff --git a/mem-pool.c b/mem-pool.c
new file mode 100644
index 0000000000..992e354e12
--- /dev/null
+++ b/mem-pool.c
@@ -0,0 +1,103 @@
+/*
+ * Memory Pool implementation logic.
+ */
+
+#include "cache.h"
+#include "mem-pool.h"
+
+static struct mp_block *mem_pool_alloc_block(struct mem_pool *mem_pool)
+{
+	struct mp_block *p;
+
+	mem_pool->pool_alloc += sizeof(struct mp_block) + mem_pool->block_alloc;
+	p = xmalloc(st_add(sizeof(struct mp_block), mem_pool->block_alloc));
+	p->next_block = mem_pool->mp_block;
+	p->next_free = (char *)p->space;
+	p->end = p->next_free + mem_pool->block_alloc;
+	mem_pool->mp_block = p;
+
+	return p;
+}
+
+/*
+ * Allocates a block of memory with a specific size and
+ * appends it to the memory pool's list of blocks.
+ *
+ * This function is used to allocate blocks with sizes
+ * different than the default "block_alloc" size for the mem_pool.
+ *
+ * There are two use cases:
+ *  1) The initial block allocation for a memory pool.
+ *
+ *  2) large" blocks of a specific size, where the entire memory block
+ *     is going to be used. This means the block will not have any
+ *     available memory for future allocations. The block is placed at
+ *     the end of the list so that it will be the last block searched
+ *     for available space.
+ */
+static struct mp_block *mem_pool_alloc_block_with_size(struct mem_pool *mem_pool, size_t block_alloc)
+{
+	struct mp_block *p, *block;
+
+	mem_pool->pool_alloc += sizeof(struct mp_block) + block_alloc;
+	p = xmalloc(st_add(sizeof(struct mp_block), block_alloc));
+
+	block = mem_pool->mp_block;
+	if (block) {
+		while (block->next_block)
+			block = block->next_block;
+
+		block->next_block = p;
+	} else {
+		mem_pool->mp_block = p;
+	}
+
+	p->next_block = NULL;
+	p->next_free = (char *)p->space;
+	p->end = p->next_free + block_alloc;
+
+	return p;
+}
+
+void *mem_pool_alloc(struct mem_pool *mem_pool, size_t len)
+{
+	struct mp_block *p;
+	void *r;
+
+	/* round up to a 'uintmax_t' alignment */
+	if (len & (sizeof(uintmax_t) - 1))
+		len += sizeof(uintmax_t) - (len & (sizeof(uintmax_t) - 1));
+
+	p = mem_pool->mp_block;
+
+	/*
+	 * In performance profiling, there was a minor perf benefit to
+	 * check for available memory in the head block via the if
+	 * statement, and only going through the loop when needed.
+	 */
+	if (p &&
+	   (p->end - p->next_free < len)) {
+		for (p = p->next_block; p; p = p->next_block)
+			if (p->end - p->next_free >= len)
+				break;
+	}
+
+	if (!p) {
+		if (len >= (mem_pool->block_alloc / 2))
+			p = mem_pool_alloc_block_with_size(mem_pool, len);
+		else
+			p = mem_pool_alloc_block(mem_pool);
+	}
+
+	r = p->next_free;
+	p->next_free += len;
+	return r;
+}
+
+void *mem_pool_calloc(struct mem_pool *mem_pool, size_t count, size_t size)
+{
+	size_t len = st_mult(count, size);
+	void *r = mem_pool_alloc(mem_pool, len);
+	memset(r, 0, len);
+	return r;
+}
diff --git a/mem-pool.h b/mem-pool.h
new file mode 100644
index 0000000000..829ad58ecf
--- /dev/null
+++ b/mem-pool.h
@@ -0,0 +1,34 @@
+#ifndef MEM_POOL_H
+#define MEM_POOL_H
+
+struct mp_block {
+	struct mp_block *next_block;
+	char *next_free;
+	char *end;
+	uintmax_t space[FLEX_ARRAY]; /* more */
+};
+
+struct mem_pool {
+	struct mp_block *mp_block;
+
+	/*
+	 * The amount of available memory to grow the pool by.
+	 * This size does not include the overhead for the mp_block.
+	 */
+	size_t block_alloc;
+
+	/* The total amount of memory allocated by the pool. */
+	size_t pool_alloc;
+};
+
+/*
+ * Alloc memory from the mem_pool.
+ */
+void *mem_pool_alloc(struct mem_pool *pool, size_t len);
+
+/*
+ * Allocate and zero memory from the memory pool.
+ */
+void *mem_pool_calloc(struct mem_pool *pool, size_t count, size_t size);
+
+#endif
-- 
2.14.3

