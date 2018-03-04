Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13EFA1F404
	for <e@80x24.org>; Sun,  4 Mar 2018 20:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752067AbeCDUP7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Mar 2018 15:15:59 -0500
Received: from mail-bl2nam02on0134.outbound.protection.outlook.com ([104.47.38.134]:61501
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932162AbeCDUPr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Mar 2018 15:15:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=nsq1GY3ckWK1vZAZIL/1MIfjKpDSlMYZS4/Xf6zNw9E=;
 b=n/iU1l0zpjs75fjJHB08u7E8cNZ7UqfjKyNCtapdeZZE245PCDJGBgvJhu2HbLSzkWumbla+GIlbDg6cQTa4sTDbwiHvh+uT32erel5SX7CG8ocW8lWjlxpQNQx9oxVkokEQoxsC1E9F2Shi8PsSN8P4x85zG++5Rdngja2dSNY=
Received: from far8gsqyz1.ads.autodesk.com (132.188.32.100) by
 DM5P136MB0009.NAMP136.PROD.OUTLOOK.COM (2603:10b6:23:8::20) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.15; Sun, 4
 Mar 2018 20:14:52 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v9 5/8] convert: add 'working-tree-encoding' attribute
Date:   Sun,  4 Mar 2018 21:14:15 +0100
Message-Id: <20180304201418.60958-6-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180304201418.60958-1-lars.schneider@autodesk.com>
References: <20180304201418.60958-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.32.100]
X-ClientProxiedBy: CO1PR15CA0113.namprd15.prod.outlook.com
 (2603:10b6:101:21::33) To DM5P136MB0009.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:23:8::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0b24bb3f-7bbf-4eab-8711-08d5820c9896
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:DM5P136MB0009;
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0009;3:rimumN8aLTR8XrXiDA4I3P4I54WdMKWHTfBsCteOcDIiA/Aktkks/d9IcYGKjT6s8v7Yztq0HKTh0VDUIeSJWzIgoifUNrWwJunFKvR/8B5wBgd5yKXLJsQiLVobL43CWMHs60sgg61yWT3uxtw1c8aA/maabxOupr48poJRkUDsmvs8km6T/huDgALz2fm00PCnFQKToBjHIkKhqXtxJElnMlGrwkd47NDK1R7nOWHLAwtW4onOVqJ9HMp/lVjh;25:IOYLbtektrn5dJT86IlHXZRnOl2BWjujOhF3+QgLZh/TV8zRTOWYCTurqiAMZO3cVqD4WlEhUlFzt6ZlWAGyFPjZ9nzZRlAwCOc9CxnksVIirJ3+7jWP/O90nBlGNu/drpzu3+B7j2NqIddOV9bv1VbKh37cpE+46nPvl1bPjBOcesZ4J1kIjBqR7srGj6SKyetZN2LM6SDueagWmNbNcugTcxtp6IBmWfQ3COYclS3cmNdOIX0A7evjntSjVGK+LVXwGRMGeLzVbdo1rS0RUXPmLjXI4CWD6OeURfSLjz2Nj0Phrt+9eWRNGUAuUC7WjmUiovZkrLv7KvBCI9kdkA==;31:uUCshasXtGG0fZBjFO/VfKOj7Y5aBq23qkbswKzh3gG3D5Ou4aBOYxrUP5SNMAM7V28YOCBhp889ihrDniMeOcpLldSvVFZI6W09LRr4m4TjxDjznht2BEx6sQRzQRWuzsXb7i2NjJVgYcoWejZx09HY811i4soTSkv2eVUrZBEbfqy7fQEa+qvDx7xKACsZlStzzDdhKWHNFKEp2l/TkPBZF6ubqgahKFgTP3tHZgM=
X-MS-TrafficTypeDiagnostic: DM5P136MB0009:
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0009;20:kQs8+xf4y4Q7UrzonkeGaYQJW1lfs61OLZSEtGqlz3ZTqnfr/QozSKCLK/e4dEGQAm0SePZlUisebd/EK8s6gvu2Pr38o4WtsXT8EkdQCsSwmKXui4CAw4GDDqBGt0p+0ux24mRDC1kdICMBh5A+9sBPNrzOu5DLOHNcPvo1uiPM8ws7/Qb6+hzgMUopcEpkGM6yUh0apNjR8gicE9FpZt5VkTnAjDGvxKVLYQQDH0KGgmVGpK+dtGfQCChcrYbOu8GNR7o4qw+u4IiYuMOFzNHKfvd8ZOkUx3gCxHMCfNdkZQrCAIDDVOgD0x+KazhvR8RS5kYAh1jkpkS07VvxgMGX2DfR0p5y/3PJCyY9dcSm081p3zkoh58OTaQGg031YTn858l3gPTApa63gl6ZB615S3fMdmg3Xs55HbCL6Oq/GXVpOukK/MxQFYD/31XGwzk4uGMg/PQpe8ZNoiudvOn7XJ/EL64o36P50zXHX2OysoMmR2zr2dgXzRzUyS0ElRmvIj2BXlRoEyqK+VgTBAKBWEgtcX3wmXoW3mbmnR4U3hIYHJFrOm8pB+2wlltVOVlIMP7Zes/W84MPjWto16NLp91U0lnFMa0s6pratxc=;4:FlXY8D28pSpMuSZLviUX1etrc/wL91RdGsXbyyk4gv+1c9F1plio3y94Ywleah6td5b0S3XWjZMKBaMedgpGTALduimXcDWYbZGG4byGjk/hOpZAsWITxjqcNKesNg/BFfkkIok+lqYEGHkhGGBokad53Tuyi8wSRZWP3BdC7jyrkgsPtQ9dq+gmOJsyaH3taHvqpD1xMvkSLiaZ+ERFpgcL8IZf6YTwrN/ZOpk1AxPSvBFPqA2UlJCt3c2EVa88QURRNU8OsJQRWXMrrzRzssG6JuU0W32deEoD39I0Hu2OhOqQSr2QxLIdIeuo59NH
X-Microsoft-Antispam-PRVS: <DM5P136MB0009ACD621E1B3854B241CEFE8DB0@DM5P136MB0009.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(6055026)(6041288)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:DM5P136MB0009;BCL:0;PCL:0;RULEID:;SRVR:DM5P136MB0009;
X-Forefront-PRVS: 060166847D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(346002)(39380400002)(396003)(189003)(199004)(316002)(1076002)(8656006)(2361001)(16586007)(66066001)(2906002)(68736007)(7696005)(85782001)(52116002)(97736004)(105586002)(51416003)(575784001)(76176011)(106356001)(86362001)(2351001)(47776003)(6116002)(3846002)(45080400002)(48376002)(8666007)(25786009)(6346003)(39060400002)(26005)(4326008)(50226002)(9686003)(305945005)(386003)(5890100001)(6486002)(59450400001)(53936002)(36756003)(6666003)(2950100002)(6916009)(81156014)(478600001)(8936002)(50466002)(7736002)(186003)(16526019)(5660300001)(81166006)(8676002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5P136MB0009;H:far8gsqyz1.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5P136MB0009;23:ROPE7mfiQQ+5zelG2L6Z36ogxTVwyJLIziqyHQYoz?=
 =?us-ascii?Q?Jqpb510q1m8NsUjgXOuy2nqaJBY5cx6yXb96G4MAr7YmhCjIPfSTCTmcObPk?=
 =?us-ascii?Q?Yk+V3ISdKmT7+D9nw+TcF7oD0zpg0aZXXQhJLyhcsy02XHxyLoxkEt6LQfHZ?=
 =?us-ascii?Q?+QZ6l8l7NCj2M4Enh/e+edlHPsX1LMuzo/UFDJSKt1XkKZSNr+Qpdv9Rsg1z?=
 =?us-ascii?Q?lDvksjhlHzk5SmZzRIAMm6438p3hhFe2lKPyakXBCtuNz8zI4mMfZzLXwzBO?=
 =?us-ascii?Q?7D+CAet5NeLQ2tpN6+mxa022gJEiE739h+xtJYBqfaJXmAOh6JRA7idt01Tp?=
 =?us-ascii?Q?PkiXtbuICqSBZWk7imWjSNjt/FnmZ130ekf0DzbauxCmCoNeQAF0mbirfqVX?=
 =?us-ascii?Q?s9krSHR7bul6aiocDomSKnxreGvBiQ9UYWfUUuBltVfxi9Pxmc0m3IpUZJWw?=
 =?us-ascii?Q?44lz5iRudKlMAH1WGg58r4w+5ltEpCtmGEv0YP4+F4b3jGqx8gAnXTPY+obL?=
 =?us-ascii?Q?mUZPrQT1B2h6aUuZ7PtQHhA5VarLXzieo4I8kOd50jz/jMfbP2Z+WAa0FdXj?=
 =?us-ascii?Q?lHGznMdaNy6GfyQ3CG+gRp/WKae9yYDx4Ul1T/4PJ1YH18iYBtue5Be4TaM1?=
 =?us-ascii?Q?d81lzPg3OeWUjnn1lCy1BvkLh+qNa0D6tLzXh9Beil6j39vPDSJMCUedyaou?=
 =?us-ascii?Q?lguJdoCC6+rF4m1clSqiyMNgnrW6+PsO2doeYIgKZIlOEQswnTqVMyXKVNae?=
 =?us-ascii?Q?egEhhrkz7u5tS33dz5eNZ8+5dBSr3hWze3ZyCgj7qO/u2ue/ts9nr1iJKZBy?=
 =?us-ascii?Q?67X7k2UxIUfhmvW/sx+z5YVtTM6ufYYeYKHI8lxsN1gGYzXlJhAQAGTdGT4w?=
 =?us-ascii?Q?qlkRmT39qjDKOnx2wK02k/E2r/cm3YPZgrGl1NhTNzbgZChq9V6I9uVM79HY?=
 =?us-ascii?Q?MeedgXW5HjaNY424NXk3GKEMX7E0J8KGKfdD3qK1aOi6A6QJiLFiNYOj1jnn?=
 =?us-ascii?Q?MBkH2UYfq8piCnUeM8sxBe9wlNZsaZfxhBSzIIrOSTGBeSeJb6hCLUnwITuf?=
 =?us-ascii?Q?THLNDnscTntL58xOan5iZMdh+I3AFnVXiPGmm3xc/zOAxlF3DbLcUyOAlkQH?=
 =?us-ascii?Q?EevM2LajtDm7FP4HQcSG5EnRAh3bug8dAAPy5PmM0G9p6IsibOr1FQop3Vju?=
 =?us-ascii?Q?MoYA3PYQ8F8alQxbAsFyqPUE4YIyAgiXQF3dOlEI9/cHNelmqWmvrZ4h5Rfj?=
 =?us-ascii?Q?dpTOq6/CoG+mCDVShPldKi9UQSqx2rZkFsYdySJveTtrbQF+zJWIBOFZmS9W?=
 =?us-ascii?Q?lCisiUlWvTe7leUphVGBZBsPVS5CbE535Gf0dN8wjNYG5m+ea1h1aIJu1inG?=
 =?us-ascii?Q?V4Uzs+4mlC/0zmw2qNVCRRA/ds=3D?=
X-Microsoft-Antispam-Message-Info: CWwMn4jw42xaj/Ce4TuLLpPn2kF0FxDXq2y5aQ4UcTemVBtlc0IJivrzTZrs9i9U4oygnlOETrDjd6u7TkHv57IDHS+BfEhCklWcMuUnQYGhf9usI3HGEWGVkW4nfR15B6cWumO9kgGUgt4dmRpvtnOBNaIpnEe8IG/Xss+5xcr9n3/OClQur15qhJaB9u3x
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0009;6:IpqmUL1D1UiPoJ13SUNyUNvR1/kVJt3yLGlRfKq22PsBSqwinoAeYCcrmLWWvcZOGI0FPdNwDdZF0z1XiQyVT0j2nNGUvmZU8wVKq66Q4NyI7hnXLXYZxQNPE43MCr7wksPWpxK4YVvIL5enbfOckiUWBVox+OQn3Olmds4+BDL3dZXWkfiJc6EwDLRO7rB5vEAbZUzdmW3GmZ59D4skywEJwH31aiDCplQpi92SJNyvWZclDqd4p7WPKy+VXuGR+6rXrp97lk19GhHblLf08ZM5hOW93yhrTcyY0QxCQViW+mXODA+DtzK42u+JBIMp2zgRn0ktuLLusk4LIiwyBL5NboFva/+x3yDMgEqyIsA=;5:TVhTV4TymSEtIgswZfYEpt9GxRiEbK//1Pdhf/AsQOlfZw0ncKsE6CVG1ZeQxWy9/MZFgI3jPgTby2A3vauQdCaN+6mtcX5RgEvLVpOvMJSmTedO3ffl0Fx/dFSdaS31x/mm04JxoOIc1K1LvHOZGYX9dXQDTw7CFCGRpSEGXJ8=;24:jfPAwqfnAiDqq8likvFJ6Q7gCgIHebb88zV30pZzfszGFj1EkEpWhAWpUM/RqAwMkSTR6nJeqtOx2417fqlo6lUObUEo3MvLp55qJ6X6kPU=;7:hQKx8e5SDukCfnWFx6/sqtAR2jW+bS5DIWaBu/HWhcxGDvJzLrjDQLMjfI1mdmUwpF3hua/q5G70QgockaBy854L42yoaZg3IpQDDhX2VPQcOJjbcw41IitFPP1yCnZTorJB31+cD8T+rDnL+Y5W04bQIDZ3vxtc45LW3aXNITDvrz9aKvIrogiWOzYgshf3GC7/Typ6x/MxStTXVKbbYrTI0bHQvianwr565CG9Smww0ispUtlnlbbfbR5OM+i6
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2018 20:14:52.6669 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b24bb3f-7bbf-4eab-8711-08d5820c9896
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5P136MB0009
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
 Documentation/gitattributes.txt  |  80 +++++++++++++++++++++++
 convert.c                        | 114 ++++++++++++++++++++++++++++++++-
 convert.h                        |   1 +
 sha1_file.c                      |   2 +-
 t/t0028-working-tree-encoding.sh | 135 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 330 insertions(+), 2 deletions(-)
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
index b976eb968c..2f864df258 100644
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
@@ -978,6 +1051,25 @@ static int ident_to_worktree(const char *path, const char *src, size_t len,
 	return 1;
 }
 
+static const char *git_path_check_encoding(struct attr_check_item *check)
+{
+	const char *value = check->value;
+
+	if (ATTR_TRUE(value) || ATTR_FALSE(value) || ATTR_UNSET(value) ||
+	    !strlen(value))
+		return NULL;
+
+	/* Don't encode to the default encoding */
+	if (!strcasecmp(value, default_encoding))
+		return NULL;
+
+	/*
+	 * Ensure encoding names are always upper case (e.g. UTF-8) to
+	 * simplify subsequent string comparisons.
+	 */
+	return xstrdup_toupper(value);
+}
+
 static enum crlf_action git_path_check_crlf(struct attr_check_item *check)
 {
 	const char *value = check->value;
@@ -1033,6 +1125,7 @@ struct conv_attrs {
 	enum crlf_action attr_action; /* What attr says */
 	enum crlf_action crlf_action; /* When no attr is set, use core.autocrlf */
 	int ident;
+	const char *working_tree_encoding; /* Supported encoding or default encoding if NULL */
 };
 
 static void convert_attrs(struct conv_attrs *ca, const char *path)
@@ -1041,7 +1134,8 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
 
 	if (!check) {
 		check = attr_check_initl("crlf", "ident", "filter",
-					 "eol", "text", NULL);
+					 "eol", "text", "working-tree-encoding",
+					 NULL);
 		user_convert_tail = &user_convert;
 		git_config(read_convert_config, NULL);
 	}
@@ -1064,6 +1158,7 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
 			else if (eol_attr == EOL_CRLF)
 				ca->crlf_action = CRLF_TEXT_CRLF;
 		}
