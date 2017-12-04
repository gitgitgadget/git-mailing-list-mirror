Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8218420954
	for <e@80x24.org>; Mon,  4 Dec 2017 14:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754425AbdLDOGY (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 09:06:24 -0500
Received: from mail-bn3nam01on0121.outbound.protection.outlook.com ([104.47.33.121]:45458
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753743AbdLDOGW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 09:06:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=/hjpu13AemKgEF4RVzgrDsRUXZyz1D3CwKNGNJhfxEI=;
 b=Ep21VOuSuIGZd3Z0Jc8rxtGquimJKjG6a546PAR1Z7zedyBOGDb4Z3T8CfdPEk8/IP0PNPp+6Xl99u4tBxyNoNcqlphJw1KjcRo5DSOWpxPEZQJWKCCnlQpYjPN36KOGZAVaUlW7vzwFjXkqI7IKV4crwj76su/Q5kSJpozwx8E=
Received: from stolee-linux.corp.microsoft.com (2001:4898:8010::2e) by
 SN4PR2101MB0734.namprd21.prod.outlook.com (2603:10b6:803:51::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.323.1; Mon, 4 Dec
 2017 14:06:19 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, peff@peff.net, git@jeffhostetler.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2] sha1_file: use strbuf_add() instead of strbuf_addf()
Date:   Mon,  4 Dec 2017 09:06:03 -0500
Message-Id: <20171204140603.180079-1-dstolee@microsoft.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171201223945.GB17334@sigill.intra.peff.net>
References: <20171201223945.GB17334@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010::2e]
X-ClientProxiedBy: BN4PR12CA0002.namprd12.prod.outlook.com
 (2603:10b6:403:2::12) To SN4PR2101MB0734.namprd21.prod.outlook.com
 (2603:10b6:803:51::25)
X-MS-Office365-Filtering-Correlation-Id: 60ffc275-82c5-4a58-4257-08d53b203159
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(5600026)(4604075)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(48565401081)(2017052603286);SRVR:SN4PR2101MB0734;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR2101MB0734;3:owuPHZ3uMk1XI0x3QRrOD1lq306b4kTtFQKpbptOznqWG9f2Y67wsq/0SJMw4gHpZNgxO0rSrvfrMmB5DECVcEq2V08sMdD5Wa08ml18XXBToYXUvDRfNSqUnx9cFqTvQKYw6xdl8XdCqfdllFNeugQZx2dIcRJxKGmRmOq2NHaJokB6CUpmuAlLS++mT6buvn8xEnMedmWUUz88pkVDpR4usPHq532obkIvKKJwB0Zz3bzPJhzfShB4K51D/qRe;25:0yviLXVPIbzPPWVNRgT6BtU6qmNwCooakhWWmw72JVbndBjnn0srlmkMnTgY3/NXZ9XJFWvA+FUGy6PPLSFjDvBFsIlFegPwq40GZ2L9B8V2NpQygrX+/OIydutivy79gPNNi1Uy8t4/YM/lB5aj+P37iVLmB8TmPCCF6kw0wd1L/ARboPkSidTZpMu3ZpBYrvix5KhyjuzXZXJHlzutlERG4NoXnX+4zszfgyab5bVMQqAjr8KVrdukzoNOYJ3GWAtc7EmP0LMbAo52TOip8amCzqcAmSLT3jOQcxRRmzBU3MYUmCPezRq4DcP/0A/hNxkdW2doJKJG6I4VJj1/uA==;31:8RslsX6INIVA2399YsrAteyHI7U0HbvMnQhDp/EYCaQsvYdq+jTulVmEhOOteKRJ340sqPEis868MSX2uO0GEApYq5enAI+RMWE2imFVLTAszbVDtLn3htUfC91IDvgCYJDUmDx8q9gavRFaKuwsEnVY0N6PY50Sp84KgeS4igOJH1nkY5XOnEcnTcY5DQQWpCFhx1P1EHap/Uny2OQj/lLjw2HgvPhDHiJVyIyVgvE=
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR2101MB0734:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;SN4PR2101MB0734;20:QQeKVAsbHx7NtumpqiHs2du/G+Eb+/9buKLObmXyaYJ+WrbEiIIlKgJcN4ZpMVrU3bUF7j+1dALrFuXj0L5lnqp6BSxnOiynwiMfCr++QLV7EJ97RQFHS8voeKS5j/hmoVsl69vNMtquCxVac1BMYAgm+xrSEYipaJIwj7NJsSFh6dVdL9aeYa+0bCI3hHBJNH7nJvo2eQ2+vWzhiL9KjwckdxKOodeLcwK9ccxr7TSSlIU8u+oSEoSkn12lEK0bHoPkaCiBhFJdqbpvgToZ6VWny5trFsCU2ZFVCZXmHS/4am7cb/n38XIu6iZZ7vH0dPeDbKYRuL3+wxi9cvgBMRD3rXuniPglWseoxYw/eoj80qg091hGFV1s1YkgH0JEV2gdjrZpw9LiL7lHkm+5gt8kNkUnIVwrjW/nn0YS6NTrC0+4CQi1xC/funoJzAAL5EB4KUkPIfUlGpC7b8YmX/E8Oni9tK/MNM44ZNzQoz9AngKDQqIE84+StVaKY3nQ;4:/CpHdJVOXM7TmWfAQfOqaSkdgmRPkDtntdyB9rCM7i1Zd7SqggO8qyAAW9+06ocOrESpB3A3lgVhxJ9M36klAyyAXptjvv5mA2u8VcqTqA5d1AUucSemRCVIdbGhFy4LeKi/Kq6aM6dcOEnTEDWWa0TUjN6mMaFSj2CPvYviZbEicCpwMpTpXyLUriZOjfV/YPjM0w+PINVRT2ocK6m+Xu/56KLO1d0vZx4TFf7qb+fxeS9dYvqfx4ExfzmFbePYTzcon8egobjtLHPd+0jhPOlE+1AKndFWGS6DIG6ymxrjCabpuK8XebrN2CPeu8dhtUZiLB2X/6vGJsY+iiJ/+g==
X-Microsoft-Antispam-PRVS: <SN4PR2101MB0734A771459A549A39D8F7B9A13C0@SN4PR2101MB0734.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171)(788757137089);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(61425038)(6040450)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231022)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123562025)(20161123564025)(20161123555025)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123558100)(6072148)(201708071742011);SRVR:SN4PR2101MB0734;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:SN4PR2101MB0734;
X-Forefront-PRVS: 051158ECBB
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(39860400002)(366004)(346002)(376002)(47760400005)(189002)(51914003)(199003)(33646002)(106356001)(105586002)(4326008)(39060400002)(2361001)(53936002)(6116002)(47776003)(305945005)(2906002)(107886003)(6486002)(2351001)(81156014)(50466002)(81166006)(478600001)(48376002)(101416001)(97736004)(36756003)(76176011)(25786009)(10290500003)(50226002)(189998001)(51416003)(52116002)(1076002)(8676002)(52396003)(22452003)(316002)(7696005)(16586007)(68736007)(5660300001)(6916009)(2950100002)(86362001)(575784001)(10090500001)(7736002)(86612001)(8936002)(6666003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR2101MB0734;H:stolee-linux.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR2101MB0734;23:Q2WQwVEbcEFwzL3x5tMxhm4sZ3h7Lm6yWQuTSAI?=
 =?us-ascii?Q?DYcpY61zviKTcDvtzPgLjJws5tCW48GxkxHgbgWTciVWwBiIiU09wJ95hZ4t?=
 =?us-ascii?Q?0zkcTucDulQhjUtShTWcfzwftEV2nG+9kgfYh4bCVVPSxYgZZpW0AGzyzcjX?=
 =?us-ascii?Q?gLHQ6DpW2auxcq2UqCMt4k4JrYAm2eqw8L032qzjPdhSeJsYLyMtyvTMVJEk?=
 =?us-ascii?Q?wveXI15u5oaOLDB+VaksttTDQvSWN7jeHTvuwK1g6fsyDw2FHVb7H5pV8NyD?=
 =?us-ascii?Q?iHmPV1YF75cYNvHLHNKoHFFmJnPmZM/fRMDKQyJ2cjYNkWKevAYW1qZvasPX?=
 =?us-ascii?Q?3qMJ4fim2PguHCKo6WV1ErPk0W3pTv97X1HdPnQ6kYYQvgz//e6LcJfwXFVl?=
 =?us-ascii?Q?Cx+pMxozEve88271JQkuPZofUYDKzHWL7+mQbS9gmZrBilZSlfQM55dws+r1?=
 =?us-ascii?Q?tHHdmwyqUaEqDntXNOF9nSADAx/WOSindpSjS0IwNFs0GPeY7mbsDMbdn/pA?=
 =?us-ascii?Q?sDtw/T1si6WBYrdXIUdV8auNUC88SR2EsTpEDqBztuyy2+jUsOuxYpF95iCc?=
 =?us-ascii?Q?wNPYRYI5H5r2hU1eI7O28tcRhkpWTNiOIqS/Gq2drASXS9KJp/tIhg8Mck9S?=
 =?us-ascii?Q?Wt8zPsPJMuHGq2s3ahmON8FCjbB0P3wO8w/PZQxwWuWBySmPGh5EpkcBWOLz?=
 =?us-ascii?Q?TYXcwYrlXFD4WQm+zuZAmWwlBXCG2goaNZFpQdARedDJ3LMoeZ+wohld/Rum?=
 =?us-ascii?Q?YINVfQwv/wm9VNvE0PkHgkZ6dCsE9+wjFKZAJYm7gdHjMEuo+IXotcJOTuwl?=
 =?us-ascii?Q?oiLHOBmZdpDFfqK7jrOPTu2t14n3B1M56jSbZBdNZFSaCihGbL7oLKY+plmD?=
 =?us-ascii?Q?TVLA62w8xvEdCd0gO2qQhYHzTlmZ4dA0NFnm4688yrWWNM7+pnQyHV/wWP51?=
 =?us-ascii?Q?pTZZjfxxh7Zv6cKlapNoflUV35cTBxcMFb7/B944oRQCvjZqIozma/6AalCf?=
 =?us-ascii?Q?csL78g1OzN75Z3K2+opDM+eebYs2KuMkTS5RNlZCv1Dyrx1uW/XkEzxvKfu7?=
 =?us-ascii?Q?/3Ns0vQi70pjUCvSwSgbZj/9g2d6XU0iWzmJb/vbOsimcLQeYZZDCImnxuM9?=
 =?us-ascii?Q?qSLIqGJMzi/hZ3o7jTWeOTOkyTPkCZm3bR5vN9j0uwTiwbarTCdX81+pH5vc?=
 =?us-ascii?Q?RnALkFHN1gCivz+z262AmguChdnRW6Jw5bg7UyUwYa0+QsU5BxO02wimobJZ?=
 =?us-ascii?Q?fFQvLQ/5AQk/4eTumA4QZkakcECAo03RhNVAnXAozbtrzL9gVvfocgNKkRCi?=
 =?us-ascii?Q?TIJgDENcZX4gK91JJGHG1Q5I=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR2101MB0734;6:TwI933MQrryixDPvc6DwQPUq+lpRuQZVMXlwO35T8hrtT5Fn4ao62BX94uNI1+eEHSlaESEX955qOH6uHkyn6mOpG7QPMTohjsAM2r4iq66SS5Q0FEU0pyzuT3A16z4zfHyIQsRsZCHYzIuf+v+QPnQmx29eChsg4TxDTC3f+u4QaGFkZOmRCltIqqmfaYmaipamrJsTAbcAKOGqpLDpXBEi3oHrwTMcU4J8cCu+mwqmEg/HHN1Qgv0vqyaJSn+2+sBdSQS8pqXsJR1NDteJK+ktcAFLRg9rBA/R1DXYBFzk0bRlVmEE6s6NljI4L7/PbvnOMvK8GnCwcSLcyNLOODS2ZzHr4YTmjvyx66MuNLU=;5:p3kwIu7kpvgbNygUzJ9RD2o46/n6Crl55nEsI+PGh2vdvoenC/todow5DXnQN98LpUVzx0WpKTdkNfHlAxMyU38+5NMStjLCWSeCnp1A3vNjN1C2YdZv47SmQddjfYZCUU2KvSrxVSQQgy0Hf0dmG9PlD6NKSR0JlFa8OWn5iCY=;24:Auf8T0Nk3K1tEw0Tky4RLF+n/k6huHUtk2pU5sNp5SBWvMX5h+WIOF1JzQvHC+/fYvMiQeiUEp7DIMjmWaCS8r3DpR6MoNIomRaMYJbB8qE=;7:rtHR/93mv+feCqfN/VRO0rMNInwxSF3E4++ioQH8sWRaravoaGi81pWoYMQxQGTmSgX5+1Upzjs4Z53S4jyCPUNo+6Zp6Nlme2R2QL5ujox5j8vVGSWs6/9I328UW9cSNqYq6VoDsok0xqRk0PSBhBHOgbuEYK6owlouiPYEoTK7F7ErhBei/6TZsBr09N2XiiU7rCT46w+dMNxFLkxPaTvJJlrIhkgf4KO8UrM2G0MInlBycchs9aJ2wm5KIVxm
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2017 14:06:19.0874
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60ffc275-82c5-4a58-4257-08d53b203159
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR2101MB0734
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the feedback on v1. This version fixes the cruft_cb
bug and streamlines the strlen(). I would include an inter-diff
but it was the same size as the patch.

Thanks,
-Stolee

---

Replace use of strbuf_addf() with strbuf_add() when enumerating
loose objects in for_each_file_in_obj_subdir(). Since we already
check the length and hex-values of the string before consuming
the path, we can prevent extra computation by using the lower-
level method.

One consumer of for_each_file_in_obj_subdir() is the abbreviation
code. OID abbreviations use a cached list of loose objects (per
object subdirectory) to make repeated queries fast, but there is
significant cache load time when there are many loose objects.

Most repositories do not have many loose objects before repacking,
but in the GVFS case the repos can grow to have millions of loose
objects. Profiling 'git log' performance in GitForWindows on a
GVFS-enabled repo with ~2.5 million loose objects revealed 12% of
the CPU time was spent in strbuf_addf().

Add a new performance test to p4211-line-log.sh that is more
sensitive to this cache-loading. By limiting to 1000 commits, we
more closely resemble user wait time when reading history into a
pager.

For a copy of the Linux repo with two ~512 MB packfiles and ~572K
loose objects, running 'git log --oneline --parents --raw -1000'
had the following performance:

 HEAD~1            HEAD
----------------------------------------
 7.70(7.15+0.54)   7.44(7.09+0.29) -3.4%

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 sha1_file.c              | 12 +++++++-----
 t/perf/p4211-line-log.sh |  4 ++++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 8ae6cb6285..2fc8fa93b4 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1903,7 +1903,6 @@ int for_each_file_in_obj_subdir(unsigned int subdir_nr,
 	origlen = path->len;
 	strbuf_complete(path, '/');
 	strbuf_addf(path, "%02x", subdir_nr);
-	baselen = path->len;
 
 	dir = opendir(path->buf);
 	if (!dir) {
@@ -1914,15 +1913,18 @@ int for_each_file_in_obj_subdir(unsigned int subdir_nr,
 	}
 
 	oid.hash[0] = subdir_nr;
+	strbuf_addch(path, '/');
+	baselen = path->len;
 
 	while ((de = readdir(dir))) {
+		size_t namelen;
 		if (is_dot_or_dotdot(de->d_name))
 			continue;
 
+		namelen = strlen(de->d_name);
 		strbuf_setlen(path, baselen);
-		strbuf_addf(path, "/%s", de->d_name);
-
-		if (strlen(de->d_name) == GIT_SHA1_HEXSZ - 2 &&
+		strbuf_add(path, de->d_name, namelen);
+		if (namelen == GIT_SHA1_HEXSZ - 2 &&
 		    !hex_to_bytes(oid.hash + 1, de->d_name,
 				  GIT_SHA1_RAWSZ - 1)) {
 			if (obj_cb) {
@@ -1941,7 +1943,7 @@ int for_each_file_in_obj_subdir(unsigned int subdir_nr,
 	}
 	closedir(dir);
 
-	strbuf_setlen(path, baselen);
+	strbuf_setlen(path, baselen - 1);
 	if (!r && subdir_cb)
 		r = subdir_cb(subdir_nr, path->buf, data);
 
diff --git a/t/perf/p4211-line-log.sh b/t/perf/p4211-line-log.sh
index e0ed05907c..392bcc0e51 100755
--- a/t/perf/p4211-line-log.sh
+++ b/t/perf/p4211-line-log.sh
@@ -35,4 +35,8 @@ test_perf 'git log --oneline --raw --parents' '
 	git log --oneline --raw --parents >/dev/null
 '
 
+test_perf 'git log --oneline --raw --parents -1000' '
+	git log --oneline --raw --parents -1000 >/dev/null
+'
+
 test_done
-- 
2.15.0

