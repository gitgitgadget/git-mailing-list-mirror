Received: from aib29agh124.zrh1.oracleemaildelivery.com (aib29agh124.zrh1.oracleemaildelivery.com [192.29.178.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D860718A6A3
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 22:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733263212; cv=none; b=Xl7xOjsgo/EDNLW3tMMEChwtCjVk56NghPHXPRxQRZOxgRfo6aEQfheB1gj4GV2WWVOnkG/tUSNTB099VkX+JoI8V0c1ra1U4H1pZ7ydGkiV3Cby1NbGU3sjeeCmuLDICP+9cpI/r/i5MgastFXlBipK1f+d7oeGeLo6RRBZMzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733263212; c=relaxed/simple;
	bh=XliBWzp994y5BVWHeqiHVSu7T0AOUvo+moy4aA/pjMI=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=IYdwlTIyPCjl1nAJTOJiY2PiKlgKZwxNb4wt8xJ1QLED1XC/8fJFG3YuXdCK5Cs+w0XkGdEm+xTveFQ/8ISeFNrV83e9LO73SFyjAf3Dj9svfTwD9iUHyghzqEHGEn888YTIXzxR3kpmPBtK7zLr3XrQIu/0AvPchrTNvxYPmrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=TRK3q7et; arc=none smtp.client-ip=192.29.178.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="TRK3q7et"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=Jz4Uv1r1bcshYGpi7FekFxCDG6uq3CW9FdFEh4m2yqg=;
 b=TRK3q7etGFZZcxYJvquftlOxeHgFO5ZrGUM9TwrOhjwlK007xPs45wi+WawLXtOij+0aqi5cmE/J
   OzQk5SOA2c13CauTC4Hu8idmtU0nw0eYy+nxqqNsrn3Mgo85DLzlrSmQ6406wDazUBclFFvrE6UF
   I8eW9IyBF9HodRFU1I4Uf0OiY8LrDEmBvp2tx839hBnfLNV2SD7YOkwXSdd+Gouk819LeBSqD5r0
   uvQK4Zk/Tj1O7JwdVDazW9/RmTqk3gZd5X2lz0VUfSiJsqJoqCUq+EZwixnyEldT2xHbbUBGubBm
   SZNmc0JLk4xJjTT44IjGgI1l7fmQMJLkplsowg==
Received: by omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241107 64bit (built Nov  7
 2024))
 with ESMTPS id <0SNX00C4UUG79AF0@omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Tue, 03 Dec 2024 22:00:07 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [RFC PATCH v1 2/2] remote set-head: set followRemoteHEAD to "warn" if
 "always"
Date: Tue,  3 Dec 2024 22:56:48 +0100
Message-id: <20241203215713.135068-3-bence@ferdinandy.com>
In-reply-to: <20241203215713.135068-1-bence@ferdinandy.com>
References: <xmqqiks7oprx.fsf@gitster.g>
 <20241203215713.135068-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAFqDQYZm1jFPCZW4D1Fmo9zRzjP+gpQNTqhKjfCq3HsU0+faZzMQLQkVEsEkPva
 9litAjVwA0PDvpxXpASiDFf+FhVB+PGHqitjxVEjeu3zMgoLql/zwehLlh/zbL4+
 ReC0AjfXHTHy6ruwssALnjHwb+i7zM6Qr9dWmaD0Jmsk0uOQhjT2VYL5uJbHGP4/
 UH2pyI5b4JjfxS0LFX0o9L+d8GBo2Y0R7uxF5aTFJtXdnq2O8lBPUu5XsDYDrBu+
 OkABtbPaMgo6fPXbwj7lg+4H7ABcKt6cmW1jqWtkVOTOXdmVj3fzAuqDvdLoM0x3
 LKjy9rRhYEgXXJ4jfijQf5f12fhi2Ypr3VqWXOch2CFJDhzpXUXdKZ/hoeF0IvDq
 r/2IHQCjTus1RhGF7LzLnPrF9TJVHDjXfhAYDYw4usPTh6a7It4/QOlpZeh6PE6S
 x4MrNgPVvEO1xAGPqF0TgRy0VsS0r7BbB+DC2doOzvjKIgdtaYqiIYA=

When running "remote set-head" manually it is unlikely, that the user
would actually like to have "fetch" always update the remote/HEAD. On
the contrary, it is more likely, that the user would expect remote/HEAD
to stay the way they manually set it, and just forgot about having
"followRemoteHEAD" set to "always".

When "followRemoteHEAD" is set to "always" make running "remote
set-head" change the config to "warn".

Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
---
 builtin/remote.c  | 12 +++++++++++-
 t/t5505-remote.sh | 11 +++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 4a8b2ef678..9a30c17724 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1433,6 +1433,7 @@ static int set_head(int argc, const char **argv, const char *prefix)
 		b_local_head = STRBUF_INIT;
 	char *head_name = NULL;
 	struct ref_store *refs = get_main_ref_store(the_repository);
+	struct remote *remote;
 
 	struct option options[] = {
 		OPT_BOOL('a', "auto", &opt_a,
@@ -1443,8 +1444,10 @@ static int set_head(int argc, const char **argv, const char *prefix)
 	};
 	argc = parse_options(argc, argv, prefix, options,
 			     builtin_remote_sethead_usage, 0);
-	if (argc)
+	if (argc) {
 		strbuf_addf(&b_head, "refs/remotes/%s/HEAD", argv[0]);
+		remote = remote_get(argv[0]);
+	}
 
 	if (!opt_a && !opt_d && argc == 2) {
 		head_name = xstrdup(argv[1]);
@@ -1483,6 +1486,13 @@ static int set_head(int argc, const char **argv, const char *prefix)
 	}
 	if (opt_a)
 		report_set_head_auto(argv[0], head_name, &b_local_head, was_detached);
+	if (remote->follow_remote_head == FOLLOW_REMOTE_ALWAYS) {
+		struct strbuf config_name = STRBUF_INIT;
+		strbuf_addf(&config_name,
+			"remote.%s.followremotehead", remote->name);
+		git_config_set(config_name.buf, "warn");
+		strbuf_release(&config_name);
+	}
 
 cleanup:
 	free(head_name);
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 2600add82a..76ffdb2ec9 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -505,6 +505,17 @@ test_expect_success 'set-head --auto has no problem w/multiple HEADs' '
 	)
 '
 
+test_expect_success 'set-head changes followRemoteHEAD always to warn' '
+	(
+		cd test &&
+		git config set remote.origin.followRemoteHEAD "always" &&
+		git remote set-head --auto origin &&
+		git config get remote.origin.followRemoteHEAD >output &&
+		echo "warn" >expect &&
+		test_cmp expect output
+	)
+'
+
 cat >test/expect <<\EOF
 refs/remotes/origin/side2
 EOF
-- 
2.47.1.297.g6455f89743

