Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4CDD1F404
	for <e@80x24.org>; Fri, 29 Dec 2017 15:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751125AbdL2PWm (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Dec 2017 10:22:42 -0500
Received: from mail-co1nam03on0113.outbound.protection.outlook.com ([104.47.40.113]:32317
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750869AbdL2PWk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Dec 2017 10:22:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=6gtc3HLHEO4QIXzUmJe18EB184sxLokAUdDNnCXdbfk=;
 b=dg67bHi0pW46asTlFggzXsuuh16rkAShPbWnin5eH/FGmJrNoEEpTaLoe+yhMggyjkGE6w6oeyMxAGnIPgKB/rBi7QI+UfmujOBRCuflrkQxpr4JRth9GJdRHdC0bwey9mUinUkCYYM2RH1hBuSQ7Un+YSRX6UItdNHzCpWCdb0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxBook4.fritz.box (93.219.84.3) by
 BN6P136MB0017.NAMP136.PROD.OUTLOOK.COM (129.75.91.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.345.17; Fri, 29 Dec 2017 15:22:35 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v2 0/5] convert: add support for different encodings
Date:   Fri, 29 Dec 2017 16:22:17 +0100
Message-Id: <20171229152222.39680-1-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [93.219.84.3]
X-ClientProxiedBy: AM5PR0502CA0001.eurprd05.prod.outlook.com (10.175.37.139)
 To BN6P136MB0017.NAMP136.PROD.OUTLOOK.COM (129.75.91.24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4d604fab-c708-4a47-3c0d-08d54ecffe23
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060);SRVR:BN6P136MB0017;
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0017;3:9VzKy8z3lQ6UJQkyQ/LnHq6fCNn/djnG/xegUJD6BPxwQ66zmxLYSZaQR/VPKRoqaSClLvzVeh7wgmUQyhAapTjSRFIUZhrKj1hhvap9mpaHyd3ZJaXcNVR+XwluuZXbm0QaakaTq7SufEfCHkyOSCWnf/pd+ALM/aFf0I0i6vFW3MTfeOCGNd+U/h9/fhkCE6ZVcFJ0Z2mGZGlwZ8IDFfKZcBaHHYFGENsKvLn71aLnCvmQfxX7OXddToAzMqdL;25:hOIvb08bMtlF2Ig/+XnZsOlo6+mh66jR+TqdXmlHK0DmYdorlOKVK1dWE1McOmsii8nAiOJOSiu+6B8TSzUQObQMfnFreRTrLr+fLBl2HXGQmzkJCzf2kN2kQO2gz48Wdtmpr5cD+DRmOY+JGcUDqjn2wniAWuWULtzHHBQI6YZKy1Q2DNhSIIjaePUpgtTqzmyFYxVpRD0LMkO+kFh36AIMgnBRS6cM8acEOG+am7bSk8Jfje/RsvifFvOD4mgNODQb5sQ1ARoNBZbCgWh513cyzKrzRhIF23BLMcgH3KCRXeOmp+mfH7R7eEAs406qdQqAiHtUagjBlTrjYgx90w==;31:J/draop2wM55Cy1BjrfO2NgzT71NvIM5PSpnWTDwsPI5UJ8nlhup0I/IHXtZLJoYGVTgqCaBlJV11znYib2ujFx1jyUVgQxgLMhh4Rb0YUUPrOxuyp6vs3SjYK5neb+o1H/tAtzqFRN/wGXa6Wrn0wlHOgJc9cPa0+om/SwbaJm4QaxenrPTByR5VoBe5C61X/DVyz/Ug4EUV8QS/J3lfMKbLzhzN3QCi1DG22/exLM=
X-MS-TrafficTypeDiagnostic: BN6P136MB0017:
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0017;20:LOzHCx5AvapHJ7cebHrEpOnD9BNd8ondKks4PZyMsKjLq1DTbj8a/BsEX2+DYb2bcn3DR5gznCQhmVa/JF+Eu0dH54t7Tys8v986ln9X/4HBed6H3vbxcIvBJcLee4SQ3M4L135+F+sp+gLuiEw3X3YGV2U9bfereTKqcQ/Pk0Pw/TJ+Hmpt0aQ1cYYXYIoAGHmsS0h64/Yxo2K9ojhAqQQ51gmc8+dbpMeVMyBjGg8Xr3U7E17KePSirbBRuiIwlRNpOdNZlm7Lg0m69e0g6Ynjl7rpdEeD4K7/PN+U3P3pgAWCPNkVEK0wpTxc64kYO34yut43xO8G8sibF8O3/PYor8GmV7KyetbEg8DCw2uKYksq9XWLFRG3rznFlECjA06+p0DkAr/ji5jToD2veH5UF0l9tz+DB9dTAVqxez2eUifaWIUWFy+y9CBVYn3aIIVSkLmhkeGQTKQQfFw3LCkYEpc178kwDJ92g0rrGvYg+lJ0b8d3WuWkmBZJ3+p0zkocFPMJz+lMf01WQGx/JGxQm484XpN4nGxLH8ySS7+o6wwajZOhN2p0891W5H3LFo5AoH6pxAiWsvO7swnOyzJOej6gYQ0SVGSVJL3gxAs=
X-Microsoft-Antispam-PRVS: <BN6P136MB0017FA346FCF30736255325DE8050@BN6P136MB0017.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820)(61196332173343);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040470)(2401047)(5005006)(8121501046)(3231023)(944501075)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041268)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6P136MB0017;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:BN6P136MB0017;
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0017;4:S2dm+eWYxOXMtquNoPrbey26cKIjfyedrQo2RureN8AEYFvdwLvldt8Hp7e5zmQuLavG3OJ8bE+YUzNF5GIM+taNDTpIxbJuIjUxkSVICWsTNZK2Mluppxbd75AO/lGCfQbsEcsQs+p+eqkgGiD8RTC0a6AbqIyWDXXY6+gmqqZMacvRk93JcFcBvyBBy66U+VI8VpLin5ehtX2uK+7h9WeeE5MDMabV9Zm1zGBgS9ihlk+y0JU4riHCwx0qvCsrekAl66fo8bMb5n2B7f7C+m+TXdTer0Z+Bited1LUHjbOCwiQ6Qjgny12/XWGquDq1Wsj+en18WwmDDaHLri2xY5R+THvWlsOkBW6Ox4qaEg=
X-Forefront-PRVS: 0536638EAC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(346002)(366004)(376002)(189003)(199004)(16526018)(4326008)(6666003)(478600001)(6916009)(59450400001)(5890100001)(9686003)(575784001)(53936002)(16586007)(6306002)(6512007)(316002)(6506007)(53946003)(68736007)(386003)(86362001)(8676002)(5660300001)(36756003)(81156014)(81166006)(39060400002)(8656006)(33896004)(25786009)(51416003)(53416004)(52116002)(53376002)(6486002)(50226002)(3846002)(66066001)(7736002)(48376002)(2906002)(1076002)(105586002)(50466002)(966005)(69596002)(97736004)(85782001)(106356001)(2361001)(8936002)(47776003)(2351001)(6116002)(305945005)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6P136MB0017;H:slxBook4.fritz.box;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6P136MB0017;23:t++cWGZNWzTmJ5nwmB1rdepIniY1JH0oWuyy5dbrN?=
 =?us-ascii?Q?aG/HaPlQxnAEtBYw1f5oByuKJlRv1QySGXdii+RijPBADYiZmYGdQq9xbEo0?=
 =?us-ascii?Q?Kbm/iOUGJLFw+9WSuXRf8jDUYsTYa7UF7OoZUV2he5oITgiOzwKaXwlgeB0k?=
 =?us-ascii?Q?uLb5ADsMkZFu+Bmyg6+tKyhwLcy3e91hxSTJR1Eoc2UPGE6eEY9jiQx/EAJw?=
 =?us-ascii?Q?J5WgdkLKU6w9M1xyZspShw55VaRxSm4/D8LVt01r4WzMHEV1LNwCYaCHnErq?=
 =?us-ascii?Q?AUb7blcsEwJrUGljwWx55KZ0Os6Ij5bwiedvcMPsm8rsfYOgmujDEBuTHEMe?=
 =?us-ascii?Q?nzTmFt8m2qUCkczwHGkZn3S5uIZD0JU9VdfEVYp5larXwUkq+b5ll/zZxfii?=
 =?us-ascii?Q?fOwQ8h4/vajd9wh5epKrrkg7ib4djGgp3fnS5iSjPeTzrqWRqlELt31S9fQP?=
 =?us-ascii?Q?fOogLF4JsjrHYJWgf7iM3U6HRqKvkYBqotHzmMHdbvhHEdrPQ51GEAGSZ/03?=
 =?us-ascii?Q?TBlvInTmS3iODf0zt/GTiy1En45i+p6kZPet3lNLl7Ch32se/qLBdQv2Knib?=
 =?us-ascii?Q?fZEoOrKq2IQpEV5fExoMOP1JAdIcHvm7G4BSvOt+p/Cszr4Q+zC6gPcxOkc6?=
 =?us-ascii?Q?rWSSQb362zTwwjcW8T8+VmcYix91F2yHXLQN5xdgNlkxK4sI2CqAzU+jOMES?=
 =?us-ascii?Q?M0hbce4gmlluuS/Kmwfjn2VrjgABTs4zPA+UP8e67CQnKOfdRARPZhYSwmko?=
 =?us-ascii?Q?oFU3t/ROAoGqF/RkNoc2LUv2Z0QE4rcqh9OfpbfhwhVLDpoYIwW3e0slTXn3?=
 =?us-ascii?Q?2FB8m5wBUL1Gea/Vr56y7RTGzMq2AHGeOJX4RwbgWQNr5rqBPWB+ZZwLDubS?=
 =?us-ascii?Q?H8qWMQSQebjkt7otNKhCBZFjjp8kw2nhvHWWUutF6SMIzt83X+HJKLziSGTN?=
 =?us-ascii?Q?sGFipB/VABEhTFrZPGmWQ9T5gU9h/lWdisMrh69VNxtKqnLoYMTOv+snZQzP?=
 =?us-ascii?Q?1YkBP1dcdgT8LyvGSwvp2pSsA6Gycl93liyBNanQDKv/uxVwk9dmcFIJuYlT?=
 =?us-ascii?Q?vph09OkQsVATtzniM33hN3wgJL8HxwLDl1hCwj8RX/Z1/PbMpweybr+yndTi?=
 =?us-ascii?Q?gZorlss1vCiV4z8c1ZN3ims0Dbee9ZEXnk7FFcnS2bkHqXk/t/ZtqywoFxIm?=
 =?us-ascii?Q?BshtlPEps6itLnrlqoelo0u9xd9gs8lK3ueMR836s8f54KvsZHUYXldiPtP6?=
 =?us-ascii?Q?BHc6jJ81KtCo4FgJ8rfLf5j+ibuDDUhYghtXpkeHtD/1dm71LGnQG+IQ6kHg?=
 =?us-ascii?Q?Ea/r6GxKk/w125CkMBA4vB1msrBnPT/lM1iib4AYV8+imuoab8r5+cFPZ6Xs?=
 =?us-ascii?Q?rwqIEDTUcS5ot+LXyXHIhON1Jy0KMwbPXCbNtYqQW2edCBG?=
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0017;6:juVQbp0BeAsp4zXlNtJswawtjEQ68cV1ILN4BDmPmsL95JnmWGeBmBp/wGr+SfjlNKhjzGR38+JCmGHhZHwJ0I1YvjBPVWVOHJ+ykwEypa6URT1m0Wa0PNQyQp7RIs1BpLcn69h3nvlaRaKNbaxuJldQ2fLqchE9290rleAfT1e67gYLC8DlDMcpKLbmpSqG5kkAADzsO2oD+yjFMXiyN6UChZdphfBd7FKOKPipckE1kosfraKp0JJjqNJW3e+aQLbqWkmQcMRVe0oV71oxB2KUc5jnSvR67GUlirIXOMxiskJhQobLlQHLDu4jLsYGw52qnPjJHXUJ1/d4qTAxIKxuRd9xO2XCUQDSLfOBGTw=;5:9Uh+xlYR4IUUUrNo486sNd0bQ7/AJMbE7cuSFcPAaZN5CM5ryHTGytGrRWAxRrPPXBnuGP5XxvVYsy+JxLJRHRCA00FaVmyHaY7CwBjDa5C2TQntuoplBwIPLo0SAV0CSs0SZyHibafmfJ7bWdCtryWsfVKNPkFwVjDtd3EyRTI=;24:mmTWZH1EHKcqA8ZTALAa7Ux0mMrasqVm9eg13WYXMUTwaN3pA7KodrNxlf4UbT8ThlC6qYzKEl62i5+EbLim1qXuciYvNVnpf3ohQY8TeiM=;7:Xc9mXrw638lWjJ56BUbmz+oEh3BpoZjQy8ATYeFfIGTKk4nZUrnnMcpMdL2MhzKuMCrdpMPcl7p+o8H5jjb7d0OPy+RL2YptKBJ1Kyj5YHi9AGqhoREHZhFyBvnMWM7yg1aq/L0k6Cp1OrHTIgjNtsMsIh6TbTTM90W8bfJG1/gGO035iig67ivLyMWyA3AumeJ1hoCCgbw4j4sWwGT+4w/7vZOeWUE1imhJjVH6rELjcSb1+6ub3lozMvmbAsT1
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2017 15:22:35.5461 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d604fab-c708-4a47-3c0d-08d54ecffe23
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6P136MB0017
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Hi,

