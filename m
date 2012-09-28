From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/3] revision: add --grep-reflog to filter commits by reflog messages
Date: Fri, 28 Sep 2012 14:01:21 +0700
Message-ID: <1348815682-18696-2-git-send-email-pclouds@gmail.com>
References: <1348745786-27197-1-git-send-email-pclouds@gmail.com>
 <1348815682-18696-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 28 09:02:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THUac-00067M-G8
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 09:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753342Ab2I1HCN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Sep 2012 03:02:13 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64678 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877Ab2I1HCL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 03:02:11 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so4721305pbb.19
        for <git@vger.kernel.org>; Fri, 28 Sep 2012 00:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=9iH1/1aKANGa3pq5OfV1ewHJRWnYxJhTT54D4x0bhB0=;
        b=ZeDWCfsH8n7y0Fv0SwB75buqAITysL5licnnSV6CN6ki2xS5dXV9MNVeqGwuskqMey
         X1BLhJN/xjhbKvMwFWw7PkgXwmLCL6hywe+CSz4GLPE+q4oNmiXC2CAommZltRDot2KY
         QE1m4WkrPHXg91t1w4e1P8llBi87pIDc2jf31LfFXllL4xH3NIaS2Drz5LPBZF2wfh7h
         V983q+v6RxJjW9JDbniIMQfXH4D3KLhJGSBfC3oV3XUVVj1WajoG62YkersJnP1dNrHm
         svQjgfjfAqH7GoGAl1vJfCveHyMg86VvcT7vxIfTAnR46X7oiycDStI8DhDtzCFdNjb1
         YiXw==
Received: by 10.66.78.195 with SMTP id d3mr15293521pax.17.1348815731550;
        Fri, 28 Sep 2012 00:02:11 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id nz6sm5133651pbb.50.2012.09.28.00.02.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 28 Sep 2012 00:02:10 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 28 Sep 2012 14:02:03 +0700
X-Mailer: git-send-email 1.7.12.1.405.gb727dc9
In-Reply-To: <1348815682-18696-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206540>

Similar to --author/--committer which filters commits by author and
committer header fields. --grep-reflog adds a fake "reflog" header to
commit and a grep filter to search on that line.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On Fri, Sep 28, 2012 at 12:09 AM, Junio C Hamano <gitster@pobox.com>
 wrote:
 > I am debating myself if it is sane for this option to have no hint
 > that it is about "limiting" in its name.  "--author/--committer"
 > don't and it is clear from the context of the command that they are
 > not about setting author/committer, so "--reflog-message" may be
 > interpreted the same, perhaps.
 >
 > The entry in the context above talks about multiple occurrence of
 > that option. Shouldn't this new one also say what happens when it
 > is
 > given twice?

 Fixed.

 > I think I wrote prep_header_patterns() and compile_grep_patterns()
 > carefully enough not to assume the headers are only the author and
 > committer names, so the various combinations i.e. all-match,
 > author(s), committer(s), grep(s), and reflog-message(s), should
 > work
 > out of the box, but have you actually tested them?

 I did not. I do now, tests are also added.

 On Fri, Sep 28, 2012 at 12:28 AM, Jeff King <peff@peff.net> wrote:
 > I also found the name confusing on first-read. While "--author" is
 > an
 > example in one direction, the fact that "--grep" is not called
 > "--body"
 > is a counter-example.
 >
 > I'd much rather see it as "--grep-reflog" or something. You could
 > also
 > do "--grep-reflog-message", which would match a later
 > "--grep-reflog-author", but I am not sure anybody would want the
 > latter,
 > and it makes the current name a lot longer.

 Changed it to --grep-reflog. I was tempted to add --grep-* but I
 can't error out if user gives an invalid header. So --grep-reflog
 only for now.

 Documentation/rev-list-options.txt |  8 ++++++++
 revision.c                         | 20 ++++++++++++++++++--
 t/t7810-grep.sh                    | 26 ++++++++++++++++++++++++++
 3 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-lis=
t-options.txt
index 1fc2a18..aa7cd9d 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -51,6 +51,14 @@ endif::git-rev-list[]
 	commits whose author matches any of the given patterns are
 	chosen (similarly for multiple `--committer=3D<pattern>`).
=20
+--grep-reflog=3D<pattern>::
+
+	Limit the commits output to ones with reflog entries that
+	match the specified pattern (regular expression). With
+	more than one `--grep-reflog`, commits whose reflog message
+	matches any of the given patterns are chosen. Ignored unless
+	`--walk-reflogs` is given.
+
 --grep=3D<pattern>::
=20
 	Limit the commits output to ones with log message that
diff --git a/revision.c b/revision.c
index f7cf385..cfa0e2e 100644
--- a/revision.c
+++ b/revision.c
@@ -1595,6 +1595,9 @@ static int handle_revision_opt(struct rev_info *r=
evs, int argc, const char **arg
 	} else if ((argcount =3D parse_long_opt("committer", argv, &optarg)))=
 {
 		add_header_grep(revs, "committer", optarg);
 		return argcount;
+	} else if ((argcount =3D parse_long_opt("grep-reflog", argv, &optarg)=
)) {
+		add_header_grep(revs, "reflog", optarg);
+		return argcount;
 	} else if ((argcount =3D parse_long_opt("grep", argv, &optarg))) {
 		add_message_grep(revs, optarg);
 		return argcount;
@@ -2210,10 +2213,23 @@ static int rewrite_parents(struct rev_info *rev=
s, struct commit *commit)
=20
 static int commit_match(struct commit *commit, struct rev_info *opt)
 {
+	int retval;
+	struct strbuf buf =3D STRBUF_INIT;
 	if (!opt->grep_filter.pattern_list && !opt->grep_filter.header_list)
 		return 1;
-	return grep_buffer(&opt->grep_filter,
-			   commit->buffer, strlen(commit->buffer));
+	if (opt->reflog_info) {
+		strbuf_addstr(&buf, "reflog ");
+		get_reflog_message(&buf, opt->reflog_info);
+		strbuf_addch(&buf, '\n');
+		strbuf_addstr(&buf, commit->buffer);
+	}
+	if (buf.len)
+		retval =3D grep_buffer(&opt->grep_filter, buf.buf, buf.len);
+	else
+		retval =3D grep_buffer(&opt->grep_filter,
+				     commit->buffer, strlen(commit->buffer));
+	strbuf_release(&buf);
+	return retval;
 }
=20
 static inline int want_ancestry(struct rev_info *revs)
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 91db352..f42a605 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -546,6 +546,32 @@ test_expect_success 'log grep (6)' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'log grep (7)' '
+	git log -g --grep-reflog=3D"commit: third" --pretty=3Dtformat:%s >act=
ual &&
+	echo third >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log grep (8)' '
+	git log -g --grep-reflog=3D"commit: third" --grep-reflog=3D"commit: s=
econd" --pretty=3Dtformat:%s >actual &&
+	{
+		echo third && echo second
+	} >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log grep (9)' '
+	git log -g --grep-reflog=3D"commit: third" --author=3D"Thor" --pretty=
=3Dtformat:%s >actual &&
+	echo third >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log grep (9)' '
+	git log -g --grep-reflog=3D"commit: third" --author=3D"non-existant" =
--pretty=3Dtformat:%s >actual &&
+	: >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'log with multiple --grep uses union' '
 	git log --grep=3Di --grep=3Dr --format=3D%s >actual &&
 	{
--=20
1.7.12.1.405.gb727dc9
