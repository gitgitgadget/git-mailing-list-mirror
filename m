Received: from smtp-1a.his.com (dc-17.his.net [108.56.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4095D43A812
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 21:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.56.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787001911; cv=none; b=Aas645EOBqtT19yQwye7z4QkTtXqKUrA5i9tPTXoyVui7GrMMUXLbScC1UQPLpznylQX8aqbxLUqlDOG6X1ig7cnFw6NJNDAoQh3DtKTc+4KyDM9kx/1lwFtVj8Usye5fBFbJM73TfcY7Lwv1daVfcnujf/qV49M20yfe0zUmXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787001911; c=relaxed/simple;
	bh=HSaOf7M2OLp5y4w99+7qEv/kE0RoiNrSCmydqe9MaNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R/fnuPVGu/t95OlU2CYmpReTb+FUuvhjS+yT5LF9KcvEW0ChEKVckBq7ysGlqG2jeIRY6WjevD4+FL796kM/nRBKC+XsQirIpH+UXTQqTl+++OXsJBNdOU7N377xNbSssWNwJEn2Kip9JnM7XV73apkJ8vH7mYmq6LBLTTSQVf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=his.com; spf=pass smtp.mailfrom=his.com; arc=none smtp.client-ip=108.56.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=his.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=his.com
Received: from proxmail101.his.com (pgh-217.his.com [75.149.19.217])
	by smtp-1a.his.com (Postfix) with ESMTPS id 1E5D8568;
	Mon, 17 Aug 2026 17:19:57 -0400 (EDT)
Received: from proxmail101.his.com (localhost.localdomain [127.0.0.1])
	by proxmail101.his.com (Proxmox) with ESMTP id 9FC8ABC0E7F;
	Mon, 17 Aug 2026 17:19:56 -0400 (EDT)
Received: from smtp-4a.his.com (dc-25.his.net [108.56.65.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by proxmail101.his.com (Proxmox) with ESMTPS id 0BE55BC0D9F;
	Mon, 17 Aug 2026 17:19:56 -0400 (EDT)
Received: from mail2.his.com (ec2-3-149-70-92.us-east-2.compute.amazonaws.com [3.149.70.92])
	by smtp-4a.his.com (Postfix) with ESMTPS id 988E01C0F;
	Mon, 17 Aug 2026 17:19:55 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail2.his.com (Postfix) with ESMTP id 772973C1731;
	Mon, 17 Aug 2026 21:19:55 +0000 (UTC)
Received: from mail2.his.com ([127.0.0.1])
 by localhost (mail2.his.com [127.0.0.1]) (amavis, port 10032) with ESMTP
 id j3B0ynsuGwlg; Mon, 17 Aug 2026 21:19:55 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail2.his.com (Postfix) with ESMTP id 44B253C1738;
	Mon, 17 Aug 2026 21:19:55 +0000 (UTC)
X-Virus-Scanned: amavis at his.com
Received: from mail2.his.com ([127.0.0.1])
 by localhost (mail2.his.com [127.0.0.1]) (amavis, port 10026) with ESMTP
 id 3JfX7VchCnS3; Mon, 17 Aug 2026 21:19:55 +0000 (UTC)
Received: from wings.localdomain (unknown [69.53.104.42])
	by mail2.his.com (Postfix) with ESMTPSA id EE24C3C1731;
	Mon, 17 Aug 2026 21:19:54 +0000 (UTC)
From: Kenneth Lorber <keni@his.com>
To: git@vger.kernel.org
Cc: Kenneth Lorber <keni@his.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 1/1] config: surface editor failure in exit code
Date: Mon, 17 Aug 2026 17:19:33 -0400
Message-ID: <20260817211936.2943278-2-keni@his.com>
X-Mailer: git-send-email 2.55.GIT
In-Reply-To: <20260817211936.2943278-1-keni@his.com>
References: <20260817211936.2943278-1-keni@his.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SPAM-LEVEL: Spam detection results:  0
	AWL                     0.140 Adjusted score from AWL reputation of From: address
	BAYES_00                 -1.9 Bayes spam probability is 0 to 1%
	DMARC_PASS               -0.1 DMARC pass policy
	KAM_DMARC_STATUS         0.01 Test Rule for DKIM or SPF Failure with Strict Alignment
	SPF_HELO_NONE           0.001 SPF: HELO does not publish an SPF Record
	SPF_PASS               -0.001 SPF: sender matches SPF record
	URIBL_DBL_BLOCKED_OPENDNS  0.001 ADMINISTRATOR NOTICE: The query to dbl.spamhaus.org was blocked due to usage of an open resolver. See https://www.spamhaus.org/returnc/pub/ [t1300-config.sh]

Teach git config --edit to show editor failure to the
parent process.

Add 2 tests to t1300 to check editor exiting successfully
or failing.

Signed-off-by: Kenneth Lorber <keni@his.com>
---
 builtin/config.c  |  5 +++--
 t/t1300-config.sh | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 0882899c3f..a166b2131e 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -1291,6 +1291,7 @@ static int cmd_config_remove_section(int argc, cons=
t char **argv, const char *pr
 static int show_editor(struct config_location_options *opts)
 {
 	char *config_file;
+	int ret;
=20
 	if (!opts->source.file && !startup_info->have_repository)
 		die(_("not in a git directory"));
@@ -1313,10 +1314,10 @@ static int show_editor(struct config_location_opt=
ions *opts)
 		else if (errno !=3D EEXIST)
 			die_errno(_("cannot create configuration file %s"), config_file);
 	}
-	launch_editor(config_file, NULL, NULL);
+	ret =3D launch_editor(config_file, NULL, NULL);
 	free(config_file);
=20
-	return 0;
+	return ret;
 }
=20
 static int cmd_config_edit(int argc, const char **argv, const char *pref=
ix,
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index e3f8064889..9a8f852a86 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1823,6 +1823,24 @@ test_expect_success 'command line overrides enviro=
nment config' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'git config --edit successful exit' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	GIT_EDITOR=3Dtrue &&
+	export GIT_EDITOR &&
+	git -C repo config -e &&
+	unset GIT_EDITOR
+'
+
+test_expect_success 'git config --edit failure exit' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	GIT_EDITOR=3Dfalse &&
+	export GIT_EDITOR &&
+	test_must_fail git -C repo config -e &&
+	unset GIT_EDITOR
+'
+
 test_expect_success 'git config --edit works' '
 	git config -f tmp test.value no &&
 	echo test.value=3Dyes >expect &&
--=20
2.43.0