notable changes since v1:

* In [1] Peff described a situation where you "couldn't checkout _away_
  from" problems because of "die() in convert_to_git()". I fixed this and
  tried to replicate the situation with the test "error if encoding
  garbage is already in Git". To achieve that I had to pass the
  'write_obj' variable through all the functions to let the encoding
  code know if Git actually writes content. If Git actually writes
  content then we die. Otherwise we just print an error. This ensures
  no garbage is added to Git.

* I renamed the attribute to "checkout-encoding" to avoid trouble with
  the existing "encoding" attribute. I also considered
  "working-tree-encoding". We also discussed "worktree-encoding" as
  attribute name but I am was worried that people could (wrongly)
  associated that with the 'git worktree' feature. I am happy to hear
  arguments for/against any of the different options.

* I read a bit on the Internet and as far as I understand it to/from
  UTF-8 reencodings are mostly round trip safe. Notable exceptions
  are some characters in the SHIFT-JIS character set:
  https://support.microsoft.com/en-us/help/170559/prb-conversion-problem-between-shift-jis-and-unicode

  However, I was not able to replicate the issue. Consider this:
      X="\x87\x90"
      printf "$X" | od -h
      printf "$X" | iconv -f SHIFT-JIS -t UTF-8 | iconv -f UTF-8 -t SHIFT-JIS | od -h

  ... the reencoding from SHIFT-JIS to UTF-8 would always fail.
  Therefore, I was not able to generate a test case that produces a
  different result after the round trip. Anyone an idea how to do that?

