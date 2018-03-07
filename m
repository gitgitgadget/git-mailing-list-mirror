Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40F881F404
	for <e@80x24.org>; Wed,  7 Mar 2018 17:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933753AbeCGRbZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 12:31:25 -0500
Received: from mail-by2nam03on0100.outbound.protection.outlook.com ([104.47.42.100]:59904
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933576AbeCGRbO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 12:31:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=RNdHiTP5XmF/5yeN33UabgJsG9b9R2kZTtI1CkXGgzQ=;
 b=HCpXAfaZ2G4/EC2KnWMFvzMVrRiPWdlSwp87tTF48ckqBG2SavIyUrOzEBy3xvrKmZEsqhGG534pmH50O2hyu359VLaYR+cSPCBH5oVd81OGXuUYq1syfDE8q4FCFUAQux/6uk2cQC3owH9GJwVt27hgJKbZ/hT9Ky/O2vLDY5s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from neu8r3hm32.ads.autodesk.com (132.188.32.100) by
 MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM (2603:10b6:320:1c::21) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.15; Wed, 7
 Mar 2018 17:31:08 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v10 6/9] convert: add 'working-tree-encoding' attribute
Date:   Wed,  7 Mar 2018 18:30:23 +0100
Message-Id: <20180307173026.30058-7-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307173026.30058-1-lars.schneider@autodesk.com>
References: <20180307173026.30058-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.32.100]
X-ClientProxiedBy: CO1PR15CA0083.namprd15.prod.outlook.com
 (2603:10b6:101:20::27) To MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:320:1c::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 24227002-8233-4e63-9c5d-08d58451387a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHP136MB0014;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;3:z3p4pYiXTOkV/fiqq4GSP7zS4FFyN310GDkiXSTpWuYQmSjyysYKpdn/9IK3jE+5mCS/0EI0xBPtm8nOOtm5MW7H6qGk6SShxjMDEv6wkhpk6d6hVkYOEGTNuMKJtfhrUx1yH30T4VHHsJXJg5883T/nNME8snHp6XgMDTXzXWZ6qjHfjDzDFCduLv+8NPXdGfbpKhBz0B6l9wLX9FiLIpoJ44F95w37zC+OwmAKeBQWB7VNYcESxa9/sCzw3qLW;25:LxqiPMEL1uLj/yMtqUyYEOI7f7tmWqiaZS9e6UjT4iOw6thzTZkk08gsO//IgSz6vsKxtBYw11YKACIlOXE0CRa/uNEBhY5KB0zngso5lQsNml5UVRpgJuIOGmjzV5IevaCw7ZwOtcM0vmwf2xIeGz4IBMi0o1tgEgrLJrBZZatHV0QVbLTI67maIc4W220xxRAEefrIhnp1LdTFdDvhaQKhZwBJpc/yf1o0h/xVl2dxCgBSE/Vs+p1pvPc0gkY8aHS3epT32752binSXeGx0xT6g+B21a7b3XzPvPsPzXNAsHGM/SDXFio7L745xRWcqccWOTyfw3tzgQLCk+5iXw==;31:yM4CFHogoy/JlaDxMnfLRskEXjJDwweYzkw1Ft+gW1ZYsD2aKD3Q3YY/G73oTLGzB9dA8ZXyeR9Mf0IxNpSEe5rHB6rEjGaT/Foecn5Q4X38ErMiNK40/u87jOZl+3ZiNaB2Cpn9ry9ceNxM4YkJkzxIhIkcN7g4uVwZsQ/u7wxkpxQRnvW8IPm8hRsJx82NjS9BNFCAkdMW6K4+8NzvxzKt/ukc9BNBmS9PeHcqc3A=
