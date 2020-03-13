Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF620C4CECE
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 12:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA8CA20746
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 12:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dePLiHQC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgCMMXo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Mar 2020 08:23:44 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:37265 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgCMMXo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Mar 2020 08:23:44 -0400
Received: by mail-pl1-f172.google.com with SMTP id f16so4198823plj.4
        for <git@vger.kernel.org>; Fri, 13 Mar 2020 05:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xgoW0Gi3MEdhHptU4qsN60lX7ZW0zkclbNP8S5BC6CY=;
        b=dePLiHQC+EKmTz5HetP/ZkE8fIivvXkf3y6tTLlfqdBsDxR06Zh+DWQSKKcNsaj95b
         Oue9QXr6nzU3s85VUnuHNeBqpkcwITDYUGGwepvOJVjsb9RGh8zk6jelZZeyhNV7AQAm
         fSGY9qmYECV41LINBNPoE0nx54QvS06xj+j9g9qO8YHAlvJpZ++GK27PXDp7pkELshwv
         /1wffoQz+CvMnkUGOLih3Uojv8AkWYh/Ma2fshCDWId0K8o5I3pbU9eqQP/ZwIxawm23
         vcJLDWgDfrD9S/OFazDje3RnV18l3y4GS4MtJT8zSZmuKo2lR5RrhFOMw+srLMiav2TU
         E2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xgoW0Gi3MEdhHptU4qsN60lX7ZW0zkclbNP8S5BC6CY=;
        b=YmVTzictcaV4TO4zgg8xvaXKT5+d3LcgpT9cFsyXCpE8f3I+8wxYCvJY95xqmWfATP
         NHgzK5VQ1Zk2UiStDOtuXZ4izFCQjrwm0eSqdfk+5LMgojxhxIBKSwuvZSZiGMJ12anU
         8G8NlB+wNJhdwRAU1nLnUZk3XlwqnEbP9GmWtqRJ7qTbsMRFF8kg2NY1DXzJJh3K2FxJ
         4r6iSKmIycasws6Z/S9OxMH0hfIioLslj7qGzfGpjsbxHadgz1YCAiwEu7A1+lmg3XWE
         Fx6o/ppGKzgcHeXdCymVkDUSDwmKfWRpftdY51OECdJftuJ6IEPO6JTzog7gWSmH2zqF
         a7jQ==
X-Gm-Message-State: ANhLgQ2ugSXkKBOeva1faigMazNu/uWE9eMPpDCQGByHb5zLcVOfAdyK
        niGcDy+DXebMLMf/adoT9po=
X-Google-Smtp-Source: ADFU+vsMtfK6w4ghAv9ue6Rf/DfudgVGc44r4tedJZnfAEZtsjGLOxgAFWDplGHc0soQ/y0lX67JUQ==
X-Received: by 2002:a17:902:6ac2:: with SMTP id i2mr12725830plt.221.1584102221617;
        Fri, 13 Mar 2020 05:23:41 -0700 (PDT)
Received: from localhost.localdomain ([47.89.83.4])
        by smtp.gmail.com with ESMTPSA id 134sm5346690pfy.27.2020.03.13.05.23.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Mar 2020 05:23:41 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
X-Google-Original-From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v3 2/4] receive-pack: refactor report for proc-receive
Date:   Fri, 13 Mar 2020 20:23:16 +0800
Message-Id: <20200313122318.78000-3-zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.26.0.rc1.5.gca1e965b06
In-Reply-To: <CANYiYbHvqLX_OozgAXJ8MbuLipqUdj4CpbExe0oiCcyUyb=Osw@mail.gmail.com>
References: <CANYiYbHvqLX_OozgAXJ8MbuLipqUdj4CpbExe0oiCcyUyb=Osw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "proc-receive" may update one or more references, and will send its
result one by one in pkt-line format.  Each line of the result has four
fields and one optional message field, as "<old-oid> <new-oid> <ref>
<status> [<message>]".  See the following example:

    # OK, run this command successfully.
    PKT-LINE(old-oid new-oid ref ok)

    # NO, I reject it.
    PKT-LINE(old-oid new-oid ref ng reason)

    # OK, but use an alternate reference.
    PKT-LINE(old-oid new-oid ref ok ref:alt-ref)

    # It will fallthrough to receive-pack to execute.
    PKT-LINE(old-oid new-oid ref ft)

The first three fields have the same foramt as a command.

The forth field has a two-letter status code.  Available status code:

* ok: The command runs successfully.  If the optional message has a
  prefix "ref:", the hook has created/updated an alternate reference
  instead.

* ng: Fail to run the command. Error message is in the optional message
  field.

