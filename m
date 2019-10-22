Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A81371F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 11:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388838AbfJVLsM (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 07:48:12 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48030 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387973AbfJVLsM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 07:48:12 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9MBcs3s084351;
        Tue, 22 Oct 2019 11:48:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=uXRj0vvCBW6iSglYn+xJdT3ojRNqHIkEmMhM4Djy5Co=;
 b=X/YX9HVFMb0sZylCC/XbBPqDrKjTVB/Yix6g0cVQ2oAgQPv4a4fkP19guGjLc8K7gkZr
 JVRIjH3g1jd9BV9dO9xzEp1cvS213ICSjpK3uSc3glzXqfVW9cz3wUJ1YLWgeGIQ0Wuw
 ThBWYjoH5A4XsQYznGNT1vy8tmWWOCTYWwrLHEmfWwu29PiPu1jdnrTsIxH++umBxgPJ
 qLTTkIAOHhRAM4J0O+3LXFentC2OHs4hfBn89eGzWcToyghnEwW1nnVm1VVHCiYwrfc0
 d6bSoORFlGtRcjZOfvn0HClhAeNVvfSYaoE5+l4m3xqPDsa9lBmS0+LhQO9QdlxGz7vb xA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2vqu4qnuvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Oct 2019 11:48:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9MBcBrV092757;
        Tue, 22 Oct 2019 11:48:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 2vsx22jngp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Oct 2019 11:48:00 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x9MBm0hQ115832;
        Tue, 22 Oct 2019 11:48:00 GMT
Received: from t460.home (dhcp-10-175-28-77.vpn.oracle.com [10.175.28.77])
        by aserp3030.oracle.com with ESMTP id 2vsx22jmx3-2;
        Tue, 22 Oct 2019 11:48:00 +0000
From:   Vegard Nossum <vegard.nossum@oracle.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: [RFC PATCH v2 1/3] format-patch: add --complete
Date:   Tue, 22 Oct 2019 13:45:16 +0200
Message-Id: <20191022114518.32055-2-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.24.0.rc0.3.g4ba423c3c2
In-Reply-To: <20191022114518.32055-1-vegard.nossum@oracle.com>
References: <20191022114518.32055-1-vegard.nossum@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9417 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910220107
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This option causes the raw commit data to be inserted between the
changelog and the diffstat when you run git-format-patch. With a
following patch to 'git am', this will allow the exact reconstruction
of the commit to the point where the sha1 will be the same.

There is also a new config option controlling the default behaviour:

  format.complete

Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
Previous-version: 622a0469a4970c5daac0c0323e2d6a77b3bebbdb
---
 Documentation/config/format.txt    |  7 ++++++
 Documentation/git-format-patch.txt |  9 ++++++++
 builtin/log.c                      | 35 ++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/Documentation/config/format.txt b/Documentation/config/format.txt
index 40cad9278f..3a38679837 100644
--- a/Documentation/config/format.txt
+++ b/Documentation/config/format.txt
@@ -87,6 +87,13 @@ format.useAutoBase::
 	A boolean value which lets you enable the `--base=auto` option of
 	format-patch by default.
 
+format.complete::
+	Provides the default value for the `--complete` option to
+	format-patch. If true, the raw commit metadata (including the
+	SHA1) is included at the bottom of the diff, before the signature.
+	This allows a recipient who has all the parent commits and/or the
+	tree to reconstruct the commit with the same SHA1.
+
 format.notes::
 	Provides the default value for the `--notes` option to
 	format-patch. Accepts a boolean value, or a ref which specifies
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 2035d4d5d5..74fc6d8a8c 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -26,6 +26,7 @@ SYNOPSIS
 		   [--no-notes | --notes[=<ref>]]
 		   [--interdiff=<previous>]
 		   [--range-diff=<previous> [--creation-factor=<percent>]]
+		   [--[no-]complete]
 		   [--progress]
 		   [<common diff options>]
 		   [ <since> | <revision range> ]
@@ -325,6 +326,14 @@ you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
 	range are always formatted as creation patches, independently
 	of this flag.
 
+--[no-]complete::
+	Include the raw commit metadata (including the SHA1) at the
+	bottom of the diff, before the signature. This allows a
+	recipient who has all the parent commits and/or the tree to
+	reconstruct the commit with the same SHA1. The default is
+	`--no-complete`, unless the `format.complete` configuration
+	option is set.
+
 --progress::
 	Show progress reports on stderr as patches are generated.
 
diff --git a/builtin/log.c b/builtin/log.c
index 89873d2dc2..822a0838b6 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -783,6 +783,8 @@ enum {
 	COVER_AUTO
 };
 
+static int fmt_complete;
+
 static int git_format_config(const char *var, const char *value, void *cb)
 {
 	struct rev_info *rev = cb;
@@ -888,6 +890,10 @@ static int git_format_config(const char *var, const char *value, void *cb)
 		}
 		return 0;
 	}
