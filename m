Received: from ste-pvt-msa1.bahnhof.se (ste-pvt-msa1.bahnhof.se [213.80.101.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FACA3921EE
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 20:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.80.101.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772139254; cv=none; b=o03wdKgQAEd0sqvGAbpJcT/HnEUmiWYRwkYuC4NUHhckfLJwVWRXOTFyqWcozyGCtRQljprc8y5W43tl6gTDdTQRhRSeiV+eYlYxAWNMPU+t3WvWQ3nZPXb/jwIQ9hPQWMkY8W99ifRqPEJYt2Fx4PQVbO/NJmIfFWvj6yV0AbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772139254; c=relaxed/simple;
	bh=ZoFDWnM+ZeB+Y32rI0kI0/LVgDBJmIB//OG+KuQaDk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uHkzy+zo9/WC9NMmTAM34crbfgldO+cDRGVEY8a4fjJvanmw3VQaw7SYewl7wtVq2JtmvaY/uhPdxYtpduAPcASHjJiLxk34ytL3dGlHEDJxUmoRuOB9ha5IY0SrifGsvQbNR0aV7AFHggX2HBf0GChyZkv4lgEmpEhASCsl9V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page; spf=pass smtp.mailfrom=jontes.page; dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b=knCUDRs5; arc=none smtp.client-ip=213.80.101.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jontes.page
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jontes.page
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jontes.page header.i=@jontes.page header.b="knCUDRs5"
Received: from localhost (localhost [127.0.0.1])
	by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 853443F83E;
	Thu, 26 Feb 2026 21:54:05 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Authentication-Results: ste-pvt-msa1.bahnhof.se (amavisd-new);
	dkim=pass (2048-bit key) header.d=jontes.page
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
	by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3J5Up29Q6-_r; Thu, 26 Feb 2026 21:54:04 +0100 (CET)
Received: 
	by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 936BB3F3EF;
	Thu, 26 Feb 2026 21:54:04 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5EAE4B234B;
	Thu, 26 Feb 2026 21:52:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jontes.page; s=dkim;
	t=1772139162; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=jZmo8c9V6Y0vpnSnRNGn4wi/NIF8Lp74egfePTpovOY=;
	b=knCUDRs5y9EmMCuE5JWJoSKQfP9BTPp/3a7LGj7M4zjuIaK9lMFAvslUq4zzHUttcqRPOk
	Yc/SFr6xy6G4OvYUOByDG4SFOU7S2cIzWeqUbw9+Fwv4To/S7R0J+2n/fI/4jLr2UqEmdn
	FpFzVTYKOlRf/It4YylFX+CfWNRzSZgrioAn0MNvA3iaC+tRIpqGpbzivHBHtURGFm4rwA
	CkMcdTWhwz4Ta+gDiTi+j8f09eEPrYdazvai75hMFm516grg9ACexWsHnIFq+H4/kL5zfB
	Cu1mtGcLJjKjGv1+QNovZkHWZMmLZoohfvZK6ejm7Z9o7uqJ0cjgmnex6J9xGw==
From: Jonatan Holmgren <jonatan@jontes.page>
To: git@vger.kernel.org
Cc: peff@peff.net,
	gitster@pobox.com,
	"D . Ben Knoble" <benknoble@gmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jonatan Holmgren <jonatan@jontes.page>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v2 3/3] git, help: fix memory leaks in alias listing
Date: Thu, 26 Feb 2026 21:53:28 +0100
Message-ID: <20260226205339.1535482-4-jonatan@jontes.page>
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
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The list_aliases() function sets the util pointer of each list item to
a heap-allocated copy of the alias command value.  Two callers failed
to free these util pointers:

 - list_cmds() in git.c collects a string list with STRING_LIST_INIT_DUP
   and clears it with string_list_clear(&list, 0), which frees the
   duplicated strings (strdup_strings=1) but not the util pointers.
   Pass free_util=1 to free them.

 - list_cmds_by_config() in help.c calls string_list_sort_u(list, 0) to
   deduplicate the list before processing completion.commands overrides.
   When duplicate entries are removed, the util pointer of each discarded
   item is leaked because free_util=0.  Pass free_util=1 to free them.

Reported-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jonatan Holmgren <jonatan@jontes.page>
---
 git.c  | 2 +-
 help.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git.c b/git.c
index 744cb6527e..aeb099ab11 100644
--- a/git.c
+++ b/git.c
@@ -119,7 +119,7 @@ static int list_cmds(const char *spec)
 	}
 	for (size_t i = 0; i < list.nr; i++)
 		puts(list.items[i].string);
-	string_list_clear(&list, 0);
+	string_list_clear(&list, 1);
 	return 0;
 }
 
diff --git a/help.c b/help.c
index 95f576c5c8..3e59d07c37 100644
--- a/help.c
+++ b/help.c
@@ -422,7 +422,7 @@ void list_cmds_by_config(struct string_list *list)
 	if (repo_config_get_string_tmp(the_repository, "completion.commands", &cmd_list))
 		return;
 
-	string_list_sort_u(list, 0);
+	string_list_sort_u(list, 1);
 
 	while (*cmd_list) {
 		struct strbuf sb = STRBUF_INIT;
-- 
2.53.0

