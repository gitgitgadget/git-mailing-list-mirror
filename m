Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3212C23E35E
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 17:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759771287; cv=none; b=AvSBy57Ux843CHgsL73Gl0zoD1laOmUJjh6jIEJp6MW2m0Hn2kX0ld5NL71T3Oq7dhkRxSKwwIsMPusvY+FyFPygkpS3GrydBPcrY33hn8n9ICY01GJJTp/Cq27nd6mo79WLk9FPpI/Zac+Ow5lATKU2Hsxe0DNWYVHdqQAIaSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759771287; c=relaxed/simple;
	bh=Wx2HAER57fTEx7y7MR3x+Qqlh70RLV2NOmznHJ+Av0Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HKwb+fq1p16UpKYM5aGLYIkgLjtjCsxeDD3Vio3GfffpiY2Ir8tXd5pOMoINrYXu9iDcjHQkCZrjZ/rfhdmzlqff8mWlB99euuU/IgOCgh+G6oXbw3h97im++bSYWhHu75Lh4V7flSnh17mBCBgS1jsqIhl+C6J6j8d+PMny/Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=wlX3WEKc; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="wlX3WEKc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759771279; x=1760376079; i=l.s.r@web.de;
	bh=O7f2YT4+ETX6mww8ocva1K96MyUwV6axJ17S0qITwZQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=wlX3WEKc8p3CFc9U0U3UBIqGXvWlOKceN63P9kVzYeFmRMl7mFCVggPJF7I1s26X
	 9tWp9lb2lZgMOLM2nFPvVIGUsmUhz/QHzNKR+D5G/8BNDq0UPW96YYH91VIlfXKz4
	 yanbslTlXN5fpDDKfuVpm7enXZ5fNAQ8kBW1WSXHKe0kDA7b1aCDtT0nnnDE1DhEl
	 zZlf1zwEut1EHIWKGszoamn86zGMsAWKek4umWF0qc3Uo15j4vtuqYdBMbpRi0Qfm
	 6blVTPRPitbr+PMp7qVj7aE7ruB0CVzwRy2M4qth0oUPJPeyiC2UxV6KGrkhc9pla
	 29MpV8Jb0//C09m+Yg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.16.132]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MZB4F-1ujQZa2SCf-00IeBk; Mon, 06
 Oct 2025 19:21:19 +0200
Message-ID: <02128b8e-74dc-4347-89d7-00dcef5dda8b@web.de>
Date: Mon, 6 Oct 2025 19:21:19 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 3/6] add-patch: let options y, n, j, and e roll over to
 next undecided
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Cc: "Windl, Ulrich" <u.windl@ukr.de>, Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <c72518099a3b465c8761e41210fe3fcb@ukr.de>
 <fe8e8097-2b05-4dd2-a754-f59e4ba5f95a@web.de>
Content-Language: en-US
In-Reply-To: <fe8e8097-2b05-4dd2-a754-f59e4ba5f95a@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qSz1uw7zFMuczbpaTgCgdDhG+ukWc8qVbXL/3l7NeTs0Ge8JZMO
 8zjuw90XVD9jbYZgE92jkI6nKYwACsdD+29srxhIp8I+Iy7tw/D+Kn+iZFA7YHbhyObdSYV
 cS7offP0WKJocqNObJ22XCby6vJCT0eOFS+ieiOZYZQtisAWE1Jfs2s5pH9515OF81agykD
 vybh8gYj3MdnKAvk7hGqQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gddT21tiPdc=;zHCOaZfnaKTupXqiwhVJNPytCnb
 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

The options y, n, and e mark the current hunk as decided.  If there's
another undecided hunk towards the bottom of the hunk array they go
there.  If there isn't, but there is another undecided hunk towards the
top then they go to the very first hunk, no matter if it has already
been decided on.

The option j does basically the same move.  Technically it is not
allowed if there's no undecided hunk towards the bottom, but the
variable "permitted" is never reset, so this permission is retained
from the very first hunk.  That may a bug, but this behavior is at
least consistent with y, n, and e and arguably more useful than
refusing to move.

Improve the roll-over behavior of these four options by moving to the
first undecided hunk instead of hunk 1, consistent with what they do
when not rolling over.

