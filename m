Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AA3F20899
	for <e@80x24.org>; Mon, 14 Aug 2017 21:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752412AbdHNVyq (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 17:54:46 -0400
Received: from mail-dm3nam03on0119.outbound.protection.outlook.com ([104.47.41.119]:41024
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751471AbdHNVyp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 17:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=R65DTKGpMJ3YPOWwaqnzJqBpCf/dE8FRz2l05LU36ZY=;
 b=bmeQGqudVJ5EOns8ZOfsT6sQAlNUHcf9pNja1dKBVPqMnuwC1hzd1mRqOz8YjWID6a8+I//EAUHPMUe6dy5chSRIoUFAgkdunOSY7clgD6Y10ZoDBF3FDBXofNR76MfhRc5L0gVmIoBanfFbTQr9PXgJ6cwhg3xDkS+DWUSljjQ=
Received: from kewillf-01.northamerica.corp.microsoft.com (67.60.94.116) by
 CY1PR21MB0039.namprd21.prod.outlook.com (10.161.168.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.1.1385.0; Mon, 14 Aug 2017 21:54:42 +0000
From:   Kevin Willford <kewillf@microsoft.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com,
        Kevin Willford <kewillf@microsoft.com>
Subject: [PATCH v2] commit: skip discarding the index if there is no pre-commit hook
Date:   Mon, 14 Aug 2017 15:54:25 -0600
Message-Id: <20170814215425.23784-1-kewillf@microsoft.com>
X-Mailer: git-send-email 2.14.1.481.g785c1dc9ae
In-Reply-To: <20170810185416.8224-1-kewillf@microsoft.com>
References: <20170810185416.8224-1-kewillf@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [67.60.94.116]
X-ClientProxiedBy: MWHPR12CA0037.namprd12.prod.outlook.com (10.172.49.23) To
 CY1PR21MB0039.namprd21.prod.outlook.com (10.161.168.21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 079c3ba6-627c-46b9-209d-08d4e35f11eb
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(48565401081)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:CY1PR21MB0039;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR21MB0039;3:OpaJo+pJOo8AnTaR1lM4NBGuyS0ianga1G+BR6adRZHRMAM72l+1LLtyO2H9olA2LyvEclC9jiU7WXPAJASsdLHKA7N6UstEDH0sCx2cK0wUvfElbVyHXctkyFbHGZlQFKwGEu/mpdegYAi4TItNv+Fo0L3+K0CVvSf0AllfX64d7NAmhRSSpo5sOhNUOR609Q38srnldCFzWAC3ifH4IOZeZlXURmyDgRzBZLDUW//0wViOk1TSb7zprNMa5Edo;25:t8OxlJ+seAgtYFliUf32lzan56eQQItRZbjwUM1354/4IkuISUcNzPrf5Ec/DN0LUhbVF+07aofFUYD8vftmqSnl16UCSMGQiDzmj3Qn6JHJHua4dLIwup9SFBqoKZqv1cGRvZCvj4fbA++RHUZO/+BTi6dupGGMLd5CF5VmD5bUtq7/TsrwDqG8elqgZespcLnzuWf5BRWnFchlOYDFewHhXpKBDveDWrYUsxiKXR4tjOoI8qvwaY597uQZu2L+ouA0skdqDAgfoSG/6BrtI/xUQlhdEuCOY7McwDm3u7RCmY1YQKTExq+SUfowuCTr66TzUKtvvWnXnRk8LGOTTg==;31:iApAP/LGgtMVFXvp8k0MWaNSLl3nhywpjwaKkfgHa31Nyb9wrtLl2uE4JqShFEiRlvvpK+k6a42K8lx+OIV3dN5PYeHQvKpoSkYyR/CGeFK5g02X9uxlzFGg3q+jVxC226YDVdSE0GiEXQ1On/kSU8YUMtxBJjO2NoEagkn+dIK26f1bioCkIq/jBWzmWN9OdRpZAw0JiHtx1DsE9VbqQr2mmtwV9D1krRHicNfbR7I=
X-MS-TrafficTypeDiagnostic: CY1PR21MB0039:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kewillf@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;CY1PR21MB0039;20:9t2/0np6R1B/93dBkqWIkl1PcTXH+Er1sDS/MdHyPRNK+YonHBCtRUHS9/B5gbI63WfhYt/NUweGuzmDq1Ypam438nVWDeiv5dOallwThLQtLHQaHHFA7W2IU5WS7MStdzm73yUpvSrPiZB9c5rfmFmRNvQUWAsKtSZOiiXAM7zHGenyabuKW6iuXPQwcgui8Naszvk5CEFa0Pq6NMAMIvRKk1Il1aY6S04PIAjiu/16CLwngb5CMjJGz6DyNliNEaoP9DY2+3Airl5pcAT03vEs/aV3wBUw9pqeSk85PmcgIvKdUD0Z4Yp2m3c8nWouPWwQkw2HejySrCovcOcWbode+YJgvjFZy4PxEy+WbETwVLjTBwJUYmeB/QXHOhJ26ISlzwSRMcT7zXbzBg5oTXxH/2J3KSikLIOw5eFiDJgyhrLI1bHuf6ATF9cYQggIrX1+IMgwMenxc6KCaAOWRUDQS4irFT/wtjLxuKy/yJLcVJDGbmXKRWhUdW2afe+r;4:8T+yN7PSJNhqc/y5sAW+0mO5KL3ojj5ELsQ4SetcZ9/CZ8avpF8zLbqKZh3yYLx0wGkWo9c/DWz4yD86KM+Ds3GG59IvYlMLWz1jEYMQxJPRJA7+TEIiwQ8/d/y1MvUV5ekOElgdmzo0SScohdWCQJ2WcOnhMune+nPrr6W9kk7Dla9J8lBeVW2b0VnnBWsrOW8BB5uB804ITOYNFJz04JNIEWLZ55Jy8/yDPy8GL8MadoPCipirNMN/T/Y3PWWpDldV5OgkS1xkKPs7dNoiXDGJK1bWp9VuKs46DCad/q0=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <CY1PR21MB0039476966175F92658CAF50B78C0@CY1PR21MB0039.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(100000703101)(100105400095)(10201501046)(6055026)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123560025)(20161123562025)(20161123558100)(20161123555025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY1PR21MB0039;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY1PR21MB0039;
X-Forefront-PRVS: 039975700A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4630300001)(7370300001)(6009001)(39860400002)(47760400005)(189002)(199003)(86362001)(101416001)(48376002)(2351001)(50466002)(36756003)(106356001)(50986999)(33646002)(76176999)(105586002)(42186005)(86612001)(2361001)(8656003)(7350300001)(1076002)(3846002)(68736007)(6116002)(5005710100001)(2906002)(305945005)(5660300001)(6486002)(81166006)(81156014)(6666003)(2950100002)(8676002)(50226002)(6916009)(53936002)(25786009)(4326008)(107886003)(110136004)(97736004)(5003940100001)(189998001)(66066001)(10090500001)(478600001)(10290500003)(7736002)(47776003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR21MB0039;H:kewillf-01.northamerica.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR21MB0039;23:6eKNktpTgXl8TwT0ssnI2nJNX+H05qxHcdCM4YqSj?=
 =?us-ascii?Q?zMp5WgQiaaIoahiWdxpTOvOqVFWYRMY4kuQlZT7IUANZiabT5QMIr08kVyc1?=
 =?us-ascii?Q?bVXGU4ad9vEMdL3dj6Q77xneZc8qivQrOZTNZik6vlWZvGh7A19o7Bhe/MAP?=
 =?us-ascii?Q?F01GALreuYbk+hfrmg8AnCoygfzAN6OsbcF4hw35tkr7Yvg0ZzAowOqYDNVd?=
 =?us-ascii?Q?ElE2nAT22YPfmPxyRN1CYYbUiLz9RQcLJF8UCvVqpOevW0hQn+n7vyqjn4qf?=
 =?us-ascii?Q?Ou1/GHOeQ1E2O7suozzQfXx+CWEWBuqZDiX+Xb9vrHYtP6mijzOGhY188Jhn?=
 =?us-ascii?Q?aKTru/q2k8On6/CHIuqFGgHJv7h3h7qJLr8ANeJxodEu971+CdvgLUgC7fJl?=
 =?us-ascii?Q?Ags5iz11QJ7veDhK8TNEGcWqJxvZh2WfGf321IQi+0CgyFOdpg4j1kcPr2yN?=
 =?us-ascii?Q?frMyfCrTTuUB8LQDb5lVEdjgn6GiVfESx2DGIwvlLiX16dALMi0+euxvasft?=
 =?us-ascii?Q?GENjGknljSLFENsMmk3yxSgGc+W0ZwOLMsrD93mlqivItzWnwc5EtSc3MuWL?=
 =?us-ascii?Q?VBu2qV7TZQ2wwYXA2412T67XIuhMHvGk8R8xq9HeR2WnJnBBDNDcahM9rQdy?=
 =?us-ascii?Q?MEW2C7myx1wW8NfAejeUM2uM9xJWcTPC2I5N+d8puQhwM3MwIoAwcH/k90P0?=
 =?us-ascii?Q?mJEaEvdK2+BsVWM3wpuFvySVQW3O/NTfiZfhFG5H2+FyxMKQlrTuayI6m8eB?=
 =?us-ascii?Q?TEuPevyQ4cFpRb5gb0K3q7c0gC7QEOoCOTCmigKPcWTXSbAqurDmu3+/JRLZ?=
 =?us-ascii?Q?Lqz6Cbl2tnUmG45Rvdww2Jp5nMXkXyVbOZDxzw67PZUsizyY2+KJe0de6Ltn?=
 =?us-ascii?Q?HjjbOfmEdaqBIkAMEq/xqEHXf3llHpdWE3RzaXt6ZoAIE7Py3V4y01rVgTbo?=
 =?us-ascii?Q?btNQXAp7ho4UTZi1/ufFOKFrvA2yvCbAi0jLmTHVpv7k9w56N/Mg99Ji+VkZ?=
 =?us-ascii?Q?GS8P0oJMc7P+I/nxGYK5L63GYmeEdTVV7TSEFY/fBmJKiVlnTRPmyaKhJ+4k?=
 =?us-ascii?Q?pX0luVGcmFjDTlXR1DZJIWC54Y5xipKEgJO1yGJFeRRAvfvSizqPbCsZPN/4?=
 =?us-ascii?Q?NyjOQu2yhjjgCIRo8+6VQZKlsCeaYm7yIqxK3PnjMmQZ6mZNN/NddxT4AfSY?=
 =?us-ascii?Q?WkpAUCmTUKWxm9nCMlvzGS0wclhKtAazTW0FdMMXMWNhN3T3w6+LM5MuI69G?=
 =?us-ascii?Q?OIR8MtKoD/qPgQ46rsrPMpn306a2mdu6URwshGOWjA5iqw8nvjLUJStYlt3l?=
 =?us-ascii?B?dz09?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR21MB0039;6:E9YCOnk4HIaKJ6/57OZFXK63pku2PKciTxsZYxGFqpWCr4MoxJvUcPtB6q2OLQUfcN+m1+MMYemw/sBWNFBFkk1t1VzeJcawIRMAAhbZrqGBeReCM2J7mfQ2y9u1rDVQye9KtjQm5YgyIwR+j40WuTC134Zksts9HZIMXsG6YXM6zOG2O6kfLO3weqZP2NbuKCVTcjv6J95akEeMKPAQt2vuH2DpBninQcikHOrcAUEUGMwMqYo7Fn9EW7WhxXMp+AaJJFZNp+o4VAcZr4kpQXgW5JHpE87iZjq9XiWdopEP5EwF/voEPhRSmzx+zdWpO6lCLvzoDj5BCuwDWz0uOw==;5:9upeV8TDhaMu5PJwwOIOPbdw04yHgdQecXR+j+9ljgfD9kq8ew0TEbJwI8zpLNjx4b+Mbp9Nvi+aCb8itW61r6/8IfczsUvZqc5nv5mruO8ey3n5sk/T/upQFBgXuqiBibw8K+BrsvFQjHPxFYm2vg==;24:ATS8+jTXNdaxBaVOGkilSftJgy8fT2xu8q579jdwUdirMcAQ1M71LCiQSIXkZKhMPO/vQImT1whG5ZalVvpZDc+iq6aLuCOCRShQPkwe7Zk=;7:/67DGImzahHT5zgxlTEYmo5Ej7ZHBtp19w6Hww8e+yJkol0Q6IxWg44gjHIfNL6vifAztBT3QNXNeX70O/ttcUjHC98SeT+z6rl1LprJAnFMcDgYpScu2VFf5GMXA4SIONv8eeDE6VOVMOkC9VZd+WBU0wWIxWgDHFV4baNL4GGjt43nyuY7eT/h2CNXb+cC/mtHFX27JMPyQY1IWjGxh8iDJeoNCKtBDYNmH5MmCJ4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2017 21:54:42.4665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR21MB0039
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If there is not a pre-commit hook, there is no reason to discard
the index and reread it.

This change checks to presence of a pre-commit hook and then only
discards the index if there was one.

Signed-off-by: Kevin Willford <kewillf@microsoft.com>
---
 builtin/commit.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index e7a2cb6285..ab71b93518 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -940,12 +940,15 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		return 0;
 	}
 
-	/*
-	 * Re-read the index as pre-commit hook could have updated it,
-	 * and write it out as a tree.  We must do this before we invoke
-	 * the editor and after we invoke run_status above.
-	 */
-	discard_cache();
+	if (!no_verify && find_hook("pre-commit")) {
+		/*
+		 * Re-read the index as pre-commit hook could have updated it,
+		 * and write it out as a tree.  We must do this before we invoke
+		 * the editor and after we invoke run_status above.
+		 */
+		discard_cache();
+	}
+
 	read_cache_from(index_file);
 	if (update_main_cache_tree(0)) {
 		error(_("Error building trees"));
-- 
2.14.1.481.g785c1dc9ae

