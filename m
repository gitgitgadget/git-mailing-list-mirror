Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9875E3D9027
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 15:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770303982; cv=none; b=Y//ANIOkuwnlYTJpqk8Tb7Febv7geAGxBkHgxhlHhA4QIUPFNPQDKTab/+WqOEi5410STX9J0hN28eE0jqaLTTBr5ammdehw/ZC+wAYScbMZFcoOGYeEzdqC+R+RExOmBPoODnbBts4D23cWzk88Opt9V4OgC4ubETo93UONOtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770303982; c=relaxed/simple;
	bh=JJISTOB7XhBR+hitJbj0CtBALuRiW+PaMXW5O/F7SZc=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=ltN1Z/8oFHcGc6HtaGM8/+kUiGWNuXsh4o7YZ/NhGeWpwC1wnqXrmSX78KU/aO8xUSCmoWk3n5+R11TMS3hZrb9EHLT6/Zm133IQRVni5uLbJQ5dgo/RJiTD2Ru1um7K9VLbVNl5qi+wwDjLZ+TbtnYDciA2NUbYhkaAs7Rv3zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ytausch.de; spf=pass smtp.mailfrom=ytausch.de; dkim=pass (2048-bit key) header.d=ytausch.de header.i=@ytausch.de header.b=V0EQRQk0; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ytausch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ytausch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ytausch.de header.i=@ytausch.de header.b="V0EQRQk0"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4f6LCD547Vz9tkQ;
	Thu,  5 Feb 2026 16:06:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ytausch.de; s=MBO0001;
	t=1770303976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kCgD5t+LLb23Vl5zgEHuL9WfIBIYraR9AuA9ZO7f/2s=;
	b=V0EQRQk04vkg1TFQ8HmC1EJCxk4N//E27+bsE9DQA24nKS4zH8R9jeohHsaDp2KGcNGlDi
	yXJv4TgwaxvcuooBnzlLIwnRP9V81FPsWW7YtL4ZyBFG1U0E1dYlrsROTEFn90pOpO3hPT
	fhbKDMq3V2SPkUJVhwhUwU1azVEM00bc2CoVCypdpLw8SXCB69yBP+Bbqrj4bggGtNavw1
	/GFRaz9v+NDb5Pik3gbVK1aerL9VSxTuC0hT3UC1GibEFV9Yg/w6ECH/QC+AKcqhx/FfxW
	oAYcxNGb2GVDD4xMkjzSsvPj2RQwOZ+tR3Zu+DNBymEnYRDsfu+P4hiGdNgWoA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of dev@ytausch.de designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=dev@ytausch.de
From: Yannik Tausch <dev@ytausch.de>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: [DOC] merge-file: document that merge.conflictStyle requires a
 repository
Message-Id: <48B1AA62-D7FF-439E-B770-1127E1EE0E79@ytausch.de>
Date: Thu, 5 Feb 2026 16:06:04 +0100
Cc: Manuel Lerchner <manuel.lerchner@quantco.com>,
 Yannik Tausch <yannik.tausch@quantco.com>,
 gitster@pobox.com
To: git@vger.kernel.org
X-Rspamd-Queue-Id: 4f6LCD547Vz9tkQ

Hi,

We noticed that `git merge-file` only respects the `merge.conflictStyle`
configuration when run inside a repository. Outside a repository, the
setting is ignored and only the `--diff3`/`--zdiff3` flags work.

Looking at the history, this appears to be intentional since b541248467
("merge.conflictstyle: choose between merge and diff3 -m styles", 2008),
which explicitly gates config reading on being inside a repository.

This behavior surprised me, and I couldn't find it documented anywhere.
Would a small documentation patch to git-merge-file.txt be welcome,
noting that the config is only read when inside a repository?

Something like adding to the --diff3 option description:

  When run inside a repository, the `merge.conflictStyle`
  configuration variable can be used as a default for this option.

Thanks,

Yannik Tausch
