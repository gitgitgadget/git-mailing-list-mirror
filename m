Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BB7F1F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 11:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388840AbfJVLsP (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 07:48:15 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48022 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387893AbfJVLsP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 07:48:15 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9MBcsiS084352;
        Tue, 22 Oct 2019 11:48:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=j6+vG+GauJXrE/rm51EPaHalt8e2KTvCoLg98hjPSTM=;
 b=XsT3+HCjEXWlmQY5l1LdnObv0kIyxj6Y+CPbmhDwhp5jJSCxx3TdUuBd076amwGMuIBS
 LvSW9vzVN15SZp1I9zUNhmzUNgSEqmoYiI3/A0n8NsjyNpub8NWLIvM3qKQfiWEtvNWg
 Y9G4Xh5yz8Ijsz1Z3/bPZTb7qzbyIK39eIpMF1z6/jtDUMH1zCBEnohFOCMCzB0T1C3L
 G7LOTxQ+PNaMfSusV09DYdNok/OZG6uGGe7sdj195xmUEaPqhLGLfsE/xZjgFmDChc15
 krIiZODa8C28nfopAs4IL0rKRsKHajTP2yQo4gyegqqXMuRnLvQHEFbn+RZjHFSgdSDa rQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2vqu4qnuvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Oct 2019 11:48:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9MBcCmP092790;
        Tue, 22 Oct 2019 11:48:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 2vsx22jnkp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Oct 2019 11:48:03 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x9MBm0hS115832;
        Tue, 22 Oct 2019 11:48:02 GMT
Received: from t460.home (dhcp-10-175-28-77.vpn.oracle.com [10.175.28.77])
        by aserp3030.oracle.com with ESMTP id 2vsx22jmx3-3;
        Tue, 22 Oct 2019 11:48:02 +0000
From:   Vegard Nossum <vegard.nossum@oracle.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: [RFC PATCH v2 2/3] mailinfo: collect commit metadata from mail
Date:   Tue, 22 Oct 2019 13:45:17 +0200
Message-Id: <20191022114518.32055-3-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.24.0.rc0.3.g4ba423c3c2
In-Reply-To: <20191022114518.32055-1-vegard.nossum@oracle.com>
References: <20191022114518.32055-1-vegard.nossum@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9417 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910220107
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Metadata" here is used for the raw commit metadata which gets included
in a patch when using 'git format-patch --complete'.

The new email format is roughly:

  1. email headers (ends with a blank line)
  2. changelog (ends with "---" or when the diff starts)
  3. comments (optional; ends when the diff starts)
  4. diff itself (ends when there are no more files/hunks)
  5. metadata (optional; starts with "--" and then "commit [...]")
  6. signature (optional; starts with "--")

Traditionally, the comments and signature were counted as part of the diff,
and although the metadata now appears between the diff and the signature
(and is extracted into its own file) the signature is also output together
with the diff; this breaks no existing test cases and seems to be the most
backwards compatible.

Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
Previous-version: 51bb531eb57320caf3761680ebf77c25b89b3719
---
 Documentation/git-mailinfo.txt |   6 +-
 builtin/am.c                   |   2 +-
 builtin/mailinfo.c             |  13 ++-
 mailinfo.c                     | 154 ++++++++++++++++++++++++++++++++-
 mailinfo.h                     |   9 +-
 t/t5100-mailinfo.sh            |  22 +++++
 t/t5100/meta-info0001          |   5 ++
 t/t5100/meta-meta0001          |  23 +++++
 t/t5100/meta-msg0001           |   6 ++
 t/t5100/meta-patch0001         |  76 ++++++++++++++++
 t/t5100/meta-samples.mbox      | 133 ++++++++++++++++++++++++++++
 11 files changed, 439 insertions(+), 10 deletions(-)
 create mode 100644 t/t5100/meta-info0001
 create mode 100644 t/t5100/meta-meta0001
 create mode 100644 t/t5100/meta-msg0001
 create mode 100644 t/t5100/meta-patch0001
 create mode 100644 t/t5100/meta-samples.mbox

diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinfo.txt
index 3bbc731f67..14a2cca08c 100644
--- a/Documentation/git-mailinfo.txt
+++ b/Documentation/git-mailinfo.txt
@@ -9,7 +9,7 @@ git-mailinfo - Extracts patch and authorship from a single e-mail message
 SYNOPSIS
 --------
 [verse]
-'git mailinfo' [-k|-b] [-u | --encoding=<encoding> | -n] [--[no-]scissors] <msg> <patch>
+'git mailinfo' [-k|-b] [-u | --encoding=<encoding> | -n] [--[no-]scissors] <msg> <patch> [<meta>]
 
 
 DESCRIPTION
@@ -21,6 +21,10 @@ written out to the standard output to be used by 'git am'
 to create a commit.  It is usually not necessary to use this
 command directly.  See linkgit:git-am[1] instead.
 
+If specified, <meta> specifies a filename where commit metadata
+will be written. If the e-mail does not contain such information,
+this file will be empty.
+
 
 OPTIONS
 -------
diff --git a/builtin/am.c b/builtin/am.c
index 8181c2aef3..4190383bba 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1159,7 +1159,7 @@ static int parse_mail(struct am_state *state, const char *mail)
 
 	mi.input = xfopen(mail, "r");
 	mi.output = xfopen(am_path(state, "info"), "w");
-	if (mailinfo(&mi, am_path(state, "msg"), am_path(state, "patch")))
+	if (mailinfo(&mi, am_path(state, "msg"), am_path(state, "patch"), am_path(state, "meta")))
 		die("could not parse patch");
 
 	fclose(mi.input);
diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index cfb667a594..6c0746fa8e 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -9,14 +9,14 @@
 #include "mailinfo.h"
 
 static const char mailinfo_usage[] =
-	"git mailinfo [-k | -b] [-m | --message-id] [-u | --encoding=<encoding> | -n] [--scissors | --no-scissors] <msg> <patch> < mail >info";
+	"git mailinfo [-k | -b] [-m | --message-id] [-u | --encoding=<encoding> | -n] [--scissors | --no-scissors] <msg> <patch> [<meta>] < mail >info";
 
 int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 {
 	const char *def_charset;
 	struct mailinfo mi;
 	int status;
-	char *msgfile, *patchfile;
+	char *msgfile, *patchfile, *metafile;
 
 	setup_mailinfo(&mi);
 
@@ -47,7 +47,7 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 		argc--; argv++;
 	}
 
-	if (argc != 3)
+	if (argc < 3 || argc > 4)
 		usage(mailinfo_usage);
 
 	mi.input = stdin;
@@ -56,10 +56,15 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 	msgfile = prefix_filename(prefix, argv[1]);
 	patchfile = prefix_filename(prefix, argv[2]);
 
-	status = !!mailinfo(&mi, msgfile, patchfile);
+	metafile = NULL;
+	if (argc == 4)
+		metafile = prefix_filename(prefix, argv[3]);
+
+	status = !!mailinfo(&mi, msgfile, patchfile, metafile);
 	clear_mailinfo(&mi);
 
 	free(msgfile);
 	free(patchfile);
+	free(metafile);
 	return status;
 }
