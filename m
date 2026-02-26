Received: from pio-pvt-msa3.bahnhof.se (pio-pvt-msa3.bahnhof.se [79.136.2.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5297A372B51
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 20:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.136.2.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772139253; cv=none; b=dP7iHMmwl9h/uQh5QdzCfLBWh1x0qGbAmer0TPrx8uCWUW9NmWanhU1IGmrZaA30s+oxzlcEEAlxdsoIgKqsKmIrzdgNcq6oQL6wFkVb9pawBEwxKTejsFxJEQVgtFUk6ZnjiO8rn3hqrr9d0bQcKGcg8YpmcmvF48rghUrr8Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772139253; c=relaxed/simple;
	bh=sxwowMzS6+5R7JnxhZdwbyolkmmTshlLemAe4AuGKf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kR9SeB9Sm44jHP1Zx6GpOKoKtSRkSCWpq9nlYT0GMu3YwzgjcwGqbSPGv+hOZh7y2pbffrLZfb7aKFbBI8/uGeB3gkYJrAxU/92+RMsU5b4qr/64YAvY8nitlrpqsJYgRKyiG0IZ4CVNIecC4WmHKFlkNBDHzxe0mLUi8mdLuDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page; spf=pass smtp.mailfrom=jontes.page; dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b=Gp7cU7it; arc=none smtp.client-ip=79.136.2.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jontes.page
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b="Gp7cU7it"
Received: from localhost (localhost [127.0.0.1])
	by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 08C853F642;
	Thu, 26 Feb 2026 21:54:03 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Authentication-Results: pio-pvt-msa3.bahnhof.se (amavisd-new);
	dkim=pass (2048-bit key) header.d=jontes.page
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
	by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oFrJxljvZ8NA; Thu, 26 Feb 2026 21:54:02 +0100 (CET)
Received: 
	by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id F012E3F64B;
	Thu, 26 Feb 2026 21:54:01 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E110AB2110;
	Thu, 26 Feb 2026 21:52:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jontes.page; s=dkim;
	t=1772139161; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=v+lL0KEq4qQQyYF07B7E9vsXQoAbDsTY6KuelbWlcjk=;
	b=Gp7cU7itBxwNqLb3b7loygLWgin2R4rU6Ab0+qra2oGCFhXrdTozxFR1TPL4c6Vxhctms0
	AMqmwixbxBSvzqrlmKZUEpqztB1cpOFbjkao+95VhCLs5zT6MbVFTdrUhNOirFqk+x/Wrr
	zJg8g2pSAKsWyiED9vQOwS8xm/eYsMXnbzeTcag79ObpWrcSzBrYhQsYNwvT+4H1xYLf73
	7/Og73lwOc9V5+Huiy8FyU5JyEp8RFDPUCuD5RxNhEt6zRdmCXIN8K8QZNKTJbUZzVJhmJ
	S/jYm354nbfYMxsfbHKnj6knEQ3YpJUuCFa/p+aSYkgVhjRqPqemXXy6VL9GjA==
From: Jonatan Holmgren <jonatan@jontes.page>
To: git@vger.kernel.org
Cc: peff@peff.net,
	gitster@pobox.com,
	"D . Ben Knoble" <benknoble@gmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jonatan Holmgren <jonatan@jontes.page>
Subject: [PATCH v2 2/3] alias: treat empty subsection [alias ""] as plain [alias]
Date: Thu, 26 Feb 2026 21:53:27 +0100
Message-ID: <20260226205339.1535482-3-jonatan@jontes.page>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260226205339.1535482-1-jonatan@jontes.page>
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
 <20260226205339.1535482-1-jonatan@jontes.page>
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

