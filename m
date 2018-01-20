Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4D121F424
	for <e@80x24.org>; Sat, 20 Jan 2018 15:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756308AbeATPZH (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Jan 2018 10:25:07 -0500
Received: from mail-dm3nam03on0123.outbound.protection.outlook.com ([104.47.41.123]:24431
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755590AbeATPZA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jan 2018 10:25:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=5s0h7jx5MieSy3uXtcojvBnup8rtuIuBByQpnsAj71k=;
 b=DAJagv1MaO9YRLIM8SnFJrzg+DrX1fUyvUfcX9TvkDlk+iViXdhGcXJB+p4tu/yX++15b6Axwcyohj5SPkyb2c73VZoy+lK+isf8L+1e9RfFJYsaOZv3crkZr0CvzGaZ58tdpM60M3jHZaZvgkt2PSolR6vcoFNXlBxwR3q7J6k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxBook4.fritz.box (91.89.52.221) by
 CY4P136MB0022.NAMP136.PROD.OUTLOOK.COM (2603:10b6:923:12::25) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.428.19; Sat, 20
 Jan 2018 15:24:54 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v4 5/6] convert: add 'working-tree-encoding' attribute
Date:   Sat, 20 Jan 2018 16:24:17 +0100
Message-Id: <20180120152418.52859-6-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.0
In-Reply-To: <20180120152418.52859-1-lars.schneider@autodesk.com>
References: <20180120152418.52859-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [91.89.52.221]
X-ClientProxiedBy: VI1P189CA0006.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::19) To CY4P136MB0022.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:923:12::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23081d17-fdfe-41a2-3d81-08d56019f5f9
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(48565401081)(4534125)(4602075)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:CY4P136MB0022;
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0022;3:tR+s7CsE4z4nF1bRPt02thRuFfBFWoxI0CbuX+H6K/XUzB/Q0N8dEWCDS0rZoC//f3tsep/yeb2O6Qy9Qo276rj7zXyV05pvcIU6NyHJhaPDduSgGt7teZ12nsjVN+0pF+GqSKqVY0kkKRFfc73lyDpgKUkFGxxDlPcuXjn6Qxs8FcrxpJWM3phploRstnUUAoPQzqeQJoqQDs7SO2NeMLGhEOD0Di2XBCYV/OuMlnogzZz669uvpxP8LRyN0usM;25:jjvN7qjQUv6PykOYCcv6MxLgLainbrSNbN5M6JKQQR6Be4rTVi1k21TbS2QTE105NT4xA8zogRJYz+Bp6rpJ72uCILX9F3rjhUEppK4px9WR254iuRWImhSobKVXR03cMHtRPSNPVBwpn8p3o43/hFOfEjCJbpM8v7PbSflWOzAeoFdm8pOmsc25V080YuqVG9K6qEPxd1bu1z/ZHsHsNLIaZXL+Ww3QddZqysNk/Hzuih+r77NSYUQeOfL8XmwMsdp9npK9wgothficCyiUktsToZB9jauW4vkIdXevxaEnQLSJDzUbJi8G1qqc0/HrVROmguiZmX1kILTfJghwSQ==;31:asz2VdK9jdY7kXdgnom2tE7F76yCqtU0FgmHoQ1viQrrNLsIH9ZARua4g8GZnQE+gVrWIu7IiSaxZrhMjabTVKYCgxgrpu5GWItcVUZDE/j76S1YYlfHqkZeqmA5NWB8wLsHDiChDyWSZq0BwOGjXQR8a5NiEprAjEMHPTMS2g+yHDczKAI9O4X77L/MB8GfjGz4x6B9BU8zHgszHE6LUB8B4yiA99KOzQo/bQVerLk=
X-MS-TrafficTypeDiagnostic: CY4P136MB0022:
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0022;20:cLtaFaaSvwEY9fzxz1iw1pQxSL9Z00unbYaADYAt6ti8MYmP/Nx/dtDfwCaOy7+AG18YBX44veqUrmvNEdauI6aPaZffVc3UdBV+G46ImSREQA4rJUTRpeaBcT0UnD+xrriq8wHS/TKa5n2ym4WwPrlmOPRAH6JknF4nIwn0XeZfpi0LbQJMFJwbWDbgN4kncTSx/bTLtSnKUu/xNl8ext2s37E6fECrIvN/kSGWLbIjG4KZ/lHdT1xZvF9eYi0hhJDzgCk4vA6Vl3bj5jNyIkuK0y6Vqd1eKEsHigyObMpu+Y62BBICeblgP4vkmOSDwuzUlPT/JA22cJOu2njPZ1DA3Yppzs52ajR4TVLhfVLVFotaCuiEdWGmdlQf4oNZjbI4SS3S9fVA6ktIWItksWoBbUlIPogOYQscbrnU+lknj+rC42rMfKUd3apv7ECYneC3m1oTEtfH4iXIcpeW8U9av9irW9R4kjRr8NIqkmnj2dvQ5KfM5IkrTu3iDA8cMbWQHOLhh6pC+wn6fgQ8uIegNgXjfSPc2j9KjyGbydUf0K8LO3kVnTJJ6sCYjYfacFxAAxpwYbxYw/nAUNW+kATroCvGqgn7zcuO9gA3Knk=
X-Microsoft-Antispam-PRVS: <CY4P136MB00229EE07093E75108851307E8EE0@CY4P136MB0022.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231023)(2400081)(944501161)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:CY4P136MB0022;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:CY4P136MB0022;
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0022;4:84vbAwjj316qwsQ3LD33VzvPZBvUSrOqXkqXsIeONFMS2DVjhFLHAzpIg3h3CBJTkYveHBdTlxlQ38Qx2kgM/i0nq4zZIhzpNowjgphSZSH4x9By6DFIZiTW5NMJILm4ij9eGCHyeVZk3AIetN6TMEHEfUNLgd2a1nt4AhuT3JrlTIwtYOCpeR0DW4D6xGohQOGyJGTN1sSjZCdlITXj5nkfOEn31qcKQKoiUdneRNC6RtdrG4t7h3a6pqy9APu9YS3xmnvAVy+BhKqmwnYdhJ3yin+KETQ3ad9mBu047hP8kIY0mxAp6klOvVX6TpmgYpjfRHUVjsMhIigAph+ohaTPNnK7G0/4SLw2SKUfnOo=
X-Forefront-PRVS: 0558D3C5AC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(376002)(366004)(346002)(39860400002)(199004)(189003)(97736004)(5890100001)(16526018)(478600001)(68736007)(48376002)(50466002)(305945005)(16586007)(25786009)(7736002)(6306002)(966005)(39060400002)(3846002)(230783001)(50226002)(316002)(85782001)(4326008)(8656006)(6512007)(1076002)(53416004)(86362001)(575784001)(2906002)(6116002)(53376002)(9686003)(2351001)(69596002)(8936002)(5660300001)(36756003)(26005)(59450400001)(66066001)(2361001)(52116002)(8676002)(106356001)(81166006)(47776003)(81156014)(8666007)(6486002)(33896004)(6916009)(2950100002)(105586002)(6506007)(386003)(51416003)(6666003)(76176011)(53936002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4P136MB0022;H:slxBook4.fritz.box;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4P136MB0022;23:AuEVhjS6T/hiHODoVgM/lDXZ12X7AhtRl3oyaK/3A?=
 =?us-ascii?Q?KEcCWaJoWq53Mdy7xs1rNJfxToKPivBdkEh+zi9dcQ/UQDF5Pyr8LNA8UXw2?=
 =?us-ascii?Q?P/hTwVSLLcHFrtulGIl8JiXOaigWIDDzM2AltHFNz8n+x2j8UN1k8ZPlKcsT?=
 =?us-ascii?Q?oFQw+s3CSIfkdFbIwU4XToQYmwZRnNAlg4TRFb8pcy/b6QC4YVbOijkims8s?=
 =?us-ascii?Q?rnE7Qsz+sjbZphsCy7eCNCmJHKiQcxa/9hG1J2/VcA6Dh9yH1sBtcDp+v5JW?=
 =?us-ascii?Q?8gsC7BaiWmP5Rbwy84Yd0GFWYxpTffhoTJchen25biO0I5byTr0Mvxt3efKQ?=
 =?us-ascii?Q?koHqRWNuBY7KDZ79JE4fFK2LxX+Jzuti8BRGwb0nXrqAdeV+yjfTj1lPxxX2?=
 =?us-ascii?Q?sOlUldHX0UvU8w1p3U5aJQk4GW5oCSWmTp7lUb6jGYuzJI76QS8dpk8D5khH?=
 =?us-ascii?Q?Ih4SBvt2MHC24xUgaQRjDZKMpSWFB4kIwJZeb3+YFpuq60T5thZm8LqWi2Ry?=
 =?us-ascii?Q?7g7Jw5pRnOPK93Jr6ZUTNk5WLSvqlc/qKbHko5Nvxaq3Pavu2MXZ1pwHOgSG?=
 =?us-ascii?Q?omUqZ0W9T+NxPFUFLu98qYdcWlKh3BSz2C/T7SmcC+hUapEOoYqwm1ut2J/8?=
 =?us-ascii?Q?8wr9OaHTb1xBxVktjKdIYOyenUt7mO8KzDqA2caH9aryUU+frGZq7sK7worB?=
 =?us-ascii?Q?WzxeJiyRPrxA0O3lMIbXHV+0NsGQJBlFcR/8yIj/IZgfJqunmawTdsDRtfIz?=
 =?us-ascii?Q?eYc84PVAqUNfnPHrqPCLhud4iaUgtl+Cez3g/K7vw1gcUWqrhokJaBzZhdyv?=
 =?us-ascii?Q?IRk4AXTaRqzsxdpB+bvMjTTPoFsZ66wm4A3EZy6lUPMepAr0BUBRz60D0/6O?=
 =?us-ascii?Q?PZtz9ivAtAkr1U+LDxcMWnyOU7hFXcZr2LgcOqg9KRTENepndIOs66DHWHy/?=
 =?us-ascii?Q?/YirnyQpdwnSqm+5reF4i8EJBTJTp0O3//E9imUMqCi5IMDuaVGjnq1vde5U?=
 =?us-ascii?Q?hdh3MpxSIqYaAN+3Q4HbHXUJAL8KDK0p5IV3QjsT8Dh/stGj9BjdN+lzA2Hh?=
 =?us-ascii?Q?A1+3X0pSVT7WJRbYw/0a/2cVnjhDr4mo2FGAhSFIsfXKdPccjnwNYXqitmyq?=
 =?us-ascii?Q?Zjqg0ZYADoEWPjMFr5hg/Xs3uH5aHHs9Sh/iiRVTxotf5CC3TsD0ZzVwLf9s?=
 =?us-ascii?Q?+o4jth6QhvkKFqJvZZzPNSD/z5C0YSMvSXZ9atgfYitGpTkRi99wxHVQe5E/?=
 =?us-ascii?Q?SorOO0KQrEax/ziFyuREG+5jH82qpSp4QN+TMht8imv4i6RhPFhglq5Aghml?=
 =?us-ascii?Q?gao1oXIF7e2aLFwVDSMIxJtJp5JppGZGXXx163nnfQi6f2LAb/Jeeynx86oz?=
 =?us-ascii?Q?3OgZdaNBwdAYkLW4hPqE6Nrajc5wtpVhx1MsN0KkgijiDQNQIr9KfnO1hJul?=
 =?us-ascii?Q?C20X9ZLSG9ckaO3RJT7PkImNS37UTvSgYha6f8FqDwbBpPuidhxFkVQxoA71?=
 =?us-ascii?Q?4Nn29Kwxp1KdA=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0022;6:FBc6rbJc5o7L3Eh9EqVz4zZqvDYEWPdOFaCnwm8R8qljmmK0BwA679F8EZayMteO617RPlN/j+R90Cn4N+BbAJN5dvo2hRvlxTBFaeYfqx9jWpE2USAdFyIOkUvc3Oc1g1cdvZ+Vp/1x1LtKMd7O/h6Y+e3BbQJABQ8eYqPz0Qx7IDiwvq1tZkxd0ud7/0vKs/36tIHGjp7btFZcyCWYssYNAqi1l4yaAbkxCFOaQZKOezNlPkbswagv/5fItUVSXDhnvfplupfAqMPBqEcHurkBq5AVItkMUvikWzeWSURnp8wZwjidd9DxcxUIsJW6iHOUXQPxh7ySSvTliRqjEfN5N0dbCqOSA2bIHU71wiI=;5:TPABimFYrxwZ5KIDZ8DtacP4IXtsoBOqIWV0Ew8pVgfZXS04XpRJT9RXb9wVjPO0UZC9RGPvL3D9cj2HNuw2cLI7Q+lHcg7qgayqsQUvodhLqGUhaV6WSZBIyogpgcyb2V2T2lhxM4kYozY4wzumNphlYHdjPi5hI00hJYLXaRQ=;24:tobL2iRWdWqo3sUm8s6v+DxSat4lVhCFeUPXPiUDZsugtxslrahMRblbxDyr9CLxc6XvdiUAkBMK2vZjySJPgTT8ve4igIoWRHoK/ajf8Ls=;7:Jsazn6KLqKi+eoY1JFqToOOgPNaf4/XKBLvG+lWL3rkTjgf2ebHVoAH86MAwX9IT1fZq/MUpa6nZFA1EvzwUEIkMMqyOOEqJRYuMar6dhBZJoSgg/cK9QTHUj5Ko9dnDkJsi3SUOHH4oP7cz+g9eGNe/1Ez4bJSVwOZcfG345VR5CB2bAmp82n1zXJ4c58DAdYM71iqMusKAaXo+EKHc0uutbfvRsX5y3czpp3NfJbFe3MLzFdQdGUBeawhULX/e
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2018 15:24:54.1244 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23081d17-fdfe-41a2-3d81-08d56019f5f9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4P136MB0022
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
 Documentation/gitattributes.txt  |  60 ++++++++++++
 convert.c                        | 190 ++++++++++++++++++++++++++++++++++++-
 convert.h                        |   1 +
 sha1_file.c                      |   2 +-
 t/t0028-working-tree-encoding.sh | 196 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 447 insertions(+), 2 deletions(-)
 create mode 100755 t/t0028-working-tree-encoding.sh

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 30687de81a..a8dbf4be30 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -272,6 +272,66 @@ few exceptions.  Even though...
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
+attributes is added to Git, then Git reencodes the content from the
+specified encoding to UTF-8 and stores the result in its internal data
+structure (called "the index"). On checkout the content is encoded
+back to the specified encoding.
+
+Please note that using the `working-tree-encoding` attribute may have a
+number of pitfalls:
+
+- Git clients that do not support the `working-tree-encoding` attribute
+  will checkout the respective files UTF-8 encoded and not in the
+  expected encoding. Consequently, these files will appear different
+  which typically causes trouble. This is in particular the case for
+  older Git versions and alternative Git implementations such as JGit
+  or libgit2 (as of January 2018).
+
+- Reencoding content to non-UTF encodings (e.g. SHIFT-JIS) can cause
+  errors as the conversion might not be round trip safe.
+
+- Reencoding content requires resources that might slow down certain
+  Git operations (e.g 'git checkout' or 'git add').
+
+Use the `working-tree-encoding` attribute only if you cannot store a file in
+UTF-8 encoding and if you want Git to be able to process the content as
+text.
+
+Use the following attributes if your '*.txt' files are UTF-16 encoded
+with byte order mark (BOM) and you want Git to perform automatic line
+ending conversion based on your platform.
+
+------------------------
+*.txt		text working-tree-encoding=UTF-16
+------------------------
+
+Use the following attributes if your '*.txt' files are UTF-16 little
+endian encoded without BOM and you want Git to use Windows line endings
+in the working directory.
+
+------------------------
+*.txt 		working-tree-encoding=UTF-16LE text eol=CRLF
+------------------------
+
+You can get a list of all available encodings on your platform with the
+following command:
+
+------------------------
+iconv --list
+------------------------
+
+
 `ident`
 ^^^^^^^
 
diff --git a/convert.c b/convert.c
index b976eb968c..0c372069b1 100644
--- a/convert.c
+++ b/convert.c
@@ -7,6 +7,7 @@
 #include "sigchain.h"
 #include "pkt-line.h"
 #include "sub-process.h"
+#include "utf8.h"
 
 /*
  * convert.c - convert a file when checking it out and checking it in.
@@ -265,6 +266,147 @@ static int will_convert_lf_to_crlf(size_t len, struct text_stat *stats,
 
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
+	} else if (has_missing_utf_bom(enc->name, src, src_len)) {
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
+	/*
+	 * UTF supports lossless round tripping [1]. UTF to other encoding are
+	 * mostly round trip safe as Unicode aims to be a superset of all other
+	 * character encodings. However, the SHIFT-JIS (Japanese character set)
+	 * is an exception as some codes are not round trip safe [2].
+	 *
+	 * Reverse the transformation of 'dst' and check the result with 'src'
+	 * if content is written to Git. This ensures no information is lost
+	 * during conversion to/from UTF-8.
+	 *
+	 * Please note, the code below is not tested because I was not able to
+	 * generate a faulty round trip without iconv error.
+	 *
+	 * [1] http://unicode.org/faq/utf_bom.html#gen2
+	 * [2] https://support.microsoft.com/en-us/help/170559/prb-conversion-problem-between-shift-jis-and-unicode
+	 */
+	if ((conv_flags & CONV_WRITE_OBJECT) && !strcmp(enc->name, "SHIFT-JIS")) {
+		char *re_src;
+		int re_src_len;
+
+		re_src = reencode_string_len(dst, dst_len,
+					     enc->name, default_encoding,
+					     &re_src_len);
+
+		if (!re_src || src_len != re_src_len ||
+		    memcmp(src, re_src, src_len)) {
+			const char* msg = _("encoding '%s' from %s to %s and "
+					    "back is not the same");
+			if (conv_flags & CONV_WRITE_OBJECT)
+				die(msg, path, enc->name, default_encoding);
+			else
+				error(msg, path, enc->name, default_encoding);
+		}
+
+		free(re_src);
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
@@ -978,6 +1120,31 @@ static int ident_to_worktree(const char *path, const char *src, size_t len,
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
+	enc = xcalloc(1, sizeof(struct convert_driver));
+	enc->name = xstrdup_toupper(value);  /* aways use upper case names! */
+	*encoding_tail = enc;
+	encoding_tail = &(enc->next);
+
+	return enc;
+}
+
 static enum crlf_action git_path_check_crlf(struct attr_check_item *check)
 {
 	const char *value = check->value;
@@ -1033,6 +1200,7 @@ struct conv_attrs {
 	enum crlf_action attr_action; /* What attr says */
 	enum crlf_action crlf_action; /* When no attr is set, use core.autocrlf */
 	int ident;
+	struct encoding *checkout_encoding; /* Supported encoding or default encoding if NULL */
 };
 
 static void convert_attrs(struct conv_attrs *ca, const char *path)
@@ -1041,8 +1209,10 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
 
 	if (!check) {
 		check = attr_check_initl("crlf", "ident", "filter",
-					 "eol", "text", NULL);
+					 "eol", "text", "working-tree-encoding",
+					 NULL);
 		user_convert_tail = &user_convert;
+		encoding_tail = &encoding;
 		git_config(read_convert_config, NULL);
 	}
 
@@ -1064,6 +1234,7 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
 			else if (eol_attr == EOL_CRLF)
 				ca->crlf_action = CRLF_TEXT_CRLF;
 		}
+		ca->checkout_encoding = git_path_check_encoding(ccheck + 5);
 	} else {
 		ca->drv = NULL;
 		ca->crlf_action = CRLF_UNDEFINED;
@@ -1144,6 +1315,13 @@ int convert_to_git(const struct index_state *istate,
 		src = dst->buf;
 		len = dst->len;
 	}
+
+	ret |= encode_to_git(path, src, len, dst, ca.checkout_encoding, conv_flags);
+	if (ret && dst) {
+		src = dst->buf;
+		len = dst->len;
+	}
+
 	if (!(conv_flags & CONV_EOL_KEEP_CRLF)) {
 		ret |= crlf_to_git(istate, path, src, len, dst, ca.crlf_action, conv_flags);
 		if (ret && dst) {
@@ -1167,6 +1345,7 @@ void convert_to_git_filter_fd(const struct index_state *istate,
 	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv, CAP_CLEAN, NULL))
 		die("%s: clean filter '%s' failed", path, ca.drv->name);
 
+	encode_to_git(path, dst->buf, dst->len, dst, ca.checkout_encoding, conv_flags);
 	crlf_to_git(istate, path, dst->buf, dst->len, dst, ca.crlf_action, conv_flags);
 	ident_to_git(path, dst->buf, dst->len, dst, ca.ident);
 }
@@ -1198,6 +1377,12 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
 		}
 	}
 
