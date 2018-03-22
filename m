Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C42FB1F404
	for <e@80x24.org>; Thu, 22 Mar 2018 17:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751825AbeCVRka (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 13:40:30 -0400
Received: from mail-sn1nam01on0108.outbound.protection.outlook.com ([104.47.32.108]:2404
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751668AbeCVRk1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 13:40:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=xveqxirrQZ0EJWmsOP3UMLo0MyY0FrsdbTFNmLtONck=;
 b=IEMq8jT41UzRCg/hi/aHaXEJ6QoYcnZmcWA7et+iCQouZ89SVMTeOWAEC1PZPMKFY5sxYd9M5S8L1RWaPLGF+Mpti9j4/JFqPUIDGVbgoZ4V0mLEkaraTeFyiFpsRZ/P0t7HBD7aXMCwLwrqqLplVHhUAfP2RjSQrfdV1b66Cbo=
Received: from stolee-linux-2.corp.microsoft.com
 (2001:4898:8010:0:eb4a:5dff:fe0f:730f) by
 DM5PR2101MB1015.namprd21.prod.outlook.com (2603:10b6:4:a8::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.631.1; Thu, 22 Mar 2018 17:40:25 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, jonathantanmy@google.com,
        sandals@crustytoothpaste.net
Subject: [PATCH v2 1/3] sha1_name: convert struct min_abbrev_data to object_id
Date:   Thu, 22 Mar 2018 13:40:08 -0400
Message-Id: <20180322174010.120117-2-dstolee@microsoft.com>
X-Mailer: git-send-email 2.17.0.rc0
In-Reply-To: <20180322174010.120117-1-dstolee@microsoft.com>
References: <20180321224226.GA74743@genre.crustytoothpaste.net>
 <20180322174010.120117-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
X-ClientProxiedBy: BN4PR10CA0017.namprd10.prod.outlook.com (2603:10b6:403::27)
 To DM5PR2101MB1015.namprd21.prod.outlook.com (2603:10b6:4:a8::37)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2f16cbab-1d98-414c-fbec-08d5901bfeff
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR2101MB1015;3:7pebXVsVcg8YAzPvftA7cCnMrztGQzDKAwTjXmyz/Rl/tpgpV3K3e/9DAb5ky4p26PCMWvag3vJay/sNO+njkolmBg6M7UFZKk6k7NpaXb+6V7rkHCAztPQu9XggKibK0v+bKh4D2Puj3A99qSXJcPk7STZOVwjHT77KpDSlnoMMDhZ7duzcnT46IGm4+BUau52gbpZG2EMfPE+JcrEzgczLyyOICnN9zgRpyxbGutlUdPkkGG7aC/CKxGtZHXLK;25:bN6wFG2jfBTEyOoQkP6763YWvQA0IP0Qyxc8yyPcDJYQItGA3ftwC3kNQ4ozDB43A9qllYCjifwLVdkUKavUZBLXYhMSa9dRE8JU2A5bvI6+DZ8gFAsv8alLu/+B5HrozfowHmS+UBeBGb3YtBq0qx3eqGRbLqpVB3XDX+k9BD6CoNWLgA8F+Hax11cGVTLu5ghIAnRWEjjfbG/uX2SflYXymiWU/Xf9KRkpEp8D0vumhY21cguibU47Oisvt0Rq5AvlKEl1wIc9dXtmMo/VI7UZGCbhVZzK1O97FnggvqONA/gpWYTg+xf6uAEfc4ug0tI3QHyHEUsx+usFzrUiTg==;31:DndQ6Iw4lmTbq1WtTSrZZeDojgavj4m6d3oxwMqEmxVLeeGcJ1MU+bk08LrJZQ4pt1voKCH9oNC5gaFy/LmiBBez2KanUIHWGLPNmWifwORyhmQzZSR/utv8LnqPssUPngx9K/p+P+meT8gN5PLi/J24JzNViGUs9Z+R6BBtqOVw5SA4D8DUlRMswIXwAXwwYWYrqhNVn/AoF2//le7sXMtjdXzqNewLVKn5PEzvu/0=
X-MS-TrafficTypeDiagnostic: DM5PR2101MB1015:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR2101MB1015;20:m/zSkFUo6r4Rl5i7EbH/zqX3PR02ax9q8yPV1Z8pNJ6uH4Wpy52PMzAjeVrjNkp2RnP64dVBzFTW5YyMEQtBBxrks7jRu7necbMSKSwg12JeXVdcKmfEOu85qQTBjcWIQ3wc/wdyMNEEkMXj+U68IWERRZfOYMooDE10WTME85O8X++XLeVmrB6NQtYMy+Mqx5o0oNui4bw4NXQHUD4LXOofr59b1ZlAJ7REqYJH344kX3eJxt/6hG5LboBk3hGq950DIAVWXFS5POEbd0H/yvpMMCY4W33NAqpcxNgSe4J5NfvzSGMIP+aB85veDbpkbbn5GhJ+rIpxsj8cftVd1UKZ0Hl/XNKfvgyzncMHCYre3JVkLgO8OmUlsiVp3gtOpTHbvq9t305jGu8i7U97a6UD8OJ9QkEvUYd2eynA5S9pkPe62Ht6BOxTeMKdD00ccgeV+NP0DZZBdX7haUpU0F44rRxPmWbX/aWJCAFiiIaagVNg4J97Las+Kj7PiTUy;4:viO18QY72W065WPd4wrW7er8/SuYtoAMLoF2qXhcVMDnUTzwvr85pQb+ggLCnVACR3G2hzcNJJlIPGT1Q1HF92ljHU3QFHtylh8nEksHRRxKrKon4LMfsKEqf4wUHFpkboKQsNW/hdyz9e4wscq47NWi5vgVRY3yo5HHAnuoXMOfX7GiKbj5IDrbjpLNjEhJVwwaJ06dibv2C2/hVntgWtZYubhZXxgMLAwfcnaqKeZdfvyFOTKZ14oALUtSDeE6MQYPlKGrAogEs+FQHPuvww==
X-Microsoft-Antispam-PRVS: <DM5PR2101MB101530A316B6DA536D24651FA1A90@DM5PR2101MB1015.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
X-Forefront-PRVS: 0619D53754
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(376002)(346002)(39380400002)(199004)(189003)(68736007)(1076002)(10290500003)(6346003)(386003)(4326008)(76176011)(22452003)(305945005)(52396003)(51416003)(7696005)(52116002)(46003)(86362001)(25786009)(5660300001)(478600001)(53936002)(50466002)(6116002)(48376002)(36756003)(446003)(8936002)(2906002)(16526019)(16586007)(6916009)(81166006)(6486002)(97736004)(6666003)(81156014)(7736002)(316002)(10090500001)(105586002)(106356001)(39060400002)(186003)(2351001)(50226002)(2361001)(86612001)(47776003)(11346002)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:stolee-linux-2.corp.microsoft.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR2101MB1015;23:3gLj/Z4dAsCSHMWYWyUO7DhqtWJk0tarOUTJle2?=
 =?us-ascii?Q?HRHhwJE0Gk0velo0UedkSwOXbvXUpkv94NFtZjgaIqwn6XuOj1AbzLewejS2?=
 =?us-ascii?Q?aD45ekKgS7ZbKr/1d/IdRQYXN0Up+6lQ7R36I5FOkmRCFIZI7pU2V5bABLKF?=
 =?us-ascii?Q?ocLqQfZg9ALA3QBA4/shA8x1PC2RfKjEnbxxTmSFjuzWPRyKr4Nf67iZ022i?=
 =?us-ascii?Q?UNYiMRn6Ar67rigou7TBXgc8jjYiHHLcCz6oD1D7R4Tm3Gg44oPmHvi6TzOx?=
 =?us-ascii?Q?mcfe9ORNz9G+xCGh/bWZLwZDdN225goCgfvrmNdH0O84KpewK2qkmvhqXY5X?=
 =?us-ascii?Q?JIrv4hVj4Rq9NQzk+c9mfpZMDaNqGQyHFwCfftPQxJubxJQCFsCllREuis0h?=
 =?us-ascii?Q?sKMy1YizwdCBYy1kn5dfhwbTfxYg9W2pUXtL6pM/pP6AkDwmkZj+NQj53BVn?=
 =?us-ascii?Q?FlibFWC+n8Oh/fFuEjvEUYcZBdnC60R8UzFiUbiDsdPhBo04kSFl1T0OJYv/?=
 =?us-ascii?Q?aScTkSKK39yVmoVCTi8L8pqMyv+hpcrK8UnW2RH4taWnGgYl/kP+V//IVimI?=
 =?us-ascii?Q?AouG+8kkRYJSGjge5lXZAATmi9zIOxKYXIXEvWttl9k4CcAMMqGfypn2QPcT?=
 =?us-ascii?Q?lQphHXQ/czFboiHCIUjqhw+UZo6eLKl3g5RfI9hp6HmJ2dNVhtEICLlHx2J6?=
 =?us-ascii?Q?VQuszFibfRUvbc98iN+MBFrENthgE7CwLD5kIAYNLubNqOmMRbEx97XYMuPa?=
 =?us-ascii?Q?tgEPby5rd9OmPBTnKTXmaX7Dqz+o5x7iM274O0m8nlZGE4SNeSahBT2mtW+C?=
 =?us-ascii?Q?rE+ka/1tsi9U7KRMCczdQLxZODwnd5LnjOeXdT5SZjEjG7/Ys8sxFN+wXaI+?=
 =?us-ascii?Q?M4eKWZrQINdaY/8O3UCwlMtK9Sa2grhPDr1ousvnDCbGj4BCFnHoyzyrWjAd?=
 =?us-ascii?Q?bWy+lZNQNoe46jLquhAUxSeEIbpFgqQRnPspuT5NY7ZO/SUxRileIAto1zsj?=
 =?us-ascii?Q?xA0gGDxRflQ18B1iIie5aYmKt/pMYkeij44S7TFfawsnptz3IpH7nwh3jf6f?=
 =?us-ascii?Q?jlVdOCqXAqhHa1VU2p84ZZGHRfONLjGPmzADHxeFOmI6mMoLBkt88Gr0fB74?=
 =?us-ascii?Q?cVvLGpdcel2OFPjQxj2dmK6aiIm2ylZk0MG3lmoybIo4wcUONdhQyXt+eJaY?=
 =?us-ascii?Q?UZJehu76fmPDtHG+ObXRSVfg8gZjqG/WATrjLAEGOTFQoekHz/AKUZlwc55l?=
 =?us-ascii?Q?NmXsoqtyDkFxOV8rBuvpKTnIMgwauGe08qaDn0VBZ?=
X-Microsoft-Antispam-Message-Info: x052YHlWWu6hoVytEg3hh9zo2FPO3T0lQMWP+gUW0FeLAUHLl6+bcGHHHwDdohv/Qw1fnC8Z6GzHCBlxT7DQ48mOJzoctWH45tjuwo7Q3JEFJPMt96UvsfXK8mazMam36UO5bf2wZA8VpbE9yCRIsuN0wgjmxbHQlb4MQBzI8M8NMfidST806pei5mP59KJA
X-Microsoft-Exchange-Diagnostics: 1;DM5PR2101MB1015;6:2llaX2xP1kBcu6B6AnSUwFPM1wfw9YWlG2aDK3WlAwhyuHlSGxEDRJJ6dXo5Uj9LJimoEsy5YShMayqzm1xt8b5WbcHgzUcAatlHFnJUIkY6U5W9hp70xSieVDvKYEbDhwEir2LPw6e8Pc+cQ0A71eBx+ta92h88O86TGd0OxrHxtwTAtPOBFBuH4dJTYhSQwxsxC8pVvEeMTn5GTOtWe+yq1a1aZwCZT9Bo7c2RaxSSl9n++7iLQvvQUTFYbXOO+QWammNxotrh1xJrGVAvS89OjTndRMqqFYLsD/ySL5gMZGCGZdKIa1X044haqx0TWZeEfsTPbRk0k9993xcAhCGNHfqTvPNdcjmnwhyz3xYJrDXjF5W0jbsfirGhkEFkPTKFw619NxasucnvhbnnKjiJGJtfgBLdQ5jIhnN1CQOT2nOn+qfaFOsWJKU7I/bs0bKbv1Nmuc14B+V/SAZK/Q==;5:WTpgEQG24IHzytXC7tNnpbkgkgyM7UQsKydGGb8qEV+D3omuMCS5vjvidRov3RIpml9RsNZyCDxtiRk2g+8xx5nP6R/x3ZryAMMJzi6/w3uUj/98niswQn2zDsoeVNlxR7FFuoh6VX2Adlo+jrDCxS4mXe/chtvR8gy8TlscSqU=;24:5eQDvjFYSSwDVNHpjtfVTYRbhhlKQQQHyCr6IraeSttsLQqN4Vn6Gha0VxzMS5x28AGFQ5cLvaiu704RfACS6dNRJ/2Kmo72rhag0EpJO3o=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR2101MB1015;7:MNy1vJsGg4bPPrpNPHSIR8SrLoIDj+/vmqELSfRtSq95KBpQo+Whh3J/els6HGWOj7sh8Wjlh3QRvVsvEPvcpWqpwc5MHu7IHDLDSTDkM60VybkMVOOxzUsLIT7B62jyFkh23VXcJHfiIwTYPLQ0/YO0GGLg6MHRYoJtnDKgGG6tECloXeaEfT8baYCTa2ZTJt79Lu6pCNcq1UmsgT2RKch5itBEhbGcejDGYwHRzddK0/Sso6RXMKPJZDSGgxmc;20:hiG3qTHg9I3Xpi9yIYU+UsQE5fR4r5TbeVii8eY156cZ94cySDlDnzXMSTPgU/nb6d2pYZNSXuz+APcz2tgBdi8VhxpoBdt8bXjdCps/Ik2+N8TA8gNbHFd9k4fQZ7eJBi+koPeJd42+7U1REFLQEOk19xZr4qTc4TXaR3RvzUw=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2018 17:40:25.5366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f16cbab-1d98-414c-fbec-08d5901bfeff
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "brian m. carlson" <sandals@crustytoothpaste.net>

This structure is only written to in one place, where we already have a
struct object_id.  Convert the struct to use a struct object_id instead.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 sha1_name.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 39e911c8ba..16e0003396 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -480,7 +480,7 @@ struct min_abbrev_data {
 	unsigned int init_len;
 	unsigned int cur_len;
 	char *hex;
-	const unsigned char *hash;
+	const struct object_id *oid;
 };
 
 static inline char get_hex_char_from_oid(const struct object_id *oid,
@@ -526,7 +526,7 @@ static void find_abbrev_len_for_pack(struct packed_git *p,
 		int cmp;
 
 		current = nth_packed_object_sha1(p, mid);
-		cmp = hashcmp(mad->hash, current);
+		cmp = hashcmp(mad->oid->hash, current);
 		if (!cmp) {
 			match = 1;
 			first = mid;
@@ -603,7 +603,7 @@ int find_unique_abbrev_r(char *hex, const struct object_id *oid, int len)
 	mad.init_len = len;
 	mad.cur_len = len;
 	mad.hex = hex;
-	mad.hash = oid->hash;
+	mad.oid = oid;
 
 	find_abbrev_len_packed(&mad);
 

base-commit: 1a750441a7360b29fff7a414649ece1d35acaca6
-- 
2.17.0.rc0