+		ca->working_tree_encoding = git_path_check_encoding(ccheck + 5);
 	} else {
 		ca->drv = NULL;
 		ca->crlf_action = CRLF_UNDEFINED;
@@ -1144,6 +1239,13 @@ int convert_to_git(const struct index_state *istate,
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
@@ -1167,6 +1269,7 @@ void convert_to_git_filter_fd(const struct index_state *istate,
 	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv, CAP_CLEAN, NULL))
 		die("%s: clean filter '%s' failed", path, ca.drv->name);
 
+	encode_to_git(path, dst->buf, dst->len, dst, ca.working_tree_encoding, conv_flags);
 	crlf_to_git(istate, path, dst->buf, dst->len, dst, ca.crlf_action, conv_flags);
 	ident_to_git(path, dst->buf, dst->len, dst, ca.ident);
 }
@@ -1198,6 +1301,12 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
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
@@ -1664,6 +1773,9 @@ struct stream_filter *get_stream_filter(const char *path, const unsigned char *s
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
index 0000000000..71e8e3700b
--- /dev/null
+++ b/t/t0028-working-tree-encoding.sh
@@ -0,0 +1,135 @@
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
+	test_when_finished "rm -f test.utf8.raw test.utf32.raw test.utf32.git" &&
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
+	test_when_finished "rm -f err.out" &&
+	test_when_finished "git reset --hard HEAD" &&
+
+	echo "*.nothing text working-tree-encoding=" >>.gitattributes &&
+	printf "nothing" >t.nothing &&
+	git add t.nothing &&
+
+	echo "*.garbage text working-tree-encoding=garbage" >>.gitattributes &&
+	printf "garbage" >t.garbage &&
+	test_must_fail git add t.garbage 2>err.out &&
+	test_i18ngrep "fatal: failed to encode" err.out
+'
+
+test_expect_success 'error if encoding round trip is not the same during refresh' '
+	BEFORE_STATE=$(git rev-parse HEAD) &&
+	test_when_finished "rm -f err.out" &&
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

