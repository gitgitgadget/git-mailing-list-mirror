Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A1A81F404
	for <e@80x24.org>; Thu, 15 Feb 2018 18:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163715AbeBOSP6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 13:15:58 -0500
Received: from mail-by2nam01on0096.outbound.protection.outlook.com ([104.47.34.96]:49632
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1163640AbeBOP1k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 10:27:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=kVHopqP8qzWQOvKHFzLSm0lWCGpcdlXMEImmvHkcjoQ=;
 b=YjTMsNHGr6lnr0FPcSGCRSuMz8gqO1Iy9+k+wsDQoyGgC2VaXfeTaYD0+6lz+m6NGAVhyRo6TcR/1+Mlf2OfUKSRMhqV7StvqBj/oyXrBe2qPGJzTTNjGqXysC19N8h9fY1gGpUM1c4hAf+Rq5J1RktMWLY2XoQdW02Ci4BZZn8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxbook4.ads.autodesk.com (62.159.156.210) by
 BN6P136MB0020.NAMP136.PROD.OUTLOOK.COM (129.75.91.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.464.14; Thu, 15 Feb 2018 15:27:35 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v7 5/7] convert: add 'working-tree-encoding' attribute
Date:   Thu, 15 Feb 2018 16:27:09 +0100
Message-Id: <20180215152711.158-6-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215152711.158-1-lars.schneider@autodesk.com>
References: <20180215152711.158-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [62.159.156.210]
X-ClientProxiedBy: DM3PR12CA0049.namprd12.prod.outlook.com (10.161.151.17) To
 BN6P136MB0020.NAMP136.PROD.OUTLOOK.COM (129.75.91.27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c2744309-2da9-4c4c-57d7-08d57488a4e8
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:BN6P136MB0020;
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0020;3:vtDN72a4nfz7T8XvgbYfNybuVBIL1ppDc0/pkgBoFEhs38T1Pnd3LSjVZUS+vh7OZ8QCRcKagDF7LjyFUuT6r6EJKMqZICCsd2I6PneDemwmmiDbPb7RRci0f+JgAO+O28lLIrPDoeLzeYCrr6BSOo0oL1h/4o2te3/VHBT2DGFWRmA7HWfC/KYqOHBLa+J5akxOuEaHkMk5c3kDZOK42c2+mm61ESZ+MRNWFQb6aV4dS31QYsnZWA4cjAT2qgMy;25:KpYnWvbMX5xqGqNH5HLkXP43KBP3R6PtJLYjrvobo3FDc77AthweSmlVea8Pv8USDm9ZrF/zt9lGGzVpnVeEgtd/2xw78x9TkvKNKHQkiVLDzVdASc5juy06ITr+f/kYD1EZa713/cqg6R7FignF5TdSAO2+jhBDFtwNaEVGele/Aei0i9GBZPXsplOp901P0VZhC+fN00+WWrHaEHXWwKASPhpxt74bS1ckNxeT5AIbdjywXx9/LdEcHSb7JqGIFsdPmWzwr9hWd67ldoWkGZTIf85N54CJtl0uUc2Cwz11vpZOlCBdrIXFMxDKdLLHKwt4kn1GO6u7plCF2lwiFA==;31:Cwgk2HYANOJWOxc+WxybRv/8oVDGSAoxjFGcvY4jSB1Bea4AqQVNalJkE2JfvA59ocARflXtRYAddaPXVMUz8UZkh/BnRZ2J3g9xQOCjloXiQHJGb4nVjmriK+dO2w57XjXKezjUVrMKvdTcYhExXeAxh5a3RL0NNLQXsHrvZp6bngE2Q0ikFxkAH3q9F9mM2gLx769kA16AlGq4MVvyVladQakTIzJ3B3lDUOCWEBs=
X-MS-TrafficTypeDiagnostic: BN6P136MB0020:
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0020;20:OKZW9nDI4+JwuQsLMi9vs9BYBK54VMQGpQ7zzcOpZT5COgExEllJXI5aKsXuYAJ0H9FJSrmvh41S6PdI8sEBZ95yax82/74vHKJmcITDWdpFWJLGoOrDIwlsGiA6sR4MvvxLK8K5Uy7UgltaIaxY8L+lS7ZnxUU6BZc9BsJbQx9n4xdnjrjTT0eizojD2Js75Ij00Nh2zZ8gVs/yBYczdRJAmdXCnM0pJ6iwaigSw4RhgLtyGmIkyzxbGcwAc+KNL+OBV9rSSdadwUnZ2981aSghb+9yTX+BPDXRUSmh+0t5UcYwDaMyblGTz5dzQ5VxiQqUyJfLDROWOLzcjQw/R4S1ftJbPLP+yfgTXkTuJXXgpVJhpASYe26HpuDY5FK8x/K6W7kdSl+3qug6aPaMeT9F+Nmdp8bxn7U02QkRZaD5sO6r/WqXDRX2D2worS809rMwSFirQLmP1lCRD8bYslnlfNzvFKwtpK9v4etCosIDykwC+Mey1U2GIcalObNCARAdo7KB5k8EaygAdeEPudl27Z0J7NI4MuCE6kc58pYA3OsC0rsfy7coz63UmHO/6MM3N6nuxqul8Sqgt1Iv1BQwLpeeFS38hibECFtdAmg=;4:DBfuYeZNCR7ft6zYygWg24WtqzmuJEJijiCXrZ4pQkUaoIw7jnScphyyrkPFZ+Jv9yh9QHCWgQDXDWJTO/vOiWoRlgXbIl4leoB0A1AcISzwOWbuBqfOKcqtBv+fXQ279r3Q/r4YRTwORX82asGjpupxGJk9P4wPX8OjHjBQZEq+ndMumjJX85u8Dp/s/9puIgKQKWeL5MthP7Za+EFH2LMUSQv0Zb4Og1u8TTOxlEciiwY19dR8ooXqpExAztNLuvIo9/GwzL59c2Q5sSDldRRRmMXAJ3pSho8OXoNWcjlBvvnlPiZ0bYbbfvAbWq04
X-Microsoft-Antispam-PRVS: <BN6P136MB0020F973CDD1513490680F9BE8F40@BN6P136MB0020.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:BN6P136MB0020;BCL:0;PCL:0;RULEID:;SRVR:BN6P136MB0020;
X-Forefront-PRVS: 058441C12A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(39380400002)(366004)(396003)(199004)(189003)(81166006)(8666007)(85782001)(186003)(5660300001)(1076002)(6116002)(50226002)(3846002)(86362001)(305945005)(97736004)(106356001)(16526019)(2906002)(478600001)(6916009)(26005)(25786009)(575784001)(81156014)(105586002)(8936002)(48376002)(5890100001)(47776003)(51416003)(76176011)(2361001)(36756003)(6486002)(66066001)(8656006)(8676002)(68736007)(50466002)(316002)(59450400001)(7736002)(2351001)(7696005)(53936002)(386003)(52116002)(9686003)(6666003)(4326008)(39060400002)(16586007)(2950100002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6P136MB0020;H:slxbook4.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6P136MB0020;23:iVzuX23Hc3MI4Pmf+850Qz3RvyHvGlBhLNdjFPbhb?=
 =?us-ascii?Q?1RFWjXrsYLlfbnvA6v0yx2rAOBxmSkDiD2YIWWHb+hqWiTQM+vq+lO4NK9r+?=
 =?us-ascii?Q?ZgRNsWql6gDsQ7CHIvgsGVc9UfvMVzLwT6z9ZN3yGfpgO/9IlfeIdvXO7uc8?=
 =?us-ascii?Q?TzEhYG5riZeWDMRaLWe9ulSnnZn+ucf8NQhBYvlyEqbMD1NU+izXuCrTy1nG?=
 =?us-ascii?Q?Xo5bfFIe/WAnX3E3vDfvfay3ABqvrE2AnZ5n0EW0HoY+1xhj6Rz5p93zXkk/?=
 =?us-ascii?Q?FmwIQGmIdzY3Yr2rVS2ezp2E5L2IhvIIQnzjZjkAIlhetS+QWUFFoz5GqE4x?=
 =?us-ascii?Q?2Q/WuU0Svq1EaYbVsCPc4k0OIl2Yypys2ZBVKu4EnbNCILIH416DfSCp0+jO?=
 =?us-ascii?Q?g0pqV9PzTItp/AEj3c8EB9MLzlM9UeZDLrWzqTQ080Ye1GoqkRBK1keuxmYc?=
 =?us-ascii?Q?6m+3PxWfSakaoX42gOVz0+d7FWkN0eVAaMxH7z7wk8tXdYmOXSv5PqRc6NCl?=
 =?us-ascii?Q?RggJis9U+ciXgx5lfy5cziuYh+vz9k5GUKGquecKr7wNLiOub5wNEIB6DrK8?=
 =?us-ascii?Q?PQyuAxKIxNCIcqJgrXEaZS4pypkWYvw8YBqHwKakJh8wlF6ojP2HdqZwz3t1?=
 =?us-ascii?Q?Tm1qAiaM4lzAhKwE94sHUaG/8XbrKAIqJUlNfkg0Z4X3DE4f72rhxSSlybUw?=
 =?us-ascii?Q?LRBN4dyuogHHpK0Jyeu5lhWOkC9K1pYNkxRhL4/NnP5imWFrTJntuRtC92Yh?=
 =?us-ascii?Q?hue5SWP9xxo7GNdSl9aiKGxLxQ2QYipJi6Y+NGQxw2tVIkhkk6uOJLAvNvuf?=
 =?us-ascii?Q?TwhTfTtP8CxXsUahSYvkhwffxl+E7xc76iCgv+d0Bz8N8RUpuB03w62RSzyx?=
 =?us-ascii?Q?jxdJj+zhY4g0808O3unknfb1Nv7IHZ0nQ3xyoqJMAUerl4gbGaNRnIfqV9ZH?=
 =?us-ascii?Q?uzG7ZjzLlFSESx4sRvNmXC848m2iVXgjqEHih8r3m5Ey7Wn9/I/1/gukf0FN?=
 =?us-ascii?Q?wTArM7G+Z/OiP4z9t9i655rgNiCFr25n5iQj4TbG3ZKSU4g2cb0p8MDdYSU9?=
 =?us-ascii?Q?H4Hjx8lCYkFp7M++G7zTkyASij3n1pvlaHbI3KDUO1gpdqeba3uLkJcbL8tq?=
 =?us-ascii?Q?wRGYLN8NHYC5lu9rntfnUZnuxcLEU5zUzE4SVmOjZdvACSxUQrDMmesO+3mz?=
 =?us-ascii?Q?BOND4XEtCuGAxlVeUOTVzo639S/TA2Q1aU5+5ADc9g8LHfxu8sGnKLKcYdtM?=
 =?us-ascii?Q?gAnaa21T7R/+RQ/f3J+awydaSJS8xWwkdFGAusS6pZ/+6P7oIkwTET9WqqjF?=
 =?us-ascii?Q?cO2mUkWMJS2Y5sW0+G9DfYYOJ88dgPX9tiMv5DgSrKU?=
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0020;6:+dEuu5Jjnig7OQAqgl59z5B8+3+VavSsVuBnhzUxUeyJ81JPUInC2b4/znUFm/uwwnmVu1i9c1PAYXLe86PB2qg13/4UcxFmS8CKTB01d5sV1PCMuC2f9skoH+1U3yOJkIvYxczl6r6MsYI0s+bf8fiPyiX3AQ6zxtDm7DGoq+Oeauuuj4KQghbALugv03d+9GikN1V3bolaM8HGmxdIEuZOEoLrkw78c4kbfx2QOka+ggZmNHoueYtwcVxXwl4LCUhVC4Q6oP81hwPl3HKOdlol0lPuZIqEzduEI+7iGYKnuZFG7DBbvkurxCTm2MC6aRZPEC3sEXVHmRBS+F84fzUkZslZ90I4oHlLFwp9+cg=;5:klFKn5+D4Aixx0qjU0G3DOJ5+6rzEGOzhjBu5C1CZ4vVxfagaEejgLnZ0+liqqsG4HP7oo07dr2R1vluzwKo9llE5LirHpOslSHFhTV/qdDhBIeM9aAiyYb6vUxYF8iHCzfMOx7aCWHdB/fPeKsGc6BDGjQYL4zh8udwdu4m0n0=;24:VW/mcQUR2dt7aIssqqr84uWLqoSCr3WYwgXQTMgd5qbsuwu0uGtiLZeTapP/vTyWbzcQkR8+WVWgpmXTjpfm6T8dSKvnTlxQ46PmqtYBt88=;7:kIdIDJqnzpldboVOvWKXPs7VsCxDyJ5wqDIE6LKRWdgZLAqhWpperJxzyXl/j995jFMZzkpEIDLF3wn+2DLCdBVSsD7dpsoyMmXOVassYocnyj0zVaevnVdoCnD8h/L1ZZUtgCaaLbB3zrBoOzJnZyWhuLIn1DuGRQYwE0HTXOYJCAflVZxXx57nBQ9fbcEI8AgxXCGCnaiLCRqDk5K4m+7Ct8y/XtGpgfjJsoTiixEmonz7Y0JY5IVAlVp5sfWm
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2018 15:27:35.4795 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2744309-2da9-4c4c-57d7-08d57488a4e8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6P136MB0020
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
index 30687de81a..5ec179d631 100644
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
+- Third party Git implementations that do not support the
+  `working-tree-encoding` attribute will checkout the respective files
+  UTF-8 encoded and not in the expected encoding. Consequently, these
+  files will appear different which typically causes trouble. This is
+  in particular the case for older Git versions and alternative Git
+  implementations such as JGit or libgit2 (as of February 2018).
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
+*.proj 		text working-tree-encoding=UTF-16LE eol=CRLF
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
index b976eb968c..d20c341b6d 100644
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
+			"BOM is prohibited in '%s' if encoded as %s");
+		/*
+		 * This advise is shown for UTF-??BE and UTF-??LE encodings.
+		 * We truncate the encoding name to 6 chars with %.6s to cut
+		 * off the last two "byte order" characters.
+		 */
+		const char *advise_msg = _(
+			"The file '%s' contains a byte order mark (BOM). "
+			"Please use %.6s as working-tree-encoding.");
+		advise(advise_msg, path, enc->name);
+		if (conv_flags & CONV_WRITE_OBJECT)
+			die(error_msg, path, enc->name);
+		else
+			error(error_msg, path, enc->name);
+
+	} else if (is_missing_required_utf_bom(enc->name, src, src_len)) {
+		const char *error_msg = _(
+			"BOM is required in '%s' if encoded as %s");
+		const char *advise_msg = _(
+			"The file '%s' is missing a byte order mark (BOM). "
+			"Please use %sBE or %sLE (depending on the byte order) "
+			"as working-tree-encoding.");
+		advise(advise_msg, path, enc->name, enc->name);
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

