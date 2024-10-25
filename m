Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C9220EA27
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 20:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729889875; cv=none; b=WPMrbEkgjLrMafAN1JmZ3/cK136pGfLRpWb/bxg7JHoW2F46KXk/AAeU/uSG5TiDh2dNhfZvK6yIVqyg43qJVrVAyxFucmoD2yk8fazyOAatL2niGBFdL8E/W6XS1PVxG8J2mF5ggw6Aj27NuoySp+YdZhqkZiQ8vNF3DGhVyt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729889875; c=relaxed/simple;
	bh=XTl0nfODBot2Eb0c1Ey4Yy1aruGS9AL3nbHrfixvIxs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M96nDgQ4ljr7HkvU7ZjGYhC92/ab1LcZhyhEB7zQtOgPIgUyc4qDmF6dpRKQwNkAgIQQWUISyXexl512+w9Q+0/x+jhNXCgmDFGT8ofXb3S8E6F3Ip0rnzpQ+tKomh9KQSxLn7bl2RjXPEKBD4+FpwTNdJMh8KLTti9MRO0D8sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=D/B3xrJY; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="D/B3xrJY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1729889871; x=1730149071;
	bh=Io6mCsVlP/8Mvzo8Ou8I0J9BJuWiZ/nllFdNrw1viv8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=D/B3xrJYpxX51REOqTQOHveuwAADqeLATpIQyJZsOurVK8/kgduwYSTd+4VUl0zST
	 L4NHyudnbx65bgU5gcH2Q/r/brnE+iLc5gjVan/IvcFsBYuMQQQAT9Fzi/057vpDfh
	 wYU0uitYzWPX2YsSUvUBc9e1uF6rlRzsyyd9jioyn9aLlWEJ2dY3iIYhv5dpNKKClE
	 y5zRkXbTG9WNX4efN+vWGP1jndrDeU8FiAVPzwKpUn1a/+0bhub5hYYKkZswsVIX/H
	 IEAqj8DwgtCYjON2njvc0ZE9Z7ddw7t9XsmnJjjfcsqOnGrpjTrzU6ZgxUOJW0iYJZ
	 DzMwuoRIGzoFg==
Date: Fri, 25 Oct 2024 20:57:46 +0000
To: git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>, Phillip Wood <phillip.wood123@gmail.com>, shejialuo <shejialuo@gmail.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Caleb White <cdwhite3@pm.me>
Subject: [PATCH v3 4/5] worktree: add test for path handling in linked worktrees
Message-ID: <20241025-wt_relative_paths-v3-4-8860a5321c01@pm.me>
In-Reply-To: <20241025-wt_relative_paths-v3-0-8860a5321c01@pm.me>
References: <20241025-wt_relative_paths-v3-0-8860a5321c01@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: ac67440ae3b5945a098a07d76d3393945470e6a2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

A failure scenario reported in an earlier patch series[1] that several
`git worktree` subcommands failed or misbehaved when invoked from within
linked worktrees that used relative paths.

This adds a test that executes a `worktree prune` command inside both an
internally and an externally linked worktree and asserts that the other
worktree was not pruned.

[1]: https://lore.kernel.org/git/CAPig+cQXFy=3DxPVpoSq6Wq0pxMRCjS=3DWbkgdO+=
3LySPX=3Dq0nPCw@mail.gmail.com/

Reported-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Caleb White <cdwhite3@pm.me>
---
 t/t2401-worktree-prune.sh | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/t/t2401-worktree-prune.sh b/t/t2401-worktree-prune.sh
index 71aa9bcd620f8a504fe628a2d7332d8b47fd4701..5eb52b9abbf29514dc082c260eb=
b7a5e8e63aae0 100755
--- a/t/t2401-worktree-prune.sh
+++ b/t/t2401-worktree-prune.sh
@@ -120,4 +120,24 @@ test_expect_success 'prune duplicate (main/linked)' '
 =09! test -d .git/worktrees/wt
 '
=20
+test_expect_success 'not prune proper worktrees inside linked worktree wit=
h relative paths' '
+=09test_when_finished rm -rf repo wt_ext &&
+=09git init repo &&
+=09(
+=09    cd repo &&
+=09    git config worktree.useRelativePaths true &&
+=09    echo content >file &&
+=09    git add file &&
+=09    git commit -m msg &&
+=09    git worktree add ../wt_ext &&
+=09    git worktree add wt_int &&
+=09    cd wt_int &&
+=09    git worktree prune -v >out &&
+=09    test_must_be_empty out &&
+=09    cd ../../wt_ext &&
+=09    git worktree prune -v >out &&
+=09    test_must_be_empty out
+=09)
+'
+
 test_done

--=20
2.47.0


