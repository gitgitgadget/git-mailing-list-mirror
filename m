Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2106C1F404
	for <e@80x24.org>; Fri,  9 Feb 2018 13:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751277AbeBIN3I (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 08:29:08 -0500
Received: from mail-dm3nam03on0133.outbound.protection.outlook.com ([104.47.41.133]:48000
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751150AbeBIN3F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 08:29:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=F3tIeyPVxkepk39Q6k8ynGRTcykqso6m08zH+g2LBWQ=;
 b=F0A2X7E9U8IhCPxqEg1SitJjJe1YHn8OkH8WOvMPzwwJKX9y/wkv28vYHlJcXwtuiNwPhYVSnyPObNZ9dvjNojj0jAFQFBKNSbZkgP/ODgKv8t4B9IF7er61bOb8GhgY3zYSSqld6mdI2zxDy1OSdK7xJmnI0geyPuWNxnr7788=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxbook4.ads.autodesk.com (62.159.156.210) by
 DM5P136MB0028.NAMP136.PROD.OUTLOOK.COM (129.75.96.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.464.14; Fri, 9 Feb 2018 13:29:00 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v6 5/7] convert: add 'working-tree-encoding' attribute
Date:   Fri,  9 Feb 2018 14:28:28 +0100
Message-Id: <20180209132830.55385-6-lars.schneider@autodesk.com>
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
X-MS-Office365-Filtering-Correlation-Id: 620f06ec-6812-4855-25ba-08d56fc115c6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM5P136MB0028;
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0028;3:moBAi8YIhT/vdEhSI+fWOwxVOat0mkFISGnF8AtD9wPMWGsIcn6YJ9hUzCPKExsigZCAU39aYY0ZEQYwNYqH5ohib2Pe0LuZaTidGZq3jHLMnoA/wi5Vxv4KMVYQ3wMyJnlKEsYyxamq8/k93PLycEE6YO4wS3sUxEZngSVwNl7Jv7/9qbJaArvvdSKQ3Te1s6oeb/Qmhv1vt0V/HVZG0RDLL9rrdP7E6WKQ3Sz72SCmJWbA4moJaTOqptc0NHZk;25:0Zji1XBIOzS9fy2Xr6frBmX+ynnjXZ/lp0dUMgoio1YZ2x08zA6FLkX1NCbxG1AamGEUVA58K8aD7HebdXMSryiL7DJaPbINf1qoF2kroiVOvLH0oGEaApV7PUW8NdmOYKAcpGhrkoOs4d37w2V7oFyk9T2DqdIRnnF4wgZoCNbjAfxyT7PWLNS7fGJEkrfsIBS6giDqMd2ytOIoquHM/g7jKlJuvc+LT8jOqOc2zru65G5MyQnin2UvmgNxlN2OamiNkZKB8T/Zp1jBO3OEYgtqJBCZeWHeR3KvI/Yr8ecUqUW6LInO1z77htAT4h1sFqxZbVti4pTLo2bdEqyWjw==;31:rCHXrYg9Ki5BSRJw8QgThD0p9iVSLpI3tqY+nVvbpoJPB+ySDke7kXG7QDkoyEpIh9KMe1tA97TCHPiZDLiFD6cVUC5/6iNk/Juu/C0AZzVKE7UX0Xauv8x9XXZJjPRGXqTe2or0GONUuSP6WJuJ164JpocpLiy+UAuNGpybFXr/Aq8cF1tvz6qfxdScrb9GwfzMggRxtU+4FfETXBORlJAO6Y1VaSCvFBaSSGVzRSI=
X-MS-TrafficTypeDiagnostic: DM5P136MB0028:
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0028;20:zZBWAG6iyzYxSz54tYFVe0M7HkEc6U0DU070qCOA6o3TqMoLYxrhBqRFQW4eq5Iqbp1oUPBIreiEo2yFWFFAOinkTgCVB8rYNHBxljNpRnbNE4FJMHoV8Ax4LmwNBE6DmY0XYoR4HV1kPFUmmtT6hP/nWfu90BuNnvtL6+xWodazytJJ0FsGVGAXkUuhnGHzXCyrj6hmbrs/ldo6tOZ9xZs10LYZFkcBdj+x4UFCopW0ihZke8qM8xSgvpN+AzTJ7PMGe63vgeCjM1eg/GL9+Ldvo2+JCXO43UEyJ+31NToHgA+CwA0+p2IKhqnDyvDhOs6qXUnnf/pPWJx13QZAnohEy/w3E/5EUkIZTH0Om8pexgPUPxNjK+gJmpzRjaFrVnJkT/80aNYGxNxVnFevJvsJ3iyCMdatvIKSPBR06/1czC6fQFj1RWjsm+xDVQOGNYhtHLLx7kN8CoHmL+3eEnYMVpzvLyKJstSkYVTxPtQEpsyLQoo9S+IIxrmx1BWOXNZjCQ1D4msb25sV2olqnv8UE6sXy8HWN5nCgaJ1neb6hJDtI4Cm5ByRhsE3o06E3Axu96zpfORGnjDsgfYETUoL1BuA5PbZ1jE9eaE5sEg=;4:3zSkX4rAiOcrXs/WCc7Cnv0HiiAKXapDuehK29PZ/VK6fjPRZ6mVyE6iQCyAZzS9z+jKcFRdDEV4IFNgW0JHzjXGCCHgMc2C08YWCEWZfn1pXcH07qJCMh7v831M8JFyoaQK4WgG7xOUjFC9Ryf7lwcWdmkZ/tADB5osRCoeswihNmHg1bhqWc82a757kpv+5Zu8js7nFHtpoZ/rD1vBzXVbCuh65Zp/RkX1RoX3cNMBWTF+SxteNxTk8EV1EV41jXpL5YGWIyTUjmtGBHtPeoQLjZrGtPm8/4rpa+VC/HdElUyef7ifjoW/uTYrEYHP
X-Microsoft-Antispam-PRVS: <DM5P136MB0028DC4220333EAE870C3C83E8F20@DM5P136MB0028.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5P136MB0028;BCL:0;PCL:0;RULEID:;SRVR:DM5P136MB0028;
X-Forefront-PRVS: 057859F9C5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(346002)(366004)(376002)(39860400002)(199004)(189003)(97736004)(68736007)(26005)(5890100001)(2361001)(6116002)(3846002)(106356001)(2351001)(478600001)(53936002)(86362001)(9686003)(1076002)(2906002)(85782001)(36756003)(8656006)(50226002)(316002)(105586002)(25786009)(52116002)(7696005)(51416003)(7736002)(575784001)(386003)(16586007)(50466002)(2950100002)(4326008)(48376002)(6916009)(6666003)(8936002)(81166006)(59450400001)(47776003)(6486002)(66066001)(39060400002)(8676002)(81156014)(76176011)(5660300001)(16526019)(186003)(8666007)(305945005)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5P136MB0028;H:slxbook4.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5P136MB0028;23:N/LsVT9LWEqCCdAczq5T8dYFnGc7dDNsQaYd0DORy?=
 =?us-ascii?Q?L7A6gzxw0fvxSc3SAd6SLGd4cIkQ7+TzM0KyIqKnvYVexY83Jp7Yw+0ryR1s?=
 =?us-ascii?Q?y++B2LYx+kaolXJBotDdHOi5mPoha5xK3np6HrXHxUAg/keSqXtXNZBWPkVu?=
 =?us-ascii?Q?BjlJdyWosaGTkSmuS34QTlUVFqsVucOJ1dSk2pbNcDvcfZh/QhYM3q4oNe48?=
 =?us-ascii?Q?4vR2oZnmB633miHDdVbIpXq36HQ+zf3gFsdjbiS6dqAqVu1l+wqdpiPKb0EC?=
 =?us-ascii?Q?i4kP9Ee4gFhFBe4MD3ubcit3xDj8wXNNg4Nn6n3zmutORe6E5nOc6xkczYrb?=
 =?us-ascii?Q?jAY1AcMtT+2TM3cyCJ2jtmU6ZuKAMWJX+W4idUGBy0Bi6fsrMJFgkER547Qj?=
 =?us-ascii?Q?Z8rZsrk3/j5uOyFrac54tfPwQAAXdRmePXds6VDuigiXiyOwPCocFU1ByM7e?=
 =?us-ascii?Q?uJ6KuuZQOSnpHRbSM4Cmfe6Rgt4Zk1VJdPVaOdmOysQCRGBn0CWmfcOOP5ze?=
 =?us-ascii?Q?hY/Ora1PUZh/7uNmx8qj8dbGGtypas0DTQ9j2t6pqqYpqzkq4CpKqIqCLE1r?=
 =?us-ascii?Q?OP7YxlODg8M+RT/MPrgHuH67v0quI/SrQ9sfy4/KL9C9iJGuMC0ZhUAh48lQ?=
 =?us-ascii?Q?tVN5x6FjN3cNZfdvy6xZqYWFiZKmBlvrLe/GyofdaqVwaBy6PvFNjdQsn7WT?=
 =?us-ascii?Q?WKpk6qZRBucF8VfPlYblfTwIvJByqOEnZA42VNeVKLpabcM/2RWIBhaZzaGZ?=
 =?us-ascii?Q?ZoVA7CxXhzMxnSCuUUtJ5eMq+bYccIi8SrDHAviWdElX/Q8EGUBnVFnPjpHS?=
 =?us-ascii?Q?7IjTxE/Wzg5cT/ul7WeaiL+pq3lRQ+SwATtr6qJ+sv8tVB/CirUNyOBbR/fs?=
 =?us-ascii?Q?nAL+00fjH7xFFfAXR1VnRPGjAuob8xFdtbsPiC4Vv8Ddx+yd4aC+AQSyeaJM?=
 =?us-ascii?Q?GbmGwNqfiuRsG0NNARbswP+OAdipEeRTGrWhkh4TTwArxgAuewylJmsY/tL7?=
 =?us-ascii?Q?Bqpm9siWIrO9WdYliFZyauKgCFukc8DSyHwtdsjQVMAio6xujgmRAI43Ktws?=
 =?us-ascii?Q?3ccw4PAGqjulAvArnfkJQ+H0mNaKPgAM/UImkn3FlVHG9yqFJH+gPn2bwjlV?=
 =?us-ascii?Q?vccgpSXKM1WDaLpr0szNbgiIb0J+SVtBqJERU/9cHIp1iPxeqwd0gK5GXqg6?=
 =?us-ascii?Q?ejY3ggRL+97KevqzW3i+YkQz5s51z2GdF8tywUsw5o+cTZTlgS4o5VJdpyeu?=
 =?us-ascii?Q?rkGollEEvP/GjmCqYPjaP8+1xt9jUpZrb/Cu/+S+c56IOrN048FbjELVx8S8?=
 =?us-ascii?Q?O0Vtw3MnujIrrsurvMfS86ccelONoy7024NWIQi9syK?=
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0028;6:o7by92GYzuX/9y4hCTybaLgWAb1biW4ptimH+1MIeByMJxlCiIJqUL4+1FcA9ko7NNh8zivjNWwVFuo6X2X3oyBY1nLgFJ+IbbDzUPkpTEwRqmjFqB+25edH00Bg4/jrgPIP7X0UDU4UEsvKWRi4eCrYarnhOLsc+nHYwwSLNFjPGGfOHHK4cS07SuDMH7/zFSCHHjFuyPbP9Fj7MfVJE/7YRZIZ/e36T+IOBeOMCJSLMfaALijqlxuRUzMerGj99aoBCjRL5bdslVL4OqX6Lo/1ttRRHN2mXLFgjzMnYEBSFSL1r/RIyqE+rJMajcXBg+L5Ni07qnnCy5L8+k9JFKW3g0oa0nOoWnK5riJ4h5Y=;5:rKdlq19x0myTAW/sheHerQS/r88MM8rgFysRY5kreEJrHy5VuaWxysSKh9wxN7/I5yv9PKZShPlMH1OK3kEvenP2cEulmiUS+jPqa1IzWa0p8f7e+4XgTNW3zfIEBhL+llPaJLX0sHnKBYziP9+q5VJpIxKehxgL8BQ5YMAg2B0=;24:0sCxLMtAMQN8u75dZwHELUaO0Cphg6vQ4UF9Ks6m/U9jBiKgllcObv8T0Wv2QxJRDSPRQFRkPj7HS8UefXjbC81WnegG2FQ4WbJEBTQZ1g8=;7:t4P21tfPZVKqutFLapYzRdQUi5VN8PXepWD95OJjusKt12tU/zSOC80PhBjXoJtm3j52QBxW8/b5efnAfjVWO9IdfG1QBul9xff0TFFKz8SQydzI1BbtZfSe15Z2Eujs5hkOhidL6a6rZyqcrnKOUdkgoOzhq/siryRDpY+jQRlHkPWSQC3lQc1Q+oodl3fnvVo0gD4Czdn+UkFB6PDo3t3yWYKM4NvZ/NLb/y1Pq57c324u8jyICSyJXcsr20Vb
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2018 13:29:00.0909 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 620f06ec-6812-4855-25ba-08d56fc115c6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5P136MB0028
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Git recognizes files encoded with ASCII or one of its supersets (e.g.
UTF-8 or ISO-8859-1) as text files. All other encodings are usually
interpreted as binary and consequently built-in Git text processing
tools (e.g. 'git diff') as well as most Git web front ends do not
visualize the content.

Add an attribute to tell Git what encoding the user has defined for a
given file. If the content is added to the index, then Git converts the
content to a canonical UTF-8 representation. On checkout Git will
reverse the conversion.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 Documentation/gitattributes.txt  |  66 ++++++++++++
 convert.c                        | 157 ++++++++++++++++++++++++++++-
 convert.h                        |   1 +
 sha1_file.c                      |   2 +-
 t/t0028-working-tree-encoding.sh | 210 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 434 insertions(+), 2 deletions(-)
 create mode 100755 t/t0028-working-tree-encoding.sh

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 30687de81a..4ecdcd4859 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -272,6 +272,72 @@ few exceptions.  Even though...
   catch potential problems early, safety triggers.
 
 
+`working-tree-encoding`
+^^^^^^^^^^^^^^^^^^^^^^^
+
+Git recognizes files encoded with ASCII or one of its supersets (e.g.
+UTF-8 or ISO-8859-1) as text files.  All other encodings are usually
+interpreted as binary and consequently built-in Git text processing
+tools (e.g. 'git diff') as well as most Git web front ends do not
+visualize the content.
+
+In these cases you can tell Git the encoding of a file in the working
+directory with the `working-tree-encoding` attribute. If a file with this
+attribute is added to Git, then Git reencodes the content from the
+specified encoding to UTF-8. Finally, Git stores the UTF-8 encoded
+content in its internal data structure (called "the index"). On checkout
+the content is reencoded back to the specified encoding.
+
+Please note that using the `working-tree-encoding` attribute may have a
+number of pitfalls:
+
+- Git clients that do not support the `working-tree-encoding` attribute
+  will checkout the respective files UTF-8 encoded and not in the
+  expected encoding. Consequently, these files will appear different
+  which typically causes trouble. This is in particular the case for
+  older Git versions and alternative Git implementations such as JGit
+  or libgit2 (as of February 2018).
+
+- Reencoding content requires resources that might slow down certain
+  Git operations (e.g 'git checkout' or 'git add').
+
+Use the `working-tree-encoding` attribute only if you cannot store a file
+in UTF-8 encoding and if you want Git to be able to process the content
+as text.
+
+As an example, use the following attributes if your '*.proj' files are
+UTF-16 encoded with byte order mark (BOM) and you want Git to perform
+automatic line ending conversion based on your platform.
+
+------------------------
+*.proj		text working-tree-encoding=UTF-16
+------------------------
+
+Use the following attributes if your '*.proj' files are UTF-16 little
+endian encoded without BOM and you want Git to use Windows line endings
+in the working directory. Please note, it is highly recommended to
+explicitly define the line endings with `eol` if the `working-tree-encoding`
+attribute is used to avoid ambiguity.
+
+------------------------
+*.proj 		working-tree-encoding=UTF-16LE text eol=CRLF
+------------------------
+
+You can get a list of all available encodings on your platform with the
+following command:
+
+------------------------
+iconv --list
+------------------------
+
+If you do not know the encoding of a file, then you can use the `file`
+command to guess the encoding:
+
+------------------------
+file foo.proj
+------------------------
+
+
 `ident`
 ^^^^^^^
 
diff --git a/convert.c b/convert.c
index b976eb968c..dc9e2db6b5 100644
--- a/convert.c
+++ b/convert.c
@@ -7,6 +7,7 @@
 #include "sigchain.h"
 #include "pkt-line.h"
 #include "sub-process.h"
+#include "utf8.h"
 
 /*
  * convert.c - convert a file when checking it out and checking it in.
@@ -265,6 +266,110 @@ static int will_convert_lf_to_crlf(size_t len, struct text_stat *stats,
 
 }
 
+static struct encoding {
+	const char *name;
+	struct encoding *next;
+} *encoding, **encoding_tail;
+static const char *default_encoding = "UTF-8";
+
+static int encode_to_git(const char *path, const char *src, size_t src_len,
+			 struct strbuf *buf, struct encoding *enc, int conv_flags)
+{
+	char *dst;
+	int dst_len;
+
+	/*
+	 * No encoding is specified or there is nothing to encode.
+	 * Tell the caller that the content was not modified.
+	 */
+	if (!enc || (src && !src_len))
+		return 0;
+
+	/*
+	 * Looks like we got called from "would_convert_to_git()".
+	 * This means Git wants to know if it would encode (= modify!)
+	 * the content. Let's answer with "yes", since an encoding was
+	 * specified.
+	 */
+	if (!buf && !src)
+		return 1;
+
+	if (has_prohibited_utf_bom(enc->name, src, src_len)) {
+		const char *error_msg = _(
+			"BOM is prohibited for '%s' if encoded as %s");
+		const char *advise_msg = _(
+			"You told Git to treat '%s' as %s. A byte order mark "
+			"(BOM) is prohibited with this encoding. Either use "
+			"%.6s as working tree encoding or remove the BOM from the "
+			"file.");
+
+		advise(advise_msg, path, enc->name, enc->name, enc->name);
+		if (conv_flags & CONV_WRITE_OBJECT)
+			die(error_msg, path, enc->name);
+		else
+			error(error_msg, path, enc->name);
+
+
+	} else if (is_missing_required_utf_bom(enc->name, src, src_len)) {
+		const char *error_msg = _(
+			"BOM is required for '%s' if encoded as %s");
+		const char *advise_msg = _(
+			"You told Git to treat '%s' as %s. A byte order mark "
+			"(BOM) is required with this encoding. Either use "
+			"%sBE/%sLE as working tree encoding or add a BOM to the "
+			"file.");
+		advise(advise_msg, path, enc->name, enc->name, enc->name);
+		if (conv_flags & CONV_WRITE_OBJECT)
+			die(error_msg, path, enc->name);
+		else
+			error(error_msg, path, enc->name);
+	}
+
+	dst = reencode_string_len(src, src_len, default_encoding, enc->name,
+				  &dst_len);
+	if (!dst) {
+		/*
+		 * We could add the blob "as-is" to Git. However, on checkout
+		 * we would try to reencode to the original encoding. This
+		 * would fail and we would leave the user with a messed-up
+		 * working tree. Let's try to avoid this by screaming loud.
+		 */
+		const char* msg = _("failed to encode '%s' from %s to %s");
+		if (conv_flags & CONV_WRITE_OBJECT)
+			die(msg, path, enc->name, default_encoding);
+		else
+			error(msg, path, enc->name, default_encoding);
+	}
+
+	strbuf_attach(buf, dst, dst_len, dst_len + 1);
+	return 1;
+}
+
+static int encode_to_worktree(const char *path, const char *src, size_t src_len,
+			      struct strbuf *buf, struct encoding *enc)
+{
+	char *dst;
+	int dst_len;
+
+	/*
+	 * No encoding is specified or there is nothing to encode.
+	 * Tell the caller that the content was not modified.
+	 */
+	if (!enc || (src && !src_len))
+		return 0;
+
+	dst = reencode_string_len(src, src_len, enc->name, default_encoding,
+				  &dst_len);
+	if (!dst) {
+		error("failed to encode '%s' from %s to %s",
+			path, enc->name, default_encoding);
+		return 0;
+	}
+
+	strbuf_attach(buf, dst, dst_len, dst_len + 1);
+	return 1;
+}
+
 static int crlf_to_git(const struct index_state *istate,
 		       const char *path, const char *src, size_t len,
 		       struct strbuf *buf,
@@ -978,6 +1083,35 @@ static int ident_to_worktree(const char *path, const char *src, size_t len,
 	return 1;
 }
 
+static struct encoding *git_path_check_encoding(struct attr_check_item *check)
+{
+	const char *value = check->value;
+	struct encoding *enc;
+
+	if (ATTR_TRUE(value) || ATTR_FALSE(value) || ATTR_UNSET(value) ||
+	    !strlen(value))
+		return NULL;
+
+	for (enc = encoding; enc; enc = enc->next)
+		if (!strcasecmp(value, enc->name))
+			return enc;
+
+	/* Don't encode to the default encoding */
+	if (!strcasecmp(value, default_encoding))
+		return NULL;
+
+	enc = xcalloc(1, sizeof(*enc));
+	/*
+	 * Ensure encoding names are always upper case (e.g. UTF-8) to
+	 * simplify subsequent string comparisons.
+	 */
+	enc->name = xstrdup_toupper(value);
+	*encoding_tail = enc;
+	encoding_tail = &(enc->next);
+
+	return enc;
+}
+
 static enum crlf_action git_path_check_crlf(struct attr_check_item *check)
 {
 	const char *value = check->value;
@@ -1033,6 +1167,7 @@ struct conv_attrs {
 	enum crlf_action attr_action; /* What attr says */
 	enum crlf_action crlf_action; /* When no attr is set, use core.autocrlf */
 	int ident;
+	struct encoding *working_tree_encoding; /* Supported encoding or default encoding if NULL */
 };
 
 static void convert_attrs(struct conv_attrs *ca, const char *path)
@@ -1041,8 +1176,10 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
 
 	if (!check) {
 		check = attr_check_initl("crlf", "ident", "filter",
-					 "eol", "text", NULL);
+					 "eol", "text", "working-tree-encoding",
+					 NULL);
 		user_convert_tail = &user_convert;
+		encoding_tail = &encoding;
 		git_config(read_convert_config, NULL);
 	}
 
@@ -1064,6 +1201,7 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
 			else if (eol_attr == EOL_CRLF)
 				ca->crlf_action = CRLF_TEXT_CRLF;
 		}
+		ca->working_tree_encoding = git_path_check_encoding(ccheck + 5);
 	} else {
 		ca->drv = NULL;
 		ca->crlf_action = CRLF_UNDEFINED;
@@ -1144,6 +1282,13 @@ int convert_to_git(const struct index_state *istate,
 		src = dst->buf;
 		len = dst->len;
 	}
+
+	ret |= encode_to_git(path, src, len, dst, ca.working_tree_encoding, conv_flags);
+	if (ret && dst) {
+		src = dst->buf;
+		len = dst->len;
+	}
+
 	if (!(conv_flags & CONV_EOL_KEEP_CRLF)) {
 		ret |= crlf_to_git(istate, path, src, len, dst, ca.crlf_action, conv_flags);
 		if (ret && dst) {
@@ -1167,6 +1312,7 @@ void convert_to_git_filter_fd(const struct index_state *istate,
 	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv, CAP_CLEAN, NULL))
 		die("%s: clean filter '%s' failed", path, ca.drv->name);
 
+	encode_to_git(path, dst->buf, dst->len, dst, ca.working_tree_encoding, conv_flags);
 	crlf_to_git(istate, path, dst->buf, dst->len, dst, ca.crlf_action, conv_flags);
 	ident_to_git(path, dst->buf, dst->len, dst, ca.ident);
 }
@@ -1198,6 +1344,12 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
 		}
 	}
 
