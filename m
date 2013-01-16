From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow custom "comment char"
Date: Tue, 15 Jan 2013 22:23:24 -0800
Message-ID: <7vmww9zlwj.fsf@alter.siamese.dyndns.org>
References: <7vk3rk25iw.fsf_-_@alter.siamese.dyndns.org>
 <1358275827-5244-1-git-send-email-ralf.thielow@gmail.com>
 <7v622y45wy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jrnieder@gmail.com, git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 07:23:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvMPd-0002TH-PH
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 07:23:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753778Ab3APGX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 01:23:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59834 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752472Ab3APGX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 01:23:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 05944592D;
	Wed, 16 Jan 2013 01:23:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nwQmuNZXrWXH+sNjjZxlAo4GSuk=; b=wRyHAq
	SBydXlzbQIgdeNS12NCFVVHjfCbV9yYaRDW5sQWT6JQbtZ2gzrbhJzslTdp9W1EB
	Wa88uwhDdnOslxo2cegodhrOMotzfF6N3MFvCaDzIPq2D5AXR05d8hjzzZn6l00Y
	Yx8nG+wXuCvo3X+oX6M40TuFoam6LxfD7y9TA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OVs5V6rrbfrCLiX3KtRcl3wtvVpdeK2p
	FAlFPXP6AWfOCMObNanZ7kO8McV+GaEauRwNxRng8TS8Sd5O6zW9e7XIWKlLrIC0
	yelED+hsJ/rwLwLlZYqZokPZu2Fx6r9M3qgu7tta8L8KamMyZI+l5ZRTGd6xgBRD
	sELFPKjM/l0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EDCF8592B;
	Wed, 16 Jan 2013 01:23:26 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F042C5929; Wed, 16 Jan 2013
 01:23:25 -0500 (EST)
In-Reply-To: <7v622y45wy.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 15 Jan 2013 11:12:13 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3C44CBE8-5FA5-11E2-A1D8-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213731>

Junio C Hamano <gitster@pobox.com> writes:

> Ralf Thielow <ralf.thielow@gmail.com> writes:
> ...
> Looks like a good progress overall, except for nits here and there.
>
>> diff --git a/builtin/notes.c b/builtin/notes.c
>> index 453457a..5e84e35 100644
>> --- a/builtin/notes.c
>> +++ b/builtin/notes.c
>> @@ -92,10 +92,7 @@ static const char * const git_notes_get_ref_usage[] = {
>>  };
>>  
>>  static const char note_template[] =
>> -	"\n"
>> -	"#\n"
>> -	"# Write/edit the notes for the following object:\n"
>> -	"#\n";
>> +	"Write/edit the notes for the following object:";
>
> I think this (and its use site that manually adds "\n#\n") is a
> symptom of strbuf_commented_add*() function not designed right.
> When it iterates over lines and adds each of them in a commented out
> form, it could check if the line is an empty one and refrain from
> adding a trailing SP if that is the case.  Then this can become
>
>     "\nWrite/edit the notes...\n\n";
>
> You have to create the "\n" blank line at the beginning manually,
> but that is logically outside the commented out block, so it is not
> a problem.

