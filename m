Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E65E20A26
	for <e@80x24.org>; Mon, 25 Sep 2017 09:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934488AbdIYJz0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 05:55:26 -0400
Received: from mail-sn1nam02on0100.outbound.protection.outlook.com ([104.47.36.100]:37136
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933128AbdIYJzW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 05:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=MwZrsWGIM9BolX6CLwvy297jxjjbmSdj/AtO16vB0WE=;
 b=o1qMDTMIvCvEVR85I7A/jEF6GByhgWV58V1d6fpFGwp45LU4OjmRv85Oz9vaYpp9ZxPe7an6J7CdA6oWFeFgk4LePbaL/xyWAV3/kmV7JM0Ccoti/HlU4DQcKgYJcR7NUzR2XsR2ZWGLwkQLkg6i/OXBxYy0acrDO4EWTdOnBBs=
Received: from stolee-linux.corp.microsoft.com (2001:4898:8010:1::2e) by
 DM2PR21MB0092.namprd21.prod.outlook.com (2a01:111:e400:50c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.98.3; Mon, 25 Sep
 2017 09:55:18 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, git@jeffhostetler.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 2/5] p0008-abbrev.sh: Test find_unique_abbrev() perf
Date:   Mon, 25 Sep 2017 05:54:49 -0400
Message-Id: <20170925095452.66833-3-dstolee@microsoft.com>
X-Mailer: git-send-email 2.14.1.538.g56ec8fc98.dirty
In-Reply-To: <20170925095452.66833-1-dstolee@microsoft.com>
References: <20170925095452.66833-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010:1::2e]
X-ClientProxiedBy: BN6PR08CA0055.namprd08.prod.outlook.com
 (2603:10b6:404:b9::17) To DM2PR21MB0092.namprd21.prod.outlook.com
 (2a01:111:e400:50c7::12)
