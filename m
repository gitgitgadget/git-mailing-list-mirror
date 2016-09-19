Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B6FC2070F
	for <e@80x24.org>; Mon, 19 Sep 2016 21:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752654AbcISVJO (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 17:09:14 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33101 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752315AbcISVJK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 17:09:10 -0400
Received: by mail-pf0-f173.google.com with SMTP id 21so43929244pfy.0
        for <git@vger.kernel.org>; Mon, 19 Sep 2016 14:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=bpFWCd8IBkN3LaH9BU0TgZmpSTyfEy9784ShVcL2TKI=;
        b=ibpdrIvvzrAyorxjXD0WqRoFbzUeSsJiPoCRDfx4a3GekWtGy4f15GHZFUWTdvB4It
         ZgKGs0t3gO8+NuurxQH+cqdixf78UlPJ4lZ3Mk6eZw4/rKDkKEjCQWv8VGObNHdDR688
         omdx+9rZ9UcOcc22YUPrhe+Z0ivEcPhJ8U1WUMj5zfg/LugaSCLzwB/B+q1HRQHQCHPM
         4KTLLhujaDk3DmxritTRnIgO7Qy332CU7lkrSLpbHJcRYIS6tDUJIBBhIQlxeZqE1tuj
         15sBLBeno/vT8g4pew+1SYOWAHa/dXY+/twSxTvW6odS3na5E7g2g9yWpDNQu9uicBrv
         WEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=bpFWCd8IBkN3LaH9BU0TgZmpSTyfEy9784ShVcL2TKI=;
        b=kWZaU5TXu6Q4FKeFjdLGBI/a9IQ4yjCLmh7M1H9gYySuJuc/El/fgHHpuBuCdAgmnD
         qb7ixLd1tPNrdDsSX8RdGYCHIlUNvpBeGci5kkz0UWwC05SaYDm4Xpqm+ZPFxjId6LT/
         lsI8sd4l1FPuxg3s+adir/1EoS3vA+gz0R0Q137JWAX1RvIsN4b/mLVDhiF/qNrgqXfb
         z7cQHwBXrh+eY7Ncer3InizEJSnvATYavNuHGwrkHT/Aq5z3xFDk6KBDEUfj1vIQhtru
         Y7KrowYPM47XfAVhi+LdNe5Mjr5PCqzIUp6Thai6bfe47JjzZgtAjLt7KT2UY76KAETG
         Zhow==
X-Gm-Message-State: AE9vXwPQud4loeE3HqKJxcGtEM++iDP2EuW3RdC+QmV3ajkPPAb7SfaYgVYbGMKtP1Xe20o5
X-Received: by 10.98.86.11 with SMTP id k11mr321911pfb.182.1474319349170;
        Mon, 19 Sep 2016 14:09:09 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id q14sm54484171pfg.63.2016.09.19.14.09.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Sep 2016 14:09:08 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        peff@peff.net
Subject: [PATCH v2 4/4] mailinfo: handle in-body header continuations
Date:   Mon, 19 Sep 2016 14:08:53 -0700
Message-Id: <9208b9759e8219c1d28564507fbd5a01a7e91d57.1474319086.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.10.0.rc2.20.g5b18e70
In-Reply-To: <cover.1474319086.git.jonathantanmy@google.com>
References: <cover.1474319086.git.jonathantanmy@google.com>
In-Reply-To: <cover.1474319086.git.jonathantanmy@google.com>
References: <cover.1474319086.git.jonathantanmy@google.com>
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
 mailinfo.c                           | 56 +++++++++++++++++++++++++++++++++++-
 mailinfo.h                           |  1 +
 t/t4150-am.sh                        | 23 +++++++++++++++
 t/t5100-mailinfo.sh                  |  2 +-
 t/t5100/info0018                     |  5 ++++
 t/t5100/info0018--no-inbody-headers  |  5 ++++
 t/t5100/msg0015                      |  2 --
 t/t5100/msg0018                      |  2 ++
 t/t5100/msg0018--no-inbody-headers   |  8 ++++++
 t/t5100/patch0018                    |  6 ++++
 t/t5100/patch0018--no-inbody-headers |  6 ++++
 t/t5100/sample.mbox                  | 19 ++++++++++++
 12 files changed, 131 insertions(+), 4 deletions(-)
 create mode 100644 t/t5100/info0018
 create mode 100644 t/t5100/info0018--no-inbody-headers
 create mode 100644 t/t5100/msg0018
 create mode 100644 t/t5100/msg0018--no-inbody-headers
 create mode 100644 t/t5100/patch0018
 create mode 100644 t/t5100/patch0018--no-inbody-headers

diff --git a/mailinfo.c b/mailinfo.c
index 1f487df..aec3c52 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -524,6 +524,21 @@ static int check_header(struct mailinfo *mi,
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
@@ -633,8 +648,39 @@ static int is_scissors_line(const char *line)
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
+		char *utf8 = NULL;
+		int is_scissors = mi->use_scissors && 
+				  try_convert_to_utf8(mi, line->buf,
+						      mi->charset.buf, &utf8) &&
+				  is_scissors_line(utf8 ? utf8 : line->buf);
+		free(utf8);
+		if (is_scissors) {
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
@@ -646,7 +692,11 @@ static int check_inbody_header(struct mailinfo *mi, const struct strbuf *line)
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
@@ -912,6 +962,8 @@ static void handle_body(struct mailinfo *mi, struct strbuf *line)
 			break;
 	} while (!strbuf_getwholeline(line, mi->input, '\n'));
 
+	flush_inbody_header_accum(mi);
+
 handle_body_out:
 	strbuf_release(&prev);
 }
@@ -1027,6 +1079,7 @@ void setup_mailinfo(struct mailinfo *mi)
 	strbuf_init(&mi->email, 0);
 	strbuf_init(&mi->charset, 0);
 	strbuf_init(&mi->log_message, 0);
+	strbuf_init(&mi->inbody_header_accum, 0);
 	mi->header_stage = 1;
 	mi->use_inbody_headers = 1;
 	mi->content_top = mi->content;
@@ -1040,6 +1093,7 @@ void clear_mailinfo(struct mailinfo *mi)
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

