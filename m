Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60062FFF94
	for <git@vger.kernel.org>; Sun,  9 Nov 2025 16:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762706634; cv=none; b=SSh4iUQtivs8D5NhWL8ahClOD8VB+cfYc0X+eceJoLnpk+4H/7lhgL+2DZO3l2Kg+lMbFSjkIQq+ggSG2O8Fw69xavIUF3quxFXEUlzhMCV/7MOUyU8p+43jMPbS3pvO24DQSQb930lASmeZY9l5BwbX2uWQ+C14Ys3qw9NQZ1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762706634; c=relaxed/simple;
	bh=e5hRc6itC6hxqIjihKZp+t2+dwNZrYFBy1i1UFEpgTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=uZK5bDeqRvs5iJfTqe3R4vcHmpexDkkhJQNHgP3Qh72ZOVMFqAKOan6p5s499wN3Q57uUSQFMqb/afh16eFuZ9kLWWF2NspGjvcBj5Me45+4kXusOl8SoebcQAbxNruuxZDp8b3JaIcPdUTU0dgtJLM+zX8cAxh2PGtQe9U6b/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=k9rBaMAy; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="k9rBaMAy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762706616; x=1763311416; i=l.s.r@web.de;
	bh=ilepFu6g3RTqkBEZ78eiWY2FGyfsMpScNgRk8Q+tsRg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=k9rBaMAybNhopJWap9KAVHARFfGuZJukWGmuknDx1cU/2gr6QzQjYU2EkPvyJ5Al
	 0530t+TMfM2iMUxfKBBfkw6M+m4ddBDJ3G1STBM1O4wwUuuiVhWxAODbOoHeCVrzv
	 ZmUoFl4nLfDAfousLVjI48M0/GmVXs1epuVug31HU2Bg7LKTvan5hdroQV+KgZmSr
	 YszmoGx8muYZMFaeXBUWwnYjpDTWwsFCcNvZZ65rAcOoPtgN0OLeRYcD8rQJJfcSw
	 9lUVC9G0Lk9HVvBJ+l3wheNQX26zr/4rL3o4EHVDgl89Tk/NKb487ozVGgzL7m+jS
	 mzydOuH8sNVNBBT1rQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([91.47.146.25]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MUU68-1viV5M2xEW-00Itn3; Sun, 09
 Nov 2025 17:43:36 +0100
Message-ID: <8796cd59-2335-4674-823d-d682ce7b7f8e@web.de>
Date: Sun, 9 Nov 2025 17:43:36 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] diff: disable rename detection with --quiet
To: "D. Ben Knoble" <ben.knoble@gmail.com>, Git <git@vger.kernel.org>
References: <CALnO6CBsj+aMvHJoUQ+LHAtXhcFhQeH8AuHyrX+rumur6MQQog@mail.gmail.com>
Content-Language: en-US
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
 Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CALnO6CBsj+aMvHJoUQ+LHAtXhcFhQeH8AuHyrX+rumur6MQQog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o7LjLD/PP14mLUzHN3KxvLnZJAbfhsoAlETgN6G2V9X215aa9/g
 3/GYz91o/EcKKNI2rZSieEV5ESOQwpRNNn6eoVTxBz9cU7b+knSAnIanOuXEH/+S9vvhxbA
 h74V+Mz3d0QSj3ucTNlzh6mC3HnROZi/SM+h+qCFico7+Kd1F7ymazi0OJzHwDtgQOOjq2U
 sS0oSAf3juDrbpG2EUqkg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ayCmLu1Wj8w=;ankMV2tV71olP5B1mFpBgVUNDiS
 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
 juaQ3dd0LCpfAF+V+u1zC+uX6U=

Detecting renames and copies improves diff's output.  This effort is
wasted if we don't show any.  Disable detection in that case.

This actually fixes the error code when using the options --cached,
=2D-find-copies-harder, --no-ext-diff and --quiet together:
run_diff_index() indirectly calls diff-lib.c::show_modified(), which
queues even non-modified entries using diff_change() because we need
them for copy detection.  diff_change() sets flags.has_changes, though,
which causes diff_can_quit_early() to declare we're done after seeing
only the very first entry -- way too soon.

Using --cached, --find-copies-harder and --quiet together without
=2D-no-ext-diff was not affected even before, as it causes the flag
flags.diff_from_contents to be set, which disables the optimization
in a different way.

Reported-by: D. Ben Knoble <ben.knoble@gmail.com>
Suggested-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 diff.c              |  2 ++
 t/t4007-rename-3.sh | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/diff.c b/diff.c
index a1961526c0..efa8d9773c 100644
=2D-- a/diff.c
+++ b/diff.c
@@ -4987,6 +4987,8 @@ void diff_setup_done(struct diff_options *options)
 	if (options->flags.quick) {
 		options->output_format =3D DIFF_FORMAT_NO_OUTPUT;
 		options->flags.exit_with_status =3D 1;
+		options->detect_rename =3D 0;
+		options->flags.find_copies_harder =3D 0;
 	}
=20
 	/*
diff --git a/t/t4007-rename-3.sh b/t/t4007-rename-3.sh
index e8faf0dd2e..3fc81bcd76 100755
=2D-- a/t/t4007-rename-3.sh
+++ b/t/t4007-rename-3.sh
@@ -41,6 +41,16 @@ test_expect_success 'copy detection, cached' '
 	compare_diff_raw current expected
 '
=20
+test_expect_success 'exit code of quiet copy detection' '
+	test_expect_code 1 \
+	git diff --quiet --cached --find-copies-harder $tree
+'
+
+test_expect_success 'exit code of quiet copy detection with --no-ext-diff=
' '
+	test_expect_code 1 \
+	git diff --quiet --cached --find-copies-harder --no-ext-diff $tree
+'
+
 # In the tree, there is only path0/COPYING.  In the cache, path0 and
 # path1 both have COPYING and the latter is a copy of path0/COPYING.
 # However when we say we care only about path1, we should just see
=2D-=20
2.51.2
