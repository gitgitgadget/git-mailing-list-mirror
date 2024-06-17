Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71C01946C4
	for <git@vger.kernel.org>; Mon, 17 Jun 2024 10:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718621016; cv=none; b=qOmbNYKIU1MpqHpuFCWcfmTwHCeKsy7V/ZMk5NrfLIAdP6y5nO4YieRiOidUGUx3d84T17L3od0yyg7aXSLot1jPoFxURKVY9iSE1Si38Gzs5fwHMw+BUevIuIhhrTMRUshGTTNTVV4smsaO3nK+xnss1pK3JL0fq4sZExmylxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718621016; c=relaxed/simple;
	bh=YQMiEIeciU5MRrzzHGGdOYeg/1Did76hnzS6B10UUaA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SKyA9FIH30nEiZAQld+Lub1PEYkMEBRIXF0fpjZwO8nNTn1quejP3R0OUyUbmOac78+nACMdUOj+zthNDRY5bNgY3h/wWEtb6L4tc7AtBmTya4BF+pPK5b4IVZosob/NZVLHREqz/u799GXO1Feh3OYDoYg+GflKMp4MFQhYACM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=fvKTLjXY; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="fvKTLjXY"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F5F71FB11
	for <git@vger.kernel.org>; Mon, 17 Jun 2024 10:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1718621006;
	bh=YQMiEIeciU5MRrzzHGGdOYeg/1Did76hnzS6B10UUaA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=fvKTLjXYesV+8HK4rTnzuyOFtQgGiMD5S+LwSv8VAPRjQHaxc9qnFkk1oU6qylg7F
	 UC1dagZVv2/+azuSITgveS9K0eRX+Kbx/K7e0ApGOJXy2gcfQSqysaX+j5MxOiGzO8
	 UBuVcLp64KIYBCYg4ms+j500tCJ8CNHhpEsEug00=
From: Eric Wong <e@80x24.org>
To: git@vger.kernel.org
Subject: [PATCH 1/2] Git.pm: use array in command_bidi_pipe example
Date: Mon, 17 Jun 2024 10:43:25 +0000
Message-ID: <20240617104326.3522535-2-e@80x24.org>
In-Reply-To: <20240617104326.3522535-1-e@80x24.org>
References: <20240617104326.3522535-1-e@80x24.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

command_bidi_pipe takes the git command and optional arguments as an
array, not a string.  Make sure the documentation example is usable
code.

Signed-off-by: Eric Wong <e@80x24.org>
---
 perl/Git.pm | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 03bf570bf4..aebfe0c6e0 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -418,7 +418,7 @@ sub command_bidi_pipe {
 and it is the fourth value returned by C<command_bidi_pipe()>.  The call idiom
 is:
 
-	my ($pid, $in, $out, $ctx) = $r->command_bidi_pipe('cat-file --batch-check');
+	my ($pid, $in, $out, $ctx) = $r->command_bidi_pipe(qw(cat-file --batch-check));
 	print $out "000000000\n";
 	while (<$in>) { ... }
 	$r->command_close_bidi_pipe($pid, $in, $out, $ctx);
@@ -431,7 +431,7 @@ sub command_bidi_pipe {
 calling this function.  This may be useful in a query-response type of
 commands where caller first writes a query and later reads response, eg:
 
-	my ($pid, $in, $out, $ctx) = $r->command_bidi_pipe('cat-file --batch-check');
+	my ($pid, $in, $out, $ctx) = $r->command_bidi_pipe(qw(cat-file --batch-check));
 	print $out "000000000\n";
 	close $out;
 	while (<$in>) { ... }
