Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0593E20281
	for <e@80x24.org>; Fri, 15 Sep 2017 19:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751800AbdIOTVz (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 15:21:55 -0400
Received: from mail-dm3nam03on0117.outbound.protection.outlook.com ([104.47.41.117]:20724
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751323AbdIOTVp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 15:21:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=BtyBYt3qOws4dHj+FyJvadmklq3wGVt/ysziTl1SIxc=;
 b=XwX2iEl7T/+6GWyhZb26mfPIQWVOZzXfH03uLDJrVcVKzbGVlj5ZUlXXx2fnFAd6BA9+rsdPu2YyJ19fPDRdG8ASEnOkw3eL/qwquOqJ41SX1jTpThcrJjH1ZtPs+3oLg4K/QTSNhfavhYd3fPgG7g698/YRy4Gr3nGisfpEM7s=
Received: from localhost.localdomain (65.222.173.206) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.77.7; Fri, 15 Sep 2017 19:21:39 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     benpeart@microsoft.com
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: [PATCH v6 12/12] fsmonitor: add a performance test
Date:   Fri, 15 Sep 2017 15:20:43 -0400
Message-Id: <20170915192043.4516-13-benpeart@microsoft.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20170915192043.4516-1-benpeart@microsoft.com>
References: <20170610134026.104552-1-benpeart@microsoft.com>
 <20170915192043.4516-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [65.222.173.206]
X-ClientProxiedBy: BN6PR2201CA0010.namprd22.prod.outlook.com (10.174.119.23)
 To CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94ff2bb4-4c6c-46c9-1f8e-08d4fc6efe97
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(48565401081)(300000503095)(300135400095)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:CY4PR21MB0469;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0469;3:lMNHmV5CmZuYB5TOC99vm0jJcInNkoG1DyOcCLdmNBTh+iOldUtvh4ItkYZNRxxvYm6Wq9rnoyX4dwFo9V/s/jltZDlMTibloJC/ob2+ZnjFTsgEgIkjogtsnhikrsU8BIhIc1759jd1LZ6u30WYO2/7yU/mV+F/hojZYa68ZLOGEsWT+RAV2mRLdK81wvHTpTN7seGEClxJWvdoRoqfFbuNB7AbO0ApRubgMYEVSWu9yo3IM/oMoXWPgXwoG0Mi;25:voqseey9y9JXkfNFRQBp9/YisyTUuSKhsl+TwxoruqqICEUn1NQmK8qh4YlHtCqFF9YBrR9847EwlosFvFKpsltOyCV2huWBqMVLN+vt65qcqs1nVfZ1nB9H1FK5EutUm0rZ03C5MxLGU7PisiUYI+IgzssoYePSkfaSwz/EErXZpTcxMiSJCUPwKE+ZnxvS+gXMZGyARXALg455WZTKok4lc84Bdp65U1iB6pBE5iNr7o/oD/2/K6BaVfH777CaPo4gXnBGU9OLBaa6a5CbjxLSf3xTaw5jKcZZgbed9bJBBoS6o9zCFmpo6JVNcs3w4K9ZSB/P9qnDXv+7I1RtUA==;31:HhOlaHxsFyrah4V3Y1DJr4Jvl8gpJJ8JX3JkBuIwW+XvL/2+ZkUjmaM4iWiT1qYDdpOQt3CfEbfpUaWDSjW6PmmWGpEF4eTmGn6ctjbCYmTS8OTTbrNSWgHaoqZnMFtDEEFYhAbWNACtmcuFz8ximFt6cDPMSO2ywkSkXseTGY+6NWy1GSYh4I2q9ASntWz12ckA/xkHUH8sXHCqESVyKDykilBSTiEpRiWsvymtueo=
X-MS-TrafficTypeDiagnostic: CY4PR21MB0469:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0469;20:hePN7gkrWEfETNN9PJJMxdglOVAMNdLtyNvcEiiXX6HU5STkLFJ7T+uLUW19pswVjtRiPTfCyA0mXL4kEeCyJjZYWp6NmqXIn/kmhmSWmITCRcN68CG1bKUtGZIXa/rq8EL2k7SJopSDDGUhdhjwpBFp5/vHfj1MSB30fJnjWcsOYMEEiUQcMnwiTc4NMWUtcw51PejXXqUoApeu40H6TXJx98JpNAfQ5vG8P3N1Wwi4h3t0y8FGvsBZP62AK7rIaqwdiTj/1Cv+/i48LeDZSAbHbYBt7qOTFM5719F1iCs9xW0F2bfIzIishy8Ld4c+5sMQwEcHE525R+msZLm1o2lRqM/gGAX7KNCyR4CzqTyJ1TJU1bzWF+PJmEM1OwRD1zcb1GdNlYIZqTSUmkLXeGSLVQ0Q3P0t3fhAeDRKyZlJgSTFXYbWbUphIIDca0IaVRCI9SC/ytYeLXH599ucLZ4+VMfWzf/s485dpLMiErKVBOQVpB3+YOB4pT3cuDB9;4:8NmPEc4z1g+VcyzduLuGz2GQgOlZycQF8KfzUBeycUtCanH44NsemmsmJzj+3P/8ALrqiuUZ7aAmbz23haMGlg1pg3y5TGzocBipVwYpxrLusfZ4JEaHCxzltEdcWGbfbMePqarjkF1n0rlbrVUC1EB5U3y8WjcbI61yDWKC8J2WjhIey666k9cbWc4preE1rLWIU9HIvknFae2hx5IThp+XKPffOjmvqPQGVf3UO9pPnlb/R+TBOTnga0lbalv6R+dI+F429fK0HAwAipz6els0L2j8hVOeG4Dni33B4oA=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <CY4PR21MB0469A7D4AECCD90F1E476D8CF46C0@CY4PR21MB0469.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(100000703101)(100105400095)(10201501046)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123562025)(20161123560025)(20161123555025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123558100)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR21MB0469;
X-Forefront-PRVS: 0431F981D8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(6009001)(346002)(376002)(39860400002)(47760400005)(199003)(189002)(101416001)(4326008)(39060400002)(110136004)(34206002)(8656003)(25786009)(97736004)(2906002)(2870700001)(2351001)(50986999)(76176999)(22452003)(50466002)(2421001)(33646002)(68736007)(36756003)(105586002)(50226002)(23676002)(2361001)(478600001)(106356001)(16526017)(1511001)(316002)(47776003)(10090500001)(5660300001)(6666003)(6506006)(2950100002)(72206003)(66066001)(6486002)(6512007)(81156014)(81166006)(6116002)(7736002)(305945005)(8936002)(8676002)(3846002)(53936002)(10290500003)(1076002)(86612001)(189998001)(8666007)(37006003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjIxTUIwNDY5OzIzOngvT0o4ajBPV0VRdExXZVlTU09iR3dSL0pv?=
 =?utf-8?B?VW4xYW9TaHQrQ3FRdGU5UEVYaXArOVhxeHFlcElEOUtkV3lPbE1heTQ4aTdF?=
 =?utf-8?B?dEcrUXdNR1ZkUEZjS2VVT2NDa0lhQnFCQXJiUjVGNnFNbmI1MXc4UElpVXlI?=
 =?utf-8?B?UUcvM0hyREtJd3ZMUFluYXZ4S0xTcEJuVnBNU3F5c1BJcytYMGRFSUhva0JT?=
 =?utf-8?B?RW0wVWM4VDdZYjQ1dnE0TzVZK09tVzljSTZieG11Z3QxY1Y1ajFEeUJYZk11?=
 =?utf-8?B?b3JvOGlZY3YzTlQvSWp1c1RuVmRJbzA1ZEQ1T2l6YzRFY3U3NTRzMmIwWmpP?=
 =?utf-8?B?eDlYWExTVHhTVEpTblBTQTVVeXZmT1h2UnU1dFM5T3JwbU4zN01hOVozRk1N?=
 =?utf-8?B?bml4ZUJRU2M5cGUwbkljZUVoRUpOcWxWdEJHR3VLbndiOVlmeDArZUV6cEtr?=
 =?utf-8?B?Ym5wcE9kZmxRVk5HZDk4elJ6Z2ZxanBlcE15V1dPRml3d0ExdmtsUmpId0VU?=
 =?utf-8?B?dW8yQUFuZzBwQ294Vzd0T2NGRTZUMWNkWHVUZ0JlMUcveU9LaFM5QWlTM29E?=
 =?utf-8?B?RGpRajFVNmI5eFJ1R2YzdVc0ZlR5cXIvKzlVaTROaFhSd2loM0VWOWNwUHAz?=
 =?utf-8?B?M0NPRWwxQ01BYUJBNjJRRXZ5Rk55S3E5bHJiZkFGd0dLdmEyZkJsemlKWWFI?=
 =?utf-8?B?aGtiTVI1VSs0Q3hJMWRteVAzRkRnSHJ4VVI0V2REbTV2ZjNVYm9CVzdLYmF1?=
 =?utf-8?B?MHhJTzNXQU1PTk1iUDVqaU5UWDN2bWVUVVJwc202bHZkTVFyZmhadmxMWE92?=
 =?utf-8?B?dmMvSEZxU21idWNBWXBWL2FNZG1QV0lhT0xheHdYSXhicVFRYkhuZStIVmQ3?=
 =?utf-8?B?NFArSDlBSFpnbkwwN1B6Y3JncjlRSzhxamxObHRiaUlMVlZhczYxWU5ORi9X?=
 =?utf-8?B?TFllRTIzbUUrYWtZRXg0b2JhT0IyTlBUbHpOd213b2Y1QThWWGJCSHUzK1Bn?=
 =?utf-8?B?MmlwUDJTZVRFUEJkUGh0VEE3dW14MXRnMEZlK21JVHFkcFRYWHU4NVZkVU1H?=
 =?utf-8?B?eWFuU3FXZ0FLZUtYVXhNVnVSMWR1NG9rWUhEZ3B0RE5LQ1h3ZDlqYkdhb3U3?=
 =?utf-8?B?MlFHalV6elNpc055TWVRclhCUFBqT2JneUh6QjR5KzhMeEVLZTRDL3gwSzEr?=
 =?utf-8?B?elM3Z3VPRDZDL0xMNnFnRFpCSy8wdDFYSjZrRGhSM09RK3ZVbHJtYlJ5c1BI?=
 =?utf-8?B?VDVUb0EyMmdxWVdQWG81Z0xLaGhHaU1CcUk0RFpCUmR5S0pSVTBLRVA0LzQ1?=
 =?utf-8?B?dEN6aEtTUXpUUnJYVko1ckpndVRTYys3eEUwaUcweU96QUx2aW53ZlZVY1Bi?=
 =?utf-8?B?ZXZkcGdWdlNzcUZ3bUJJQXFVcWRnZVg1VU9sSy9TajgvdEFlYzdGKzVPNktI?=
 =?utf-8?B?QityZjdxQzhGQy9KaGVyREl3dlFpZFEvdVFIVHFVRmk5Nks4Y0UrazRFOXpP?=
 =?utf-8?B?MGhlSTR1UFNLVFRYTWZjYi81N2k2MFpFc3ZsRE9wWVdOM0JoeDVKc2tWQjIv?=
 =?utf-8?B?ZVI4TEFScjA2eWllVzQzZzM3RVl4eG9udk52TCtubzJqend3cjdIZlRMMkMr?=
 =?utf-8?B?ZUxsOHNJSXlxVGRla2IvSm1Sa3d0eXBtWE93Q1NZQWtuZFR6NkVLQlRMYXBW?=
 =?utf-8?B?ZnlPbFRyampVTFdzK25lU241dkNXNHYzcVcvQ0hRNWxKR1pid1B4RmNXc3Az?=
 =?utf-8?B?TGJ6ZjJDenk5MnZ4VEVyS0VGaDBEOG4wL1M3UUE4R2xkOHNqb01TQXZPYndC?=
 =?utf-8?B?YnN4MlZZbjkrZDZoTFh4N21WaDMvdkt4ZHJtbXRMdVBXc1lubnZjaHN1R0V0?=
 =?utf-8?B?ekxnUVNrUld0VHRYc0t3ZDU2aXVjTDVKVml0ZDJHRERtMkxsRmpramFDcVlv?=
 =?utf-8?Q?AG5NiDmGU0vbaUfioVHLURBWkg6E6Q=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0469;6:1+k5JL1D2pBRRrcnAOHOSo665cgi9jOirF9GPElu0yrprcsc32hRdy43DgRRI39ICaw2+/V2igelS2LvG51O4+doDyouj6oOrvY7KaWd69pGwon2pytWUOQvho63UCKgE4Y3kOg+BQUoB0uckSTPsWvIXJ3reowkkwW9dJ/XXGWzqRgLS52PHbQf1QiMb8mAPSVv8qO0T28lXxlmT1uKlGK6pMiyr+DMbt11jwhVcQZVnh2Lqa9ZCSGi0Px3iB00/W3AbzXHM3rlNscvR9oOSoWX7fSr8QgAIAZE4AYf3q9aGizenG7w5oGMZpmuPMDSXiD76s4017M4+tdan+b8BA==;5:3joUTD89bMzrqJM0YWfPPwJfUkPbeqjEVRtvlGnNE8DPmJK+3W1MY6smphI+6Ab9Qha1MfiRJh4NOQcOYvzcQ28gHJn+G2+BoHEjzEyL5HbW+vv8Xt2+sNZRviRU+hFnppw1hCt91+Q0Y0+fmIHvCw==;24:svNKg0FxCtGx4ieq4wh8kirCaa3A/juhRP8uwYPNMH8dMtQrDCTsRuiPqkpOuN5F6UDoURYyrOK+GTy2RNi7Q+sV42v2jE+dG0lTPMSEb88=;7:qI0jzUqP5eI6xgei6pY2KaZuSUDfXfY8iJZpVK+8bx41MdMQGhHSFCDoq8NzpcZd0j7W0iLv1GQPRBbDF9XbCYz9l9y5LG/ZkoH5cdHMGdZtIYTsmAej8H09wASvnC3Sjr3rtEfthLB6RnX/0HDerAZvfUm9wS/kubdB4d7yuLSsoAnGlWz4iqxM4DDaJ1IA+pYfSQnlzfr7e43ZbjO3mlWOBSXZDgaz+A07rNh89do=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2017 19:21:39.5720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
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

There are 3 environment variables that can be used to alter the default
behavior of the performance test:

GIT_PERF_7519_UNTRACKED_CACHE: used to configure core.untrackedCache
GIT_PERF_7519_SPLIT_INDEX: used to configure core.splitIndex
GIT_PERF_7519_FSMONITOR: used to configure core.fsMonitor

The big win for using fsmonitor is the elimination of the need to scan the
working directory looking for changed and untracked files. If the file
information is all cached in RAM, the benefits are reduced.

GIT_PERF_7519_DROP_CACHE: if set, the OS caches are dropped between tests

Signed-off-by: Ben Peart <benpeart@microsoft.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile                    |   1 +
 t/helper/.gitignore         |   1 +
 t/helper/test-drop-caches.c | 161 ++++++++++++++++++++++++++++++++++++++
 t/perf/p7519-fsmonitor.sh   | 184 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 347 insertions(+)
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
index 0000000000..717079865c
--- /dev/null
+++ b/t/helper/test-drop-caches.c
@@ -0,0 +1,161 @@
+#include "git-compat-util.h"
+
+#if defined(GIT_WINDOWS_NATIVE)
+
+int cmd_sync(void)
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
+BOOL GetPrivilege(HANDLE TokenHandle, LPCSTR lpName, int flags)
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
+int cmd_dropcaches(void)
+{
+	HANDLE hProcess = GetCurrentProcess();
+	HANDLE hToken;
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
+	HMODULE ntdll = LoadLibrary("ntdll.dll");
+	if (!ntdll)
+		return error("Can't load ntdll.dll, wrong Windows version?");
+
+	DWORD(WINAPI *NtSetSystemInformation)(INT, PVOID, ULONG) =
+		(DWORD(WINAPI *)(INT, PVOID, ULONG))GetProcAddress(ntdll, "NtSetSystemInformation");
+	if (!NtSetSystemInformation)
+		return error("Can't get function addresses, wrong Windows version?");
+
+	SYSTEM_MEMORY_LIST_COMMAND command = MemoryPurgeStandbyList;
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
+int cmd_sync(void)
+{
+	return system("sync");
+}
+
+int cmd_dropcaches(void)
+{
+	return system("echo 3 | sudo tee /proc/sys/vm/drop_caches");
+}
+
+#elif defined(__APPLE__)
+
+int cmd_sync(void)
+{
+	return system("sync");
+}
+
+int cmd_dropcaches(void)
+{
+	return system("sudo purge");
+}
+
+#else
+
+int cmd_sync(void)
+{
+	return 0;
+}
+
+int cmd_dropcaches(void)
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
index 0000000000..1c5978d5c8
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
+		# Choose integration script based on existance of Watchman.
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
2.14.1.548.ge54b1befee.dirty