+	ret |= encode_to_worktree(path, src, len, dst, ca.working_tree_encoding);
+	if (ret) {
+		src = dst->buf;
+		len = dst->len;
+	}
+
 	ret_filter = apply_filter(
 		path, src, len, -1, dst, ca.drv, CAP_SMUDGE, dco);
 	if (!ret_filter && ca.drv && ca.drv->required)
@@ -1664,6 +1816,9 @@ struct stream_filter *get_stream_filter(const char *path, const unsigned char *s
 	if (ca.drv && (ca.drv->process || ca.drv->smudge || ca.drv->clean))
 		return NULL;
 
+	if (ca.working_tree_encoding)
+		return NULL;
+
 	if (ca.crlf_action == CRLF_AUTO || ca.crlf_action == CRLF_AUTO_CRLF)
 		return NULL;
 
diff --git a/convert.h b/convert.h
index 65ab3e5167..1d9539ed0b 100644
--- a/convert.h
+++ b/convert.h
@@ -12,6 +12,7 @@ struct index_state;
 #define CONV_EOL_RNDTRP_WARN  (1<<1) /* Warn if CRLF to LF to CRLF is different */
 #define CONV_EOL_RENORMALIZE  (1<<2) /* Convert CRLF to LF */
 #define CONV_EOL_KEEP_CRLF    (1<<3) /* Keep CRLF line endings as is */
+#define CONV_WRITE_OBJECT     (1<<4) /* Content is written to the index */
 
 extern int global_conv_flags_eol;
 
diff --git a/sha1_file.c b/sha1_file.c
index 6bc7c6ada9..e2f319d677 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -138,7 +138,7 @@ static int get_conv_flags(unsigned flags)
 	if (flags & HASH_RENORMALIZE)
 		return CONV_EOL_RENORMALIZE;
 	else if (flags & HASH_WRITE_OBJECT)
-	  return global_conv_flags_eol;
+		return global_conv_flags_eol | CONV_WRITE_OBJECT;
 	else
 		return 0;
 }
diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
new file mode 100755
index 0000000000..f9ce3e5ef5
--- /dev/null
+++ b/t/t0028-working-tree-encoding.sh
@@ -0,0 +1,210 @@
+#!/bin/sh
+
+test_description='working-tree-encoding conversion via gitattributes'
+
+. ./test-lib.sh
+
+test_expect_success 'setup test repo' '
+	git config core.eol lf &&
+
+	text="hallo there!\ncan you read me?" &&
+	echo "*.utf16 text working-tree-encoding=utf-16" >.gitattributes &&
+	printf "$text" >test.utf8.raw &&
+	printf "$text" | iconv -f UTF-8 -t UTF-16 >test.utf16.raw &&
+	cp test.utf16.raw test.utf16 &&
+
+	git add .gitattributes test.utf16 &&
+	git commit -m initial
+'
+
+test_expect_success 'ensure UTF-8 is stored in Git' '
+	git cat-file -p :test.utf16 >test.utf16.git &&
+	test_cmp_bin test.utf8.raw test.utf16.git &&
+
+	# cleanup
+	rm test.utf8.raw test.utf16.git
+'
+
+test_expect_success 're-encode to UTF-16 on checkout' '
+	rm test.utf16 &&
+	git checkout test.utf16 &&
+	test_cmp_bin test.utf16.raw test.utf16 &&
+
+	# cleanup
+	rm test.utf16.raw
+'
+
+test_expect_success 'check prohibited UTF BOM' '
+	printf "\0a\0b\0c"                         >nobom.utf16be.raw &&
+	printf "a\0b\0c\0"                         >nobom.utf16le.raw &&
+	printf "\376\777\0a\0b\0c"                 >bebom.utf16be.raw &&
+	printf "\777\376a\0b\0c\0"                 >lebom.utf16le.raw &&
+
+	printf "\0\0\0a\0\0\0b\0\0\0c"             >nobom.utf32be.raw &&
+	printf "a\0\0\0b\0\0\0c\0\0\0"             >nobom.utf32le.raw &&
+	printf "\0\0\376\777\0\0\0a\0\0\0b\0\0\0c" >bebom.utf32be.raw &&
+	printf "\777\376\0\0a\0\0\0b\0\0\0c\0\0\0" >lebom.utf32le.raw &&
+
+	echo "*.utf16be text working-tree-encoding=utf-16be" >>.gitattributes &&
+	echo "*.utf16le text working-tree-encoding=utf-16le" >>.gitattributes &&
+	echo "*.utf32be text working-tree-encoding=utf-32be" >>.gitattributes &&
+	echo "*.utf32le text working-tree-encoding=utf-32le" >>.gitattributes &&
+
+	# Here we add a UTF-16 files with BOM (big-endian and little-endian)
+	# but we tell Git to treat it as UTF-16BE/UTF-16LE. In these cases
+	# the BOM is prohibited.
+	cp bebom.utf16be.raw bebom.utf16be &&
+	test_must_fail git add bebom.utf16be 2>err.out &&
+	test_i18ngrep "fatal: BOM is prohibited .* UTF-16BE" err.out &&
+
+	cp lebom.utf16le.raw lebom.utf16be &&
+	test_must_fail git add lebom.utf16be 2>err.out &&
+	test_i18ngrep "fatal: BOM is prohibited .* UTF-16BE" err.out &&
+
+	cp bebom.utf16be.raw bebom.utf16le &&
+	test_must_fail git add bebom.utf16le 2>err.out &&
+	test_i18ngrep "fatal: BOM is prohibited .* UTF-16LE" err.out &&
+
+	cp lebom.utf16le.raw lebom.utf16le &&
+	test_must_fail git add lebom.utf16le 2>err.out &&
+	test_i18ngrep "fatal: BOM is prohibited .* UTF-16LE" err.out &&
+
+	# ... and the same for UTF-32
+	cp bebom.utf32be.raw bebom.utf32be &&
+	test_must_fail git add bebom.utf32be 2>err.out &&
+	test_i18ngrep "fatal: BOM is prohibited .* UTF-32BE" err.out &&
+
+	cp lebom.utf32le.raw lebom.utf32be &&
+	test_must_fail git add lebom.utf32be 2>err.out &&
+	test_i18ngrep "fatal: BOM is prohibited .* UTF-32BE" err.out &&
+
+	cp bebom.utf32be.raw bebom.utf32le &&
+	test_must_fail git add bebom.utf32le 2>err.out &&
+	test_i18ngrep "fatal: BOM is prohibited .* UTF-32LE" err.out &&
+
+	cp lebom.utf32le.raw lebom.utf32le &&
+	test_must_fail git add lebom.utf32le 2>err.out &&
+	test_i18ngrep "fatal: BOM is prohibited .* UTF-32LE" err.out &&
+
+	# cleanup
+	git reset --hard HEAD
+'
+
+test_expect_success 'check required UTF BOM' '
+	echo "*.utf32 text working-tree-encoding=utf-32" >>.gitattributes &&
+
+	cp nobom.utf16be.raw nobom.utf16 &&
+	test_must_fail git add nobom.utf16 2>err.out &&
+	test_i18ngrep "fatal: BOM is required .* UTF-16" err.out &&
+
+	cp nobom.utf16le.raw nobom.utf16 &&
+	test_must_fail git add nobom.utf16 2>err.out &&
+	test_i18ngrep "fatal: BOM is required .* UTF-16" err.out &&
+
+	cp nobom.utf32be.raw nobom.utf32 &&
+	test_must_fail git add nobom.utf32 2>err.out &&
+	test_i18ngrep "fatal: BOM is required .* UTF-32" err.out &&
+
+	cp nobom.utf32le.raw nobom.utf32 &&
+	test_must_fail git add nobom.utf32 2>err.out &&
+	test_i18ngrep "fatal: BOM is required .* UTF-32" err.out &&
+
+	# cleanup
+	rm nobom.utf16 nobom.utf32 &&
+	git reset --hard HEAD
+'
+
+test_expect_success 'eol conversion for UTF-16 encoded files on checkout' '
+	printf "one\ntwo\nthree\n" >lf.utf8.raw &&
+	printf "one\r\ntwo\r\nthree\r\n" >crlf.utf8.raw &&
+
+	cat lf.utf8.raw | iconv -f UTF-8 -t UTF-16 >lf.utf16.raw &&
+	cat crlf.utf8.raw | iconv -f UTF-8 -t UTF-16 >crlf.utf16.raw &&
+	cp crlf.utf16.raw eol.utf16 &&
+
+	cat >expectIndexLF <<-\EOF &&
+		i/lf    w/-text attr/text             	eol.utf16
+	EOF
+
+	git add eol.utf16 &&
+	git commit -m eol &&
+
+	# UTF-16 with CRLF (Windows line endings)
+	rm eol.utf16 &&
+	git -c core.eol=crlf checkout eol.utf16 &&
+	test_cmp_bin crlf.utf16.raw eol.utf16 &&
+
+	# Although the file has CRLF in the working tree, ensure LF in the index
+	git ls-files --eol eol.utf16 >actual &&
+	test_cmp expectIndexLF actual &&
+
+	# UTF-16 with LF (Unix line endings)
+	rm eol.utf16 &&
+	git -c core.eol=lf checkout eol.utf16 &&
+	test_cmp_bin lf.utf16.raw eol.utf16 &&
+
+	# The file LF in the working tree, ensure LF in the index
+	git ls-files --eol eol.utf16 >actual &&
+	test_cmp expectIndexLF actual&&
+
+	rm crlf.utf16.raw crlf.utf8.raw lf.utf16.raw lf.utf8.raw &&
+
+	# cleanup
+	git reset --hard HEAD^
+'
+
+test_expect_success 'check unsupported encodings' '
+
+	echo "*.nothing text working-tree-encoding=" >>.gitattributes &&
+	printf "nothing" >t.nothing &&
+	git add t.nothing &&
+
+	echo "*.garbage text working-tree-encoding=garbage" >>.gitattributes &&
+	printf "garbage" >t.garbage &&
+	test_must_fail git add t.garbage 2>err.out &&
+	test_i18ngrep "fatal: failed to encode" err.out &&
+
+	# cleanup
+	rm err.out &&
+	git reset --hard HEAD
+'
+
+test_expect_success 'error if encoding round trip is not the same during refresh' '
+	BEFORE_STATE=$(git rev-parse HEAD) &&
+
+	# Skip the UTF-16 filter for the added file
+	# This simulates a Git version that has no working tree encoding support
+	echo "hallo" >nonsense.utf16 &&
+	TEST_HASH=$(git hash-object --no-filters -w nonsense.utf16) &&
+	git update-index --add --cacheinfo 100644 $TEST_HASH nonsense.utf16 &&
+	COMMIT=$(git commit-tree -p $(git rev-parse HEAD) -m "plain commit" $(git write-tree)) &&
+	git update-ref refs/heads/master $COMMIT &&
+
+	test_must_fail git checkout HEAD^ 2>err.out &&
+	test_i18ngrep "error: .* overwritten by checkout:" err.out &&
+
+	# cleanup
+	rm err.out &&
+	git reset --hard $BEFORE_STATE
+'
+
+test_expect_success 'error if encoding garbage is already in Git' '
+	BEFORE_STATE=$(git rev-parse HEAD) &&
+
+	# Skip the UTF-16 filter for the added file
+	# This simulates a Git version that has no checkoutEncoding support
+	cp nobom.utf16be.raw nonsense.utf16 &&
+	TEST_HASH=$(git hash-object --no-filters -w nonsense.utf16) &&
+	git update-index --add --cacheinfo 100644 $TEST_HASH nonsense.utf16 &&
+	COMMIT=$(git commit-tree -p $(git rev-parse HEAD) -m "plain commit" $(git write-tree)) &&
+	git update-ref refs/heads/master $COMMIT &&
+
+	git diff 2>err.out &&
+	test_i18ngrep "error: BOM is required" err.out &&
+
+	# cleanup
+	rm err.out &&
+	git reset --hard $BEFORE_STATE
+'
+
+test_done
-- 
2.16.1

