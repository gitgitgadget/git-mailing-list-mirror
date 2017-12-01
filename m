Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44F9020954
	for <e@80x24.org>; Fri,  1 Dec 2017 17:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751668AbdLARuP (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Dec 2017 12:50:15 -0500
Received: from mail-sn1nam01on0119.outbound.protection.outlook.com ([104.47.32.119]:15639
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750995AbdLARuN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 12:50:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=A85CAI36+UB+ybcYEzKNjxn+pC+gJvKe7A1k6QWp2ww=;
 b=nb5JvmgK8K7g47OUSPBfPINpUkMzWkazwN/bY8tzkHdCYHx2s51PxFpj/Suruii1XfjPRcVcGxecTCol7cZGQ32sjNSeUVN13gib1dXQ0c+BBV5jR8+BClbxCvS2dQjJZp8kxa1H4q9FvHDWK+as/B1R7x0z9UjgsPf9ZtHaEwI=
Received: from stolee-linux.corp.microsoft.com (2001:4898:8010::2e) by
 MWHPR2101MB0730.namprd21.prod.outlook.com (2603:10b6:301:7f::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.323.0; Fri, 1 Dec
 2017 17:50:10 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, git@jeffhostetler.com, stolee@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH] sha1_file: use strbuf_add() instead of strbuf_addf()
Date:   Fri,  1 Dec 2017 12:49:56 -0500
Message-Id: <20171201174956.143245-1-dstolee@microsoft.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2001:4898:8010::2e]
X-ClientProxiedBy: BN6PR1201CA0012.namprd12.prod.outlook.com
 (2603:10b6:405:4c::22) To MWHPR2101MB0730.namprd21.prod.outlook.com
 (2603:10b6:301:7f::39)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84b377b3-17c0-4671-1768-08d538e3f7f4
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(5600026)(4604075)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(48565401081)(2017052603286);SRVR:MWHPR2101MB0730;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR2101MB0730;3:1LzNvvBJONPzoSdahSvRyHYRh3iJ6/g+ZChcClyYBCcY8HH6XxWv/t5HMAcZOMokEweqh0Jwke7OJWo+iLgHM/hyXoTD5nj8C6bHkyC76sf34mOeigvUPeZR8MXLeAx8LxXa7DgQhNinjNnGwiGXAIGswiTj7LlHiq4E4bM3ww2oly25uAGxzMBPp6k2xfCL7UgwHInU9k7vXOwYWINCXsLXC58qpEphpzZXcAPfgmaYQqEAWRgCsAzZ4lzFfnyr;25:mSjbwUGe6Us5LDON5o8q/kKmQYubz6lDI6DQSthu4hGLOy2cMDkQcyhWLhMLS0W8sPqrl2S5XN1e0x+K/59rOSotxCv3fyrD839zT2kc7tIyPIgp+AnOXvFixPmscDSm4O7W0N2TYrEkd8AlChdIHXt12Q1VFsKSfPAiu5NGp1A6KH9Wq4c7xfI/5H+bG3I9IDZUklBn6J/8teftTtMPuthacbc5/ObAp7bShIuigX9P6zaJAaohTJJFPWU1daR9b4mQoN3/nHOLThPRQf4q72ixjiC8k01UJRoVVYpfsf8OCd+Y6d9yKrcSzBZNuNu4hrIuW035Pd3jw2NVaplTCw==;31:qxnAmiRgk9Pdv10vEGVA4uNJScvKezwKJEId+S+KVvYaoFCmMqcC8/wk6McUMbviBczj+UK/jh+XGYEpW8rZaRi5t91eHpxcgFu061tNxW8KHj9HHXb8vRQ+6WJzlQgCCd0rykv5TDv6Ra/05qLrWWx6d9FfwxN+vjWsF9WixFDN82i+HWAFvaRlOhSCLh3kq/slF4Xn3K9Nviz0HSsBjzLQCqZ34VOWcvjMT67jIlc=
X-MS-TrafficTypeDiagnostic: MWHPR2101MB0730:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
X-Microsoft-Exchange-Diagnostics: 1;MWHPR2101MB0730;20:qvV8wtVKTu1XTL619OszqHccIAV8OVc8Ikb3utKoq3Je5YYjDn/8V1UlnqYqfmVjmk562NLMKTtE03p77KyNFmr44dk3pLFvYTwDyIED3xuxo7WZcSx9HWSNVocpkKU7yk2NKpL5uW5hMbImvqlwzbCZ0z8o7K4l8cNM3FqKn6bUcwh1oRRZQ31ferkIgCbn1B3rg3APTWHMFPeBSSjvidOnvEcyyn/bgcdgLmW3v4IWUj9umt2WwJzfZmjDWPFOj/gE+KMC0bCk0OMbX4eGLWRHcrX6yVqvGZ2LVWfNpgvy2gth5I2juof6hCvlXaBE3KZKYZryYiUkMUfvXymUJ+yeJ0FtPwxGqhdzI+65ckRBhiVHQMwnJpvS4iw7E8gvrdXtCOPHyhZQvhCzKHb9q00VLYFATlCb3C+j6K2mODuUQQGFgNwWfegW4CMwsFm16ftiobq2WRve9JtvgpFrwGp8ghaHXLpKmr8zxzzbLxn6L77dY7mq20/jtYVFUCrY;4:RLTMdYHV7nZSuWmCcL3nstCnO6eGVJFrgKdDYw5pcTNL8nqrKRlW+zWpVS82myvV9byp38eP3UP9yROV5XpTqKROOsyc92obWl3Ow4ca/4m9FbVCdyzxgJ1bff9g8aI7Z4uimg2EfKAXV037Z8w+15Yxt3M1w+PMfo0cZVt8dqSBMAxWBUZPeMm00GQdEmr9QWsgKSWmsqGhNe/jGE2F3v1JzAri+cjJCs8XyCaayvygRted2nMFOT+v4ERxl6MZiOeI3v02rJETvPHGQyUWNfbWhLdB+RGaQpey0v3ZJevC7Swk1pLDWm8lGWtpOhGrW1UdHYYeABeAaCu9ygoweQ==
X-Microsoft-Antispam-PRVS: <MWHPR2101MB07308A5382B4B8B127975FA6A1390@MWHPR2101MB0730.namprd21.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(89211679590171)(788757137089);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(61425038)(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231022)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123564025)(20161123555025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123558100)(20161123560025)(6072148)(201708071742011);SRVR:MWHPR2101MB0730;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:MWHPR2101MB0730;
X-Forefront-PRVS: 05087F0C24
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(346002)(39860400002)(366004)(376002)(47760400005)(189002)(199003)(52396003)(7696005)(36756003)(52116002)(107886003)(10090500001)(5660300001)(53936002)(6116002)(97736004)(81166006)(81156014)(8676002)(8936002)(50226002)(51416003)(1076002)(47776003)(7736002)(316002)(305945005)(478600001)(86362001)(575784001)(68736007)(25786009)(50466002)(10290500003)(48376002)(86612001)(6486002)(16586007)(2906002)(101416001)(4326008)(6916009)(39060400002)(2361001)(33646002)(6666003)(105586002)(106356001)(2351001)(22452003)(189998001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2101MB0730;H:stolee-linux.corp.microsoft.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR2101MB0730;23:pzZ6msmQGshKgXUbvhl+QKhEYcClqWkbeFatwUr?=
 =?us-ascii?Q?2M4gfNPqowA++RwRHLhDwMW0FN8Zjd88kWVIpwawNAdLWUp214bwoHydOY28?=
 =?us-ascii?Q?aG5icaoCP2NEc3X+q+CxbtDwkXPlNqq/SxTf8LyppR8hF10cAR9flsoPVAby?=
 =?us-ascii?Q?yTKQOADXl3Y54o/7ycG8kzzqsmwAzpKgZkZcen1ZJD9t2jP0VchaRgRemi+/?=
 =?us-ascii?Q?pxcTEt+kQcSBZrL7tnE2t/O/4lBCI/uJfIXhUpwwEmCb8TPR1Y9CmaxiwLUD?=
 =?us-ascii?Q?5Q/bn5j6fXe5nOr+wyi15b45kRRDlIobqcdSEujl9WuKy46KCR3vhVOnZRgs?=
 =?us-ascii?Q?x/bGkuCFusXpRcerjF5JKXF9lArU/ELcGXSXAx35miIkrRafhdLiGL9/l+Qf?=
 =?us-ascii?Q?yDx/bmUtK9KFlhBxpRrpA3LPzEZ0Qz3dHJ4xxk68n1m6DekBvTpLL8YbOQ6W?=
 =?us-ascii?Q?Mdk+cApiKUuXpLc8swdrkPzQta7wOp+MtmShYLVC0JrawFw+FBKvmuwr+UVM?=
 =?us-ascii?Q?GVzCY3/JyGUe57dUYXGz1FK4EYJKTITxcoqo2SijiiFBrGXrx+FzRL06+2G5?=
 =?us-ascii?Q?rCtGWfh5pB5Jh+b+lT2ZvmQLvVG7xXynPpE5S9a49Q2BL0G2Ezd/tl5Xryhd?=
 =?us-ascii?Q?1MKuvdn7ntLW+mjuEd+wR6H4aPZIJZ1uVYwkAQlFFZVleFTSDg5gwvhkc6NP?=
 =?us-ascii?Q?EPN4dikU1Z2ErgsCbVv+Vkded7uBwqK6m9RY4hHcBZslVaxgORdEjCOZPO36?=
 =?us-ascii?Q?ADkfrCwo3yDyQq7Wty1mZqmGxjjUcqhJX4EivT1U/MC59YbStQQ9I5mzbs6p?=
 =?us-ascii?Q?9pGpgZlKPBLYRZgE35VybCsQO2AuGwKQe28esseETF3i29YxJ4TIHkeWywkc?=
 =?us-ascii?Q?gGnGyXriqleADr4NPH7xxI0tUA6X3tb5eShhVG/znBVYnO9iL0wNfohOWUsS?=
 =?us-ascii?Q?Lpp+4Tv3eV1yG1QjxfBVeuE0lmXZBq/Wr2QrV0q9uS4nyBeUrbzmSuxPClpN?=
 =?us-ascii?Q?cJqpNThMm8k5yD3q9j5w8meFW4RG+khj8FphZyqyEIjQwgpks1XCOBu+iCo5?=
 =?us-ascii?Q?Vj/erQQUaAnfJlq4eG8nxBIgEHkDDrKXeTjhVt6qLOI2JPuZ5sluzFDczcrR?=
 =?us-ascii?Q?Zu1FGtELQWFYf6oGBpXLjNfpSBPbRlMhpGDIEzNIKcQaKg0l0jxjsUoI5zJf?=
 =?us-ascii?Q?SE/gVZzefzPM3q6UesyLsQfVT61pGok9qBKXeSLPAob4bKE8Ng+YkuY5R+x7?=
 =?us-ascii?Q?4cn7yr+srfm7rGwtmrJw=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR2101MB0730;6:nDXVxDg6GEiUSUf4VsICD2rtRKtVWUM6pRDrwXx6uEMsT15quwcCMP2wYM5Ip5cqsNOM7s4WHySIOh98B2Yqy6AmOGi9Jt8zRxDR2jyyPBBWMcHor0l2yoPOIlRCIN3IMuyb/qh6zpXJkez3EwwhSDTYtuA1qpvQkf1wRdZXW/emK3N/ZiWIp84+SOK8B59RYWsgr3vu7OX2vxtP4KHcobKTSperWJTxEcmFwntk4wMymJUjvWvXx5QbnciNK/VXXEtXtBeresxq1ajI9Rq8IvDLfVSFWUIvHbDksCsA0KVU5Lgi0MSPcSgMdBr9Nkm+2hZM4pJI0mt9c4goQVphW1tbYqcAWJG5r6URZZIBnvg=;5:QcX9QqQT86PCLLIn0SqX7SmH4qS/uy2LLUErhi0m9AprqhBSmDgJ8yubQwnSjnSzNX3p7QdR5Gr0Zle+UtMOK1IRFF3slhrXFU79hc4Sq7xOakfzQCcl/yP2OjchReVydAMn4h4eAoo70sTgUs+MuTwzox8asbSKOK4RvS81Im0=;24:WY+H8hcAa8nA2/sv02momoqDJ2tTvnliL145H5xuP+sS2pE+0YURFN4HWGqwgxnIbOO7pq1rSXVGl+LGS6aUacZlHelEqrWqQrvx7q8jcxw=;7:ufTw3FVbagqxpgwaeQQt4IZV2mXUQvmXNAERwv3bfg9oPv6l8qdcNtzbODDvGDj1rLZEcr7nHOR5dOxnlIb1jjBIG3/T3pQlq16YHET2dJPwHScgPIfdZo9McHjwFeg6UJr42h1/hkmQkOjOEIpNErwezTFUCdMZCi6czt6JX3H3x8lty7AS5ufL2GbXVYLr3cJAq5M43Hwj8ZUUzupwjK0GvB/2HifMHaEsDWeNAHJQda9e9uANxK06v4f8Faw+
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2017 17:50:10.3837
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b377b3-17c0-4671-1768-08d538e3f7f4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0730
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
loose objects, running 'git log --oneline --raw --parents -1000'
had the following performance:

 HEAD~1            HEAD
----------------------------------------
 7.70(7.15+0.54)   7.44(7.09+0.29) -3.4%

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 sha1_file.c              | 7 ++++---
 t/perf/p4211-line-log.sh | 4 ++++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 8ae6cb6285..2160323c4a 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1914,17 +1914,18 @@ int for_each_file_in_obj_subdir(unsigned int subdir_nr,
 	}
 
 	oid.hash[0] = subdir_nr;
+	strbuf_add(path, "/", 1);
+	baselen = path->len;
 
 	while ((de = readdir(dir))) {
 		if (is_dot_or_dotdot(de->d_name))
 			continue;
 
-		strbuf_setlen(path, baselen);
-		strbuf_addf(path, "/%s", de->d_name);
-
 		if (strlen(de->d_name) == GIT_SHA1_HEXSZ - 2 &&
 		    !hex_to_bytes(oid.hash + 1, de->d_name,
 				  GIT_SHA1_RAWSZ - 1)) {
+			strbuf_setlen(path, baselen);
+			strbuf_add(path, de->d_name, GIT_SHA1_HEXSZ - 2);
 			if (obj_cb) {
 				r = obj_cb(&oid, path->buf, data);
 				if (r)
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

