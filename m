Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5BC3202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 16:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752558AbdIVQgk (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 12:36:40 -0400
Received: from mail-cys01nam02on0106.outbound.protection.outlook.com ([104.47.37.106]:2304
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752516AbdIVQgc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 12:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=tnX6nUpBkA1NOl2zO+EDVOEHdF/WIMoD6XYmVGw1RH8=;
 b=CzIWnCJWZ8dP/6hUYGBP/Ke2/pt8pOe4H4T9kesiYK5uMUNX5qMNuR3KGfKQDkQW1Kk9fG7BjnICfIMj+fos64axVPYKqOYeFjCuhLlcyubH7GfXVtgB+BbROrZkLD2BVvquoztXdQUsQwU1P4yN855TQSln/CHdVIKkt7Mn4VE=
Received: from localhost.localdomain (65.222.173.206) by
 BN6PR21MB0466.namprd21.prod.outlook.com (10.172.111.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.98.0; Fri, 22 Sep 2017 16:36:17 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     benpeart@microsoft.com
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: [PATCH v8 12/12] fsmonitor: add a performance test
Date:   Fri, 22 Sep 2017 12:35:48 -0400
Message-Id: <20170922163548.11288-13-benpeart@microsoft.com>
X-Mailer: git-send-email 2.14.1.549.g6ff7ed0467
In-Reply-To: <20170922163548.11288-1-benpeart@microsoft.com>
References: <20170919192744.19224-1-benpeart@microsoft.com>
 <20170922163548.11288-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [65.222.173.206]
X-ClientProxiedBy: BN6PR06CA0048.namprd06.prod.outlook.com (10.174.93.37) To
 BN6PR21MB0466.namprd21.prod.outlook.com (10.172.111.144)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8adb10e-f60f-435a-f9c1-08d501d80cc6
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:BN6PR21MB0466;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR21MB0466;3:6+Qhymf1KePX2/glOTzbp6/JO8/TgI/e47L/j31vi5E1VEBv8fkXvKbjNt6/mfcOAR5DpFEhSqylFABcKZfVuJCqS68YCOoWb2evIY034PBSICzF/R7M/QmB1gaZ6bT40dZerOZVTnIgi0xkYHvh/35YmWhtZYYlsuR8Stu4o2EJNK75CdzFbZ7ISHMcKHHQIEG503/xhBtfkaSdXWJzLN9t3Nw8upgojQKf/w/NRt8iQCs/dQxA2vPwNLrcUXya;25:HOGXI8/U95udHx0Hn+cDkYDceoYfrWg7jGRVxgyR9tdLofKXK7Ed8wHz7fTAkWA56cQehjty86X1IpLfEVr6oYDmIxXPrYG8x47J8DrLXlAcK0sIVdLbzabFWvj0DIs7gyGL8B7pjxuiiHCyB6hhSEDE1t4+I29kVnP5FRSzl36E6xzMefP3Yib5qwiPSIRc9r0Qz0ZTa28pIBX17j5VNajflrCw9MMMHGKcrmP2ZCynFQPRS8auCw5ZnsxKuP9uUtVkYcKAkJehYYXZi1prsE5IlWz/Cns3HFmlaG8zctpsKeEW/9XgPtHbtZaUjrH2Cna2ZeZ5A4a7Thc1dB9A/w==;31:qRgQD6EmEIAdvYRTUDIpLrYqzv/VTkVcv8pIjHnwr6V1S7Th4zNbo7XWs9ame54pcum9PChNwVfgX+J/xcdH0mOAOyWXHlrUyDq28RnWOAOD7QRtuKT/1s7o6ztbMqTLESNHa10Ka6d8evsvs/l0dZX/lCmN8g2ve0viGb9AjSgfVT7oRWT1KPnZup4dU4yENYvhail9B4JQHre7jkts7/Gf1dAgK7KvjXWvjDw9zVo=
X-MS-TrafficTypeDiagnostic: BN6PR21MB0466:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;BN6PR21MB0466;20:o9Q2ILMkCfJ+4I6s3emDsgt6vc4swLYwUwpYQ+jiOTimYbrqSuFiL/djbWE8B6EnGGeI2VbJDCUI+3LD+vUw3uTDZPSFpoBfvf3scsJX2QtVpoow5jLpQq7fq31Pri1+CZFwg/lQ4HFbnkJ72y6n1joYRlP780LvK4g+n7gpQd0xlH0znsXWYwkgBgZWDO3zMvciH0kSfzPmL9fcCrBi5lFbVzWtbbXaqSxsH6hK90jT3XXOtNCGrwQwjgimWRBNQlmpnUNf8NhanugBtlzdb3gvtRUPJdjsLiv9TNTFIZNaRjOaJwLVdfKeTmgDmE8NTuQeitfwso0TSwPUHdk+9t4oZF12nXqd0wKGMx5b01ZHR9VTBvLU2iGRNFPhY36Tebr7W8UuRIxMsbKuXxoH2siTK+YZcHc0aJGf/gFpuilTpBszGDqryzl0T3fBayy2PQTheZm0xN/gtWl8L2kx/S5VkJUP2yBEIH7N38ejdkm0IbaRX/n0w/oDn9LW2pcJ;4:3rQNaUsbcmhVv+qsGOkr3e4WY2AzK+Wekh78kujwIEq9vnoogalwdDnETys2MlfigtgxMuvXUf9eTdrelNAEmldtJmXgGV1FN6WZGAmfsKWYfvIvhpR+yFER7pvS2cWNpv5SuAXXYgQM4wP6d5A/pzKyUNwCj+2ACLVECps8UnUyWDAPMjCKVjpX0x+V0ZrkB7+HiDoCKjOYyI9gU8Kv5bfg/DDN7lt3aAWL9XUTCEUnWF2WjUVL1iwEF+MoKQ9q2ktgaP5QqyLlZXsWFFzNqPjjx/FbYYeswV5STr97Ffc=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <BN6PR21MB0466CB4F3AE48584B4C06324F4670@BN6PR21MB0466.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(100000703101)(100105400095)(6055026)(61426038)(61427038)(6041248)(20161123558100)(20161123564025)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123555025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:BN6PR21MB0466;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:BN6PR21MB0466;
X-Forefront-PRVS: 0438F90F17
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(6009001)(346002)(376002)(39860400002)(47760400005)(199003)(189002)(2351001)(6506006)(10290500003)(6486002)(86612001)(2906002)(5660300001)(66066001)(4326008)(10090500001)(101416001)(97736004)(1511001)(47776003)(50986999)(68736007)(76176999)(50226002)(2870700001)(106356001)(6666003)(16526017)(478600001)(53936002)(2361001)(37006003)(50466002)(81166006)(81156014)(8666007)(8936002)(316002)(72206003)(36756003)(23676002)(22452003)(6512007)(189998001)(8656003)(25786009)(2421001)(33646002)(2950100002)(6116002)(34206002)(39060400002)(3846002)(1076002)(305945005)(7736002)(105586002)(8676002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR21MB0466;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjIxTUIwNDY2OzIzOmcwTm4zSFUxTjNTMWlDQldmSG54UERpd2JC?=
 =?utf-8?B?b0x0VVdVNllYR1ZCSm5adWVOYlJ4NVhhMk4rMnlHRGJHblYyclBORnl5bVg0?=
 =?utf-8?B?Yk9HQ3BNdXRPTUx2UFozNWhyQStEdzY2Wk1qeS9VQ1NIdVRFYUlzWEpsb29M?=
 =?utf-8?B?RGRRekZDS3pGc0hwTGk4Z0RKcFczVDlYajB1MnNNTjI2QVZGa0hHMk85Z1hT?=
 =?utf-8?B?SlRlZUJiSnh2YlhXWGZ6V3ROM081aFBUNjZYOXh6S3ZjQUpCTGRHTGJRb0RR?=
 =?utf-8?B?RWIzOWp6UWlPTXhZTTY0QlpHQUpHdk5jNVg5YlgzdjJiL3A3M2ZDeW5rK0g1?=
 =?utf-8?B?dHhiVXU1dXE2ZzRQbWxMQ0JYL0I2bGRaK3lNTGl0eXRYTUI0YUVDZGhlWFIy?=
 =?utf-8?B?c2FVcDgyR2pKcFdEM3d0OTg1SzRlRVkyNllyYklnZHpZZURQNittZnBaRk9E?=
 =?utf-8?B?czdISnNlTkJEaFVFYyt6UEZlZi83ZmpiMUZ5dDI3ZE5RNk5tSnUya2hVMzNv?=
 =?utf-8?B?MEcxeFVpWDZsNTdoTEo4RzdSeERKVXNZS1F0c2l5UURYRE9tYkx0SWVyMks0?=
 =?utf-8?B?MGJBTTdHSFo5Y0Fud0pabVpsaHRHejFVd3BmenBCckpEWGtmM2Y0UzB5cll5?=
 =?utf-8?B?VUFDVHVtYitIUWRUSmpFTndiMm9ueDhJTWJQbVNLbU5VME9JNDdvUXFBaWJ5?=
 =?utf-8?B?WTF1d1hOZnBaRDVxYVJ5bVhzMGZScVBVL01uVExRZlJPbG1PRyt3MjM3N0ll?=
 =?utf-8?B?RktUUTVFV0JDZnpJWjJVWldGTlpMT3B1Y1FRV0ljUytWSHMrSUtZZEEyYWdJ?=
 =?utf-8?B?akx2NnZrYzI2aVZEam9zWmtSODhSc1RsYUdVcE93MVlWTlgrbjBBTlVwWDNr?=
 =?utf-8?B?RkNPSGhmUnczMlQ2MkZhTHRYZzFtektCdm02WVVORVUvTHJ4V0dyVUNMcGpW?=
 =?utf-8?B?cUIvMHZrYWdiMUhOQWtvY2ZlVnVFc3pBcms1V2N1WmF2WEp1L3gySXhKVy9h?=
 =?utf-8?B?T0NwUWRsdXdlckQ3YkR2cHYrZzF3YWhtZ1VOQm9MWFlLUnl1c3R2eHI2aFB6?=
 =?utf-8?B?UWhuTnYwQmJKbS9LZ28ydnhHNWpRRGJrVEkwQ0gxZ0VZMlpxaFJ1MCtsM1k1?=
 =?utf-8?B?NWtGUEZhdU1kUUp3QUd3UEwrNFZPeitRU25sQmxZeHBJRGxvdDN2Ni9pc213?=
 =?utf-8?B?bGpiWW5xaENqVTFTRjFkOXhtWkxjVWZlRnFFVi9UTmxxUEh1Y2hkYW5BU1k3?=
 =?utf-8?B?OElCeXVaNkxrbWJadVg3ODRDa3RaUFBsMjM2bThqUCtFbGFobHYwQ1RnZ1JD?=
 =?utf-8?B?bUlHdXMvcGdjYXhVM0k0dGtPa3MvcEYzWHE0cEtQMkpBNnA5bzVMeFN4cHlx?=
 =?utf-8?B?VEM0SDBxbXFaRkhLUGw1R0pYZnZ0VGJOVlh5SHZOMUN3R25NdUNCa0FlSTAy?=
 =?utf-8?B?MWN5cENXZ2tBYzI4RTZEb3FZUUlTUkw3WVpqZEt2UFpXNDRwbG5DVnJoWVEr?=
 =?utf-8?B?cmloOXpRQWZwSmRNYnlFZW8xOGFvdDNCZ3RmTXhrVE9XVnVvbmwxVG5peEZh?=
 =?utf-8?B?azZOOFFFSld0Z0w1R0NsNCtmZFJRckRtdFordGdxeEpvRlRmNHBZMkJWUmNG?=
 =?utf-8?B?S3ZYOTJ2Q1lLWjUzc0tvMTJDb2VLUjc3d3p1VENsSFp5ejdoak9nUldZckJ6?=
 =?utf-8?B?UWQ4aFFKY0QrajF5NWtlS3Ewa1ppQ3pxb29RY295dU9nTVQ2UlZEbDFJSEVp?=
 =?utf-8?B?S1RUMWdEcW1DdzRVK2xIamxBL0NoWTlhbG5PUU5aZUdWampLR200R3FXUXRB?=
 =?utf-8?B?WXlOdHVIUDkycTdsT0oxbXRWYzNVWlJlUElTTDBhYnBxdnNMWUp0b1htVmNM?=
 =?utf-8?B?VkxKS1lTbTIveTArS1VjMjlzaTV1VTh6RDF2Wjdqd3hha1BZcnFHbm05LzUw?=
 =?utf-8?B?OFlmNlRGUXpBPT0=?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR21MB0466;6:TpUBS8dQiYaVIpkFjb0j8z9sFjzrglWFlNKQfr7Ny8hm2UFFnRXDMsoDEBd9/HQsnGuvwBShwqUKUgxg1D1epHyOqF9MmuzBXLi5wLmo3bWQWTCJ/PKgTuZ3vjs7N49mMBzKXzM7V7UIV1L4v/bzJJd+39so+nCD+JKxKXXdUHjJnB5J939xQflqC92yYMBVj1olZLmA3aiL2u8m1oClmkZcppkqSQ1j6kMmCgLUw+v6pUrqhp0A0008z+clH1ECyAUYkrc6R4DIpUYL9AuPc2MJbZ7iH8w4ZW+Mve1nKG6xnzqPTIez8yziU/AyQsO4TgwXT6RR8Jp7hS2CvyP8tA==;5:hFEdMviVMqqvzVTD8EOf5f+Y2ugH/kpdu6AoVSX04kNHoohNuKo2DcAUETEiLyw9kdVaF0700O1UpWaJu77IWoaLqedyeR0tSXigg4xgRa5U+UUDh7IF9FJeDFxqiworVwt7PojtYu8DYQScQu5vaA==;24:WslEV2o4OQn0tSzoS6Cv6rmZ3GcQsoLqU/T5AGvg+6axdMA17HaOwH787zwU82ALY3fsgW0YoaXYCgCUSfScHLNWr3hNiE3I8TbjyZyxacg=;7:LcUR0PMe1eUm7y80NaPEa77bA43KSJmfcFTbuwW4LD0Up9GKDbqT0+M4xkIm0YZNGhI9wV4+4SSXT+WHoQJPc3pwyXUsz9ckRM7yKfqSNP80jMsGu/j6p6cT+nnBCednUwO8Yx99fRlVnIfp5Pmy25M5ccKKO1UQvc9ecvf2RszZPDypEqLBnzL8rQT36MioCsMVgpOdI2wJ3JNK9rauyf9epVG2R2awVJUU1V9S/v4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2017 16:36:17.7348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0466
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test utility (test-drop-caches) that flushes all changes to disk
then drops file system cache on Windows, Linux, and OSX.

Add a perf test (p7519-fsmonitor.sh) for fsmonitor.

By default, the performance test will utilize the Watchman file system
monitor if it is installed.  If Watchman is not installed, it will use a
dummy integration script that does not report any new or modified files.
The dummy script has very little overhead which provides optimistic results.

The performance test will also use the untracked cache feature if it is
available as fsmonitor uses it to speed up scanning for untracked files.

There are 4 environment variables that can be used to alter the default
behavior of the performance test:

GIT_PERF_7519_UNTRACKED_CACHE: used to configure core.untrackedCache
GIT_PERF_7519_SPLIT_INDEX: used to configure core.splitIndex
GIT_PERF_7519_FSMONITOR: used to configure core.fsmonitor
GIT_PERF_7519_DROP_CACHE: if set, the OS caches are dropped between tests

The big win for using fsmonitor is the elimination of the need to scan the
working directory looking for changed and untracked files. If the file
information is all cached in RAM, the benefits are reduced.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile                    |   1 +
 t/helper/.gitignore         |   1 +
 t/helper/test-drop-caches.c | 164 +++++++++++++++++++++++++++++++++++++++
 t/perf/p7519-fsmonitor.sh   | 184 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 350 insertions(+)
 create mode 100644 t/helper/test-drop-caches.c
 create mode 100755 t/perf/p7519-fsmonitor.sh

diff --git a/Makefile b/Makefile
index d970cd00e9..b2653ee64f 100644
--- a/Makefile
+++ b/Makefile
@@ -638,6 +638,7 @@ TEST_PROGRAMS_NEED_X += test-ctype
 TEST_PROGRAMS_NEED_X += test-config
 TEST_PROGRAMS_NEED_X += test-date
 TEST_PROGRAMS_NEED_X += test-delta
+TEST_PROGRAMS_NEED_X += test-drop-caches
 TEST_PROGRAMS_NEED_X += test-dump-cache-tree
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
 TEST_PROGRAMS_NEED_X += test-dump-split-index
diff --git a/t/helper/.gitignore b/t/helper/.gitignore
index 721650256e..f9328eebdd 100644
--- a/t/helper/.gitignore
+++ b/t/helper/.gitignore
@@ -3,6 +3,7 @@
 /test-config
 /test-date
 /test-delta
+/test-drop-caches
 /test-dump-cache-tree
 /test-dump-split-index
 /test-dump-untracked-cache
diff --git a/t/helper/test-drop-caches.c b/t/helper/test-drop-caches.c
new file mode 100644
index 0000000000..bd1a857d52
--- /dev/null
+++ b/t/helper/test-drop-caches.c
@@ -0,0 +1,164 @@
+#include "git-compat-util.h"
+
+#if defined(GIT_WINDOWS_NATIVE)
+
+static int cmd_sync(void)
+{
+	char Buffer[MAX_PATH];
+	DWORD dwRet;
+	char szVolumeAccessPath[] = "\\\\.\\X:";
+	HANDLE hVolWrite;
+	int success = 0;
+
+	dwRet = GetCurrentDirectory(MAX_PATH, Buffer);
+	if ((0 == dwRet) || (dwRet > MAX_PATH))
+		return error("Error getting current directory");
+
+	if ((Buffer[0] < 'A') || (Buffer[0] > 'Z'))
+		return error("Invalid drive letter '%c'", Buffer[0]);
+
+	szVolumeAccessPath[4] = Buffer[0];
+	hVolWrite = CreateFile(szVolumeAccessPath, GENERIC_READ | GENERIC_WRITE,
+		FILE_SHARE_READ | FILE_SHARE_WRITE, NULL, OPEN_EXISTING, 0, NULL);
+	if (INVALID_HANDLE_VALUE == hVolWrite)
+		return error("Unable to open volume for writing, need admin access");
+
+	success = FlushFileBuffers(hVolWrite);
+	if (!success)
+		error("Unable to flush volume");
+
+	CloseHandle(hVolWrite);
+
+	return !success;
+}
+
+#define STATUS_SUCCESS			(0x00000000L)
+#define STATUS_PRIVILEGE_NOT_HELD	(0xC0000061L)
+
+typedef enum _SYSTEM_INFORMATION_CLASS {
+	SystemMemoryListInformation = 80,
+} SYSTEM_INFORMATION_CLASS;
+
+typedef enum _SYSTEM_MEMORY_LIST_COMMAND {
+	MemoryCaptureAccessedBits,
+	MemoryCaptureAndResetAccessedBits,
+	MemoryEmptyWorkingSets,
+	MemoryFlushModifiedList,
+	MemoryPurgeStandbyList,
+	MemoryPurgeLowPriorityStandbyList,
+	MemoryCommandMax
+} SYSTEM_MEMORY_LIST_COMMAND;
+
+static BOOL GetPrivilege(HANDLE TokenHandle, LPCSTR lpName, int flags)
+{
+	BOOL bResult;
+	DWORD dwBufferLength;
+	LUID luid;
+	TOKEN_PRIVILEGES tpPreviousState;
+	TOKEN_PRIVILEGES tpNewState;
+
+	dwBufferLength = 16;
+	bResult = LookupPrivilegeValueA(0, lpName, &luid);
+	if (bResult) {
+		tpNewState.PrivilegeCount = 1;
+		tpNewState.Privileges[0].Luid = luid;
+		tpNewState.Privileges[0].Attributes = 0;
+		bResult = AdjustTokenPrivileges(TokenHandle, 0, &tpNewState,
+			(DWORD)((LPBYTE)&(tpNewState.Privileges[1]) - (LPBYTE)&tpNewState),
+			&tpPreviousState, &dwBufferLength);
+		if (bResult) {
+			tpPreviousState.PrivilegeCount = 1;
+			tpPreviousState.Privileges[0].Luid = luid;
+			tpPreviousState.Privileges[0].Attributes = flags != 0 ? 2 : 0;
+			bResult = AdjustTokenPrivileges(TokenHandle, 0, &tpPreviousState,
+				dwBufferLength, 0, 0);
+		}
+	}
+	return bResult;
+}
+
+static int cmd_dropcaches(void)
+{
+	HANDLE hProcess = GetCurrentProcess();
+	HANDLE hToken;
+	HMODULE ntdll;
+	DWORD(WINAPI *NtSetSystemInformation)(INT, PVOID, ULONG);
+	SYSTEM_MEMORY_LIST_COMMAND command;
+	int status;
+
+	if (!OpenProcessToken(hProcess, TOKEN_QUERY | TOKEN_ADJUST_PRIVILEGES, &hToken))
+		return error("Can't open current process token");
+
+	if (!GetPrivilege(hToken, "SeProfileSingleProcessPrivilege", 1))
+		return error("Can't get SeProfileSingleProcessPrivilege");
+
+	CloseHandle(hToken);
+
+	ntdll = LoadLibrary("ntdll.dll");
+	if (!ntdll)
+		return error("Can't load ntdll.dll, wrong Windows version?");
+
+	NtSetSystemInformation =
+		(DWORD(WINAPI *)(INT, PVOID, ULONG))GetProcAddress(ntdll, "NtSetSystemInformation");
+	if (!NtSetSystemInformation)
+		return error("Can't get function addresses, wrong Windows version?");
+
+	command = MemoryPurgeStandbyList;
+	status = NtSetSystemInformation(
+		SystemMemoryListInformation,
+		&command,
+		sizeof(SYSTEM_MEMORY_LIST_COMMAND)
+	);
+	if (status == STATUS_PRIVILEGE_NOT_HELD)
+		error("Insufficient privileges to purge the standby list, need admin access");
+	else if (status != STATUS_SUCCESS)
+		error("Unable to execute the memory list command %d", status);
+
+	FreeLibrary(ntdll);
+
+	return status;
+}
+
+#elif defined(__linux__)
+
+static int cmd_sync(void)
+{
+	return system("sync");
+}
+
+static int cmd_dropcaches(void)
+{
+	return system("echo 3 | sudo tee /proc/sys/vm/drop_caches");
+}
+
+#elif defined(__APPLE__)
+
+static int cmd_sync(void)
+{
+	return system("sync");
+}
+
+static int cmd_dropcaches(void)
+{
+	return system("sudo purge");
+}
+
+#else
+
+static int cmd_sync(void)
+{
+	return 0;
+}
+
+static int cmd_dropcaches(void)
+{
+	return error("drop caches not implemented on this platform");
+}
+
+#endif
+
+int cmd_main(int argc, const char **argv)
+{
+	cmd_sync();
+	return cmd_dropcaches();
+}
diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
new file mode 100755
index 0000000000..16d1bf72e5
--- /dev/null
+++ b/t/perf/p7519-fsmonitor.sh
@@ -0,0 +1,184 @@
+#!/bin/sh
+
+test_description="Test core.fsmonitor"
+
+. ./perf-lib.sh
+
+#
+# Performance test for the fsmonitor feature which enables git to talk to a
+# file system change monitor and avoid having to scan the working directory
+# for new or modified files.
+#
+# By default, the performance test will utilize the Watchman file system
+# monitor if it is installed.  If Watchman is not installed, it will use a
+# dummy integration script that does not report any new or modified files.
+# The dummy script has very little overhead which provides optimistic results.
+#
+# The performance test will also use the untracked cache feature if it is
+# available as fsmonitor uses it to speed up scanning for untracked files.
+#
+# There are 3 environment variables that can be used to alter the default
+# behavior of the performance test:
+#
+# GIT_PERF_7519_UNTRACKED_CACHE: used to configure core.untrackedCache
+# GIT_PERF_7519_SPLIT_INDEX: used to configure core.splitIndex
+# GIT_PERF_7519_FSMONITOR: used to configure core.fsMonitor
+#
+# The big win for using fsmonitor is the elimination of the need to scan the
+# working directory looking for changed and untracked files. If the file
+# information is all cached in RAM, the benefits are reduced.
+#
+# GIT_PERF_7519_DROP_CACHE: if set, the OS caches are dropped between tests
+#
+
+test_perf_large_repo
+test_checkout_worktree
+
+test_lazy_prereq UNTRACKED_CACHE '
+	{ git update-index --test-untracked-cache; ret=$?; } &&
+	test $ret -ne 1
+'
+
+test_lazy_prereq WATCHMAN '
+	{ command -v watchman >/dev/null 2>&1; ret=$?; } &&
+	test $ret -ne 1
+'
+
+if test_have_prereq WATCHMAN
+then
+	# Convert unix style paths to escaped Windows style paths for Watchman
+	case "$(uname -s)" in
+	MSYS_NT*)
+	  GIT_WORK_TREE="$(cygpath -aw "$PWD" | sed 's,\\,/,g')"
+	  ;;
+	*)
+	  GIT_WORK_TREE="$PWD"
+	  ;;
+	esac
+fi
+
+if test -n "$GIT_PERF_7519_DROP_CACHE"
+then
+	# When using GIT_PERF_7519_DROP_CACHE, GIT_PERF_REPEAT_COUNT must be 1 to
+	# generate valid results. Otherwise the caching that happens for the nth
+	# run will negate the validity of the comparisons.
+	if test "$GIT_PERF_REPEAT_COUNT" -ne 1
+	then
+		echo "warning: Setting GIT_PERF_REPEAT_COUNT=1" >&2
+		GIT_PERF_REPEAT_COUNT=1
+	fi
+fi
+
+test_expect_success "setup for fsmonitor" '
+	# set untrackedCache depending on the environment
+	if test -n "$GIT_PERF_7519_UNTRACKED_CACHE"
+	then
+		git config core.untrackedCache "$GIT_PERF_7519_UNTRACKED_CACHE"
+	else
+		if test_have_prereq UNTRACKED_CACHE
+		then
+			git config core.untrackedCache true
+		else
+			git config core.untrackedCache false
+		fi
+	fi &&
+
+	# set core.splitindex depending on the environment
+	if test -n "$GIT_PERF_7519_SPLIT_INDEX"
+	then
+		git config core.splitIndex "$GIT_PERF_7519_SPLIT_INDEX"
+	fi &&
+
+	# set INTEGRATION_SCRIPT depending on the environment
+	if test -n "$GIT_PERF_7519_FSMONITOR"
+	then
+		INTEGRATION_SCRIPT="$GIT_PERF_7519_FSMONITOR"
+	else
+		#
+		# Choose integration script based on existence of Watchman.
+		# If Watchman exists, watch the work tree and attempt a query.
+		# If everything succeeds, use Watchman integration script,
+		# else fall back to an empty integration script.
+		#
+		mkdir .git/hooks &&
+		if test_have_prereq WATCHMAN
+		then
+			INTEGRATION_SCRIPT=".git/hooks/fsmonitor-watchman" &&
+			cp "$TEST_DIRECTORY/../templates/hooks--fsmonitor-watchman.sample" "$INTEGRATION_SCRIPT" &&
+			watchman watch "$GIT_WORK_TREE" &&
+			watchman watch-list | grep -q -F "$GIT_WORK_TREE"
+		else
+			INTEGRATION_SCRIPT=".git/hooks/fsmonitor-empty" &&
+			write_script "$INTEGRATION_SCRIPT"<<-\EOF
+			EOF
+		fi
+	fi &&
+
+	git config core.fsmonitor "$INTEGRATION_SCRIPT" &&
+	git update-index --fsmonitor
+'
+
+if test -n "$GIT_PERF_7519_DROP_CACHE"; then
+	test-drop-caches
+fi
+
+test_perf "status (fsmonitor=$INTEGRATION_SCRIPT)" '
+	git status
+'
+
+if test -n "$GIT_PERF_7519_DROP_CACHE"; then
+	test-drop-caches
+fi
+
+test_perf "status -uno (fsmonitor=$INTEGRATION_SCRIPT)" '
+	git status -uno
+'
+
+if test -n "$GIT_PERF_7519_DROP_CACHE"; then
+	test-drop-caches
+fi
+
+test_perf "status -uall (fsmonitor=$INTEGRATION_SCRIPT)" '
+	git status -uall
+'
+
+test_expect_success "setup without fsmonitor" '
+	unset INTEGRATION_SCRIPT &&
+	git config --unset core.fsmonitor &&
+	git update-index --no-fsmonitor
+'
+
+if test -n "$GIT_PERF_7519_DROP_CACHE"; then
+	test-drop-caches
+fi
+
+test_perf "status (fsmonitor=$INTEGRATION_SCRIPT)" '
+	git status
+'
+
+if test -n "$GIT_PERF_7519_DROP_CACHE"; then
+	test-drop-caches
+fi
+
+test_perf "status -uno (fsmonitor=$INTEGRATION_SCRIPT)" '
+	git status -uno
+'
+
+if test -n "$GIT_PERF_7519_DROP_CACHE"; then
+	test-drop-caches
+fi
+
+test_perf "status -uall (fsmonitor=$INTEGRATION_SCRIPT)" '
+	git status -uall
+'
+
+if test_have_prereq WATCHMAN
+then
+	watchman watch-del "$GIT_WORK_TREE" >/dev/null 2>&1 &&
+
+	# Work around Watchman bug on Windows where it holds on to handles
+	# preventing the removal of the trash directory
+	watchman shutdown-server >/dev/null 2>&1
+fi
+
+test_done
-- 
2.14.1.549.g6ff7ed0467

