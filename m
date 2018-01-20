Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 100DE1F424
	for <e@80x24.org>; Sat, 20 Jan 2018 15:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754742AbeATPYt (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Jan 2018 10:24:49 -0500
Received: from mail-by2nam03on0136.outbound.protection.outlook.com ([104.47.42.136]:63120
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753549AbeATPYq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jan 2018 10:24:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=XqGxj+1e+zuD0arpoclD/6RH0gw3en97KNXiCzZz7Eo=;
 b=c0Je/XosTZwuWbVaBlVSRYNNDF0N94zyC1O56+/GQMG1T2+3R7b9ud0Ls+HKHwfr4yAFwoKoIqprHkLaVs5j30FNH5qyd9rDYHo/Vp2aH/TEZgCCf5xIFh0v3R0CI1MhvA9PQLkszS4ZozqlUPY3H/5CDMN1R2odhj7HWZeCJVQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxBook4.fritz.box (91.89.52.221) by
 CY4P136MB0022.NAMP136.PROD.OUTLOOK.COM (2603:10b6:923:12::25) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.428.19; Sat, 20
 Jan 2018 15:24:42 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v4 0/6]  convert: add support for different encodings
Date:   Sat, 20 Jan 2018 16:24:12 +0100
Message-Id: <20180120152418.52859-1-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [91.89.52.221]
X-ClientProxiedBy: VI1P189CA0006.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::19) To CY4P136MB0022.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:923:12::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34574ed7-b7ee-461b-7a0e-08d56019eee0
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(48565401081)(4534125)(4602075)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:CY4P136MB0022;
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0022;3:SDbHDV2sM6woLixf5KLLlbwDQE3odrvF8jMCOz+ynRP5fxoL0yNISMzyMCdPRMyO7IIKQZFfsqQzJ/g6Q6TAgI6PMFUGTN1AhJB9D9Jkm4rSpt4LCP3Pl/9SHZaIKj5S2pLMPVr/PsicxEntXDBvbd7kwTiTCMCEfZqhNxhpg1EJxW6l+JqfQQls6k2JCPjqntjXejQ4ZNoH0PGrVD+/gV8GOHMVzfthY5autmuvvymygwFGyiCRi2AmjyBqPLco;25:4Sdly08e5jSXs5isk8NL/McUFk9DMT3+zqR24zEDGPzMfhtwhHXEiNxx1Kw5oi76Dqu39CJO6H0sfNvNQSa0Ejq8/b7fwxRSIokzd+pUrQOZHKds/rwBdrt0qvZ1z4KxjQFWsT0oul+ip0DBUH22XDQWZULAbw2Aa9NdDh62X6DLgc0yBud0fQWfibMyKhubW8U6Q2VUOGovcTr9VwAEnPZWkpWZ+is47nUZOucn2GhyHov4xJcx/rAOPeImrGWnX0j5negBjCcfuYZvWfJUn/3hCxUNENJtbaERargl20XAoUJyS4q6aASCVxL6fCZWTzqbdFWXo79vvxtbr2wokw==;31:PoWf5cEcyudcXbpnhjqw9pbZScBtzGp3Q5gg9FcInRgRg27hHedhaV+NSXc+2HEdctf0S4PihT3/PL7ogiDFp/PIBkqXzO1A/tAkarYc+rTMqT6T64aspNetGarvuUjf1XxBZQ6nuTBa408QQKITQpwOhZZSohIfWqKVow7s1XNeIFjU8vJP5w/91H+wR6+LjonazMDzpM2SBG/5cfn8caLBnImuK6pVnaL0eF0p8CE=
X-MS-TrafficTypeDiagnostic: CY4P136MB0022:
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0022;20:YKN3XNMZMt//pG7a+dRKroWcLEm5D8GEKabWT2PQ07TrCezaRcx8nGNJ+6MOh4j29g6a+qBmjYJprSgAQoKIykCyQRrIuehGkfgIrt2WsapyX7eCxTLybC983Jlwea+jZkBOPx84To2d4BtaRfVG6JKq9U9cElY16hywzwHm1l70WYM5kMsmxqiJ8FOe+kqVrp5s0iR0bBXqs65VKKkDpkjqWvwhr57QhtNqrVqf+9iTWN5CNlYm1hiAC0OzzCrVAuK1CergwijY7mIZHErFHfefz9sUhkkBq21EMfsN4WokyAcfnIkYKR9PLKQ7WHwRyra2qmlyTCWy5zJIAdkBvxOd+1rHwfgA++UITaqKsDk8PwUe/Q/rGInGlpswUHvUpOyuMGvoMdfZESfAwCDv7z005Btqz6nieTc9HtxR9VJcOJOkRi6Jz6NL/aaO1URRXC3K8JdliPIx8KTuLCXHd9pIN/eTHtk2LJWZqITLvGWxEPPePt2QEIac7vLnHw9ba2IzKL/xOen3nBXXv/4gx6z/p5hyIqjew0RE3tX00uU3kCh7P3Rvfu2wkRgMx/1ruguP6Uj2g+DR+JI5Scz9zSSYkVQ1luwIFLRfJXFLODo=
X-Microsoft-Antispam-PRVS: <CY4P136MB002297A1B29F51C0B716999DE8EE0@CY4P136MB0022.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820)(85827821059158)(245156298449039)(61196332173343);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231023)(2400081)(944501161)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:CY4P136MB0022;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:CY4P136MB0022;
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0022;4:UopsTGDgoiKCAuHDdBTqCVteJsJ8g+5DDSCst7B0EoOnntyxQPsj0a57sap6aBm5zHO/7ZFMFOlw14tbMFNKaaTDDQlrtdkYlAKumtt4t3WMHDHEyuJOFASjhVzhZbLyUAgWXT97xsLfW0QtvA19wOauJzmpca1B5VNd6yaRemIBDRu5O0Sfjh+RM0eOnre1Qv71L+pRkmoqYTIKiKbs2DVPzwl582feVL8QsGHsqIRUPGgZafYNEzeYVn2Me3u8q1Ov90ge5rtTHyoUyXwkH4EmOgYX8LZ2/YgNmU9v0+0ReoYvfaXznunhnHFd9QtJY8dBO+Fs6ure24JN8vEK8POX2zt0QhaU4a7wtw8CQ/iNkdGpDgIDVvew2Oq53INEqQGnScU7vJ7DNHgs7/r8hvmpxOpnyhwdS4T24UFOqqg=
X-Forefront-PRVS: 0558D3C5AC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(376002)(366004)(346002)(39860400002)(199004)(189003)(97736004)(16526018)(478600001)(68736007)(48376002)(50466002)(305945005)(16586007)(25786009)(7736002)(6306002)(966005)(39060400002)(3846002)(50226002)(316002)(85782001)(4326008)(8656006)(6512007)(1076002)(53416004)(86362001)(2906002)(6116002)(9686003)(2351001)(69596002)(8936002)(5660300001)(36756003)(26005)(59450400001)(66066001)(2361001)(52116002)(8676002)(106356001)(81166006)(47776003)(81156014)(8666007)(6486002)(33896004)(6916009)(105586002)(6506007)(386003)(51416003)(6666003)(53936002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4P136MB0022;H:slxBook4.fritz.box;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4P136MB0022;23:ayKCSTBHj1k+TlGwTAJn9Z+lMZBmX32if7/O14uuF?=
 =?us-ascii?Q?zPQzQQnpMbUUYQVKQR5o+mI2OvwYR6HK+G+3BzLwzi83CmbTfkI8orf1YAXr?=
 =?us-ascii?Q?pqwPoWC3H8u9+WxQx4cJAXI+nXQSz54DH60+/geTfb+gIGim1bzKNX0nQkCR?=
 =?us-ascii?Q?K8v1bXmBbpNelGugEOWPe/Z3Vhld0rMkGFWtFXnFvHf+Kyxr6U7ADb0gRwY/?=
 =?us-ascii?Q?QNVyCB9eNn7x1HuXhpTdL/M/OHTmUb5oXb/sXeEwioqfDMD8wIATbkWn2DUt?=
 =?us-ascii?Q?fq+ZFgbyOHGWk9qwtlVmito7BfiadF/KmB0uqk9CzJ5pnabZK+EHYtOZcIz3?=
 =?us-ascii?Q?f+v3/hEYk9dwmLXb+h0Z6l4DlxzPYgR8DuDv7Du7PBIOB9OplJBVFKqCQ3J0?=
 =?us-ascii?Q?nDK4AxpulrgXUhh0mMmbhTzaVWScaFM8cwV7MPUuvzDwBxP9kzYymsytV5It?=
 =?us-ascii?Q?OO4JU4UuHskohN5OtTzcUQikS2JQ6kEeFlxh7a3QRGlA89WzWzYW/C5jsT5p?=
 =?us-ascii?Q?0h3Q+40doHj+Ynm3KRUJNt2yE2kFXwb3h5rQhCxkLTww0s/bSfM3ztOw9TjT?=
 =?us-ascii?Q?MOt9YlyqbxuL3Oqb0KxZZZR1kYemLvDrZ1nZpkKTrahUKEtgoa4WfjAmfB7r?=
 =?us-ascii?Q?P7v9HMV1EYU1cprzPSvMpsbbGpDLSPoI5lPxUoVjaZMh5uaGtBtN2rxxZ/zS?=
 =?us-ascii?Q?KwfCJ2fCv5TvW10ff96U2uDoMe7UDIZvaXyLnAyBo9yNFQYyITpvqZdh8DzJ?=
 =?us-ascii?Q?BPgwdD1VJx+cJZJdwJJRQZw+Iq+fwFa1vOZl5vOUw+U06ScnxsE5r0i/jSMB?=
 =?us-ascii?Q?SCJGoD9Cte6NK+A8h4BTPrHA9zshrA/RKsJkv/Bs2lri8IJcS3znDB6xCywB?=
 =?us-ascii?Q?td0snufm6ejY586fuL2cJ79OI5TfUuaJXeuQiVAJ544jFo39Qd6FiiSVs2Ou?=
 =?us-ascii?Q?8NFE4JwKxUXIiZjCo8bYSR8G8J/nQFJ/WJ1s3OLyY+DxcuOEgFtMTIICwaSR?=
 =?us-ascii?Q?qQJFRGQ3ZRxCfkBDVXx6MHIWjpR9XGQJgmzRWNFsbFL0pirS80RQZPXtgW3V?=
 =?us-ascii?Q?K4+hYmd6lWKDDv6vsR6DOFT7rBi/Y/DSohc4QJRfSVMZB/rrZ2kbvnyQ6e0Q?=
 =?us-ascii?Q?Wi1CUaIPkdV/G/OPzWzy/K6EwoAekx+HrKqkYJdbOuH29tmgHScdSiGc8Bsy?=
 =?us-ascii?Q?gzY/DRQG8x6ld7GaQXgRDOgoZxTfYCy+WE4ATvFWBdr77UeQgm93jacUBKHj?=
 =?us-ascii?Q?VFP+o/qbr8ngMcPjFAO73lOvDf+6nRmmfyePnoVp9TwgmCtstiIAnEp+t1Si?=
 =?us-ascii?Q?+8bYgkO4LKwBbRz/hGBjHzVCyBixs9EaSV9jea2ocI85Pf5R9HBCME0ZpF5o?=
 =?us-ascii?Q?aXxQw=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0022;6:1n+zh8tnP6ImjPmSmDKTtSBLBmZmJloY1b9rM3zuJlJ1Hkg4NNeQ/WUqiplxcLd8VSjFvh55sXSGgsW+7QudLjKqJwH4sOouEEtf2PAvuL/xCq5+XrQ6wKnOg6MwYSgV5tTCqak4XS0nusmOwuqTNEr31YrfVK2o5KbkXtONrTe1ea8cIudoAgpPh3YjXJg/ff3c9J7X1JtAnfkGCFtY1MKjCXQNEoWzNPSg6W8Jlcu33WfRK0YQKsTiZYYrLWYrvQTi5aONwuh8DuX8UKPzLAO7/GUT+JR1pJgHuTwYPeun2dqYESFkhH8CPxOtLt+WgF2BzIfn0GKP/DSEGoRVPVTVx66i1aXi9RBQQo4xM8I=;5:cqq7kRsY7BpUAAEHs5EX7M67BMmOxaFi5Ub82+fRK2rostLk6Jc8sG6Ic5E08F7IeuJ6DRbd/9Ae36l6qXROpNHlhqq/rqzYMmpX7PeT7Qub/IPrq1c8pSfyyf858UYPEllJXCvR0uPVgk7c8KYjqmC5cM5vLEPPAJrRXgwgbdM=;24:D+iCszFbFXmYkRD3cVKxhfslcQ2+OCMTEyTQTCZ4DB2cIoT7mtVvjKXCpMgEg+oAcPV3dOTXTofG0EijQSjMW88u/MfD8KQfYarmZ8HSYGk=;7:S8LQBff3OD9hY/cwlT7wizh6ghdUph5p9OKqEcPWyCLPAplsZZa476b9fJhh/H29kbg14F79Ar6njmsYrs0Ql7X8KhDkFZf3rk8BT1dgHUnL9bfgZpO8KZiSNGLXxjtYGbgMGXegGxp3I2ObJPdWILqa9VWcZCOfhasVT3ZNdLPs+59qfJzJB6l4WYV295P79b09/PCJU99xZxwdD7EadlxABBTCkd29wWUkJ/3quMcoWhPmO7D0nbVt+U91X9Jc
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2018 15:24:42.2336 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34574ed7-b7ee-461b-7a0e-08d56019eee0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4P136MB0022
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Hi,

Patches 1-4 and 6 are preparation and helper functions.
Patch 5 is the actual change.

This series depends on Torsten's "convert_to_git(): safe_crlf/checksafe
becomes int conv_flags" patch:
https://public-inbox.org/git/20180113224931.27031-1-tboegi@web.de/

Changes since v3:

* I renamed the attribute from "checkout-encoding" to "working-tree-encoding"
  in the hope to convey better what the attribute is about.

* I rebased the series to Git 2.16 and removed Torsten's patch as he
  posted the patch on his own.

* Fix documentation wording. (Torsten)

* A macro was used in a commit before it's introduction. Fixed!(Junio)

Thanks,
Lars

   RFC: https://public-inbox.org/git/BDB9B884-6D17-4BE3-A83C-F67E2AFA2B46@gmail.com/
    v1: https://public-inbox.org/git/20171211155023.1405-1-lars.schneider@autodesk.com/
    v2: https://public-inbox.org/git/20171229152222.39680-1-lars.schneider@autodesk.com/
    v3: https://public-inbox.org/git/20180106004808.77513-1-lars.schneider@autodesk.com/


Base Ref:
Web-Diff: https://github.com/larsxschneider/git/commit/21f4dac5ab
Checkout: git fetch https://github.com/larsxschneider/git encoding-v4 && git checkout 21f4dac5ab


### Interdiff (v3-rebased-2.16..v4):

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 1bc03e69cb..a8dbf4be30 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -272,8 +272,8 @@ few exceptions.  Even though...
   catch potential problems early, safety triggers.


-`checkout-encoding`
-^^^^^^^^^^^^^^^^^^^
+`working-tree-encoding`
+^^^^^^^^^^^^^^^^^^^^^^^

 Git recognizes files encoded with ASCII or one of its supersets (e.g.
 UTF-8 or ISO-8859-1) as text files.  All other encodings are usually
@@ -281,17 +281,17 @@ interpreted as binary and consequently built-in Git text processing
 tools (e.g. 'git diff') as well as most Git web front ends do not
 visualize the content.

-In these cases you can teach Git the encoding of a file in the working
-directory with the `checkout-encoding` attribute. If a file with this
+In these cases you can tell Git the encoding of a file in the working
+directory with the `working-tree-encoding` attribute. If a file with this
 attributes is added to Git, then Git reencodes the content from the
 specified encoding to UTF-8 and stores the result in its internal data
 structure (called "the index"). On checkout the content is encoded
 back to the specified encoding.

-Please note that using the `checkout-encoding` attribute may have a
+Please note that using the `working-tree-encoding` attribute may have a
 number of pitfalls:

-- Git clients that do not support the `checkout-encoding` attribute
+- Git clients that do not support the `working-tree-encoding` attribute
   will checkout the respective files UTF-8 encoded and not in the
   expected encoding. Consequently, these files will appear different
   which typically causes trouble. This is in particular the case for
@@ -304,7 +304,7 @@ number of pitfalls:
 - Reencoding content requires resources that might slow down certain
   Git operations (e.g 'git checkout' or 'git add').

-Use the `checkout-encoding` attribute only if you cannot store a file in
+Use the `working-tree-encoding` attribute only if you cannot store a file in
 UTF-8 encoding and if you want Git to be able to process the content as
 text.

@@ -313,7 +313,7 @@ with byte order mark (BOM) and you want Git to perform automatic line
 ending conversion based on your platform.

 ------------------------
-*.txt    text checkout-encoding=UTF-16
+*.txt    text working-tree-encoding=UTF-16
 ------------------------

 Use the following attributes if your '*.txt' files are UTF-16 little
@@ -321,7 +321,7 @@ endian encoded without BOM and you want Git to use Windows line endings
 in the working directory.

 ------------------------
-*.txt    checkout-encoding=UTF-16LE text eol=CRLF
+*.txt    working-tree-encoding=UTF-16LE text eol=CRLF
 ------------------------

 You can get a list of all available encodings on your platform with the
diff --git a/convert.c b/convert.c
index 8559651b3f..13fad490ce 100644
--- a/convert.c
+++ b/convert.c
@@ -323,7 +323,7 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
    const char *advise_msg = _(
      "You told Git to treat '%s' as %s. A byte order mark "
      "(BOM) is prohibited with this encoding. Either use "
-     "%.6s as checkout encoding or remove the BOM from the "
+     "%.6s as working tree encoding or remove the BOM from the "
      "file.");

    advise(advise_msg, path, enc->name, enc->name, enc->name);
@@ -339,7 +339,7 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
    const char *advise_msg = _(
      "You told Git to treat '%s' as %s. A byte order mark "
      "(BOM) is required with this encoding. Either use "
-     "%sBE/%sLE as checkout encoding or add a BOM to the "
+     "%sBE/%sLE as working tree encoding or add a BOM to the "
      "file.");
    advise(advise_msg, path, enc->name, enc->name, enc->name);
    if (conv_flags & CONV_WRITE_OBJECT)
@@ -1237,7 +1237,7 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)

  if (!check) {
    check = attr_check_initl("crlf", "ident", "filter",
-          "eol", "text", "checkout-encoding",
+          "eol", "text", "working-tree-encoding",
           NULL);
    user_convert_tail = &user_convert;
    encoding_tail = &encoding;
diff --git a/t/t0028-checkout-encoding.sh b/t/t0028-working-tree-encoding.sh
similarity index 89%
rename from t/t0028-checkout-encoding.sh
rename to t/t0028-working-tree-encoding.sh
index 5f1c911c07..0f36d4990a 100755
--- a/t/t0028-checkout-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -1,6 +1,6 @@
 #!/bin/sh

-test_description='checkout-encoding conversion via gitattributes'
+test_description='working-tree-encoding conversion via gitattributes'

 . ./test-lib.sh

@@ -10,7 +10,7 @@ test_expect_success 'setup test repo' '
  git config core.eol lf &&

  text="hallo there!\ncan you read me?" &&
- echo "*.utf16 text checkout-encoding=utf-16" >.gitattributes &&
+ echo "*.utf16 text working-tree-encoding=utf-16" >.gitattributes &&
  printf "$text" >test.utf8.raw &&
  printf "$text" | iconv -f UTF-8 -t UTF-16 >test.utf16.raw &&
  cp test.utf16.raw test.utf16 &&
@@ -45,10 +45,10 @@ test_expect_success 'check prohibited UTF BOM' '
  printf "\0\0\376\777\0\0\0a\0\0\0b\0\0\0c" >bebom.utf32be.raw &&
  printf "\777\376\0\0a\0\0\0b\0\0\0c\0\0\0" >lebom.utf32le.raw &&

- echo "*.utf16be text checkout-encoding=utf-16be" >>.gitattributes &&
- echo "*.utf16le text checkout-encoding=utf-16le" >>.gitattributes &&
- echo "*.utf32be text checkout-encoding=utf-32be" >>.gitattributes &&
- echo "*.utf32le text checkout-encoding=utf-32le" >>.gitattributes &&
+ echo "*.utf16be text working-tree-encoding=utf-16be" >>.gitattributes &&
+ echo "*.utf16le text working-tree-encoding=utf-16le" >>.gitattributes &&
+ echo "*.utf32be text working-tree-encoding=utf-32be" >>.gitattributes &&
+ echo "*.utf32le text working-tree-encoding=utf-32le" >>.gitattributes &&

  # Here we add a UTF-16 files with BOM (big-endian and little-endian)
  # but we tell Git to treat it as UTF-16BE/UTF-16LE. In these cases
@@ -91,7 +91,7 @@ test_expect_success 'check prohibited UTF BOM' '
 '

 test_expect_success 'check required UTF BOM' '
- echo "*.utf32 text checkout-encoding=utf-32" >>.gitattributes &&
+ echo "*.utf32 text working-tree-encoding=utf-32" >>.gitattributes &&

  cp nobom.utf16be.raw nobom.utf16 &&
  test_must_fail git add nobom.utf16 2>err.out &&
@@ -143,11 +143,11 @@ test_expect_success 'eol conversion for UTF-16 encoded files on checkout' '

 test_expect_success 'check unsupported encodings' '

- echo "*.nothing text checkout-encoding=" >>.gitattributes &&
+ echo "*.nothing text working-tree-encoding=" >>.gitattributes &&
  printf "nothing" >t.nothing &&
  git add t.nothing &&

- echo "*.garbage text checkout-encoding=garbage" >>.gitattributes &&
+ echo "*.garbage text working-tree-encoding=garbage" >>.gitattributes &&
  printf "garbage" >t.garbage &&
  test_must_fail git add t.garbage 2>err.out &&
  test_i18ngrep "fatal: failed to encode" err.out &&
@@ -161,7 +161,7 @@ test_expect_success 'error if encoding round trip is not the same during refresh
  BEFORE_STATE=$(git rev-parse HEAD) &&

  # Skip the UTF-16 filter for the added file
- # This simulates a Git version that has no checkoutEncoding support
+ # This simulates a Git version that has no working tree encoding support
  echo "hallo" >nonsense.utf16 &&
  TEST_HASH=$(git hash-object --no-filters -w nonsense.utf16) &&
  git update-index --add --cacheinfo 100644 $TEST_HASH nonsense.utf16 &&



### Patches

Lars Schneider (6):
  strbuf: remove unnecessary NUL assignment in xstrdup_tolower()
  strbuf: add xstrdup_toupper()
  utf8: add function to detect prohibited UTF-16/32 BOM
  utf8: add function to detect a missing UTF-16/32 BOM
  convert: add 'working-tree-encoding' attribute
  convert: add tracing for 'working-tree-encoding' attribute

 Documentation/gitattributes.txt  |  60 +++++++++++
 convert.c                        | 218 ++++++++++++++++++++++++++++++++++++++-
 convert.h                        |   1 +
 sha1_file.c                      |   2 +-
 strbuf.c                         |  13 ++-
 strbuf.h                         |   1 +
 t/t0028-working-tree-encoding.sh | 198 +++++++++++++++++++++++++++++++++++
 utf8.c                           |  37 +++++++
 utf8.h                           |  25 +++++
 9 files changed, 552 insertions(+), 3 deletions(-)
 create mode 100755 t/t0028-working-tree-encoding.sh


base-commit: 8a2f0888555ce46ac87452b194dec5cb66fb1417
--
2.16.0

