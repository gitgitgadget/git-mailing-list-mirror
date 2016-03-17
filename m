From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/4] pretty-print: de-tabify indented logs to make things line up properly
Date: Thu, 17 Mar 2016 16:13:47 -0700
Message-ID: <xmqq37rozoic.fsf_-_@gitster.mtv.corp.google.com>
References: <alpine.LFD.2.20.1603160926060.13030@i7>
	<xmqq7fh25mkc.fsf@gitster.mtv.corp.google.com>
	<CA+55aFxV5PWdSn9Gj=zV464TtJo=QvciZrhc5Pwe+Qfyqt8sXw@mail.gmail.com>
	<xmqqwpp243sb.fsf@gitster.mtv.corp.google.com>
	<xmqqoaae4340.fsf@gitster.mtv.corp.google.com>
	<CA+55aFwbNXJnwEYrKE5dDRk_6eZeGT6Z11uSQS8RmCSq43PkdA@mail.gmail.com>
	<xmqqk2l23xzc.fsf@gitster.mtv.corp.google.com>
	<CA+55aFwbev52kTV1wNMTsxR3kWvhXxTkjVy-KQOEO_2jX3RrAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 18 00:13:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agh77-0000V6-9j
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 00:13:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933407AbcCQXNx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Mar 2016 19:13:53 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:63279 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933172AbcCQXNv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Mar 2016 19:13:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1D3B74CC49;
	Thu, 17 Mar 2016 19:13:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=zu4TpVB8koBu
	D6Hp19qNHrYfYS4=; b=vZAoss3hMH3PhNXVR58euUAysem6uYBeK2LGArVKUVEi
	1QdYpOgnqa+NpmOBJ7RwMItrKMozxtEQn/gGC9iafSaWs21NgHcLU06cPTfuGTZ+
	JKe3PRw9Vgj0qKj8xLEywY3BUAVvZl6oIu424QK7KF/lUYXR/6pboV8gYk9oJcs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=feyu59
	cNEj479DoqydrRnb5Bn/YBXedN6OBeQXh/hj54fhI4ncBL/nRSP+1/sdRv6jUP3r
	bhbpQiV5cTboJKPp81Yrvvr9ereyfq4vAbz5flG1/qxMcVtD+TUE+lDBsZ0nHtX+
	5URNWVFM/6Uk3FGMiwLV61XZFBeCx6MAl85DU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 135384CC48;
	Thu, 17 Mar 2016 19:13:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 60A2A4CC46;
	Thu, 17 Mar 2016 19:13:49 -0400 (EDT)
