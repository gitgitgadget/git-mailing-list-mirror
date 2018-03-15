Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A90641F404
	for <e@80x24.org>; Thu, 15 Mar 2018 22:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932822AbeCOW6Z (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 18:58:25 -0400
Received: from mail-bl2nam02on0132.outbound.protection.outlook.com ([104.47.38.132]:45186
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932670AbeCOW6V (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 18:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Jd4qLp6KfLJL5KWf5maRUYBlxRpdFzGJM7kcZM+whjA=;
 b=DQjjG/DsCrIALAyHm+yLS66K5X3gn//NDngxbj58EOWeL+YrbMv//zEVKNimTiKh+Hy79tbbCxKq/gOt6/O9Lep7/7wb/F1BLo6yDK0x8XjloyjcsmPh5laosc/jSlYTF5dNoEHRwz1v8pL4+ERzo5utQxhAcs6xDAY3qV59CdU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from rem2ua0031cfw.ads.autodesk.com (132.188.32.100) by
 MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM (2603:10b6:320:1c::21) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.15; Thu, 15
 Mar 2018 22:58:16 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        pclouds@gmail.com, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v12 07/10] convert: add 'working-tree-encoding' attribute
Date:   Thu, 15 Mar 2018 23:57:43 +0100
Message-Id: <20180315225746.18119-8-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180315225746.18119-1-lars.schneider@autodesk.com>
References: <20180315225746.18119-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.32.100]
X-ClientProxiedBy: CO2PR04CA0095.namprd04.prod.outlook.com
 (2603:10b6:104:6::21) To MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:320:1c::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 64dddd7c-d230-42c9-f541-08d58ac83e84
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHP136MB0014;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;3:YPSlNFHMQ2+VvmvANukmJyDQkJwc21C2afww+RYfJ/YYE5+TXV2ioaBL/6/f/y4AjIFim3sYeYB1Y+BPbnTKTRp+H18HPJYTEYBL6Haqf7sWK25sN+mtNm2oy5CNCt8YCdNOUnBDeUEmfpUbd2gPzwlxYDzK/xYOvr2tOmyPPWBL4XnG934f7z1kw92dN9JDLhgQ8wdtT4D9bQI0JAQZXkzcFM7e1eXwDIDMPSAtGa4DzYLRyHnto186bmHzPcwj;25:sNTz34bmrnoyKxltJSc+g7iKzmluzA+gkTCK2IiCoswfD8EbEgUCX3C1fEJVJPNbKpUI9m9HPoQfkL1PAX5xAKogcPYhcYbbcs8aJ/mImo3+FIwW4r8AWjCVBi37KcPGmZ78dZ1DZQfFuwYXkTHiK0ekFMQjv2My0VlSqdifxQoDzUqI8kSXREJoTnRGxFbljGDnDFsctk3G8oEwri5OH3l6//VaZ0tfhEFUN35WZ6h1l/WkIPFetU4XuAsD755FY1l/kVV9n9qiqCkocXZh9R8LRMdkOVB5h72UZtRdPZSWFh5hJWsZ70Ngkfy9pFN8e+oSdpDh3GwCLtSclCuZMg==;31:V85WwzlaTslETlw1n3TdA7Q3QcZTmY2tvxpjMNbEsfFsnEEarSd6gC646gYcLVmPrmQi0K65glrgcQaLYL938V4UiiLWks8nMEoFBy/YHFyFSkAooP7rXJ8XNCPR9XURjlv4h0fWvpky6z7lpCzjv7J6MG5RkkGAyyNexuPQ3JqNGLoxpVxeOP/Iw+mwhNhlmdbqGzebEekLHX5IT1+cc/CIGaTzG3cTOg9dyvtbpc4=
X-MS-TrafficTypeDiagnostic: MWHP136MB0014:
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;20:FC+6E5QCmcXS8dDcIGOJwx+nFp6O2ODJyxGVKDeb6irc7mP3dvDRm5/XpgobhJs37YY5bxcG/VWHBiQbBoGAj9MrttrdufoVCdYDUwI9vn3jTVtKVU/en4n0/bs0bt8oCU2EqhzH9R6fr/La6cnLSQDuYKGsG+ALO127zzg+wP5cJFlOsjEJxz2Xgh2FHmXrl1Aj7Hcci+zLwHX4RlBL/LOGj43n71mfPymzNUWuHvpAeqrRN6/efWThn/w7UUUBbThnXW+qb/yRLNbAmasGhRND+HDvuEPQgKJE/3jb/r59bdZ0AGJZvPEVaVVHGJvGOaBhq8JOVek7GYyNpPdMBedG7/60T4NAvPc3QOH5y1o3eVoy8f9gnOTLjICdDGX2Avc2SnbEwpHjukmQtu4pNmqog0/gwKHkWob2ixOqLHoBIWdg60NijgH0p2l3j7BXNmPfCfV0jDQzZwQ2ETf1+s1Awyt3C2MEmegbOedtxM6wnYzjImx5F/CVDkbrFL+pf62navLwlHNA9vGWOXA4063tSHgBQSAUo8c7SxA1EJh+227OBJoHaRfx98zcLCqC994el0NQe8DOg17deujH/OQK3LgEatiIk64oH9cdzqA=;4:wjHL/JiFKWblDuLc1K1fFhaRHEWnB87+kBB2jX/ICWEfhPss1zJeMaNdSHicwxl7OP6QscPiMzJfBH/hUAsFrTC92t7AiDwUzlx4bhBJRO5hVQi8eLKCWjYaNcWLQeKo8TXr59xCMGyCYgaKa80JnLbbyDn1dImZqm4D4SR8cvfS8dgKxM5HGhmfP6Zo8j0CZWTYccGc9Ua3vZfLtySc/0Kje7yAQSrldiUO9XCmVdz0SwoNjBv+9DNhhyvDShqSSlIZZCbg4W04gHEAsK2NVGXBfCkMvTWChNhJJkvxytJcmX26IoK7kajO1QLgvT/1
X-Microsoft-Antispam-PRVS: <MWHP136MB001496A9B81F03BCA427D34DE8D00@MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231221)(944501276)(52105095)(6055026)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:MWHP136MB0014;BCL:0;PCL:0;RULEID:;SRVR:MWHP136MB0014;
X-Forefront-PRVS: 0612E553B4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(376002)(366004)(346002)(189003)(199004)(85782001)(81166006)(52116002)(53936002)(45080400002)(51416003)(76176011)(1076002)(39060400002)(16586007)(2361001)(8676002)(105586002)(47776003)(6486002)(2906002)(478600001)(106356001)(50226002)(575784001)(81156014)(2351001)(26005)(4326008)(8936002)(2950100002)(6116002)(68736007)(3846002)(186003)(66066001)(8666007)(25786009)(59450400001)(48376002)(86362001)(386003)(6666003)(36756003)(6916009)(7696005)(5660300001)(97736004)(7736002)(305945005)(7416002)(316002)(16526019)(5890100001)(9686003)(50466002)(8656006)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHP136MB0014;H:rem2ua0031cfw.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHP136MB0014;23:n7mzCFz7RwIx+LNu4cZSRJOOlcar93yCZ+zWB6fQN?=
 =?us-ascii?Q?uE4TFlhU1OEd3yZt3w47Ae5HJt9FLfBe4LX4TqRGGXdjZU1ppjnkv+avLsx5?=
 =?us-ascii?Q?lpRmS8/p2LyuLJtCnkG5UEE3NKlVLn3ynQrtt4sk9mfUpqjcbYqsVS24uWhM?=
 =?us-ascii?Q?q2raYZJovzpqtYk2wvs+0AqQXSv+4L+X6LTxA01U+4NrSNC2JzNA+UX+7UTU?=
 =?us-ascii?Q?UW8iW7/gAtPOcolpJjuszvgN6p2ETUICpbtlxSD8UgNHjYnCZCBKPOdBSKYe?=
 =?us-ascii?Q?oL1rtFBo0rfK/EBsbWMZ5uwRG5eDeaNDcaoFsOcIe3GSz2izAO3EkGHY5xql?=
 =?us-ascii?Q?gNrW0T3g5G+A4AOiG2kPWC2dgHnZv9DpHCLXfQ7vD66T6WhLlvbsPPQcJZjb?=
 =?us-ascii?Q?EJlj2RRdduJThkTS1WFrYWZ88lb2zFh4Kwcm9x1zRrppI2QcOehs0Rana5UF?=
 =?us-ascii?Q?V8sIB3ieqeidEmg5B/skiqm8v4EKnnWPSgS08pN/OynCOHPRP1JlRHXbzTmb?=
 =?us-ascii?Q?EgJPkDKYDVjvif48dAwoZxsHEuEu92T2AfZMQtpnSEZ2CWhIhNYPfVKbENKy?=
 =?us-ascii?Q?cNaGJKQe1mfq0tQt9LgqcJCDbMVgIx7Sbo0xHvEBWWhAs0f3DjdrXYoFIzt+?=
 =?us-ascii?Q?BGl00++hajshuXTKPr4Xg2IcmSqego/ik2c/wS28oGzDImraScyrV04YusfA?=
 =?us-ascii?Q?JVRcl7qjDWlJlKWciyRapE9jN2oWnXju6+bE7qHzGvBZkNZAed57aUqPLJLa?=
 =?us-ascii?Q?DbzmZfu7tRo26GH1Yz296/l/MkCfo3QUacVUuW/Gkvl0XPAT+kajYBN7OrXb?=
 =?us-ascii?Q?QWpJIQ2mDvHKYym2qDX1U+KgXRBrAGPcGhho18YrPTvos4Lj2/LYfLGKWqOs?=
 =?us-ascii?Q?Izh0EwspJKKiUebLHKj8F5lJO4Q//Fb5xc2H3HvOjipnkvRt86tzI4cb9oht?=
 =?us-ascii?Q?fav+iaW2tzCIW58t6XdtiJD32IaV1lHr2w6H1rOAJijQXG51tJ6Cm064d4tj?=
 =?us-ascii?Q?UedXC+azdFF+Vji8DaIDBE2TgMWxzi960FtFSuNn80cdATvBylu0nFQdMkv3?=
 =?us-ascii?Q?Lg9CWzUJyTMaIRor4sAeICuwV1AoT8ziCoz78Jua5lfDnbtAUOR4hYUlffKA?=
 =?us-ascii?Q?98LVzCdsh26LwL9ERiwompyeSAcKgI75bat/W0oBg03s0rwrjdcgFV2wxdwS?=
 =?us-ascii?Q?Ir+rJXj8C6ovJvwejowP0LflqWKmEkuc5eDqr6/EL/mX9upqkhsk6s91asw5?=
 =?us-ascii?Q?pk19JD5r6Ghh2V1QoDpuXQAGsgToD3U17Mn3dzLHOVIbp2HJ2fRLAodtdLMc?=
 =?us-ascii?Q?UlM4tX4ExRs/SFsmBrVCS9yT4Sq9UpEI1fU+KCeYLdLumytIBTa5ocaahCX2?=
 =?us-ascii?Q?s9JW7fjwPPryectrX3UxK3d2Lc=3D?=
