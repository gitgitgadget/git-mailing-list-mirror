Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71C6F1F4FF
	for <e@80x24.org>; Tue, 20 Sep 2016 17:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755605AbcITRSK (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Sep 2016 13:18:10 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33183 "EHLO
        mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754694AbcITRSF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2016 13:18:05 -0400
Received: by mail-pa0-f45.google.com with SMTP id hm5so9013100pac.0
        for <git@vger.kernel.org>; Tue, 20 Sep 2016 10:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=CTImPM0w9qgOwUh8gOxZ423kxUx21NDfU3MS0oFzWqE=;
        b=bAk6jz9hZk8POoUheGZpYh0qhf3z4bqnBgzIlEsynvveHVaQxdZiIPAeg3dDz3Gb/r
         hPwAB0JKhgj/abHGx4NRwmqGonByVSrukgaG9Hb3KqnhY6Us34d663k1XPfT25XVi2r+
         soOMBq8Ue2094lRVAAKjUtihaWtvRnXs3fMfI2eiVPWILfQDm/GgiwHisP7JdU6u5Ng1
         y33wjuxftn2G6y7qwKTp2cLhCvpEJce9SW+oP1SseNXIFpxa1UVWo85IJtXoD7mS7eVz
         ffQHAjaCrZ89Iy2HBijprE7CWb7BpjgHC8HpxVBp0hK//JdRM/qdNux6Kll/YDUJ3MHZ
         3dlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=CTImPM0w9qgOwUh8gOxZ423kxUx21NDfU3MS0oFzWqE=;
        b=XYKOYRZf5ueIM8nFRlXTYIJhMGKgtXG3pWuBoww2DKlkLn5NPOC7Hbc82Bh1JDA/nT
         uNxU4rPUfZFf607UlC8XNmdD4J4Mj/7wjo1o/6UVcX5Xf9zmOWcZNZo+r11FD+3jWzDF
         8hX1xhsfTEMtP3j0+Z03+vnkl3l0XgyrYixQr7xCiujOKHByws4bgRtTsKCYqmhAlNv4
         uABPPY5OvmYekkkjXbDyx6zqWCDi2y3CnCgu4bd6nOHzdQupcBpJuDS7WT01MAISF2WI
         1OTig4NvmoR3JWSg2rXSa5f2tDtUkDelmE1VL+bP61rnv3H9GrfyTKqMwJyUVXaXVwlp
         Yhfw==
X-Gm-Message-State: AE9vXwNsWndLOxkLsC3JK+VDHQaupYtAyf8ZvAbdvaYrL2ipMe/o3pyXaO482caH2r/Y27pE
X-Received: by 10.66.249.134 with SMTP id yu6mr58220199pac.44.1474391884686;
        Tue, 20 Sep 2016 10:18:04 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id x9sm80586932pfd.70.2016.09.20.10.18.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Sep 2016 10:18:03 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH v3 3/3] mailinfo: handle in-body header continuations
Date:   Tue, 20 Sep 2016 10:17:53 -0700
Message-Id: <54f0a036b504e88af3122069864524d60a954a4d.1474391594.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.10.0.rc2.20.g5b18e70
In-Reply-To: <cover.1474391594.git.jonathantanmy@google.com>
References: <cover.1474391594.git.jonathantanmy@google.com>
In-Reply-To: <cover.1474391594.git.jonathantanmy@google.com>
References: <cover.1474319086.git.jonathantanmy@google.com> <cover.1474391594.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mailinfo currently handles multi-line headers, but it does not handle
multi-line in-body headers. Teach it to handle such headers, for
example, for this input:

  From: author <author@example.com>
  Date: Fri, 9 Jun 2006 00:44:16 -0700
  Subject: a very long
   broken line

  Subject: another very long
   broken line

interpret the in-body subject to be "another very long broken line"
instead of "another very long".

An existing test (t/t5100/msg0015) has an indented line immediately
after an in-body header - it has been modified to reflect the new
functionality.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 mailinfo.c                           | 50 +++++++++++++++++++++++++++++++++++-
 mailinfo.h                           |  1 +
 t/t4150-am.sh                        | 23 +++++++++++++++++
 t/t5100-mailinfo.sh                  |  2 +-
 t/t5100/info0018                     |  5 ++++
 t/t5100/info0018--no-inbody-headers  |  5 ++++
 t/t5100/msg0015                      |  2 --
 t/t5100/msg0018                      |  2 ++
 t/t5100/msg0018--no-inbody-headers   |  8 ++++++
 t/t5100/patch0018                    |  6 +++++
 t/t5100/patch0018--no-inbody-headers |  6 +++++
 t/t5100/sample.mbox                  | 19 ++++++++++++++
 12 files changed, 125 insertions(+), 4 deletions(-)
 create mode 100644 t/t5100/info0018
 create mode 100644 t/t5100/info0018--no-inbody-headers
 create mode 100644 t/t5100/msg0018
 create mode 100644 t/t5100/msg0018--no-inbody-headers
 create mode 100644 t/t5100/patch0018
 create mode 100644 t/t5100/patch0018--no-inbody-headers

