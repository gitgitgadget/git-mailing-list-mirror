Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 138411F404
	for <e@80x24.org>; Thu, 15 Feb 2018 18:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166168AbeBOSPF (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 13:15:05 -0500
Received: from mail-by2nam01on0096.outbound.protection.outlook.com ([104.47.34.96]:49632
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1162915AbeBOP1r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 10:27:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=mnVkaYbTNma1u+1WSqZHbT1Cx1bAxnM8U7ZA6RIkh84=;
 b=G8Mg8TrigFgW0/J8tXLzO/XnyvyD11Zim5cliXrAT3+AxpsabaO0LjNKv7HuP3sdxf41Mf23BTogqy1uxcc/Qy9WT0vMG60ZoiUyVENA5EqDTQF1mQzZ3PhpANP3mFiviDjxVGlq56QZccGGCQYYphjVUQAXPG/CtGfu27JTN3I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxbook4.ads.autodesk.com (62.159.156.210) by
 BN6P136MB0020.NAMP136.PROD.OUTLOOK.COM (129.75.91.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.464.14; Thu, 15 Feb 2018 15:27:40 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v7 7/7] convert: add round trip check based on 'core.checkRoundtripEncoding'
Date:   Thu, 15 Feb 2018 16:27:11 +0100
Message-Id: <20180215152711.158-8-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215152711.158-1-lars.schneider@autodesk.com>
References: <20180215152711.158-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [62.159.156.210]
X-ClientProxiedBy: DM3PR12CA0049.namprd12.prod.outlook.com (10.161.151.17) To
 BN6P136MB0020.NAMP136.PROD.OUTLOOK.COM (129.75.91.27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8d87281a-1b15-4e71-5d08-08d57488a7f6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:BN6P136MB0020;
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0020;3:m9SI53YbLzPLcrOS5AIT4SjE+5gNj4s8OEdOQD195npXUn02oeQVLkJdJNgwZsPQG8FEzc+GgDyQj9fJePIC0qhkLwyJygdJEydnA7AZrsxNNb1RDT4JEcAfESyxetcJAqR81NUx7vQZQTU7I1LpfH3habzbvNXuEW6JRW80Q5o4xfwEpXhltfMf4dBkDmH2A7qk6kxMtV8eJIhh5jMJt4DmrKfQCbzrnGu4dL+HK8i+2r7XAv03gGLGyIa/SUCr;25:yD9waWYqAC06vZsXF3TWkQxNCDXS5/eRwgEzwa9fkMLDpuF3yvBoFEAGB2IkqicGgRfLJ9tTYUuSzyPaEdrLBl1A4dCaRaohls2kstqNLyeGv9LmYmgt1Wnuvk4Tp5zeMMiA/86x9dCgtl7BKUDU4lOHCEQrtcbsVyC1jwXVMASrl78ThBrbraiS6HOFvHIDN6fdUGP+xTPxIPbFC49v8ZFJ0WdpmdEYVz2M4kOG3sPt8u8q6ZgGFhdj2YsasMnUla5RIMB2nqkRObeP6zfX4ZrVDSVGSd7WQwFeFzEHfd4++W7CEupaO60mQjZunRc31Ga/ZLepPgI/LSFZDOCBUw==;31:PYNkXNEwoZPYwhzMM0AccihJuFi2/Rp3jhD0GMkhHEvcqOLgGR8GpugFk3hUD4KpkAwyDaJrDP0I6EfXuMd7pUoyNjt817EJ7RcdMaPeqeS/HUWhrsDv4PUEP01ABiywhcdKdaF8v0N5WSPDCTkS/oZss7Em/PBOnD9CtzcEIqq+E9GUl62JXTLZSq96uveTurtYPLWBhkIg5zB51wvh6p4AHzeOATtaJFbcejkPIyU=
X-MS-TrafficTypeDiagnostic: BN6P136MB0020:
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0020;20:svTN3EepnyfViT+exEcQjoHgxR5Z9dqkL8aaVoq8FohqJxXQYDrPFBBfRHC0C243W7AZ98JzNbHC6nfdJnwoY7oxnH4N3weH/7H3BhBlL/Hb152DBAm1BNsHa46Kowhq2SrPR9DXW12Qpe5qkAxP/X1pUEoRfERGGPfNsn6jAASU9LLU0LZpxK1lYsebc/cEpV5VzRoXNnojE8Cj4LtFSEiYe6ejFjaBk72X/pO6/Ao8rB4eHN7UnTaQ+IWuG8u5ayQja+yLa9hZ703JTi8HV/PqNWi4Vs44KPh5elIJyb88gQ/oy//LX63wxB6M4Cj3C46NXAhrresH71c93IzU4WoqD8bQxFAgfj50eaVsk5GqM6YCznMpt1YeD+0iGz3r2ZV7N0Hk6E7uIsF0vCIRw0j96FsFqvmXM3Od/FQzDQeh3e8cAV5zCV4LV4/YP3DjuD6GUUYxHFqHBZPFXPrX34mPhfQiNk6d9dehwG7+YKhjLinPYctTmgZV8VdgOIiT1Nyw/0WN6g1eXapI8ahZrYD/3GFlfa89IAPIsDizuSbhWlDm50k46ZgIHeFf7JkeSbl6R0M/QFlAvVFT3FonlOjNPXOez72Ppb68OFqCt3k=
X-Microsoft-Antispam-PRVS: <BN6P136MB002019816D135BDCEFCAF544E8F40@BN6P136MB0020.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:BN6P136MB0020;BCL:0;PCL:0;RULEID:;SRVR:BN6P136MB0020;
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0020;4:rxhknmLRG+x6TNRdwMVMWy8xOQLu4H6Ju3/ohOmLM0ee291Jn5I7z+EFFP/nWL6mm3X7gzexdqf4/j9Dn6V7qSBw/gAZetRlkycGwuEb4NAaFt3293NiokmaHX9LsIvdOnk5Bj1Qh5TnVR3lceGlFuvceXvcQp+9yzpRBbqM25skkf7+F9vQ7YKD7Ls3P5XbZ/07sWbhNUqDWeNj7M7uD7ZCxDiYlDhtZ3qMy2QRQkSp7OpYMxyRxHEiWB5P0i0J4kQl13mmq8zWNjriz2I0bjyWXcSwiErm48wW4Q5I6aeYxZnqce6O1N34b1mVJ2lKUhMRyvNn823TzNAPGp+71NoSlJkBM7UBhFmMOJRMBIw=
X-Forefront-PRVS: 058441C12A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(39380400002)(366004)(396003)(199004)(189003)(81166006)(8666007)(85782001)(186003)(5660300001)(1076002)(6116002)(50226002)(6306002)(3846002)(86362001)(305945005)(97736004)(106356001)(16526019)(2906002)(478600001)(6916009)(26005)(25786009)(575784001)(81156014)(105586002)(8936002)(48376002)(5890100001)(53376002)(47776003)(51416003)(76176011)(2361001)(36756003)(6486002)(66066001)(8656006)(8676002)(68736007)(50466002)(316002)(59450400001)(7736002)(2351001)(7696005)(53936002)(386003)(52116002)(9686003)(966005)(6666003)(4326008)(39060400002)(16586007)(2950100002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6P136MB0020;H:slxbook4.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6P136MB0020;23:SBJbD3qI6AVx+FnHQKk4bkuIYMujTrnoNQEsNjH0O?=
 =?us-ascii?Q?7QKLUXWc2CHKdoCSZYeIJ7BHdk35f2BFqVbOS7OEgZTO4EYuYktYOa+3lJ0P?=
 =?us-ascii?Q?UG6j7Gv9Y0cJdPx+sdXRM6t5DXL2YiaQD0Y8g3V5vikLKnrPGZyBwJwKVT/x?=
 =?us-ascii?Q?+OM7/w9kTy9JInoWrdYiJPXn4YpF76lxIsKVKXYYJlbxu6VpPIZHgThpBIby?=
 =?us-ascii?Q?469+J/iSLFuME6udVabMAms98AUJo9IW9KugtBKvcPhVzqxguw/Yf8WHZtfi?=
 =?us-ascii?Q?oiCd5US4F15icevjSa2ov6XQaWpfpcVoNWNA3snz9sFUz01cGh6wcC7IWTjQ?=
 =?us-ascii?Q?MtoQzwwwPH4kcn0VAvsHni878Kii298t/0qKsWCSmiMZWLrpo4fipHM0NMR0?=
 =?us-ascii?Q?8qaug2Blet4fQUiiBF2jLS8+MZeWxx5U0kMFD9cDTcGQpuz7SMl1P1SLWbh6?=
 =?us-ascii?Q?ukDf57BNkCt9RJ+gxfJIk22sNN1pY7YOGz+93b65cldw9l54bDsPipjhbSla?=
 =?us-ascii?Q?P8Rl61lHLVfZEcTAIjYzZvGWYHdJxZZliFJos4hfmO3rAjRkS0Zz2Wqab6FW?=
 =?us-ascii?Q?kNojzXYKu5B+gOgqEJz1QvP4NYxlJiCpRIn8QaJ5qJwIW+e2E4YDznd2zOq1?=
 =?us-ascii?Q?RHTgxkFmmF6ijLQwCNiY4TzaOlXfl97CJYzAf3pOP4Y4addOp3tKWqFUna23?=
 =?us-ascii?Q?UMZ2D9Fr1I4Ws7Av6YRF93ZU9gJPEifjjvKH+t3pPUO4n+YCIl4PgtHVclsx?=
 =?us-ascii?Q?hdUokhxLtINCquuWDxd2Rn//EIWIYRBIOd9egBGp2oJwdVtJ4HjjUm1OC3UZ?=
 =?us-ascii?Q?KsNEwBGbiGMedu66D+CPHcGdZngdyYpt9CPCUuzhQ3zXrgmEJEQpUJDj2q5C?=
 =?us-ascii?Q?UrFUslgtPriZBbrc//RzeCldzGbrZGK0wJCHcYdQS7sv30KwXa+nAfHeQXve?=
 =?us-ascii?Q?hCHTIIdZz27A5zxVWi4wvIgDBPssvr4tsxdd90JJK6CJW6KGMivwx2SntV6W?=
 =?us-ascii?Q?BlHVjQgzua8Vu6rz6HYCqswwNB8j2vSpVC0MBkYmkZl9tVMV1cFsvXCBPm+i?=
 =?us-ascii?Q?9etPtnCzk/ATos0WCGf7YEceSKFyNOqeRaIUQ/BIm44mfxJP231yzs1PtJFg?=
 =?us-ascii?Q?YUoHuNlp6W2rzfffRttA5S5IMARGCRefQEi3ia7CvRvhjliCy1ueI2ljnYxP?=
 =?us-ascii?Q?8ngtLeRXqSYZy+0yFStttSSScPMkymo2zR3wfeaIoxuPvDBjKIxHVb5ajV8C?=
 =?us-ascii?Q?306ZpRYPAgME1wbYAZPs7eC9halsc3WOFLpNHKIMv8Zsbu2lhTQbGmP0ft5X?=
 =?us-ascii?Q?Vqm1QdwS5LRVHQTJoGpuDfAp3XiC0i6hZyuW1aTdk1yAmW4OMoFRsmEAhdkE?=
 =?us-ascii?Q?pOmk8+2CU7QeOW/pSOChZ4CEzB3lW7LUCYRc44ScQ43ZLHi?=
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0020;6:O5pndc+JAulh/Ac8k9Sn+stnIsFxrRy5f5b/W+YLzvVb2olnonBpVS5ka/YE92xJbHumuoiZav8nsQ5vW/4+GfYbMcIeYqVPT/Nnx8Irb/R6b6VGgLhbAV3vOxMmoCyxFoSPkreKSyDfcq8lVsn2B2y6tzTi1JdRX0J+Zz7xuGdsCzRFAYtF2noe/h6ziUhap/ODJgPQ/mIg1YVJ0L0XCgSeVP2+RuA56rH6n4raXiUOdbVAbhedNdpilMoLdo0ccsBt/88PwiQ6ikyWR5eAn9XdRUfdOvtUfvTc/RK4rrzHyHuWvWriUi7mb8AYPYN3E9u+3ok3GHfVxgODbN43UmaJvAG8Dygs5q8QANdqIW8=;5:NZZBrd43KGMBhHsD70QvnRTat/vhwLMnZp/anrVHInBUqcIPxkYbHCrPa05LTZ2m6EbTh2odwCwWk/lz4GvzoI/Td2LtOxQSVmmWZpq1BMUyVqY4gWltuxzi6F1sFPXnXJOuW/FnNqinqzvOXr/CAVq/0SgU8fn4JfV1Z3lCXFE=;24:Scz+GGpy+1i3ilfFGq8lXCrcnepMc+OTuhZeaSLgNHrsi08kgLaNOgaQzBxc7393fFc6mCJ07U3K7YWQgHDcEhaqRpS8YM0albf+q1UhEoM=;7:KUvvKyknTbWOQ4NTkWQTxhIG9xXC6sPbuEXXj5f6AiscKMlXR3xM2fLHoasGfsZQdHfccRqJZctA8ixxJJYvkCRBq29yzK+7nDOpV4t0pRT1sbRfwTiq0oZuA4cjiuQ9ky05uUX6Z6TrsP7hi1PId58uOWDPRK+2Gn9l592BVtF6zccmzRZvawh2iYRX8U2piDccer+MDBRTRs9oP6kiR432EeaqRnp2PBrhucgY4eprqbloecmsKlpKgxBOKODU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2018 15:27:40.6358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d87281a-1b15-4e71-5d08-08d57488a7f6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6P136MB0020
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

UTF supports lossless conversion round tripping and conversions between
UTF and other encodings are mostly round trip safe as Unicode aims to be
a superset of all other character encodings. However, certain encodings
(e.g. SHIFT-JIS) are known to have round trip issues [1].

Add 'core.checkRoundTripEncoding', which contains a comma separated
list of encodings, to define for what encodings Git should check the
conversion round trip if they are used in the 'working-tree-encoding'
attribute.

Set SHIFT-JIS as default value for 'core.checkRoundTripEncoding'.

[1] https://support.microsoft.com/en-us/help/170559/prb-conversion-problem-between-shift-jis-and-unicode

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 Documentation/config.txt         |  6 ++++
 Documentation/gitattributes.txt  |  8 +++++
 config.c                         |  5 +++
 convert.c                        | 74 ++++++++++++++++++++++++++++++++++++++++
 convert.h                        |  1 +
 environment.c                    |  1 +
 t/t0028-working-tree-encoding.sh | 41 ++++++++++++++++++++++
 7 files changed, 136 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0e25b2c92b..d7a56054a5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -530,6 +530,12 @@ core.autocrlf::
 	This variable can be set to 'input',
 	in which case no output conversion is performed.
 
+core.checkRoundtripEncoding::
+	A comma separated list of encodings that Git performs UTF-8 round
+	trip checks on if they are used in an `working-tree-encoding`
+	attribute (see linkgit:gitattributes[5]). The default value is
+	`SHIFT-JIS`.
+
 core.symlinks::
 	If false, symbolic links are checked out as small plain files that
 	contain the link text. linkgit:git-update-index[1] and
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 5ec179d631..10cb37795d 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -298,6 +298,14 @@ number of pitfalls:
   in particular the case for older Git versions and alternative Git
   implementations such as JGit or libgit2 (as of February 2018).
 
+- Reencoding content to non-UTF encodings can cause errors as the
+  conversion might not be UTF-8 round trip safe. If you suspect your
+  encoding to not be round trip safe, then add it to
+  `core.checkRoundtripEncoding` to make Git check the round trip
+  encoding (see linkgit:git-config[1]). SHIFT-JIS (Japanese character
+  set) is known to have round trip issues with UTF-8 and is checked by
+  default.
+
 - Reencoding content requires resources that might slow down certain
   Git operations (e.g 'git checkout' or 'git add').
 
diff --git a/config.c b/config.c
index 1f003fbb90..d0ada9fcd4 100644
--- a/config.c
+++ b/config.c
@@ -1172,6 +1172,11 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.checkroundtripencoding")) {
+		check_roundtrip_encoding = xstrdup(value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.notesref")) {
 		notes_ref_name = xstrdup(value);
 		return 0;
diff --git a/convert.c b/convert.c
index c4e2fd5fa5..398cd9cf7b 100644
--- a/convert.c
+++ b/convert.c
@@ -289,6 +289,39 @@ static void trace_encoding(const char *context, const char *path,
 	strbuf_release(&trace);
 }
 
+static int check_roundtrip(const char* enc_name)
+{
+	/*
+	 * check_roundtrip_encoding contains a string of space and/or
+	 * comma separated encodings (eg. "UTF-16, ASCII, CP1125").
+	 * Search for the given encoding in that string.
+	 */
+	const char *found = strcasestr(check_roundtrip_encoding, enc_name);
+	const char *next = found + strlen(enc_name);
+	int len = strlen(check_roundtrip_encoding);
+	return (found && (
+			/*
+			 * check that the found encoding is at the
+			 * beginning of check_roundtrip_encoding or
+			 * that it is prefixed with a space or comma
+			 */
+			found == check_roundtrip_encoding || (
+				found > check_roundtrip_encoding &&
+				(*(found-1) == ' ' || *(found-1) == ',')
+			)
+		) && (
+			/*
+			 * check that the found encoding is at the
+			 * end of check_roundtrip_encoding or
+			 * that it is suffixed with a space or comma
+			 */
+			next == check_roundtrip_encoding + len || (
+				next < check_roundtrip_encoding + len &&
+				(*next == ' ' || *next == ',')
+			)
+		));
+}
+
 static struct encoding {
 	const char *name;
 	struct encoding *next;
@@ -366,6 +399,47 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 	}
 	trace_encoding("destination", path, default_encoding, dst, dst_len);
 
+	/*
+	 * UTF supports lossless conversion round tripping [1] and conversions
+	 * between UTF and other encodings are mostly round trip safe as
+	 * Unicode aims to be a superset of all other character encodings.
+	 * However, certain encodings (e.g. SHIFT-JIS) are known to have round
+	 * trip issues [2]. Check the round trip conversion for all encodings
+	 * listed in core.checkRoundtripEncoding.
+	 *
+	 * The round trip check is only performed if content is written to Git.
+	 * This ensures that no information is lost during conversion to/from
+	 * the internal UTF-8 representation.
+	 *
+	 * Please note, the code below is not tested because I was not able to
+	 * generate a faulty round trip without an iconv error. Iconv errors
+	 * are already caught above.
+	 *
+	 * [1] http://unicode.org/faq/utf_bom.html#gen2
+	 * [2] https://support.microsoft.com/en-us/help/170559/prb-conversion-problem-between-shift-jis-and-unicode
+	 */
+	if ((conv_flags & CONV_WRITE_OBJECT) && check_roundtrip(enc->name)) {
+		char *re_src;
+		int re_src_len;
+
+		re_src = reencode_string_len(dst, dst_len,
+					     enc->name, default_encoding,
+					     &re_src_len);
+
+		trace_printf("Checking roundtrip encoding for %s...\n", enc->name);
+		trace_encoding("reencoded source", path, enc->name,
+			       re_src, re_src_len);
+
+		if (!re_src || src_len != re_src_len ||
+		    memcmp(src, re_src, src_len)) {
+			const char* msg = _("encoding '%s' from %s to %s and "
+					    "back is not the same");
+			die(msg, path, enc->name, default_encoding);
+		}
+
+		free(re_src);
+	}
+
 	strbuf_attach(buf, dst, dst_len, dst_len + 1);
 	return 1;
 }
diff --git a/convert.h b/convert.h
index 1d9539ed0b..765abfbd60 100644
--- a/convert.h
+++ b/convert.h
@@ -56,6 +56,7 @@ struct delayed_checkout {
 };
 
 extern enum eol core_eol;
+extern char *check_roundtrip_encoding;
 extern const char *get_cached_convert_stats_ascii(const struct index_state *istate,
 						  const char *path);
 extern const char *get_wt_convert_stats_ascii(const char *path);
diff --git a/environment.c b/environment.c
index 10a32c20ac..5bae9131ad 100644
--- a/environment.c
+++ b/environment.c
@@ -50,6 +50,7 @@ int check_replace_refs = 1;
 char *git_replace_ref_base;
 enum eol core_eol = EOL_UNSET;
 int global_conv_flags_eol = CONV_EOL_RNDTRP_WARN;
+char *check_roundtrip_encoding = "SHIFT-JIS";
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
 enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index 01789ae1b8..e4717402a5 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -209,4 +209,45 @@ test_expect_success 'error if encoding garbage is already in Git' '
 	git reset --hard $BEFORE_STATE
 '
 
+test_expect_success 'check roundtrip encoding' '
+	text="hallo there!\nroundtrip test here!" &&
+	printf "$text" | iconv -f UTF-8 -t SHIFT-JIS >roundtrip.shift &&
+	printf "$text" | iconv -f UTF-8 -t UTF-16 >roundtrip.utf16 &&
+	echo "*.shift text working-tree-encoding=SHIFT-JIS" >>.gitattributes &&
+
+	# SHIFT-JIS encoded files are round-trip checked by default...
+	GIT_TRACE=1 git add .gitattributes roundtrip.shift 2>&1 >/dev/null |
+		grep "Checking roundtrip encoding for SHIFT-JIS" &&
+	git reset &&
+
+	# ... unless we overwrite the Git config!
+	test_config core.checkRoundtripEncoding "garbage" &&
+	! GIT_TRACE=1 git add .gitattributes roundtrip.shift 2>&1 >/dev/null |
+		grep "Checking roundtrip encoding for SHIFT-JIS" &&
+	test_unconfig core.checkRoundtripEncoding &&
+	git reset &&
+
+	# UTF-16 encoded files should not be round-trip checked by default...
+	! GIT_TRACE=1 git add roundtrip.utf16 2>&1 >/dev/null |
+		grep "Checking roundtrip encoding for UTF-16" &&
+	git reset &&
+
+	# ... unless we tell Git to check it!
+	test_config_global core.checkRoundtripEncoding "UTF-16, UTF-32" &&
+	GIT_TRACE=1 git add roundtrip.utf16 2>&1 >/dev/null |
+		grep "Checking roundtrip encoding for UTF-16" &&
+	git reset &&
+
+	# ... unless we tell Git to check it!
+	# (here we also check that the casing of the encoding is irrelevant)
+	test_config_global core.checkRoundtripEncoding "UTF-32, utf-16" &&
+	GIT_TRACE=1 git add roundtrip.utf16 2>&1 >/dev/null |
+		grep "Checking roundtrip encoding for UTF-16" &&
+	git reset &&
+
+	# cleanup
+	rm roundtrip.shift roundtrip.utf16 &&
+	git reset --hard HEAD
+'
+
 test_done
-- 
2.16.1

