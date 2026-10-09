Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81F24F7982
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 18:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791569411; cv=none; b=hRvBtsmLvIDROkguhp3tw5kjuaZvgGsC3G+cUQyiWubktGEU9wcBt6wDI4R1rFw1hvivcGQEB1VDrUR420tXrauE2Pd4mF3JrYZ6xxCjXGjDPsuEdCa43sd/RTZAIOuK/MCtgaZBOdviVQSFO3D51mJ3GSrv5/EgpS87mnolao4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791569411; c=relaxed/simple;
	bh=zJkAGRlWsiqyNtDrlYP8gH7u8QVnkUgl/4GlUnzagmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KaQ2tyHVB8ol/JwaDevZd+Iu19/nSneD9g5RkISkb6sIhFljusEgrrKy8Buc4CK30LSMYD0iUiUNcvEeD4lZc8XOcnWuoF2fi8qLbiht7BhKew/52o3gsXIPvmMWefusg48Lq5ttr5qZgkQR1UZ0hEJEA03nTelyZ72CxViHLZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Q68caRw/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HgcxI0cT; arc=none smtp.client-ip=202.12.124.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Q68caRw/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HgcxI0cT"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id 04B531300F27
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 14:10:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 09 Oct 2026 14:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1791569408; x=
	1791573008; bh=SgpgLpjEbit3sBRnC6QTnGNVpZTkLSojEp/9lBHDQoY=; b=Q
	68caRw/6K7wdtUnVZF1PKerPOKzEbX8EAVJyzmBH9E03wuB7AYfQxSiV7kXBaS7H
	uwlt0amHxC+g9vbueVZ3Qkl6a8dDh0/8ArgETMY/GWpS07DZBC4ShAvqdeYYiP/q
	jA9lMliqCXm+nCoTKbGXmM2wqZ5Pvv2PWJwvNgLxxX5/9Fr1fD/d9R40P+HzASjb
	9U/hI+bEYSc7dBktE8aVtjqq+9uLflMH6gNQUS7jAft+XmH8y814yYNoQRQVEWcL
	nDcUWjdpq61capaaysjOR/ezQS/9i3vRXhsN9MK/a0fwfp2gxWGMe4Cmn55S+ev+
	yKn/X7DctlfN9WH+JEMlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1791569408; x=1791573008; bh=S
	gpgLpjEbit3sBRnC6QTnGNVpZTkLSojEp/9lBHDQoY=; b=HgcxI0cTC5fnqoNJ3
	FayUkwVY+QKX+zO49FIpRFa89pe6+JNC8a0f9k7JVsckLvf9fJnOJeMWXFrs91pX
	Cl10D7r7mXgZi7iOCDQ9o76ZdQ4HSXKQ+SS/W3seCsslIjosf0XN6UcjQ7yuSrBg
	UTYPkZdz9KgHmrx7Gvg/pKneZtfJNuIsevykWuymyFtHmqtLbXxsWFffp0TA6pGd
	fwGYXyfBhq3tLKieKmR9y2urKIi51Do4B3tsyTP0SeDh/M3+q8GyvKEPdgoHB7KZ
	xUiPR4c3/McIWWYC+xSMWBs7KDf9FmsWb93tb4D0bWWZ2vK4D/R7kKFtgR6Eq+Bx
	mLGog==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791569408; d=fastmail.com;
	mf=PG1hcmtjaHVjYXJyb2xsQGZhc3RtYWlsLmNvbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:l3r1dmGerOVjC2wi+BGNikOCzWqOwp4S4hd2asCCh554jNb
	rpAJcVcodaxzoLbVl17ZbGG+meT18knl9RSojA27aVsXw1PDAs7WczP3y06R4Jtg
	YgYQH4JH4jGjuLyXGQFQYOlDxjTSBjXkyzrGzbSk1nrd7zEYoPICJCgIWa+YiXnk
	dNihL6KxZsyyE6wFXomVrBMoDdxVS+NKuenZZJ01KXPdUB+ce+npNomjEzj1DJqa
	xqGv6pGAUxanhEuwRnRN+wkwRzx6NF/waiwqoADlPRF6Mx22gHFXoD2K8CTqoxfM
	3nnAsRbYI39psBDCOtW4yEzC0qLlMU9jNu3+z2Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:9TBhEMKKtDwn2PiYjfz4qmZ0jVya8x1/n8BeEASMKAk=:zJkAGRlWsiqyNtDrlYP8gH7u8QVnkUgl/4GlUnzagmc=;
