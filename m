Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96564C900C
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 17:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791827806; cv=none; b=HJiCKUwNhSA5+iHxVGvHDoarlONTrS5lk7ZYnMACkZcjgbL9wISDSzsGb7Po8B2UElgPTurcxhElag4/G/MT2NDjmQHGiDtFy6hULxNVRpKwf3jS0Fck95igKGbWQNnjSmhawwC0Oo5Jy0fjddyQ8prgFfvKZS/lDIF5RJVRFH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791827806; c=relaxed/simple;
	bh=0yl3AGRnUJdh6ju/hm0h3G14OlZWAWbnvIaJeuG1NGY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gfVybOPSQCwj/i+DkpthlrZC0+xMcPwzc5kIhMcw71AnusvQUzo2UVesDvBcUUFEduIAgaQs8FoGrkeWt8kMlnY5rl0aMTVMekrqsUSh7eandknWxYZ0nuNx/o0FEzb2aBylw+2nh7wsRtIRXj+vD+Ruz7oNIV2Ep3OpuGkujf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=N/PAvI7M; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="N/PAvI7M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1791827801; x=1792432601; i=tboegi@web.de;
	bh=bbEgjxxOKv+ja/eN5TgBSlNkabsZwnEwPyMbCqsaXdc=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=N/PAvI7MSvjptNl+ij49v7mtyq2++TW4n8CtCG6O+TBAmwUen71qJah8Yo4q8+sL
	 WWiM3Prlsg9z9+V/CzlUNTTNoCiRyP2v6++JSQLmmLIA8/v5LjYJGS1ID/JttMk4X
	 vlo6nFlwv7MmddhBVDwQDBdWz0Eod+t4HT/yQ+Om6j1odL0cP2bAYR8TSLGloXYLj
	 g1sacI+8VDz3IxuW2ZpTMX+APvp07csBtJtFLYO0n+0ornHDwht/jPGRJRhyDfGKH
	 3oa4fxyBdqffa1NGSeFPxcMI42Q3fniNKmpLEgSLl/tQ4kEPNsMNcU+JkDhJYNck/
	 YOC72AqTaSM4CHtMLw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MYLmq-1xCYlH1kmY-00Uvao; Mon, 12
 Oct 2026 19:56:41 +0200
From: tboegi@web.de
To: tboegi@web.de,
	git@vger.kernel.org,
	curtis.allen.smith@gmail.com
Subject: [PATCH v3/RFC 1/1] read-cache: do not trust a size change when conversion is active
Date: Mon, 12 Oct 2026 19:56:38 +0200
Message-Id: <20261012175638.3712-1-tboegi@web.de>
X-Mailer: git-send-email 2.34.0.rc0.25.ga000dc5aaa
In-Reply-To: <xmqqwm1no29m.fsf@gitster.g>
References: <xmqqwm1no29m.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UX7t8s35cssAdlqtmM8tIBwZEarObF0aEsSjwNpowdoLGblvkFh
 rdCK7nRqUIGL4EX09D+RPRt4d2rW97OitXi5YRa0Wm9Gh3DUulq6rJlN8k6f1eM1rfpvNJ1
 NbxVLtt90hN2CwZe/XfLSIqfhvvMMSZmvOGVrohxqOxJnrTZ8jZw/lM43Qb8PvLBuCdW+DM
 zn9ts1sQu2FlkFXPcVgJw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ha15kydlr2E=;wY4/vr1gXpKMYogIJeZGeTwXHVS
 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
 =

From: Torsten B=C3=B6gershausen <tboegi@web.de>

"git status" can report a file as modified while "git diff" and
"git add", which both run the clean filter, agree its contents are
unchanged:

	git init t && cd t
	printf '* text eol=3Dlf\n' >.gitattributes
	printf 'one\ntwo\nthree\n' >file.txt
	git add . && git commit -m init

	printf 'one\r\ntwo\r\nthree\r\n' >file.txt

	git status --short      # ->  M file.txt
	git diff                # -> empty
	git add file.txt        # -> updates the index

Note that "clean filter" here means the "clean filter" and CRLF conversion=
,
and all converting of a file in the worktree into the index.

Problems that have been found in real live:
  Tools that rewrites unchanged files in native line endings e.g.
    javadoc, code generators, formatters and some editors change
    the size of every file it touches.
  Editors that insist to replace 4 space with a TAB,
    even if the file is changed manually forth and back -
    Using a clean filter that changes the TAB back into space when
    committing will cause the same confusion.

`git status` and `git diff` disagree because ie_modified()
in read-cache.c concludes that a file is modified
as soon as the size has changed.
This had been true when Git was young, before the clean filter
and CRLF conversion had been introduced.

