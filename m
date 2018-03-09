Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 127C71F404
	for <e@80x24.org>; Fri,  9 Mar 2018 17:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932440AbeCIRhN (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 12:37:13 -0500
Received: from mail-bn3nam01on0118.outbound.protection.outlook.com ([104.47.33.118]:2112
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932252AbeCIRg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 12:36:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=cYaIW1SMnmycb2s39diWQJNRqs6euGJuoJLO3ADUzM0=;
 b=ky9R3wmaXt2QJ71FeR7onLwUzMTdc3kkhaqDb6WbpFM6+8PSpjW5KIYk4KvsTkaf77hLITFAvxi31b2fdYbwk9aBKuDE91b2ZurjPajp4nwNs24KJ7PdF4wsNuL1YAvWObPPac2Dimq/TK76KdfoZk/C10zSKUw/bwixuO/5D4Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from remr90mpm73.ads.autodesk.com (132.188.32.100) by
 MWHP136MB0015.NAMP136.PROD.OUTLOOK.COM (2603:10b6:320:1c::22) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.15; Fri, 9
 Mar 2018 17:36:11 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        pclouds@gmail.com, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v11 06/10] convert: add 'working-tree-encoding' attribute
Date:   Fri,  9 Mar 2018 18:35:32 +0100
Message-Id: <20180309173536.62012-7-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180309173536.62012-1-lars.schneider@autodesk.com>
References: <20180309173536.62012-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.32.100]
X-ClientProxiedBy: CO2PR04CA0119.namprd04.prod.outlook.com
 (2603:10b6:104:7::21) To MWHP136MB0015.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:320:1c::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e89f7c00-7ebc-45db-2bb3-08d585e44180
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHP136MB0015;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0015;3:XwjMusdooJARzeupAKlCdWDmDs9YbVOGDsvEGLt+fAvfzRkKpWIGeHlov2tIkd14L0s5NDA0NjaI9rZ8uJ2E4AiFIIcVMlkM6pY6SuB5ZOr5kX5j5f2ETHLaahjjCUQO0oz7A9QqxjjIGLi9Q2VGhcZMCVdfW8P0NC3M5k7bStzQj2yBHOUVuWjYg4djUEXEScT5d9Lb2FlURWNFiKNPLp8SsZhfZs/YzATM8HI0RvGNivN5Zg5avQifMvDxCQ5b;25:R1FsfVJ0xUk2UYPQW3FvfXHHrOLmQG0+5utr+dWCZY7R8umdPtl7PhY2QTQNdzxkTcH8+uXWB72IG3DidVU21x1kJrrzq4t9iqKTBR9Luy6e+qsVjizQGvawUTCilAALVH4zlQcyku4iq6XFzA5abWyPFI+Nnj3KkA6J0G4EOIkahxnJ042za2oTNa3o0PnPARIgeLyETt8HgXdzBtpXK/gNJbPcnUboAMyN+388qJgYBk5rbeQPgZeFP7Fv8hgvjyMTGVTTJTrLAkYF0pMXgVKaYJXpaOGq0CNxtBwp1Rd7PITsIzsm5LxO7NT+qunp2CAfJzd+ZinzV7JySpKliA==;31:K0WqwM322lOG9+vwFCa4N58HJaw3ArhoYVoXIVzsQdXstb9f+jyhJSXx6qhdIEgkjBBo5ANllgbSLQZT/h+1uVl9uuC53IEobzzDMIqKB7/6thA8T6FC1JzNJ5x2Rn7A5jLLQFJMBPVKzibD4U4IzFxifjXCdih0WQb0dD48w604n1by2Cp7M6ZC+TjSUj3H8WXtyUBL1PFPxTXZAmrlgo66Dl6ADSb+zR1cKu5YCxs=
X-MS-TrafficTypeDiagnostic: MWHP136MB0015:
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0015;20:iXoYQAjiDqtKl0FXaeR3cXsnj/Y1Er4FqEM9zyHNV0SBhsnLw9hq3qYws5hkw7t3n3mAwhQmhIs9HK3XOYaTvHm4rxhWe/GNn6/xrHpCk4UjZ/qPyiMb1LrHVcE9WMz6HPRho76/bzHmExhPpGGvYnpzyPVXZe2XdiV0s6eCEB/yHZtceTiUojqD9HYzvNS84zqQOuPLXBFwGrcSWH1IqjEtpOBHv4PSp1Lmcm32Q71GKI1lTpOo27dJKBO3ZYW3BDW4h4xZiXGE5n7COASTSliKqxaH4oJDH8wx0hzjnLy52dpeQMLE7xPL15DNH09OVId69c/1Xzjj9sYTlEuFOe/+nrLRkOuuPKsQSBPmEjOlNV2Hq2vTu+e1jZB4GmZoMr3U6H5z+G+bgBKvQMYbL4wgi+PhBtNI5PdxjDAUtMrDCKYykO4iOvzAeBil4VSBRPdiRdZhHkEpm8BcIi9yn1zzgwxRN/eZRNrvqjV4+9LfE9tawd2VWbAoGlSBp2mN1xQeZeWdSityoAagsZsTeE7zfqJgqa1znIsQ+OSxHPFhHVnXmO/V8wYI5C6x/b9aGqsoTmKMlQ3Jfy+o4tA30RusbFhyUA2ZmsoepAG+C1A=;4:a4HaHlEq6ZDQNq7SC4t3Vnlzt//7wA2IVx1JlzSnmDlxqgnZZGjWgojg5rW+tQdUea6lq/LQb7TNl9hQe/osHAPf0/jN0o1TSsv2uz34smsrzURidfUdR3iA5ALaTIP9TsqVMXxYwLDVXVFd5HP2XuNmHyPRjddgGqBMheqV25Sn/4R+gaF8dr6RxI7hdcl6HdHw41SXNLuvOnUpZrhx6F48M3Nt9CbHOHTTULb8Xopsd6x4Ty0D3iqFRPSdSJcuEtHJMekZ0d2WesDp5kvaflyHfH8pc1a4lN+9SFNUbWmKTlFulWGQsHnhzCp9pbpV
X-Microsoft-Antispam-PRVS: <MWHP136MB0015255AE64C8BC6DA350808E8DE0@MWHP136MB0015.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHP136MB0015;BCL:0;PCL:0;RULEID:;SRVR:MWHP136MB0015;
X-Forefront-PRVS: 0606BBEB39
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(366004)(39380400002)(346002)(189003)(199004)(50226002)(76176011)(8656006)(7416002)(5890100001)(25786009)(45080400002)(106356001)(51416003)(8676002)(2351001)(6486002)(2361001)(386003)(105586002)(68736007)(8936002)(5660300001)(39060400002)(7696005)(52116002)(59450400001)(4326008)(50466002)(2906002)(48376002)(81156014)(81166006)(16586007)(6116002)(86362001)(575784001)(26005)(3846002)(85782001)(316002)(9686003)(186003)(97736004)(16526019)(8666007)(1076002)(53936002)(2950100002)(36756003)(6666003)(305945005)(47776003)(6916009)(478600001)(7736002)(66066001)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHP136MB0015;H:remr90mpm73.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHP136MB0015;23:nmIBTl95JZNxxz1G3IvMIKp2Hkcp2GvUBwPM0e7Lu?=
 =?us-ascii?Q?xjA4/hEA6RHfQL7q6Z2bdo1SaXWcHeIn2Z4tt3ky+R0lQdmjXxlb6qJ+OrK1?=
 =?us-ascii?Q?9WwZehecSe3ij1AUclOzWv7kiOHNv2i7dA6eTN6/36fvOPIKrJJE3Hn9hChk?=
 =?us-ascii?Q?Rd0cBseKkbGbiC7RpYBm5AnE1Q0vjon4FO4xz48VXmwbBqpt/Zt1hUgDR65r?=
 =?us-ascii?Q?i2OhBCK2nSw+pZd3z9/cTL11qpIFaKm8zlXDOUOeA0S1s5XYt18qgWhZRqvB?=
 =?us-ascii?Q?BPnlGAvZSmtxzGV8NuE86dDdF82RxbvkNjyfOHvkU+aeaL/d5EV/z3z+8r5V?=
 =?us-ascii?Q?/EKq1F57J3imQ2pVzFt3SDEeImKBHQdi/hr1/6NUgQBS1QUTKV1/Zi0jI+RG?=
 =?us-ascii?Q?H9gViTQAHvB5yqRzt5D3+JW/ibXmMrA6wlWdmtLT26SbVv4noA8cfzXOqvhT?=
 =?us-ascii?Q?aoCVapf5T2HsrQR+0HR5YEAlO6nerIBN0uOct3Qok0BBKB+IT+TtzbI/WNYN?=
 =?us-ascii?Q?36Lu5h8CVID96LfLFoDPMqrydBDUmel845MHgk/EM6rPTB6u8w2MG6XwFPhT?=
 =?us-ascii?Q?h7TDxTHX7yr/Svh+citOrBrWPQqD5LpGQlp0Vn6YTNjaEYmUpVJJVGOg5skU?=
 =?us-ascii?Q?AeKPUzk1h+UlFQajmu0DZcRkaL88cEUfb8wlG7eF7b7lCrdjeqWn3hdG4ywV?=
 =?us-ascii?Q?PQtlUKOBtAfsFJCJR8JP2D9u24e9vuVl2Qmo9WHidwhlDMnDR+gzfmTqLz09?=
 =?us-ascii?Q?3qJM8o0ctonwwEb8p7Gf4b++nIXLjJEWEC2pNCSBmucsQgPzYhH7VBTPk3Y6?=
 =?us-ascii?Q?Ur1igScy8kW2+qB+T8Vf5kicT4PqRnwuzoG1eExmRSNj+GY7tn8wE/gTbphf?=
 =?us-ascii?Q?JzxKtZ9mGRL4FL9Flbj1kxsas1lhrKurztf4lD5X0Vu2Mhh2gpYHrNe0nlCa?=
 =?us-ascii?Q?uQ72aFbpMnN1q2dpKE4n67tpKrL64T34ar0fF69vXhGxEzv9VnHUXoAYakaW?=
 =?us-ascii?Q?6lOP0HMxf+OUi+bjhyUVXGilmv/eNPpu4KvQwDjp+YTDSXFpmj8Oer0eArG9?=
 =?us-ascii?Q?SQkfM7/fnq9koTyn32BMLRBVyUup0VDUUmQuo0wjnTvyhueDeN6NWdt+Iw+0?=
 =?us-ascii?Q?G8DiMoaCA14AKBOrDKooHy0M248WrSQNxKhGGwfAXwTm/MtXI+NbbJz99uqn?=
 =?us-ascii?Q?zzrsAZj1uiGounHAxF2R6QKvhi5SEaZIQQkIvt+S/WchPLkYYIW2v74/84jq?=
 =?us-ascii?Q?ztWAaNZtvkESBGDNupsX2QZU56VywTil6a2quC2Cg2fbRqnCRX0/aweFtbI9?=
 =?us-ascii?Q?W2um6BOV3QeZ8JDIXEUFDS2BKAbMqGYrM38qeG+eRRUxcTZk8nb0FKYQLP+J?=
 =?us-ascii?Q?H1qdJd7HF2EriiQjehI3YP61Tw=3D?=