* Patch 1, 2, 3, and 5 are helper functions. Patch 4 is the real change.

Thanks,
Lars

     RFC: ttps://public-inbox.org/git/BDB9B884-6D17-4BE3-A83C-F67E2AFA2B46@gmail.comh
      v1: https://public-inbox.org/git/20171211155023.1405-1-lars.schneider@autodesk.com/

Base Ref: master
Web-Diff: https://github.com/larsxschneider/git/commit/e11e375fdb
Checkout: git fetch https://github.com/larsxschneider/git encoding-v2 && git checkout e11e375fdb


### Interdiff (v1..v2):

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 84de2fa49c..0039bd38c3 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -146,33 +146,6 @@ Unspecified::
 Any other value causes Git to act as if `text` has been left
 unspecified.

-`encoding`
-^^^^^^^^^^
-
-By default Git assumes UTF-8 encoding for text files.  The `encoding`
-attribute sets the encoding to be used in the working directory.
-If the path is added to the index, then Git encodes the content to
-UTF-8.  On checkout the content is encoded back to the original
-encoding.  Consequently, you can use all built-in Git text processing
-tools (e.g. git diff, line ending conversions, etc.) with your
-non-UTF-8 encoded file.
-
-Please note that re-encoding content can cause errors and requires
-resources. Use the `encoding` attribute only if you cannot store
-a file in UTF-8 encoding and if you want Git to be able to process
-the text.
-
-------------------------
-*.txt		text encoding=UTF-16
-------------------------
-
-All `iconv` encodings with a stable round-trip conversion to and from
-UTF-8 are supported.  You can see a full list with the following command:
-
-------------------------
-iconv --list
-------------------------
-
 `eol`
 ^^^^^

@@ -299,6 +272,65 @@ few exceptions.  Even though...
   catch potential problems early, safety triggers.