>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index 22ec5b6..1b8d95f 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -975,13 +975,19 @@ cmd_summary() {
>>  		echo
>>  	done |
>>  	if test -n "$for_status"; then
>> +		comment_char=`git config core.commentchar`
>> +		if [ ! -n "$comment_char" ]; then
>> +			comment_char='#'
>> +		elif [ ${#comment_char} -gt 1 ]; then
>
> Not portable, I think.
>
>> +		echo "$comment_char"
>> +		sed -e "s|^|$comment_char |" -e "s|^$comment_char $|$comment_char|"
>
> Can $comment_char be a '|'?

I think it may be the easiest to teach one of the pure-helper
commands, e.g. "git stripspace", to do this kind of thing for you
with a new option.

To summarize, along the lines of the attached patch (on top of
jc/custom-comment-char topic).

 builtin/branch.c     | 20 +++++++++-----------
 builtin/stripspace.c | 35 +++++++++++++++++++++++++++++------
 strbuf.c             | 42 +++++++++++++++++++++++++++++++++++++++++-
 strbuf.h             |  4 ++++
 4 files changed, 83 insertions(+), 18 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 7f8865a..42de4c5 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -707,18 +707,16 @@ static int edit_branch_description(const char *branch_name)
 	if (!buf.len || buf.buf[buf.len-1] != '\n')
 		strbuf_addch(&buf, '\n');
 	/*
-	 * NEEDSWORK: introduce a strbuf_commented_addf(), possibly
-	 * sharing code with status_vprintf(), that makes each line
-	 * commented with comment_line_char, and use it here and from
-	 * other places (e.g. write_commented_object() and create_note()
-	 * in builtin/notes.c and create_tag() in builtin/tag.c).
+	 * NEEDSWORK: convert more code to use this:
+	 * (e.g. write_commented_object() and create_note() in
+	 * builtin/notes.c and create_tag() in builtin/tag.c).
 	 */
-	strbuf_addf(&buf,
-		    "%c Please edit the description for the branch\n"
-		    "%c   %s\n"
-		    "%c Lines starting with '%c' will be stripped.\n",
-		    comment_line_char, comment_line_char,
-		    branch_name, comment_line_char, comment_line_char);
+	strbuf_commented_addf(&buf,
+			      "Please edit the description for the branch\n"
+			      "  %s\n"
+			      "Lines starting with '%c' will be stripped.\n",
+			      branch_name, comment_line_char);
+
 	fp = fopen(git_path(edit_description), "w");
 	if ((fwrite(buf.buf, 1, buf.len, fp) < buf.len) || fclose(fp)) {
 		strbuf_release(&buf);
diff --git a/builtin/stripspace.c b/builtin/stripspace.c
index 600ca66..790b500 100644
--- a/builtin/stripspace.c
+++ b/builtin/stripspace.c
@@ -66,21 +66,44 @@ void stripspace(struct strbuf *sb, int skip_comments)
 	strbuf_setlen(sb, j);
 }
 
+static void comment_lines(struct strbuf *buf)
+{
+	char *msg;
+	size_t len;
+
+	msg = strbuf_detach(buf, &len);
+	strbuf_add_commented_lines(buf, msg, len);
+}
+
 int cmd_stripspace(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int strip_comments = 0;
+	enum { INVAL = 0, STRIP_SPACE = 1, COMMENT_LINES = 2 } mode = STRIP_SPACE;
+
+	if (argc == 2) {
+		if (!strcmp(argv[1], "-s") ||
+		    !strcmp(argv[1], "--strip-comments")) {
+			strip_comments = 1;
+		} else if (!strcmp(argv[1], "-c")) {
+			mode = COMMENT_LINES;
+			git_config(git_default_config, NULL);
+		} else {
+			mode = INVAL;
+		}
+	} else if (argc > 1)
+		mode = INVAL;
 
-	if (argc == 2 && (!strcmp(argv[1], "-s") ||
-				!strcmp(argv[1], "--strip-comments")))
-		strip_comments = 1;
-	else if (argc > 1)
-		usage("git stripspace [-s | --strip-comments] < input");
+	if (mode == INVAL)
+		usage("git stripspace [-s|-c] <input");
 
 	if (strbuf_read(&buf, 0, 1024) < 0)
 		die_errno("could not read the input");
 
-	stripspace(&buf, strip_comments);
+	if (mode == STRIP_SPACE)
+		stripspace(&buf, strip_comments);
+	else /* i.e. COMMENT_LINES */
+		comment_lines(&buf);
 
 	write_or_die(1, buf.buf, buf.len);
 	strbuf_release(&buf);
diff --git a/strbuf.c b/strbuf.c
index 9a373be..d0525c8 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -411,12 +411,17 @@ int strbuf_read_file(struct strbuf *sb, const char *path, size_t hint)
 	return len;
 }
 
-void strbuf_add_lines(struct strbuf *out, const char *prefix,
+static void add_lines(struct strbuf *out,
+		      const char *prefix1,
+		      const char *prefix2,
 		      const char *buf, size_t size)
 {
 	while (size) {
+		const char *prefix;
 		const char *next = memchr(buf, '\n', size);
 		next = next ? (next + 1) : (buf + size);
+
+		prefix = (prefix2 && buf[0] == '\n') ? prefix2 : prefix1;
 		strbuf_addstr(out, prefix);
 		strbuf_add(out, buf, next - buf);
 		size -= next - buf;
@@ -425,6 +430,41 @@ void strbuf_add_lines(struct strbuf *out, const char *prefix,
 	strbuf_complete_line(out);
 }
 
+void strbuf_add_lines(struct strbuf *out, const char *prefix,
+		      const char *buf, size_t size)
+{
+	add_lines(out, prefix, NULL, buf, size);
+}
+
+void strbuf_add_commented_lines(struct strbuf *out,
+				const char *buf, size_t size)
+{
+	static char prefix1[3];
+	static char prefix2[2];
+
+	if (prefix1[0] != comment_line_char) {
+		sprintf(prefix1, "%c ", comment_line_char);
+		sprintf(prefix2, "%c", comment_line_char);
+	}
+	add_lines(out, prefix1, prefix2, buf, size);
+}
+
+void strbuf_commented_addf(struct strbuf *sb, const char *fmt, ...)
+{
+	va_list params;
+	struct strbuf buf = STRBUF_INIT;
+	int incomplete_line = sb->len && sb->buf[sb->len - 1] != '\n';
+
+	va_start(params, fmt);
+	strbuf_vaddf(&buf, fmt, params);
+	va_end(params);
+
+	strbuf_add_commented_lines(sb, buf.buf, buf.len);
+	if (incomplete_line)
+		sb->buf[--sb->len] = '\0';
+	strbuf_release(&buf);
+}
+
 void strbuf_addstr_xml_quoted(struct strbuf *buf, const char *s)
 {
 	while (*s) {
diff --git a/strbuf.h b/strbuf.h
index ecae4e2..1eb0c75 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -131,10 +131,14 @@ extern void strbuf_addbuf_percentquote(struct strbuf *dst, const struct strbuf *
 
 __attribute__((format (printf,2,3)))
 extern void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
+__attribute__((format (printf,2,3)))
+extern void strbuf_commented_addf(struct strbuf *sb, const char *fmt, ...);
 __attribute__((format (printf,2,0)))
 extern void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
 
 extern void strbuf_add_lines(struct strbuf *sb, const char *prefix, const char *buf, size_t size);
+extern void strbuf_add_commented_lines(struct strbuf *out, const char *buf, size_t size);
+
 
 /*
  * Append s to sb, with the characters '<', '>', '&' and '"' converted