X-ME-Sender: <xms:AC7Jao7XQPtMCqSMo1FQ8HCt0He049ctbVUCVKn6_1dFmO2y7ycbnw>
    <xme:AC7Jag4cXHoqIgXGFmUCuB9B2w8_I5BiYCsDlDM8MZ-m1kbpexMDaTcHmbveVFLYk
    UdeDVDWW261ul4h838QEtHlPIbOOwESputtwzwLqd-QJTUpUBpNpkQ>
X-ME-Received: <xmr:AC7JaseTPkkruNlEuY0vT0QXGwpWG1B9cBIx_ushJ4l-_t0VM4XIsju4VjJjz-TPGZGOtWal_myrUE1eTnlq_3PWmb2fHYxAEkqtXykagxhQT42wIPipxZCuWntp9U8z3VAt5nYbqXk_ZnlXBuEi>
X-ME-Proxy-Cause: dmFkZTGvrWrBqoNo/SGmDMChYQVxAQK1vuW2zvi/SyW6vEyDefe0kXikfbNtQSiyJre3Vs
    Pak99tUzUmRHJljeBr6NGr/dYaq5PcxPUzapGW8wOcXRqM0VS/gpDF3W03XiqGpmAfbgmn
    Y3D/xKgdACj3+ZVIjDdmM8e+sEitBsye1tUJ8vvqTUay/S+y5lex6nC/LurPbySnqtU1P/
    zsRvkXqI1QfYLKJDDnAcu28beqETaje9kmBJnijlK6rX5oRyjbhSm/94KE0opPRNTU2NnR
    TyBxu7Kq36pFVOzB/E6J9fKOuktElS284kj4fTWjKMhxPQ8maqad2lVRlDiFRaMwlav5o6
    cuOjLRoivhhvOM8uDq0aBABOTZHmamMCJlEeZVxBFvmnmyo/8v2uV4geRmLaoO2N5imsPy
    b/ZND+4D1bhmG61fGwVDGNlw5x89bif5NBn49CX+bqbu0bzZ1kW0IaMEFOE8LeJRkBVyrz
    +uicgI44nRQJf1gGaQqlG5yFlrgmUZqq99rgq7yekmS4Od3bvb3UTuIJRETqMlKeedw7hg
    f9rYq9OMukiqB2vX9VV2W6QUjjYM7bnq7LOYH4vJi8bYCcJmjhx5PjgW9ItlDEjxVvvQ77
    Z9WDMtElK/e7Xdz6FmJGlh9rm618tVgggvVCeRCQaayZGPVh3u0CvotcqG3g
X-ME-Proxy: <xmx:AC7JasDD_Q68hc_rUpgWLFd4HC8ohpgdqEn_ih01GhlWftig9C3Stg>
    <xmx:AC7Jan8OLAKEHIoDhX8RKhn1qz7zB5_Nc69Y-RmOkFJtTVVMpi_gRA>
    <xmx:AC7JavKTck9QessnsLYfk2ZmS-9GX2UTvZXTg5cUlz_KUnUqD5OO3w>
    <xmx:AC7Jaoh9t4vThsfTPoXYSl4-oRtGlDp5zPqvR5xR81Lagr-KPNNEuQ>
    <xmx:AC7JavTH2ZcZYlUg9kwRPAdu7LaeOk2LA59qixKQtv78mkS5JKaO20xy>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 14:10:08 -0400 (EDT)
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com,
	ps@pks.im,
	"Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Subject: [PATCH v3 0/1] repo: add revision filtering options to "repo structure"
Date: Fri,  9 Oct 2026 14:09:50 -0400
Message-ID: <20261009180951.1628134-1-markchucarroll@fastmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924164503.119506-2-markchucarroll@fastmail.com>
References: <20260924164503.119506-2-markchucarroll@fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"git repo structure" provides a collection of useful information
about the information stored in a repo. In particular, it's
valuable for diagnosing performance issues caused by large objects
stored in a repo.

The current implementation of "git repo stucture" provides summary
information about everything in the repository - all of the
branches, remotes, tags, stashes, and notes. But sometimes
to properly diagnose a problem, it's useful to be able to get
information about the specific part of the repo that's exhibiting
a problem.

Add the option to specify a set of revs. If revs are included,
then the set of objects processed will be limited based on the
rev specification; otherwise, all objects will be processed.

Mark C. Chu-Carroll (1):
  repo: add revision filtering options to "repo structure"

 Documentation/git-repo.adoc     |  37 +++++-
 Documentation/git-rev-list.adoc |   2 +-
 Documentation/revisions.adoc    |   2 +-
 builtin/repo.c                  |  32 +++--
 revision.c                      |   2 +-
 revision.h                      |   2 +-
 t/t1901-repo-structure.sh       | 211 ++++++++++++++++++++++++--------
 7 files changed, 217 insertions(+), 71 deletions(-)

-- 
2.53.0

