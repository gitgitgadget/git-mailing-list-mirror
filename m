From: tboegi@web.de
Subject: [PATCH v2 6/7] correct blame for files commited with CRLF
Date: Fri,  1 Apr 2016 18:08:31 +0200
Message-ID: <1459526911-19985-1-git-send-email-tboegi@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 01 18:05:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1am1Zz-0006WA-4N
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 18:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758859AbcDAQFh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Apr 2016 12:05:37 -0400
Received: from mout.web.de ([212.227.17.11]:59361 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754802AbcDAQFf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 12:05:35 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0M2uao-1ZtVVu2JR0-00sfrD; Fri, 01 Apr 2016 18:05:28
 +0200
X-Mailer: git-send-email 2.8.0.rc2.2.g1a4d45a.dirty
In-Reply-To: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:WLlsUo9SQ+rAWPJV8DJzDgcBZ0BRhjFmUNBUweyrwU1DzW0sXZF
 a6YMMQKiy/NlPzziitbF1XU416GE1n3QLEHhyZUwP8mhEVnzRONo7EiceYMeklf61t1J/wU
 WJQUL7YfyA78X/VHCAQwST4gl6t0KOe4x07PpZggUDR3EseVfp8b0m+EV1+/pBUOb0WwUNZ
 8+p144y5JKdVaKLQcSo3g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kCIc1i7YShg=:NiA92XX+/0bwxDn5T81VwB
 FwCgO6tM2YKBdjToLiwYZgY5ryRPUt9WcScEYLu43SBg9X0wv1RoNXZI2ruTOEgLKysrLNlBz
 llfQxJB10Q3eBGoK27JTc6UEocDlkvCqVNGZb9gdT/IzJzXzeIVkTAY/GyIKyKL/5847Anra8
 Xay2bs0/kCwbncqYZisy+lyXxjDFeteJBUniP88Td/Znxu3wiNFi25Va96xYnIZ5srU20vcO0
 YbbvWptAL4+s40BSMyEgWDBYy8rEsmLKTEqZ8GMf3uGTKKJlGRxHx1d8d0VNF+yz2HG4qCGes
 PRZUXqIbm/PI0yHJVoY0seZOYQrt+jifjWtma+cGY3gzWhG9W5juSnAqKl/AbpjTNQ57RZD6N
 3cLANcJrOJeyq7d6iOwrmzUtSqxkZPfjnIJyUJP/iLdom4Z/wQSYGNcbEI12I7z4eHTYnX7Ln
 Nc8F7ltNJLAIrJ/CwSj/g0gwDG/G4O8ONHLxq6hfhsAZtXkLIt+dPpyPo3zbNS5VbKB8JR0aF
 JQlLTKqUNjBZFSbhm5+fUFZGNbIneTTYRjMnsYAFmL4rV+uPEQUhRfetLcRXpDhfdznF/siyR
 yeMRDfWdNAIboElcsvLGqaI+jKVVCEAri7D5VbtFf/A5P811+kzt9E0pbHOQzPe3yS16KgfPJ
 5meNO+MoHX/zSxUwoLja9AYEjLy+35ycsJTG2oZfUd8FEY4pSF7ieP21koi+aUmqCSKldExBd
 Tg+BsPIH/47yrTUnIdjEv8zy5f5tfwE/kwZ9FoJk/429nKZtSKHJoKJYKf3QfjnStL6BT8sK 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290553>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

git blame reports lines as not "Not Committed Yet" when they have
CRLF in the index, CRLF in the worktree and e.g. core.autocrlf is true.

Since commit c48053 "new safer autocrlf handling", files that have CRLF
in the index are not normalized at commit when e.g. core.autocrl is set=
=2E

Whenever a CLRF conversion is needed (or any filter us set), load the
index temporally, before calling convert_to_git()

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 builtin/blame.c               |  6 +++++-
 convert.c                     | 10 ++++++++++
 convert.h                     |  1 +
 t/t8003-blame-corner-cases.sh | 14 ++++++++++++++
 4 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index e982fb8..a219068 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2376,7 +2376,11 @@ static struct commit *fake_working_tree_commit(s=
truct diff_options *opt,
 		if (strbuf_read(&buf, 0, 0) < 0)
 			die_errno("failed to read from stdin");
 	}
-	convert_to_git(path, buf.buf, buf.len, &buf, 0);
+	if (convert_needs_conversion(path)) {
+		read_cache();
+		convert_to_git(path, buf.buf, buf.len, &buf, 0);
+		discard_cache();
+	}
 	origin->file.ptr =3D buf.buf;
 	origin->file.size =3D buf.len;
 	pretend_sha1_file(buf.buf, buf.len, OBJ_BLOB, origin->blob_sha1);
diff --git a/convert.c b/convert.c
index 4ed5d89..02c50da 100644
--- a/convert.c
+++ b/convert.c
@@ -903,6 +903,16 @@ const char *get_convert_attr_ascii(const char *pat=
h)
 	return "";
 }
=20
+int convert_needs_conversion(const char *path)
+{
+	struct conv_attrs ca;
+
+	convert_attrs(&ca, path);
+	if (ca.drv || ca.ident || ca.crlf_action !=3D CRLF_BINARY)
+		return 1;
+	return 0;
+}
+
 int convert_to_git(const char *path, const char *src, size_t len,
                    struct strbuf *dst, enum safe_crlf checksafe)
 {
diff --git a/convert.h b/convert.h
index ccf436b..ffd9c32 100644
--- a/convert.h
+++ b/convert.h
@@ -35,6 +35,7 @@ extern enum eol core_eol;
 extern const char *get_cached_convert_stats_ascii(const char *path);
 extern const char *get_wt_convert_stats_ascii(const char *path);
 extern const char *get_convert_attr_ascii(const char *path);
+int convert_needs_conversion(const char *path);
=20
 /* returns 1 if *dst was used */
 extern int convert_to_git(const char *path, const char *src, size_t le=
n,
diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases=
=2Esh
index 6568429..a9b266f 100755
--- a/t/t8003-blame-corner-cases.sh
+++ b/t/t8003-blame-corner-cases.sh
@@ -212,4 +212,18 @@ test_expect_success 'blame file with CRLF attribut=
es text' '
 	grep "A U Thor" actual
 '
=20
+test_expect_success 'blame file with CRLF core.autocrlf=3Dtrue' '
+	git config core.autocrlf false &&
+	printf "testcase\r\n" >crlfinrepo &&
+	>.gitattributes &&
+	git add crlfinrepo &&
+	git commit -m "add crlfinrepo" &&
+	git config core.autocrlf true &&
+	mv crlfinrepo tmp &&
+	git checkout crlfinrepo &&
+	rm tmp &&
+	git blame crlfinrepo >actual &&
+	grep "A U Thor" actual
+'
+
 test_done
--=20
2.8.0.rc2.2.g1a4d45a.dirty
