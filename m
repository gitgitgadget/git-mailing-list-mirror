Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C95651F404
	for <e@80x24.org>; Sat, 24 Feb 2018 16:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751499AbeBXQ3p (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Feb 2018 11:29:45 -0500
Received: from mail-cys01nam02on0121.outbound.protection.outlook.com ([104.47.37.121]:55968
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751465AbeBXQ3j (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Feb 2018 11:29:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Crfq43rf/cjuJcpiqmwTr5rrepwNDhW/TuK9xMvZmPs=;
 b=PbnoaYb2wu1CzHGwEbSQvzFdlDgSZur7O3YJFvOTAav+GgWHY/oCe0FF3W4CUGhlZ7EJ9mLYp273IM6JrcBo4X00igoZ3p0lKzMGXEDoCCZpYpNSBiVCtsWK+SXXCGvbBMrR0r6dWkQuum4ZSNH6i6A84QGlOljCeA7QzHnWMLQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from localhost.localdomain (132.188.32.100) by
 CY4P136MB0007.NAMP136.PROD.OUTLOOK.COM (2603:10b6:923:12::22) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.506.26; Sat, 24
 Feb 2018 16:28:43 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v8 5/7] convert: add 'working-tree-encoding' attribute
Date:   Sat, 24 Feb 2018 17:27:59 +0100
Message-Id: <20180224162801.98860-6-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180224162801.98860-1-lars.schneider@autodesk.com>
References: <20180224162801.98860-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.32.100]
X-ClientProxiedBy: CY4PR1201CA0003.namprd12.prod.outlook.com
 (2603:10b6:910:16::13) To CY4P136MB0007.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:923:12::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cc1096b9-295f-472f-62b2-08d57ba3ad51
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY4P136MB0007;
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0007;3:mDkgvb8cBU2pdRAYlzXjQVi6NooDp3aHZw+P4KJRtMkcDrWU8hwBZBTZsdicWApSBMKdxR8yyw8ODKXuCSQKWxh09vlqLfa5Tsp/YlztJF4ghb7lH81uHAVlZmR6j2Gj619qe2jpoc/bURfd5u7rxCyMQQQT9PFbvS7qfFT/Czko4yzt2G11vuhO40zcL78HFSlUKzqmUUCoF8SImkwGWxTWEbZ5iDjU6DM/P504QWiFrj+mhiJn3ERH24kw0S38;25:EfJ3hUay6/wYmqTtbCMvK1gvSLETSpf3uhYfau5HeIdo5qKO3jQ4ubkmku2k90DIfPtXvzwAjvk+zc3P/ZUt5FECVjoT0Cvy15dyL+5J+UsYz2SaZigsTfCmP3mq02dnjmQ/VKnxAXKlK2hGkleZ+WKuCMnYVmlefijUOkU4cXSc6MRF1k8qdT4u2AH9pVdAzIOP643HWAOCEwPbQoq7sB+R1TCD4F006Cdy4Y00vUmZRnQ5ToCCv7BnJveS8uUsixLxHSRSxXTwq5UKBze7F1TfGjjT8jHmU+gaakh74kpkM+xiLVfBeQt3dRO4nwgkDY89vngHAmlsSNolfG3MOw==;31:C9ab4xwkKS1A8YjZc1BBsR2dGWUgicQn7KHlaKc0ijVAw3O8An0HiCdMOBeidA/JVJLHKCeguo7Ta8mKnW8YR0fwc4J56YI5/flTOLDK0gKfbr0B4GzIq3FFgO9/FOwco2Rm5dJHops1jT2AoXP64QShLijFniLUvjg/0A3slCmcSIi3SIl4y02zJLJtnaCMs3n5QUfuRjY5QK3h8Dq52tYdBD51sZjUNBojOv0pWjg=
X-MS-TrafficTypeDiagnostic: CY4P136MB0007:
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0007;20:B10zgBFxPxd732ndMLpzENXTiT9lNgh6DiciMxouyG+yf96skfvPy2kH8fyxQEO9+hDfMiH5Z97lg48RjP+NaQsJ8bq4xHJpSoph+nBUJ51yz4CPRRjwxgJROKnxRKXnh6Kz9xndfjdd7GpTFdfwIlsA/M3fxm2NjjGrK+v+eWdMYrB8f9oZfpcDD6E1IzgLz2koTJiSpd7vXobfm/7JnEwnKp6OxaylmnX2ymjhYJZ1UNFJP3EgiTKh0ZJhm6WIMRV5O21gC4q1rFCqWbS0iO+VLWjQPvA/1AijiX/8VxyTcC1E2QQwVopyLW62eVswhRsQ/AIxVT0gjQj1NqGh55s5MRRE6CrMqarg//anu72e3zFkpUs1jmTsSRQJ0f8dDqO1nCLOInlG7jM8xBSr2TewKYeMVCwTCnUIUDCMosezpw6M83aNSM+TO1EKk2kjK33XZ0kgzWEG79lHf/KK+6PzeV53nh91A8jB0aNVCueYOG8lfNHs00xMZqh85B5DcFIfSMxpoQhk7id4Jc6MJH+xKPhVFMt9gCo8xQebaQgpWE9PMZ1siummT2WEpe1IYh+whK1ciIaNXeteVKderQVIHE1nL26GNUpJKFrohJs=;4:cg2DJeWhKIgeDeGS1BbCgef8WqK5dsdRx9sJy+NEl+JFiWpQI5gjE/35Sv5rerw9HAWUcSi0tUriZbdvuwKp5pYKDoPbcFROhNEyE4LpI3AMckPfqfqhuB49cYrm2fCwcdcpBpcTcQSsn7jvFAkFiiWYVuEdaRrFSltlo7i4sy1kiCpEYD+FjTxt06FjJp6NPeVJgtNgdotfc+YZsIhpQwd4RwL7EeUIk8puau1k3EG5oQ5UuOVrQ+eVZxeM4S4+a62+zUQBCvMa5FYX2Mgkkw==
X-Exchange-Antispam-Report-CFA: BCL:0;PCL:0;RULEID:(3231001);SRVR:CY4P136MB0007;BCL:0;PCL:0;RULEID:;SRVR:CY4P136MB0007;
X-Forefront-PRVS: 0593E261C4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(199004)(189003)(8656006)(5660300001)(7736002)(66066001)(50226002)(47776003)(97736004)(8936002)(6512007)(9686003)(305945005)(8666007)(6486002)(106356001)(36756003)(2351001)(2361001)(8676002)(81156014)(48376002)(68736007)(50466002)(5890100001)(85782001)(16586007)(33896004)(59450400001)(6506007)(386003)(105586002)(86362001)(26005)(6116002)(3846002)(1076002)(16526019)(186003)(52116002)(2950100002)(51416003)(39060400002)(76176011)(6666003)(4326008)(25786009)(6916009)(575784001)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4P136MB0007;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4P136MB0007;23:0MayKzDuqzSp9jEoPiA2kriI57EiBkIeTb3GZog9/?=
 =?us-ascii?Q?RnrQKROcbtM7LXms+nIOPBP8lhSwSU3Doiy6JF2/973LYc8mXPTBpP+2aU3Z?=
 =?us-ascii?Q?cG9z39vis98D1AtnIezgzpfWZkAEx7v10s7h/iLva3l+yoG7wnB7VZN856QT?=
 =?us-ascii?Q?+dAuEd1PZnClDUxl+kGXq7Go55ImjIXp5f9xezqs5jlZH2n1Tz/2QELMlvTO?=
 =?us-ascii?Q?1VkIkQo1qB3kx7en83HVFjrd4Y/aZVvKgjUYEBvV3IdRnumsACaEa1tnwnNa?=
 =?us-ascii?Q?N3U6Dh37zdhY/dxAG/c+ngh48zbGDhqMEkroGYtAYV+0jHxvSzVAyBv8hY3Z?=
 =?us-ascii?Q?eL9OrhYpwmBMLGqZienQr1JmRPQY9YkwzafSWbZ2pVPdA9VkDYNzTbrDk/VI?=
 =?us-ascii?Q?ZtvsiioPRdG2sYHWRZ1eWegZ9okg4XuokMy2uNKkbChrPZy28NvwqaMW2kIB?=
 =?us-ascii?Q?m89k+MWeMwvLiBlXugryj55fHvgUq42AD2aT3FEIZUJUCxGtsQPKLsyT5urR?=
 =?us-ascii?Q?I2z2q6SxOlAErpEl9OIQgwBrzbIHuXF60/iF1ZVVR1tjFNMn+c/zho1H4ugY?=
 =?us-ascii?Q?x4YYnolgCKAnya1pO75pgZDTnw0A/0GTh4mq1AUIVGrDEhl+Ti24fZvjv+ob?=
 =?us-ascii?Q?H1wrzfg3os+dYDkame2i37eIIchNZu899XRVe/83JLr1WqHo8kfgS0Ov/MOq?=
 =?us-ascii?Q?G7nwQykHmMIhjAxS8qeXQjTO0FBvIcSwNCbU2gXDomwmXEPHoVcLhavjlvfN?=
 =?us-ascii?Q?TDsSWGVJ6jRw++UtTa29IhHj09vQfTlVQUyglUkP2mNith5ZIPz/65WVUFV+?=
 =?us-ascii?Q?UrvZwiwfXYCyH8Ixf7k5sBe2p7+yFZV3Sm61iA/xCVurCWAGfrbgD/qhG+V0?=
 =?us-ascii?Q?Dm3Vcm/uFwLqRwme4+/ce9QfVBlVVLyPjJiW2kAkXcgLyXFFKx3Kg0wN0syi?=
 =?us-ascii?Q?JhNQaKW/cIhdDf243Iqb02eJbld1Cewu5lu2AQiSIKmFiPfTjtUXW6PWCrK8?=
 =?us-ascii?Q?2CLOpY9A8ycUoXacuPhuCG7AHEXdm2h7Y9f+CZmf2ZDb4CJ7MzZNE/Jmtnma?=
 =?us-ascii?Q?LyV8tL61EkJHONj/kIX+BvH8DgoQEPOz3YcRx4gJqHKeA/R+qYw6ISuFbGVU?=
 =?us-ascii?Q?jxPEipPNI/KY8eadYVQJ4roMNAY7NmRUlivWMk4vumBdftKpbAKUwptwyQYd?=
 =?us-ascii?Q?7OIH/RPpdUG6KV4IUhAMv0AI1Wunis8Slip?=
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0007;6:lySedrpQN6OJaf5d0YaPRMexl9CKOaXWfwgOMUDVGvyZLOrMk5ERb5AqxtcEhs4hq7BWhwKgNMytZMmtpP+bzE6ACuT8tpsYPYlteTMk27RilqN3UxXLXtW6bbjQxmknDXGKWfGM48LOFukngDeDC0Mlj+Z9siX4Y6szwyNikmxF/1qNhhJV3pC/Imsi6Bkd9G0bLq9k3PXfqe/v2MY8OCYYZSM+qy6DZRGZLx5geFlSwJbqNlqeG9hmQ4t0DIbIamQZ2CTv3YfVjAfu0k1UtxjC0LIrHbfgF/JtdIVBxZiaE0TzY0DYqThGBll+EIgOJJOI/IKLjHR1FSt2mOXLoRBlisjSVaAa1wrikOevedE=;5:584bWP0WvasCt6GFIE8/Rb3Bsequ0lmS5QLWmNk22H+5TBqZj87A4wbClhazSzGsCO+ctPJ4m6lUCkyilddkGUimNk65xB3TxHoNtx5TMRDRZ/ce0UejuOLKZizsWmjftCLAzLcpnq4PJW30yBkbts4Ve7sigA/INXGUIaItGoE=;24:CltK7/bMRVBIqtGMyXtjhX0qwgRxznL8qsDwj8DxXt1lxZ6YJdM6y0ePTwXz3j4KFgfF5gTez3LgjF+Uut1W5jA9btGPkFKmA4DScfBKxOY=;7:tHoOfDUJTBLJJVtbWiBfu5t95d6uHSJYTfcadSt4R5Q5VBEK0bPFemwT7g/XUk65c1Qp6SN0BR+cOjrGHmA0DtnhTtuDr3/pHzx68r7lxIdbf7pNcdSvs+AE5X27pn7B9Bfe85jzxhkOjnjOhdbOTCl5W8gHWN/4GhFeYykP/knBIPb5VOqV/sHxyO/8VFd/627JBN0NXKDm7SEBwMHwKF3DpH9i8Qre0FFc8LqtZJR0/bOa9FRo1o1wrrtys7GK
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2018 16:28:43.9533 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1096b9-295f-472f-62b2-08d57ba3ad51
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4P136MB0007
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
 Documentation/gitattributes.txt  |  78 ++++++++++++++
 convert.c                        | 157 ++++++++++++++++++++++++++-
 convert.h                        |   1 +
 sha1_file.c                      |   2 +-
 t/t0028-working-tree-encoding.sh | 226 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 462 insertions(+), 2 deletions(-)
 create mode 100755 t/t0028-working-tree-encoding.sh

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 30687de81a..eddeaee1f7 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -272,6 +272,84 @@ few exceptions.  Even though...
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
+  If you declare `*.proj` files as UTF-16 and you add `foo.proj` with an
+  `working-tree-encoding` enabled Git client, then `foo.proj` will be
+  stored as UTF-8 internally. A client without `working-tree-encoding`
+  support will checkout `foo.proj` as UTF-8 encoded file. This will
+  typically cause trouble for the users of this file.
+
+  If a Git client, that does not support the `working-tree-encoding`
+  attribute, adds a new file `bar.proj`, then `bar.proj` will be
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
index 0000000000..a55bbcb6d3
--- /dev/null
+++ b/t/t0028-working-tree-encoding.sh
@@ -0,0 +1,226 @@
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
+	printf "$text" | iconv -f UTF-8 -t UTF-32 >test.utf32.raw &&
+	cp test.utf16.raw test.utf16 &&
+	cp test.utf32.raw test.utf32 &&
+
+	# Add only UTF-16 file, we will add the UTF-32 file later
+	git add .gitattributes test.utf16 &&
+	git commit -m initial
+'
+
+test_expect_success 'ensure UTF-8 is stored in Git' '
+	git cat-file -p :test.utf16 >test.utf16.git &&
+	test_cmp_bin test.utf8.raw test.utf16.git &&
+
+	# cleanup
+	rm test.utf16.git
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
+test_expect_success 'check $GIT_DIR/info/attributes support' '
+	echo "*.utf32 text working-tree-encoding=utf-32" >.git/info/attributes &&
+
+	git add test.utf32 &&
+
+	git cat-file -p :test.utf32 >test.utf32.git &&
+	test_cmp_bin test.utf8.raw test.utf32.git &&
+
+	# cleanup
+	git reset --hard HEAD &&
+	rm test.utf8.raw test.utf32.raw test.utf32.git
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