X-MS-TrafficTypeDiagnostic: MWHP136MB0014:
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;20:zIK26njPPBu8JjyLOiFkUGbuhtQ59CqT7oIoc2wPsq9p+JrUrMidq4T6onwhMhZu3r6TOrKPVZ5YRbxi6JQ09NzI2bcaO8YorZD7Z9688jtwcwDvKapJb5HqyhoCrbDhE2kpv3rNkHlxKXFvr9sfqO+/Wje45bnyBw7EqS8IKqR4JHVIk8ZvyOj5/oxwImWqtFjVUwv2dEC5jlLryELI1YhPbfr5MI6GZWOUnkgXHb+Tg5Ro9TJziAgySfiw9PZlf35UN9W1zF/JSBeLAI4ciygmOKNAYivToies+2J/oqrVBqz7XIMZrs6UBcKLnJ3JcblE3+poJYwUQXZI1b5+G8nIXE5zHMmUhUtJN4jtbM8giwTsQpTB137Qh5vd7KYkFbPBx/VgFMweQHhP9e/yWMPPFoz9J0U+n/CHPcEkJFM76AtuZDW5rrnFmihhvFa4Y3PeK93j67WIo7OpQfC8k+NK22+V8esHJHPgTbaY7zYZHzu0+YTKmJaSD+qxMuVg3/e/PiR2RsZhH1yqV9BTo46UqtnFJtYnNmW1uBGfzJ08zm7N7ELXjHXcFuwYUabuSYl4SDgBE9KJmcvZr2zgMDCyPblKNgIhdWKMQoAlNJA=;4:n20BQ8lRfxJHfssm2USp2vgjhQQ8KspXxwu8SqJMTiOONXaZI1skshIFyzy8ZCkHl18AD8GOdtntYU7NbXqD0J2jhFY09WXF1x1yo4jxMGyzIz/heduMq1SlYZk10tnLpzuL2hcaxr/U2IgWSii3yKbbgGoJ9RWOLpkyWEEe402wzXCFGeKxI30wuFE8OoO+v3bHZf88cCom+JrJXdOClex2sOJCGOyRaFkBh67GO7oKlY8Tnw2lWc2KFJrdJMkXc020IEDqRHpeQ1CeJBFq4is/KPnt7Ht0Mqya2M0r68NeAkdCqY5DTaFg1g0KWyKC
X-Microsoft-Antispam-PRVS: <MWHP136MB0014BB86091EDE9B1C1809EAE8D80@MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(6041288)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:MWHP136MB0014;BCL:0;PCL:0;RULEID:;SRVR:MWHP136MB0014;
X-Forefront-PRVS: 0604AFA86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(346002)(366004)(376002)(199004)(189003)(68736007)(36756003)(53936002)(9686003)(16586007)(16526019)(186003)(59450400001)(6486002)(4326008)(26005)(316002)(8666007)(386003)(8656006)(39060400002)(76176011)(52116002)(7696005)(51416003)(5890100001)(97736004)(25786009)(50466002)(2361001)(2351001)(45080400002)(105586002)(85782001)(50226002)(575784001)(86362001)(478600001)(6666003)(2950100002)(6916009)(2906002)(8676002)(7736002)(48376002)(106356001)(5660300001)(305945005)(81156014)(8936002)(81166006)(66066001)(47776003)(3846002)(6116002)(1076002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHP136MB0014;H:neu8r3hm32.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHP136MB0014;23:aiYnTuUVLAS/Qj9OZn7xeZrkbRhwONCGaV3h6oFxj?=
 =?us-ascii?Q?KSPb1xzSM+gi8W9LAj6B2M/zeAWwL7FgwReULnqt3KzHTj4OP8J+tBTYNCeM?=
 =?us-ascii?Q?byaA0aQw3d/lpbhq5XWfQGMFXjJywuWsDmxSJoGlPulVHZczYTXwcchDTXlS?=
 =?us-ascii?Q?H7ITM01E8exeeg3gDqdNAyOpO6i/sEvDcNgdI4pglYGqYHkL1DRB3z0pGo4X?=
 =?us-ascii?Q?ZkwJMKn4Hw1j1S9qBe5ozrv8VgSD5/WkcRPKTNT+CQ3KsPVKIKHSVdhV/i/P?=
 =?us-ascii?Q?9kGxSJqdG1XmcV2l6m7/fNDacVX+DSVEAR7glpmilyQDm2nPalamoYDZetPA?=
 =?us-ascii?Q?Lw6kiXmhNzzz38TDR+cVXYte9OUliRVtPJgPoUaXqFgvWsl0CrNMrAldpmAS?=
 =?us-ascii?Q?gBN1vE9wn1GSDdO8cjvIfxKw+0ZpdM28HVh5xQsEtmmkwFKDdBb6CpU2d84e?=
 =?us-ascii?Q?xoHiJgRBZ85ACi8EhNlkVeeE17fdYWJuMB/HPHDSb0TdubkKZAmsrQMI7g8t?=
 =?us-ascii?Q?HL/uFLYwi8rybZig5Vy7SYR5KLRe695qH9hysZ+SlMr/51DtMAzFBi3q8Vyt?=
 =?us-ascii?Q?gM6rDRlShbOcMTQFEdag2H9vbpNoEjYtmWCof/dcf67eu3v+QpJcRmbNwMGr?=
 =?us-ascii?Q?9eSAyBwznG5KTi0BqbXChT0fOAvMm9MIuBtk9MWUzw5N/kdY+E+OKPHcIJFf?=
 =?us-ascii?Q?mj4j/hnFwEcY9NpCD2K6KBn/NxVMvCE8HsFYdKG2vS0eFNSqFldlRBwI+Sb9?=
 =?us-ascii?Q?fQ0q7lHXhXocPjc0ZnpirblCoYHVCrexThhnv4SWXJIqNUsXaqIe3OgKvADs?=
 =?us-ascii?Q?CYA20OLLAgbKmgV9DcdfTGZV2RsUZeawHBh0Hri8P5JlgEufVHaRTV+DXy97?=
 =?us-ascii?Q?tKvEsVNxocMJej+Rn5uY/UFbb1t9DFRKdrYxWhVscD1R/0otmDZQOntvQuGf?=
 =?us-ascii?Q?60RzkTOoDeHRoQuiFNMg9wuot+Zs9cCZEIiKX1zVaisvNR7YA8XimnaKWNml?=
 =?us-ascii?Q?G3YAROLw5m0U2VN7XAvBPF6YuOrNdLIBfuGKMZu2uqCKfW9FTpHM258sJfM2?=
 =?us-ascii?Q?zAiAJUo4YwMavwAr56c7PGRXCM3oWkQ+xk3umrJYuiQ8R/3PUKaR+7jH9jRP?=
 =?us-ascii?Q?JfFp5NrOyJAZg1OrFYwMP2egwH59n4AxDSYn7JWGvWOGVLAUaDkfsSkI+m+K?=
 =?us-ascii?Q?V1BDo6h09SbGUgRmO1xmStE/tRMOIM+YiPMEZXBM4KZACoJ7DgVDW237Y+Va?=
 =?us-ascii?Q?CJn72/0bzKgkqKgzktvTfGKXv4hE+sYH3x/cLU5P6/8MEHV/VvIKgcQ8om+l?=
 =?us-ascii?Q?L/AEAOIhKeUQB8m+RaJHHnclRToFRsmaNK11NozPksCSr/TDlvPIowMoXEeQ?=
 =?us-ascii?Q?lGQJnclepdRiGWRDrmcmkJgskg=3D?=
X-Microsoft-Antispam-Message-Info: QKt7op6+2ym1Hc2QZ/hoJhPvdElPYlxjbdntvVrN4CvkRdEVZUVSAIKKRp9kVhWvCIjIkEPTiNaFpsk+5r7tZH+7s2Yp3X+rYcMSfYmxAZG7vIs9ewkmCdsNQIm88erUi1n9B9a3GGQNuBA0QelGp9vJgWkklAbI0Co9yq6fcECwpcB6RBlykEg8Wty/iqtW
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;6:qjMlEuTbkuyQ0OebZgtzpkEhVxb4Tx0YZB1R8Jsb6WEpeiT1pF5cbd+Ez9/NxbZA365OA/QHDCeLeM6p1MfGTmyvzrHUEfAgFTkg4cYuNwj2W3qHubB96Oaxl/mMO+X7FslWuw+T31GH3tHjTJm/9qh2mYMXdTcEIp7sG6FYiiq1Ab1N90Hy4q6mGpvnTRQg+K7jGOpfdLbZUUePMmoxyyHPV+Cf7oMyom/O1qaqnRbjWyxsDpWvRQDBTJA3dKVpYc6fj7Bb3S+jxiUwrJFcavU+txJuI2n01drR737bne4mdBP5DjdWf8RGA7e1tTLeMkd1gmYcUQ/fBlJuISkGxYsBPuA/1ld5MdaTtE2gyyo=;5:JrZdwtzkjhbrQpeTV1mAOD0ku2KIHVxDasDqC/84ep47pSo7r6MvTK5A4iguna3AYNog26OCg/0W0uAoP4VKWHIqsht808WguqojNFy5HinKLPwUth6v47nNKe0AMF4hPjDxhJahm6b3M2XArJaPjGDIVhd5pnYH4oKXXFyUgP4=;24:48jTPI7sj0V3ut4bZGS4qXELBzcQU4aNAmIxSeSlXoM83qSCY5CAntlb9losv1hr4iczbs/jXrpuaZ5mhefgvQrvqljf6+pzHI9OPu6Efvc=;7:w5WQMV4yZb37FGrW1Fo7gpwKH/SAMFBHUdESM3ab45aCYEWo7LTpM1HO3twNCbzAZ1poZZqPw/R/3hJMCojMWfOSFIsV3fNUKP/tR6C10WQmib6IocBAYPOpAzuyiFRa1uXMIX0aO/YhFKjYexm9eweEoDN35PYDbCO3KP7FUJr4R+lGeP+Zgxqp6ag6tZjYcqR1F/3cglVL38tscmQONnId4aGBLTPqhhEpIf7tSKmOjlkWjbrKXzjqo5HJooVE
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2018 17:31:08.7257 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24227002-8233-4e63-9c5d-08d58451387a
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
 Documentation/gitattributes.txt  |  80 +++++++++++++++++++++++
 convert.c                        | 110 +++++++++++++++++++++++++++++++-
 convert.h                        |   1 +
 sha1_file.c                      |   2 +-
 t/t0028-working-tree-encoding.sh | 133 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 324 insertions(+), 2 deletions(-)
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
index b976eb968c..80549ff2b5 100644
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
@@ -978,6 +1051,21 @@ static int ident_to_worktree(const char *path, const char *src, size_t len,
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
+	return value;
+}
+
 static enum crlf_action git_path_check_crlf(struct attr_check_item *check)
 {
 	const char *value = check->value;
@@ -1033,6 +1121,7 @@ struct conv_attrs {
 	enum crlf_action attr_action; /* What attr says */
 	enum crlf_action crlf_action; /* When no attr is set, use core.autocrlf */
 	int ident;
+	const char *working_tree_encoding; /* Supported encoding or default encoding if NULL */
 };
 
 static void convert_attrs(struct conv_attrs *ca, const char *path)
@@ -1041,7 +1130,8 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
 
 	if (!check) {
 		check = attr_check_initl("crlf", "ident", "filter",
-					 "eol", "text", NULL);
+					 "eol", "text", "working-tree-encoding",
+					 NULL);
 		user_convert_tail = &user_convert;
 		git_config(read_convert_config, NULL);
 	}
@@ -1064,6 +1154,7 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
 			else if (eol_attr == EOL_CRLF)
 				ca->crlf_action = CRLF_TEXT_CRLF;
 		}
+		ca->working_tree_encoding = git_path_check_encoding(ccheck + 5);
 	} else {
 		ca->drv = NULL;
 		ca->crlf_action = CRLF_UNDEFINED;
@@ -1144,6 +1235,13 @@ int convert_to_git(const struct index_state *istate,
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
@@ -1167,6 +1265,7 @@ void convert_to_git_filter_fd(const struct index_state *istate,
 	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv, CAP_CLEAN, NULL))
 		die("%s: clean filter '%s' failed", path, ca.drv->name);
 
+	encode_to_git(path, dst->buf, dst->len, dst, ca.working_tree_encoding, conv_flags);
 	crlf_to_git(istate, path, dst->buf, dst->len, dst, ca.crlf_action, conv_flags);
 	ident_to_git(path, dst->buf, dst->len, dst, ca.ident);
 }
@@ -1198,6 +1297,12 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
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
@@ -1664,6 +1769,9 @@ struct stream_filter *get_stream_filter(const char *path, const unsigned char *s
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
index 0000000000..89b4dbee1d
--- /dev/null
+++ b/t/t0028-working-tree-encoding.sh
@@ -0,0 +1,133 @@
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

