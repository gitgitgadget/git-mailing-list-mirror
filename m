Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBB1134A8
	for <git@vger.kernel.org>; Sun,  1 Dec 2024 22:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733091950; cv=none; b=NhU8ft5lusKAPZIqakQIThHuTO1xWZA1NjDh/T/dK8q4/MZDd9ODPhKbHK3kD0B+GBqwvQlCUQldl3DWhqegLdEeoyIAEKnEFTSQNd8hSZ/77zLKhuOAl86bo3IJ4jKvdqaAMxy1vPHpLn2ib/nFu0VNJSsnu6YT60RAKCXLeZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733091950; c=relaxed/simple;
	bh=f7tJNtvDMAeRrhJHNcOnDbNjmDzc1uT01g9Pk9yuE8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ARTKYsj5KkzROpY/FDjGOfjhu+39N64ScVKwN4oWxFtblMSes8jlr3WI3pozNAucmSnv384sIys5PKeG0Dop76fPv2OhAfsAbBMmbMZrHikEHh0tzMun+Lk2HjuV47dfXIAYz1dpruHbpjZhEp3PVkY4n3JADXKMamCDuavdMcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=cepl.eu; spf=fail smtp.mailfrom=cepl.eu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=cepl.eu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=cepl.eu
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 266421F383;
	Sun,  1 Dec 2024 22:25:43 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 12EDC138A5;
	Sun,  1 Dec 2024 22:25:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EgVvA2fiTGfkEQAAD6G6ig
	(envelope-from <mcepl@cepl.eu>); Sun, 01 Dec 2024 22:25:43 +0000
From: =?UTF-8?q?Mat=C4=9Bj=20Cepl?= <mcepl@cepl.eu>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Mat=C4=9Bj=20Cepl?= <mcepl@cepl.eu>
Subject: [PATCH] Documentation/git-update-index.txt: add an example of use
Date: Sun,  1 Dec 2024 23:25:23 +0100
Message-ID: <20241201222531.1478338-1-mcepl@cepl.eu>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.988];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

I met this command in the wild and I spent a lot of time to
understand what it is good for.
---
 Documentation/git-update-index.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 7128aed540..da11cbc418 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -399,6 +399,15 @@ M foo.c
 <8> you can tell about the change after the fact.
 <9> now it checks with lstat(2) and finds it has been changed.
 
+To speed up other Git commands that rely on the index, such as git status
+or git commit, user can refresh the index and avoid having to re-check
+the status of every file in the working directory. This command
+doesn't modify any committed data in your repository.
++
+----------------
+$ git update-index -q --refresh || true
+----------------
+
 
 SKIP-WORKTREE BIT
 -----------------
-- 
2.47.1