X-Microsoft-Antispam-Message-Info: U2trPVOU0XCHErXRn7NaMeeBMB4UYq3XK/TRwtWK6D6UFUgdFGCj0UXQR16rd0Axsq0fWt5XaZ7nhzKTqaLrVzFdlCvJ8Sk6P7YrziTrCpqMAfGSJ+07VCzLxjHWIwOIPWGPyDLn6T9d6BRyD/INkNuw4y4LOWCJQpWd5zlJtdpOBf0U1bIxefusv6crV3Ys
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;6:G/8tuLLG8x9YHHlVDidn4QWAAvzNeThp6X2hF8vkMmfK/faJmVcvSv2xqoPLI8JVBfsb//blNvCRBrefLArVXWtJWwwhRx+Neq8Wc2aWa7YvuVle2DfXeK9dcpBD6mhqWyAZSUwkFcU5cOW5JDUTrvFQIWKlP417h6OM1yW0nVfcyfnFs4eR7IooTF4YO1BPc7hRfM7w4U4jg5QsVKCvt3Hp3F+1GKK3dbwkxhRHhs4LY6ffX+NosRbhdaHyKANemrt9D2nA5m465MeQOy+vdZUTAga+9hXD8yTyfK7Up9tLdLacG74V3CTs9YxaKobt2/j9kaVigv7r6T3xkag5kpAde5PUajqVQb/RdC4yStE=;5:Zu5fmzAQM3WJgL5iQiyc3mNsA4oUOCriXyqJ0726ltRD/EsL9ZEtESy15AJH9Sr06HPpvij4aXn3a5zsz1hOj0xtHABD+pY1zGzkH5EY8mOFuT5Q9yl7Ab+KeAPK86Cvi6tQfYTp6ZXJPyHTj0YhGRfSIvLRdnXoLuiju2R6KAA=;24:x8GnVKioVR2QohfkxvOP8Vaq1IBkT2K4n6eQeVpZ+9LMU6OjOdooMBECUU/akaj0Pj94GCv7zU70Yb0hmxyew1DF1Nqou57jk1/D08YesCY=;7:8fOatsQDaokm/3ecCF6HJkHDZ6KMNjfU5IMidNNomNniCiVSfkouIRoeO5uaYQ8PBe1Eei8FT16x/uvjGDbAOjGPjkbU3FDaZuXw9Y+vJrRP7CbQaYAhNF2GhvSZFuouNzgLsZlfAiiHASM7LuQZmDyra9ghFU0mU9iEPELGazk+2WwlaLSgfN/85pb1nToVl9uxa7OAuA7MaQrWoz2/Ol6oyesH1LTsn7jZcwmjlFShbN/Xj21PwQ0FyER1NSND
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2018 22:58:16.4473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64dddd7c-d230-42c9-f541-08d58ac83e84
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHP136MB0014
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
 Documentation/gitattributes.txt  |  80 ++++++++++++++++++++++
 convert.c                        | 113 ++++++++++++++++++++++++++++++-
 convert.h                        |   1 +
 sha1_file.c                      |   2 +-
 t/t0028-working-tree-encoding.sh | 142 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 336 insertions(+), 2 deletions(-)
 create mode 100755 t/t0028-working-tree-encoding.sh

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 30687de81a..31a4f92840 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -272,6 +272,86 @@ few exceptions.  Even though...
   catch potential problems early, safety triggers.
 
 