+	ret |= encode_to_worktree(path, src, len, dst, ca.checkout_encoding);
+	if (ret) {
+		src = dst->buf;
+		len = dst->len;
+	}
+
 	ret_filter = apply_filter(
 		path, src, len, -1, dst, ca.drv, CAP_SMUDGE, dco);
 	if (!ret_filter && ca.drv && ca.drv->required)
@@ -1664,6 +1849,9 @@ struct stream_filter *get_stream_filter(const char *path, const unsigned char *s
 	if (ca.drv && (ca.drv->process || ca.drv->smudge || ca.drv->clean))
 		return NULL;
 
+	if (ca.checkout_encoding)
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
index 0000000000..4d85b42776
--- /dev/null
+++ b/t/t0028-working-tree-encoding.sh
@@ -0,0 +1,196 @@
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
+	git add eol.utf16 &&
+	git commit -m eol &&
+
+	# UTF-16 with CRLF (Windows line endings)
+	rm eol.utf16 &&
+	git -c core.eol=crlf checkout eol.utf16 &&
+	test_cmp_bin crlf.utf16.raw eol.utf16 &&
+
+	# UTF-16 with LF (Unix line endings)
+	rm eol.utf16 &&
+	git -c core.eol=lf checkout eol.utf16 &&
+	test_cmp_bin lf.utf16.raw eol.utf16 &&
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
2.16.0

