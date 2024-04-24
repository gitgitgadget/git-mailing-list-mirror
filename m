Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E234156F52
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 21:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713995429; cv=none; b=EBZRx92JJUsgAyzikKEUsIYoaohYrA9Zg1Y+oitsdoxw7QBGFjec7xpejWTEQuHnRD9y0zaDKcP8o07QHyZ28tLVOC7vJ/lH+GrFcfpz09X82z6aM/xeZk+K4kW8rHdUvtTJaPPe32GZbqlr7DRd2djYaprwxUIpMpujUWpDb5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713995429; c=relaxed/simple;
	bh=mwR3HlXmzQQUgemlemex+YzuuijjqbRwdLnDfCzSyjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=soD0paCwN1MN6cUBAc6zY3IO4z+4bU0ZubE9plY7jfBZTQ5Y6zHOg9OMR+DXM+gFig0sdmRviZjR1cQ1S1bRRownKxMDZ/AuKX3ITTHB/W7oZhwTRLL8eKvvY0wcOo+je3jMXSFmCOTGbP8VM/58ispcYRHuQF1EPT3Z1S60zVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <rhi@pengutronix.de>)
	id 1rzkVV-0003DN-UK; Wed, 24 Apr 2024 23:50:25 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <rhi@pengutronix.de>)
	id 1rzkVV-00E9H7-55; Wed, 24 Apr 2024 23:50:25 +0200
Received: from rhi by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <rhi@pengutronix.de>)
	id 1rzkVV-0017qn-0L;
	Wed, 24 Apr 2024 23:50:25 +0200
From: Roland Hieber <rhi@pengutronix.de>
To: git@vger.kernel.org
Cc: Roland Hieber <rhi@pengutronix.de>,
	Denton Liu <liu.denton@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/2] completion: add 'symbolic-ref'
Date: Wed, 24 Apr 2024 23:50:17 +0200
Message-Id: <20240424215019.268208-1-rhi@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: rhi@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org

Even 'symbolic-ref' is only completed when
GIT_COMPLETION_SHOW_ALL_COMMANDS=1 is set, it currently defaults to
completing file names, which is not very helpful. Add a simple
completion function which completes options and refs.

Signed-off-by: Roland Hieber <rhi@pengutronix.de>
---
PATCH v2:
 - no changes

PATCH v1: https://lore.kernel.org/git/20240424210549.256256-1-rhi@pengutronix.de/
---
 contrib/completion/git-completion.bash | 11 +++++++++++
 t/t9902-completion.sh                  | 16 ++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 75193ded4bde..ffcc55484bcd 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3581,6 +3581,17 @@ _git_svn ()
 	fi
 }
 
+_git_symbolic_ref () {
+	case "$cur" in
+	--*)
+		__gitcomp "--delete --quiet --short --recurse --no-recurse"
+		return
+		;;
+	esac
+	
+	__git_complete_refs
+}
+
 _git_tag ()
 {
 	local i c="$__git_cmd_idx" f=0
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 569cf2310434..a34953da6c96 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2518,6 +2518,22 @@ test_expect_success 'complete tree filename with metacharacters' '
 	EOF
 '
 
+test_expect_success 'symbolic-ref completes short ref names ' '
+	test_completion "git symbolic-ref foo m" <<-\EOF
+	main Z
+	mybranch Z
+	mytag Z
+	EOF
+'
+test_expect_success 'symbolic-ref completes full ref names' '
+	test_completion "git symbolic-ref foo refs/" <<-\EOF
+	refs/heads/main Z
+	refs/heads/mybranch Z
+	refs/tags/mytag Z
+	refs/tags/A Z
+	EOF
+'
+
 test_expect_success PERL 'send-email' '
 	test_completion "git send-email --cov" <<-\EOF &&
 	--cover-from-description=Z
-- 
2.39.2

