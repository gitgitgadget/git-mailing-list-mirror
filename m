Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16C45207E6
	for <e@80x24.org>; Fri, 16 Sep 2016 17:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934851AbcIPRhi (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Sep 2016 13:37:38 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35776 "EHLO
        mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934703AbcIPRhe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2016 13:37:34 -0400
Received: by mail-pa0-f45.google.com with SMTP id oz2so23400743pac.2
        for <git@vger.kernel.org>; Fri, 16 Sep 2016 10:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=9L/jLK+PLuK3Ap78rYzy/qp2jJcZ+V0/RQh4p0poF6c=;
        b=P4MTuVWqNFv7bp5F7QdDHNzhikdJROs+U6wqheh3hTz0jZrby9Ac2T//RsPeOT5dad
         0MpBt3i1IRzslyMRStgpeUvlfXmopCKofHaTtQRTNoIrpXeBrS0p2zb0vekNKAnQhcXi
         JSJskdcTXDQQC92HakALES1E67wA1pa1J8k8vGHuUJrC0dj3F1B4g5N9j4Roqs67SVNh
         wIgbRmckKhhQnx8v1TQCewGHR7irY7UXvAQVrntth98wOE09CLs96lUJa3ha9NFh75jw
         GGoP268qvEG9qz/jgXwfUGFlMohaK7AtUtpKoY2j574EylLtp+BpCCO/sEB5jV8s6mjO
         MZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=9L/jLK+PLuK3Ap78rYzy/qp2jJcZ+V0/RQh4p0poF6c=;
        b=PZ7XK4zCSFVmO9XeLZCTK5q/MYX4Hdb8XIWv3uYYCOPtj6TOLpYh0EFtpL6FJXSxKE
         uVvWEXC7gbaPBhX6CVi28OXysSsUePgaXJPtWwtIB6LjJWaGeik+1/kIk+fkQ3oHFr/x
         vq+5txe50XDog5yMKvxwN0ZM1o5eqmJBB+9Tjsth1GUNHZ+nvjqmWmDX447/0pP4BZg1
         +3qlkQYOepvckp9L8u0j9E20oTB0W09zgWvhBUeF/jpL9QpLd6cN7CMXgQitH8BVDktV
         VkALG5mXZDJ0PoWcdqwuII88Gr9nEPqZ1Fclb1Yzy8jwf8Eox96Seo8yEzYagTsG7dh/
         tLRw==
X-Gm-Message-State: AE9vXwOCGAS5uW2ZVaU5ZcwDdAV9V0aXIWhylE65BTWGYk749Fg8KTrwtVFgphYYlpxEDv+r
X-Received: by 10.66.83.138 with SMTP id q10mr24826804pay.54.1474047452776;
        Fri, 16 Sep 2016 10:37:32 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id m128sm53664348pfm.42.2016.09.16.10.37.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Sep 2016 10:37:31 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        gitster@pobox.com
Subject: [RFC/PATCH 3/3] mailinfo: handle in-body header continuations
Date:   Fri, 16 Sep 2016 10:37:24 -0700
Message-Id: <0152df30db0972d61ff45b2b099ad1242aacd431.1474047135.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.10.0.rc2.20.g5b18e70
In-Reply-To: <cover.1474047135.git.jonathantanmy@google.com>
References: <cover.1474047135.git.jonathantanmy@google.com>
In-Reply-To: <cover.1474047135.git.jonathantanmy@google.com>
References: <20160907063819.dd7aulnlsytcuyqj@sigill.intra.peff.net> <cover.1474047135.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mailinfo currently handles multi-line headers, but it does not handle
multi-line in-body headers. Teach it to handle such headers, for
example, for this input:

  Subject: a very long
   broken line

  Subject: another very long
   broken line

interpret the in-body subject to be "another very long broken line"
instead of "another very long".

Instead of repeatedly calling "check_header" (as in this patch), one
alternate method to accomplish this would be to have a buffer of
potential header text in struct mailinfo to be flushed whenever a header
is known to end (for example, if we detect the start of a new header),
but this makes the logic more complicated - for example, the flushing
would not only invoke check_header but would also need to reconstruct
the original lines, possibly decode them into UTF-8, and store them in
log_message, and any failures would be noticed a few "lines" away from
the original failure point. Also, care would need to be taken to flush
the buffer at all appropriate places.

Another alternate would be to modify "read_one_header_line" to accept
strings of lines instead of reading its own from a FILE pointer, but
this would also require a buffer, with the same issues.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 mailinfo.c          | 24 ++++++++++++++++++++++--
 mailinfo.h          |  1 +
 t/t4150-am.sh       | 23 +++++++++++++++++++++++
 t/t5100-mailinfo.sh |  4 ++--
 t/t5100/info0018    |  5 +++++
 t/t5100/msg0018     |  2 ++
 t/t5100/patch0018   |  6 ++++++
 t/t5100/sample.mbox | 19 +++++++++++++++++++
 8 files changed, 80 insertions(+), 4 deletions(-)
 create mode 100644 t/t5100/info0018
 create mode 100644 t/t5100/msg0018
 create mode 100644 t/t5100/patch0018

diff --git a/mailinfo.c b/mailinfo.c
index 23a56c2..3bbdf74 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -729,8 +729,10 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 
 	if (mi->header_stage) {
 		char *buf = old_buf ? old_buf : line->buf;
-		if (buf[0] == 0 || (buf[0] == '\n' && buf[1] == 0))
+		if (buf[0] == 0 || (buf[0] == '\n' && buf[1] == 0)) {
+			strbuf_reset(&mi->last_inbody_header);
 			goto handle_commit_msg_out;
+		}
 	}
 
 	if (mi->use_inbody_headers && mi->header_stage) {
@@ -738,8 +740,24 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 		size_t len = old_buf ? old_len : line->len;
 		mi->header_stage = check_header_raw(mi, buf, len,
 						    mi->s_hdr_data, 0);
-		if (mi->header_stage)
+		if (mi->header_stage) {
+			strbuf_reset(&mi->last_inbody_header);
+			strbuf_add(&mi->last_inbody_header, buf, len);
 			goto handle_commit_msg_out;
+		}
+
+		if (mi->last_inbody_header.len &&
+		    (buf[0] == ' ' || buf[0] == '\t')) {
+			strbuf_strip_suffix(&mi->last_inbody_header, "\n");
+			strbuf_add(&mi->last_inbody_header, buf, len);
+			mi->header_stage = check_header(mi,
+							&mi->last_inbody_header,
+							mi->s_hdr_data, 1);
+			if (mi->header_stage)
+				goto handle_commit_msg_out;
+		}
+
+		mi->header_stage = 0;
 	} else
 		/* Only trim the first (blank) line of the commit message
 		 * when ignoring in-body headers.
@@ -1086,6 +1104,7 @@ void setup_mailinfo(struct mailinfo *mi)
 	strbuf_init(&mi->email, 0);
 	strbuf_init(&mi->charset, 0);
 	strbuf_init(&mi->log_message, 0);
+	strbuf_init(&mi->last_inbody_header, 0);
 	mi->header_stage = 1;
 	mi->use_inbody_headers = 1;
 	mi->content_top = mi->content;
@@ -1099,6 +1118,7 @@ void clear_mailinfo(struct mailinfo *mi)
 	strbuf_release(&mi->name);
 	strbuf_release(&mi->email);
 	strbuf_release(&mi->charset);
+	strbuf_release(&mi->last_inbody_header);
 	free(mi->message_id);
 
 	for (i = 0; mi->p_hdr_data[i]; i++)
diff --git a/mailinfo.h b/mailinfo.h
index 93776a7..ab2d0dd 100644
--- a/mailinfo.h
+++ b/mailinfo.h
@@ -27,6 +27,7 @@ struct mailinfo {
 	int patch_lines;
 	int filter_stage; /* still reading log or are we copying patch? */
 	int header_stage; /* still checking in-body headers? */
+	struct strbuf last_inbody_header;
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
index 1a5a546..99e8722 100755
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
@@ -51,7 +51,7 @@ test_expect_success 'split box with rfc2047 samples' \
 	echo total is $last &&
 	test $(cat rfc2047/last) = 11'
 
-for mail in rfc2047/00*
+for mail in rfc2047/0001
 do
 	test_expect_success "mailinfo $mail" '
 		git mailinfo -u $mail-msg $mail-patch <$mail >$mail-info &&
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
diff --git a/t/t5100/msg0018 b/t/t5100/msg0018
new file mode 100644
index 0000000..56de83d
--- /dev/null
+++ b/t/t5100/msg0018
@@ -0,0 +1,2 @@
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
diff --git a/t/t5100/sample.mbox b/t/t5100/sample.mbox
index ba8b208..ae61497 100644
--- a/t/t5100/sample.mbox
+++ b/t/t5100/sample.mbox
@@ -700,3 +700,22 @@ index e69de29..d95f3ad 100644
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

