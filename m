Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE6F21F404
	for <e@80x24.org>; Fri, 29 Dec 2017 15:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751313AbdL2PWz (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Dec 2017 10:22:55 -0500
Received: from mail-dm3nam03on0112.outbound.protection.outlook.com ([104.47.41.112]:7200
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751242AbdL2PWt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Dec 2017 10:22:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=+rhNvZCiSuSkznd4ZW8bxwinPuCrAF+q7eRux7vxkRk=;
 b=POxB3s4lpeMRdwcH7QDFbaHQ9QZJbNvDbvcvlip+YlbP/4/jbjRjnykAbTulLYlx5H3uYDPFKzAJI8gG8LRE7MaH27YFBYheAx37QchFBn6FRu0XlWgWAqEP/o/TjDTppZ20tmu7T2DJ7nmAlloMhcMR3tOc6kJhQyIWOGCSGqw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxBook4.fritz.box (93.219.84.3) by
 BN6P136MB0017.NAMP136.PROD.OUTLOOK.COM (129.75.91.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.345.17; Fri, 29 Dec 2017 15:22:44 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v2 4/5] convert: add support for 'checkout-encoding' attribute
Date:   Fri, 29 Dec 2017 16:22:21 +0100
Message-Id: <20171229152222.39680-5-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20171229152222.39680-1-lars.schneider@autodesk.com>
References: <20171229152222.39680-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [93.219.84.3]
X-ClientProxiedBy: AM5PR0502CA0001.eurprd05.prod.outlook.com (10.175.37.139)
 To BN6P136MB0017.NAMP136.PROD.OUTLOOK.COM (129.75.91.24)
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9d7a0342-ab8e-42bf-87bb-08d54ed0036d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060);SRVR:BN6P136MB0017;
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0017;3:eDak6MdcYDxBXW5dLLAXNqt8o2h1LK1a40oZgjREzwGhVBs1//3TD5QCkq43pCtym7T7PQqgqnl4a5QUjZ+MJPKhLRpdiXHBYi09+EXD+ILXhg2ZMCsY2u8M/eQMmXx/kjgtXMuoq3sWvyEb471obEsnKxQAu9bYjARjsnroWAM06kgIGloNodlVPfeJmBCsGPBlOog015E71EYWD+EN+3XrzP2ZCh9RmUltO43gwlNeX6ZUHIVyRy4hvlsEVrt+;25:786rAqvLgN4RBq0Wkvsnm179e7kLzqBAW3HGubWDlUbeJ1d6+OcjXvSoG1kKWdWQednkq5AkEh9zEancDk0mOkdmiQlzfA2s9mbCYfYowwAM5/pFpCypdAUxGgU+e5xYezAsSroIgl79WskrdbshO2hos5+BN6bMXrRXii1E3OXM2c9PQYenb3VgTwr+C4yy9xPbppPIa4UC8bEF783qM/7rQPHeg+5OY3EwJWHJFgrprTy4igpTs3xv/A/OShQ/Zri1U7bLPNXEhfmnS7k1EzuRKTy0WW42uXvP2BmdeSTVzS1W2TR3n66D4exceyapYBrIXsLUY07YnpD4EdF0Pw==;31:b2fTOelVwBimPbthd9006WZZwS4EEpQWYKCwp3oRim4GJi+omdsBljq4DRQ1/GaVgxY5zBMiyzU8rRPP9zoY4ykzQR03jeJGEek0QMf/WNQpf4B7HkN3EFUznxgBBKZB7S+6S8eo8agzE+eWFYNKAbKF+p8q5m0gNESrnfTUMoNMMJi9oILRhliUMyyqr2qwFc5hjqzYE773LhqPrXXSDZJrwddKXKM+wZdcH1a/Evg=
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6P136MB0017:
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0017;20:WtFKO7TlFzU4L4qjjD24Ajf55WHnCfiGddTiAkhRXTYD9PuKufwEWobA92RETrznL7ofuE6jK1c5U3IDj3RVoPZ0jQ9xylZJGZE9BaaLzGHCxQRxUeZJ7AaqekUfgV455veSf+fDdpMtgIOCJ2StprVLJn6LsNiCsz4A2xPdi9t3rMO7Svp1MN4hPNhGKUdc0LYEkWR50z+AIOhzJAeMNSOMAGpcz3o4Qrw0QkpCh4ZKsK03qzCsSvXY76couJqIjBIRthhHw7NsrUTwVl/rpNQ3NKdm4sPODTP35yqrG+8TC/9LQYWKbqjIplp/e5Gn4Snf1TBUw30J1wKNlzfmOKov4iYDUm5amHnup8xXzo+AKgJ2a4eIxnxyLkapbh7lCLHvlf2bq74vLk1vnT2GJ4GYj2Q6dRsKeKHbegCPO63oHw58ocUEZK+kd5Z/wLr0YRiyrP8NHyA82Pk8GdrGyDETq6nI3CQVJkuAmPkQjA9CtqjZjHFj5nB7Ok92wlfL3zfkhK+ILXiDMcjtN5uH5O2h0khPf5DtZFN8SzzGgaJCH0wXH9VOXlf+4phd6kMMSD7kwaKjgRguhZA7pLUIw20SFnsa38qoyOj+5BwB6DQ=;4:uHVU8eYY0t8vskTCrCq9bX+MZOMYzFKBzNgIfhEbPHgf+mnysl5U7eJh7kEDvkE2SuJFU1qOWWfSNlYb451eJytV4I5rq1CwGJCidqNHll3M+jCV4Takvtrt23h3mi2vKHCclVICm9aMC0Zvd1Itv8DC8Zt/ZGiZC+M452kYIbRnSefZLIgYNwWQMl6+EH07Wt6gMbG0/O4uwgqc1OwasOsWXFPxvDU4qmH9fJYcHt75k8ybxsjirx0HEpodLYJtl2dXZqO4H48h2e5P6BRlhQ==
X-Microsoft-Antispam-PRVS: <BN6P136MB00178965E02C12B7643DCD3EE8050@BN6P136MB0017.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040470)(2401047)(5005006)(8121501046)(3231023)(944501075)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041268)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6P136MB0017;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:BN6P136MB0017;
X-Forefront-PRVS: 0536638EAC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(346002)(366004)(376002)(189003)(199004)(16526018)(4326008)(6666003)(2950100002)(478600001)(6916009)(59450400001)(5890100001)(9686003)(575784001)(53936002)(16586007)(6306002)(6512007)(316002)(6506007)(68736007)(386003)(86362001)(8676002)(5660300001)(36756003)(81156014)(76176011)(81166006)(39060400002)(8656006)(33896004)(25786009)(51416003)(53416004)(52116002)(53376002)(6486002)(50226002)(3846002)(66066001)(7736002)(48376002)(2906002)(1076002)(105586002)(50466002)(966005)(69596002)(97736004)(85782001)(106356001)(2361001)(8936002)(47776003)(2351001)(6116002)(305945005)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6P136MB0017;H:slxBook4.fritz.box;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6P136MB0017;23:EGFUt6RRjY+Ulz98is7KWNa5qhQN+w7euHqtyaU4k?=
 =?us-ascii?Q?qsZ182QjHAF/cVduw9D4MXg3+OIe04paNi0D6Vx99C3JxSQ3PRfZMzrv/a5n?=
 =?us-ascii?Q?tznVUoeJdJnECA0xpLRhOIfg7GST/GzxLIEX64aUxSsqpXN4Lxj3qPp+mGD5?=
 =?us-ascii?Q?SPmbcHX22fcDpDO6GxRPceY7Fq7MtXvC5sFRfmsl4MHvPcCdpRY0P/I/9jzF?=
 =?us-ascii?Q?XT2UTap+sJNO4t9Rz0x6ozcmq2AjGkzpRZ4JY5k7mQXSHcs2UMm+j7Bl2wix?=
 =?us-ascii?Q?JenQUfX+VwyPpyr+AzL5vwBREz+GQh9ZN5NMknWknmCx9BivlPFHEsk1Szn/?=
 =?us-ascii?Q?7LK8VrR5VP1hdOZfyTovIdCw0VcTy9WmiTg0d62UbYigq+DFBOUjwcO4qDb4?=
 =?us-ascii?Q?REsbu6NubprCTy9vGV7yWIqwWA009/NVEEiM0mrwchVSE7uCuC68wlKOXYVu?=
 =?us-ascii?Q?XUQkUN8ArC+F2Z56KUn3+NnqqqlzHWb3EMHers1Cs8GapcVMv7/DSvRH5ZKg?=
 =?us-ascii?Q?fvAm3YXhWZTaCg0fqmeO7vayc6KsIQKmQ49CRnyff7QlmgEbcZBw6nAPBxv3?=
 =?us-ascii?Q?9gO6XFyz3A6fRUceeyrHq/AMWLsSznJCm6Gx5QhnhOjd6D0uz3ilY7hFCBNz?=
 =?us-ascii?Q?zFntQOkadeUThSuGy6wpnV1T0M5ts73IDIG5CZPXBDBg/iWZy0ujvFTEFLd3?=
 =?us-ascii?Q?0VssqVreoowT0/QyWSealuHPFNfASImd95EfsamW+3Chz8SyHWCy4EQZbN20?=
 =?us-ascii?Q?Ql3Vb3K3jCUp38yX1e6GddQo4SnEWi4hhNfmKjlm/KPA8Fg/wxFCGOf0us73?=
 =?us-ascii?Q?icSaDP0XOjVfFA0naskgHVr8SM6P9BCOroBdv8qeTig2r53LIyJst9RRPSPB?=
 =?us-ascii?Q?TrD0b+JluQT3pVM5PZbjmlChCxMRvQQ4B6+SqXqnhY7DuynTSqMscrA592QE?=
 =?us-ascii?Q?KNmhCvlZxuXiX0J7iKUBENuFhI/Ln4GfTZPIER+sq1uKWNKRewg1+4qx7kcY?=
 =?us-ascii?Q?zYWDNfkHhkaBAX1Gjmsr7ECjIx9+tqmL3AOFwsAyrbzRN5tWycsytQqcDERM?=
 =?us-ascii?Q?iCrOphxUO1DAe+3QNvUu7V89T3K1Bm1riPqqulET/bm9UaPzvc5TtU0DQFy8?=
 =?us-ascii?Q?iBvLt+LgpSyFuiX5YWLwvEsFQ4E6ADfbRIxYSl/3VIg/l1K/jcu+TNUZJvY7?=
 =?us-ascii?Q?EzjZULeA+xM/VPnc+4Xjdtd/4dNXKG9982E89HtCJhpaCUpSBSSmU/pz2xPG?=
 =?us-ascii?Q?YN0oSaad3WcKLcw9NwPCnHoRhXPdyCIPow4c0VikMn8S9ZCSMHMGcKvTCCsL?=
 =?us-ascii?Q?6fYI2AcIR9zU9VJbSoaWY9vsRVhLKon4qIUaWQ783Hq0A/NAxi74oQVd3qns?=
 =?us-ascii?Q?eeQHFn0CQRT5MarPP4YXBb+CF/9xAZ43vLdocpvxdxMExBCSZEqHnVSAmWT/?=
 =?us-ascii?Q?jHC9A9R9NQ4HAJKhuUk4OYj+fB9XMA=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0017;6:dwcsTpcDm1Q0XChypeLMB0lI+uBY7cfeODy7rCzv+jUDnTuZ2y4/ZImHJsLS5+9AuABJtcghyeGupODeV2KlefcXlltkhWwgdkw4gqX5QLExR4WaSScKdGDw2cL6RBMaYQXxLTjD9OK3bPhP604mYvakscDh+txbqgtwzQGNnCMgo6ZV5oxyNZtI0gjxaPEU9cQcbZ8LIlzuEHRZkoG8SJiIu6ENmnKWj5fYQoD1hyrqvd94dUNjgkOR3/LgSulgeOV+pC7qtmJXBnAvhDvSjGIIAJiJi2gedmoh0F6LBgHeWlefaCjWX6RUjZmuY2SL4j4/X0fb8S3rfuiFNlfhhJU9xxur/Yh+Hh+BjGLOiAg=;5:6+IvG4xZDMYizCgHyj7E4aEypRE7/YTITzITlXsVlQV+JZxHaOox0ehPBmIFIyJPepuEiYlsLBTKHAMKDq3Shp3xzkJAOBDg+kVOr16CDjEh9gcN3LvEQFbGeFlN7wLYiU1HCCPBwYjmKJZEU/BYSrFyJ+RuLQOK0rMcB39V4gI=;24:qy5NSs7pfRYxKzHlgJEfh6l9XwrTTDbhs6ghx7au9xL0ms2wFNepbINk7XF6Od4jRdg15BKeT/H1Lh/ngIyrBtl4DzalRvxfhqrvbpqXwHA=;7:eYKdkCsY4R5LU7ZrWpJhXzD9OvwWKouL6jHropVXK7EgEJlhYDjiKxDR+xdPNLfOEBoowHNYYgVPpvzgKZstpYkxOz9bgCnysFXtNt/Tuxv0PwQHoTbtNK537n9NjQLbhMstqmcmaD2BslKn0SJiOYYkiNCFDqpPgeU8/1tbkoBle6v0NvJh77nbco7DZOjTs3L8dodDpvee4DDlCbzh9uNQlUW+v/VC7nZ2Cx39VywqkUFHdWOOpPCHODCdnmU9
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2017 15:22:44.4841 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d7a0342-ab8e-42bf-87bb-08d54ed0036d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6P136MB0017
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Git and its tools (e.g. git diff) expect all text files in UTF-8
encoding. Git will happily accept content in all other encodings, too,
but it might not be able to process the text (e.g. viewing diffs or
changing line endings).

