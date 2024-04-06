Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0563017C2
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 00:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712362147; cv=none; b=CEYaACVgxRmZG7DNHHPBChfISOyOZ6+PD156v0xkMbtFqhs3FQMK5c1ftZ2rJoV3lV05euC1M9nlnSC+J590N38KgIVZ+a6vaSsmOGZ3UXgv7Gk/sjx+o5n4XmRt5c5kwTr2radezLM9AJ86luqVHnVrTss/y/A1mQYKSjvF4a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712362147; c=relaxed/simple;
	bh=hYJYIGfx0i4ouBx+0HcdDjm/tWOC+Pg7EEhkgp1Ts78=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=T6aIV2IHT+w8F2ievegE5l1JKa5gD8DSHDHJD62xsVvbBXtC8ms/BMy17UySj0uKaBaH0ATFwwg16YckW8GETLoas9Jxb8bk3/c/cbfj4xulpjG+dAkL1wFqQtNMJf0QN4NtosxmfF4mtLGbi6EJfE+6zeqIhYrjhPHB9EADyfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NzJC9jXR; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NzJC9jXR"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DE7D51F28AD;
	Fri,  5 Apr 2024 20:09:04 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-transfer-encoding;
	 s=sasl; bh=hYJYIGfx0i4ouBx+0HcdDjm/tWOC+Pg7EEhkgp1Ts78=; b=NzJC
	9jXRyjWjDxt0f6iwEm0k80//LwVLASSBie6aNfx0hFnMizGUvZ/HZ9Kvn30wBqs8
	7i0Co5r9uDjeNVtU68eJlM5PVVUYEuNSJJ5D83m3rJDI7NjDhBhb6lVDlcELLwsK
	VRPr1nH7HdX3oYfoff/xP+YpgBnMBSkhOlHhiIQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D6AC61F28AC;
	Fri,  5 Apr 2024 20:09:04 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 40BB01F28AB;
	Fri,  5 Apr 2024 20:09:04 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 0/6] local VAR="VAL"
Date: Fri,  5 Apr 2024 17:08:56 -0700
Message-ID: <20240406000902.3082301-1-gitster@pobox.com>
X-Mailer: git-send-email 2.44.0-501-g19981daefd
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 E0DED5BE-F3A9-11EE-9459-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

* Update coding guidelines and test-lint script so that we quote the
  right hand side of assignment used with "local", which is buggy on
  certain versions of dash.

The first patch is not about the theme of the topic, but to document
a rule enforced by the test-lint script that is not written down in
the coding guidelines.

The second patch gives guidance to avoid the dash bug.

Patches [3/6], [4/6], and [5/6] are to adjust the existing tests. I
think many of them are currently safe because the values they assign
are $IFS safe, but some may be real workarounds for the dash bug.

The last patch introduces the test-lint pattern.

Junio C Hamano (6):
  CodingGuidelines: describe "export VAR=3DVAL" rule
  CodingGuidelines: quote assigned value in 'local var=3D$val'
  t: local VAR=3D"VAL" (quote positional parameters)
  t: local VAR=3D"VAL" (quote command substitution)
  t: local VAR=3D"VAL" (quote ${magic-reference})
  t: teach lint that RHS of 'local VAR=3DVAL' needs to be quoted

 Documentation/CodingGuidelines | 20 ++++++++++++++++++++
 t/check-non-portable-shell.pl  |  2 ++
 t/lib-parallel-checkout.sh     |  2 +-
 t/t2400-worktree-add.sh        |  2 +-
 t/t4011-diff-symlink.sh        |  4 ++--
 t/t4210-log-i18n.sh            |  4 ++--
 t/test-lib-functions.sh        | 12 ++++++------
 7 files changed, 34 insertions(+), 12 deletions(-)

--=20
2.44.0-501-g19981daefd