diff --git a/mailinfo.c b/mailinfo.c
index b395adbdf2..173cb58f6b 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -825,10 +825,139 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 	return 0;
 }
 
-static void handle_patch(struct mailinfo *mi, const struct strbuf *line)
+enum patch_parser_state {
+	SKIP_UNTIL_DIFF,
+	NEW_DIFF_OR_HUNK,
+	MATCH_HUNK_HEADER,
+	HUNK,
+};
+
+static int handle_patch(struct mailinfo *mi, const struct strbuf *line)
 {
+	int old_pos, old_size;
+	int new_pos, new_size;
+
+	switch (mi->patch_stage) {
+	case SKIP_UNTIL_DIFF:
+		if (starts_with(line->buf, "diff "))
+			mi->patch_stage = MATCH_HUNK_HEADER;
+
+		break;
+
+	case NEW_DIFF_OR_HUNK:
+		if (starts_with(line->buf, "diff ")) {
+			mi->patch_stage = MATCH_HUNK_HEADER;
+			break;
+		}
+
+		/* fallthrough */
+
+	case MATCH_HUNK_HEADER:
+		if (sscanf(line->buf, "@@ -%d,%d +%d,%d @@", &old_pos, &old_size, &new_pos, &new_size) == 4
+			|| sscanf(line->buf, "@@ -%d,%d +%d @@", &old_pos, &old_size, &new_size) == 3
+			|| sscanf(line->buf, "@@ -%d +%d,%d @@", &old_size, &old_pos, &new_size) == 3
+			|| sscanf(line->buf, "@@ -%d +%d @@", &old_size, &new_size) == 2)
+		{
+			mi->old_size = old_size;
+			mi->new_size = new_size;
+
+			if (old_size > 0 || new_size > 0)
+				mi->patch_stage = HUNK;
+
+			break;
+		}
+
+		if (mi->patch_stage == NEW_DIFF_OR_HUNK) {
+			/*
+			 * We expected a 'diff' line or a hunk header and
+			 * didn't find either; this must be the end of the
+			 * patch!
+			 */
+			return 1;
+		}
+
+		/*
+		 * We were looking for a hunk header, but found something
+		 * else, probably an 'index' line or a '---' or '+++' line.
+		 */
+		break;
+
+	case HUNK:
+		if (line->buf[0] == '-' || line->buf[0] == ' ')
+			--mi->old_size;
+		if (line->buf[0] == '+' || line->buf[0] == ' ')
+			--mi->new_size;
+
+		if (mi->format_flowed) {
+			/*
+			 * format=flowed eats blanks at line ends
+			 */
+			if (line->buf[0] == '\r' || line->buf[0] == '\n') {
+				--mi->old_size;
+				--mi->new_size;
+			}
+		}
+
+		if (mi->old_size <= 0 && mi->new_size <= 0) {
+			/* done with hunk */
+			mi->patch_stage = NEW_DIFF_OR_HUNK;
+		}
+
+		break;
+	}
+
+	fwrite(line->buf, 1, line->len, mi->patchfile);
+	mi->patch_lines++;
+	return 0;
+}
+
+/*
+ * At the end of the diff, we find a signature and (optionally) metadata.
+ *
+ * "metadata" is whatever info we need to reconstruct a commit perfectly.
+ * It does _not_ include the signature or other lines.
+ *
+ * The way we parse this is a bit strange: there may be some lines before
+ * the metadata which logically belong to the signature, even though the
+ * actual signature appears after the metadata (e.g. sometimes blank lines
+ * appear between the diff and the signature, and we don't want to count
+ * them among the metadata).
+ */
+static void handle_signature(struct mailinfo *mi, const struct strbuf *line)
+{
+	switch (mi->meta_stage) {
+	case 0:
+		/* Done with the diff */
+		if (starts_with(line->buf, "commit ")) {
+			if (mi->metafile)
+				fwrite(line->buf, 1, line->len, mi->metafile);
+
+			mi->meta_stage = 1;
+			return;
+		}
+
+		break;
+
+	case 1:
+		/* Metadata */
+		if (starts_with(line->buf, "--")) {
+			mi->meta_stage = 2;
+			return;
+		}
+
+		if (mi->metafile)
+			fwrite(line->buf, 1, line->len, mi->metafile);
+
+		return;
+
+	case 2:
+		/* Done with metadata */
+		break;
+	}
+
 	fwrite(line->buf, 1, line->len, mi->patchfile);
 	mi->patch_lines++;
+	return;
 }
 
 static void handle_filter(struct mailinfo *mi, struct strbuf *line)
