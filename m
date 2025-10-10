Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB42A2F9995
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 15:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760109737; cv=none; b=VQn9/Ey1dLVjT6JTShuRUtr/IqkmdxlXuttH2k92XFsr+AoFq+UjxXkhQ5YOQ5lBdDnq8ZeOba7nN51eskpnrKsfmYY/piLE27/PVbumaTqUFvWmBSF1bBDgwVVEPx0H1luANmw7VmXHkzxxXu66orH6xz+ZmY0Ossn8iImXR/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760109737; c=relaxed/simple;
	bh=f/f3u4m5no37qwWuMXMHrL3P5P3JhdGZ3EWDyaS0/zI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ul5y5bl/EPAUNR9R+aUTBusw8f6sGr5K0tCKJcumT47aNG0SdK2mi5T7bUNuqU5fUP90V0Q3aevgN/9K+DAr63XdTHyQw1NlPRHjM3YNDar+hvAb8Jn6TvAQ+bkVodpY1YmY4DrxxZ5R5zpkhqQO2XeeiAsyABZu6DGjRDjBEO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=decentsoftwa.re; spf=pass smtp.mailfrom=decentsoftwa.re; dkim=pass (2048-bit key) header.d=decentsoftwa.re header.i=@decentsoftwa.re header.b=kGMXSqNd; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=decentsoftwa.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decentsoftwa.re
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=decentsoftwa.re header.i=@decentsoftwa.re header.b="kGMXSqNd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=decentsoftwa.re;
	s=protonmail3; t=1760109733; x=1760368933;
	bh=NFqWW87M3ImGRBGe3ugMEoJ5S3oBbY4FxxgIJqNrmGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=kGMXSqNdKm6h4CeQ5q9hHNkh6ZUCYLR5LMdbfTmtZLTvySK4s8ymB6/uBGyIpy4Sd
	 QSM1WeFSJ+8zoQHx1kD2fA61FPxEDerj0FnaJnZ8Eg9c9gD0U6RPVE+PPBLV1PBNx4
	 3d89CRw4ipJchvJ8A3j6gOieUaRJr/BlLKRYznxclkZvWmucmebRGWsJzwI8AWJRtb
	 MNhqj2j75Pok2GdP84JiDvyw8NUdaHxRpfCEK4cBmALlPrP9VOSxad7duf2WQC/0IA
	 dk4vgBjpTB9hNvoDtL+SK5pirInI+CQ7cgMIhZhMTHFOaHwzuMIc0bMgtjXhu/4kaz
	 rSJMWe72VN95w==
X-Pm-Submission-Id: 4cjr834mwZz2Sdl8
From: Philip Patsch <philip@decentsoftwa.re>
To: git@vger.kernel.org
Cc: Philip Patsch <philip@decentsoftwa.re>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH 1/1] docs/git-blame: describe sourceline and resultline
Date: Fri, 10 Oct 2025 17:21:59 +0200
Message-ID: <20251010152204.815520-2-philip@decentsoftwa.re>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251010152204.815520-1-philip@decentsoftwa.re>
References: <20251010152204.815520-1-philip@decentsoftwa.re>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The manpage did not make clean what source and resultlines
refer to. This simple adjustment should remove that confusion.

Based on the question and answer on this Stackoverflow page:
https://stackoverflow.com/questions/49370690/what-is-sourceline-resultline-in-git-blame-incremental-output

Signed-off-by: Philip Patsch <philip@decentsoftwa.re>
---
 Documentation/git-blame.adoc | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-blame.adoc b/Documentation/git-blame.adoc
index e438d28625..870d0de0a5 100644
--- a/Documentation/git-blame.adoc
+++ b/Documentation/git-blame.adoc
@@ -113,8 +113,10 @@ In this format, each line is output after a header; the
 header at the minimum has the first line which has:
 
 - 40-byte SHA-1 of the commit the line is attributed to;
-- the line number of the line in the original file;
-- the line number of the line in the final file;
+- the line number of the line in the original file,
+  from when the commit was made;
+- the line number of the line in the final file,
+  from the current state of the file;
 - on a line that starts a group of lines from a different
   commit than the previous one, the number of lines in this
   group.  On subsequent lines this field is absent.
@@ -214,6 +216,9 @@ annotated.
 	<40-byte-hex-sha1> <sourceline> <resultline> <num-lines>
 +
 Line numbers count from 1.
++
+<sourceline> is where this line shows up in the original source commit.
+<resultline> is where this line shows up in the current state of the file.
 
 . The first time that a commit shows up in the stream, it has various
   other information about it printed out with a one-word tag at the
-- 
2.49.0

