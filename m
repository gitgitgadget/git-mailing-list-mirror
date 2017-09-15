Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFE6420281
	for <e@80x24.org>; Fri, 15 Sep 2017 19:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751925AbdIOTVn (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 15:21:43 -0400
Received: from mail-dm3nam03on0117.outbound.protection.outlook.com ([104.47.41.117]:20724
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751810AbdIOTVi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 15:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=bIbIibeLLj05GL+8Xjq5Q4J7WAwe3v+59MvQpXO2y8I=;
 b=AK8OqM4hbBmGqidA8pf4XisxRdEK7RSf9KDdBOpDucYAR0RGTGWJ53lfvF3QPeNc4iBKkR9SVlepVTxXHF3KM/RrjW7ciLQRyusjsNwvHYe8A2lthTF1Ehy/V4ijnBhQMxUMl79iBKXWmzCsGYNW4FssqgLvA7LE0biFKEHGS7g=
Received: from localhost.localdomain (65.222.173.206) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.77.7; Fri, 15 Sep 2017 19:21:31 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     benpeart@microsoft.com
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: [PATCH v6 08/12] fsmonitor: add a test tool to dump the index extension
Date:   Fri, 15 Sep 2017 15:20:39 -0400
Message-Id: <20170915192043.4516-9-benpeart@microsoft.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20170915192043.4516-1-benpeart@microsoft.com>
References: <20170610134026.104552-1-benpeart@microsoft.com>
 <20170915192043.4516-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [65.222.173.206]
X-ClientProxiedBy: BN6PR2201CA0010.namprd22.prod.outlook.com (10.174.119.23)
 To CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147)
X-MS-Office365-Filtering-Correlation-Id: c76d1549-3f5a-455c-1ffe-08d4fc6ef967
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(48565401081)(300000503095)(300135400095)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:CY4PR21MB0469;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0469;3:Srl6sLbhPOmHeAiE1Sj98Qrat/Ii+0xmanqtXb4w4O87nM4AdnqH3PH0SiBh9mUTBABwh4P3DBZ+9oH/GZjFqbtVlG4VKClZM6EI2sUXSZo9sQ/8IZRwvk1Am0llwb0e9yE6V+mwCOVEmjSp/pe3frDs38ehnv2czuprvYAGngFVH7th1NrBLrVkG/l8oNy4q1GfWOd7lyKe8wWOgROcA1ImxhgYGgyyY7nRXaOFNB+XKlm9+XWS6Im7OWSlp7K5;25:zyESMM8glh/n4lZDCowT75UYPgJt4pjw8G241KRJu21uzPcwrBnXKp6LDc5qtxs5WIGFObGYu9DLmluIpVLApSceP2OeksFIm45h3jO8M+cdoXppACDkDmMpQP1dQCquYRV4sSA2DeRSWFyC9vqJ6CAeeAhbvET+khDazwfa7yMx7b9+13DJBUOVFSYqX+EApgJL6c7fk4zV25pJ7yTzQ7I2j//6xQ3AQSXQY2wTa+e1qGCF5ZXQzzIjXVAbcPgIa83JCThL19VLALBiOuDh7FoDwTkWEdJ7c0M0niQPk7THkHwPCbHIG9LGT0LGDY+8ClHyxP7UDJjWvIyGK+Hf+A==;31:/DCLuoUuosT5OZWoqMICz9kA5YVBAtw92pRq3mu1r6DIiShGCCRZJguzyevCFBacUIgwxlUt2Cjh2avkIfr2vsE2ZWpBTcIVeVPaj3Ef0sp/+ym66HYqKXEXzjhUnHiNWqM2Ls2xzEgcZhh7VS5S/xc+3CuzCvBjqI3v9QXdZd/bsN0y264C2GQg1DNwDoqsVPdCXjzQt9/nDNOXo7d2uT3sK+ir3Fm6FXNS7mzOk4o=
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR21MB0469:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0469;20:NOu9MH+z0AshPUHhAhQsURxmagxkmamSHkm5yoMKKORklbZEYE/XdprXMT1y4c3OX5tYtz4RxqfCPy6rmWFeTsi+19KY2I5tK+Rj3ul0EDCBzeGGmN0m9EsySAmKPwurELPIREWDuD/P6o4B6+XC5S7v8dCO+pYPMUqm8XgCwbIPlJnEYl88lwa89TgUgTEXYPsizBcR6QDeJ8R0A8Vz/Nw4XLb0qso2EaITzj83SeyoyEZJlMv4YzUBYgvE2UYKyYP4i96eOypRlTcRpnv0+EYyUuKWEhuA2nWWVeZEHkd+uARh06My+sZ6gA3Sy9jnoFia01MVjNUkK6Cpvp+gWuZjBwlNEX3qb7eaMH9sA1EjrWIc1mkCa7ed8UH8scEdWOmalq/DoJ+cVaMN2dL2/xf2CR5rNcTv828ryngltSKPQNL65KwEC2T5oDBwoKqhxI+Sbb+OP0Qx/OZ1KfQBfnG0cylKcd9rWo1QCTzo6jw++yguXUhaQBt2jgPF4Bto;4:Ny8PhdXDwLZYTYm1qhSvJt/di9PJ6NiK88KrWKWI0p9NS8o103R/iG8a44g11e/AvoMEoe/w2qvZa5yPM4n8M5CEcHZembIjeW5GCewUYAWpT8MjLLM/Q/86lwjA6wXpnZe50go8y4K9C+U0Kt91VLzGU+dYS+yGm/pWFKHb018KD9dUmNddw3vd3qNugNQcEtBtPDu03vPzjhCWuuv5j9MBoln8hrrL3HC61NYhpWeSIJ75XZSe70i5uX0854vcdi1JRKFQ7Ok2YSxhuUcrcwq9Gp99tnV6EtfKZZVJtZY=
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171);
X-Microsoft-Antispam-PRVS: <CY4PR21MB04690E997B30622D97916D50F46C0@CY4PR21MB0469.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(100000703101)(100105400095)(10201501046)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123562025)(20161123560025)(20161123555025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123558100)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR21MB0469;
X-Forefront-PRVS: 0431F981D8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(6009001)(346002)(376002)(39860400002)(47760400005)(199003)(189002)(101416001)(4326008)(39060400002)(110136004)(34206002)(8656003)(25786009)(97736004)(2906002)(2351001)(50986999)(76176999)(22452003)(48376002)(50466002)(2421001)(33646002)(68736007)(36756003)(105586002)(50226002)(2361001)(478600001)(106356001)(16526017)(1511001)(316002)(16586007)(47776003)(10090500001)(5660300001)(6506006)(2950100002)(72206003)(5003940100001)(66066001)(6486002)(6512007)(81156014)(81166006)(6116002)(7736002)(305945005)(8936002)(8676002)(3846002)(53936002)(10290500003)(1076002)(86612001)(189998001)(8666007)(37006003)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR21MB0469;23:4KfU8El66EOW/bbuUvZhx8LLz6861fc9eR4DYWVLm?=
 =?us-ascii?Q?hwCVGZAKhx8TATBQlewYerrYxLql2C8YdLn6IV0v4zU6XAayXi7gPjHxc8Tr?=
 =?us-ascii?Q?fIYe3GFMzUNP1tOsOtM/H1M6Vqnk/7toGjUisxSrFafh37UftId3qc/N46Su?=
 =?us-ascii?Q?l0ar2MgBPGXm/Siz/VgO2avSEcUSR361sxATK915M0ubEp5pIqL68tyu/cwM?=
 =?us-ascii?Q?Tv+eS+n859E/5iJq5NpvJ3EuwJzoY+S0i9uwwKn5HoiqoorawKDJH43g33Dc?=
 =?us-ascii?Q?OhMI83yE+HfcOqjqkG+74IqIChkEK0g1L8EtgkBCgYJm1e+TGqt7Djsb1f9I?=
 =?us-ascii?Q?6z07X380307BoLFODFvZoyWS6xXnAhkj3yAesmPhjyGg2qQF46rkW4MNIXRd?=
 =?us-ascii?Q?n0ySvGyFdcCxQ0Bxdq8X/oJNrT9GpJjczeqHJ4CVBia8mkrgJs+/1SzvbFzl?=
 =?us-ascii?Q?WUBRshucWQ45hgVYKWGBgN8c2YCuleYJHJSta/QuQ4+SxZ82MEbTCrkyxlCP?=
 =?us-ascii?Q?kaAVadK5Y5pESQXzhL5M3tXGKSoihzUjdFJjAcmeZqI+9S/Qjq5SiNh5Djjl?=
 =?us-ascii?Q?LjzJ/ljs8JUAL2HmkTjWlIWNzhbWgdzneAcc/GP7FpysWjQwWQz8ggNXWek+?=
 =?us-ascii?Q?OWtH1OKPHGNyDPEl4zSUQvwCuaN3pSB5aZDtZIop6BfyXDYrs2t20F/S8rq1?=
 =?us-ascii?Q?BeozKhcuwL6CGI7wFFGvkJuq+SHqRovv4IVpfyMFNciiceDCok7xGa4NbQ7l?=
 =?us-ascii?Q?O1OeA2LhxxhOnnbrTrD1yE3LxZ4PpRl0Lvc8YQnioo3YNDBFAhju1I5Lvj1G?=
 =?us-ascii?Q?D9O50TAWHe6C4M+ap9FTFQcZqz+Upjj6ZVlGrFx2wgSOjjq7z2kr+qsRdLug?=
 =?us-ascii?Q?tDmxnEaUsp36MQDS0L//KMx50MXOYlsa6/6h7SwRO/F1/WBnPfVko7UArFsz?=
 =?us-ascii?Q?gY/Oz5O2hYznX44UwknQqUzv5K6VeFEVFmzzbmXzSzG+hHZVnJszSZF2kFKF?=
 =?us-ascii?Q?y6tHq+eLfAgft06DthIMfUozeBjEVyC9J800WeFrubJ/M9uLZyHkv1Vqt9rF?=
 =?us-ascii?Q?5vCm+A00rRyabI2Yt51hjGZshH9g+1e2d/SEXP/IlP0UPNh0ONS5FolcNg1r?=
 =?us-ascii?Q?Y0b67TVNpHeGAW2JOoY8FABPtg3io5hx95Q6mXz7ss37iRHw6uqcJUJggwoB?=
 =?us-ascii?Q?FD+34mqlp7XaxoG0YmYmv2rjzRyyy7pwXeMwt3i8163VrFtNzHncuDICY0N9?=
 =?us-ascii?Q?fnkwWK00hDMJ9+DBjv1u7mLhOQArBvaWXNzZ7AhydI1KF+zYn9l2RHdXPEwh?=
 =?us-ascii?Q?wMoNTPZl8wNA6Vb3FJEkvs55w0YU3znV/pF/3Ol8MM6bunvIXamqmgfR5tjI?=
 =?us-ascii?Q?LzdgtZQGolP7cJWJ/JMCdNf66zXUbBWGfPJp9zm24NpOBnDSI5/rAXQoIkJe?=
 =?us-ascii?Q?RpmwRk3aJS0FE7ylWg8kGRWlSvwoqU=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR21MB0469;6:3FZmwSHyMqkrxLN/yIIVsIiTnPSEnwrolIf9osoSzNNtagrE1yZ6v2aCS3JLO01ANYTYB7pGQaKYJjV7rBOYqJBZKiqWm0ZL6Fm6VdG14A2DQRt0LXhl6Ha8S2NX2LAreIXfi6SaK/TFb6zqnOfFMM8nDeXoi8SoANVN3NO86w9sF50dFQMR4AJ+yXjeU6pvVYB4Wn4CytPmloitK2Jlz+fjH9OxIonhhS6tEW2IOaEMsGVBTXax9dOJ6h7mUwe0+TtQs1KXee2svQaQwxwEqrSTF5PxgYOk4KhU+LQBDrEFS1ZdbMcekLa3splcWvodn+udiJ+pJ/+sVMkWj0dEyQ==;5:01SBkRqdJFqRo6rgeCkUYaxZkZHs8Jh1XRR5wxa9jyQHZC3aN3rnnM/jYaG2KRJ9BUc+f3K947T6kf5yhulcYJqanYChbHHW3rVY6RG5usCt0vychTnpV+YsJtS9zYSLrhARtbqwoEegIru9RWgkVQ==;24:LNTZXMe6uhSuVNSP22C81ytdvW9/IE+oR7oofEpK5q0h4l8WSJPF61uH04snOGO646ks4Ymmy3hA3nLuzNNvuTvXevDr5Q8IyNmr4jqUFqs=;7:HlsgoaMtA07/n7ee5+NxaU2Xh44J0UjBBQ1BnUtrzbq1qwxi0is25keq4LHrd1EfdeoYvMj8zrtBMwmDqDjWz/2wyiHx4a2qJ5Kfk0Xlo6LswCCikaw/p6jS4Y1HULkb2JAOcHxYt6JVjNp4ZMM3OHH5MjIAqS56fPCbRNZ2nw06DGXe5zhwpUpCOgPq3SilawNCTWyprHjo+faaxcDVi7JxQDEY87CTjMDhRmMtq4w=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2017 19:21:31.5563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test utility (test-dump-fsmonitor) that will dump the fsmonitor