Also adjust the error message for j, as it will only be shown if
there's no other undecided hunk in either direction.

Reported-by: Windl, Ulrich <u.windl@ukr.de>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Documentation/git-add.adoc |  2 +-
 add-patch.c                | 13 ++++++++++---
 t/t3701-add-interactive.sh | 22 ++++++++++++++++++++++
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
index 5c05a3a7f9..596cdeff93 100644
=2D-- a/Documentation/git-add.adoc
+++ b/Documentation/git-add.adoc
@@ -342,7 +342,7 @@ patch::
        d - do not stage this hunk or any of the later hunks in the file
        g - select a hunk to go to
        / - search for a hunk matching the given regex
-       j - go to the next undecided hunk
+       j - go to the next undecided hunk, roll over at the bottom
        J - go to the next hunk, roll over at the bottom
        k - go to the previous undecided hunk
        K - go to the previous hunk
diff --git a/add-patch.c b/add-patch.c
index 1f466ec9c0..106bfcb275 100644
=2D-- a/add-patch.c
+++ b/add-patch.c
@@ -1397,7 +1397,7 @@ static size_t display_hunks(struct add_p_state *s,
 }
=20
 static const char help_patch_remainder[] =3D
-N_("j - go to the next undecided hunk\n"
+N_("j - go to the next undecided hunk, roll over at the bottom\n"
    "J - go to the next hunk, roll over at the bottom\n"
    "k - go to the previous undecided hunk\n"
    "K - go to the previous hunk\n"
@@ -1408,6 +1408,11 @@ N_("j - go to the next undecided hunk\n"
    "p - print the current hunk, 'P' to use the pager\n"
    "? - print help\n");
=20
+static size_t inc_mod(size_t a, size_t m)
+{
+	return a < m - 1 ? a + 1 : 0;
+}
+
 static int patch_update_file(struct add_p_state *s,
 			     struct file_diff *file_diff)
 {
@@ -1451,7 +1456,9 @@ static int patch_update_file(struct add_p_state *s,
 					break;
 				}
=20
-			for (i =3D hunk_index + 1; i < file_diff->hunk_nr; i++)
+			for (i =3D inc_mod(hunk_index, file_diff->hunk_nr);
+			     i !=3D hunk_index;
+			     i =3D inc_mod(i, file_diff->hunk_nr))
 				if (file_diff->hunk[i].use =3D=3D UNDECIDED_HUNK) {
 					undecided_next =3D i;
 					break;
@@ -1594,7 +1601,7 @@ static int patch_update_file(struct add_p_state *s,
 			if (permitted & ALLOW_GOTO_NEXT_UNDECIDED_HUNK)
 				hunk_index =3D undecided_next;
 			else
-				err(s, _("No next hunk"));
+				err(s, _("No other undecided hunk"));
 		} else if (s->answer.buf[0] =3D=3D 'g') {
 			char *pend;
 			unsigned long response;
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index d5d2e120ab..8086d3da71 100755
=2D-- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -1364,4 +1364,26 @@ test_expect_success 'option J rolls over' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'options y, n, j, e roll over to next undecided (1)' =
'
+	test_write_lines a b c d e f g h i j k l m n o p q >file &&
+	git add file &&
+	test_write_lines X b c d e f g h X j k l m n o p X >file &&
+	test_set_editor : &&
+	test_write_lines g3 y g3 n g3 j g3 e q | git add -p >out &&
+	test_write_lines 1  3 1  3 1  3 1  3 1 >expect &&
+	sed -n -e "s-/.*--" -e "s/^(//p" <out >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'options y, n, j, e roll over to next undecided (2)' =
'
+	test_write_lines a b c d e f g h i j k l m n o p q >file &&
+	git add file &&
+	test_write_lines X b c d e f g h X j k l m n o p X >file &&
+	test_set_editor : &&
+	test_write_lines y g3 y g3 n g3 j g3 e q | git add -p >out &&
+	test_write_lines 1 2  3 2  3 2  3 2  3 2 >expect &&
+	sed -n -e "s-/.*--" -e "s/^(//p" <out >actual &&
+	test_cmp expect actual
+'
+
 test_done
=2D-=20
2.51.0
