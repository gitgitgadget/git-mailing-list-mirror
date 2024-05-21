Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06A551C27
	for <git@vger.kernel.org>; Tue, 21 May 2024 20:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716324312; cv=none; b=NdDk93nlww2crKppEqtGcAP7ds6JWk7rE+qOgu6t0AtGh7x70HO2lSJJHIFcILP3YNMRRYN+ciycu4kV1AvY5lz1bAdSyyHo6cWIAr2aAlyfa2j+zVxCIgkaOUTaGm6aL6D2ouqzY/+YgdVMSFWsbWrlwRdxG4uHacDkhOqvuKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716324312; c=relaxed/simple;
	bh=DIv4DhJ6/tv/xw5azVW2PBHi82q80nyDHI+i4fWaCBA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kSYBeX2CjCnymgEnrv5hihBlgy1WmpmLy8zxXqvh8+xfVdjhiwHPuq0hAQsrWsqydMondYnsA6H68ybzvew7JCp7hSe62jiYeuFHsfOoqWDOsjRRgEL4O6B8kpjhYbXXYIlmLwirBwZRalNBAjWCuG2+xfiqIwd3IMMcm2yOhz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=lq9efm1W; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lq9efm1W"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 80266315ED;
	Tue, 21 May 2024 16:45:09 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=DIv4DhJ6/tv/xw5azVW2PBHi8
	2q80nyDHI+i4fWaCBA=; b=lq9efm1Wigc0ZmUn/k3DKMA5ueC38/xUp4wotpoZm
	rh6Qllhhrq+leEdKVfjPj6TsPaxOTcfZ+MFmX58LrZ1ltq6g+UBrqRfXA0jSTsAP
	j0eEvq+Fu++haTgbuQNJ9a3/Rpi8+nw2/4nlNiNZDV4nBO0b/j+YOFVC+lvJSyie
	+o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6EEE1315EC;
	Tue, 21 May 2024 16:45:09 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 726F9315EA;
	Tue, 21 May 2024 16:45:08 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [rPATCH 13/12] Merge branch 'jc/fix-aggressive-protection-2.39'
Date: Tue, 21 May 2024 13:45:06 -0700
Message-ID: <20240521204507.1288528-1-gitster@pobox.com>
X-Mailer: git-send-email 2.45.1-216-g4365c6fcf9
In-Reply-To: <20240521195659.870714-1-gitster@pobox.com>
References: <20240521195659.870714-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 02C57AF2-17B3-11EF-9AB3-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

This is "git show --remerge-diff" of the result of adjusting the
jc/fix-aggressive-protection-2.39 topic (which you just saw) into
maint-2.40 track.
The result is called jc/fix-aggressive-protection-2.40.

It is not for direct consumption by "git am".

If this format looks reasonable to folks as a way to review the result
of merging up fixes, I'll follow up with "patches" for more recent
maintenance tracks.

diff --git a/builtin/clone.c b/builtin/clone.c
remerge CONFLICT (content): Merge conflict in builtin/clone.c
index 17d34efebd..399b2d3f42 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1447,15 +1447,8 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 	free(unborn_head);
 	free(dir);
 	free(path);
-<<<<<<< b9b439e0e3 (Git 2.40.2)
 	free(repo_to_free);
-	free(template_dir_dup);
-||||||| 47b6d90e91
-	free(template_dir_dup);
 	UNLEAK(repo);
-=3D=3D=3D=3D=3D=3D=3D
-	UNLEAK(repo);
->>>>>>> 9074ec92e7 (Revert "fetch/clone: detect dubious ownership of loc=
al repositories")
 	junk_mode =3D JUNK_LEAVE_ALL;
=20
 	transport_ls_refs_options_release(&transport_ls_refs_options);
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
remerge CONFLICT (content): Merge conflict in t/t1800-hook.sh
index edf0fa1334..3506f627b6 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -177,7 +177,6 @@ test_expect_success 'git hook run a hook with a bad s=
hebang' '
 	test_cmp expect actual
 '
=20
-<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< b9b439e0e3 (Git 2.40.2)
 test_expect_success 'stdin to hooks' '
 	write_script .git/hooks/test-hook <<-\EOF &&
 	echo BEGIN stdin
@@ -196,37 +195,4 @@ test_expect_success 'stdin to hooks' '
 	test_cmp expect actual
 '
=20
-test_expect_success 'clone protections' '
-	test_config core.hooksPath "$(pwd)/my-hooks" &&
-	mkdir -p my-hooks &&
-	write_script my-hooks/test-hook <<-\EOF &&
-	echo Hook ran $1
-	EOF
-
-	git hook run test-hook 2>err &&
-	grep "Hook ran" err &&
-	test_must_fail env GIT_CLONE_PROTECTION_ACTIVE=3Dtrue \
-		git hook run test-hook 2>err &&
-	grep "active .core.hooksPath" err &&
-	! grep "Hook ran" err
-'
-
-|||||||||||||||||||||||||||||||| 47b6d90e91
-test_expect_success 'clone protections' '
-	test_config core.hooksPath "$(pwd)/my-hooks" &&
-	mkdir -p my-hooks &&
-	write_script my-hooks/test-hook <<-\EOF &&
-	echo Hook ran $1
-	EOF
-
-	git hook run test-hook 2>err &&
-	grep "Hook ran" err &&
-	test_must_fail env GIT_CLONE_PROTECTION_ACTIVE=3Dtrue \
-		git hook run test-hook 2>err &&
-	grep "active .core.hooksPath" err &&
-	! grep "Hook ran" err
-'
-
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 9074ec92e7 (Revert "fetch/clone: detect=
 dubious ownership of local repositories")
 test_done