index extension.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 Makefile                       |  1 +
 t/helper/test-dump-fsmonitor.c | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100644 t/helper/test-dump-fsmonitor.c

diff --git a/Makefile b/Makefile
index 9d6ec9c1e9..d970cd00e9 100644
--- a/Makefile
+++ b/Makefile
@@ -639,6 +639,7 @@ TEST_PROGRAMS_NEED_X += test-config
 TEST_PROGRAMS_NEED_X += test-date
 TEST_PROGRAMS_NEED_X += test-delta
 TEST_PROGRAMS_NEED_X += test-dump-cache-tree
+TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
 TEST_PROGRAMS_NEED_X += test-dump-split-index
 TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
 TEST_PROGRAMS_NEED_X += test-fake-ssh
diff --git a/t/helper/test-dump-fsmonitor.c b/t/helper/test-dump-fsmonitor.c
new file mode 100644
index 0000000000..482d749bb9
--- /dev/null
+++ b/t/helper/test-dump-fsmonitor.c
@@ -0,0 +1,21 @@
+#include "cache.h"
+
+int cmd_main(int ac, const char **av)
+{
+	struct index_state *istate = &the_index;
+	int i;
+
+	setup_git_directory();
+	if (do_read_index(istate, get_index_file(), 0) < 0)
+		die("unable to read index file");
+	if (!istate->fsmonitor_last_update) {
+		printf("no fsmonitor\n");
+		return 0;
+	}
+	printf("fsmonitor last update %"PRIuMAX"\n", istate->fsmonitor_last_update);
+
+	for (i = 0; i < istate->cache_nr; i++)
+		printf((istate->cache[i]->ce_flags & CE_FSMONITOR_VALID) ? "+" : "-");
+
+	return 0;
+}
-- 
2.14.1.548.ge54b1befee.dirty