Add an attribute to tell Git what encoding the user has defined for a
given file. If the content is added to the index, then Git converts the
content to a canonical UTF-8 representation. On checkout Git will
reverse the conversion.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 Documentation/gitattributes.txt |  59 ++++++++++++
 apply.c                         |   2 +-
 blame.c                         |   2 +-
 combine-diff.c                  |   2 +-
 convert.c                       | 196 ++++++++++++++++++++++++++++++++++++++-
 convert.h                       |   8 +-
 diff.c                          |   2 +-
 sha1_file.c                     |   5 +-
 t/t0028-checkout-encoding.sh    | 197 ++++++++++++++++++++++++++++++++++++++++
 9 files changed, 460 insertions(+), 13 deletions(-)
 create mode 100755 t/t0028-checkout-encoding.sh

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 30687de81a..0039bd38c3 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -272,6 +272,65 @@ few exceptions.  Even though...
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
index 20d7ab67bd..fc8c96b670 100644
--- a/convert.c
+++ b/convert.c
@@ -7,6 +7,7 @@
 #include "sigchain.h"
 #include "pkt-line.h"
 #include "sub-process.h"
+#include "utf8.h"
 
 /*
  * convert.c - convert a file when checking it out and checking it in.
@@ -256,6 +257,147 @@ static int will_convert_lf_to_crlf(size_t len, struct text_stat *stats,
 
 }
 
+static struct encoding {
+	const char *name;
+	struct encoding *next;
+} *encoding, **encoding_tail;
+static const char *default_encoding = "UTF-8";
+
+static int encode_to_git(const char *path, const char *src, size_t src_len,
+			 struct strbuf *buf, struct encoding *enc, int write_obj)
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
+		if (write_obj)
+			die(msg, path, enc->name, default_encoding);
+		else
+			error(msg, path, enc->name, default_encoding);
+	}
+
+	/*
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
+	 */
+	if (write_obj && !strcmp(enc->name, "SHIFT-JIS")) {
+		char *re_src;
+		int re_src_len;
+
+		re_src = reencode_string_len(dst, dst_len,
+					     enc->name, default_encoding,
+					     &re_src_len);
+
+		if (!re_src || src_len != re_src_len ||
+		    memcmp(src, re_src, src_len)) {
+			const char* msg = _("encoding '%s' from %s to %s and "
+					    "back is not the same");
+			if (write_obj)
+				die(msg, path, enc->name, default_encoding);
+			else
+				error(msg, path, enc->name, default_encoding);
+		}
+
+		free(re_src);
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
@@ -969,6 +1111,31 @@ static int ident_to_worktree(const char *path, const char *src, size_t len,
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
+	enc = xcalloc(1, sizeof(struct convert_driver));
+	enc->name = xstrdup_toupper(value);  /* aways use upper case names! */
+	*encoding_tail = enc;
+	encoding_tail = &(enc->next);
+
+	return enc;
+}
+
 static enum crlf_action git_path_check_crlf(struct attr_check_item *check)
 {
 	const char *value = check->value;
@@ -1024,6 +1191,7 @@ struct conv_attrs {
 	enum crlf_action attr_action; /* What attr says */
 	enum crlf_action crlf_action; /* When no attr is set, use core.autocrlf */
 	int ident;
+	struct encoding *checkout_encoding; /* Supported encoding or default encoding if NULL */
 };
 
 static void convert_attrs(struct conv_attrs *ca, const char *path)
@@ -1032,8 +1200,10 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
 
 	if (!check) {
 		check = attr_check_initl("crlf", "ident", "filter",
-					 "eol", "text", NULL);
+					 "eol", "text", "checkout-encoding",
+					 NULL);
 		user_convert_tail = &user_convert;
+		encoding_tail = &encoding;
 		git_config(read_convert_config, NULL);
 	}
 
@@ -1055,6 +1225,7 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
 			else if (eol_attr == EOL_CRLF)
 				ca->crlf_action = CRLF_TEXT_CRLF;
 		}
