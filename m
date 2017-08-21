Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B88A8208CD
	for <e@80x24.org>; Mon, 21 Aug 2017 21:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754155AbdHUVQ7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 17:16:59 -0400
Received: from mail-dm3nam03on0130.outbound.protection.outlook.com ([104.47.41.130]:44988
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753548AbdHUVQ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 17:16:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=r1Q3TIbEiDf7Y4PR+OSnWncYeK+7bw1PFsMhMZx14z8=;
 b=RkUAyhQgcxk53oGMhTiF9RbSQPPV1GtUKM2K2mbgZM7fRnyTGenlZv/jl6ffOiT3iRt4DKh2PUroPk4g82IeR2eLpeBwTFxqCK/mFl4vIMisNmgcZRLaFFINETEcBScwvZiG1ajU7etduBuLXkNi3gYNS4QitGkndmrM8aqj5b0=
Received: from kewillf-01.northamerica.corp.microsoft.com (174.126.250.66) by
 SN1PR21MB0047.namprd21.prod.outlook.com (10.161.254.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.20.13.0; Mon, 21 Aug 2017 21:16:53 +0000
From:   Kevin Willford <kewillf@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, peartben@gmail.com,
        Kevin Willford <kewillf@microsoft.com>
Subject: [PATCH 1/3] perf: add test for writing the index
Date:   Mon, 21 Aug 2017 15:24:30 -0600
Message-Id: <20170821212432.47364-2-kewillf@microsoft.com>
X-Mailer: git-send-email 2.14.1.gvfs.1.1.g44deceb
In-Reply-To: <20170821212432.47364-1-kewillf@microsoft.com>
References: <20170821212432.47364-1-kewillf@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [174.126.250.66]
X-ClientProxiedBy: MWHPR20CA0017.namprd20.prod.outlook.com (10.171.151.155) To
 SN1PR21MB0047.namprd21.prod.outlook.com (10.161.254.145)
X-MS-Office365-Filtering-Correlation-Id: 52a1dcb1-741f-4004-dcd1-08d4e8d9f2ad
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(48565401081)(300000503095)(300135400095)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:SN1PR21MB0047;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR21MB0047;3:EzmqSmBSn6icSQoosxLNIrKbGuXD8EqqKx1dkkBQ2lXS+9HEM2nUudI3c45SlDwcfd4TRUdi6oFTeuXoj39BoTu5FrM52RP1EGazMDxzbWuUBnhL03SX/LWTuf6IIYkD3oFxmRJmgYhpG4mwLNi+RyTr9zWnauBNupzYgxgefZXDc6AmU6JMbPp5MWRvhRYVFDm/3MLZ5RfvHNRgZDWNlnpgv+JcVmObn0EGphwGjwIUsMvUBn0D4Vi7q3rPvB2i;25:5Kz57ER1AzxOpUO0KduceVZGdaf4sb0AvYen1zzTwphYaCn6HK8pKTsLBZU6T69w426R1358OgRj4ySMnkMHGoz9nTY5+Pf+BluMQnvqhFDH2codF9Sbl6tPr5jj8HGhucj2vluQYrMwiaT5/mzo2muUc4IC+XzQ5+KYoslxBCbBHoNYU0tPFKyeuEpGDN+Zs2ijAtvIijjjDseo/t9qZoR1ECdwXEdgTgTX96bUeViQAsNvXo34dqHcK0r+2+4C7kdq4ecTTw4SulNlg8BnIXqS/ESOlkSKgIRyE++2SXOCmDUqAPB5s0FwTaBYA/MfPpwfE+5M+zKAQOmJ/TWzmg==;31:P7rhWuCh+1Au10QJq2tkuq3ExiEKyh3kSo/6phf5XpfMKZ7l6VeIF0LgVVnVUh67rfCcCV8uw40vrt5L2XIjOhBbVV/uLmsEhYfwc/JwNxxSeS2rDvUflpOvdWJn61wahKQLagC1HTaY4DAuJbNZivTDi16XTKIFWexI155uaX+Pg1StgOysMv3nnMzexxIqriaGD3PLSD1XQ1++MyTtbWM7RXVTm5Mbchvb5OPyF1I=
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR21MB0047:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR21MB0047;20:LqHk84JMoVkcme8t7VLZJaupwesa4R3XGEHbPPKS0gEwdV2oBoBjHLBr2Wk/MBMa32xDUpxovufQlipUjkzV/cn6W1WDYu0fDXDs26VBeGIjqkmQcb1JLXK2jriv3Wzd0QvNjFiQ9DhSTywyr9hO2GBEdLcYy0X1GVNnZFg8CmMnODyiH6K/VY42JXTGuAJ/7fXo4TvX+uTESzeZbNvdIU05YdmkLjkXSM9AJsijGqs5/MBGIyY8LVgW1I6OLCP4d430/mXaMNFHRLogcF89yTteVSFdKn+2c0OTBM3aPUQNrO1c5z7eubthGyD1Egg+j3GvRqXy8x1XmOx00QuP+cd2lSSggI3sHrMsJgLnGvYhLLE7LwpWgRVPuGHlP5/d+/0g34pZMQs3DrpWMRsAYGCkm4WDvalN2KvlDkCXFJdL3BFCb9wduM3k06qP2VNV/o2Y9bCskpoFbhkkAnTmyI1U0a80bldQ8WRfHoOboCvZnfq4eAjNnIqjTOIBv4to;4:gkIslnpD2OrTaV1B2VZ+4UDPd2eRdfpeqfp97gBGdDKSEXXIGTMVgJOf11Js/MWVi6QqPhQgpCSB+K7k9Net/DENsaKPpzpgwAax2sfs9sPQgwQuknd7QhP6HCKHibNwevKCo/VkddiwC2QCMPUPsTEWV+/LuXTA+Jokk7Ae16CnpVSq7Z9GPZFmT4ArvbVS+e9Oe+SI0hYW6wJ8R/ewBlopFCWHh95mxTu+hslIfv0gq0h/+NhbFXrjexusTRLNjefvta4U9EDDUyEBB0F/AUnPZ7UuYoC98mVhJDOXPZw=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <SN1PR21MB00471ADCF0197130BB1DBB20B7870@SN1PR21MB0047.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046)(100000703101)(100105400095)(93006095)(93001095)(6055026)(6041248)(20161123564025)(20161123558100)(20161123560025)(20161123555025)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN1PR21MB0047;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN1PR21MB0047;
X-Forefront-PRVS: 040655413E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4630300001)(7370300001)(6009001)(39860400002)(47760400005)(189002)(199003)(6486002)(33646002)(5003940100001)(305945005)(7736002)(5005710100001)(53936002)(110136004)(107886003)(2950100002)(86612001)(6916009)(86362001)(81166006)(81156014)(8676002)(36756003)(6666003)(50226002)(4326008)(3846002)(6116002)(97736004)(5660300001)(25786009)(189998001)(47776003)(7350300001)(8656003)(66066001)(2906002)(48376002)(105586002)(50466002)(76176999)(50986999)(10290500003)(10090500001)(478600001)(101416001)(1076002)(106356001)(68736007)(2351001)(42186005)(2361001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR21MB0047;H:kewillf-01.northamerica.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kewillf@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR21MB0047;23:gXNVZ4ZLUi/yWgeLb7spM3f2Lgl0eLC/8P6VLDhuw?=
 =?us-ascii?Q?MXMslR2+uZ/upsi3iNBGKvIBmP3VkQhc4kNjt1sMY47/cR8tFF6XFcdQhkLB?=
 =?us-ascii?Q?xZSaWbmf3Jcyl8DRV+j0uoCfseCh6WHJUEdSTVfmEn26xjEuA+6ND8AodQCr?=
 =?us-ascii?Q?r6w092oY0wYR3ZKtbcRalDN5Rm5ffbq2Yzy7vBwU+iE89nM9KKTnR9bz2ZHY?=
 =?us-ascii?Q?KIKSVsd2ZrDS+ZFy3Z0KwNhQf3qnXE237m2+sh9IxbuMmclPnNs4ES7raNur?=
 =?us-ascii?Q?DhIH0+/ngQ39ZNWYzLdiYhIPQvAR+1EdU6m7lX5tiWsuzFLgWfg8kTeJFuw1?=
 =?us-ascii?Q?0Q9284ptcOi0O2s/oehE5r6DVXyrOx/wj3VjhTepvgcMMcojMB3M4pbMy0vI?=
 =?us-ascii?Q?eKskQHLNHZtl4kFWCJIxNraPR6Y0KDTmZdJuTKrmRL/ev8x0iGSK0ZI/EqN1?=
 =?us-ascii?Q?kt/RyVlZU2u1txIRRl0k2t33DJSPXLyFYyL0JQfnFFYgtBVPuBHFsuW2FjGW?=
 =?us-ascii?Q?CYYEcslLpO2pP7XxzgkkR1z3urEzC5MFsBC3qfhpgfrw1vMmT9hE3+VvkeeH?=
 =?us-ascii?Q?QkPX77appLGUQ1cSGbDnoXWx/wTuwhRBbGEYqABFqV2OGGXaY/o/9likaGP+?=
 =?us-ascii?Q?rm/SGmb+fl3BZG8RGVUknbRToB0G96DT1+qg0xiIbMRiG61qRzYPt9RsCSSN?=
 =?us-ascii?Q?XOpRXr9ILDUXaL+BHZLsjof3uE1YQmSM0XWyNj+weaz6lVaxbMrCjua/5K1k?=
 =?us-ascii?Q?+SNxnUvEJQIIHP4iE4ThXYaptsaGaipkNV+1yqaF93AW7Kito0Lt1EkijfVh?=
 =?us-ascii?Q?7dXKqS7IlEQKJyrlFNviBGIyfxffbZcL2k3bJvUme0eLHVgfkkLMPgHzMfji?=
 =?us-ascii?Q?fUBgppdDmYQ6cHjDmyuXBXKfZ5TiVTEiK6LCuDdmcqeDDlycrHBXFr69wTTC?=
 =?us-ascii?Q?DeDAOLk1f8MBMjVVtWGdZ4LH+K1NlG81BSxFKPIkDJeSG/laaxwX1bI6pMo/?=
 =?us-ascii?Q?cU3xao+nQnBqGVMSwNIv4KzzRO35XifVZZygcxMnzukMOH3dpBQpwHoX4Qh+?=
 =?us-ascii?Q?0uW2HDJdN590WNzB5V5iJAaUdklFEBo81sXIxOZAw60xNImiO6xvrnxJJUGV?=
 =?us-ascii?Q?tyKiNhVO/sl3ISASsvRCqc2qzgkbFm7mHdF1dPhaUP30erZiyuIhT7L54cdx?=
 =?us-ascii?Q?eV81JH3/IbBuDmM2Dw1e/3FXf//SPZmi50UUxPQDff64kC19/dtzU1hjW0fn?=
 =?us-ascii?Q?Pzkv7+tZLcNWajpeSFUS1JzTvJ26qKtFqbaC2jyjRGulezJ2GgkgF/4UrBVZ?=
 =?us-ascii?B?dz09?=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR21MB0047;6:22lcMRJ1IdWYA1JGUYZEh7c6WTr47vBYw/v0cSVJhzGswZyyHuIWDU6j/4qk6jENQdPpVoqJj/UTOtuxIx08sUnWAvCuzAWso/v8ycG6RBK5G4BybRxBsIsy00zT+4Zqb3bU3jvykFwLVpOx5L3kNlhvFSGNtqmm6sd3Lka5nSRYo2QxCNhNh4fji/RxbHEihyTRwma+3t9E8mIYqv1Sm5LRME2vg3L9DkDhA9aeS1jvC8zxzw1x8zqYxPJzAI858wuMxtJczo21ucMzFcQ71wD5wNZz7PiJQZA1ErEZEqxcD8HrxmqVsVPUKsxVLHpV7xeIgo6UhV0uVboOFciCNw==;5://Dete7uufjdiB6Su4t3deTWqsGfG+y/CepmNTqGjogTJCVUW5uSMjOijs2hvuJGo9MXoBIHqQ4pl0fK0LBMz5gXfle3E6a8niZ5VRtXpJqrLPME3A57HpfsRtqee5TZjWC79VlcKyfe7VIlOfsCfw==;24:mn9/0mKBcgntJAHYxoinvTamx/bLbAhGjWvRwpHZaejFteK1rS8WEaHPN9ZGyolCHMsYMkMYEDuwWMef72170+ajQVD8YY3ziD3RmFu9kcU=;7:q7btZoJidUIq7hEFO7oEeIHF6uZDITwmItcKtEJUZxYAnbFPFjrPTd3bO0slcA8Q40B7Qa7mrYBpq4+8ppGXSfzg1ejGoZCOaHFLl6Z/bGVNMf6AhCdg0wU0wAYBkXXbnceSmLk/BrlZwrYoL9Y1dXpwO28Mn1PC8xDoH+Ii+NnuAEJwpSMlKCug9Xpj3K/Unru54/7A3Aj8wBIhS1TWVzSGUM5UabSmLsd/jmE7oc0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2017 21:16:53.7485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR21MB0047
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A performance test for writing the index to be able to
determine if changes to allocating ondisk structure help.

Signed-off-by: Kevin Willford <kewillf@microsoft.com>
---
 Makefile                    |  1 +
 t/helper/test-write-cache.c | 23 +++++++++++++++++++++++
 t/perf/p0007-write-cache.sh | 29 +++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+)
 create mode 100644 t/helper/test-write-cache.c
 create mode 100755 t/perf/p0007-write-cache.sh

