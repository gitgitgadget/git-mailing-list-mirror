Received: from www555.your-server.de (www555.your-server.de [78.47.83.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550D23BBE7
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 20:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.83.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710881476; cv=none; b=Q3lu6NG9Tt0nZNqDdJIT5L2o7wOuSgdnfG4mcDl5dDg9AEoAtTlU87YkmGqObz820liaDDq+pIxu/M6GyNsbgjPkCD0JvpOQiADL70G1+1+0HtNlASQrCJa6EdaNAqU50Qn93w3JEV7xvWHmYWqMIeOKuGHISMtfAeY97COZXDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710881476; c=relaxed/simple;
	bh=dBtzWiwrPD6UQwokiTmREFzmlEPiCEyK5G4a9gEUheE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BK9UG6Ror9T/ekBJ5xr0qh55SkQXsCUzCT6r0IjQVlMNWrZHzPRPhud+cehcDrtcF4q/9MYBCbGnmppUSQw/VJ4VxmDIl6NjCMqfVORrfEU6Q/GTzmAp40yXgL5vx/hYxvc+KYv/Kl1KcuU+xaIoYqEX/X1jZa4Pzc9wsuLVSa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=x14.nl; spf=pass smtp.mailfrom=x14.nl; dkim=pass (2048-bit key) header.d=x14.nl header.i=@x14.nl header.b=UurZx2Pn; arc=none smtp.client-ip=78.47.83.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=x14.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=x14.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=x14.nl header.i=@x14.nl header.b="UurZx2Pn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=x14.nl;
	s=default2204; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=51R3lPf8qjolgdhorOcyWKSlN/cd/qNCcH/ols1ltLg=; b=UurZx2Pn0Cb2064UhP2nJ3zbvf
	1ViS9PXlS9LI0WZqzLDvHb2BwOYWc724o6iGPHeSODkIN9S9IL0EkZXp12yR04gKxMPXBsdrb7Tya
	G9wdk6xX0ssSC+eRRd1ZW2kZEKcqUoRzJpLSzAlog2nReeBNzx09qP3ogn03uEdAKwJ2PdldsCQax
	lwBaJwqMlcJrphCp0Um/+MEnEEF+O0lLKJHd4aCqOrb5T5SG11phpBiIzMIVSNwWQVR7XwpMxU5+3
	T5TnxgtxH1A6U9DF0yQ6WdpLAyh9WlgnyMaWBfTD2YkosqWEGLc5RZAIArKTnPML5hH6xcM6K2D+J
	ALJq8wdg==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www555.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mb@x14.nl>)
	id 1rmg98-000O8u-P5; Tue, 19 Mar 2024 21:33:18 +0100
Received: from [2a02:a44b:9e0c:1:343a:5235:74e3:373a] (helo=foaf.home.x14.nl)
	by sslproxy07.your-server.de with esmtpa (Exim 4.96)
	(envelope-from <mb@x14.nl>)
	id 1rmg98-000Boc-1p;
	Tue, 19 Mar 2024 21:33:18 +0100
From: "Michiel W. Beijen" <mb@x14.nl>
To: git@vger.kernel.org
Cc: justinrdonnelly@gmail.com,
	"Michiel W. Beijen" <mb@x14.nl>
Subject: [PATCH] git-prompt: GIT_PS1_SHOWCONFLICTSTATE variable fix
Date: Tue, 19 Mar 2024 21:32:44 +0100
Message-ID: <20240319203244.799796-1-mb@x14.nl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: mb@x14.nl
X-Virus-Scanned: Clear (ClamAV 0.103.10/27219/Tue Mar 19 09:25:53 2024)

There are a few environment variables that can influence the output for
the __git_ps1 macro in git-prompt.sh. All settings that are 'on/off'
types such as GIT_PS1_SHOWUNTRACKEDFILES and GIT_PS1_SHOWDIRTYSTATE
just take any value, and in the tests are tested with 'y', however
GIT_PS1_SHOWCONFLICTSTATE must be set to 'yes' otherwise it will not
work.

This commit changes that behaviour, and makes sure
GIT_PS1_SHOWCONFLICTSTATE is consistent with these other parameters.

Signed-off-by: Michiel W. Beijen <mb@x14.nl>
---
 contrib/completion/git-prompt.sh | 6 +++---
 t/t9903-bash-prompt.sh           | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 71f179cba3..fd6141e463 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -85,8 +85,8 @@
 # by setting GIT_PS1_OMITSPARSESTATE.
 #
 # If you would like to see a notification on the prompt when there are
-# unresolved conflicts, set GIT_PS1_SHOWCONFLICTSTATE to "yes". The
-# prompt will include "|CONFLICT".
+# unresolved conflicts, set GIT_PS1_SHOWCONFLICTSTATE to a nonempty
+# value. The prompt will include "|CONFLICT".
 #
 # If you would like to see more information about the identity of
 # commits checked out as a detached HEAD, set GIT_PS1_DESCRIBE_STYLE
@@ -528,7 +528,7 @@ __git_ps1 ()
 	fi
 
 	local conflict="" # state indicator for unresolved conflicts
-	if [[ "${GIT_PS1_SHOWCONFLICTSTATE}" == "yes" ]] &&
+	if [ -n "${GIT_PS1_SHOWCONFLICTSTATE-}" ] &&
 	   [[ $(git ls-files --unmerged 2>/dev/null) ]]; then
 		conflict="|CONFLICT"
 	fi
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index d667dda654..6479a0d898 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -769,7 +769,7 @@ test_expect_success 'prompt - conflict indicator' '
 	test_when_finished "git reset --hard HEAD~" &&
 	test_must_fail git stash apply &&
 	(
-		GIT_PS1_SHOWCONFLICTSTATE="yes" &&
+		GIT_PS1_SHOWCONFLICTSTATE=y &&
 		__git_ps1 >"$actual"
 	) &&
 	test_cmp expected "$actual"

base-commit: 3bd955d26919e149552f34aacf8a4e6368c26cec
-- 
2.43.0

