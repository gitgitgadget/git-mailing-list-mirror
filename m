Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883C9A93D
	for <git@vger.kernel.org>; Sun,  8 Sep 2024 07:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725779157; cv=none; b=raMkHripyvxC6d6WLxG6xTH9qZrk1O6L13NL+8bzdHyJl2GHB3uVP8xXB+lWh4SOmVjPjWKW/NySanNZpuRhatmesyU6vQ5vNdYg5T3DOph2e8cnNLiWzW7lVH0aL1qLx6/8RKnr8iK04cnLPH1yhPlgXJzQwHRpICWhUgpC/wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725779157; c=relaxed/simple;
	bh=+qFJd2WWD2WsRy/i6lSt90bIFCQForn10wQ+AIoLMik=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=Tk2/dBAhZlVKS8zp7Ne+/0235ZC4QlCw+5iz10o5tNpdM8NiAQOcPycX8bcvXXwCg2FMPlATEVSEKB9AHL0PAiUZzVlPFzt4+9hg2XrVL5Sszs0tHN3rtNXlSDLGx60YGhI8hQGFv/2DtLgD0rFkuOwJDU4bJF50oR7r915gNto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=cC/5kR5G; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="cC/5kR5G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1725779144; x=1726383944; i=l.s.r@web.de;
	bh=3WeJ9pGy+ZAYWeac1SK0VkmDN4Q1KOKaRg1yLNK1Gxk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Cc:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=cC/5kR5G0l5jOtuJludrEKAceh3fR4xErOdnfazukkj6CNVKcUZ3woh+wHDTmzPZ
	 Pq39VqByFUNMBCcf+MdgOcvlz2FsWnB9JMg5ZxeqVVvTwdptIgbAvndy0pnhQ/w+R
	 3E6m48T5z2A1gWkmuqv8BuusDCKmSEW98CxieytHg96yJtk04tCyZHCKRrfLADTK2
	 3BF6DaAfqZ7fghea1PxBCqnLQ8ODkmJ25gYVrHbDSkxGTKBlQyOY9JPZfzk+ztYLW
	 E9rYvcFIm2FSa+6IInwv8OzB200jX/0IflIvfNhpmxpnAF3Hji8COdpxsb7ZS2AC9
	 AFLpInhosLhWQzMHyw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.152.211]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mft7t-1s7GbJ26u1-00igbg; Sun, 08
 Sep 2024 09:05:44 +0200
Message-ID: <130d4803-2818-4611-9258-951a18dd5717@web.de>
Date: Sun, 8 Sep 2024 09:05:44 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 1/2] diff: report copies and renames as changes in
 run_diff_cmd()