+`working-tree-encoding`
+^^^^^^^^^^^^^^^^^^^^^^^
+
+Git recognizes files encoded in ASCII or one of its supersets (e.g.
+UTF-8, ISO-8859-1, ...) as text files. Files encoded in certain other
+encodings (e.g. UTF-16) are interpreted as binary and consequently
+built-in Git text processing tools (e.g. 'git diff') as well as most Git
+web front ends do not visualize the contents of these files by default.
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
+- Alternative Git implementations (e.g. JGit or libgit2) and older Git
+  versions (as of March 2018) do not support the `working-tree-encoding`
+  attribute. If you decide to use the `working-tree-encoding` attribute
+  in your repository, then it is strongly recommended to ensure that all
+  clients working with the repository support it.
+
+  For example, Microsoft Visual Studio resources files (`*.rc`) or
+  PowerShell script files (`*.ps1`) are sometimes encoded in UTF-16.
+  If you declare `*.ps1` as files as UTF-16 and you add `foo.ps1` with
+  a `working-tree-encoding` enabled Git client, then `foo.ps1` will be
+  stored as UTF-8 internally. A client without `working-tree-encoding`
+  support will checkout `foo.ps1` as UTF-8 encoded file. This will
+  typically cause trouble for the users of this file.
+
+  If a Git client, that does not support the `working-tree-encoding`
+  attribute, adds a new file `bar.ps1`, then `bar.ps1` will be
+  stored "as-is" internally (in this example probably as UTF-16).
+  A client with `working-tree-encoding` support will interpret the
+  internal contents as UTF-8 and try to convert it to UTF-16 on checkout.
+  That operation will fail and cause an error.
+
+- Reencoding content requires resources that might slow down certain
+  Git operations (e.g 'git checkout' or 'git add').
+
+Use the `working-tree-encoding` attribute only if you cannot store a file
+in UTF-8 encoding and if you want Git to be able to process the content
+as text.
+
+As an example, use the following attributes if your '*.ps1' files are
+UTF-16 encoded with byte order mark (BOM) and you want Git to perform
+automatic line ending conversion based on your platform.
+
+------------------------
+*.ps1		text working-tree-encoding=UTF-16
+------------------------
+
+Use the following attributes if your '*.ps1' files are UTF-16 little
+endian encoded without BOM and you want Git to use Windows line endings
+in the working directory. Please note, it is highly recommended to
+explicitly define the line endings with `eol` if the `working-tree-encoding`
+attribute is used to avoid ambiguity.
+
+------------------------
+*.ps1		text working-tree-encoding=UTF-16LE eol=CRLF
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
+file foo.ps1
+------------------------
+
+
 `ident`
 ^^^^^^^
 
