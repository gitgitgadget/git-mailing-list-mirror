Received: from smtp.bit-artificer.com (smtp.bit-artificer.com [172.105.170.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9996312E63
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 07:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.170.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710487840; cv=none; b=nvBqQlLEqkOkxShtu6ESovWh8PF6GoDS4GU5d/sOzOhqoTD4zkwSuxuuxcnSRWHQ9CHezzCB3Qre2TdltQAtskq6Ivom05mXV4vfAPv44V8c95rIKS74cT3jrWigDCq0Hp9phGmRKTiim4p8+E2ZXK7/MySkDmaCwVfpijOVulI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710487840; c=relaxed/simple;
	bh=DtruQOTOGQFO/oNzZmlITQXW6OpJMyuYzQ/dPD2FD+U=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject; b=BgPjrsgc4JyX1KLaoDALNwzz7cdGhtNA5loHvQ3UJmol8wfKYU7su02glGR3fgewiAEzfgjBUsGrKm7VPFt//KNMzRomrL70gpobzyLI285Un7VHuOwJ4o95mg55fxegImINIQnuGeTKSLfNGXxMaS3eqz/WlJauD30uMILfXl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-artificer.com; spf=pass smtp.mailfrom=bit-artificer.com; dkim=pass (2048-bit key) header.d=bit-artificer.com header.i=@bit-artificer.com header.b=Mw3OZbZP; arc=none smtp.client-ip=172.105.170.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-artificer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bit-artificer.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bit-artificer.com header.i=@bit-artificer.com header.b="Mw3OZbZP"
Received: from localhost (193-115-73-98.tpgi.com.au [193.115.73.98])
	by smtp.bit-artificer.com (Postfix) with ESMTPSA id 1080E3C0BB
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 07:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bit-artificer.com;
	s=20230529; t=1710487441;
	bh=fdTFwdxmv7oTJ/ATlImwCR7OoH0u+7hmg7Vyzx5yEQY=;
	h=Date:From:To:Subject:From;
	b=Mw3OZbZPzlxyyRwQesr9qYhGn8yTS6Bpg5tq0w1kM+rXS+GpfWqSw/MQ2m8OCNAN6
	 bN0pRcDr7miLCjbt7WrOw/CpxroOZJNkFAHtjvmQ+8DEgoji5asVxAhwwfSgeE1pTC
	 xnvenTostCjSSQsW4AnJKPh7ji9JIIgkRpgjHxJrVG6TOgqYoD7htJDJeeMuHce7nn
	 kmwV1zHa2aZCElHV9v4Cy3Qz27hEm6yC90M27vajZc/Mef6LVzjGtXUlu+qosiBUkG
	 Hz9r/K3KmHN1SkkYUtrTkLFNYKe4F43kSzTA7i3+fWlPWbAkGbIuYtnWAN3xTiXBxl
	 VEfiNG9938htA==
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 15 Mar 2024 17:53:59 +1030
Message-Id: <CZU56XWOUT4P.1WZ2BSE0VLN01@bit-artificer.com>
From: "Thomas Lowry" <thomas@bit-artificer.com>
To: <git@vger.kernel.org>
Subject: Expanded worktree tooling?
X-Mailer: aerc 0.15.2

Hello,

I recently learned about worktrees in git and I was wondering if some
extra tooling could benefit workflows that lean on it?

These are the use cases I have banging around in my head:
- throwaway/temp workspaces
  One use case that I've seen alot is creating a workspace to handle
  some hotfix and/or debugging and possibly commit the fix. Instead of
  needing to actively manage this workspace (mostly the cleanup) I
  imagine it would not be too dificult to these in the /tmp folder and
  then cleanup/ignore their entries. Temp workspace file paths might
  make this kind of tooling pointless unless you also automatically
  change the working directory to the new workspace.. I've seen people
  advocate for a git aliases that jump between workspaces but if your
  adding the workspace and typing out the file path anyways then
  `cd path` is shorter than an alias anyways.
- move hunks between workspaces
  In my experience it's more common for a hotfix/debugging use case to
  get the report and just use the current branch since it's not often
  that your current branch is either completely broken or directly
  conflicts with the reported bug. I usually don't stashing and changing
  branches until I've got a fix and want to commit it. I recently tried
  a workspace for this situation but I ended needing to retype the fix
  in the new workspace, after reflecting a bit I should be able to do=20
  `git stash -p` in the main workspace then `git stash pop` in the new
  worktree but a dedicated way to move hunks would be quite useful.

I think there could be more opportunities for general use cases to
benefit from workspaces if there were extra workspace tooling but these
are the only ones I can think of, also to be clear I'm not really
considering any tooling that would allow workspaces to do something you
can't already do with git in some other way.

Thoughts?

Regards,
Thomas
