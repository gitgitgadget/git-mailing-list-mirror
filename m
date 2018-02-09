Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 003781F404
	for <e@80x24.org>; Fri,  9 Feb 2018 13:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751093AbeBIN2u (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 08:28:50 -0500
Received: from mail-dm3nam03on0137.outbound.protection.outlook.com ([104.47.41.137]:26450
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750924AbeBIN2s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 08:28:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Ib8AjYgT11xCGPnlEQENsWnYnmtTkM+3RQTmn/qOL90=;
 b=aNq0gOElo36OKAx5TFccPHWb+949E2TJzDWvp0pdqOHAnxpkMw41VbfL+XGg9whiWjO2V5YcUNqam+SzAVmEZM9ezu94P+QfcMyZyLW6IHEnHeCzVmIY5u4mwgmS52uYqLDcJYESA13fDZJ6rYbaLkuqF8knp6g/miwjyPUMau0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxbook4.ads.autodesk.com (62.159.156.210) by
 DM5P136MB0028.NAMP136.PROD.OUTLOOK.COM (129.75.96.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.464.14; Fri, 9 Feb 2018 13:28:42 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v6 0/7] convert: add support for different encodings
Date:   Fri,  9 Feb 2018 14:28:23 +0100
Message-Id: <20180209132830.55385-1-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [62.159.156.210]
X-ClientProxiedBy: DB6PR1001CA0018.EURPRD10.PROD.OUTLOOK.COM (10.171.79.28) To
 DM5P136MB0028.NAMP136.PROD.OUTLOOK.COM (129.75.96.155)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fc71de55-341f-4639-fd2c-08d56fc10b5e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM5P136MB0028;
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0028;3:43FrzsIuGG1L9x38sZktx0m8UV5skNJUKfVpN6mrzJ9eTJMMByWRD6HpN2U7ItQmMapTnFFP7mFHsm5y3T+K+Z64KxhRZ3ZdpOim5er0JP+Xr+QPBLV3fjE72pUX06F3ivcL8qdECRL+DYg+IfPVTPwlhMESK+RrfUhk8hs0qQaupbtUKUcrc9qNAYh7ZPoxMlVH6FGx1m1ZdUz2UY7obrkqkj3hhcRflYJ7fDCtMHtJ/o20afqCCT2itZfuN594;25:yq1jTYm5hHpL10gou/DsmtLHdvn76PeeC/A0o3fdmYXOj3c0mwYK7/TOSu+MqlN8mODLfAARjMPpQXNwEDom9GoExIAKq3OmjdTFCLDHkOSyNjVqmFuahpB626xRZ/e/KtMTN9LOw98AIaXY0qMcV8gDLMx23KMA7k9XuLV6aDNN11wqqeBLN52img9SKoY4fDBu7oAqeytvEFerxbNpyQ0RCvANzyh5LtRqtneAbORrffJRpv2S+lJ74h6d3obdIoHNTm+5fAR0065SeijV+pmRlnrzmaKGJ0963t/x8W6FajrAbbpV0tWlTCpzPbRw03vHwjRyws6wmXYY5JlUXg==;31:HY3+71YlpWwCUrBoy+r9k01pLHReSCRD9y3kj1sKOAjbQijYTrqTD79pk8EsmKKOTtcy9BdyalfTdrUpTBJD+YNWgisQVyhY8E7yJw+qPB62Hc61nNvvWzj54unrv3JXEampAXWzckOsCp1M2UgCpzF4QE5GhHCCaEtkr303cT/AMsUB8UphAX4laQvGaNHuRT98E6ZrQSM035MMyGkCLlZdfjtoz8ZPZwbJiqxmoiQ=
X-MS-TrafficTypeDiagnostic: DM5P136MB0028:
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0028;20:rZkYE7/SvqMv1BIsfMHoGdk/xUGaV0ZhuYs6KMMSH+XtEcR4CsYngvO2KyANaY9xCNKtrlcyd61ZIRGoVNlyvynjMyVCHyL3eiTI6+e5GBMrRdcMwe8YWEqciCCCLNZ60SZgub3ez53GfQCkeUd54qBH1eOIwAsytOii6MD/PdftFSWcwnx5HDSpi0HA771CL1xEBfQMptQDsifW3ay5n4lkDkrrkPcKYRa/sUs9cBhUCwhXcj4Nx6S/Wj3B1D1jbF+MS/dwlucmZL1Rk5T18o2nQPnI2jEeOYLabXY4d6qv1oFXcOIq0z6HpEe6Hw81i9exYpbqwPemTYWOyFG5QtsYyl5252ln4VKTW/jazTx0W2A/QOV0CAzFNOy+JlUACfAUkUo/1k6+EmZ3mWwbje66nhfZkS/SalRevmzORY2Hd+jlbmy7Q+q3x2YuPqBDVjoH77wbCwIR/tEPIVmtwZtVN699SGNb+0s5DAOv2SYKfXxeHEha5lqrplk5FhAeYdBp8yhIVZOpo3p2ve6aWOFRNDPE1kUMsR0poLbpQfQHNC5TLPyGhAyl8V9lTh1NBJjs5ptW7iFXkb5+egQYB7DI7zHw4r10kfHS8/pSKfA=
X-Microsoft-Antispam-PRVS: <DM5P136MB00280926411ECBB82EE7F6FEE8F20@DM5P136MB0028.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(166708455590820)(85827821059158)(245156298449039)(61196332173343);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5P136MB0028;BCL:0;PCL:0;RULEID:;SRVR:DM5P136MB0028;
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0028;4:GNywaOYLOrIpLYAj5yfHyXjZK/fKfj2Qa01dkZkVqAGPnRE4a1yDl8VU1gpQSPPWozVsDFpHh6IVWdyfa7taugKYRfWbZcEV7IDiStcX0mAMnz5FNax+HeLEJ0syoAYxq7F3BNxhxOnHh4tM7WzfUFAdc1uHhY3kGap5dZRi8irTZFSD/O1P8Zaz2S5o+SRnfUoOyOyNgFDYQHHoNFNhh5o9if7Ft06Kr5FMRACOGqD2WT30j7t1T/8uVlKf0JhsxbKjHyQcTEaysx0bbmsjEczcbmkW5NdNfcuda0zQVUFFFxCFaItItNrRAX8tHVzmjKoQQ+L7+VEJmKlXO+3VpskN7Z7EYPofOaGm2mV09fOCQN915y2GHshgW2oxAFVpLpAchM8l+tMsuUNdX9FTrlS9pR9Upkyotfw3u7g7vstSF6d3boP6IbdLAWMewwNTBYxXyxQfU0jEsW/H9dH8gw==
X-Forefront-PRVS: 057859F9C5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(346002)(366004)(376002)(39860400002)(377424004)(199004)(189003)(97736004)(68736007)(26005)(2361001)(6116002)(3846002)(106356001)(2351001)(478600001)(53936002)(966005)(86362001)(9686003)(1076002)(2906002)(85782001)(6306002)(36756003)(8656006)(50226002)(316002)(105586002)(25786009)(52116002)(7696005)(51416003)(7736002)(575784001)(386003)(16586007)(50466002)(4326008)(48376002)(6916009)(6666003)(8936002)(81166006)(59450400001)(47776003)(6486002)(66066001)(39060400002)(53376002)(8676002)(81156014)(5660300001)(16526019)(186003)(8666007)(305945005)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5P136MB0028;H:slxbook4.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5P136MB0028;23:aUVeekj20HZZofJoqT7zNmXGW2O4K4n6tydqdBl9V?=
 =?us-ascii?Q?Ih54P11kB8g9+dC3KI5WxAWPiRESgPBOr/XbrOuvnRjqZuwtPH6inGEcbHnq?=
 =?us-ascii?Q?p8jrIsypYzmKeRkEO0X90CTJM/f091bRWcU90gc7Eoc3ddCgcNKFiUHuUrPI?=
 =?us-ascii?Q?LHknTBqUXzeIHhV266ujzfY/UJ04cJkeAwN7VLaLujyLUnOBa21bauiWUPWx?=
 =?us-ascii?Q?Se6hBtHjQx6L+/Zu89/q913FcljZXjZj5WZ3bLGaFaFiFncx/6K9WsJuGJTa?=
 =?us-ascii?Q?zIVuLUE/+T+enrKWEHUZ3n4mesyg5zTLSK2lvhkfL5JBnFMioDkvSt6YAaGI?=
 =?us-ascii?Q?V5HC7F2aYaNGRUkld8Sp8IMl1oPwcPyeeZ47M76xBdWUxy5/+zAcWg1vxd7R?=
 =?us-ascii?Q?VhiNY8zdv/GdqoxYZgbDM8Qkm64X6gxp96be3p3oxiPqdWTfrCjxfXquSXFm?=
 =?us-ascii?Q?hy+nzp3WrSqOBI1cPRlOXtL+I2kmmPQZ+rkAYVy0FigShe6NvK+F27rTaqpd?=
 =?us-ascii?Q?Uj5nc3yGZeVs8bLk9/obss7pzuUD4LrwOsAMHWyoDs+bqQg3Z/XGCkmSLiNj?=
 =?us-ascii?Q?sKDYQ0Skd0Cma1F6s3LQkk/BJRHt1BocDF7INFN1rn8ZPwl442RZ9IyNGrqg?=
 =?us-ascii?Q?zu71gJuAC8f/lK9vwpThhJcuadGrSF93HZgSH0Vur7v+/DXUfY2aT93JpryU?=
 =?us-ascii?Q?S33ZWE1HjlSn+xi3yBWHoEGpyCFwTfOq7aXK+9l0ucip7mK0ueQ3tVapCEOh?=
 =?us-ascii?Q?ZNCOARJ6ihls6K6cVKpxJFGq3nvZKZQNzy6vy5qZOOAQd4eCZCIJMOpfHvw2?=
 =?us-ascii?Q?fRDIz/Uu+wkT7ibO+mDpkfjWEYB4baA1B40OmZjNNxeqtiS5Q2MI409J5hVh?=
 =?us-ascii?Q?WVl9YoaH0DwALF2HaYnpGqG2rUCalEjPF0bWdMgRNUhC6+H20P10TxmSF/jP?=
 =?us-ascii?Q?Utl9Ozn24eFSOeiL4H9mvYpDRJ7RIr8Abq5bXhrcLBD0nsA2lQmIavJsqfqQ?=
 =?us-ascii?Q?jmI0qVqPSXph6O+ppIpf8IC96Arru258lM7PHUObwqUY64gW75EWbkCbZjmN?=
 =?us-ascii?Q?s827+Ect0oNxj3hkvkYQiAH+LBQUKQZYEuv6GYZVC5q/NrSHm+9vc+Ai31wO?=
 =?us-ascii?Q?Lr7mnoCi439HUX33g62iphDXRB4iVYC41seHMhaeJG2dRzIvnBwVx7jHzw7m?=
 =?us-ascii?Q?XSYrHwgI9WHwKbGIY4KsL/HTsf1bFBMpPQDkNNKSzfDSanCrPaA/3+fbRke7?=
 =?us-ascii?Q?mAgScbGU6tGJk0p0fhLAmtL6d9YIKSAQJdvRXwLBMkRXyhwRj33DM/6BnGrN?=
 =?us-ascii?Q?OA94TLl4RjIoR2jV4PVJV2+9aCFh1ke8/gegAjfgLKEj+mxmHfOXbD8tpz4P?=
 =?us-ascii?Q?Nl9pw=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0028;6:Qjelc0quudVr0wYOCAr3HUt9kWcovMzzRe/Owku9a6NpUvjtEl+rMDOtdfsUNC3roMZs5XkCZIqWnaHzzlZwoVqXcTnwc0Sx78eUXS/Eyv2nJJluZ+WlmCDIXJQ4gcYxV5D31FUgr3nj0YD26phlCF2j23dI6PGAz/Y/jFYCMaYQWBpeDxNrz0hot3hoTEo4pjqkh2GnsMDF/7SxIxlRETarCnoB0lJHDwpKEy74pMoBuOp0HfOug+N1CKROfR1M3tLpxzXWyOQ1JdG6PdLQ/CK4dzL56hOilsTObLV7YLa9kpkAKX1Cq+7FSNiS5FHgDA+hYndidgWaFsSilJ8d4hBzCS/Mj+8N+XoIBYUFH+w=;5:u8TyZrFcFMve2B9VXIntUa5loniqvZQeHbD5ScgjAWJmSZVBSQegDmCVs100jhHWaDIinDoIzC/qQHv4iMjCAT0TGOPP/y3Ga/9mG7AV4VnjH29Ff+WZGNmIj2uNsaX6+h0BWETU/curF3MDouqXsrsDBjPSmRl4TpCS9YMC9qw=;24:90Cm/qhQayI1p1kkBx/KW90nWaPvtQsrINs+oWHq/bok+c7fZslSMQCRiB5ZaiEsnWXalGsWD12c8sUNR8N8vpSZ5Q0f/K5dPi5uvAvcbzU=;7:r5fOfWq2482VW8w12LyMRLiyAUuA0mPooZUPJCZEefFkXOpB67N4itau6ga4rvfba6lGUs4J6vnnGN6esjkJ5nTK0wuyOF/vFlw978z1MBPFZSrii20swt0po62/YhRzwc61W/KTbBCYASBfJW2ITojf5whN6AKeTC5oh9KNffOAi909NXmfcKWlcUcBsKbF1Ule4Rp0P6Mg/SskwKaCxYMCH41B7r8KiWY26fIXCJpG4TyWgp0bGqZJP4h08q1v
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2018 13:28:42.5438 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc71de55-341f-4639-fd2c-08d56fc10b5e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5P136MB0028
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Hi,

Patches 1-4, 6 are preparation and helper functions.
Patch 5,7 are the actual change.

This series depends on Torsten's 8462ff43e4 (convert_to_git():
safe_crlf/checksafe becomes int conv_flags, 2018-01-13) which is already
in next.

Changes since v5:

* added 'core.checkRoundtripEncoding' to let the end user define a list
  of encodings for which Git performs conversion round trip checks
  (Junio's feedback)
* add a test case for round trip conversions
* move all round trip related changes into a new patch
* rename has_missing_utf_bom() to is_missing_required_utf_bom() (Junio)
* remove dead code in conversion round trip check (Junio)
* use *.proj files instead of *.txt files as example (Torsten's feedback)
* recommend explicitly setting the eol attribute if working-tree-encoding
  attribute is used (Torsten)
* improve test case and check that 'git ls-files --eol' works as expected
* rename variables from checkout_encoding to working_tree_encoding


Thanks,
Lars

   RFC: https://public-inbox.org/git/BDB9B884-6D17-4BE3-A83C-F67E2AFA2B46@gmail.com/
    v1: https://public-inbox.org/git/20171211155023.1405-1-lars.schneider@autodesk.com/
    v2: https://public-inbox.org/git/20171229152222.39680-1-lars.schneider@autodesk.com/
    v3: https://public-inbox.org/git/20180106004808.77513-1-lars.schneider@autodesk.com/
    v4: https://public-inbox.org/git/20180120152418.52859-1-lars.schneider@autodesk.com/
    v5: https://public-inbox.org/git/20180129201855.9182-1-tboegi@web.de/


Base Ref:
Web-Diff: https://github.com/larsxschneider/git/commit/9e31832f3c
Checkout: git fetch https://github.com/larsxschneider/git encoding-v6 && git checkout 9e31832f3c


### Interdiff (v5..v6):

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0e25b2c92b..d7a56054a5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -530,6 +530,12 @@ core.autocrlf::
    This variable can be set to 'input',
    in which case no output conversion is performed.

+core.checkRoundtripEncoding::
+   A comma separated list of encodings that Git performs UTF-8 round
+   trip checks on if they are used in an `working-tree-encoding`
+   attribute (see linkgit:gitattributes[5]). The default value is
+   `SHIFT-JIS`.
+
 core.symlinks::
    If false, symbolic links are checked out as small plain files that
    contain the link text. linkgit:git-update-index[1] and
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index a8dbf4be30..ea5a9509c6 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -283,10 +283,10 @@ visualize the content.

 In these cases you can tell Git the encoding of a file in the working
 directory with the `working-tree-encoding` attribute. If a file with this
-attributes is added to Git, then Git reencodes the content from the
-specified encoding to UTF-8 and stores the result in its internal data
-structure (called "the index"). On checkout the content is encoded
-back to the specified encoding.
+attribute is added to Git, then Git reencodes the content from the
+specified encoding to UTF-8. Finally, Git stores the UTF-8 encoded
+content in its internal data structure (called "the index"). On checkout
+the content is reencoded back to the specified encoding.

 Please note that using the `working-tree-encoding` attribute may have a
 number of pitfalls:
@@ -296,32 +296,38 @@ number of pitfalls:
   expected encoding. Consequently, these files will appear different
   which typically causes trouble. This is in particular the case for
   older Git versions and alternative Git implementations such as JGit
-  or libgit2 (as of January 2018).
+  or libgit2 (as of February 2018).

-- Reencoding content to non-UTF encodings (e.g. SHIFT-JIS) can cause
-  errors as the conversion might not be round trip safe.
+- Reencoding content to non-UTF encodings can cause errors as the
+  conversion might not be UTF-8 round trip safe. If you suspect your
+  encoding to not be round trip safe, then add it to `core.checkRoundtripEncoding`
+  to make Git check the round trip encoding (see linkgit:git-config[1]).
+  SHIFT-JIS (Japanese character set) is known to have round trip issues
+  with UTF-8 and is checked by default.

 - Reencoding content requires resources that might slow down certain
   Git operations (e.g 'git checkout' or 'git add').

-Use the `working-tree-encoding` attribute only if you cannot store a file in
-UTF-8 encoding and if you want Git to be able to process the content as
-text.
+Use the `working-tree-encoding` attribute only if you cannot store a file
+in UTF-8 encoding and if you want Git to be able to process the content
+as text.

-Use the following attributes if your '*.txt' files are UTF-16 encoded
-with byte order mark (BOM) and you want Git to perform automatic line
-ending conversion based on your platform.
+As an example, use the following attributes if your '*.proj' files are
+UTF-16 encoded with byte order mark (BOM) and you want Git to perform
+automatic line ending conversion based on your platform.

 ------------------------
-*.txt      text working-tree-encoding=UTF-16
+*.proj     text working-tree-encoding=UTF-16
 ------------------------

-Use the following attributes if your '*.txt' files are UTF-16 little
+Use the following attributes if your '*.proj' files are UTF-16 little
 endian encoded without BOM and you want Git to use Windows line endings
-in the working directory.
+in the working directory. Please note, it is highly recommended to
+explicitly define the line endings with `eol` if the `working-tree-encoding`
+attribute is used to avoid ambiguity.

 ------------------------
-*.txt      working-tree-encoding=UTF-16LE text eol=CRLF
+*.proj         working-tree-encoding=UTF-16LE text eol=CRLF
 ------------------------

 You can get a list of all available encodings on your platform with the
@@ -331,6 +337,13 @@ following command:
 iconv --list
 ------------------------

+If you do not know the encoding of a file, then you can use the `file`
+command to guess the encoding:
+
+------------------------
+file foo.proj
+------------------------
+

 `ident`
 ^^^^^^^
diff --git a/config.c b/config.c
index 1f003fbb90..d0ada9fcd4 100644
--- a/config.c
+++ b/config.c
@@ -1172,6 +1172,11 @@ static int git_default_core_config(const char *var, const char *value)
        return 0;
    }

+   if (!strcmp(var, "core.checkroundtripencoding")) {
+       check_roundtrip_encoding = xstrdup(value);
+       return 0;
+   }
+
    if (!strcmp(var, "core.notesref")) {
        notes_ref_name = xstrdup(value);
        return 0;
diff --git a/convert.c b/convert.c
index 13fad490ce..71dffc7167 100644
--- a/convert.c
+++ b/convert.c
@@ -269,7 +269,7 @@ static int will_convert_lf_to_crlf(size_t len, struct text_stat *stats,
 static void trace_encoding(const char *context, const char *path,
               const char *encoding, const char *buf, size_t len)
 {
-   static struct trace_key coe = TRACE_KEY_INIT(CHECKOUT_ENCODING);
+   static struct trace_key coe = TRACE_KEY_INIT(WORKING_TREE_ENCODING);
    struct strbuf trace = STRBUF_INIT;
    int i;

@@ -289,6 +289,39 @@ static void trace_encoding(const char *context, const char *path,
    strbuf_release(&trace);
 }

+static int check_roundtrip(const char* enc_name)
+{
+   /*
+    * check_roundtrip_encoding contains a string of space and/or
+    * comma separated encodings (eg. "UTF-16, ASCII, CP1125").
+    * Search for the given encoding in that string.
+    */
+   const char *found = strcasestr(check_roundtrip_encoding, enc_name);
+   const char *next = found + strlen(enc_name);
+   int len = strlen(check_roundtrip_encoding);
+   return (found && (
+           /*
+            * check that the found encoding is at the
+            * beginning of check_roundtrip_encoding or
+            * that it is prefixed with a space or comma
+            */
+           found == check_roundtrip_encoding || (
+               found > check_roundtrip_encoding &&
+               (*(found-1) == ' ' || *(found-1) == ',')
+           )
+       ) && (
+           /*
+            * check that the found encoding is at the
+            * end of check_roundtrip_encoding or
+            * that it is suffixed with a space or comma
+            */
+           next == check_roundtrip_encoding + len || (
+               next < check_roundtrip_encoding + len &&
+               (*next == ' ' || *next == ',')
+           )
+       ));
+}
+
 static struct encoding {
    const char *name;
    struct encoding *next;
@@ -333,7 +366,7 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
            error(error_msg, path, enc->name);


-   } else if (has_missing_utf_bom(enc->name, src, src_len)) {
+   } else if (is_missing_required_utf_bom(enc->name, src, src_len)) {
        const char *error_msg = _(
            "BOM is required for '%s' if encoded as %s");
        const char *advise_msg = _(
@@ -367,22 +400,25 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
    trace_encoding("destination", path, default_encoding, dst, dst_len);

    /*
-    * UTF supports lossless round tripping [1]. UTF to other encoding are
-    * mostly round trip safe as Unicode aims to be a superset of all other
-    * character encodings. However, the SHIFT-JIS (Japanese character set)
-    * is an exception as some codes are not round trip safe [2].
+    * UTF supports lossless conversion round tripping [1] and conversions
+    * between UTF and other encodings are mostly round trip safe as
+    * Unicode aims to be a superset of all other character encodings.
+    * However, certain encodings (e.g. SHIFT-JIS) are known to have round
+    * trip issues [2]. Check the round trip conversion for all encodings
+    * listed in core.checkRoundTripEncoding.
     *
-    * Reverse the transformation of 'dst' and check the result with 'src'
-    * if content is written to Git. This ensures no information is lost
-    * during conversion to/from UTF-8.
+    * The round trip check is only performed if content is written to Git.
+    * This ensures that no information is lost during conversion to/from
+    * the internal UTF-8 representation.
     *
     * Please note, the code below is not tested because I was not able to
-    * generate a faulty round trip without iconv error.
+    * generate a faulty round trip without an iconv error. Iconv errors
+    * are already caught above.
     *
     * [1] http://unicode.org/faq/utf_bom.html#gen2
     * [2] https://support.microsoft.com/en-us/help/170559/prb-conversion-problem-between-shift-jis-and-unicode
     */
-   if ((conv_flags & CONV_WRITE_OBJECT) && !strcmp(enc->name, "SHIFT-JIS")) {
+   if ((conv_flags & CONV_WRITE_OBJECT) && check_roundtrip(enc->name)) {
        char *re_src;
        int re_src_len;

@@ -390,6 +426,7 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
                         enc->name, default_encoding,
                         &re_src_len);

+       trace_printf("Checking roundtrip encoding for %s...\n", enc->name);
        trace_encoding("reencoded source", path, enc->name,
                   re_src, re_src_len);

@@ -397,10 +434,7 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
            memcmp(src, re_src, src_len)) {
            const char* msg = _("encoding '%s' from %s to %s and "
                        "back is not the same");
-           if (conv_flags & CONV_WRITE_OBJECT)
-               die(msg, path, enc->name, default_encoding);
-           else
-               error(msg, path, enc->name, default_encoding);
+           die(msg, path, enc->name, default_encoding);
        }

        free(re_src);
@@ -1165,8 +1199,12 @@ static struct encoding *git_path_check_encoding(struct attr_check_item *check)
    if (!strcasecmp(value, default_encoding))
        return NULL;

-   enc = xcalloc(1, sizeof(struct convert_driver));
-   enc->name = xstrdup_toupper(value);  /* aways use upper case names! */
+   enc = xcalloc(1, sizeof(*enc));
+   /*
+    * Ensure encoding names are always upper case (e.g. UTF-8) to
+    * simplify subsequent string comparisons.
+    */
+   enc->name = xstrdup_toupper(value);
    *encoding_tail = enc;
    encoding_tail = &(enc->next);

@@ -1228,7 +1266,7 @@ struct conv_attrs {
    enum crlf_action attr_action; /* What attr says */
    enum crlf_action crlf_action; /* When no attr is set, use core.autocrlf */
    int ident;
-   struct encoding *checkout_encoding; /* Supported encoding or default encoding if NULL */
+   struct encoding *working_tree_encoding; /* Supported encoding or default encoding if NULL */
 };

 static void convert_attrs(struct conv_attrs *ca, const char *path)
@@ -1262,7 +1300,7 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
            else if (eol_attr == EOL_CRLF)
                ca->crlf_action = CRLF_TEXT_CRLF;
        }
-       ca->checkout_encoding = git_path_check_encoding(ccheck + 5);
+       ca->working_tree_encoding = git_path_check_encoding(ccheck + 5);
    } else {
        ca->drv = NULL;
        ca->crlf_action = CRLF_UNDEFINED;
@@ -1344,7 +1382,7 @@ int convert_to_git(const struct index_state *istate,
        len = dst->len;
    }

-   ret |= encode_to_git(path, src, len, dst, ca.checkout_encoding, conv_flags);
+   ret |= encode_to_git(path, src, len, dst, ca.working_tree_encoding, conv_flags);
    if (ret && dst) {
        src = dst->buf;
        len = dst->len;
@@ -1373,7 +1411,7 @@ void convert_to_git_filter_fd(const struct index_state *istate,
    if (!apply_filter(path, NULL, 0, fd, dst, ca.drv, CAP_CLEAN, NULL))
        die("%s: clean filter '%s' failed", path, ca.drv->name);

-   encode_to_git(path, dst->buf, dst->len, dst, ca.checkout_encoding, conv_flags);
+   encode_to_git(path, dst->buf, dst->len, dst, ca.working_tree_encoding, conv_flags);
    crlf_to_git(istate, path, dst->buf, dst->len, dst, ca.crlf_action, conv_flags);
    ident_to_git(path, dst->buf, dst->len, dst, ca.ident);
 }
@@ -1405,7 +1443,7 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
        }
    }

-   ret |= encode_to_worktree(path, src, len, dst, ca.checkout_encoding);
+   ret |= encode_to_worktree(path, src, len, dst, ca.working_tree_encoding);
    if (ret) {
        src = dst->buf;
        len = dst->len;
@@ -1877,7 +1915,7 @@ struct stream_filter *get_stream_filter(const char *path, const unsigned char *s
    if (ca.drv && (ca.drv->process || ca.drv->smudge || ca.drv->clean))
        return NULL;

-   if (ca.checkout_encoding)
+   if (ca.working_tree_encoding)
        return NULL;

    if (ca.crlf_action == CRLF_AUTO || ca.crlf_action == CRLF_AUTO_CRLF)
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
index 0f36d4990a..5dcdd5f899 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -4,7 +4,7 @@ test_description='working-tree-encoding conversion via gitattributes'

 . ./test-lib.sh

-GIT_TRACE_CHECKOUT_ENCODING=1 && export GIT_TRACE_CHECKOUT_ENCODING
+GIT_TRACE_WORKING_TREE_ENCODING=1 && export GIT_TRACE_WORKING_TREE_ENCODING

 test_expect_success 'setup test repo' '
    git config core.eol lf &&
@@ -22,6 +22,8 @@ test_expect_success 'setup test repo' '
 test_expect_success 'ensure UTF-8 is stored in Git' '
    git cat-file -p :test.utf16 >test.utf16.git &&
    test_cmp_bin test.utf8.raw test.utf16.git &&
+
+   # cleanup
    rm test.utf8.raw test.utf16.git
 '

@@ -122,6 +124,10 @@ test_expect_success 'eol conversion for UTF-16 encoded files on checkout' '
    cat crlf.utf8.raw | iconv -f UTF-8 -t UTF-16 >crlf.utf16.raw &&
    cp crlf.utf16.raw eol.utf16 &&

+   cat >expectIndexLF <<-\EOF &&
+       i/lf    w/-text attr/text               eol.utf16
+   EOF
+
    git add eol.utf16 &&
    git commit -m eol &&

@@ -130,11 +136,19 @@ test_expect_success 'eol conversion for UTF-16 encoded files on checkout' '
    git -c core.eol=crlf checkout eol.utf16 &&
    test_cmp_bin crlf.utf16.raw eol.utf16 &&

+   # Although the file has CRLF in the working tree, ensure LF in the index
+   git ls-files --eol eol.utf16 >actual &&
+   test_cmp expectIndexLF actual &&
+
    # UTF-16 with LF (Unix line endings)
    rm eol.utf16 &&
    git -c core.eol=lf checkout eol.utf16 &&
    test_cmp_bin lf.utf16.raw eol.utf16 &&

+   # The file LF in the working tree, ensure LF in the index
+   git ls-files --eol eol.utf16 >actual &&
+   test_cmp expectIndexLF actual&&
+
    rm crlf.utf16.raw crlf.utf8.raw lf.utf16.raw lf.utf8.raw &&

    # cleanup
@@ -195,4 +209,45 @@ test_expect_success 'error if encoding garbage is already in Git' '
    git reset --hard $BEFORE_STATE
 '

+test_expect_success 'check roundtrip encoding' '
+   text="hallo there!\nroundtrip test here!" &&
+   printf "$text" | iconv -f UTF-8 -t SHIFT-JIS >roundtrip.shift &&
+   printf "$text" | iconv -f UTF-8 -t UTF-16 >roundtrip.utf16 &&
+   echo "*.shift text working-tree-encoding=SHIFT-JIS" >>.gitattributes &&
+
+   # SHIFT-JIS encoded files are round-trip checked by default...
+   GIT_TRACE=1 git add .gitattributes roundtrip.shift 2>&1 >/dev/null |
+       grep "Checking roundtrip encoding for SHIFT-JIS" &&
+   git reset &&
+
+   # ... unless we overwrite the Git config!
+   test_config core.checkRoundTripEncoding "garbage" &&
+   ! GIT_TRACE=1 git add .gitattributes roundtrip.shift 2>&1 >/dev/null |
+       grep "Checking roundtrip encoding for SHIFT-JIS" &&
+   test_unconfig core.checkRoundTripEncoding &&
+   git reset &&
+
+   # UTF-16 encoded files should not be round-trip checked by default...
+   ! GIT_TRACE=1 git add roundtrip.utf16 2>&1 >/dev/null |
+       grep "Checking roundtrip encoding for UTF-16" &&
+   git reset &&
+
+   # ... unless we tell Git to check it!
+   test_config_global core.checkRoundTripEncoding "UTF-16, UTF-32" &&
+   GIT_TRACE=1 git add roundtrip.utf16 2>&1 >/dev/null |
+       grep "Checking roundtrip encoding for UTF-16" &&
+   git reset &&
+
+   # ... unless we tell Git to check it!
+   # (here we also check that the casing of the encoding is irrelevant)
+   test_config_global core.checkRoundTripEncoding "UTF-32, utf-16" &&
+   GIT_TRACE=1 git add roundtrip.utf16 2>&1 >/dev/null |
+       grep "Checking roundtrip encoding for UTF-16" &&
+   git reset &&
+
+   # cleanup
+   rm roundtrip.shift roundtrip.utf16 &&
+   git reset --hard HEAD
+'
+
 test_done
diff --git a/utf8.c b/utf8.c
index f033fec1c2..5113d26e56 100644
--- a/utf8.c
+++ b/utf8.c
@@ -562,7 +562,7 @@ int has_prohibited_utf_bom(const char *enc, const char *data, size_t len)
    );
 }

-int has_missing_utf_bom(const char *enc, const char *data, size_t len)
+int is_missing_required_utf_bom(const char *enc, const char *data, size_t len)
 {
    return (
       !strcmp(enc, "UTF-16") &&
diff --git a/utf8.h b/utf8.h
index 26b5e91852..62f86fba64 100644
--- a/utf8.h
+++ b/utf8.h
@@ -93,6 +93,6 @@ int has_prohibited_utf_bom(const char *enc, const char *data, size_t len);
  *     Section 3.10, D98, page 132
  * [3] https://encoding.spec.whatwg.org/#utf-16le
  */
-int has_missing_utf_bom(const char *enc, const char *data, size_t len);
+int is_missing_required_utf_bom(const char *enc, const char *data, size_t len);

 #endif



### Patches

Lars Schneider (7):
  strbuf: remove unnecessary NUL assignment in xstrdup_tolower()
  strbuf: add xstrdup_toupper()
  utf8: add function to detect prohibited UTF-16/32 BOM
  utf8: add function to detect a missing UTF-16/32 BOM
  convert: add 'working-tree-encoding' attribute
  convert: add tracing for 'working-tree-encoding' attribute
  convert: add round trip check based on 'core.checkRoundtripEncoding'

 Documentation/config.txt         |   6 +
 Documentation/gitattributes.txt  |  73 +++++++++++
 config.c                         |   5 +
 convert.c                        | 256 ++++++++++++++++++++++++++++++++++++++-
 convert.h                        |   2 +
 environment.c                    |   1 +
 sha1_file.c                      |   2 +-
 strbuf.c                         |  13 +-
 strbuf.h                         |   1 +
 t/t0028-working-tree-encoding.sh | 253 ++++++++++++++++++++++++++++++++++++++
 utf8.c                           |  37 ++++++
 utf8.h                           |  25 ++++
 12 files changed, 671 insertions(+), 3 deletions(-)
 create mode 100755 t/t0028-working-tree-encoding.sh


base-commit: 8a2f0888555ce46ac87452b194dec5cb66fb1417
--
2.16.1

