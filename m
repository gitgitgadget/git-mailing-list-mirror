Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CBD3A1B5
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 07:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712732502; cv=none; b=iNmBU0h8uJgHkodYf3p7SpByDbGHLYsV05lV3habrZMcb0Z6n2U9xHqg0F+kYPEHaT/yA1m3iP1UEkck4JF1O4unlRZhCPCw/CXQ5xUoWzJIq5Fx6FwQam+K7k2DfH14twJTfAy+9L24RnBNs3Bru5p+N8J79Xe4/XJu1sItVDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712732502; c=relaxed/simple;
	bh=FcYBR+ONmJvNT1qjQMDL1kj79mEX9rjJ5ORVW4srt40=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ARy7GeIhwfZkk1RE14Lhl0qh7FdOpb5BzUDOLLKstJ5KDNAyTxONXkeTgjuWv9vLAuldaM/gZf2HVpRiN8d7K6f141+/cDR6GvRl2oc7yyDTBpxFKkh/dfyqK8GYZv5/QtAJVwTh0F/IgPa0QBi1E2hjxGermJ+kTlwxnuf63UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=NZEAPfBW; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="NZEAPfBW"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712732497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L7gewyzs64hp0iWETKsAHyDDQs11VLxJLXye0xBaxrA=;
	b=NZEAPfBW9z4lVC6RP0FTza7f19JPEcf6bGyk/sFun21vVIyB//2QCrgvGk/EEeTNkxwwKo
	2k3QZPuXTORol0KICgbXdfTqM6FLaJ5JkAWrxcFyo36rXBKhhzJ+pogWEre6SPREjAl9gU
	T7rszoC3Elj00cSFg+Y0I749vndy3pUOEqUBWDJl2Ov/d9YRrA7c8JaxEI+CyWRvZ0iR3t
	mIOtFBT+TXtfYSDCxpDYtI4yF5twpipGwMCoko65LobDK+ovkcjv5VY4qw+qPMWER+xh+R
	WLg3zOYue6UD4bXhIf6evQBd8xYbS/vmOvvq7HDnLxERvztG7+I7A7UfunzD3A==
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	code@khaugsbakk.name
Subject: [PATCH v6 1/2] send-email: move newline characters out of a few translatable strings
Date: Wed, 10 Apr 2024 09:01:29 +0200
Message-Id: <29ea3a9b07bf1aa17b5d6a1e41325379c494bcb2.1712732383.git.dsimic@manjaro.org>
In-Reply-To: <cover.1712732383.git.dsimic@manjaro.org>
References: <cover.1712732383.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Move the already existing newline characters out of a few translatable
strings, to help a bit with the translation efforts.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 git-send-email.perl | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 821b2b3a135a..f0be4b4560f7 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1664,9 +1664,11 @@ sub send_message {
 		$smtp->code =~ /250|200/ or die sprintf(__("Failed to send %s\n"), $subject).$smtp->message;
 	}
 	if ($quiet) {
-		printf($dry_run ? __("Dry-Sent %s\n") : __("Sent %s\n"), $subject);
+		printf($dry_run ? __("Dry-Sent %s") : __("Sent %s"), $subject);
+		print "\n";
 	} else {
-		print($dry_run ? __("Dry-OK. Log says:\n") : __("OK. Log says:\n"));
+		print($dry_run ? __("Dry-OK. Log says:") : __("OK. Log says:"));
+		print "\n";
 		if (!defined $sendmail_cmd && !file_name_is_absolute($smtp_server)) {
 			print "Server: $smtp_server\n";
 			print "MAIL FROM:<$raw_from>\n";
@@ -1686,10 +1688,11 @@ sub send_message {
 		print $header, "\n";
 		if ($smtp) {
 			print __("Result: "), $smtp->code, ' ',
-				($smtp->message =~ /\n([^\n]+\n)$/s), "\n";
+				($smtp->message =~ /\n([^\n]+\n)$/s);
 		} else {
-			print __("Result: OK\n");
+			print __("Result: OK");
 		}
+		print "\n";
 	}
 
 	return 1;
