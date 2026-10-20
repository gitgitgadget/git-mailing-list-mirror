Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=157.230.60.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792474816;
	b=h7yF+Fmty/1VXIxm5wQ9k5/kTfoLIjRbfmhLrukFN1Uxpsm863FJmenRalg8nAE+6Klx
	 jSaqO2UMyGDVyMOsbEVDMkGlJFn25rvp679aGX5yGRo0BqSUxMtjdn7p8Dp73/0VCa+D9
	 MUNnHTe5CMQGvuE60BLlWU+VLo6ryOSkNvLf8OUgHlNSlDUOqygJ6qd8eaILFe15kbYFl
	 pBvX23L/5KdJw7HkRtaBEUZZHUdZPP/SUl+xeEhBn3v8nA1ZWD3F24buqQtSbNMqwo1Lc
	 egG4nVAyo2LCHpUK7aIn7T7ldt1Vev5VF0LcOvC4TuHJSW7+K3/WgmgjmRb8dZZdQXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792474816;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=2+S4poIuayLx8Xg6sBzNCoLOXBtlyYETIxKNzfrSpXk=;
	b=Rmuz6kCh1LZgh8wJKvsIDyK6WwYw4vxxguvNz0AP1WamLpK1ozTN/JeTMwLcBfm5hF4y
	 PT+eAoQ8UodDZCl8mqrdo0zOYMBAC03rEWHEontoP3ChuEGgbzanjvscoThnvWKErWeLK
	 2ESsOv4+kvpMN9107QdwXjf8jDILe9+AizQ6R+V3crmxdH586ABmaTyFq99Lv32SsLZz2
	 eYCNwqMr+qVb5jDVG9C6NKkLm7otSjrdvoYpCGxRA1e9uXn2YUBN0d+1sQu00WH7C8F+r
	 ua9Gch4eHWoXvDcWW3pUNfu52IkTYhmAnjvtnTcBo/SxfIwSJFuskfr2lwF3PES0Rhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lfurio.us;
	spf=pass smtp.mailfrom=lfurio.us;
	dkim=pass header.d=lfurio.us header.i=@lfurio.us header.a=rsa-sha256 header.s=default header.b=ewMeR7Xb;
	arc=none smtp.remote-ip=157.230.60.252
Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33965606A319
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 05:40:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33965606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lfurio.us header.i=@lfurio.us header.a=rsa-sha256 header.s=default header.b=ewMeR7Xb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1792474815; bh=MvleDe6J10sa5Me7hsE5f6tB6QXqzWK6Y7ZRttzHsKY=;
	h=From:To:Cc:Subject:Date:From;
	b=ewMeR7XbggIYSxu2upU+n/IjwoeUurIsHRgL9DSUjZaQBMVw7raMCugH4lt3vaaAJ
	 TZWg2JQRU5X+L9yLNX2AvThz/ljnnvhd29dDyx+bJCtAk9g0Fy/DvQuw0g3aOs9LAZ
	 nLKx8ldRJNR2Tbd0CG6ARpQhXyYxM9jcbYyJHepM=
Received: by mail.normalmode.org (Postfix) with ESMTPSA id E9B3E6225B;
	Tue, 20 Oct 2026 05:40:14 +0000 (UTC)
From: Matt Hunter <m@lfurio.us>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH] init: show absolute path of (re)initialized repository
Date: Tue, 20 Oct 2026 01:38:47 -0400
Message-ID: <20261020053932.1274210-1-m@lfurio.us>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since 20e38cba3926 (setup: split up concerns of `init_db()`,
2026-09-10), git-init produces the message:

    Initialized empty Git repository in .git/

instead of the previous

    Initialized empty Git repository in /full/path/to/repo/.git/

Prior to 20e38cba3926, the code producing this message was in function
init_db (renamed at the time to create_repository).  In that context,
the git_dir variable was updated by 'git_dir = repo_get_git_dir(repo);'
earlier in the function, to set the value used in printf.

None of the discussion [1] around the original patch indicates that this
change was intentional, so address the regression by similarly using
repo_get_git_dir in this code's new location.

In this case, git_dir is referencing owned memory that is later freed,
so declare a new variable to hold the used string.

1: https://lore.kernel.org/git/20260825-pks-odb-write-alternates-at-creation-time-v1-0-911513ba95c3@pks.im/

Signed-off-by: Matt Hunter <m@lfurio.us>
---
 builtin/init-db.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 374ed3a74706..a2628568ff6a 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -248,18 +248,19 @@ int cmd_init_db(int argc,
 	create_object_database(the_repository, NULL);
 
 	if (!quiet) {
-		int len = strlen(git_dir);
+		const char *full_git_dir = repo_get_git_dir(the_repository);
+		int len = strlen(full_git_dir);
 
 		if (reinit)
 			printf(repo_settings_get_shared_repository(the_repository)
 			       ? _("Reinitialized existing shared Git repository in %s%s\n")
 			       : _("Reinitialized existing Git repository in %s%s\n"),
-			       git_dir, len && git_dir[len-1] != '/' ? "/" : "");
+			       full_git_dir, len && full_git_dir[len-1] != '/' ? "/" : "");
 		else
 			printf(repo_settings_get_shared_repository(the_repository)
 			       ? _("Initialized empty shared Git repository in %s%s\n")
 			       : _("Initialized empty Git repository in %s%s\n"),
-			       git_dir, len && git_dir[len-1] != '/' ? "/" : "");
+			       full_git_dir, len && full_git_dir[len-1] != '/' ? "/" : "");
 	}
 
 	free(template_dir_to_free);

base-commit: c51408889c3b372814bc20b9431c3b74d0d268eb
-- 
2.56.0.257.gf7497c7d27

