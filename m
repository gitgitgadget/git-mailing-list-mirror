Received: from smtp-1a.his.com (dc-17.his.net [108.56.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860A12D8796
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 15:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.56.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787152182; cv=none; b=tc0eTOP9weMiRdyw1h368bfjp2a0z8OOyX5xMI/dKtsFLpjjvSCdaOmQVDNiIjUFZG6r4v5yiMpF+q2Wk6CcnkJyKU6M4KBQ16rYF38CFUoikxqNHWyAqm7BoYodEdzFwwLnsuMUKorPQ61ekLkEwRLnQh4HZD+KYd11iyR9ETA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787152182; c=relaxed/simple;
	bh=uPjWflKj1gYTtyF1ZbwwXlMGWlBtm2TS+SBP4tWdra4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aVhmOs/tjTgCvo0e0plNoOgmyAffCf6YCEfvNAB6CMnoTHcxXkgLOZ/wg/1fVA1M/xwoV81+jlW+wgurAZ6pab3uulwzzHQQklNkDn0fjT2VWCr2Bm23wpP50HS1qbdshg2mQQUU0GdRFfuUkvE9T4+SRYBiPsK7cNFUv6C0PBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=his.com; spf=pass smtp.mailfrom=his.com; arc=none smtp.client-ip=108.56.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=his.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=his.com
Received: from proxmail101.his.com (pgh-217.his.com [75.149.19.217])
	by smtp-1a.his.com (Postfix) with ESMTPS id 9D4C983B;
	Wed, 19 Aug 2026 11:09:39 -0400 (EDT)
Received: from proxmail101.his.com (localhost.localdomain [127.0.0.1])
	by proxmail101.his.com (Proxmox) with ESMTP id 1D85DBC0EF1;
	Wed, 19 Aug 2026 11:09:39 -0400 (EDT)
Received: from smtp-4a.his.com (dc-25.his.net [108.56.65.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by proxmail101.his.com (Proxmox) with ESMTPS id 71655BC0E24;
	Wed, 19 Aug 2026 11:09:38 -0400 (EDT)
Received: from mail2.his.com (ec2-3-149-70-92.us-east-2.compute.amazonaws.com [3.149.70.92])
	by smtp-4a.his.com (Postfix) with ESMTPS id 1AB011C11;
	Wed, 19 Aug 2026 11:09:38 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail2.his.com (Postfix) with ESMTP id EFF463C168A;
	Wed, 19 Aug 2026 15:09:37 +0000 (UTC)
Received: from mail2.his.com ([127.0.0.1])
 by localhost (mail2.his.com [127.0.0.1]) (amavis, port 10032) with ESMTP
 id wkK4a9saGlOt; Wed, 19 Aug 2026 15:09:37 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail2.his.com (Postfix) with ESMTP id B9A7F3C168B;
	Wed, 19 Aug 2026 15:09:37 +0000 (UTC)
X-Virus-Scanned: amavis at his.com
Received: from mail2.his.com ([127.0.0.1])
 by localhost (mail2.his.com [127.0.0.1]) (amavis, port 10026) with ESMTP
 id Ox7sauHzHCkX; Wed, 19 Aug 2026 15:09:37 +0000 (UTC)
Received: from wings.localdomain (unknown [69.53.104.42])
	by mail2.his.com (Postfix) with ESMTPSA id 6C6A33C168A;
	Wed, 19 Aug 2026 15:09:37 +0000 (UTC)
From: Kenneth Lorber <keni@his.com>
To: git@vger.kernel.org
Cc: Kenneth Lorber <keni@his.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 1/1] config: surface editor failure in exit code
Date: Wed, 19 Aug 2026 11:09:18 -0400
Message-ID: <20260819150922.2984850-2-keni@his.com>
X-Mailer: git-send-email 2.55.GIT
In-Reply-To: <20260819150922.2984850-1-keni@his.com>
References: <20260817211936.2943278-1-keni@his.com>
 <20260819150922.2984850-1-keni@his.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SPAM-LEVEL: Spam detection results:  0
	AWL                     0.120 Adjusted score from AWL reputation of From: address
	BAYES_00                 -1.9 Bayes spam probability is 0 to 1%
	DMARC_PASS               -0.1 DMARC pass policy
	KAM_DMARC_STATUS         0.01 Test Rule for DKIM or SPF Failure with Strict Alignment
	SPF_HELO_NONE           0.001 SPF: HELO does not publish an SPF Record
	SPF_PASS               -0.001 SPF: sender matches SPF record

Teach git config --edit to show editor failure to the
parent process.

Add 2 tests to t1300 to check editor exiting successfully
or failing.

Signed-off-by: Kenneth Lorber <keni@his.com>
---
 builtin/config.c  |  5 +++--
 t/t1300-config.sh | 12 ++++++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

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
index e3f8064889..3e218079ee 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1823,6 +1823,18 @@ test_expect_success 'command line overrides enviro=
nment config' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'git config -e successful exit' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	test_env GIT_EDITOR=3Dtrue git -C repo config -e
+'
+
+test_expect_success 'git config -e failure exit' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	test_env GIT_EDITOR=3Dfalse test_must_fail git -C repo config -e
+'
+
 test_expect_success 'git config --edit works' '
 	git config -f tmp test.value no &&
 	echo test.value=3Dyes >expect &&
--=20
2.43.0


