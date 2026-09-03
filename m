Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3545F3955EB
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 18:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788461117; cv=none; b=Sg22pp2xkDwv8I4McPAQejcKxcX4Cay4f4ZiaLlaUfvkBgTakhjFM5fOwWbPHBaly+bHBZu9xMmpafjKG2jh4Fbrgp6t/WohcJDPOkULrObAxhLwxO6I7LhLG21OgnjKy8mZsBHlUtZ5JSu/NsFVpIqyXm9sgoet7nUuPsjnxcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788461117; c=relaxed/simple;
	bh=UHBMe94+L4jPSut5GiHGc1jGbEFRUWbzd2GDDHSBuqg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=MpegOkM2GW0hV8Hg+5chp9fFGhfAC+zxzc5ID+5HLB2XiU48Gq2hjIKUKejlb6Z4fG+d4GUnKK4LpUF6yOGqVYjzdGbxuujC/SRXbTHMWlBf8uqmwaw79pyAd04dX8vzG6FGh8pmeRmOuEell8M474uc48WfzEPtn2gkMX9lxnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ytausch.de; spf=pass smtp.mailfrom=ytausch.de; dkim=pass (2048-bit key) header.d=ytausch.de header.i=@ytausch.de header.b=wTMX5qS1; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ytausch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ytausch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ytausch.de header.i=@ytausch.de header.b="wTMX5qS1"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hbT6v4lM0zMlNv;
	Thu, 03 Sep 2026 20:45:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ytausch.de; s=MBO0001;
	t=1788461111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NKxMrAucIekyVmchIeFZ2rY9ZtdERNTRs1IKHb7OZy0=;
	b=wTMX5qS1YigJOpLK2mq+GItNdGH02f3Bh7ib2nzob4VKNDaM3M+sn3cSahzWijvyjtU11r
	y6PEYJ8WjULvYcgJbdpzByAhvS7B/f4m/KfSUOFQUDhdU/5cZwgaQdPzXYtflNtQTPcIKe
	Pfogqf4L40Iyr9N3YBzNufIDcJAY36jy+Blp3wCyk22sL1aNATPQWnEu+JSz1sLm0a+qZx
	KyXNhZdZzcSuMXfvUS7jNQlBdpHPpO9LO0W35lR/JsrwpsO9uDmGtLqnWEcA93je2pmPgA
	Ve4xDC/3vayh4SWv5ppRQeOij1Xz7NcNdERHmZ2f7eSquwfPKkGmL53vguXiTg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of dev@ytausch.de designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=dev@ytausch.de
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: [PATCH v3 2/3] dir: do not apply prefix to negative pathspecs
From: Yannik Tausch <dev@ytausch.de>
In-Reply-To: <887D6D84-F76E-4DCB-9633-CD78DA02BCC5@ytausch.de>
Date: Thu, 3 Sep 2026 20:45:00 +0200
Cc: Junio C Hamano <gitster@pobox.com>,
 dc@diogocastro.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <A1808378-5CC7-4809-B7D6-2F420306339B@ytausch.de>
References: <AA085B7A-F528-458A-8AA9-7664480997AE@ytausch.de>
 <xmqqecfbk2eb.fsf@gitster.g>
 <81EC0E28-13E7-4D10-BD07-3601124CBD77@ytausch.de>
 <886A25E6-8854-4AF6-BF0B-CFB57B673026@ytausch.de>
 <887D6D84-F76E-4DCB-9633-CD78DA02BCC5@ytausch.de>
To: git@vger.kernel.org
X-Rspamd-Queue-Id: 4hbT6v4lM0zMlNv

common_prefix_len() derives the common prefix solely from positive
pathspecs, skipping those marked with PATHSPEC_EXCLUDE. However,
match_pathspec_with_flags() also passes that prefix when matching the
negative pathspecs.

A negative pathspec may be shorter than the prefix. In that case,
match_pathspec_item() advances item->match beyond its allocation and
subtracts the prefix from item->len, producing a negative matchlen. It
then dereferences the out-of-bounds pointer. If the resulting byte is
not NUL, matchlen is converted to size_t when passed to ps_strncmp(),
which may cause a much larger out-of-bounds read.

The problem can be reproduced with AddressSanitizer:

    make SANITIZE=3Daddress CFLAGS=3D"-g -O0" git
    git init test &&
    cd test &&
    DIR=3D$(printf "a%.0s" {1..150}) &&
    mkdir -p "$DIR" &&
    touch "$DIR/f.txt" &&
    git add -A &&
    git commit -m test &&
    ../git ls-files -- "$DIR/" ":(exclude)xy"

This reports a heap-buffer-overflow. Without AddressSanitizer, the
output may depend on the contents of memory following the negative
pathspec.

Fix the bug by using a zero prefix when matching negative pathspecs.
Add a regression test that combines a positive pathspec with a longer
common prefix and a shorter, unrelated negative pathspec.

Signed-off-by: Yannik Tausch <dev@ytausch.de>
---
 dir.c                       | 2 +-
 t/t6132-pathspec-exclude.sh | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 95d8a1cce9..7072715389 100644
--- a/dir.c
+++ b/dir.c
@@ -593,7 +593,7 @@ static int match_pathspec_with_flags(struct =
index_state *istate,
 	if (!(ps->magic & PATHSPEC_EXCLUDE) || !positive)
 		return positive;
 	negative =3D do_match_pathspec(istate, ps, name, namelen,
-				     prefix, seen,
+				     0, seen,
 				     flags | DO_MATCH_EXCLUDE);
 	return negative ? 0 : positive;
 }
diff --git a/t/t6132-pathspec-exclude.sh b/t/t6132-pathspec-exclude.sh
index 9fdafeb1e9..ad919cc739 100755
--- a/t/t6132-pathspec-exclude.sh
+++ b/t/t6132-pathspec-exclude.sh
@@ -183,6 +183,15 @@ EOF
 	test_cmp expect actual
 '
=20
+test_expect_success 'negative pathspec shorter than positive pathspec =
prefix' '
+	git ls-files -- sub/sub/ ":(exclude)sub2" >actual &&
+	cat <<-\EOF >expect &&
+	sub/sub/file
+	sub/sub/sub/file
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'multiple exclusions' '
 	git ls-files -- ":^*/file2" ":^sub2" >actual &&
 	cat <<-\EOF >expect &&
--=20
2.55.0