diff --git a/mailinfo.c b/mailinfo.c
index 69391aa..2275b28 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -500,6 +500,21 @@ static int check_header(struct mailinfo *mi,
 	return ret;
 }
 
+/*
+ * Returns 1 if the given line or any line beginning with the given line is an
+ * in-body header (that is, check_header will succeed when passed
+ * mi->s_hdr_data).
+ */
+static int is_inbody_header(const struct mailinfo *mi,
+			    const struct strbuf *line)
+{
+	int i;
+	for (i = 0; header[i]; i++)
+		if (!mi->s_hdr_data[i] && cmp_header(line, header[i]))
+			return 1;
+	return 0;
+}
+
 static void decode_transfer_encoding(struct mailinfo *mi, struct strbuf *line)
 {
 	struct strbuf *ret;
@@ -609,8 +624,33 @@ static int is_scissors_line(const char *line)
 		gap * 2 < perforation);
 }
 
+static void flush_inbody_header_accum(struct mailinfo *mi)
+{
+	if (!mi->inbody_header_accum.len)
+		return;
+	assert(check_header(mi, &mi->inbody_header_accum, mi->s_hdr_data, 0));
+	strbuf_reset(&mi->inbody_header_accum);
+}
+
 static int check_inbody_header(struct mailinfo *mi, const struct strbuf *line)
 {
+	if (mi->inbody_header_accum.len &&
+	    (line->buf[0] == ' ' || line->buf[0] == '\t')) {
+		if (mi->use_scissors && is_scissors_line(line->buf)) {
+			/*
+			 * This is a scissors line; do not consider this line
+			 * as a header continuation line.
+			 */
+			flush_inbody_header_accum(mi);
+			return 0;
+		}
+		strbuf_strip_suffix(&mi->inbody_header_accum, "\n");
+		strbuf_addbuf(&mi->inbody_header_accum, line);
+		return 1;
+	}
+
+	flush_inbody_header_accum(mi);
+
 	if (starts_with(line->buf, ">From") && isspace(line->buf[5]))
 		return is_format_patch_separator(line->buf + 1, line->len - 1);
 	if (starts_with(line->buf, "[PATCH]") && isspace(line->buf[7])) {
@@ -622,7 +662,11 @@ static int check_inbody_header(struct mailinfo *mi, const struct strbuf *line)
 			}
 		return 0;
 	}
-	return check_header(mi, line, mi->s_hdr_data, 0);
+	if (is_inbody_header(mi, line)) {
+		strbuf_addbuf(&mi->inbody_header_accum, line);
+		return 1;
+	}
+	return 0;
 }
 
 static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
@@ -888,6 +932,8 @@ static void handle_body(struct mailinfo *mi, struct strbuf *line)
 			break;
 	} while (!strbuf_getwholeline(line, mi->input, '\n'));
 
+	flush_inbody_header_accum(mi);
+
 handle_body_out:
 	strbuf_release(&prev);
 }
@@ -1003,6 +1049,7 @@ void setup_mailinfo(struct mailinfo *mi)
 	strbuf_init(&mi->email, 0);
 	strbuf_init(&mi->charset, 0);
 	strbuf_init(&mi->log_message, 0);
+	strbuf_init(&mi->inbody_header_accum, 0);
 	mi->header_stage = 1;
 	mi->use_inbody_headers = 1;
 	mi->content_top = mi->content;
@@ -1016,6 +1063,7 @@ void clear_mailinfo(struct mailinfo *mi)
 	strbuf_release(&mi->name);
 	strbuf_release(&mi->email);
 	strbuf_release(&mi->charset);
+	strbuf_release(&mi->inbody_header_accum);
 	free(mi->message_id);
 
 	for (i = 0; mi->p_hdr_data[i]; i++)