@@ -840,7 +969,12 @@ static void handle_filter(struct mailinfo *mi, struct strbuf *line)
 		mi->filter_stage++;
 		/* fallthrough */
 	case 1:
-		handle_patch(mi, line);
+		if (!handle_patch(mi, line))
+			break;
+		mi->filter_stage++;
+		/* fallthrough */
+	case 2:
+		handle_signature(mi, line);
 		break;
 	}
 }
@@ -1145,7 +1279,7 @@ static void handle_info(struct mailinfo *mi)
 	fprintf(mi->output, "\n");
 }
 
-int mailinfo(struct mailinfo *mi, const char *msg, const char *patch)
+int mailinfo(struct mailinfo *mi, const char *msg, const char *patch, const char *meta)
 {
 	FILE *cmitmsg;
 	int peek;
@@ -1163,6 +1297,16 @@ int mailinfo(struct mailinfo *mi, const char *msg, const char *patch)
 		return -1;
 	}
 
+	if (meta) {
+		mi->metafile = fopen(meta, "w");
+		if (!mi->metafile) {
+			perror(meta);
+			fclose(mi->patchfile);
+			fclose(cmitmsg);
+			return -1;
+		}
+	}
+
 	mi->p_hdr_data = xcalloc(MAX_HDR_PARSED, sizeof(*(mi->p_hdr_data)));
 	mi->s_hdr_data = xcalloc(MAX_HDR_PARSED, sizeof(*(mi->s_hdr_data)));
 