+	if (!strcmp(var, "format.complete")) {
+		fmt_complete = git_config_bool(var, value);
+		return 0;
+	}
 
 	return git_log_config(var, value, cb);
 }
@@ -1490,6 +1496,23 @@ static void print_bases(struct base_tree_info *bases, FILE *file)
 	oidclr(&bases->base_commit);
 }
 
+static void print_meta(struct rev_info *opt, struct commit *commit)
+{
+	const char *buffer = get_commit_buffer(commit, NULL);
+	const char *subject;
+
+	fprintf(opt->diffopt.file, "--\n");
+	fprintf(opt->diffopt.file, "commit %s\n", oid_to_hex(&commit->object.oid));
+
+	/*
+	 * TODO: hex-encode to avoid mailer mangling?
+	 */
+	if (find_commit_subject(buffer, &subject))
+		fprintf(opt->diffopt.file, "%.*s", (int) (subject - buffer), buffer);
+	else
+		fprintf(opt->diffopt.file, "%s", buffer);
+}
+
 static const char *diff_title(struct strbuf *sb, int reroll_count,
 		       const char *generic, const char *rerolled)
 {
@@ -1622,6 +1645,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			    N_("add a signature")),
 		OPT_STRING(0, "base", &base_commit, N_("base-commit"),
 			   N_("add prerequisite tree info to the patch series")),
+		OPT_BOOL(0, "complete", &fmt_complete,
+			 N_("include all the information necessary to reconstruct commit exactly")),
 		OPT_FILENAME(0, "signature-file", &signature_file,
 				N_("add a signature from a file")),
 		OPT__QUIET(&quiet, N_("don't print the patch filenames")),
@@ -1921,6 +1946,14 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		prepare_bases(&bases, base, list, nr);
 	}
 
+	if (fmt_complete) {
+		/*
+		 * We need the commit buffer so that we can output the exact
+		 * sequence of bytes that gets hashed as part of a commit.
+		 */
+		save_commit_buffer = 1;
+	}
+
 	if (in_reply_to || thread || cover_letter)
 		rev.ref_message_ids = xcalloc(1, sizeof(struct string_list));
 	if (in_reply_to) {
@@ -2004,6 +2037,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			rev.shown_one = 0;
 		if (shown) {
 			print_bases(&bases, rev.diffopt.file);
+			if (fmt_complete)
+				print_meta(&rev, commit);
 			if (rev.mime_boundary)
 				fprintf(rev.diffopt.file, "\n--%s%s--\n\n\n",
 				       mime_boundary_leader,
--
commit 7fa59e79ef5474fb4c657fb2ff6a8341cc17c897
tree 891d334e23f950afbaaafc182384309fd8c73e48
parent d966095db01190a2196e31195ea6fa0c722aa732
author Vegard Nossum <vegard.nossum@oracle.com> 1570284959 +0200
committer Vegard Nossum <vegard.nossum@oracle.com> 1571666151 +0200

-- 
2.24.0.rc0.3.g4ba423c3c2

