Received: from aib29agh122.zrh1.oracleemaildelivery.com (aib29agh122.zrh1.oracleemaildelivery.com [192.29.178.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA409217F24
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 12:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733401147; cv=none; b=ikwmR1MyPVIbI72DcWCwcS0djjpH/ioCnibeKsrJCAiRJxkAwZ7c7saKbahW3X1xRTsGxbIvhNJvVrSYwzTEk1v+Jf5n/GLtvi5h9yNX9+XnSSF7ZHdwMNEFb0F10kAEC64MSQ4TkWzt7ltWZVScUkSM9+u/v1g4Rd5AhaWoY0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733401147; c=relaxed/simple;
	bh=ejXllhv6b0UrMN2AJWzLExCvRsRbitYjyqNcKveWVgo=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=aRMlvKztZE/CPh2lYiG3CXimZeXRjNe4lb6mscpTxHhw1FtQKOjpatPDqn0HlI9bADtjfPLTcZSVYkfSf/T7tyN/kfeBuENSr1Qfo7gOB3fBsMI8M9YzqUctjoguQIscpnZMRFBkegViok2k3d+7uk9nvgx0Y29mdOb6IGoip4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=E3eaIAJn; arc=none smtp.client-ip=192.29.178.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="E3eaIAJn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=gxbcC0/kx+3f+7aT+s9vshMkp7QfT/el9w1VfvAygUo=;
 b=E3eaIAJnwIGZrOUszQd+FzLwjQ/QodpBUMFogVZiDTzB4imGad1kPLDh9teb+pDrD0y3zNlDjvos
   RbO8sLp8QhlHX/EHGzVIUbpTM2zaG1GbIJ5jcH25g5y/YYAKzhJPwfa/d4GoR6/+aQSQ6xYxj3XX
   RzAAMHFb/pe2nt2QfmxKXX8o4Zo658h6cSE+0fnqFYEFeeNJa64lSxsRJcdc008flAntwonK8lhF
   9OZ6OHR0XIzRRJYFk46dkTaJkOwbrHows9H+bzzsHoa48AZD4HgMevYC0i68d504kb79oeMl7szK
   FicihFPKKSeBEDDhvxDyOT/2TmnAJsCrglp83w==
Received: by omta-ad1-fd1-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241107 64bit (built Nov  7
 2024))
 with ESMTPS id <0SO0008H6SVMO080@omta-ad1-fd1-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Thu, 05 Dec 2024 12:18:58 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: Bence Ferdinandy <bence@ferdinandy.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Karthik Nayak <karthik.188@gmail.com>,	Taylor Blau <me@ttaylorr.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 3/3] remote set-head: set followRemoteHEAD to "warn" if
 "always"
Date: Thu,  5 Dec 2024 13:16:22 +0100
Message-id: <20241205121737.1181695-3-bence@ferdinandy.com>
In-reply-to: <20241205121737.1181695-1-bence@ferdinandy.com>
References: <173ea521-6a2e-45aa-ae5e-4da99060cc4f@app.fastmail.com>
 <20241205121737.1181695-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAF7auvij4z5nZj1+hXu9tMn/LZ18Pk4Ps3GFhpA0WpLphquIyAscYY4pgHTOzrh
 WB97q7yVo/cXdUcktolYJONQhm1W+3bEY4hvHiA2FySVta3bzOoy/Tb4DbmAtpJG
 praJPulo0BLWD5Fu+LMEQ+I3P0J4DH5v4Yf5xGn1WwpA9etQ6OhoPRHFzZqauMrA
 iEzWOJ+5YXzW9mgB5pcoOv+kSBURBHvzX8Vo3Kb8rcQBfjw6BPWxNvpTjA6pwu6Q
 4P2speFoJIhNToV/z1ThluIahcWYvGXpnK0ZOaVoOd116hZg7XKax21Bf+NZoSiK
 af/M7aY8jkNH6IUnHtGUEmEdviWApBdPKOe2dG/P4+8ITGn7FQJ/55CgVegi4UkH
 fhFsQbwCbiQ26IY63j0ezgeZuPAJCadvkwqmSsKnzJAUS+XzBb2/GUcJumHCNEM2
 xbrcIpnTqEwP0a3kKYi8FS17t3toZj8ypqZooJAKxGTHMxh14zbp6Bof

When running "remote set-head" manually it is unlikely, that the user
would actually like to have "fetch" always update the remote/HEAD. On
the contrary, it is more likely, that the user would expect remote/HEAD
to stay the way they manually set it, and just forgot about having
"followRemoteHEAD" set to "always".

When "followRemoteHEAD" is set to "always" make running "remote
set-head" change the config to "warn".

Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
---

Notes:
    v3: s/output/actual

 builtin/remote.c  | 12 +++++++++++-
 t/t5505-remote.sh | 11 +++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index d5b81445f2..32d02ca4a0 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1438,6 +1438,7 @@ static int set_head(int argc, const char **argv, const char *prefix,
 		b_local_head = STRBUF_INIT;
 	char *head_name = NULL;
 	struct ref_store *refs = get_main_ref_store(the_repository);
+	struct remote *remote;
 
 	struct option options[] = {
 		OPT_BOOL('a', "auto", &opt_a,
@@ -1448,8 +1449,10 @@ static int set_head(int argc, const char **argv, const char *prefix,
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
@@ -1488,6 +1491,13 @@ static int set_head(int argc, const char **argv, const char *prefix,
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
index 7411aa770d..519f7973e3 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -504,6 +504,17 @@ test_expect_success 'set-head --auto has no problem w/multiple HEADs' '
 	)
 '
 
+test_expect_success 'set-head changes followRemoteHEAD always to warn' '
+	(
+		cd test &&
+		git config set remote.origin.followRemoteHEAD "always" &&
+		git remote set-head --auto origin &&
+		git config get remote.origin.followRemoteHEAD >actual &&
+		echo "warn" >expect &&
+		test_cmp expect actual
+	)
+'
+
 cat >test/expect <<\EOF
 refs/remotes/origin/side2
 EOF
-- 
2.47.1.398.g18e7475ebe

