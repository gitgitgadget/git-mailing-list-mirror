Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 962401F404
	for <e@80x24.org>; Fri, 23 Mar 2018 14:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751819AbeCWOpD (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 10:45:03 -0400
Received: from mail-bn3nam01on0111.outbound.protection.outlook.com ([104.47.33.111]:49120
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751670AbeCWOpC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 10:45:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Puhk4OZ8qa+38sG6Sn698ZVLKWAYYj67Diz7Kz+iis0=;
 b=ocqaJrmxf2jVxLqCbhlaz6d7Zn6FkUR69WnzEcJ7DRleyrNaJ3e/e08FrOnZiYGH2bspXCFT1CeXFNPWbC/6GXol815Q41S0CEynMXwtz1wleA8PVW7wfilF2hy6BBqjunC3cGQiIMkE+0J1n+zzCNRrwdl+D0V3qjHE7atFHdw=
Received: from localhost.corp.microsoft.com
 (2001:4898:8010:1:1060:bd2c:4297:50e) by
 BL0PR2101MB1105.namprd21.prod.outlook.com (2603:10b6:207:37::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.631.2; Fri, 23 Mar
 2018 14:44:59 +0000
From:   Jameson Miller <jamill@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jameson Miller <jamill@microsoft.com>
Subject: [PATCH v2 1/5] fast-import: rename mem_pool type to mp_block
Date:   Fri, 23 Mar 2018 10:44:04 -0400
Message-Id: <20180323144408.213145-2-jamill@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: db7052d1-991e-49b6-a466-08d590cca77f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1105;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1105;3:J5j+oA4rxv2IarkxEWicBPLHbOTDYlNJz5B+aoz3ixQZs97d+vS3VvUVCpWULqyiJvE6B3FmmZz70ZyDXVvP45dzlbO1gG6Q464kwVW69tnCugOBMhHkoeI1Xd0jnBHzfGhvPmRWpskhWpYYSouC1fm7EgQuLp8HTiiIojsgbm/EufqmCK09A2Oe8zru26suFUqvr7ZPrDJG4I4MZMKZ0iqMJa+Zxkm1IK1VBCTNnc1RJkgt/poerTAk/ocL6T2m;25:Fliita6pKOngKZymKaQrtEjqA2MJrVtMzUKe4rZX1UdIavEEkOJbkMy5xqMpATkX0la5c+GE+G6BzhUFOoBTZAma67pTCUYuQu4IXhPgDtizuoMo5Ak/cVPq6rb6zGIHT2B+bq9FAHo6PlA2rPFyEiSin+xy7ko9wYhmyOjf3GISfq430RllNakglcHUMJw/seDv+zDgTMVze/EY7yAYm29hbkg83tV5pR4XiUIzb9DIzBk/E+C1LgkML4q29z4IbgTEQQCsa5iVJxW5k/WJ7ZjdNlOGcgZMtVKnqNgqhd11NULPoVZJHqEOeO2uS0Z3ll5Y0n7abJbHWDj0VvANHQ==;31:RZJV1HsvzAg1hAjwoaeWDp2xzj8iizEMRBeccskVefferjh+pLI2BIGWJcinxllcdyHFF14vxYBXe7bhZt5L/B17wBHgT7L2x1BTTHNvgaEK1ry+n/3RwJor/Xg1KFFByNBJCYD0LMSrBKMzi7pxTBBbxH06XVdLUq16EoJq0ZIshZwlCNc5hWuvgl/5VdHKFGAEq2TENucWMiq4jVD+tAzkbbXWw9iHQnhwdUT3lW0=
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1105:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1105;20:9T04euOjQN2x5xl+8t7LyouTpbwc3xbgzSt0gsVJU9xrwuZrkj92B49cbl1X1uyrGG7dx8N7sMszR7pDsnsXYrhSGx6w4yQrHAcDC62S4IKaxqWS45j6mabYquCljTXT0GTi8BOSJHOBQHNHx0HvgMAaHnqvd/8I+3TW1Roq/VPrdzfqmVB3iP27GmR0tDtT0Rl1WhMLx2u+O6v+fR8LGIZzly1W94pggtPWSkm/FKa0sZ3zFfMepjd6kn0A0KBNu1J1J16QHazkJrIaATLbowOk4hO568J7tNYHTX+2SQ5fA2M+dCIwzMvQhtnXP/FVDwWxdhSEpE8YnUKRubumIyABcdOMmpgrjRIxt3lPpnqv/e81BsPhelPgDrTpGj9ndaWSWvwJdE9T8cMuMHLp+Evuz2vJTPYkKnBxrjevbkaFsVHQye4aFPzvywVQl3Jy9ODRdN5ZBQWEwcsczY6nTwObOvV9Rh6aZIgh62BoikySOwdeHPDvJltPrasI8NXb;4:kkWm6JQxKbq8cixsOyzXylqEMVCFkOYAsUzaQthtHCF5oxPywtvfprrxG/Q06WAVfUHYGNcwv5Q9zADkQwYmk7/Wmu0VMUGFrESdJiHmthq0dSUq51yzzX1hB0FLpbIuyYaUD8pyMa1frfMctJdoi1IUvpeI/RicCiQ93yoDXuMcUwPS/LEQgYT27kWIF0MqLppxGFbURymirIXEUm/ndavJSxDT4i6ReZxw7lhzNh3oLyzYigWYmn+EWFLcyMUqbOUZC4vXC6x/IbfsUvVkSHzfZKF4v3fGgGOP9DkFfwCMIDeqatbkj+8EQaBSGlevQuaYXoaPUvABJDN3jYjC9gSA1in/uFPxBT7oQdPXAGU=
X-Microsoft-Antispam-PRVS: <BL0PR2101MB110599F34E04CD770EEC875FCEA80@BL0PR2101MB1105.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(89211679590171);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:BL0PR2101MB1105;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1105;
X-Forefront-PRVS: 0620CADDF3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39380400002)(39860400002)(346002)(396003)(366004)(376002)(199004)(189003)(305945005)(446003)(46003)(11346002)(36756003)(6916009)(6666003)(4326008)(5660300001)(2906002)(186003)(68736007)(10290500003)(25786009)(7736002)(107886003)(16526019)(86362001)(2351001)(8936002)(8656006)(22452003)(76506005)(478600001)(50226002)(47776003)(52116002)(6346003)(316002)(52396003)(97736004)(48376002)(86612001)(8676002)(81156014)(81166006)(51416003)(7696005)(1076002)(105586002)(106356001)(76176011)(16586007)(386003)(50466002)(2361001)(53936002)(10090500001)(6486002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1105;H:localhost.corp.microsoft.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jamill@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR2101MB1105;23:OtwLHw4+LIJGqe6X+h4U4y5M3IFPwFAROp/ekKd?=
 =?us-ascii?Q?rSpWRaOjkpWg3jHC0sFZQwhIENy7ui6FnZ3VcRi2OQoVdnHKwm3gqLKeev74?=
 =?us-ascii?Q?uwgk4r6RVqbTy/RmU2hCJmvs7/fMqdqw9+AliqtdMJ5P/MJo5LTu7w0RINzt?=
 =?us-ascii?Q?JVfF1j26c80kbKqxxfHcgn43QhP7Kqsqoq+xLsN2V2jVzukFjpS8HkNm278e?=
 =?us-ascii?Q?bZn2S6+gzaVBfcmOW3vvZvUDzcGIkKzrelfpjFfUaG5wUd7yDWmgKeqedt8n?=
 =?us-ascii?Q?inylaojwbF+TJt/3tLhnyJxTQCVIjUAbU/zfNEOQlofUJckZcq98yc+KhvDS?=
 =?us-ascii?Q?DTRnDwH/7LSNFnm+uoLuZqTOU3dxdbAha0Mjo0DovFahXQ98twN4pZYpns/Z?=
 =?us-ascii?Q?m9VN+sj2QaPtyShDDVF/de4F9A9PP2Zf47xqUXWivrJ9LGUPFQCfZgBkbC+p?=
 =?us-ascii?Q?8OCj6xE+5eUI9EOJhIrhiLzkZr7YrTwKtXn1+TpzTwpFFXWYQiG1EYUJkPTd?=
 =?us-ascii?Q?adhkDYzwvBOblraz4odgPDEKdpVRjbKvFExMHH3ls0zobYwnY5vF+4og8855?=
 =?us-ascii?Q?tioETsdvjRk/Q6S0h7ZlPIYh/Qesk5Ei2tiTZQsztPYARDNJ9VwoG77Ekufa?=
 =?us-ascii?Q?mPaDFC85HabYAXShJiBEI3ydaERPJxvNpaJJV1PDXWVcjmzWUt9skhkv6tTC?=
 =?us-ascii?Q?C6itd1ellLWotL3DB0DnK9sPbo9f1nlhx4HXe/f1rpNRUvTndxJK6cunCGEu?=
 =?us-ascii?Q?DJv1xnZl8xmOpZzqef37cCDq7HYeSz98D0SIv920lcSWTVudW+pxTedSysxY?=
 =?us-ascii?Q?NfqMG+ZZmElkhmStWjLTBkA79U+mMa7VFYjg43q2l3eUmSRUsPACBqi0HbLe?=
 =?us-ascii?Q?BypYGJ8HKmyEDq55X/Wmp36fS9/cYhgD4TMZfb6Yn9SVwi8g7Cr1ExJCgi2F?=
 =?us-ascii?Q?2LSpdVZmXknC3CSfrzM3yC1Gi5IXLtQ4Cc1cCNLtL02cJgBHBtyG13F/6HjQ?=
 =?us-ascii?Q?B6590Gc3qKPMW4SOuPZBUFicaL1yLqS4Rk/+VJcgiSvMG0B6nI01kl/Sx49w?=
 =?us-ascii?Q?LgK72sz1NEYi0dBM8MKLVWVyv5AU+hD+rxJF5JunQyaZyiqBdr1SXG/yNTg0?=
 =?us-ascii?Q?Q0g4etZs5G4BjApKkjUvC6Bm2zURgSdpf5xmpfRj6fOfCJBdYooqqpGxUhiM?=
 =?us-ascii?Q?Y3VLScu5hBRNfxATZC8jLxVmB0rg0nwAfoAmJOc5i20St9puSE8Osw1H2Z8r?=
 =?us-ascii?Q?iBuJZp0Ekt5Jz/lG5f9vhSvrX8OQ7emiW4ky9gob3wsAWNf/Z+VAdZYLaPRC?=
 =?us-ascii?Q?EkcH0nOnV13ligKp4vBRyT4JC2BsETlegYcjsMwvh8fzu?=
X-Microsoft-Antispam-Message-Info: NgK00LjklLeSjQD2tKZOSkuRVE5CxvINOFOFF3eWZseentlK0zlwxaccxRoNmUFKfC/b3jhyrJVLXXgCpp0g8b6S+t0lP9YkcEdsRrCfTdmu1KppMwRAqnxYal20TpdhqPy6VuS1LvapHvpeAW3ifbCFTzG7Kl53YmBjsPGMFVSSwTOB3oLUZ41HOkoeJ95T
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1105;6:A4Zm7MSPZoxvUV9z5voHwXvAe7rlR4b8MWAQXq5bSdPsfjk1CyhFsfTUwbd8Qs1aOOkslclqq98OfE7u1avj5haZqdpxqpP4r0HQr3WyXJVWNcEZKQwrIOHHpRzFsl2duq8ruoCSZkd+4gpBcrjKe8H4VWge1g6m1gApGumfIi0dwyIScYMtrQMgQQR34TyUewQ/i75TURgVjQm1YXga9v1yBhVNndPWNRM+Qi3ZedKNBhYCNxi/srEnWoFcOTojMjLhiHFM+31Uf04bmKCkbPnUULgqQJMpwAVlZhd2IbCRU4BlZk22YL4Hd5f8k8bMlborihhxfxpMKx4DKtOVQFS8Zdu150jP7f0Kn59pHD4LMgEGTAh+WAL6jwT9DHNqTFsDYJlXtdmHA3WXSiXlmPz8ou/3GCwLXPVfHQzv1o74h41XNfM9ZRJ0D/gC43rC4zf5MJx6AM2w4E9Neou/Xw==;5:oe2oBtgM3dWK9Z+oUVe1Je34icO1QSTkoBDuOsNi+BqQjY5q0dVnzLvJ05pODVyL3YOxtuO2VtneSwc9mPSdkolvHG5P1/eRQmGFYvbytoPzRm1KEH/S10BfdXjuRvzLC2LRvpt/h/a2FSJxuaZ6xzXIS7tV2yqrK2U5gcSwoLk=;24:1Dxt5meh+txslUxWvlYme0iPHghBdsbTG30+7pbhKN5uHt8HJr1kbqJjx3h5uroDCq7WwjsVHu9CWUtlacWnA3J5TwMy2kd9OiM7abM+5fA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR2101MB1105;7:ikJCtF0eYk4A71j9CJCgaj8OSnv6C9+GAv+6ldC7CRjn547/mHDoLkOWVGknVw1P+TEVdFJreylgCzc98qcI3Ot6ycRniw9vekmDKcZIYpL5vde6ov/1wvtR0NiBDBy4bqBmjkP/4731YVraWDsfHS5UnP69QYY3IXDiFaRjfxvAluXm16MopxK7owFNtNON0rvABXRbjLU4EmYvMI3nY/b5+Dlm27ChinO9CqK7P1rEVqEVdcGYm17AywU24ZCn;20:iTq5rGQZM6FuwO8xe2uHYEGQDdvNghF+4A/QfY9kpO1UeKeZZ90MROARPOks2R3u4oQYMqo8qwOWYbFJISooTR68betsZQVtSEAlFh4dramtSp5FsuiESkVYtQjFFyWiol4IcjvS4HRtBcQi932b9j2lNcXn07+JCOtqTfWB4Xg=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 14:44:59.4817
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db7052d1-991e-49b6-a466-08d590cca77f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1105
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is part of a patch series to extract the memory pool logic in
fast-import into a more generalized version. The existing mem_pool type
maps more closely to a "block of memory" (mp_block) in the more
generalized memory pool. This commit renames the mem_pool to mp_block to
reduce churn in future patches.

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 fast-import.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 58ef360da4..6c3215d7c3 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -209,8 +209,8 @@ struct last_object {
 	unsigned no_swap : 1;
 };
 
-struct mem_pool {
-	struct mem_pool *next_pool;
+struct mp_block {
+	struct mp_block *next_block;
 	char *next_free;
 	char *end;
 	uintmax_t space[FLEX_ARRAY]; /* more */
@@ -304,9 +304,9 @@ static int global_argc;
 static const char **global_argv;
 
 /* Memory pools */
-static size_t mem_pool_alloc = 2*1024*1024 - sizeof(struct mem_pool);
+static size_t mem_pool_alloc = 2*1024*1024 - sizeof(struct mp_block);
 static size_t total_allocd;
-static struct mem_pool *mem_pool;
+static struct mp_block *mp_block_head;
 
 /* Atom management */
 static unsigned int atom_table_sz = 4451;
@@ -636,14 +636,14 @@ static unsigned int hc_str(const char *s, size_t len)
 
 static void *pool_alloc(size_t len)
 {
-	struct mem_pool *p;
+	struct mp_block *p;
 	void *r;
 
 	/* round up to a 'uintmax_t' alignment */
 	if (len & (sizeof(uintmax_t) - 1))
 		len += sizeof(uintmax_t) - (len & (sizeof(uintmax_t) - 1));
 
-	for (p = mem_pool; p; p = p->next_pool)
+	for (p = mp_block_head; p; p = p->next_block)
 		if ((p->end - p->next_free >= len))
 			break;
 
@@ -652,12 +652,12 @@ static void *pool_alloc(size_t len)
 			total_allocd += len;
 			return xmalloc(len);
 		}
-		total_allocd += sizeof(struct mem_pool) + mem_pool_alloc;
-		p = xmalloc(st_add(sizeof(struct mem_pool), mem_pool_alloc));
-		p->next_pool = mem_pool;
+		total_allocd += sizeof(struct mp_block) + mem_pool_alloc;
+		p = xmalloc(st_add(sizeof(struct mp_block), mem_pool_alloc));
+		p->next_block = mp_block_head;
 		p->next_free = (char *) p->space;
 		p->end = p->next_free + mem_pool_alloc;
-		mem_pool = p;
+		mp_block_head = p;
 	}
 
 	r = p->next_free;
-- 
2.14.3