diff --git a/mailinfo.h b/mailinfo.h
index 93776a7..04a2535 100644
--- a/mailinfo.h
+++ b/mailinfo.h
@@ -27,6 +27,7 @@ struct mailinfo {
 	int patch_lines;
 	int filter_stage; /* still reading log or are we copying patch? */
 	int header_stage; /* still checking in-body headers? */
+	struct strbuf inbody_header_accum;
 	struct strbuf **p_hdr_data;
 	struct strbuf **s_hdr_data;
 
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 9ce9424..89a5bac 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -977,4 +977,27 @@ test_expect_success 'am --patch-format=mboxrd handles mboxrd' '
 	test_cmp msg out
 '
 
+test_expect_success 'am works with multi-line in-body headers' '
+	FORTY="String that has a length of more than forty characters" &&
+	LONG="$FORTY $FORTY" &&
+	rm -fr .git/rebase-apply &&
+	git checkout -f first &&
+	echo one >> file &&
+	git commit -am "$LONG" --author="$LONG <long@example.com>" &&
+	git format-patch --stdout -1 >patch &&
+	# bump from, date, and subject down to in-body header
+	perl -lpe "
+		if (/^From:/) {
+			print \"From: x <x\@example.com>\";
+			print \"Date: Sat, 1 Jan 2000 00:00:00 +0000\";
+			print \"Subject: x\n\";
+		}
+	" patch >msg &&
+	git checkout HEAD^ &&
+	git am msg &&
+	# Ensure that the author and full message are present
+	git cat-file commit HEAD | grep "^author.*long@example.com" &&
+	git cat-file commit HEAD | grep "^$LONG"
+'
+
 test_done
diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index 1a5a546..e173c33 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -11,7 +11,7 @@ test_expect_success 'split sample box' \
 	'git mailsplit -o. "$TEST_DIRECTORY"/t5100/sample.mbox >last &&
 	last=$(cat last) &&
 	echo total is $last &&
-	test $(cat last) = 17'
+	test $(cat last) = 18'
 
 check_mailinfo () {
 	mail=$1 opt=$2
diff --git a/t/t5100/info0018 b/t/t5100/info0018
new file mode 100644
index 0000000..d53e749
--- /dev/null
+++ b/t/t5100/info0018
@@ -0,0 +1,5 @@
+Author: Another Thor
+Email: a.thor@example.com
+Subject: This one contains a tab and a space
+Date: Fri, 9 Jun 2006 00:44:16 -0700
+
diff --git a/t/t5100/info0018--no-inbody-headers b/t/t5100/info0018--no-inbody-headers
new file mode 100644
index 0000000..30b17bd
--- /dev/null
+++ b/t/t5100/info0018--no-inbody-headers
@@ -0,0 +1,5 @@
+Author: A U Thor
+Email: a.u.thor@example.com
+Subject: check multiline inbody headers
+Date: Fri, 9 Jun 2006 00:44:16 -0700
+
diff --git a/t/t5100/msg0015 b/t/t5100/msg0015
index 4abb3d5..e69de29 100644
--- a/t/t5100/msg0015
+++ b/t/t5100/msg0015
@@ -1,2 +0,0 @@
-  - a list
-  - of stuff
diff --git a/t/t5100/msg0018 b/t/t5100/msg0018
new file mode 100644
index 0000000..56de83d
--- /dev/null
+++ b/t/t5100/msg0018
@@ -0,0 +1,2 @@
+a commit message
+
diff --git a/t/t5100/msg0018--no-inbody-headers b/t/t5100/msg0018--no-inbody-headers
new file mode 100644
index 0000000..b1e05d3
--- /dev/null
+++ b/t/t5100/msg0018--no-inbody-headers
@@ -0,0 +1,8 @@
+From: Another Thor
+ <a.thor@example.com>
+Subject: This one contains
+	a tab
+ and a space
+
+a commit message
+
diff --git a/t/t5100/patch0018 b/t/t5100/patch0018
new file mode 100644
index 0000000..789df6d
--- /dev/null
+++ b/t/t5100/patch0018
@@ -0,0 +1,6 @@
+diff --git a/foo b/foo
+index e69de29..d95f3ad 100644
+--- a/foo
++++ b/foo
+@@ -0,0 +1 @@
++content
diff --git a/t/t5100/patch0018--no-inbody-headers b/t/t5100/patch0018--no-inbody-headers
new file mode 100644
index 0000000..789df6d
--- /dev/null
+++ b/t/t5100/patch0018--no-inbody-headers
@@ -0,0 +1,6 @@
+diff --git a/foo b/foo
+index e69de29..d95f3ad 100644
+--- a/foo
++++ b/foo
+@@ -0,0 +1 @@
++content
diff --git a/t/t5100/sample.mbox b/t/t5100/sample.mbox
index 8b2ae06..6d4d0e4 100644
--- a/t/t5100/sample.mbox
+++ b/t/t5100/sample.mbox
@@ -699,3 +699,22 @@ index e69de29..d95f3ad 100644
 +++ b/foo
 @@ -0,0 +1 @@
 +New content
+From nobody Mon Sep 17 00:00:00 2001
+From: A U Thor <a.u.thor@example.com>
+Subject: check multiline inbody headers
+Date: Fri, 9 Jun 2006 00:44:16 -0700
+
+From: Another Thor
+ <a.thor@example.com>
+Subject: This one contains
+	a tab
+ and a space
+
+a commit message
+
+diff --git a/foo b/foo
+index e69de29..d95f3ad 100644
+--- a/foo
++++ b/foo
+@@ -0,0 +1 @@
++content
-- 
2.10.0.rc2.20.g5b18e70

