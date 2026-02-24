Received: from pio-pvt-msa1.bahnhof.se (pio-pvt-msa1.bahnhof.se [79.136.2.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07EA3A63FE
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 17:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.136.2.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771953219; cv=none; b=kZlmZK47Y0mZSP8f1vhdI/0o9Gu3WCTsvqswlvI4dEEPaXt2tIUQIwsqNvJfhY4ZSkV+q43KY4RX8JtJPnjLaQhJPxEoIHFU+vQ0Wg0lpcY9mlEWCzSWJHtZK5MHBW01Ucx6jYnk3qB//+Jbre8I/ZCjTjGZfrO/Gw4Cmc8GGSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771953219; c=relaxed/simple;
	bh=sxwowMzS6+5R7JnxhZdwbyolkmmTshlLemAe4AuGKf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K9taGVvTfnTa71t4XwW9h5NofLNnCzfZNoyLYSEz98Nni+FTPj4XzlUtRpK1ysQVAEx4h5BqTKw6kl5gl7GgiSQBK13JyIb2WzxPBCzHQgSth2ZsYqSba2LAR6LFXJN9vRfoI2M/yD6RDIuqmxFH3qlBLyA7urG9K6N2hZk2hVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page; spf=pass smtp.mailfrom=jontes.page; dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b=ipfGxnRQ; arc=none smtp.client-ip=79.136.2.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jontes.page
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b="ipfGxnRQ"
Received: from localhost (localhost [127.0.0.1])
	by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id BD83140C2A;
	Tue, 24 Feb 2026 18:13:29 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Authentication-Results: pio-pvt-msa1.bahnhof.se (amavisd-new);
	dkim=pass (2048-bit key) header.d=jontes.page
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
	by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6-ApE7gdcwFP; Tue, 24 Feb 2026 18:13:29 +0100 (CET)
Received: 
	by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id D196840866;
	Tue, 24 Feb 2026 18:13:28 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1B6CCB223E;
	Tue, 24 Feb 2026 18:12:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jontes.page; s=dkim;
	t=1771953131; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=v+lL0KEq4qQQyYF07B7E9vsXQoAbDsTY6KuelbWlcjk=;
	b=ipfGxnRQFhy4MHZqZyaKs9ct48ET5cPJKmiO298lKz7Fw3BevYdMjNtscIC3EAHaGrlWKL
	kVps3aUKvFldt01Por1fD1aD5Vtv7g0f3SXwdgVcAChcXQBYWdAUEe3mzdQ+Yq1oWexpcG
	21abXg3p1CfWDQTMgQHgZRqI0/c8bAluwIK+g0HokLz7CD1/iZ9AN3hPO7tp/ez3qi3Hur
	8pK3rIeA/pYMwPs7mnW8JVNMDHJbYcoGG6dT7P9jNBNqqNAQdknIFdK0/WSiRc2UFnlg+F
	mwVPGR191plJWHP5ul9vZNbhHY/m59t6y5mmP0TGpGjfLrA41wlb7rGzBXYkxA==
From: Jonatan Holmgren <jonatan@jontes.page>
To: git@vger.kernel.org
Cc: peff@peff.net,
	gitster@pobox.com,
	"D . Ben Knoble" <benknoble@gmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jonatan Holmgren <jonatan@jontes.page>
Subject: [PATCH 2/2] alias: treat empty subsection [alias ""] as plain [alias]
Date: Tue, 24 Feb 2026 18:12:36 +0100
Message-ID: <20260224171245.458377-3-jonatan@jontes.page>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260224171245.458377-1-jonatan@jontes.page>
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
 <20260224171245.458377-1-jonatan@jontes.page>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

When git-config stores a key of the form alias..name, it records
it under an empty subsection ([alias ""]). The new subsection-aware
alias lookup would see a non-NULL but zero-length subsection and
fall into the subsection code path, where it required a "command"
key and thus silently ignored the entry.

Normalize an empty subsection to NULL before any further processing
so that entries stored this way continue to work as plain
case-insensitive aliases, matching the pre-subsection behaviour.

Users who relied on alias..name to create an alias literally named
".name" may want to migrate to subsection syntax, which looks less confusing:

    [alias ".name"]
        command = <value>

Add tests covering both the empty-subsection compatibility case and
the leading-dot alias via the new syntax.

Signed-off-by: Jonatan Holmgren <jonatan@jontes.page>
---
 alias.c          |  4 ++++
 t/t0014-alias.sh | 14 ++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/alias.c b/alias.c
index 0d636278bc..ec9833dd30 100644
--- a/alias.c
+++ b/alias.c
@@ -30,6 +30,10 @@ static int config_alias_cb(const char *var, const char *value,
 	 * - [alias "name"]
 	 *       command = value  (with subsection, case-sensitive)
 	 */
+	/* Treat [alias ""] (empty subsection) the same as plain [alias]. */
+	if (subsection && !subsection_len)
+		subsection = NULL;
+
 	if (subsection && strcmp(key, "command"))
 		return 0;
 
diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
index 34bbdb51c5..68b4903cbf 100755
--- a/t/t0014-alias.sh
+++ b/t/t0014-alias.sh
@@ -183,4 +183,18 @@ test_expect_success 'subsection aliases listed in help -a' '
 	test_grep "förgrena" output
 '
 
+test_expect_success 'empty subsection treated as no subsection' '
+	test_config "alias..something" "!echo foobar" &&
+	git something >actual &&
+	echo foobar >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'alias with leading dot via subsection syntax' '
+	test_config alias.".something".command "!echo foobar" &&
+	git .something >actual &&
+	echo foobar >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.53.0