diff --git a/Makefile b/Makefile
index 86ec29202b..c6b061086f 100644
--- a/Makefile
+++ b/Makefile
@@ -655,6 +655,7 @@ TEST_PROGRAMS_NEED_X += test-parse-options
 TEST_PROGRAMS_NEED_X += test-path-utils
 TEST_PROGRAMS_NEED_X += test-prio-queue
 TEST_PROGRAMS_NEED_X += test-read-cache
+TEST_PROGRAMS_NEED_X += test-write-cache
 TEST_PROGRAMS_NEED_X += test-ref-store
 TEST_PROGRAMS_NEED_X += test-regex
 TEST_PROGRAMS_NEED_X += test-revision-walking
diff --git a/t/helper/test-write-cache.c b/t/helper/test-write-cache.c
new file mode 100644
index 0000000000..b7ee039669
--- /dev/null
+++ b/t/helper/test-write-cache.c
@@ -0,0 +1,23 @@
+#include "cache.h"
+#include "lockfile.h"
+
+static struct lock_file index_lock;
+
+int cmd_main(int argc, const char **argv)
+{
+	int i, cnt = 1, lockfd;
+	if (argc == 2)
+		cnt = strtol(argv[1], NULL, 0);
+	setup_git_directory();
+	read_cache();
+	for (i = 0; i < cnt; i++) {
+		lockfd = hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
+		if (0 <= lockfd) {
+			write_locked_index(&the_index, &index_lock, COMMIT_LOCK);
+		} else {
+			rollback_lock_file(&index_lock);
+		}
+	}
+
+	return 0;
+}
diff --git a/t/perf/p0007-write-cache.sh b/t/perf/p0007-write-cache.sh
new file mode 100755
index 0000000000..261fe92fd9
--- /dev/null
+++ b/t/perf/p0007-write-cache.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+
+test_description="Tests performance of writing the index"
+
+. ./perf-lib.sh
+
+test_perf_default_repo
+
+test_expect_success "setup repo" '
+	if git rev-parse --verify refs/heads/p0006-ballast^{commit}
+	then
+		echo Assuming synthetic repo from many-files.sh
+		git config --local core.sparsecheckout 1
+		cat >.git/info/sparse-checkout <<-EOF
+		/*
+		!ballast/*
+		EOF
+	else
+		echo Assuming non-synthetic repo...
+	fi &&
+	nr_files=$(git ls-files | wc -l)
+'
+
+count=3
+test_perf "write_locked_index $count times ($nr_files files)" "
+	test-write-cache $count
+"
+
+test_done
-- 
2.14.1.205.g2812f3410d