@@ -1183,6 +1327,8 @@ int mailinfo(struct mailinfo *mi, const char *msg, const char *patch)
 	fwrite(mi->log_message.buf, 1, mi->log_message.len, cmitmsg);
 	fclose(cmitmsg);
 	fclose(mi->patchfile);
+	if (mi->metafile)
+		fclose(mi->metafile);
 
 	handle_info(mi);
 	strbuf_release(&line);
@@ -1212,6 +1358,8 @@ void setup_mailinfo(struct mailinfo *mi)
 	strbuf_init(&mi->log_message, 0);
 	strbuf_init(&mi->inbody_header_accum, 0);
 	mi->header_stage = 1;
+	mi->patch_stage = 0;
+	mi->meta_stage = 0;
 	mi->use_inbody_headers = 1;
 	mi->content_top = mi->content;
 	git_config(git_mailinfo_config, mi);
diff --git a/mailinfo.h b/mailinfo.h
index 79b1d6774e..fdf3ba2674 100644
--- a/mailinfo.h
+++ b/mailinfo.h
@@ -9,6 +9,7 @@ struct mailinfo {
 	FILE *input;
 	FILE *output;
 	FILE *patchfile;
+	FILE *metafile;
 
 	struct strbuf name;
 	struct strbuf email;
@@ -31,16 +32,22 @@ struct mailinfo {
 	int patch_lines;
 	int filter_stage; /* still reading log or are we copying patch? */
 	int header_stage; /* still checking in-body headers? */
+	int patch_stage;
+	int meta_stage;
 	struct strbuf inbody_header_accum;
 	struct strbuf **p_hdr_data;
 	struct strbuf **s_hdr_data;
 
 	struct strbuf log_message;
 	int input_error;
+
+	/* handle_patch() */
+	int old_size;
+	int new_size;
 };
 
 void setup_mailinfo(struct mailinfo *);
-int mailinfo(struct mailinfo *, const char *msg, const char *patch);
+int mailinfo(struct mailinfo *, const char *msg, const char *patch, const char *meta);
 void clear_mailinfo(struct mailinfo *);
 
 #endif /* MAILINFO_H */
diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index 9690dcad4f..76303bfaee 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -66,6 +66,28 @@ do
 	'
 done
 
+
+test_expect_success 'split box with metadata samples' \
+	'mkdir meta &&
+	git mailsplit -ometa "$DATA/meta-samples.mbox" \
+	  >meta/last &&
+	last=$(cat meta/last) &&
+	echo total is $last &&
+	test $(cat meta/last) = 1'
+
+for mail in meta/00*
+do
+	n=$(basename $mail)
+	test_expect_success "mailinfo $mail" '
+		git mailinfo -u "$mail-msg" "$mail-patch" "$mail-meta" <"$mail" >"$mail-info" &&
+		test_cmp "$DATA/meta-msg$n" "$mail-msg" &&
+		test_cmp "$DATA/meta-patch$n" "$mail-patch" &&
+		test_cmp "$DATA/meta-meta$n" "$mail-meta" &&
+		test_cmp "$DATA/meta-info$n" "$mail-info"
+	'
+done
+
+
 test_expect_success 'respect NULs' '
 
 	git mailsplit -d3 -o. "$DATA/nul-plain" &&
diff --git a/t/t5100/meta-info0001 b/t/t5100/meta-info0001
new file mode 100644
index 0000000000..69889dc9ce
--- /dev/null
+++ b/t/t5100/meta-info0001
@@ -0,0 +1,5 @@
+Author: Vegard Nossum
+Email: vegard.nossum@oracle.com
+Subject: format-patch: add --complete
+Date: Sun, 20 Oct 2019 21:40:24 +0200
+
diff --git a/t/t5100/meta-meta0001 b/t/t5100/meta-meta0001
new file mode 100644
index 0000000000..1db7e9f715
--- /dev/null
+++ b/t/t5100/meta-meta0001
@@ -0,0 +1,23 @@
+commit 763f9b1cfd69ade5e22dcdcdc35d144697675a93
+tree 43a6b213a2891b5a863775771cab0c0dba3730dc
+parent 108b97dc372828f0e72e56bbb40cae8e1e83ece6
+author Vegard Nossum <vegard.nossum@oracle.com> 1570284959 +0200
+committer Vegard Nossum <vegard.nossum@oracle.com> 1571599909 +0200
+gpgsig -----BEGIN PGP SIGNATURE-----
+ Version: GnuPG v1
+ 
+ iQIcBAABAgAGBQJdrLYmAAoJEAvO9Nj+mLpY5zIQAJkdnnZMrCVme64r43M/KMm0
+ W1fmdeXiIMrI7i0McBdAsQ/KQ5yD4HBvaJWCyI0/g6IeLgVBf9//9xq4Y32iqsKn
+ XRut2Pk3H3Az0WfUlpLpDJUgzz7er8t/glaKnESb94XR/ac59tEELbePh+bXsFLH
+ 3+v8Y78zeHJd6ZLKrKmLyq/9ZaJQR+9xmGdKzZdnwM+8seE4aOhM1VtA8ik68Tn6
+ Tbaofp1jbsXcyY4nBG9GxK14wnb/8OZmQlH4J40LsZT4KDWQNWighGig8ude7SJa
+ 6FJXWJPLfOB6r2ThiJUnrf/UXeHbvYUWITiYoWOxEVb6c7RfNLqDbbGF9VQfTD0n
+ SEFO5NqOs6KofaYzALprtgpMrqksRHeLc7Ouh9xgLyLZLx/669I9lo8M1aQ7RJMy
+ V1KDG6sYbFrgy4gQ/4xqXj3NpBmMb/VcjOnCj3j040wo8q7hlpzb6ev5lcqAFEuP
+ y1owwhljMjqAdGIBw6sLVn2on+6gEQuIjbkoapBktPDw7xEpOKe9rzTGcWRRyANs
+ Z+pMWbn8c6TKonokNjERy0iPnu2t2j8x1YpqKdjY+oq8ApNZFMlU1U+UtXFfuLw5
+ ZKR5DtmXxWzvd+nKBenjzXyOt33v5eq4I/WMfATauXBgFu75mbfiKIFVD5VeMfxq
+ DoiIqvLtW+DDUkH99zXm
+ =2APb
+ -----END PGP SIGNATURE-----
+
diff --git a/t/t5100/meta-msg0001 b/t/t5100/meta-msg0001
new file mode 100644
index 0000000000..cc0690657d
--- /dev/null
+++ b/t/t5100/meta-msg0001
@@ -0,0 +1,6 @@
+Include the raw commit data between the changelog and the diffstat.
+This will allow 'git am' to reconstruct the commit exactly to the point
+where the sha1 will be the same.
+
+Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
+Previous-version: 622a0469a4970c5daac0c0323e2d6a77b3bebbdb
diff --git a/t/t5100/meta-patch0001 b/t/t5100/meta-patch0001
new file mode 100644
index 0000000000..8b926834ce
--- /dev/null
+++ b/t/t5100/meta-patch0001
@@ -0,0 +1,76 @@
+---
+ builtin/log.c | 30 ++++++++++++++++++++++++++++++
+ 1 file changed, 30 insertions(+)
+
+diff --git a/builtin/log.c b/builtin/log.c
+index c4b35fdaf9..cd96d579a7 100644
+--- a/builtin/log.c
++++ b/builtin/log.c
+@@ -1490,6 +1490,23 @@ static void print_bases(struct base_tree_info *bases, FILE *file)
+ 	oidclr(&bases->base_commit);
+ }
+ 
++static void print_meta(struct rev_info *opt, struct commit *commit)
++{
++	const char *buffer = get_commit_buffer(commit, NULL);
++	const char *subject;
++
++	fprintf(opt->diffopt.file, "--\n");
++	fprintf(opt->diffopt.file, "commit %s\n", oid_to_hex(&commit->object.oid));
++
++	/*
++	 * TODO: hex-encode to avoid mailer mangling?
++	 */
++	if (find_commit_subject(buffer, &subject))
++		fprintf(opt->diffopt.file, "%.*s", (int) (subject - buffer), buffer);
++	else
++		fprintf(opt->diffopt.file, "%s", buffer);
++}
++
+ static const char *diff_title(struct strbuf *sb, int reroll_count,
+ 		       const char *generic, const char *rerolled)
+ {
+@@ -1545,6 +1562,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
+ 	char *branch_name = NULL;
+ 	char *base_commit = NULL;
+ 	struct base_tree_info bases;
++	int complete = 0;
+ 	int show_progress = 0;
+ 	struct progress *progress = NULL;
+ 	struct oid_array idiff_prev = OID_ARRAY_INIT;
+@@ -1622,6 +1640,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
+ 			    N_("add a signature")),
+ 		OPT_STRING(0, "base", &base_commit, N_("base-commit"),
+ 			   N_("add prerequisite tree info to the patch series")),
++		OPT_BOOL(0, "complete", &complete,
++			 N_("include all the information necessary to reconstruct commit exactly")),
+ 		OPT_FILENAME(0, "signature-file", &signature_file,
+ 				N_("add a signature from a file")),
+ 		OPT__QUIET(&quiet, N_("don't print the patch filenames")),
+@@ -1905,6 +1925,14 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
+ 		prepare_bases(&bases, base, list, nr);
+ 	}
+ 
++	if (complete) {
++		/*
++		 * We need the commit buffer so that we can output the exact
++		 * sequence of bytes that gets hashed as part of a commit.
++		 */
++		save_commit_buffer = 1;
++	}
++
+ 	if (in_reply_to || thread || cover_letter)
+ 		rev.ref_message_ids = xcalloc(1, sizeof(struct string_list));
+ 	if (in_reply_to) {
+@@ -1988,6 +2016,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
+ 			rev.shown_one = 0;
+ 		if (shown) {
+ 			print_bases(&bases, rev.diffopt.file);
++			if (complete)
++				print_meta(&rev, commit);
+ 			if (rev.mime_boundary)
+ 				fprintf(rev.diffopt.file, "\n--%s%s--\n\n\n",
+ 				       mime_boundary_leader,
+--
+2.23.0.718.g5ad94255a8
+
diff --git a/t/t5100/meta-samples.mbox b/t/t5100/meta-samples.mbox
new file mode 100644
index 0000000000..ce68687b0e
--- /dev/null
+++ b/t/t5100/meta-samples.mbox
@@ -0,0 +1,133 @@
+From nobody Mon Sep 17 00:00:00 2001
+Received: from aserp3020.oracle.com (/141.146.126.70)
+	by default (Oracle Beehive Gateway v4.0)
+	with ESMTP ; Sun, 20 Oct 2019 12:42:33 -0700
+Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
+	by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9KJcZax145871
+	for <vegard.nossum@oracle.com>; Sun, 20 Oct 2019 19:42:33 GMT
+Authentication-Results: aserp3010.oracle.com;
+	spf=softfail smtp.mailfrom=vegard.nossum@oracle.com;
+	dmarc=none header.from=oracle.com
+Received: from t460.home (dhcp-10-175-57-121.vpn.oracle.com [10.175.57.121])
+	by aserp3020.oracle.com with ESMTP id 2vrbyxapj4-1
+	for <vegard.nossum@oracle.com>; Sun, 20 Oct 2019 19:42:33 +0000
+From: Vegard Nossum <vegard.nossum@oracle.com>
+To: vegard.nossum@oracle.com
+Subject: [PATCH 1/3] format-patch: add --complete
+Date: Sun, 20 Oct 2019 21:40:24 +0200
+Message-Id: <20191020194026.19245-1-vegard.nossum@oracle.com>
+X-Mailer: git-send-email 2.23.0.718.g5ad94255a8
+MIME-Version: 1.0
+Content-Transfer-Encoding: 8bit
+X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9416 signatures=668684
+X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
+ phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=676
+ adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
+ engine=8.0.1-1908290000 definitions=main-1910200201
+
+Include the raw commit data between the changelog and the diffstat.
+This will allow 'git am' to reconstruct the commit exactly to the point
+where the sha1 will be the same.
+
+Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
+Previous-version: 622a0469a4970c5daac0c0323e2d6a77b3bebbdb
+---
+ builtin/log.c | 30 ++++++++++++++++++++++++++++++
+ 1 file changed, 30 insertions(+)
+
+diff --git a/builtin/log.c b/builtin/log.c
+index c4b35fdaf9..cd96d579a7 100644
+--- a/builtin/log.c
++++ b/builtin/log.c
+@@ -1490,6 +1490,23 @@ static void print_bases(struct base_tree_info *bases, FILE *file)
+ 	oidclr(&bases->base_commit);
+ }
+ 
++static void print_meta(struct rev_info *opt, struct commit *commit)
++{
++	const char *buffer = get_commit_buffer(commit, NULL);
++	const char *subject;
++
++	fprintf(opt->diffopt.file, "--\n");
++	fprintf(opt->diffopt.file, "commit %s\n", oid_to_hex(&commit->object.oid));
++
++	/*
++	 * TODO: hex-encode to avoid mailer mangling?
++	 */
++	if (find_commit_subject(buffer, &subject))
++		fprintf(opt->diffopt.file, "%.*s", (int) (subject - buffer), buffer);
++	else
++		fprintf(opt->diffopt.file, "%s", buffer);
++}
++
+ static const char *diff_title(struct strbuf *sb, int reroll_count,
+ 		       const char *generic, const char *rerolled)
+ {
+@@ -1545,6 +1562,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
+ 	char *branch_name = NULL;
+ 	char *base_commit = NULL;
+ 	struct base_tree_info bases;
++	int complete = 0;
+ 	int show_progress = 0;
+ 	struct progress *progress = NULL;
+ 	struct oid_array idiff_prev = OID_ARRAY_INIT;
+@@ -1622,6 +1640,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
+ 			    N_("add a signature")),
+ 		OPT_STRING(0, "base", &base_commit, N_("base-commit"),
+ 			   N_("add prerequisite tree info to the patch series")),
++		OPT_BOOL(0, "complete", &complete,
++			 N_("include all the information necessary to reconstruct commit exactly")),
+ 		OPT_FILENAME(0, "signature-file", &signature_file,
+ 				N_("add a signature from a file")),
+ 		OPT__QUIET(&quiet, N_("don't print the patch filenames")),
+@@ -1905,6 +1925,14 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
+ 		prepare_bases(&bases, base, list, nr);
+ 	}
+ 
++	if (complete) {
++		/*
++		 * We need the commit buffer so that we can output the exact
++		 * sequence of bytes that gets hashed as part of a commit.
++		 */
++		save_commit_buffer = 1;
++	}
++
+ 	if (in_reply_to || thread || cover_letter)
+ 		rev.ref_message_ids = xcalloc(1, sizeof(struct string_list));
+ 	if (in_reply_to) {
+@@ -1988,6 +2016,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
+ 			rev.shown_one = 0;
+ 		if (shown) {
+ 			print_bases(&bases, rev.diffopt.file);
++			if (complete)
++				print_meta(&rev, commit);
+ 			if (rev.mime_boundary)
+ 				fprintf(rev.diffopt.file, "\n--%s%s--\n\n\n",
+ 				       mime_boundary_leader,
+--
+commit 763f9b1cfd69ade5e22dcdcdc35d144697675a93
+tree 43a6b213a2891b5a863775771cab0c0dba3730dc
+parent 108b97dc372828f0e72e56bbb40cae8e1e83ece6
+author Vegard Nossum <vegard.nossum@oracle.com> 1570284959 +0200
+committer Vegard Nossum <vegard.nossum@oracle.com> 1571599909 +0200
+gpgsig -----BEGIN PGP SIGNATURE-----
+ Version: GnuPG v1
+ 
+ iQIcBAABAgAGBQJdrLYmAAoJEAvO9Nj+mLpY5zIQAJkdnnZMrCVme64r43M/KMm0
+ W1fmdeXiIMrI7i0McBdAsQ/KQ5yD4HBvaJWCyI0/g6IeLgVBf9//9xq4Y32iqsKn
+ XRut2Pk3H3Az0WfUlpLpDJUgzz7er8t/glaKnESb94XR/ac59tEELbePh+bXsFLH
+ 3+v8Y78zeHJd6ZLKrKmLyq/9ZaJQR+9xmGdKzZdnwM+8seE4aOhM1VtA8ik68Tn6
+ Tbaofp1jbsXcyY4nBG9GxK14wnb/8OZmQlH4J40LsZT4KDWQNWighGig8ude7SJa
+ 6FJXWJPLfOB6r2ThiJUnrf/UXeHbvYUWITiYoWOxEVb6c7RfNLqDbbGF9VQfTD0n
+ SEFO5NqOs6KofaYzALprtgpMrqksRHeLc7Ouh9xgLyLZLx/669I9lo8M1aQ7RJMy
+ V1KDG6sYbFrgy4gQ/4xqXj3NpBmMb/VcjOnCj3j040wo8q7hlpzb6ev5lcqAFEuP
+ y1owwhljMjqAdGIBw6sLVn2on+6gEQuIjbkoapBktPDw7xEpOKe9rzTGcWRRyANs
+ Z+pMWbn8c6TKonokNjERy0iPnu2t2j8x1YpqKdjY+oq8ApNZFMlU1U+UtXFfuLw5
+ ZKR5DtmXxWzvd+nKBenjzXyOt33v5eq4I/WMfATauXBgFu75mbfiKIFVD5VeMfxq
+ DoiIqvLtW+DDUkH99zXm
+ =2APb
+ -----END PGP SIGNATURE-----
+
+-- 
+2.23.0.718.g5ad94255a8
+
--
commit 53da20012e763a65071bfe0a42fbf4968d0e1e49
tree 46bdf2b042c66643bacf803bb9ffc28043343d5e
parent 7fa59e79ef5474fb4c657fb2ff6a8341cc17c897
author Vegard Nossum <vegard.nossum@oracle.com> 1571184248 +0200
committer Vegard Nossum <vegard.nossum@oracle.com> 1571666151 +0200

-- 
2.24.0.rc0.3.g4ba423c3c2

