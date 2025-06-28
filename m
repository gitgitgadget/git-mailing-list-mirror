Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF18413DDAE
	for <git@vger.kernel.org>; Sat, 28 Jun 2025 22:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751151588; cv=none; b=kcK1c+4CWVq66efWWvgR4SVkkpV2phQ2qiXTprRAczm3owelOzeUmK56XkD99bJwPH6zNp6ZTHjdI21miYBcPI0oiVmzIQ1CD2nWIfqNGMB0dbOrN/w2MnRplQ1ZTPdoFt1SXzwsuTqsD9wzEmwgeoJ9LUqpKc1+QhfqMaYg0J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751151588; c=relaxed/simple;
	bh=Qh1VWE6YGR9qfxXLplfOwB2bb2Q99cPWqBv79uXGP9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pAdC7AwRUiN1pAomMO0Z1O+hoIifSVfXWC2gC20nT0stZX/ZWX3j+DqgnRNczCBZMIIUUzFs2f1LVR77HPRDefgO0dtmq4yZRI+MAQCBrQhIL+WCx316llYNz7fHaLzyeMwMGH54TvuGyxsncYUIDwLrleXWjzj/4YoXirQ71uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev; spf=pass smtp.mailfrom=ameretat.dev; dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b=KBHL3umM; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="KBHL3umM"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
	s=default; t=1751151582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=z10Vt0bqw7ie+HWtPihQCALrIa959pmCAoCL4Svq8Zs=;
	b=KBHL3umMbWU+9c6aMFCT+n3xsay97m6pOCwy7LSckOrKcxclCQoql1WPcMZ+GM6Zp9ZueQ
	NF1atWQDrWFolO4HM6oNKBsDW/o9ZgWyJ8A9qhczyoeqx5W2jbn5MkNopba+0lUuiOK5pU
	GrbXqljjSjNyEzby+sN0T8Ju/1BycCY=
From: "Raymond E. Pasco" <ray@ameretat.dev>
To: git@vger.kernel.org
Cc: "Raymond E. Pasco" <ray@ameretat.dev>,
	aclopte@gmail.com,
	gitster@pobox.com,
	jason11choca@proton.me,
	kristofferhaugsbakk@fastmail.com,
	rhodges@cisco.com
Subject: [PATCH 0/5] fix apply --intent-to-add
Date: Sat, 28 Jun 2025 18:52:02 -0400
Message-ID: <20250628225819.1294068-2-ray@ameretat.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The --intent-to-add (-N) flag to apply has not worked properly since its
introduction in Git 2.19; in particular, it creates an empty index
except for any new files in the patch, making it largely useless except
on blank repositories.

This patch series fixes it to work as expected and updates the tests
and documentation for this flag.

Earlier discussion of this issue can be found in the threads associated
with message ids <20211106114202.3486969-1-aclopte@gmail.com> and
<20250511003955.242889-1-ray@ameretat.dev>.

Raymond E. Pasco (5):
  apply: error on --intent-to-add outside gitdir
  apply: read in the index in --intent-to-add mode
  apply: only write intents to add for new files
  t4140: test apply --intent-to-add interactions
  apply docs: clarify wording for --intent-to-add

 Documentation/git-apply.adoc |  8 ++++----
 apply.c                      | 12 ++++++++----
 t/t4140-apply-ita.sh         | 31 ++++++++++++++++++++++++++++++-
 3 files changed, 42 insertions(+), 9 deletions(-)

-- 
2.50.0.195.g74e6fc65d0