diff --git a/convert.c b/convert.c
index b976eb968c..85e49741af 100644
--- a/convert.c
+++ b/convert.c
@@ -7,6 +7,7 @@
 #include "sigchain.h"
 #include "pkt-line.h"
 #include "sub-process.h"
+#include "utf8.h"
 
 /*
  * convert.c - convert a file when checking it out and checking it in.
@@ -265,6 +266,78 @@ static int will_convert_lf_to_crlf(size_t len, struct text_stat *stats,
 
 }
 
+static const char *default_encoding = "UTF-8";
+
+static int encode_to_git(const char *path, const char *src, size_t src_len,
+			 struct strbuf *buf, const char *enc, int conv_flags)
+{
+	char *dst;
+	int dst_len;
+	int die_on_error = conv_flags & CONV_WRITE_OBJECT;
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
+	dst = reencode_string_len(src, src_len, default_encoding, enc,
+				  &dst_len);
+	if (!dst) {
+		/*
+		 * We could add the blob "as-is" to Git. However, on checkout
+		 * we would try to reencode to the original encoding. This
+		 * would fail and we would leave the user with a messed-up
+		 * working tree. Let's try to avoid this by screaming loud.
+		 */
+		const char* msg = _("failed to encode '%s' from %s to %s");
+		if (die_on_error)
+			die(msg, path, enc, default_encoding);
+		else {
+			error(msg, path, enc, default_encoding);
+			return 0;
+		}
+	}
+
+	strbuf_attach(buf, dst, dst_len, dst_len + 1);
+	return 1;
+}
+
+static int encode_to_worktree(const char *path, const char *src, size_t src_len,
+			      struct strbuf *buf, const char *enc)
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
+	dst = reencode_string_len(src, src_len, enc, default_encoding,
+				  &dst_len);
+	if (!dst) {
+		error("failed to encode '%s' from %s to %s",
+			path, default_encoding, enc);
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
@@ -978,6 +1051,24 @@ static int ident_to_worktree(const char *path, const char *src, size_t len,
 	return 1;
 }
 
+static const char *git_path_check_encoding(struct attr_check_item *check)
+{
+	const char *value = check->value;
+
+	if (ATTR_UNSET(value) || !strlen(value))
+		return NULL;
+
+	if (ATTR_TRUE(value) || ATTR_FALSE(value)) {
+		die(_("working-tree-encoding attribute requires a value"));
+	}
+
+	/* Don't encode to the default encoding */
+	if (same_encoding(value, default_encoding))
+		return NULL;
+
+	return value;
+}
+
 static enum crlf_action git_path_check_crlf(struct attr_check_item *check)
 {
 	const char *value = check->value;
@@ -1033,6 +1124,7 @@ struct conv_attrs {
 	enum crlf_action attr_action; /* What attr says */
 	enum crlf_action crlf_action; /* When no attr is set, use core.autocrlf */
 	int ident;
+	const char *working_tree_encoding; /* Supported encoding or default encoding if NULL */
 };
 
 static void convert_attrs(struct conv_attrs *ca, const char *path)
@@ -1041,7 +1133,8 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
 
 	if (!check) {
 		check = attr_check_initl("crlf", "ident", "filter",
-					 "eol", "text", NULL);
+					 "eol", "text", "working-tree-encoding",
+					 NULL);
 		user_convert_tail = &user_convert;
 		git_config(read_convert_config, NULL);
 	}
@@ -1064,6 +1157,7 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
 			else if (eol_attr == EOL_CRLF)
 				ca->crlf_action = CRLF_TEXT_CRLF;
 		}