X-MS-Office365-Filtering-Correlation-Id: 35022b2d-acc7-4ea7-076b-08d503fb87aa
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:DM2PR21MB0092;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR21MB0092;3:bzdcMZg6IaamKZHjknllsF6PzwVNifNodZhFR9KuOjE/KXXTHlnEApHOu6o00mmpBYxZTeSV3RSu8GnPGqWZOUbj1gNjx3TBqI0tpYc/fD73jJKz3DXVsqFLnlJwEHwT8hsQU65fGcgZJd0VnJ21sr630rxhstTLy/NhrCfwWRqb8UwHkjD8GLaCde7SZpWY32sxGoPHVxy8hEJszsRyTzVNqtCWX5M4xJ0dWFQV0Qn1eavsYaoGy4LyZpecKqoB;25:GSn0NnKT9EvLCrrnQe10VOOYgpWa+iBtNBxuPTesY4I+BbwY88/6ColyZCynnULzHyRfrWSkdWX/OsGq6b6xKvfepv8/pEzcvoCNv+2VtUzeg9ueqw7bLWWuZbPfvn36Vc8aoJRbPe5anco3jyLaUFMV6xmlLk6M1n4ucokEZ5kr0oFFn0eaP0qotzxOuYUTvqVJoRv02gPx0GNuJvG/p/Igp5yuB5EfTasD6xFqpXaXicKJQ8hGAnCUqPzb8W1P0j9MIZX6f2akXzwzeGIIBFpAokoErdKipq1azIjkPKsd6S7+9kdCEupcKVl9Ag1dKD2vq1TcgiLqTse5G4N9vg==;31:tLQArBD8VVfpYP7Xi1evuogAxDz6bUNMZ8wW/Jz/HAXWLXSRlmfVTuo2dC6DnQWb179J2VHrW9/qeOxMrY+sMkk7Qv/Jw4nl3HT6hQhrUWTxBnJdG/dWAjcZPEc+5kF48pazlwSWd4ysqJYRc6rf6mUGTS11r820wlSXBFmeOVmIplscl39bs9n2yD4UT2lWGcZkW5gCz9SQCH39zGZtfLZxSXT9PsPhEQzP5qNwKMY=
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PR21MB0092:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;DM2PR21MB0092;20:59YfgFiqcgSSGkda36PfA+9t76Fse0mkKBfEA+uyteONsss/aDn9KpUl8LZi0iGlNB3oUt5LEOzfsgKXzfZJyG7rjpVSqUltcCFMxvS2RxfiKS1cuqv4TFIOzcQoz3SXQ1CLMqkQAHxypZdQyYxvcQHdfu+MmVmg+TMfKIXjxhN9CDV6mNU3U15KK582cd5+eWzD52ayVX/LU4F8tZzCi0rEfXF7BqSmezfi9GKBVu1tL3CFOPozYjOBgpaYVHtWzqfRMKOpjR9ehkxReDg9o8gPCjh2CXMYvw37ywFNwko75yQfhDj+HPnrcxv9PDIR5T17KVhlmpUOmKn2vvZ5vD3WP5LLP3xzDVzUiFOEh959Ln+nUVpDR+191IBVmf2l2VmRtsCM+dckpnz/zo/dzBx6qAGcb0vLfH1sP1T/qmUT+DZGSjd6XDetw4kIERRtun0IssiABzMwsNt2iGjIpGtJEA9tgPyzKtdzwK36u1NCIaZ+MU6pUIEPvHASguSi;4:B0V1anNhDWwnYTLv8FUqACd56SeVHlqGTWzeRsOnd4J1cjHccijKM4o0dr1nvYdIhPYTSGUjnyyHYjUC2+llmnD3NRYgOoiV/5S23qSZBJLzGHmvsAgbL18yWkGI509mRqM7Dg0/oqfwaOUjcKy6FhwkOVz6g2vSDO+/wpFEJej0/TwASDGUNXhQYMUqB6sud+rzXz7z2M/xjN2bNpwOyuo3jcxYjkCcW+ZubgwCMzYdTGRlTv53fejEQGM1Z0q22kP2NYmntFPwRnd+YnKHYg2KXBKn/6BYB0dB7/BjhoM=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <DM2PR21MB0092DB7F29AC2BD58023C571A17A0@DM2PR21MB0092.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(10201501046)(100000703101)(100105400095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(20161123555025)(20161123562025)(20161123558100)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:DM2PR21MB0092;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:DM2PR21MB0092;
X-Forefront-PRVS: 04410E544A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(39860400002)(346002)(376002)(47760400005)(189002)(199003)(316002)(305945005)(68736007)(86362001)(10290500003)(101416001)(6666003)(7736002)(478600001)(2950100002)(105586002)(53936002)(6916009)(2351001)(86612001)(4326008)(2361001)(1076002)(48376002)(10090500001)(6116002)(189998001)(81166006)(5660300001)(25786009)(8676002)(97736004)(106356001)(39060400002)(107886003)(81156014)(36756003)(50986999)(22452003)(6486002)(8936002)(2906002)(47776003)(5003940100001)(50466002)(16586007)(33646002)(76176999)(50226002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM2PR21MB0092;H:stolee-linux.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR21MB0092;23:oTqOIEb7D89ZWeWSXq0n5T7uWp5SGuQ7dKdBbJ1Od?=
 =?us-ascii?Q?ifF2mBBQWQEkX5pBAb5uLmE1Et7wa9sC5n3zhsNC4j9FQfVKA4DPfOqCC8L6?=
 =?us-ascii?Q?Dsv9f35yzs4blYGuovK7ljDLIUi+BdNtL+4WuU+XP6Tqd/VfhZp49gi1sBQL?=
 =?us-ascii?Q?PENuYb0YpnGKZvxXimrEa5eRvxmPIMxOIvpDQO8O+WvbWrkuUHjYfAF99t2W?=
 =?us-ascii?Q?n4z4r1BcprrzVSOusDZGrd0h6rcygG7uwRYTOfltWdCnUrEdvX7527wVJuaW?=
 =?us-ascii?Q?mifFeKGhJlxD6XEnBO/ueALGhI+vrfEOooXBYUTxADoMcTgm5NAPyBEMXn54?=
 =?us-ascii?Q?7utsQowPtCj6znD6AhpD3yvTNcNE/7K3INDHOCwJbbZvbUkg6U/GCdq8812j?=
 =?us-ascii?Q?w9GQDTjZVnJh+i+prK7EFzM6Ee6w1q8TI+C0Synkk35OjDE3rC0T4GhBa+O8?=
 =?us-ascii?Q?qtinV8kaJMJW7Jw3FltSw8X+6ObVv6sWwMBzTr21GiS1n4n+EceMpTeiI9eq?=
 =?us-ascii?Q?fjsPxwO5SL/bgPkdYUlr7TkGbEL1ixqX+Ka/d7Mlnrz9FgVaJKJPgJV9f2Sn?=
 =?us-ascii?Q?+3Q1vEMBBcfk+mLFC/pqio8o4BbdMQMW09Cg0vD79E+wqDPZ9mqUIB+u6OAk?=
 =?us-ascii?Q?EZT5SYHX6pDr6TkJuc4MUZWc9angC9kd4A1dj0fDTIeWGNcLQBePTtLqtj2u?=
 =?us-ascii?Q?Oj1v7+URhFoeQi21yFXW2t80Y+rEGuEmxaLb/iug4Ti5LOjl4IGTiAL6As+u?=
 =?us-ascii?Q?QocN3pc6UiLfHp3nwjPO38k9z7z4+FOmQpHglow+YgQQn2Es2Bq2E/yXiLJ4?=
 =?us-ascii?Q?AQNjEhxxfpvYVCW86rpkpGXSAqV9rdRJExFzLzox2gFtU4S/C52Mt1mnigxW?=
 =?us-ascii?Q?x3LVf/Cz5oXH8/YEDiwd2fTOjvS8F5O72axSuQJ6z9bqk48PgjyAr94Uv3Vx?=
 =?us-ascii?Q?B7M4x71xFQb6N3RUUqdCoCh2O3C4aeMa4I0xrSjHsMR4J5D/tK5xPJUJmoPa?=
 =?us-ascii?Q?kv0PaFiMuRMd6foVP28AeiXYJWNR60wB05jp1alRAuSbzTaJ5X2YPdE+WwoZ?=
 =?us-ascii?Q?ZbCKi1IsdF1DHFAJFoVWzCzECgmigFowgnOmnsMxpBhnbXflYbtMHLVpoi9i?=
 =?us-ascii?Q?lbeF/ckfh5CL9eSSyD8FyJTVU7UdwQjVYCrMd+sIe17Yn258Dw3pwl+1QDCb?=
 =?us-ascii?Q?4teuRnUEXjC0vy7famSHD8nFi4FCmvnSEuWmQ89FZDNytrBIF+uAXabcg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR21MB0092;6:avQ7W5tmWicuBQHdKn33yL43l3IGG0fh7p9ZqfZmQOHhFc37oe+v8OotJI9dQQbEVdmZ4Mxx3KtjUs/NSIKmmnBq71vctENLMiFDzSdco8f0z95myL2kcIfEZjxATPLjHY/U2MrpP1UxIPSxqqvr03NoUGSNLq3WcvO+oMkYOeaZP8de78priqQ6TismJop+2uHaX2qeNjyqnSUddDodd2XWSkSGj8PxG4eDf6nHAVrb9s1atvOBoAnbPJoKZ2j+XePrdTbra2jNZwDKKPyPcXTit8vbW7W3Mdou0+z+QnT3dgCMfi8lKkmgGuA1J+KWHy9d261FGFUSbv9CiIlR3w==;5:re6fJvWEwxJ+x5l4BsqPUIzesM/ES6etANEMA9e8nKbgJGOs+/kxI01EYJcn1Mc5ySAo/4YyRpkXA1i9B25YoFjbpVFAnt/C4et+NxfLq7qiMJR9qOxl6UsnzNBj5PNgcdy3B0sA3+lrPr9Wgu4z4A==;24:QzajvR7UVndPiDcsZ2Z7Uh2y0/WU52mevqGrBXKzbufvH2n2h547/kRc68mM1FXux4drWtgR4BkQkiYh3raen+R1fRPDdfnyDypg5ZEG2AE=;7:2f+mr67RAUzRe1pVaKOtjq286m+09Kj22WH7BIUcJCspclh90ZIpmrxoONFwGTgkOC7DHh7Zpr0Y8dlkdt4dNUYvuZ/GNJBGqDBoZibLnOl9MTXv27EWNdgkEUCpYuJQBaiwMF+scCuIC4estduokpWiFniywrquD/Aq5GV+GkWZhV3LdfqtZkmS3BR/XTqWcffr0uFvHq8OauoXS32W0S7KPrTVEUWN1U+0ANEWL0E=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2017 09:55:18.6472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR21MB0092
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create helper program test-abbrev to compute the minimum length of a
disambiguating short-sha for an input list of object ids.

Perf test p0008-abbrev.sh runs test-abbrev for 100,000 object ids. For
test 0008.1, these objects exist. For test 0008.2 these objects do not
exist in the repo (with high probability). For each test, use `sort -R`
to (deterministically) shuffle the sample of object ids to not check
abbreviations in lexicographic order.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Makefile               |  1 +
 t/helper/.gitignore    |  1 +
 t/helper/test-abbrev.c | 19 +++++++++++++++++++
 t/perf/p0008-abbrev.sh | 22 ++++++++++++++++++++++
 4 files changed, 43 insertions(+)
 create mode 100644 t/helper/test-abbrev.c
 create mode 100755 t/perf/p0008-abbrev.sh

diff --git a/Makefile b/Makefile
index af94b655a..75835c7c0 100644
--- a/Makefile
+++ b/Makefile
@@ -633,6 +633,7 @@ X =
 
 PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
 
+TEST_PROGRAMS_NEED_X += test-abbrev
 TEST_PROGRAMS_NEED_X += test-chmtime
 TEST_PROGRAMS_NEED_X += test-ctype
 TEST_PROGRAMS_NEED_X += test-config
diff --git a/t/helper/.gitignore b/t/helper/.gitignore
index 9dd1c9f3c..ab9df8369 100644
--- a/t/helper/.gitignore
+++ b/t/helper/.gitignore
@@ -1,3 +1,4 @@
+/test-abbrev
 /test-chmtime
 /test-ctype
 /test-config
diff --git a/t/helper/test-abbrev.c b/t/helper/test-abbrev.c
new file mode 100644
index 000000000..6866896eb
--- /dev/null
+++ b/t/helper/test-abbrev.c
@@ -0,0 +1,19 @@
+#include "cache.h"
+#include <stdio.h>
+
+int cmd_main(int ac, const char **av)
+{
+	struct object_id oid;
+	char hex[GIT_MAX_HEXSZ + 2];
+	const char *end;
+
+	setup_git_directory();
+
+	while (fgets(hex, GIT_MAX_HEXSZ + 2, stdin)) {
+		hex[GIT_MAX_HEXSZ] = 0;
+		if (!parse_oid_hex(hex, &oid, &end))
+			find_unique_abbrev(oid.hash, MINIMUM_ABBREV);
+	}
+
+	exit(0);
+}
diff --git a/t/perf/p0008-abbrev.sh b/t/perf/p0008-abbrev.sh
new file mode 100755
index 000000000..ba25e7824
--- /dev/null
+++ b/t/perf/p0008-abbrev.sh
@@ -0,0 +1,22 @@
+#!/bin/bash
+
+test_description='Test object disambiguation through abbreviations'
+. ./perf-lib.sh
+
+test_perf_large_repo
+
+test-list-objects 100000 | sort -R > objs.txt
+
+test_perf 'find_unique_abbrev() for existing objects' '
+	test-abbrev < objs.txt
+'
+
+test-list-objects 100000 --missing | sort -R > objs.txt
+
+test_perf 'find_unique_abbrev() for missing objects' '
+	test-abbrev < objs.txt
+'
+
+rm objs.txt
+
+test_done
-- 
2.14.1.538.g56ec8fc98.dirty

