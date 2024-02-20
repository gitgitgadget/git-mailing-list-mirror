Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760075D8E4
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 09:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421420; cv=none; b=GLWTzo3wTTxVQK6qVYuJAYmrah1ksIfNKl8F6l7rbYYoc8370T6nDVLRnHYHeG2CvpGxhVEu3z0SkLFKyxh+C/2Azagcny8x9Q5NUZ0qRm57qVQxosxEEuqRyEg7OizCSoD7RbFFRGjdY8x/EhY4TwPXH+o9sbU+tBlJIvvuGek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421420; c=relaxed/simple;
	bh=e/9RM3coxggO4aMEOrhaFMwgi2RC0PKUicmqaVIW0WM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZofHIWlBt79jmAW/TnClJ9evnGTIMn1tl3Cw/a0iSoUayaxExJMwQiUmNLvVCNOyyToexXuy1I9uYW5CvBxNYumqnbGi4rTG9jHFoTUAXJULnaLOJbeu2Lx98er5hXKaqZDUllfY7+CDwDFY0qmRiyyNIvuzSja4+3zvvvQb1ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNsifNdY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNsifNdY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01ACC433C7;
	Tue, 20 Feb 2024 09:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708421420;
	bh=e/9RM3coxggO4aMEOrhaFMwgi2RC0PKUicmqaVIW0WM=;
	h=From:To:Cc:Subject:Date:From;
	b=GNsifNdYuoix/uXb5sjx+e1AH74ChihoDLzAvC2ftBbj9+p0lkfp3yum4bWQpbm/U
	 3bw/wTldrVys9QtYjP5GA5qL4MLLksnPQfeiUH7I4XvZC4Ra1IXc8G8Jsg4xEOOYj2
	 8bTkgjgNGKCHTF/R3Wqca4ImjELh7UvqyP5VnDvBPCnG0mIbf6gFMXo+a57bm8mbOA
	 FVPepDjjbEfThIctvHIQ/kd6KE46YwtS2WAOSenTMEAab84RGH/a5yAWIUcsk2gBVr
	 R/KoLtftLcddDWcfWSI9fXDEITiXkwSXcXmN5zQj9QgmHQc4LfXoO3ptGJ5LgrIVGa
	 O0XBy2HUwnNSg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH] Revert "Declare both git-switch and git-restore experimental"
Date: Tue, 20 Feb 2024 10:29:51 +0100
Message-ID: <20240220092957.1296283-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2552; i=matttbe@kernel.org; h=from:subject; bh=e/9RM3coxggO4aMEOrhaFMwgi2RC0PKUicmqaVIW0WM=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl1HEVlS9u8RA01gmOiyKjGwH14+EjCjK0sUSpV ey08qQvv8WJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZdRxFQAKCRD2t4JPQmmg c1OdD/kBJDfocUJJYIp47QCTaHPSJMlothOzPARxmJIGvR5fy6OlKnsXxNtbI0Lb2nV2Q9uFMlr voYjY2NctGKdRZ5imgJmt+YQY1bwQ4tJd9oRCLj+Cz7ey7Zo+/bWWHmv7gQpcC+36l+rz+2lGZC 4XnImJxJqMfbKLpuWQQbDiqQ6bU6hsezxp3MUoOeQaaq9/zTksWMGBaTPUh0dFc/52MM4Bgn0gt P7+GjdKTGX0sCS60OonvQlxtXAA1Nj8KBeqXVxlg8QRp2vaMVMlLzTwfLz4Pww0IWm4dgBw5KXY 18kS5bSc2xDD85DYQXiwYKJq923gGEuCXXmtK4/uzmX6y/gdW7+jM9UnkLA+9yPx/MBAup1hLJ7 JDRCuUQzfpwyPIkdb5zOHtt4mA41dQp4uuB0BoS4u6TF8rxHkdGD/neOkwAPz1qHKBg8wmmXlEe 3x8hgOAZ6A5EE8Y3kY0yCa4l6roEnG+VB4MVAIz6bFuqRthGffOR7LMvL7XdqlKJiAH/Mx1SEXe uu2SABcK/UQ6y0U9WcJJ5UWr60Ug+2Yraa6NYHOt6IqoQPxMNYhg6CE0WkTct+Tq698CTH0btSy WiTbNY9gw0+a5ucMmnpqG3prP75daEbwQGNzCbzR1mfPS4yyQAbNFa1VccOGuD1He4NJ3bdLM+0 Th/oqZY+y4DDtTA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

This reverts commit 4e43b7ff1ea4b6f16b93a432b6718e9ab38749bd.

Recently, I wanted to recommend the use of git-switch and git-restore
instead of git-checkout in new documentation pages. But then, I found
out that these two commands were still marked as experimental in the
documentation. git-switch and git-restore have been marked as such since
their introduction, in version 2.23.

That was for good reasons, according to the reverted commit:

> These two commands are basically redesigned git-checkout. We will not
> have that many opportunities to redo (because we run out of verbs, and
> that would also increase maintenance cost).

The reverted commit also mentions this:

> To play it safe, let's declare the two commands experimental in one or
> two releases. If there is a serious flaw in the UI, we could still fix
> it. If everything goes well and nobody complains loudly, we can remove
> the experimental status by reverting this patch.

Version 2.44 is approaching, almost 5 years after the introduction of
these two commands, it then looks safe to remove this experimental
status.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---

Notes:
    Here is a simple 'git revert', as suggested in 4e43b7ff1e ("Declare both
    git-switch and git-restore experimental"), without any conflicts to
    resolve.
    
    BTW, thank you very much for maintaining and still improving this great
    tool!

 Documentation/git-restore.txt | 2 --
 Documentation/git-switch.txt  | 2 --
 2 files changed, 4 deletions(-)

diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.txt
index 975825b44a..4f5531c440 100644
--- a/Documentation/git-restore.txt
+++ b/Documentation/git-restore.txt
@@ -28,8 +28,6 @@ otherwise from the index. Use `--source` to restore from a different commit.
 See "Reset, restore and revert" in linkgit:git[1] for the differences
 between the three commands.
 
-THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
-
 OPTIONS
 -------
 -s <tree>::
diff --git a/Documentation/git-switch.txt b/Documentation/git-switch.txt
index f38e4c8afa..96cfd9ba52 100644
--- a/Documentation/git-switch.txt
+++ b/Documentation/git-switch.txt
@@ -29,8 +29,6 @@ Switching branches does not require a clean index and working tree
 however if the operation leads to loss of local changes, unless told
 otherwise with `--discard-changes` or `--merge`.
 
-THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
-
 OPTIONS
 -------
 <branch>::
-- 
2.43.0

