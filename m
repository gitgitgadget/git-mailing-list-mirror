Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B67363511
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 17:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710351138; cv=none; b=qjPdqCI1zaMOaLoAUGoP07QagCl1Un7tOUnPz44KVHIawaHr1AxZfMkMe2cja6kNN+rl22Y2+4q3K54cxlrY0AE8J4hGL6fesCKwgsbDIGHrwJDLTF2bW6a3WF1mIWwlgC4WdKK4gb+/tn4PVRanQcjZKHDrSfOv5/dntV2z5AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710351138; c=relaxed/simple;
	bh=E2igRF5AJ19EEbzjVEdUZns2Azc6M+JyaiPdhlmIYVM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=bStFmHFiBM2EO5sWeqc/iVZLOiJTr/MH12KMWPRt0VmX2jMLCEQDUeaviaB5l4sxrN4arSG0MdNVSYloqjOLSBZplpm8guJ8/ZbcNoMnK/z0q4E1gNZPbNIor9KCmahX2b4BBf30twk9WrdKxjmfxVMauCV0S72J4hTRxdXSFCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=WD3coTLX; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WD3coTLX"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5CFB61D42B2;
	Wed, 13 Mar 2024 13:32:16 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-transfer-encoding;
	 s=sasl; bh=E2igRF5AJ19EEbzjVEdUZns2Azc6M+JyaiPdhlmIYVM=; b=WD3c
	oTLX+ZfR96IFXgvISuT6Qf0WVDAQkVin1awM+oYyB3WHDdETCW+q8IS+d1A/iEhv
	/+NsD410VSLoDjUsIW61JeYsyq9LOUg2uSCFjw2O0IVUpqPjREisgwNEe+nY9gGP
	xc5v88oRk5GO5cC4QqfowksLxbbyVHF19C9IDVQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 545391D42B1;
	Wed, 13 Mar 2024 13:32:16 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7DCB31D42AF;
	Wed, 13 Mar 2024 13:32:15 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 0/2] status --untracked=no
Date: Wed, 13 Mar 2024 10:32:12 -0700
Message-ID: <20240313173214.962532-1-gitster@pobox.com>
X-Mailer: git-send-email 2.44.0-191-g945115026a
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 A2409C40-E15F-11EE-81F0-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Jonas Wunderlich noticed that "git status" documentation mentioned
"--untracked-files=3Dfalse", which unfortunately is not even accepted
by the command.  It is natural to expect that the "--untracked" option
and the status.showuntrackedFiles configuration variable to take a
Boolean value ("do you want me to show untracked files?"), but the
current code takes nothing but "no" as "no, please do not show any".

Junio C Hamano (2):
  status: unify parsing of --untracked=3D and status.showUntrackedFiles
  status: allow --untracked=3Dfalse and friends

 Documentation/config/status.txt |  2 ++
 Documentation/git-commit.txt    |  2 ++
 Documentation/git-status.txt    |  2 ++
 builtin/commit.c                | 57 ++++++++++++++++++++++-----------
 t/t7508-status.sh               | 32 ++++++++++++------
 wt-status.h                     |  3 +-
 6 files changed, 68 insertions(+), 30 deletions(-)

--=20
2.44.0-191-g945115026a

