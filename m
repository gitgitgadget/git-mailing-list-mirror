Received: from 4.mo576.mail-out.ovh.net (4.mo576.mail-out.ovh.net [46.105.42.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95982857F7
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 17:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.42.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751823767; cv=none; b=jDh3s+h/h45pegsTgituavi4NtSZTHcNHz8eHTCmt99/Uh32skUVomTycnp6RwcVEiszdDJ+AviCATwBxidXxHdGCSGB1AEhlKS0Fm+gebTbh2G5+UjnJmSFv9itIM3ihfSwKLm6WNXviHrz2YHFsIzstHnEl1aD77mDyYswBYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751823767; c=relaxed/simple;
	bh=NUHe9ro08UJuReuTun2qSlaoYKXGOhhEocebHoECvXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WoIeDn+Pp0d0sP1H18EirHa6GDcu8UnOHRg1TnAFYiUpFQM+wz7cVb8MwSejqQxFKQnaMYk6HWlYLQV3EuypXeHLRdfjZ1iUhu4SzaLfKcN60KS12Q9wRi69MY06XMe1OpoSpi1DCAYVFqnKcY0FYSktp3zjBNF6dIL1pYF85W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redoste.xyz; spf=pass smtp.mailfrom=redoste.xyz; dkim=pass (2048-bit key) header.d=redoste.xyz header.i=@redoste.xyz header.b=0shqR8La; arc=none smtp.client-ip=46.105.42.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redoste.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redoste.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=redoste.xyz header.i=@redoste.xyz header.b="0shqR8La"
Received: from director1.ghost.mail-out.ovh.net (unknown [10.110.0.35])
	by mo576.mail-out.ovh.net (Postfix) with ESMTP id 4bZvfd021cz60wW
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 17:35:52 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-jsqz6 (unknown [10.108.54.55])
	by director1.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 77708C15EE;
	Sun,  6 Jul 2025 17:35:52 +0000 (UTC)
Received: from redoste.xyz ([37.59.142.105])
	by ghost-submission-5b5ff79f4f-jsqz6 with ESMTPSA
	id GYahDfizamhazggAtkv52A
	(envelope-from <redoste@redoste.xyz>); Sun, 06 Jul 2025 17:35:52 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-105G006d9372e2f-d638-4541-a38a-4b6a1cb6a2f4,
                    03B360DA9A158DBC4F736A687BEA6D6B8F7DE961) smtp.auth=redoste@redoste.xyz
X-OVh-ClientIp:62.34.249.37
From: redoste <redoste@redoste.xyz>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	redoste <redoste@redoste.xyz>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Fabian Stelzer <fs@gigacodes.de>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v2] ssh signing: don't detach the filename strbuf from key_file tempfile
Date: Sun,  6 Jul 2025 19:34:49 +0200
Message-ID: <20250706173450.12995-1-redoste@redoste.xyz>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704230829.29696-1-redoste@redoste.xyz>
References: <20250704230829.29696-1-redoste@redoste.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 12968115127832122724
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -65
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvleehfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlhcuvffnffculdefhedmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheprhgvughoshhtvgcuoehrvgguohhsthgvsehrvgguohhsthgvrdighiiiqeenucggtffrrghtthgvrhhnpeduvdejtdejuddvteelfeduvefhffffhfefkedvteekudffjedthefhkeeuieetjeenucfkphepuddvjedrtddrtddruddpiedvrdefgedrvdegledrfeejpdefjedrheelrddugedvrddutdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehrvgguohhsthgvsehrvgguohhsthgvrdighiiipdhnsggprhgtphhtthhopedupdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheejiegmpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=S+pUANrWYhPUw3onJpfQvL1kMDLjrxeEtTK5dsWfsLQ=;
 c=relaxed/relaxed; d=redoste.xyz; h=From; s=ovhmo3968190-selector1;
 t=1751823353; v=1;
 b=0shqR8LacNucej8g0Lef7NgHtmvztGvPzlmxQ5D8ADdWTvBk6lPxkCyOgOfeyTqAFB0KbVFl
 CiODx/48c+XHa3p1G2opw+93LjLoA2SDghpYfKwRGp0zygr360621ue1ZW2+K2ucKv2lpRDxnjM
 aCEDBmRaprJD3UO1TXxmWmr6iqOzlmbXllJAqDnAUov/l94xn5KO+6ZQssJ8o1nYn5PXZs3eHAi
 KDw06QWwuUgMwaE07wMlrvaxWiGvXwZI0oH3jRJ5AiNOKFA+SCHKTAU3wgKF4732U+pU03np0LP
 lJc7dQeZMMmYOinN/8Vc5H+WMyxb20rc83NwpKVmyobSg==

Detaching the filename string from the tempfile structure used to cause
delete_tempfile() to fail and the temporary file was not cleaned up.

While it's possible to get rid of the allocation and copy from
xstrdup(), it keeps the code symetric with the other branch since
interpolate_path() also allocates and ssh_signing_key_file is freed
in both cases.

Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: redoste <redoste@redoste.xyz>
---
v1->v2:
 * add a test case that checks for temporary files after signing commits
 * add small explaination about the use of xstrdup() in the commit
   body

 gpg-interface.c              |  2 +-
 t/t7528-signed-commit-ssh.sh | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 0896458de5..bdcc8c2a2e 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -1048,7 +1048,7 @@ static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
 				    key_file->filename.buf);
 			goto out;
 		}
-		ssh_signing_key_file = strbuf_detach(&key_file->filename, NULL);
+		ssh_signing_key_file = xstrdup(key_file->filename.buf);
 	} else {
 		/* We assume a file */
 		ssh_signing_key_file = interpolate_path(signing_key, 1);
diff --git a/t/t7528-signed-commit-ssh.sh b/t/t7528-signed-commit-ssh.sh
index 065f780636..1a8d96f355 100755
--- a/t/t7528-signed-commit-ssh.sh
+++ b/t/t7528-signed-commit-ssh.sh
@@ -390,6 +390,22 @@ test_expect_success GPGSSH 'check config gpg.format values' '
 	test_must_fail git commit -S --amend -m "fail"
 '
 
+test_expect_success GPGSSH 'check temporary files clean up when signing commits' '
+	test_config gpg.format ssh &&
+	eval $(ssh-agent) &&
+	test_when_finished "kill ${SSH_AGENT_PID}" &&
+	mkdir tmpdir &&
+	TMPDIR="$(pwd)/tmpdir" &&
+	export TMPDIR &&
+	ssh-add "${GPGSSH_KEY_PRIMARY}" &&
+	echo 1 >file && git add file &&
+	git commit -a -m inline -S"$(cat "${GPGSSH_KEY_PRIMARY}.pub")" &&
+	echo 2 >file &&
+	git commit -a -m file -S"${GPGSSH_KEY_PRIMARY}" &&
+	find tmpdir -type f >tmpfiles &&
+	test_line_count = 0 tmpfiles
+'
+
 test_expect_failure GPGSSH 'detect fudged commit with double signature (TODO)' '
 	sed -e "/gpgsig/,/END PGP/d" forged1 >double-base &&
 	sed -n -e "/gpgsig/,/END PGP/p" forged1 | \
-- 
2.49.0