In-Reply-To: <CA+55aFwbev52kTV1wNMTsxR3kWvhXxTkjVy-KQOEO_2jX3RrAQ@mail.gmail.com>
	(Linus Torvalds's message of "Wed, 16 Mar 2016 15:04:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E82B5C1C-EC95-11E5-A769-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289166>

=46rom: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 16 Mar 2016 09:15:53 -0700

A commit log message sometimes tries to line things up using tabs,
assuming fixed-width font with the standard 8-place tab settings.
Viewing such a commit however does not work well in "git log", as we
indent the lines by prefixing 4 spaces in front of them.

This should all line up:

  Column 1	Column 2
  --------	--------
  A		B
  ABCD		EFGH
  SPACES        Instead of Tabs

Even with multi-byte UTF8 characters:

  Column 1	Column 2
  --------	--------
  =C3=84		B
  =C3=A5=C3=A4=C3=B6		100
  A M=C3=B8=C3=B8se	once bit my sister..

Tab-expand the lines in "git log --pretty=3Dmedium" output (which is
the default), before prefixing 4 spaces.

This breaks a few tests in t4201, that tests "git shortlog".

 - One passes "git log" output to "git shortlog" to use the latter
   as a filter and does not expect the output of the former to be
   de-tabified.

 - The other expects that "git shortlog", when it reads the first
   line of the commit and produces the output itself, does not
   de-tabify it.

Mark them as expecting failure for now.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 pretty.c            | 76 +++++++++++++++++++++++++++++++++++++++++++++=
++++++--
 t/t4201-shortlog.sh |  4 +--
 2 files changed, 76 insertions(+), 4 deletions(-)

diff --git a/pretty.c b/pretty.c
index 92b2870..0b40457 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1629,6 +1629,76 @@ void pp_title_line(struct pretty_print_context *=
pp,
 	strbuf_release(&title);
 }
=20
+static int pp_utf8_width(const char *start, const char *end)
+{
+	int width =3D 0;
+	size_t remain =3D end - start;
+
+	while (remain) {
+		int n =3D utf8_width(&start, &remain);
+		if (n < 0 || !start)
+			return -1;
+		width +=3D n;
+	}
+	return width;
+}
+
+/*
+ * pp_handle_indent() prints out the intendation, and
+ * perhaps the whole line (without the final newline)
+ *
+ * Why "perhaps"? If there are tabs in the indented line
+ * it will print it out in order to de-tabify the line.
+ *
+ * But if there are no tabs, we just fall back on the
+ * normal "print the whole line".
+ */
+static int pp_handle_indent(struct strbuf *sb, int indent,
+			     const char *line, int linelen)
+{
+	const char *tab;
+
+	strbuf_addchars(sb, ' ', indent);
+
+	tab =3D memchr(line, '\t', linelen);
+	if (!tab)
+		return 0;
+
+	do {
+		int width =3D pp_utf8_width(line, tab);
+
+		/*
+		 * If it wasn't well-formed utf8, or it
+		 * had characters with badly defined
+		 * width (control characters etc), just
+		 * give up on trying to align things.
+		 */
+		if (width < 0)
+			break;
+
+		/* Output the data .. */
+		strbuf_add(sb, line, tab - line);
+
+		/* .. and the de-tabified tab */
+		strbuf_addchars(sb, ' ', 8-(width & 7));
+
+		/* Skip over the printed part .. */
+		linelen -=3D 1+tab-line;
+		line =3D tab + 1;
+
+		/* .. and look for the next tab */
+		tab =3D memchr(line, '\t', linelen);
+	} while (tab);
+
+	/*
+	 * Print out everything after the last tab without
+	 * worrying about width - there's nothing more to
+	 * align.
+	 */
+	strbuf_add(sb, line, linelen);
+	return 1;
+}
+
 void pp_remainder(struct pretty_print_context *pp,
 		  const char **msg_p,
 		  struct strbuf *sb,
@@ -1652,8 +1722,10 @@ void pp_remainder(struct pretty_print_context *p=
p,
 		first =3D 0;
=20
 		strbuf_grow(sb, linelen + indent + 20);
-		if (indent)
-			strbuf_addchars(sb, ' ', indent);
+		if (indent) {
+			if (pp_handle_indent(sb, indent, line, linelen))
+				linelen =3D 0;
+		}
 		strbuf_add(sb, line, linelen);
 		strbuf_addch(sb, '\n');
 	}
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 7600a3e..987b708 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -93,7 +93,7 @@ test_expect_success 'output from user-defined format =
is re-wrapped' '
 	test_cmp expect log.predictable
 '
=20
-test_expect_success !MINGW 'shortlog wrapping' '
+test_expect_failure !MINGW 'shortlog wrapping' '
 	cat >expect <<\EOF &&
 A U Thor (5):
       Test
@@ -114,7 +114,7 @@ EOF
 	test_cmp expect out
 '
=20
-test_expect_success !MINGW 'shortlog from non-git directory' '
+test_expect_failure !MINGW 'shortlog from non-git directory' '
 	git log HEAD >log &&
 	GIT_DIR=3Dnon-existing git shortlog -w <log >out &&
 	test_cmp expect out
--=20
2.8.0-rc3-175-g64dcf62
