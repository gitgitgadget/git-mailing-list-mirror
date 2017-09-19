Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A65882047F
	for <e@80x24.org>; Tue, 19 Sep 2017 19:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751397AbdIST3C (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 15:29:02 -0400
Received: from mail-dm3nam03on0134.outbound.protection.outlook.com ([104.47.41.134]:8672
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751509AbdIST2x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 15:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=GT/u0nGqE3nATT1lTnb/48l/kv807jGnW5HNa2562HI=;
 b=OHiF130NlFHtsBX0TXqR6y4ifnSWc/d8c08mFo70P+dojUyAAd9MK7+Jf7URKo9MwVLwFQnX0N907u7KXEtD+NXPqpKPcnVIQVX69YUSE1S/aC9SYrU6ARpJmOyaMm0mP2msiapuXxqgcxXD8mx3mJhQLHh7s80QzxPFiQqtwl4=
Received: from localhost.localdomain (65.222.173.206) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.98.1; Tue, 19 Sep 2017 19:28:43 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     benpeart@microsoft.com
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: [PATCH v7 12/12] fsmonitor: add a performance test
Date:   Tue, 19 Sep 2017 15:27:44 -0400
Message-Id: <20170919192744.19224-13-benpeart@microsoft.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20170919192744.19224-1-benpeart@microsoft.com>
References: <20170915192043.4516-1-benpeart@microsoft.com>
 <20170919192744.19224-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [65.222.173.206]
X-ClientProxiedBy: DM5PR03CA0030.namprd03.prod.outlook.com (10.174.189.147) To
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2f0923b-d712-4010-d9ab-08d4ff94a46b
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:CY4PR21MB0471;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;3:gXwY6dkbfvcO5craHGyDznNns3ENjYv0rYdHuHNGzoi4orQK6eS5j05S/7djsgdsm922mzvrSdk2QYJ1CHk+uTg0ulYEoLE8caAhmKjAoaAetbiLkT25heQEVeWcEbauR38a2BTs5AcYOjlgeLEnU59neUzUA0ryDMvE+SZqjZVZjcV/g0eQqZlNq9dLiP70Ovs9DN3VrkaYfJAYRC1pSFzUE15mId6qA5ntRaf0gcRaY4RjUn4ycxku1I4saBDz;25:/Pkpf+u7pfw/FpoFAqn0jQvp6I9l7beaqe0Mb0so0a21WMQ2jieg+LATriK9yUovb1oa+bEefvUKv0JCpTcU6ZJIBMwJZlbOX77AsbW1+DVlvnXrqJuiiEnnK75EeucnpHOO5+X90YMEAFf5kCZol7K39st0Pho/eX0HyEdVRIClxiCdwLDiyBL4iCmQJ4FAWLrhmfCeOID2juZYBhNuNd+5NFzxNQpndGE/ShtGzZ8+rWXqcG6vg6f+dwrdiVyrLwQE+eI7cCP7YnWgAVb9VyxFAT1tc8sWDJ7vMN1vt1RW4iEcZj+oRjdsLzAlrBrjGVhkFrNicDTEywEz5nJ/dA==;31:QGuoP3uIU5rfeGzwBAedvwL5VYaJKdd6HlXvYLELJbql/xppkv1XZkLfPZcbZt5veWbwIHnO5VKRzq2S2GhBAnoDVOvaA+4hh6BTfdbZ5zKDjx6UwB8nCJpoEET1b8/g6JoWyvyQDuFMuvG/hF9SW17fk81NRhT7q7N1LiSCoygZnmf/iDaHXAeagXInkthEuUNYKXSbmMMIueEFJ+T15oYon6ouHHNPi9nQv1i9m+c=
X-MS-TrafficTypeDiagnostic: CY4PR21MB0471:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;20:NOwpRTLeLzCHwm35tOKnsJxerJB196SWxmFTZ0RATAk0jNV6T64jtWOV2O1OJAxA+75bXZuQCrylsuL73EsjfUPRBqqY/qeIpo28izhai7Iwz+yVQnl+nJhB7+0Lm6E8XJ/7paHUGzFyCb+PWDBJCU+O3EDevth6OwWXow3xsyEDVDSO25bExrTYnuD6KP5E1SWdSUoiOAaJcG4T8/imE5KwWecleRoe+taVC8rjSzQRQKkwvyMTb5S6jdJNn+/JMb5G5eRacrXe/HuMZ3ne1VXaBFnkwECXsJ254Nctj1xEaIRTRB324qR1fUSzcs2UXHZE87zIhz6eXV/bDYWWzPRj3jC/65s08SuFAOMjqST7KUTnzUBZbiwO6aoalP0L3OzSR67cWb/rzuzrEFaM+5tECcywwM7d25OM8z8HKXR586X+hY6Mh6sbiOSRVSmh0VP0TSacQzK/5SgRH8i7yhr5JGO4FmM86LS42thzTa2lun1/5K2ZrOKarKb5R2cH;4:9zNaKCc95uJB/ZBGa7IHYQ2b5r31etzMmiIB3IYYzUgwnYtK3iqk1iuY6K8MyPEdaQH1FQ17rWzaG825fWu0LEK3KmdlLnqrIBZDdGRV1kYS5DE3apK7Ir0keqYoEwZ8ruNOxDroG6uYjAN95gaBO3/xwb3yG2NDvKgscHr0nqffHi8jRMq9naiMFMULSYFVboAFyBigXAhq0+l+9aZohcUicvdxRWLFAG0WKjvjXoqeidd9QOiD4FkGFbGpaUrLbU9q1cs8UUsct8yx4SExty57E6JN1ePSbK78IIQxy1c=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <CY4PR21MB047156D211B316D9422BFBA1F4600@CY4PR21MB0471.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(100000703101)(100105400095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(20161123564025)(20161123555025)(20161123558100)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR21MB0471;
X-Forefront-PRVS: 04359FAD81
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(6009001)(346002)(376002)(39860400002)(47760400005)(189002)(199003)(25786009)(1076002)(2906002)(50226002)(478600001)(6486002)(5660300001)(33646002)(50466002)(23676002)(36756003)(8676002)(16526017)(10290500003)(316002)(37006003)(2870700001)(189998001)(97736004)(3846002)(22452003)(86612001)(81166006)(6116002)(305945005)(6512007)(4326008)(34206002)(101416001)(39060400002)(106356001)(105586002)(8656003)(76176999)(50986999)(68736007)(53936002)(2351001)(7736002)(10090500001)(81156014)(8666007)(72206003)(2361001)(1511001)(8936002)(47776003)(66066001)(2950100002)(6506006)(2421001)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjIxTUIwNDcxOzIzOm03alY1S0NNZy9WRFlTaHRTLzNmNFBuSDls?=
 =?utf-8?B?WUl5RFozVG9neGM3dUtKY3JUZUVTL3Q5YmIzdDgzMUVXQkk1QUNvVDdKbzdx?=
 =?utf-8?B?dHgxbEJ5Ry9Ocm43dWIxMkpDamJWNEs3ajdRYnJnSHZLdXdWMk1xRm11bnFE?=
 =?utf-8?B?eVprQlIyMXBhTzNEVVpjS2lnQzJFOC9YZGxOOWY4TmlabGRscFhYVTZsZllZ?=
 =?utf-8?B?aWx1cENyQUR2bzgrZlBXR3cwQVNxeUZlWTVJSG15MWl0aEJzYnVJdGZDU1d2?=
 =?utf-8?B?NEU0SjVKSmhDb3l0RHZVY09oTlBkU2JaWjJHSXpnZVp3bXd3Yit6a3lNZ1lk?=
 =?utf-8?B?elpVTExkL1IxalRjY2RmemczdVE3eEdrbTEwYTlYVkExTE40YzdCM0xGMEFE?=
 =?utf-8?B?LzNOL0J5NTNxZ0dUODRqeUo0QVlWek5uczBxNXI1Q2wrMDdBNE5wN25MU3JI?=
 =?utf-8?B?NWl3eG94SGdnK0xHT3JubVpiNDAxc1l1M1I3N0JWTnZrdVQwb2RzZkdXekdq?=
 =?utf-8?B?VDlZQXkvSFFpcGZrTHpmWkUwajJQcEgrVDJhcXdQQnN4NHlXbjRueDdPQm8r?=
 =?utf-8?B?WjAva3FuKyttbkQ0U3MvYllTZ1dEZk5Dd2ZZMVluYXltTFlXOXpsN2tIYUM2?=
 =?utf-8?B?bUNTRzR2a1BLanRJRHlIVU1yRU52UTdZbWhYSWdPTUNtS1l0N21BMzJKQVNy?=
 =?utf-8?B?bFJWZ1AzcVk3a1RRT2JUdkc2ejQ0VVVXWExMRy9TNmhYWDRyeVBMMmtDWkZQ?=
 =?utf-8?B?R2liYkJULy93S09wSWM5UGMxVmZ4WXJhSEk1VTVnZ21FYVJyZUpvSzJ6Q0tR?=
 =?utf-8?B?Y21RcEF2Smh5SEVjNjJPR28rU3dabzY0QXNWZ0VxNUk4NmdDWnZlcGVlUVFn?=
 =?utf-8?B?aERCVFF6cGltWGlpYUxHcFRkUElXV1Q1QU9nZUxZWHdkL05ucTdoTXBNNmtX?=
 =?utf-8?B?emRXM1hBK3QyN1BqMjF6d0NjLzFQUnJvZlcxZGM0UHVzd1RudEJiZU5CMmdX?=
 =?utf-8?B?dzVJRElJcGZCQ1UzM2syQVJQUUVYWWRCZHBjbzlNT29RbitjcitSczJsSkh2?=
 =?utf-8?B?K1Q5YmR1T0hXcXZXNW5DUzFxVkFDYWtEcmxyRGMvdHlCRUVnWnBrZEF5VGto?=
 =?utf-8?B?K0E4L1RzcG51dVZHcjk4QVdxaU4xcWg3MVhPZm9Gc2ZRY0NMa2MzaFlNMkFh?=
 =?utf-8?B?ZnYxYkFxZ0l1dXozbEpPQUlXOVFVMHV3dEdKbWxMWnZnZlVSOHhkeU5saTVF?=
 =?utf-8?B?bGJPeGhPTUw1WGdUVHJTSnpVUTd2ckFOaFpzK09XVmFNQ2l1TE9pWWR6MFR2?=
 =?utf-8?B?SmszR2ZhT2dDWTRKbzU4ZkMwdFBLRitGNFovZU0zejRsejZsak1hRDVwM3Za?=
 =?utf-8?B?eTA4NzVRTW5uOWNuRDFrVFBGbWJUVkpBZG0yc256TWZXVlRlbTJCYzNhSTlp?=
 =?utf-8?B?M2UxSnlDcCswT096bHdzT3R2d0E1YlB0c3lQaVU5dUpLVHBLQTA4NnFOVHlp?=
 =?utf-8?B?eE1iTzh6MVdocFp4M2FxYTdWNlZvNEZEUThpRUhQbEpmditSa1hTMFVKb1p4?=
 =?utf-8?B?TU9PV0tNNGhBMmdkLzI2TFRvZmczVkQ3SXR1a2kyK0hjRElnb25nRExVL2Uy?=
 =?utf-8?B?ZGxQbXgyVzROd3hvOENIMzMzeTlWQjk4b1FyNGtiQmVQWWNyTXRZbk5mdnRw?=
 =?utf-8?B?bFYzU0RKYW13MGVoQzVNZTA4NHhZL2g4enR1MHZrZDFzbWlWbU8wWk5TM1lv?=
 =?utf-8?B?bk9ReHhrakswamNldDlDemMvYnpJZ2t4cVExc1lNenZyLzNyRjZmUnpDY3pJ?=
 =?utf-8?B?aTl4YXhITE0xRkhUUzBMQVhjT3RyZEtpZHA3VUFLRmo0VFNoNEwxUU1LalBH?=
 =?utf-8?Q?yM2+9esi09YAj0TYFiebtvJ+YHEUfXla?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0471;6:srqr+RlizRcQtI0k017XuNXfEj7ybBm1KtLD0JtCubYHVrnXaEOwi6TS8urFeez3+1YsPD+W9roGLNHMnGA3rYhFh8MC/oMq74F93AdXDokWb5TCdve94uKsvuwuaXBnaphesDYRTTSdSa8R9WFrbLz8u2reiAgiIviYcVG5DYvuQK/dAkbY1ue+URxRdmQGjpfqu0WUaks/rWAG2vhyiBf3+yx5yJpuBcGPWy6Uddb95p53xPxxvnoxHhwSvIpEsCEU6Ne+mRfCq/SRM9xdLMVulfkoeRQEuU0BxRqnGQGVAkn3tcwlAHeAhrBQrvzWfXERfgcPS0XpmAbcdlFDSg==;5:29oNY3vSDDn4Fh717U6ZZNeKKK5aNY/p6ncHoW/wIVy67NoqP0KDKbI1rXWlvtix2oRXCdgEfzywl7LIWD9JNJlBC6gbxMDVd7iUBKSqPRgBebcncHkdQ8hrPnF+yD+t242+AwiMOB3pGgjBDCEMbw==;24:v1T0dvgGStBOBxOK8OuhXyXpMl5d2iqmacUjQ/rEjGeKb/qOT/WMaoxGsoYh4Q/vzDDInx1Mmai5oOle3pArR2Zi7lYbZPPpuHjzCvGAIOs=;7:aE2WqRFL2kZKgWYU5pzswjuXDRxFQGnImbzR9bq4MUvDiXjCvRczUqsoIP4n2JcA4fq/JzqApK/7QPPy1sR/Bw9SoM9+3cnrAe+CCn+0zoqaoOkFfp7t2zkvbgyBLPvrv7c0PvAfKCPt/ZgjczCdlCWKpE+EtAxToAOzRs6go66nI03EJUB6ti/tCEhLQ4h21d/pdPJKp9LC1v02o9/nuT18wxRCwZRsVWIFgPIVYzo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2017 19:28:43.4387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
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
 t/helper/test-drop-caches.c | 162 ++++++++++++++++++++++++++++++++++++++
 t/perf/p7519-fsmonitor.sh   | 184 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 348 insertions(+)
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
index 0000000000..4e5ca8f397
--- /dev/null
+++ b/t/helper/test-drop-caches.c
@@ -0,0 +1,162 @@
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
2.14.1.windows.1

