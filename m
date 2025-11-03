Received: from mail-10626.protonmail.ch (mail-10626.protonmail.ch [79.135.106.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BB62FFF8B
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 10:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762167083; cv=none; b=OD00+fEAZ94HOBDssRUKEpefU4HNQyP1ZEbnNoe2OArF14KUPeNRb1wKdMAA8wulQM8AHU6n5p+U9nZZcoAeISsNNLTACQZqxqb2qfX8ZpXsJGh6iLFHaM3v/l92acOO8qjh1ZiRzw/brxSHgyQ4rbmMf8U6lWmJh8ui8RRaMOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762167083; c=relaxed/simple;
	bh=B0cHjriIBMh1SSKqgx3nm6MTOEflDcrUh2B2ywBWHlk=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=sCZx4jMvlU52eJlG9v/px6CeiyFhl0W0O62+uMVId9MUOo9+yXlLtYWtDpX6ek/QJ+r2grpNVs1xW9LQP3YnNUPuFYmStBTtGU4sv+v3dQrvD/Ova5uVK2o78hh0+wnNtG2GG3rqtgcR3Wa/24xcF+urLZABBGXTbx85RdU7LHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=calamity.inc; spf=pass smtp.mailfrom=calamity.inc; dkim=pass (2048-bit key) header.d=calamity.inc header.i=@calamity.inc header.b=QmMkJXe+; arc=none smtp.client-ip=79.135.106.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=calamity.inc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=calamity.inc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=calamity.inc header.i=@calamity.inc header.b="QmMkJXe+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calamity.inc;
	s=protonmail3; t=1762167076; x=1762426276;
	bh=B0cHjriIBMh1SSKqgx3nm6MTOEflDcrUh2B2ywBWHlk=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=QmMkJXe+DgLTC2jOf99MNqj6DX9f4+J6bFDDWKa9YORulm4mUdsq/4/R3bHMk1osK
	 SkGwfXsNirND7I5IZIeSlFV7fGgceTGz5msslX9RymWxiPB7ywaKx66sEnifbk81cO
	 atpbNp9t6KLBr9UasadOjT/DjA0wnoFfwTxRnkKuxarJQ0XAxpyG75BviGNKOvB4qa
	 q61hQjhPXiXet3kvW8fnTB+EFRMDjYEt0gHngmND81KCvMAcZn5nzCS937nUa2DLGh
	 hQoswA2XfTct9X4oDuZES9yqP7kmtqFfQzcoq3uOY5+xmdmMY294+e6fuF07EaHzxY
	 M0WyH2FWbxqrA==
Date: Mon, 03 Nov 2025 10:51:10 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: Sainan <sainan@calamity.inc>
Subject: git diff: --submodule=diff does not synergise with --name-only
Message-ID: <C6Lp4oh3zEx1R6wysONzY_opvR6SE1GVNIHwMp1tXuAp_ob7jehtLPbu7XguZdU6vQ_Djq7ADBHOLrn3g4am4brUiiS6yzwpDCjIK_QaR00=@calamity.inc>
Feedback-ID: 116374642:user:proton
X-Pm-Message-ID: 5b1d5bef109b1529f7e099b8875219c00dab9405
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi, I'm using Git v2.51.2.windows.1 but this bug may have existed as far ba=
ck as when --submodule=3Ddiff was introduced according to my research.

To reproduce this, you need a repository with a submodule which was changed=
 since a given tag, then it can be observed like so:

1. git diff --name-only --submodule=3Ddiff <tag> | wc -l
2. git diff --submodule=3Ddiff <tag> | grep "diff --git" | wc -l

You should notice a discrepency between the line counts because in the firs=
t case only the submodule path is listed, whereas in the second case it cor=
rectly recurses into the submodule and lists the files changed in those sub=
modules.

--=C2=A0Sainan