Cc: Jorge Luis Martinez Gomez <jol@jol.dev>,
 David Hull <david.hull@friendbuy.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LR8jyB23f+BYvsB349G/I/sx/Hqtz3jZVpjHegWg37VKjiU478G
 7k8NjtPfpwTIAeOrL38UDUIy3K58/bQi1l28KT3N0w7DxaikGPOoxFU4Va0T2YFMyfXMwWv
 w3kftLF64ZqFCtJ4OHFLGSp0K/KV3idf5AliGr+IdwGp7C90dYGeToLru951pjTrS5YR/7q
 MflZMPxIzP77lvoyU6TfA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4c/ihfTWUjE=;pvilP9U73SXS7Xxc4HKpB/lnF75
 /q0zteY4Ht4ApIEU4eD/tcD8mvZvwDiMEdBmaqVnmtjEpoPO6zX0h6f3u3DutFnwD7/dR1PVP
 o9Di/QHsk+EvW1C5ys1NsvBJg/eS5HoPMp5A59PHxxpveTnJ8mCMH6ViFILPsH5cUQulbZE3o
 4PKEHSrBM9w9CYLwGlYoJj+bIS6PuGg49GVoyosmVBcZN2XdXhs3n6ZQEUsgBoVbHHWhi4QT+
 RefOGr/yKWYFQn7VDcNRJ+sT0hbbHDf0GuKhF2oBJwm3UO1kdAMsrA5c1zXxY4QZRTDa+8ehZ
 A9eDTO30V9daFgOwhZp1hjNdvfEdmqkHTlwBs4LdlHuh9w4UXAxNxUR1jr0/gEG21koAew4lE
 I4q5i9ejIjHHDyViDoDVX2xgl83wOP2hMpGrtmu0NSImaJmfBpUnkr2gFFfEnM5HVozeGQ8Fe
 OkS2iwM6DqAdPuM6DHj33WjnQglD6nBzPz0mY4j8nv/EFnPC57EzWRDgrlcpgJgW6CJ1LsU7M
 wfn2Q6T198lq43gVlyKL1/eU0wXIEs6cUn1nQSHE0B93VlLhxyU0AWIDwO/QQfIrDMxzd3gLH
 67mvmx82vEl6MWCwfj+0QdDPX/6FDbjoTs1ZvLUrZ67+Ol1JeQXfV3cZNNEA/K3C0B5hwzjad
 EkecYzzuXT7V0NIKMlG4+7co8RvPpIucmZa85rSmtRzZ0xbH7dl3JeLzhIhEy93qC5Q5pO9lW
 +syrLPOPP1zkKtRA7EBtzwNnqzPCPSq5KtSUobRwhD4rpVXWb51HwyGF0TTtEZdXcJQvmr+UR
 m7h3v4dSofwsUxH4PFZkTHJA==

The diff machinery has two ways to detect changes to set the exit code:
Just comparing hashes and comparing blob contents.  The latter is needed
if certain changes have to be ignored, e.g. with --ignore-space-change
or --ignore-matching-lines.  It's enabled by the diff_options flag
diff_from_contents.

The slower mode has never considered copies and renames to be changes,
which is inconsistent with the quicker one.  Fix it.  Even if we ignore
the file contents (because it's empty or contains only ignored lines),
there's still the meta data change of adding or changing a filename, so
we need to report it in the exit code.

d7b97b7185 (diff: let external diffs report that changes are
uninteresting, 2024-06-09) set diff_from_contents if external diff
programs are allowed.  This is the default e.g. for git diff, and so
that change exposed the inconsistency much more widely.

Reported-by: Jorge Luis Martinez Gomez <jol@jol.dev>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 diff.c                 |  3 +++
 t/t4017-diff-retval.sh | 16 ++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/diff.c b/diff.c
index 4035a9374d..1d2057d4cb 100644
=2D-- a/diff.c
+++ b/diff.c
@@ -4587,6 +4587,9 @@ static void run_diff_cmd(const struct external_diff =
*pgm,
 		builtin_diff(name, other ? other : name,
 			     one, two, xfrm_msg, must_show_header,
 			     o, complete_rewrite);
+		if (p->status =3D=3D DIFF_STATUS_COPIED ||
+		    p->status =3D=3D DIFF_STATUS_RENAMED)
+			o->found_changes =3D 1;
 	} else {
 		fprintf(o->file, "* Unmerged path %s\n", name);
 		o->found_changes =3D 1;
diff --git a/t/t4017-diff-retval.sh b/t/t4017-diff-retval.sh
index f439f469bd..9a4f578614 100755
=2D-- a/t/t4017-diff-retval.sh
+++ b/t/t4017-diff-retval.sh
@@ -143,4 +143,20 @@ test_expect_success 'option errors are not confused b=
y --exit-code' '
 	grep '^usage:' err
 '

+for option in --exit-code --quiet
+do
+	test_expect_success "git diff $option returns 1 for copied file" "
+		git reset --hard &&
+		cp a copy &&
+		git add copy &&
+		test_expect_code 1 git diff $option --cached --find-copies-harder
+	"
+
+	test_expect_success "git diff $option returns 1 for renamed file" "
+		git reset --hard &&
+		git mv a renamed &&
+		test_expect_code 1 git diff $option --cached
+	"
+done
+
 test_done
=2D-
2.46.0