+		ca->checkout_encoding = git_path_check_encoding(ccheck + 5);
 	} else {
 		ca->drv = NULL;
 		ca->crlf_action = CRLF_UNDEFINED;
@@ -1120,7 +1291,7 @@ const char *get_convert_attr_ascii(const char *path)
 
 int convert_to_git(const struct index_state *istate,
 		   const char *path, const char *src, size_t len,
-                   struct strbuf *dst, enum safe_crlf checksafe)
+		   struct strbuf *dst, enum safe_crlf checksafe, int write_obj)
 {
 	int ret = 0;
 	struct conv_attrs ca;
@@ -1135,6 +1306,13 @@ int convert_to_git(const struct index_state *istate,
 		src = dst->buf;
 		len = dst->len;
 	}
+
+	ret |= encode_to_git(path, src, len, dst, ca.checkout_encoding, write_obj);
+	if (ret && dst) {
+		src = dst->buf;
+		len = dst->len;
+	}
+
 	if (checksafe != SAFE_CRLF_KEEP_CRLF) {
 		ret |= crlf_to_git(istate, path, src, len, dst, ca.crlf_action, checksafe);
 		if (ret && dst) {
@@ -1147,7 +1325,7 @@ int convert_to_git(const struct index_state *istate,
 
 void convert_to_git_filter_fd(const struct index_state *istate,
 			      const char *path, int fd, struct strbuf *dst,
-			      enum safe_crlf checksafe)
+			      enum safe_crlf checksafe, int write_obj)
 {
 	struct conv_attrs ca;
 	convert_attrs(&ca, path);
@@ -1158,6 +1336,7 @@ void convert_to_git_filter_fd(const struct index_state *istate,
 	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv, CAP_CLEAN, NULL))
 		die("%s: clean filter '%s' failed", path, ca.drv->name);
 
+	encode_to_git(path, dst->buf, dst->len, dst, ca.checkout_encoding, write_obj);
 	crlf_to_git(istate, path, dst->buf, dst->len, dst, ca.crlf_action, checksafe);
 	ident_to_git(path, dst->buf, dst->len, dst, ca.ident);
 }
@@ -1189,6 +1368,12 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
 		}
 	}
 
