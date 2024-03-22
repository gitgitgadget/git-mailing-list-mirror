Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE07823A2
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 22:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711145647; cv=none; b=dRgLv9WDuGHSi2OqnfWfogOVftl7lkOOXXPMkRwbVjfnTBTs/6idFPhFztH+WdYy7SP9gSQ6+WoXV6Oy9zGmAEv3G087lH89fQ7v3Q2E8HlwRKWH4Uzu534L2Hold81AYOKANgcG0qRXQBFVRMIWixS0/I7//avntbEiM/sw6e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711145647; c=relaxed/simple;
	bh=TdF/9CKV905jeZejVMA0JaQa2xwurmqwh6eRFgDyuAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y8AG/Z8v2GI6B9bK8j9/7fz1RUAX2upBjFouB+IfpcXsBLqFsUlkuiUugy62X/v0BSww8g8WYPlThjOwJ/hanGe6Ef7avT8McYzujFbXNFUX3kYacPyEuz0B8EFKZUxRwiOO0RCAz3fGBBkEmxly3F0a/X8meRhk7K/QIKG8xpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=na/r2H1W; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="na/r2H1W"
Received: from localhost (reverse-238.fdn.fr [80.67.176.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id CD3E66037C;
	Fri, 22 Mar 2024 23:13:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1711145634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9E9Vqsc7YN7dc53i7cQRKPf/0DHrozMmdUpC296HWxM=;
	b=na/r2H1WoUwGwzhJbu/UHMhq9UT896ggyr7joJhmEw+nFD1y9UQZUYLR2eZaOtPHqydgt6
	KewBfConZKGXuntRzmR6/6O1A4fZ8SxoxG+YsCDOQCRB/muLnQh2qnsQ+qSoKtmKcpsAel
	jXIrWxKju6Am+hIy4LT4/3nn/W6B6QVSJh4YAg70ySZVKesCym/YPMNleh1YD+yCd/HfNp
	eZwrkNREEKJU/ifv0xq1Z5m+jJXYZXbR9pCkl1HEHZFIUCqvOgKzvUKQ2SUjamDr9hFukg
	oHqZkL+qaVVDzbtkSpCQraTVjtjxwEIlevd+88/etFbswpzynHPPmDu+v0ylBQ==
From: Max Gautier <mg@max.gautier.name>
To: git@vger.kernel.org
Cc: Max Gautier <mg@max.gautier.name>,
	=?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>,
	Derrick Stolee <stolee@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/6] maintenance: update systemd scheduler docs
Date: Fri, 22 Mar 2024 23:11:10 +0100
Message-ID: <20240322221327.12204-6-mg@max.gautier.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322221327.12204-1-mg@max.gautier.name>
References: <20240322221327.12204-1-mg@max.gautier.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `git maintenance` systemd scheduler no longer writes units in
$XDG_CONFIG_HOME.

Describe the new behavior.
Instead of explaining manual ways to modify the timer, suggest the
systemd standard tool: `systemctl edit`.

Signed-off-by: Max Gautier <mg@max.gautier.name>
---
 Documentation/git-maintenance.txt | 33 +++++++++++++++----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index 51d0f7e94b..6511c3f3f1 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -304,10 +304,9 @@ distributions, systemd timers are superseding it.
 If user systemd timers are available, they will be used as a replacement
 of `cron`.
 
-In this case, `git maintenance start` will create user systemd timer units
-and start the timers. The current list of user-scheduled tasks can be found
-by running `systemctl --user list-timers`. The timers written by `git
-maintenance start` are similar to this:
+In this case, `git maintenance start` will enable user systemd timer units
+and start them. The current list of user-scheduled tasks can be found by
+running `systemctl --user list-timers`. These timers are similar to this:
 
 -----------------------------------------------------------------------
 $ systemctl --user list-timers
@@ -317,25 +316,25 @@ Fri 2021-04-30 00:00:00 CEST 5h 42min left Thu 2021-04-29 00:00:11 CEST 18h ago
 Mon 2021-05-03 00:00:00 CEST 3 days left   Mon 2021-04-26 00:00:11 CEST 3 days ago git-maintenance@weekly.timer git-maintenance@weekly.service
 -----------------------------------------------------------------------
 
-One timer is registered for each `--schedule=<frequency>` option.
+One timer instance is enabled for each `--schedule=<frequency>` option.
 
-The definition of the systemd units can be inspected in the following files:
+The definition of the systemd units can be inspected this way:
 
 -----------------------------------------------------------------------
-~/.config/systemd/user/git-maintenance@.timer
-~/.config/systemd/user/git-maintenance@.service
-~/.config/systemd/user/timers.target.wants/git-maintenance@hourly.timer
-~/.config/systemd/user/timers.target.wants/git-maintenance@daily.timer
-~/.config/systemd/user/timers.target.wants/git-maintenance@weekly.timer
+$ systemctl cat --user git-maintenance@.timer
+$ systemctl cat --user git-maintenance@.service
 -----------------------------------------------------------------------
 
-`git maintenance start` will overwrite these files and start the timer
-again with `systemctl --user`, so any customization should be done by
-creating a drop-in file, i.e. a `.conf` suffixed file in the
-`~/.config/systemd/user/git-maintenance@.service.d` directory.
+Customization of the timer or service can be performed with the usual systemd
+tooling:
+-----------------------------------------------------------------------
+$ systemctl edit --user git-maintenance@.timer # all the timers
+$ systemctl edit --user git-maintenance@hourly.timer # the hourly timer
+$ systemctl edit --user git-maintenance@.service # all the services
+$ systemctl edit --user git-maintenance@hourly.service # the hourly run
+-----------------------------------------------------------------------
 
-`git maintenance stop` will stop the user systemd timers and delete
-the above mentioned files.
+`git maintenance stop` will disable and stop the user systemd timers.
 
 For more details, see `systemd.timer(5)`.
 
-- 
2.44.0

