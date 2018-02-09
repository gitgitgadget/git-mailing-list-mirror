Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BB3A1F404
	for <e@80x24.org>; Fri,  9 Feb 2018 13:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751299AbeBIN3R (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 08:29:17 -0500
Received: from mail-dm3nam03on0124.outbound.protection.outlook.com ([104.47.41.124]:60090
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751140AbeBIN3M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 08:29:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=lcLVAXgZDk44LGLKY4bPPPOb6f9WKNjc4Yshxh7Pj6w=;
 b=faMVN8+e1AB/mMZUDw4LwKE5HBwWFGw8kmhumoq6qdUU+/Bqn00/M/YgNDqacfF5Mmk83tSkzhnudBCwcQaf2fxjsNZ3EcnRijbBUd23u6uwihvVDwXHKxCprQWu6v/jUV5l3PQ4/CNYirE0sWvMTdAqAkvswG1yhnCLvughUXk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxbook4.ads.autodesk.com (62.159.156.210) by
 DM5P136MB0028.NAMP136.PROD.OUTLOOK.COM (129.75.96.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.464.14; Fri, 9 Feb 2018 13:29:06 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v6 7/7] convert: add round trip check based on 'core.checkRoundtripEncoding'
Date:   Fri,  9 Feb 2018 14:28:30 +0100
Message-Id: <20180209132830.55385-8-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209132830.55385-1-lars.schneider@autodesk.com>
References: <20180209132830.55385-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [62.159.156.210]
X-ClientProxiedBy: DB6PR1001CA0018.EURPRD10.PROD.OUTLOOK.COM (10.171.79.28) To
 DM5P136MB0028.NAMP136.PROD.OUTLOOK.COM (129.75.96.155)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 89470494-7a27-4f09-59cb-08d56fc119e6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM5P136MB0028;
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0028;3:kBSyR75wu6HCmICZEBJ/Td2mMbGXNLfbD/uySo8Hf7ol47spRgn2KIOx0EQGAj4IyZNOjG5fsT4cFYq/2R4xCC3FK7y4p3vYHwr+OezgPHF3B2dTfZ6Nnwk2k3sQymqGeyrfwsfpCqrwubxuP5vbkFWQzxBsgKhz04jTqRlWLn0Q6IWjvSSxfqU8p1zLFKil+Ao/wFm/+91fjKxd95ROKPhYl1PstfRRxry0cq/qLdEADCnrGrI03C60PrtOQyAJ;25:pnvReG9KlJdzVmMwb9NxYqVqnfObkqtef42HROMnNAotTQ07kqA0T8CSgIVWbgqsWN/7k+WITozCZb9jmrH0y0xtKWggWcByuiy6n97sLFFegiATH3AsWtIVfpAmen1nI3ZujG4fSbMp+wyMz8X1L44903yA0qx4rYMolMBacMMBemnRl1t0TJ98aid3ixWYShurbbRbbL47wu16JWfWWfJ5H6Lzc8OxMlZsgAvJ/2QaF69MNKcTL1CS/VDYXRpuPRrY4thWvqaunS9lafzyeY3L0q3PUwJRnSCNUmFEsA4yASi43fiat//KCCPQW6UuAAB7u9gfPo8MVer9q4rZUw==;31:xnd7IW3ywCLEMU7XGzm2CvA6LozhZ20PuvPmKmJ69/hAtidCvOulFVw28ZYbNiUk9GJdjFB3hDndk73YS+K78MV7uQc9iBzmAB+vorKtOHo4v9Z2tlI6jjcrJUTXb2uP8vAZNrVYcqVudj86z2boDtIpJr6r+/YdecbPPLbnQU+nhmlnYYaLMbzE8++iLica1Nbsh5Mx/O7DpdUL0V+yjvmfmRs4Ni2tOuegp7qEq7k=
X-MS-TrafficTypeDiagnostic: DM5P136MB0028:
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0028;20:YedPgFqqXK6Ff84MngJkNIhBbRA8V39RKCGpU+UH8TzsFUPSiIyL/JUN4Fcy1xvtjLxzbbNb6vOg1HZ7vdlGED0mjGcGnEYAgo5/L0Vz4V7QTqHDP2flf8QSkSZv2kA6OrRf8y+LK5e5Ku3uLEb5Kx60XlLtP53aGGUe+71CGRPppdo0dE/FhziZlqtOJInejfi5mlwHwpq6zxxJi4lRfKVikQDdUqEK1FiqM0E+KrcF+VhfE+ySqV3Yu34svUAt+8cQTiaIOLbBgl2rD15BGiVXkN07X/sa6shoXUVazTFdk+c+n7xsh4oNow6aM9FF+LEOlVtCK3a/R3RHO745fkz2PSp8Ayu51+8bytG94ZGgb4XFtCUvoh0mak6x6y3knJsqQf+iOF7iCLP5E8Y0MMCCWibyblu0/yl+nD+SowpWNdvEPU7yrFu+rbBPjteCcU0ju+kQaQStO9jjvEnRzYR7/DSVZkzm2fOfiE6tfPHQLBKNwvXHYpNBRKdyLslBvIbny29IvSL4OwCdY5AaKo66HX9YVlJLN+x0WxZuovfDO46b2qlnKrnIgX4XORYbxvbWpegGsIY8yfM19u2NqISiraZQC55KGipjS3ohF08=
X-Microsoft-Antispam-PRVS: <DM5P136MB0028901437A02CA18B3D33E1E8F20@DM5P136MB0028.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5P136MB0028;BCL:0;PCL:0;RULEID:;SRVR:DM5P136MB0028;
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0028;4:FHM8YaoJWMTBnMWBVdyV4GLCVI5DORnvElYdF+jopfZ5Slar6R6LT34aPhLGH4GhZbrzs3bc0fzJOI89etsOadFR0t5P9KRIMQhl89/H3WnRIbYJxLtj31vtdmB+cNQGiegTjbdsZ1DQvhUlUFzsLEK7MV4OZcJAzZNlCODsO7Ey6Ca0vzOUccPZWGVMP2UNERR3nF3PTPYbja4O/UDpPEJLEKsLMd06mJ0xB8kNRPjkBfk1m7ba7MSCpZuGzAa+xsdmve2rw+qAn3WjPand/8FwY4YrsSgSZa76us0r0m4Docxq1NOxxZ96l0DQoa7wpQ+VSoyEtm8aETVIb8utKTVmicDOQuJE/4l7k0USkWg=
X-Forefront-PRVS: 057859F9C5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(346002)(366004)(376002)(39860400002)(199004)(189003)(97736004)(68736007)(26005)(5890100001)(2361001)(6116002)(3846002)(106356001)(2351001)(478600001)(53936002)(966005)(86362001)(9686003)(1076002)(2906002)(85782001)(6306002)(36756003)(8656006)(50226002)(316002)(105586002)(25786009)(52116002)(7696005)(51416003)(7736002)(575784001)(386003)(16586007)(50466002)(2950100002)(4326008)(48376002)(6916009)(6666003)(8936002)(81166006)(59450400001)(47776003)(6486002)(66066001)(39060400002)(53376002)(8676002)(81156014)(76176011)(5660300001)(16526019)(186003)(8666007)(305945005)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5P136MB0028;H:slxbook4.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5P136MB0028;23:kgHMs5h6AiJ3b1NrS+SGEyRn6Vdd3ibg1wEuA0K2+?=
 =?us-ascii?Q?4mBSG6foINbYuYDB8sZayTg7p878APAwvlyaPCowS6le6j0EWN4IjjCW+LrC?=
 =?us-ascii?Q?2qCNUjZ1sGFf6omKTSivf334aS0ueEGneSGSd8kSVAtLvwTYO9u0dmz2cZ/d?=
 =?us-ascii?Q?97tk2NVb0kHGfWIJETYIvlwXbFrlwGooI+uCq3u+b3YZcgYvNRcMeWhOGZO/?=
 =?us-ascii?Q?t6MSbYneqYu7eaU1sWMFrXS4fMwmxuoF+WZvqv1cXvG3FWqJbeaiVuHbORJ1?=
 =?us-ascii?Q?RSNkNzUoMT7i1NX5nBRzaUgrgHysoa6s2/LRhT6Y7FV+8sJp3zmr53EKwu3R?=
 =?us-ascii?Q?SdlLbHQrrsnVo1Qvb5Afn4r61ZZJ7vQYsQtTgI6o9Q/skDHPAaiOOtUFEQ9e?=
 =?us-ascii?Q?D0dAoDlI6t1qiAevvQy93YXgrDIDtF2qVy/7MlbjiEYrT2FBpJ4TI18rCQyT?=
 =?us-ascii?Q?lmY34uhEfLy3wwUKL02AZ4SpBim1GO2PJVG/gYayoSkxRPU31fhzkc1dv85A?=
 =?us-ascii?Q?yMjNAZD6+pBS75mNJnK88Fe1JbjRJhkatk8vwyoo9H3SmxAHvM2xU5BE9BDM?=
 =?us-ascii?Q?GbKSZbzW8oknOsYrhWJm2Th7HkLBLNCEmBZQ7FZ5lp9HWHixqeQDFJIS9QOc?=
 =?us-ascii?Q?ToeC6JeQJmzAlW9C2WaX99gyIIi8hfBAHfMIBI+2oWnjytxhff7PZY8PHp92?=
 =?us-ascii?Q?3R0+sbMwjxxTOaVswK7WbFLWcimuWavX8mGajoXF1/aEHqV+xT6Mu6loX+Lo?=
 =?us-ascii?Q?nDcl5z2JFnfsIeQbmGFuoZdHqB5sGCReF34wWl3rcfcBHvEQBGnYTo4++CGT?=
 =?us-ascii?Q?onsBPGc7+mkIWXWpeR1Lt+alcwzAJGkH2PEj7y7cUatfzqVVCjbBYsZ19aIE?=
 =?us-ascii?Q?WmfuDcoMQHCgl3oVnAcj2TwTP7XHYUh5SAoRbExe9QbKYKh5hrnvOWmjniCv?=
 =?us-ascii?Q?ooQjjHZ1hkJxBT4nPSgUhcnpUnuoQEAdcLP21+IBG0CmgEezBecCLIxH6Tak?=
 =?us-ascii?Q?DowD1JYDtbZYapBqHc2DxL17ARvyByTC78OGpS48ZvOCeNf5N+PVX4p6iHGQ?=
 =?us-ascii?Q?Z4abJJQPmRLjL4/fW+TuR0XzxOuneIrjzGkU0mcE1pnJRd65hGi7lKNWJQkk?=
 =?us-ascii?Q?e4hwigbgaBdhhB1FjuSY/jgKMYBm0PofDnd2BT8G8iZ4MzvOpgstTg6vlfzJ?=
 =?us-ascii?Q?Kv1pEhs5sFC1DVJ/ED4jYD6c6D+bU/cHJmIWrWpPvD8ytuQ/G3nHF+7CEkzn?=
 =?us-ascii?Q?/lIopBiOrhXt9mPODlwBdiVhJt/OPlDWduj4uY+FMv/fHXsnRNVpkz9fUsL1?=
 =?us-ascii?Q?Hpk/+V3QhhJZmfhm62tSKqMSCNfm3bsPd6zZZcsHa6/gM/Coz7CUioIO+hFP?=
 =?us-ascii?Q?k0aL2ea8oVbPkeHRKU0VPXgbLvMLo296bHP4kxd6FXfpj+t?=
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0028;6:RSe/BkQ3v86k84gcU1Q+MsmQZk0bgFuCskUl+vVnWresgl4vwnMBLZFQ8UyL8eWiu8Xtpf0ONEssBBa3vqz4B6pnl0Gl+EgCZGPTS1q7KnulPRg/oZA6fEEgBuIcIh/7rYJkO81Nbjy9qIKxtWdXc2wXhLmiRe9wEYZNL6wvBMiH+M6ocUsNeRYtJGGAYPQvYTtx0VCQJ46ffhJJMFNNqYirSotAjle4Q0T2wJWwabq0dmSFIZnd0Py9DKvFGhlsSNOkYLG+lENz91FP2fGWleNLyJeVBsGIxj6GKMZ+9rdt/iuPOekc8LHDGGqEMeZ5Si6Q2SpjZ2uYs4yQIdrgoMI1+h1vWuNgO+u8p7wApyM=;5:ymDNgtaek91Rf6uelKE5rsWM5zDeyqEL3aPWuYzH1T3txacdyNSLGWSA1yZYgho465GQ8m4/96aG9GUHRjoOWetkU0jpCMlL70BrCa3yusM7Eaiy68nuSdDANkcge4SfngRPHekLl3m03qwM1o/gK8cZhgVQV6xnrWqjFHf/d4s=;24:Lo51SYBOWT+mh39K1DgiI6ks+XMaxuIxk0I6JbnaoGDKum6ufte30Qis/w4NY8S/aoJuZdAQX/AjATpb/rSUmf0pljSU6NvgpRzwqta6VrM=;7:JJ65jaCiQnEOu4TWK/D8xW+zdWd5IefomIDDyrmKPy8vT+XCJJERw+yh/yJAZzZCEfj1RTNEu7OGHErAHpiuQ6EfPh48SOCnZ5JkY/rM/dDgWE4/pWPc3+u+z2mFCOWVxDrEgsi6sQ3AbQQfXDwHkWsxEmzlof9x6CJobeaqcru87jbHTFBUr92v+kdW9Zy0qimHqLjnNYas4rgMNbybwsU7FlY0z8NqYWzSyO2h9xgHJlOg5POimP4iPXbqOyt0
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2018 13:29:06.8878 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89470494-7a27-4f09-59cb-08d56fc119e6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5P136MB0028
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
 Documentation/gitattributes.txt  |  7 ++++
 config.c                         |  5 +++
 convert.c                        | 74 ++++++++++++++++++++++++++++++++++++++++
 convert.h                        |  1 +
 environment.c                    |  1 +
 t/t0028-working-tree-encoding.sh | 41 ++++++++++++++++++++++
 7 files changed, 135 insertions(+)

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
index 4ecdcd4859..ea5a9509c6 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -298,6 +298,13 @@ number of pitfalls:
   older Git versions and alternative Git implementations such as JGit
   or libgit2 (as of February 2018).
 
+- Reencoding content to non-UTF encodings can cause errors as the
+  conversion might not be UTF-8 round trip safe. If you suspect your
+  encoding to not be round trip safe, then add it to `core.checkRoundtripEncoding`
+  to make Git check the round trip encoding (see linkgit:git-config[1]).
+  SHIFT-JIS (Japanese character set) is known to have round trip issues
+  with UTF-8 and is checked by default.
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
index 5b49416ee1..71dffc7167 100644
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
+	 * listed in core.checkRoundTripEncoding.
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
index 01789ae1b8..5dcdd5f899 100755
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
+	test_config core.checkRoundTripEncoding "garbage" &&
+	! GIT_TRACE=1 git add .gitattributes roundtrip.shift 2>&1 >/dev/null |
+		grep "Checking roundtrip encoding for SHIFT-JIS" &&
+	test_unconfig core.checkRoundTripEncoding &&
+	git reset &&
+
+	# UTF-16 encoded files should not be round-trip checked by default...
+	! GIT_TRACE=1 git add roundtrip.utf16 2>&1 >/dev/null |
+		grep "Checking roundtrip encoding for UTF-16" &&
+	git reset &&
+
+	# ... unless we tell Git to check it!
+	test_config_global core.checkRoundTripEncoding "UTF-16, UTF-32" &&
+	GIT_TRACE=1 git add roundtrip.utf16 2>&1 >/dev/null |
+		grep "Checking roundtrip encoding for UTF-16" &&
+	git reset &&
+
+	# ... unless we tell Git to check it!
+	# (here we also check that the casing of the encoding is irrelevant)
+	test_config_global core.checkRoundTripEncoding "UTF-32, utf-16" &&
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