X-Microsoft-Antispam-Message-Info: DpKPlIqgC+GW0rWG6X4DuG521z6+WgSlO0B8x70iguv4C9qumDOajWY/ZMgNFzKWahnWFeshAULPd2Wxm1OXZmquEQny0rkSbJDBkk9ITqpuAmwUJR4UTQlj64hAP2NhaibvmaX475vsGIw5+VKVjv6n4Eu2xCPHFQltWBsTvlHRF/Wp7DuPFy8s+ROV2Ky1
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0015;6:p3ou52mJtqvq2O2dim3Ti8X9uMUlN5gy5yzVlfpWzPSnpG6TFikxftpF0fi/k1ix2Bktp2RmrW0yEqs+Ubtpi7DUHWRUAItKh0XnlmVySgV+S+oyYi1y4K+LYOh7dbrOqNIt0wc6x/0Q35n+gkDkdalqjnQcZ12TzmmJzENKub649cEhLd71qvKsUYj+OlAlCGEyOlfPtI2CbqBP8pZUKtwdbCwx/8zTXl22d1DoQaqn7Q3MBNVoZVLwItiELf7WBnbG44jcc3TSevqjCPjGCt8rjka2ZlwutyKCToBiPrhmmSfdszss2gxHcIe7ATMgOWrXen3wlW568A9Af+j7Pm8ZQExk1370DZLH57tlZQY=;5:fUJpIc5gZpQN5emO0OVGamgTdMsqNoX+JmaF2s27YIyc3m3ej1DM4wsJnFT/ungu+mER/6Vjw7hcbijTO/FPRqFPlDRgbaC7ebx+xUMmf1xUZUS8In374oVyOh35wWUguVQmUmLdVMeJboIlR0vHMtbRZCjgge+XAIYFwjpJ/M0=;24:a/M0hPCaaVP7mOmSklHuPqqe+VdRb6xINn5c0iFVbwVU+g7PWxbn87WV0UjgnYFyMn4kWePySrjVjsBXjXyvDR7OGdM+v1VGCKB5d+DokJQ=;7:n77JVDPPGCEbJP28Dr/12SlgoEIL9zMmlnsrIZYDXAy2zKWaOiGG8VsknCFBk7ttNJtFdEcXCuZL+6tsv6nS/1aVtTT7wALiWSaBzCnnQux/JvNH9asDnCyq1COoGPJtC+IAnsdj93rMwWnkv7Mmo6exdrhRmi+6jJU2MJbxoQs7UizvTSw4hN14qgzbTEkG0NEvCZ30RmzFUXfRiJMOU6ToRMQaIFa6hgSF7YwHEdGe5QuUHLO6D1XNFxBSKFdD
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2018 17:36:11.1062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e89f7c00-7ebc-45db-2bb3-08d585e44180
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHP136MB0015
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
 convert.c                        | 114 ++++++++++++++++++++++++++++++-
 convert.h                        |   1 +
 sha1_file.c                      |   2 +-
 t/t0028-working-tree-encoding.sh | 144 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 339 insertions(+), 2 deletions(-)
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
index b976eb968c..aa59ecfe49 100644
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
+	if (ATTR_UNSET(value) || !strlen(value))
+		return NULL;
+
+	if (ATTR_TRUE(value) || ATTR_FALSE(value)) {
+		error(_("working-tree-encoding attribute requires a value"));
+		return NULL;
+	}
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
index 0000000000..e492945a01
--- /dev/null
+++ b/t/t0028-working-tree-encoding.sh
@@ -0,0 +1,144 @@
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
+	echo "*.set text working-tree-encoding" >>.gitattributes &&
+	printf "set" >t.set &&
+	git add t.set 2>err.out &&
+	test_i18ngrep "error: working-tree-encoding attribute requires a value" err.out &&
+
+	echo "*.unset text -working-tree-encoding" >>.gitattributes &&
+	printf "unset" >t.unset &&
+	git add t.unset 2>err.out &&
+	test_i18ngrep "error: working-tree-encoding attribute requires a value" err.out &&
+
+	echo "*.empty text working-tree-encoding=" >>.gitattributes &&
+	printf "empty" >t.empty &&
+	git add t.empty 2>err.out &&
+	test_i18ngrep "error: working-tree-encoding attribute requires a value" err.out &&
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