* ft: Will fallthrough to receive-pack to execute.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 builtin/receive-pack.c | 21 ++++++++++++++++-----
 transport.c            | 33 ++++++++++++++++++++++++---------
 2 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 8cda2b9cf7..23f1ae3795 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -311,6 +311,7 @@ static void write_head_info(void)
 struct command {
 	struct command *next;
 	const char *error_string;
+	const char *extra_string;
 	unsigned int skip_update:1,
 		     did_not_exist:1,
 		     have_special_ref:1;
@@ -868,7 +869,12 @@ static int read_proc_receive_result(struct packet_reader *reader,
 			else
 				cmd->error_string = "failed";
 			code = 1;
-		} else if (strcmp("ok", status)) {
+		} else if (!strcmp("ok", status)) {
+			cmd->extra_string = xstrdup_or_null(msg);
+		} else if (!strcmp("ft", status)) {
+			/* Unset "have_special_ref" field, will execute by "receive-pack" */
+			cmd->have_special_ref = 0;
+		} else {
 			rp_warning("unknown proc-receive status '%s' for '%s'",
 				   status, reader->line);
 			cmd->error_string = "bad status";
@@ -2133,12 +2139,17 @@ static void report(struct command *commands, const char *unpack_status)
 	packet_buf_write(&buf, "unpack %s\n",
 			 unpack_status ? unpack_status : "ok");
 	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (!cmd->error_string)
-			packet_buf_write(&buf, "ok %s\n",
-					 cmd->ref_name);
-		else
+		if (!cmd->error_string) {
+			if (!cmd->extra_string)
+				packet_buf_write(&buf, "ok %s\n",
+						 cmd->ref_name);
+			else
+				packet_buf_write(&buf, "ok %s%c%s\n",
+						 cmd->ref_name, ' ', cmd->extra_string);
+		} else {
 			packet_buf_write(&buf, "ng %s %s\n",
 					 cmd->ref_name, cmd->error_string);
+		}
 	}
 	packet_buf_flush(&buf);
 
diff --git a/transport.c b/transport.c
index 1fdc7dac1a..a4f2a5cc6f 100644
--- a/transport.c
+++ b/transport.c
@@ -463,11 +463,17 @@ static void print_ref_status(char flag, const char *summary,
 			     struct ref *to, struct ref *from, const char *msg,
 			     int porcelain, int summary_width)
 {
+	char *to_name = to->name;
+
+	if (to->remote_status) {
+		if (!strncmp("ref:", to->remote_status, 4))
+			to_name = to->remote_status + 4;
+	}
 	if (porcelain) {
 		if (from)
-			fprintf(stdout, "%c\t%s:%s\t", flag, from->name, to->name);
+			fprintf(stdout, "%c\t%s:%s\t", flag, from->name, to_name);
 		else
-			fprintf(stdout, "%c\t:%s\t", flag, to->name);
+			fprintf(stdout, "%c\t:%s\t", flag, to_name);
 		if (msg)
 			fprintf(stdout, "%s (%s)\n", summary, msg);
 		else
@@ -481,9 +487,9 @@ static void print_ref_status(char flag, const char *summary,
 		fprintf(stderr, " %s%c %-*s%s ", red, flag, summary_width,
 			summary, reset);
 		if (from)
-			fprintf(stderr, "%s -> %s", prettify_refname(from->name), prettify_refname(to->name));
+			fprintf(stderr, "%s -> %s", prettify_refname(from->name), prettify_refname(to_name));
 		else
-			fputs(prettify_refname(to->name), stderr);
+			fputs(prettify_refname(to_name), stderr);
 		if (msg) {
 			fputs(" (", stderr);
 			fputs(msg, stderr);
@@ -498,12 +504,21 @@ static void print_ok_ref_status(struct ref *ref, int porcelain, int summary_widt
 	if (ref->deletion)
 		print_ref_status('-', "[deleted]", ref, NULL, NULL,
 				 porcelain, summary_width);
-	else if (is_null_oid(&ref->old_oid))
+	else if (is_null_oid(&ref->old_oid)) {
+		char *refname, *summary;
+		if (ref->remote_status && !strncmp(ref->remote_status, "ref:", 4))
+			refname = ref->remote_status + 4;
+		else
+			refname = ref->name;
+		if (starts_with(refname, "refs/tags/"))
+		       summary = "[new tag]";
+		else if (starts_with(refname, "refs/heads/"))
+		       summary = "[new branch]";
+		else
+		       summary = "[new reference]";
 		print_ref_status('*',
-			(starts_with(ref->name, "refs/tags/") ? "[new tag]" :
-			"[new branch]"),
-			ref, ref->peer_ref, NULL, porcelain, summary_width);
-	else {
+			summary, ref, ref->peer_ref, NULL, porcelain, summary_width);
+	} else {
 		struct strbuf quickref = STRBUF_INIT;
 		char type;
 		const char *msg;
-- 
2.26.0.rc1.5.gca1e965b06