+`checkout-encoding`
+^^^^^^^^^^^^^^^^^^^
+
+Git recognizes files encoded with ASCII or one of its supersets (e.g.
+UTF-8 or ISO-8859-1) as text files.  All other encodings are usually
+interpreted as binary and consequently built-in Git text processing
+tools (e.g. 'git diff') as well as most Git web front ends do not
+visualize the content.
+
+In these cases you can teach Git the encoding of a file in the working
+directory with the `checkout-encoding` attribute. If a file with this
+attributes is added to Git, then Git reencodes the content from the
+specified encoding to UTF-8 and stores the result in its internal data
+structure. On checkout the content is encoded back to the specified
+encoding.
+
+Please note that using the `checkout-encoding` attribute has a number
+of drawbacks:
+
+- Reencoding content to non-UTF encodings (e.g. SHIFT-JIS) can cause
+  errors as the conversion might not be round trip safe.
+
+- Reencoding content requires resources that might slow down certain
+  Git operations (e.g 'git checkout' or 'git add').
+
+- Git clients that do not support the `checkout-encoding` attribute or
+  the used encoding will checkout the respective files as UTF-8 encoded.
+  That means the content appears to be different which could cause
+  trouble. Affected clients are older Git versions and alternative Git
+  implementations such as JGit or libgit2 (as of January 2018).
+
+Use the `checkout-encoding` attribute only if you cannot store a file in
+UTF-8 encoding and if you want Git to be able to process the content as
+text.
+
+Use the following attributes if your '*.txt' files are UTF-16 encoded
+with byte order mark (BOM) and you want Git to perform automatic line
+ending conversion based on your platform.
+
+------------------------
+*.txt		text checkout-encoding=UTF-16
+------------------------
+
+Use the following attributes if your '*.txt' files are UTF-16 little
+endian encoded without BOM and you want Git to use Windows line endings
+in the working directory.
+
+------------------------
+*.txt 		checkout-encoding=UTF-16LE text eol=CRLF
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

diff --git a/apply.c b/apply.c
index 321a9fa68d..c4bd5cf1f2 100644
--- a/apply.c
+++ b/apply.c
@@ -2281,7 +2281,7 @@ static int read_old_data(struct stat *st, struct patch *patch,
 		 * should never look at the index when explicit crlf option
 		 * is given.
 		 */
-		convert_to_git(NULL, path, buf->buf, buf->len, buf, safe_crlf);
+		convert_to_git(NULL, path, buf->buf, buf->len, buf, safe_crlf, 0);
 		return 0;
 	default:
 		return -1;
diff --git a/blame.c b/blame.c
index 2893f3c103..388b66897b 100644
--- a/blame.c
+++ b/blame.c
@@ -229,7 +229,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 		if (strbuf_read(&buf, 0, 0) < 0)
 			die_errno("failed to read from stdin");
 	}
-	convert_to_git(&the_index, path, buf.buf, buf.len, &buf, 0);
+	convert_to_git(&the_index, path, buf.buf, buf.len, &buf, 0, 0);
 	origin->file.ptr = buf.buf;
 	origin->file.size = buf.len;
 	pretend_sha1_file(buf.buf, buf.len, OBJ_BLOB, origin->blob_oid.hash);