+		ca->working_tree_encoding = git_path_check_encoding(ccheck + 5);
 	} else {
 		ca->drv = NULL;
 		ca->crlf_action = CRLF_UNDEFINED;
@@ -1144,6 +1238,13 @@ int convert_to_git(const struct index_state *istate,
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
@@ -1167,6 +1268,7 @@ void convert_to_git_filter_fd(const struct index_state *istate,
 	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv, CAP_CLEAN, NULL))
 		die("%s: clean filter '%s' failed", path, ca.drv->name);
 
+	encode_to_git(path, dst->buf, dst->len, dst, ca.working_tree_encoding, conv_flags);
 	crlf_to_git(istate, path, dst->buf, dst->len, dst, ca.crlf_action, conv_flags);
 	ident_to_git(path, dst->buf, dst->len, dst, ca.ident);
 }
@@ -1198,6 +1300,12 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
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
@@ -1664,6 +1772,9 @@ struct stream_filter *get_stream_filter(const char *path, const unsigned char *s
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
index 0000000000..d67dbde1d4
--- /dev/null
+++ b/t/t0028-working-tree-encoding.sh
@@ -0,0 +1,142 @@
+#!/bin/sh
+
+test_description='working-tree-encoding conversion via gitattributes'
+
+. ./test-lib.sh
+
+test_expect_success 'setup test files' '
+	git config core.eol lf &&
+
+	text="hallo there!\ncan you read me?" &&
+	echo "*.utf16 text working-tree-encoding=utf-16" >.gitattributes &&
+	printf "$text" >test.utf8.raw &&
+	printf "$text" | iconv -f UTF-8 -t UTF-16 >test.utf16.raw &&
+	printf "$text" | iconv -f UTF-8 -t UTF-32 >test.utf32.raw &&
+
+	# Line ending tests
+	printf "one\ntwo\nthree\n" >lf.utf8.raw &&
+	printf "one\r\ntwo\r\nthree\r\n" >crlf.utf8.raw &&
+
+	# BOM tests
+	printf "\0a\0b\0c"                         >nobom.utf16be.raw &&
+	printf "a\0b\0c\0"                         >nobom.utf16le.raw &&
+	printf "\376\777\0a\0b\0c"                 >bebom.utf16be.raw &&
+	printf "\777\376a\0b\0c\0"                 >lebom.utf16le.raw &&
+	printf "\0\0\0a\0\0\0b\0\0\0c"             >nobom.utf32be.raw &&
+	printf "a\0\0\0b\0\0\0c\0\0\0"             >nobom.utf32le.raw &&
+	printf "\0\0\376\777\0\0\0a\0\0\0b\0\0\0c" >bebom.utf32be.raw &&
+	printf "\777\376\0\0a\0\0\0b\0\0\0c\0\0\0" >lebom.utf32le.raw &&
+
+	# Add only UTF-16 file, we will add the UTF-32 file later
+	cp test.utf16.raw test.utf16 &&
+	cp test.utf32.raw test.utf32 &&
+	git add .gitattributes test.utf16 &&
+	git commit -m initial
+'
+
+test_expect_success 'ensure UTF-8 is stored in Git' '
+	test_when_finished "rm -f test.utf16.git" &&
+
+	git cat-file -p :test.utf16 >test.utf16.git &&
+	test_cmp_bin test.utf8.raw test.utf16.git
+'
+
+test_expect_success 're-encode to UTF-16 on checkout' '
+	test_when_finished "rm -f test.utf16.raw" &&
+
+	rm test.utf16 &&
+	git checkout test.utf16 &&
+	test_cmp_bin test.utf16.raw test.utf16
+'
+
+test_expect_success 'check $GIT_DIR/info/attributes support' '
+	test_when_finished "rm -f test.utf32.git" &&
+	test_when_finished "git reset --hard HEAD" &&
+
+	echo "*.utf32 text working-tree-encoding=utf-32" >.git/info/attributes &&
+	git add test.utf32 &&
+
+	git cat-file -p :test.utf32 >test.utf32.git &&
+	test_cmp_bin test.utf8.raw test.utf32.git
+'
+
+for i in 16 32
+do
+	test_expect_success "eol conversion for UTF-${i} encoded files on checkout" '
+		test_when_finished "rm -f crlf.utf${i}.raw lf.utf${i}.raw" &&
+		test_when_finished "git reset --hard HEAD^" &&
+
+		cat lf.utf8.raw | iconv -f UTF-8 -t UTF-${i} >lf.utf${i}.raw &&
+		cat crlf.utf8.raw | iconv -f UTF-8 -t UTF-${i} >crlf.utf${i}.raw &&
+		cp crlf.utf${i}.raw eol.utf${i} &&
+
+		cat >expectIndexLF <<-EOF &&
+			i/lf    w/-text attr/text             	eol.utf${i}
+		EOF
+
+		git add eol.utf${i} &&
+		git commit -m eol &&
+
+		# UTF-${i} with CRLF (Windows line endings)
+		rm eol.utf${i} &&
+		git -c core.eol=crlf checkout eol.utf${i} &&
+		test_cmp_bin crlf.utf${i}.raw eol.utf${i} &&
+
+		# Although the file has CRLF in the working tree,
+		# ensure LF in the index
+		git ls-files --eol eol.utf${i} >actual &&
+		test_cmp expectIndexLF actual &&
+
+		# UTF-${i} with LF (Unix line endings)
+		rm eol.utf${i} &&
+		git -c core.eol=lf checkout eol.utf${i} &&
+		test_cmp_bin lf.utf${i}.raw eol.utf${i} &&
+
+		# The file LF in the working tree, ensure LF in the index
+		git ls-files --eol eol.utf${i} >actual &&
+		test_cmp expectIndexLF actual
+	'
+done
+
+test_expect_success 'check unsupported encodings' '
+	test_when_finished "git reset --hard HEAD" &&
+
+	echo "*.set text working-tree-encoding" >.gitattributes &&
+	printf "set" >t.set &&
+	test_must_fail git add t.set 2>err.out &&
+	test_i18ngrep "working-tree-encoding attribute requires a value" err.out &&
+
+	echo "*.unset text -working-tree-encoding" >.gitattributes &&
+	printf "unset" >t.unset &&
+	git add t.unset &&
+
+	echo "*.empty text working-tree-encoding=" >.gitattributes &&
+	printf "empty" >t.empty &&
+	git add t.empty &&
+
+	echo "*.garbage text working-tree-encoding=garbage" >.gitattributes &&
+	printf "garbage" >t.garbage &&
+	test_must_fail git add t.garbage 2>err.out &&
+	test_i18ngrep "failed to encode" err.out
+'
+
+test_expect_success 'error if encoding round trip is not the same during refresh' '
+	BEFORE_STATE=$(git rev-parse HEAD) &&
+	test_when_finished "git reset --hard $BEFORE_STATE" &&
+
+	# Add and commit a UTF-16 file but skip the "working-tree-encoding"
+	# filter. Consequently, the in-repo representation is UTF-16 and not
+	# UTF-8. This simulates a Git version that has no working tree encoding
+	# support.
+	echo "*.utf16le text working-tree-encoding=utf-16le" >.gitattributes &&
+	echo "hallo" >nonsense.utf16le &&
+	TEST_HASH=$(git hash-object --no-filters -w nonsense.utf16le) &&
+	git update-index --add --cacheinfo 100644 $TEST_HASH nonsense.utf16le &&
+	COMMIT=$(git commit-tree -p $(git rev-parse HEAD) -m "plain commit" $(git write-tree)) &&
+	git update-ref refs/heads/master $COMMIT &&
+
+	test_must_fail git checkout HEAD^ 2>err.out &&
+	test_i18ngrep "error: .* overwritten by checkout:" err.out
+'
+
+test_done
-- 
2.16.2

