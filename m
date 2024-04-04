Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CB7101DB
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 17:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712250465; cv=none; b=iO7M3TKbQWaA8lcrCehhmQBbaZa9Hv5XxEOTggaB9wa5lCwGa7X2DnQURpfGlPb95XVtDMhSwduwY+lAUgs0sjZSNoY3WJnUzcPwRmZmL6SQK3oakrxE94txBbvVol7MogP8m4dM+8LMpweMm8D7lAK+qExdBTkdW+adwyOBzRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712250465; c=relaxed/simple;
	bh=5sMBbXZ66HsD74i/ONqX6MNkPwtkibmTURBmp5N90/8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=UWcAoWapD75ZkWFSMO5p58Q8nzx+zW4VUrqfiZMzhwGpK+c1akRd3UZM14DKK7lRP4/XZZUD3Q8LuuoZ/YLtCX2y01pFk7dzI/nhqJ7k5S5KKPbCvsY5micecW061FqEGxWIo4AW1VVM4fq+LbnZb1hivAgwqLGOARx6eyL8jdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Jvym1E35; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Jvym1E35"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712250455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fipOROSoCGDTYOF+QQLqS9y0a4blq7ERl2XMmLgYKIY=;
	b=Jvym1E35OdY0jvwm0h6dJ8s0IHXyyK66kGkqFFxXc5MZ68WoYZoqu8yU0xE6VX1b2jaztg
	UBb7b6ASYlqP42QNMV60O8aFNBiGeFLJMpAY1SbHPD4uMJSJulXWGqYsb/bMNgfFiZuVO1
	kNbSua1X67BbYelAvM4/bdhes8g4NDwRRzsSPkhctiT39w6tvZhlOxrX3cUxfNmz6ufYXc
	JDxaSDLy+Fa65XVXLJVkXmlRl/TNJwnAvG/zkHlUHVyDVhWbjQm+Sjyou4tW9wpzyLXiUy
	wqfci8ZnTzOG9To2ZhHhQnzZMBGl+g8DxWEOK6ySu9gitY1mbknzxuQDLZOvVg==
To: git@vger.kernel.org
Subject: [PATCH RESEND] send-email: make produced outputs more readable
Date: Thu,  4 Apr 2024 19:07:32 +0200
Message-Id: <62553db377c28458883b66bcdc0c58cc0f32d15b.1712250366.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

When sending multiple patches at once, without confirming the sending of each
patch separately, the displayed result statuses of sending each patch become
bunched together with the messages produced for the subsequent patch.  This
unnecessarily makes discerning each of the result statuses a bit difficult,
as visible in the sample output excerpt below:

    ...
    MIME-Version: 1.0
    Content-Transfer-Encoding: 8bit

    Result: 250
    OK. Log says:
    ...

As visible above, bunching the "Result: <status-code>" lines together with
the messages produced for the subsequent patch makes the output unreadable.
Thus, let's add a newline after each displayed result status, to make the
outputs more readable, as visible in the sample output excerpt below:

    ...
    MIME-Version: 1.0
    Content-Transfer-Encoding: 8bit

    Result: 250

    OK. Log says:
    ...

This change also adds a newline after the last produced result status, which
may be seen as redundant.  Though, it doesn't look too bad, and making that
last newline not displayed would make the code much more complex, which would
not be worth neither the time and effort now, nor the additional maintenance
burden in the future.

While there, remove one spotted stray newline in the code.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---

Notes:
     * send-email: make produced outputs more readable by separating
       the result statuses from the subsequent patch outputs
    
    This is a resubmission of the patch I submitted about a week and a half
    ago. [1]  The patch subject in the original submission was selected in
    a bit unfortunate way, which this submission corrects, and also improves
    the patch description a bit.  There are no changes to the patch itself.
    
    [1] https://lore.kernel.org/git/6ee28707b9eb8bd8fdfc8756c351455c6bc3bb62.1711447365.git.dsimic@manjaro.org/

 git-send-email.perl | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 821b2b3a135a..62505ab2707c 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1576,7 +1576,6 @@ sub send_message {
 		print $sm "$header\n$message";
 		close $sm or die $!;
 	} else {
-
 		if (!defined $smtp_server) {
 			die __("The required SMTP server is not properly defined.")
 		}
@@ -1686,9 +1685,9 @@ sub send_message {
 		print $header, "\n";
 		if ($smtp) {
 			print __("Result: "), $smtp->code, ' ',
-				($smtp->message =~ /\n([^\n]+\n)$/s), "\n";
+				($smtp->message =~ /\n([^\n]+\n)$/s), "\n\n";
 		} else {
-			print __("Result: OK\n");
+			print __("Result: OK\n\n");
 		}
 	}
 
