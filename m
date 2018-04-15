Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC46E1F404
	for <e@80x24.org>; Sun, 15 Apr 2018 18:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752961AbeDOSRI (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 14:17:08 -0400
Received: from mail-sn1nam01on0137.outbound.protection.outlook.com ([104.47.32.137]:55872
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752777AbeDOSRA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 14:17:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=L1n1fzLsV7HCW34E9RM1gAyzw8cP9E6eyBvLGKvyCEA=;
 b=nxvG5ls3r08sTUagDkrvtwPkmqOlK9kU5hLcJWUHfdRZIL2Wa/gCr21swUkoRwDshzsUCCnC4qjsbNX5240uCdNNMD2cXWVikRa921/YVqItFuerbNzwmDJD2Ei+9FwAPdn2PE6Hl/SlLUZQL2kC7ALlI1VJ4xmzapEdqdS04XU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from remj8gtty1.ads.autodesk.com (132.188.32.100) by
 MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM (2603:10b6:320:1c::21) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.675.14; Sun, 15
 Apr 2018 18:16:55 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        pclouds@gmail.com, avarab@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v13 07/10] convert: add 'working-tree-encoding' attribute
Date:   Sun, 15 Apr 2018 20:16:07 +0200
Message-Id: <20180415181610.1612-8-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180415181610.1612-1-lars.schneider@autodesk.com>
References: <20180415181610.1612-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.32.100]
X-ClientProxiedBy: AM6P193CA0010.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:3e::23) To MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:320:1c::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHP136MB0014;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;3:WToGtLC4K3wRBQ8jHLJIUci5Z5ssKMh+JbXkyEKfGyWkgTS4euszNLl7j7EqL9W2MMAF/CSCATHOlBJyOuD/rg02Lsn2zjJs24rh2jEqUwQZCPVFL2MTElalRpRFRe/F15bqDAitwh2YqROyZH4RacfyqP7dqn/N3Fh35Zjjhlu3gm0TdaaUpzgbmS3YomwYBV4sOWsJb2hRR5L3hGJX3Lvnf4PoFZvXehAZeIZO93InykUwhP8ULH9c6JhZ8p4k;25:KEZIDXn2JtfY+l6YSbMhanuGt8jx4IsiC3qxYCwSBYdUyqaWEMGuJOwvCnkn/rdopenhnscPZjvkRApys/MUwQplms5rmgZzNMsT9ql8gUbGNfPn8/tHWXxyPwRvPiJyqx59ik3SLgsT24wSJ8dhmAH2Vjo7LBmWsnPgrZB3Vm7SYn+PLQa+scMVgAds75jcVr7HOmxy17j6M0iwirxMiCCJj+DqPeSgdJQAN+P0SbIWbUG2SxFN5Kk8RX7ZoPifoMZ4oRPcXkHtd2/XcAlZzpmolFUzfaRXWFftPqP3wEYg/UIqQcczxluI1/ClHPulEDKH9mxRDKaBedcR2/RHcA==;31:+4B04IJNL2YcHdg7FuU1noi7RTcmPQM/sbJPFx+JDdU6yEO5Bp+6auouN51OsKrAfSEfRvW/c9FWP9pgqlP0t79Yq6bCsUPk6xS1t10UQQtG8KGmn0M7aovVw+lyrbrKHDh0GnT4EmE/O6+i42KD3nEm47FK0dNYwamZnNKNZyMipQcB5gdeYHkrCsmAAgj3qrWitAYsx5epupzb3OV+qHmi3g15kkPGYrO91ofuGEY=
X-MS-TrafficTypeDiagnostic: MWHP136MB0014:
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;20:9h5c0TfN80Rq6gVbB+3qn1g5drJJKR5XqeBqsL8q40L04h1HA+K0GV8LF8tiDoQYt9n4vRt/UUM70IFIi+70mJmq+jS596STW+CneliY08Fe5td9UYNIaU5IF66TEJMQy+mRVz465nBeJVGhRWophYAAoWNDdSGpqVpVYSKqGshnTT3mir1fkhP48OcpE3vvLJKmnKIXk6xV7qNM4pIcvi+MD303XVzyHQsHfTmGJw1n5et4YPcwnC6lQJHxBOPHnozWTAL0Ay5qm01BroLIrpUXLtxve8Ul/buTdOTO9AwgjNs2CDvPOg4cF3XB8r/HCIgjsnpANXo2XtsGyrYdyzqP41u04eBu2e5XWy+f8ew02FuB1KBsvyNQ9iigGMH8/Xf9eaJs+6w2510D3gaznYB8cKSZ9tSsc7jFBkDMOaRNeBGaxzjIm2ndPSqjXVOIgix/dW5ygONtkwHqmL02G0D6oVtSy7iDwan9FJGKwH7G1os/zQm4WiO8p0WbcGrwHl81lgE+dLkZ4EqIfdiERl2UT8spc7R8lJIj04l6Nm62pWYXP0oxt9b+Z6j65e/LX+cHchWMBLV5Z6IzivYfs32JpSWZD+R0YAFYi3d93O4=;4:Q98HT8toSW0w9502/hiWlw4DinvpvB5nLmzSJbhfykQyAGMjwVQXE7Awkg76Cw4cJ1sqT0ivY5vULv4wQeJJEw5D3t6UgS5fws8hp+XWp1KYYe4umOSXUx2Vu+ac79y9cbT5Uj7UtT4ranP9RVbU8/Cwhs3T4scD13LyNs46vGthGsEQwfpjah1dz6FrRfOW8B92UctBf1Xca58RL4AOX4Qin/D5nVy1uAUluJO9M1hSz2xlZUFQJ2cEJfu3SdE2F8bAIAIelY+yMU0deS1GmG/hnMj7Ww9ixFZktEnM00wE8jB76SH5qZdphJDuyrdM
X-Microsoft-Antispam-PRVS: <MWHP136MB0014140DAC81CA7F6984321BE8B10@MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231232)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHP136MB0014;BCL:0;PCL:0;RULEID:;SRVR:MWHP136MB0014;
X-Forefront-PRVS: 0643BDA83C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(39860400002)(396003)(39380400002)(189003)(199004)(53936002)(86362001)(8656006)(7416002)(45080400002)(9686003)(106356001)(76176011)(478600001)(52116002)(7696005)(51416003)(386003)(6116002)(97736004)(446003)(476003)(1076002)(4326008)(5890100001)(50466002)(26005)(575784001)(68736007)(16526019)(186003)(85782001)(59450400001)(486006)(3846002)(36756003)(48376002)(2616005)(956004)(11346002)(105586002)(2351001)(50226002)(8676002)(7736002)(305945005)(39060400002)(8936002)(66066001)(2361001)(81166006)(81156014)(5660300001)(25786009)(6916009)(316002)(6666003)(47776003)(16586007)(2906002)(8666007)(6486002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHP136MB0014;H:remj8gtty1.ads.autodesk.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHP136MB0014;23:z2YkzrP0D9cfuHKbAWTmBjxDy+uNmNvJDovwK71kY?=
 =?us-ascii?Q?u9gAxyECx1BSj2Rt4bmLNCxxK46Q5TRc33OVbzS7ZtSQLXqEaD17T3N2llLi?=
 =?us-ascii?Q?JUXVhmcssh3CLv8l9AjSgffHOsLADsS7H4xcEtLDs6Pzv/p5vgBQwdX6ZlbV?=
 =?us-ascii?Q?78b/lx245ZXE8SClsE3lqvwmW98OMrROfCwHoE1bH2Em6ulP34yboyIdHymr?=
 =?us-ascii?Q?QMfmQ2U4wJ8NbUAxgHFxxc9MTsflmh5aHMWj9bEWLgKp9q9nV8rLg4QOx0E1?=
 =?us-ascii?Q?fHocdy0z6zUluXT0YDG/qimjoTE8QJFvNWZHslQskJN+3bge2AUnEfvzvOyf?=
 =?us-ascii?Q?GacMyfKAB71pWhcxROkOdOEZsURyF1Y+O++3+BV+LBX754kga+oW4wH05AiV?=
 =?us-ascii?Q?4UgYop284maGZn28EVFIAOUAaqZC5TKJLWiaROZiHG9nwzGB83fTfE5coYXj?=
 =?us-ascii?Q?Q2/9NQLV04PIBHN+NAf4+URFD6TQxIuy+dcbZvCKbWfnWZRYSiIVSL7Hbco8?=
 =?us-ascii?Q?778r+dKuNLoYZ4hW8xXyvvecwOCtiv3h4YEIAQHpPAfGUmWtfMaLylg1ir8k?=
 =?us-ascii?Q?GpRq6biWcu7+FxC8b12mbLfOUXEmapElw/916B/KZ67cnUKkRQUkXVPos7JF?=
 =?us-ascii?Q?xDOv9xELhc72GTdoAboq0Fbjv52yQPLVVvwxT2D4PGgCjlr8Cl0Tviu77NFg?=
 =?us-ascii?Q?wrOpURX7ELgYElVDF4tUtDM2ELDEsqvcJy6LTM5Kkl8SQV2OcvdPxl9tmVx6?=
 =?us-ascii?Q?0v1FbiJBn4zC3fT3mlPyd01OjpJqnb6oSclcLdIkMphafm8juWgdul4ss+rf?=
 =?us-ascii?Q?ylEp5Rt5r5ge8/XwSkVMGVIutkB75A2LpJKPmz7Lda8oF7VeX8rdzam1O9Di?=
 =?us-ascii?Q?vA9GdJY68XIn79nkCOZynksu2o+Ui/3DOwXMHSAYqsArrTlRiZKtO+YNykTG?=
 =?us-ascii?Q?/Clwir8Q+oGzu2fDLdLD0WVKHSPhAZYBRFd18wJbepntZyC2C223r8tSkssD?=
 =?us-ascii?Q?wguRBkyDjiak0nF04coThqdXrxHCsSWK0vXpOqF40OGScARH/4VbbuWJa1gl?=
 =?us-ascii?Q?wqzeWbUBWVQzNq9YYg6ZwR+Ff6rIOGvNfAvHUKSKT+B4UsrAvMlECOiMm8Xy?=
 =?us-ascii?Q?hmRiZOr8sgIjdNrWy7o90l0qo+NGavH8m17AACs6bMj34E2toXgpPlEolIIE?=
 =?us-ascii?Q?/xRBXcf5KnUzeztbz0iX3lQPCv8svKlS0nkJ7l+U4L9+lI4V+P05BEkMU02L?=
 =?us-ascii?Q?EIz6hKG1Zjyy590iNrFK45GQxLdwwFJ5Itz+fowQGNw8lzIsaHuvfwD+ahWK?=
 =?us-ascii?Q?uktYM9r9rNod2EztAcRBL6USHoN5HoccM0pQpbtSYSVF1+2Oswo0gR6ZU0Qu?=
 =?us-ascii?Q?UjKsTN5qeBQUPc3LTGfopJrOuXAfXaooWRS4lI7XM0/cq0fAlM7W3zm7xAAo?=
 =?us-ascii?Q?7q4ojiGEUD8nEhzF0krU5odu/Cy6GtmaG9RkWXio3uf+I+VWupW?=
X-Microsoft-Antispam-Message-Info: rAr6eXpGuknO6I8FHLOuymNXhv8pBRMQFyjp9fgiYZk6ZbDqbnUA2W1iI88bfroSP+/i2vRnUaASbs0hLL0r0iVkz4DQicfw7T2msbqanp9aXcW7VRTd89ZcJ4kKctEAwXBMdymns5tryOundCsV/E02pmBm3qfBks07c/IWkqfMlMZTUuU3BiXs1QgDE8tj
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;6:cTnZv7vFY6SvGr2PO9yt7o+qQ5zICBqcgJhaDZj9OBrXOG+AcqoEdmIGNO0R3qhRTSnYtpTpXmFM4RBbIe7gXHwVveAdopsMRFpLGWdBRCCWxm4Ko3J6SAeOl0FJetTMaAnWF7hRCSadenZJo7t++iyqn55zNKBVN36Kpx+VjWO3d4FlSkXKMOhMCip3COXI6INIXEbL970DYvsqIc4QZGS8EfoUxFML8MI3IccWzABFvUX95oULD9dZTq+aDQO4adTROmTQs7ugxLh2k6n8mSuQkqknAPrWxaR2RXOs7rvuT3VWmQn5DvfZspoz7+zOyYrox0bJI7573TiWwiroECUWU72gAGiVKr7ouPye/6Zs1wHlJLjtc0+IyR7QU9X/uGKBMvktLuig3DuaXUDn4uM2K5m1T+yAP5JYnS5rKqEJBqkC2sOn/7vAlTjFwNX35Ri862IGZ7/7lo6gyjGmnA==;5:hjUxbW8D4TsAVNNUotLTTcKN4SxoznJb5lKkgktcTun6+JfcPZzXWIPOaBqlOlhtuPmF+XC1sqxtdxJZstLgKPSRvsbeJE1j2JdgHKea8sg2x5oOsZjnWocvOsN523FF9gPbRPTnAPbCtQYFx5pwviPfPUiOb2gj47FjujkaNkE=;24:aueglqCDdsQ9roInhZwtJEqoPS6LgvcA+LNRwCZyIrGQ06UdO5j8vArPivFJnFAXX9gZQ+wGmE8AaaKM9Y9ec/fNNKtMS6OwdRDu7Ke5QP4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;7:j+2NzMFlT69SZfPmWl00o5K18ne/steUc7+xyK6RcVHYwKFc2IT+M/UgVsMTezRJke3cqfw8nUAI5VTU32F1OynqByJz6+NDrDQ0puq2q8mzMfR79EutlFIlNuHugOYqkyn+YesW9f4voXR4/u19tApXUJwuukZ68o7nkG+5IpoK/MQ38B61oi+vNsmJqadkTarJJE5ks7bcUEz+Zb7Dg4XtNNs5w5RVphLj7tZdQQbbZJB9vJve9/kcILHVQyBY
X-MS-Office365-Filtering-Correlation-Id: 74b9b948-1135-4eab-9331-08d5a2fd1395
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2018 18:16:55.3662 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b9b948-1135-4eab-9331-08d5a2fd1395
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
given file. If the content is added to the index, then Git reencodes
the content to a canonical UTF-8 representation. On checkout Git will
reverse this operation.

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
index b976eb968c..21d5cb60da 100644
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
+		die(_("true/false are no valid working-tree-encodings"));
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
index 0000000000..8e574ccdd8
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
+	test_i18ngrep "true/false are no valid working-tree-encodings" err.out &&
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

