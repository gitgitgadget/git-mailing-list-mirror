Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D7A15F3FF
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 21:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717622849; cv=none; b=Ti3e6QEfmae5N7IU2znFkHVWSQi06BuHJeNUHFLJAO9I8ErUuADj9DVeatY6/WSafJU7IiiPSqtSJNWE2BIJLywV+IwXmA8HjIxjZA78U03tx8fz/aAquTHJ85Tdg3ehW729Ve7IhTeSbSY8739RKzkRJGOTZi/IMCymC4IR+zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717622849; c=relaxed/simple;
	bh=qYTfd1e09XiS4WxvWsg+y6thRij959FL47JWmgXypb8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GN13L2d5AMN+3vMoNbxZ16WW2vA08tNGS62F0yZKQiYCo5RZDJVa4GLT70bdFdksZCzFoOYb9as7bNB/07N4rfOtiO9IqBQ0q5z9IY2ZgFy6xcyMqrD90dcdVN+682sau4kqdX0WSjNL+Gx1jLW87Jj2JF+WntiaPl5qWZMvv8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q01M0a/7; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q01M0a/7"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 79BAF1CE46;
	Wed,  5 Jun 2024 17:27:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=q
	YTfd1e09XiS4WxvWsg+y6thRij959FL47JWmgXypb8=; b=Q01M0a/7lS2LC4Qp6
	sYz1glYCrPBlmaZevevIP0EKCIRv1t2NB3r2HdBQ/gdkgckaVgGYDRy4pTaK/sGy
	xkeg8BuYxr+CzigrERwFYCY05l+2cPC2aw20qnbfD520+W8Aq6hItp0f+FijEY7u
	DgbdJre0gsrqXv7ngu4LQFpUI4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7390E1CE45;
	Wed,  5 Jun 2024 17:27:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0999F1CE44;
	Wed,  5 Jun 2024 17:27:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] add-i: finally retire add.interactive.useBuiltin
Date: Wed, 05 Jun 2024 14:27:21 -0700
Message-ID: <xmqqikynqdvq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 65B054C2-2382-11EF-9862-ACC938F0AE34-77302942!pb-smtp20.pobox.com

The configuration variable stopped doing anything (other than
announcing itself as a variable that does not do anything useful,
when it is used) in Git 2.40.  

At this point, it is not even worth giving the warning, which was
meant to be a way to help users notice they are carrying unused
cruft in their configuration files and give them a chance to
clean-up.

Let's remove the warning and documentation for it, and truly stop
paying attention to it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
               ---
 Documentation/config/add.txt |  6 ------
 builtin/add.c                |  6 +-----
 t/t3701-add-interactive.sh   | 15 ---------------
 3 files changed, 1 insertion(+), 26 deletions(-)

diff --git c/Documentation/config/add.txt w/Documentation/config/add.txt
index e0354ceaed..4d753f006e 100644
--- c/Documentation/config/add.txt
+++ w/Documentation/config/add.txt
@@ -5,9 +5,3 @@ add.ignore-errors (deprecated)::
 	option of linkgit:git-add[1].  `add.ignore-errors` is deprecated,
 	as it does not follow the usual naming convention for configuration
 	variables.
-
-add.interactive.useBuiltin::
-	Unused configuration variable. Used in Git versions v2.25.0 to
-	v2.36.0 to enable the built-in version of linkgit:git-add[1]'s
-	interactive mode, which then became the default in Git
-	versions v2.37.0 to v2.39.0.
diff --git c/builtin/add.c w/builtin/add.c
index 3dfcfc5fba..40b61ef90d 100644
--- c/builtin/add.c
+++ w/builtin/add.c
@@ -150,11 +150,7 @@ static int refresh(int verbose, const struct pathspec *pathspec)
 int interactive_add(const char **argv, const char *prefix, int patch)
 {
 	struct pathspec pathspec;
-	int unused, ret;
-
-	if (!git_config_get_bool("add.interactive.usebuiltin", &unused))
-		warning(_("the add.interactive.useBuiltin setting has been removed!\n"
-			  "See its entry in 'git help config' for details."));
+	int ret;
 
 	parse_pathspec(&pathspec, 0,
 		       PATHSPEC_PREFER_FULL |
diff --git c/t/t3701-add-interactive.sh w/t/t3701-add-interactive.sh
index 6624a4f7c0..5d78868ac1 100755
--- c/t/t3701-add-interactive.sh
+++ w/t/t3701-add-interactive.sh
@@ -43,21 +43,6 @@ force_color () {
 	)
 }
 
-test_expect_success 'warn about add.interactive.useBuiltin' '
-	cat >expect <<-\EOF &&
-	warning: the add.interactive.useBuiltin setting has been removed!
-	See its entry in '\''git help config'\'' for details.
-	EOF
-	echo "No changes." >expect.out &&
-
-	for v in = =true =false
-	do
-		git -c "add.interactive.useBuiltin$v" add -p >out 2>actual &&
-		test_cmp expect.out out &&
-		test_cmp expect actual || return 1
-	done
-'
-
 test_expect_success 'unknown command' '
 	test_when_finished "git reset --hard; rm -f command" &&
 	echo W >command &&