Introduce size_change_is_conclusive() in read-cache.c, which calls
would_convert_to_git().
The content of the file in the worktree is now run through all filters
and CRLF conversion whenever the size is different.
After that, the new size (and mtime) is stored in the index
together with the modified status.

Technical correctness vs performance considerations:
Instead of running the chain of
`git status` `git diff` (hm, nothing changed ?) `git add`
we now handle everything in `git status`, which may give a slower
execution time for this command.
Different measurements came up with 20ms per file which are now
spend in `git status` instead of `git add`.

Signed-off-by: Curtis Allen Smith <curtis.allen.smith@gmail.com>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
=2D--
 read-cache.c    | 25 ++++++++++++++++++++++++-
 t/t0020-crlf.sh | 45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index c4cf08a3a3..9aebe4c394 100644
=2D-- a/read-cache.c
+++ b/read-cache.c
@@ -9,6 +9,7 @@
=20
 #include "git-compat-util.h"
 #include "config.h"
+#include "convert.h"
 #include "date.h"
 #include "diff.h"
 #include "diffcore.h"
@@ -438,6 +439,27 @@ int ie_match_stat(struct index_state *istate,
 	return changed;
 }
=20
+/*
+ * A difference between the size of the file in the working tree and the
+ * size recorded for it in the index proves that the contents changed
+ * only as long as the two are byte-for-byte comparable.  That stops
+ * being true as soon as the path is run through a clean filter:
+ * rewriting a file with CRLF endings under "text eol=3Dlf", for example,
+ * changes its size in the working tree without changing the blob Git
+ * would record for it.  For such a path the only way to tell is to read
+ * the contents and convert them, which is what we already do when only
+ * the mtime changed.
+ */
+static int size_change_is_conclusive(struct index_state *istate,
+				     const struct cache_entry *ce,
+				     struct stat *st)
+{
+	if (!S_ISREG(st->st_mode))
+		return 1;
+
+	return !would_convert_to_git(istate, ce->name);
+}
+
 int ie_modified(struct index_state *istate,
 		const struct cache_entry *ce,
 		struct stat *st, unsigned int options)
@@ -480,7 +502,8 @@ int ie_modified(struct index_state *istate,
 	     */
 	    (!S_ISLNK(st->st_mode) || ce->ce_stat_data.sd_size !=3D MAX_PATH) &&
 #endif
-	    (S_ISGITLINK(ce->ce_mode) || ce->ce_stat_data.sd_size !=3D 0))
+	    (S_ISGITLINK(ce->ce_mode) || ce->ce_stat_data.sd_size !=3D 0) &&
+	    size_change_is_conclusive(istate, ce, st))
 		return changed;
=20
 	changed_fs =3D ce_modified_check_fs(istate, ce, st);
diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index fd1cae09ed..88b728d509 100755
=2D-- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -397,4 +397,49 @@ test_expect_success 'New CRLF file gets LF in repo' '
 	test_cmp alllf alllf2
 '
=20
+test_expect_success 'status does not report a CRLF-only rewrite as modifi=
ed' '
+	git init eol-status &&
+	(
+		cd eol-status &&
+		echo "* text eol=3Dlf" >.gitattributes &&
+		printf "one\ntwo\nthree\n" >file.txt &&
+		git add .gitattributes file.txt &&
+		git commit -m initial &&
+
+		# a generator rewrites the file with CRLF, same content
+		printf "one\r\ntwo\r\nthree\r\n" >file.txt &&
+		git status --porcelain -uno >actual &&
+		test_must_be_empty actual &&
+		git diff --exit-code &&
+
+		# a real change is still reported
+		printf "one\r\ntwo\r\nfour\r\n" >file.txt &&
+		git status --porcelain -uno >actual &&
+		echo " M file.txt" >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'status sizes a text file by its CRLF pairs, not its =
CRs' '
+	git init eol-status-lone-cr &&
+	(
+		cd eol-status-lone-cr &&
+		echo "* text eol=3Dlf" >.gitattributes &&
+		printf "one\rtwo\nthree\n" >file.txt &&
+		git add .gitattributes file.txt &&
+		git commit -m initial &&
+
+		# "git add" keeps the lone CR and drops the others
+		printf "one\rtwo\r\nthree\r\n" >file.txt &&
+		git status --porcelain -uno >actual &&
+		test_must_be_empty actual &&
+
+		# the converted size matches the blob, the content does not
+		printf "one\rtwo\nthrEE\r\n" >file.txt &&
+		git status --porcelain -uno >actual &&
+		echo " M file.txt" >expect &&
+		test_cmp expect actual
+	)
+'
+
 test_done
=2D-=20
2.50.0.rc0.46.g7014b55638