diff --git a/combine-diff.c b/combine-diff.c
index 2505de119a..4555e49b5f 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1053,7 +1053,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			if (is_file) {
 				struct strbuf buf = STRBUF_INIT;

-				if (convert_to_git(&the_index, elem->path, result, len, &buf, safe_crlf)) {
+				if (convert_to_git(&the_index, elem->path, result, len, &buf, safe_crlf, 0)) {
 					free(result);
 					result = strbuf_detach(&buf, &len);
 					result_size = len;
diff --git a/convert.c b/convert.c
index ee19c17104..ca7b2f3e5c 100644
--- a/convert.c
+++ b/convert.c
@@ -257,28 +257,40 @@ static int will_convert_lf_to_crlf(size_t len, struct text_stat *stats,

 }

-#ifdef NO_ICONV
-#ifndef _ICONV_T
-/* The type is just a placeholder and not actually used. */
-typedef void* iconv_t;
-#endif
-#endif
+static void trace_encoding(const char *context, const char *path,
+			   const char *encoding, const char *buf, size_t len)
+{
+	static struct trace_key coe = TRACE_KEY_INIT(CHECKOUT_ENCODING);
+	struct strbuf trace = STRBUF_INIT;
+	int i;
+
+	strbuf_addf(&trace, "%s (%s, considered %s):\n", context, path, encoding);
+	for (i = 0; i < len && buf; ++i) {
+		strbuf_addf(
+			&trace,"| \e[2m%2i:\e[0m %2x \e[2m%c\e[0m%c",
+			i,
+			(unsigned char) buf[i],
+			(buf[i] > 32 && buf[i] < 127 ? buf[i] : ' '),
+			((i+1) % 8 && (i+1) < len ? ' ' : '\n')
+		);
+	}
+	strbuf_addchars(&trace, '\n', 1);
+
+	trace_strbuf(&coe, &trace);
+	strbuf_release(&trace);
+}

 static struct encoding {
 	const char *name;
-	iconv_t to_git;       /* conversion to Git's canonical encoding (UTF-8) */
-	iconv_t to_worktree;  /* conversion to user-defined encoding */
 	struct encoding *next;
 } *encoding, **encoding_tail;
-static const char *default_encoding = "utf-8";
-static iconv_t invalid_conversion = (iconv_t)-1;
+static const char *default_encoding = "UTF-8";

 static int encode_to_git(const char *path, const char *src, size_t src_len,
-			 struct strbuf *buf, struct encoding *enc)
+			 struct strbuf *buf, struct encoding *enc, int write_obj)
 {
-#ifndef NO_ICONV
-	char *dst, *re_src;
-	int dst_len, re_src_len;
+	char *dst;
+	int dst_len;

 	/*
 	 * No encoding is specified or there is nothing to encode.
@@ -296,70 +308,102 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 	if (!buf && !src)
 		return 1;

-	if (enc->to_git == invalid_conversion) {
-		enc->to_git = iconv_open(default_encoding, encoding->name);
-		if (enc->to_git == invalid_conversion)
-			warning(_("unsupported encoding %s"), encoding->name);
+	if (has_prohibited_utf_bom(enc->name, src, src_len)) {
+		const char *error_msg = _(
+			"BOM is prohibited for '%s' if encoded as %s");
+		const char *advise_msg = _(
+			"You told Git to treat '%s' as %s. A byte order mark "
+			"(BOM) is prohibited with this encoding. Either use "
+			"%.6s as checkout encoding or remove the BOM from the "
+			"file.");
+
+		advise(advise_msg, path, enc->name, enc->name, enc->name);
+		if (write_obj)
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
+			"%sBE/%sLE as checkout encoding or add a BOM to the "
+			"file.");
+		advise(advise_msg, path, enc->name, enc->name, enc->name);
+		if (write_obj)
+			die(error_msg, path, enc->name);
+		else
+			error(error_msg, path, enc->name);
 	}

-	if (enc->to_worktree == invalid_conversion)
-		enc->to_worktree = iconv_open(encoding->name, default_encoding);
-
-	/*
-	 * Do nothing if the encoding is not supported. This could happen in
-	 * two cases:
-	 *   (1) The encoding is garbage. That is no problem as we would not
-	 *       encode the content to UTF-8 on "add" and we would not encode
-	 *       it back on "checkout".
-	 *   (2) Git users use different iconv versions that support different
-	 *       encodings. This could lead to problems, as the content might
-	 *       not be encoded on "add" but encoded back on "checkout" (or
-	 *       the other way around).
-	 * We print a one-time warning to the user in both cases above.
-	 */
-	if (enc->to_git == invalid_conversion || enc->to_worktree == invalid_conversion)
-		return 0;
-
-	dst = reencode_string_iconv(src, src_len, enc->to_git, &dst_len);
-	if (!dst)
+	trace_encoding("source", path, enc->name, src, src_len);
+	dst = reencode_string_len(src, src_len, default_encoding, enc->name,
+				  &dst_len);
+	if (!dst) {
 		/*
 		 * We could add the blob "as-is" to Git. However, on checkout
 		 * we would try to reencode to the original encoding. This
 		 * would fail and we would leave the user with a messed-up
 		 * working tree. Let's try to avoid this by screaming loud.
 		 */
-		die(_("failed to encode '%s' from %s to %s"),
-			path, enc->name, default_encoding);
+		const char* msg = _("failed to encode '%s' from %s to %s");
+		if (write_obj)
+			die(msg, path, enc->name, default_encoding);
+		else
+			error(msg, path, enc->name, default_encoding);
+	}
+	trace_encoding("destination", path, default_encoding, dst, dst_len);

 	/*
-	 * Encode dst back to ensure no information is lost. This wastes
-	 * a few cycles as most conversions are round trip conversion
-	 * safe. However, content that has an invalid encoding might not
-	 * match its original byte sequence after the UTF-8 conversion
-	 * round trip. Let's play safe here and check the round trip
-	 * conversion.
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
 	 */
-	re_src = reencode_string_iconv(dst, dst_len, enc->to_worktree, &re_src_len);
-	if (!re_src || strcmp(src, re_src)) {
-		die(_("encoding '%s' from %s to %s and back is not the same"),
-			path, enc->name, default_encoding);
+	if (write_obj && !strcmp(enc->name, "SHIFT-JIS")) {
+		char *re_src;
+		int re_src_len;
+
+		re_src = reencode_string_len(dst, dst_len,
+					     enc->name, default_encoding,
+					     &re_src_len);
+
+		trace_encoding("reencoded source", path, enc->name,
+			       re_src, re_src_len);
+
+		if (!re_src || src_len != re_src_len ||
+		    memcmp(src, re_src, src_len)) {
+			const char* msg = _("encoding '%s' from %s to %s and "
+					    "back is not the same");
+			if (write_obj)
+				die(msg, path, enc->name, default_encoding);
+			else
+				error(msg, path, enc->name, default_encoding);
 		}
+
 		free(re_src);
+	}

 	strbuf_attach(buf, dst, dst_len, dst_len + 1);
 	return 1;
-#else
-	warning(_("cannot encode '%s' from %s to %s because "
-		"your Git was not compiled with encoding support"),
-		path, enc->name, default_encoding);
-	return 0;
-#endif
 }

 static int encode_to_worktree(const char *path, const char *src, size_t src_len,
 			      struct strbuf *buf, struct encoding *enc)
 {
-#ifndef NO_ICONV
 	char *dst;
 	int dst_len;

@@ -370,34 +414,16 @@ static int encode_to_worktree(const char *path, const char *src, size_t src_len,
 	if (!enc || (src && !src_len))
 		return 0;

-	if (enc->to_worktree == invalid_conversion) {
-		enc->to_worktree = iconv_open(encoding->name, default_encoding);
-		if (enc->to_worktree == invalid_conversion)
-			warning("unsupported encoding %s", encoding->name);
-	}
-
-	/*
-	 * Do nothing if the encoding is not supported.
-	 * See detailed explanation in encode_to_git().
-	 */
-	if (enc->to_worktree == invalid_conversion)
-		return 0;
-
-	dst = reencode_string_iconv(src, src_len, enc->to_worktree, &dst_len);
+	dst = reencode_string_len(src, src_len, enc->name, default_encoding,
+				  &dst_len);
 	if (!dst) {
-		warning("failed to encode '%s' from %s to %s",
-			path, default_encoding, encoding->name);
+		error("failed to encode '%s' from %s to %s",
+			path, enc->name, default_encoding);
 		return 0;
 	}

 	strbuf_attach(buf, dst, dst_len, dst_len + 1);
 	return 1;
-#else
-	warning(_("cannot encode '%s' from %s to %s because "
-		"your Git was not compiled with encoding support"),
-		path, default_encoding, encoding->name);
-	return 0;
-#endif
 }

 static int crlf_to_git(const struct index_state *istate,
@@ -1118,11 +1144,12 @@ static struct encoding *git_path_check_encoding(struct attr_check_item *check)
 	const char *value = check->value;
 	struct encoding *enc;

-	if (ATTR_UNSET(value))
+	if (ATTR_TRUE(value) || ATTR_FALSE(value) || ATTR_UNSET(value) ||
+	    !strlen(value))
 		return NULL;

 	for (enc = encoding; enc; enc = enc->next)
-		if (!strcmp(value, enc->name))
+		if (!strcasecmp(value, enc->name))
 			return enc;

 	/* Don't encode to the default encoding */
@@ -1130,9 +1157,7 @@ static struct encoding *git_path_check_encoding(struct attr_check_item *check)
 		return NULL;

 	enc = xcalloc(1, sizeof(struct convert_driver));
-	enc->name = xstrdup(value);
-	enc->to_git = invalid_conversion;
-	enc->to_worktree = invalid_conversion;
+	enc->name = xstrdup_toupper(value);  /* aways use upper case names! */
 	*encoding_tail = enc;
 	encoding_tail = &(enc->next);

@@ -1194,7 +1219,7 @@ struct conv_attrs {
 	enum crlf_action attr_action; /* What attr says */
 	enum crlf_action crlf_action; /* When no attr is set, use core.autocrlf */
 	int ident;
-	struct encoding *encoding; /* Supported encoding or default encoding if NULL */
+	struct encoding *checkout_encoding; /* Supported encoding or default encoding if NULL */
 };

 static void convert_attrs(struct conv_attrs *ca, const char *path)
@@ -1203,7 +1228,8 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)

 	if (!check) {
 		check = attr_check_initl("crlf", "ident", "filter",
-					 "eol", "text", "encoding", NULL);
+					 "eol", "text", "checkout-encoding",
+					 NULL);
 		user_convert_tail = &user_convert;
 		encoding_tail = &encoding;
 		git_config(read_convert_config, NULL);
@@ -1227,7 +1253,7 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
 			else if (eol_attr == EOL_CRLF)
 				ca->crlf_action = CRLF_TEXT_CRLF;
 		}
-		ca->encoding = git_path_check_encoding(ccheck + 5);
+		ca->checkout_encoding = git_path_check_encoding(ccheck + 5);
 	} else {
 		ca->drv = NULL;
 		ca->crlf_action = CRLF_UNDEFINED;
@@ -1293,7 +1319,7 @@ const char *get_convert_attr_ascii(const char *path)

 int convert_to_git(const struct index_state *istate,
 		   const char *path, const char *src, size_t len,
-                   struct strbuf *dst, enum safe_crlf checksafe)
+		   struct strbuf *dst, enum safe_crlf checksafe, int write_obj)
 {
 	int ret = 0;
 	struct conv_attrs ca;
@@ -1309,7 +1335,7 @@ int convert_to_git(const struct index_state *istate,
 		len = dst->len;
 	}

-	ret |= encode_to_git(path, src, len, dst, ca.encoding);
+	ret |= encode_to_git(path, src, len, dst, ca.checkout_encoding, write_obj);
 	if (ret && dst) {
 		src = dst->buf;
 		len = dst->len;
@@ -1327,7 +1353,7 @@ int convert_to_git(const struct index_state *istate,

 void convert_to_git_filter_fd(const struct index_state *istate,
 			      const char *path, int fd, struct strbuf *dst,
-			      enum safe_crlf checksafe)
+			      enum safe_crlf checksafe, int write_obj)
 {
 	struct conv_attrs ca;
 	convert_attrs(&ca, path);
@@ -1338,7 +1364,7 @@ void convert_to_git_filter_fd(const struct index_state *istate,
 	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv, CAP_CLEAN, NULL))
 		die("%s: clean filter '%s' failed", path, ca.drv->name);

-	encode_to_git(path, dst->buf, dst->len, dst, ca.encoding);
+	encode_to_git(path, dst->buf, dst->len, dst, ca.checkout_encoding, write_obj);
 	crlf_to_git(istate, path, dst->buf, dst->len, dst, ca.crlf_action, checksafe);
 	ident_to_git(path, dst->buf, dst->len, dst, ca.ident);
 }
@@ -1370,7 +1396,7 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
 		}
 	}

-	ret |= encode_to_worktree(path, src, len, dst, ca.encoding);
+	ret |= encode_to_worktree(path, src, len, dst, ca.checkout_encoding);
 	if (ret) {
 		src = dst->buf;
 		len = dst->len;
@@ -1404,7 +1430,7 @@ int renormalize_buffer(const struct index_state *istate, const char *path,
 		src = dst->buf;
 		len = dst->len;
 	}
-	return ret | convert_to_git(istate, path, src, len, dst, SAFE_CRLF_RENORMALIZE);
+	return ret | convert_to_git(istate, path, src, len, dst, SAFE_CRLF_RENORMALIZE, 0);
 }

 /*****************************************************************
@@ -1842,7 +1868,7 @@ struct stream_filter *get_stream_filter(const char *path, const unsigned char *s
 	if (ca.drv && (ca.drv->process || ca.drv->smudge || ca.drv->clean))
 		return NULL;

-	if (ca.encoding)
+	if (ca.checkout_encoding)
 		return NULL;

 	if (ca.crlf_action == CRLF_AUTO || ca.crlf_action == CRLF_AUTO_CRLF)
diff --git a/convert.h b/convert.h
index 4f2da225a8..9e4e884ec1 100644
--- a/convert.h
+++ b/convert.h
@@ -66,7 +66,8 @@ extern const char *get_convert_attr_ascii(const char *path);
 /* returns 1 if *dst was used */
 extern int convert_to_git(const struct index_state *istate,
 			  const char *path, const char *src, size_t len,
-			  struct strbuf *dst, enum safe_crlf checksafe);
+			  struct strbuf *dst, enum safe_crlf checksafe,
+			  int write_obj);
 extern int convert_to_working_tree(const char *path, const char *src,
 				   size_t len, struct strbuf *dst);
 extern int async_convert_to_working_tree(const char *path, const char *src,
@@ -79,13 +80,14 @@ extern int renormalize_buffer(const struct index_state *istate,
 static inline int would_convert_to_git(const struct index_state *istate,
 				       const char *path)
 {
-	return convert_to_git(istate, path, NULL, 0, NULL, 0);
+	return convert_to_git(istate, path, NULL, 0, NULL, 0, 0);
 }
 /* Precondition: would_convert_to_git_filter_fd(path) == true */
 extern void convert_to_git_filter_fd(const struct index_state *istate,
 				     const char *path, int fd,
 				     struct strbuf *dst,
-				     enum safe_crlf checksafe);
+				     enum safe_crlf checksafe,
+				     int write_obj);
 extern int would_convert_to_git_filter_fd(const char *path);

 /*****************************************************************
diff --git a/diff.c b/diff.c
index 2ebe2227b4..16ca0bf0df 100644
--- a/diff.c
+++ b/diff.c
@@ -3599,7 +3599,7 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
 		/*
 		 * Convert from working tree format to canonical git format
 		 */
-		if (convert_to_git(&the_index, s->path, s->data, s->size, &buf, crlf_warn)) {
+		if (convert_to_git(&the_index, s->path, s->data, s->size, &buf, crlf_warn, 0)) {
 			size_t size = 0;
 			munmap(s->data, s->size);
 			s->should_munmap = 0;
diff --git a/sha1_file.c b/sha1_file.c
index afe4b90f6e..75800248d2 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1694,7 +1694,8 @@ static int index_mem(struct object_id *oid, void *buf, size_t size,
 	if ((type == OBJ_BLOB) && path) {
 		struct strbuf nbuf = STRBUF_INIT;
 		if (convert_to_git(&the_index, path, buf, size, &nbuf,
-				   get_safe_crlf(flags))) {
+				   get_safe_crlf(flags),
+				   write_object)) {
 			buf = strbuf_detach(&nbuf, &size);
 			re_allocated = 1;
 		}
@@ -1728,7 +1729,7 @@ static int index_stream_convert_blob(struct object_id *oid, int fd,
 	assert(would_convert_to_git_filter_fd(path));

 	convert_to_git_filter_fd(&the_index, path, fd, &sbuf,
-				 get_safe_crlf(flags));
+				 get_safe_crlf(flags), write_object);

 	if (write_object)
 		ret = write_sha1_file(sbuf.buf, sbuf.len, typename(OBJ_BLOB),
diff --git a/strbuf.c b/strbuf.c
index 323c49ceb3..54276e96e7 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -760,6 +760,19 @@ char *xstrdup_tolower(const char *string)
 	return result;
 }

+char *xstrdup_toupper(const char *string)
+{
+	char *result;
+	size_t len, i;
+
+	len = strlen(string);
+	result = xmallocz(len);
+	for (i = 0; i < len; i++)
+		result[i] = toupper(string[i]);
+	result[i] = '\0';
+	return result;
+}
+
 char *xstrvfmt(const char *fmt, va_list ap)
 {
 	struct strbuf buf = STRBUF_INIT;
diff --git a/strbuf.h b/strbuf.h
index 0a74acb236..2bc148526f 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -616,6 +616,7 @@ __attribute__((format (printf,2,3)))
 extern int fprintf_ln(FILE *fp, const char *fmt, ...);

 char *xstrdup_tolower(const char *);
+char *xstrdup_toupper(const char *);

 /**
  * Create a newly allocated string using printf format. You can do this easily
diff --git a/t/t0028-checkout-encoding.sh b/t/t0028-checkout-encoding.sh
new file mode 100755
index 0000000000..df3cc91269
--- /dev/null
+++ b/t/t0028-checkout-encoding.sh
@@ -0,0 +1,199 @@
+#!/bin/sh
+
+test_description='checkout-encoding conversion via gitattributes'
+
+. ./test-lib.sh
+
+GIT_TRACE_CHECKOUT_ENCODING=1 && export GIT_TRACE_CHECKOUT_ENCODING
+
+test_expect_success 'setup test repo' '
+
+	text="hallo there!\ncan you read me?" &&
+
+	echo "*.utf16 text checkout-encoding=utf-16" >.gitattributes &&
+
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
+	echo "*.utf16be text checkout-encoding=utf-16be" >>.gitattributes &&
+	echo "*.utf16le text checkout-encoding=utf-16le" >>.gitattributes &&
+	echo "*.utf32be text checkout-encoding=utf-32be" >>.gitattributes &&
+	echo "*.utf32le text checkout-encoding=utf-32le" >>.gitattributes &&
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
+	echo "*.utf32 text checkout-encoding=utf-32" >>.gitattributes &&
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
+	echo "*.nothing text checkout-encoding=" >>.gitattributes &&
+	printf "nothing" >t.nothing &&
+	git add t.nothing &&
+
+	echo "*.garbage text checkout-encoding=garbage" >>.gitattributes &&
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
+	# This simulates a Git version that has no checkoutEncoding support
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
diff --git a/t/t0028-encoding.sh b/t/t0028-encoding.sh
deleted file mode 100755
index 24f24f9e0d..0000000000
--- a/t/t0028-encoding.sh
+++ /dev/null
@@ -1,60 +0,0 @@
-#!/bin/sh
-
-test_description='encoding conversion via gitattributes'
-
-. ./test-lib.sh
-
-test_expect_success 'setup test repo' '
-
-	text="hallo there!\ncan you read me?" &&
-
-	echo "*.utf16 text encoding=utf-16" >.gitattributes &&
-	printf "$text" >t.utf8.raw &&
-	printf "$text" | iconv -f UTF-8 -t UTF-16 >t.utf16.raw &&
-	cp t.utf16.raw t.utf16 &&
-
-	git add .gitattributes t.utf16.raw t.utf16 &&
-	git commit -m initial
-'
-
-test_expect_success 'ensure UTF-8 is stored in Git' '
-	git cat-file -p :t.utf16 >t.utf16.git &&
-	test_cmp_bin t.utf8.raw t.utf16.git
-'
-
-test_expect_success 're-encode to UTF-16 on checkout' '
-	rm t.utf16 &&
-	git checkout t.utf16 &&
-	test_cmp_bin t.utf16.raw t.utf16
-'
-
-test_expect_success 'warn if an unsupported encoding is used' '
-	echo "*.garbage text encoding=garbage" >>.gitattributes &&
-	printf "garbage" >t.garbage &&
-	git add t.garbage 2>error.out &&
-	test_i18ngrep "warning: unsupported encoding" error.out &&
-
-	# cleanup
-	git reset --hard HEAD
-'
-
-test_expect_success 'fail if files with invalid encoding are added' '
-	printf "\0\0h\0a" >error.utf16 &&
-	# The test string encoding would fail
-	# test_must_fail iconv -f utf-16 -t utf-8 error.utf16 &&
-	test_must_fail git add error.utf16
-'
-
-# Some sequences might trigger errno == E2BIG in reencode_string_iconv, utf.8.
-# This would cause no error on "git add" and, consequently, the Git internal
-# UTF-8 encoded blob would contain garbage. Hence, the worktree file after a
-# checkout would contain garbage, too. This garbage would not match the file
-# that was initially added.
-test_expect_success 'fail if encoding from X to UTF-8 and back to X is not the same' '
-	printf "\xc3\x28" >error.utf16 &&
-	# The test string re-encoding would fail
-	# iconv -f utf-16 -t utf-8 error.utf16 | iconv -f utf-8 -t utf-16 &&
-	test_must_fail git add error.utf16
-'
-
-test_done
diff --git a/utf8.c b/utf8.c
index 2c27ce0137..1978d6c42a 100644
--- a/utf8.c
+++ b/utf8.c
@@ -538,6 +538,43 @@ char *reencode_string_len(const char *in, int insz,
 }
 #endif

+static int has_bom_prefix(const char *data, size_t len,
+			  const char *bom, size_t bom_len)
+{
+	return (len >= bom_len) && !memcmp(data, bom, bom_len);
+}
+
+const char utf16_be_bom[] = {0xFE, 0xFF};
+const char utf16_le_bom[] = {0xFF, 0xFE};
+const char utf32_be_bom[] = {0x00, 0x00, 0xFE, 0xFF};
+const char utf32_le_bom[] = {0xFF, 0xFE, 0x00, 0x00};
+
+int has_prohibited_utf_bom(const char *enc, const char *data, size_t len)
+{
+	return (
+	  (!strcmp(enc, "UTF-16BE") || !strcmp(enc, "UTF-16LE")) &&
+	  (has_bom_prefix(data, len, utf16_be_bom, sizeof(utf16_be_bom)) ||
+	   has_bom_prefix(data, len, utf16_le_bom, sizeof(utf16_le_bom)))
+	) || (
+	  (!strcmp(enc, "UTF-32BE") || !strcmp(enc, "UTF-32LE")) &&
+	  (has_bom_prefix(data, len, utf32_be_bom, sizeof(utf32_be_bom)) ||
+	   has_bom_prefix(data, len, utf32_le_bom, sizeof(utf32_le_bom)))
+	);
+}
+
+int has_missing_utf_bom(const char *enc, const char *data, size_t len)
+{
+	return (
+	   !strcmp(enc, "UTF-16") &&
+	   !(has_bom_prefix(data, len, utf16_be_bom, sizeof(utf16_be_bom)) ||
+	     has_bom_prefix(data, len, utf16_le_bom, sizeof(utf16_le_bom)))
+	) || (
+	   !strcmp(enc, "UTF-32") &&
+	   !(has_bom_prefix(data, len, utf32_be_bom, sizeof(utf32_be_bom)) ||
+	     has_bom_prefix(data, len, utf32_le_bom, sizeof(utf32_le_bom)))
+	);
+}
+
 /*
  * Returns first character length in bytes for multi-byte `text` according to
  * `encoding`.
diff --git a/utf8.h b/utf8.h
index 6bbcf31a83..26b5e91852 100644
--- a/utf8.h
+++ b/utf8.h
@@ -70,4 +70,29 @@ typedef enum {
 void strbuf_utf8_align(struct strbuf *buf, align_type position, unsigned int width,
 		       const char *s);

+/*
+ * Whenever a data stream is declared to be UTF-16BE, UTF-16LE, UTF-32BE
+ * or UTF-32LE a BOM must not be used [1]. The function returns true if
+ * this is the case.
+ *
+ * [1] http://unicode.org/faq/utf_bom.html#bom10
+ */
+int has_prohibited_utf_bom(const char *enc, const char *data, size_t len);
+
+/*
+ * If the endianness is not defined in the encoding name, then we
+ * require a BOM. The function returns true if a required BOM is missing.
+ *
+ * The Unicode standard instructs to assume big-endian if there
+ * in no BOM for UTF-16/32 [1][2]. However, the W3C/WHATWG
+ * encoding standard used in HTML5 recommends to assume
+ * little-endian to "deal with deployed content" [3].
+ *
+ * [1] http://unicode.org/faq/utf_bom.html#gen6
+ * [2] http://www.unicode.org/versions/Unicode10.0.0/ch03.pdf
+ *     Section 3.10, D98, page 132
+ * [3] https://encoding.spec.whatwg.org/#utf-16le
+ */
+int has_missing_utf_bom(const char *enc, const char *data, size_t len);
+
 #endif


### Patches

Lars Schneider (5):
  strbuf: add xstrdup_toupper()
  utf8: add function to detect prohibited UTF-16/32 BOM
  utf8: add function to detect a missing UTF-16/32 BOM
  convert: add support for 'checkout-encoding' attribute
  convert: add tracing for checkout-encoding

 Documentation/gitattributes.txt |  59 +++++++++++
 apply.c                         |   2 +-
 blame.c                         |   2 +-
 combine-diff.c                  |   2 +-
 convert.c                       | 224 +++++++++++++++++++++++++++++++++++++++-
 convert.h                       |   8 +-
 diff.c                          |   2 +-
 sha1_file.c                     |   5 +-
 strbuf.c                        |  13 +++
 strbuf.h                        |   1 +
 t/t0028-checkout-encoding.sh    | 199 +++++++++++++++++++++++++++++++++++
 utf8.c                          |  37 +++++++
 utf8.h                          |  25 +++++
 13 files changed, 566 insertions(+), 13 deletions(-)
 create mode 100755 t/t0028-checkout-encoding.sh


base-commit: 95ec6b1b3393eb6e26da40c565520a8db9796e9f
--
2.15.1