+	ret |= encode_to_worktree(path, src, len, dst, ca.checkout_encoding);
+	if (ret) {
+		src = dst->buf;
+		len = dst->len;
+	}
+
 	ret_filter = apply_filter(
 		path, src, len, -1, dst, ca.drv, CAP_SMUDGE, dco);
 	if (!ret_filter && ca.drv && ca.drv->required)
@@ -1217,7 +1402,7 @@ int renormalize_buffer(const struct index_state *istate, const char *path,
 		src = dst->buf;
 		len = dst->len;
 	}
-	return ret | convert_to_git(istate, path, src, len, dst, SAFE_CRLF_RENORMALIZE);
+	return ret | convert_to_git(istate, path, src, len, dst, SAFE_CRLF_RENORMALIZE, 0);
 }
 
 /*****************************************************************
@@ -1655,6 +1840,9 @@ struct stream_filter *get_stream_filter(const char *path, const unsigned char *s
 	if (ca.drv && (ca.drv->process || ca.drv->smudge || ca.drv->clean))
 		return NULL;
 
+	if (ca.checkout_encoding)
+		return NULL;
+
 	if (ca.crlf_action == CRLF_AUTO || ca.crlf_action == CRLF_AUTO_CRLF)
 		return NULL;
 
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
diff --git a/t/t0028-checkout-encoding.sh b/t/t0028-checkout-encoding.sh
new file mode 100755
index 0000000000..1a329ab933
--- /dev/null
+++ b/t/t0028-checkout-encoding.sh
@@ -0,0 +1,197 @@
+#!/bin/sh
+
+test_description='checkout-encoding conversion via gitattributes'
+
+. ./test-lib.sh
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
-- 
2.15.1

